// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Transfer"
{
	Properties
	{
		_RenderClip( "_RenderClip", Float ) = 0
		_IsElementShader( "_IsElementShader", Float ) = 0
		_IsHelperShader( "_IsHelperShader", Float ) = 0
		_TransferIntensityValue( "Transfer Intensity", Range( 0, 1 ) ) = 0
		_TransferMeshValue( "Transfer Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _TransferMeshMode( "Transfer Mesh Mask", Float ) = 3
		[StyledRemapSlider] _TransferMeshRemap( "Transfer Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[HideInInspector] _IsTVEShader( "_IsTVEShader", Float ) = 0
		[StyledCategory(Object Settings, true, Use the Legacy Model mode only for meshes converted using the old Vegetation Engine asset.NEWNEWUse the Z Up Axis mode when the mesh rotation is set as MIN90 on the X axis.NEWNEWUse the Phase Mask to select which vertex color is used for perMINbranch or perMINleaf variation for Motion or Perspective phase offset.NEWNEWUse the Height and Radius values to normalize the procedural Height and Capsule masks used for Motion. In URP and HDRP__ the mesh renderer bounds can be used to remap the values automaticalyEXC, 0, 10)] _ObjectCategory( "[ Object Category ]", Float ) = 1
		[Enum(Legacy,0,Default,1)] _ObjectModelMode( "Object Model Mode", Float ) = 1
		[Enum(Y Up,0,Z Up,1)] _ObjectCoordMode( "Object Coord Mode", Float ) = 0
		[Enum(Single,0,Baked,1,Procedural,2)] _ObjectPivotMode( "Object Pivots Mode", Float ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _ObjectPhaseMode( "Object Phase Mask", Float ) = 0
		_ObjectHeightValue( "Object Height Value", Range( 0, 40 ) ) = 1
		_ObjectRadiusValue( "Object Radius Value", Range( 0, 40 ) ) = 1
		[StyledSpace(10)] _ObjectEnd( "[ Object End ]", Float ) = 1
		_IsShaderType( "_IsShaderType", Float ) = 0
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
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#define ASE_NEEDS_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_BITANGENT
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_COLOR
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
				#pragma shader_feature_local_vertex TVE_COORD_ZUP
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_vertex TVE_TRANSFER
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
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
					float4 ase_texcoord9 : TEXCOORD9;
					float4 ase_texcoord10 : TEXCOORD10;
					float4 ase_color : COLOR;
					float4 ase_texcoord11 : TEXCOORD11;
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
				uniform half _TransferIntensityValue;
				uniform half _TransferMeshMode;
				uniform half4 _TransferMeshRemap;
				uniform half _TransferMeshValue;
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
				
				float3 ASESafeNormalize(float3 inVec)
				{
					float dp3 = max(1.175494351e-38, dot(inVec, inVec));
					return inVec* rsqrt(dp3);
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
				

				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					TVEVertexData Data16_g251557 =(TVEVertexData)0;
					float In_Dummy16_g251557 = 0.0;
					TVEVertexData Data16_g251552 =(TVEVertexData)0;
					float In_Dummy16_g251552 = 0.0;
					float localIfModelDataByShader26_g242551 = ( 0.0 );
					TVEModelData Data26_g242551 = (TVEModelData)0;
					TVEModelData Data16_g242447 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g242429 = _ObjectCoordMode;
					#else
					float staticSwitch343_g242429 = _ObjectCoordMode;
					#endif
					half Dummy207_g242429 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g242429 );
					float temp_output_14_0_g242447 = Dummy207_g242429;
					float In_Dummy16_g242447 = temp_output_14_0_g242447;
					float3 PositionOS131_g242429 = v.vertex.xyz;
					float3 temp_output_4_0_g242447 = PositionOS131_g242429;
					float3 In_PositionOS16_g242447 = temp_output_4_0_g242447;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g242429 = ase_positionWS;
					float3 vertexToFrag73_g242429 = temp_output_104_7_g242429;
					float3 PositionWS122_g242429 = vertexToFrag73_g242429;
					float3 In_PositionWS16_g242447 = PositionWS122_g242429;
					float4x4 break19_g242432 = unity_ObjectToWorld;
					float3 appendResult20_g242432 = (float3(break19_g242432[ 0 ][ 3 ] , break19_g242432[ 1 ][ 3 ] , break19_g242432[ 2 ][ 3 ]));
					float3 temp_output_340_7_g242429 = appendResult20_g242432;
					float4x4 break19_g242434 = unity_ObjectToWorld;
					float3 appendResult20_g242434 = (float3(break19_g242434[ 0 ][ 3 ] , break19_g242434[ 1 ][ 3 ] , break19_g242434[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g242430 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g242429 = PositionOS131_g242429;
					float3 appendResult234_g242429 = (float3(break233_g242429.x , 0.0 , break233_g242429.z));
					float3 break413_g242429 = PositionOS131_g242429;
					float3 appendResult414_g242429 = (float3(break413_g242429.x , break413_g242429.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g242436 = appendResult414_g242429;
					#else
					float3 staticSwitch65_g242436 = appendResult234_g242429;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g242429 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g242429 = appendResult60_g242430;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g242429 = staticSwitch65_g242436;
					#else
					float3 staticSwitch229_g242429 = _Vector0;
					#endif
					float3 PivotOS149_g242429 = staticSwitch229_g242429;
					float3 temp_output_122_0_g242434 = PivotOS149_g242429;
					float3 PivotsOnlyWS105_g242434 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g242434 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g242429 = ( appendResult20_g242434 + PivotsOnlyWS105_g242434 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g242429 = temp_output_340_7_g242429;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g242429 = temp_output_341_7_g242429;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g242429 = temp_output_341_7_g242429;
					#else
					float3 staticSwitch236_g242429 = temp_output_340_7_g242429;
					#endif
					float3 vertexToFrag76_g242429 = staticSwitch236_g242429;
					float3 PivotWS121_g242429 = vertexToFrag76_g242429;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242429 = ( PositionWS122_g242429 - PivotWS121_g242429 );
					#else
					float3 staticSwitch204_g242429 = PositionWS122_g242429;
					#endif
					float3 PositionWO132_g242429 = ( staticSwitch204_g242429 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242447 = PositionWO132_g242429;
					float3 In_PivotOS16_g242447 = PivotOS149_g242429;
					float3 In_PivotWS16_g242447 = PivotWS121_g242429;
					float3 PivotWO133_g242429 = ( PivotWS121_g242429 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242447 = PivotWO133_g242429;
					half3 NormalOS134_g242429 = v.normal;
					float3 temp_output_21_0_g242447 = NormalOS134_g242429;
					float3 In_NormalOS16_g242447 = temp_output_21_0_g242447;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g242429 = normalizedWorldNormal;
					float3 In_NormalWS16_g242447 = NormalWS95_g242429;
					half4 TangentlOS153_g242429 = v.tangent;
					float4 temp_output_6_0_g242447 = TangentlOS153_g242429;
					float4 In_TangentOS16_g242447 = temp_output_6_0_g242447;
					float3 normalizeResult296_g242429 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242429 ) );
					half3 ViewDirWS169_g242429 = normalizeResult296_g242429;
					float3 In_ViewDirWS16_g242447 = ViewDirWS169_g242429;
					float4 appendResult397_g242429 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g242429 = appendResult397_g242429;
					float4 In_CoordsData16_g242447 = CoordsData398_g242429;
					half4 VertexMasks171_g242429 = v.ase_color;
					float4 In_VertexData16_g242447 = VertexMasks171_g242429;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g242441 = (PositionOS131_g242429).z;
					#else
					float staticSwitch65_g242441 = (PositionOS131_g242429).y;
					#endif
					half Object_HeightValue267_g242429 = _ObjectHeightValue;
					half Bounds_HeightMask274_g242429 = saturate( ( staticSwitch65_g242441 / Object_HeightValue267_g242429 ) );
					half3 Position387_g242429 = PositionOS131_g242429;
					half Height387_g242429 = Object_HeightValue267_g242429;
					half Object_RadiusValue268_g242429 = _ObjectRadiusValue;
					half Radius387_g242429 = Object_RadiusValue268_g242429;
					half localCapsuleMaskYUp387_g242429 = CapsuleMaskYUp( Position387_g242429 , Height387_g242429 , Radius387_g242429 );
					half3 Position408_g242429 = PositionOS131_g242429;
					half Height408_g242429 = Object_HeightValue267_g242429;
					half Radius408_g242429 = Object_RadiusValue268_g242429;
					half localCapsuleMaskZUp408_g242429 = CapsuleMaskZUp( Position408_g242429 , Height408_g242429 , Radius408_g242429 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g242446 = saturate( localCapsuleMaskZUp408_g242429 );
					#else
					float staticSwitch65_g242446 = saturate( localCapsuleMaskYUp387_g242429 );
					#endif
					half Bounds_SphereMask282_g242429 = staticSwitch65_g242446;
					float4 appendResult253_g242429 = (float4(Bounds_HeightMask274_g242429 , Bounds_SphereMask282_g242429 , 1.0 , 1.0));
					half4 MasksData254_g242429 = appendResult253_g242429;
					float4 In_MasksData16_g242447 = MasksData254_g242429;
					float temp_output_17_0_g242440 = _ObjectPhaseMode;
					float Option70_g242440 = temp_output_17_0_g242440;
					float4 temp_output_3_0_g242440 = v.ase_color;
					float4 Channel70_g242440 = temp_output_3_0_g242440;
					float localSwitchChannel470_g242440 = SwitchChannel4( Option70_g242440 , Channel70_g242440 );
					half Phase_Value372_g242429 = localSwitchChannel470_g242440;
					float3 break319_g242429 = PivotWO133_g242429;
					half Pivot_Position322_g242429 = ( break319_g242429.x + break319_g242429.z );
					half Phase_Position357_g242429 = ( Phase_Value372_g242429 + Pivot_Position322_g242429 );
					float temp_output_248_0_g242429 = frac( Phase_Position357_g242429 );
					float4 appendResult177_g242429 = (float4((frac( ( Phase_Position357_g242429 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g242429));
					half4 Phase_Data176_g242429 = appendResult177_g242429;
					float4 In_PhaseData16_g242447 = Phase_Data176_g242429;
					BuildModelVertData( Data16_g242447 , In_Dummy16_g242447 , In_PositionOS16_g242447 , In_PositionWS16_g242447 , In_PositionWO16_g242447 , In_PivotOS16_g242447 , In_PivotWS16_g242447 , In_PivotWO16_g242447 , In_NormalOS16_g242447 , In_NormalWS16_g242447 , In_TangentOS16_g242447 , In_ViewDirWS16_g242447 , In_CoordsData16_g242447 , In_VertexData16_g242447 , In_MasksData16_g242447 , In_PhaseData16_g242447 );
					TVEModelData DataDefault26_g242551 = Data16_g242447;
					TVEModelData DataGeneral26_g242551 = Data16_g242447;
					TVEModelData DataBlanket26_g242551 = Data16_g242447;
					TVEModelData DataImpostor26_g242551 = Data16_g242447;
					TVEModelData Data16_g242427 =(TVEModelData)0;
					half Dummy207_g242409 = 0.0;
					float temp_output_14_0_g242427 = Dummy207_g242409;
					float In_Dummy16_g242427 = temp_output_14_0_g242427;
					float3 PositionOS131_g242409 = v.vertex.xyz;
					float3 temp_output_4_0_g242427 = PositionOS131_g242409;
					float3 In_PositionOS16_g242427 = temp_output_4_0_g242427;
					float3 temp_output_104_7_g242409 = ase_positionWS;
					float3 PositionWS122_g242409 = temp_output_104_7_g242409;
					float3 In_PositionWS16_g242427 = PositionWS122_g242409;
					float4x4 break19_g242412 = unity_ObjectToWorld;
					float3 appendResult20_g242412 = (float3(break19_g242412[ 0 ][ 3 ] , break19_g242412[ 1 ][ 3 ] , break19_g242412[ 2 ][ 3 ]));
					float3 temp_output_340_7_g242409 = appendResult20_g242412;
					float3 PivotWS121_g242409 = temp_output_340_7_g242409;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242409 = ( PositionWS122_g242409 - PivotWS121_g242409 );
					#else
					float3 staticSwitch204_g242409 = PositionWS122_g242409;
					#endif
					float3 PositionWO132_g242409 = ( staticSwitch204_g242409 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242427 = PositionWO132_g242409;
					float3 PivotOS149_g242409 = _Vector0;
					float3 In_PivotOS16_g242427 = PivotOS149_g242409;
					float3 In_PivotWS16_g242427 = PivotWS121_g242409;
					float3 PivotWO133_g242409 = ( PivotWS121_g242409 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242427 = PivotWO133_g242409;
					half3 NormalOS134_g242409 = v.normal;
					float3 temp_output_21_0_g242427 = NormalOS134_g242409;
					float3 In_NormalOS16_g242427 = temp_output_21_0_g242427;
					half3 NormalWS95_g242409 = normalizedWorldNormal;
					float3 In_NormalWS16_g242427 = NormalWS95_g242409;
					float4 appendResult462_g242409 = (float4(cross( v.normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g242409 = appendResult462_g242409;
					float4 temp_output_6_0_g242427 = TangentlOS153_g242409;
					float4 In_TangentOS16_g242427 = temp_output_6_0_g242427;
					float3 normalizeResult296_g242409 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242409 ) );
					half3 ViewDirWS169_g242409 = normalizeResult296_g242409;
					float3 In_ViewDirWS16_g242427 = ViewDirWS169_g242409;
					float4 appendResult397_g242409 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g242409 = appendResult397_g242409;
					float4 In_CoordsData16_g242427 = CoordsData398_g242409;
					half4 VertexMasks171_g242409 = float4( 0,0,0,0 );
					float4 In_VertexData16_g242427 = VertexMasks171_g242409;
					half4 MasksData254_g242409 = float4( 0,0,0,0 );
					float4 In_MasksData16_g242427 = MasksData254_g242409;
					half4 Phase_Data176_g242409 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g242427 = Phase_Data176_g242409;
					BuildModelVertData( Data16_g242427 , In_Dummy16_g242427 , In_PositionOS16_g242427 , In_PositionWS16_g242427 , In_PositionWO16_g242427 , In_PivotOS16_g242427 , In_PivotWS16_g242427 , In_PivotWO16_g242427 , In_NormalOS16_g242427 , In_NormalWS16_g242427 , In_TangentOS16_g242427 , In_ViewDirWS16_g242427 , In_CoordsData16_g242427 , In_VertexData16_g242427 , In_MasksData16_g242427 , In_PhaseData16_g242427 );
					TVEModelData DataTerrain26_g242551 = Data16_g242427;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g242551 = IsShaderType2637;
					{
					if (Type26_g242551 == 0 )
					{
					Data26_g242551 = DataDefault26_g242551;
					}
					else if (Type26_g242551 == 1 )
					{
					Data26_g242551 = DataGeneral26_g242551;
					}
					else if (Type26_g242551 == 2 )
					{
					Data26_g242551 = DataBlanket26_g242551;
					}
					else if (Type26_g242551 == 3 )
					{
					Data26_g242551 = DataImpostor26_g242551;
					}
					else if (Type26_g242551 == 4 )
					{
					Data26_g242551 = DataTerrain26_g242551;
					}
					}
					TVEModelData Data15_g251553 =(TVEModelData)Data26_g242551;
					float Out_Dummy15_g251553 = 0.0;
					float3 Out_PositionOS15_g251553 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251553 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251553 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251553 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251553 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251553 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251553 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251553 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251553 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251553 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251553 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251553 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251553 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251553 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251553 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251553 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251553 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251553 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251553 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251553 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251553 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251553 , Out_Dummy15_g251553 , Out_PositionOS15_g251553 , Out_PositionWS15_g251553 , Out_PositionWO15_g251553 , Out_PositionRawOS15_g251553 , Out_PivotOS15_g251553 , Out_PivotWS15_g251553 , Out_PivotWO15_g251553 , Out_NormalOS15_g251553 , Out_NormalWS15_g251553 , Out_NormalRawOS15_g251553 , Out_TangentOS15_g251553 , Out_TangentWS15_g251553 , Out_BitangentWS15_g251553 , Out_ViewDirWS15_g251553 , Out_CoordsData15_g251553 , Out_VertexData15_g251553 , Out_MasksData15_g251553 , Out_PhaseData15_g251553 , Out_TransformData15_g251553 , Out_RotationData15_g251553 , Out_Interpolator15_g251553 );
					float3 In_PositionOS16_g251552 = Out_PositionOS15_g251553;
					float3 In_NormalOS16_g251552 = Out_NormalOS15_g251553;
					float4 In_TangentOS16_g251552 = Out_TangentOS15_g251553;
					float4 In_TransformData16_g251552 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251552 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251552 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251552 , In_Dummy16_g251552 , In_PositionOS16_g251552 , In_NormalOS16_g251552 , In_TangentOS16_g251552 , In_TransformData16_g251552 , In_RotationData16_g251552 , In_Interpolator16_g251552 );
					TVEVertexData Data15_g251555 =(TVEVertexData)Data16_g251552;
					float Out_Dummy15_g251555 = 0.0;
					float3 Out_PositionOS15_g251555 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251555 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251555 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251555 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251555 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251555 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251555 , Out_Dummy15_g251555 , Out_PositionOS15_g251555 , Out_NormalOS15_g251555 , Out_TangentOS15_g251555 , Out_TransformData15_g251555 , Out_RotationData15_g251555 , Out_Interpolator15_g251555 );
					TVEModelData Data15_g251556 =(TVEModelData)Data15_g251553;
					float Out_Dummy15_g251556 = 0.0;
					float3 Out_PositionOS15_g251556 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251556 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251556 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251556 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251556 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251556 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251556 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251556 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251556 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251556 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251556 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251556 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251556 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251556 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251556 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251556 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251556 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251556 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251556 , Out_Dummy15_g251556 , Out_PositionOS15_g251556 , Out_PositionWS15_g251556 , Out_PositionWO15_g251556 , Out_PositionRawOS15_g251556 , Out_PivotOS15_g251556 , Out_PivotWS15_g251556 , Out_PivotWO15_g251556 , Out_NormalOS15_g251556 , Out_NormalWS15_g251556 , Out_NormalRawOS15_g251556 , Out_TangentOS15_g251556 , Out_TangentWS15_g251556 , Out_BitangentWS15_g251556 , Out_ViewDirWS15_g251556 , Out_CoordsData15_g251556 , Out_VertexData15_g251556 , Out_MasksData15_g251556 , Out_PhaseData15_g251556 , Out_TransformData15_g251556 , Out_RotationData15_g251556 , Out_Interpolator15_g251556 );
					float3 In_PositionOS16_g251557 = ( Out_PositionOS15_g251555 - Out_PivotOS15_g251556 );
					float3 In_NormalOS16_g251557 = Out_NormalOS15_g251556;
					float4 In_TangentOS16_g251557 = Out_TangentOS15_g251556;
					float4 In_TransformData16_g251557 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251557 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251557 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251557 , In_Dummy16_g251557 , In_PositionOS16_g251557 , In_NormalOS16_g251557 , In_TangentOS16_g251557 , In_TransformData16_g251557 , In_RotationData16_g251557 , In_Interpolator16_g251557 );
					TVEVertexData Data15_g251566 =(TVEVertexData)Data16_g251557;
					float Out_Dummy15_g251566 = 0.0;
					float3 Out_PositionOS15_g251566 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251566 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251566 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251566 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251566 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251566 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251566 , Out_Dummy15_g251566 , Out_PositionOS15_g251566 , Out_NormalOS15_g251566 , Out_TangentOS15_g251566 , Out_TransformData15_g251566 , Out_RotationData15_g251566 , Out_Interpolator15_g251566 );
					TVEVertexData Data16_g251567 =(TVEVertexData)Data15_g251566;
					half Dummy317_g251558 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251567 = Dummy317_g251558;
					float3 In_PositionOS16_g251567 = Out_PositionOS15_g251566;
					float3 In_NormalOS16_g251567 = Out_NormalOS15_g251566;
					float4 In_TangentOS16_g251567 = Out_TangentOS15_g251566;
					half4 Model_TransformData356_g251558 = Out_TransformData15_g251566;
					float localBuildGlobalData204_g242450 = ( 0.0 );
					TVEGlobalData Data204_g242450 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g242450 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g242450 = Dummy211_g242450;
					float4 temp_output_203_0_g242469 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g242408 = ( 0.0 );
					TVEModelData Data26_g242408 = (TVEModelData)0;
					TVEModelData Data16_g242437 =(TVEModelData)0;
					float In_Dummy16_g242437 = 0.0;
					float3 In_PositionWS16_g242437 = PositionWS122_g242429;
					float3 In_PositionWO16_g242437 = PositionWO132_g242429;
					float3 In_PivotWS16_g242437 = PivotWS121_g242429;
					float3 In_PivotWO16_g242437 = PivotWO133_g242429;
					float3 In_NormalWS16_g242437 = NormalWS95_g242429;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g242429 = ase_tangentWS;
					float3 In_TangentWS16_g242437 = TangentWS136_g242429;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g242429 = ase_bitangentWS;
					float3 In_BitangentWS16_g242437 = BiangentWS421_g242429;
					half3 NormalWS427_g242429 = NormalWS95_g242429;
					half3 localComputeTriplanarMasks427_g242429 = ComputeTriplanarMasks( NormalWS427_g242429 );
					half3 TriplanarWeights429_g242429 = localComputeTriplanarMasks427_g242429;
					float3 In_TriplanarWeights16_g242437 = TriplanarWeights429_g242429;
					float3 In_ViewDirWS16_g242437 = ViewDirWS169_g242429;
					float4 In_CoordsData16_g242437 = CoordsData398_g242429;
					float4 In_VertexData16_g242437 = VertexMasks171_g242429;
					float4 In_Interpolator16_g242437 = Phase_Data176_g242429;
					BuildModelFragData( Data16_g242437 , In_Dummy16_g242437 , In_PositionWS16_g242437 , In_PositionWO16_g242437 , In_PivotWS16_g242437 , In_PivotWO16_g242437 , In_NormalWS16_g242437 , In_TangentWS16_g242437 , In_BitangentWS16_g242437 , In_TriplanarWeights16_g242437 , In_ViewDirWS16_g242437 , In_CoordsData16_g242437 , In_VertexData16_g242437 , In_Interpolator16_g242437 );
					TVEModelData DataDefault26_g242408 = Data16_g242437;
					TVEModelData DataGeneral26_g242408 = Data16_g242437;
					TVEModelData DataBlanket26_g242408 = Data16_g242437;
					TVEModelData DataImpostor26_g242408 = Data16_g242437;
					TVEModelData Data16_g242417 =(TVEModelData)0;
					float In_Dummy16_g242417 = 0.0;
					float3 In_PositionWS16_g242417 = PositionWS122_g242409;
					float3 In_PositionWO16_g242417 = PositionWO132_g242409;
					float3 In_PivotWS16_g242417 = PivotWS121_g242409;
					float3 In_PivotWO16_g242417 = PivotWO133_g242409;
					float3 In_NormalWS16_g242417 = NormalWS95_g242409;
					half3 TangentWS136_g242409 = ase_tangentWS;
					float3 In_TangentWS16_g242417 = TangentWS136_g242409;
					half3 BiangentWS421_g242409 = ase_bitangentWS;
					float3 In_BitangentWS16_g242417 = BiangentWS421_g242409;
					half3 NormalWS427_g242409 = NormalWS95_g242409;
					half3 localComputeTriplanarMasks427_g242409 = ComputeTriplanarMasks( NormalWS427_g242409 );
					half3 TriplanarWeights429_g242409 = localComputeTriplanarMasks427_g242409;
					float3 In_TriplanarWeights16_g242417 = TriplanarWeights429_g242409;
					float3 In_ViewDirWS16_g242417 = ViewDirWS169_g242409;
					float4 In_CoordsData16_g242417 = CoordsData398_g242409;
					float4 In_VertexData16_g242417 = VertexMasks171_g242409;
					float4 In_Interpolator16_g242417 = Phase_Data176_g242409;
					BuildModelFragData( Data16_g242417 , In_Dummy16_g242417 , In_PositionWS16_g242417 , In_PositionWO16_g242417 , In_PivotWS16_g242417 , In_PivotWO16_g242417 , In_NormalWS16_g242417 , In_TangentWS16_g242417 , In_BitangentWS16_g242417 , In_TriplanarWeights16_g242417 , In_ViewDirWS16_g242417 , In_CoordsData16_g242417 , In_VertexData16_g242417 , In_Interpolator16_g242417 );
					TVEModelData DataTerrain26_g242408 = Data16_g242417;
					float Type26_g242408 = IsShaderType2637;
					{
					if (Type26_g242408 == 0 )
					{
					Data26_g242408 = DataDefault26_g242408;
					}
					else if (Type26_g242408 == 1 )
					{
					Data26_g242408 = DataGeneral26_g242408;
					}
					else if (Type26_g242408 == 2 )
					{
					Data26_g242408 = DataBlanket26_g242408;
					}
					else if (Type26_g242408 == 3 )
					{
					Data26_g242408 = DataImpostor26_g242408;
					}
					else if (Type26_g242408 == 4 )
					{
					Data26_g242408 = DataTerrain26_g242408;
					}
					}
					TVEModelData Data15_g242540 =(TVEModelData)Data26_g242408;
					float Out_Dummy15_g242540 = 0.0;
					float3 Out_PositionWS15_g242540 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242540 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242540 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242540 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242540 = float3( 0,0,0 );
					float3 Out_TangentWS15_g242540 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242540 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g242540 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242540 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242540 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242540 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g242540 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g242540 , Out_Dummy15_g242540 , Out_PositionWS15_g242540 , Out_PositionWO15_g242540 , Out_PivotWS15_g242540 , Out_PivotWO15_g242540 , Out_NormalWS15_g242540 , Out_TangentWS15_g242540 , Out_BitangentWS15_g242540 , Out_TriplanarWeights15_g242540 , Out_ViewDirWS15_g242540 , Out_CoordsData15_g242540 , Out_VertexData15_g242540 , Out_Interpolator15_g242540 );
					float3 Model_PositionWS497_g242450 = Out_PositionWS15_g242540;
					float2 Model_PositionWS_XZ143_g242450 = (Model_PositionWS497_g242450).xz;
					float3 Model_PivotWS498_g242450 = Out_PivotWS15_g242540;
					float2 Model_PivotWS_XZ145_g242450 = (Model_PivotWS498_g242450).xz;
					float2 lerpResult300_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g242469 = lerpResult300_g242450;
					float temp_output_82_0_g242467 = _GlobalCoatLayerValue;
					float temp_output_82_0_g242469 = temp_output_82_0_g242467;
					float4 tex2DArrayNode83_g242469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242469).zw + ( (temp_output_203_0_g242469).xy * temp_output_81_0_g242469 ) ),temp_output_82_0_g242469), 0.0 );
					float4 appendResult210_g242469 = (float4(tex2DArrayNode83_g242469.rgb , tex2DArrayNode83_g242469.a));
					float4 temp_output_204_0_g242469 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g242469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242469).zw + ( (temp_output_204_0_g242469).xy * temp_output_81_0_g242469 ) ),temp_output_82_0_g242469), 0.0 );
					float4 appendResult212_g242469 = (float4(tex2DArrayNode122_g242469.rgb , tex2DArrayNode122_g242469.a));
					float4 TVE_RenderNearPositionR628_g242450 = TVE_RenderNearPositionR;
					float temp_output_507_0_g242450 = saturate( ( distance( Model_PositionWS497_g242450 , (TVE_RenderNearPositionR628_g242450).xyz ) / (TVE_RenderNearPositionR628_g242450).w ) );
					float temp_output_7_0_g242539 = 1.0;
					float temp_output_9_0_g242539 = ( temp_output_507_0_g242450 - temp_output_7_0_g242539 );
					half TVE_RenderNearFadeValue635_g242450 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g242450 = saturate( ( temp_output_9_0_g242539 / ( ( TVE_RenderNearFadeValue635_g242450 - temp_output_7_0_g242539 ) + 0.0001 ) ) );
					float4 lerpResult131_g242469 = lerp( appendResult210_g242469 , appendResult212_g242469 , Global_TexBlend509_g242450);
					float4 temp_output_159_109_g242467 = lerpResult131_g242469;
					float4 lerpResult168_g242467 = lerp( TVE_CoatParams , temp_output_159_109_g242467 , TVE_CoatLayers[(int)temp_output_82_0_g242467]);
					float4 temp_output_589_109_g242450 = lerpResult168_g242467;
					half4 Coat_Texture302_g242450 = temp_output_589_109_g242450;
					float4 In_CoatTexture204_g242450 = Coat_Texture302_g242450;
					half4 Draw_Texture656_g242450 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g242450 = Draw_Texture656_g242450;
					float4 temp_output_203_0_g242494 = TVE_PaintBaseCoord;
					float2 lerpResult85_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g242494 = lerpResult85_g242450;
					float temp_output_82_0_g242491 = _GlobalPaintLayerValue;
					float temp_output_82_0_g242494 = temp_output_82_0_g242491;
					float4 tex2DArrayNode83_g242494 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242494).zw + ( (temp_output_203_0_g242494).xy * temp_output_81_0_g242494 ) ),temp_output_82_0_g242494), 0.0 );
					float4 appendResult210_g242494 = (float4(tex2DArrayNode83_g242494.rgb , tex2DArrayNode83_g242494.a));
					float4 temp_output_204_0_g242494 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g242494 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242494).zw + ( (temp_output_204_0_g242494).xy * temp_output_81_0_g242494 ) ),temp_output_82_0_g242494), 0.0 );
					float4 appendResult212_g242494 = (float4(tex2DArrayNode122_g242494.rgb , tex2DArrayNode122_g242494.a));
					float4 lerpResult131_g242494 = lerp( appendResult210_g242494 , appendResult212_g242494 , Global_TexBlend509_g242450);
					float4 temp_output_171_109_g242491 = lerpResult131_g242494;
					float4 lerpResult174_g242491 = lerp( TVE_PaintParams , temp_output_171_109_g242491 , TVE_PaintLayers[(int)temp_output_82_0_g242491]);
					float4 temp_output_595_109_g242450 = lerpResult174_g242491;
					half4 Paint_Texture71_g242450 = temp_output_595_109_g242450;
					float4 In_PaintTexture204_g242450 = Paint_Texture71_g242450;
					float4 temp_output_203_0_g242477 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g242477 = lerpResult104_g242450;
					float temp_output_132_0_g242475 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g242477 = temp_output_132_0_g242475;
					float4 tex2DArrayNode83_g242477 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242477).zw + ( (temp_output_203_0_g242477).xy * temp_output_81_0_g242477 ) ),temp_output_82_0_g242477), 0.0 );
					float4 appendResult210_g242477 = (float4(tex2DArrayNode83_g242477.rgb , tex2DArrayNode83_g242477.a));
					float4 temp_output_204_0_g242477 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g242477 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242477).zw + ( (temp_output_204_0_g242477).xy * temp_output_81_0_g242477 ) ),temp_output_82_0_g242477), 0.0 );
					float4 appendResult212_g242477 = (float4(tex2DArrayNode122_g242477.rgb , tex2DArrayNode122_g242477.a));
					float4 lerpResult131_g242477 = lerp( appendResult210_g242477 , appendResult212_g242477 , Global_TexBlend509_g242450);
					float4 temp_output_137_109_g242475 = lerpResult131_g242477;
					float4 lerpResult145_g242475 = lerp( TVE_AtmoParams , temp_output_137_109_g242475 , TVE_AtmoLayers[(int)temp_output_132_0_g242475]);
					float4 temp_output_590_110_g242450 = lerpResult145_g242475;
					half4 Atmo_Texture80_g242450 = temp_output_590_110_g242450;
					float4 In_AtmoTexture204_g242450 = Atmo_Texture80_g242450;
					float4 temp_output_203_0_g242545 = TVE_EffexBaseCoord;
					float2 lerpResult414_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g242545 = lerpResult414_g242450;
					float temp_output_132_0_g242543 = _GlobalEffexLayerValue;
					float temp_output_82_0_g242545 = temp_output_132_0_g242543;
					float4 tex2DArrayNode83_g242545 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242545).zw + ( (temp_output_203_0_g242545).xy * temp_output_81_0_g242545 ) ),temp_output_82_0_g242545), 0.0 );
					float4 appendResult210_g242545 = (float4(tex2DArrayNode83_g242545.rgb , tex2DArrayNode83_g242545.a));
					float4 temp_output_204_0_g242545 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g242545 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242545).zw + ( (temp_output_204_0_g242545).xy * temp_output_81_0_g242545 ) ),temp_output_82_0_g242545), 0.0 );
					float4 appendResult212_g242545 = (float4(tex2DArrayNode122_g242545.rgb , tex2DArrayNode122_g242545.a));
					float4 lerpResult131_g242545 = lerp( appendResult210_g242545 , appendResult212_g242545 , Global_TexBlend509_g242450);
					float4 temp_output_137_109_g242543 = lerpResult131_g242545;
					float4 lerpResult145_g242543 = lerp( TVE_EffexParams , temp_output_137_109_g242543 , TVE_EffexLayers[(int)temp_output_132_0_g242543]);
					float4 temp_output_731_110_g242450 = lerpResult145_g242543;
					half4 Effex_Texture420_g242450 = temp_output_731_110_g242450;
					float4 In_EffexTexture204_g242450 = Effex_Texture420_g242450;
					float4 temp_output_203_0_g242525 = TVE_GlowBaseCoord;
					float2 lerpResult247_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g242525 = lerpResult247_g242450;
					float temp_output_82_0_g242523 = _GlobalGlowLayerValue;
					float temp_output_82_0_g242525 = temp_output_82_0_g242523;
					float4 tex2DArrayNode83_g242525 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242525).zw + ( (temp_output_203_0_g242525).xy * temp_output_81_0_g242525 ) ),temp_output_82_0_g242525), 0.0 );
					float4 appendResult210_g242525 = (float4(tex2DArrayNode83_g242525.rgb , tex2DArrayNode83_g242525.a));
					float4 temp_output_204_0_g242525 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g242525 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242525).zw + ( (temp_output_204_0_g242525).xy * temp_output_81_0_g242525 ) ),temp_output_82_0_g242525), 0.0 );
					float4 appendResult212_g242525 = (float4(tex2DArrayNode122_g242525.rgb , tex2DArrayNode122_g242525.a));
					float4 lerpResult131_g242525 = lerp( appendResult210_g242525 , appendResult212_g242525 , Global_TexBlend509_g242450);
					float4 temp_output_159_109_g242523 = lerpResult131_g242525;
					float4 lerpResult167_g242523 = lerp( TVE_GlowParams , temp_output_159_109_g242523 , TVE_GlowLayers[(int)temp_output_82_0_g242523]);
					float4 temp_output_593_109_g242450 = lerpResult167_g242523;
					half4 Glow_Texture248_g242450 = temp_output_593_109_g242450;
					float4 In_GlowTexture204_g242450 = Glow_Texture248_g242450;
					float4 temp_output_203_0_g242461 = TVE_FormBaseCoord;
					float2 lerpResult168_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g242461 = lerpResult168_g242450;
					float temp_output_130_0_g242459 = _GlobalFormLayerValue;
					float temp_output_82_0_g242461 = temp_output_130_0_g242459;
					float4 tex2DArrayNode83_g242461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242461).zw + ( (temp_output_203_0_g242461).xy * temp_output_81_0_g242461 ) ),temp_output_82_0_g242461), 0.0 );
					float4 appendResult210_g242461 = (float4(tex2DArrayNode83_g242461.rgb , tex2DArrayNode83_g242461.a));
					float4 temp_output_204_0_g242461 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g242461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242461).zw + ( (temp_output_204_0_g242461).xy * temp_output_81_0_g242461 ) ),temp_output_82_0_g242461), 0.0 );
					float4 appendResult212_g242461 = (float4(tex2DArrayNode122_g242461.rgb , tex2DArrayNode122_g242461.a));
					float4 lerpResult131_g242461 = lerp( appendResult210_g242461 , appendResult212_g242461 , Global_TexBlend509_g242450);
					float4 temp_output_135_109_g242459 = lerpResult131_g242461;
					float4 lerpResult143_g242459 = lerp( TVE_FormParams , temp_output_135_109_g242459 , TVE_FormLayers[(int)temp_output_130_0_g242459]);
					float4 temp_output_592_0_g242450 = lerpResult143_g242459;
					float4 Form_Texture112_g242450 = temp_output_592_0_g242450;
					float4 In_FormTexture204_g242450 = Form_Texture112_g242450;
					float4 In_LandTexture204_g242450 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g242509 = TVE_VertxBaseCoord;
					float2 lerpResult681_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g242509 = lerpResult681_g242450;
					float temp_output_136_0_g242507 = _GlobalVertxLayerValue;
					float temp_output_82_0_g242509 = temp_output_136_0_g242507;
					float4 tex2DArrayNode83_g242509 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242509).zw + ( (temp_output_203_0_g242509).xy * temp_output_81_0_g242509 ) ),temp_output_82_0_g242509), 0.0 );
					float4 appendResult210_g242509 = (float4(tex2DArrayNode83_g242509.rgb , tex2DArrayNode83_g242509.a));
					float4 temp_output_204_0_g242509 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g242509 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242509).zw + ( (temp_output_204_0_g242509).xy * temp_output_81_0_g242509 ) ),temp_output_82_0_g242509), 0.0 );
					float4 appendResult212_g242509 = (float4(tex2DArrayNode122_g242509.rgb , tex2DArrayNode122_g242509.a));
					float4 lerpResult131_g242509 = lerp( appendResult210_g242509 , appendResult212_g242509 , Global_TexBlend509_g242450);
					float4 temp_output_141_109_g242507 = lerpResult131_g242509;
					float4 lerpResult149_g242507 = lerp( TVE_VertxParams , temp_output_141_109_g242507 , TVE_VertxLayers[(int)temp_output_136_0_g242507]);
					float4 temp_output_695_0_g242450 = lerpResult149_g242507;
					half4 Vertx_Texture693_g242450 = temp_output_695_0_g242450;
					float4 In_VertxTexture204_g242450 = Vertx_Texture693_g242450;
					float4 temp_output_203_0_g242485 = TVE_FlowBaseCoord;
					float2 lerpResult400_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g242485 = lerpResult400_g242450;
					float temp_output_136_0_g242483 = _GlobalFlowLayerValue;
					float temp_output_82_0_g242485 = temp_output_136_0_g242483;
					float4 tex2DArrayNode83_g242485 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242485).zw + ( (temp_output_203_0_g242485).xy * temp_output_81_0_g242485 ) ),temp_output_82_0_g242485), 0.0 );
					float4 appendResult210_g242485 = (float4(tex2DArrayNode83_g242485.rgb , tex2DArrayNode83_g242485.a));
					float4 temp_output_204_0_g242485 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g242485 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242485).zw + ( (temp_output_204_0_g242485).xy * temp_output_81_0_g242485 ) ),temp_output_82_0_g242485), 0.0 );
					float4 appendResult212_g242485 = (float4(tex2DArrayNode122_g242485.rgb , tex2DArrayNode122_g242485.a));
					float4 lerpResult131_g242485 = lerp( appendResult210_g242485 , appendResult212_g242485 , Global_TexBlend509_g242450);
					float4 temp_output_141_109_g242483 = lerpResult131_g242485;
					float4 lerpResult149_g242483 = lerp( TVE_FlowParams , temp_output_141_109_g242483 , TVE_FlowLayers[(int)temp_output_136_0_g242483]);
					float4 temp_output_594_0_g242450 = lerpResult149_g242483;
					half4 Flow_Texture405_g242450 = temp_output_594_0_g242450;
					float4 In_FlowTexture204_g242450 = Flow_Texture405_g242450;
					half4 User_Texture677_g242450 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g242450 = User_Texture677_g242450;
					BuildGlobalData( Data204_g242450 , In_Dummy204_g242450 , In_CoatTexture204_g242450 , In_DrawTexture204_g242450 , In_PaintTexture204_g242450 , In_AtmoTexture204_g242450 , In_EffexTexture204_g242450 , In_GlowTexture204_g242450 , In_FormTexture204_g242450 , In_LandTexture204_g242450 , In_VertxTexture204_g242450 , In_FlowTexture204_g242450 , In_UserTexture204_g242450 );
					TVEGlobalData Data15_g251568 =(TVEGlobalData)Data204_g242450;
					float Out_Dummy15_g251568 = 0.0;
					float4 Out_CoatTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251568 = float4( 0,0,0,0 );
					BreakData( Data15_g251568 , Out_Dummy15_g251568 , Out_CoatTexture15_g251568 , Out_DrawTexture15_g251568 , Out_PaintTexture15_g251568 , Out_AtmoTexture15_g251568 , Out_EffexTexture15_g251568 , Out_GlowTexture15_g251568 , Out_FormTexture15_g251568 , Out_LandTexture15_g251568 , Out_VertxTexture15_g251568 , Out_FlowTexture15_g251568 , Out_UserTexture15_g251568 );
					float4 Global_FormTexture351_g251558 = Out_FormTexture15_g251568;
					TVEModelData Data15_g251565 =(TVEModelData)Data15_g251556;
					float Out_Dummy15_g251565 = 0.0;
					float3 Out_PositionOS15_g251565 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251565 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251565 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251565 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251565 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251565 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251565 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251565 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251565 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251565 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251565 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251565 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251565 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251565 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251565 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251565 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251565 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251565 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251565 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251565 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251565 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251565 , Out_Dummy15_g251565 , Out_PositionOS15_g251565 , Out_PositionWS15_g251565 , Out_PositionWO15_g251565 , Out_PositionRawOS15_g251565 , Out_PivotOS15_g251565 , Out_PivotWS15_g251565 , Out_PivotWO15_g251565 , Out_NormalOS15_g251565 , Out_NormalWS15_g251565 , Out_NormalRawOS15_g251565 , Out_TangentOS15_g251565 , Out_TangentWS15_g251565 , Out_BitangentWS15_g251565 , Out_ViewDirWS15_g251565 , Out_CoordsData15_g251565 , Out_VertexData15_g251565 , Out_MasksData15_g251565 , Out_PhaseData15_g251565 , Out_TransformData15_g251565 , Out_RotationData15_g251565 , Out_Interpolator15_g251565 );
					float3 Model_PivotWO353_g251558 = Out_PivotWO15_g251565;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251564 = _ConformMeshMode;
					float Option70_g251564 = temp_output_17_0_g251564;
					half4 Model_VertexData357_g251558 = Out_VertexData15_g251565;
					float4 temp_output_3_0_g251564 = Model_VertexData357_g251558;
					float4 Channel70_g251564 = temp_output_3_0_g251564;
					float localSwitchChannel470_g251564 = SwitchChannel4( Option70_g251564 , Channel70_g251564 );
					float temp_output_390_0_g251558 = localSwitchChannel470_g251564;
					float temp_output_7_0_g251561 = _ConformMeshRemap.x;
					float temp_output_9_0_g251561 = ( temp_output_390_0_g251558 - temp_output_7_0_g251561 );
					float lerpResult374_g251558 = lerp( 1.0 , saturate( ( temp_output_9_0_g251561 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251558 = lerpResult374_g251558;
					float temp_output_328_0_g251558 = ( Blend_VertMask379_g251558 * TVE_IsEnabled );
					half Conform_Mask366_g251558 = temp_output_328_0_g251558;
					float temp_output_322_0_g251558 = ( ( ( ( (Global_FormTexture351_g251558).z - ( (Model_PivotWO353_g251558).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251558 ) );
					float3 appendResult329_g251558 = (float3(0.0 , temp_output_322_0_g251558 , 0.0));
					float3 appendResult387_g251558 = (float3(0.0 , 0.0 , temp_output_322_0_g251558));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251562 = appendResult387_g251558;
					#else
					float3 staticSwitch65_g251562 = appendResult329_g251558;
					#endif
					float3 Blanket_Conform368_g251558 = staticSwitch65_g251562;
					float4 appendResult312_g251558 = (float4(Blanket_Conform368_g251558 , 0.0));
					float4 temp_output_310_0_g251558 = ( Model_TransformData356_g251558 + appendResult312_g251558 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251558 = temp_output_310_0_g251558;
					#else
					float4 staticSwitch364_g251558 = Model_TransformData356_g251558;
					#endif
					half4 Final_TransformData365_g251558 = staticSwitch364_g251558;
					float4 In_TransformData16_g251567 = Final_TransformData365_g251558;
					float4 In_RotationData16_g251567 = Out_RotationData15_g251566;
					float4 In_Interpolator16_g251567 = Out_Interpolator15_g251566;
					BuildVertexData( Data16_g251567 , In_Dummy16_g251567 , In_PositionOS16_g251567 , In_NormalOS16_g251567 , In_TangentOS16_g251567 , In_TransformData16_g251567 , In_RotationData16_g251567 , In_Interpolator16_g251567 );
					TVEVertexData Data15_g251578 =(TVEVertexData)Data16_g251567;
					float Out_Dummy15_g251578 = 0.0;
					float3 Out_PositionOS15_g251578 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251578 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251578 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251578 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251578 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251578 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251578 , Out_Dummy15_g251578 , Out_PositionOS15_g251578 , Out_NormalOS15_g251578 , Out_TangentOS15_g251578 , Out_TransformData15_g251578 , Out_RotationData15_g251578 , Out_Interpolator15_g251578 );
					TVEVertexData Data16_g251579 =(TVEVertexData)Data15_g251578;
					float In_Dummy16_g251579 = 0.0;
					float3 Vertex_PositionOS147_g251569 = Out_PositionOS15_g251578;
					half3 VertexPos40_g251573 = Vertex_PositionOS147_g251569;
					float4 temp_output_1615_33_g251569 = Out_RotationData15_g251578;
					half4 Vertex_RotationData1569_g251569 = temp_output_1615_33_g251569;
					float2 break1582_g251569 = (Vertex_RotationData1569_g251569).xy;
					half Angle44_g251573 = break1582_g251569.y;
					half CosAngle89_g251573 = cos( Angle44_g251573 );
					half SinAngle93_g251573 = sin( Angle44_g251573 );
					float3 appendResult95_g251573 = (float3((VertexPos40_g251573).x , ( ( (VertexPos40_g251573).y * CosAngle89_g251573 ) - ( (VertexPos40_g251573).z * SinAngle93_g251573 ) ) , ( ( (VertexPos40_g251573).y * SinAngle93_g251573 ) + ( (VertexPos40_g251573).z * CosAngle89_g251573 ) )));
					half3 VertexPos40_g251574 = appendResult95_g251573;
					half Angle44_g251574 = -break1582_g251569.x;
					half CosAngle94_g251574 = cos( Angle44_g251574 );
					half SinAngle95_g251574 = sin( Angle44_g251574 );
					float3 appendResult98_g251574 = (float3(( ( (VertexPos40_g251574).x * CosAngle94_g251574 ) - ( (VertexPos40_g251574).y * SinAngle95_g251574 ) ) , ( ( (VertexPos40_g251574).x * SinAngle95_g251574 ) + ( (VertexPos40_g251574).y * CosAngle94_g251574 ) ) , (VertexPos40_g251574).z));
					half3 VertexPos40_g251572 = Vertex_PositionOS147_g251569;
					half Angle44_g251572 = break1582_g251569.y;
					half CosAngle89_g251572 = cos( Angle44_g251572 );
					half SinAngle93_g251572 = sin( Angle44_g251572 );
					float3 appendResult95_g251572 = (float3((VertexPos40_g251572).x , ( ( (VertexPos40_g251572).y * CosAngle89_g251572 ) - ( (VertexPos40_g251572).z * SinAngle93_g251572 ) ) , ( ( (VertexPos40_g251572).y * SinAngle93_g251572 ) + ( (VertexPos40_g251572).z * CosAngle89_g251572 ) )));
					half3 VertexPos40_g251577 = appendResult95_g251572;
					half Angle44_g251577 = break1582_g251569.x;
					half CosAngle91_g251577 = cos( Angle44_g251577 );
					half SinAngle92_g251577 = sin( Angle44_g251577 );
					float3 appendResult93_g251577 = (float3(( ( (VertexPos40_g251577).x * CosAngle91_g251577 ) + ( (VertexPos40_g251577).z * SinAngle92_g251577 ) ) , (VertexPos40_g251577).y , ( ( -(VertexPos40_g251577).x * SinAngle92_g251577 ) + ( (VertexPos40_g251577).z * CosAngle91_g251577 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251575 = appendResult93_g251577;
					#else
					float3 staticSwitch65_g251575 = appendResult98_g251574;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251570 = staticSwitch65_g251575;
					#else
					float3 staticSwitch65_g251570 = Vertex_PositionOS147_g251569;
					#endif
					float3 temp_output_1608_0_g251569 = staticSwitch65_g251570;
					half3 VertexPos40_g251576 = temp_output_1608_0_g251569;
					half Angle44_g251576 = (Vertex_RotationData1569_g251569).z;
					half CosAngle91_g251576 = cos( Angle44_g251576 );
					half SinAngle92_g251576 = sin( Angle44_g251576 );
					float3 appendResult93_g251576 = (float3(( ( (VertexPos40_g251576).x * CosAngle91_g251576 ) + ( (VertexPos40_g251576).z * SinAngle92_g251576 ) ) , (VertexPos40_g251576).y , ( ( -(VertexPos40_g251576).x * SinAngle92_g251576 ) + ( (VertexPos40_g251576).z * CosAngle91_g251576 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251571 = appendResult93_g251576;
					#else
					float3 staticSwitch65_g251571 = temp_output_1608_0_g251569;
					#endif
					float4 temp_output_1615_31_g251569 = Out_TransformData15_g251578;
					half4 Vertex_TransformData1568_g251569 = temp_output_1615_31_g251569;
					half3 Final_PositionOS178_g251569 = ( ( staticSwitch65_g251571 * (Vertex_TransformData1568_g251569).w ) + (Vertex_TransformData1568_g251569).xyz );
					float3 In_PositionOS16_g251579 = Final_PositionOS178_g251569;
					float3 In_NormalOS16_g251579 = Out_NormalOS15_g251578;
					float4 In_TangentOS16_g251579 = Out_TangentOS15_g251578;
					float4 In_TransformData16_g251579 = temp_output_1615_31_g251569;
					float4 In_RotationData16_g251579 = temp_output_1615_33_g251569;
					float4 In_Interpolator16_g251579 = Out_Interpolator15_g251578;
					BuildVertexData( Data16_g251579 , In_Dummy16_g251579 , In_PositionOS16_g251579 , In_NormalOS16_g251579 , In_TangentOS16_g251579 , In_TransformData16_g251579 , In_RotationData16_g251579 , In_Interpolator16_g251579 );
					TVEVertexData Data15_g251582 =(TVEVertexData)Data16_g251579;
					float Out_Dummy15_g251582 = 0.0;
					float3 Out_PositionOS15_g251582 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251582 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251582 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251582 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251582 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251582 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251582 , Out_Dummy15_g251582 , Out_PositionOS15_g251582 , Out_NormalOS15_g251582 , Out_TangentOS15_g251582 , Out_TransformData15_g251582 , Out_RotationData15_g251582 , Out_Interpolator15_g251582 );
					TVEVertexData Data16_g251583 =(TVEVertexData)Data15_g251582;
					float In_Dummy16_g251583 = 0.0;
					TVEModelData Data15_g251581 =(TVEModelData)Data15_g251565;
					float Out_Dummy15_g251581 = 0.0;
					float3 Out_PositionOS15_g251581 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251581 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251581 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251581 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251581 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251581 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251581 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251581 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251581 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251581 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251581 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251581 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251581 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251581 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251581 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251581 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251581 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251581 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251581 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251581 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251581 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251581 , Out_Dummy15_g251581 , Out_PositionOS15_g251581 , Out_PositionWS15_g251581 , Out_PositionWO15_g251581 , Out_PositionRawOS15_g251581 , Out_PivotOS15_g251581 , Out_PivotWS15_g251581 , Out_PivotWO15_g251581 , Out_NormalOS15_g251581 , Out_NormalWS15_g251581 , Out_NormalRawOS15_g251581 , Out_TangentOS15_g251581 , Out_TangentWS15_g251581 , Out_BitangentWS15_g251581 , Out_ViewDirWS15_g251581 , Out_CoordsData15_g251581 , Out_VertexData15_g251581 , Out_MasksData15_g251581 , Out_PhaseData15_g251581 , Out_TransformData15_g251581 , Out_RotationData15_g251581 , Out_Interpolator15_g251581 );
					float3 In_PositionOS16_g251583 = ( Out_PositionOS15_g251582 + Out_PivotOS15_g251581 );
					float3 In_NormalOS16_g251583 = Out_NormalOS15_g251582;
					float4 In_TangentOS16_g251583 = Out_TangentOS15_g251582;
					float4 In_TransformData16_g251583 = Out_TransformData15_g251582;
					float4 In_RotationData16_g251583 = Out_RotationData15_g251582;
					float4 In_Interpolator16_g251583 = Out_Interpolator15_g251582;
					BuildVertexData( Data16_g251583 , In_Dummy16_g251583 , In_PositionOS16_g251583 , In_NormalOS16_g251583 , In_TangentOS16_g251583 , In_TransformData16_g251583 , In_RotationData16_g251583 , In_Interpolator16_g251583 );
					TVEVertexData Data15_g251728 =(TVEVertexData)Data16_g251583;
					float Out_Dummy15_g251728 = 0.0;
					float3 Out_PositionOS15_g251728 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251728 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251728 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251728 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251728 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251728 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251728 , Out_Dummy15_g251728 , Out_PositionOS15_g251728 , Out_NormalOS15_g251728 , Out_TangentOS15_g251728 , Out_TransformData15_g251728 , Out_RotationData15_g251728 , Out_Interpolator15_g251728 );
					
					float3 color107_g251670 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g251670 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float localBreakData4_g251669 = ( 0.0 );
					float localBuildMasksData3_g251658 = ( 0.0 );
					TVEMasksData Data3_g251658 = (TVEMasksData)0;
					half Feature_Intensity1846_g251655 = _TransferIntensityValue;
					float ifLocalVar18_g251660 = 0;
					if( Feature_Intensity1846_g251655 <= 0.0 )
					ifLocalVar18_g251660 = 0.0;
					else
					ifLocalVar18_g251660 = 1.0;
					float4 temp_cast_13 = (ifLocalVar18_g251660).xxxx;
					float4 In_MaskA3_g251658 = temp_cast_13;
					float temp_output_17_0_g251666 = _TransferMeshMode;
					float Option70_g251666 = temp_output_17_0_g251666;
					TVEModelData Data15_g251656 =(TVEModelData)Data26_g242551;
					float Out_Dummy15_g251656 = 0.0;
					float3 Out_PositionOS15_g251656 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251656 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251656 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251656 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251656 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251656 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251656 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251656 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251656 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251656 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251656 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251656 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251656 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251656 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251656 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251656 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251656 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251656 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251656 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251656 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251656 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251656 , Out_Dummy15_g251656 , Out_PositionOS15_g251656 , Out_PositionWS15_g251656 , Out_PositionWO15_g251656 , Out_PositionRawOS15_g251656 , Out_PivotOS15_g251656 , Out_PivotWS15_g251656 , Out_PivotWO15_g251656 , Out_NormalOS15_g251656 , Out_NormalWS15_g251656 , Out_NormalRawOS15_g251656 , Out_TangentOS15_g251656 , Out_TangentWS15_g251656 , Out_BitangentWS15_g251656 , Out_ViewDirWS15_g251656 , Out_CoordsData15_g251656 , Out_VertexData15_g251656 , Out_MasksData15_g251656 , Out_PhaseData15_g251656 , Out_TransformData15_g251656 , Out_RotationData15_g251656 , Out_Interpolator15_g251656 );
					float4 temp_output_1567_29_g251655 = Out_VertexData15_g251656;
					half4 Model_VertexData1608_g251655 = temp_output_1567_29_g251655;
					float4 temp_output_3_0_g251666 = Model_VertexData1608_g251655;
					float4 Channel70_g251666 = temp_output_3_0_g251666;
					float localSwitchChannel470_g251666 = SwitchChannel4( Option70_g251666 , Channel70_g251666 );
					float temp_output_1870_0_g251655 = localSwitchChannel470_g251666;
					float temp_output_7_0_g251665 = _TransferMeshRemap.x;
					float temp_output_9_0_g251665 = ( temp_output_1870_0_g251655 - temp_output_7_0_g251665 );
					float lerpResult1868_g251655 = lerp( 1.0 , saturate( ( temp_output_9_0_g251665 * _TransferMeshRemap.z ) ) , _TransferMeshValue);
					half Blend_MeshMask1876_g251655 = lerpResult1868_g251655;
					half Blend_Mask1742_g251655 = ( _TransferIntensityValue * Blend_MeshMask1876_g251655 * TVE_IsEnabled );
					float ifLocalVar18_g251668 = 0;
					if( Feature_Intensity1846_g251655 <= 0.0 )
					ifLocalVar18_g251668 = 0.0;
					else
					ifLocalVar18_g251668 = Blend_Mask1742_g251655;
					float4 appendResult1840_g251655 = (float4(ifLocalVar18_g251668 , 0.0 , 0.0 , 0.0));
					float4 In_MaskB3_g251658 = appendResult1840_g251655;
					TVEVertexData Data15_g251662 =(TVEVertexData)Data16_g251583;
					float Out_Dummy15_g251662 = 0.0;
					float3 Out_PositionOS15_g251662 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251662 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251662 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251662 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251662 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251662 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251662 , Out_Dummy15_g251662 , Out_PositionOS15_g251662 , Out_NormalOS15_g251662 , Out_TangentOS15_g251662 , Out_TransformData15_g251662 , Out_RotationData15_g251662 , Out_Interpolator15_g251662 );
					half3 Vertex_NormalOS1568_g251655 = Out_NormalOS15_g251662;
					TVEGlobalData Data15_g251661 =(TVEGlobalData)Data204_g242450;
					float Out_Dummy15_g251661 = 0.0;
					float4 Out_CoatTexture15_g251661 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251661 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251661 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251661 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251661 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251661 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251661 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251661 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251661 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251661 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251661 = float4( 0,0,0,0 );
					BreakData( Data15_g251661 , Out_Dummy15_g251661 , Out_CoatTexture15_g251661 , Out_DrawTexture15_g251661 , Out_PaintTexture15_g251661 , Out_AtmoTexture15_g251661 , Out_EffexTexture15_g251661 , Out_GlowTexture15_g251661 , Out_FormTexture15_g251661 , Out_LandTexture15_g251661 , Out_VertxTexture15_g251661 , Out_FlowTexture15_g251661 , Out_UserTexture15_g251661 );
					half4 Global_FormTexture1633_g251655 = Out_FormTexture15_g251661;
					float2 temp_output_1627_0_g251655 = ((Global_FormTexture1633_g251655).xy*2.0 + -1.0);
					float2 break1617_g251655 = temp_output_1627_0_g251655;
					float dotResult1619_g251655 = dot( temp_output_1627_0_g251655 , temp_output_1627_0_g251655 );
					float3 appendResult1618_g251655 = (float3(break1617_g251655.x , sqrt( ( 1.0 - saturate( dotResult1619_g251655 ) ) ) , break1617_g251655.y));
					float3 worldToObjDir1623_g251655 = mul( unity_WorldToObject, float4( appendResult1618_g251655, 0.0 ) ).xyz;
					half3 Surface_Normal1630_g251655 = worldToObjDir1623_g251655;
					float3 lerpResult1670_g251655 = lerp( Vertex_NormalOS1568_g251655 , Surface_Normal1630_g251655 , Blend_Mask1742_g251655);
					#ifdef TVE_TRANSFER
					float3 staticSwitch1716_g251655 = lerpResult1670_g251655;
					#else
					float3 staticSwitch1716_g251655 = Vertex_NormalOS1568_g251655;
					#endif
					half3 Final_NormalOS178_g251655 = staticSwitch1716_g251655;
					float3 ifLocalVar18_g251659 = 0;
					if( Feature_Intensity1846_g251655 <= 0.0 )
					ifLocalVar18_g251659 = Vertex_NormalOS1568_g251655;
					else
					ifLocalVar18_g251659 = Final_NormalOS178_g251655;
					float4 appendResult1839_g251655 = (float4(ifLocalVar18_g251659 , 0.0));
					float4 In_MaskC3_g251658 = appendResult1839_g251655;
					float4 temp_cast_14 = (0.0).xxxx;
					float4 In_MaskD3_g251658 = temp_cast_14;
					float4 temp_cast_15 = (0.0).xxxx;
					float4 In_MaskE3_g251658 = temp_cast_15;
					float4 temp_cast_16 = (0.0).xxxx;
					float4 In_MaskF3_g251658 = temp_cast_16;
					float4 temp_cast_17 = (0.0).xxxx;
					float4 In_MaskG3_g251658 = temp_cast_17;
					float4 temp_cast_18 = (0.0).xxxx;
					float4 In_MaskH3_g251658 = temp_cast_18;
					float4 temp_cast_19 = (0.0).xxxx;
					float4 In_MaskI3_g251658 = temp_cast_19;
					float4 temp_cast_20 = (0.0).xxxx;
					float4 In_MaskJ3_g251658 = temp_cast_20;
					float4 temp_cast_21 = (0.0).xxxx;
					float4 In_MaskK3_g251658 = temp_cast_21;
					float4 temp_cast_22 = (0.0).xxxx;
					float4 In_MaskL3_g251658 = temp_cast_22;
					{
					Data3_g251658.MaskA = In_MaskA3_g251658;
					Data3_g251658.MaskB = In_MaskB3_g251658;
					Data3_g251658.MaskC = In_MaskC3_g251658;
					Data3_g251658.MaskD = In_MaskD3_g251658;
					Data3_g251658.MaskE = In_MaskE3_g251658;
					Data3_g251658.MaskF = In_MaskF3_g251658;
					Data3_g251658.MaskG = In_MaskG3_g251658;
					Data3_g251658.MaskH = In_MaskH3_g251658;
					Data3_g251658.MaskI = In_MaskI3_g251658;
					Data3_g251658.MaskJ= In_MaskJ3_g251658;
					Data3_g251658.MaskK= In_MaskK3_g251658;
					Data3_g251658.MaskL = In_MaskL3_g251658;
					}
					TVEMasksData Data4_g251669 = Data3_g251658;
					float4 Out_MaskA4_g251669 = float4( 0,0,0,0 );
					float4 Out_MaskB4_g251669 = float4( 0,0,0,0 );
					float4 Out_MaskC4_g251669 = float4( 0,0,0,0 );
					float4 Out_MaskD4_g251669 = float4( 0,0,0,0 );
					float4 Out_MaskE4_g251669 = float4( 0,0,0,0 );
					float4 Out_MaskF4_g251669 = float4( 0,0,0,0 );
					float4 Out_MaskG4_g251669 = float4( 0,0,0,0 );
					float4 Out_MaskH4_g251669 = float4( 0,0,0,0 );
					{
					Out_MaskA4_g251669 = Data4_g251669.MaskA;
					Out_MaskB4_g251669 = Data4_g251669.MaskB;
					Out_MaskC4_g251669 = Data4_g251669.MaskC;
					Out_MaskD4_g251669 = Data4_g251669.MaskD;
					Out_MaskE4_g251669 = Data4_g251669.MaskE;
					Out_MaskF4_g251669 = Data4_g251669.MaskF;
					Out_MaskG4_g251669 = Data4_g251669.MaskG;
					Out_MaskH4_g251669 = Data4_g251669.MaskH;
					}
					float3 lerpResult2568 = lerp( color107_g251670 , color106_g251670 , (Out_MaskA4_g251669).x);
					float3 ifLocalVar40_g251674 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g251674 = lerpResult2568;
					float3 ifLocalVar40_g251675 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g251675 = (Out_MaskB4_g251669).xxx;
					float3 temp_output_2511_0 = (Out_MaskC4_g251669).xyz;
					float3 ifLocalVar40_g251672 = 0;
					if( TVE_DEBUG_Index == 4.0 )
					ifLocalVar40_g251672 = temp_output_2511_0;
					float3 objToWorldDir2643 = ASESafeNormalize( mul( unity_ObjectToWorld, float4( temp_output_2511_0, 0.0 ) ).xyz );
					float3 ifLocalVar40_g251673 = 0;
					if( TVE_DEBUG_Index == 5.0 )
					ifLocalVar40_g251673 = objToWorldDir2643;
					float3 vertexToFrag2524 = ( ifLocalVar40_g251674 + ifLocalVar40_g251675 + ( ifLocalVar40_g251672 + ifLocalVar40_g251673 ) );
					o.ase_texcoord6.xyz = vertexToFrag2524;
					float3 vertexPos57_g251720 = v.vertex.xyz;
					float4 ase_positionCS57_g251720 = UnityObjectToClipPos( vertexPos57_g251720 );
					o.ase_texcoord7 = ase_positionCS57_g251720;
					o.ase_texcoord8.xyz = vertexToFrag73_g242429;
					o.ase_texcoord9.xyz = vertexToFrag76_g242429;
					TVEVertexData Data1902_g251676 = Data16_g251583;
					float4 Out_Interpolator1902_g251676 = float4( 0,0,0,0 );
					{
					Out_Interpolator1902_g251676 = Data1902_g251676.Interpolator;
					}
					float4 vertexToFrag1901_g251676 = Out_Interpolator1902_g251676;
					o.ase_texcoord11 = vertexToFrag1901_g251676;
					
					o.ase_texcoord10.xy = v.texcoord.xyzw.xy;
					o.ase_texcoord10.zw = v.texcoord2.xyzw.xy;
					o.ase_color = v.ase_color;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord6.w = 0;
					o.ase_texcoord8.w = 0;
					o.ase_texcoord9.w = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251728;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251728;
					v.tangent = Out_TangentOS15_g251728;

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

					float temp_output_2609_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2609_114).xxx;
					
					float3 temp_cast_1 = (temp_output_2609_114).xxx;
					
					float3 color130_g251720 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g251720 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g251722 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g251721 = ( temp_cast_4 * ( 0.5 + appendResult128_g251722 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g251721 = (float4(ddx( FinalUV13_g251721 ) , ddy( FinalUV13_g251721 )));
					float4 UVDerivatives17_g251721 = appendResult16_g251721;
					float4 break28_g251721 = UVDerivatives17_g251721;
					float2 appendResult19_g251721 = (float2(break28_g251721.x , break28_g251721.z));
					float2 appendResult20_g251721 = (float2(break28_g251721.x , break28_g251721.z));
					float dotResult24_g251721 = dot( appendResult19_g251721 , appendResult20_g251721 );
					float2 appendResult21_g251721 = (float2(break28_g251721.y , break28_g251721.w));
					float2 appendResult22_g251721 = (float2(break28_g251721.y , break28_g251721.w));
					float dotResult23_g251721 = dot( appendResult21_g251721 , appendResult22_g251721 );
					float2 appendResult25_g251721 = (float2(dotResult24_g251721 , dotResult23_g251721));
					float2 derivativesLength29_g251721 = sqrt( appendResult25_g251721 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g251721 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g251721 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g251721 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g251721 = clampResult57_g251721;
					float2 break55_g251721 = derivativesLength29_g251721;
					float4 lerpResult73_g251721 = lerp( float4( color130_g251720 , 0.0 ) , float4( color81_g251720 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g251721.x * break71_g251721.y * sqrt( saturate( ( 1.1 - max( break55_g251721.x, break55_g251721.y ) ) ) ) ) ) ));
					float3 vertexToFrag2524 = IN.ase_texcoord6.xyz;
					half3 Final_Debug2399 = vertexToFrag2524;
					float temp_output_7_0_g251727 = TVE_DEBUG_Min;
					float3 temp_cast_9 = (temp_output_7_0_g251727).xxx;
					float3 temp_output_9_0_g251727 = ( Final_Debug2399 - temp_cast_9 );
					float lerpResult76_g251720 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g251720 = lerpResult76_g251720;
					float3 lerpResult72_g251720 = lerp( (lerpResult73_g251721).rgb , saturate( ( temp_output_9_0_g251727 / ( ( TVE_DEBUG_Max - temp_output_7_0_g251727 ) + 0.0001 ) ) ) , Filter152_g251720);
					float dotResult61_g251720 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g251720 = ( 1.0 - saturate( dotResult61_g251720 ) );
					float Shading_Fresnel59_g251720 = (( 1.0 - ( temp_output_65_0_g251720 * temp_output_65_0_g251720 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g251720 = IN.ase_texcoord7;
					float depthLinearEye57_g251720 = LinearEyeDepth( ase_positionCS57_g251720.z / ase_positionCS57_g251720.w );
					float temp_output_69_0_g251720 = saturate(  (0.0 + ( depthLinearEye57_g251720 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g251720 = (( temp_output_69_0_g251720 * temp_output_69_0_g251720 )*0.5 + 0.5);
					float lerpResult84_g251720 = lerp( 1.0 , Shading_Fresnel59_g251720 , ( Shading_Distance58_g251720 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g251725 = ( 0.0 );
					float localBuildVisualData3_g251682 = ( 0.0 );
					float localBuildVisualData3_g251677 = ( 0.0 );
					TVEVisualData Data3_g251677 =(TVEVisualData)0;
					float temp_output_14_0_g251677 = 0.0;
					float In_Dummy3_g251677 = temp_output_14_0_g251677;
					float3 temp_cast_10 = (0.5).xxx;
					float3 temp_output_4_0_g251677 = temp_cast_10;
					float3 In_Albedo3_g251677 = temp_output_4_0_g251677;
					float3 temp_cast_11 = (0.5).xxx;
					float3 temp_output_44_0_g251677 = temp_cast_11;
					float3 In_AlbedoBase3_g251677 = temp_output_44_0_g251677;
					float2 temp_cast_12 = (0.0).xx;
					float2 In_NormalTS3_g251677 = temp_cast_12;
					float3 temp_cast_13 = (0.5).xxx;
					float3 In_NormalWS3_g251677 = temp_cast_13;
					float4 In_Shader3_g251677 = half4( 0, 1, 0, 1 );
					float4 In_Feature3_g251677 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251677 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251677 = half4( 1, 1, 1, 1 );
					float temp_output_12_0_g251677 = 0.5;
					float In_Grayscale3_g251677 = temp_output_12_0_g251677;
					float temp_output_16_0_g251677 = 1.0;
					float In_Luminosity3_g251677 = temp_output_16_0_g251677;
					float In_MultiMask3_g251677 = 1.0;
					float In_AlphaClip3_g251677 = 1.0;
					float In_AlphaFade3_g251677 = 1.0;
					float3 temp_cast_14 = (1.0).xxx;
					float3 In_Translucency3_g251677 = temp_cast_14;
					float In_Transmission3_g251677 = 1.0;
					float In_Thickness3_g251677 = 0.0;
					float In_Diffusion3_g251677 = 0.0;
					float In_Depth3_g251677 = 0.0;
					BuildVisualData( Data3_g251677 , In_Dummy3_g251677 , In_Albedo3_g251677 , In_AlbedoBase3_g251677 , In_NormalTS3_g251677 , In_NormalWS3_g251677 , In_Shader3_g251677 , In_Feature3_g251677 , In_Season3_g251677 , In_Emissive3_g251677 , In_Grayscale3_g251677 , In_Luminosity3_g251677 , In_MultiMask3_g251677 , In_AlphaClip3_g251677 , In_AlphaFade3_g251677 , In_Translucency3_g251677 , In_Transmission3_g251677 , In_Thickness3_g251677 , In_Diffusion3_g251677 , In_Depth3_g251677 );
					TVEVisualData Data3_g251682 =(TVEVisualData)Data3_g251677;
					half Dummy130_g251680 = ( _MainCategory + _MainEnd );
					float temp_output_14_0_g251682 = Dummy130_g251680;
					float In_Dummy3_g251682 = temp_output_14_0_g251682;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251703) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g251685 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g251685 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g251685 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g251685 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g251685 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g251685 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g251703 = staticSwitch36_g251685;
					float localBreakTextureData456_g251703 = ( 0.0 );
					float localBuildTextureData431_g251702 = ( 0.0 );
					TVEMasksData Data431_g251702 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g251702 = ( 0.0 );
					float4 temp_output_6_0_g251718 = _main_coord_value;
					float4 temp_output_7_0_g251718 = ( _MainSampleMode + _MainCoordMode + _MainCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g251718 = ( temp_output_6_0_g251718 + temp_output_7_0_g251718 );
					#else
					float4 staticSwitch14_g251718 = temp_output_6_0_g251718;
					#endif
					half4 Local_Coords180_g251680 = staticSwitch14_g251718;
					float4 Coords444_g251702 = Local_Coords180_g251680;
					float localIfModelDataByShader26_g242408 = ( 0.0 );
					TVEModelData Data26_g242408 = (TVEModelData)0;
					TVEModelData Data16_g242437 =(TVEModelData)0;
					float In_Dummy16_g242437 = 0.0;
					float3 vertexToFrag73_g242429 = IN.ase_texcoord8.xyz;
					float3 PositionWS122_g242429 = vertexToFrag73_g242429;
					float3 In_PositionWS16_g242437 = PositionWS122_g242429;
					float3 vertexToFrag76_g242429 = IN.ase_texcoord9.xyz;
					float3 PivotWS121_g242429 = vertexToFrag76_g242429;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242429 = ( PositionWS122_g242429 - PivotWS121_g242429 );
					#else
					float3 staticSwitch204_g242429 = PositionWS122_g242429;
					#endif
					float3 PositionWO132_g242429 = ( staticSwitch204_g242429 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242437 = PositionWO132_g242429;
					float3 In_PivotWS16_g242437 = PivotWS121_g242429;
					float3 PivotWO133_g242429 = ( PivotWS121_g242429 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242437 = PivotWO133_g242429;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g242429 = normalizedWorldNormal;
					float3 In_NormalWS16_g242437 = NormalWS95_g242429;
					half3 TangentWS136_g242429 = TangentWS;
					float3 In_TangentWS16_g242437 = TangentWS136_g242429;
					half3 BiangentWS421_g242429 = BitangentWS;
					float3 In_BitangentWS16_g242437 = BiangentWS421_g242429;
					half3 NormalWS427_g242429 = NormalWS95_g242429;
					half3 localComputeTriplanarMasks427_g242429 = ComputeTriplanarMasks( NormalWS427_g242429 );
					half3 TriplanarWeights429_g242429 = localComputeTriplanarMasks427_g242429;
					float3 In_TriplanarWeights16_g242437 = TriplanarWeights429_g242429;
					float3 normalizeResult296_g242429 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242429 ) );
					half3 ViewDirWS169_g242429 = normalizeResult296_g242429;
					float3 In_ViewDirWS16_g242437 = ViewDirWS169_g242429;
					float4 appendResult397_g242429 = (float4(IN.ase_texcoord10.xy , IN.ase_texcoord10.zw));
					float4 CoordsData398_g242429 = appendResult397_g242429;
					float4 In_CoordsData16_g242437 = CoordsData398_g242429;
					half4 VertexMasks171_g242429 = IN.ase_color;
					float4 In_VertexData16_g242437 = VertexMasks171_g242429;
					float temp_output_17_0_g242440 = _ObjectPhaseMode;
					float Option70_g242440 = temp_output_17_0_g242440;
					float4 temp_output_3_0_g242440 = IN.ase_color;
					float4 Channel70_g242440 = temp_output_3_0_g242440;
					float localSwitchChannel470_g242440 = SwitchChannel4( Option70_g242440 , Channel70_g242440 );
					half Phase_Value372_g242429 = localSwitchChannel470_g242440;
					float3 break319_g242429 = PivotWO133_g242429;
					half Pivot_Position322_g242429 = ( break319_g242429.x + break319_g242429.z );
					half Phase_Position357_g242429 = ( Phase_Value372_g242429 + Pivot_Position322_g242429 );
					float temp_output_248_0_g242429 = frac( Phase_Position357_g242429 );
					float4 appendResult177_g242429 = (float4((frac( ( Phase_Position357_g242429 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g242429));
					half4 Phase_Data176_g242429 = appendResult177_g242429;
					float4 In_Interpolator16_g242437 = Phase_Data176_g242429;
					BuildModelFragData( Data16_g242437 , In_Dummy16_g242437 , In_PositionWS16_g242437 , In_PositionWO16_g242437 , In_PivotWS16_g242437 , In_PivotWO16_g242437 , In_NormalWS16_g242437 , In_TangentWS16_g242437 , In_BitangentWS16_g242437 , In_TriplanarWeights16_g242437 , In_ViewDirWS16_g242437 , In_CoordsData16_g242437 , In_VertexData16_g242437 , In_Interpolator16_g242437 );
					TVEModelData DataDefault26_g242408 = Data16_g242437;
					TVEModelData DataGeneral26_g242408 = Data16_g242437;
					TVEModelData DataBlanket26_g242408 = Data16_g242437;
					TVEModelData DataImpostor26_g242408 = Data16_g242437;
					TVEModelData Data16_g242417 =(TVEModelData)0;
					float In_Dummy16_g242417 = 0.0;
					float3 temp_output_104_7_g242409 = PositionWS;
					float3 PositionWS122_g242409 = temp_output_104_7_g242409;
					float3 In_PositionWS16_g242417 = PositionWS122_g242409;
					float4x4 break19_g242412 = unity_ObjectToWorld;
					float3 appendResult20_g242412 = (float3(break19_g242412[ 0 ][ 3 ] , break19_g242412[ 1 ][ 3 ] , break19_g242412[ 2 ][ 3 ]));
					float3 temp_output_340_7_g242409 = appendResult20_g242412;
					float3 PivotWS121_g242409 = temp_output_340_7_g242409;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242409 = ( PositionWS122_g242409 - PivotWS121_g242409 );
					#else
					float3 staticSwitch204_g242409 = PositionWS122_g242409;
					#endif
					float3 PositionWO132_g242409 = ( staticSwitch204_g242409 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242417 = PositionWO132_g242409;
					float3 In_PivotWS16_g242417 = PivotWS121_g242409;
					float3 PivotWO133_g242409 = ( PivotWS121_g242409 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242417 = PivotWO133_g242409;
					half3 NormalWS95_g242409 = normalizedWorldNormal;
					float3 In_NormalWS16_g242417 = NormalWS95_g242409;
					half3 TangentWS136_g242409 = TangentWS;
					float3 In_TangentWS16_g242417 = TangentWS136_g242409;
					half3 BiangentWS421_g242409 = BitangentWS;
					float3 In_BitangentWS16_g242417 = BiangentWS421_g242409;
					half3 NormalWS427_g242409 = NormalWS95_g242409;
					half3 localComputeTriplanarMasks427_g242409 = ComputeTriplanarMasks( NormalWS427_g242409 );
					half3 TriplanarWeights429_g242409 = localComputeTriplanarMasks427_g242409;
					float3 In_TriplanarWeights16_g242417 = TriplanarWeights429_g242409;
					float3 normalizeResult296_g242409 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242409 ) );
					half3 ViewDirWS169_g242409 = normalizeResult296_g242409;
					float3 In_ViewDirWS16_g242417 = ViewDirWS169_g242409;
					float4 appendResult397_g242409 = (float4(IN.ase_texcoord10.xy , IN.ase_texcoord10.zw));
					float4 CoordsData398_g242409 = appendResult397_g242409;
					float4 In_CoordsData16_g242417 = CoordsData398_g242409;
					half4 VertexMasks171_g242409 = float4( 0,0,0,0 );
					float4 In_VertexData16_g242417 = VertexMasks171_g242409;
					half4 Phase_Data176_g242409 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g242417 = Phase_Data176_g242409;
					BuildModelFragData( Data16_g242417 , In_Dummy16_g242417 , In_PositionWS16_g242417 , In_PositionWO16_g242417 , In_PivotWS16_g242417 , In_PivotWO16_g242417 , In_NormalWS16_g242417 , In_TangentWS16_g242417 , In_BitangentWS16_g242417 , In_TriplanarWeights16_g242417 , In_ViewDirWS16_g242417 , In_CoordsData16_g242417 , In_VertexData16_g242417 , In_Interpolator16_g242417 );
					TVEModelData DataTerrain26_g242408 = Data16_g242417;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g242408 = IsShaderType2637;
					{
					if (Type26_g242408 == 0 )
					{
					Data26_g242408 = DataDefault26_g242408;
					}
					else if (Type26_g242408 == 1 )
					{
					Data26_g242408 = DataGeneral26_g242408;
					}
					else if (Type26_g242408 == 2 )
					{
					Data26_g242408 = DataBlanket26_g242408;
					}
					else if (Type26_g242408 == 3 )
					{
					Data26_g242408 = DataImpostor26_g242408;
					}
					else if (Type26_g242408 == 4 )
					{
					Data26_g242408 = DataTerrain26_g242408;
					}
					}
					TVEModelData Data15_g251678 =(TVEModelData)Data26_g242408;
					float Out_Dummy15_g251678 = 0.0;
					float3 Out_PositionWS15_g251678 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251678 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251678 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251678 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251678 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251678 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251678 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251678 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251678 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251678 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251678 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251678 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251678 , Out_Dummy15_g251678 , Out_PositionWS15_g251678 , Out_PositionWO15_g251678 , Out_PivotWS15_g251678 , Out_PivotWO15_g251678 , Out_NormalWS15_g251678 , Out_TangentWS15_g251678 , Out_BitangentWS15_g251678 , Out_TriplanarWeights15_g251678 , Out_ViewDirWS15_g251678 , Out_CoordsData15_g251678 , Out_VertexData15_g251678 , Out_Interpolator15_g251678 );
					TVEModelData Data16_g251679 =(TVEModelData)Data15_g251678;
					float In_Dummy16_g251679 = Out_Dummy15_g251678;
					float3 In_PositionWS16_g251679 = Out_PositionWS15_g251678;
					float3 In_PositionWO16_g251679 = Out_PositionWO15_g251678;
					float3 In_PivotWS16_g251679 = Out_PivotWS15_g251678;
					float3 In_PivotWO16_g251679 = Out_PivotWO15_g251678;
					float3 In_NormalWS16_g251679 = Out_NormalWS15_g251678;
					float3 In_TangentWS16_g251679 = Out_TangentWS15_g251678;
					float3 In_BitangentWS16_g251679 = Out_BitangentWS15_g251678;
					float3 In_TriplanarWeights16_g251679 = Out_TriplanarWeights15_g251678;
					float3 In_ViewDirWS16_g251679 = Out_ViewDirWS15_g251678;
					float4 In_CoordsData16_g251679 = Out_CoordsData15_g251678;
					float4 In_VertexData16_g251679 = Out_VertexData15_g251678;
					float4 vertexToFrag1901_g251676 = IN.ase_texcoord11;
					float4 In_Interpolator16_g251679 = vertexToFrag1901_g251676;
					BuildModelFragData( Data16_g251679 , In_Dummy16_g251679 , In_PositionWS16_g251679 , In_PositionWO16_g251679 , In_PivotWS16_g251679 , In_PivotWO16_g251679 , In_NormalWS16_g251679 , In_TangentWS16_g251679 , In_BitangentWS16_g251679 , In_TriplanarWeights16_g251679 , In_ViewDirWS16_g251679 , In_CoordsData16_g251679 , In_VertexData16_g251679 , In_Interpolator16_g251679 );
					TVEModelData Data15_g251681 =(TVEModelData)Data16_g251679;
					float Out_Dummy15_g251681 = 0.0;
					float3 Out_PositionWS15_g251681 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251681 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251681 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251681 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251681 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251681 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251681 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251681 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251681 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251681 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251681 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251681 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251681 , Out_Dummy15_g251681 , Out_PositionWS15_g251681 , Out_PositionWO15_g251681 , Out_PivotWS15_g251681 , Out_PivotWO15_g251681 , Out_NormalWS15_g251681 , Out_TangentWS15_g251681 , Out_BitangentWS15_g251681 , Out_TriplanarWeights15_g251681 , Out_ViewDirWS15_g251681 , Out_CoordsData15_g251681 , Out_VertexData15_g251681 , Out_Interpolator15_g251681 );
					float4 Model_CoordsData324_g251680 = Out_CoordsData15_g251681;
					float4 MeshCoords444_g251702 = Model_CoordsData324_g251680;
					float2 UV0444_g251702 = float2( 0,0 );
					float2 UV3444_g251702 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g251702 , MeshCoords444_g251702 , UV0444_g251702 , UV3444_g251702 );
					float4 appendResult430_g251702 = (float4(UV0444_g251702 , UV3444_g251702));
					float4 In_MaskA431_g251702 = appendResult430_g251702;
					float localComputeWorldCoords315_g251702 = ( 0.0 );
					float4 Coords315_g251702 = Local_Coords180_g251680;
					float3 Model_PositionWO222_g251680 = Out_PositionWO15_g251681;
					float3 PositionWS315_g251702 = Model_PositionWO222_g251680;
					float2 ZY315_g251702 = float2( 0,0 );
					float2 XZ315_g251702 = float2( 0,0 );
					float2 XY315_g251702 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g251702 , PositionWS315_g251702 , ZY315_g251702 , XZ315_g251702 , XY315_g251702 );
					float2 ZY402_g251702 = ZY315_g251702;
					float2 XZ403_g251702 = XZ315_g251702;
					float4 appendResult432_g251702 = (float4(ZY402_g251702 , XZ403_g251702));
					float4 In_MaskB431_g251702 = appendResult432_g251702;
					float2 XY404_g251702 = XY315_g251702;
					float localComputeStochasticCoords409_g251702 = ( 0.0 );
					float2 UV409_g251702 = ZY402_g251702;
					float2 UV1409_g251702 = float2( 0,0 );
					float2 UV2409_g251702 = float2( 0,0 );
					float2 UV3409_g251702 = float2( 0,0 );
					float3 Weights409_g251702 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g251702 , UV1409_g251702 , UV2409_g251702 , UV3409_g251702 , Weights409_g251702 );
					float4 appendResult433_g251702 = (float4(XY404_g251702 , UV1409_g251702));
					float4 In_MaskC431_g251702 = appendResult433_g251702;
					float4 appendResult434_g251702 = (float4(UV2409_g251702 , UV3409_g251702));
					float4 In_MaskD431_g251702 = appendResult434_g251702;
					float localComputeStochasticCoords422_g251702 = ( 0.0 );
					float2 UV422_g251702 = XZ403_g251702;
					float2 UV1422_g251702 = float2( 0,0 );
					float2 UV2422_g251702 = float2( 0,0 );
					float2 UV3422_g251702 = float2( 0,0 );
					float3 Weights422_g251702 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g251702 , UV1422_g251702 , UV2422_g251702 , UV3422_g251702 , Weights422_g251702 );
					float4 appendResult435_g251702 = (float4(UV1422_g251702 , UV2422_g251702));
					float4 In_MaskE431_g251702 = appendResult435_g251702;
					float localComputeStochasticCoords423_g251702 = ( 0.0 );
					float2 UV423_g251702 = XY404_g251702;
					float2 UV1423_g251702 = float2( 0,0 );
					float2 UV2423_g251702 = float2( 0,0 );
					float2 UV3423_g251702 = float2( 0,0 );
					float3 Weights423_g251702 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g251702 , UV1423_g251702 , UV2423_g251702 , UV3423_g251702 , Weights423_g251702 );
					float4 appendResult436_g251702 = (float4(UV3422_g251702 , UV1423_g251702));
					float4 In_MaskF431_g251702 = appendResult436_g251702;
					float4 appendResult437_g251702 = (float4(UV2423_g251702 , UV3423_g251702));
					float4 In_MaskG431_g251702 = appendResult437_g251702;
					float4 In_MaskH431_g251702 = float4( Weights409_g251702 , 0.0 );
					float4 In_MaskI431_g251702 = float4( Weights422_g251702 , 0.0 );
					float4 In_MaskJ431_g251702 = float4( Weights423_g251702 , 0.0 );
					half3 Model_NormalWS226_g251680 = Out_NormalWS15_g251681;
					float3 temp_output_449_0_g251702 = Model_NormalWS226_g251680;
					float4 In_MaskK431_g251702 = float4( temp_output_449_0_g251702 , 0.0 );
					half3 Model_TangentWS366_g251680 = Out_TangentWS15_g251681;
					float3 temp_output_450_0_g251702 = Model_TangentWS366_g251680;
					float4 In_MaskL431_g251702 = float4( temp_output_450_0_g251702 , 0.0 );
					half3 Model_BitangentWS367_g251680 = Out_BitangentWS15_g251681;
					float3 temp_output_451_0_g251702 = Model_BitangentWS367_g251680;
					float4 In_MaskM431_g251702 = float4( temp_output_451_0_g251702 , 0.0 );
					half3 Model_TriplanarWeights368_g251680 = Out_TriplanarWeights15_g251681;
					float3 temp_output_445_0_g251702 = Model_TriplanarWeights368_g251680;
					float4 In_MaskN431_g251702 = float4( temp_output_445_0_g251702 , 0.0 );
					BuildTextureData( Data431_g251702 , In_MaskA431_g251702 , In_MaskB431_g251702 , In_MaskC431_g251702 , In_MaskD431_g251702 , In_MaskE431_g251702 , In_MaskF431_g251702 , In_MaskG431_g251702 , In_MaskH431_g251702 , In_MaskI431_g251702 , In_MaskJ431_g251702 , In_MaskK431_g251702 , In_MaskL431_g251702 , In_MaskM431_g251702 , In_MaskN431_g251702 );
					TVEMasksData Data456_g251703 =(TVEMasksData)Data431_g251702;
					float4 Out_MaskA456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251703 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251703 , Out_MaskA456_g251703 , Out_MaskB456_g251703 , Out_MaskC456_g251703 , Out_MaskD456_g251703 , Out_MaskE456_g251703 , Out_MaskF456_g251703 , Out_MaskG456_g251703 , Out_MaskH456_g251703 , Out_MaskI456_g251703 , Out_MaskJ456_g251703 , Out_MaskK456_g251703 , Out_MaskL456_g251703 , Out_MaskM456_g251703 , Out_MaskN456_g251703 );
					half2 UV276_g251703 = (Out_MaskA456_g251703).xy;
					float temp_output_504_0_g251703 = 0.0;
					half Bias276_g251703 = temp_output_504_0_g251703;
					half2 Normal276_g251703 = float2( 0,0 );
					half4 localSampleCoord276_g251703 = SampleCoord( Texture276_g251703 , Sampler276_g251703 , UV276_g251703 , Bias276_g251703 , Normal276_g251703 );
					float4 temp_output_407_277_g251680 = localSampleCoord276_g251703;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251703) = _MainAlbedoTex;
					SamplerState Sampler502_g251703 = staticSwitch36_g251685;
					half2 UV502_g251703 = (Out_MaskA456_g251703).zw;
					half Bias502_g251703 = temp_output_504_0_g251703;
					half2 Normal502_g251703 = float2( 0,0 );
					half4 localSampleCoord502_g251703 = SampleCoord( Texture502_g251703 , Sampler502_g251703 , UV502_g251703 , Bias502_g251703 , Normal502_g251703 );
					float4 temp_output_407_278_g251680 = localSampleCoord502_g251703;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251703) = _MainAlbedoTex;
					SamplerState Sampler496_g251703 = staticSwitch36_g251685;
					float2 temp_output_463_0_g251703 = (Out_MaskB456_g251703).zw;
					half2 XZ496_g251703 = temp_output_463_0_g251703;
					half Bias496_g251703 = temp_output_504_0_g251703;
					half3 NormalWS512_g251703 = (Out_MaskK456_g251703).xyz;
					half3 NormalWS496_g251703 = NormalWS512_g251703;
					half3 Normal496_g251703 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251703 = SamplePlanar2D( Texture496_g251703 , Sampler496_g251703 , XZ496_g251703 , Bias496_g251703 , NormalWS496_g251703 , Normal496_g251703 );
					float4 temp_output_407_0_g251680 = localSamplePlanar2D496_g251703;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251703) = _MainAlbedoTex;
					SamplerState Sampler490_g251703 = staticSwitch36_g251685;
					float2 temp_output_462_0_g251703 = (Out_MaskB456_g251703).xy;
					half2 ZY490_g251703 = temp_output_462_0_g251703;
					half2 XZ490_g251703 = temp_output_463_0_g251703;
					float2 temp_output_464_0_g251703 = (Out_MaskC456_g251703).xy;
					half2 XY490_g251703 = temp_output_464_0_g251703;
					half Bias490_g251703 = temp_output_504_0_g251703;
					half3 Triplanar522_g251703 = (Out_MaskN456_g251703).xyz;
					half3 Triplanar490_g251703 = Triplanar522_g251703;
					half3 NormalWS490_g251703 = NormalWS512_g251703;
					half3 Normal490_g251703 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251703 = SamplePlanar3D( Texture490_g251703 , Sampler490_g251703 , ZY490_g251703 , XZ490_g251703 , XY490_g251703 , Bias490_g251703 , Triplanar490_g251703 , NormalWS490_g251703 , Normal490_g251703 );
					float4 temp_output_407_201_g251680 = localSamplePlanar3D490_g251703;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251703) = _MainAlbedoTex;
					SamplerState Sampler498_g251703 = staticSwitch36_g251685;
					half2 XZ498_g251703 = temp_output_463_0_g251703;
					float2 temp_output_473_0_g251703 = (Out_MaskE456_g251703).xy;
					half2 XZ_1498_g251703 = temp_output_473_0_g251703;
					float2 temp_output_474_0_g251703 = (Out_MaskE456_g251703).zw;
					half2 XZ_2498_g251703 = temp_output_474_0_g251703;
					float2 temp_output_475_0_g251703 = (Out_MaskF456_g251703).xy;
					half2 XZ_3498_g251703 = temp_output_475_0_g251703;
					float temp_output_510_0_g251703 = exp2( temp_output_504_0_g251703 );
					half Bias498_g251703 = temp_output_510_0_g251703;
					float3 temp_output_480_0_g251703 = (Out_MaskI456_g251703).xyz;
					half3 Weights_2498_g251703 = temp_output_480_0_g251703;
					half3 NormalWS498_g251703 = NormalWS512_g251703;
					half3 Normal498_g251703 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251703 = SampleStochastic2D( Texture498_g251703 , Sampler498_g251703 , XZ498_g251703 , XZ_1498_g251703 , XZ_2498_g251703 , XZ_3498_g251703 , Bias498_g251703 , Weights_2498_g251703 , NormalWS498_g251703 , Normal498_g251703 );
					float4 temp_output_407_202_g251680 = localSampleStochastic2D498_g251703;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251703) = _MainAlbedoTex;
					SamplerState Sampler500_g251703 = staticSwitch36_g251685;
					half2 ZY500_g251703 = temp_output_462_0_g251703;
					half2 ZY_1500_g251703 = (Out_MaskC456_g251703).zw;
					half2 ZY_2500_g251703 = (Out_MaskD456_g251703).xy;
					half2 ZY_3500_g251703 = (Out_MaskD456_g251703).zw;
					half2 XZ500_g251703 = temp_output_463_0_g251703;
					half2 XZ_1500_g251703 = temp_output_473_0_g251703;
					half2 XZ_2500_g251703 = temp_output_474_0_g251703;
					half2 XZ_3500_g251703 = temp_output_475_0_g251703;
					half2 XY500_g251703 = temp_output_464_0_g251703;
					half2 XY_1500_g251703 = (Out_MaskF456_g251703).zw;
					half2 XY_2500_g251703 = (Out_MaskG456_g251703).xy;
					half2 XY_3500_g251703 = (Out_MaskG456_g251703).zw;
					half Bias500_g251703 = temp_output_510_0_g251703;
					half3 Weights_1500_g251703 = (Out_MaskH456_g251703).xyz;
					half3 Weights_2500_g251703 = temp_output_480_0_g251703;
					half3 Weights_3500_g251703 = (Out_MaskJ456_g251703).xyz;
					half3 Triplanar500_g251703 = Triplanar522_g251703;
					half3 NormalWS500_g251703 = NormalWS512_g251703;
					half3 Normal500_g251703 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251703 = SampleStochastic3D( Texture500_g251703 , Sampler500_g251703 , ZY500_g251703 , ZY_1500_g251703 , ZY_2500_g251703 , ZY_3500_g251703 , XZ500_g251703 , XZ_1500_g251703 , XZ_2500_g251703 , XZ_3500_g251703 , XY500_g251703 , XY_1500_g251703 , XY_2500_g251703 , XY_3500_g251703 , Bias500_g251703 , Weights_1500_g251703 , Weights_2500_g251703 , Weights_3500_g251703 , Triplanar500_g251703 , NormalWS500_g251703 , Normal500_g251703 );
					float4 temp_output_407_203_g251680 = localSampleStochastic3D500_g251703;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g251680 = temp_output_407_277_g251680;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g251680 = temp_output_407_278_g251680;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g251680 = temp_output_407_0_g251680;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g251680 = temp_output_407_201_g251680;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g251680 = temp_output_407_202_g251680;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g251680 = temp_output_407_203_g251680;
					#else
					float4 staticSwitch184_g251680 = temp_output_407_277_g251680;
					#endif
					half4 Local_AlbedoSample185_g251680 = staticSwitch184_g251680;
					float3 lerpResult53_g251680 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g251680).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g251680 = lerpResult53_g251680;
					float temp_output_17_0_g251700 = _MainMultiWriteMode;
					float Option91_g251700 = temp_output_17_0_g251700;
					float4 Model_VertexData418_g251680 = Out_VertexData15_g251681;
					float4 temp_output_84_0_g251700 = Model_VertexData418_g251680;
					float4 ChannelA91_g251700 = temp_output_84_0_g251700;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251688) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g251687 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g251687 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g251687 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g251687 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g251687 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g251687 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251688 = staticSwitch38_g251687;
					float localBreakTextureData456_g251688 = ( 0.0 );
					TVEMasksData Data456_g251688 =(TVEMasksData)Data431_g251702;
					float4 Out_MaskA456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251688 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251688 , Out_MaskA456_g251688 , Out_MaskB456_g251688 , Out_MaskC456_g251688 , Out_MaskD456_g251688 , Out_MaskE456_g251688 , Out_MaskF456_g251688 , Out_MaskG456_g251688 , Out_MaskH456_g251688 , Out_MaskI456_g251688 , Out_MaskJ456_g251688 , Out_MaskK456_g251688 , Out_MaskL456_g251688 , Out_MaskM456_g251688 , Out_MaskN456_g251688 );
					half2 UV276_g251688 = (Out_MaskA456_g251688).xy;
					float temp_output_504_0_g251688 = 0.0;
					half Bias276_g251688 = temp_output_504_0_g251688;
					half2 Normal276_g251688 = float2( 0,0 );
					half4 localSampleCoord276_g251688 = SampleCoord( Texture276_g251688 , Sampler276_g251688 , UV276_g251688 , Bias276_g251688 , Normal276_g251688 );
					float4 temp_output_405_277_g251680 = localSampleCoord276_g251688;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251688) = _MainShaderTex;
					SamplerState Sampler502_g251688 = staticSwitch38_g251687;
					half2 UV502_g251688 = (Out_MaskA456_g251688).zw;
					half Bias502_g251688 = temp_output_504_0_g251688;
					half2 Normal502_g251688 = float2( 0,0 );
					half4 localSampleCoord502_g251688 = SampleCoord( Texture502_g251688 , Sampler502_g251688 , UV502_g251688 , Bias502_g251688 , Normal502_g251688 );
					float4 temp_output_405_278_g251680 = localSampleCoord502_g251688;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251688) = _MainShaderTex;
					SamplerState Sampler496_g251688 = staticSwitch38_g251687;
					float2 temp_output_463_0_g251688 = (Out_MaskB456_g251688).zw;
					half2 XZ496_g251688 = temp_output_463_0_g251688;
					half Bias496_g251688 = temp_output_504_0_g251688;
					half3 NormalWS512_g251688 = (Out_MaskK456_g251688).xyz;
					half3 NormalWS496_g251688 = NormalWS512_g251688;
					half3 Normal496_g251688 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251688 = SamplePlanar2D( Texture496_g251688 , Sampler496_g251688 , XZ496_g251688 , Bias496_g251688 , NormalWS496_g251688 , Normal496_g251688 );
					float4 temp_output_405_0_g251680 = localSamplePlanar2D496_g251688;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251688) = _MainShaderTex;
					SamplerState Sampler490_g251688 = staticSwitch38_g251687;
					float2 temp_output_462_0_g251688 = (Out_MaskB456_g251688).xy;
					half2 ZY490_g251688 = temp_output_462_0_g251688;
					half2 XZ490_g251688 = temp_output_463_0_g251688;
					float2 temp_output_464_0_g251688 = (Out_MaskC456_g251688).xy;
					half2 XY490_g251688 = temp_output_464_0_g251688;
					half Bias490_g251688 = temp_output_504_0_g251688;
					half3 Triplanar522_g251688 = (Out_MaskN456_g251688).xyz;
					half3 Triplanar490_g251688 = Triplanar522_g251688;
					half3 NormalWS490_g251688 = NormalWS512_g251688;
					half3 Normal490_g251688 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251688 = SamplePlanar3D( Texture490_g251688 , Sampler490_g251688 , ZY490_g251688 , XZ490_g251688 , XY490_g251688 , Bias490_g251688 , Triplanar490_g251688 , NormalWS490_g251688 , Normal490_g251688 );
					float4 temp_output_405_201_g251680 = localSamplePlanar3D490_g251688;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251688) = _MainShaderTex;
					SamplerState Sampler498_g251688 = staticSwitch38_g251687;
					half2 XZ498_g251688 = temp_output_463_0_g251688;
					float2 temp_output_473_0_g251688 = (Out_MaskE456_g251688).xy;
					half2 XZ_1498_g251688 = temp_output_473_0_g251688;
					float2 temp_output_474_0_g251688 = (Out_MaskE456_g251688).zw;
					half2 XZ_2498_g251688 = temp_output_474_0_g251688;
					float2 temp_output_475_0_g251688 = (Out_MaskF456_g251688).xy;
					half2 XZ_3498_g251688 = temp_output_475_0_g251688;
					float temp_output_510_0_g251688 = exp2( temp_output_504_0_g251688 );
					half Bias498_g251688 = temp_output_510_0_g251688;
					float3 temp_output_480_0_g251688 = (Out_MaskI456_g251688).xyz;
					half3 Weights_2498_g251688 = temp_output_480_0_g251688;
					half3 NormalWS498_g251688 = NormalWS512_g251688;
					half3 Normal498_g251688 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251688 = SampleStochastic2D( Texture498_g251688 , Sampler498_g251688 , XZ498_g251688 , XZ_1498_g251688 , XZ_2498_g251688 , XZ_3498_g251688 , Bias498_g251688 , Weights_2498_g251688 , NormalWS498_g251688 , Normal498_g251688 );
					float4 temp_output_405_202_g251680 = localSampleStochastic2D498_g251688;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251688) = _MainShaderTex;
					SamplerState Sampler500_g251688 = staticSwitch38_g251687;
					half2 ZY500_g251688 = temp_output_462_0_g251688;
					half2 ZY_1500_g251688 = (Out_MaskC456_g251688).zw;
					half2 ZY_2500_g251688 = (Out_MaskD456_g251688).xy;
					half2 ZY_3500_g251688 = (Out_MaskD456_g251688).zw;
					half2 XZ500_g251688 = temp_output_463_0_g251688;
					half2 XZ_1500_g251688 = temp_output_473_0_g251688;
					half2 XZ_2500_g251688 = temp_output_474_0_g251688;
					half2 XZ_3500_g251688 = temp_output_475_0_g251688;
					half2 XY500_g251688 = temp_output_464_0_g251688;
					half2 XY_1500_g251688 = (Out_MaskF456_g251688).zw;
					half2 XY_2500_g251688 = (Out_MaskG456_g251688).xy;
					half2 XY_3500_g251688 = (Out_MaskG456_g251688).zw;
					half Bias500_g251688 = temp_output_510_0_g251688;
					half3 Weights_1500_g251688 = (Out_MaskH456_g251688).xyz;
					half3 Weights_2500_g251688 = temp_output_480_0_g251688;
					half3 Weights_3500_g251688 = (Out_MaskJ456_g251688).xyz;
					half3 Triplanar500_g251688 = Triplanar522_g251688;
					half3 NormalWS500_g251688 = NormalWS512_g251688;
					half3 Normal500_g251688 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251688 = SampleStochastic3D( Texture500_g251688 , Sampler500_g251688 , ZY500_g251688 , ZY_1500_g251688 , ZY_2500_g251688 , ZY_3500_g251688 , XZ500_g251688 , XZ_1500_g251688 , XZ_2500_g251688 , XZ_3500_g251688 , XY500_g251688 , XY_1500_g251688 , XY_2500_g251688 , XY_3500_g251688 , Bias500_g251688 , Weights_1500_g251688 , Weights_2500_g251688 , Weights_3500_g251688 , Triplanar500_g251688 , NormalWS500_g251688 , Normal500_g251688 );
					float4 temp_output_405_203_g251680 = localSampleStochastic3D500_g251688;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g251680 = temp_output_405_277_g251680;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g251680 = temp_output_405_278_g251680;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g251680 = temp_output_405_0_g251680;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g251680 = temp_output_405_201_g251680;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g251680 = temp_output_405_202_g251680;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g251680 = temp_output_405_203_g251680;
					#else
					float4 staticSwitch198_g251680 = temp_output_405_277_g251680;
					#endif
					half4 Local_ShaderSample199_g251680 = staticSwitch198_g251680;
					float2 appendResult428_g251680 = (float2((Local_AlbedoSample185_g251680).w , (Local_ShaderSample199_g251680).z));
					float2 temp_output_85_0_g251700 = appendResult428_g251680;
					float4 ChannelB91_g251700 = float4( temp_output_85_0_g251700, 0.0 , 0.0 );
					float localSwitchChannel691_g251700 = SwitchChannel6( Option91_g251700 , ChannelA91_g251700 , ChannelB91_g251700 );
					float clampResult17_g251698 = clamp( localSwitchChannel691_g251700 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251699 = _MainMultiWriteRemap.x;
					float temp_output_9_0_g251699 = ( clampResult17_g251698 - temp_output_7_0_g251699 );
					half Local_MultiMask78_g251680 = saturate( ( temp_output_9_0_g251699 * _MainMultiWriteRemap.z ) );
					float lerpResult58_g251680 = lerp( 1.0 , Local_MultiMask78_g251680 , _MainColorMode);
					float4 lerpResult62_g251680 = lerp( _MainColorTwo , _MainColor , lerpResult58_g251680);
					half3 Local_ColorRGB93_g251680 = (lerpResult62_g251680).rgb;
					half3 Local_Albedo139_g251680 = ( Local_AlbedoRGB107_g251680 * Local_ColorRGB93_g251680 );
					float3 temp_output_4_0_g251682 = Local_Albedo139_g251680;
					float3 In_Albedo3_g251682 = temp_output_4_0_g251682;
					float3 temp_output_44_0_g251682 = Local_Albedo139_g251680;
					float3 In_AlbedoBase3_g251682 = temp_output_44_0_g251682;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251709) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g251686 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g251686 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g251686 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g251686 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g251686 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g251686 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251709 = staticSwitch37_g251686;
					float localBreakTextureData456_g251709 = ( 0.0 );
					TVEMasksData Data456_g251709 =(TVEMasksData)Data431_g251702;
					float4 Out_MaskA456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251709 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251709 , Out_MaskA456_g251709 , Out_MaskB456_g251709 , Out_MaskC456_g251709 , Out_MaskD456_g251709 , Out_MaskE456_g251709 , Out_MaskF456_g251709 , Out_MaskG456_g251709 , Out_MaskH456_g251709 , Out_MaskI456_g251709 , Out_MaskJ456_g251709 , Out_MaskK456_g251709 , Out_MaskL456_g251709 , Out_MaskM456_g251709 , Out_MaskN456_g251709 );
					half2 UV276_g251709 = (Out_MaskA456_g251709).xy;
					float temp_output_504_0_g251709 = 0.0;
					half Bias276_g251709 = temp_output_504_0_g251709;
					half2 Normal276_g251709 = float2( 0,0 );
					half4 localSampleCoord276_g251709 = SampleCoord( Texture276_g251709 , Sampler276_g251709 , UV276_g251709 , Bias276_g251709 , Normal276_g251709 );
					float2 temp_output_406_394_g251680 = Normal276_g251709;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251709) = _MainNormalTex;
					SamplerState Sampler502_g251709 = staticSwitch37_g251686;
					half2 UV502_g251709 = (Out_MaskA456_g251709).zw;
					half Bias502_g251709 = temp_output_504_0_g251709;
					half2 Normal502_g251709 = float2( 0,0 );
					half4 localSampleCoord502_g251709 = SampleCoord( Texture502_g251709 , Sampler502_g251709 , UV502_g251709 , Bias502_g251709 , Normal502_g251709 );
					float2 temp_output_406_397_g251680 = Normal502_g251709;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251709) = _MainNormalTex;
					SamplerState Sampler496_g251709 = staticSwitch37_g251686;
					float2 temp_output_463_0_g251709 = (Out_MaskB456_g251709).zw;
					half2 XZ496_g251709 = temp_output_463_0_g251709;
					half Bias496_g251709 = temp_output_504_0_g251709;
					half3 NormalWS512_g251709 = (Out_MaskK456_g251709).xyz;
					half3 NormalWS496_g251709 = NormalWS512_g251709;
					half3 Normal496_g251709 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251709 = SamplePlanar2D( Texture496_g251709 , Sampler496_g251709 , XZ496_g251709 , Bias496_g251709 , NormalWS496_g251709 , Normal496_g251709 );
					float3 temp_output_35_0_g251712 = Normal496_g251709;
					half3 TangentWS519_g251709 = (Out_MaskL456_g251709).xyz;
					float dotResult84_g251712 = dot( temp_output_35_0_g251712 , TangentWS519_g251709 );
					half3 BitangentWS521_g251709 = (Out_MaskM456_g251709).xyz;
					float dotResult85_g251712 = dot( temp_output_35_0_g251712 , BitangentWS521_g251709 );
					float2 appendResult87_g251712 = (float2(dotResult84_g251712 , dotResult85_g251712));
					float2 temp_output_406_375_g251680 = appendResult87_g251712;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251709) = _MainNormalTex;
					SamplerState Sampler490_g251709 = staticSwitch37_g251686;
					float2 temp_output_462_0_g251709 = (Out_MaskB456_g251709).xy;
					half2 ZY490_g251709 = temp_output_462_0_g251709;
					half2 XZ490_g251709 = temp_output_463_0_g251709;
					float2 temp_output_464_0_g251709 = (Out_MaskC456_g251709).xy;
					half2 XY490_g251709 = temp_output_464_0_g251709;
					half Bias490_g251709 = temp_output_504_0_g251709;
					half3 Triplanar522_g251709 = (Out_MaskN456_g251709).xyz;
					half3 Triplanar490_g251709 = Triplanar522_g251709;
					half3 NormalWS490_g251709 = NormalWS512_g251709;
					half3 Normal490_g251709 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251709 = SamplePlanar3D( Texture490_g251709 , Sampler490_g251709 , ZY490_g251709 , XZ490_g251709 , XY490_g251709 , Bias490_g251709 , Triplanar490_g251709 , NormalWS490_g251709 , Normal490_g251709 );
					float3 temp_output_35_0_g251713 = Normal490_g251709;
					float dotResult84_g251713 = dot( temp_output_35_0_g251713 , TangentWS519_g251709 );
					float dotResult85_g251713 = dot( temp_output_35_0_g251713 , BitangentWS521_g251709 );
					float2 appendResult87_g251713 = (float2(dotResult84_g251713 , dotResult85_g251713));
					float2 temp_output_406_353_g251680 = appendResult87_g251713;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251709) = _MainNormalTex;
					SamplerState Sampler498_g251709 = staticSwitch37_g251686;
					half2 XZ498_g251709 = temp_output_463_0_g251709;
					float2 temp_output_473_0_g251709 = (Out_MaskE456_g251709).xy;
					half2 XZ_1498_g251709 = temp_output_473_0_g251709;
					float2 temp_output_474_0_g251709 = (Out_MaskE456_g251709).zw;
					half2 XZ_2498_g251709 = temp_output_474_0_g251709;
					float2 temp_output_475_0_g251709 = (Out_MaskF456_g251709).xy;
					half2 XZ_3498_g251709 = temp_output_475_0_g251709;
					float temp_output_510_0_g251709 = exp2( temp_output_504_0_g251709 );
					half Bias498_g251709 = temp_output_510_0_g251709;
					float3 temp_output_480_0_g251709 = (Out_MaskI456_g251709).xyz;
					half3 Weights_2498_g251709 = temp_output_480_0_g251709;
					half3 NormalWS498_g251709 = NormalWS512_g251709;
					half3 Normal498_g251709 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251709 = SampleStochastic2D( Texture498_g251709 , Sampler498_g251709 , XZ498_g251709 , XZ_1498_g251709 , XZ_2498_g251709 , XZ_3498_g251709 , Bias498_g251709 , Weights_2498_g251709 , NormalWS498_g251709 , Normal498_g251709 );
					float3 temp_output_35_0_g251714 = Normal498_g251709;
					float dotResult84_g251714 = dot( temp_output_35_0_g251714 , TangentWS519_g251709 );
					float dotResult85_g251714 = dot( temp_output_35_0_g251714 , BitangentWS521_g251709 );
					float2 appendResult87_g251714 = (float2(dotResult84_g251714 , dotResult85_g251714));
					float2 temp_output_406_391_g251680 = appendResult87_g251714;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251709) = _MainNormalTex;
					SamplerState Sampler500_g251709 = staticSwitch37_g251686;
					half2 ZY500_g251709 = temp_output_462_0_g251709;
					half2 ZY_1500_g251709 = (Out_MaskC456_g251709).zw;
					half2 ZY_2500_g251709 = (Out_MaskD456_g251709).xy;
					half2 ZY_3500_g251709 = (Out_MaskD456_g251709).zw;
					half2 XZ500_g251709 = temp_output_463_0_g251709;
					half2 XZ_1500_g251709 = temp_output_473_0_g251709;
					half2 XZ_2500_g251709 = temp_output_474_0_g251709;
					half2 XZ_3500_g251709 = temp_output_475_0_g251709;
					half2 XY500_g251709 = temp_output_464_0_g251709;
					half2 XY_1500_g251709 = (Out_MaskF456_g251709).zw;
					half2 XY_2500_g251709 = (Out_MaskG456_g251709).xy;
					half2 XY_3500_g251709 = (Out_MaskG456_g251709).zw;
					half Bias500_g251709 = temp_output_510_0_g251709;
					half3 Weights_1500_g251709 = (Out_MaskH456_g251709).xyz;
					half3 Weights_2500_g251709 = temp_output_480_0_g251709;
					half3 Weights_3500_g251709 = (Out_MaskJ456_g251709).xyz;
					half3 Triplanar500_g251709 = Triplanar522_g251709;
					half3 NormalWS500_g251709 = NormalWS512_g251709;
					half3 Normal500_g251709 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251709 = SampleStochastic3D( Texture500_g251709 , Sampler500_g251709 , ZY500_g251709 , ZY_1500_g251709 , ZY_2500_g251709 , ZY_3500_g251709 , XZ500_g251709 , XZ_1500_g251709 , XZ_2500_g251709 , XZ_3500_g251709 , XY500_g251709 , XY_1500_g251709 , XY_2500_g251709 , XY_3500_g251709 , Bias500_g251709 , Weights_1500_g251709 , Weights_2500_g251709 , Weights_3500_g251709 , Triplanar500_g251709 , NormalWS500_g251709 , Normal500_g251709 );
					float3 temp_output_35_0_g251710 = Normal500_g251709;
					float dotResult84_g251710 = dot( temp_output_35_0_g251710 , TangentWS519_g251709 );
					float dotResult85_g251710 = dot( temp_output_35_0_g251710 , BitangentWS521_g251709 );
					float2 appendResult87_g251710 = (float2(dotResult84_g251710 , dotResult85_g251710));
					float2 temp_output_406_390_g251680 = appendResult87_g251710;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g251680 = temp_output_406_394_g251680;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g251680 = temp_output_406_397_g251680;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g251680 = temp_output_406_375_g251680;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g251680 = temp_output_406_353_g251680;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g251680 = temp_output_406_391_g251680;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g251680 = temp_output_406_390_g251680;
					#else
					float2 staticSwitch193_g251680 = temp_output_406_394_g251680;
					#endif
					half2 Local_NormaSample191_g251680 = staticSwitch193_g251680;
					half2 Local_NormalTS108_g251680 = ( Local_NormaSample191_g251680 * _MainNormalValue );
					float2 In_NormalTS3_g251682 = Local_NormalTS108_g251680;
					float2 break80_g251701 = Local_NormalTS108_g251680;
					float3 temp_output_77_0_g251701 = Model_TangentWS366_g251680;
					float3 temp_output_78_0_g251701 = Model_BitangentWS367_g251680;
					float3 temp_output_76_0_g251701 = Model_NormalWS226_g251680;
					half3 Local_NormalWS250_g251680 = ( ( break80_g251701.x * temp_output_77_0_g251701 ) + ( break80_g251701.y * temp_output_78_0_g251701 ) + temp_output_76_0_g251701 );
					float3 In_NormalWS3_g251682 = Local_NormalWS250_g251680;
					float temp_output_209_0_g251680 = (Local_ShaderSample199_g251680).y;
					float temp_output_7_0_g251694 = _MainOcclusionRemap.x;
					float temp_output_9_0_g251694 = ( temp_output_209_0_g251680 - temp_output_7_0_g251694 );
					float lerpResult23_g251680 = lerp( 1.0 , saturate( ( temp_output_9_0_g251694 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g251680 = lerpResult23_g251680;
					float temp_output_213_0_g251680 = (Local_ShaderSample199_g251680).w;
					float temp_output_7_0_g251697 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g251697 = ( temp_output_213_0_g251680 - temp_output_7_0_g251697 );
					half Local_Smoothness317_g251680 = ( saturate( ( temp_output_9_0_g251697 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g251680 = (float4(( (Local_ShaderSample199_g251680).x * _MainMetallicValue ) , Local_Occlusion313_g251680 , (Local_ShaderSample199_g251680).z , Local_Smoothness317_g251680));
					half4 Local_Masks109_g251680 = appendResult73_g251680;
					float4 In_Shader3_g251682 = Local_Masks109_g251680;
					float4 In_Feature3_g251682 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251682 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251682 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g251715 = Local_Albedo139_g251680;
					float dotResult20_g251715 = dot( temp_output_3_0_g251715 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g251680 = dotResult20_g251715;
					float temp_output_12_0_g251682 = Local_Grayscale110_g251680;
					float In_Grayscale3_g251682 = temp_output_12_0_g251682;
					float temp_output_3_0_g251716 = Local_Grayscale110_g251680;
					float clampResult27_g251716 = clamp( saturate( ( temp_output_3_0_g251716 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g251680 = clampResult27_g251716;
					float temp_output_16_0_g251682 = Local_Luminosity145_g251680;
					float In_Luminosity3_g251682 = temp_output_16_0_g251682;
					float In_MultiMask3_g251682 = Local_MultiMask78_g251680;
					float temp_output_187_0_g251680 = (Local_AlbedoSample185_g251680).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g251680 = ( temp_output_187_0_g251680 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g251680 = temp_output_187_0_g251680;
					#endif
					half Local_AlphaClip111_g251680 = staticSwitch236_g251680;
					float In_AlphaClip3_g251682 = Local_AlphaClip111_g251680;
					half Local_AlphaFade246_g251680 = (lerpResult62_g251680).a;
					float In_AlphaFade3_g251682 = Local_AlphaFade246_g251680;
					float3 temp_cast_25 = (1.0).xxx;
					float3 In_Translucency3_g251682 = temp_cast_25;
					float In_Transmission3_g251682 = 1.0;
					float In_Thickness3_g251682 = 0.0;
					float In_Diffusion3_g251682 = 0.0;
					float In_Depth3_g251682 = 0.0;
					BuildVisualData( Data3_g251682 , In_Dummy3_g251682 , In_Albedo3_g251682 , In_AlbedoBase3_g251682 , In_NormalTS3_g251682 , In_NormalWS3_g251682 , In_Shader3_g251682 , In_Feature3_g251682 , In_Season3_g251682 , In_Emissive3_g251682 , In_Grayscale3_g251682 , In_Luminosity3_g251682 , In_MultiMask3_g251682 , In_AlphaClip3_g251682 , In_AlphaFade3_g251682 , In_Translucency3_g251682 , In_Transmission3_g251682 , In_Thickness3_g251682 , In_Diffusion3_g251682 , In_Depth3_g251682 );
					TVEVisualData Data4_g251725 =(TVEVisualData)Data3_g251682;
					float Out_Dummy4_g251725 = 0.0;
					float3 Out_Albedo4_g251725 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g251725 = float3( 0,0,0 );
					float2 Out_NormalTS4_g251725 = float2( 0,0 );
					float3 Out_NormalWS4_g251725 = float3( 0,0,0 );
					float4 Out_Shader4_g251725 = float4( 0,0,0,0 );
					float4 Out_Feature4_g251725 = float4( 0,0,0,0 );
					float4 Out_Season4_g251725 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g251725 = float4( 0,0,0,0 );
					float Out_MultiMask4_g251725 = 0.0;
					float Out_Grayscale4_g251725 = 0.0;
					float Out_Luminosity4_g251725 = 0.0;
					float Out_AlphaClip4_g251725 = 0.0;
					float Out_AlphaFade4_g251725 = 0.0;
					float3 Out_Translucency4_g251725 = float3( 0,0,0 );
					float Out_Transmission4_g251725 = 0.0;
					float Out_Thickness4_g251725 = 0.0;
					float Out_Diffusion4_g251725 = 0.0;
					float Out_Depth4_g251725 = 0.0;
					BreakVisualData( Data4_g251725 , Out_Dummy4_g251725 , Out_Albedo4_g251725 , Out_AlbedoBase4_g251725 , Out_NormalTS4_g251725 , Out_NormalWS4_g251725 , Out_Shader4_g251725 , Out_Feature4_g251725 , Out_Season4_g251725 , Out_Emissive4_g251725 , Out_MultiMask4_g251725 , Out_Grayscale4_g251725 , Out_Luminosity4_g251725 , Out_AlphaClip4_g251725 , Out_AlphaFade4_g251725 , Out_Translucency4_g251725 , Out_Transmission4_g251725 , Out_Thickness4_g251725 , Out_Diffusion4_g251725 , Out_Depth4_g251725 );
					float Alpha109_g251720 = Out_AlphaClip4_g251725;
					float lerpResult91_g251720 = lerp( 1.0 , Alpha109_g251720 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g251720 = lerp( 1.0 , lerpResult91_g251720 , Filter152_g251720);
					clip( lerpResult154_g251720 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = temp_cast_1;
					half Metallic = 0;
					half Smoothness = temp_output_2609_114;
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

					o.Emission = ( lerpResult72_g251720 * lerpResult84_g251720 );
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
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#define ASE_NEEDS_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_BITANGENT
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#define ASE_NEEDS_FRAG_COLOR
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
				#pragma shader_feature_local_vertex TVE_COORD_ZUP
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_vertex TVE_TRANSFER
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
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
					float4 ase_texcoord7 : TEXCOORD7;
					float4 ase_texcoord8 : TEXCOORD8;
					float4 ase_color : COLOR;
					float4 ase_texcoord9 : TEXCOORD9;
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
				uniform half _TransferIntensityValue;
				uniform half _TransferMeshMode;
				uniform half4 _TransferMeshRemap;
				uniform half _TransferMeshValue;
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
				
				float3 ASESafeNormalize(float3 inVec)
				{
					float dp3 = max(1.175494351e-38, dot(inVec, inVec));
					return inVec* rsqrt(dp3);
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
				

				v2f VertexFunction (appdata v  ) {
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					TVEVertexData Data16_g251557 =(TVEVertexData)0;
					float In_Dummy16_g251557 = 0.0;
					TVEVertexData Data16_g251552 =(TVEVertexData)0;
					float In_Dummy16_g251552 = 0.0;
					float localIfModelDataByShader26_g242551 = ( 0.0 );
					TVEModelData Data26_g242551 = (TVEModelData)0;
					TVEModelData Data16_g242447 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g242429 = _ObjectCoordMode;
					#else
					float staticSwitch343_g242429 = _ObjectCoordMode;
					#endif
					half Dummy207_g242429 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g242429 );
					float temp_output_14_0_g242447 = Dummy207_g242429;
					float In_Dummy16_g242447 = temp_output_14_0_g242447;
					float3 PositionOS131_g242429 = v.vertex.xyz;
					float3 temp_output_4_0_g242447 = PositionOS131_g242429;
					float3 In_PositionOS16_g242447 = temp_output_4_0_g242447;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g242429 = ase_positionWS;
					float3 vertexToFrag73_g242429 = temp_output_104_7_g242429;
					float3 PositionWS122_g242429 = vertexToFrag73_g242429;
					float3 In_PositionWS16_g242447 = PositionWS122_g242429;
					float4x4 break19_g242432 = unity_ObjectToWorld;
					float3 appendResult20_g242432 = (float3(break19_g242432[ 0 ][ 3 ] , break19_g242432[ 1 ][ 3 ] , break19_g242432[ 2 ][ 3 ]));
					float3 temp_output_340_7_g242429 = appendResult20_g242432;
					float4x4 break19_g242434 = unity_ObjectToWorld;
					float3 appendResult20_g242434 = (float3(break19_g242434[ 0 ][ 3 ] , break19_g242434[ 1 ][ 3 ] , break19_g242434[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g242430 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g242429 = PositionOS131_g242429;
					float3 appendResult234_g242429 = (float3(break233_g242429.x , 0.0 , break233_g242429.z));
					float3 break413_g242429 = PositionOS131_g242429;
					float3 appendResult414_g242429 = (float3(break413_g242429.x , break413_g242429.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g242436 = appendResult414_g242429;
					#else
					float3 staticSwitch65_g242436 = appendResult234_g242429;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g242429 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g242429 = appendResult60_g242430;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g242429 = staticSwitch65_g242436;
					#else
					float3 staticSwitch229_g242429 = _Vector0;
					#endif
					float3 PivotOS149_g242429 = staticSwitch229_g242429;
					float3 temp_output_122_0_g242434 = PivotOS149_g242429;
					float3 PivotsOnlyWS105_g242434 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g242434 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g242429 = ( appendResult20_g242434 + PivotsOnlyWS105_g242434 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g242429 = temp_output_340_7_g242429;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g242429 = temp_output_341_7_g242429;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g242429 = temp_output_341_7_g242429;
					#else
					float3 staticSwitch236_g242429 = temp_output_340_7_g242429;
					#endif
					float3 vertexToFrag76_g242429 = staticSwitch236_g242429;
					float3 PivotWS121_g242429 = vertexToFrag76_g242429;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242429 = ( PositionWS122_g242429 - PivotWS121_g242429 );
					#else
					float3 staticSwitch204_g242429 = PositionWS122_g242429;
					#endif
					float3 PositionWO132_g242429 = ( staticSwitch204_g242429 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242447 = PositionWO132_g242429;
					float3 In_PivotOS16_g242447 = PivotOS149_g242429;
					float3 In_PivotWS16_g242447 = PivotWS121_g242429;
					float3 PivotWO133_g242429 = ( PivotWS121_g242429 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242447 = PivotWO133_g242429;
					half3 NormalOS134_g242429 = v.normal;
					float3 temp_output_21_0_g242447 = NormalOS134_g242429;
					float3 In_NormalOS16_g242447 = temp_output_21_0_g242447;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g242429 = normalizedWorldNormal;
					float3 In_NormalWS16_g242447 = NormalWS95_g242429;
					half4 TangentlOS153_g242429 = v.tangent;
					float4 temp_output_6_0_g242447 = TangentlOS153_g242429;
					float4 In_TangentOS16_g242447 = temp_output_6_0_g242447;
					float3 normalizeResult296_g242429 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242429 ) );
					half3 ViewDirWS169_g242429 = normalizeResult296_g242429;
					float3 In_ViewDirWS16_g242447 = ViewDirWS169_g242429;
					float4 appendResult397_g242429 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g242429 = appendResult397_g242429;
					float4 In_CoordsData16_g242447 = CoordsData398_g242429;
					half4 VertexMasks171_g242429 = v.ase_color;
					float4 In_VertexData16_g242447 = VertexMasks171_g242429;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g242441 = (PositionOS131_g242429).z;
					#else
					float staticSwitch65_g242441 = (PositionOS131_g242429).y;
					#endif
					half Object_HeightValue267_g242429 = _ObjectHeightValue;
					half Bounds_HeightMask274_g242429 = saturate( ( staticSwitch65_g242441 / Object_HeightValue267_g242429 ) );
					half3 Position387_g242429 = PositionOS131_g242429;
					half Height387_g242429 = Object_HeightValue267_g242429;
					half Object_RadiusValue268_g242429 = _ObjectRadiusValue;
					half Radius387_g242429 = Object_RadiusValue268_g242429;
					half localCapsuleMaskYUp387_g242429 = CapsuleMaskYUp( Position387_g242429 , Height387_g242429 , Radius387_g242429 );
					half3 Position408_g242429 = PositionOS131_g242429;
					half Height408_g242429 = Object_HeightValue267_g242429;
					half Radius408_g242429 = Object_RadiusValue268_g242429;
					half localCapsuleMaskZUp408_g242429 = CapsuleMaskZUp( Position408_g242429 , Height408_g242429 , Radius408_g242429 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g242446 = saturate( localCapsuleMaskZUp408_g242429 );
					#else
					float staticSwitch65_g242446 = saturate( localCapsuleMaskYUp387_g242429 );
					#endif
					half Bounds_SphereMask282_g242429 = staticSwitch65_g242446;
					float4 appendResult253_g242429 = (float4(Bounds_HeightMask274_g242429 , Bounds_SphereMask282_g242429 , 1.0 , 1.0));
					half4 MasksData254_g242429 = appendResult253_g242429;
					float4 In_MasksData16_g242447 = MasksData254_g242429;
					float temp_output_17_0_g242440 = _ObjectPhaseMode;
					float Option70_g242440 = temp_output_17_0_g242440;
					float4 temp_output_3_0_g242440 = v.ase_color;
					float4 Channel70_g242440 = temp_output_3_0_g242440;
					float localSwitchChannel470_g242440 = SwitchChannel4( Option70_g242440 , Channel70_g242440 );
					half Phase_Value372_g242429 = localSwitchChannel470_g242440;
					float3 break319_g242429 = PivotWO133_g242429;
					half Pivot_Position322_g242429 = ( break319_g242429.x + break319_g242429.z );
					half Phase_Position357_g242429 = ( Phase_Value372_g242429 + Pivot_Position322_g242429 );
					float temp_output_248_0_g242429 = frac( Phase_Position357_g242429 );
					float4 appendResult177_g242429 = (float4((frac( ( Phase_Position357_g242429 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g242429));
					half4 Phase_Data176_g242429 = appendResult177_g242429;
					float4 In_PhaseData16_g242447 = Phase_Data176_g242429;
					BuildModelVertData( Data16_g242447 , In_Dummy16_g242447 , In_PositionOS16_g242447 , In_PositionWS16_g242447 , In_PositionWO16_g242447 , In_PivotOS16_g242447 , In_PivotWS16_g242447 , In_PivotWO16_g242447 , In_NormalOS16_g242447 , In_NormalWS16_g242447 , In_TangentOS16_g242447 , In_ViewDirWS16_g242447 , In_CoordsData16_g242447 , In_VertexData16_g242447 , In_MasksData16_g242447 , In_PhaseData16_g242447 );
					TVEModelData DataDefault26_g242551 = Data16_g242447;
					TVEModelData DataGeneral26_g242551 = Data16_g242447;
					TVEModelData DataBlanket26_g242551 = Data16_g242447;
					TVEModelData DataImpostor26_g242551 = Data16_g242447;
					TVEModelData Data16_g242427 =(TVEModelData)0;
					half Dummy207_g242409 = 0.0;
					float temp_output_14_0_g242427 = Dummy207_g242409;
					float In_Dummy16_g242427 = temp_output_14_0_g242427;
					float3 PositionOS131_g242409 = v.vertex.xyz;
					float3 temp_output_4_0_g242427 = PositionOS131_g242409;
					float3 In_PositionOS16_g242427 = temp_output_4_0_g242427;
					float3 temp_output_104_7_g242409 = ase_positionWS;
					float3 PositionWS122_g242409 = temp_output_104_7_g242409;
					float3 In_PositionWS16_g242427 = PositionWS122_g242409;
					float4x4 break19_g242412 = unity_ObjectToWorld;
					float3 appendResult20_g242412 = (float3(break19_g242412[ 0 ][ 3 ] , break19_g242412[ 1 ][ 3 ] , break19_g242412[ 2 ][ 3 ]));
					float3 temp_output_340_7_g242409 = appendResult20_g242412;
					float3 PivotWS121_g242409 = temp_output_340_7_g242409;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242409 = ( PositionWS122_g242409 - PivotWS121_g242409 );
					#else
					float3 staticSwitch204_g242409 = PositionWS122_g242409;
					#endif
					float3 PositionWO132_g242409 = ( staticSwitch204_g242409 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242427 = PositionWO132_g242409;
					float3 PivotOS149_g242409 = _Vector0;
					float3 In_PivotOS16_g242427 = PivotOS149_g242409;
					float3 In_PivotWS16_g242427 = PivotWS121_g242409;
					float3 PivotWO133_g242409 = ( PivotWS121_g242409 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242427 = PivotWO133_g242409;
					half3 NormalOS134_g242409 = v.normal;
					float3 temp_output_21_0_g242427 = NormalOS134_g242409;
					float3 In_NormalOS16_g242427 = temp_output_21_0_g242427;
					half3 NormalWS95_g242409 = normalizedWorldNormal;
					float3 In_NormalWS16_g242427 = NormalWS95_g242409;
					float4 appendResult462_g242409 = (float4(cross( v.normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g242409 = appendResult462_g242409;
					float4 temp_output_6_0_g242427 = TangentlOS153_g242409;
					float4 In_TangentOS16_g242427 = temp_output_6_0_g242427;
					float3 normalizeResult296_g242409 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242409 ) );
					half3 ViewDirWS169_g242409 = normalizeResult296_g242409;
					float3 In_ViewDirWS16_g242427 = ViewDirWS169_g242409;
					float4 appendResult397_g242409 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g242409 = appendResult397_g242409;
					float4 In_CoordsData16_g242427 = CoordsData398_g242409;
					half4 VertexMasks171_g242409 = float4( 0,0,0,0 );
					float4 In_VertexData16_g242427 = VertexMasks171_g242409;
					half4 MasksData254_g242409 = float4( 0,0,0,0 );
					float4 In_MasksData16_g242427 = MasksData254_g242409;
					half4 Phase_Data176_g242409 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g242427 = Phase_Data176_g242409;
					BuildModelVertData( Data16_g242427 , In_Dummy16_g242427 , In_PositionOS16_g242427 , In_PositionWS16_g242427 , In_PositionWO16_g242427 , In_PivotOS16_g242427 , In_PivotWS16_g242427 , In_PivotWO16_g242427 , In_NormalOS16_g242427 , In_NormalWS16_g242427 , In_TangentOS16_g242427 , In_ViewDirWS16_g242427 , In_CoordsData16_g242427 , In_VertexData16_g242427 , In_MasksData16_g242427 , In_PhaseData16_g242427 );
					TVEModelData DataTerrain26_g242551 = Data16_g242427;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g242551 = IsShaderType2637;
					{
					if (Type26_g242551 == 0 )
					{
					Data26_g242551 = DataDefault26_g242551;
					}
					else if (Type26_g242551 == 1 )
					{
					Data26_g242551 = DataGeneral26_g242551;
					}
					else if (Type26_g242551 == 2 )
					{
					Data26_g242551 = DataBlanket26_g242551;
					}
					else if (Type26_g242551 == 3 )
					{
					Data26_g242551 = DataImpostor26_g242551;
					}
					else if (Type26_g242551 == 4 )
					{
					Data26_g242551 = DataTerrain26_g242551;
					}
					}
					TVEModelData Data15_g251553 =(TVEModelData)Data26_g242551;
					float Out_Dummy15_g251553 = 0.0;
					float3 Out_PositionOS15_g251553 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251553 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251553 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251553 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251553 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251553 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251553 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251553 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251553 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251553 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251553 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251553 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251553 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251553 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251553 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251553 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251553 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251553 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251553 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251553 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251553 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251553 , Out_Dummy15_g251553 , Out_PositionOS15_g251553 , Out_PositionWS15_g251553 , Out_PositionWO15_g251553 , Out_PositionRawOS15_g251553 , Out_PivotOS15_g251553 , Out_PivotWS15_g251553 , Out_PivotWO15_g251553 , Out_NormalOS15_g251553 , Out_NormalWS15_g251553 , Out_NormalRawOS15_g251553 , Out_TangentOS15_g251553 , Out_TangentWS15_g251553 , Out_BitangentWS15_g251553 , Out_ViewDirWS15_g251553 , Out_CoordsData15_g251553 , Out_VertexData15_g251553 , Out_MasksData15_g251553 , Out_PhaseData15_g251553 , Out_TransformData15_g251553 , Out_RotationData15_g251553 , Out_Interpolator15_g251553 );
					float3 In_PositionOS16_g251552 = Out_PositionOS15_g251553;
					float3 In_NormalOS16_g251552 = Out_NormalOS15_g251553;
					float4 In_TangentOS16_g251552 = Out_TangentOS15_g251553;
					float4 In_TransformData16_g251552 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251552 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251552 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251552 , In_Dummy16_g251552 , In_PositionOS16_g251552 , In_NormalOS16_g251552 , In_TangentOS16_g251552 , In_TransformData16_g251552 , In_RotationData16_g251552 , In_Interpolator16_g251552 );
					TVEVertexData Data15_g251555 =(TVEVertexData)Data16_g251552;
					float Out_Dummy15_g251555 = 0.0;
					float3 Out_PositionOS15_g251555 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251555 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251555 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251555 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251555 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251555 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251555 , Out_Dummy15_g251555 , Out_PositionOS15_g251555 , Out_NormalOS15_g251555 , Out_TangentOS15_g251555 , Out_TransformData15_g251555 , Out_RotationData15_g251555 , Out_Interpolator15_g251555 );
					TVEModelData Data15_g251556 =(TVEModelData)Data15_g251553;
					float Out_Dummy15_g251556 = 0.0;
					float3 Out_PositionOS15_g251556 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251556 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251556 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251556 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251556 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251556 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251556 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251556 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251556 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251556 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251556 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251556 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251556 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251556 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251556 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251556 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251556 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251556 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251556 , Out_Dummy15_g251556 , Out_PositionOS15_g251556 , Out_PositionWS15_g251556 , Out_PositionWO15_g251556 , Out_PositionRawOS15_g251556 , Out_PivotOS15_g251556 , Out_PivotWS15_g251556 , Out_PivotWO15_g251556 , Out_NormalOS15_g251556 , Out_NormalWS15_g251556 , Out_NormalRawOS15_g251556 , Out_TangentOS15_g251556 , Out_TangentWS15_g251556 , Out_BitangentWS15_g251556 , Out_ViewDirWS15_g251556 , Out_CoordsData15_g251556 , Out_VertexData15_g251556 , Out_MasksData15_g251556 , Out_PhaseData15_g251556 , Out_TransformData15_g251556 , Out_RotationData15_g251556 , Out_Interpolator15_g251556 );
					float3 In_PositionOS16_g251557 = ( Out_PositionOS15_g251555 - Out_PivotOS15_g251556 );
					float3 In_NormalOS16_g251557 = Out_NormalOS15_g251556;
					float4 In_TangentOS16_g251557 = Out_TangentOS15_g251556;
					float4 In_TransformData16_g251557 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251557 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251557 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251557 , In_Dummy16_g251557 , In_PositionOS16_g251557 , In_NormalOS16_g251557 , In_TangentOS16_g251557 , In_TransformData16_g251557 , In_RotationData16_g251557 , In_Interpolator16_g251557 );
					TVEVertexData Data15_g251566 =(TVEVertexData)Data16_g251557;
					float Out_Dummy15_g251566 = 0.0;
					float3 Out_PositionOS15_g251566 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251566 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251566 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251566 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251566 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251566 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251566 , Out_Dummy15_g251566 , Out_PositionOS15_g251566 , Out_NormalOS15_g251566 , Out_TangentOS15_g251566 , Out_TransformData15_g251566 , Out_RotationData15_g251566 , Out_Interpolator15_g251566 );
					TVEVertexData Data16_g251567 =(TVEVertexData)Data15_g251566;
					half Dummy317_g251558 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251567 = Dummy317_g251558;
					float3 In_PositionOS16_g251567 = Out_PositionOS15_g251566;
					float3 In_NormalOS16_g251567 = Out_NormalOS15_g251566;
					float4 In_TangentOS16_g251567 = Out_TangentOS15_g251566;
					half4 Model_TransformData356_g251558 = Out_TransformData15_g251566;
					float localBuildGlobalData204_g242450 = ( 0.0 );
					TVEGlobalData Data204_g242450 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g242450 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g242450 = Dummy211_g242450;
					float4 temp_output_203_0_g242469 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g242408 = ( 0.0 );
					TVEModelData Data26_g242408 = (TVEModelData)0;
					TVEModelData Data16_g242437 =(TVEModelData)0;
					float In_Dummy16_g242437 = 0.0;
					float3 In_PositionWS16_g242437 = PositionWS122_g242429;
					float3 In_PositionWO16_g242437 = PositionWO132_g242429;
					float3 In_PivotWS16_g242437 = PivotWS121_g242429;
					float3 In_PivotWO16_g242437 = PivotWO133_g242429;
					float3 In_NormalWS16_g242437 = NormalWS95_g242429;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g242429 = ase_tangentWS;
					float3 In_TangentWS16_g242437 = TangentWS136_g242429;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g242429 = ase_bitangentWS;
					float3 In_BitangentWS16_g242437 = BiangentWS421_g242429;
					half3 NormalWS427_g242429 = NormalWS95_g242429;
					half3 localComputeTriplanarMasks427_g242429 = ComputeTriplanarMasks( NormalWS427_g242429 );
					half3 TriplanarWeights429_g242429 = localComputeTriplanarMasks427_g242429;
					float3 In_TriplanarWeights16_g242437 = TriplanarWeights429_g242429;
					float3 In_ViewDirWS16_g242437 = ViewDirWS169_g242429;
					float4 In_CoordsData16_g242437 = CoordsData398_g242429;
					float4 In_VertexData16_g242437 = VertexMasks171_g242429;
					float4 In_Interpolator16_g242437 = Phase_Data176_g242429;
					BuildModelFragData( Data16_g242437 , In_Dummy16_g242437 , In_PositionWS16_g242437 , In_PositionWO16_g242437 , In_PivotWS16_g242437 , In_PivotWO16_g242437 , In_NormalWS16_g242437 , In_TangentWS16_g242437 , In_BitangentWS16_g242437 , In_TriplanarWeights16_g242437 , In_ViewDirWS16_g242437 , In_CoordsData16_g242437 , In_VertexData16_g242437 , In_Interpolator16_g242437 );
					TVEModelData DataDefault26_g242408 = Data16_g242437;
					TVEModelData DataGeneral26_g242408 = Data16_g242437;
					TVEModelData DataBlanket26_g242408 = Data16_g242437;
					TVEModelData DataImpostor26_g242408 = Data16_g242437;
					TVEModelData Data16_g242417 =(TVEModelData)0;
					float In_Dummy16_g242417 = 0.0;
					float3 In_PositionWS16_g242417 = PositionWS122_g242409;
					float3 In_PositionWO16_g242417 = PositionWO132_g242409;
					float3 In_PivotWS16_g242417 = PivotWS121_g242409;
					float3 In_PivotWO16_g242417 = PivotWO133_g242409;
					float3 In_NormalWS16_g242417 = NormalWS95_g242409;
					half3 TangentWS136_g242409 = ase_tangentWS;
					float3 In_TangentWS16_g242417 = TangentWS136_g242409;
					half3 BiangentWS421_g242409 = ase_bitangentWS;
					float3 In_BitangentWS16_g242417 = BiangentWS421_g242409;
					half3 NormalWS427_g242409 = NormalWS95_g242409;
					half3 localComputeTriplanarMasks427_g242409 = ComputeTriplanarMasks( NormalWS427_g242409 );
					half3 TriplanarWeights429_g242409 = localComputeTriplanarMasks427_g242409;
					float3 In_TriplanarWeights16_g242417 = TriplanarWeights429_g242409;
					float3 In_ViewDirWS16_g242417 = ViewDirWS169_g242409;
					float4 In_CoordsData16_g242417 = CoordsData398_g242409;
					float4 In_VertexData16_g242417 = VertexMasks171_g242409;
					float4 In_Interpolator16_g242417 = Phase_Data176_g242409;
					BuildModelFragData( Data16_g242417 , In_Dummy16_g242417 , In_PositionWS16_g242417 , In_PositionWO16_g242417 , In_PivotWS16_g242417 , In_PivotWO16_g242417 , In_NormalWS16_g242417 , In_TangentWS16_g242417 , In_BitangentWS16_g242417 , In_TriplanarWeights16_g242417 , In_ViewDirWS16_g242417 , In_CoordsData16_g242417 , In_VertexData16_g242417 , In_Interpolator16_g242417 );
					TVEModelData DataTerrain26_g242408 = Data16_g242417;
					float Type26_g242408 = IsShaderType2637;
					{
					if (Type26_g242408 == 0 )
					{
					Data26_g242408 = DataDefault26_g242408;
					}
					else if (Type26_g242408 == 1 )
					{
					Data26_g242408 = DataGeneral26_g242408;
					}
					else if (Type26_g242408 == 2 )
					{
					Data26_g242408 = DataBlanket26_g242408;
					}
					else if (Type26_g242408 == 3 )
					{
					Data26_g242408 = DataImpostor26_g242408;
					}
					else if (Type26_g242408 == 4 )
					{
					Data26_g242408 = DataTerrain26_g242408;
					}
					}
					TVEModelData Data15_g242540 =(TVEModelData)Data26_g242408;
					float Out_Dummy15_g242540 = 0.0;
					float3 Out_PositionWS15_g242540 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242540 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242540 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242540 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242540 = float3( 0,0,0 );
					float3 Out_TangentWS15_g242540 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242540 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g242540 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242540 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242540 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242540 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g242540 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g242540 , Out_Dummy15_g242540 , Out_PositionWS15_g242540 , Out_PositionWO15_g242540 , Out_PivotWS15_g242540 , Out_PivotWO15_g242540 , Out_NormalWS15_g242540 , Out_TangentWS15_g242540 , Out_BitangentWS15_g242540 , Out_TriplanarWeights15_g242540 , Out_ViewDirWS15_g242540 , Out_CoordsData15_g242540 , Out_VertexData15_g242540 , Out_Interpolator15_g242540 );
					float3 Model_PositionWS497_g242450 = Out_PositionWS15_g242540;
					float2 Model_PositionWS_XZ143_g242450 = (Model_PositionWS497_g242450).xz;
					float3 Model_PivotWS498_g242450 = Out_PivotWS15_g242540;
					float2 Model_PivotWS_XZ145_g242450 = (Model_PivotWS498_g242450).xz;
					float2 lerpResult300_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g242469 = lerpResult300_g242450;
					float temp_output_82_0_g242467 = _GlobalCoatLayerValue;
					float temp_output_82_0_g242469 = temp_output_82_0_g242467;
					float4 tex2DArrayNode83_g242469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242469).zw + ( (temp_output_203_0_g242469).xy * temp_output_81_0_g242469 ) ),temp_output_82_0_g242469), 0.0 );
					float4 appendResult210_g242469 = (float4(tex2DArrayNode83_g242469.rgb , tex2DArrayNode83_g242469.a));
					float4 temp_output_204_0_g242469 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g242469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242469).zw + ( (temp_output_204_0_g242469).xy * temp_output_81_0_g242469 ) ),temp_output_82_0_g242469), 0.0 );
					float4 appendResult212_g242469 = (float4(tex2DArrayNode122_g242469.rgb , tex2DArrayNode122_g242469.a));
					float4 TVE_RenderNearPositionR628_g242450 = TVE_RenderNearPositionR;
					float temp_output_507_0_g242450 = saturate( ( distance( Model_PositionWS497_g242450 , (TVE_RenderNearPositionR628_g242450).xyz ) / (TVE_RenderNearPositionR628_g242450).w ) );
					float temp_output_7_0_g242539 = 1.0;
					float temp_output_9_0_g242539 = ( temp_output_507_0_g242450 - temp_output_7_0_g242539 );
					half TVE_RenderNearFadeValue635_g242450 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g242450 = saturate( ( temp_output_9_0_g242539 / ( ( TVE_RenderNearFadeValue635_g242450 - temp_output_7_0_g242539 ) + 0.0001 ) ) );
					float4 lerpResult131_g242469 = lerp( appendResult210_g242469 , appendResult212_g242469 , Global_TexBlend509_g242450);
					float4 temp_output_159_109_g242467 = lerpResult131_g242469;
					float4 lerpResult168_g242467 = lerp( TVE_CoatParams , temp_output_159_109_g242467 , TVE_CoatLayers[(int)temp_output_82_0_g242467]);
					float4 temp_output_589_109_g242450 = lerpResult168_g242467;
					half4 Coat_Texture302_g242450 = temp_output_589_109_g242450;
					float4 In_CoatTexture204_g242450 = Coat_Texture302_g242450;
					half4 Draw_Texture656_g242450 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g242450 = Draw_Texture656_g242450;
					float4 temp_output_203_0_g242494 = TVE_PaintBaseCoord;
					float2 lerpResult85_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g242494 = lerpResult85_g242450;
					float temp_output_82_0_g242491 = _GlobalPaintLayerValue;
					float temp_output_82_0_g242494 = temp_output_82_0_g242491;
					float4 tex2DArrayNode83_g242494 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242494).zw + ( (temp_output_203_0_g242494).xy * temp_output_81_0_g242494 ) ),temp_output_82_0_g242494), 0.0 );
					float4 appendResult210_g242494 = (float4(tex2DArrayNode83_g242494.rgb , tex2DArrayNode83_g242494.a));
					float4 temp_output_204_0_g242494 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g242494 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242494).zw + ( (temp_output_204_0_g242494).xy * temp_output_81_0_g242494 ) ),temp_output_82_0_g242494), 0.0 );
					float4 appendResult212_g242494 = (float4(tex2DArrayNode122_g242494.rgb , tex2DArrayNode122_g242494.a));
					float4 lerpResult131_g242494 = lerp( appendResult210_g242494 , appendResult212_g242494 , Global_TexBlend509_g242450);
					float4 temp_output_171_109_g242491 = lerpResult131_g242494;
					float4 lerpResult174_g242491 = lerp( TVE_PaintParams , temp_output_171_109_g242491 , TVE_PaintLayers[(int)temp_output_82_0_g242491]);
					float4 temp_output_595_109_g242450 = lerpResult174_g242491;
					half4 Paint_Texture71_g242450 = temp_output_595_109_g242450;
					float4 In_PaintTexture204_g242450 = Paint_Texture71_g242450;
					float4 temp_output_203_0_g242477 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g242477 = lerpResult104_g242450;
					float temp_output_132_0_g242475 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g242477 = temp_output_132_0_g242475;
					float4 tex2DArrayNode83_g242477 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242477).zw + ( (temp_output_203_0_g242477).xy * temp_output_81_0_g242477 ) ),temp_output_82_0_g242477), 0.0 );
					float4 appendResult210_g242477 = (float4(tex2DArrayNode83_g242477.rgb , tex2DArrayNode83_g242477.a));
					float4 temp_output_204_0_g242477 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g242477 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242477).zw + ( (temp_output_204_0_g242477).xy * temp_output_81_0_g242477 ) ),temp_output_82_0_g242477), 0.0 );
					float4 appendResult212_g242477 = (float4(tex2DArrayNode122_g242477.rgb , tex2DArrayNode122_g242477.a));
					float4 lerpResult131_g242477 = lerp( appendResult210_g242477 , appendResult212_g242477 , Global_TexBlend509_g242450);
					float4 temp_output_137_109_g242475 = lerpResult131_g242477;
					float4 lerpResult145_g242475 = lerp( TVE_AtmoParams , temp_output_137_109_g242475 , TVE_AtmoLayers[(int)temp_output_132_0_g242475]);
					float4 temp_output_590_110_g242450 = lerpResult145_g242475;
					half4 Atmo_Texture80_g242450 = temp_output_590_110_g242450;
					float4 In_AtmoTexture204_g242450 = Atmo_Texture80_g242450;
					float4 temp_output_203_0_g242545 = TVE_EffexBaseCoord;
					float2 lerpResult414_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g242545 = lerpResult414_g242450;
					float temp_output_132_0_g242543 = _GlobalEffexLayerValue;
					float temp_output_82_0_g242545 = temp_output_132_0_g242543;
					float4 tex2DArrayNode83_g242545 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242545).zw + ( (temp_output_203_0_g242545).xy * temp_output_81_0_g242545 ) ),temp_output_82_0_g242545), 0.0 );
					float4 appendResult210_g242545 = (float4(tex2DArrayNode83_g242545.rgb , tex2DArrayNode83_g242545.a));
					float4 temp_output_204_0_g242545 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g242545 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242545).zw + ( (temp_output_204_0_g242545).xy * temp_output_81_0_g242545 ) ),temp_output_82_0_g242545), 0.0 );
					float4 appendResult212_g242545 = (float4(tex2DArrayNode122_g242545.rgb , tex2DArrayNode122_g242545.a));
					float4 lerpResult131_g242545 = lerp( appendResult210_g242545 , appendResult212_g242545 , Global_TexBlend509_g242450);
					float4 temp_output_137_109_g242543 = lerpResult131_g242545;
					float4 lerpResult145_g242543 = lerp( TVE_EffexParams , temp_output_137_109_g242543 , TVE_EffexLayers[(int)temp_output_132_0_g242543]);
					float4 temp_output_731_110_g242450 = lerpResult145_g242543;
					half4 Effex_Texture420_g242450 = temp_output_731_110_g242450;
					float4 In_EffexTexture204_g242450 = Effex_Texture420_g242450;
					float4 temp_output_203_0_g242525 = TVE_GlowBaseCoord;
					float2 lerpResult247_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g242525 = lerpResult247_g242450;
					float temp_output_82_0_g242523 = _GlobalGlowLayerValue;
					float temp_output_82_0_g242525 = temp_output_82_0_g242523;
					float4 tex2DArrayNode83_g242525 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242525).zw + ( (temp_output_203_0_g242525).xy * temp_output_81_0_g242525 ) ),temp_output_82_0_g242525), 0.0 );
					float4 appendResult210_g242525 = (float4(tex2DArrayNode83_g242525.rgb , tex2DArrayNode83_g242525.a));
					float4 temp_output_204_0_g242525 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g242525 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242525).zw + ( (temp_output_204_0_g242525).xy * temp_output_81_0_g242525 ) ),temp_output_82_0_g242525), 0.0 );
					float4 appendResult212_g242525 = (float4(tex2DArrayNode122_g242525.rgb , tex2DArrayNode122_g242525.a));
					float4 lerpResult131_g242525 = lerp( appendResult210_g242525 , appendResult212_g242525 , Global_TexBlend509_g242450);
					float4 temp_output_159_109_g242523 = lerpResult131_g242525;
					float4 lerpResult167_g242523 = lerp( TVE_GlowParams , temp_output_159_109_g242523 , TVE_GlowLayers[(int)temp_output_82_0_g242523]);
					float4 temp_output_593_109_g242450 = lerpResult167_g242523;
					half4 Glow_Texture248_g242450 = temp_output_593_109_g242450;
					float4 In_GlowTexture204_g242450 = Glow_Texture248_g242450;
					float4 temp_output_203_0_g242461 = TVE_FormBaseCoord;
					float2 lerpResult168_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g242461 = lerpResult168_g242450;
					float temp_output_130_0_g242459 = _GlobalFormLayerValue;
					float temp_output_82_0_g242461 = temp_output_130_0_g242459;
					float4 tex2DArrayNode83_g242461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242461).zw + ( (temp_output_203_0_g242461).xy * temp_output_81_0_g242461 ) ),temp_output_82_0_g242461), 0.0 );
					float4 appendResult210_g242461 = (float4(tex2DArrayNode83_g242461.rgb , tex2DArrayNode83_g242461.a));
					float4 temp_output_204_0_g242461 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g242461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242461).zw + ( (temp_output_204_0_g242461).xy * temp_output_81_0_g242461 ) ),temp_output_82_0_g242461), 0.0 );
					float4 appendResult212_g242461 = (float4(tex2DArrayNode122_g242461.rgb , tex2DArrayNode122_g242461.a));
					float4 lerpResult131_g242461 = lerp( appendResult210_g242461 , appendResult212_g242461 , Global_TexBlend509_g242450);
					float4 temp_output_135_109_g242459 = lerpResult131_g242461;
					float4 lerpResult143_g242459 = lerp( TVE_FormParams , temp_output_135_109_g242459 , TVE_FormLayers[(int)temp_output_130_0_g242459]);
					float4 temp_output_592_0_g242450 = lerpResult143_g242459;
					float4 Form_Texture112_g242450 = temp_output_592_0_g242450;
					float4 In_FormTexture204_g242450 = Form_Texture112_g242450;
					float4 In_LandTexture204_g242450 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g242509 = TVE_VertxBaseCoord;
					float2 lerpResult681_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g242509 = lerpResult681_g242450;
					float temp_output_136_0_g242507 = _GlobalVertxLayerValue;
					float temp_output_82_0_g242509 = temp_output_136_0_g242507;
					float4 tex2DArrayNode83_g242509 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242509).zw + ( (temp_output_203_0_g242509).xy * temp_output_81_0_g242509 ) ),temp_output_82_0_g242509), 0.0 );
					float4 appendResult210_g242509 = (float4(tex2DArrayNode83_g242509.rgb , tex2DArrayNode83_g242509.a));
					float4 temp_output_204_0_g242509 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g242509 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242509).zw + ( (temp_output_204_0_g242509).xy * temp_output_81_0_g242509 ) ),temp_output_82_0_g242509), 0.0 );
					float4 appendResult212_g242509 = (float4(tex2DArrayNode122_g242509.rgb , tex2DArrayNode122_g242509.a));
					float4 lerpResult131_g242509 = lerp( appendResult210_g242509 , appendResult212_g242509 , Global_TexBlend509_g242450);
					float4 temp_output_141_109_g242507 = lerpResult131_g242509;
					float4 lerpResult149_g242507 = lerp( TVE_VertxParams , temp_output_141_109_g242507 , TVE_VertxLayers[(int)temp_output_136_0_g242507]);
					float4 temp_output_695_0_g242450 = lerpResult149_g242507;
					half4 Vertx_Texture693_g242450 = temp_output_695_0_g242450;
					float4 In_VertxTexture204_g242450 = Vertx_Texture693_g242450;
					float4 temp_output_203_0_g242485 = TVE_FlowBaseCoord;
					float2 lerpResult400_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g242485 = lerpResult400_g242450;
					float temp_output_136_0_g242483 = _GlobalFlowLayerValue;
					float temp_output_82_0_g242485 = temp_output_136_0_g242483;
					float4 tex2DArrayNode83_g242485 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242485).zw + ( (temp_output_203_0_g242485).xy * temp_output_81_0_g242485 ) ),temp_output_82_0_g242485), 0.0 );
					float4 appendResult210_g242485 = (float4(tex2DArrayNode83_g242485.rgb , tex2DArrayNode83_g242485.a));
					float4 temp_output_204_0_g242485 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g242485 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242485).zw + ( (temp_output_204_0_g242485).xy * temp_output_81_0_g242485 ) ),temp_output_82_0_g242485), 0.0 );
					float4 appendResult212_g242485 = (float4(tex2DArrayNode122_g242485.rgb , tex2DArrayNode122_g242485.a));
					float4 lerpResult131_g242485 = lerp( appendResult210_g242485 , appendResult212_g242485 , Global_TexBlend509_g242450);
					float4 temp_output_141_109_g242483 = lerpResult131_g242485;
					float4 lerpResult149_g242483 = lerp( TVE_FlowParams , temp_output_141_109_g242483 , TVE_FlowLayers[(int)temp_output_136_0_g242483]);
					float4 temp_output_594_0_g242450 = lerpResult149_g242483;
					half4 Flow_Texture405_g242450 = temp_output_594_0_g242450;
					float4 In_FlowTexture204_g242450 = Flow_Texture405_g242450;
					half4 User_Texture677_g242450 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g242450 = User_Texture677_g242450;
					BuildGlobalData( Data204_g242450 , In_Dummy204_g242450 , In_CoatTexture204_g242450 , In_DrawTexture204_g242450 , In_PaintTexture204_g242450 , In_AtmoTexture204_g242450 , In_EffexTexture204_g242450 , In_GlowTexture204_g242450 , In_FormTexture204_g242450 , In_LandTexture204_g242450 , In_VertxTexture204_g242450 , In_FlowTexture204_g242450 , In_UserTexture204_g242450 );
					TVEGlobalData Data15_g251568 =(TVEGlobalData)Data204_g242450;
					float Out_Dummy15_g251568 = 0.0;
					float4 Out_CoatTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251568 = float4( 0,0,0,0 );
					BreakData( Data15_g251568 , Out_Dummy15_g251568 , Out_CoatTexture15_g251568 , Out_DrawTexture15_g251568 , Out_PaintTexture15_g251568 , Out_AtmoTexture15_g251568 , Out_EffexTexture15_g251568 , Out_GlowTexture15_g251568 , Out_FormTexture15_g251568 , Out_LandTexture15_g251568 , Out_VertxTexture15_g251568 , Out_FlowTexture15_g251568 , Out_UserTexture15_g251568 );
					float4 Global_FormTexture351_g251558 = Out_FormTexture15_g251568;
					TVEModelData Data15_g251565 =(TVEModelData)Data15_g251556;
					float Out_Dummy15_g251565 = 0.0;
					float3 Out_PositionOS15_g251565 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251565 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251565 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251565 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251565 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251565 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251565 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251565 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251565 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251565 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251565 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251565 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251565 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251565 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251565 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251565 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251565 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251565 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251565 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251565 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251565 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251565 , Out_Dummy15_g251565 , Out_PositionOS15_g251565 , Out_PositionWS15_g251565 , Out_PositionWO15_g251565 , Out_PositionRawOS15_g251565 , Out_PivotOS15_g251565 , Out_PivotWS15_g251565 , Out_PivotWO15_g251565 , Out_NormalOS15_g251565 , Out_NormalWS15_g251565 , Out_NormalRawOS15_g251565 , Out_TangentOS15_g251565 , Out_TangentWS15_g251565 , Out_BitangentWS15_g251565 , Out_ViewDirWS15_g251565 , Out_CoordsData15_g251565 , Out_VertexData15_g251565 , Out_MasksData15_g251565 , Out_PhaseData15_g251565 , Out_TransformData15_g251565 , Out_RotationData15_g251565 , Out_Interpolator15_g251565 );
					float3 Model_PivotWO353_g251558 = Out_PivotWO15_g251565;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251564 = _ConformMeshMode;
					float Option70_g251564 = temp_output_17_0_g251564;
					half4 Model_VertexData357_g251558 = Out_VertexData15_g251565;
					float4 temp_output_3_0_g251564 = Model_VertexData357_g251558;
					float4 Channel70_g251564 = temp_output_3_0_g251564;
					float localSwitchChannel470_g251564 = SwitchChannel4( Option70_g251564 , Channel70_g251564 );
					float temp_output_390_0_g251558 = localSwitchChannel470_g251564;
					float temp_output_7_0_g251561 = _ConformMeshRemap.x;
					float temp_output_9_0_g251561 = ( temp_output_390_0_g251558 - temp_output_7_0_g251561 );
					float lerpResult374_g251558 = lerp( 1.0 , saturate( ( temp_output_9_0_g251561 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251558 = lerpResult374_g251558;
					float temp_output_328_0_g251558 = ( Blend_VertMask379_g251558 * TVE_IsEnabled );
					half Conform_Mask366_g251558 = temp_output_328_0_g251558;
					float temp_output_322_0_g251558 = ( ( ( ( (Global_FormTexture351_g251558).z - ( (Model_PivotWO353_g251558).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251558 ) );
					float3 appendResult329_g251558 = (float3(0.0 , temp_output_322_0_g251558 , 0.0));
					float3 appendResult387_g251558 = (float3(0.0 , 0.0 , temp_output_322_0_g251558));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251562 = appendResult387_g251558;
					#else
					float3 staticSwitch65_g251562 = appendResult329_g251558;
					#endif
					float3 Blanket_Conform368_g251558 = staticSwitch65_g251562;
					float4 appendResult312_g251558 = (float4(Blanket_Conform368_g251558 , 0.0));
					float4 temp_output_310_0_g251558 = ( Model_TransformData356_g251558 + appendResult312_g251558 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251558 = temp_output_310_0_g251558;
					#else
					float4 staticSwitch364_g251558 = Model_TransformData356_g251558;
					#endif
					half4 Final_TransformData365_g251558 = staticSwitch364_g251558;
					float4 In_TransformData16_g251567 = Final_TransformData365_g251558;
					float4 In_RotationData16_g251567 = Out_RotationData15_g251566;
					float4 In_Interpolator16_g251567 = Out_Interpolator15_g251566;
					BuildVertexData( Data16_g251567 , In_Dummy16_g251567 , In_PositionOS16_g251567 , In_NormalOS16_g251567 , In_TangentOS16_g251567 , In_TransformData16_g251567 , In_RotationData16_g251567 , In_Interpolator16_g251567 );
					TVEVertexData Data15_g251578 =(TVEVertexData)Data16_g251567;
					float Out_Dummy15_g251578 = 0.0;
					float3 Out_PositionOS15_g251578 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251578 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251578 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251578 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251578 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251578 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251578 , Out_Dummy15_g251578 , Out_PositionOS15_g251578 , Out_NormalOS15_g251578 , Out_TangentOS15_g251578 , Out_TransformData15_g251578 , Out_RotationData15_g251578 , Out_Interpolator15_g251578 );
					TVEVertexData Data16_g251579 =(TVEVertexData)Data15_g251578;
					float In_Dummy16_g251579 = 0.0;
					float3 Vertex_PositionOS147_g251569 = Out_PositionOS15_g251578;
					half3 VertexPos40_g251573 = Vertex_PositionOS147_g251569;
					float4 temp_output_1615_33_g251569 = Out_RotationData15_g251578;
					half4 Vertex_RotationData1569_g251569 = temp_output_1615_33_g251569;
					float2 break1582_g251569 = (Vertex_RotationData1569_g251569).xy;
					half Angle44_g251573 = break1582_g251569.y;
					half CosAngle89_g251573 = cos( Angle44_g251573 );
					half SinAngle93_g251573 = sin( Angle44_g251573 );
					float3 appendResult95_g251573 = (float3((VertexPos40_g251573).x , ( ( (VertexPos40_g251573).y * CosAngle89_g251573 ) - ( (VertexPos40_g251573).z * SinAngle93_g251573 ) ) , ( ( (VertexPos40_g251573).y * SinAngle93_g251573 ) + ( (VertexPos40_g251573).z * CosAngle89_g251573 ) )));
					half3 VertexPos40_g251574 = appendResult95_g251573;
					half Angle44_g251574 = -break1582_g251569.x;
					half CosAngle94_g251574 = cos( Angle44_g251574 );
					half SinAngle95_g251574 = sin( Angle44_g251574 );
					float3 appendResult98_g251574 = (float3(( ( (VertexPos40_g251574).x * CosAngle94_g251574 ) - ( (VertexPos40_g251574).y * SinAngle95_g251574 ) ) , ( ( (VertexPos40_g251574).x * SinAngle95_g251574 ) + ( (VertexPos40_g251574).y * CosAngle94_g251574 ) ) , (VertexPos40_g251574).z));
					half3 VertexPos40_g251572 = Vertex_PositionOS147_g251569;
					half Angle44_g251572 = break1582_g251569.y;
					half CosAngle89_g251572 = cos( Angle44_g251572 );
					half SinAngle93_g251572 = sin( Angle44_g251572 );
					float3 appendResult95_g251572 = (float3((VertexPos40_g251572).x , ( ( (VertexPos40_g251572).y * CosAngle89_g251572 ) - ( (VertexPos40_g251572).z * SinAngle93_g251572 ) ) , ( ( (VertexPos40_g251572).y * SinAngle93_g251572 ) + ( (VertexPos40_g251572).z * CosAngle89_g251572 ) )));
					half3 VertexPos40_g251577 = appendResult95_g251572;
					half Angle44_g251577 = break1582_g251569.x;
					half CosAngle91_g251577 = cos( Angle44_g251577 );
					half SinAngle92_g251577 = sin( Angle44_g251577 );
					float3 appendResult93_g251577 = (float3(( ( (VertexPos40_g251577).x * CosAngle91_g251577 ) + ( (VertexPos40_g251577).z * SinAngle92_g251577 ) ) , (VertexPos40_g251577).y , ( ( -(VertexPos40_g251577).x * SinAngle92_g251577 ) + ( (VertexPos40_g251577).z * CosAngle91_g251577 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251575 = appendResult93_g251577;
					#else
					float3 staticSwitch65_g251575 = appendResult98_g251574;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251570 = staticSwitch65_g251575;
					#else
					float3 staticSwitch65_g251570 = Vertex_PositionOS147_g251569;
					#endif
					float3 temp_output_1608_0_g251569 = staticSwitch65_g251570;
					half3 VertexPos40_g251576 = temp_output_1608_0_g251569;
					half Angle44_g251576 = (Vertex_RotationData1569_g251569).z;
					half CosAngle91_g251576 = cos( Angle44_g251576 );
					half SinAngle92_g251576 = sin( Angle44_g251576 );
					float3 appendResult93_g251576 = (float3(( ( (VertexPos40_g251576).x * CosAngle91_g251576 ) + ( (VertexPos40_g251576).z * SinAngle92_g251576 ) ) , (VertexPos40_g251576).y , ( ( -(VertexPos40_g251576).x * SinAngle92_g251576 ) + ( (VertexPos40_g251576).z * CosAngle91_g251576 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251571 = appendResult93_g251576;
					#else
					float3 staticSwitch65_g251571 = temp_output_1608_0_g251569;
					#endif
					float4 temp_output_1615_31_g251569 = Out_TransformData15_g251578;
					half4 Vertex_TransformData1568_g251569 = temp_output_1615_31_g251569;
					half3 Final_PositionOS178_g251569 = ( ( staticSwitch65_g251571 * (Vertex_TransformData1568_g251569).w ) + (Vertex_TransformData1568_g251569).xyz );
					float3 In_PositionOS16_g251579 = Final_PositionOS178_g251569;
					float3 In_NormalOS16_g251579 = Out_NormalOS15_g251578;
					float4 In_TangentOS16_g251579 = Out_TangentOS15_g251578;
					float4 In_TransformData16_g251579 = temp_output_1615_31_g251569;
					float4 In_RotationData16_g251579 = temp_output_1615_33_g251569;
					float4 In_Interpolator16_g251579 = Out_Interpolator15_g251578;
					BuildVertexData( Data16_g251579 , In_Dummy16_g251579 , In_PositionOS16_g251579 , In_NormalOS16_g251579 , In_TangentOS16_g251579 , In_TransformData16_g251579 , In_RotationData16_g251579 , In_Interpolator16_g251579 );
					TVEVertexData Data15_g251582 =(TVEVertexData)Data16_g251579;
					float Out_Dummy15_g251582 = 0.0;
					float3 Out_PositionOS15_g251582 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251582 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251582 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251582 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251582 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251582 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251582 , Out_Dummy15_g251582 , Out_PositionOS15_g251582 , Out_NormalOS15_g251582 , Out_TangentOS15_g251582 , Out_TransformData15_g251582 , Out_RotationData15_g251582 , Out_Interpolator15_g251582 );
					TVEVertexData Data16_g251583 =(TVEVertexData)Data15_g251582;
					float In_Dummy16_g251583 = 0.0;
					TVEModelData Data15_g251581 =(TVEModelData)Data15_g251565;
					float Out_Dummy15_g251581 = 0.0;
					float3 Out_PositionOS15_g251581 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251581 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251581 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251581 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251581 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251581 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251581 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251581 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251581 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251581 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251581 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251581 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251581 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251581 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251581 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251581 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251581 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251581 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251581 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251581 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251581 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251581 , Out_Dummy15_g251581 , Out_PositionOS15_g251581 , Out_PositionWS15_g251581 , Out_PositionWO15_g251581 , Out_PositionRawOS15_g251581 , Out_PivotOS15_g251581 , Out_PivotWS15_g251581 , Out_PivotWO15_g251581 , Out_NormalOS15_g251581 , Out_NormalWS15_g251581 , Out_NormalRawOS15_g251581 , Out_TangentOS15_g251581 , Out_TangentWS15_g251581 , Out_BitangentWS15_g251581 , Out_ViewDirWS15_g251581 , Out_CoordsData15_g251581 , Out_VertexData15_g251581 , Out_MasksData15_g251581 , Out_PhaseData15_g251581 , Out_TransformData15_g251581 , Out_RotationData15_g251581 , Out_Interpolator15_g251581 );
					float3 In_PositionOS16_g251583 = ( Out_PositionOS15_g251582 + Out_PivotOS15_g251581 );
					float3 In_NormalOS16_g251583 = Out_NormalOS15_g251582;
					float4 In_TangentOS16_g251583 = Out_TangentOS15_g251582;
					float4 In_TransformData16_g251583 = Out_TransformData15_g251582;
					float4 In_RotationData16_g251583 = Out_RotationData15_g251582;
					float4 In_Interpolator16_g251583 = Out_Interpolator15_g251582;
					BuildVertexData( Data16_g251583 , In_Dummy16_g251583 , In_PositionOS16_g251583 , In_NormalOS16_g251583 , In_TangentOS16_g251583 , In_TransformData16_g251583 , In_RotationData16_g251583 , In_Interpolator16_g251583 );
					TVEVertexData Data15_g251728 =(TVEVertexData)Data16_g251583;
					float Out_Dummy15_g251728 = 0.0;
					float3 Out_PositionOS15_g251728 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251728 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251728 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251728 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251728 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251728 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251728 , Out_Dummy15_g251728 , Out_PositionOS15_g251728 , Out_NormalOS15_g251728 , Out_TangentOS15_g251728 , Out_TransformData15_g251728 , Out_RotationData15_g251728 , Out_Interpolator15_g251728 );
					
					float3 color107_g251670 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g251670 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float localBreakData4_g251669 = ( 0.0 );
					float localBuildMasksData3_g251658 = ( 0.0 );
					TVEMasksData Data3_g251658 = (TVEMasksData)0;
					half Feature_Intensity1846_g251655 = _TransferIntensityValue;
					float ifLocalVar18_g251660 = 0;
					if( Feature_Intensity1846_g251655 <= 0.0 )
					ifLocalVar18_g251660 = 0.0;
					else
					ifLocalVar18_g251660 = 1.0;
					float4 temp_cast_13 = (ifLocalVar18_g251660).xxxx;
					float4 In_MaskA3_g251658 = temp_cast_13;
					float temp_output_17_0_g251666 = _TransferMeshMode;
					float Option70_g251666 = temp_output_17_0_g251666;
					TVEModelData Data15_g251656 =(TVEModelData)Data26_g242551;
					float Out_Dummy15_g251656 = 0.0;
					float3 Out_PositionOS15_g251656 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251656 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251656 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251656 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251656 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251656 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251656 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251656 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251656 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251656 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251656 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251656 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251656 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251656 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251656 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251656 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251656 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251656 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251656 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251656 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251656 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251656 , Out_Dummy15_g251656 , Out_PositionOS15_g251656 , Out_PositionWS15_g251656 , Out_PositionWO15_g251656 , Out_PositionRawOS15_g251656 , Out_PivotOS15_g251656 , Out_PivotWS15_g251656 , Out_PivotWO15_g251656 , Out_NormalOS15_g251656 , Out_NormalWS15_g251656 , Out_NormalRawOS15_g251656 , Out_TangentOS15_g251656 , Out_TangentWS15_g251656 , Out_BitangentWS15_g251656 , Out_ViewDirWS15_g251656 , Out_CoordsData15_g251656 , Out_VertexData15_g251656 , Out_MasksData15_g251656 , Out_PhaseData15_g251656 , Out_TransformData15_g251656 , Out_RotationData15_g251656 , Out_Interpolator15_g251656 );
					float4 temp_output_1567_29_g251655 = Out_VertexData15_g251656;
					half4 Model_VertexData1608_g251655 = temp_output_1567_29_g251655;
					float4 temp_output_3_0_g251666 = Model_VertexData1608_g251655;
					float4 Channel70_g251666 = temp_output_3_0_g251666;
					float localSwitchChannel470_g251666 = SwitchChannel4( Option70_g251666 , Channel70_g251666 );
					float temp_output_1870_0_g251655 = localSwitchChannel470_g251666;
					float temp_output_7_0_g251665 = _TransferMeshRemap.x;
					float temp_output_9_0_g251665 = ( temp_output_1870_0_g251655 - temp_output_7_0_g251665 );
					float lerpResult1868_g251655 = lerp( 1.0 , saturate( ( temp_output_9_0_g251665 * _TransferMeshRemap.z ) ) , _TransferMeshValue);
					half Blend_MeshMask1876_g251655 = lerpResult1868_g251655;
					half Blend_Mask1742_g251655 = ( _TransferIntensityValue * Blend_MeshMask1876_g251655 * TVE_IsEnabled );
					float ifLocalVar18_g251668 = 0;
					if( Feature_Intensity1846_g251655 <= 0.0 )
					ifLocalVar18_g251668 = 0.0;
					else
					ifLocalVar18_g251668 = Blend_Mask1742_g251655;
					float4 appendResult1840_g251655 = (float4(ifLocalVar18_g251668 , 0.0 , 0.0 , 0.0));
					float4 In_MaskB3_g251658 = appendResult1840_g251655;
					TVEVertexData Data15_g251662 =(TVEVertexData)Data16_g251583;
					float Out_Dummy15_g251662 = 0.0;
					float3 Out_PositionOS15_g251662 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251662 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251662 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251662 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251662 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251662 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251662 , Out_Dummy15_g251662 , Out_PositionOS15_g251662 , Out_NormalOS15_g251662 , Out_TangentOS15_g251662 , Out_TransformData15_g251662 , Out_RotationData15_g251662 , Out_Interpolator15_g251662 );
					half3 Vertex_NormalOS1568_g251655 = Out_NormalOS15_g251662;
					TVEGlobalData Data15_g251661 =(TVEGlobalData)Data204_g242450;
					float Out_Dummy15_g251661 = 0.0;
					float4 Out_CoatTexture15_g251661 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251661 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251661 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251661 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251661 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251661 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251661 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251661 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251661 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251661 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251661 = float4( 0,0,0,0 );
					BreakData( Data15_g251661 , Out_Dummy15_g251661 , Out_CoatTexture15_g251661 , Out_DrawTexture15_g251661 , Out_PaintTexture15_g251661 , Out_AtmoTexture15_g251661 , Out_EffexTexture15_g251661 , Out_GlowTexture15_g251661 , Out_FormTexture15_g251661 , Out_LandTexture15_g251661 , Out_VertxTexture15_g251661 , Out_FlowTexture15_g251661 , Out_UserTexture15_g251661 );
					half4 Global_FormTexture1633_g251655 = Out_FormTexture15_g251661;
					float2 temp_output_1627_0_g251655 = ((Global_FormTexture1633_g251655).xy*2.0 + -1.0);
					float2 break1617_g251655 = temp_output_1627_0_g251655;
					float dotResult1619_g251655 = dot( temp_output_1627_0_g251655 , temp_output_1627_0_g251655 );
					float3 appendResult1618_g251655 = (float3(break1617_g251655.x , sqrt( ( 1.0 - saturate( dotResult1619_g251655 ) ) ) , break1617_g251655.y));
					float3 worldToObjDir1623_g251655 = mul( unity_WorldToObject, float4( appendResult1618_g251655, 0.0 ) ).xyz;
					half3 Surface_Normal1630_g251655 = worldToObjDir1623_g251655;
					float3 lerpResult1670_g251655 = lerp( Vertex_NormalOS1568_g251655 , Surface_Normal1630_g251655 , Blend_Mask1742_g251655);
					#ifdef TVE_TRANSFER
					float3 staticSwitch1716_g251655 = lerpResult1670_g251655;
					#else
					float3 staticSwitch1716_g251655 = Vertex_NormalOS1568_g251655;
					#endif
					half3 Final_NormalOS178_g251655 = staticSwitch1716_g251655;
					float3 ifLocalVar18_g251659 = 0;
					if( Feature_Intensity1846_g251655 <= 0.0 )
					ifLocalVar18_g251659 = Vertex_NormalOS1568_g251655;
					else
					ifLocalVar18_g251659 = Final_NormalOS178_g251655;
					float4 appendResult1839_g251655 = (float4(ifLocalVar18_g251659 , 0.0));
					float4 In_MaskC3_g251658 = appendResult1839_g251655;
					float4 temp_cast_14 = (0.0).xxxx;
					float4 In_MaskD3_g251658 = temp_cast_14;
					float4 temp_cast_15 = (0.0).xxxx;
					float4 In_MaskE3_g251658 = temp_cast_15;
					float4 temp_cast_16 = (0.0).xxxx;
					float4 In_MaskF3_g251658 = temp_cast_16;
					float4 temp_cast_17 = (0.0).xxxx;
					float4 In_MaskG3_g251658 = temp_cast_17;
					float4 temp_cast_18 = (0.0).xxxx;
					float4 In_MaskH3_g251658 = temp_cast_18;
					float4 temp_cast_19 = (0.0).xxxx;
					float4 In_MaskI3_g251658 = temp_cast_19;
					float4 temp_cast_20 = (0.0).xxxx;
					float4 In_MaskJ3_g251658 = temp_cast_20;
					float4 temp_cast_21 = (0.0).xxxx;
					float4 In_MaskK3_g251658 = temp_cast_21;
					float4 temp_cast_22 = (0.0).xxxx;
					float4 In_MaskL3_g251658 = temp_cast_22;
					{
					Data3_g251658.MaskA = In_MaskA3_g251658;
					Data3_g251658.MaskB = In_MaskB3_g251658;
					Data3_g251658.MaskC = In_MaskC3_g251658;
					Data3_g251658.MaskD = In_MaskD3_g251658;
					Data3_g251658.MaskE = In_MaskE3_g251658;
					Data3_g251658.MaskF = In_MaskF3_g251658;
					Data3_g251658.MaskG = In_MaskG3_g251658;
					Data3_g251658.MaskH = In_MaskH3_g251658;
					Data3_g251658.MaskI = In_MaskI3_g251658;
					Data3_g251658.MaskJ= In_MaskJ3_g251658;
					Data3_g251658.MaskK= In_MaskK3_g251658;
					Data3_g251658.MaskL = In_MaskL3_g251658;
					}
					TVEMasksData Data4_g251669 = Data3_g251658;
					float4 Out_MaskA4_g251669 = float4( 0,0,0,0 );
					float4 Out_MaskB4_g251669 = float4( 0,0,0,0 );
					float4 Out_MaskC4_g251669 = float4( 0,0,0,0 );
					float4 Out_MaskD4_g251669 = float4( 0,0,0,0 );
					float4 Out_MaskE4_g251669 = float4( 0,0,0,0 );
					float4 Out_MaskF4_g251669 = float4( 0,0,0,0 );
					float4 Out_MaskG4_g251669 = float4( 0,0,0,0 );
					float4 Out_MaskH4_g251669 = float4( 0,0,0,0 );
					{
					Out_MaskA4_g251669 = Data4_g251669.MaskA;
					Out_MaskB4_g251669 = Data4_g251669.MaskB;
					Out_MaskC4_g251669 = Data4_g251669.MaskC;
					Out_MaskD4_g251669 = Data4_g251669.MaskD;
					Out_MaskE4_g251669 = Data4_g251669.MaskE;
					Out_MaskF4_g251669 = Data4_g251669.MaskF;
					Out_MaskG4_g251669 = Data4_g251669.MaskG;
					Out_MaskH4_g251669 = Data4_g251669.MaskH;
					}
					float3 lerpResult2568 = lerp( color107_g251670 , color106_g251670 , (Out_MaskA4_g251669).x);
					float3 ifLocalVar40_g251674 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g251674 = lerpResult2568;
					float3 ifLocalVar40_g251675 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g251675 = (Out_MaskB4_g251669).xxx;
					float3 temp_output_2511_0 = (Out_MaskC4_g251669).xyz;
					float3 ifLocalVar40_g251672 = 0;
					if( TVE_DEBUG_Index == 4.0 )
					ifLocalVar40_g251672 = temp_output_2511_0;
					float3 objToWorldDir2643 = ASESafeNormalize( mul( unity_ObjectToWorld, float4( temp_output_2511_0, 0.0 ) ).xyz );
					float3 ifLocalVar40_g251673 = 0;
					if( TVE_DEBUG_Index == 5.0 )
					ifLocalVar40_g251673 = objToWorldDir2643;
					float3 vertexToFrag2524 = ( ifLocalVar40_g251674 + ifLocalVar40_g251675 + ( ifLocalVar40_g251672 + ifLocalVar40_g251673 ) );
					o.ase_texcoord4.xyz = vertexToFrag2524;
					float3 vertexPos57_g251720 = v.vertex.xyz;
					float4 ase_positionCS57_g251720 = UnityObjectToClipPos( vertexPos57_g251720 );
					o.ase_texcoord5 = ase_positionCS57_g251720;
					o.ase_texcoord6.xyz = vertexToFrag73_g242429;
					o.ase_texcoord7.xyz = vertexToFrag76_g242429;
					TVEVertexData Data1902_g251676 = Data16_g251583;
					float4 Out_Interpolator1902_g251676 = float4( 0,0,0,0 );
					{
					Out_Interpolator1902_g251676 = Data1902_g251676.Interpolator;
					}
					float4 vertexToFrag1901_g251676 = Out_Interpolator1902_g251676;
					o.ase_texcoord9 = vertexToFrag1901_g251676;
					
					o.ase_texcoord8.xy = v.texcoord.xyzw.xy;
					o.ase_texcoord8.zw = v.texcoord2.xyzw.xy;
					o.ase_color = v.ase_color;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord4.w = 0;
					o.ase_texcoord6.w = 0;
					o.ase_texcoord7.w = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251728;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251728;
					v.tangent = Out_TangentOS15_g251728;

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

					float temp_output_2609_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2609_114).xxx;
					
					float3 temp_cast_1 = (temp_output_2609_114).xxx;
					
					float3 color130_g251720 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g251720 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g251722 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g251721 = ( temp_cast_4 * ( 0.5 + appendResult128_g251722 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g251721 = (float4(ddx( FinalUV13_g251721 ) , ddy( FinalUV13_g251721 )));
					float4 UVDerivatives17_g251721 = appendResult16_g251721;
					float4 break28_g251721 = UVDerivatives17_g251721;
					float2 appendResult19_g251721 = (float2(break28_g251721.x , break28_g251721.z));
					float2 appendResult20_g251721 = (float2(break28_g251721.x , break28_g251721.z));
					float dotResult24_g251721 = dot( appendResult19_g251721 , appendResult20_g251721 );
					float2 appendResult21_g251721 = (float2(break28_g251721.y , break28_g251721.w));
					float2 appendResult22_g251721 = (float2(break28_g251721.y , break28_g251721.w));
					float dotResult23_g251721 = dot( appendResult21_g251721 , appendResult22_g251721 );
					float2 appendResult25_g251721 = (float2(dotResult24_g251721 , dotResult23_g251721));
					float2 derivativesLength29_g251721 = sqrt( appendResult25_g251721 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g251721 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g251721 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g251721 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g251721 = clampResult57_g251721;
					float2 break55_g251721 = derivativesLength29_g251721;
					float4 lerpResult73_g251721 = lerp( float4( color130_g251720 , 0.0 ) , float4( color81_g251720 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g251721.x * break71_g251721.y * sqrt( saturate( ( 1.1 - max( break55_g251721.x, break55_g251721.y ) ) ) ) ) ) ));
					float3 vertexToFrag2524 = IN.ase_texcoord4.xyz;
					half3 Final_Debug2399 = vertexToFrag2524;
					float temp_output_7_0_g251727 = TVE_DEBUG_Min;
					float3 temp_cast_9 = (temp_output_7_0_g251727).xxx;
					float3 temp_output_9_0_g251727 = ( Final_Debug2399 - temp_cast_9 );
					float lerpResult76_g251720 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g251720 = lerpResult76_g251720;
					float3 lerpResult72_g251720 = lerp( (lerpResult73_g251721).rgb , saturate( ( temp_output_9_0_g251727 / ( ( TVE_DEBUG_Max - temp_output_7_0_g251727 ) + 0.0001 ) ) ) , Filter152_g251720);
					float dotResult61_g251720 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g251720 = ( 1.0 - saturate( dotResult61_g251720 ) );
					float Shading_Fresnel59_g251720 = (( 1.0 - ( temp_output_65_0_g251720 * temp_output_65_0_g251720 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g251720 = IN.ase_texcoord5;
					float depthLinearEye57_g251720 = LinearEyeDepth( ase_positionCS57_g251720.z / ase_positionCS57_g251720.w );
					float temp_output_69_0_g251720 = saturate(  (0.0 + ( depthLinearEye57_g251720 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g251720 = (( temp_output_69_0_g251720 * temp_output_69_0_g251720 )*0.5 + 0.5);
					float lerpResult84_g251720 = lerp( 1.0 , Shading_Fresnel59_g251720 , ( Shading_Distance58_g251720 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g251725 = ( 0.0 );
					float localBuildVisualData3_g251682 = ( 0.0 );
					float localBuildVisualData3_g251677 = ( 0.0 );
					TVEVisualData Data3_g251677 =(TVEVisualData)0;
					float temp_output_14_0_g251677 = 0.0;
					float In_Dummy3_g251677 = temp_output_14_0_g251677;
					float3 temp_cast_10 = (0.5).xxx;
					float3 temp_output_4_0_g251677 = temp_cast_10;
					float3 In_Albedo3_g251677 = temp_output_4_0_g251677;
					float3 temp_cast_11 = (0.5).xxx;
					float3 temp_output_44_0_g251677 = temp_cast_11;
					float3 In_AlbedoBase3_g251677 = temp_output_44_0_g251677;
					float2 temp_cast_12 = (0.0).xx;
					float2 In_NormalTS3_g251677 = temp_cast_12;
					float3 temp_cast_13 = (0.5).xxx;
					float3 In_NormalWS3_g251677 = temp_cast_13;
					float4 In_Shader3_g251677 = half4( 0, 1, 0, 1 );
					float4 In_Feature3_g251677 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251677 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251677 = half4( 1, 1, 1, 1 );
					float temp_output_12_0_g251677 = 0.5;
					float In_Grayscale3_g251677 = temp_output_12_0_g251677;
					float temp_output_16_0_g251677 = 1.0;
					float In_Luminosity3_g251677 = temp_output_16_0_g251677;
					float In_MultiMask3_g251677 = 1.0;
					float In_AlphaClip3_g251677 = 1.0;
					float In_AlphaFade3_g251677 = 1.0;
					float3 temp_cast_14 = (1.0).xxx;
					float3 In_Translucency3_g251677 = temp_cast_14;
					float In_Transmission3_g251677 = 1.0;
					float In_Thickness3_g251677 = 0.0;
					float In_Diffusion3_g251677 = 0.0;
					float In_Depth3_g251677 = 0.0;
					BuildVisualData( Data3_g251677 , In_Dummy3_g251677 , In_Albedo3_g251677 , In_AlbedoBase3_g251677 , In_NormalTS3_g251677 , In_NormalWS3_g251677 , In_Shader3_g251677 , In_Feature3_g251677 , In_Season3_g251677 , In_Emissive3_g251677 , In_Grayscale3_g251677 , In_Luminosity3_g251677 , In_MultiMask3_g251677 , In_AlphaClip3_g251677 , In_AlphaFade3_g251677 , In_Translucency3_g251677 , In_Transmission3_g251677 , In_Thickness3_g251677 , In_Diffusion3_g251677 , In_Depth3_g251677 );
					TVEVisualData Data3_g251682 =(TVEVisualData)Data3_g251677;
					half Dummy130_g251680 = ( _MainCategory + _MainEnd );
					float temp_output_14_0_g251682 = Dummy130_g251680;
					float In_Dummy3_g251682 = temp_output_14_0_g251682;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251703) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g251685 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g251685 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g251685 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g251685 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g251685 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g251685 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g251703 = staticSwitch36_g251685;
					float localBreakTextureData456_g251703 = ( 0.0 );
					float localBuildTextureData431_g251702 = ( 0.0 );
					TVEMasksData Data431_g251702 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g251702 = ( 0.0 );
					float4 temp_output_6_0_g251718 = _main_coord_value;
					float4 temp_output_7_0_g251718 = ( _MainSampleMode + _MainCoordMode + _MainCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g251718 = ( temp_output_6_0_g251718 + temp_output_7_0_g251718 );
					#else
					float4 staticSwitch14_g251718 = temp_output_6_0_g251718;
					#endif
					half4 Local_Coords180_g251680 = staticSwitch14_g251718;
					float4 Coords444_g251702 = Local_Coords180_g251680;
					float localIfModelDataByShader26_g242408 = ( 0.0 );
					TVEModelData Data26_g242408 = (TVEModelData)0;
					TVEModelData Data16_g242437 =(TVEModelData)0;
					float In_Dummy16_g242437 = 0.0;
					float3 vertexToFrag73_g242429 = IN.ase_texcoord6.xyz;
					float3 PositionWS122_g242429 = vertexToFrag73_g242429;
					float3 In_PositionWS16_g242437 = PositionWS122_g242429;
					float3 vertexToFrag76_g242429 = IN.ase_texcoord7.xyz;
					float3 PivotWS121_g242429 = vertexToFrag76_g242429;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242429 = ( PositionWS122_g242429 - PivotWS121_g242429 );
					#else
					float3 staticSwitch204_g242429 = PositionWS122_g242429;
					#endif
					float3 PositionWO132_g242429 = ( staticSwitch204_g242429 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242437 = PositionWO132_g242429;
					float3 In_PivotWS16_g242437 = PivotWS121_g242429;
					float3 PivotWO133_g242429 = ( PivotWS121_g242429 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242437 = PivotWO133_g242429;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g242429 = normalizedWorldNormal;
					float3 In_NormalWS16_g242437 = NormalWS95_g242429;
					half3 TangentWS136_g242429 = TangentWS;
					float3 In_TangentWS16_g242437 = TangentWS136_g242429;
					half3 BiangentWS421_g242429 = BitangentWS;
					float3 In_BitangentWS16_g242437 = BiangentWS421_g242429;
					half3 NormalWS427_g242429 = NormalWS95_g242429;
					half3 localComputeTriplanarMasks427_g242429 = ComputeTriplanarMasks( NormalWS427_g242429 );
					half3 TriplanarWeights429_g242429 = localComputeTriplanarMasks427_g242429;
					float3 In_TriplanarWeights16_g242437 = TriplanarWeights429_g242429;
					float3 normalizeResult296_g242429 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242429 ) );
					half3 ViewDirWS169_g242429 = normalizeResult296_g242429;
					float3 In_ViewDirWS16_g242437 = ViewDirWS169_g242429;
					float4 appendResult397_g242429 = (float4(IN.ase_texcoord8.xy , IN.ase_texcoord8.zw));
					float4 CoordsData398_g242429 = appendResult397_g242429;
					float4 In_CoordsData16_g242437 = CoordsData398_g242429;
					half4 VertexMasks171_g242429 = IN.ase_color;
					float4 In_VertexData16_g242437 = VertexMasks171_g242429;
					float temp_output_17_0_g242440 = _ObjectPhaseMode;
					float Option70_g242440 = temp_output_17_0_g242440;
					float4 temp_output_3_0_g242440 = IN.ase_color;
					float4 Channel70_g242440 = temp_output_3_0_g242440;
					float localSwitchChannel470_g242440 = SwitchChannel4( Option70_g242440 , Channel70_g242440 );
					half Phase_Value372_g242429 = localSwitchChannel470_g242440;
					float3 break319_g242429 = PivotWO133_g242429;
					half Pivot_Position322_g242429 = ( break319_g242429.x + break319_g242429.z );
					half Phase_Position357_g242429 = ( Phase_Value372_g242429 + Pivot_Position322_g242429 );
					float temp_output_248_0_g242429 = frac( Phase_Position357_g242429 );
					float4 appendResult177_g242429 = (float4((frac( ( Phase_Position357_g242429 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g242429));
					half4 Phase_Data176_g242429 = appendResult177_g242429;
					float4 In_Interpolator16_g242437 = Phase_Data176_g242429;
					BuildModelFragData( Data16_g242437 , In_Dummy16_g242437 , In_PositionWS16_g242437 , In_PositionWO16_g242437 , In_PivotWS16_g242437 , In_PivotWO16_g242437 , In_NormalWS16_g242437 , In_TangentWS16_g242437 , In_BitangentWS16_g242437 , In_TriplanarWeights16_g242437 , In_ViewDirWS16_g242437 , In_CoordsData16_g242437 , In_VertexData16_g242437 , In_Interpolator16_g242437 );
					TVEModelData DataDefault26_g242408 = Data16_g242437;
					TVEModelData DataGeneral26_g242408 = Data16_g242437;
					TVEModelData DataBlanket26_g242408 = Data16_g242437;
					TVEModelData DataImpostor26_g242408 = Data16_g242437;
					TVEModelData Data16_g242417 =(TVEModelData)0;
					float In_Dummy16_g242417 = 0.0;
					float3 temp_output_104_7_g242409 = PositionWS;
					float3 PositionWS122_g242409 = temp_output_104_7_g242409;
					float3 In_PositionWS16_g242417 = PositionWS122_g242409;
					float4x4 break19_g242412 = unity_ObjectToWorld;
					float3 appendResult20_g242412 = (float3(break19_g242412[ 0 ][ 3 ] , break19_g242412[ 1 ][ 3 ] , break19_g242412[ 2 ][ 3 ]));
					float3 temp_output_340_7_g242409 = appendResult20_g242412;
					float3 PivotWS121_g242409 = temp_output_340_7_g242409;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242409 = ( PositionWS122_g242409 - PivotWS121_g242409 );
					#else
					float3 staticSwitch204_g242409 = PositionWS122_g242409;
					#endif
					float3 PositionWO132_g242409 = ( staticSwitch204_g242409 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242417 = PositionWO132_g242409;
					float3 In_PivotWS16_g242417 = PivotWS121_g242409;
					float3 PivotWO133_g242409 = ( PivotWS121_g242409 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242417 = PivotWO133_g242409;
					half3 NormalWS95_g242409 = normalizedWorldNormal;
					float3 In_NormalWS16_g242417 = NormalWS95_g242409;
					half3 TangentWS136_g242409 = TangentWS;
					float3 In_TangentWS16_g242417 = TangentWS136_g242409;
					half3 BiangentWS421_g242409 = BitangentWS;
					float3 In_BitangentWS16_g242417 = BiangentWS421_g242409;
					half3 NormalWS427_g242409 = NormalWS95_g242409;
					half3 localComputeTriplanarMasks427_g242409 = ComputeTriplanarMasks( NormalWS427_g242409 );
					half3 TriplanarWeights429_g242409 = localComputeTriplanarMasks427_g242409;
					float3 In_TriplanarWeights16_g242417 = TriplanarWeights429_g242409;
					float3 normalizeResult296_g242409 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242409 ) );
					half3 ViewDirWS169_g242409 = normalizeResult296_g242409;
					float3 In_ViewDirWS16_g242417 = ViewDirWS169_g242409;
					float4 appendResult397_g242409 = (float4(IN.ase_texcoord8.xy , IN.ase_texcoord8.zw));
					float4 CoordsData398_g242409 = appendResult397_g242409;
					float4 In_CoordsData16_g242417 = CoordsData398_g242409;
					half4 VertexMasks171_g242409 = float4( 0,0,0,0 );
					float4 In_VertexData16_g242417 = VertexMasks171_g242409;
					half4 Phase_Data176_g242409 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g242417 = Phase_Data176_g242409;
					BuildModelFragData( Data16_g242417 , In_Dummy16_g242417 , In_PositionWS16_g242417 , In_PositionWO16_g242417 , In_PivotWS16_g242417 , In_PivotWO16_g242417 , In_NormalWS16_g242417 , In_TangentWS16_g242417 , In_BitangentWS16_g242417 , In_TriplanarWeights16_g242417 , In_ViewDirWS16_g242417 , In_CoordsData16_g242417 , In_VertexData16_g242417 , In_Interpolator16_g242417 );
					TVEModelData DataTerrain26_g242408 = Data16_g242417;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g242408 = IsShaderType2637;
					{
					if (Type26_g242408 == 0 )
					{
					Data26_g242408 = DataDefault26_g242408;
					}
					else if (Type26_g242408 == 1 )
					{
					Data26_g242408 = DataGeneral26_g242408;
					}
					else if (Type26_g242408 == 2 )
					{
					Data26_g242408 = DataBlanket26_g242408;
					}
					else if (Type26_g242408 == 3 )
					{
					Data26_g242408 = DataImpostor26_g242408;
					}
					else if (Type26_g242408 == 4 )
					{
					Data26_g242408 = DataTerrain26_g242408;
					}
					}
					TVEModelData Data15_g251678 =(TVEModelData)Data26_g242408;
					float Out_Dummy15_g251678 = 0.0;
					float3 Out_PositionWS15_g251678 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251678 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251678 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251678 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251678 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251678 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251678 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251678 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251678 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251678 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251678 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251678 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251678 , Out_Dummy15_g251678 , Out_PositionWS15_g251678 , Out_PositionWO15_g251678 , Out_PivotWS15_g251678 , Out_PivotWO15_g251678 , Out_NormalWS15_g251678 , Out_TangentWS15_g251678 , Out_BitangentWS15_g251678 , Out_TriplanarWeights15_g251678 , Out_ViewDirWS15_g251678 , Out_CoordsData15_g251678 , Out_VertexData15_g251678 , Out_Interpolator15_g251678 );
					TVEModelData Data16_g251679 =(TVEModelData)Data15_g251678;
					float In_Dummy16_g251679 = Out_Dummy15_g251678;
					float3 In_PositionWS16_g251679 = Out_PositionWS15_g251678;
					float3 In_PositionWO16_g251679 = Out_PositionWO15_g251678;
					float3 In_PivotWS16_g251679 = Out_PivotWS15_g251678;
					float3 In_PivotWO16_g251679 = Out_PivotWO15_g251678;
					float3 In_NormalWS16_g251679 = Out_NormalWS15_g251678;
					float3 In_TangentWS16_g251679 = Out_TangentWS15_g251678;
					float3 In_BitangentWS16_g251679 = Out_BitangentWS15_g251678;
					float3 In_TriplanarWeights16_g251679 = Out_TriplanarWeights15_g251678;
					float3 In_ViewDirWS16_g251679 = Out_ViewDirWS15_g251678;
					float4 In_CoordsData16_g251679 = Out_CoordsData15_g251678;
					float4 In_VertexData16_g251679 = Out_VertexData15_g251678;
					float4 vertexToFrag1901_g251676 = IN.ase_texcoord9;
					float4 In_Interpolator16_g251679 = vertexToFrag1901_g251676;
					BuildModelFragData( Data16_g251679 , In_Dummy16_g251679 , In_PositionWS16_g251679 , In_PositionWO16_g251679 , In_PivotWS16_g251679 , In_PivotWO16_g251679 , In_NormalWS16_g251679 , In_TangentWS16_g251679 , In_BitangentWS16_g251679 , In_TriplanarWeights16_g251679 , In_ViewDirWS16_g251679 , In_CoordsData16_g251679 , In_VertexData16_g251679 , In_Interpolator16_g251679 );
					TVEModelData Data15_g251681 =(TVEModelData)Data16_g251679;
					float Out_Dummy15_g251681 = 0.0;
					float3 Out_PositionWS15_g251681 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251681 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251681 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251681 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251681 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251681 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251681 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251681 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251681 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251681 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251681 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251681 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251681 , Out_Dummy15_g251681 , Out_PositionWS15_g251681 , Out_PositionWO15_g251681 , Out_PivotWS15_g251681 , Out_PivotWO15_g251681 , Out_NormalWS15_g251681 , Out_TangentWS15_g251681 , Out_BitangentWS15_g251681 , Out_TriplanarWeights15_g251681 , Out_ViewDirWS15_g251681 , Out_CoordsData15_g251681 , Out_VertexData15_g251681 , Out_Interpolator15_g251681 );
					float4 Model_CoordsData324_g251680 = Out_CoordsData15_g251681;
					float4 MeshCoords444_g251702 = Model_CoordsData324_g251680;
					float2 UV0444_g251702 = float2( 0,0 );
					float2 UV3444_g251702 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g251702 , MeshCoords444_g251702 , UV0444_g251702 , UV3444_g251702 );
					float4 appendResult430_g251702 = (float4(UV0444_g251702 , UV3444_g251702));
					float4 In_MaskA431_g251702 = appendResult430_g251702;
					float localComputeWorldCoords315_g251702 = ( 0.0 );
					float4 Coords315_g251702 = Local_Coords180_g251680;
					float3 Model_PositionWO222_g251680 = Out_PositionWO15_g251681;
					float3 PositionWS315_g251702 = Model_PositionWO222_g251680;
					float2 ZY315_g251702 = float2( 0,0 );
					float2 XZ315_g251702 = float2( 0,0 );
					float2 XY315_g251702 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g251702 , PositionWS315_g251702 , ZY315_g251702 , XZ315_g251702 , XY315_g251702 );
					float2 ZY402_g251702 = ZY315_g251702;
					float2 XZ403_g251702 = XZ315_g251702;
					float4 appendResult432_g251702 = (float4(ZY402_g251702 , XZ403_g251702));
					float4 In_MaskB431_g251702 = appendResult432_g251702;
					float2 XY404_g251702 = XY315_g251702;
					float localComputeStochasticCoords409_g251702 = ( 0.0 );
					float2 UV409_g251702 = ZY402_g251702;
					float2 UV1409_g251702 = float2( 0,0 );
					float2 UV2409_g251702 = float2( 0,0 );
					float2 UV3409_g251702 = float2( 0,0 );
					float3 Weights409_g251702 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g251702 , UV1409_g251702 , UV2409_g251702 , UV3409_g251702 , Weights409_g251702 );
					float4 appendResult433_g251702 = (float4(XY404_g251702 , UV1409_g251702));
					float4 In_MaskC431_g251702 = appendResult433_g251702;
					float4 appendResult434_g251702 = (float4(UV2409_g251702 , UV3409_g251702));
					float4 In_MaskD431_g251702 = appendResult434_g251702;
					float localComputeStochasticCoords422_g251702 = ( 0.0 );
					float2 UV422_g251702 = XZ403_g251702;
					float2 UV1422_g251702 = float2( 0,0 );
					float2 UV2422_g251702 = float2( 0,0 );
					float2 UV3422_g251702 = float2( 0,0 );
					float3 Weights422_g251702 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g251702 , UV1422_g251702 , UV2422_g251702 , UV3422_g251702 , Weights422_g251702 );
					float4 appendResult435_g251702 = (float4(UV1422_g251702 , UV2422_g251702));
					float4 In_MaskE431_g251702 = appendResult435_g251702;
					float localComputeStochasticCoords423_g251702 = ( 0.0 );
					float2 UV423_g251702 = XY404_g251702;
					float2 UV1423_g251702 = float2( 0,0 );
					float2 UV2423_g251702 = float2( 0,0 );
					float2 UV3423_g251702 = float2( 0,0 );
					float3 Weights423_g251702 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g251702 , UV1423_g251702 , UV2423_g251702 , UV3423_g251702 , Weights423_g251702 );
					float4 appendResult436_g251702 = (float4(UV3422_g251702 , UV1423_g251702));
					float4 In_MaskF431_g251702 = appendResult436_g251702;
					float4 appendResult437_g251702 = (float4(UV2423_g251702 , UV3423_g251702));
					float4 In_MaskG431_g251702 = appendResult437_g251702;
					float4 In_MaskH431_g251702 = float4( Weights409_g251702 , 0.0 );
					float4 In_MaskI431_g251702 = float4( Weights422_g251702 , 0.0 );
					float4 In_MaskJ431_g251702 = float4( Weights423_g251702 , 0.0 );
					half3 Model_NormalWS226_g251680 = Out_NormalWS15_g251681;
					float3 temp_output_449_0_g251702 = Model_NormalWS226_g251680;
					float4 In_MaskK431_g251702 = float4( temp_output_449_0_g251702 , 0.0 );
					half3 Model_TangentWS366_g251680 = Out_TangentWS15_g251681;
					float3 temp_output_450_0_g251702 = Model_TangentWS366_g251680;
					float4 In_MaskL431_g251702 = float4( temp_output_450_0_g251702 , 0.0 );
					half3 Model_BitangentWS367_g251680 = Out_BitangentWS15_g251681;
					float3 temp_output_451_0_g251702 = Model_BitangentWS367_g251680;
					float4 In_MaskM431_g251702 = float4( temp_output_451_0_g251702 , 0.0 );
					half3 Model_TriplanarWeights368_g251680 = Out_TriplanarWeights15_g251681;
					float3 temp_output_445_0_g251702 = Model_TriplanarWeights368_g251680;
					float4 In_MaskN431_g251702 = float4( temp_output_445_0_g251702 , 0.0 );
					BuildTextureData( Data431_g251702 , In_MaskA431_g251702 , In_MaskB431_g251702 , In_MaskC431_g251702 , In_MaskD431_g251702 , In_MaskE431_g251702 , In_MaskF431_g251702 , In_MaskG431_g251702 , In_MaskH431_g251702 , In_MaskI431_g251702 , In_MaskJ431_g251702 , In_MaskK431_g251702 , In_MaskL431_g251702 , In_MaskM431_g251702 , In_MaskN431_g251702 );
					TVEMasksData Data456_g251703 =(TVEMasksData)Data431_g251702;
					float4 Out_MaskA456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251703 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251703 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251703 , Out_MaskA456_g251703 , Out_MaskB456_g251703 , Out_MaskC456_g251703 , Out_MaskD456_g251703 , Out_MaskE456_g251703 , Out_MaskF456_g251703 , Out_MaskG456_g251703 , Out_MaskH456_g251703 , Out_MaskI456_g251703 , Out_MaskJ456_g251703 , Out_MaskK456_g251703 , Out_MaskL456_g251703 , Out_MaskM456_g251703 , Out_MaskN456_g251703 );
					half2 UV276_g251703 = (Out_MaskA456_g251703).xy;
					float temp_output_504_0_g251703 = 0.0;
					half Bias276_g251703 = temp_output_504_0_g251703;
					half2 Normal276_g251703 = float2( 0,0 );
					half4 localSampleCoord276_g251703 = SampleCoord( Texture276_g251703 , Sampler276_g251703 , UV276_g251703 , Bias276_g251703 , Normal276_g251703 );
					float4 temp_output_407_277_g251680 = localSampleCoord276_g251703;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251703) = _MainAlbedoTex;
					SamplerState Sampler502_g251703 = staticSwitch36_g251685;
					half2 UV502_g251703 = (Out_MaskA456_g251703).zw;
					half Bias502_g251703 = temp_output_504_0_g251703;
					half2 Normal502_g251703 = float2( 0,0 );
					half4 localSampleCoord502_g251703 = SampleCoord( Texture502_g251703 , Sampler502_g251703 , UV502_g251703 , Bias502_g251703 , Normal502_g251703 );
					float4 temp_output_407_278_g251680 = localSampleCoord502_g251703;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251703) = _MainAlbedoTex;
					SamplerState Sampler496_g251703 = staticSwitch36_g251685;
					float2 temp_output_463_0_g251703 = (Out_MaskB456_g251703).zw;
					half2 XZ496_g251703 = temp_output_463_0_g251703;
					half Bias496_g251703 = temp_output_504_0_g251703;
					half3 NormalWS512_g251703 = (Out_MaskK456_g251703).xyz;
					half3 NormalWS496_g251703 = NormalWS512_g251703;
					half3 Normal496_g251703 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251703 = SamplePlanar2D( Texture496_g251703 , Sampler496_g251703 , XZ496_g251703 , Bias496_g251703 , NormalWS496_g251703 , Normal496_g251703 );
					float4 temp_output_407_0_g251680 = localSamplePlanar2D496_g251703;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251703) = _MainAlbedoTex;
					SamplerState Sampler490_g251703 = staticSwitch36_g251685;
					float2 temp_output_462_0_g251703 = (Out_MaskB456_g251703).xy;
					half2 ZY490_g251703 = temp_output_462_0_g251703;
					half2 XZ490_g251703 = temp_output_463_0_g251703;
					float2 temp_output_464_0_g251703 = (Out_MaskC456_g251703).xy;
					half2 XY490_g251703 = temp_output_464_0_g251703;
					half Bias490_g251703 = temp_output_504_0_g251703;
					half3 Triplanar522_g251703 = (Out_MaskN456_g251703).xyz;
					half3 Triplanar490_g251703 = Triplanar522_g251703;
					half3 NormalWS490_g251703 = NormalWS512_g251703;
					half3 Normal490_g251703 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251703 = SamplePlanar3D( Texture490_g251703 , Sampler490_g251703 , ZY490_g251703 , XZ490_g251703 , XY490_g251703 , Bias490_g251703 , Triplanar490_g251703 , NormalWS490_g251703 , Normal490_g251703 );
					float4 temp_output_407_201_g251680 = localSamplePlanar3D490_g251703;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251703) = _MainAlbedoTex;
					SamplerState Sampler498_g251703 = staticSwitch36_g251685;
					half2 XZ498_g251703 = temp_output_463_0_g251703;
					float2 temp_output_473_0_g251703 = (Out_MaskE456_g251703).xy;
					half2 XZ_1498_g251703 = temp_output_473_0_g251703;
					float2 temp_output_474_0_g251703 = (Out_MaskE456_g251703).zw;
					half2 XZ_2498_g251703 = temp_output_474_0_g251703;
					float2 temp_output_475_0_g251703 = (Out_MaskF456_g251703).xy;
					half2 XZ_3498_g251703 = temp_output_475_0_g251703;
					float temp_output_510_0_g251703 = exp2( temp_output_504_0_g251703 );
					half Bias498_g251703 = temp_output_510_0_g251703;
					float3 temp_output_480_0_g251703 = (Out_MaskI456_g251703).xyz;
					half3 Weights_2498_g251703 = temp_output_480_0_g251703;
					half3 NormalWS498_g251703 = NormalWS512_g251703;
					half3 Normal498_g251703 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251703 = SampleStochastic2D( Texture498_g251703 , Sampler498_g251703 , XZ498_g251703 , XZ_1498_g251703 , XZ_2498_g251703 , XZ_3498_g251703 , Bias498_g251703 , Weights_2498_g251703 , NormalWS498_g251703 , Normal498_g251703 );
					float4 temp_output_407_202_g251680 = localSampleStochastic2D498_g251703;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251703) = _MainAlbedoTex;
					SamplerState Sampler500_g251703 = staticSwitch36_g251685;
					half2 ZY500_g251703 = temp_output_462_0_g251703;
					half2 ZY_1500_g251703 = (Out_MaskC456_g251703).zw;
					half2 ZY_2500_g251703 = (Out_MaskD456_g251703).xy;
					half2 ZY_3500_g251703 = (Out_MaskD456_g251703).zw;
					half2 XZ500_g251703 = temp_output_463_0_g251703;
					half2 XZ_1500_g251703 = temp_output_473_0_g251703;
					half2 XZ_2500_g251703 = temp_output_474_0_g251703;
					half2 XZ_3500_g251703 = temp_output_475_0_g251703;
					half2 XY500_g251703 = temp_output_464_0_g251703;
					half2 XY_1500_g251703 = (Out_MaskF456_g251703).zw;
					half2 XY_2500_g251703 = (Out_MaskG456_g251703).xy;
					half2 XY_3500_g251703 = (Out_MaskG456_g251703).zw;
					half Bias500_g251703 = temp_output_510_0_g251703;
					half3 Weights_1500_g251703 = (Out_MaskH456_g251703).xyz;
					half3 Weights_2500_g251703 = temp_output_480_0_g251703;
					half3 Weights_3500_g251703 = (Out_MaskJ456_g251703).xyz;
					half3 Triplanar500_g251703 = Triplanar522_g251703;
					half3 NormalWS500_g251703 = NormalWS512_g251703;
					half3 Normal500_g251703 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251703 = SampleStochastic3D( Texture500_g251703 , Sampler500_g251703 , ZY500_g251703 , ZY_1500_g251703 , ZY_2500_g251703 , ZY_3500_g251703 , XZ500_g251703 , XZ_1500_g251703 , XZ_2500_g251703 , XZ_3500_g251703 , XY500_g251703 , XY_1500_g251703 , XY_2500_g251703 , XY_3500_g251703 , Bias500_g251703 , Weights_1500_g251703 , Weights_2500_g251703 , Weights_3500_g251703 , Triplanar500_g251703 , NormalWS500_g251703 , Normal500_g251703 );
					float4 temp_output_407_203_g251680 = localSampleStochastic3D500_g251703;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g251680 = temp_output_407_277_g251680;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g251680 = temp_output_407_278_g251680;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g251680 = temp_output_407_0_g251680;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g251680 = temp_output_407_201_g251680;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g251680 = temp_output_407_202_g251680;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g251680 = temp_output_407_203_g251680;
					#else
					float4 staticSwitch184_g251680 = temp_output_407_277_g251680;
					#endif
					half4 Local_AlbedoSample185_g251680 = staticSwitch184_g251680;
					float3 lerpResult53_g251680 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g251680).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g251680 = lerpResult53_g251680;
					float temp_output_17_0_g251700 = _MainMultiWriteMode;
					float Option91_g251700 = temp_output_17_0_g251700;
					float4 Model_VertexData418_g251680 = Out_VertexData15_g251681;
					float4 temp_output_84_0_g251700 = Model_VertexData418_g251680;
					float4 ChannelA91_g251700 = temp_output_84_0_g251700;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251688) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g251687 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g251687 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g251687 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g251687 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g251687 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g251687 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251688 = staticSwitch38_g251687;
					float localBreakTextureData456_g251688 = ( 0.0 );
					TVEMasksData Data456_g251688 =(TVEMasksData)Data431_g251702;
					float4 Out_MaskA456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251688 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251688 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251688 , Out_MaskA456_g251688 , Out_MaskB456_g251688 , Out_MaskC456_g251688 , Out_MaskD456_g251688 , Out_MaskE456_g251688 , Out_MaskF456_g251688 , Out_MaskG456_g251688 , Out_MaskH456_g251688 , Out_MaskI456_g251688 , Out_MaskJ456_g251688 , Out_MaskK456_g251688 , Out_MaskL456_g251688 , Out_MaskM456_g251688 , Out_MaskN456_g251688 );
					half2 UV276_g251688 = (Out_MaskA456_g251688).xy;
					float temp_output_504_0_g251688 = 0.0;
					half Bias276_g251688 = temp_output_504_0_g251688;
					half2 Normal276_g251688 = float2( 0,0 );
					half4 localSampleCoord276_g251688 = SampleCoord( Texture276_g251688 , Sampler276_g251688 , UV276_g251688 , Bias276_g251688 , Normal276_g251688 );
					float4 temp_output_405_277_g251680 = localSampleCoord276_g251688;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251688) = _MainShaderTex;
					SamplerState Sampler502_g251688 = staticSwitch38_g251687;
					half2 UV502_g251688 = (Out_MaskA456_g251688).zw;
					half Bias502_g251688 = temp_output_504_0_g251688;
					half2 Normal502_g251688 = float2( 0,0 );
					half4 localSampleCoord502_g251688 = SampleCoord( Texture502_g251688 , Sampler502_g251688 , UV502_g251688 , Bias502_g251688 , Normal502_g251688 );
					float4 temp_output_405_278_g251680 = localSampleCoord502_g251688;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251688) = _MainShaderTex;
					SamplerState Sampler496_g251688 = staticSwitch38_g251687;
					float2 temp_output_463_0_g251688 = (Out_MaskB456_g251688).zw;
					half2 XZ496_g251688 = temp_output_463_0_g251688;
					half Bias496_g251688 = temp_output_504_0_g251688;
					half3 NormalWS512_g251688 = (Out_MaskK456_g251688).xyz;
					half3 NormalWS496_g251688 = NormalWS512_g251688;
					half3 Normal496_g251688 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251688 = SamplePlanar2D( Texture496_g251688 , Sampler496_g251688 , XZ496_g251688 , Bias496_g251688 , NormalWS496_g251688 , Normal496_g251688 );
					float4 temp_output_405_0_g251680 = localSamplePlanar2D496_g251688;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251688) = _MainShaderTex;
					SamplerState Sampler490_g251688 = staticSwitch38_g251687;
					float2 temp_output_462_0_g251688 = (Out_MaskB456_g251688).xy;
					half2 ZY490_g251688 = temp_output_462_0_g251688;
					half2 XZ490_g251688 = temp_output_463_0_g251688;
					float2 temp_output_464_0_g251688 = (Out_MaskC456_g251688).xy;
					half2 XY490_g251688 = temp_output_464_0_g251688;
					half Bias490_g251688 = temp_output_504_0_g251688;
					half3 Triplanar522_g251688 = (Out_MaskN456_g251688).xyz;
					half3 Triplanar490_g251688 = Triplanar522_g251688;
					half3 NormalWS490_g251688 = NormalWS512_g251688;
					half3 Normal490_g251688 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251688 = SamplePlanar3D( Texture490_g251688 , Sampler490_g251688 , ZY490_g251688 , XZ490_g251688 , XY490_g251688 , Bias490_g251688 , Triplanar490_g251688 , NormalWS490_g251688 , Normal490_g251688 );
					float4 temp_output_405_201_g251680 = localSamplePlanar3D490_g251688;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251688) = _MainShaderTex;
					SamplerState Sampler498_g251688 = staticSwitch38_g251687;
					half2 XZ498_g251688 = temp_output_463_0_g251688;
					float2 temp_output_473_0_g251688 = (Out_MaskE456_g251688).xy;
					half2 XZ_1498_g251688 = temp_output_473_0_g251688;
					float2 temp_output_474_0_g251688 = (Out_MaskE456_g251688).zw;
					half2 XZ_2498_g251688 = temp_output_474_0_g251688;
					float2 temp_output_475_0_g251688 = (Out_MaskF456_g251688).xy;
					half2 XZ_3498_g251688 = temp_output_475_0_g251688;
					float temp_output_510_0_g251688 = exp2( temp_output_504_0_g251688 );
					half Bias498_g251688 = temp_output_510_0_g251688;
					float3 temp_output_480_0_g251688 = (Out_MaskI456_g251688).xyz;
					half3 Weights_2498_g251688 = temp_output_480_0_g251688;
					half3 NormalWS498_g251688 = NormalWS512_g251688;
					half3 Normal498_g251688 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251688 = SampleStochastic2D( Texture498_g251688 , Sampler498_g251688 , XZ498_g251688 , XZ_1498_g251688 , XZ_2498_g251688 , XZ_3498_g251688 , Bias498_g251688 , Weights_2498_g251688 , NormalWS498_g251688 , Normal498_g251688 );
					float4 temp_output_405_202_g251680 = localSampleStochastic2D498_g251688;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251688) = _MainShaderTex;
					SamplerState Sampler500_g251688 = staticSwitch38_g251687;
					half2 ZY500_g251688 = temp_output_462_0_g251688;
					half2 ZY_1500_g251688 = (Out_MaskC456_g251688).zw;
					half2 ZY_2500_g251688 = (Out_MaskD456_g251688).xy;
					half2 ZY_3500_g251688 = (Out_MaskD456_g251688).zw;
					half2 XZ500_g251688 = temp_output_463_0_g251688;
					half2 XZ_1500_g251688 = temp_output_473_0_g251688;
					half2 XZ_2500_g251688 = temp_output_474_0_g251688;
					half2 XZ_3500_g251688 = temp_output_475_0_g251688;
					half2 XY500_g251688 = temp_output_464_0_g251688;
					half2 XY_1500_g251688 = (Out_MaskF456_g251688).zw;
					half2 XY_2500_g251688 = (Out_MaskG456_g251688).xy;
					half2 XY_3500_g251688 = (Out_MaskG456_g251688).zw;
					half Bias500_g251688 = temp_output_510_0_g251688;
					half3 Weights_1500_g251688 = (Out_MaskH456_g251688).xyz;
					half3 Weights_2500_g251688 = temp_output_480_0_g251688;
					half3 Weights_3500_g251688 = (Out_MaskJ456_g251688).xyz;
					half3 Triplanar500_g251688 = Triplanar522_g251688;
					half3 NormalWS500_g251688 = NormalWS512_g251688;
					half3 Normal500_g251688 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251688 = SampleStochastic3D( Texture500_g251688 , Sampler500_g251688 , ZY500_g251688 , ZY_1500_g251688 , ZY_2500_g251688 , ZY_3500_g251688 , XZ500_g251688 , XZ_1500_g251688 , XZ_2500_g251688 , XZ_3500_g251688 , XY500_g251688 , XY_1500_g251688 , XY_2500_g251688 , XY_3500_g251688 , Bias500_g251688 , Weights_1500_g251688 , Weights_2500_g251688 , Weights_3500_g251688 , Triplanar500_g251688 , NormalWS500_g251688 , Normal500_g251688 );
					float4 temp_output_405_203_g251680 = localSampleStochastic3D500_g251688;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g251680 = temp_output_405_277_g251680;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g251680 = temp_output_405_278_g251680;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g251680 = temp_output_405_0_g251680;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g251680 = temp_output_405_201_g251680;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g251680 = temp_output_405_202_g251680;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g251680 = temp_output_405_203_g251680;
					#else
					float4 staticSwitch198_g251680 = temp_output_405_277_g251680;
					#endif
					half4 Local_ShaderSample199_g251680 = staticSwitch198_g251680;
					float2 appendResult428_g251680 = (float2((Local_AlbedoSample185_g251680).w , (Local_ShaderSample199_g251680).z));
					float2 temp_output_85_0_g251700 = appendResult428_g251680;
					float4 ChannelB91_g251700 = float4( temp_output_85_0_g251700, 0.0 , 0.0 );
					float localSwitchChannel691_g251700 = SwitchChannel6( Option91_g251700 , ChannelA91_g251700 , ChannelB91_g251700 );
					float clampResult17_g251698 = clamp( localSwitchChannel691_g251700 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251699 = _MainMultiWriteRemap.x;
					float temp_output_9_0_g251699 = ( clampResult17_g251698 - temp_output_7_0_g251699 );
					half Local_MultiMask78_g251680 = saturate( ( temp_output_9_0_g251699 * _MainMultiWriteRemap.z ) );
					float lerpResult58_g251680 = lerp( 1.0 , Local_MultiMask78_g251680 , _MainColorMode);
					float4 lerpResult62_g251680 = lerp( _MainColorTwo , _MainColor , lerpResult58_g251680);
					half3 Local_ColorRGB93_g251680 = (lerpResult62_g251680).rgb;
					half3 Local_Albedo139_g251680 = ( Local_AlbedoRGB107_g251680 * Local_ColorRGB93_g251680 );
					float3 temp_output_4_0_g251682 = Local_Albedo139_g251680;
					float3 In_Albedo3_g251682 = temp_output_4_0_g251682;
					float3 temp_output_44_0_g251682 = Local_Albedo139_g251680;
					float3 In_AlbedoBase3_g251682 = temp_output_44_0_g251682;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251709) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g251686 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g251686 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g251686 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g251686 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g251686 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g251686 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251709 = staticSwitch37_g251686;
					float localBreakTextureData456_g251709 = ( 0.0 );
					TVEMasksData Data456_g251709 =(TVEMasksData)Data431_g251702;
					float4 Out_MaskA456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251709 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251709 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251709 , Out_MaskA456_g251709 , Out_MaskB456_g251709 , Out_MaskC456_g251709 , Out_MaskD456_g251709 , Out_MaskE456_g251709 , Out_MaskF456_g251709 , Out_MaskG456_g251709 , Out_MaskH456_g251709 , Out_MaskI456_g251709 , Out_MaskJ456_g251709 , Out_MaskK456_g251709 , Out_MaskL456_g251709 , Out_MaskM456_g251709 , Out_MaskN456_g251709 );
					half2 UV276_g251709 = (Out_MaskA456_g251709).xy;
					float temp_output_504_0_g251709 = 0.0;
					half Bias276_g251709 = temp_output_504_0_g251709;
					half2 Normal276_g251709 = float2( 0,0 );
					half4 localSampleCoord276_g251709 = SampleCoord( Texture276_g251709 , Sampler276_g251709 , UV276_g251709 , Bias276_g251709 , Normal276_g251709 );
					float2 temp_output_406_394_g251680 = Normal276_g251709;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251709) = _MainNormalTex;
					SamplerState Sampler502_g251709 = staticSwitch37_g251686;
					half2 UV502_g251709 = (Out_MaskA456_g251709).zw;
					half Bias502_g251709 = temp_output_504_0_g251709;
					half2 Normal502_g251709 = float2( 0,0 );
					half4 localSampleCoord502_g251709 = SampleCoord( Texture502_g251709 , Sampler502_g251709 , UV502_g251709 , Bias502_g251709 , Normal502_g251709 );
					float2 temp_output_406_397_g251680 = Normal502_g251709;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251709) = _MainNormalTex;
					SamplerState Sampler496_g251709 = staticSwitch37_g251686;
					float2 temp_output_463_0_g251709 = (Out_MaskB456_g251709).zw;
					half2 XZ496_g251709 = temp_output_463_0_g251709;
					half Bias496_g251709 = temp_output_504_0_g251709;
					half3 NormalWS512_g251709 = (Out_MaskK456_g251709).xyz;
					half3 NormalWS496_g251709 = NormalWS512_g251709;
					half3 Normal496_g251709 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251709 = SamplePlanar2D( Texture496_g251709 , Sampler496_g251709 , XZ496_g251709 , Bias496_g251709 , NormalWS496_g251709 , Normal496_g251709 );
					float3 temp_output_35_0_g251712 = Normal496_g251709;
					half3 TangentWS519_g251709 = (Out_MaskL456_g251709).xyz;
					float dotResult84_g251712 = dot( temp_output_35_0_g251712 , TangentWS519_g251709 );
					half3 BitangentWS521_g251709 = (Out_MaskM456_g251709).xyz;
					float dotResult85_g251712 = dot( temp_output_35_0_g251712 , BitangentWS521_g251709 );
					float2 appendResult87_g251712 = (float2(dotResult84_g251712 , dotResult85_g251712));
					float2 temp_output_406_375_g251680 = appendResult87_g251712;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251709) = _MainNormalTex;
					SamplerState Sampler490_g251709 = staticSwitch37_g251686;
					float2 temp_output_462_0_g251709 = (Out_MaskB456_g251709).xy;
					half2 ZY490_g251709 = temp_output_462_0_g251709;
					half2 XZ490_g251709 = temp_output_463_0_g251709;
					float2 temp_output_464_0_g251709 = (Out_MaskC456_g251709).xy;
					half2 XY490_g251709 = temp_output_464_0_g251709;
					half Bias490_g251709 = temp_output_504_0_g251709;
					half3 Triplanar522_g251709 = (Out_MaskN456_g251709).xyz;
					half3 Triplanar490_g251709 = Triplanar522_g251709;
					half3 NormalWS490_g251709 = NormalWS512_g251709;
					half3 Normal490_g251709 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251709 = SamplePlanar3D( Texture490_g251709 , Sampler490_g251709 , ZY490_g251709 , XZ490_g251709 , XY490_g251709 , Bias490_g251709 , Triplanar490_g251709 , NormalWS490_g251709 , Normal490_g251709 );
					float3 temp_output_35_0_g251713 = Normal490_g251709;
					float dotResult84_g251713 = dot( temp_output_35_0_g251713 , TangentWS519_g251709 );
					float dotResult85_g251713 = dot( temp_output_35_0_g251713 , BitangentWS521_g251709 );
					float2 appendResult87_g251713 = (float2(dotResult84_g251713 , dotResult85_g251713));
					float2 temp_output_406_353_g251680 = appendResult87_g251713;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251709) = _MainNormalTex;
					SamplerState Sampler498_g251709 = staticSwitch37_g251686;
					half2 XZ498_g251709 = temp_output_463_0_g251709;
					float2 temp_output_473_0_g251709 = (Out_MaskE456_g251709).xy;
					half2 XZ_1498_g251709 = temp_output_473_0_g251709;
					float2 temp_output_474_0_g251709 = (Out_MaskE456_g251709).zw;
					half2 XZ_2498_g251709 = temp_output_474_0_g251709;
					float2 temp_output_475_0_g251709 = (Out_MaskF456_g251709).xy;
					half2 XZ_3498_g251709 = temp_output_475_0_g251709;
					float temp_output_510_0_g251709 = exp2( temp_output_504_0_g251709 );
					half Bias498_g251709 = temp_output_510_0_g251709;
					float3 temp_output_480_0_g251709 = (Out_MaskI456_g251709).xyz;
					half3 Weights_2498_g251709 = temp_output_480_0_g251709;
					half3 NormalWS498_g251709 = NormalWS512_g251709;
					half3 Normal498_g251709 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251709 = SampleStochastic2D( Texture498_g251709 , Sampler498_g251709 , XZ498_g251709 , XZ_1498_g251709 , XZ_2498_g251709 , XZ_3498_g251709 , Bias498_g251709 , Weights_2498_g251709 , NormalWS498_g251709 , Normal498_g251709 );
					float3 temp_output_35_0_g251714 = Normal498_g251709;
					float dotResult84_g251714 = dot( temp_output_35_0_g251714 , TangentWS519_g251709 );
					float dotResult85_g251714 = dot( temp_output_35_0_g251714 , BitangentWS521_g251709 );
					float2 appendResult87_g251714 = (float2(dotResult84_g251714 , dotResult85_g251714));
					float2 temp_output_406_391_g251680 = appendResult87_g251714;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251709) = _MainNormalTex;
					SamplerState Sampler500_g251709 = staticSwitch37_g251686;
					half2 ZY500_g251709 = temp_output_462_0_g251709;
					half2 ZY_1500_g251709 = (Out_MaskC456_g251709).zw;
					half2 ZY_2500_g251709 = (Out_MaskD456_g251709).xy;
					half2 ZY_3500_g251709 = (Out_MaskD456_g251709).zw;
					half2 XZ500_g251709 = temp_output_463_0_g251709;
					half2 XZ_1500_g251709 = temp_output_473_0_g251709;
					half2 XZ_2500_g251709 = temp_output_474_0_g251709;
					half2 XZ_3500_g251709 = temp_output_475_0_g251709;
					half2 XY500_g251709 = temp_output_464_0_g251709;
					half2 XY_1500_g251709 = (Out_MaskF456_g251709).zw;
					half2 XY_2500_g251709 = (Out_MaskG456_g251709).xy;
					half2 XY_3500_g251709 = (Out_MaskG456_g251709).zw;
					half Bias500_g251709 = temp_output_510_0_g251709;
					half3 Weights_1500_g251709 = (Out_MaskH456_g251709).xyz;
					half3 Weights_2500_g251709 = temp_output_480_0_g251709;
					half3 Weights_3500_g251709 = (Out_MaskJ456_g251709).xyz;
					half3 Triplanar500_g251709 = Triplanar522_g251709;
					half3 NormalWS500_g251709 = NormalWS512_g251709;
					half3 Normal500_g251709 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251709 = SampleStochastic3D( Texture500_g251709 , Sampler500_g251709 , ZY500_g251709 , ZY_1500_g251709 , ZY_2500_g251709 , ZY_3500_g251709 , XZ500_g251709 , XZ_1500_g251709 , XZ_2500_g251709 , XZ_3500_g251709 , XY500_g251709 , XY_1500_g251709 , XY_2500_g251709 , XY_3500_g251709 , Bias500_g251709 , Weights_1500_g251709 , Weights_2500_g251709 , Weights_3500_g251709 , Triplanar500_g251709 , NormalWS500_g251709 , Normal500_g251709 );
					float3 temp_output_35_0_g251710 = Normal500_g251709;
					float dotResult84_g251710 = dot( temp_output_35_0_g251710 , TangentWS519_g251709 );
					float dotResult85_g251710 = dot( temp_output_35_0_g251710 , BitangentWS521_g251709 );
					float2 appendResult87_g251710 = (float2(dotResult84_g251710 , dotResult85_g251710));
					float2 temp_output_406_390_g251680 = appendResult87_g251710;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g251680 = temp_output_406_394_g251680;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g251680 = temp_output_406_397_g251680;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g251680 = temp_output_406_375_g251680;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g251680 = temp_output_406_353_g251680;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g251680 = temp_output_406_391_g251680;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g251680 = temp_output_406_390_g251680;
					#else
					float2 staticSwitch193_g251680 = temp_output_406_394_g251680;
					#endif
					half2 Local_NormaSample191_g251680 = staticSwitch193_g251680;
					half2 Local_NormalTS108_g251680 = ( Local_NormaSample191_g251680 * _MainNormalValue );
					float2 In_NormalTS3_g251682 = Local_NormalTS108_g251680;
					float2 break80_g251701 = Local_NormalTS108_g251680;
					float3 temp_output_77_0_g251701 = Model_TangentWS366_g251680;
					float3 temp_output_78_0_g251701 = Model_BitangentWS367_g251680;
					float3 temp_output_76_0_g251701 = Model_NormalWS226_g251680;
					half3 Local_NormalWS250_g251680 = ( ( break80_g251701.x * temp_output_77_0_g251701 ) + ( break80_g251701.y * temp_output_78_0_g251701 ) + temp_output_76_0_g251701 );
					float3 In_NormalWS3_g251682 = Local_NormalWS250_g251680;
					float temp_output_209_0_g251680 = (Local_ShaderSample199_g251680).y;
					float temp_output_7_0_g251694 = _MainOcclusionRemap.x;
					float temp_output_9_0_g251694 = ( temp_output_209_0_g251680 - temp_output_7_0_g251694 );
					float lerpResult23_g251680 = lerp( 1.0 , saturate( ( temp_output_9_0_g251694 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g251680 = lerpResult23_g251680;
					float temp_output_213_0_g251680 = (Local_ShaderSample199_g251680).w;
					float temp_output_7_0_g251697 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g251697 = ( temp_output_213_0_g251680 - temp_output_7_0_g251697 );
					half Local_Smoothness317_g251680 = ( saturate( ( temp_output_9_0_g251697 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g251680 = (float4(( (Local_ShaderSample199_g251680).x * _MainMetallicValue ) , Local_Occlusion313_g251680 , (Local_ShaderSample199_g251680).z , Local_Smoothness317_g251680));
					half4 Local_Masks109_g251680 = appendResult73_g251680;
					float4 In_Shader3_g251682 = Local_Masks109_g251680;
					float4 In_Feature3_g251682 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251682 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251682 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g251715 = Local_Albedo139_g251680;
					float dotResult20_g251715 = dot( temp_output_3_0_g251715 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g251680 = dotResult20_g251715;
					float temp_output_12_0_g251682 = Local_Grayscale110_g251680;
					float In_Grayscale3_g251682 = temp_output_12_0_g251682;
					float temp_output_3_0_g251716 = Local_Grayscale110_g251680;
					float clampResult27_g251716 = clamp( saturate( ( temp_output_3_0_g251716 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g251680 = clampResult27_g251716;
					float temp_output_16_0_g251682 = Local_Luminosity145_g251680;
					float In_Luminosity3_g251682 = temp_output_16_0_g251682;
					float In_MultiMask3_g251682 = Local_MultiMask78_g251680;
					float temp_output_187_0_g251680 = (Local_AlbedoSample185_g251680).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g251680 = ( temp_output_187_0_g251680 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g251680 = temp_output_187_0_g251680;
					#endif
					half Local_AlphaClip111_g251680 = staticSwitch236_g251680;
					float In_AlphaClip3_g251682 = Local_AlphaClip111_g251680;
					half Local_AlphaFade246_g251680 = (lerpResult62_g251680).a;
					float In_AlphaFade3_g251682 = Local_AlphaFade246_g251680;
					float3 temp_cast_25 = (1.0).xxx;
					float3 In_Translucency3_g251682 = temp_cast_25;
					float In_Transmission3_g251682 = 1.0;
					float In_Thickness3_g251682 = 0.0;
					float In_Diffusion3_g251682 = 0.0;
					float In_Depth3_g251682 = 0.0;
					BuildVisualData( Data3_g251682 , In_Dummy3_g251682 , In_Albedo3_g251682 , In_AlbedoBase3_g251682 , In_NormalTS3_g251682 , In_NormalWS3_g251682 , In_Shader3_g251682 , In_Feature3_g251682 , In_Season3_g251682 , In_Emissive3_g251682 , In_Grayscale3_g251682 , In_Luminosity3_g251682 , In_MultiMask3_g251682 , In_AlphaClip3_g251682 , In_AlphaFade3_g251682 , In_Translucency3_g251682 , In_Transmission3_g251682 , In_Thickness3_g251682 , In_Diffusion3_g251682 , In_Depth3_g251682 );
					TVEVisualData Data4_g251725 =(TVEVisualData)Data3_g251682;
					float Out_Dummy4_g251725 = 0.0;
					float3 Out_Albedo4_g251725 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g251725 = float3( 0,0,0 );
					float2 Out_NormalTS4_g251725 = float2( 0,0 );
					float3 Out_NormalWS4_g251725 = float3( 0,0,0 );
					float4 Out_Shader4_g251725 = float4( 0,0,0,0 );
					float4 Out_Feature4_g251725 = float4( 0,0,0,0 );
					float4 Out_Season4_g251725 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g251725 = float4( 0,0,0,0 );
					float Out_MultiMask4_g251725 = 0.0;
					float Out_Grayscale4_g251725 = 0.0;
					float Out_Luminosity4_g251725 = 0.0;
					float Out_AlphaClip4_g251725 = 0.0;
					float Out_AlphaFade4_g251725 = 0.0;
					float3 Out_Translucency4_g251725 = float3( 0,0,0 );
					float Out_Transmission4_g251725 = 0.0;
					float Out_Thickness4_g251725 = 0.0;
					float Out_Diffusion4_g251725 = 0.0;
					float Out_Depth4_g251725 = 0.0;
					BreakVisualData( Data4_g251725 , Out_Dummy4_g251725 , Out_Albedo4_g251725 , Out_AlbedoBase4_g251725 , Out_NormalTS4_g251725 , Out_NormalWS4_g251725 , Out_Shader4_g251725 , Out_Feature4_g251725 , Out_Season4_g251725 , Out_Emissive4_g251725 , Out_MultiMask4_g251725 , Out_Grayscale4_g251725 , Out_Luminosity4_g251725 , Out_AlphaClip4_g251725 , Out_AlphaFade4_g251725 , Out_Translucency4_g251725 , Out_Transmission4_g251725 , Out_Thickness4_g251725 , Out_Diffusion4_g251725 , Out_Depth4_g251725 );
					float Alpha109_g251720 = Out_AlphaClip4_g251725;
					float lerpResult91_g251720 = lerp( 1.0 , Alpha109_g251720 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g251720 = lerp( 1.0 , lerpResult91_g251720 , Filter152_g251720);
					clip( lerpResult154_g251720 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = temp_cast_1;
					half Metallic = 0;
					half Smoothness = temp_output_2609_114;
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

					o.Emission = ( lerpResult72_g251720 * lerpResult84_g251720 );
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

					TVEVertexData Data16_g251557 =(TVEVertexData)0;
					float In_Dummy16_g251557 = 0.0;
					TVEVertexData Data16_g251552 =(TVEVertexData)0;
					float In_Dummy16_g251552 = 0.0;
					float localIfModelDataByShader26_g242551 = ( 0.0 );
					TVEModelData Data26_g242551 = (TVEModelData)0;
					TVEModelData Data16_g242447 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g242429 = _ObjectCoordMode;
					#else
					float staticSwitch343_g242429 = _ObjectCoordMode;
					#endif
					half Dummy207_g242429 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g242429 );
					float temp_output_14_0_g242447 = Dummy207_g242429;
					float In_Dummy16_g242447 = temp_output_14_0_g242447;
					float3 PositionOS131_g242429 = v.vertex.xyz;
					float3 temp_output_4_0_g242447 = PositionOS131_g242429;
					float3 In_PositionOS16_g242447 = temp_output_4_0_g242447;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g242429 = ase_positionWS;
					float3 vertexToFrag73_g242429 = temp_output_104_7_g242429;
					float3 PositionWS122_g242429 = vertexToFrag73_g242429;
					float3 In_PositionWS16_g242447 = PositionWS122_g242429;
					float4x4 break19_g242432 = unity_ObjectToWorld;
					float3 appendResult20_g242432 = (float3(break19_g242432[ 0 ][ 3 ] , break19_g242432[ 1 ][ 3 ] , break19_g242432[ 2 ][ 3 ]));
					float3 temp_output_340_7_g242429 = appendResult20_g242432;
					float4x4 break19_g242434 = unity_ObjectToWorld;
					float3 appendResult20_g242434 = (float3(break19_g242434[ 0 ][ 3 ] , break19_g242434[ 1 ][ 3 ] , break19_g242434[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g242430 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g242429 = PositionOS131_g242429;
					float3 appendResult234_g242429 = (float3(break233_g242429.x , 0.0 , break233_g242429.z));
					float3 break413_g242429 = PositionOS131_g242429;
					float3 appendResult414_g242429 = (float3(break413_g242429.x , break413_g242429.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g242436 = appendResult414_g242429;
					#else
					float3 staticSwitch65_g242436 = appendResult234_g242429;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g242429 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g242429 = appendResult60_g242430;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g242429 = staticSwitch65_g242436;
					#else
					float3 staticSwitch229_g242429 = _Vector0;
					#endif
					float3 PivotOS149_g242429 = staticSwitch229_g242429;
					float3 temp_output_122_0_g242434 = PivotOS149_g242429;
					float3 PivotsOnlyWS105_g242434 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g242434 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g242429 = ( appendResult20_g242434 + PivotsOnlyWS105_g242434 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g242429 = temp_output_340_7_g242429;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g242429 = temp_output_341_7_g242429;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g242429 = temp_output_341_7_g242429;
					#else
					float3 staticSwitch236_g242429 = temp_output_340_7_g242429;
					#endif
					float3 vertexToFrag76_g242429 = staticSwitch236_g242429;
					float3 PivotWS121_g242429 = vertexToFrag76_g242429;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242429 = ( PositionWS122_g242429 - PivotWS121_g242429 );
					#else
					float3 staticSwitch204_g242429 = PositionWS122_g242429;
					#endif
					float3 PositionWO132_g242429 = ( staticSwitch204_g242429 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242447 = PositionWO132_g242429;
					float3 In_PivotOS16_g242447 = PivotOS149_g242429;
					float3 In_PivotWS16_g242447 = PivotWS121_g242429;
					float3 PivotWO133_g242429 = ( PivotWS121_g242429 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242447 = PivotWO133_g242429;
					half3 NormalOS134_g242429 = v.normal;
					float3 temp_output_21_0_g242447 = NormalOS134_g242429;
					float3 In_NormalOS16_g242447 = temp_output_21_0_g242447;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g242429 = normalizedWorldNormal;
					float3 In_NormalWS16_g242447 = NormalWS95_g242429;
					half4 TangentlOS153_g242429 = v.tangent;
					float4 temp_output_6_0_g242447 = TangentlOS153_g242429;
					float4 In_TangentOS16_g242447 = temp_output_6_0_g242447;
					float3 normalizeResult296_g242429 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242429 ) );
					half3 ViewDirWS169_g242429 = normalizeResult296_g242429;
					float3 In_ViewDirWS16_g242447 = ViewDirWS169_g242429;
					float4 appendResult397_g242429 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g242429 = appendResult397_g242429;
					float4 In_CoordsData16_g242447 = CoordsData398_g242429;
					half4 VertexMasks171_g242429 = v.ase_color;
					float4 In_VertexData16_g242447 = VertexMasks171_g242429;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g242441 = (PositionOS131_g242429).z;
					#else
					float staticSwitch65_g242441 = (PositionOS131_g242429).y;
					#endif
					half Object_HeightValue267_g242429 = _ObjectHeightValue;
					half Bounds_HeightMask274_g242429 = saturate( ( staticSwitch65_g242441 / Object_HeightValue267_g242429 ) );
					half3 Position387_g242429 = PositionOS131_g242429;
					half Height387_g242429 = Object_HeightValue267_g242429;
					half Object_RadiusValue268_g242429 = _ObjectRadiusValue;
					half Radius387_g242429 = Object_RadiusValue268_g242429;
					half localCapsuleMaskYUp387_g242429 = CapsuleMaskYUp( Position387_g242429 , Height387_g242429 , Radius387_g242429 );
					half3 Position408_g242429 = PositionOS131_g242429;
					half Height408_g242429 = Object_HeightValue267_g242429;
					half Radius408_g242429 = Object_RadiusValue268_g242429;
					half localCapsuleMaskZUp408_g242429 = CapsuleMaskZUp( Position408_g242429 , Height408_g242429 , Radius408_g242429 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g242446 = saturate( localCapsuleMaskZUp408_g242429 );
					#else
					float staticSwitch65_g242446 = saturate( localCapsuleMaskYUp387_g242429 );
					#endif
					half Bounds_SphereMask282_g242429 = staticSwitch65_g242446;
					float4 appendResult253_g242429 = (float4(Bounds_HeightMask274_g242429 , Bounds_SphereMask282_g242429 , 1.0 , 1.0));
					half4 MasksData254_g242429 = appendResult253_g242429;
					float4 In_MasksData16_g242447 = MasksData254_g242429;
					float temp_output_17_0_g242440 = _ObjectPhaseMode;
					float Option70_g242440 = temp_output_17_0_g242440;
					float4 temp_output_3_0_g242440 = v.ase_color;
					float4 Channel70_g242440 = temp_output_3_0_g242440;
					float localSwitchChannel470_g242440 = SwitchChannel4( Option70_g242440 , Channel70_g242440 );
					half Phase_Value372_g242429 = localSwitchChannel470_g242440;
					float3 break319_g242429 = PivotWO133_g242429;
					half Pivot_Position322_g242429 = ( break319_g242429.x + break319_g242429.z );
					half Phase_Position357_g242429 = ( Phase_Value372_g242429 + Pivot_Position322_g242429 );
					float temp_output_248_0_g242429 = frac( Phase_Position357_g242429 );
					float4 appendResult177_g242429 = (float4((frac( ( Phase_Position357_g242429 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g242429));
					half4 Phase_Data176_g242429 = appendResult177_g242429;
					float4 In_PhaseData16_g242447 = Phase_Data176_g242429;
					BuildModelVertData( Data16_g242447 , In_Dummy16_g242447 , In_PositionOS16_g242447 , In_PositionWS16_g242447 , In_PositionWO16_g242447 , In_PivotOS16_g242447 , In_PivotWS16_g242447 , In_PivotWO16_g242447 , In_NormalOS16_g242447 , In_NormalWS16_g242447 , In_TangentOS16_g242447 , In_ViewDirWS16_g242447 , In_CoordsData16_g242447 , In_VertexData16_g242447 , In_MasksData16_g242447 , In_PhaseData16_g242447 );
					TVEModelData DataDefault26_g242551 = Data16_g242447;
					TVEModelData DataGeneral26_g242551 = Data16_g242447;
					TVEModelData DataBlanket26_g242551 = Data16_g242447;
					TVEModelData DataImpostor26_g242551 = Data16_g242447;
					TVEModelData Data16_g242427 =(TVEModelData)0;
					half Dummy207_g242409 = 0.0;
					float temp_output_14_0_g242427 = Dummy207_g242409;
					float In_Dummy16_g242427 = temp_output_14_0_g242427;
					float3 PositionOS131_g242409 = v.vertex.xyz;
					float3 temp_output_4_0_g242427 = PositionOS131_g242409;
					float3 In_PositionOS16_g242427 = temp_output_4_0_g242427;
					float3 temp_output_104_7_g242409 = ase_positionWS;
					float3 PositionWS122_g242409 = temp_output_104_7_g242409;
					float3 In_PositionWS16_g242427 = PositionWS122_g242409;
					float4x4 break19_g242412 = unity_ObjectToWorld;
					float3 appendResult20_g242412 = (float3(break19_g242412[ 0 ][ 3 ] , break19_g242412[ 1 ][ 3 ] , break19_g242412[ 2 ][ 3 ]));
					float3 temp_output_340_7_g242409 = appendResult20_g242412;
					float3 PivotWS121_g242409 = temp_output_340_7_g242409;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242409 = ( PositionWS122_g242409 - PivotWS121_g242409 );
					#else
					float3 staticSwitch204_g242409 = PositionWS122_g242409;
					#endif
					float3 PositionWO132_g242409 = ( staticSwitch204_g242409 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242427 = PositionWO132_g242409;
					float3 PivotOS149_g242409 = _Vector0;
					float3 In_PivotOS16_g242427 = PivotOS149_g242409;
					float3 In_PivotWS16_g242427 = PivotWS121_g242409;
					float3 PivotWO133_g242409 = ( PivotWS121_g242409 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242427 = PivotWO133_g242409;
					half3 NormalOS134_g242409 = v.normal;
					float3 temp_output_21_0_g242427 = NormalOS134_g242409;
					float3 In_NormalOS16_g242427 = temp_output_21_0_g242427;
					half3 NormalWS95_g242409 = normalizedWorldNormal;
					float3 In_NormalWS16_g242427 = NormalWS95_g242409;
					float4 appendResult462_g242409 = (float4(cross( v.normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g242409 = appendResult462_g242409;
					float4 temp_output_6_0_g242427 = TangentlOS153_g242409;
					float4 In_TangentOS16_g242427 = temp_output_6_0_g242427;
					float3 normalizeResult296_g242409 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242409 ) );
					half3 ViewDirWS169_g242409 = normalizeResult296_g242409;
					float3 In_ViewDirWS16_g242427 = ViewDirWS169_g242409;
					float4 appendResult397_g242409 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g242409 = appendResult397_g242409;
					float4 In_CoordsData16_g242427 = CoordsData398_g242409;
					half4 VertexMasks171_g242409 = float4( 0,0,0,0 );
					float4 In_VertexData16_g242427 = VertexMasks171_g242409;
					half4 MasksData254_g242409 = float4( 0,0,0,0 );
					float4 In_MasksData16_g242427 = MasksData254_g242409;
					half4 Phase_Data176_g242409 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g242427 = Phase_Data176_g242409;
					BuildModelVertData( Data16_g242427 , In_Dummy16_g242427 , In_PositionOS16_g242427 , In_PositionWS16_g242427 , In_PositionWO16_g242427 , In_PivotOS16_g242427 , In_PivotWS16_g242427 , In_PivotWO16_g242427 , In_NormalOS16_g242427 , In_NormalWS16_g242427 , In_TangentOS16_g242427 , In_ViewDirWS16_g242427 , In_CoordsData16_g242427 , In_VertexData16_g242427 , In_MasksData16_g242427 , In_PhaseData16_g242427 );
					TVEModelData DataTerrain26_g242551 = Data16_g242427;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g242551 = IsShaderType2637;
					{
					if (Type26_g242551 == 0 )
					{
					Data26_g242551 = DataDefault26_g242551;
					}
					else if (Type26_g242551 == 1 )
					{
					Data26_g242551 = DataGeneral26_g242551;
					}
					else if (Type26_g242551 == 2 )
					{
					Data26_g242551 = DataBlanket26_g242551;
					}
					else if (Type26_g242551 == 3 )
					{
					Data26_g242551 = DataImpostor26_g242551;
					}
					else if (Type26_g242551 == 4 )
					{
					Data26_g242551 = DataTerrain26_g242551;
					}
					}
					TVEModelData Data15_g251553 =(TVEModelData)Data26_g242551;
					float Out_Dummy15_g251553 = 0.0;
					float3 Out_PositionOS15_g251553 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251553 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251553 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251553 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251553 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251553 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251553 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251553 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251553 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251553 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251553 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251553 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251553 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251553 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251553 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251553 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251553 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251553 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251553 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251553 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251553 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251553 , Out_Dummy15_g251553 , Out_PositionOS15_g251553 , Out_PositionWS15_g251553 , Out_PositionWO15_g251553 , Out_PositionRawOS15_g251553 , Out_PivotOS15_g251553 , Out_PivotWS15_g251553 , Out_PivotWO15_g251553 , Out_NormalOS15_g251553 , Out_NormalWS15_g251553 , Out_NormalRawOS15_g251553 , Out_TangentOS15_g251553 , Out_TangentWS15_g251553 , Out_BitangentWS15_g251553 , Out_ViewDirWS15_g251553 , Out_CoordsData15_g251553 , Out_VertexData15_g251553 , Out_MasksData15_g251553 , Out_PhaseData15_g251553 , Out_TransformData15_g251553 , Out_RotationData15_g251553 , Out_Interpolator15_g251553 );
					float3 In_PositionOS16_g251552 = Out_PositionOS15_g251553;
					float3 In_NormalOS16_g251552 = Out_NormalOS15_g251553;
					float4 In_TangentOS16_g251552 = Out_TangentOS15_g251553;
					float4 In_TransformData16_g251552 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251552 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251552 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251552 , In_Dummy16_g251552 , In_PositionOS16_g251552 , In_NormalOS16_g251552 , In_TangentOS16_g251552 , In_TransformData16_g251552 , In_RotationData16_g251552 , In_Interpolator16_g251552 );
					TVEVertexData Data15_g251555 =(TVEVertexData)Data16_g251552;
					float Out_Dummy15_g251555 = 0.0;
					float3 Out_PositionOS15_g251555 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251555 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251555 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251555 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251555 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251555 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251555 , Out_Dummy15_g251555 , Out_PositionOS15_g251555 , Out_NormalOS15_g251555 , Out_TangentOS15_g251555 , Out_TransformData15_g251555 , Out_RotationData15_g251555 , Out_Interpolator15_g251555 );
					TVEModelData Data15_g251556 =(TVEModelData)Data15_g251553;
					float Out_Dummy15_g251556 = 0.0;
					float3 Out_PositionOS15_g251556 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251556 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251556 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251556 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251556 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251556 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251556 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251556 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251556 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251556 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251556 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251556 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251556 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251556 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251556 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251556 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251556 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251556 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251556 , Out_Dummy15_g251556 , Out_PositionOS15_g251556 , Out_PositionWS15_g251556 , Out_PositionWO15_g251556 , Out_PositionRawOS15_g251556 , Out_PivotOS15_g251556 , Out_PivotWS15_g251556 , Out_PivotWO15_g251556 , Out_NormalOS15_g251556 , Out_NormalWS15_g251556 , Out_NormalRawOS15_g251556 , Out_TangentOS15_g251556 , Out_TangentWS15_g251556 , Out_BitangentWS15_g251556 , Out_ViewDirWS15_g251556 , Out_CoordsData15_g251556 , Out_VertexData15_g251556 , Out_MasksData15_g251556 , Out_PhaseData15_g251556 , Out_TransformData15_g251556 , Out_RotationData15_g251556 , Out_Interpolator15_g251556 );
					float3 In_PositionOS16_g251557 = ( Out_PositionOS15_g251555 - Out_PivotOS15_g251556 );
					float3 In_NormalOS16_g251557 = Out_NormalOS15_g251556;
					float4 In_TangentOS16_g251557 = Out_TangentOS15_g251556;
					float4 In_TransformData16_g251557 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251557 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251557 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251557 , In_Dummy16_g251557 , In_PositionOS16_g251557 , In_NormalOS16_g251557 , In_TangentOS16_g251557 , In_TransformData16_g251557 , In_RotationData16_g251557 , In_Interpolator16_g251557 );
					TVEVertexData Data15_g251566 =(TVEVertexData)Data16_g251557;
					float Out_Dummy15_g251566 = 0.0;
					float3 Out_PositionOS15_g251566 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251566 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251566 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251566 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251566 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251566 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251566 , Out_Dummy15_g251566 , Out_PositionOS15_g251566 , Out_NormalOS15_g251566 , Out_TangentOS15_g251566 , Out_TransformData15_g251566 , Out_RotationData15_g251566 , Out_Interpolator15_g251566 );
					TVEVertexData Data16_g251567 =(TVEVertexData)Data15_g251566;
					half Dummy317_g251558 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251567 = Dummy317_g251558;
					float3 In_PositionOS16_g251567 = Out_PositionOS15_g251566;
					float3 In_NormalOS16_g251567 = Out_NormalOS15_g251566;
					float4 In_TangentOS16_g251567 = Out_TangentOS15_g251566;
					half4 Model_TransformData356_g251558 = Out_TransformData15_g251566;
					float localBuildGlobalData204_g242450 = ( 0.0 );
					TVEGlobalData Data204_g242450 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g242450 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g242450 = Dummy211_g242450;
					float4 temp_output_203_0_g242469 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g242408 = ( 0.0 );
					TVEModelData Data26_g242408 = (TVEModelData)0;
					TVEModelData Data16_g242437 =(TVEModelData)0;
					float In_Dummy16_g242437 = 0.0;
					float3 In_PositionWS16_g242437 = PositionWS122_g242429;
					float3 In_PositionWO16_g242437 = PositionWO132_g242429;
					float3 In_PivotWS16_g242437 = PivotWS121_g242429;
					float3 In_PivotWO16_g242437 = PivotWO133_g242429;
					float3 In_NormalWS16_g242437 = NormalWS95_g242429;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g242429 = ase_tangentWS;
					float3 In_TangentWS16_g242437 = TangentWS136_g242429;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g242429 = ase_bitangentWS;
					float3 In_BitangentWS16_g242437 = BiangentWS421_g242429;
					half3 NormalWS427_g242429 = NormalWS95_g242429;
					half3 localComputeTriplanarMasks427_g242429 = ComputeTriplanarMasks( NormalWS427_g242429 );
					half3 TriplanarWeights429_g242429 = localComputeTriplanarMasks427_g242429;
					float3 In_TriplanarWeights16_g242437 = TriplanarWeights429_g242429;
					float3 In_ViewDirWS16_g242437 = ViewDirWS169_g242429;
					float4 In_CoordsData16_g242437 = CoordsData398_g242429;
					float4 In_VertexData16_g242437 = VertexMasks171_g242429;
					float4 In_Interpolator16_g242437 = Phase_Data176_g242429;
					BuildModelFragData( Data16_g242437 , In_Dummy16_g242437 , In_PositionWS16_g242437 , In_PositionWO16_g242437 , In_PivotWS16_g242437 , In_PivotWO16_g242437 , In_NormalWS16_g242437 , In_TangentWS16_g242437 , In_BitangentWS16_g242437 , In_TriplanarWeights16_g242437 , In_ViewDirWS16_g242437 , In_CoordsData16_g242437 , In_VertexData16_g242437 , In_Interpolator16_g242437 );
					TVEModelData DataDefault26_g242408 = Data16_g242437;
					TVEModelData DataGeneral26_g242408 = Data16_g242437;
					TVEModelData DataBlanket26_g242408 = Data16_g242437;
					TVEModelData DataImpostor26_g242408 = Data16_g242437;
					TVEModelData Data16_g242417 =(TVEModelData)0;
					float In_Dummy16_g242417 = 0.0;
					float3 In_PositionWS16_g242417 = PositionWS122_g242409;
					float3 In_PositionWO16_g242417 = PositionWO132_g242409;
					float3 In_PivotWS16_g242417 = PivotWS121_g242409;
					float3 In_PivotWO16_g242417 = PivotWO133_g242409;
					float3 In_NormalWS16_g242417 = NormalWS95_g242409;
					half3 TangentWS136_g242409 = ase_tangentWS;
					float3 In_TangentWS16_g242417 = TangentWS136_g242409;
					half3 BiangentWS421_g242409 = ase_bitangentWS;
					float3 In_BitangentWS16_g242417 = BiangentWS421_g242409;
					half3 NormalWS427_g242409 = NormalWS95_g242409;
					half3 localComputeTriplanarMasks427_g242409 = ComputeTriplanarMasks( NormalWS427_g242409 );
					half3 TriplanarWeights429_g242409 = localComputeTriplanarMasks427_g242409;
					float3 In_TriplanarWeights16_g242417 = TriplanarWeights429_g242409;
					float3 In_ViewDirWS16_g242417 = ViewDirWS169_g242409;
					float4 In_CoordsData16_g242417 = CoordsData398_g242409;
					float4 In_VertexData16_g242417 = VertexMasks171_g242409;
					float4 In_Interpolator16_g242417 = Phase_Data176_g242409;
					BuildModelFragData( Data16_g242417 , In_Dummy16_g242417 , In_PositionWS16_g242417 , In_PositionWO16_g242417 , In_PivotWS16_g242417 , In_PivotWO16_g242417 , In_NormalWS16_g242417 , In_TangentWS16_g242417 , In_BitangentWS16_g242417 , In_TriplanarWeights16_g242417 , In_ViewDirWS16_g242417 , In_CoordsData16_g242417 , In_VertexData16_g242417 , In_Interpolator16_g242417 );
					TVEModelData DataTerrain26_g242408 = Data16_g242417;
					float Type26_g242408 = IsShaderType2637;
					{
					if (Type26_g242408 == 0 )
					{
					Data26_g242408 = DataDefault26_g242408;
					}
					else if (Type26_g242408 == 1 )
					{
					Data26_g242408 = DataGeneral26_g242408;
					}
					else if (Type26_g242408 == 2 )
					{
					Data26_g242408 = DataBlanket26_g242408;
					}
					else if (Type26_g242408 == 3 )
					{
					Data26_g242408 = DataImpostor26_g242408;
					}
					else if (Type26_g242408 == 4 )
					{
					Data26_g242408 = DataTerrain26_g242408;
					}
					}
					TVEModelData Data15_g242540 =(TVEModelData)Data26_g242408;
					float Out_Dummy15_g242540 = 0.0;
					float3 Out_PositionWS15_g242540 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242540 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242540 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242540 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242540 = float3( 0,0,0 );
					float3 Out_TangentWS15_g242540 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242540 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g242540 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242540 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242540 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242540 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g242540 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g242540 , Out_Dummy15_g242540 , Out_PositionWS15_g242540 , Out_PositionWO15_g242540 , Out_PivotWS15_g242540 , Out_PivotWO15_g242540 , Out_NormalWS15_g242540 , Out_TangentWS15_g242540 , Out_BitangentWS15_g242540 , Out_TriplanarWeights15_g242540 , Out_ViewDirWS15_g242540 , Out_CoordsData15_g242540 , Out_VertexData15_g242540 , Out_Interpolator15_g242540 );
					float3 Model_PositionWS497_g242450 = Out_PositionWS15_g242540;
					float2 Model_PositionWS_XZ143_g242450 = (Model_PositionWS497_g242450).xz;
					float3 Model_PivotWS498_g242450 = Out_PivotWS15_g242540;
					float2 Model_PivotWS_XZ145_g242450 = (Model_PivotWS498_g242450).xz;
					float2 lerpResult300_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g242469 = lerpResult300_g242450;
					float temp_output_82_0_g242467 = _GlobalCoatLayerValue;
					float temp_output_82_0_g242469 = temp_output_82_0_g242467;
					float4 tex2DArrayNode83_g242469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242469).zw + ( (temp_output_203_0_g242469).xy * temp_output_81_0_g242469 ) ),temp_output_82_0_g242469), 0.0 );
					float4 appendResult210_g242469 = (float4(tex2DArrayNode83_g242469.rgb , tex2DArrayNode83_g242469.a));
					float4 temp_output_204_0_g242469 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g242469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242469).zw + ( (temp_output_204_0_g242469).xy * temp_output_81_0_g242469 ) ),temp_output_82_0_g242469), 0.0 );
					float4 appendResult212_g242469 = (float4(tex2DArrayNode122_g242469.rgb , tex2DArrayNode122_g242469.a));
					float4 TVE_RenderNearPositionR628_g242450 = TVE_RenderNearPositionR;
					float temp_output_507_0_g242450 = saturate( ( distance( Model_PositionWS497_g242450 , (TVE_RenderNearPositionR628_g242450).xyz ) / (TVE_RenderNearPositionR628_g242450).w ) );
					float temp_output_7_0_g242539 = 1.0;
					float temp_output_9_0_g242539 = ( temp_output_507_0_g242450 - temp_output_7_0_g242539 );
					half TVE_RenderNearFadeValue635_g242450 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g242450 = saturate( ( temp_output_9_0_g242539 / ( ( TVE_RenderNearFadeValue635_g242450 - temp_output_7_0_g242539 ) + 0.0001 ) ) );
					float4 lerpResult131_g242469 = lerp( appendResult210_g242469 , appendResult212_g242469 , Global_TexBlend509_g242450);
					float4 temp_output_159_109_g242467 = lerpResult131_g242469;
					float4 lerpResult168_g242467 = lerp( TVE_CoatParams , temp_output_159_109_g242467 , TVE_CoatLayers[(int)temp_output_82_0_g242467]);
					float4 temp_output_589_109_g242450 = lerpResult168_g242467;
					half4 Coat_Texture302_g242450 = temp_output_589_109_g242450;
					float4 In_CoatTexture204_g242450 = Coat_Texture302_g242450;
					half4 Draw_Texture656_g242450 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g242450 = Draw_Texture656_g242450;
					float4 temp_output_203_0_g242494 = TVE_PaintBaseCoord;
					float2 lerpResult85_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g242494 = lerpResult85_g242450;
					float temp_output_82_0_g242491 = _GlobalPaintLayerValue;
					float temp_output_82_0_g242494 = temp_output_82_0_g242491;
					float4 tex2DArrayNode83_g242494 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242494).zw + ( (temp_output_203_0_g242494).xy * temp_output_81_0_g242494 ) ),temp_output_82_0_g242494), 0.0 );
					float4 appendResult210_g242494 = (float4(tex2DArrayNode83_g242494.rgb , tex2DArrayNode83_g242494.a));
					float4 temp_output_204_0_g242494 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g242494 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242494).zw + ( (temp_output_204_0_g242494).xy * temp_output_81_0_g242494 ) ),temp_output_82_0_g242494), 0.0 );
					float4 appendResult212_g242494 = (float4(tex2DArrayNode122_g242494.rgb , tex2DArrayNode122_g242494.a));
					float4 lerpResult131_g242494 = lerp( appendResult210_g242494 , appendResult212_g242494 , Global_TexBlend509_g242450);
					float4 temp_output_171_109_g242491 = lerpResult131_g242494;
					float4 lerpResult174_g242491 = lerp( TVE_PaintParams , temp_output_171_109_g242491 , TVE_PaintLayers[(int)temp_output_82_0_g242491]);
					float4 temp_output_595_109_g242450 = lerpResult174_g242491;
					half4 Paint_Texture71_g242450 = temp_output_595_109_g242450;
					float4 In_PaintTexture204_g242450 = Paint_Texture71_g242450;
					float4 temp_output_203_0_g242477 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g242477 = lerpResult104_g242450;
					float temp_output_132_0_g242475 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g242477 = temp_output_132_0_g242475;
					float4 tex2DArrayNode83_g242477 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242477).zw + ( (temp_output_203_0_g242477).xy * temp_output_81_0_g242477 ) ),temp_output_82_0_g242477), 0.0 );
					float4 appendResult210_g242477 = (float4(tex2DArrayNode83_g242477.rgb , tex2DArrayNode83_g242477.a));
					float4 temp_output_204_0_g242477 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g242477 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242477).zw + ( (temp_output_204_0_g242477).xy * temp_output_81_0_g242477 ) ),temp_output_82_0_g242477), 0.0 );
					float4 appendResult212_g242477 = (float4(tex2DArrayNode122_g242477.rgb , tex2DArrayNode122_g242477.a));
					float4 lerpResult131_g242477 = lerp( appendResult210_g242477 , appendResult212_g242477 , Global_TexBlend509_g242450);
					float4 temp_output_137_109_g242475 = lerpResult131_g242477;
					float4 lerpResult145_g242475 = lerp( TVE_AtmoParams , temp_output_137_109_g242475 , TVE_AtmoLayers[(int)temp_output_132_0_g242475]);
					float4 temp_output_590_110_g242450 = lerpResult145_g242475;
					half4 Atmo_Texture80_g242450 = temp_output_590_110_g242450;
					float4 In_AtmoTexture204_g242450 = Atmo_Texture80_g242450;
					float4 temp_output_203_0_g242545 = TVE_EffexBaseCoord;
					float2 lerpResult414_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g242545 = lerpResult414_g242450;
					float temp_output_132_0_g242543 = _GlobalEffexLayerValue;
					float temp_output_82_0_g242545 = temp_output_132_0_g242543;
					float4 tex2DArrayNode83_g242545 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242545).zw + ( (temp_output_203_0_g242545).xy * temp_output_81_0_g242545 ) ),temp_output_82_0_g242545), 0.0 );
					float4 appendResult210_g242545 = (float4(tex2DArrayNode83_g242545.rgb , tex2DArrayNode83_g242545.a));
					float4 temp_output_204_0_g242545 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g242545 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242545).zw + ( (temp_output_204_0_g242545).xy * temp_output_81_0_g242545 ) ),temp_output_82_0_g242545), 0.0 );
					float4 appendResult212_g242545 = (float4(tex2DArrayNode122_g242545.rgb , tex2DArrayNode122_g242545.a));
					float4 lerpResult131_g242545 = lerp( appendResult210_g242545 , appendResult212_g242545 , Global_TexBlend509_g242450);
					float4 temp_output_137_109_g242543 = lerpResult131_g242545;
					float4 lerpResult145_g242543 = lerp( TVE_EffexParams , temp_output_137_109_g242543 , TVE_EffexLayers[(int)temp_output_132_0_g242543]);
					float4 temp_output_731_110_g242450 = lerpResult145_g242543;
					half4 Effex_Texture420_g242450 = temp_output_731_110_g242450;
					float4 In_EffexTexture204_g242450 = Effex_Texture420_g242450;
					float4 temp_output_203_0_g242525 = TVE_GlowBaseCoord;
					float2 lerpResult247_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g242525 = lerpResult247_g242450;
					float temp_output_82_0_g242523 = _GlobalGlowLayerValue;
					float temp_output_82_0_g242525 = temp_output_82_0_g242523;
					float4 tex2DArrayNode83_g242525 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242525).zw + ( (temp_output_203_0_g242525).xy * temp_output_81_0_g242525 ) ),temp_output_82_0_g242525), 0.0 );
					float4 appendResult210_g242525 = (float4(tex2DArrayNode83_g242525.rgb , tex2DArrayNode83_g242525.a));
					float4 temp_output_204_0_g242525 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g242525 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242525).zw + ( (temp_output_204_0_g242525).xy * temp_output_81_0_g242525 ) ),temp_output_82_0_g242525), 0.0 );
					float4 appendResult212_g242525 = (float4(tex2DArrayNode122_g242525.rgb , tex2DArrayNode122_g242525.a));
					float4 lerpResult131_g242525 = lerp( appendResult210_g242525 , appendResult212_g242525 , Global_TexBlend509_g242450);
					float4 temp_output_159_109_g242523 = lerpResult131_g242525;
					float4 lerpResult167_g242523 = lerp( TVE_GlowParams , temp_output_159_109_g242523 , TVE_GlowLayers[(int)temp_output_82_0_g242523]);
					float4 temp_output_593_109_g242450 = lerpResult167_g242523;
					half4 Glow_Texture248_g242450 = temp_output_593_109_g242450;
					float4 In_GlowTexture204_g242450 = Glow_Texture248_g242450;
					float4 temp_output_203_0_g242461 = TVE_FormBaseCoord;
					float2 lerpResult168_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g242461 = lerpResult168_g242450;
					float temp_output_130_0_g242459 = _GlobalFormLayerValue;
					float temp_output_82_0_g242461 = temp_output_130_0_g242459;
					float4 tex2DArrayNode83_g242461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242461).zw + ( (temp_output_203_0_g242461).xy * temp_output_81_0_g242461 ) ),temp_output_82_0_g242461), 0.0 );
					float4 appendResult210_g242461 = (float4(tex2DArrayNode83_g242461.rgb , tex2DArrayNode83_g242461.a));
					float4 temp_output_204_0_g242461 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g242461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242461).zw + ( (temp_output_204_0_g242461).xy * temp_output_81_0_g242461 ) ),temp_output_82_0_g242461), 0.0 );
					float4 appendResult212_g242461 = (float4(tex2DArrayNode122_g242461.rgb , tex2DArrayNode122_g242461.a));
					float4 lerpResult131_g242461 = lerp( appendResult210_g242461 , appendResult212_g242461 , Global_TexBlend509_g242450);
					float4 temp_output_135_109_g242459 = lerpResult131_g242461;
					float4 lerpResult143_g242459 = lerp( TVE_FormParams , temp_output_135_109_g242459 , TVE_FormLayers[(int)temp_output_130_0_g242459]);
					float4 temp_output_592_0_g242450 = lerpResult143_g242459;
					float4 Form_Texture112_g242450 = temp_output_592_0_g242450;
					float4 In_FormTexture204_g242450 = Form_Texture112_g242450;
					float4 In_LandTexture204_g242450 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g242509 = TVE_VertxBaseCoord;
					float2 lerpResult681_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g242509 = lerpResult681_g242450;
					float temp_output_136_0_g242507 = _GlobalVertxLayerValue;
					float temp_output_82_0_g242509 = temp_output_136_0_g242507;
					float4 tex2DArrayNode83_g242509 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242509).zw + ( (temp_output_203_0_g242509).xy * temp_output_81_0_g242509 ) ),temp_output_82_0_g242509), 0.0 );
					float4 appendResult210_g242509 = (float4(tex2DArrayNode83_g242509.rgb , tex2DArrayNode83_g242509.a));
					float4 temp_output_204_0_g242509 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g242509 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242509).zw + ( (temp_output_204_0_g242509).xy * temp_output_81_0_g242509 ) ),temp_output_82_0_g242509), 0.0 );
					float4 appendResult212_g242509 = (float4(tex2DArrayNode122_g242509.rgb , tex2DArrayNode122_g242509.a));
					float4 lerpResult131_g242509 = lerp( appendResult210_g242509 , appendResult212_g242509 , Global_TexBlend509_g242450);
					float4 temp_output_141_109_g242507 = lerpResult131_g242509;
					float4 lerpResult149_g242507 = lerp( TVE_VertxParams , temp_output_141_109_g242507 , TVE_VertxLayers[(int)temp_output_136_0_g242507]);
					float4 temp_output_695_0_g242450 = lerpResult149_g242507;
					half4 Vertx_Texture693_g242450 = temp_output_695_0_g242450;
					float4 In_VertxTexture204_g242450 = Vertx_Texture693_g242450;
					float4 temp_output_203_0_g242485 = TVE_FlowBaseCoord;
					float2 lerpResult400_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g242485 = lerpResult400_g242450;
					float temp_output_136_0_g242483 = _GlobalFlowLayerValue;
					float temp_output_82_0_g242485 = temp_output_136_0_g242483;
					float4 tex2DArrayNode83_g242485 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242485).zw + ( (temp_output_203_0_g242485).xy * temp_output_81_0_g242485 ) ),temp_output_82_0_g242485), 0.0 );
					float4 appendResult210_g242485 = (float4(tex2DArrayNode83_g242485.rgb , tex2DArrayNode83_g242485.a));
					float4 temp_output_204_0_g242485 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g242485 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242485).zw + ( (temp_output_204_0_g242485).xy * temp_output_81_0_g242485 ) ),temp_output_82_0_g242485), 0.0 );
					float4 appendResult212_g242485 = (float4(tex2DArrayNode122_g242485.rgb , tex2DArrayNode122_g242485.a));
					float4 lerpResult131_g242485 = lerp( appendResult210_g242485 , appendResult212_g242485 , Global_TexBlend509_g242450);
					float4 temp_output_141_109_g242483 = lerpResult131_g242485;
					float4 lerpResult149_g242483 = lerp( TVE_FlowParams , temp_output_141_109_g242483 , TVE_FlowLayers[(int)temp_output_136_0_g242483]);
					float4 temp_output_594_0_g242450 = lerpResult149_g242483;
					half4 Flow_Texture405_g242450 = temp_output_594_0_g242450;
					float4 In_FlowTexture204_g242450 = Flow_Texture405_g242450;
					half4 User_Texture677_g242450 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g242450 = User_Texture677_g242450;
					BuildGlobalData( Data204_g242450 , In_Dummy204_g242450 , In_CoatTexture204_g242450 , In_DrawTexture204_g242450 , In_PaintTexture204_g242450 , In_AtmoTexture204_g242450 , In_EffexTexture204_g242450 , In_GlowTexture204_g242450 , In_FormTexture204_g242450 , In_LandTexture204_g242450 , In_VertxTexture204_g242450 , In_FlowTexture204_g242450 , In_UserTexture204_g242450 );
					TVEGlobalData Data15_g251568 =(TVEGlobalData)Data204_g242450;
					float Out_Dummy15_g251568 = 0.0;
					float4 Out_CoatTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251568 = float4( 0,0,0,0 );
					BreakData( Data15_g251568 , Out_Dummy15_g251568 , Out_CoatTexture15_g251568 , Out_DrawTexture15_g251568 , Out_PaintTexture15_g251568 , Out_AtmoTexture15_g251568 , Out_EffexTexture15_g251568 , Out_GlowTexture15_g251568 , Out_FormTexture15_g251568 , Out_LandTexture15_g251568 , Out_VertxTexture15_g251568 , Out_FlowTexture15_g251568 , Out_UserTexture15_g251568 );
					float4 Global_FormTexture351_g251558 = Out_FormTexture15_g251568;
					TVEModelData Data15_g251565 =(TVEModelData)Data15_g251556;
					float Out_Dummy15_g251565 = 0.0;
					float3 Out_PositionOS15_g251565 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251565 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251565 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251565 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251565 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251565 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251565 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251565 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251565 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251565 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251565 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251565 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251565 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251565 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251565 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251565 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251565 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251565 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251565 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251565 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251565 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251565 , Out_Dummy15_g251565 , Out_PositionOS15_g251565 , Out_PositionWS15_g251565 , Out_PositionWO15_g251565 , Out_PositionRawOS15_g251565 , Out_PivotOS15_g251565 , Out_PivotWS15_g251565 , Out_PivotWO15_g251565 , Out_NormalOS15_g251565 , Out_NormalWS15_g251565 , Out_NormalRawOS15_g251565 , Out_TangentOS15_g251565 , Out_TangentWS15_g251565 , Out_BitangentWS15_g251565 , Out_ViewDirWS15_g251565 , Out_CoordsData15_g251565 , Out_VertexData15_g251565 , Out_MasksData15_g251565 , Out_PhaseData15_g251565 , Out_TransformData15_g251565 , Out_RotationData15_g251565 , Out_Interpolator15_g251565 );
					float3 Model_PivotWO353_g251558 = Out_PivotWO15_g251565;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251564 = _ConformMeshMode;
					float Option70_g251564 = temp_output_17_0_g251564;
					half4 Model_VertexData357_g251558 = Out_VertexData15_g251565;
					float4 temp_output_3_0_g251564 = Model_VertexData357_g251558;
					float4 Channel70_g251564 = temp_output_3_0_g251564;
					float localSwitchChannel470_g251564 = SwitchChannel4( Option70_g251564 , Channel70_g251564 );
					float temp_output_390_0_g251558 = localSwitchChannel470_g251564;
					float temp_output_7_0_g251561 = _ConformMeshRemap.x;
					float temp_output_9_0_g251561 = ( temp_output_390_0_g251558 - temp_output_7_0_g251561 );
					float lerpResult374_g251558 = lerp( 1.0 , saturate( ( temp_output_9_0_g251561 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251558 = lerpResult374_g251558;
					float temp_output_328_0_g251558 = ( Blend_VertMask379_g251558 * TVE_IsEnabled );
					half Conform_Mask366_g251558 = temp_output_328_0_g251558;
					float temp_output_322_0_g251558 = ( ( ( ( (Global_FormTexture351_g251558).z - ( (Model_PivotWO353_g251558).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251558 ) );
					float3 appendResult329_g251558 = (float3(0.0 , temp_output_322_0_g251558 , 0.0));
					float3 appendResult387_g251558 = (float3(0.0 , 0.0 , temp_output_322_0_g251558));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251562 = appendResult387_g251558;
					#else
					float3 staticSwitch65_g251562 = appendResult329_g251558;
					#endif
					float3 Blanket_Conform368_g251558 = staticSwitch65_g251562;
					float4 appendResult312_g251558 = (float4(Blanket_Conform368_g251558 , 0.0));
					float4 temp_output_310_0_g251558 = ( Model_TransformData356_g251558 + appendResult312_g251558 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251558 = temp_output_310_0_g251558;
					#else
					float4 staticSwitch364_g251558 = Model_TransformData356_g251558;
					#endif
					half4 Final_TransformData365_g251558 = staticSwitch364_g251558;
					float4 In_TransformData16_g251567 = Final_TransformData365_g251558;
					float4 In_RotationData16_g251567 = Out_RotationData15_g251566;
					float4 In_Interpolator16_g251567 = Out_Interpolator15_g251566;
					BuildVertexData( Data16_g251567 , In_Dummy16_g251567 , In_PositionOS16_g251567 , In_NormalOS16_g251567 , In_TangentOS16_g251567 , In_TransformData16_g251567 , In_RotationData16_g251567 , In_Interpolator16_g251567 );
					TVEVertexData Data15_g251578 =(TVEVertexData)Data16_g251567;
					float Out_Dummy15_g251578 = 0.0;
					float3 Out_PositionOS15_g251578 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251578 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251578 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251578 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251578 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251578 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251578 , Out_Dummy15_g251578 , Out_PositionOS15_g251578 , Out_NormalOS15_g251578 , Out_TangentOS15_g251578 , Out_TransformData15_g251578 , Out_RotationData15_g251578 , Out_Interpolator15_g251578 );
					TVEVertexData Data16_g251579 =(TVEVertexData)Data15_g251578;
					float In_Dummy16_g251579 = 0.0;
					float3 Vertex_PositionOS147_g251569 = Out_PositionOS15_g251578;
					half3 VertexPos40_g251573 = Vertex_PositionOS147_g251569;
					float4 temp_output_1615_33_g251569 = Out_RotationData15_g251578;
					half4 Vertex_RotationData1569_g251569 = temp_output_1615_33_g251569;
					float2 break1582_g251569 = (Vertex_RotationData1569_g251569).xy;
					half Angle44_g251573 = break1582_g251569.y;
					half CosAngle89_g251573 = cos( Angle44_g251573 );
					half SinAngle93_g251573 = sin( Angle44_g251573 );
					float3 appendResult95_g251573 = (float3((VertexPos40_g251573).x , ( ( (VertexPos40_g251573).y * CosAngle89_g251573 ) - ( (VertexPos40_g251573).z * SinAngle93_g251573 ) ) , ( ( (VertexPos40_g251573).y * SinAngle93_g251573 ) + ( (VertexPos40_g251573).z * CosAngle89_g251573 ) )));
					half3 VertexPos40_g251574 = appendResult95_g251573;
					half Angle44_g251574 = -break1582_g251569.x;
					half CosAngle94_g251574 = cos( Angle44_g251574 );
					half SinAngle95_g251574 = sin( Angle44_g251574 );
					float3 appendResult98_g251574 = (float3(( ( (VertexPos40_g251574).x * CosAngle94_g251574 ) - ( (VertexPos40_g251574).y * SinAngle95_g251574 ) ) , ( ( (VertexPos40_g251574).x * SinAngle95_g251574 ) + ( (VertexPos40_g251574).y * CosAngle94_g251574 ) ) , (VertexPos40_g251574).z));
					half3 VertexPos40_g251572 = Vertex_PositionOS147_g251569;
					half Angle44_g251572 = break1582_g251569.y;
					half CosAngle89_g251572 = cos( Angle44_g251572 );
					half SinAngle93_g251572 = sin( Angle44_g251572 );
					float3 appendResult95_g251572 = (float3((VertexPos40_g251572).x , ( ( (VertexPos40_g251572).y * CosAngle89_g251572 ) - ( (VertexPos40_g251572).z * SinAngle93_g251572 ) ) , ( ( (VertexPos40_g251572).y * SinAngle93_g251572 ) + ( (VertexPos40_g251572).z * CosAngle89_g251572 ) )));
					half3 VertexPos40_g251577 = appendResult95_g251572;
					half Angle44_g251577 = break1582_g251569.x;
					half CosAngle91_g251577 = cos( Angle44_g251577 );
					half SinAngle92_g251577 = sin( Angle44_g251577 );
					float3 appendResult93_g251577 = (float3(( ( (VertexPos40_g251577).x * CosAngle91_g251577 ) + ( (VertexPos40_g251577).z * SinAngle92_g251577 ) ) , (VertexPos40_g251577).y , ( ( -(VertexPos40_g251577).x * SinAngle92_g251577 ) + ( (VertexPos40_g251577).z * CosAngle91_g251577 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251575 = appendResult93_g251577;
					#else
					float3 staticSwitch65_g251575 = appendResult98_g251574;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251570 = staticSwitch65_g251575;
					#else
					float3 staticSwitch65_g251570 = Vertex_PositionOS147_g251569;
					#endif
					float3 temp_output_1608_0_g251569 = staticSwitch65_g251570;
					half3 VertexPos40_g251576 = temp_output_1608_0_g251569;
					half Angle44_g251576 = (Vertex_RotationData1569_g251569).z;
					half CosAngle91_g251576 = cos( Angle44_g251576 );
					half SinAngle92_g251576 = sin( Angle44_g251576 );
					float3 appendResult93_g251576 = (float3(( ( (VertexPos40_g251576).x * CosAngle91_g251576 ) + ( (VertexPos40_g251576).z * SinAngle92_g251576 ) ) , (VertexPos40_g251576).y , ( ( -(VertexPos40_g251576).x * SinAngle92_g251576 ) + ( (VertexPos40_g251576).z * CosAngle91_g251576 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251571 = appendResult93_g251576;
					#else
					float3 staticSwitch65_g251571 = temp_output_1608_0_g251569;
					#endif
					float4 temp_output_1615_31_g251569 = Out_TransformData15_g251578;
					half4 Vertex_TransformData1568_g251569 = temp_output_1615_31_g251569;
					half3 Final_PositionOS178_g251569 = ( ( staticSwitch65_g251571 * (Vertex_TransformData1568_g251569).w ) + (Vertex_TransformData1568_g251569).xyz );
					float3 In_PositionOS16_g251579 = Final_PositionOS178_g251569;
					float3 In_NormalOS16_g251579 = Out_NormalOS15_g251578;
					float4 In_TangentOS16_g251579 = Out_TangentOS15_g251578;
					float4 In_TransformData16_g251579 = temp_output_1615_31_g251569;
					float4 In_RotationData16_g251579 = temp_output_1615_33_g251569;
					float4 In_Interpolator16_g251579 = Out_Interpolator15_g251578;
					BuildVertexData( Data16_g251579 , In_Dummy16_g251579 , In_PositionOS16_g251579 , In_NormalOS16_g251579 , In_TangentOS16_g251579 , In_TransformData16_g251579 , In_RotationData16_g251579 , In_Interpolator16_g251579 );
					TVEVertexData Data15_g251582 =(TVEVertexData)Data16_g251579;
					float Out_Dummy15_g251582 = 0.0;
					float3 Out_PositionOS15_g251582 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251582 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251582 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251582 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251582 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251582 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251582 , Out_Dummy15_g251582 , Out_PositionOS15_g251582 , Out_NormalOS15_g251582 , Out_TangentOS15_g251582 , Out_TransformData15_g251582 , Out_RotationData15_g251582 , Out_Interpolator15_g251582 );
					TVEVertexData Data16_g251583 =(TVEVertexData)Data15_g251582;
					float In_Dummy16_g251583 = 0.0;
					TVEModelData Data15_g251581 =(TVEModelData)Data15_g251565;
					float Out_Dummy15_g251581 = 0.0;
					float3 Out_PositionOS15_g251581 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251581 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251581 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251581 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251581 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251581 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251581 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251581 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251581 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251581 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251581 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251581 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251581 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251581 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251581 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251581 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251581 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251581 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251581 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251581 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251581 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251581 , Out_Dummy15_g251581 , Out_PositionOS15_g251581 , Out_PositionWS15_g251581 , Out_PositionWO15_g251581 , Out_PositionRawOS15_g251581 , Out_PivotOS15_g251581 , Out_PivotWS15_g251581 , Out_PivotWO15_g251581 , Out_NormalOS15_g251581 , Out_NormalWS15_g251581 , Out_NormalRawOS15_g251581 , Out_TangentOS15_g251581 , Out_TangentWS15_g251581 , Out_BitangentWS15_g251581 , Out_ViewDirWS15_g251581 , Out_CoordsData15_g251581 , Out_VertexData15_g251581 , Out_MasksData15_g251581 , Out_PhaseData15_g251581 , Out_TransformData15_g251581 , Out_RotationData15_g251581 , Out_Interpolator15_g251581 );
					float3 In_PositionOS16_g251583 = ( Out_PositionOS15_g251582 + Out_PivotOS15_g251581 );
					float3 In_NormalOS16_g251583 = Out_NormalOS15_g251582;
					float4 In_TangentOS16_g251583 = Out_TangentOS15_g251582;
					float4 In_TransformData16_g251583 = Out_TransformData15_g251582;
					float4 In_RotationData16_g251583 = Out_RotationData15_g251582;
					float4 In_Interpolator16_g251583 = Out_Interpolator15_g251582;
					BuildVertexData( Data16_g251583 , In_Dummy16_g251583 , In_PositionOS16_g251583 , In_NormalOS16_g251583 , In_TangentOS16_g251583 , In_TransformData16_g251583 , In_RotationData16_g251583 , In_Interpolator16_g251583 );
					TVEVertexData Data15_g251728 =(TVEVertexData)Data16_g251583;
					float Out_Dummy15_g251728 = 0.0;
					float3 Out_PositionOS15_g251728 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251728 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251728 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251728 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251728 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251728 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251728 , Out_Dummy15_g251728 , Out_PositionOS15_g251728 , Out_NormalOS15_g251728 , Out_TangentOS15_g251728 , Out_TransformData15_g251728 , Out_RotationData15_g251728 , Out_Interpolator15_g251728 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251728;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251728;
					v.tangent = Out_TangentOS15_g251728;

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

					TVEVertexData Data16_g251557 =(TVEVertexData)0;
					float In_Dummy16_g251557 = 0.0;
					TVEVertexData Data16_g251552 =(TVEVertexData)0;
					float In_Dummy16_g251552 = 0.0;
					float localIfModelDataByShader26_g242551 = ( 0.0 );
					TVEModelData Data26_g242551 = (TVEModelData)0;
					TVEModelData Data16_g242447 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g242429 = _ObjectCoordMode;
					#else
					float staticSwitch343_g242429 = _ObjectCoordMode;
					#endif
					half Dummy207_g242429 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g242429 );
					float temp_output_14_0_g242447 = Dummy207_g242429;
					float In_Dummy16_g242447 = temp_output_14_0_g242447;
					float3 PositionOS131_g242429 = v.vertex.xyz;
					float3 temp_output_4_0_g242447 = PositionOS131_g242429;
					float3 In_PositionOS16_g242447 = temp_output_4_0_g242447;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g242429 = ase_positionWS;
					float3 vertexToFrag73_g242429 = temp_output_104_7_g242429;
					float3 PositionWS122_g242429 = vertexToFrag73_g242429;
					float3 In_PositionWS16_g242447 = PositionWS122_g242429;
					float4x4 break19_g242432 = unity_ObjectToWorld;
					float3 appendResult20_g242432 = (float3(break19_g242432[ 0 ][ 3 ] , break19_g242432[ 1 ][ 3 ] , break19_g242432[ 2 ][ 3 ]));
					float3 temp_output_340_7_g242429 = appendResult20_g242432;
					float4x4 break19_g242434 = unity_ObjectToWorld;
					float3 appendResult20_g242434 = (float3(break19_g242434[ 0 ][ 3 ] , break19_g242434[ 1 ][ 3 ] , break19_g242434[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g242430 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g242429 = PositionOS131_g242429;
					float3 appendResult234_g242429 = (float3(break233_g242429.x , 0.0 , break233_g242429.z));
					float3 break413_g242429 = PositionOS131_g242429;
					float3 appendResult414_g242429 = (float3(break413_g242429.x , break413_g242429.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g242436 = appendResult414_g242429;
					#else
					float3 staticSwitch65_g242436 = appendResult234_g242429;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g242429 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g242429 = appendResult60_g242430;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g242429 = staticSwitch65_g242436;
					#else
					float3 staticSwitch229_g242429 = _Vector0;
					#endif
					float3 PivotOS149_g242429 = staticSwitch229_g242429;
					float3 temp_output_122_0_g242434 = PivotOS149_g242429;
					float3 PivotsOnlyWS105_g242434 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g242434 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g242429 = ( appendResult20_g242434 + PivotsOnlyWS105_g242434 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g242429 = temp_output_340_7_g242429;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g242429 = temp_output_341_7_g242429;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g242429 = temp_output_341_7_g242429;
					#else
					float3 staticSwitch236_g242429 = temp_output_340_7_g242429;
					#endif
					float3 vertexToFrag76_g242429 = staticSwitch236_g242429;
					float3 PivotWS121_g242429 = vertexToFrag76_g242429;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242429 = ( PositionWS122_g242429 - PivotWS121_g242429 );
					#else
					float3 staticSwitch204_g242429 = PositionWS122_g242429;
					#endif
					float3 PositionWO132_g242429 = ( staticSwitch204_g242429 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242447 = PositionWO132_g242429;
					float3 In_PivotOS16_g242447 = PivotOS149_g242429;
					float3 In_PivotWS16_g242447 = PivotWS121_g242429;
					float3 PivotWO133_g242429 = ( PivotWS121_g242429 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242447 = PivotWO133_g242429;
					half3 NormalOS134_g242429 = v.normal;
					float3 temp_output_21_0_g242447 = NormalOS134_g242429;
					float3 In_NormalOS16_g242447 = temp_output_21_0_g242447;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g242429 = normalizedWorldNormal;
					float3 In_NormalWS16_g242447 = NormalWS95_g242429;
					half4 TangentlOS153_g242429 = v.tangent;
					float4 temp_output_6_0_g242447 = TangentlOS153_g242429;
					float4 In_TangentOS16_g242447 = temp_output_6_0_g242447;
					float3 normalizeResult296_g242429 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242429 ) );
					half3 ViewDirWS169_g242429 = normalizeResult296_g242429;
					float3 In_ViewDirWS16_g242447 = ViewDirWS169_g242429;
					float4 appendResult397_g242429 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g242429 = appendResult397_g242429;
					float4 In_CoordsData16_g242447 = CoordsData398_g242429;
					half4 VertexMasks171_g242429 = v.ase_color;
					float4 In_VertexData16_g242447 = VertexMasks171_g242429;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g242441 = (PositionOS131_g242429).z;
					#else
					float staticSwitch65_g242441 = (PositionOS131_g242429).y;
					#endif
					half Object_HeightValue267_g242429 = _ObjectHeightValue;
					half Bounds_HeightMask274_g242429 = saturate( ( staticSwitch65_g242441 / Object_HeightValue267_g242429 ) );
					half3 Position387_g242429 = PositionOS131_g242429;
					half Height387_g242429 = Object_HeightValue267_g242429;
					half Object_RadiusValue268_g242429 = _ObjectRadiusValue;
					half Radius387_g242429 = Object_RadiusValue268_g242429;
					half localCapsuleMaskYUp387_g242429 = CapsuleMaskYUp( Position387_g242429 , Height387_g242429 , Radius387_g242429 );
					half3 Position408_g242429 = PositionOS131_g242429;
					half Height408_g242429 = Object_HeightValue267_g242429;
					half Radius408_g242429 = Object_RadiusValue268_g242429;
					half localCapsuleMaskZUp408_g242429 = CapsuleMaskZUp( Position408_g242429 , Height408_g242429 , Radius408_g242429 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g242446 = saturate( localCapsuleMaskZUp408_g242429 );
					#else
					float staticSwitch65_g242446 = saturate( localCapsuleMaskYUp387_g242429 );
					#endif
					half Bounds_SphereMask282_g242429 = staticSwitch65_g242446;
					float4 appendResult253_g242429 = (float4(Bounds_HeightMask274_g242429 , Bounds_SphereMask282_g242429 , 1.0 , 1.0));
					half4 MasksData254_g242429 = appendResult253_g242429;
					float4 In_MasksData16_g242447 = MasksData254_g242429;
					float temp_output_17_0_g242440 = _ObjectPhaseMode;
					float Option70_g242440 = temp_output_17_0_g242440;
					float4 temp_output_3_0_g242440 = v.ase_color;
					float4 Channel70_g242440 = temp_output_3_0_g242440;
					float localSwitchChannel470_g242440 = SwitchChannel4( Option70_g242440 , Channel70_g242440 );
					half Phase_Value372_g242429 = localSwitchChannel470_g242440;
					float3 break319_g242429 = PivotWO133_g242429;
					half Pivot_Position322_g242429 = ( break319_g242429.x + break319_g242429.z );
					half Phase_Position357_g242429 = ( Phase_Value372_g242429 + Pivot_Position322_g242429 );
					float temp_output_248_0_g242429 = frac( Phase_Position357_g242429 );
					float4 appendResult177_g242429 = (float4((frac( ( Phase_Position357_g242429 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g242429));
					half4 Phase_Data176_g242429 = appendResult177_g242429;
					float4 In_PhaseData16_g242447 = Phase_Data176_g242429;
					BuildModelVertData( Data16_g242447 , In_Dummy16_g242447 , In_PositionOS16_g242447 , In_PositionWS16_g242447 , In_PositionWO16_g242447 , In_PivotOS16_g242447 , In_PivotWS16_g242447 , In_PivotWO16_g242447 , In_NormalOS16_g242447 , In_NormalWS16_g242447 , In_TangentOS16_g242447 , In_ViewDirWS16_g242447 , In_CoordsData16_g242447 , In_VertexData16_g242447 , In_MasksData16_g242447 , In_PhaseData16_g242447 );
					TVEModelData DataDefault26_g242551 = Data16_g242447;
					TVEModelData DataGeneral26_g242551 = Data16_g242447;
					TVEModelData DataBlanket26_g242551 = Data16_g242447;
					TVEModelData DataImpostor26_g242551 = Data16_g242447;
					TVEModelData Data16_g242427 =(TVEModelData)0;
					half Dummy207_g242409 = 0.0;
					float temp_output_14_0_g242427 = Dummy207_g242409;
					float In_Dummy16_g242427 = temp_output_14_0_g242427;
					float3 PositionOS131_g242409 = v.vertex.xyz;
					float3 temp_output_4_0_g242427 = PositionOS131_g242409;
					float3 In_PositionOS16_g242427 = temp_output_4_0_g242427;
					float3 temp_output_104_7_g242409 = ase_positionWS;
					float3 PositionWS122_g242409 = temp_output_104_7_g242409;
					float3 In_PositionWS16_g242427 = PositionWS122_g242409;
					float4x4 break19_g242412 = unity_ObjectToWorld;
					float3 appendResult20_g242412 = (float3(break19_g242412[ 0 ][ 3 ] , break19_g242412[ 1 ][ 3 ] , break19_g242412[ 2 ][ 3 ]));
					float3 temp_output_340_7_g242409 = appendResult20_g242412;
					float3 PivotWS121_g242409 = temp_output_340_7_g242409;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g242409 = ( PositionWS122_g242409 - PivotWS121_g242409 );
					#else
					float3 staticSwitch204_g242409 = PositionWS122_g242409;
					#endif
					float3 PositionWO132_g242409 = ( staticSwitch204_g242409 - TVE_WorldOrigin );
					float3 In_PositionWO16_g242427 = PositionWO132_g242409;
					float3 PivotOS149_g242409 = _Vector0;
					float3 In_PivotOS16_g242427 = PivotOS149_g242409;
					float3 In_PivotWS16_g242427 = PivotWS121_g242409;
					float3 PivotWO133_g242409 = ( PivotWS121_g242409 - TVE_WorldOrigin );
					float3 In_PivotWO16_g242427 = PivotWO133_g242409;
					half3 NormalOS134_g242409 = v.normal;
					float3 temp_output_21_0_g242427 = NormalOS134_g242409;
					float3 In_NormalOS16_g242427 = temp_output_21_0_g242427;
					half3 NormalWS95_g242409 = normalizedWorldNormal;
					float3 In_NormalWS16_g242427 = NormalWS95_g242409;
					float4 appendResult462_g242409 = (float4(cross( v.normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g242409 = appendResult462_g242409;
					float4 temp_output_6_0_g242427 = TangentlOS153_g242409;
					float4 In_TangentOS16_g242427 = temp_output_6_0_g242427;
					float3 normalizeResult296_g242409 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g242409 ) );
					half3 ViewDirWS169_g242409 = normalizeResult296_g242409;
					float3 In_ViewDirWS16_g242427 = ViewDirWS169_g242409;
					float4 appendResult397_g242409 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g242409 = appendResult397_g242409;
					float4 In_CoordsData16_g242427 = CoordsData398_g242409;
					half4 VertexMasks171_g242409 = float4( 0,0,0,0 );
					float4 In_VertexData16_g242427 = VertexMasks171_g242409;
					half4 MasksData254_g242409 = float4( 0,0,0,0 );
					float4 In_MasksData16_g242427 = MasksData254_g242409;
					half4 Phase_Data176_g242409 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g242427 = Phase_Data176_g242409;
					BuildModelVertData( Data16_g242427 , In_Dummy16_g242427 , In_PositionOS16_g242427 , In_PositionWS16_g242427 , In_PositionWO16_g242427 , In_PivotOS16_g242427 , In_PivotWS16_g242427 , In_PivotWO16_g242427 , In_NormalOS16_g242427 , In_NormalWS16_g242427 , In_TangentOS16_g242427 , In_ViewDirWS16_g242427 , In_CoordsData16_g242427 , In_VertexData16_g242427 , In_MasksData16_g242427 , In_PhaseData16_g242427 );
					TVEModelData DataTerrain26_g242551 = Data16_g242427;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g242551 = IsShaderType2637;
					{
					if (Type26_g242551 == 0 )
					{
					Data26_g242551 = DataDefault26_g242551;
					}
					else if (Type26_g242551 == 1 )
					{
					Data26_g242551 = DataGeneral26_g242551;
					}
					else if (Type26_g242551 == 2 )
					{
					Data26_g242551 = DataBlanket26_g242551;
					}
					else if (Type26_g242551 == 3 )
					{
					Data26_g242551 = DataImpostor26_g242551;
					}
					else if (Type26_g242551 == 4 )
					{
					Data26_g242551 = DataTerrain26_g242551;
					}
					}
					TVEModelData Data15_g251553 =(TVEModelData)Data26_g242551;
					float Out_Dummy15_g251553 = 0.0;
					float3 Out_PositionOS15_g251553 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251553 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251553 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251553 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251553 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251553 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251553 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251553 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251553 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251553 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251553 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251553 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251553 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251553 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251553 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251553 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251553 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251553 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251553 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251553 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251553 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251553 , Out_Dummy15_g251553 , Out_PositionOS15_g251553 , Out_PositionWS15_g251553 , Out_PositionWO15_g251553 , Out_PositionRawOS15_g251553 , Out_PivotOS15_g251553 , Out_PivotWS15_g251553 , Out_PivotWO15_g251553 , Out_NormalOS15_g251553 , Out_NormalWS15_g251553 , Out_NormalRawOS15_g251553 , Out_TangentOS15_g251553 , Out_TangentWS15_g251553 , Out_BitangentWS15_g251553 , Out_ViewDirWS15_g251553 , Out_CoordsData15_g251553 , Out_VertexData15_g251553 , Out_MasksData15_g251553 , Out_PhaseData15_g251553 , Out_TransformData15_g251553 , Out_RotationData15_g251553 , Out_Interpolator15_g251553 );
					float3 In_PositionOS16_g251552 = Out_PositionOS15_g251553;
					float3 In_NormalOS16_g251552 = Out_NormalOS15_g251553;
					float4 In_TangentOS16_g251552 = Out_TangentOS15_g251553;
					float4 In_TransformData16_g251552 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251552 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251552 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251552 , In_Dummy16_g251552 , In_PositionOS16_g251552 , In_NormalOS16_g251552 , In_TangentOS16_g251552 , In_TransformData16_g251552 , In_RotationData16_g251552 , In_Interpolator16_g251552 );
					TVEVertexData Data15_g251555 =(TVEVertexData)Data16_g251552;
					float Out_Dummy15_g251555 = 0.0;
					float3 Out_PositionOS15_g251555 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251555 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251555 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251555 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251555 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251555 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251555 , Out_Dummy15_g251555 , Out_PositionOS15_g251555 , Out_NormalOS15_g251555 , Out_TangentOS15_g251555 , Out_TransformData15_g251555 , Out_RotationData15_g251555 , Out_Interpolator15_g251555 );
					TVEModelData Data15_g251556 =(TVEModelData)Data15_g251553;
					float Out_Dummy15_g251556 = 0.0;
					float3 Out_PositionOS15_g251556 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251556 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251556 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251556 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251556 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251556 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251556 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251556 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251556 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251556 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251556 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251556 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251556 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251556 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251556 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251556 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251556 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251556 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251556 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251556 , Out_Dummy15_g251556 , Out_PositionOS15_g251556 , Out_PositionWS15_g251556 , Out_PositionWO15_g251556 , Out_PositionRawOS15_g251556 , Out_PivotOS15_g251556 , Out_PivotWS15_g251556 , Out_PivotWO15_g251556 , Out_NormalOS15_g251556 , Out_NormalWS15_g251556 , Out_NormalRawOS15_g251556 , Out_TangentOS15_g251556 , Out_TangentWS15_g251556 , Out_BitangentWS15_g251556 , Out_ViewDirWS15_g251556 , Out_CoordsData15_g251556 , Out_VertexData15_g251556 , Out_MasksData15_g251556 , Out_PhaseData15_g251556 , Out_TransformData15_g251556 , Out_RotationData15_g251556 , Out_Interpolator15_g251556 );
					float3 In_PositionOS16_g251557 = ( Out_PositionOS15_g251555 - Out_PivotOS15_g251556 );
					float3 In_NormalOS16_g251557 = Out_NormalOS15_g251556;
					float4 In_TangentOS16_g251557 = Out_TangentOS15_g251556;
					float4 In_TransformData16_g251557 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251557 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251557 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251557 , In_Dummy16_g251557 , In_PositionOS16_g251557 , In_NormalOS16_g251557 , In_TangentOS16_g251557 , In_TransformData16_g251557 , In_RotationData16_g251557 , In_Interpolator16_g251557 );
					TVEVertexData Data15_g251566 =(TVEVertexData)Data16_g251557;
					float Out_Dummy15_g251566 = 0.0;
					float3 Out_PositionOS15_g251566 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251566 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251566 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251566 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251566 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251566 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251566 , Out_Dummy15_g251566 , Out_PositionOS15_g251566 , Out_NormalOS15_g251566 , Out_TangentOS15_g251566 , Out_TransformData15_g251566 , Out_RotationData15_g251566 , Out_Interpolator15_g251566 );
					TVEVertexData Data16_g251567 =(TVEVertexData)Data15_g251566;
					half Dummy317_g251558 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251567 = Dummy317_g251558;
					float3 In_PositionOS16_g251567 = Out_PositionOS15_g251566;
					float3 In_NormalOS16_g251567 = Out_NormalOS15_g251566;
					float4 In_TangentOS16_g251567 = Out_TangentOS15_g251566;
					half4 Model_TransformData356_g251558 = Out_TransformData15_g251566;
					float localBuildGlobalData204_g242450 = ( 0.0 );
					TVEGlobalData Data204_g242450 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g242450 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g242450 = Dummy211_g242450;
					float4 temp_output_203_0_g242469 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g242408 = ( 0.0 );
					TVEModelData Data26_g242408 = (TVEModelData)0;
					TVEModelData Data16_g242437 =(TVEModelData)0;
					float In_Dummy16_g242437 = 0.0;
					float3 In_PositionWS16_g242437 = PositionWS122_g242429;
					float3 In_PositionWO16_g242437 = PositionWO132_g242429;
					float3 In_PivotWS16_g242437 = PivotWS121_g242429;
					float3 In_PivotWO16_g242437 = PivotWO133_g242429;
					float3 In_NormalWS16_g242437 = NormalWS95_g242429;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g242429 = ase_tangentWS;
					float3 In_TangentWS16_g242437 = TangentWS136_g242429;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g242429 = ase_bitangentWS;
					float3 In_BitangentWS16_g242437 = BiangentWS421_g242429;
					half3 NormalWS427_g242429 = NormalWS95_g242429;
					half3 localComputeTriplanarMasks427_g242429 = ComputeTriplanarMasks( NormalWS427_g242429 );
					half3 TriplanarWeights429_g242429 = localComputeTriplanarMasks427_g242429;
					float3 In_TriplanarWeights16_g242437 = TriplanarWeights429_g242429;
					float3 In_ViewDirWS16_g242437 = ViewDirWS169_g242429;
					float4 In_CoordsData16_g242437 = CoordsData398_g242429;
					float4 In_VertexData16_g242437 = VertexMasks171_g242429;
					float4 In_Interpolator16_g242437 = Phase_Data176_g242429;
					BuildModelFragData( Data16_g242437 , In_Dummy16_g242437 , In_PositionWS16_g242437 , In_PositionWO16_g242437 , In_PivotWS16_g242437 , In_PivotWO16_g242437 , In_NormalWS16_g242437 , In_TangentWS16_g242437 , In_BitangentWS16_g242437 , In_TriplanarWeights16_g242437 , In_ViewDirWS16_g242437 , In_CoordsData16_g242437 , In_VertexData16_g242437 , In_Interpolator16_g242437 );
					TVEModelData DataDefault26_g242408 = Data16_g242437;
					TVEModelData DataGeneral26_g242408 = Data16_g242437;
					TVEModelData DataBlanket26_g242408 = Data16_g242437;
					TVEModelData DataImpostor26_g242408 = Data16_g242437;
					TVEModelData Data16_g242417 =(TVEModelData)0;
					float In_Dummy16_g242417 = 0.0;
					float3 In_PositionWS16_g242417 = PositionWS122_g242409;
					float3 In_PositionWO16_g242417 = PositionWO132_g242409;
					float3 In_PivotWS16_g242417 = PivotWS121_g242409;
					float3 In_PivotWO16_g242417 = PivotWO133_g242409;
					float3 In_NormalWS16_g242417 = NormalWS95_g242409;
					half3 TangentWS136_g242409 = ase_tangentWS;
					float3 In_TangentWS16_g242417 = TangentWS136_g242409;
					half3 BiangentWS421_g242409 = ase_bitangentWS;
					float3 In_BitangentWS16_g242417 = BiangentWS421_g242409;
					half3 NormalWS427_g242409 = NormalWS95_g242409;
					half3 localComputeTriplanarMasks427_g242409 = ComputeTriplanarMasks( NormalWS427_g242409 );
					half3 TriplanarWeights429_g242409 = localComputeTriplanarMasks427_g242409;
					float3 In_TriplanarWeights16_g242417 = TriplanarWeights429_g242409;
					float3 In_ViewDirWS16_g242417 = ViewDirWS169_g242409;
					float4 In_CoordsData16_g242417 = CoordsData398_g242409;
					float4 In_VertexData16_g242417 = VertexMasks171_g242409;
					float4 In_Interpolator16_g242417 = Phase_Data176_g242409;
					BuildModelFragData( Data16_g242417 , In_Dummy16_g242417 , In_PositionWS16_g242417 , In_PositionWO16_g242417 , In_PivotWS16_g242417 , In_PivotWO16_g242417 , In_NormalWS16_g242417 , In_TangentWS16_g242417 , In_BitangentWS16_g242417 , In_TriplanarWeights16_g242417 , In_ViewDirWS16_g242417 , In_CoordsData16_g242417 , In_VertexData16_g242417 , In_Interpolator16_g242417 );
					TVEModelData DataTerrain26_g242408 = Data16_g242417;
					float Type26_g242408 = IsShaderType2637;
					{
					if (Type26_g242408 == 0 )
					{
					Data26_g242408 = DataDefault26_g242408;
					}
					else if (Type26_g242408 == 1 )
					{
					Data26_g242408 = DataGeneral26_g242408;
					}
					else if (Type26_g242408 == 2 )
					{
					Data26_g242408 = DataBlanket26_g242408;
					}
					else if (Type26_g242408 == 3 )
					{
					Data26_g242408 = DataImpostor26_g242408;
					}
					else if (Type26_g242408 == 4 )
					{
					Data26_g242408 = DataTerrain26_g242408;
					}
					}
					TVEModelData Data15_g242540 =(TVEModelData)Data26_g242408;
					float Out_Dummy15_g242540 = 0.0;
					float3 Out_PositionWS15_g242540 = float3( 0,0,0 );
					float3 Out_PositionWO15_g242540 = float3( 0,0,0 );
					float3 Out_PivotWS15_g242540 = float3( 0,0,0 );
					float3 Out_PivotWO15_g242540 = float3( 0,0,0 );
					float3 Out_NormalWS15_g242540 = float3( 0,0,0 );
					float3 Out_TangentWS15_g242540 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g242540 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g242540 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g242540 = float3( 0,0,0 );
					float4 Out_CoordsData15_g242540 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g242540 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g242540 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g242540 , Out_Dummy15_g242540 , Out_PositionWS15_g242540 , Out_PositionWO15_g242540 , Out_PivotWS15_g242540 , Out_PivotWO15_g242540 , Out_NormalWS15_g242540 , Out_TangentWS15_g242540 , Out_BitangentWS15_g242540 , Out_TriplanarWeights15_g242540 , Out_ViewDirWS15_g242540 , Out_CoordsData15_g242540 , Out_VertexData15_g242540 , Out_Interpolator15_g242540 );
					float3 Model_PositionWS497_g242450 = Out_PositionWS15_g242540;
					float2 Model_PositionWS_XZ143_g242450 = (Model_PositionWS497_g242450).xz;
					float3 Model_PivotWS498_g242450 = Out_PivotWS15_g242540;
					float2 Model_PivotWS_XZ145_g242450 = (Model_PivotWS498_g242450).xz;
					float2 lerpResult300_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g242469 = lerpResult300_g242450;
					float temp_output_82_0_g242467 = _GlobalCoatLayerValue;
					float temp_output_82_0_g242469 = temp_output_82_0_g242467;
					float4 tex2DArrayNode83_g242469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242469).zw + ( (temp_output_203_0_g242469).xy * temp_output_81_0_g242469 ) ),temp_output_82_0_g242469), 0.0 );
					float4 appendResult210_g242469 = (float4(tex2DArrayNode83_g242469.rgb , tex2DArrayNode83_g242469.a));
					float4 temp_output_204_0_g242469 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g242469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242469).zw + ( (temp_output_204_0_g242469).xy * temp_output_81_0_g242469 ) ),temp_output_82_0_g242469), 0.0 );
					float4 appendResult212_g242469 = (float4(tex2DArrayNode122_g242469.rgb , tex2DArrayNode122_g242469.a));
					float4 TVE_RenderNearPositionR628_g242450 = TVE_RenderNearPositionR;
					float temp_output_507_0_g242450 = saturate( ( distance( Model_PositionWS497_g242450 , (TVE_RenderNearPositionR628_g242450).xyz ) / (TVE_RenderNearPositionR628_g242450).w ) );
					float temp_output_7_0_g242539 = 1.0;
					float temp_output_9_0_g242539 = ( temp_output_507_0_g242450 - temp_output_7_0_g242539 );
					half TVE_RenderNearFadeValue635_g242450 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g242450 = saturate( ( temp_output_9_0_g242539 / ( ( TVE_RenderNearFadeValue635_g242450 - temp_output_7_0_g242539 ) + 0.0001 ) ) );
					float4 lerpResult131_g242469 = lerp( appendResult210_g242469 , appendResult212_g242469 , Global_TexBlend509_g242450);
					float4 temp_output_159_109_g242467 = lerpResult131_g242469;
					float4 lerpResult168_g242467 = lerp( TVE_CoatParams , temp_output_159_109_g242467 , TVE_CoatLayers[(int)temp_output_82_0_g242467]);
					float4 temp_output_589_109_g242450 = lerpResult168_g242467;
					half4 Coat_Texture302_g242450 = temp_output_589_109_g242450;
					float4 In_CoatTexture204_g242450 = Coat_Texture302_g242450;
					half4 Draw_Texture656_g242450 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g242450 = Draw_Texture656_g242450;
					float4 temp_output_203_0_g242494 = TVE_PaintBaseCoord;
					float2 lerpResult85_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g242494 = lerpResult85_g242450;
					float temp_output_82_0_g242491 = _GlobalPaintLayerValue;
					float temp_output_82_0_g242494 = temp_output_82_0_g242491;
					float4 tex2DArrayNode83_g242494 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242494).zw + ( (temp_output_203_0_g242494).xy * temp_output_81_0_g242494 ) ),temp_output_82_0_g242494), 0.0 );
					float4 appendResult210_g242494 = (float4(tex2DArrayNode83_g242494.rgb , tex2DArrayNode83_g242494.a));
					float4 temp_output_204_0_g242494 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g242494 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242494).zw + ( (temp_output_204_0_g242494).xy * temp_output_81_0_g242494 ) ),temp_output_82_0_g242494), 0.0 );
					float4 appendResult212_g242494 = (float4(tex2DArrayNode122_g242494.rgb , tex2DArrayNode122_g242494.a));
					float4 lerpResult131_g242494 = lerp( appendResult210_g242494 , appendResult212_g242494 , Global_TexBlend509_g242450);
					float4 temp_output_171_109_g242491 = lerpResult131_g242494;
					float4 lerpResult174_g242491 = lerp( TVE_PaintParams , temp_output_171_109_g242491 , TVE_PaintLayers[(int)temp_output_82_0_g242491]);
					float4 temp_output_595_109_g242450 = lerpResult174_g242491;
					half4 Paint_Texture71_g242450 = temp_output_595_109_g242450;
					float4 In_PaintTexture204_g242450 = Paint_Texture71_g242450;
					float4 temp_output_203_0_g242477 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g242477 = lerpResult104_g242450;
					float temp_output_132_0_g242475 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g242477 = temp_output_132_0_g242475;
					float4 tex2DArrayNode83_g242477 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242477).zw + ( (temp_output_203_0_g242477).xy * temp_output_81_0_g242477 ) ),temp_output_82_0_g242477), 0.0 );
					float4 appendResult210_g242477 = (float4(tex2DArrayNode83_g242477.rgb , tex2DArrayNode83_g242477.a));
					float4 temp_output_204_0_g242477 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g242477 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242477).zw + ( (temp_output_204_0_g242477).xy * temp_output_81_0_g242477 ) ),temp_output_82_0_g242477), 0.0 );
					float4 appendResult212_g242477 = (float4(tex2DArrayNode122_g242477.rgb , tex2DArrayNode122_g242477.a));
					float4 lerpResult131_g242477 = lerp( appendResult210_g242477 , appendResult212_g242477 , Global_TexBlend509_g242450);
					float4 temp_output_137_109_g242475 = lerpResult131_g242477;
					float4 lerpResult145_g242475 = lerp( TVE_AtmoParams , temp_output_137_109_g242475 , TVE_AtmoLayers[(int)temp_output_132_0_g242475]);
					float4 temp_output_590_110_g242450 = lerpResult145_g242475;
					half4 Atmo_Texture80_g242450 = temp_output_590_110_g242450;
					float4 In_AtmoTexture204_g242450 = Atmo_Texture80_g242450;
					float4 temp_output_203_0_g242545 = TVE_EffexBaseCoord;
					float2 lerpResult414_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g242545 = lerpResult414_g242450;
					float temp_output_132_0_g242543 = _GlobalEffexLayerValue;
					float temp_output_82_0_g242545 = temp_output_132_0_g242543;
					float4 tex2DArrayNode83_g242545 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242545).zw + ( (temp_output_203_0_g242545).xy * temp_output_81_0_g242545 ) ),temp_output_82_0_g242545), 0.0 );
					float4 appendResult210_g242545 = (float4(tex2DArrayNode83_g242545.rgb , tex2DArrayNode83_g242545.a));
					float4 temp_output_204_0_g242545 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g242545 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242545).zw + ( (temp_output_204_0_g242545).xy * temp_output_81_0_g242545 ) ),temp_output_82_0_g242545), 0.0 );
					float4 appendResult212_g242545 = (float4(tex2DArrayNode122_g242545.rgb , tex2DArrayNode122_g242545.a));
					float4 lerpResult131_g242545 = lerp( appendResult210_g242545 , appendResult212_g242545 , Global_TexBlend509_g242450);
					float4 temp_output_137_109_g242543 = lerpResult131_g242545;
					float4 lerpResult145_g242543 = lerp( TVE_EffexParams , temp_output_137_109_g242543 , TVE_EffexLayers[(int)temp_output_132_0_g242543]);
					float4 temp_output_731_110_g242450 = lerpResult145_g242543;
					half4 Effex_Texture420_g242450 = temp_output_731_110_g242450;
					float4 In_EffexTexture204_g242450 = Effex_Texture420_g242450;
					float4 temp_output_203_0_g242525 = TVE_GlowBaseCoord;
					float2 lerpResult247_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g242525 = lerpResult247_g242450;
					float temp_output_82_0_g242523 = _GlobalGlowLayerValue;
					float temp_output_82_0_g242525 = temp_output_82_0_g242523;
					float4 tex2DArrayNode83_g242525 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242525).zw + ( (temp_output_203_0_g242525).xy * temp_output_81_0_g242525 ) ),temp_output_82_0_g242525), 0.0 );
					float4 appendResult210_g242525 = (float4(tex2DArrayNode83_g242525.rgb , tex2DArrayNode83_g242525.a));
					float4 temp_output_204_0_g242525 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g242525 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242525).zw + ( (temp_output_204_0_g242525).xy * temp_output_81_0_g242525 ) ),temp_output_82_0_g242525), 0.0 );
					float4 appendResult212_g242525 = (float4(tex2DArrayNode122_g242525.rgb , tex2DArrayNode122_g242525.a));
					float4 lerpResult131_g242525 = lerp( appendResult210_g242525 , appendResult212_g242525 , Global_TexBlend509_g242450);
					float4 temp_output_159_109_g242523 = lerpResult131_g242525;
					float4 lerpResult167_g242523 = lerp( TVE_GlowParams , temp_output_159_109_g242523 , TVE_GlowLayers[(int)temp_output_82_0_g242523]);
					float4 temp_output_593_109_g242450 = lerpResult167_g242523;
					half4 Glow_Texture248_g242450 = temp_output_593_109_g242450;
					float4 In_GlowTexture204_g242450 = Glow_Texture248_g242450;
					float4 temp_output_203_0_g242461 = TVE_FormBaseCoord;
					float2 lerpResult168_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g242461 = lerpResult168_g242450;
					float temp_output_130_0_g242459 = _GlobalFormLayerValue;
					float temp_output_82_0_g242461 = temp_output_130_0_g242459;
					float4 tex2DArrayNode83_g242461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242461).zw + ( (temp_output_203_0_g242461).xy * temp_output_81_0_g242461 ) ),temp_output_82_0_g242461), 0.0 );
					float4 appendResult210_g242461 = (float4(tex2DArrayNode83_g242461.rgb , tex2DArrayNode83_g242461.a));
					float4 temp_output_204_0_g242461 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g242461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242461).zw + ( (temp_output_204_0_g242461).xy * temp_output_81_0_g242461 ) ),temp_output_82_0_g242461), 0.0 );
					float4 appendResult212_g242461 = (float4(tex2DArrayNode122_g242461.rgb , tex2DArrayNode122_g242461.a));
					float4 lerpResult131_g242461 = lerp( appendResult210_g242461 , appendResult212_g242461 , Global_TexBlend509_g242450);
					float4 temp_output_135_109_g242459 = lerpResult131_g242461;
					float4 lerpResult143_g242459 = lerp( TVE_FormParams , temp_output_135_109_g242459 , TVE_FormLayers[(int)temp_output_130_0_g242459]);
					float4 temp_output_592_0_g242450 = lerpResult143_g242459;
					float4 Form_Texture112_g242450 = temp_output_592_0_g242450;
					float4 In_FormTexture204_g242450 = Form_Texture112_g242450;
					float4 In_LandTexture204_g242450 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g242509 = TVE_VertxBaseCoord;
					float2 lerpResult681_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g242509 = lerpResult681_g242450;
					float temp_output_136_0_g242507 = _GlobalVertxLayerValue;
					float temp_output_82_0_g242509 = temp_output_136_0_g242507;
					float4 tex2DArrayNode83_g242509 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242509).zw + ( (temp_output_203_0_g242509).xy * temp_output_81_0_g242509 ) ),temp_output_82_0_g242509), 0.0 );
					float4 appendResult210_g242509 = (float4(tex2DArrayNode83_g242509.rgb , tex2DArrayNode83_g242509.a));
					float4 temp_output_204_0_g242509 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g242509 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242509).zw + ( (temp_output_204_0_g242509).xy * temp_output_81_0_g242509 ) ),temp_output_82_0_g242509), 0.0 );
					float4 appendResult212_g242509 = (float4(tex2DArrayNode122_g242509.rgb , tex2DArrayNode122_g242509.a));
					float4 lerpResult131_g242509 = lerp( appendResult210_g242509 , appendResult212_g242509 , Global_TexBlend509_g242450);
					float4 temp_output_141_109_g242507 = lerpResult131_g242509;
					float4 lerpResult149_g242507 = lerp( TVE_VertxParams , temp_output_141_109_g242507 , TVE_VertxLayers[(int)temp_output_136_0_g242507]);
					float4 temp_output_695_0_g242450 = lerpResult149_g242507;
					half4 Vertx_Texture693_g242450 = temp_output_695_0_g242450;
					float4 In_VertxTexture204_g242450 = Vertx_Texture693_g242450;
					float4 temp_output_203_0_g242485 = TVE_FlowBaseCoord;
					float2 lerpResult400_g242450 = lerp( Model_PositionWS_XZ143_g242450 , Model_PivotWS_XZ145_g242450 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g242485 = lerpResult400_g242450;
					float temp_output_136_0_g242483 = _GlobalFlowLayerValue;
					float temp_output_82_0_g242485 = temp_output_136_0_g242483;
					float4 tex2DArrayNode83_g242485 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g242485).zw + ( (temp_output_203_0_g242485).xy * temp_output_81_0_g242485 ) ),temp_output_82_0_g242485), 0.0 );
					float4 appendResult210_g242485 = (float4(tex2DArrayNode83_g242485.rgb , tex2DArrayNode83_g242485.a));
					float4 temp_output_204_0_g242485 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g242485 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g242485).zw + ( (temp_output_204_0_g242485).xy * temp_output_81_0_g242485 ) ),temp_output_82_0_g242485), 0.0 );
					float4 appendResult212_g242485 = (float4(tex2DArrayNode122_g242485.rgb , tex2DArrayNode122_g242485.a));
					float4 lerpResult131_g242485 = lerp( appendResult210_g242485 , appendResult212_g242485 , Global_TexBlend509_g242450);
					float4 temp_output_141_109_g242483 = lerpResult131_g242485;
					float4 lerpResult149_g242483 = lerp( TVE_FlowParams , temp_output_141_109_g242483 , TVE_FlowLayers[(int)temp_output_136_0_g242483]);
					float4 temp_output_594_0_g242450 = lerpResult149_g242483;
					half4 Flow_Texture405_g242450 = temp_output_594_0_g242450;
					float4 In_FlowTexture204_g242450 = Flow_Texture405_g242450;
					half4 User_Texture677_g242450 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g242450 = User_Texture677_g242450;
					BuildGlobalData( Data204_g242450 , In_Dummy204_g242450 , In_CoatTexture204_g242450 , In_DrawTexture204_g242450 , In_PaintTexture204_g242450 , In_AtmoTexture204_g242450 , In_EffexTexture204_g242450 , In_GlowTexture204_g242450 , In_FormTexture204_g242450 , In_LandTexture204_g242450 , In_VertxTexture204_g242450 , In_FlowTexture204_g242450 , In_UserTexture204_g242450 );
					TVEGlobalData Data15_g251568 =(TVEGlobalData)Data204_g242450;
					float Out_Dummy15_g251568 = 0.0;
					float4 Out_CoatTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251568 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251568 = float4( 0,0,0,0 );
					BreakData( Data15_g251568 , Out_Dummy15_g251568 , Out_CoatTexture15_g251568 , Out_DrawTexture15_g251568 , Out_PaintTexture15_g251568 , Out_AtmoTexture15_g251568 , Out_EffexTexture15_g251568 , Out_GlowTexture15_g251568 , Out_FormTexture15_g251568 , Out_LandTexture15_g251568 , Out_VertxTexture15_g251568 , Out_FlowTexture15_g251568 , Out_UserTexture15_g251568 );
					float4 Global_FormTexture351_g251558 = Out_FormTexture15_g251568;
					TVEModelData Data15_g251565 =(TVEModelData)Data15_g251556;
					float Out_Dummy15_g251565 = 0.0;
					float3 Out_PositionOS15_g251565 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251565 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251565 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251565 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251565 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251565 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251565 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251565 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251565 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251565 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251565 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251565 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251565 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251565 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251565 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251565 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251565 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251565 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251565 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251565 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251565 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251565 , Out_Dummy15_g251565 , Out_PositionOS15_g251565 , Out_PositionWS15_g251565 , Out_PositionWO15_g251565 , Out_PositionRawOS15_g251565 , Out_PivotOS15_g251565 , Out_PivotWS15_g251565 , Out_PivotWO15_g251565 , Out_NormalOS15_g251565 , Out_NormalWS15_g251565 , Out_NormalRawOS15_g251565 , Out_TangentOS15_g251565 , Out_TangentWS15_g251565 , Out_BitangentWS15_g251565 , Out_ViewDirWS15_g251565 , Out_CoordsData15_g251565 , Out_VertexData15_g251565 , Out_MasksData15_g251565 , Out_PhaseData15_g251565 , Out_TransformData15_g251565 , Out_RotationData15_g251565 , Out_Interpolator15_g251565 );
					float3 Model_PivotWO353_g251558 = Out_PivotWO15_g251565;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251564 = _ConformMeshMode;
					float Option70_g251564 = temp_output_17_0_g251564;
					half4 Model_VertexData357_g251558 = Out_VertexData15_g251565;
					float4 temp_output_3_0_g251564 = Model_VertexData357_g251558;
					float4 Channel70_g251564 = temp_output_3_0_g251564;
					float localSwitchChannel470_g251564 = SwitchChannel4( Option70_g251564 , Channel70_g251564 );
					float temp_output_390_0_g251558 = localSwitchChannel470_g251564;
					float temp_output_7_0_g251561 = _ConformMeshRemap.x;
					float temp_output_9_0_g251561 = ( temp_output_390_0_g251558 - temp_output_7_0_g251561 );
					float lerpResult374_g251558 = lerp( 1.0 , saturate( ( temp_output_9_0_g251561 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251558 = lerpResult374_g251558;
					float temp_output_328_0_g251558 = ( Blend_VertMask379_g251558 * TVE_IsEnabled );
					half Conform_Mask366_g251558 = temp_output_328_0_g251558;
					float temp_output_322_0_g251558 = ( ( ( ( (Global_FormTexture351_g251558).z - ( (Model_PivotWO353_g251558).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251558 ) );
					float3 appendResult329_g251558 = (float3(0.0 , temp_output_322_0_g251558 , 0.0));
					float3 appendResult387_g251558 = (float3(0.0 , 0.0 , temp_output_322_0_g251558));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251562 = appendResult387_g251558;
					#else
					float3 staticSwitch65_g251562 = appendResult329_g251558;
					#endif
					float3 Blanket_Conform368_g251558 = staticSwitch65_g251562;
					float4 appendResult312_g251558 = (float4(Blanket_Conform368_g251558 , 0.0));
					float4 temp_output_310_0_g251558 = ( Model_TransformData356_g251558 + appendResult312_g251558 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251558 = temp_output_310_0_g251558;
					#else
					float4 staticSwitch364_g251558 = Model_TransformData356_g251558;
					#endif
					half4 Final_TransformData365_g251558 = staticSwitch364_g251558;
					float4 In_TransformData16_g251567 = Final_TransformData365_g251558;
					float4 In_RotationData16_g251567 = Out_RotationData15_g251566;
					float4 In_Interpolator16_g251567 = Out_Interpolator15_g251566;
					BuildVertexData( Data16_g251567 , In_Dummy16_g251567 , In_PositionOS16_g251567 , In_NormalOS16_g251567 , In_TangentOS16_g251567 , In_TransformData16_g251567 , In_RotationData16_g251567 , In_Interpolator16_g251567 );
					TVEVertexData Data15_g251578 =(TVEVertexData)Data16_g251567;
					float Out_Dummy15_g251578 = 0.0;
					float3 Out_PositionOS15_g251578 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251578 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251578 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251578 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251578 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251578 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251578 , Out_Dummy15_g251578 , Out_PositionOS15_g251578 , Out_NormalOS15_g251578 , Out_TangentOS15_g251578 , Out_TransformData15_g251578 , Out_RotationData15_g251578 , Out_Interpolator15_g251578 );
					TVEVertexData Data16_g251579 =(TVEVertexData)Data15_g251578;
					float In_Dummy16_g251579 = 0.0;
					float3 Vertex_PositionOS147_g251569 = Out_PositionOS15_g251578;
					half3 VertexPos40_g251573 = Vertex_PositionOS147_g251569;
					float4 temp_output_1615_33_g251569 = Out_RotationData15_g251578;
					half4 Vertex_RotationData1569_g251569 = temp_output_1615_33_g251569;
					float2 break1582_g251569 = (Vertex_RotationData1569_g251569).xy;
					half Angle44_g251573 = break1582_g251569.y;
					half CosAngle89_g251573 = cos( Angle44_g251573 );
					half SinAngle93_g251573 = sin( Angle44_g251573 );
					float3 appendResult95_g251573 = (float3((VertexPos40_g251573).x , ( ( (VertexPos40_g251573).y * CosAngle89_g251573 ) - ( (VertexPos40_g251573).z * SinAngle93_g251573 ) ) , ( ( (VertexPos40_g251573).y * SinAngle93_g251573 ) + ( (VertexPos40_g251573).z * CosAngle89_g251573 ) )));
					half3 VertexPos40_g251574 = appendResult95_g251573;
					half Angle44_g251574 = -break1582_g251569.x;
					half CosAngle94_g251574 = cos( Angle44_g251574 );
					half SinAngle95_g251574 = sin( Angle44_g251574 );
					float3 appendResult98_g251574 = (float3(( ( (VertexPos40_g251574).x * CosAngle94_g251574 ) - ( (VertexPos40_g251574).y * SinAngle95_g251574 ) ) , ( ( (VertexPos40_g251574).x * SinAngle95_g251574 ) + ( (VertexPos40_g251574).y * CosAngle94_g251574 ) ) , (VertexPos40_g251574).z));
					half3 VertexPos40_g251572 = Vertex_PositionOS147_g251569;
					half Angle44_g251572 = break1582_g251569.y;
					half CosAngle89_g251572 = cos( Angle44_g251572 );
					half SinAngle93_g251572 = sin( Angle44_g251572 );
					float3 appendResult95_g251572 = (float3((VertexPos40_g251572).x , ( ( (VertexPos40_g251572).y * CosAngle89_g251572 ) - ( (VertexPos40_g251572).z * SinAngle93_g251572 ) ) , ( ( (VertexPos40_g251572).y * SinAngle93_g251572 ) + ( (VertexPos40_g251572).z * CosAngle89_g251572 ) )));
					half3 VertexPos40_g251577 = appendResult95_g251572;
					half Angle44_g251577 = break1582_g251569.x;
					half CosAngle91_g251577 = cos( Angle44_g251577 );
					half SinAngle92_g251577 = sin( Angle44_g251577 );
					float3 appendResult93_g251577 = (float3(( ( (VertexPos40_g251577).x * CosAngle91_g251577 ) + ( (VertexPos40_g251577).z * SinAngle92_g251577 ) ) , (VertexPos40_g251577).y , ( ( -(VertexPos40_g251577).x * SinAngle92_g251577 ) + ( (VertexPos40_g251577).z * CosAngle91_g251577 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251575 = appendResult93_g251577;
					#else
					float3 staticSwitch65_g251575 = appendResult98_g251574;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251570 = staticSwitch65_g251575;
					#else
					float3 staticSwitch65_g251570 = Vertex_PositionOS147_g251569;
					#endif
					float3 temp_output_1608_0_g251569 = staticSwitch65_g251570;
					half3 VertexPos40_g251576 = temp_output_1608_0_g251569;
					half Angle44_g251576 = (Vertex_RotationData1569_g251569).z;
					half CosAngle91_g251576 = cos( Angle44_g251576 );
					half SinAngle92_g251576 = sin( Angle44_g251576 );
					float3 appendResult93_g251576 = (float3(( ( (VertexPos40_g251576).x * CosAngle91_g251576 ) + ( (VertexPos40_g251576).z * SinAngle92_g251576 ) ) , (VertexPos40_g251576).y , ( ( -(VertexPos40_g251576).x * SinAngle92_g251576 ) + ( (VertexPos40_g251576).z * CosAngle91_g251576 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251571 = appendResult93_g251576;
					#else
					float3 staticSwitch65_g251571 = temp_output_1608_0_g251569;
					#endif
					float4 temp_output_1615_31_g251569 = Out_TransformData15_g251578;
					half4 Vertex_TransformData1568_g251569 = temp_output_1615_31_g251569;
					half3 Final_PositionOS178_g251569 = ( ( staticSwitch65_g251571 * (Vertex_TransformData1568_g251569).w ) + (Vertex_TransformData1568_g251569).xyz );
					float3 In_PositionOS16_g251579 = Final_PositionOS178_g251569;
					float3 In_NormalOS16_g251579 = Out_NormalOS15_g251578;
					float4 In_TangentOS16_g251579 = Out_TangentOS15_g251578;
					float4 In_TransformData16_g251579 = temp_output_1615_31_g251569;
					float4 In_RotationData16_g251579 = temp_output_1615_33_g251569;
					float4 In_Interpolator16_g251579 = Out_Interpolator15_g251578;
					BuildVertexData( Data16_g251579 , In_Dummy16_g251579 , In_PositionOS16_g251579 , In_NormalOS16_g251579 , In_TangentOS16_g251579 , In_TransformData16_g251579 , In_RotationData16_g251579 , In_Interpolator16_g251579 );
					TVEVertexData Data15_g251582 =(TVEVertexData)Data16_g251579;
					float Out_Dummy15_g251582 = 0.0;
					float3 Out_PositionOS15_g251582 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251582 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251582 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251582 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251582 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251582 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251582 , Out_Dummy15_g251582 , Out_PositionOS15_g251582 , Out_NormalOS15_g251582 , Out_TangentOS15_g251582 , Out_TransformData15_g251582 , Out_RotationData15_g251582 , Out_Interpolator15_g251582 );
					TVEVertexData Data16_g251583 =(TVEVertexData)Data15_g251582;
					float In_Dummy16_g251583 = 0.0;
					TVEModelData Data15_g251581 =(TVEModelData)Data15_g251565;
					float Out_Dummy15_g251581 = 0.0;
					float3 Out_PositionOS15_g251581 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251581 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251581 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251581 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251581 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251581 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251581 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251581 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251581 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251581 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251581 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251581 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251581 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251581 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251581 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251581 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251581 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251581 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251581 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251581 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251581 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251581 , Out_Dummy15_g251581 , Out_PositionOS15_g251581 , Out_PositionWS15_g251581 , Out_PositionWO15_g251581 , Out_PositionRawOS15_g251581 , Out_PivotOS15_g251581 , Out_PivotWS15_g251581 , Out_PivotWO15_g251581 , Out_NormalOS15_g251581 , Out_NormalWS15_g251581 , Out_NormalRawOS15_g251581 , Out_TangentOS15_g251581 , Out_TangentWS15_g251581 , Out_BitangentWS15_g251581 , Out_ViewDirWS15_g251581 , Out_CoordsData15_g251581 , Out_VertexData15_g251581 , Out_MasksData15_g251581 , Out_PhaseData15_g251581 , Out_TransformData15_g251581 , Out_RotationData15_g251581 , Out_Interpolator15_g251581 );
					float3 In_PositionOS16_g251583 = ( Out_PositionOS15_g251582 + Out_PivotOS15_g251581 );
					float3 In_NormalOS16_g251583 = Out_NormalOS15_g251582;
					float4 In_TangentOS16_g251583 = Out_TangentOS15_g251582;
					float4 In_TransformData16_g251583 = Out_TransformData15_g251582;
					float4 In_RotationData16_g251583 = Out_RotationData15_g251582;
					float4 In_Interpolator16_g251583 = Out_Interpolator15_g251582;
					BuildVertexData( Data16_g251583 , In_Dummy16_g251583 , In_PositionOS16_g251583 , In_NormalOS16_g251583 , In_TangentOS16_g251583 , In_TransformData16_g251583 , In_RotationData16_g251583 , In_Interpolator16_g251583 );
					TVEVertexData Data15_g251728 =(TVEVertexData)Data16_g251583;
					float Out_Dummy15_g251728 = 0.0;
					float3 Out_PositionOS15_g251728 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251728 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251728 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251728 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251728 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251728 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251728 , Out_Dummy15_g251728 , Out_PositionOS15_g251728 , Out_NormalOS15_g251728 , Out_TangentOS15_g251728 , Out_TransformData15_g251728 , Out_RotationData15_g251728 , Out_Interpolator15_g251728 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251728;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251728;
					v.tangent = Out_TangentOS15_g251728;

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
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":2631,"pos":[-7296,-5376],"params":["Inherit","False","Property","_IsShaderType","_IsShaderType","34","0","Create","True","0","0","0","False","0","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2635,"pos":[-6912,-4736],"params":["Inherit","False","If Model Data","-1","","242408","d269c9c511ff160419055604aade1e70","1,32,1","9","3","OBJECT","0","False","17","OBJECT","0","False","19","FLOAT","0","False","33","OBJECT","0","False","27","OBJECT","0","False","28","OBJECT","0","False","29","OBJECT","0","False","30","OBJECT","0","False","31","FLOAT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2637,"pos":[-7104,-5376],"params":["Half","False","IsShaderType","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2373,"pos":[-6592,-4736],"params":["Half","False","Model Frag","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2632,"pos":[-7296,-4864],"params":["Inherit","False","Block Model","21","","242409","7ad7765e793a6714babedee0033c36e9","19,463,0,289,0,240,0,437,0,291,0,431,0,404,0,290,0,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0","11","102","FLOAT3","0,0,0","False","163","FLOAT3","0,0,0","False","186","FLOAT3","0,0,0","False","187","FLOAT3","0,0,0","False","166","FLOAT3","0,0,0","False","164","FLOAT3","0,0,0","False","301","FLOAT3","0,0,0","False","418","FLOAT3","0,0,0","False","167","FLOAT4","0,0,0,0","False","172","FLOAT4","0,0,0,0","False","175","FLOAT4","0,0,0,0","False","2","OBJECT","128","OBJECT","314"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2374,"pos":[-6144,-4992],"params":["Inherit","False","2373","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2634,"pos":[-7296,-4992],"params":["Inherit","False","Block Model","21","","242429","7ad7765e793a6714babedee0033c36e9","19,463,1,289,1,240,1,437,1,291,1,431,1,404,1,290,1,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0","11","102","FLOAT3","0,0,0","False","163","FLOAT3","0,0,0","False","186","FLOAT3","0,0,0","False","187","FLOAT3","0,0,0","False","166","FLOAT3","0,0,0","False","164","FLOAT3","0,0,0","False","301","FLOAT3","0,0,0","False","418","FLOAT3","0,0,0","False","167","FLOAT4","0,0,0,0","False","172","FLOAT4","0,0,0,0","False","175","FLOAT4","0,0,0,0","False","2","OBJECT","128","OBJECT","314"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2633,"pos":[-7296,-4608],"params":["Inherit","False","2637","IsShaderType","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2375,"pos":[-5888,-4992],"params":["Inherit","False","Block Global","35","","242450","212e17d4006dc88449d56ce0340cb5ff","46,385,1,692,1,667,1,276,1,396,1,417,1,282,1,402,1,560,1,285,1,283,1,308,1,650,1,483,0,484,0,486,0,488,0,561,0,487,0,652,0,482,0,485,0,668,0,691,0,315,1,703,1,719,1,716,1,715,1,709,1,710,1,706,1,701,1,704,1,707,1,655,0,311,1,317,1,421,1,321,1,398,1,700,0,694,1,713,1,404,1,675,0","1","206","OBJECT","0,0,0,0","False","1","OBJECT","151"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2636,"pos":[-6912,-4992],"params":["Inherit","False","If Model Data","-1","","242551","d269c9c511ff160419055604aade1e70","1,32,1","9","3","OBJECT","0","False","17","OBJECT","0","False","19","FLOAT","0","False","33","OBJECT","0","False","27","OBJECT","0","False","28","OBJECT","0","False","29","OBJECT","0","False","30","OBJECT","0","False","31","FLOAT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2505,"pos":[-5568,-4992],"params":["Half","False","Global Data","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2377,"pos":[-6592,-4992],"params":["Half","False","Model Vert","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2655,"pos":[-5120,-4992],"params":["Inherit","False","2377","Model Vert","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2656,"pos":[-5120,-4928],"params":["Inherit","False","2505","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2654,"pos":[-4864,-4992],"params":["Inherit","False","Block Vertex","-1","","251551","79888a886ac7456468e9ffe3eda11f4f","0","2","1894","OBJECT","0,0,0,0","False","1896","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","1895","OBJECT","1897"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2604,"pos":[-4480,-4992],"params":["Inherit","False","Block Pivots Sub","-1","","251554","186f08b1bbe15894d9c677d50398679b","0","3","224","OBJECT","0,0,0,0","False","146","OBJECT","0,0,0,0","False","231","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","229","OBJECT","232"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2606,"pos":[-4096,-4992],"params":["Inherit","False","Block Blanket Conform","140","","251558","3ce1684c4351aeb42b79a955aa483301","2,389,0,377,1","3","146","OBJECT","0,0,0,0","False","397","OBJECT","0,0,0,0","False","186","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","398","OBJECT","399"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2610,"pos":[-3712,-4992],"params":["Inherit","False","Block Transform","-1","","251569","5ac6202bdddd8b34a85c261af6b8de8b","0","3","146","OBJECT","0,0,0,0","False","1620","OBJECT","0,0,0,0","False","1619","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","1617","OBJECT","1618"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2607,"pos":[-3328,-4992],"params":["Inherit","False","Block Pivots Add","-1","","251580","016babe9e3e643242aa4d123a988150c","0","3","146","OBJECT","0,0,0,0","False","225","OBJECT","0,0,0,0","False","227","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","226","OBJECT","228"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2608,"pos":[-3008,-4992],"params":["Half","False","Vertex Data","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2507,"pos":[-896,-4864],"params":["Inherit","False","2505","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2508,"pos":[-896,-4928],"params":["Inherit","False","2377","Model Vert","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2653,"pos":[-896,-4992],"params":["Inherit","False","2608","Vertex Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2657,"pos":[-640,-4992],"params":["Inherit","False","Block Transfer","7","","251655","763e552cdbe87d34bb26108bbb845dcd","3,1843,0,1844,0,1875,1","3","1861","OBJECT","0,0,0,0","False","146","OBJECT","0,0,0,0","False","1631","OBJECT","0,0,0,0","False","4","OBJECT","1863","OBJECT","128","OBJECT","1864","OBJECT","1785"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2509,"pos":[-256,-4992],"params":["Inherit","False","Break Masks Data","-1","","251669","23311522ecc97b54e8b77d849401069d","0","1","6","OBJECT","0","False","8","FLOAT4","14","FLOAT4","0","FLOAT4","23","FLOAT4","5","FLOAT4","24","FLOAT4","25","FLOAT4","26","FLOAT4","27"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2551,"pos":[512,-4992],"params":["Inherit","False","Tool Debug Active","16","","251670","0bb5baa3fd5a859489bbfc09acf77496","0","2","80","FLOAT3","0,0,0","False","102","FLOAT","0","False","2","FLOAT3","108","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2567,"pos":[512,-4864],"params":["Inherit","False","FLOAT","0","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2511,"pos":[512,-4480],"params":["Inherit","False","FLOAT3","0","1","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.TransformDirectionNode, AmplifyShaderEditor","id":2643,"pos":[768,-4352],"params":["Inherit","False","Object","World","True","Fast","True","1","0","FLOAT3","0,0,0","False","4","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":2568,"pos":[768,-4992],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2513,"pos":[512,-4736],"params":["Inherit","False","FLOAT3","0","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2585,"pos":[1152,-4480],"params":["Inherit","False","Tool Debug Index","-1","","251672","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","4","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2642,"pos":[1152,-4352],"params":["Inherit","False","Tool Debug Index","-1","","251673","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","5","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2651,"pos":[-2560,-4864],"params":["Inherit","False","2505","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2379,"pos":[-2560,-4928],"params":["Inherit","False","2373","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2652,"pos":[-2560,-4992],"params":["Inherit","False","2608","Vertex Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2594,"pos":[1152,-4992],"params":["Inherit","False","Tool Debug Index","-1","","251674","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2523,"pos":[1536,-4480],"params":["Inherit","False","2","2","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2586,"pos":[1152,-4736],"params":["Inherit","False","Tool Debug Index","-1","","251675","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","2","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2550,"pos":[1792,-4992],"params":["Inherit","False","3","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2658,"pos":[-2304,-4992],"params":["Inherit","False","Block Visual","-1","","251676","9511980f05dcfdf4d8967cd55c0d1784","1,1910,1","3","1904","OBJECT","0,0,0,0","False","1894","OBJECT","0,0,0,0","False","1896","OBJECT","0,0,0,0","False","3","OBJECT","1900","OBJECT","1895","OBJECT","1897"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2380,"pos":[-1920,-4992],"params":["Inherit","False","Block Main","114","","251680","b04cfed9a7b4c0841afdb49a38c282c5","13,65,1,136,1,41,1,133,1,40,1,344,0,347,0,342,0,346,0,343,0,345,0,329,1,408,1","3","430","OBJECT","0,0,0,0","False","225","OBJECT","0,0,0,0","False","414","OBJECT","0,0,0,0","False","3","OBJECT","106","OBJECT","417","OBJECT","415"]}
{"type":"AmplifyShaderEditor.VertexToFragmentNode, AmplifyShaderEditor","id":2524,"pos":[1920,-4992],"params":["Inherit","False","False","False","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2454,"pos":[-1600,-4992],"params":["Half","False","Visual Data","-1","True","1","0","OBJECT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2399,"pos":[2240,-4992],"params":["Half","False","Final_Debug","-1","True","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2400,"pos":[2816,-4992],"params":["Inherit","False","2399","Final_Debug","1","0","OBJECT","","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2563,"pos":[2816,-4928],"params":["Inherit","False","2454","Visual Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2555,"pos":[2816,-4864],"params":["Inherit","False","2608","Vertex Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2203,"pos":[3456,-5120],"params":["Inherit","False","Base Compile","-1","","251719","e67c8238031dbf04ab79a5d4d63d1b4f","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2609,"pos":[3072,-4992],"params":["Inherit","False","Tool Debug Color","0","","251720","d992d3ed4a7539141ba053d3e0c12277","0","3","80","FLOAT3","0,0,0","False","106","OBJECT","0,0,0","False","107","OBJECT","0,0,0","False","5","FLOAT","114","FLOAT3","0","FLOAT3","113","FLOAT3","148","FLOAT4","149"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2355,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","15","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ForwardAdd","0","2","ForwardAdd","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","4","1","False","","1","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","","False","False","False","True","1","LightMode=ForwardAdd","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2356,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","15","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","Deferred","0","3","Deferred","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=Deferred","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2357,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","15","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","Meta","0","4","Meta","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=Meta","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2358,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","15","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ShadowCaster","0","5","ShadowCaster","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","True","3","False","","False","False","True","1","LightMode=ShadowCaster","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2353,"pos":[3072,-4992],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","15","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ExtraPrePass","0","0","ExtraPrePass","5","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2354,"pos":[3456,-4992],"params":["Float","False","True","-1","3","","0","3","Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Transfer","28cd5599e02859647ae1798e4fcaef6c","True","ForwardBase","0","1","ForwardBase","15","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","2","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","40","Category","0","0","Workflow","0","638874882197810641","Surface","0","0","  Blend","0","0","  Dither Shadows","1","0","Two Sided","0","638874603607655403","Deferred Pass","1","0","Normal Space","0","0","Transmission","0","0","  Transmission Shadow","0.5,False,","0","Translucency","0","0","  Translucency Strength","1,False,","0","  Normal Distortion","0.5,False,","0","  Scattering","2,False,","0","  Direct","0.9,False,","0","  Ambient","0.1,False,","0","  Shadow","0.5,False,","0","Cast Shadows","0","638814711411603618","Receive Shadows","0","638814711415148256","Receive Specular","0","638814711419031593","GPU Instancing","1","638874881145939632","LOD CrossFade","0","638814711429956434","Built-in Fog","0","638814711441065168","Ambient Light","0","638814711449050123","Meta Pass","0","638814711456998358","Add Pass","0","638814711466594157","Override Baked GI","0","0","Write Depth","0","0","Extra Pre Pass","0","0","Tessellation","0","0","  Phong","0","0","  Strength","0.5,False,","0","  Type","0","0","  Tess","16,False,","0","  Min","10,False,","0","  Max","25,False,","0","  Edge Length","16,False,","0","  Max Displacement","25,False,","0","Disable Batching","0","638874882298697380","Vertex Position","0","638874601191422915","0","8","False","True","False","True","False","False","True","True","False","","True","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2638,"pos":[3072,-4932],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","15","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","SceneSelectionPass","0","6","SceneSelectionPass","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","False","False","False","True","1","LightMode=SceneSelectionPass","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2639,"pos":[3456,-4992],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","15","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ScenePickingPass","0","7","ScenePickingPass","1","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","False","False","False","True","1","LightMode=Picking","False","False","0","","0","0","Standard","0","False","0"]}
{"wire":[2635,33,2634,314]}
{"wire":[2635,27,2634,314]}
{"wire":[2635,28,2634,314]}
{"wire":[2635,29,2634,314]}
{"wire":[2635,30,2632,314]}
{"wire":[2635,31,2633,0]}
{"wire":[2637,0,2631,0]}
{"wire":[2373,0,2635,0]}
{"wire":[2375,206,2374,0]}
{"wire":[2636,33,2634,128]}
{"wire":[2636,27,2634,128]}
{"wire":[2636,28,2634,128]}
{"wire":[2636,29,2634,128]}
{"wire":[2636,30,2632,128]}
{"wire":[2636,31,2633,0]}
{"wire":[2505,0,2375,151]}
{"wire":[2377,0,2636,0]}
{"wire":[2654,1894,2655,0]}
{"wire":[2654,1896,2656,0]}
{"wire":[2604,224,2654,128]}
{"wire":[2604,146,2654,1895]}
{"wire":[2604,231,2654,1897]}
{"wire":[2606,146,2604,128]}
{"wire":[2606,397,2604,229]}
{"wire":[2606,186,2604,232]}
{"wire":[2610,146,2606,128]}
{"wire":[2610,1620,2606,398]}
{"wire":[2610,1619,2606,399]}
{"wire":[2607,146,2610,128]}
{"wire":[2607,225,2610,1617]}
{"wire":[2607,227,2610,1618]}
{"wire":[2608,0,2607,128]}
{"wire":[2657,1861,2653,0]}
{"wire":[2657,146,2508,0]}
{"wire":[2657,1631,2507,0]}
{"wire":[2509,6,2657,1785]}
{"wire":[2567,0,2509,14]}
{"wire":[2511,0,2509,23]}
{"wire":[2643,0,2511,0]}
{"wire":[2568,0,2551,108]}
{"wire":[2568,1,2551,0]}
{"wire":[2568,2,2567,0]}
{"wire":[2513,0,2509,0]}
{"wire":[2585,39,2511,0]}
{"wire":[2642,39,2643,0]}
{"wire":[2594,39,2568,0]}
{"wire":[2523,0,2585,0]}
{"wire":[2523,1,2642,0]}
{"wire":[2586,39,2513,0]}
{"wire":[2550,0,2594,0]}
{"wire":[2550,1,2586,0]}
{"wire":[2550,2,2523,0]}
{"wire":[2658,1904,2652,0]}
{"wire":[2658,1894,2379,0]}
{"wire":[2658,1896,2651,0]}
{"wire":[2380,430,2658,1900]}
{"wire":[2380,225,2658,1895]}
{"wire":[2380,414,2658,1897]}
{"wire":[2524,0,2550,0]}
{"wire":[2454,0,2380,106]}
{"wire":[2399,0,2524,0]}
{"wire":[2609,80,2400,0]}
{"wire":[2609,106,2563,0]}
{"wire":[2609,107,2555,0]}
{"wire":[2354,0,2609,114]}
{"wire":[2354,3,2609,114]}
{"wire":[2354,5,2609,114]}
{"wire":[2354,2,2609,0]}
{"wire":[2354,15,2609,113]}
{"wire":[2354,16,2609,148]}
{"wire":[2354,17,2609,149]}
ASEEND*/
//CHKSM=EA810D414602BE5CCAE628BDFFEE061CAD917AD6