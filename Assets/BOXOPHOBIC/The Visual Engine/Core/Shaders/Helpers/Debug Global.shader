// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Global"
{
	Properties
	{
		[HideInInspector] _IsTVEShader( "_IsTVEShader", Float ) = 0
		_RenderClip( "_RenderClip", Float ) = 0
		_IsElementShader( "_IsElementShader", Float ) = 0
		_IsHelperShader( "_IsHelperShader", Float ) = 0
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
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
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

				uniform half TVE_DEBUG_Index;
				uniform half TVE_DEBUG_Clip;
				uniform half TVE_DEBUG_Min;
				uniform half TVE_DEBUG_Max;
				uniform half TVE_DEBUG_Shading;
				uniform half _IsTVEShader;
				uniform half TVE_DEBUG_Filter;
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
				uniform float4 TVE_RenderBasePositionR;
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

					TVEVertexData Data16_g251819 =(TVEVertexData)0;
					float In_Dummy16_g251819 = 0.0;
					TVEVertexData Data16_g251813 =(TVEVertexData)0;
					float In_Dummy16_g251813 = 0.0;
					float localIfModelDataByShader26_g251590 = ( 0.0 );
					TVEModelData Data26_g251590 = (TVEModelData)0;
					TVEModelData Data16_g251630 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g251612 = _ObjectCoordMode;
					#else
					float staticSwitch343_g251612 = _ObjectCoordMode;
					#endif
					half Dummy207_g251612 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g251612 );
					float temp_output_14_0_g251630 = Dummy207_g251612;
					float In_Dummy16_g251630 = temp_output_14_0_g251630;
					float3 PositionOS131_g251612 = v.vertex.xyz;
					float3 temp_output_4_0_g251630 = PositionOS131_g251612;
					float3 In_PositionOS16_g251630 = temp_output_4_0_g251630;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g251612 = ase_positionWS;
					float3 vertexToFrag73_g251612 = temp_output_104_7_g251612;
					float3 PositionWS122_g251612 = vertexToFrag73_g251612;
					float3 In_PositionWS16_g251630 = PositionWS122_g251612;
					float4x4 break19_g251615 = unity_ObjectToWorld;
					float3 appendResult20_g251615 = (float3(break19_g251615[ 0 ][ 3 ] , break19_g251615[ 1 ][ 3 ] , break19_g251615[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251612 = appendResult20_g251615;
					float4x4 break19_g251617 = unity_ObjectToWorld;
					float3 appendResult20_g251617 = (float3(break19_g251617[ 0 ][ 3 ] , break19_g251617[ 1 ][ 3 ] , break19_g251617[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g251613 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g251612 = PositionOS131_g251612;
					float3 appendResult234_g251612 = (float3(break233_g251612.x , 0.0 , break233_g251612.z));
					float3 break413_g251612 = PositionOS131_g251612;
					float3 appendResult414_g251612 = (float3(break413_g251612.x , break413_g251612.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251619 = appendResult414_g251612;
					#else
					float3 staticSwitch65_g251619 = appendResult234_g251612;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g251612 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g251612 = appendResult60_g251613;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g251612 = staticSwitch65_g251619;
					#else
					float3 staticSwitch229_g251612 = _Vector0;
					#endif
					float3 PivotOS149_g251612 = staticSwitch229_g251612;
					float3 temp_output_122_0_g251617 = PivotOS149_g251612;
					float3 PivotsOnlyWS105_g251617 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g251617 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g251612 = ( appendResult20_g251617 + PivotsOnlyWS105_g251617 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g251612 = temp_output_340_7_g251612;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g251612 = temp_output_341_7_g251612;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g251612 = temp_output_341_7_g251612;
					#else
					float3 staticSwitch236_g251612 = temp_output_340_7_g251612;
					#endif
					float3 vertexToFrag76_g251612 = staticSwitch236_g251612;
					float3 PivotWS121_g251612 = vertexToFrag76_g251612;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251612 = ( PositionWS122_g251612 - PivotWS121_g251612 );
					#else
					float3 staticSwitch204_g251612 = PositionWS122_g251612;
					#endif
					float3 PositionWO132_g251612 = ( staticSwitch204_g251612 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251630 = PositionWO132_g251612;
					float3 In_PivotOS16_g251630 = PivotOS149_g251612;
					float3 In_PivotWS16_g251630 = PivotWS121_g251612;
					float3 PivotWO133_g251612 = ( PivotWS121_g251612 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251630 = PivotWO133_g251612;
					half3 NormalOS134_g251612 = v.normal;
					float3 temp_output_21_0_g251630 = NormalOS134_g251612;
					float3 In_NormalOS16_g251630 = temp_output_21_0_g251630;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g251612 = normalizedWorldNormal;
					float3 In_NormalWS16_g251630 = NormalWS95_g251612;
					half4 TangentlOS153_g251612 = v.tangent;
					float4 temp_output_6_0_g251630 = TangentlOS153_g251612;
					float4 In_TangentOS16_g251630 = temp_output_6_0_g251630;
					float3 normalizeResult296_g251612 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251612 ) );
					half3 ViewDirWS169_g251612 = normalizeResult296_g251612;
					float3 In_ViewDirWS16_g251630 = ViewDirWS169_g251612;
					float4 appendResult397_g251612 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g251612 = appendResult397_g251612;
					float4 In_CoordsData16_g251630 = CoordsData398_g251612;
					half4 VertexMasks171_g251612 = v.ase_color;
					float4 In_VertexData16_g251630 = VertexMasks171_g251612;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251624 = (PositionOS131_g251612).z;
					#else
					float staticSwitch65_g251624 = (PositionOS131_g251612).y;
					#endif
					half Object_HeightValue267_g251612 = _ObjectHeightValue;
					half Bounds_HeightMask274_g251612 = saturate( ( staticSwitch65_g251624 / Object_HeightValue267_g251612 ) );
					half3 Position387_g251612 = PositionOS131_g251612;
					half Height387_g251612 = Object_HeightValue267_g251612;
					half Object_RadiusValue268_g251612 = _ObjectRadiusValue;
					half Radius387_g251612 = Object_RadiusValue268_g251612;
					half localCapsuleMaskYUp387_g251612 = CapsuleMaskYUp( Position387_g251612 , Height387_g251612 , Radius387_g251612 );
					half3 Position408_g251612 = PositionOS131_g251612;
					half Height408_g251612 = Object_HeightValue267_g251612;
					half Radius408_g251612 = Object_RadiusValue268_g251612;
					half localCapsuleMaskZUp408_g251612 = CapsuleMaskZUp( Position408_g251612 , Height408_g251612 , Radius408_g251612 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251629 = saturate( localCapsuleMaskZUp408_g251612 );
					#else
					float staticSwitch65_g251629 = saturate( localCapsuleMaskYUp387_g251612 );
					#endif
					half Bounds_SphereMask282_g251612 = staticSwitch65_g251629;
					float4 appendResult253_g251612 = (float4(Bounds_HeightMask274_g251612 , Bounds_SphereMask282_g251612 , 1.0 , 1.0));
					half4 MasksData254_g251612 = appendResult253_g251612;
					float4 In_MasksData16_g251630 = MasksData254_g251612;
					float temp_output_17_0_g251623 = _ObjectPhaseMode;
					float Option70_g251623 = temp_output_17_0_g251623;
					float4 temp_output_3_0_g251623 = v.ase_color;
					float4 Channel70_g251623 = temp_output_3_0_g251623;
					float localSwitchChannel470_g251623 = SwitchChannel4( Option70_g251623 , Channel70_g251623 );
					half Phase_Value372_g251612 = localSwitchChannel470_g251623;
					float3 break319_g251612 = PivotWO133_g251612;
					half Pivot_Position322_g251612 = ( break319_g251612.x + break319_g251612.z );
					half Phase_Position357_g251612 = ( Phase_Value372_g251612 + Pivot_Position322_g251612 );
					float temp_output_248_0_g251612 = frac( Phase_Position357_g251612 );
					float4 appendResult177_g251612 = (float4((frac( ( Phase_Position357_g251612 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g251612));
					half4 Phase_Data176_g251612 = appendResult177_g251612;
					float4 In_PhaseData16_g251630 = Phase_Data176_g251612;
					BuildModelVertData( Data16_g251630 , In_Dummy16_g251630 , In_PositionOS16_g251630 , In_PositionWS16_g251630 , In_PositionWO16_g251630 , In_PivotOS16_g251630 , In_PivotWS16_g251630 , In_PivotWO16_g251630 , In_NormalOS16_g251630 , In_NormalWS16_g251630 , In_TangentOS16_g251630 , In_ViewDirWS16_g251630 , In_CoordsData16_g251630 , In_VertexData16_g251630 , In_MasksData16_g251630 , In_PhaseData16_g251630 );
					TVEModelData DataDefault26_g251590 = Data16_g251630;
					TVEModelData DataGeneral26_g251590 = Data16_g251630;
					TVEModelData DataBlanket26_g251590 = Data16_g251630;
					TVEModelData DataImpostor26_g251590 = Data16_g251630;
					TVEModelData Data16_g251610 =(TVEModelData)0;
					half Dummy207_g251592 = 0.0;
					float temp_output_14_0_g251610 = Dummy207_g251592;
					float In_Dummy16_g251610 = temp_output_14_0_g251610;
					float3 PositionOS131_g251592 = v.vertex.xyz;
					float3 temp_output_4_0_g251610 = PositionOS131_g251592;
					float3 In_PositionOS16_g251610 = temp_output_4_0_g251610;
					float3 temp_output_104_7_g251592 = ase_positionWS;
					float3 PositionWS122_g251592 = temp_output_104_7_g251592;
					float3 In_PositionWS16_g251610 = PositionWS122_g251592;
					float4x4 break19_g251595 = unity_ObjectToWorld;
					float3 appendResult20_g251595 = (float3(break19_g251595[ 0 ][ 3 ] , break19_g251595[ 1 ][ 3 ] , break19_g251595[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251592 = appendResult20_g251595;
					float3 PivotWS121_g251592 = temp_output_340_7_g251592;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251592 = ( PositionWS122_g251592 - PivotWS121_g251592 );
					#else
					float3 staticSwitch204_g251592 = PositionWS122_g251592;
					#endif
					float3 PositionWO132_g251592 = ( staticSwitch204_g251592 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251610 = PositionWO132_g251592;
					float3 PivotOS149_g251592 = _Vector0;
					float3 In_PivotOS16_g251610 = PivotOS149_g251592;
					float3 In_PivotWS16_g251610 = PivotWS121_g251592;
					float3 PivotWO133_g251592 = ( PivotWS121_g251592 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251610 = PivotWO133_g251592;
					half3 NormalOS134_g251592 = v.normal;
					float3 temp_output_21_0_g251610 = NormalOS134_g251592;
					float3 In_NormalOS16_g251610 = temp_output_21_0_g251610;
					half3 NormalWS95_g251592 = normalizedWorldNormal;
					float3 In_NormalWS16_g251610 = NormalWS95_g251592;
					float4 appendResult462_g251592 = (float4(cross( v.normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g251592 = appendResult462_g251592;
					float4 temp_output_6_0_g251610 = TangentlOS153_g251592;
					float4 In_TangentOS16_g251610 = temp_output_6_0_g251610;
					float3 normalizeResult296_g251592 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251592 ) );
					half3 ViewDirWS169_g251592 = normalizeResult296_g251592;
					float3 In_ViewDirWS16_g251610 = ViewDirWS169_g251592;
					float4 appendResult397_g251592 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g251592 = appendResult397_g251592;
					float4 In_CoordsData16_g251610 = CoordsData398_g251592;
					half4 VertexMasks171_g251592 = float4( 0,0,0,0 );
					float4 In_VertexData16_g251610 = VertexMasks171_g251592;
					half4 MasksData254_g251592 = float4( 0,0,0,0 );
					float4 In_MasksData16_g251610 = MasksData254_g251592;
					half4 Phase_Data176_g251592 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g251610 = Phase_Data176_g251592;
					BuildModelVertData( Data16_g251610 , In_Dummy16_g251610 , In_PositionOS16_g251610 , In_PositionWS16_g251610 , In_PositionWO16_g251610 , In_PivotOS16_g251610 , In_PivotWS16_g251610 , In_PivotWO16_g251610 , In_NormalOS16_g251610 , In_NormalWS16_g251610 , In_TangentOS16_g251610 , In_ViewDirWS16_g251610 , In_CoordsData16_g251610 , In_VertexData16_g251610 , In_MasksData16_g251610 , In_PhaseData16_g251610 );
					TVEModelData DataTerrain26_g251590 = Data16_g251610;
					half IsShaderType2544 = _IsShaderType;
					float Type26_g251590 = IsShaderType2544;
					{
					if (Type26_g251590 == 0 )
					{
					Data26_g251590 = DataDefault26_g251590;
					}
					else if (Type26_g251590 == 1 )
					{
					Data26_g251590 = DataGeneral26_g251590;
					}
					else if (Type26_g251590 == 2 )
					{
					Data26_g251590 = DataBlanket26_g251590;
					}
					else if (Type26_g251590 == 3 )
					{
					Data26_g251590 = DataImpostor26_g251590;
					}
					else if (Type26_g251590 == 4 )
					{
					Data26_g251590 = DataTerrain26_g251590;
					}
					}
					TVEModelData Data15_g251814 =(TVEModelData)Data26_g251590;
					float Out_Dummy15_g251814 = 0.0;
					float3 Out_PositionOS15_g251814 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251814 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251814 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251814 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251814 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251814 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251814 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251814 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251814 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251814 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251814 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251814 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251814 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251814 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251814 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251814 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251814 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251814 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251814 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251814 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251814 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251814 , Out_Dummy15_g251814 , Out_PositionOS15_g251814 , Out_PositionWS15_g251814 , Out_PositionWO15_g251814 , Out_PositionRawOS15_g251814 , Out_PivotOS15_g251814 , Out_PivotWS15_g251814 , Out_PivotWO15_g251814 , Out_NormalOS15_g251814 , Out_NormalWS15_g251814 , Out_NormalRawOS15_g251814 , Out_TangentOS15_g251814 , Out_TangentWS15_g251814 , Out_BitangentWS15_g251814 , Out_ViewDirWS15_g251814 , Out_CoordsData15_g251814 , Out_VertexData15_g251814 , Out_MasksData15_g251814 , Out_PhaseData15_g251814 , Out_TransformData15_g251814 , Out_RotationData15_g251814 , Out_Interpolator15_g251814 );
					float3 In_PositionOS16_g251813 = Out_PositionOS15_g251814;
					float3 In_NormalOS16_g251813 = Out_NormalOS15_g251814;
					float4 In_TangentOS16_g251813 = Out_TangentOS15_g251814;
					float4 In_TransformData16_g251813 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251813 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251813 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251813 , In_Dummy16_g251813 , In_PositionOS16_g251813 , In_NormalOS16_g251813 , In_TangentOS16_g251813 , In_TransformData16_g251813 , In_RotationData16_g251813 , In_Interpolator16_g251813 );
					TVEVertexData Data15_g251817 =(TVEVertexData)Data16_g251813;
					float Out_Dummy15_g251817 = 0.0;
					float3 Out_PositionOS15_g251817 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251817 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251817 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251817 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251817 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251817 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251817 , Out_Dummy15_g251817 , Out_PositionOS15_g251817 , Out_NormalOS15_g251817 , Out_TangentOS15_g251817 , Out_TransformData15_g251817 , Out_RotationData15_g251817 , Out_Interpolator15_g251817 );
					TVEModelData Data15_g251818 =(TVEModelData)Data15_g251814;
					float Out_Dummy15_g251818 = 0.0;
					float3 Out_PositionOS15_g251818 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251818 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251818 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251818 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251818 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251818 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251818 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251818 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251818 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251818 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251818 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251818 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251818 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251818 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251818 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251818 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251818 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251818 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251818 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251818 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251818 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251818 , Out_Dummy15_g251818 , Out_PositionOS15_g251818 , Out_PositionWS15_g251818 , Out_PositionWO15_g251818 , Out_PositionRawOS15_g251818 , Out_PivotOS15_g251818 , Out_PivotWS15_g251818 , Out_PivotWO15_g251818 , Out_NormalOS15_g251818 , Out_NormalWS15_g251818 , Out_NormalRawOS15_g251818 , Out_TangentOS15_g251818 , Out_TangentWS15_g251818 , Out_BitangentWS15_g251818 , Out_ViewDirWS15_g251818 , Out_CoordsData15_g251818 , Out_VertexData15_g251818 , Out_MasksData15_g251818 , Out_PhaseData15_g251818 , Out_TransformData15_g251818 , Out_RotationData15_g251818 , Out_Interpolator15_g251818 );
					float3 In_PositionOS16_g251819 = ( Out_PositionOS15_g251817 - Out_PivotOS15_g251818 );
					float3 In_NormalOS16_g251819 = Out_NormalOS15_g251818;
					float4 In_TangentOS16_g251819 = Out_TangentOS15_g251818;
					float4 In_TransformData16_g251819 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251819 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251819 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251819 , In_Dummy16_g251819 , In_PositionOS16_g251819 , In_NormalOS16_g251819 , In_TangentOS16_g251819 , In_TransformData16_g251819 , In_RotationData16_g251819 , In_Interpolator16_g251819 );
					TVEVertexData Data15_g251930 =(TVEVertexData)Data16_g251819;
					float Out_Dummy15_g251930 = 0.0;
					float3 Out_PositionOS15_g251930 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251930 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251930 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251930 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251930 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251930 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251930 , Out_Dummy15_g251930 , Out_PositionOS15_g251930 , Out_NormalOS15_g251930 , Out_TangentOS15_g251930 , Out_TransformData15_g251930 , Out_RotationData15_g251930 , Out_Interpolator15_g251930 );
					TVEVertexData Data16_g251931 =(TVEVertexData)Data15_g251930;
					half Dummy317_g251922 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251931 = Dummy317_g251922;
					float3 In_PositionOS16_g251931 = Out_PositionOS15_g251930;
					float3 In_NormalOS16_g251931 = Out_NormalOS15_g251930;
					float4 In_TangentOS16_g251931 = Out_TangentOS15_g251930;
					half4 Model_TransformData356_g251922 = Out_TransformData15_g251930;
					float localBuildGlobalData204_g251489 = ( 0.0 );
					TVEGlobalData Data204_g251489 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251489 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251489 = Dummy211_g251489;
					float4 temp_output_203_0_g251508 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g251632 = ( 0.0 );
					TVEModelData Data26_g251632 = (TVEModelData)0;
					TVEModelData Data16_g251620 =(TVEModelData)0;
					float In_Dummy16_g251620 = 0.0;
					float3 In_PositionWS16_g251620 = PositionWS122_g251612;
					float3 In_PositionWO16_g251620 = PositionWO132_g251612;
					float3 In_PivotWS16_g251620 = PivotWS121_g251612;
					float3 In_PivotWO16_g251620 = PivotWO133_g251612;
					float3 In_NormalWS16_g251620 = NormalWS95_g251612;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g251612 = ase_tangentWS;
					float3 In_TangentWS16_g251620 = TangentWS136_g251612;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g251612 = ase_bitangentWS;
					float3 In_BitangentWS16_g251620 = BiangentWS421_g251612;
					half3 NormalWS427_g251612 = NormalWS95_g251612;
					half3 localComputeTriplanarMasks427_g251612 = ComputeTriplanarMasks( NormalWS427_g251612 );
					half3 TriplanarWeights429_g251612 = localComputeTriplanarMasks427_g251612;
					float3 In_TriplanarWeights16_g251620 = TriplanarWeights429_g251612;
					float3 In_ViewDirWS16_g251620 = ViewDirWS169_g251612;
					float4 In_CoordsData16_g251620 = CoordsData398_g251612;
					float4 In_VertexData16_g251620 = VertexMasks171_g251612;
					float4 In_Interpolator16_g251620 = Phase_Data176_g251612;
					BuildModelFragData( Data16_g251620 , In_Dummy16_g251620 , In_PositionWS16_g251620 , In_PositionWO16_g251620 , In_PivotWS16_g251620 , In_PivotWO16_g251620 , In_NormalWS16_g251620 , In_TangentWS16_g251620 , In_BitangentWS16_g251620 , In_TriplanarWeights16_g251620 , In_ViewDirWS16_g251620 , In_CoordsData16_g251620 , In_VertexData16_g251620 , In_Interpolator16_g251620 );
					TVEModelData DataDefault26_g251632 = Data16_g251620;
					TVEModelData DataGeneral26_g251632 = Data16_g251620;
					TVEModelData DataBlanket26_g251632 = Data16_g251620;
					TVEModelData DataImpostor26_g251632 = Data16_g251620;
					TVEModelData Data16_g251600 =(TVEModelData)0;
					float In_Dummy16_g251600 = 0.0;
					float3 In_PositionWS16_g251600 = PositionWS122_g251592;
					float3 In_PositionWO16_g251600 = PositionWO132_g251592;
					float3 In_PivotWS16_g251600 = PivotWS121_g251592;
					float3 In_PivotWO16_g251600 = PivotWO133_g251592;
					float3 In_NormalWS16_g251600 = NormalWS95_g251592;
					half3 TangentWS136_g251592 = ase_tangentWS;
					float3 In_TangentWS16_g251600 = TangentWS136_g251592;
					half3 BiangentWS421_g251592 = ase_bitangentWS;
					float3 In_BitangentWS16_g251600 = BiangentWS421_g251592;
					half3 NormalWS427_g251592 = NormalWS95_g251592;
					half3 localComputeTriplanarMasks427_g251592 = ComputeTriplanarMasks( NormalWS427_g251592 );
					half3 TriplanarWeights429_g251592 = localComputeTriplanarMasks427_g251592;
					float3 In_TriplanarWeights16_g251600 = TriplanarWeights429_g251592;
					float3 In_ViewDirWS16_g251600 = ViewDirWS169_g251592;
					float4 In_CoordsData16_g251600 = CoordsData398_g251592;
					float4 In_VertexData16_g251600 = VertexMasks171_g251592;
					float4 In_Interpolator16_g251600 = Phase_Data176_g251592;
					BuildModelFragData( Data16_g251600 , In_Dummy16_g251600 , In_PositionWS16_g251600 , In_PositionWO16_g251600 , In_PivotWS16_g251600 , In_PivotWO16_g251600 , In_NormalWS16_g251600 , In_TangentWS16_g251600 , In_BitangentWS16_g251600 , In_TriplanarWeights16_g251600 , In_ViewDirWS16_g251600 , In_CoordsData16_g251600 , In_VertexData16_g251600 , In_Interpolator16_g251600 );
					TVEModelData DataTerrain26_g251632 = Data16_g251600;
					float Type26_g251632 = IsShaderType2544;
					{
					if (Type26_g251632 == 0 )
					{
					Data26_g251632 = DataDefault26_g251632;
					}
					else if (Type26_g251632 == 1 )
					{
					Data26_g251632 = DataGeneral26_g251632;
					}
					else if (Type26_g251632 == 2 )
					{
					Data26_g251632 = DataBlanket26_g251632;
					}
					else if (Type26_g251632 == 3 )
					{
					Data26_g251632 = DataImpostor26_g251632;
					}
					else if (Type26_g251632 == 4 )
					{
					Data26_g251632 = DataTerrain26_g251632;
					}
					}
					TVEModelData Data15_g251579 =(TVEModelData)Data26_g251632;
					float Out_Dummy15_g251579 = 0.0;
					float3 Out_PositionWS15_g251579 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251579 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251579 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251579 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251579 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251579 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251579 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251579 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251579 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251579 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251579 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251579 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251579 , Out_Dummy15_g251579 , Out_PositionWS15_g251579 , Out_PositionWO15_g251579 , Out_PivotWS15_g251579 , Out_PivotWO15_g251579 , Out_NormalWS15_g251579 , Out_TangentWS15_g251579 , Out_BitangentWS15_g251579 , Out_TriplanarWeights15_g251579 , Out_ViewDirWS15_g251579 , Out_CoordsData15_g251579 , Out_VertexData15_g251579 , Out_Interpolator15_g251579 );
					float3 Model_PositionWS497_g251489 = Out_PositionWS15_g251579;
					float2 Model_PositionWS_XZ143_g251489 = (Model_PositionWS497_g251489).xz;
					float3 Model_PivotWS498_g251489 = Out_PivotWS15_g251579;
					float2 Model_PivotWS_XZ145_g251489 = (Model_PivotWS498_g251489).xz;
					float2 lerpResult300_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251508 = lerpResult300_g251489;
					float temp_output_82_0_g251506 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251508 = temp_output_82_0_g251506;
					float4 tex2DArrayNode83_g251508 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251508).zw + ( (temp_output_203_0_g251508).xy * temp_output_81_0_g251508 ) ),temp_output_82_0_g251508), 0.0 );
					float4 appendResult210_g251508 = (float4(tex2DArrayNode83_g251508.rgb , tex2DArrayNode83_g251508.a));
					float4 temp_output_204_0_g251508 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251508 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251508).zw + ( (temp_output_204_0_g251508).xy * temp_output_81_0_g251508 ) ),temp_output_82_0_g251508), 0.0 );
					float4 appendResult212_g251508 = (float4(tex2DArrayNode122_g251508.rgb , tex2DArrayNode122_g251508.a));
					float4 TVE_RenderNearPositionR628_g251489 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251489 = saturate( ( distance( Model_PositionWS497_g251489 , (TVE_RenderNearPositionR628_g251489).xyz ) / (TVE_RenderNearPositionR628_g251489).w ) );
					float temp_output_7_0_g251578 = 1.0;
					float temp_output_9_0_g251578 = ( temp_output_507_0_g251489 - temp_output_7_0_g251578 );
					half TVE_RenderNearFadeValue635_g251489 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251489 = saturate( ( temp_output_9_0_g251578 / ( ( TVE_RenderNearFadeValue635_g251489 - temp_output_7_0_g251578 ) + 0.0001 ) ) );
					float4 lerpResult131_g251508 = lerp( appendResult210_g251508 , appendResult212_g251508 , Global_TexBlend509_g251489);
					float4 temp_output_159_109_g251506 = lerpResult131_g251508;
					float4 lerpResult168_g251506 = lerp( TVE_CoatParams , temp_output_159_109_g251506 , TVE_CoatLayers[(int)temp_output_82_0_g251506]);
					float4 temp_output_589_109_g251489 = lerpResult168_g251506;
					half4 Coat_Texture302_g251489 = temp_output_589_109_g251489;
					float4 In_CoatTexture204_g251489 = Coat_Texture302_g251489;
					half4 Draw_Texture656_g251489 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g251489 = Draw_Texture656_g251489;
					float4 temp_output_203_0_g251533 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251533 = lerpResult85_g251489;
					float temp_output_82_0_g251530 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251533 = temp_output_82_0_g251530;
					float4 tex2DArrayNode83_g251533 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251533).zw + ( (temp_output_203_0_g251533).xy * temp_output_81_0_g251533 ) ),temp_output_82_0_g251533), 0.0 );
					float4 appendResult210_g251533 = (float4(tex2DArrayNode83_g251533.rgb , tex2DArrayNode83_g251533.a));
					float4 temp_output_204_0_g251533 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251533 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251533).zw + ( (temp_output_204_0_g251533).xy * temp_output_81_0_g251533 ) ),temp_output_82_0_g251533), 0.0 );
					float4 appendResult212_g251533 = (float4(tex2DArrayNode122_g251533.rgb , tex2DArrayNode122_g251533.a));
					float4 lerpResult131_g251533 = lerp( appendResult210_g251533 , appendResult212_g251533 , Global_TexBlend509_g251489);
					float4 temp_output_171_109_g251530 = lerpResult131_g251533;
					float4 lerpResult174_g251530 = lerp( TVE_PaintParams , temp_output_171_109_g251530 , TVE_PaintLayers[(int)temp_output_82_0_g251530]);
					float4 temp_output_595_109_g251489 = lerpResult174_g251530;
					half4 Paint_Texture71_g251489 = temp_output_595_109_g251489;
					float4 In_PaintTexture204_g251489 = Paint_Texture71_g251489;
					float4 temp_output_203_0_g251516 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251516 = lerpResult104_g251489;
					float temp_output_132_0_g251514 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251516 = temp_output_132_0_g251514;
					float4 tex2DArrayNode83_g251516 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251516).zw + ( (temp_output_203_0_g251516).xy * temp_output_81_0_g251516 ) ),temp_output_82_0_g251516), 0.0 );
					float4 appendResult210_g251516 = (float4(tex2DArrayNode83_g251516.rgb , tex2DArrayNode83_g251516.a));
					float4 temp_output_204_0_g251516 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251516 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251516).zw + ( (temp_output_204_0_g251516).xy * temp_output_81_0_g251516 ) ),temp_output_82_0_g251516), 0.0 );
					float4 appendResult212_g251516 = (float4(tex2DArrayNode122_g251516.rgb , tex2DArrayNode122_g251516.a));
					float4 lerpResult131_g251516 = lerp( appendResult210_g251516 , appendResult212_g251516 , Global_TexBlend509_g251489);
					float4 temp_output_137_109_g251514 = lerpResult131_g251516;
					float4 lerpResult145_g251514 = lerp( TVE_AtmoParams , temp_output_137_109_g251514 , TVE_AtmoLayers[(int)temp_output_132_0_g251514]);
					float4 temp_output_590_110_g251489 = lerpResult145_g251514;
					half4 Atmo_Texture80_g251489 = temp_output_590_110_g251489;
					float4 In_AtmoTexture204_g251489 = Atmo_Texture80_g251489;
					float4 temp_output_203_0_g251584 = TVE_EffexBaseCoord;
					float2 lerpResult414_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g251584 = lerpResult414_g251489;
					float temp_output_132_0_g251582 = _GlobalEffexLayerValue;
					float temp_output_82_0_g251584 = temp_output_132_0_g251582;
					float4 tex2DArrayNode83_g251584 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251584).zw + ( (temp_output_203_0_g251584).xy * temp_output_81_0_g251584 ) ),temp_output_82_0_g251584), 0.0 );
					float4 appendResult210_g251584 = (float4(tex2DArrayNode83_g251584.rgb , tex2DArrayNode83_g251584.a));
					float4 temp_output_204_0_g251584 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g251584 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251584).zw + ( (temp_output_204_0_g251584).xy * temp_output_81_0_g251584 ) ),temp_output_82_0_g251584), 0.0 );
					float4 appendResult212_g251584 = (float4(tex2DArrayNode122_g251584.rgb , tex2DArrayNode122_g251584.a));
					float4 lerpResult131_g251584 = lerp( appendResult210_g251584 , appendResult212_g251584 , Global_TexBlend509_g251489);
					float4 temp_output_137_109_g251582 = lerpResult131_g251584;
					float4 lerpResult145_g251582 = lerp( TVE_EffexParams , temp_output_137_109_g251582 , TVE_EffexLayers[(int)temp_output_132_0_g251582]);
					float4 temp_output_731_110_g251489 = lerpResult145_g251582;
					half4 Effex_Texture420_g251489 = temp_output_731_110_g251489;
					float4 In_EffexTexture204_g251489 = Effex_Texture420_g251489;
					float4 temp_output_203_0_g251564 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251564 = lerpResult247_g251489;
					float temp_output_82_0_g251562 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251564 = temp_output_82_0_g251562;
					float4 tex2DArrayNode83_g251564 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251564).zw + ( (temp_output_203_0_g251564).xy * temp_output_81_0_g251564 ) ),temp_output_82_0_g251564), 0.0 );
					float4 appendResult210_g251564 = (float4(tex2DArrayNode83_g251564.rgb , tex2DArrayNode83_g251564.a));
					float4 temp_output_204_0_g251564 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251564 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251564).zw + ( (temp_output_204_0_g251564).xy * temp_output_81_0_g251564 ) ),temp_output_82_0_g251564), 0.0 );
					float4 appendResult212_g251564 = (float4(tex2DArrayNode122_g251564.rgb , tex2DArrayNode122_g251564.a));
					float4 lerpResult131_g251564 = lerp( appendResult210_g251564 , appendResult212_g251564 , Global_TexBlend509_g251489);
					float4 temp_output_159_109_g251562 = lerpResult131_g251564;
					float4 lerpResult167_g251562 = lerp( TVE_GlowParams , temp_output_159_109_g251562 , TVE_GlowLayers[(int)temp_output_82_0_g251562]);
					float4 temp_output_593_109_g251489 = lerpResult167_g251562;
					half4 Glow_Texture248_g251489 = temp_output_593_109_g251489;
					float4 In_GlowTexture204_g251489 = Glow_Texture248_g251489;
					float4 temp_output_203_0_g251500 = TVE_FormBaseCoord;
					float2 lerpResult168_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251500 = lerpResult168_g251489;
					float temp_output_130_0_g251498 = _GlobalFormLayerValue;
					float temp_output_82_0_g251500 = temp_output_130_0_g251498;
					float4 tex2DArrayNode83_g251500 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251500).zw + ( (temp_output_203_0_g251500).xy * temp_output_81_0_g251500 ) ),temp_output_82_0_g251500), 0.0 );
					float4 appendResult210_g251500 = (float4(tex2DArrayNode83_g251500.rgb , tex2DArrayNode83_g251500.a));
					float4 temp_output_204_0_g251500 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251500 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251500).zw + ( (temp_output_204_0_g251500).xy * temp_output_81_0_g251500 ) ),temp_output_82_0_g251500), 0.0 );
					float4 appendResult212_g251500 = (float4(tex2DArrayNode122_g251500.rgb , tex2DArrayNode122_g251500.a));
					float4 lerpResult131_g251500 = lerp( appendResult210_g251500 , appendResult212_g251500 , Global_TexBlend509_g251489);
					float4 temp_output_135_109_g251498 = lerpResult131_g251500;
					float4 lerpResult143_g251498 = lerp( TVE_FormParams , temp_output_135_109_g251498 , TVE_FormLayers[(int)temp_output_130_0_g251498]);
					float4 temp_output_592_0_g251489 = lerpResult143_g251498;
					float4 Form_Texture112_g251489 = temp_output_592_0_g251489;
					float4 In_FormTexture204_g251489 = Form_Texture112_g251489;
					float4 In_LandTexture204_g251489 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g251548 = TVE_VertxBaseCoord;
					float2 lerpResult681_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g251548 = lerpResult681_g251489;
					float temp_output_136_0_g251546 = _GlobalVertxLayerValue;
					float temp_output_82_0_g251548 = temp_output_136_0_g251546;
					float4 tex2DArrayNode83_g251548 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251548).zw + ( (temp_output_203_0_g251548).xy * temp_output_81_0_g251548 ) ),temp_output_82_0_g251548), 0.0 );
					float4 appendResult210_g251548 = (float4(tex2DArrayNode83_g251548.rgb , tex2DArrayNode83_g251548.a));
					float4 temp_output_204_0_g251548 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g251548 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251548).zw + ( (temp_output_204_0_g251548).xy * temp_output_81_0_g251548 ) ),temp_output_82_0_g251548), 0.0 );
					float4 appendResult212_g251548 = (float4(tex2DArrayNode122_g251548.rgb , tex2DArrayNode122_g251548.a));
					float4 lerpResult131_g251548 = lerp( appendResult210_g251548 , appendResult212_g251548 , Global_TexBlend509_g251489);
					float4 temp_output_141_109_g251546 = lerpResult131_g251548;
					float4 lerpResult149_g251546 = lerp( TVE_VertxParams , temp_output_141_109_g251546 , TVE_VertxLayers[(int)temp_output_136_0_g251546]);
					float4 temp_output_695_0_g251489 = lerpResult149_g251546;
					half4 Vertx_Texture693_g251489 = temp_output_695_0_g251489;
					float4 In_VertxTexture204_g251489 = Vertx_Texture693_g251489;
					float4 temp_output_203_0_g251524 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251524 = lerpResult400_g251489;
					float temp_output_136_0_g251522 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251524 = temp_output_136_0_g251522;
					float4 tex2DArrayNode83_g251524 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251524).zw + ( (temp_output_203_0_g251524).xy * temp_output_81_0_g251524 ) ),temp_output_82_0_g251524), 0.0 );
					float4 appendResult210_g251524 = (float4(tex2DArrayNode83_g251524.rgb , tex2DArrayNode83_g251524.a));
					float4 temp_output_204_0_g251524 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251524 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251524).zw + ( (temp_output_204_0_g251524).xy * temp_output_81_0_g251524 ) ),temp_output_82_0_g251524), 0.0 );
					float4 appendResult212_g251524 = (float4(tex2DArrayNode122_g251524.rgb , tex2DArrayNode122_g251524.a));
					float4 lerpResult131_g251524 = lerp( appendResult210_g251524 , appendResult212_g251524 , Global_TexBlend509_g251489);
					float4 temp_output_141_109_g251522 = lerpResult131_g251524;
					float4 lerpResult149_g251522 = lerp( TVE_FlowParams , temp_output_141_109_g251522 , TVE_FlowLayers[(int)temp_output_136_0_g251522]);
					float4 temp_output_594_0_g251489 = lerpResult149_g251522;
					half4 Flow_Texture405_g251489 = temp_output_594_0_g251489;
					float4 In_FlowTexture204_g251489 = Flow_Texture405_g251489;
					half4 User_Texture677_g251489 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g251489 = User_Texture677_g251489;
					BuildGlobalData( Data204_g251489 , In_Dummy204_g251489 , In_CoatTexture204_g251489 , In_DrawTexture204_g251489 , In_PaintTexture204_g251489 , In_AtmoTexture204_g251489 , In_EffexTexture204_g251489 , In_GlowTexture204_g251489 , In_FormTexture204_g251489 , In_LandTexture204_g251489 , In_VertxTexture204_g251489 , In_FlowTexture204_g251489 , In_UserTexture204_g251489 );
					TVEGlobalData Data15_g251932 =(TVEGlobalData)Data204_g251489;
					float Out_Dummy15_g251932 = 0.0;
					float4 Out_CoatTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251932 = float4( 0,0,0,0 );
					BreakData( Data15_g251932 , Out_Dummy15_g251932 , Out_CoatTexture15_g251932 , Out_DrawTexture15_g251932 , Out_PaintTexture15_g251932 , Out_AtmoTexture15_g251932 , Out_EffexTexture15_g251932 , Out_GlowTexture15_g251932 , Out_FormTexture15_g251932 , Out_LandTexture15_g251932 , Out_VertxTexture15_g251932 , Out_FlowTexture15_g251932 , Out_UserTexture15_g251932 );
					float4 Global_FormTexture351_g251922 = Out_FormTexture15_g251932;
					TVEModelData Data15_g251929 =(TVEModelData)Data15_g251818;
					float Out_Dummy15_g251929 = 0.0;
					float3 Out_PositionOS15_g251929 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251929 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251929 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251929 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251929 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251929 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251929 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251929 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251929 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251929 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251929 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251929 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251929 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251929 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251929 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251929 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251929 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251929 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251929 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251929 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251929 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251929 , Out_Dummy15_g251929 , Out_PositionOS15_g251929 , Out_PositionWS15_g251929 , Out_PositionWO15_g251929 , Out_PositionRawOS15_g251929 , Out_PivotOS15_g251929 , Out_PivotWS15_g251929 , Out_PivotWO15_g251929 , Out_NormalOS15_g251929 , Out_NormalWS15_g251929 , Out_NormalRawOS15_g251929 , Out_TangentOS15_g251929 , Out_TangentWS15_g251929 , Out_BitangentWS15_g251929 , Out_ViewDirWS15_g251929 , Out_CoordsData15_g251929 , Out_VertexData15_g251929 , Out_MasksData15_g251929 , Out_PhaseData15_g251929 , Out_TransformData15_g251929 , Out_RotationData15_g251929 , Out_Interpolator15_g251929 );
					float3 Model_PivotWO353_g251922 = Out_PivotWO15_g251929;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251928 = _ConformMeshMode;
					float Option70_g251928 = temp_output_17_0_g251928;
					half4 Model_VertexData357_g251922 = Out_VertexData15_g251929;
					float4 temp_output_3_0_g251928 = Model_VertexData357_g251922;
					float4 Channel70_g251928 = temp_output_3_0_g251928;
					float localSwitchChannel470_g251928 = SwitchChannel4( Option70_g251928 , Channel70_g251928 );
					float temp_output_390_0_g251922 = localSwitchChannel470_g251928;
					float temp_output_7_0_g251925 = _ConformMeshRemap.x;
					float temp_output_9_0_g251925 = ( temp_output_390_0_g251922 - temp_output_7_0_g251925 );
					float lerpResult374_g251922 = lerp( 1.0 , saturate( ( temp_output_9_0_g251925 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251922 = lerpResult374_g251922;
					float temp_output_328_0_g251922 = ( Blend_VertMask379_g251922 * TVE_IsEnabled );
					half Conform_Mask366_g251922 = temp_output_328_0_g251922;
					float temp_output_322_0_g251922 = ( ( ( ( (Global_FormTexture351_g251922).z - ( (Model_PivotWO353_g251922).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251922 ) );
					float3 appendResult329_g251922 = (float3(0.0 , temp_output_322_0_g251922 , 0.0));
					float3 appendResult387_g251922 = (float3(0.0 , 0.0 , temp_output_322_0_g251922));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251926 = appendResult387_g251922;
					#else
					float3 staticSwitch65_g251926 = appendResult329_g251922;
					#endif
					float3 Blanket_Conform368_g251922 = staticSwitch65_g251926;
					float4 appendResult312_g251922 = (float4(Blanket_Conform368_g251922 , 0.0));
					float4 temp_output_310_0_g251922 = ( Model_TransformData356_g251922 + appendResult312_g251922 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251922 = temp_output_310_0_g251922;
					#else
					float4 staticSwitch364_g251922 = Model_TransformData356_g251922;
					#endif
					half4 Final_TransformData365_g251922 = staticSwitch364_g251922;
					float4 In_TransformData16_g251931 = Final_TransformData365_g251922;
					float4 In_RotationData16_g251931 = Out_RotationData15_g251930;
					float4 In_Interpolator16_g251931 = Out_Interpolator15_g251930;
					BuildVertexData( Data16_g251931 , In_Dummy16_g251931 , In_PositionOS16_g251931 , In_NormalOS16_g251931 , In_TangentOS16_g251931 , In_TransformData16_g251931 , In_RotationData16_g251931 , In_Interpolator16_g251931 );
					TVEVertexData Data15_g251943 =(TVEVertexData)Data16_g251931;
					float Out_Dummy15_g251943 = 0.0;
					float3 Out_PositionOS15_g251943 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251943 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251943 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251943 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251943 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251943 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251943 , Out_Dummy15_g251943 , Out_PositionOS15_g251943 , Out_NormalOS15_g251943 , Out_TangentOS15_g251943 , Out_TransformData15_g251943 , Out_RotationData15_g251943 , Out_Interpolator15_g251943 );
					TVEVertexData Data16_g251944 =(TVEVertexData)Data15_g251943;
					float In_Dummy16_g251944 = 0.0;
					float3 Vertex_PositionOS147_g251934 = Out_PositionOS15_g251943;
					half3 VertexPos40_g251938 = Vertex_PositionOS147_g251934;
					float4 temp_output_1615_33_g251934 = Out_RotationData15_g251943;
					half4 Vertex_RotationData1569_g251934 = temp_output_1615_33_g251934;
					float2 break1582_g251934 = (Vertex_RotationData1569_g251934).xy;
					half Angle44_g251938 = break1582_g251934.y;
					half CosAngle89_g251938 = cos( Angle44_g251938 );
					half SinAngle93_g251938 = sin( Angle44_g251938 );
					float3 appendResult95_g251938 = (float3((VertexPos40_g251938).x , ( ( (VertexPos40_g251938).y * CosAngle89_g251938 ) - ( (VertexPos40_g251938).z * SinAngle93_g251938 ) ) , ( ( (VertexPos40_g251938).y * SinAngle93_g251938 ) + ( (VertexPos40_g251938).z * CosAngle89_g251938 ) )));
					half3 VertexPos40_g251939 = appendResult95_g251938;
					half Angle44_g251939 = -break1582_g251934.x;
					half CosAngle94_g251939 = cos( Angle44_g251939 );
					half SinAngle95_g251939 = sin( Angle44_g251939 );
					float3 appendResult98_g251939 = (float3(( ( (VertexPos40_g251939).x * CosAngle94_g251939 ) - ( (VertexPos40_g251939).y * SinAngle95_g251939 ) ) , ( ( (VertexPos40_g251939).x * SinAngle95_g251939 ) + ( (VertexPos40_g251939).y * CosAngle94_g251939 ) ) , (VertexPos40_g251939).z));
					half3 VertexPos40_g251937 = Vertex_PositionOS147_g251934;
					half Angle44_g251937 = break1582_g251934.y;
					half CosAngle89_g251937 = cos( Angle44_g251937 );
					half SinAngle93_g251937 = sin( Angle44_g251937 );
					float3 appendResult95_g251937 = (float3((VertexPos40_g251937).x , ( ( (VertexPos40_g251937).y * CosAngle89_g251937 ) - ( (VertexPos40_g251937).z * SinAngle93_g251937 ) ) , ( ( (VertexPos40_g251937).y * SinAngle93_g251937 ) + ( (VertexPos40_g251937).z * CosAngle89_g251937 ) )));
					half3 VertexPos40_g251942 = appendResult95_g251937;
					half Angle44_g251942 = break1582_g251934.x;
					half CosAngle91_g251942 = cos( Angle44_g251942 );
					half SinAngle92_g251942 = sin( Angle44_g251942 );
					float3 appendResult93_g251942 = (float3(( ( (VertexPos40_g251942).x * CosAngle91_g251942 ) + ( (VertexPos40_g251942).z * SinAngle92_g251942 ) ) , (VertexPos40_g251942).y , ( ( -(VertexPos40_g251942).x * SinAngle92_g251942 ) + ( (VertexPos40_g251942).z * CosAngle91_g251942 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251940 = appendResult93_g251942;
					#else
					float3 staticSwitch65_g251940 = appendResult98_g251939;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251935 = staticSwitch65_g251940;
					#else
					float3 staticSwitch65_g251935 = Vertex_PositionOS147_g251934;
					#endif
					float3 temp_output_1608_0_g251934 = staticSwitch65_g251935;
					half3 VertexPos40_g251941 = temp_output_1608_0_g251934;
					half Angle44_g251941 = (Vertex_RotationData1569_g251934).z;
					half CosAngle91_g251941 = cos( Angle44_g251941 );
					half SinAngle92_g251941 = sin( Angle44_g251941 );
					float3 appendResult93_g251941 = (float3(( ( (VertexPos40_g251941).x * CosAngle91_g251941 ) + ( (VertexPos40_g251941).z * SinAngle92_g251941 ) ) , (VertexPos40_g251941).y , ( ( -(VertexPos40_g251941).x * SinAngle92_g251941 ) + ( (VertexPos40_g251941).z * CosAngle91_g251941 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251936 = appendResult93_g251941;
					#else
					float3 staticSwitch65_g251936 = temp_output_1608_0_g251934;
					#endif
					float4 temp_output_1615_31_g251934 = Out_TransformData15_g251943;
					half4 Vertex_TransformData1568_g251934 = temp_output_1615_31_g251934;
					half3 Final_PositionOS178_g251934 = ( ( staticSwitch65_g251936 * (Vertex_TransformData1568_g251934).w ) + (Vertex_TransformData1568_g251934).xyz );
					float3 In_PositionOS16_g251944 = Final_PositionOS178_g251934;
					float3 In_NormalOS16_g251944 = Out_NormalOS15_g251943;
					float4 In_TangentOS16_g251944 = Out_TangentOS15_g251943;
					float4 In_TransformData16_g251944 = temp_output_1615_31_g251934;
					float4 In_RotationData16_g251944 = temp_output_1615_33_g251934;
					float4 In_Interpolator16_g251944 = Out_Interpolator15_g251943;
					BuildVertexData( Data16_g251944 , In_Dummy16_g251944 , In_PositionOS16_g251944 , In_NormalOS16_g251944 , In_TangentOS16_g251944 , In_TransformData16_g251944 , In_RotationData16_g251944 , In_Interpolator16_g251944 );
					TVEVertexData Data15_g252048 =(TVEVertexData)Data16_g251944;
					float Out_Dummy15_g252048 = 0.0;
					float3 Out_PositionOS15_g252048 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252048 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252048 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252048 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252048 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252048 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252048 , Out_Dummy15_g252048 , Out_PositionOS15_g252048 , Out_NormalOS15_g252048 , Out_TangentOS15_g252048 , Out_TransformData15_g252048 , Out_RotationData15_g252048 , Out_Interpolator15_g252048 );
					TVEVertexData Data16_g252049 =(TVEVertexData)Data15_g252048;
					float In_Dummy16_g252049 = 0.0;
					TVEModelData Data15_g252047 =(TVEModelData)Data15_g251929;
					float Out_Dummy15_g252047 = 0.0;
					float3 Out_PositionOS15_g252047 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252047 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252047 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252047 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252047 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252047 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252047 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252047 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252047 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252047 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252047 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252047 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252047 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252047 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252047 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252047 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252047 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252047 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252047 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252047 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252047 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252047 , Out_Dummy15_g252047 , Out_PositionOS15_g252047 , Out_PositionWS15_g252047 , Out_PositionWO15_g252047 , Out_PositionRawOS15_g252047 , Out_PivotOS15_g252047 , Out_PivotWS15_g252047 , Out_PivotWO15_g252047 , Out_NormalOS15_g252047 , Out_NormalWS15_g252047 , Out_NormalRawOS15_g252047 , Out_TangentOS15_g252047 , Out_TangentWS15_g252047 , Out_BitangentWS15_g252047 , Out_ViewDirWS15_g252047 , Out_CoordsData15_g252047 , Out_VertexData15_g252047 , Out_MasksData15_g252047 , Out_PhaseData15_g252047 , Out_TransformData15_g252047 , Out_RotationData15_g252047 , Out_Interpolator15_g252047 );
					float3 In_PositionOS16_g252049 = ( Out_PositionOS15_g252048 + Out_PivotOS15_g252047 );
					float3 In_NormalOS16_g252049 = Out_NormalOS15_g252048;
					float4 In_TangentOS16_g252049 = Out_TangentOS15_g252048;
					float4 In_TransformData16_g252049 = Out_TransformData15_g252048;
					float4 In_RotationData16_g252049 = Out_RotationData15_g252048;
					float4 In_Interpolator16_g252049 = Out_Interpolator15_g252048;
					BuildVertexData( Data16_g252049 , In_Dummy16_g252049 , In_PositionOS16_g252049 , In_NormalOS16_g252049 , In_TangentOS16_g252049 , In_TransformData16_g252049 , In_RotationData16_g252049 , In_Interpolator16_g252049 );
					TVEVertexData Data15_g252196 =(TVEVertexData)Data16_g252049;
					float Out_Dummy15_g252196 = 0.0;
					float3 Out_PositionOS15_g252196 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252196 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252196 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252196 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252196 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252196 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252196 , Out_Dummy15_g252196 , Out_PositionOS15_g252196 , Out_NormalOS15_g252196 , Out_TangentOS15_g252196 , Out_TransformData15_g252196 , Out_RotationData15_g252196 , Out_Interpolator15_g252196 );
					
					o.ase_texcoord6.xyz = vertexToFrag73_g251612;
					o.ase_texcoord7.xyz = vertexToFrag76_g251612;
					float3 vertexPos57_g252188 = v.vertex.xyz;
					float4 ase_positionCS57_g252188 = UnityObjectToClipPos( vertexPos57_g252188 );
					o.ase_texcoord9 = ase_positionCS57_g252188;
					TVEVertexData Data1902_g252143 = Data16_g252049;
					float4 Out_Interpolator1902_g252143 = float4( 0,0,0,0 );
					{
					Out_Interpolator1902_g252143 = Data1902_g252143.Interpolator;
					}
					float4 vertexToFrag1901_g252143 = Out_Interpolator1902_g252143;
					o.ase_texcoord10 = vertexToFrag1901_g252143;
					
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
					float3 vertexValue = Out_PositionOS15_g252196;
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

					float temp_output_2587_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2587_114).xxx;
					
					float3 temp_cast_1 = (temp_output_2587_114).xxx;
					
					float3 color130_g252188 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g252188 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g252190 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g252189 = ( temp_cast_4 * ( 0.5 + appendResult128_g252190 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g252189 = (float4(ddx( FinalUV13_g252189 ) , ddy( FinalUV13_g252189 )));
					float4 UVDerivatives17_g252189 = appendResult16_g252189;
					float4 break28_g252189 = UVDerivatives17_g252189;
					float2 appendResult19_g252189 = (float2(break28_g252189.x , break28_g252189.z));
					float2 appendResult20_g252189 = (float2(break28_g252189.x , break28_g252189.z));
					float dotResult24_g252189 = dot( appendResult19_g252189 , appendResult20_g252189 );
					float2 appendResult21_g252189 = (float2(break28_g252189.y , break28_g252189.w));
					float2 appendResult22_g252189 = (float2(break28_g252189.y , break28_g252189.w));
					float dotResult23_g252189 = dot( appendResult21_g252189 , appendResult22_g252189 );
					float2 appendResult25_g252189 = (float2(dotResult24_g252189 , dotResult23_g252189));
					float2 derivativesLength29_g252189 = sqrt( appendResult25_g252189 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g252189 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g252189 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g252189 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g252189 = clampResult57_g252189;
					float2 break55_g252189 = derivativesLength29_g252189;
					float4 lerpResult73_g252189 = lerp( float4( color130_g252188 , 0.0 ) , float4( color81_g252188 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g252189.x * break71_g252189.y * sqrt( saturate( ( 1.1 - max( break55_g252189.x, break55_g252189.y ) ) ) ) ) ) ));
					float3 color2584 = IsGammaSpace() ? float3( 0.3867925, 0.3867925, 0.3867925 ) : float3( 0.1237993, 0.1237993, 0.1237993 );
					float3 color2564 = IsGammaSpace() ? float3( 1, 0, 0.3576326 ) : float3( 1, 0, 0.1050864 );
					float3 color2565 = IsGammaSpace() ? float3( 0, 0.5347826, 1 ) : float3( 0, 0.2476594, 1 );
					float4 temp_output_2563_145 = TVE_RenderNearPositionR;
					float temp_output_7_0_g251820 = 1.0;
					float temp_output_9_0_g251820 = ( saturate( ( distance( PositionWS , (temp_output_2563_145).xyz ) / (temp_output_2563_145).w ) ) - temp_output_7_0_g251820 );
					half Global_Blend2558 = saturate( ( temp_output_9_0_g251820 / ( ( TVE_RenderNearFadeValue - temp_output_7_0_g251820 ) + 0.0001 ) ) );
					float3 lerpResult2567 = lerp( color2564 , color2565 , Global_Blend2558);
					float4 temp_output_2582_148 = TVE_RenderBasePositionR;
					float temp_output_7_0_g251933 = 1.0;
					float temp_output_9_0_g251933 = ( saturate( ( distance( PositionWS , (temp_output_2582_148).xyz ) / (temp_output_2582_148).w ) ) - temp_output_7_0_g251933 );
					half Global_Edge2578 = saturate( ( temp_output_9_0_g251933 / ( ( 0.9999 - temp_output_7_0_g251933 ) + 0.0001 ) ) );
					float3 lerpResult2583 = lerp( color2584 , lerpResult2567 , Global_Edge2578);
					float3 ifLocalVar40_g252147 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g252147 = lerpResult2583;
					float localBuildGlobalData204_g251945 = ( 0.0 );
					TVEGlobalData Data204_g251945 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251945 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251945 = Dummy211_g251945;
					float4 temp_output_203_0_g251964 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g251632 = ( 0.0 );
					TVEModelData Data26_g251632 = (TVEModelData)0;
					TVEModelData Data16_g251620 =(TVEModelData)0;
					float In_Dummy16_g251620 = 0.0;
					float3 vertexToFrag73_g251612 = IN.ase_texcoord6.xyz;
					float3 PositionWS122_g251612 = vertexToFrag73_g251612;
					float3 In_PositionWS16_g251620 = PositionWS122_g251612;
					float3 vertexToFrag76_g251612 = IN.ase_texcoord7.xyz;
					float3 PivotWS121_g251612 = vertexToFrag76_g251612;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251612 = ( PositionWS122_g251612 - PivotWS121_g251612 );
					#else
					float3 staticSwitch204_g251612 = PositionWS122_g251612;
					#endif
					float3 PositionWO132_g251612 = ( staticSwitch204_g251612 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251620 = PositionWO132_g251612;
					float3 In_PivotWS16_g251620 = PivotWS121_g251612;
					float3 PivotWO133_g251612 = ( PivotWS121_g251612 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251620 = PivotWO133_g251612;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g251612 = normalizedWorldNormal;
					float3 In_NormalWS16_g251620 = NormalWS95_g251612;
					half3 TangentWS136_g251612 = TangentWS;
					float3 In_TangentWS16_g251620 = TangentWS136_g251612;
					half3 BiangentWS421_g251612 = BitangentWS;
					float3 In_BitangentWS16_g251620 = BiangentWS421_g251612;
					half3 NormalWS427_g251612 = NormalWS95_g251612;
					half3 localComputeTriplanarMasks427_g251612 = ComputeTriplanarMasks( NormalWS427_g251612 );
					half3 TriplanarWeights429_g251612 = localComputeTriplanarMasks427_g251612;
					float3 In_TriplanarWeights16_g251620 = TriplanarWeights429_g251612;
					float3 normalizeResult296_g251612 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251612 ) );
					half3 ViewDirWS169_g251612 = normalizeResult296_g251612;
					float3 In_ViewDirWS16_g251620 = ViewDirWS169_g251612;
					float4 appendResult397_g251612 = (float4(IN.ase_texcoord8.xy , IN.ase_texcoord8.zw));
					float4 CoordsData398_g251612 = appendResult397_g251612;
					float4 In_CoordsData16_g251620 = CoordsData398_g251612;
					half4 VertexMasks171_g251612 = IN.ase_color;
					float4 In_VertexData16_g251620 = VertexMasks171_g251612;
					float temp_output_17_0_g251623 = _ObjectPhaseMode;
					float Option70_g251623 = temp_output_17_0_g251623;
					float4 temp_output_3_0_g251623 = IN.ase_color;
					float4 Channel70_g251623 = temp_output_3_0_g251623;
					float localSwitchChannel470_g251623 = SwitchChannel4( Option70_g251623 , Channel70_g251623 );
					half Phase_Value372_g251612 = localSwitchChannel470_g251623;
					float3 break319_g251612 = PivotWO133_g251612;
					half Pivot_Position322_g251612 = ( break319_g251612.x + break319_g251612.z );
					half Phase_Position357_g251612 = ( Phase_Value372_g251612 + Pivot_Position322_g251612 );
					float temp_output_248_0_g251612 = frac( Phase_Position357_g251612 );
					float4 appendResult177_g251612 = (float4((frac( ( Phase_Position357_g251612 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g251612));
					half4 Phase_Data176_g251612 = appendResult177_g251612;
					float4 In_Interpolator16_g251620 = Phase_Data176_g251612;
					BuildModelFragData( Data16_g251620 , In_Dummy16_g251620 , In_PositionWS16_g251620 , In_PositionWO16_g251620 , In_PivotWS16_g251620 , In_PivotWO16_g251620 , In_NormalWS16_g251620 , In_TangentWS16_g251620 , In_BitangentWS16_g251620 , In_TriplanarWeights16_g251620 , In_ViewDirWS16_g251620 , In_CoordsData16_g251620 , In_VertexData16_g251620 , In_Interpolator16_g251620 );
					TVEModelData DataDefault26_g251632 = Data16_g251620;
					TVEModelData DataGeneral26_g251632 = Data16_g251620;
					TVEModelData DataBlanket26_g251632 = Data16_g251620;
					TVEModelData DataImpostor26_g251632 = Data16_g251620;
					TVEModelData Data16_g251600 =(TVEModelData)0;
					float In_Dummy16_g251600 = 0.0;
					float3 temp_output_104_7_g251592 = PositionWS;
					float3 PositionWS122_g251592 = temp_output_104_7_g251592;
					float3 In_PositionWS16_g251600 = PositionWS122_g251592;
					float4x4 break19_g251595 = unity_ObjectToWorld;
					float3 appendResult20_g251595 = (float3(break19_g251595[ 0 ][ 3 ] , break19_g251595[ 1 ][ 3 ] , break19_g251595[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251592 = appendResult20_g251595;
					float3 PivotWS121_g251592 = temp_output_340_7_g251592;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251592 = ( PositionWS122_g251592 - PivotWS121_g251592 );
					#else
					float3 staticSwitch204_g251592 = PositionWS122_g251592;
					#endif
					float3 PositionWO132_g251592 = ( staticSwitch204_g251592 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251600 = PositionWO132_g251592;
					float3 In_PivotWS16_g251600 = PivotWS121_g251592;
					float3 PivotWO133_g251592 = ( PivotWS121_g251592 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251600 = PivotWO133_g251592;
					half3 NormalWS95_g251592 = normalizedWorldNormal;
					float3 In_NormalWS16_g251600 = NormalWS95_g251592;
					half3 TangentWS136_g251592 = TangentWS;
					float3 In_TangentWS16_g251600 = TangentWS136_g251592;
					half3 BiangentWS421_g251592 = BitangentWS;
					float3 In_BitangentWS16_g251600 = BiangentWS421_g251592;
					half3 NormalWS427_g251592 = NormalWS95_g251592;
					half3 localComputeTriplanarMasks427_g251592 = ComputeTriplanarMasks( NormalWS427_g251592 );
					half3 TriplanarWeights429_g251592 = localComputeTriplanarMasks427_g251592;
					float3 In_TriplanarWeights16_g251600 = TriplanarWeights429_g251592;
					float3 normalizeResult296_g251592 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251592 ) );
					half3 ViewDirWS169_g251592 = normalizeResult296_g251592;
					float3 In_ViewDirWS16_g251600 = ViewDirWS169_g251592;
					float4 appendResult397_g251592 = (float4(IN.ase_texcoord8.xy , IN.ase_texcoord8.zw));
					float4 CoordsData398_g251592 = appendResult397_g251592;
					float4 In_CoordsData16_g251600 = CoordsData398_g251592;
					half4 VertexMasks171_g251592 = float4( 0,0,0,0 );
					float4 In_VertexData16_g251600 = VertexMasks171_g251592;
					half4 Phase_Data176_g251592 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251600 = Phase_Data176_g251592;
					BuildModelFragData( Data16_g251600 , In_Dummy16_g251600 , In_PositionWS16_g251600 , In_PositionWO16_g251600 , In_PivotWS16_g251600 , In_PivotWO16_g251600 , In_NormalWS16_g251600 , In_TangentWS16_g251600 , In_BitangentWS16_g251600 , In_TriplanarWeights16_g251600 , In_ViewDirWS16_g251600 , In_CoordsData16_g251600 , In_VertexData16_g251600 , In_Interpolator16_g251600 );
					TVEModelData DataTerrain26_g251632 = Data16_g251600;
					half IsShaderType2544 = _IsShaderType;
					float Type26_g251632 = IsShaderType2544;
					{
					if (Type26_g251632 == 0 )
					{
					Data26_g251632 = DataDefault26_g251632;
					}
					else if (Type26_g251632 == 1 )
					{
					Data26_g251632 = DataGeneral26_g251632;
					}
					else if (Type26_g251632 == 2 )
					{
					Data26_g251632 = DataBlanket26_g251632;
					}
					else if (Type26_g251632 == 3 )
					{
					Data26_g251632 = DataImpostor26_g251632;
					}
					else if (Type26_g251632 == 4 )
					{
					Data26_g251632 = DataTerrain26_g251632;
					}
					}
					TVEModelData Data15_g252035 =(TVEModelData)Data26_g251632;
					float Out_Dummy15_g252035 = 0.0;
					float3 Out_PositionWS15_g252035 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252035 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252035 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252035 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252035 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252035 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252035 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252035 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252035 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252035 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252035 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252035 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252035 , Out_Dummy15_g252035 , Out_PositionWS15_g252035 , Out_PositionWO15_g252035 , Out_PivotWS15_g252035 , Out_PivotWO15_g252035 , Out_NormalWS15_g252035 , Out_TangentWS15_g252035 , Out_BitangentWS15_g252035 , Out_TriplanarWeights15_g252035 , Out_ViewDirWS15_g252035 , Out_CoordsData15_g252035 , Out_VertexData15_g252035 , Out_Interpolator15_g252035 );
					float3 Model_PositionWS497_g251945 = Out_PositionWS15_g252035;
					float2 Model_PositionWS_XZ143_g251945 = (Model_PositionWS497_g251945).xz;
					float3 Model_PivotWS498_g251945 = Out_PivotWS15_g252035;
					float2 Model_PivotWS_XZ145_g251945 = (Model_PivotWS498_g251945).xz;
					float2 lerpResult300_g251945 = lerp( Model_PositionWS_XZ143_g251945 , Model_PivotWS_XZ145_g251945 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251964 = lerpResult300_g251945;
					float temp_output_82_0_g251962 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251964 = temp_output_82_0_g251962;
					float4 tex2DArrayNode83_g251964 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251964).zw + ( (temp_output_203_0_g251964).xy * temp_output_81_0_g251964 ) ),temp_output_82_0_g251964) );
					float4 appendResult210_g251964 = (float4(tex2DArrayNode83_g251964.rgb , tex2DArrayNode83_g251964.a));
					float4 temp_output_204_0_g251964 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251964 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251964).zw + ( (temp_output_204_0_g251964).xy * temp_output_81_0_g251964 ) ),temp_output_82_0_g251964) );
					float4 appendResult212_g251964 = (float4(tex2DArrayNode122_g251964.rgb , tex2DArrayNode122_g251964.a));
					float4 TVE_RenderNearPositionR628_g251945 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251945 = saturate( ( distance( Model_PositionWS497_g251945 , (TVE_RenderNearPositionR628_g251945).xyz ) / (TVE_RenderNearPositionR628_g251945).w ) );
					float temp_output_7_0_g252034 = 1.0;
					float temp_output_9_0_g252034 = ( temp_output_507_0_g251945 - temp_output_7_0_g252034 );
					half TVE_RenderNearFadeValue635_g251945 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251945 = saturate( ( temp_output_9_0_g252034 / ( ( TVE_RenderNearFadeValue635_g251945 - temp_output_7_0_g252034 ) + 0.0001 ) ) );
					float4 lerpResult131_g251964 = lerp( appendResult210_g251964 , appendResult212_g251964 , Global_TexBlend509_g251945);
					float4 temp_output_159_109_g251962 = lerpResult131_g251964;
					float4 lerpResult168_g251962 = lerp( TVE_CoatParams , temp_output_159_109_g251962 , TVE_CoatLayers[(int)temp_output_82_0_g251962]);
					float4 temp_output_589_109_g251945 = lerpResult168_g251962;
					half4 Coat_Texture302_g251945 = temp_output_589_109_g251945;
					float4 In_CoatTexture204_g251945 = Coat_Texture302_g251945;
					half4 Draw_Texture656_g251945 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g251945 = Draw_Texture656_g251945;
					float4 temp_output_203_0_g251989 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251945 = lerp( Model_PositionWS_XZ143_g251945 , Model_PivotWS_XZ145_g251945 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251989 = lerpResult85_g251945;
					float temp_output_82_0_g251986 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251989 = temp_output_82_0_g251986;
					float4 tex2DArrayNode83_g251989 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251989).zw + ( (temp_output_203_0_g251989).xy * temp_output_81_0_g251989 ) ),temp_output_82_0_g251989) );
					float4 appendResult210_g251989 = (float4(tex2DArrayNode83_g251989.rgb , tex2DArrayNode83_g251989.a));
					float4 temp_output_204_0_g251989 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251989 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251989).zw + ( (temp_output_204_0_g251989).xy * temp_output_81_0_g251989 ) ),temp_output_82_0_g251989) );
					float4 appendResult212_g251989 = (float4(tex2DArrayNode122_g251989.rgb , tex2DArrayNode122_g251989.a));
					float4 lerpResult131_g251989 = lerp( appendResult210_g251989 , appendResult212_g251989 , Global_TexBlend509_g251945);
					float4 temp_output_171_109_g251986 = lerpResult131_g251989;
					float4 lerpResult174_g251986 = lerp( TVE_PaintParams , temp_output_171_109_g251986 , TVE_PaintLayers[(int)temp_output_82_0_g251986]);
					float4 temp_output_595_109_g251945 = lerpResult174_g251986;
					half4 Paint_Texture71_g251945 = temp_output_595_109_g251945;
					float4 In_PaintTexture204_g251945 = Paint_Texture71_g251945;
					float4 temp_output_203_0_g251972 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251945 = lerp( Model_PositionWS_XZ143_g251945 , Model_PivotWS_XZ145_g251945 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251972 = lerpResult104_g251945;
					float temp_output_132_0_g251970 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251972 = temp_output_132_0_g251970;
					float4 tex2DArrayNode83_g251972 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251972).zw + ( (temp_output_203_0_g251972).xy * temp_output_81_0_g251972 ) ),temp_output_82_0_g251972) );
					float4 appendResult210_g251972 = (float4(tex2DArrayNode83_g251972.rgb , tex2DArrayNode83_g251972.a));
					float4 temp_output_204_0_g251972 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251972 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251972).zw + ( (temp_output_204_0_g251972).xy * temp_output_81_0_g251972 ) ),temp_output_82_0_g251972) );
					float4 appendResult212_g251972 = (float4(tex2DArrayNode122_g251972.rgb , tex2DArrayNode122_g251972.a));
					float4 lerpResult131_g251972 = lerp( appendResult210_g251972 , appendResult212_g251972 , Global_TexBlend509_g251945);
					float4 temp_output_137_109_g251970 = lerpResult131_g251972;
					float4 lerpResult145_g251970 = lerp( TVE_AtmoParams , temp_output_137_109_g251970 , TVE_AtmoLayers[(int)temp_output_132_0_g251970]);
					float4 temp_output_590_110_g251945 = lerpResult145_g251970;
					half4 Atmo_Texture80_g251945 = temp_output_590_110_g251945;
					float4 In_AtmoTexture204_g251945 = Atmo_Texture80_g251945;
					float4 temp_output_203_0_g252040 = TVE_EffexBaseCoord;
					float2 lerpResult414_g251945 = lerp( Model_PositionWS_XZ143_g251945 , Model_PivotWS_XZ145_g251945 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g252040 = lerpResult414_g251945;
					float temp_output_132_0_g252038 = _GlobalEffexLayerValue;
					float temp_output_82_0_g252040 = temp_output_132_0_g252038;
					float4 tex2DArrayNode83_g252040 = SAMPLE_TEXTURE2D_ARRAY( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g252040).zw + ( (temp_output_203_0_g252040).xy * temp_output_81_0_g252040 ) ),temp_output_82_0_g252040) );
					float4 appendResult210_g252040 = (float4(tex2DArrayNode83_g252040.rgb , tex2DArrayNode83_g252040.a));
					float4 temp_output_204_0_g252040 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g252040 = SAMPLE_TEXTURE2D_ARRAY( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g252040).zw + ( (temp_output_204_0_g252040).xy * temp_output_81_0_g252040 ) ),temp_output_82_0_g252040) );
					float4 appendResult212_g252040 = (float4(tex2DArrayNode122_g252040.rgb , tex2DArrayNode122_g252040.a));
					float4 lerpResult131_g252040 = lerp( appendResult210_g252040 , appendResult212_g252040 , Global_TexBlend509_g251945);
					float4 temp_output_137_109_g252038 = lerpResult131_g252040;
					float4 lerpResult145_g252038 = lerp( TVE_EffexParams , temp_output_137_109_g252038 , TVE_EffexLayers[(int)temp_output_132_0_g252038]);
					float4 temp_output_731_110_g251945 = lerpResult145_g252038;
					half4 Effex_Texture420_g251945 = temp_output_731_110_g251945;
					float4 In_EffexTexture204_g251945 = Effex_Texture420_g251945;
					float4 temp_output_203_0_g252020 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251945 = lerp( Model_PositionWS_XZ143_g251945 , Model_PivotWS_XZ145_g251945 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g252020 = lerpResult247_g251945;
					float temp_output_82_0_g252018 = _GlobalGlowLayerValue;
					float temp_output_82_0_g252020 = temp_output_82_0_g252018;
					float4 tex2DArrayNode83_g252020 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g252020).zw + ( (temp_output_203_0_g252020).xy * temp_output_81_0_g252020 ) ),temp_output_82_0_g252020) );
					float4 appendResult210_g252020 = (float4(tex2DArrayNode83_g252020.rgb , tex2DArrayNode83_g252020.a));
					float4 temp_output_204_0_g252020 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g252020 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g252020).zw + ( (temp_output_204_0_g252020).xy * temp_output_81_0_g252020 ) ),temp_output_82_0_g252020) );
					float4 appendResult212_g252020 = (float4(tex2DArrayNode122_g252020.rgb , tex2DArrayNode122_g252020.a));
					float4 lerpResult131_g252020 = lerp( appendResult210_g252020 , appendResult212_g252020 , Global_TexBlend509_g251945);
					float4 temp_output_159_109_g252018 = lerpResult131_g252020;
					float4 lerpResult167_g252018 = lerp( TVE_GlowParams , temp_output_159_109_g252018 , TVE_GlowLayers[(int)temp_output_82_0_g252018]);
					float4 temp_output_593_109_g251945 = lerpResult167_g252018;
					half4 Glow_Texture248_g251945 = temp_output_593_109_g251945;
					float4 In_GlowTexture204_g251945 = Glow_Texture248_g251945;
					float4 temp_output_203_0_g251956 = TVE_FormBaseCoord;
					float2 lerpResult168_g251945 = lerp( Model_PositionWS_XZ143_g251945 , Model_PivotWS_XZ145_g251945 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251956 = lerpResult168_g251945;
					float temp_output_130_0_g251954 = _GlobalFormLayerValue;
					float temp_output_82_0_g251956 = temp_output_130_0_g251954;
					float4 tex2DArrayNode83_g251956 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251956).zw + ( (temp_output_203_0_g251956).xy * temp_output_81_0_g251956 ) ),temp_output_82_0_g251956) );
					float4 appendResult210_g251956 = (float4(tex2DArrayNode83_g251956.rgb , tex2DArrayNode83_g251956.a));
					float4 temp_output_204_0_g251956 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251956 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251956).zw + ( (temp_output_204_0_g251956).xy * temp_output_81_0_g251956 ) ),temp_output_82_0_g251956) );
					float4 appendResult212_g251956 = (float4(tex2DArrayNode122_g251956.rgb , tex2DArrayNode122_g251956.a));
					float4 lerpResult131_g251956 = lerp( appendResult210_g251956 , appendResult212_g251956 , Global_TexBlend509_g251945);
					float4 temp_output_135_109_g251954 = lerpResult131_g251956;
					float4 lerpResult143_g251954 = lerp( TVE_FormParams , temp_output_135_109_g251954 , TVE_FormLayers[(int)temp_output_130_0_g251954]);
					float4 temp_output_592_0_g251945 = lerpResult143_g251954;
					float4 Form_Texture112_g251945 = temp_output_592_0_g251945;
					float4 In_FormTexture204_g251945 = Form_Texture112_g251945;
					float4 In_LandTexture204_g251945 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g252004 = TVE_VertxBaseCoord;
					float2 lerpResult681_g251945 = lerp( Model_PositionWS_XZ143_g251945 , Model_PivotWS_XZ145_g251945 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g252004 = lerpResult681_g251945;
					float temp_output_136_0_g252002 = _GlobalVertxLayerValue;
					float temp_output_82_0_g252004 = temp_output_136_0_g252002;
					float4 tex2DArrayNode83_g252004 = SAMPLE_TEXTURE2D_ARRAY( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g252004).zw + ( (temp_output_203_0_g252004).xy * temp_output_81_0_g252004 ) ),temp_output_82_0_g252004) );
					float4 appendResult210_g252004 = (float4(tex2DArrayNode83_g252004.rgb , tex2DArrayNode83_g252004.a));
					float4 temp_output_204_0_g252004 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g252004 = SAMPLE_TEXTURE2D_ARRAY( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g252004).zw + ( (temp_output_204_0_g252004).xy * temp_output_81_0_g252004 ) ),temp_output_82_0_g252004) );
					float4 appendResult212_g252004 = (float4(tex2DArrayNode122_g252004.rgb , tex2DArrayNode122_g252004.a));
					float4 lerpResult131_g252004 = lerp( appendResult210_g252004 , appendResult212_g252004 , Global_TexBlend509_g251945);
					float4 temp_output_141_109_g252002 = lerpResult131_g252004;
					float4 lerpResult149_g252002 = lerp( TVE_VertxParams , temp_output_141_109_g252002 , TVE_VertxLayers[(int)temp_output_136_0_g252002]);
					float4 temp_output_695_0_g251945 = lerpResult149_g252002;
					half4 Vertx_Texture693_g251945 = temp_output_695_0_g251945;
					float4 In_VertxTexture204_g251945 = Vertx_Texture693_g251945;
					float4 temp_output_203_0_g251980 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251945 = lerp( Model_PositionWS_XZ143_g251945 , Model_PivotWS_XZ145_g251945 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251980 = lerpResult400_g251945;
					float temp_output_136_0_g251978 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251980 = temp_output_136_0_g251978;
					float4 tex2DArrayNode83_g251980 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251980).zw + ( (temp_output_203_0_g251980).xy * temp_output_81_0_g251980 ) ),temp_output_82_0_g251980) );
					float4 appendResult210_g251980 = (float4(tex2DArrayNode83_g251980.rgb , tex2DArrayNode83_g251980.a));
					float4 temp_output_204_0_g251980 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251980 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251980).zw + ( (temp_output_204_0_g251980).xy * temp_output_81_0_g251980 ) ),temp_output_82_0_g251980) );
					float4 appendResult212_g251980 = (float4(tex2DArrayNode122_g251980.rgb , tex2DArrayNode122_g251980.a));
					float4 lerpResult131_g251980 = lerp( appendResult210_g251980 , appendResult212_g251980 , Global_TexBlend509_g251945);
					float4 temp_output_141_109_g251978 = lerpResult131_g251980;
					float4 lerpResult149_g251978 = lerp( TVE_FlowParams , temp_output_141_109_g251978 , TVE_FlowLayers[(int)temp_output_136_0_g251978]);
					float4 temp_output_594_0_g251945 = lerpResult149_g251978;
					half4 Flow_Texture405_g251945 = temp_output_594_0_g251945;
					float4 In_FlowTexture204_g251945 = Flow_Texture405_g251945;
					half4 User_Texture677_g251945 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g251945 = User_Texture677_g251945;
					BuildGlobalData( Data204_g251945 , In_Dummy204_g251945 , In_CoatTexture204_g251945 , In_DrawTexture204_g251945 , In_PaintTexture204_g251945 , In_AtmoTexture204_g251945 , In_EffexTexture204_g251945 , In_GlowTexture204_g251945 , In_FormTexture204_g251945 , In_LandTexture204_g251945 , In_VertxTexture204_g251945 , In_FlowTexture204_g251945 , In_UserTexture204_g251945 );
					TVEGlobalData Data15_g252050 =(TVEGlobalData)Data204_g251945;
					float Out_Dummy15_g252050 = 0.0;
					float4 Out_CoatTexture15_g252050 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g252050 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g252050 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g252050 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g252050 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g252050 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g252050 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g252050 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g252050 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g252050 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g252050 = float4( 0,0,0,0 );
					BreakData( Data15_g252050 , Out_Dummy15_g252050 , Out_CoatTexture15_g252050 , Out_DrawTexture15_g252050 , Out_PaintTexture15_g252050 , Out_AtmoTexture15_g252050 , Out_EffexTexture15_g252050 , Out_GlowTexture15_g252050 , Out_FormTexture15_g252050 , Out_LandTexture15_g252050 , Out_VertxTexture15_g252050 , Out_FlowTexture15_g252050 , Out_UserTexture15_g252050 );
					float4 temp_output_2419_27 = Out_CoatTexture15_g252050;
					float3 ifLocalVar40_g252051 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g252051 = (temp_output_2419_27).xxx;
					float3 ifLocalVar40_g252052 = 0;
					if( TVE_DEBUG_Index == 3.0 )
					ifLocalVar40_g252052 = (temp_output_2419_27).yyy;
					float3 ifLocalVar40_g252053 = 0;
					if( TVE_DEBUG_Index == 4.0 )
					ifLocalVar40_g252053 = (temp_output_2419_27).zzz;
					float4 temp_output_2419_38 = Out_DrawTexture15_g252050;
					float3 ifLocalVar40_g252120 = 0;
					if( TVE_DEBUG_Index == 6.0 )
					ifLocalVar40_g252120 = (temp_output_2419_38).xyz;
					float3 ifLocalVar40_g252121 = 0;
					if( TVE_DEBUG_Index == 7.0 )
					ifLocalVar40_g252121 = (temp_output_2419_38).www;
					float4 temp_output_2419_0 = Out_PaintTexture15_g252050;
					float3 ifLocalVar40_g252123 = 0;
					if( TVE_DEBUG_Index == 9.0 )
					ifLocalVar40_g252123 = (temp_output_2419_0).xyz;
					float3 ifLocalVar40_g252122 = 0;
					if( TVE_DEBUG_Index == 10.0 )
					ifLocalVar40_g252122 = (temp_output_2419_0).www;
					float3 ifLocalVar40_g252124 = 0;
					if( TVE_DEBUG_Index == 12.0 )
					ifLocalVar40_g252124 = (Out_EffexTexture15_g252050).xxx;
					float4 temp_output_2419_16 = Out_AtmoTexture15_g252050;
					float3 ifLocalVar40_g252125 = 0;
					if( TVE_DEBUG_Index == 14.0 )
					ifLocalVar40_g252125 = (temp_output_2419_16).xxx;
					float3 ifLocalVar40_g252126 = 0;
					if( TVE_DEBUG_Index == 15.0 )
					ifLocalVar40_g252126 = (temp_output_2419_16).yyy;
					float3 ifLocalVar40_g252127 = 0;
					if( TVE_DEBUG_Index == 16.0 )
					ifLocalVar40_g252127 = (temp_output_2419_16).zzz;
					float3 ifLocalVar40_g252128 = 0;
					if( TVE_DEBUG_Index == 17.0 )
					ifLocalVar40_g252128 = (temp_output_2419_16).www;
					float4 temp_output_2419_19 = Out_GlowTexture15_g252050;
					float3 ifLocalVar40_g252129 = 0;
					if( TVE_DEBUG_Index == 19.0 )
					ifLocalVar40_g252129 = (temp_output_2419_19).xyz;
					float3 ifLocalVar40_g252130 = 0;
					if( TVE_DEBUG_Index == 20.0 )
					ifLocalVar40_g252130 = (temp_output_2419_19).www;
					float4 temp_output_2419_18 = Out_FormTexture15_g252050;
					float3 appendResult2536 = (float3((temp_output_2419_18).xy , 0.0));
					float3 ifLocalVar40_g252131 = 0;
					if( TVE_DEBUG_Index == 22.0 )
					ifLocalVar40_g252131 = ( appendResult2536 * appendResult2536 );
					float3 temp_output_2537_0 = ( (temp_output_2419_18).zzz * 0.1 );
					float3 ifLocalVar40_g252132 = 0;
					if( TVE_DEBUG_Index == 23.0 )
					ifLocalVar40_g252132 = temp_output_2537_0;
					float3 ifLocalVar40_g252134 = 0;
					if( TVE_DEBUG_Index == 24.0 )
					ifLocalVar40_g252134 = (temp_output_2419_18).www;
					float3 ifLocalVar40_g252133 = 0;
					if( TVE_DEBUG_Index == 26.0 )
					ifLocalVar40_g252133 = (Out_VertxTexture15_g252050).xxx;
					float4 temp_output_2419_24 = Out_FlowTexture15_g252050;
					float2 temp_output_2435_0 = (temp_output_2419_24).xy;
					float3 appendResult2501 = (float3(temp_output_2435_0 , 0.0));
					float3 ifLocalVar40_g252135 = 0;
					if( TVE_DEBUG_Index == 30.0 )
					ifLocalVar40_g252135 = ( appendResult2501 * appendResult2501 );
					float3 ifLocalVar40_g252136 = 0;
					if( TVE_DEBUG_Index == 31.0 )
					ifLocalVar40_g252136 = (temp_output_2419_24).zzz;
					float3 ifLocalVar40_g252137 = 0;
					if( TVE_DEBUG_Index == 32.0 )
					ifLocalVar40_g252137 = (temp_output_2419_24).www;
					float4 temp_output_2419_39 = Out_UserTexture15_g252050;
					float3 ifLocalVar40_g252138 = 0;
					if( TVE_DEBUG_Index == 34.0 )
					ifLocalVar40_g252138 = (temp_output_2419_39).xyz;
					float3 ifLocalVar40_g252139 = 0;
					if( TVE_DEBUG_Index == 35.0 )
					ifLocalVar40_g252139 = (temp_output_2419_39).xxx;
					float3 ifLocalVar40_g252140 = 0;
					if( TVE_DEBUG_Index == 36.0 )
					ifLocalVar40_g252140 = (temp_output_2419_39).yyy;
					float3 ifLocalVar40_g252141 = 0;
					if( TVE_DEBUG_Index == 37.0 )
					ifLocalVar40_g252141 = (temp_output_2419_39).zzz;
					float3 ifLocalVar40_g252142 = 0;
					if( TVE_DEBUG_Index == 38.0 )
					ifLocalVar40_g252142 = (temp_output_2419_39).www;
					half3 Final_Debug2399 = ( ifLocalVar40_g252147 + ( ifLocalVar40_g252051 + ifLocalVar40_g252052 + ifLocalVar40_g252053 ) + ( ifLocalVar40_g252120 + ifLocalVar40_g252121 ) + ( ifLocalVar40_g252123 + ifLocalVar40_g252122 + ifLocalVar40_g252124 ) + ( ifLocalVar40_g252125 + ifLocalVar40_g252126 + ifLocalVar40_g252127 + ifLocalVar40_g252128 ) + ( ifLocalVar40_g252129 + ifLocalVar40_g252130 ) + ( ifLocalVar40_g252131 + ifLocalVar40_g252132 + ifLocalVar40_g252134 + ifLocalVar40_g252133 ) + ( ifLocalVar40_g252135 + ifLocalVar40_g252136 + ifLocalVar40_g252137 ) + ( ifLocalVar40_g252138 + ifLocalVar40_g252139 + ifLocalVar40_g252140 + ifLocalVar40_g252141 + ifLocalVar40_g252142 ) );
					float temp_output_7_0_g252195 = TVE_DEBUG_Min;
					float3 temp_cast_19 = (temp_output_7_0_g252195).xxx;
					float3 temp_output_9_0_g252195 = ( Final_Debug2399 - temp_cast_19 );
					float lerpResult76_g252188 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g252188 = lerpResult76_g252188;
					float3 lerpResult72_g252188 = lerp( (lerpResult73_g252189).rgb , saturate( ( temp_output_9_0_g252195 / ( ( TVE_DEBUG_Max - temp_output_7_0_g252195 ) + 0.0001 ) ) ) , Filter152_g252188);
					float dotResult61_g252188 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g252188 = ( 1.0 - saturate( dotResult61_g252188 ) );
					float Shading_Fresnel59_g252188 = (( 1.0 - ( temp_output_65_0_g252188 * temp_output_65_0_g252188 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g252188 = IN.ase_texcoord9;
					float depthLinearEye57_g252188 = LinearEyeDepth( ase_positionCS57_g252188.z / ase_positionCS57_g252188.w );
					float temp_output_69_0_g252188 = saturate(  (0.0 + ( depthLinearEye57_g252188 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g252188 = (( temp_output_69_0_g252188 * temp_output_69_0_g252188 )*0.5 + 0.5);
					float lerpResult84_g252188 = lerp( 1.0 , Shading_Fresnel59_g252188 , ( Shading_Distance58_g252188 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g252193 = ( 0.0 );
					float localBuildVisualData3_g252150 = ( 0.0 );
					float localBuildVisualData3_g252144 = ( 0.0 );
					TVEVisualData Data3_g252144 =(TVEVisualData)0;
					float temp_output_14_0_g252144 = 0.0;
					float In_Dummy3_g252144 = temp_output_14_0_g252144;
					float3 temp_cast_20 = (0.5).xxx;
					float3 temp_output_4_0_g252144 = temp_cast_20;
					float3 In_Albedo3_g252144 = temp_output_4_0_g252144;
					float3 temp_cast_21 = (0.5).xxx;
					float3 temp_output_44_0_g252144 = temp_cast_21;
					float3 In_AlbedoBase3_g252144 = temp_output_44_0_g252144;
					float2 temp_cast_22 = (0.0).xx;
					float2 In_NormalTS3_g252144 = temp_cast_22;
					float3 temp_cast_23 = (0.5).xxx;
					float3 In_NormalWS3_g252144 = temp_cast_23;
					float4 In_Shader3_g252144 = half4( 0, 1, 0, 1 );
					float4 In_Feature3_g252144 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g252144 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g252144 = half4( 1, 1, 1, 1 );
					float temp_output_12_0_g252144 = 0.5;
					float In_Grayscale3_g252144 = temp_output_12_0_g252144;
					float temp_output_16_0_g252144 = 1.0;
					float In_Luminosity3_g252144 = temp_output_16_0_g252144;
					float In_MultiMask3_g252144 = 1.0;
					float In_AlphaClip3_g252144 = 1.0;
					float In_AlphaFade3_g252144 = 1.0;
					float3 temp_cast_24 = (1.0).xxx;
					float3 In_Translucency3_g252144 = temp_cast_24;
					float In_Transmission3_g252144 = 1.0;
					float In_Thickness3_g252144 = 0.0;
					float In_Diffusion3_g252144 = 0.0;
					float In_Depth3_g252144 = 0.0;
					BuildVisualData( Data3_g252144 , In_Dummy3_g252144 , In_Albedo3_g252144 , In_AlbedoBase3_g252144 , In_NormalTS3_g252144 , In_NormalWS3_g252144 , In_Shader3_g252144 , In_Feature3_g252144 , In_Season3_g252144 , In_Emissive3_g252144 , In_Grayscale3_g252144 , In_Luminosity3_g252144 , In_MultiMask3_g252144 , In_AlphaClip3_g252144 , In_AlphaFade3_g252144 , In_Translucency3_g252144 , In_Transmission3_g252144 , In_Thickness3_g252144 , In_Diffusion3_g252144 , In_Depth3_g252144 );
					TVEVisualData Data3_g252150 =(TVEVisualData)Data3_g252144;
					half Dummy130_g252148 = ( _MainCategory + _MainEnd );
					float temp_output_14_0_g252150 = Dummy130_g252148;
					float In_Dummy3_g252150 = temp_output_14_0_g252150;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g252171) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g252153 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g252153 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g252153 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g252153 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g252153 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g252153 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g252171 = staticSwitch36_g252153;
					float localBreakTextureData456_g252171 = ( 0.0 );
					float localBuildTextureData431_g252170 = ( 0.0 );
					TVEMasksData Data431_g252170 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g252170 = ( 0.0 );
					float4 temp_output_6_0_g252186 = _main_coord_value;
					float4 temp_output_7_0_g252186 = ( _MainSampleMode + _MainCoordMode + _MainCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g252186 = ( temp_output_6_0_g252186 + temp_output_7_0_g252186 );
					#else
					float4 staticSwitch14_g252186 = temp_output_6_0_g252186;
					#endif
					half4 Local_Coords180_g252148 = staticSwitch14_g252186;
					float4 Coords444_g252170 = Local_Coords180_g252148;
					TVEModelData Data15_g252145 =(TVEModelData)Data26_g251632;
					float Out_Dummy15_g252145 = 0.0;
					float3 Out_PositionWS15_g252145 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252145 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252145 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252145 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252145 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252145 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252145 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252145 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252145 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252145 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252145 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252145 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252145 , Out_Dummy15_g252145 , Out_PositionWS15_g252145 , Out_PositionWO15_g252145 , Out_PivotWS15_g252145 , Out_PivotWO15_g252145 , Out_NormalWS15_g252145 , Out_TangentWS15_g252145 , Out_BitangentWS15_g252145 , Out_TriplanarWeights15_g252145 , Out_ViewDirWS15_g252145 , Out_CoordsData15_g252145 , Out_VertexData15_g252145 , Out_Interpolator15_g252145 );
					TVEModelData Data16_g252146 =(TVEModelData)Data15_g252145;
					float In_Dummy16_g252146 = Out_Dummy15_g252145;
					float3 In_PositionWS16_g252146 = Out_PositionWS15_g252145;
					float3 In_PositionWO16_g252146 = Out_PositionWO15_g252145;
					float3 In_PivotWS16_g252146 = Out_PivotWS15_g252145;
					float3 In_PivotWO16_g252146 = Out_PivotWO15_g252145;
					float3 In_NormalWS16_g252146 = Out_NormalWS15_g252145;
					float3 In_TangentWS16_g252146 = Out_TangentWS15_g252145;
					float3 In_BitangentWS16_g252146 = Out_BitangentWS15_g252145;
					float3 In_TriplanarWeights16_g252146 = Out_TriplanarWeights15_g252145;
					float3 In_ViewDirWS16_g252146 = Out_ViewDirWS15_g252145;
					float4 In_CoordsData16_g252146 = Out_CoordsData15_g252145;
					float4 In_VertexData16_g252146 = Out_VertexData15_g252145;
					float4 vertexToFrag1901_g252143 = IN.ase_texcoord10;
					float4 In_Interpolator16_g252146 = vertexToFrag1901_g252143;
					BuildModelFragData( Data16_g252146 , In_Dummy16_g252146 , In_PositionWS16_g252146 , In_PositionWO16_g252146 , In_PivotWS16_g252146 , In_PivotWO16_g252146 , In_NormalWS16_g252146 , In_TangentWS16_g252146 , In_BitangentWS16_g252146 , In_TriplanarWeights16_g252146 , In_ViewDirWS16_g252146 , In_CoordsData16_g252146 , In_VertexData16_g252146 , In_Interpolator16_g252146 );
					TVEModelData Data15_g252149 =(TVEModelData)Data16_g252146;
					float Out_Dummy15_g252149 = 0.0;
					float3 Out_PositionWS15_g252149 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252149 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252149 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252149 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252149 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252149 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252149 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252149 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252149 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252149 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252149 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252149 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252149 , Out_Dummy15_g252149 , Out_PositionWS15_g252149 , Out_PositionWO15_g252149 , Out_PivotWS15_g252149 , Out_PivotWO15_g252149 , Out_NormalWS15_g252149 , Out_TangentWS15_g252149 , Out_BitangentWS15_g252149 , Out_TriplanarWeights15_g252149 , Out_ViewDirWS15_g252149 , Out_CoordsData15_g252149 , Out_VertexData15_g252149 , Out_Interpolator15_g252149 );
					float4 Model_CoordsData324_g252148 = Out_CoordsData15_g252149;
					float4 MeshCoords444_g252170 = Model_CoordsData324_g252148;
					float2 UV0444_g252170 = float2( 0,0 );
					float2 UV3444_g252170 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g252170 , MeshCoords444_g252170 , UV0444_g252170 , UV3444_g252170 );
					float4 appendResult430_g252170 = (float4(UV0444_g252170 , UV3444_g252170));
					float4 In_MaskA431_g252170 = appendResult430_g252170;
					float localComputeWorldCoords315_g252170 = ( 0.0 );
					float4 Coords315_g252170 = Local_Coords180_g252148;
					float3 Model_PositionWO222_g252148 = Out_PositionWO15_g252149;
					float3 PositionWS315_g252170 = Model_PositionWO222_g252148;
					float2 ZY315_g252170 = float2( 0,0 );
					float2 XZ315_g252170 = float2( 0,0 );
					float2 XY315_g252170 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g252170 , PositionWS315_g252170 , ZY315_g252170 , XZ315_g252170 , XY315_g252170 );
					float2 ZY402_g252170 = ZY315_g252170;
					float2 XZ403_g252170 = XZ315_g252170;
					float4 appendResult432_g252170 = (float4(ZY402_g252170 , XZ403_g252170));
					float4 In_MaskB431_g252170 = appendResult432_g252170;
					float2 XY404_g252170 = XY315_g252170;
					float localComputeStochasticCoords409_g252170 = ( 0.0 );
					float2 UV409_g252170 = ZY402_g252170;
					float2 UV1409_g252170 = float2( 0,0 );
					float2 UV2409_g252170 = float2( 0,0 );
					float2 UV3409_g252170 = float2( 0,0 );
					float3 Weights409_g252170 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g252170 , UV1409_g252170 , UV2409_g252170 , UV3409_g252170 , Weights409_g252170 );
					float4 appendResult433_g252170 = (float4(XY404_g252170 , UV1409_g252170));
					float4 In_MaskC431_g252170 = appendResult433_g252170;
					float4 appendResult434_g252170 = (float4(UV2409_g252170 , UV3409_g252170));
					float4 In_MaskD431_g252170 = appendResult434_g252170;
					float localComputeStochasticCoords422_g252170 = ( 0.0 );
					float2 UV422_g252170 = XZ403_g252170;
					float2 UV1422_g252170 = float2( 0,0 );
					float2 UV2422_g252170 = float2( 0,0 );
					float2 UV3422_g252170 = float2( 0,0 );
					float3 Weights422_g252170 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g252170 , UV1422_g252170 , UV2422_g252170 , UV3422_g252170 , Weights422_g252170 );
					float4 appendResult435_g252170 = (float4(UV1422_g252170 , UV2422_g252170));
					float4 In_MaskE431_g252170 = appendResult435_g252170;
					float localComputeStochasticCoords423_g252170 = ( 0.0 );
					float2 UV423_g252170 = XY404_g252170;
					float2 UV1423_g252170 = float2( 0,0 );
					float2 UV2423_g252170 = float2( 0,0 );
					float2 UV3423_g252170 = float2( 0,0 );
					float3 Weights423_g252170 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g252170 , UV1423_g252170 , UV2423_g252170 , UV3423_g252170 , Weights423_g252170 );
					float4 appendResult436_g252170 = (float4(UV3422_g252170 , UV1423_g252170));
					float4 In_MaskF431_g252170 = appendResult436_g252170;
					float4 appendResult437_g252170 = (float4(UV2423_g252170 , UV3423_g252170));
					float4 In_MaskG431_g252170 = appendResult437_g252170;
					float4 In_MaskH431_g252170 = float4( Weights409_g252170 , 0.0 );
					float4 In_MaskI431_g252170 = float4( Weights422_g252170 , 0.0 );
					float4 In_MaskJ431_g252170 = float4( Weights423_g252170 , 0.0 );
					half3 Model_NormalWS226_g252148 = Out_NormalWS15_g252149;
					float3 temp_output_449_0_g252170 = Model_NormalWS226_g252148;
					float4 In_MaskK431_g252170 = float4( temp_output_449_0_g252170 , 0.0 );
					half3 Model_TangentWS366_g252148 = Out_TangentWS15_g252149;
					float3 temp_output_450_0_g252170 = Model_TangentWS366_g252148;
					float4 In_MaskL431_g252170 = float4( temp_output_450_0_g252170 , 0.0 );
					half3 Model_BitangentWS367_g252148 = Out_BitangentWS15_g252149;
					float3 temp_output_451_0_g252170 = Model_BitangentWS367_g252148;
					float4 In_MaskM431_g252170 = float4( temp_output_451_0_g252170 , 0.0 );
					half3 Model_TriplanarWeights368_g252148 = Out_TriplanarWeights15_g252149;
					float3 temp_output_445_0_g252170 = Model_TriplanarWeights368_g252148;
					float4 In_MaskN431_g252170 = float4( temp_output_445_0_g252170 , 0.0 );
					BuildTextureData( Data431_g252170 , In_MaskA431_g252170 , In_MaskB431_g252170 , In_MaskC431_g252170 , In_MaskD431_g252170 , In_MaskE431_g252170 , In_MaskF431_g252170 , In_MaskG431_g252170 , In_MaskH431_g252170 , In_MaskI431_g252170 , In_MaskJ431_g252170 , In_MaskK431_g252170 , In_MaskL431_g252170 , In_MaskM431_g252170 , In_MaskN431_g252170 );
					TVEMasksData Data456_g252171 =(TVEMasksData)Data431_g252170;
					float4 Out_MaskA456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g252171 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g252171 , Out_MaskA456_g252171 , Out_MaskB456_g252171 , Out_MaskC456_g252171 , Out_MaskD456_g252171 , Out_MaskE456_g252171 , Out_MaskF456_g252171 , Out_MaskG456_g252171 , Out_MaskH456_g252171 , Out_MaskI456_g252171 , Out_MaskJ456_g252171 , Out_MaskK456_g252171 , Out_MaskL456_g252171 , Out_MaskM456_g252171 , Out_MaskN456_g252171 );
					half2 UV276_g252171 = (Out_MaskA456_g252171).xy;
					float temp_output_504_0_g252171 = 0.0;
					half Bias276_g252171 = temp_output_504_0_g252171;
					half2 Normal276_g252171 = float2( 0,0 );
					half4 localSampleCoord276_g252171 = SampleCoord( Texture276_g252171 , Sampler276_g252171 , UV276_g252171 , Bias276_g252171 , Normal276_g252171 );
					float4 temp_output_407_277_g252148 = localSampleCoord276_g252171;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g252171) = _MainAlbedoTex;
					SamplerState Sampler502_g252171 = staticSwitch36_g252153;
					half2 UV502_g252171 = (Out_MaskA456_g252171).zw;
					half Bias502_g252171 = temp_output_504_0_g252171;
					half2 Normal502_g252171 = float2( 0,0 );
					half4 localSampleCoord502_g252171 = SampleCoord( Texture502_g252171 , Sampler502_g252171 , UV502_g252171 , Bias502_g252171 , Normal502_g252171 );
					float4 temp_output_407_278_g252148 = localSampleCoord502_g252171;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252171) = _MainAlbedoTex;
					SamplerState Sampler496_g252171 = staticSwitch36_g252153;
					float2 temp_output_463_0_g252171 = (Out_MaskB456_g252171).zw;
					half2 XZ496_g252171 = temp_output_463_0_g252171;
					half Bias496_g252171 = temp_output_504_0_g252171;
					half3 NormalWS512_g252171 = (Out_MaskK456_g252171).xyz;
					half3 NormalWS496_g252171 = NormalWS512_g252171;
					half3 Normal496_g252171 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g252171 = SamplePlanar2D( Texture496_g252171 , Sampler496_g252171 , XZ496_g252171 , Bias496_g252171 , NormalWS496_g252171 , Normal496_g252171 );
					float4 temp_output_407_0_g252148 = localSamplePlanar2D496_g252171;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252171) = _MainAlbedoTex;
					SamplerState Sampler490_g252171 = staticSwitch36_g252153;
					float2 temp_output_462_0_g252171 = (Out_MaskB456_g252171).xy;
					half2 ZY490_g252171 = temp_output_462_0_g252171;
					half2 XZ490_g252171 = temp_output_463_0_g252171;
					float2 temp_output_464_0_g252171 = (Out_MaskC456_g252171).xy;
					half2 XY490_g252171 = temp_output_464_0_g252171;
					half Bias490_g252171 = temp_output_504_0_g252171;
					half3 Triplanar522_g252171 = (Out_MaskN456_g252171).xyz;
					half3 Triplanar490_g252171 = Triplanar522_g252171;
					half3 NormalWS490_g252171 = NormalWS512_g252171;
					half3 Normal490_g252171 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g252171 = SamplePlanar3D( Texture490_g252171 , Sampler490_g252171 , ZY490_g252171 , XZ490_g252171 , XY490_g252171 , Bias490_g252171 , Triplanar490_g252171 , NormalWS490_g252171 , Normal490_g252171 );
					float4 temp_output_407_201_g252148 = localSamplePlanar3D490_g252171;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g252171) = _MainAlbedoTex;
					SamplerState Sampler498_g252171 = staticSwitch36_g252153;
					half2 XZ498_g252171 = temp_output_463_0_g252171;
					float2 temp_output_473_0_g252171 = (Out_MaskE456_g252171).xy;
					half2 XZ_1498_g252171 = temp_output_473_0_g252171;
					float2 temp_output_474_0_g252171 = (Out_MaskE456_g252171).zw;
					half2 XZ_2498_g252171 = temp_output_474_0_g252171;
					float2 temp_output_475_0_g252171 = (Out_MaskF456_g252171).xy;
					half2 XZ_3498_g252171 = temp_output_475_0_g252171;
					float temp_output_510_0_g252171 = exp2( temp_output_504_0_g252171 );
					half Bias498_g252171 = temp_output_510_0_g252171;
					float3 temp_output_480_0_g252171 = (Out_MaskI456_g252171).xyz;
					half3 Weights_2498_g252171 = temp_output_480_0_g252171;
					half3 NormalWS498_g252171 = NormalWS512_g252171;
					half3 Normal498_g252171 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g252171 = SampleStochastic2D( Texture498_g252171 , Sampler498_g252171 , XZ498_g252171 , XZ_1498_g252171 , XZ_2498_g252171 , XZ_3498_g252171 , Bias498_g252171 , Weights_2498_g252171 , NormalWS498_g252171 , Normal498_g252171 );
					float4 temp_output_407_202_g252148 = localSampleStochastic2D498_g252171;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g252171) = _MainAlbedoTex;
					SamplerState Sampler500_g252171 = staticSwitch36_g252153;
					half2 ZY500_g252171 = temp_output_462_0_g252171;
					half2 ZY_1500_g252171 = (Out_MaskC456_g252171).zw;
					half2 ZY_2500_g252171 = (Out_MaskD456_g252171).xy;
					half2 ZY_3500_g252171 = (Out_MaskD456_g252171).zw;
					half2 XZ500_g252171 = temp_output_463_0_g252171;
					half2 XZ_1500_g252171 = temp_output_473_0_g252171;
					half2 XZ_2500_g252171 = temp_output_474_0_g252171;
					half2 XZ_3500_g252171 = temp_output_475_0_g252171;
					half2 XY500_g252171 = temp_output_464_0_g252171;
					half2 XY_1500_g252171 = (Out_MaskF456_g252171).zw;
					half2 XY_2500_g252171 = (Out_MaskG456_g252171).xy;
					half2 XY_3500_g252171 = (Out_MaskG456_g252171).zw;
					half Bias500_g252171 = temp_output_510_0_g252171;
					half3 Weights_1500_g252171 = (Out_MaskH456_g252171).xyz;
					half3 Weights_2500_g252171 = temp_output_480_0_g252171;
					half3 Weights_3500_g252171 = (Out_MaskJ456_g252171).xyz;
					half3 Triplanar500_g252171 = Triplanar522_g252171;
					half3 NormalWS500_g252171 = NormalWS512_g252171;
					half3 Normal500_g252171 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g252171 = SampleStochastic3D( Texture500_g252171 , Sampler500_g252171 , ZY500_g252171 , ZY_1500_g252171 , ZY_2500_g252171 , ZY_3500_g252171 , XZ500_g252171 , XZ_1500_g252171 , XZ_2500_g252171 , XZ_3500_g252171 , XY500_g252171 , XY_1500_g252171 , XY_2500_g252171 , XY_3500_g252171 , Bias500_g252171 , Weights_1500_g252171 , Weights_2500_g252171 , Weights_3500_g252171 , Triplanar500_g252171 , NormalWS500_g252171 , Normal500_g252171 );
					float4 temp_output_407_203_g252148 = localSampleStochastic3D500_g252171;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g252148 = temp_output_407_277_g252148;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g252148 = temp_output_407_278_g252148;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g252148 = temp_output_407_0_g252148;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g252148 = temp_output_407_201_g252148;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g252148 = temp_output_407_202_g252148;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g252148 = temp_output_407_203_g252148;
					#else
					float4 staticSwitch184_g252148 = temp_output_407_277_g252148;
					#endif
					half4 Local_AlbedoSample185_g252148 = staticSwitch184_g252148;
					float3 lerpResult53_g252148 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g252148).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g252148 = lerpResult53_g252148;
					float temp_output_17_0_g252168 = _MainMultiWriteMode;
					float Option91_g252168 = temp_output_17_0_g252168;
					float4 Model_VertexData418_g252148 = Out_VertexData15_g252149;
					float4 temp_output_84_0_g252168 = Model_VertexData418_g252148;
					float4 ChannelA91_g252168 = temp_output_84_0_g252168;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g252156) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g252155 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g252155 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g252155 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g252155 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g252155 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g252155 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g252156 = staticSwitch38_g252155;
					float localBreakTextureData456_g252156 = ( 0.0 );
					TVEMasksData Data456_g252156 =(TVEMasksData)Data431_g252170;
					float4 Out_MaskA456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g252156 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g252156 , Out_MaskA456_g252156 , Out_MaskB456_g252156 , Out_MaskC456_g252156 , Out_MaskD456_g252156 , Out_MaskE456_g252156 , Out_MaskF456_g252156 , Out_MaskG456_g252156 , Out_MaskH456_g252156 , Out_MaskI456_g252156 , Out_MaskJ456_g252156 , Out_MaskK456_g252156 , Out_MaskL456_g252156 , Out_MaskM456_g252156 , Out_MaskN456_g252156 );
					half2 UV276_g252156 = (Out_MaskA456_g252156).xy;
					float temp_output_504_0_g252156 = 0.0;
					half Bias276_g252156 = temp_output_504_0_g252156;
					half2 Normal276_g252156 = float2( 0,0 );
					half4 localSampleCoord276_g252156 = SampleCoord( Texture276_g252156 , Sampler276_g252156 , UV276_g252156 , Bias276_g252156 , Normal276_g252156 );
					float4 temp_output_405_277_g252148 = localSampleCoord276_g252156;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g252156) = _MainShaderTex;
					SamplerState Sampler502_g252156 = staticSwitch38_g252155;
					half2 UV502_g252156 = (Out_MaskA456_g252156).zw;
					half Bias502_g252156 = temp_output_504_0_g252156;
					half2 Normal502_g252156 = float2( 0,0 );
					half4 localSampleCoord502_g252156 = SampleCoord( Texture502_g252156 , Sampler502_g252156 , UV502_g252156 , Bias502_g252156 , Normal502_g252156 );
					float4 temp_output_405_278_g252148 = localSampleCoord502_g252156;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252156) = _MainShaderTex;
					SamplerState Sampler496_g252156 = staticSwitch38_g252155;
					float2 temp_output_463_0_g252156 = (Out_MaskB456_g252156).zw;
					half2 XZ496_g252156 = temp_output_463_0_g252156;
					half Bias496_g252156 = temp_output_504_0_g252156;
					half3 NormalWS512_g252156 = (Out_MaskK456_g252156).xyz;
					half3 NormalWS496_g252156 = NormalWS512_g252156;
					half3 Normal496_g252156 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g252156 = SamplePlanar2D( Texture496_g252156 , Sampler496_g252156 , XZ496_g252156 , Bias496_g252156 , NormalWS496_g252156 , Normal496_g252156 );
					float4 temp_output_405_0_g252148 = localSamplePlanar2D496_g252156;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252156) = _MainShaderTex;
					SamplerState Sampler490_g252156 = staticSwitch38_g252155;
					float2 temp_output_462_0_g252156 = (Out_MaskB456_g252156).xy;
					half2 ZY490_g252156 = temp_output_462_0_g252156;
					half2 XZ490_g252156 = temp_output_463_0_g252156;
					float2 temp_output_464_0_g252156 = (Out_MaskC456_g252156).xy;
					half2 XY490_g252156 = temp_output_464_0_g252156;
					half Bias490_g252156 = temp_output_504_0_g252156;
					half3 Triplanar522_g252156 = (Out_MaskN456_g252156).xyz;
					half3 Triplanar490_g252156 = Triplanar522_g252156;
					half3 NormalWS490_g252156 = NormalWS512_g252156;
					half3 Normal490_g252156 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g252156 = SamplePlanar3D( Texture490_g252156 , Sampler490_g252156 , ZY490_g252156 , XZ490_g252156 , XY490_g252156 , Bias490_g252156 , Triplanar490_g252156 , NormalWS490_g252156 , Normal490_g252156 );
					float4 temp_output_405_201_g252148 = localSamplePlanar3D490_g252156;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g252156) = _MainShaderTex;
					SamplerState Sampler498_g252156 = staticSwitch38_g252155;
					half2 XZ498_g252156 = temp_output_463_0_g252156;
					float2 temp_output_473_0_g252156 = (Out_MaskE456_g252156).xy;
					half2 XZ_1498_g252156 = temp_output_473_0_g252156;
					float2 temp_output_474_0_g252156 = (Out_MaskE456_g252156).zw;
					half2 XZ_2498_g252156 = temp_output_474_0_g252156;
					float2 temp_output_475_0_g252156 = (Out_MaskF456_g252156).xy;
					half2 XZ_3498_g252156 = temp_output_475_0_g252156;
					float temp_output_510_0_g252156 = exp2( temp_output_504_0_g252156 );
					half Bias498_g252156 = temp_output_510_0_g252156;
					float3 temp_output_480_0_g252156 = (Out_MaskI456_g252156).xyz;
					half3 Weights_2498_g252156 = temp_output_480_0_g252156;
					half3 NormalWS498_g252156 = NormalWS512_g252156;
					half3 Normal498_g252156 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g252156 = SampleStochastic2D( Texture498_g252156 , Sampler498_g252156 , XZ498_g252156 , XZ_1498_g252156 , XZ_2498_g252156 , XZ_3498_g252156 , Bias498_g252156 , Weights_2498_g252156 , NormalWS498_g252156 , Normal498_g252156 );
					float4 temp_output_405_202_g252148 = localSampleStochastic2D498_g252156;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g252156) = _MainShaderTex;
					SamplerState Sampler500_g252156 = staticSwitch38_g252155;
					half2 ZY500_g252156 = temp_output_462_0_g252156;
					half2 ZY_1500_g252156 = (Out_MaskC456_g252156).zw;
					half2 ZY_2500_g252156 = (Out_MaskD456_g252156).xy;
					half2 ZY_3500_g252156 = (Out_MaskD456_g252156).zw;
					half2 XZ500_g252156 = temp_output_463_0_g252156;
					half2 XZ_1500_g252156 = temp_output_473_0_g252156;
					half2 XZ_2500_g252156 = temp_output_474_0_g252156;
					half2 XZ_3500_g252156 = temp_output_475_0_g252156;
					half2 XY500_g252156 = temp_output_464_0_g252156;
					half2 XY_1500_g252156 = (Out_MaskF456_g252156).zw;
					half2 XY_2500_g252156 = (Out_MaskG456_g252156).xy;
					half2 XY_3500_g252156 = (Out_MaskG456_g252156).zw;
					half Bias500_g252156 = temp_output_510_0_g252156;
					half3 Weights_1500_g252156 = (Out_MaskH456_g252156).xyz;
					half3 Weights_2500_g252156 = temp_output_480_0_g252156;
					half3 Weights_3500_g252156 = (Out_MaskJ456_g252156).xyz;
					half3 Triplanar500_g252156 = Triplanar522_g252156;
					half3 NormalWS500_g252156 = NormalWS512_g252156;
					half3 Normal500_g252156 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g252156 = SampleStochastic3D( Texture500_g252156 , Sampler500_g252156 , ZY500_g252156 , ZY_1500_g252156 , ZY_2500_g252156 , ZY_3500_g252156 , XZ500_g252156 , XZ_1500_g252156 , XZ_2500_g252156 , XZ_3500_g252156 , XY500_g252156 , XY_1500_g252156 , XY_2500_g252156 , XY_3500_g252156 , Bias500_g252156 , Weights_1500_g252156 , Weights_2500_g252156 , Weights_3500_g252156 , Triplanar500_g252156 , NormalWS500_g252156 , Normal500_g252156 );
					float4 temp_output_405_203_g252148 = localSampleStochastic3D500_g252156;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g252148 = temp_output_405_277_g252148;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g252148 = temp_output_405_278_g252148;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g252148 = temp_output_405_0_g252148;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g252148 = temp_output_405_201_g252148;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g252148 = temp_output_405_202_g252148;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g252148 = temp_output_405_203_g252148;
					#else
					float4 staticSwitch198_g252148 = temp_output_405_277_g252148;
					#endif
					half4 Local_ShaderSample199_g252148 = staticSwitch198_g252148;
					float2 appendResult428_g252148 = (float2((Local_AlbedoSample185_g252148).w , (Local_ShaderSample199_g252148).z));
					float2 temp_output_85_0_g252168 = appendResult428_g252148;
					float4 ChannelB91_g252168 = float4( temp_output_85_0_g252168, 0.0 , 0.0 );
					float localSwitchChannel691_g252168 = SwitchChannel6( Option91_g252168 , ChannelA91_g252168 , ChannelB91_g252168 );
					float clampResult17_g252166 = clamp( localSwitchChannel691_g252168 , 0.0001 , 0.9999 );
					float temp_output_7_0_g252167 = _MainMultiWriteRemap.x;
					float temp_output_9_0_g252167 = ( clampResult17_g252166 - temp_output_7_0_g252167 );
					half Local_MultiMask78_g252148 = saturate( ( temp_output_9_0_g252167 * _MainMultiWriteRemap.z ) );
					float lerpResult58_g252148 = lerp( 1.0 , Local_MultiMask78_g252148 , _MainColorMode);
					float4 lerpResult62_g252148 = lerp( _MainColorTwo , _MainColor , lerpResult58_g252148);
					half3 Local_ColorRGB93_g252148 = (lerpResult62_g252148).rgb;
					half3 Local_Albedo139_g252148 = ( Local_AlbedoRGB107_g252148 * Local_ColorRGB93_g252148 );
					float3 temp_output_4_0_g252150 = Local_Albedo139_g252148;
					float3 In_Albedo3_g252150 = temp_output_4_0_g252150;
					float3 temp_output_44_0_g252150 = Local_Albedo139_g252148;
					float3 In_AlbedoBase3_g252150 = temp_output_44_0_g252150;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g252177) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g252154 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g252154 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g252154 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g252154 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g252154 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g252154 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g252177 = staticSwitch37_g252154;
					float localBreakTextureData456_g252177 = ( 0.0 );
					TVEMasksData Data456_g252177 =(TVEMasksData)Data431_g252170;
					float4 Out_MaskA456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g252177 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g252177 , Out_MaskA456_g252177 , Out_MaskB456_g252177 , Out_MaskC456_g252177 , Out_MaskD456_g252177 , Out_MaskE456_g252177 , Out_MaskF456_g252177 , Out_MaskG456_g252177 , Out_MaskH456_g252177 , Out_MaskI456_g252177 , Out_MaskJ456_g252177 , Out_MaskK456_g252177 , Out_MaskL456_g252177 , Out_MaskM456_g252177 , Out_MaskN456_g252177 );
					half2 UV276_g252177 = (Out_MaskA456_g252177).xy;
					float temp_output_504_0_g252177 = 0.0;
					half Bias276_g252177 = temp_output_504_0_g252177;
					half2 Normal276_g252177 = float2( 0,0 );
					half4 localSampleCoord276_g252177 = SampleCoord( Texture276_g252177 , Sampler276_g252177 , UV276_g252177 , Bias276_g252177 , Normal276_g252177 );
					float2 temp_output_406_394_g252148 = Normal276_g252177;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g252177) = _MainNormalTex;
					SamplerState Sampler502_g252177 = staticSwitch37_g252154;
					half2 UV502_g252177 = (Out_MaskA456_g252177).zw;
					half Bias502_g252177 = temp_output_504_0_g252177;
					half2 Normal502_g252177 = float2( 0,0 );
					half4 localSampleCoord502_g252177 = SampleCoord( Texture502_g252177 , Sampler502_g252177 , UV502_g252177 , Bias502_g252177 , Normal502_g252177 );
					float2 temp_output_406_397_g252148 = Normal502_g252177;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252177) = _MainNormalTex;
					SamplerState Sampler496_g252177 = staticSwitch37_g252154;
					float2 temp_output_463_0_g252177 = (Out_MaskB456_g252177).zw;
					half2 XZ496_g252177 = temp_output_463_0_g252177;
					half Bias496_g252177 = temp_output_504_0_g252177;
					half3 NormalWS512_g252177 = (Out_MaskK456_g252177).xyz;
					half3 NormalWS496_g252177 = NormalWS512_g252177;
					half3 Normal496_g252177 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g252177 = SamplePlanar2D( Texture496_g252177 , Sampler496_g252177 , XZ496_g252177 , Bias496_g252177 , NormalWS496_g252177 , Normal496_g252177 );
					float3 temp_output_35_0_g252180 = Normal496_g252177;
					half3 TangentWS519_g252177 = (Out_MaskL456_g252177).xyz;
					float dotResult84_g252180 = dot( temp_output_35_0_g252180 , TangentWS519_g252177 );
					half3 BitangentWS521_g252177 = (Out_MaskM456_g252177).xyz;
					float dotResult85_g252180 = dot( temp_output_35_0_g252180 , BitangentWS521_g252177 );
					float2 appendResult87_g252180 = (float2(dotResult84_g252180 , dotResult85_g252180));
					float2 temp_output_406_375_g252148 = appendResult87_g252180;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252177) = _MainNormalTex;
					SamplerState Sampler490_g252177 = staticSwitch37_g252154;
					float2 temp_output_462_0_g252177 = (Out_MaskB456_g252177).xy;
					half2 ZY490_g252177 = temp_output_462_0_g252177;
					half2 XZ490_g252177 = temp_output_463_0_g252177;
					float2 temp_output_464_0_g252177 = (Out_MaskC456_g252177).xy;
					half2 XY490_g252177 = temp_output_464_0_g252177;
					half Bias490_g252177 = temp_output_504_0_g252177;
					half3 Triplanar522_g252177 = (Out_MaskN456_g252177).xyz;
					half3 Triplanar490_g252177 = Triplanar522_g252177;
					half3 NormalWS490_g252177 = NormalWS512_g252177;
					half3 Normal490_g252177 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g252177 = SamplePlanar3D( Texture490_g252177 , Sampler490_g252177 , ZY490_g252177 , XZ490_g252177 , XY490_g252177 , Bias490_g252177 , Triplanar490_g252177 , NormalWS490_g252177 , Normal490_g252177 );
					float3 temp_output_35_0_g252181 = Normal490_g252177;
					float dotResult84_g252181 = dot( temp_output_35_0_g252181 , TangentWS519_g252177 );
					float dotResult85_g252181 = dot( temp_output_35_0_g252181 , BitangentWS521_g252177 );
					float2 appendResult87_g252181 = (float2(dotResult84_g252181 , dotResult85_g252181));
					float2 temp_output_406_353_g252148 = appendResult87_g252181;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g252177) = _MainNormalTex;
					SamplerState Sampler498_g252177 = staticSwitch37_g252154;
					half2 XZ498_g252177 = temp_output_463_0_g252177;
					float2 temp_output_473_0_g252177 = (Out_MaskE456_g252177).xy;
					half2 XZ_1498_g252177 = temp_output_473_0_g252177;
					float2 temp_output_474_0_g252177 = (Out_MaskE456_g252177).zw;
					half2 XZ_2498_g252177 = temp_output_474_0_g252177;
					float2 temp_output_475_0_g252177 = (Out_MaskF456_g252177).xy;
					half2 XZ_3498_g252177 = temp_output_475_0_g252177;
					float temp_output_510_0_g252177 = exp2( temp_output_504_0_g252177 );
					half Bias498_g252177 = temp_output_510_0_g252177;
					float3 temp_output_480_0_g252177 = (Out_MaskI456_g252177).xyz;
					half3 Weights_2498_g252177 = temp_output_480_0_g252177;
					half3 NormalWS498_g252177 = NormalWS512_g252177;
					half3 Normal498_g252177 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g252177 = SampleStochastic2D( Texture498_g252177 , Sampler498_g252177 , XZ498_g252177 , XZ_1498_g252177 , XZ_2498_g252177 , XZ_3498_g252177 , Bias498_g252177 , Weights_2498_g252177 , NormalWS498_g252177 , Normal498_g252177 );
					float3 temp_output_35_0_g252182 = Normal498_g252177;
					float dotResult84_g252182 = dot( temp_output_35_0_g252182 , TangentWS519_g252177 );
					float dotResult85_g252182 = dot( temp_output_35_0_g252182 , BitangentWS521_g252177 );
					float2 appendResult87_g252182 = (float2(dotResult84_g252182 , dotResult85_g252182));
					float2 temp_output_406_391_g252148 = appendResult87_g252182;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g252177) = _MainNormalTex;
					SamplerState Sampler500_g252177 = staticSwitch37_g252154;
					half2 ZY500_g252177 = temp_output_462_0_g252177;
					half2 ZY_1500_g252177 = (Out_MaskC456_g252177).zw;
					half2 ZY_2500_g252177 = (Out_MaskD456_g252177).xy;
					half2 ZY_3500_g252177 = (Out_MaskD456_g252177).zw;
					half2 XZ500_g252177 = temp_output_463_0_g252177;
					half2 XZ_1500_g252177 = temp_output_473_0_g252177;
					half2 XZ_2500_g252177 = temp_output_474_0_g252177;
					half2 XZ_3500_g252177 = temp_output_475_0_g252177;
					half2 XY500_g252177 = temp_output_464_0_g252177;
					half2 XY_1500_g252177 = (Out_MaskF456_g252177).zw;
					half2 XY_2500_g252177 = (Out_MaskG456_g252177).xy;
					half2 XY_3500_g252177 = (Out_MaskG456_g252177).zw;
					half Bias500_g252177 = temp_output_510_0_g252177;
					half3 Weights_1500_g252177 = (Out_MaskH456_g252177).xyz;
					half3 Weights_2500_g252177 = temp_output_480_0_g252177;
					half3 Weights_3500_g252177 = (Out_MaskJ456_g252177).xyz;
					half3 Triplanar500_g252177 = Triplanar522_g252177;
					half3 NormalWS500_g252177 = NormalWS512_g252177;
					half3 Normal500_g252177 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g252177 = SampleStochastic3D( Texture500_g252177 , Sampler500_g252177 , ZY500_g252177 , ZY_1500_g252177 , ZY_2500_g252177 , ZY_3500_g252177 , XZ500_g252177 , XZ_1500_g252177 , XZ_2500_g252177 , XZ_3500_g252177 , XY500_g252177 , XY_1500_g252177 , XY_2500_g252177 , XY_3500_g252177 , Bias500_g252177 , Weights_1500_g252177 , Weights_2500_g252177 , Weights_3500_g252177 , Triplanar500_g252177 , NormalWS500_g252177 , Normal500_g252177 );
					float3 temp_output_35_0_g252178 = Normal500_g252177;
					float dotResult84_g252178 = dot( temp_output_35_0_g252178 , TangentWS519_g252177 );
					float dotResult85_g252178 = dot( temp_output_35_0_g252178 , BitangentWS521_g252177 );
					float2 appendResult87_g252178 = (float2(dotResult84_g252178 , dotResult85_g252178));
					float2 temp_output_406_390_g252148 = appendResult87_g252178;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g252148 = temp_output_406_394_g252148;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g252148 = temp_output_406_397_g252148;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g252148 = temp_output_406_375_g252148;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g252148 = temp_output_406_353_g252148;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g252148 = temp_output_406_391_g252148;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g252148 = temp_output_406_390_g252148;
					#else
					float2 staticSwitch193_g252148 = temp_output_406_394_g252148;
					#endif
					half2 Local_NormaSample191_g252148 = staticSwitch193_g252148;
					half2 Local_NormalTS108_g252148 = ( Local_NormaSample191_g252148 * _MainNormalValue );
					float2 In_NormalTS3_g252150 = Local_NormalTS108_g252148;
					float2 break80_g252169 = Local_NormalTS108_g252148;
					float3 temp_output_77_0_g252169 = Model_TangentWS366_g252148;
					float3 temp_output_78_0_g252169 = Model_BitangentWS367_g252148;
					float3 temp_output_76_0_g252169 = Model_NormalWS226_g252148;
					half3 Local_NormalWS250_g252148 = ( ( break80_g252169.x * temp_output_77_0_g252169 ) + ( break80_g252169.y * temp_output_78_0_g252169 ) + temp_output_76_0_g252169 );
					float3 In_NormalWS3_g252150 = Local_NormalWS250_g252148;
					float temp_output_209_0_g252148 = (Local_ShaderSample199_g252148).y;
					float temp_output_7_0_g252162 = _MainOcclusionRemap.x;
					float temp_output_9_0_g252162 = ( temp_output_209_0_g252148 - temp_output_7_0_g252162 );
					float lerpResult23_g252148 = lerp( 1.0 , saturate( ( temp_output_9_0_g252162 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g252148 = lerpResult23_g252148;
					float temp_output_213_0_g252148 = (Local_ShaderSample199_g252148).w;
					float temp_output_7_0_g252165 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g252165 = ( temp_output_213_0_g252148 - temp_output_7_0_g252165 );
					half Local_Smoothness317_g252148 = ( saturate( ( temp_output_9_0_g252165 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g252148 = (float4(( (Local_ShaderSample199_g252148).x * _MainMetallicValue ) , Local_Occlusion313_g252148 , (Local_ShaderSample199_g252148).z , Local_Smoothness317_g252148));
					half4 Local_Masks109_g252148 = appendResult73_g252148;
					float4 In_Shader3_g252150 = Local_Masks109_g252148;
					float4 In_Feature3_g252150 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g252150 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g252150 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g252183 = Local_Albedo139_g252148;
					float dotResult20_g252183 = dot( temp_output_3_0_g252183 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g252148 = dotResult20_g252183;
					float temp_output_12_0_g252150 = Local_Grayscale110_g252148;
					float In_Grayscale3_g252150 = temp_output_12_0_g252150;
					float temp_output_3_0_g252184 = Local_Grayscale110_g252148;
					float clampResult27_g252184 = clamp( saturate( ( temp_output_3_0_g252184 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g252148 = clampResult27_g252184;
					float temp_output_16_0_g252150 = Local_Luminosity145_g252148;
					float In_Luminosity3_g252150 = temp_output_16_0_g252150;
					float In_MultiMask3_g252150 = Local_MultiMask78_g252148;
					float temp_output_187_0_g252148 = (Local_AlbedoSample185_g252148).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g252148 = ( temp_output_187_0_g252148 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g252148 = temp_output_187_0_g252148;
					#endif
					half Local_AlphaClip111_g252148 = staticSwitch236_g252148;
					float In_AlphaClip3_g252150 = Local_AlphaClip111_g252148;
					half Local_AlphaFade246_g252148 = (lerpResult62_g252148).a;
					float In_AlphaFade3_g252150 = Local_AlphaFade246_g252148;
					float3 temp_cast_33 = (1.0).xxx;
					float3 In_Translucency3_g252150 = temp_cast_33;
					float In_Transmission3_g252150 = 1.0;
					float In_Thickness3_g252150 = 0.0;
					float In_Diffusion3_g252150 = 0.0;
					float In_Depth3_g252150 = 0.0;
					BuildVisualData( Data3_g252150 , In_Dummy3_g252150 , In_Albedo3_g252150 , In_AlbedoBase3_g252150 , In_NormalTS3_g252150 , In_NormalWS3_g252150 , In_Shader3_g252150 , In_Feature3_g252150 , In_Season3_g252150 , In_Emissive3_g252150 , In_Grayscale3_g252150 , In_Luminosity3_g252150 , In_MultiMask3_g252150 , In_AlphaClip3_g252150 , In_AlphaFade3_g252150 , In_Translucency3_g252150 , In_Transmission3_g252150 , In_Thickness3_g252150 , In_Diffusion3_g252150 , In_Depth3_g252150 );
					TVEVisualData Data4_g252193 =(TVEVisualData)Data3_g252150;
					float Out_Dummy4_g252193 = 0.0;
					float3 Out_Albedo4_g252193 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g252193 = float3( 0,0,0 );
					float2 Out_NormalTS4_g252193 = float2( 0,0 );
					float3 Out_NormalWS4_g252193 = float3( 0,0,0 );
					float4 Out_Shader4_g252193 = float4( 0,0,0,0 );
					float4 Out_Feature4_g252193 = float4( 0,0,0,0 );
					float4 Out_Season4_g252193 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g252193 = float4( 0,0,0,0 );
					float Out_MultiMask4_g252193 = 0.0;
					float Out_Grayscale4_g252193 = 0.0;
					float Out_Luminosity4_g252193 = 0.0;
					float Out_AlphaClip4_g252193 = 0.0;
					float Out_AlphaFade4_g252193 = 0.0;
					float3 Out_Translucency4_g252193 = float3( 0,0,0 );
					float Out_Transmission4_g252193 = 0.0;
					float Out_Thickness4_g252193 = 0.0;
					float Out_Diffusion4_g252193 = 0.0;
					float Out_Depth4_g252193 = 0.0;
					BreakVisualData( Data4_g252193 , Out_Dummy4_g252193 , Out_Albedo4_g252193 , Out_AlbedoBase4_g252193 , Out_NormalTS4_g252193 , Out_NormalWS4_g252193 , Out_Shader4_g252193 , Out_Feature4_g252193 , Out_Season4_g252193 , Out_Emissive4_g252193 , Out_MultiMask4_g252193 , Out_Grayscale4_g252193 , Out_Luminosity4_g252193 , Out_AlphaClip4_g252193 , Out_AlphaFade4_g252193 , Out_Translucency4_g252193 , Out_Transmission4_g252193 , Out_Thickness4_g252193 , Out_Diffusion4_g252193 , Out_Depth4_g252193 );
					float Alpha109_g252188 = Out_AlphaClip4_g252193;
					float lerpResult91_g252188 = lerp( 1.0 , Alpha109_g252188 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g252188 = lerp( 1.0 , lerpResult91_g252188 , Filter152_g252188);
					clip( lerpResult154_g252188 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = temp_cast_1;
					half Metallic = 0;
					half Smoothness = temp_output_2587_114;
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

					o.Emission = ( lerpResult72_g252188 * lerpResult84_g252188 );
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
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
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

				uniform half TVE_DEBUG_Index;
				uniform half TVE_DEBUG_Clip;
				uniform half TVE_DEBUG_Min;
				uniform half TVE_DEBUG_Max;
				uniform half TVE_DEBUG_Shading;
				uniform half _IsTVEShader;
				uniform half TVE_DEBUG_Filter;
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
				uniform float4 TVE_RenderBasePositionR;
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

					TVEVertexData Data16_g251819 =(TVEVertexData)0;
					float In_Dummy16_g251819 = 0.0;
					TVEVertexData Data16_g251813 =(TVEVertexData)0;
					float In_Dummy16_g251813 = 0.0;
					float localIfModelDataByShader26_g251590 = ( 0.0 );
					TVEModelData Data26_g251590 = (TVEModelData)0;
					TVEModelData Data16_g251630 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g251612 = _ObjectCoordMode;
					#else
					float staticSwitch343_g251612 = _ObjectCoordMode;
					#endif
					half Dummy207_g251612 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g251612 );
					float temp_output_14_0_g251630 = Dummy207_g251612;
					float In_Dummy16_g251630 = temp_output_14_0_g251630;
					float3 PositionOS131_g251612 = v.vertex.xyz;
					float3 temp_output_4_0_g251630 = PositionOS131_g251612;
					float3 In_PositionOS16_g251630 = temp_output_4_0_g251630;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g251612 = ase_positionWS;
					float3 vertexToFrag73_g251612 = temp_output_104_7_g251612;
					float3 PositionWS122_g251612 = vertexToFrag73_g251612;
					float3 In_PositionWS16_g251630 = PositionWS122_g251612;
					float4x4 break19_g251615 = unity_ObjectToWorld;
					float3 appendResult20_g251615 = (float3(break19_g251615[ 0 ][ 3 ] , break19_g251615[ 1 ][ 3 ] , break19_g251615[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251612 = appendResult20_g251615;
					float4x4 break19_g251617 = unity_ObjectToWorld;
					float3 appendResult20_g251617 = (float3(break19_g251617[ 0 ][ 3 ] , break19_g251617[ 1 ][ 3 ] , break19_g251617[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g251613 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g251612 = PositionOS131_g251612;
					float3 appendResult234_g251612 = (float3(break233_g251612.x , 0.0 , break233_g251612.z));
					float3 break413_g251612 = PositionOS131_g251612;
					float3 appendResult414_g251612 = (float3(break413_g251612.x , break413_g251612.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251619 = appendResult414_g251612;
					#else
					float3 staticSwitch65_g251619 = appendResult234_g251612;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g251612 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g251612 = appendResult60_g251613;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g251612 = staticSwitch65_g251619;
					#else
					float3 staticSwitch229_g251612 = _Vector0;
					#endif
					float3 PivotOS149_g251612 = staticSwitch229_g251612;
					float3 temp_output_122_0_g251617 = PivotOS149_g251612;
					float3 PivotsOnlyWS105_g251617 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g251617 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g251612 = ( appendResult20_g251617 + PivotsOnlyWS105_g251617 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g251612 = temp_output_340_7_g251612;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g251612 = temp_output_341_7_g251612;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g251612 = temp_output_341_7_g251612;
					#else
					float3 staticSwitch236_g251612 = temp_output_340_7_g251612;
					#endif
					float3 vertexToFrag76_g251612 = staticSwitch236_g251612;
					float3 PivotWS121_g251612 = vertexToFrag76_g251612;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251612 = ( PositionWS122_g251612 - PivotWS121_g251612 );
					#else
					float3 staticSwitch204_g251612 = PositionWS122_g251612;
					#endif
					float3 PositionWO132_g251612 = ( staticSwitch204_g251612 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251630 = PositionWO132_g251612;
					float3 In_PivotOS16_g251630 = PivotOS149_g251612;
					float3 In_PivotWS16_g251630 = PivotWS121_g251612;
					float3 PivotWO133_g251612 = ( PivotWS121_g251612 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251630 = PivotWO133_g251612;
					half3 NormalOS134_g251612 = v.normal;
					float3 temp_output_21_0_g251630 = NormalOS134_g251612;
					float3 In_NormalOS16_g251630 = temp_output_21_0_g251630;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g251612 = normalizedWorldNormal;
					float3 In_NormalWS16_g251630 = NormalWS95_g251612;
					half4 TangentlOS153_g251612 = v.tangent;
					float4 temp_output_6_0_g251630 = TangentlOS153_g251612;
					float4 In_TangentOS16_g251630 = temp_output_6_0_g251630;
					float3 normalizeResult296_g251612 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251612 ) );
					half3 ViewDirWS169_g251612 = normalizeResult296_g251612;
					float3 In_ViewDirWS16_g251630 = ViewDirWS169_g251612;
					float4 appendResult397_g251612 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g251612 = appendResult397_g251612;
					float4 In_CoordsData16_g251630 = CoordsData398_g251612;
					half4 VertexMasks171_g251612 = v.ase_color;
					float4 In_VertexData16_g251630 = VertexMasks171_g251612;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251624 = (PositionOS131_g251612).z;
					#else
					float staticSwitch65_g251624 = (PositionOS131_g251612).y;
					#endif
					half Object_HeightValue267_g251612 = _ObjectHeightValue;
					half Bounds_HeightMask274_g251612 = saturate( ( staticSwitch65_g251624 / Object_HeightValue267_g251612 ) );
					half3 Position387_g251612 = PositionOS131_g251612;
					half Height387_g251612 = Object_HeightValue267_g251612;
					half Object_RadiusValue268_g251612 = _ObjectRadiusValue;
					half Radius387_g251612 = Object_RadiusValue268_g251612;
					half localCapsuleMaskYUp387_g251612 = CapsuleMaskYUp( Position387_g251612 , Height387_g251612 , Radius387_g251612 );
					half3 Position408_g251612 = PositionOS131_g251612;
					half Height408_g251612 = Object_HeightValue267_g251612;
					half Radius408_g251612 = Object_RadiusValue268_g251612;
					half localCapsuleMaskZUp408_g251612 = CapsuleMaskZUp( Position408_g251612 , Height408_g251612 , Radius408_g251612 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251629 = saturate( localCapsuleMaskZUp408_g251612 );
					#else
					float staticSwitch65_g251629 = saturate( localCapsuleMaskYUp387_g251612 );
					#endif
					half Bounds_SphereMask282_g251612 = staticSwitch65_g251629;
					float4 appendResult253_g251612 = (float4(Bounds_HeightMask274_g251612 , Bounds_SphereMask282_g251612 , 1.0 , 1.0));
					half4 MasksData254_g251612 = appendResult253_g251612;
					float4 In_MasksData16_g251630 = MasksData254_g251612;
					float temp_output_17_0_g251623 = _ObjectPhaseMode;
					float Option70_g251623 = temp_output_17_0_g251623;
					float4 temp_output_3_0_g251623 = v.ase_color;
					float4 Channel70_g251623 = temp_output_3_0_g251623;
					float localSwitchChannel470_g251623 = SwitchChannel4( Option70_g251623 , Channel70_g251623 );
					half Phase_Value372_g251612 = localSwitchChannel470_g251623;
					float3 break319_g251612 = PivotWO133_g251612;
					half Pivot_Position322_g251612 = ( break319_g251612.x + break319_g251612.z );
					half Phase_Position357_g251612 = ( Phase_Value372_g251612 + Pivot_Position322_g251612 );
					float temp_output_248_0_g251612 = frac( Phase_Position357_g251612 );
					float4 appendResult177_g251612 = (float4((frac( ( Phase_Position357_g251612 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g251612));
					half4 Phase_Data176_g251612 = appendResult177_g251612;
					float4 In_PhaseData16_g251630 = Phase_Data176_g251612;
					BuildModelVertData( Data16_g251630 , In_Dummy16_g251630 , In_PositionOS16_g251630 , In_PositionWS16_g251630 , In_PositionWO16_g251630 , In_PivotOS16_g251630 , In_PivotWS16_g251630 , In_PivotWO16_g251630 , In_NormalOS16_g251630 , In_NormalWS16_g251630 , In_TangentOS16_g251630 , In_ViewDirWS16_g251630 , In_CoordsData16_g251630 , In_VertexData16_g251630 , In_MasksData16_g251630 , In_PhaseData16_g251630 );
					TVEModelData DataDefault26_g251590 = Data16_g251630;
					TVEModelData DataGeneral26_g251590 = Data16_g251630;
					TVEModelData DataBlanket26_g251590 = Data16_g251630;
					TVEModelData DataImpostor26_g251590 = Data16_g251630;
					TVEModelData Data16_g251610 =(TVEModelData)0;
					half Dummy207_g251592 = 0.0;
					float temp_output_14_0_g251610 = Dummy207_g251592;
					float In_Dummy16_g251610 = temp_output_14_0_g251610;
					float3 PositionOS131_g251592 = v.vertex.xyz;
					float3 temp_output_4_0_g251610 = PositionOS131_g251592;
					float3 In_PositionOS16_g251610 = temp_output_4_0_g251610;
					float3 temp_output_104_7_g251592 = ase_positionWS;
					float3 PositionWS122_g251592 = temp_output_104_7_g251592;
					float3 In_PositionWS16_g251610 = PositionWS122_g251592;
					float4x4 break19_g251595 = unity_ObjectToWorld;
					float3 appendResult20_g251595 = (float3(break19_g251595[ 0 ][ 3 ] , break19_g251595[ 1 ][ 3 ] , break19_g251595[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251592 = appendResult20_g251595;
					float3 PivotWS121_g251592 = temp_output_340_7_g251592;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251592 = ( PositionWS122_g251592 - PivotWS121_g251592 );
					#else
					float3 staticSwitch204_g251592 = PositionWS122_g251592;
					#endif
					float3 PositionWO132_g251592 = ( staticSwitch204_g251592 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251610 = PositionWO132_g251592;
					float3 PivotOS149_g251592 = _Vector0;
					float3 In_PivotOS16_g251610 = PivotOS149_g251592;
					float3 In_PivotWS16_g251610 = PivotWS121_g251592;
					float3 PivotWO133_g251592 = ( PivotWS121_g251592 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251610 = PivotWO133_g251592;
					half3 NormalOS134_g251592 = v.normal;
					float3 temp_output_21_0_g251610 = NormalOS134_g251592;
					float3 In_NormalOS16_g251610 = temp_output_21_0_g251610;
					half3 NormalWS95_g251592 = normalizedWorldNormal;
					float3 In_NormalWS16_g251610 = NormalWS95_g251592;
					float4 appendResult462_g251592 = (float4(cross( v.normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g251592 = appendResult462_g251592;
					float4 temp_output_6_0_g251610 = TangentlOS153_g251592;
					float4 In_TangentOS16_g251610 = temp_output_6_0_g251610;
					float3 normalizeResult296_g251592 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251592 ) );
					half3 ViewDirWS169_g251592 = normalizeResult296_g251592;
					float3 In_ViewDirWS16_g251610 = ViewDirWS169_g251592;
					float4 appendResult397_g251592 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g251592 = appendResult397_g251592;
					float4 In_CoordsData16_g251610 = CoordsData398_g251592;
					half4 VertexMasks171_g251592 = float4( 0,0,0,0 );
					float4 In_VertexData16_g251610 = VertexMasks171_g251592;
					half4 MasksData254_g251592 = float4( 0,0,0,0 );
					float4 In_MasksData16_g251610 = MasksData254_g251592;
					half4 Phase_Data176_g251592 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g251610 = Phase_Data176_g251592;
					BuildModelVertData( Data16_g251610 , In_Dummy16_g251610 , In_PositionOS16_g251610 , In_PositionWS16_g251610 , In_PositionWO16_g251610 , In_PivotOS16_g251610 , In_PivotWS16_g251610 , In_PivotWO16_g251610 , In_NormalOS16_g251610 , In_NormalWS16_g251610 , In_TangentOS16_g251610 , In_ViewDirWS16_g251610 , In_CoordsData16_g251610 , In_VertexData16_g251610 , In_MasksData16_g251610 , In_PhaseData16_g251610 );
					TVEModelData DataTerrain26_g251590 = Data16_g251610;
					half IsShaderType2544 = _IsShaderType;
					float Type26_g251590 = IsShaderType2544;
					{
					if (Type26_g251590 == 0 )
					{
					Data26_g251590 = DataDefault26_g251590;
					}
					else if (Type26_g251590 == 1 )
					{
					Data26_g251590 = DataGeneral26_g251590;
					}
					else if (Type26_g251590 == 2 )
					{
					Data26_g251590 = DataBlanket26_g251590;
					}
					else if (Type26_g251590 == 3 )
					{
					Data26_g251590 = DataImpostor26_g251590;
					}
					else if (Type26_g251590 == 4 )
					{
					Data26_g251590 = DataTerrain26_g251590;
					}
					}
					TVEModelData Data15_g251814 =(TVEModelData)Data26_g251590;
					float Out_Dummy15_g251814 = 0.0;
					float3 Out_PositionOS15_g251814 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251814 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251814 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251814 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251814 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251814 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251814 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251814 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251814 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251814 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251814 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251814 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251814 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251814 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251814 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251814 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251814 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251814 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251814 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251814 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251814 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251814 , Out_Dummy15_g251814 , Out_PositionOS15_g251814 , Out_PositionWS15_g251814 , Out_PositionWO15_g251814 , Out_PositionRawOS15_g251814 , Out_PivotOS15_g251814 , Out_PivotWS15_g251814 , Out_PivotWO15_g251814 , Out_NormalOS15_g251814 , Out_NormalWS15_g251814 , Out_NormalRawOS15_g251814 , Out_TangentOS15_g251814 , Out_TangentWS15_g251814 , Out_BitangentWS15_g251814 , Out_ViewDirWS15_g251814 , Out_CoordsData15_g251814 , Out_VertexData15_g251814 , Out_MasksData15_g251814 , Out_PhaseData15_g251814 , Out_TransformData15_g251814 , Out_RotationData15_g251814 , Out_Interpolator15_g251814 );
					float3 In_PositionOS16_g251813 = Out_PositionOS15_g251814;
					float3 In_NormalOS16_g251813 = Out_NormalOS15_g251814;
					float4 In_TangentOS16_g251813 = Out_TangentOS15_g251814;
					float4 In_TransformData16_g251813 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251813 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251813 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251813 , In_Dummy16_g251813 , In_PositionOS16_g251813 , In_NormalOS16_g251813 , In_TangentOS16_g251813 , In_TransformData16_g251813 , In_RotationData16_g251813 , In_Interpolator16_g251813 );
					TVEVertexData Data15_g251817 =(TVEVertexData)Data16_g251813;
					float Out_Dummy15_g251817 = 0.0;
					float3 Out_PositionOS15_g251817 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251817 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251817 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251817 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251817 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251817 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251817 , Out_Dummy15_g251817 , Out_PositionOS15_g251817 , Out_NormalOS15_g251817 , Out_TangentOS15_g251817 , Out_TransformData15_g251817 , Out_RotationData15_g251817 , Out_Interpolator15_g251817 );
					TVEModelData Data15_g251818 =(TVEModelData)Data15_g251814;
					float Out_Dummy15_g251818 = 0.0;
					float3 Out_PositionOS15_g251818 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251818 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251818 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251818 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251818 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251818 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251818 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251818 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251818 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251818 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251818 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251818 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251818 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251818 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251818 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251818 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251818 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251818 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251818 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251818 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251818 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251818 , Out_Dummy15_g251818 , Out_PositionOS15_g251818 , Out_PositionWS15_g251818 , Out_PositionWO15_g251818 , Out_PositionRawOS15_g251818 , Out_PivotOS15_g251818 , Out_PivotWS15_g251818 , Out_PivotWO15_g251818 , Out_NormalOS15_g251818 , Out_NormalWS15_g251818 , Out_NormalRawOS15_g251818 , Out_TangentOS15_g251818 , Out_TangentWS15_g251818 , Out_BitangentWS15_g251818 , Out_ViewDirWS15_g251818 , Out_CoordsData15_g251818 , Out_VertexData15_g251818 , Out_MasksData15_g251818 , Out_PhaseData15_g251818 , Out_TransformData15_g251818 , Out_RotationData15_g251818 , Out_Interpolator15_g251818 );
					float3 In_PositionOS16_g251819 = ( Out_PositionOS15_g251817 - Out_PivotOS15_g251818 );
					float3 In_NormalOS16_g251819 = Out_NormalOS15_g251818;
					float4 In_TangentOS16_g251819 = Out_TangentOS15_g251818;
					float4 In_TransformData16_g251819 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251819 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251819 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251819 , In_Dummy16_g251819 , In_PositionOS16_g251819 , In_NormalOS16_g251819 , In_TangentOS16_g251819 , In_TransformData16_g251819 , In_RotationData16_g251819 , In_Interpolator16_g251819 );
					TVEVertexData Data15_g251930 =(TVEVertexData)Data16_g251819;
					float Out_Dummy15_g251930 = 0.0;
					float3 Out_PositionOS15_g251930 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251930 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251930 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251930 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251930 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251930 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251930 , Out_Dummy15_g251930 , Out_PositionOS15_g251930 , Out_NormalOS15_g251930 , Out_TangentOS15_g251930 , Out_TransformData15_g251930 , Out_RotationData15_g251930 , Out_Interpolator15_g251930 );
					TVEVertexData Data16_g251931 =(TVEVertexData)Data15_g251930;
					half Dummy317_g251922 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251931 = Dummy317_g251922;
					float3 In_PositionOS16_g251931 = Out_PositionOS15_g251930;
					float3 In_NormalOS16_g251931 = Out_NormalOS15_g251930;
					float4 In_TangentOS16_g251931 = Out_TangentOS15_g251930;
					half4 Model_TransformData356_g251922 = Out_TransformData15_g251930;
					float localBuildGlobalData204_g251489 = ( 0.0 );
					TVEGlobalData Data204_g251489 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251489 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251489 = Dummy211_g251489;
					float4 temp_output_203_0_g251508 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g251632 = ( 0.0 );
					TVEModelData Data26_g251632 = (TVEModelData)0;
					TVEModelData Data16_g251620 =(TVEModelData)0;
					float In_Dummy16_g251620 = 0.0;
					float3 In_PositionWS16_g251620 = PositionWS122_g251612;
					float3 In_PositionWO16_g251620 = PositionWO132_g251612;
					float3 In_PivotWS16_g251620 = PivotWS121_g251612;
					float3 In_PivotWO16_g251620 = PivotWO133_g251612;
					float3 In_NormalWS16_g251620 = NormalWS95_g251612;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g251612 = ase_tangentWS;
					float3 In_TangentWS16_g251620 = TangentWS136_g251612;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g251612 = ase_bitangentWS;
					float3 In_BitangentWS16_g251620 = BiangentWS421_g251612;
					half3 NormalWS427_g251612 = NormalWS95_g251612;
					half3 localComputeTriplanarMasks427_g251612 = ComputeTriplanarMasks( NormalWS427_g251612 );
					half3 TriplanarWeights429_g251612 = localComputeTriplanarMasks427_g251612;
					float3 In_TriplanarWeights16_g251620 = TriplanarWeights429_g251612;
					float3 In_ViewDirWS16_g251620 = ViewDirWS169_g251612;
					float4 In_CoordsData16_g251620 = CoordsData398_g251612;
					float4 In_VertexData16_g251620 = VertexMasks171_g251612;
					float4 In_Interpolator16_g251620 = Phase_Data176_g251612;
					BuildModelFragData( Data16_g251620 , In_Dummy16_g251620 , In_PositionWS16_g251620 , In_PositionWO16_g251620 , In_PivotWS16_g251620 , In_PivotWO16_g251620 , In_NormalWS16_g251620 , In_TangentWS16_g251620 , In_BitangentWS16_g251620 , In_TriplanarWeights16_g251620 , In_ViewDirWS16_g251620 , In_CoordsData16_g251620 , In_VertexData16_g251620 , In_Interpolator16_g251620 );
					TVEModelData DataDefault26_g251632 = Data16_g251620;
					TVEModelData DataGeneral26_g251632 = Data16_g251620;
					TVEModelData DataBlanket26_g251632 = Data16_g251620;
					TVEModelData DataImpostor26_g251632 = Data16_g251620;
					TVEModelData Data16_g251600 =(TVEModelData)0;
					float In_Dummy16_g251600 = 0.0;
					float3 In_PositionWS16_g251600 = PositionWS122_g251592;
					float3 In_PositionWO16_g251600 = PositionWO132_g251592;
					float3 In_PivotWS16_g251600 = PivotWS121_g251592;
					float3 In_PivotWO16_g251600 = PivotWO133_g251592;
					float3 In_NormalWS16_g251600 = NormalWS95_g251592;
					half3 TangentWS136_g251592 = ase_tangentWS;
					float3 In_TangentWS16_g251600 = TangentWS136_g251592;
					half3 BiangentWS421_g251592 = ase_bitangentWS;
					float3 In_BitangentWS16_g251600 = BiangentWS421_g251592;
					half3 NormalWS427_g251592 = NormalWS95_g251592;
					half3 localComputeTriplanarMasks427_g251592 = ComputeTriplanarMasks( NormalWS427_g251592 );
					half3 TriplanarWeights429_g251592 = localComputeTriplanarMasks427_g251592;
					float3 In_TriplanarWeights16_g251600 = TriplanarWeights429_g251592;
					float3 In_ViewDirWS16_g251600 = ViewDirWS169_g251592;
					float4 In_CoordsData16_g251600 = CoordsData398_g251592;
					float4 In_VertexData16_g251600 = VertexMasks171_g251592;
					float4 In_Interpolator16_g251600 = Phase_Data176_g251592;
					BuildModelFragData( Data16_g251600 , In_Dummy16_g251600 , In_PositionWS16_g251600 , In_PositionWO16_g251600 , In_PivotWS16_g251600 , In_PivotWO16_g251600 , In_NormalWS16_g251600 , In_TangentWS16_g251600 , In_BitangentWS16_g251600 , In_TriplanarWeights16_g251600 , In_ViewDirWS16_g251600 , In_CoordsData16_g251600 , In_VertexData16_g251600 , In_Interpolator16_g251600 );
					TVEModelData DataTerrain26_g251632 = Data16_g251600;
					float Type26_g251632 = IsShaderType2544;
					{
					if (Type26_g251632 == 0 )
					{
					Data26_g251632 = DataDefault26_g251632;
					}
					else if (Type26_g251632 == 1 )
					{
					Data26_g251632 = DataGeneral26_g251632;
					}
					else if (Type26_g251632 == 2 )
					{
					Data26_g251632 = DataBlanket26_g251632;
					}
					else if (Type26_g251632 == 3 )
					{
					Data26_g251632 = DataImpostor26_g251632;
					}
					else if (Type26_g251632 == 4 )
					{
					Data26_g251632 = DataTerrain26_g251632;
					}
					}
					TVEModelData Data15_g251579 =(TVEModelData)Data26_g251632;
					float Out_Dummy15_g251579 = 0.0;
					float3 Out_PositionWS15_g251579 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251579 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251579 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251579 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251579 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251579 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251579 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251579 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251579 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251579 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251579 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251579 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251579 , Out_Dummy15_g251579 , Out_PositionWS15_g251579 , Out_PositionWO15_g251579 , Out_PivotWS15_g251579 , Out_PivotWO15_g251579 , Out_NormalWS15_g251579 , Out_TangentWS15_g251579 , Out_BitangentWS15_g251579 , Out_TriplanarWeights15_g251579 , Out_ViewDirWS15_g251579 , Out_CoordsData15_g251579 , Out_VertexData15_g251579 , Out_Interpolator15_g251579 );
					float3 Model_PositionWS497_g251489 = Out_PositionWS15_g251579;
					float2 Model_PositionWS_XZ143_g251489 = (Model_PositionWS497_g251489).xz;
					float3 Model_PivotWS498_g251489 = Out_PivotWS15_g251579;
					float2 Model_PivotWS_XZ145_g251489 = (Model_PivotWS498_g251489).xz;
					float2 lerpResult300_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251508 = lerpResult300_g251489;
					float temp_output_82_0_g251506 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251508 = temp_output_82_0_g251506;
					float4 tex2DArrayNode83_g251508 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251508).zw + ( (temp_output_203_0_g251508).xy * temp_output_81_0_g251508 ) ),temp_output_82_0_g251508), 0.0 );
					float4 appendResult210_g251508 = (float4(tex2DArrayNode83_g251508.rgb , tex2DArrayNode83_g251508.a));
					float4 temp_output_204_0_g251508 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251508 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251508).zw + ( (temp_output_204_0_g251508).xy * temp_output_81_0_g251508 ) ),temp_output_82_0_g251508), 0.0 );
					float4 appendResult212_g251508 = (float4(tex2DArrayNode122_g251508.rgb , tex2DArrayNode122_g251508.a));
					float4 TVE_RenderNearPositionR628_g251489 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251489 = saturate( ( distance( Model_PositionWS497_g251489 , (TVE_RenderNearPositionR628_g251489).xyz ) / (TVE_RenderNearPositionR628_g251489).w ) );
					float temp_output_7_0_g251578 = 1.0;
					float temp_output_9_0_g251578 = ( temp_output_507_0_g251489 - temp_output_7_0_g251578 );
					half TVE_RenderNearFadeValue635_g251489 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251489 = saturate( ( temp_output_9_0_g251578 / ( ( TVE_RenderNearFadeValue635_g251489 - temp_output_7_0_g251578 ) + 0.0001 ) ) );
					float4 lerpResult131_g251508 = lerp( appendResult210_g251508 , appendResult212_g251508 , Global_TexBlend509_g251489);
					float4 temp_output_159_109_g251506 = lerpResult131_g251508;
					float4 lerpResult168_g251506 = lerp( TVE_CoatParams , temp_output_159_109_g251506 , TVE_CoatLayers[(int)temp_output_82_0_g251506]);
					float4 temp_output_589_109_g251489 = lerpResult168_g251506;
					half4 Coat_Texture302_g251489 = temp_output_589_109_g251489;
					float4 In_CoatTexture204_g251489 = Coat_Texture302_g251489;
					half4 Draw_Texture656_g251489 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g251489 = Draw_Texture656_g251489;
					float4 temp_output_203_0_g251533 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251533 = lerpResult85_g251489;
					float temp_output_82_0_g251530 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251533 = temp_output_82_0_g251530;
					float4 tex2DArrayNode83_g251533 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251533).zw + ( (temp_output_203_0_g251533).xy * temp_output_81_0_g251533 ) ),temp_output_82_0_g251533), 0.0 );
					float4 appendResult210_g251533 = (float4(tex2DArrayNode83_g251533.rgb , tex2DArrayNode83_g251533.a));
					float4 temp_output_204_0_g251533 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251533 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251533).zw + ( (temp_output_204_0_g251533).xy * temp_output_81_0_g251533 ) ),temp_output_82_0_g251533), 0.0 );
					float4 appendResult212_g251533 = (float4(tex2DArrayNode122_g251533.rgb , tex2DArrayNode122_g251533.a));
					float4 lerpResult131_g251533 = lerp( appendResult210_g251533 , appendResult212_g251533 , Global_TexBlend509_g251489);
					float4 temp_output_171_109_g251530 = lerpResult131_g251533;
					float4 lerpResult174_g251530 = lerp( TVE_PaintParams , temp_output_171_109_g251530 , TVE_PaintLayers[(int)temp_output_82_0_g251530]);
					float4 temp_output_595_109_g251489 = lerpResult174_g251530;
					half4 Paint_Texture71_g251489 = temp_output_595_109_g251489;
					float4 In_PaintTexture204_g251489 = Paint_Texture71_g251489;
					float4 temp_output_203_0_g251516 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251516 = lerpResult104_g251489;
					float temp_output_132_0_g251514 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251516 = temp_output_132_0_g251514;
					float4 tex2DArrayNode83_g251516 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251516).zw + ( (temp_output_203_0_g251516).xy * temp_output_81_0_g251516 ) ),temp_output_82_0_g251516), 0.0 );
					float4 appendResult210_g251516 = (float4(tex2DArrayNode83_g251516.rgb , tex2DArrayNode83_g251516.a));
					float4 temp_output_204_0_g251516 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251516 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251516).zw + ( (temp_output_204_0_g251516).xy * temp_output_81_0_g251516 ) ),temp_output_82_0_g251516), 0.0 );
					float4 appendResult212_g251516 = (float4(tex2DArrayNode122_g251516.rgb , tex2DArrayNode122_g251516.a));
					float4 lerpResult131_g251516 = lerp( appendResult210_g251516 , appendResult212_g251516 , Global_TexBlend509_g251489);
					float4 temp_output_137_109_g251514 = lerpResult131_g251516;
					float4 lerpResult145_g251514 = lerp( TVE_AtmoParams , temp_output_137_109_g251514 , TVE_AtmoLayers[(int)temp_output_132_0_g251514]);
					float4 temp_output_590_110_g251489 = lerpResult145_g251514;
					half4 Atmo_Texture80_g251489 = temp_output_590_110_g251489;
					float4 In_AtmoTexture204_g251489 = Atmo_Texture80_g251489;
					float4 temp_output_203_0_g251584 = TVE_EffexBaseCoord;
					float2 lerpResult414_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g251584 = lerpResult414_g251489;
					float temp_output_132_0_g251582 = _GlobalEffexLayerValue;
					float temp_output_82_0_g251584 = temp_output_132_0_g251582;
					float4 tex2DArrayNode83_g251584 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251584).zw + ( (temp_output_203_0_g251584).xy * temp_output_81_0_g251584 ) ),temp_output_82_0_g251584), 0.0 );
					float4 appendResult210_g251584 = (float4(tex2DArrayNode83_g251584.rgb , tex2DArrayNode83_g251584.a));
					float4 temp_output_204_0_g251584 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g251584 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251584).zw + ( (temp_output_204_0_g251584).xy * temp_output_81_0_g251584 ) ),temp_output_82_0_g251584), 0.0 );
					float4 appendResult212_g251584 = (float4(tex2DArrayNode122_g251584.rgb , tex2DArrayNode122_g251584.a));
					float4 lerpResult131_g251584 = lerp( appendResult210_g251584 , appendResult212_g251584 , Global_TexBlend509_g251489);
					float4 temp_output_137_109_g251582 = lerpResult131_g251584;
					float4 lerpResult145_g251582 = lerp( TVE_EffexParams , temp_output_137_109_g251582 , TVE_EffexLayers[(int)temp_output_132_0_g251582]);
					float4 temp_output_731_110_g251489 = lerpResult145_g251582;
					half4 Effex_Texture420_g251489 = temp_output_731_110_g251489;
					float4 In_EffexTexture204_g251489 = Effex_Texture420_g251489;
					float4 temp_output_203_0_g251564 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251564 = lerpResult247_g251489;
					float temp_output_82_0_g251562 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251564 = temp_output_82_0_g251562;
					float4 tex2DArrayNode83_g251564 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251564).zw + ( (temp_output_203_0_g251564).xy * temp_output_81_0_g251564 ) ),temp_output_82_0_g251564), 0.0 );
					float4 appendResult210_g251564 = (float4(tex2DArrayNode83_g251564.rgb , tex2DArrayNode83_g251564.a));
					float4 temp_output_204_0_g251564 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251564 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251564).zw + ( (temp_output_204_0_g251564).xy * temp_output_81_0_g251564 ) ),temp_output_82_0_g251564), 0.0 );
					float4 appendResult212_g251564 = (float4(tex2DArrayNode122_g251564.rgb , tex2DArrayNode122_g251564.a));
					float4 lerpResult131_g251564 = lerp( appendResult210_g251564 , appendResult212_g251564 , Global_TexBlend509_g251489);
					float4 temp_output_159_109_g251562 = lerpResult131_g251564;
					float4 lerpResult167_g251562 = lerp( TVE_GlowParams , temp_output_159_109_g251562 , TVE_GlowLayers[(int)temp_output_82_0_g251562]);
					float4 temp_output_593_109_g251489 = lerpResult167_g251562;
					half4 Glow_Texture248_g251489 = temp_output_593_109_g251489;
					float4 In_GlowTexture204_g251489 = Glow_Texture248_g251489;
					float4 temp_output_203_0_g251500 = TVE_FormBaseCoord;
					float2 lerpResult168_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251500 = lerpResult168_g251489;
					float temp_output_130_0_g251498 = _GlobalFormLayerValue;
					float temp_output_82_0_g251500 = temp_output_130_0_g251498;
					float4 tex2DArrayNode83_g251500 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251500).zw + ( (temp_output_203_0_g251500).xy * temp_output_81_0_g251500 ) ),temp_output_82_0_g251500), 0.0 );
					float4 appendResult210_g251500 = (float4(tex2DArrayNode83_g251500.rgb , tex2DArrayNode83_g251500.a));
					float4 temp_output_204_0_g251500 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251500 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251500).zw + ( (temp_output_204_0_g251500).xy * temp_output_81_0_g251500 ) ),temp_output_82_0_g251500), 0.0 );
					float4 appendResult212_g251500 = (float4(tex2DArrayNode122_g251500.rgb , tex2DArrayNode122_g251500.a));
					float4 lerpResult131_g251500 = lerp( appendResult210_g251500 , appendResult212_g251500 , Global_TexBlend509_g251489);
					float4 temp_output_135_109_g251498 = lerpResult131_g251500;
					float4 lerpResult143_g251498 = lerp( TVE_FormParams , temp_output_135_109_g251498 , TVE_FormLayers[(int)temp_output_130_0_g251498]);
					float4 temp_output_592_0_g251489 = lerpResult143_g251498;
					float4 Form_Texture112_g251489 = temp_output_592_0_g251489;
					float4 In_FormTexture204_g251489 = Form_Texture112_g251489;
					float4 In_LandTexture204_g251489 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g251548 = TVE_VertxBaseCoord;
					float2 lerpResult681_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g251548 = lerpResult681_g251489;
					float temp_output_136_0_g251546 = _GlobalVertxLayerValue;
					float temp_output_82_0_g251548 = temp_output_136_0_g251546;
					float4 tex2DArrayNode83_g251548 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251548).zw + ( (temp_output_203_0_g251548).xy * temp_output_81_0_g251548 ) ),temp_output_82_0_g251548), 0.0 );
					float4 appendResult210_g251548 = (float4(tex2DArrayNode83_g251548.rgb , tex2DArrayNode83_g251548.a));
					float4 temp_output_204_0_g251548 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g251548 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251548).zw + ( (temp_output_204_0_g251548).xy * temp_output_81_0_g251548 ) ),temp_output_82_0_g251548), 0.0 );
					float4 appendResult212_g251548 = (float4(tex2DArrayNode122_g251548.rgb , tex2DArrayNode122_g251548.a));
					float4 lerpResult131_g251548 = lerp( appendResult210_g251548 , appendResult212_g251548 , Global_TexBlend509_g251489);
					float4 temp_output_141_109_g251546 = lerpResult131_g251548;
					float4 lerpResult149_g251546 = lerp( TVE_VertxParams , temp_output_141_109_g251546 , TVE_VertxLayers[(int)temp_output_136_0_g251546]);
					float4 temp_output_695_0_g251489 = lerpResult149_g251546;
					half4 Vertx_Texture693_g251489 = temp_output_695_0_g251489;
					float4 In_VertxTexture204_g251489 = Vertx_Texture693_g251489;
					float4 temp_output_203_0_g251524 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251524 = lerpResult400_g251489;
					float temp_output_136_0_g251522 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251524 = temp_output_136_0_g251522;
					float4 tex2DArrayNode83_g251524 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251524).zw + ( (temp_output_203_0_g251524).xy * temp_output_81_0_g251524 ) ),temp_output_82_0_g251524), 0.0 );
					float4 appendResult210_g251524 = (float4(tex2DArrayNode83_g251524.rgb , tex2DArrayNode83_g251524.a));
					float4 temp_output_204_0_g251524 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251524 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251524).zw + ( (temp_output_204_0_g251524).xy * temp_output_81_0_g251524 ) ),temp_output_82_0_g251524), 0.0 );
					float4 appendResult212_g251524 = (float4(tex2DArrayNode122_g251524.rgb , tex2DArrayNode122_g251524.a));
					float4 lerpResult131_g251524 = lerp( appendResult210_g251524 , appendResult212_g251524 , Global_TexBlend509_g251489);
					float4 temp_output_141_109_g251522 = lerpResult131_g251524;
					float4 lerpResult149_g251522 = lerp( TVE_FlowParams , temp_output_141_109_g251522 , TVE_FlowLayers[(int)temp_output_136_0_g251522]);
					float4 temp_output_594_0_g251489 = lerpResult149_g251522;
					half4 Flow_Texture405_g251489 = temp_output_594_0_g251489;
					float4 In_FlowTexture204_g251489 = Flow_Texture405_g251489;
					half4 User_Texture677_g251489 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g251489 = User_Texture677_g251489;
					BuildGlobalData( Data204_g251489 , In_Dummy204_g251489 , In_CoatTexture204_g251489 , In_DrawTexture204_g251489 , In_PaintTexture204_g251489 , In_AtmoTexture204_g251489 , In_EffexTexture204_g251489 , In_GlowTexture204_g251489 , In_FormTexture204_g251489 , In_LandTexture204_g251489 , In_VertxTexture204_g251489 , In_FlowTexture204_g251489 , In_UserTexture204_g251489 );
					TVEGlobalData Data15_g251932 =(TVEGlobalData)Data204_g251489;
					float Out_Dummy15_g251932 = 0.0;
					float4 Out_CoatTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251932 = float4( 0,0,0,0 );
					BreakData( Data15_g251932 , Out_Dummy15_g251932 , Out_CoatTexture15_g251932 , Out_DrawTexture15_g251932 , Out_PaintTexture15_g251932 , Out_AtmoTexture15_g251932 , Out_EffexTexture15_g251932 , Out_GlowTexture15_g251932 , Out_FormTexture15_g251932 , Out_LandTexture15_g251932 , Out_VertxTexture15_g251932 , Out_FlowTexture15_g251932 , Out_UserTexture15_g251932 );
					float4 Global_FormTexture351_g251922 = Out_FormTexture15_g251932;
					TVEModelData Data15_g251929 =(TVEModelData)Data15_g251818;
					float Out_Dummy15_g251929 = 0.0;
					float3 Out_PositionOS15_g251929 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251929 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251929 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251929 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251929 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251929 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251929 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251929 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251929 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251929 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251929 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251929 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251929 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251929 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251929 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251929 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251929 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251929 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251929 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251929 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251929 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251929 , Out_Dummy15_g251929 , Out_PositionOS15_g251929 , Out_PositionWS15_g251929 , Out_PositionWO15_g251929 , Out_PositionRawOS15_g251929 , Out_PivotOS15_g251929 , Out_PivotWS15_g251929 , Out_PivotWO15_g251929 , Out_NormalOS15_g251929 , Out_NormalWS15_g251929 , Out_NormalRawOS15_g251929 , Out_TangentOS15_g251929 , Out_TangentWS15_g251929 , Out_BitangentWS15_g251929 , Out_ViewDirWS15_g251929 , Out_CoordsData15_g251929 , Out_VertexData15_g251929 , Out_MasksData15_g251929 , Out_PhaseData15_g251929 , Out_TransformData15_g251929 , Out_RotationData15_g251929 , Out_Interpolator15_g251929 );
					float3 Model_PivotWO353_g251922 = Out_PivotWO15_g251929;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251928 = _ConformMeshMode;
					float Option70_g251928 = temp_output_17_0_g251928;
					half4 Model_VertexData357_g251922 = Out_VertexData15_g251929;
					float4 temp_output_3_0_g251928 = Model_VertexData357_g251922;
					float4 Channel70_g251928 = temp_output_3_0_g251928;
					float localSwitchChannel470_g251928 = SwitchChannel4( Option70_g251928 , Channel70_g251928 );
					float temp_output_390_0_g251922 = localSwitchChannel470_g251928;
					float temp_output_7_0_g251925 = _ConformMeshRemap.x;
					float temp_output_9_0_g251925 = ( temp_output_390_0_g251922 - temp_output_7_0_g251925 );
					float lerpResult374_g251922 = lerp( 1.0 , saturate( ( temp_output_9_0_g251925 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251922 = lerpResult374_g251922;
					float temp_output_328_0_g251922 = ( Blend_VertMask379_g251922 * TVE_IsEnabled );
					half Conform_Mask366_g251922 = temp_output_328_0_g251922;
					float temp_output_322_0_g251922 = ( ( ( ( (Global_FormTexture351_g251922).z - ( (Model_PivotWO353_g251922).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251922 ) );
					float3 appendResult329_g251922 = (float3(0.0 , temp_output_322_0_g251922 , 0.0));
					float3 appendResult387_g251922 = (float3(0.0 , 0.0 , temp_output_322_0_g251922));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251926 = appendResult387_g251922;
					#else
					float3 staticSwitch65_g251926 = appendResult329_g251922;
					#endif
					float3 Blanket_Conform368_g251922 = staticSwitch65_g251926;
					float4 appendResult312_g251922 = (float4(Blanket_Conform368_g251922 , 0.0));
					float4 temp_output_310_0_g251922 = ( Model_TransformData356_g251922 + appendResult312_g251922 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251922 = temp_output_310_0_g251922;
					#else
					float4 staticSwitch364_g251922 = Model_TransformData356_g251922;
					#endif
					half4 Final_TransformData365_g251922 = staticSwitch364_g251922;
					float4 In_TransformData16_g251931 = Final_TransformData365_g251922;
					float4 In_RotationData16_g251931 = Out_RotationData15_g251930;
					float4 In_Interpolator16_g251931 = Out_Interpolator15_g251930;
					BuildVertexData( Data16_g251931 , In_Dummy16_g251931 , In_PositionOS16_g251931 , In_NormalOS16_g251931 , In_TangentOS16_g251931 , In_TransformData16_g251931 , In_RotationData16_g251931 , In_Interpolator16_g251931 );
					TVEVertexData Data15_g251943 =(TVEVertexData)Data16_g251931;
					float Out_Dummy15_g251943 = 0.0;
					float3 Out_PositionOS15_g251943 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251943 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251943 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251943 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251943 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251943 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251943 , Out_Dummy15_g251943 , Out_PositionOS15_g251943 , Out_NormalOS15_g251943 , Out_TangentOS15_g251943 , Out_TransformData15_g251943 , Out_RotationData15_g251943 , Out_Interpolator15_g251943 );
					TVEVertexData Data16_g251944 =(TVEVertexData)Data15_g251943;
					float In_Dummy16_g251944 = 0.0;
					float3 Vertex_PositionOS147_g251934 = Out_PositionOS15_g251943;
					half3 VertexPos40_g251938 = Vertex_PositionOS147_g251934;
					float4 temp_output_1615_33_g251934 = Out_RotationData15_g251943;
					half4 Vertex_RotationData1569_g251934 = temp_output_1615_33_g251934;
					float2 break1582_g251934 = (Vertex_RotationData1569_g251934).xy;
					half Angle44_g251938 = break1582_g251934.y;
					half CosAngle89_g251938 = cos( Angle44_g251938 );
					half SinAngle93_g251938 = sin( Angle44_g251938 );
					float3 appendResult95_g251938 = (float3((VertexPos40_g251938).x , ( ( (VertexPos40_g251938).y * CosAngle89_g251938 ) - ( (VertexPos40_g251938).z * SinAngle93_g251938 ) ) , ( ( (VertexPos40_g251938).y * SinAngle93_g251938 ) + ( (VertexPos40_g251938).z * CosAngle89_g251938 ) )));
					half3 VertexPos40_g251939 = appendResult95_g251938;
					half Angle44_g251939 = -break1582_g251934.x;
					half CosAngle94_g251939 = cos( Angle44_g251939 );
					half SinAngle95_g251939 = sin( Angle44_g251939 );
					float3 appendResult98_g251939 = (float3(( ( (VertexPos40_g251939).x * CosAngle94_g251939 ) - ( (VertexPos40_g251939).y * SinAngle95_g251939 ) ) , ( ( (VertexPos40_g251939).x * SinAngle95_g251939 ) + ( (VertexPos40_g251939).y * CosAngle94_g251939 ) ) , (VertexPos40_g251939).z));
					half3 VertexPos40_g251937 = Vertex_PositionOS147_g251934;
					half Angle44_g251937 = break1582_g251934.y;
					half CosAngle89_g251937 = cos( Angle44_g251937 );
					half SinAngle93_g251937 = sin( Angle44_g251937 );
					float3 appendResult95_g251937 = (float3((VertexPos40_g251937).x , ( ( (VertexPos40_g251937).y * CosAngle89_g251937 ) - ( (VertexPos40_g251937).z * SinAngle93_g251937 ) ) , ( ( (VertexPos40_g251937).y * SinAngle93_g251937 ) + ( (VertexPos40_g251937).z * CosAngle89_g251937 ) )));
					half3 VertexPos40_g251942 = appendResult95_g251937;
					half Angle44_g251942 = break1582_g251934.x;
					half CosAngle91_g251942 = cos( Angle44_g251942 );
					half SinAngle92_g251942 = sin( Angle44_g251942 );
					float3 appendResult93_g251942 = (float3(( ( (VertexPos40_g251942).x * CosAngle91_g251942 ) + ( (VertexPos40_g251942).z * SinAngle92_g251942 ) ) , (VertexPos40_g251942).y , ( ( -(VertexPos40_g251942).x * SinAngle92_g251942 ) + ( (VertexPos40_g251942).z * CosAngle91_g251942 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251940 = appendResult93_g251942;
					#else
					float3 staticSwitch65_g251940 = appendResult98_g251939;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251935 = staticSwitch65_g251940;
					#else
					float3 staticSwitch65_g251935 = Vertex_PositionOS147_g251934;
					#endif
					float3 temp_output_1608_0_g251934 = staticSwitch65_g251935;
					half3 VertexPos40_g251941 = temp_output_1608_0_g251934;
					half Angle44_g251941 = (Vertex_RotationData1569_g251934).z;
					half CosAngle91_g251941 = cos( Angle44_g251941 );
					half SinAngle92_g251941 = sin( Angle44_g251941 );
					float3 appendResult93_g251941 = (float3(( ( (VertexPos40_g251941).x * CosAngle91_g251941 ) + ( (VertexPos40_g251941).z * SinAngle92_g251941 ) ) , (VertexPos40_g251941).y , ( ( -(VertexPos40_g251941).x * SinAngle92_g251941 ) + ( (VertexPos40_g251941).z * CosAngle91_g251941 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251936 = appendResult93_g251941;
					#else
					float3 staticSwitch65_g251936 = temp_output_1608_0_g251934;
					#endif
					float4 temp_output_1615_31_g251934 = Out_TransformData15_g251943;
					half4 Vertex_TransformData1568_g251934 = temp_output_1615_31_g251934;
					half3 Final_PositionOS178_g251934 = ( ( staticSwitch65_g251936 * (Vertex_TransformData1568_g251934).w ) + (Vertex_TransformData1568_g251934).xyz );
					float3 In_PositionOS16_g251944 = Final_PositionOS178_g251934;
					float3 In_NormalOS16_g251944 = Out_NormalOS15_g251943;
					float4 In_TangentOS16_g251944 = Out_TangentOS15_g251943;
					float4 In_TransformData16_g251944 = temp_output_1615_31_g251934;
					float4 In_RotationData16_g251944 = temp_output_1615_33_g251934;
					float4 In_Interpolator16_g251944 = Out_Interpolator15_g251943;
					BuildVertexData( Data16_g251944 , In_Dummy16_g251944 , In_PositionOS16_g251944 , In_NormalOS16_g251944 , In_TangentOS16_g251944 , In_TransformData16_g251944 , In_RotationData16_g251944 , In_Interpolator16_g251944 );
					TVEVertexData Data15_g252048 =(TVEVertexData)Data16_g251944;
					float Out_Dummy15_g252048 = 0.0;
					float3 Out_PositionOS15_g252048 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252048 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252048 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252048 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252048 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252048 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252048 , Out_Dummy15_g252048 , Out_PositionOS15_g252048 , Out_NormalOS15_g252048 , Out_TangentOS15_g252048 , Out_TransformData15_g252048 , Out_RotationData15_g252048 , Out_Interpolator15_g252048 );
					TVEVertexData Data16_g252049 =(TVEVertexData)Data15_g252048;
					float In_Dummy16_g252049 = 0.0;
					TVEModelData Data15_g252047 =(TVEModelData)Data15_g251929;
					float Out_Dummy15_g252047 = 0.0;
					float3 Out_PositionOS15_g252047 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252047 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252047 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252047 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252047 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252047 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252047 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252047 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252047 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252047 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252047 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252047 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252047 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252047 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252047 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252047 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252047 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252047 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252047 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252047 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252047 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252047 , Out_Dummy15_g252047 , Out_PositionOS15_g252047 , Out_PositionWS15_g252047 , Out_PositionWO15_g252047 , Out_PositionRawOS15_g252047 , Out_PivotOS15_g252047 , Out_PivotWS15_g252047 , Out_PivotWO15_g252047 , Out_NormalOS15_g252047 , Out_NormalWS15_g252047 , Out_NormalRawOS15_g252047 , Out_TangentOS15_g252047 , Out_TangentWS15_g252047 , Out_BitangentWS15_g252047 , Out_ViewDirWS15_g252047 , Out_CoordsData15_g252047 , Out_VertexData15_g252047 , Out_MasksData15_g252047 , Out_PhaseData15_g252047 , Out_TransformData15_g252047 , Out_RotationData15_g252047 , Out_Interpolator15_g252047 );
					float3 In_PositionOS16_g252049 = ( Out_PositionOS15_g252048 + Out_PivotOS15_g252047 );
					float3 In_NormalOS16_g252049 = Out_NormalOS15_g252048;
					float4 In_TangentOS16_g252049 = Out_TangentOS15_g252048;
					float4 In_TransformData16_g252049 = Out_TransformData15_g252048;
					float4 In_RotationData16_g252049 = Out_RotationData15_g252048;
					float4 In_Interpolator16_g252049 = Out_Interpolator15_g252048;
					BuildVertexData( Data16_g252049 , In_Dummy16_g252049 , In_PositionOS16_g252049 , In_NormalOS16_g252049 , In_TangentOS16_g252049 , In_TransformData16_g252049 , In_RotationData16_g252049 , In_Interpolator16_g252049 );
					TVEVertexData Data15_g252196 =(TVEVertexData)Data16_g252049;
					float Out_Dummy15_g252196 = 0.0;
					float3 Out_PositionOS15_g252196 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252196 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252196 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252196 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252196 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252196 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252196 , Out_Dummy15_g252196 , Out_PositionOS15_g252196 , Out_NormalOS15_g252196 , Out_TangentOS15_g252196 , Out_TransformData15_g252196 , Out_RotationData15_g252196 , Out_Interpolator15_g252196 );
					
					o.ase_texcoord4.xyz = vertexToFrag73_g251612;
					o.ase_texcoord5.xyz = vertexToFrag76_g251612;
					float3 vertexPos57_g252188 = v.vertex.xyz;
					float4 ase_positionCS57_g252188 = UnityObjectToClipPos( vertexPos57_g252188 );
					o.ase_texcoord7 = ase_positionCS57_g252188;
					TVEVertexData Data1902_g252143 = Data16_g252049;
					float4 Out_Interpolator1902_g252143 = float4( 0,0,0,0 );
					{
					Out_Interpolator1902_g252143 = Data1902_g252143.Interpolator;
					}
					float4 vertexToFrag1901_g252143 = Out_Interpolator1902_g252143;
					o.ase_texcoord8 = vertexToFrag1901_g252143;
					
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
					float3 vertexValue = Out_PositionOS15_g252196;
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

					float temp_output_2587_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2587_114).xxx;
					
					float3 temp_cast_1 = (temp_output_2587_114).xxx;
					
					float3 color130_g252188 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g252188 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g252190 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g252189 = ( temp_cast_4 * ( 0.5 + appendResult128_g252190 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g252189 = (float4(ddx( FinalUV13_g252189 ) , ddy( FinalUV13_g252189 )));
					float4 UVDerivatives17_g252189 = appendResult16_g252189;
					float4 break28_g252189 = UVDerivatives17_g252189;
					float2 appendResult19_g252189 = (float2(break28_g252189.x , break28_g252189.z));
					float2 appendResult20_g252189 = (float2(break28_g252189.x , break28_g252189.z));
					float dotResult24_g252189 = dot( appendResult19_g252189 , appendResult20_g252189 );
					float2 appendResult21_g252189 = (float2(break28_g252189.y , break28_g252189.w));
					float2 appendResult22_g252189 = (float2(break28_g252189.y , break28_g252189.w));
					float dotResult23_g252189 = dot( appendResult21_g252189 , appendResult22_g252189 );
					float2 appendResult25_g252189 = (float2(dotResult24_g252189 , dotResult23_g252189));
					float2 derivativesLength29_g252189 = sqrt( appendResult25_g252189 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g252189 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g252189 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g252189 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g252189 = clampResult57_g252189;
					float2 break55_g252189 = derivativesLength29_g252189;
					float4 lerpResult73_g252189 = lerp( float4( color130_g252188 , 0.0 ) , float4( color81_g252188 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g252189.x * break71_g252189.y * sqrt( saturate( ( 1.1 - max( break55_g252189.x, break55_g252189.y ) ) ) ) ) ) ));
					float3 color2584 = IsGammaSpace() ? float3( 0.3867925, 0.3867925, 0.3867925 ) : float3( 0.1237993, 0.1237993, 0.1237993 );
					float3 color2564 = IsGammaSpace() ? float3( 1, 0, 0.3576326 ) : float3( 1, 0, 0.1050864 );
					float3 color2565 = IsGammaSpace() ? float3( 0, 0.5347826, 1 ) : float3( 0, 0.2476594, 1 );
					float4 temp_output_2563_145 = TVE_RenderNearPositionR;
					float temp_output_7_0_g251820 = 1.0;
					float temp_output_9_0_g251820 = ( saturate( ( distance( PositionWS , (temp_output_2563_145).xyz ) / (temp_output_2563_145).w ) ) - temp_output_7_0_g251820 );
					half Global_Blend2558 = saturate( ( temp_output_9_0_g251820 / ( ( TVE_RenderNearFadeValue - temp_output_7_0_g251820 ) + 0.0001 ) ) );
					float3 lerpResult2567 = lerp( color2564 , color2565 , Global_Blend2558);
					float4 temp_output_2582_148 = TVE_RenderBasePositionR;
					float temp_output_7_0_g251933 = 1.0;
					float temp_output_9_0_g251933 = ( saturate( ( distance( PositionWS , (temp_output_2582_148).xyz ) / (temp_output_2582_148).w ) ) - temp_output_7_0_g251933 );
					half Global_Edge2578 = saturate( ( temp_output_9_0_g251933 / ( ( 0.9999 - temp_output_7_0_g251933 ) + 0.0001 ) ) );
					float3 lerpResult2583 = lerp( color2584 , lerpResult2567 , Global_Edge2578);
					float3 ifLocalVar40_g252147 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g252147 = lerpResult2583;
					float localBuildGlobalData204_g251945 = ( 0.0 );
					TVEGlobalData Data204_g251945 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251945 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251945 = Dummy211_g251945;
					float4 temp_output_203_0_g251964 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g251632 = ( 0.0 );
					TVEModelData Data26_g251632 = (TVEModelData)0;
					TVEModelData Data16_g251620 =(TVEModelData)0;
					float In_Dummy16_g251620 = 0.0;
					float3 vertexToFrag73_g251612 = IN.ase_texcoord4.xyz;
					float3 PositionWS122_g251612 = vertexToFrag73_g251612;
					float3 In_PositionWS16_g251620 = PositionWS122_g251612;
					float3 vertexToFrag76_g251612 = IN.ase_texcoord5.xyz;
					float3 PivotWS121_g251612 = vertexToFrag76_g251612;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251612 = ( PositionWS122_g251612 - PivotWS121_g251612 );
					#else
					float3 staticSwitch204_g251612 = PositionWS122_g251612;
					#endif
					float3 PositionWO132_g251612 = ( staticSwitch204_g251612 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251620 = PositionWO132_g251612;
					float3 In_PivotWS16_g251620 = PivotWS121_g251612;
					float3 PivotWO133_g251612 = ( PivotWS121_g251612 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251620 = PivotWO133_g251612;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g251612 = normalizedWorldNormal;
					float3 In_NormalWS16_g251620 = NormalWS95_g251612;
					half3 TangentWS136_g251612 = TangentWS;
					float3 In_TangentWS16_g251620 = TangentWS136_g251612;
					half3 BiangentWS421_g251612 = BitangentWS;
					float3 In_BitangentWS16_g251620 = BiangentWS421_g251612;
					half3 NormalWS427_g251612 = NormalWS95_g251612;
					half3 localComputeTriplanarMasks427_g251612 = ComputeTriplanarMasks( NormalWS427_g251612 );
					half3 TriplanarWeights429_g251612 = localComputeTriplanarMasks427_g251612;
					float3 In_TriplanarWeights16_g251620 = TriplanarWeights429_g251612;
					float3 normalizeResult296_g251612 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251612 ) );
					half3 ViewDirWS169_g251612 = normalizeResult296_g251612;
					float3 In_ViewDirWS16_g251620 = ViewDirWS169_g251612;
					float4 appendResult397_g251612 = (float4(IN.ase_texcoord6.xy , IN.ase_texcoord6.zw));
					float4 CoordsData398_g251612 = appendResult397_g251612;
					float4 In_CoordsData16_g251620 = CoordsData398_g251612;
					half4 VertexMasks171_g251612 = IN.ase_color;
					float4 In_VertexData16_g251620 = VertexMasks171_g251612;
					float temp_output_17_0_g251623 = _ObjectPhaseMode;
					float Option70_g251623 = temp_output_17_0_g251623;
					float4 temp_output_3_0_g251623 = IN.ase_color;
					float4 Channel70_g251623 = temp_output_3_0_g251623;
					float localSwitchChannel470_g251623 = SwitchChannel4( Option70_g251623 , Channel70_g251623 );
					half Phase_Value372_g251612 = localSwitchChannel470_g251623;
					float3 break319_g251612 = PivotWO133_g251612;
					half Pivot_Position322_g251612 = ( break319_g251612.x + break319_g251612.z );
					half Phase_Position357_g251612 = ( Phase_Value372_g251612 + Pivot_Position322_g251612 );
					float temp_output_248_0_g251612 = frac( Phase_Position357_g251612 );
					float4 appendResult177_g251612 = (float4((frac( ( Phase_Position357_g251612 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g251612));
					half4 Phase_Data176_g251612 = appendResult177_g251612;
					float4 In_Interpolator16_g251620 = Phase_Data176_g251612;
					BuildModelFragData( Data16_g251620 , In_Dummy16_g251620 , In_PositionWS16_g251620 , In_PositionWO16_g251620 , In_PivotWS16_g251620 , In_PivotWO16_g251620 , In_NormalWS16_g251620 , In_TangentWS16_g251620 , In_BitangentWS16_g251620 , In_TriplanarWeights16_g251620 , In_ViewDirWS16_g251620 , In_CoordsData16_g251620 , In_VertexData16_g251620 , In_Interpolator16_g251620 );
					TVEModelData DataDefault26_g251632 = Data16_g251620;
					TVEModelData DataGeneral26_g251632 = Data16_g251620;
					TVEModelData DataBlanket26_g251632 = Data16_g251620;
					TVEModelData DataImpostor26_g251632 = Data16_g251620;
					TVEModelData Data16_g251600 =(TVEModelData)0;
					float In_Dummy16_g251600 = 0.0;
					float3 temp_output_104_7_g251592 = PositionWS;
					float3 PositionWS122_g251592 = temp_output_104_7_g251592;
					float3 In_PositionWS16_g251600 = PositionWS122_g251592;
					float4x4 break19_g251595 = unity_ObjectToWorld;
					float3 appendResult20_g251595 = (float3(break19_g251595[ 0 ][ 3 ] , break19_g251595[ 1 ][ 3 ] , break19_g251595[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251592 = appendResult20_g251595;
					float3 PivotWS121_g251592 = temp_output_340_7_g251592;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251592 = ( PositionWS122_g251592 - PivotWS121_g251592 );
					#else
					float3 staticSwitch204_g251592 = PositionWS122_g251592;
					#endif
					float3 PositionWO132_g251592 = ( staticSwitch204_g251592 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251600 = PositionWO132_g251592;
					float3 In_PivotWS16_g251600 = PivotWS121_g251592;
					float3 PivotWO133_g251592 = ( PivotWS121_g251592 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251600 = PivotWO133_g251592;
					half3 NormalWS95_g251592 = normalizedWorldNormal;
					float3 In_NormalWS16_g251600 = NormalWS95_g251592;
					half3 TangentWS136_g251592 = TangentWS;
					float3 In_TangentWS16_g251600 = TangentWS136_g251592;
					half3 BiangentWS421_g251592 = BitangentWS;
					float3 In_BitangentWS16_g251600 = BiangentWS421_g251592;
					half3 NormalWS427_g251592 = NormalWS95_g251592;
					half3 localComputeTriplanarMasks427_g251592 = ComputeTriplanarMasks( NormalWS427_g251592 );
					half3 TriplanarWeights429_g251592 = localComputeTriplanarMasks427_g251592;
					float3 In_TriplanarWeights16_g251600 = TriplanarWeights429_g251592;
					float3 normalizeResult296_g251592 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251592 ) );
					half3 ViewDirWS169_g251592 = normalizeResult296_g251592;
					float3 In_ViewDirWS16_g251600 = ViewDirWS169_g251592;
					float4 appendResult397_g251592 = (float4(IN.ase_texcoord6.xy , IN.ase_texcoord6.zw));
					float4 CoordsData398_g251592 = appendResult397_g251592;
					float4 In_CoordsData16_g251600 = CoordsData398_g251592;
					half4 VertexMasks171_g251592 = float4( 0,0,0,0 );
					float4 In_VertexData16_g251600 = VertexMasks171_g251592;
					half4 Phase_Data176_g251592 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251600 = Phase_Data176_g251592;
					BuildModelFragData( Data16_g251600 , In_Dummy16_g251600 , In_PositionWS16_g251600 , In_PositionWO16_g251600 , In_PivotWS16_g251600 , In_PivotWO16_g251600 , In_NormalWS16_g251600 , In_TangentWS16_g251600 , In_BitangentWS16_g251600 , In_TriplanarWeights16_g251600 , In_ViewDirWS16_g251600 , In_CoordsData16_g251600 , In_VertexData16_g251600 , In_Interpolator16_g251600 );
					TVEModelData DataTerrain26_g251632 = Data16_g251600;
					half IsShaderType2544 = _IsShaderType;
					float Type26_g251632 = IsShaderType2544;
					{
					if (Type26_g251632 == 0 )
					{
					Data26_g251632 = DataDefault26_g251632;
					}
					else if (Type26_g251632 == 1 )
					{
					Data26_g251632 = DataGeneral26_g251632;
					}
					else if (Type26_g251632 == 2 )
					{
					Data26_g251632 = DataBlanket26_g251632;
					}
					else if (Type26_g251632 == 3 )
					{
					Data26_g251632 = DataImpostor26_g251632;
					}
					else if (Type26_g251632 == 4 )
					{
					Data26_g251632 = DataTerrain26_g251632;
					}
					}
					TVEModelData Data15_g252035 =(TVEModelData)Data26_g251632;
					float Out_Dummy15_g252035 = 0.0;
					float3 Out_PositionWS15_g252035 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252035 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252035 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252035 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252035 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252035 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252035 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252035 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252035 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252035 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252035 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252035 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252035 , Out_Dummy15_g252035 , Out_PositionWS15_g252035 , Out_PositionWO15_g252035 , Out_PivotWS15_g252035 , Out_PivotWO15_g252035 , Out_NormalWS15_g252035 , Out_TangentWS15_g252035 , Out_BitangentWS15_g252035 , Out_TriplanarWeights15_g252035 , Out_ViewDirWS15_g252035 , Out_CoordsData15_g252035 , Out_VertexData15_g252035 , Out_Interpolator15_g252035 );
					float3 Model_PositionWS497_g251945 = Out_PositionWS15_g252035;
					float2 Model_PositionWS_XZ143_g251945 = (Model_PositionWS497_g251945).xz;
					float3 Model_PivotWS498_g251945 = Out_PivotWS15_g252035;
					float2 Model_PivotWS_XZ145_g251945 = (Model_PivotWS498_g251945).xz;
					float2 lerpResult300_g251945 = lerp( Model_PositionWS_XZ143_g251945 , Model_PivotWS_XZ145_g251945 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251964 = lerpResult300_g251945;
					float temp_output_82_0_g251962 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251964 = temp_output_82_0_g251962;
					float4 tex2DArrayNode83_g251964 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251964).zw + ( (temp_output_203_0_g251964).xy * temp_output_81_0_g251964 ) ),temp_output_82_0_g251964) );
					float4 appendResult210_g251964 = (float4(tex2DArrayNode83_g251964.rgb , tex2DArrayNode83_g251964.a));
					float4 temp_output_204_0_g251964 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251964 = SAMPLE_TEXTURE2D_ARRAY( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251964).zw + ( (temp_output_204_0_g251964).xy * temp_output_81_0_g251964 ) ),temp_output_82_0_g251964) );
					float4 appendResult212_g251964 = (float4(tex2DArrayNode122_g251964.rgb , tex2DArrayNode122_g251964.a));
					float4 TVE_RenderNearPositionR628_g251945 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251945 = saturate( ( distance( Model_PositionWS497_g251945 , (TVE_RenderNearPositionR628_g251945).xyz ) / (TVE_RenderNearPositionR628_g251945).w ) );
					float temp_output_7_0_g252034 = 1.0;
					float temp_output_9_0_g252034 = ( temp_output_507_0_g251945 - temp_output_7_0_g252034 );
					half TVE_RenderNearFadeValue635_g251945 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251945 = saturate( ( temp_output_9_0_g252034 / ( ( TVE_RenderNearFadeValue635_g251945 - temp_output_7_0_g252034 ) + 0.0001 ) ) );
					float4 lerpResult131_g251964 = lerp( appendResult210_g251964 , appendResult212_g251964 , Global_TexBlend509_g251945);
					float4 temp_output_159_109_g251962 = lerpResult131_g251964;
					float4 lerpResult168_g251962 = lerp( TVE_CoatParams , temp_output_159_109_g251962 , TVE_CoatLayers[(int)temp_output_82_0_g251962]);
					float4 temp_output_589_109_g251945 = lerpResult168_g251962;
					half4 Coat_Texture302_g251945 = temp_output_589_109_g251945;
					float4 In_CoatTexture204_g251945 = Coat_Texture302_g251945;
					half4 Draw_Texture656_g251945 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g251945 = Draw_Texture656_g251945;
					float4 temp_output_203_0_g251989 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251945 = lerp( Model_PositionWS_XZ143_g251945 , Model_PivotWS_XZ145_g251945 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251989 = lerpResult85_g251945;
					float temp_output_82_0_g251986 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251989 = temp_output_82_0_g251986;
					float4 tex2DArrayNode83_g251989 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251989).zw + ( (temp_output_203_0_g251989).xy * temp_output_81_0_g251989 ) ),temp_output_82_0_g251989) );
					float4 appendResult210_g251989 = (float4(tex2DArrayNode83_g251989.rgb , tex2DArrayNode83_g251989.a));
					float4 temp_output_204_0_g251989 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251989 = SAMPLE_TEXTURE2D_ARRAY( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251989).zw + ( (temp_output_204_0_g251989).xy * temp_output_81_0_g251989 ) ),temp_output_82_0_g251989) );
					float4 appendResult212_g251989 = (float4(tex2DArrayNode122_g251989.rgb , tex2DArrayNode122_g251989.a));
					float4 lerpResult131_g251989 = lerp( appendResult210_g251989 , appendResult212_g251989 , Global_TexBlend509_g251945);
					float4 temp_output_171_109_g251986 = lerpResult131_g251989;
					float4 lerpResult174_g251986 = lerp( TVE_PaintParams , temp_output_171_109_g251986 , TVE_PaintLayers[(int)temp_output_82_0_g251986]);
					float4 temp_output_595_109_g251945 = lerpResult174_g251986;
					half4 Paint_Texture71_g251945 = temp_output_595_109_g251945;
					float4 In_PaintTexture204_g251945 = Paint_Texture71_g251945;
					float4 temp_output_203_0_g251972 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251945 = lerp( Model_PositionWS_XZ143_g251945 , Model_PivotWS_XZ145_g251945 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251972 = lerpResult104_g251945;
					float temp_output_132_0_g251970 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251972 = temp_output_132_0_g251970;
					float4 tex2DArrayNode83_g251972 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251972).zw + ( (temp_output_203_0_g251972).xy * temp_output_81_0_g251972 ) ),temp_output_82_0_g251972) );
					float4 appendResult210_g251972 = (float4(tex2DArrayNode83_g251972.rgb , tex2DArrayNode83_g251972.a));
					float4 temp_output_204_0_g251972 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251972 = SAMPLE_TEXTURE2D_ARRAY( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251972).zw + ( (temp_output_204_0_g251972).xy * temp_output_81_0_g251972 ) ),temp_output_82_0_g251972) );
					float4 appendResult212_g251972 = (float4(tex2DArrayNode122_g251972.rgb , tex2DArrayNode122_g251972.a));
					float4 lerpResult131_g251972 = lerp( appendResult210_g251972 , appendResult212_g251972 , Global_TexBlend509_g251945);
					float4 temp_output_137_109_g251970 = lerpResult131_g251972;
					float4 lerpResult145_g251970 = lerp( TVE_AtmoParams , temp_output_137_109_g251970 , TVE_AtmoLayers[(int)temp_output_132_0_g251970]);
					float4 temp_output_590_110_g251945 = lerpResult145_g251970;
					half4 Atmo_Texture80_g251945 = temp_output_590_110_g251945;
					float4 In_AtmoTexture204_g251945 = Atmo_Texture80_g251945;
					float4 temp_output_203_0_g252040 = TVE_EffexBaseCoord;
					float2 lerpResult414_g251945 = lerp( Model_PositionWS_XZ143_g251945 , Model_PivotWS_XZ145_g251945 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g252040 = lerpResult414_g251945;
					float temp_output_132_0_g252038 = _GlobalEffexLayerValue;
					float temp_output_82_0_g252040 = temp_output_132_0_g252038;
					float4 tex2DArrayNode83_g252040 = SAMPLE_TEXTURE2D_ARRAY( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g252040).zw + ( (temp_output_203_0_g252040).xy * temp_output_81_0_g252040 ) ),temp_output_82_0_g252040) );
					float4 appendResult210_g252040 = (float4(tex2DArrayNode83_g252040.rgb , tex2DArrayNode83_g252040.a));
					float4 temp_output_204_0_g252040 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g252040 = SAMPLE_TEXTURE2D_ARRAY( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g252040).zw + ( (temp_output_204_0_g252040).xy * temp_output_81_0_g252040 ) ),temp_output_82_0_g252040) );
					float4 appendResult212_g252040 = (float4(tex2DArrayNode122_g252040.rgb , tex2DArrayNode122_g252040.a));
					float4 lerpResult131_g252040 = lerp( appendResult210_g252040 , appendResult212_g252040 , Global_TexBlend509_g251945);
					float4 temp_output_137_109_g252038 = lerpResult131_g252040;
					float4 lerpResult145_g252038 = lerp( TVE_EffexParams , temp_output_137_109_g252038 , TVE_EffexLayers[(int)temp_output_132_0_g252038]);
					float4 temp_output_731_110_g251945 = lerpResult145_g252038;
					half4 Effex_Texture420_g251945 = temp_output_731_110_g251945;
					float4 In_EffexTexture204_g251945 = Effex_Texture420_g251945;
					float4 temp_output_203_0_g252020 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251945 = lerp( Model_PositionWS_XZ143_g251945 , Model_PivotWS_XZ145_g251945 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g252020 = lerpResult247_g251945;
					float temp_output_82_0_g252018 = _GlobalGlowLayerValue;
					float temp_output_82_0_g252020 = temp_output_82_0_g252018;
					float4 tex2DArrayNode83_g252020 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g252020).zw + ( (temp_output_203_0_g252020).xy * temp_output_81_0_g252020 ) ),temp_output_82_0_g252020) );
					float4 appendResult210_g252020 = (float4(tex2DArrayNode83_g252020.rgb , tex2DArrayNode83_g252020.a));
					float4 temp_output_204_0_g252020 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g252020 = SAMPLE_TEXTURE2D_ARRAY( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g252020).zw + ( (temp_output_204_0_g252020).xy * temp_output_81_0_g252020 ) ),temp_output_82_0_g252020) );
					float4 appendResult212_g252020 = (float4(tex2DArrayNode122_g252020.rgb , tex2DArrayNode122_g252020.a));
					float4 lerpResult131_g252020 = lerp( appendResult210_g252020 , appendResult212_g252020 , Global_TexBlend509_g251945);
					float4 temp_output_159_109_g252018 = lerpResult131_g252020;
					float4 lerpResult167_g252018 = lerp( TVE_GlowParams , temp_output_159_109_g252018 , TVE_GlowLayers[(int)temp_output_82_0_g252018]);
					float4 temp_output_593_109_g251945 = lerpResult167_g252018;
					half4 Glow_Texture248_g251945 = temp_output_593_109_g251945;
					float4 In_GlowTexture204_g251945 = Glow_Texture248_g251945;
					float4 temp_output_203_0_g251956 = TVE_FormBaseCoord;
					float2 lerpResult168_g251945 = lerp( Model_PositionWS_XZ143_g251945 , Model_PivotWS_XZ145_g251945 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251956 = lerpResult168_g251945;
					float temp_output_130_0_g251954 = _GlobalFormLayerValue;
					float temp_output_82_0_g251956 = temp_output_130_0_g251954;
					float4 tex2DArrayNode83_g251956 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251956).zw + ( (temp_output_203_0_g251956).xy * temp_output_81_0_g251956 ) ),temp_output_82_0_g251956) );
					float4 appendResult210_g251956 = (float4(tex2DArrayNode83_g251956.rgb , tex2DArrayNode83_g251956.a));
					float4 temp_output_204_0_g251956 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251956 = SAMPLE_TEXTURE2D_ARRAY( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251956).zw + ( (temp_output_204_0_g251956).xy * temp_output_81_0_g251956 ) ),temp_output_82_0_g251956) );
					float4 appendResult212_g251956 = (float4(tex2DArrayNode122_g251956.rgb , tex2DArrayNode122_g251956.a));
					float4 lerpResult131_g251956 = lerp( appendResult210_g251956 , appendResult212_g251956 , Global_TexBlend509_g251945);
					float4 temp_output_135_109_g251954 = lerpResult131_g251956;
					float4 lerpResult143_g251954 = lerp( TVE_FormParams , temp_output_135_109_g251954 , TVE_FormLayers[(int)temp_output_130_0_g251954]);
					float4 temp_output_592_0_g251945 = lerpResult143_g251954;
					float4 Form_Texture112_g251945 = temp_output_592_0_g251945;
					float4 In_FormTexture204_g251945 = Form_Texture112_g251945;
					float4 In_LandTexture204_g251945 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g252004 = TVE_VertxBaseCoord;
					float2 lerpResult681_g251945 = lerp( Model_PositionWS_XZ143_g251945 , Model_PivotWS_XZ145_g251945 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g252004 = lerpResult681_g251945;
					float temp_output_136_0_g252002 = _GlobalVertxLayerValue;
					float temp_output_82_0_g252004 = temp_output_136_0_g252002;
					float4 tex2DArrayNode83_g252004 = SAMPLE_TEXTURE2D_ARRAY( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g252004).zw + ( (temp_output_203_0_g252004).xy * temp_output_81_0_g252004 ) ),temp_output_82_0_g252004) );
					float4 appendResult210_g252004 = (float4(tex2DArrayNode83_g252004.rgb , tex2DArrayNode83_g252004.a));
					float4 temp_output_204_0_g252004 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g252004 = SAMPLE_TEXTURE2D_ARRAY( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g252004).zw + ( (temp_output_204_0_g252004).xy * temp_output_81_0_g252004 ) ),temp_output_82_0_g252004) );
					float4 appendResult212_g252004 = (float4(tex2DArrayNode122_g252004.rgb , tex2DArrayNode122_g252004.a));
					float4 lerpResult131_g252004 = lerp( appendResult210_g252004 , appendResult212_g252004 , Global_TexBlend509_g251945);
					float4 temp_output_141_109_g252002 = lerpResult131_g252004;
					float4 lerpResult149_g252002 = lerp( TVE_VertxParams , temp_output_141_109_g252002 , TVE_VertxLayers[(int)temp_output_136_0_g252002]);
					float4 temp_output_695_0_g251945 = lerpResult149_g252002;
					half4 Vertx_Texture693_g251945 = temp_output_695_0_g251945;
					float4 In_VertxTexture204_g251945 = Vertx_Texture693_g251945;
					float4 temp_output_203_0_g251980 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251945 = lerp( Model_PositionWS_XZ143_g251945 , Model_PivotWS_XZ145_g251945 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251980 = lerpResult400_g251945;
					float temp_output_136_0_g251978 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251980 = temp_output_136_0_g251978;
					float4 tex2DArrayNode83_g251980 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251980).zw + ( (temp_output_203_0_g251980).xy * temp_output_81_0_g251980 ) ),temp_output_82_0_g251980) );
					float4 appendResult210_g251980 = (float4(tex2DArrayNode83_g251980.rgb , tex2DArrayNode83_g251980.a));
					float4 temp_output_204_0_g251980 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251980 = SAMPLE_TEXTURE2D_ARRAY( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251980).zw + ( (temp_output_204_0_g251980).xy * temp_output_81_0_g251980 ) ),temp_output_82_0_g251980) );
					float4 appendResult212_g251980 = (float4(tex2DArrayNode122_g251980.rgb , tex2DArrayNode122_g251980.a));
					float4 lerpResult131_g251980 = lerp( appendResult210_g251980 , appendResult212_g251980 , Global_TexBlend509_g251945);
					float4 temp_output_141_109_g251978 = lerpResult131_g251980;
					float4 lerpResult149_g251978 = lerp( TVE_FlowParams , temp_output_141_109_g251978 , TVE_FlowLayers[(int)temp_output_136_0_g251978]);
					float4 temp_output_594_0_g251945 = lerpResult149_g251978;
					half4 Flow_Texture405_g251945 = temp_output_594_0_g251945;
					float4 In_FlowTexture204_g251945 = Flow_Texture405_g251945;
					half4 User_Texture677_g251945 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g251945 = User_Texture677_g251945;
					BuildGlobalData( Data204_g251945 , In_Dummy204_g251945 , In_CoatTexture204_g251945 , In_DrawTexture204_g251945 , In_PaintTexture204_g251945 , In_AtmoTexture204_g251945 , In_EffexTexture204_g251945 , In_GlowTexture204_g251945 , In_FormTexture204_g251945 , In_LandTexture204_g251945 , In_VertxTexture204_g251945 , In_FlowTexture204_g251945 , In_UserTexture204_g251945 );
					TVEGlobalData Data15_g252050 =(TVEGlobalData)Data204_g251945;
					float Out_Dummy15_g252050 = 0.0;
					float4 Out_CoatTexture15_g252050 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g252050 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g252050 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g252050 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g252050 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g252050 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g252050 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g252050 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g252050 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g252050 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g252050 = float4( 0,0,0,0 );
					BreakData( Data15_g252050 , Out_Dummy15_g252050 , Out_CoatTexture15_g252050 , Out_DrawTexture15_g252050 , Out_PaintTexture15_g252050 , Out_AtmoTexture15_g252050 , Out_EffexTexture15_g252050 , Out_GlowTexture15_g252050 , Out_FormTexture15_g252050 , Out_LandTexture15_g252050 , Out_VertxTexture15_g252050 , Out_FlowTexture15_g252050 , Out_UserTexture15_g252050 );
					float4 temp_output_2419_27 = Out_CoatTexture15_g252050;
					float3 ifLocalVar40_g252051 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g252051 = (temp_output_2419_27).xxx;
					float3 ifLocalVar40_g252052 = 0;
					if( TVE_DEBUG_Index == 3.0 )
					ifLocalVar40_g252052 = (temp_output_2419_27).yyy;
					float3 ifLocalVar40_g252053 = 0;
					if( TVE_DEBUG_Index == 4.0 )
					ifLocalVar40_g252053 = (temp_output_2419_27).zzz;
					float4 temp_output_2419_38 = Out_DrawTexture15_g252050;
					float3 ifLocalVar40_g252120 = 0;
					if( TVE_DEBUG_Index == 6.0 )
					ifLocalVar40_g252120 = (temp_output_2419_38).xyz;
					float3 ifLocalVar40_g252121 = 0;
					if( TVE_DEBUG_Index == 7.0 )
					ifLocalVar40_g252121 = (temp_output_2419_38).www;
					float4 temp_output_2419_0 = Out_PaintTexture15_g252050;
					float3 ifLocalVar40_g252123 = 0;
					if( TVE_DEBUG_Index == 9.0 )
					ifLocalVar40_g252123 = (temp_output_2419_0).xyz;
					float3 ifLocalVar40_g252122 = 0;
					if( TVE_DEBUG_Index == 10.0 )
					ifLocalVar40_g252122 = (temp_output_2419_0).www;
					float3 ifLocalVar40_g252124 = 0;
					if( TVE_DEBUG_Index == 12.0 )
					ifLocalVar40_g252124 = (Out_EffexTexture15_g252050).xxx;
					float4 temp_output_2419_16 = Out_AtmoTexture15_g252050;
					float3 ifLocalVar40_g252125 = 0;
					if( TVE_DEBUG_Index == 14.0 )
					ifLocalVar40_g252125 = (temp_output_2419_16).xxx;
					float3 ifLocalVar40_g252126 = 0;
					if( TVE_DEBUG_Index == 15.0 )
					ifLocalVar40_g252126 = (temp_output_2419_16).yyy;
					float3 ifLocalVar40_g252127 = 0;
					if( TVE_DEBUG_Index == 16.0 )
					ifLocalVar40_g252127 = (temp_output_2419_16).zzz;
					float3 ifLocalVar40_g252128 = 0;
					if( TVE_DEBUG_Index == 17.0 )
					ifLocalVar40_g252128 = (temp_output_2419_16).www;
					float4 temp_output_2419_19 = Out_GlowTexture15_g252050;
					float3 ifLocalVar40_g252129 = 0;
					if( TVE_DEBUG_Index == 19.0 )
					ifLocalVar40_g252129 = (temp_output_2419_19).xyz;
					float3 ifLocalVar40_g252130 = 0;
					if( TVE_DEBUG_Index == 20.0 )
					ifLocalVar40_g252130 = (temp_output_2419_19).www;
					float4 temp_output_2419_18 = Out_FormTexture15_g252050;
					float3 appendResult2536 = (float3((temp_output_2419_18).xy , 0.0));
					float3 ifLocalVar40_g252131 = 0;
					if( TVE_DEBUG_Index == 22.0 )
					ifLocalVar40_g252131 = ( appendResult2536 * appendResult2536 );
					float3 temp_output_2537_0 = ( (temp_output_2419_18).zzz * 0.1 );
					float3 ifLocalVar40_g252132 = 0;
					if( TVE_DEBUG_Index == 23.0 )
					ifLocalVar40_g252132 = temp_output_2537_0;
					float3 ifLocalVar40_g252134 = 0;
					if( TVE_DEBUG_Index == 24.0 )
					ifLocalVar40_g252134 = (temp_output_2419_18).www;
					float3 ifLocalVar40_g252133 = 0;
					if( TVE_DEBUG_Index == 26.0 )
					ifLocalVar40_g252133 = (Out_VertxTexture15_g252050).xxx;
					float4 temp_output_2419_24 = Out_FlowTexture15_g252050;
					float2 temp_output_2435_0 = (temp_output_2419_24).xy;
					float3 appendResult2501 = (float3(temp_output_2435_0 , 0.0));
					float3 ifLocalVar40_g252135 = 0;
					if( TVE_DEBUG_Index == 30.0 )
					ifLocalVar40_g252135 = ( appendResult2501 * appendResult2501 );
					float3 ifLocalVar40_g252136 = 0;
					if( TVE_DEBUG_Index == 31.0 )
					ifLocalVar40_g252136 = (temp_output_2419_24).zzz;
					float3 ifLocalVar40_g252137 = 0;
					if( TVE_DEBUG_Index == 32.0 )
					ifLocalVar40_g252137 = (temp_output_2419_24).www;
					float4 temp_output_2419_39 = Out_UserTexture15_g252050;
					float3 ifLocalVar40_g252138 = 0;
					if( TVE_DEBUG_Index == 34.0 )
					ifLocalVar40_g252138 = (temp_output_2419_39).xyz;
					float3 ifLocalVar40_g252139 = 0;
					if( TVE_DEBUG_Index == 35.0 )
					ifLocalVar40_g252139 = (temp_output_2419_39).xxx;
					float3 ifLocalVar40_g252140 = 0;
					if( TVE_DEBUG_Index == 36.0 )
					ifLocalVar40_g252140 = (temp_output_2419_39).yyy;
					float3 ifLocalVar40_g252141 = 0;
					if( TVE_DEBUG_Index == 37.0 )
					ifLocalVar40_g252141 = (temp_output_2419_39).zzz;
					float3 ifLocalVar40_g252142 = 0;
					if( TVE_DEBUG_Index == 38.0 )
					ifLocalVar40_g252142 = (temp_output_2419_39).www;
					half3 Final_Debug2399 = ( ifLocalVar40_g252147 + ( ifLocalVar40_g252051 + ifLocalVar40_g252052 + ifLocalVar40_g252053 ) + ( ifLocalVar40_g252120 + ifLocalVar40_g252121 ) + ( ifLocalVar40_g252123 + ifLocalVar40_g252122 + ifLocalVar40_g252124 ) + ( ifLocalVar40_g252125 + ifLocalVar40_g252126 + ifLocalVar40_g252127 + ifLocalVar40_g252128 ) + ( ifLocalVar40_g252129 + ifLocalVar40_g252130 ) + ( ifLocalVar40_g252131 + ifLocalVar40_g252132 + ifLocalVar40_g252134 + ifLocalVar40_g252133 ) + ( ifLocalVar40_g252135 + ifLocalVar40_g252136 + ifLocalVar40_g252137 ) + ( ifLocalVar40_g252138 + ifLocalVar40_g252139 + ifLocalVar40_g252140 + ifLocalVar40_g252141 + ifLocalVar40_g252142 ) );
					float temp_output_7_0_g252195 = TVE_DEBUG_Min;
					float3 temp_cast_19 = (temp_output_7_0_g252195).xxx;
					float3 temp_output_9_0_g252195 = ( Final_Debug2399 - temp_cast_19 );
					float lerpResult76_g252188 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g252188 = lerpResult76_g252188;
					float3 lerpResult72_g252188 = lerp( (lerpResult73_g252189).rgb , saturate( ( temp_output_9_0_g252195 / ( ( TVE_DEBUG_Max - temp_output_7_0_g252195 ) + 0.0001 ) ) ) , Filter152_g252188);
					float dotResult61_g252188 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g252188 = ( 1.0 - saturate( dotResult61_g252188 ) );
					float Shading_Fresnel59_g252188 = (( 1.0 - ( temp_output_65_0_g252188 * temp_output_65_0_g252188 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g252188 = IN.ase_texcoord7;
					float depthLinearEye57_g252188 = LinearEyeDepth( ase_positionCS57_g252188.z / ase_positionCS57_g252188.w );
					float temp_output_69_0_g252188 = saturate(  (0.0 + ( depthLinearEye57_g252188 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g252188 = (( temp_output_69_0_g252188 * temp_output_69_0_g252188 )*0.5 + 0.5);
					float lerpResult84_g252188 = lerp( 1.0 , Shading_Fresnel59_g252188 , ( Shading_Distance58_g252188 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g252193 = ( 0.0 );
					float localBuildVisualData3_g252150 = ( 0.0 );
					float localBuildVisualData3_g252144 = ( 0.0 );
					TVEVisualData Data3_g252144 =(TVEVisualData)0;
					float temp_output_14_0_g252144 = 0.0;
					float In_Dummy3_g252144 = temp_output_14_0_g252144;
					float3 temp_cast_20 = (0.5).xxx;
					float3 temp_output_4_0_g252144 = temp_cast_20;
					float3 In_Albedo3_g252144 = temp_output_4_0_g252144;
					float3 temp_cast_21 = (0.5).xxx;
					float3 temp_output_44_0_g252144 = temp_cast_21;
					float3 In_AlbedoBase3_g252144 = temp_output_44_0_g252144;
					float2 temp_cast_22 = (0.0).xx;
					float2 In_NormalTS3_g252144 = temp_cast_22;
					float3 temp_cast_23 = (0.5).xxx;
					float3 In_NormalWS3_g252144 = temp_cast_23;
					float4 In_Shader3_g252144 = half4( 0, 1, 0, 1 );
					float4 In_Feature3_g252144 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g252144 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g252144 = half4( 1, 1, 1, 1 );
					float temp_output_12_0_g252144 = 0.5;
					float In_Grayscale3_g252144 = temp_output_12_0_g252144;
					float temp_output_16_0_g252144 = 1.0;
					float In_Luminosity3_g252144 = temp_output_16_0_g252144;
					float In_MultiMask3_g252144 = 1.0;
					float In_AlphaClip3_g252144 = 1.0;
					float In_AlphaFade3_g252144 = 1.0;
					float3 temp_cast_24 = (1.0).xxx;
					float3 In_Translucency3_g252144 = temp_cast_24;
					float In_Transmission3_g252144 = 1.0;
					float In_Thickness3_g252144 = 0.0;
					float In_Diffusion3_g252144 = 0.0;
					float In_Depth3_g252144 = 0.0;
					BuildVisualData( Data3_g252144 , In_Dummy3_g252144 , In_Albedo3_g252144 , In_AlbedoBase3_g252144 , In_NormalTS3_g252144 , In_NormalWS3_g252144 , In_Shader3_g252144 , In_Feature3_g252144 , In_Season3_g252144 , In_Emissive3_g252144 , In_Grayscale3_g252144 , In_Luminosity3_g252144 , In_MultiMask3_g252144 , In_AlphaClip3_g252144 , In_AlphaFade3_g252144 , In_Translucency3_g252144 , In_Transmission3_g252144 , In_Thickness3_g252144 , In_Diffusion3_g252144 , In_Depth3_g252144 );
					TVEVisualData Data3_g252150 =(TVEVisualData)Data3_g252144;
					half Dummy130_g252148 = ( _MainCategory + _MainEnd );
					float temp_output_14_0_g252150 = Dummy130_g252148;
					float In_Dummy3_g252150 = temp_output_14_0_g252150;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g252171) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g252153 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g252153 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g252153 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g252153 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g252153 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g252153 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g252171 = staticSwitch36_g252153;
					float localBreakTextureData456_g252171 = ( 0.0 );
					float localBuildTextureData431_g252170 = ( 0.0 );
					TVEMasksData Data431_g252170 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g252170 = ( 0.0 );
					float4 temp_output_6_0_g252186 = _main_coord_value;
					float4 temp_output_7_0_g252186 = ( _MainSampleMode + _MainCoordMode + _MainCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g252186 = ( temp_output_6_0_g252186 + temp_output_7_0_g252186 );
					#else
					float4 staticSwitch14_g252186 = temp_output_6_0_g252186;
					#endif
					half4 Local_Coords180_g252148 = staticSwitch14_g252186;
					float4 Coords444_g252170 = Local_Coords180_g252148;
					TVEModelData Data15_g252145 =(TVEModelData)Data26_g251632;
					float Out_Dummy15_g252145 = 0.0;
					float3 Out_PositionWS15_g252145 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252145 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252145 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252145 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252145 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252145 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252145 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252145 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252145 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252145 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252145 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252145 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252145 , Out_Dummy15_g252145 , Out_PositionWS15_g252145 , Out_PositionWO15_g252145 , Out_PivotWS15_g252145 , Out_PivotWO15_g252145 , Out_NormalWS15_g252145 , Out_TangentWS15_g252145 , Out_BitangentWS15_g252145 , Out_TriplanarWeights15_g252145 , Out_ViewDirWS15_g252145 , Out_CoordsData15_g252145 , Out_VertexData15_g252145 , Out_Interpolator15_g252145 );
					TVEModelData Data16_g252146 =(TVEModelData)Data15_g252145;
					float In_Dummy16_g252146 = Out_Dummy15_g252145;
					float3 In_PositionWS16_g252146 = Out_PositionWS15_g252145;
					float3 In_PositionWO16_g252146 = Out_PositionWO15_g252145;
					float3 In_PivotWS16_g252146 = Out_PivotWS15_g252145;
					float3 In_PivotWO16_g252146 = Out_PivotWO15_g252145;
					float3 In_NormalWS16_g252146 = Out_NormalWS15_g252145;
					float3 In_TangentWS16_g252146 = Out_TangentWS15_g252145;
					float3 In_BitangentWS16_g252146 = Out_BitangentWS15_g252145;
					float3 In_TriplanarWeights16_g252146 = Out_TriplanarWeights15_g252145;
					float3 In_ViewDirWS16_g252146 = Out_ViewDirWS15_g252145;
					float4 In_CoordsData16_g252146 = Out_CoordsData15_g252145;
					float4 In_VertexData16_g252146 = Out_VertexData15_g252145;
					float4 vertexToFrag1901_g252143 = IN.ase_texcoord8;
					float4 In_Interpolator16_g252146 = vertexToFrag1901_g252143;
					BuildModelFragData( Data16_g252146 , In_Dummy16_g252146 , In_PositionWS16_g252146 , In_PositionWO16_g252146 , In_PivotWS16_g252146 , In_PivotWO16_g252146 , In_NormalWS16_g252146 , In_TangentWS16_g252146 , In_BitangentWS16_g252146 , In_TriplanarWeights16_g252146 , In_ViewDirWS16_g252146 , In_CoordsData16_g252146 , In_VertexData16_g252146 , In_Interpolator16_g252146 );
					TVEModelData Data15_g252149 =(TVEModelData)Data16_g252146;
					float Out_Dummy15_g252149 = 0.0;
					float3 Out_PositionWS15_g252149 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252149 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252149 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252149 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252149 = float3( 0,0,0 );
					float3 Out_TangentWS15_g252149 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252149 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g252149 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252149 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252149 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252149 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252149 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g252149 , Out_Dummy15_g252149 , Out_PositionWS15_g252149 , Out_PositionWO15_g252149 , Out_PivotWS15_g252149 , Out_PivotWO15_g252149 , Out_NormalWS15_g252149 , Out_TangentWS15_g252149 , Out_BitangentWS15_g252149 , Out_TriplanarWeights15_g252149 , Out_ViewDirWS15_g252149 , Out_CoordsData15_g252149 , Out_VertexData15_g252149 , Out_Interpolator15_g252149 );
					float4 Model_CoordsData324_g252148 = Out_CoordsData15_g252149;
					float4 MeshCoords444_g252170 = Model_CoordsData324_g252148;
					float2 UV0444_g252170 = float2( 0,0 );
					float2 UV3444_g252170 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g252170 , MeshCoords444_g252170 , UV0444_g252170 , UV3444_g252170 );
					float4 appendResult430_g252170 = (float4(UV0444_g252170 , UV3444_g252170));
					float4 In_MaskA431_g252170 = appendResult430_g252170;
					float localComputeWorldCoords315_g252170 = ( 0.0 );
					float4 Coords315_g252170 = Local_Coords180_g252148;
					float3 Model_PositionWO222_g252148 = Out_PositionWO15_g252149;
					float3 PositionWS315_g252170 = Model_PositionWO222_g252148;
					float2 ZY315_g252170 = float2( 0,0 );
					float2 XZ315_g252170 = float2( 0,0 );
					float2 XY315_g252170 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g252170 , PositionWS315_g252170 , ZY315_g252170 , XZ315_g252170 , XY315_g252170 );
					float2 ZY402_g252170 = ZY315_g252170;
					float2 XZ403_g252170 = XZ315_g252170;
					float4 appendResult432_g252170 = (float4(ZY402_g252170 , XZ403_g252170));
					float4 In_MaskB431_g252170 = appendResult432_g252170;
					float2 XY404_g252170 = XY315_g252170;
					float localComputeStochasticCoords409_g252170 = ( 0.0 );
					float2 UV409_g252170 = ZY402_g252170;
					float2 UV1409_g252170 = float2( 0,0 );
					float2 UV2409_g252170 = float2( 0,0 );
					float2 UV3409_g252170 = float2( 0,0 );
					float3 Weights409_g252170 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g252170 , UV1409_g252170 , UV2409_g252170 , UV3409_g252170 , Weights409_g252170 );
					float4 appendResult433_g252170 = (float4(XY404_g252170 , UV1409_g252170));
					float4 In_MaskC431_g252170 = appendResult433_g252170;
					float4 appendResult434_g252170 = (float4(UV2409_g252170 , UV3409_g252170));
					float4 In_MaskD431_g252170 = appendResult434_g252170;
					float localComputeStochasticCoords422_g252170 = ( 0.0 );
					float2 UV422_g252170 = XZ403_g252170;
					float2 UV1422_g252170 = float2( 0,0 );
					float2 UV2422_g252170 = float2( 0,0 );
					float2 UV3422_g252170 = float2( 0,0 );
					float3 Weights422_g252170 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g252170 , UV1422_g252170 , UV2422_g252170 , UV3422_g252170 , Weights422_g252170 );
					float4 appendResult435_g252170 = (float4(UV1422_g252170 , UV2422_g252170));
					float4 In_MaskE431_g252170 = appendResult435_g252170;
					float localComputeStochasticCoords423_g252170 = ( 0.0 );
					float2 UV423_g252170 = XY404_g252170;
					float2 UV1423_g252170 = float2( 0,0 );
					float2 UV2423_g252170 = float2( 0,0 );
					float2 UV3423_g252170 = float2( 0,0 );
					float3 Weights423_g252170 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g252170 , UV1423_g252170 , UV2423_g252170 , UV3423_g252170 , Weights423_g252170 );
					float4 appendResult436_g252170 = (float4(UV3422_g252170 , UV1423_g252170));
					float4 In_MaskF431_g252170 = appendResult436_g252170;
					float4 appendResult437_g252170 = (float4(UV2423_g252170 , UV3423_g252170));
					float4 In_MaskG431_g252170 = appendResult437_g252170;
					float4 In_MaskH431_g252170 = float4( Weights409_g252170 , 0.0 );
					float4 In_MaskI431_g252170 = float4( Weights422_g252170 , 0.0 );
					float4 In_MaskJ431_g252170 = float4( Weights423_g252170 , 0.0 );
					half3 Model_NormalWS226_g252148 = Out_NormalWS15_g252149;
					float3 temp_output_449_0_g252170 = Model_NormalWS226_g252148;
					float4 In_MaskK431_g252170 = float4( temp_output_449_0_g252170 , 0.0 );
					half3 Model_TangentWS366_g252148 = Out_TangentWS15_g252149;
					float3 temp_output_450_0_g252170 = Model_TangentWS366_g252148;
					float4 In_MaskL431_g252170 = float4( temp_output_450_0_g252170 , 0.0 );
					half3 Model_BitangentWS367_g252148 = Out_BitangentWS15_g252149;
					float3 temp_output_451_0_g252170 = Model_BitangentWS367_g252148;
					float4 In_MaskM431_g252170 = float4( temp_output_451_0_g252170 , 0.0 );
					half3 Model_TriplanarWeights368_g252148 = Out_TriplanarWeights15_g252149;
					float3 temp_output_445_0_g252170 = Model_TriplanarWeights368_g252148;
					float4 In_MaskN431_g252170 = float4( temp_output_445_0_g252170 , 0.0 );
					BuildTextureData( Data431_g252170 , In_MaskA431_g252170 , In_MaskB431_g252170 , In_MaskC431_g252170 , In_MaskD431_g252170 , In_MaskE431_g252170 , In_MaskF431_g252170 , In_MaskG431_g252170 , In_MaskH431_g252170 , In_MaskI431_g252170 , In_MaskJ431_g252170 , In_MaskK431_g252170 , In_MaskL431_g252170 , In_MaskM431_g252170 , In_MaskN431_g252170 );
					TVEMasksData Data456_g252171 =(TVEMasksData)Data431_g252170;
					float4 Out_MaskA456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g252171 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g252171 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g252171 , Out_MaskA456_g252171 , Out_MaskB456_g252171 , Out_MaskC456_g252171 , Out_MaskD456_g252171 , Out_MaskE456_g252171 , Out_MaskF456_g252171 , Out_MaskG456_g252171 , Out_MaskH456_g252171 , Out_MaskI456_g252171 , Out_MaskJ456_g252171 , Out_MaskK456_g252171 , Out_MaskL456_g252171 , Out_MaskM456_g252171 , Out_MaskN456_g252171 );
					half2 UV276_g252171 = (Out_MaskA456_g252171).xy;
					float temp_output_504_0_g252171 = 0.0;
					half Bias276_g252171 = temp_output_504_0_g252171;
					half2 Normal276_g252171 = float2( 0,0 );
					half4 localSampleCoord276_g252171 = SampleCoord( Texture276_g252171 , Sampler276_g252171 , UV276_g252171 , Bias276_g252171 , Normal276_g252171 );
					float4 temp_output_407_277_g252148 = localSampleCoord276_g252171;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g252171) = _MainAlbedoTex;
					SamplerState Sampler502_g252171 = staticSwitch36_g252153;
					half2 UV502_g252171 = (Out_MaskA456_g252171).zw;
					half Bias502_g252171 = temp_output_504_0_g252171;
					half2 Normal502_g252171 = float2( 0,0 );
					half4 localSampleCoord502_g252171 = SampleCoord( Texture502_g252171 , Sampler502_g252171 , UV502_g252171 , Bias502_g252171 , Normal502_g252171 );
					float4 temp_output_407_278_g252148 = localSampleCoord502_g252171;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252171) = _MainAlbedoTex;
					SamplerState Sampler496_g252171 = staticSwitch36_g252153;
					float2 temp_output_463_0_g252171 = (Out_MaskB456_g252171).zw;
					half2 XZ496_g252171 = temp_output_463_0_g252171;
					half Bias496_g252171 = temp_output_504_0_g252171;
					half3 NormalWS512_g252171 = (Out_MaskK456_g252171).xyz;
					half3 NormalWS496_g252171 = NormalWS512_g252171;
					half3 Normal496_g252171 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g252171 = SamplePlanar2D( Texture496_g252171 , Sampler496_g252171 , XZ496_g252171 , Bias496_g252171 , NormalWS496_g252171 , Normal496_g252171 );
					float4 temp_output_407_0_g252148 = localSamplePlanar2D496_g252171;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252171) = _MainAlbedoTex;
					SamplerState Sampler490_g252171 = staticSwitch36_g252153;
					float2 temp_output_462_0_g252171 = (Out_MaskB456_g252171).xy;
					half2 ZY490_g252171 = temp_output_462_0_g252171;
					half2 XZ490_g252171 = temp_output_463_0_g252171;
					float2 temp_output_464_0_g252171 = (Out_MaskC456_g252171).xy;
					half2 XY490_g252171 = temp_output_464_0_g252171;
					half Bias490_g252171 = temp_output_504_0_g252171;
					half3 Triplanar522_g252171 = (Out_MaskN456_g252171).xyz;
					half3 Triplanar490_g252171 = Triplanar522_g252171;
					half3 NormalWS490_g252171 = NormalWS512_g252171;
					half3 Normal490_g252171 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g252171 = SamplePlanar3D( Texture490_g252171 , Sampler490_g252171 , ZY490_g252171 , XZ490_g252171 , XY490_g252171 , Bias490_g252171 , Triplanar490_g252171 , NormalWS490_g252171 , Normal490_g252171 );
					float4 temp_output_407_201_g252148 = localSamplePlanar3D490_g252171;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g252171) = _MainAlbedoTex;
					SamplerState Sampler498_g252171 = staticSwitch36_g252153;
					half2 XZ498_g252171 = temp_output_463_0_g252171;
					float2 temp_output_473_0_g252171 = (Out_MaskE456_g252171).xy;
					half2 XZ_1498_g252171 = temp_output_473_0_g252171;
					float2 temp_output_474_0_g252171 = (Out_MaskE456_g252171).zw;
					half2 XZ_2498_g252171 = temp_output_474_0_g252171;
					float2 temp_output_475_0_g252171 = (Out_MaskF456_g252171).xy;
					half2 XZ_3498_g252171 = temp_output_475_0_g252171;
					float temp_output_510_0_g252171 = exp2( temp_output_504_0_g252171 );
					half Bias498_g252171 = temp_output_510_0_g252171;
					float3 temp_output_480_0_g252171 = (Out_MaskI456_g252171).xyz;
					half3 Weights_2498_g252171 = temp_output_480_0_g252171;
					half3 NormalWS498_g252171 = NormalWS512_g252171;
					half3 Normal498_g252171 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g252171 = SampleStochastic2D( Texture498_g252171 , Sampler498_g252171 , XZ498_g252171 , XZ_1498_g252171 , XZ_2498_g252171 , XZ_3498_g252171 , Bias498_g252171 , Weights_2498_g252171 , NormalWS498_g252171 , Normal498_g252171 );
					float4 temp_output_407_202_g252148 = localSampleStochastic2D498_g252171;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g252171) = _MainAlbedoTex;
					SamplerState Sampler500_g252171 = staticSwitch36_g252153;
					half2 ZY500_g252171 = temp_output_462_0_g252171;
					half2 ZY_1500_g252171 = (Out_MaskC456_g252171).zw;
					half2 ZY_2500_g252171 = (Out_MaskD456_g252171).xy;
					half2 ZY_3500_g252171 = (Out_MaskD456_g252171).zw;
					half2 XZ500_g252171 = temp_output_463_0_g252171;
					half2 XZ_1500_g252171 = temp_output_473_0_g252171;
					half2 XZ_2500_g252171 = temp_output_474_0_g252171;
					half2 XZ_3500_g252171 = temp_output_475_0_g252171;
					half2 XY500_g252171 = temp_output_464_0_g252171;
					half2 XY_1500_g252171 = (Out_MaskF456_g252171).zw;
					half2 XY_2500_g252171 = (Out_MaskG456_g252171).xy;
					half2 XY_3500_g252171 = (Out_MaskG456_g252171).zw;
					half Bias500_g252171 = temp_output_510_0_g252171;
					half3 Weights_1500_g252171 = (Out_MaskH456_g252171).xyz;
					half3 Weights_2500_g252171 = temp_output_480_0_g252171;
					half3 Weights_3500_g252171 = (Out_MaskJ456_g252171).xyz;
					half3 Triplanar500_g252171 = Triplanar522_g252171;
					half3 NormalWS500_g252171 = NormalWS512_g252171;
					half3 Normal500_g252171 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g252171 = SampleStochastic3D( Texture500_g252171 , Sampler500_g252171 , ZY500_g252171 , ZY_1500_g252171 , ZY_2500_g252171 , ZY_3500_g252171 , XZ500_g252171 , XZ_1500_g252171 , XZ_2500_g252171 , XZ_3500_g252171 , XY500_g252171 , XY_1500_g252171 , XY_2500_g252171 , XY_3500_g252171 , Bias500_g252171 , Weights_1500_g252171 , Weights_2500_g252171 , Weights_3500_g252171 , Triplanar500_g252171 , NormalWS500_g252171 , Normal500_g252171 );
					float4 temp_output_407_203_g252148 = localSampleStochastic3D500_g252171;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g252148 = temp_output_407_277_g252148;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g252148 = temp_output_407_278_g252148;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g252148 = temp_output_407_0_g252148;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g252148 = temp_output_407_201_g252148;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g252148 = temp_output_407_202_g252148;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g252148 = temp_output_407_203_g252148;
					#else
					float4 staticSwitch184_g252148 = temp_output_407_277_g252148;
					#endif
					half4 Local_AlbedoSample185_g252148 = staticSwitch184_g252148;
					float3 lerpResult53_g252148 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g252148).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g252148 = lerpResult53_g252148;
					float temp_output_17_0_g252168 = _MainMultiWriteMode;
					float Option91_g252168 = temp_output_17_0_g252168;
					float4 Model_VertexData418_g252148 = Out_VertexData15_g252149;
					float4 temp_output_84_0_g252168 = Model_VertexData418_g252148;
					float4 ChannelA91_g252168 = temp_output_84_0_g252168;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g252156) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g252155 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g252155 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g252155 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g252155 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g252155 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g252155 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g252156 = staticSwitch38_g252155;
					float localBreakTextureData456_g252156 = ( 0.0 );
					TVEMasksData Data456_g252156 =(TVEMasksData)Data431_g252170;
					float4 Out_MaskA456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g252156 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g252156 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g252156 , Out_MaskA456_g252156 , Out_MaskB456_g252156 , Out_MaskC456_g252156 , Out_MaskD456_g252156 , Out_MaskE456_g252156 , Out_MaskF456_g252156 , Out_MaskG456_g252156 , Out_MaskH456_g252156 , Out_MaskI456_g252156 , Out_MaskJ456_g252156 , Out_MaskK456_g252156 , Out_MaskL456_g252156 , Out_MaskM456_g252156 , Out_MaskN456_g252156 );
					half2 UV276_g252156 = (Out_MaskA456_g252156).xy;
					float temp_output_504_0_g252156 = 0.0;
					half Bias276_g252156 = temp_output_504_0_g252156;
					half2 Normal276_g252156 = float2( 0,0 );
					half4 localSampleCoord276_g252156 = SampleCoord( Texture276_g252156 , Sampler276_g252156 , UV276_g252156 , Bias276_g252156 , Normal276_g252156 );
					float4 temp_output_405_277_g252148 = localSampleCoord276_g252156;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g252156) = _MainShaderTex;
					SamplerState Sampler502_g252156 = staticSwitch38_g252155;
					half2 UV502_g252156 = (Out_MaskA456_g252156).zw;
					half Bias502_g252156 = temp_output_504_0_g252156;
					half2 Normal502_g252156 = float2( 0,0 );
					half4 localSampleCoord502_g252156 = SampleCoord( Texture502_g252156 , Sampler502_g252156 , UV502_g252156 , Bias502_g252156 , Normal502_g252156 );
					float4 temp_output_405_278_g252148 = localSampleCoord502_g252156;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252156) = _MainShaderTex;
					SamplerState Sampler496_g252156 = staticSwitch38_g252155;
					float2 temp_output_463_0_g252156 = (Out_MaskB456_g252156).zw;
					half2 XZ496_g252156 = temp_output_463_0_g252156;
					half Bias496_g252156 = temp_output_504_0_g252156;
					half3 NormalWS512_g252156 = (Out_MaskK456_g252156).xyz;
					half3 NormalWS496_g252156 = NormalWS512_g252156;
					half3 Normal496_g252156 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g252156 = SamplePlanar2D( Texture496_g252156 , Sampler496_g252156 , XZ496_g252156 , Bias496_g252156 , NormalWS496_g252156 , Normal496_g252156 );
					float4 temp_output_405_0_g252148 = localSamplePlanar2D496_g252156;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252156) = _MainShaderTex;
					SamplerState Sampler490_g252156 = staticSwitch38_g252155;
					float2 temp_output_462_0_g252156 = (Out_MaskB456_g252156).xy;
					half2 ZY490_g252156 = temp_output_462_0_g252156;
					half2 XZ490_g252156 = temp_output_463_0_g252156;
					float2 temp_output_464_0_g252156 = (Out_MaskC456_g252156).xy;
					half2 XY490_g252156 = temp_output_464_0_g252156;
					half Bias490_g252156 = temp_output_504_0_g252156;
					half3 Triplanar522_g252156 = (Out_MaskN456_g252156).xyz;
					half3 Triplanar490_g252156 = Triplanar522_g252156;
					half3 NormalWS490_g252156 = NormalWS512_g252156;
					half3 Normal490_g252156 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g252156 = SamplePlanar3D( Texture490_g252156 , Sampler490_g252156 , ZY490_g252156 , XZ490_g252156 , XY490_g252156 , Bias490_g252156 , Triplanar490_g252156 , NormalWS490_g252156 , Normal490_g252156 );
					float4 temp_output_405_201_g252148 = localSamplePlanar3D490_g252156;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g252156) = _MainShaderTex;
					SamplerState Sampler498_g252156 = staticSwitch38_g252155;
					half2 XZ498_g252156 = temp_output_463_0_g252156;
					float2 temp_output_473_0_g252156 = (Out_MaskE456_g252156).xy;
					half2 XZ_1498_g252156 = temp_output_473_0_g252156;
					float2 temp_output_474_0_g252156 = (Out_MaskE456_g252156).zw;
					half2 XZ_2498_g252156 = temp_output_474_0_g252156;
					float2 temp_output_475_0_g252156 = (Out_MaskF456_g252156).xy;
					half2 XZ_3498_g252156 = temp_output_475_0_g252156;
					float temp_output_510_0_g252156 = exp2( temp_output_504_0_g252156 );
					half Bias498_g252156 = temp_output_510_0_g252156;
					float3 temp_output_480_0_g252156 = (Out_MaskI456_g252156).xyz;
					half3 Weights_2498_g252156 = temp_output_480_0_g252156;
					half3 NormalWS498_g252156 = NormalWS512_g252156;
					half3 Normal498_g252156 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g252156 = SampleStochastic2D( Texture498_g252156 , Sampler498_g252156 , XZ498_g252156 , XZ_1498_g252156 , XZ_2498_g252156 , XZ_3498_g252156 , Bias498_g252156 , Weights_2498_g252156 , NormalWS498_g252156 , Normal498_g252156 );
					float4 temp_output_405_202_g252148 = localSampleStochastic2D498_g252156;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g252156) = _MainShaderTex;
					SamplerState Sampler500_g252156 = staticSwitch38_g252155;
					half2 ZY500_g252156 = temp_output_462_0_g252156;
					half2 ZY_1500_g252156 = (Out_MaskC456_g252156).zw;
					half2 ZY_2500_g252156 = (Out_MaskD456_g252156).xy;
					half2 ZY_3500_g252156 = (Out_MaskD456_g252156).zw;
					half2 XZ500_g252156 = temp_output_463_0_g252156;
					half2 XZ_1500_g252156 = temp_output_473_0_g252156;
					half2 XZ_2500_g252156 = temp_output_474_0_g252156;
					half2 XZ_3500_g252156 = temp_output_475_0_g252156;
					half2 XY500_g252156 = temp_output_464_0_g252156;
					half2 XY_1500_g252156 = (Out_MaskF456_g252156).zw;
					half2 XY_2500_g252156 = (Out_MaskG456_g252156).xy;
					half2 XY_3500_g252156 = (Out_MaskG456_g252156).zw;
					half Bias500_g252156 = temp_output_510_0_g252156;
					half3 Weights_1500_g252156 = (Out_MaskH456_g252156).xyz;
					half3 Weights_2500_g252156 = temp_output_480_0_g252156;
					half3 Weights_3500_g252156 = (Out_MaskJ456_g252156).xyz;
					half3 Triplanar500_g252156 = Triplanar522_g252156;
					half3 NormalWS500_g252156 = NormalWS512_g252156;
					half3 Normal500_g252156 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g252156 = SampleStochastic3D( Texture500_g252156 , Sampler500_g252156 , ZY500_g252156 , ZY_1500_g252156 , ZY_2500_g252156 , ZY_3500_g252156 , XZ500_g252156 , XZ_1500_g252156 , XZ_2500_g252156 , XZ_3500_g252156 , XY500_g252156 , XY_1500_g252156 , XY_2500_g252156 , XY_3500_g252156 , Bias500_g252156 , Weights_1500_g252156 , Weights_2500_g252156 , Weights_3500_g252156 , Triplanar500_g252156 , NormalWS500_g252156 , Normal500_g252156 );
					float4 temp_output_405_203_g252148 = localSampleStochastic3D500_g252156;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g252148 = temp_output_405_277_g252148;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g252148 = temp_output_405_278_g252148;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g252148 = temp_output_405_0_g252148;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g252148 = temp_output_405_201_g252148;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g252148 = temp_output_405_202_g252148;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g252148 = temp_output_405_203_g252148;
					#else
					float4 staticSwitch198_g252148 = temp_output_405_277_g252148;
					#endif
					half4 Local_ShaderSample199_g252148 = staticSwitch198_g252148;
					float2 appendResult428_g252148 = (float2((Local_AlbedoSample185_g252148).w , (Local_ShaderSample199_g252148).z));
					float2 temp_output_85_0_g252168 = appendResult428_g252148;
					float4 ChannelB91_g252168 = float4( temp_output_85_0_g252168, 0.0 , 0.0 );
					float localSwitchChannel691_g252168 = SwitchChannel6( Option91_g252168 , ChannelA91_g252168 , ChannelB91_g252168 );
					float clampResult17_g252166 = clamp( localSwitchChannel691_g252168 , 0.0001 , 0.9999 );
					float temp_output_7_0_g252167 = _MainMultiWriteRemap.x;
					float temp_output_9_0_g252167 = ( clampResult17_g252166 - temp_output_7_0_g252167 );
					half Local_MultiMask78_g252148 = saturate( ( temp_output_9_0_g252167 * _MainMultiWriteRemap.z ) );
					float lerpResult58_g252148 = lerp( 1.0 , Local_MultiMask78_g252148 , _MainColorMode);
					float4 lerpResult62_g252148 = lerp( _MainColorTwo , _MainColor , lerpResult58_g252148);
					half3 Local_ColorRGB93_g252148 = (lerpResult62_g252148).rgb;
					half3 Local_Albedo139_g252148 = ( Local_AlbedoRGB107_g252148 * Local_ColorRGB93_g252148 );
					float3 temp_output_4_0_g252150 = Local_Albedo139_g252148;
					float3 In_Albedo3_g252150 = temp_output_4_0_g252150;
					float3 temp_output_44_0_g252150 = Local_Albedo139_g252148;
					float3 In_AlbedoBase3_g252150 = temp_output_44_0_g252150;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g252177) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g252154 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g252154 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g252154 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g252154 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g252154 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g252154 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g252177 = staticSwitch37_g252154;
					float localBreakTextureData456_g252177 = ( 0.0 );
					TVEMasksData Data456_g252177 =(TVEMasksData)Data431_g252170;
					float4 Out_MaskA456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g252177 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g252177 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g252177 , Out_MaskA456_g252177 , Out_MaskB456_g252177 , Out_MaskC456_g252177 , Out_MaskD456_g252177 , Out_MaskE456_g252177 , Out_MaskF456_g252177 , Out_MaskG456_g252177 , Out_MaskH456_g252177 , Out_MaskI456_g252177 , Out_MaskJ456_g252177 , Out_MaskK456_g252177 , Out_MaskL456_g252177 , Out_MaskM456_g252177 , Out_MaskN456_g252177 );
					half2 UV276_g252177 = (Out_MaskA456_g252177).xy;
					float temp_output_504_0_g252177 = 0.0;
					half Bias276_g252177 = temp_output_504_0_g252177;
					half2 Normal276_g252177 = float2( 0,0 );
					half4 localSampleCoord276_g252177 = SampleCoord( Texture276_g252177 , Sampler276_g252177 , UV276_g252177 , Bias276_g252177 , Normal276_g252177 );
					float2 temp_output_406_394_g252148 = Normal276_g252177;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g252177) = _MainNormalTex;
					SamplerState Sampler502_g252177 = staticSwitch37_g252154;
					half2 UV502_g252177 = (Out_MaskA456_g252177).zw;
					half Bias502_g252177 = temp_output_504_0_g252177;
					half2 Normal502_g252177 = float2( 0,0 );
					half4 localSampleCoord502_g252177 = SampleCoord( Texture502_g252177 , Sampler502_g252177 , UV502_g252177 , Bias502_g252177 , Normal502_g252177 );
					float2 temp_output_406_397_g252148 = Normal502_g252177;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g252177) = _MainNormalTex;
					SamplerState Sampler496_g252177 = staticSwitch37_g252154;
					float2 temp_output_463_0_g252177 = (Out_MaskB456_g252177).zw;
					half2 XZ496_g252177 = temp_output_463_0_g252177;
					half Bias496_g252177 = temp_output_504_0_g252177;
					half3 NormalWS512_g252177 = (Out_MaskK456_g252177).xyz;
					half3 NormalWS496_g252177 = NormalWS512_g252177;
					half3 Normal496_g252177 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g252177 = SamplePlanar2D( Texture496_g252177 , Sampler496_g252177 , XZ496_g252177 , Bias496_g252177 , NormalWS496_g252177 , Normal496_g252177 );
					float3 temp_output_35_0_g252180 = Normal496_g252177;
					half3 TangentWS519_g252177 = (Out_MaskL456_g252177).xyz;
					float dotResult84_g252180 = dot( temp_output_35_0_g252180 , TangentWS519_g252177 );
					half3 BitangentWS521_g252177 = (Out_MaskM456_g252177).xyz;
					float dotResult85_g252180 = dot( temp_output_35_0_g252180 , BitangentWS521_g252177 );
					float2 appendResult87_g252180 = (float2(dotResult84_g252180 , dotResult85_g252180));
					float2 temp_output_406_375_g252148 = appendResult87_g252180;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g252177) = _MainNormalTex;
					SamplerState Sampler490_g252177 = staticSwitch37_g252154;
					float2 temp_output_462_0_g252177 = (Out_MaskB456_g252177).xy;
					half2 ZY490_g252177 = temp_output_462_0_g252177;
					half2 XZ490_g252177 = temp_output_463_0_g252177;
					float2 temp_output_464_0_g252177 = (Out_MaskC456_g252177).xy;
					half2 XY490_g252177 = temp_output_464_0_g252177;
					half Bias490_g252177 = temp_output_504_0_g252177;
					half3 Triplanar522_g252177 = (Out_MaskN456_g252177).xyz;
					half3 Triplanar490_g252177 = Triplanar522_g252177;
					half3 NormalWS490_g252177 = NormalWS512_g252177;
					half3 Normal490_g252177 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g252177 = SamplePlanar3D( Texture490_g252177 , Sampler490_g252177 , ZY490_g252177 , XZ490_g252177 , XY490_g252177 , Bias490_g252177 , Triplanar490_g252177 , NormalWS490_g252177 , Normal490_g252177 );
					float3 temp_output_35_0_g252181 = Normal490_g252177;
					float dotResult84_g252181 = dot( temp_output_35_0_g252181 , TangentWS519_g252177 );
					float dotResult85_g252181 = dot( temp_output_35_0_g252181 , BitangentWS521_g252177 );
					float2 appendResult87_g252181 = (float2(dotResult84_g252181 , dotResult85_g252181));
					float2 temp_output_406_353_g252148 = appendResult87_g252181;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g252177) = _MainNormalTex;
					SamplerState Sampler498_g252177 = staticSwitch37_g252154;
					half2 XZ498_g252177 = temp_output_463_0_g252177;
					float2 temp_output_473_0_g252177 = (Out_MaskE456_g252177).xy;
					half2 XZ_1498_g252177 = temp_output_473_0_g252177;
					float2 temp_output_474_0_g252177 = (Out_MaskE456_g252177).zw;
					half2 XZ_2498_g252177 = temp_output_474_0_g252177;
					float2 temp_output_475_0_g252177 = (Out_MaskF456_g252177).xy;
					half2 XZ_3498_g252177 = temp_output_475_0_g252177;
					float temp_output_510_0_g252177 = exp2( temp_output_504_0_g252177 );
					half Bias498_g252177 = temp_output_510_0_g252177;
					float3 temp_output_480_0_g252177 = (Out_MaskI456_g252177).xyz;
					half3 Weights_2498_g252177 = temp_output_480_0_g252177;
					half3 NormalWS498_g252177 = NormalWS512_g252177;
					half3 Normal498_g252177 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g252177 = SampleStochastic2D( Texture498_g252177 , Sampler498_g252177 , XZ498_g252177 , XZ_1498_g252177 , XZ_2498_g252177 , XZ_3498_g252177 , Bias498_g252177 , Weights_2498_g252177 , NormalWS498_g252177 , Normal498_g252177 );
					float3 temp_output_35_0_g252182 = Normal498_g252177;
					float dotResult84_g252182 = dot( temp_output_35_0_g252182 , TangentWS519_g252177 );
					float dotResult85_g252182 = dot( temp_output_35_0_g252182 , BitangentWS521_g252177 );
					float2 appendResult87_g252182 = (float2(dotResult84_g252182 , dotResult85_g252182));
					float2 temp_output_406_391_g252148 = appendResult87_g252182;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g252177) = _MainNormalTex;
					SamplerState Sampler500_g252177 = staticSwitch37_g252154;
					half2 ZY500_g252177 = temp_output_462_0_g252177;
					half2 ZY_1500_g252177 = (Out_MaskC456_g252177).zw;
					half2 ZY_2500_g252177 = (Out_MaskD456_g252177).xy;
					half2 ZY_3500_g252177 = (Out_MaskD456_g252177).zw;
					half2 XZ500_g252177 = temp_output_463_0_g252177;
					half2 XZ_1500_g252177 = temp_output_473_0_g252177;
					half2 XZ_2500_g252177 = temp_output_474_0_g252177;
					half2 XZ_3500_g252177 = temp_output_475_0_g252177;
					half2 XY500_g252177 = temp_output_464_0_g252177;
					half2 XY_1500_g252177 = (Out_MaskF456_g252177).zw;
					half2 XY_2500_g252177 = (Out_MaskG456_g252177).xy;
					half2 XY_3500_g252177 = (Out_MaskG456_g252177).zw;
					half Bias500_g252177 = temp_output_510_0_g252177;
					half3 Weights_1500_g252177 = (Out_MaskH456_g252177).xyz;
					half3 Weights_2500_g252177 = temp_output_480_0_g252177;
					half3 Weights_3500_g252177 = (Out_MaskJ456_g252177).xyz;
					half3 Triplanar500_g252177 = Triplanar522_g252177;
					half3 NormalWS500_g252177 = NormalWS512_g252177;
					half3 Normal500_g252177 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g252177 = SampleStochastic3D( Texture500_g252177 , Sampler500_g252177 , ZY500_g252177 , ZY_1500_g252177 , ZY_2500_g252177 , ZY_3500_g252177 , XZ500_g252177 , XZ_1500_g252177 , XZ_2500_g252177 , XZ_3500_g252177 , XY500_g252177 , XY_1500_g252177 , XY_2500_g252177 , XY_3500_g252177 , Bias500_g252177 , Weights_1500_g252177 , Weights_2500_g252177 , Weights_3500_g252177 , Triplanar500_g252177 , NormalWS500_g252177 , Normal500_g252177 );
					float3 temp_output_35_0_g252178 = Normal500_g252177;
					float dotResult84_g252178 = dot( temp_output_35_0_g252178 , TangentWS519_g252177 );
					float dotResult85_g252178 = dot( temp_output_35_0_g252178 , BitangentWS521_g252177 );
					float2 appendResult87_g252178 = (float2(dotResult84_g252178 , dotResult85_g252178));
					float2 temp_output_406_390_g252148 = appendResult87_g252178;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g252148 = temp_output_406_394_g252148;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g252148 = temp_output_406_397_g252148;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g252148 = temp_output_406_375_g252148;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g252148 = temp_output_406_353_g252148;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g252148 = temp_output_406_391_g252148;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g252148 = temp_output_406_390_g252148;
					#else
					float2 staticSwitch193_g252148 = temp_output_406_394_g252148;
					#endif
					half2 Local_NormaSample191_g252148 = staticSwitch193_g252148;
					half2 Local_NormalTS108_g252148 = ( Local_NormaSample191_g252148 * _MainNormalValue );
					float2 In_NormalTS3_g252150 = Local_NormalTS108_g252148;
					float2 break80_g252169 = Local_NormalTS108_g252148;
					float3 temp_output_77_0_g252169 = Model_TangentWS366_g252148;
					float3 temp_output_78_0_g252169 = Model_BitangentWS367_g252148;
					float3 temp_output_76_0_g252169 = Model_NormalWS226_g252148;
					half3 Local_NormalWS250_g252148 = ( ( break80_g252169.x * temp_output_77_0_g252169 ) + ( break80_g252169.y * temp_output_78_0_g252169 ) + temp_output_76_0_g252169 );
					float3 In_NormalWS3_g252150 = Local_NormalWS250_g252148;
					float temp_output_209_0_g252148 = (Local_ShaderSample199_g252148).y;
					float temp_output_7_0_g252162 = _MainOcclusionRemap.x;
					float temp_output_9_0_g252162 = ( temp_output_209_0_g252148 - temp_output_7_0_g252162 );
					float lerpResult23_g252148 = lerp( 1.0 , saturate( ( temp_output_9_0_g252162 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g252148 = lerpResult23_g252148;
					float temp_output_213_0_g252148 = (Local_ShaderSample199_g252148).w;
					float temp_output_7_0_g252165 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g252165 = ( temp_output_213_0_g252148 - temp_output_7_0_g252165 );
					half Local_Smoothness317_g252148 = ( saturate( ( temp_output_9_0_g252165 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g252148 = (float4(( (Local_ShaderSample199_g252148).x * _MainMetallicValue ) , Local_Occlusion313_g252148 , (Local_ShaderSample199_g252148).z , Local_Smoothness317_g252148));
					half4 Local_Masks109_g252148 = appendResult73_g252148;
					float4 In_Shader3_g252150 = Local_Masks109_g252148;
					float4 In_Feature3_g252150 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g252150 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g252150 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g252183 = Local_Albedo139_g252148;
					float dotResult20_g252183 = dot( temp_output_3_0_g252183 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g252148 = dotResult20_g252183;
					float temp_output_12_0_g252150 = Local_Grayscale110_g252148;
					float In_Grayscale3_g252150 = temp_output_12_0_g252150;
					float temp_output_3_0_g252184 = Local_Grayscale110_g252148;
					float clampResult27_g252184 = clamp( saturate( ( temp_output_3_0_g252184 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g252148 = clampResult27_g252184;
					float temp_output_16_0_g252150 = Local_Luminosity145_g252148;
					float In_Luminosity3_g252150 = temp_output_16_0_g252150;
					float In_MultiMask3_g252150 = Local_MultiMask78_g252148;
					float temp_output_187_0_g252148 = (Local_AlbedoSample185_g252148).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g252148 = ( temp_output_187_0_g252148 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g252148 = temp_output_187_0_g252148;
					#endif
					half Local_AlphaClip111_g252148 = staticSwitch236_g252148;
					float In_AlphaClip3_g252150 = Local_AlphaClip111_g252148;
					half Local_AlphaFade246_g252148 = (lerpResult62_g252148).a;
					float In_AlphaFade3_g252150 = Local_AlphaFade246_g252148;
					float3 temp_cast_33 = (1.0).xxx;
					float3 In_Translucency3_g252150 = temp_cast_33;
					float In_Transmission3_g252150 = 1.0;
					float In_Thickness3_g252150 = 0.0;
					float In_Diffusion3_g252150 = 0.0;
					float In_Depth3_g252150 = 0.0;
					BuildVisualData( Data3_g252150 , In_Dummy3_g252150 , In_Albedo3_g252150 , In_AlbedoBase3_g252150 , In_NormalTS3_g252150 , In_NormalWS3_g252150 , In_Shader3_g252150 , In_Feature3_g252150 , In_Season3_g252150 , In_Emissive3_g252150 , In_Grayscale3_g252150 , In_Luminosity3_g252150 , In_MultiMask3_g252150 , In_AlphaClip3_g252150 , In_AlphaFade3_g252150 , In_Translucency3_g252150 , In_Transmission3_g252150 , In_Thickness3_g252150 , In_Diffusion3_g252150 , In_Depth3_g252150 );
					TVEVisualData Data4_g252193 =(TVEVisualData)Data3_g252150;
					float Out_Dummy4_g252193 = 0.0;
					float3 Out_Albedo4_g252193 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g252193 = float3( 0,0,0 );
					float2 Out_NormalTS4_g252193 = float2( 0,0 );
					float3 Out_NormalWS4_g252193 = float3( 0,0,0 );
					float4 Out_Shader4_g252193 = float4( 0,0,0,0 );
					float4 Out_Feature4_g252193 = float4( 0,0,0,0 );
					float4 Out_Season4_g252193 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g252193 = float4( 0,0,0,0 );
					float Out_MultiMask4_g252193 = 0.0;
					float Out_Grayscale4_g252193 = 0.0;
					float Out_Luminosity4_g252193 = 0.0;
					float Out_AlphaClip4_g252193 = 0.0;
					float Out_AlphaFade4_g252193 = 0.0;
					float3 Out_Translucency4_g252193 = float3( 0,0,0 );
					float Out_Transmission4_g252193 = 0.0;
					float Out_Thickness4_g252193 = 0.0;
					float Out_Diffusion4_g252193 = 0.0;
					float Out_Depth4_g252193 = 0.0;
					BreakVisualData( Data4_g252193 , Out_Dummy4_g252193 , Out_Albedo4_g252193 , Out_AlbedoBase4_g252193 , Out_NormalTS4_g252193 , Out_NormalWS4_g252193 , Out_Shader4_g252193 , Out_Feature4_g252193 , Out_Season4_g252193 , Out_Emissive4_g252193 , Out_MultiMask4_g252193 , Out_Grayscale4_g252193 , Out_Luminosity4_g252193 , Out_AlphaClip4_g252193 , Out_AlphaFade4_g252193 , Out_Translucency4_g252193 , Out_Transmission4_g252193 , Out_Thickness4_g252193 , Out_Diffusion4_g252193 , Out_Depth4_g252193 );
					float Alpha109_g252188 = Out_AlphaClip4_g252193;
					float lerpResult91_g252188 = lerp( 1.0 , Alpha109_g252188 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g252188 = lerp( 1.0 , lerpResult91_g252188 , Filter152_g252188);
					clip( lerpResult154_g252188 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = temp_cast_1;
					half Metallic = 0;
					half Smoothness = temp_output_2587_114;
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

					o.Emission = ( lerpResult72_g252188 * lerpResult84_g252188 );
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

				uniform half TVE_DEBUG_Index;
				uniform half TVE_DEBUG_Clip;
				uniform half TVE_DEBUG_Min;
				uniform half TVE_DEBUG_Max;
				uniform half TVE_DEBUG_Shading;
				uniform half _IsTVEShader;
				uniform half TVE_DEBUG_Filter;
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

					TVEVertexData Data16_g251819 =(TVEVertexData)0;
					float In_Dummy16_g251819 = 0.0;
					TVEVertexData Data16_g251813 =(TVEVertexData)0;
					float In_Dummy16_g251813 = 0.0;
					float localIfModelDataByShader26_g251590 = ( 0.0 );
					TVEModelData Data26_g251590 = (TVEModelData)0;
					TVEModelData Data16_g251630 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g251612 = _ObjectCoordMode;
					#else
					float staticSwitch343_g251612 = _ObjectCoordMode;
					#endif
					half Dummy207_g251612 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g251612 );
					float temp_output_14_0_g251630 = Dummy207_g251612;
					float In_Dummy16_g251630 = temp_output_14_0_g251630;
					float3 PositionOS131_g251612 = v.vertex.xyz;
					float3 temp_output_4_0_g251630 = PositionOS131_g251612;
					float3 In_PositionOS16_g251630 = temp_output_4_0_g251630;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g251612 = ase_positionWS;
					float3 vertexToFrag73_g251612 = temp_output_104_7_g251612;
					float3 PositionWS122_g251612 = vertexToFrag73_g251612;
					float3 In_PositionWS16_g251630 = PositionWS122_g251612;
					float4x4 break19_g251615 = unity_ObjectToWorld;
					float3 appendResult20_g251615 = (float3(break19_g251615[ 0 ][ 3 ] , break19_g251615[ 1 ][ 3 ] , break19_g251615[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251612 = appendResult20_g251615;
					float4x4 break19_g251617 = unity_ObjectToWorld;
					float3 appendResult20_g251617 = (float3(break19_g251617[ 0 ][ 3 ] , break19_g251617[ 1 ][ 3 ] , break19_g251617[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g251613 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g251612 = PositionOS131_g251612;
					float3 appendResult234_g251612 = (float3(break233_g251612.x , 0.0 , break233_g251612.z));
					float3 break413_g251612 = PositionOS131_g251612;
					float3 appendResult414_g251612 = (float3(break413_g251612.x , break413_g251612.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251619 = appendResult414_g251612;
					#else
					float3 staticSwitch65_g251619 = appendResult234_g251612;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g251612 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g251612 = appendResult60_g251613;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g251612 = staticSwitch65_g251619;
					#else
					float3 staticSwitch229_g251612 = _Vector0;
					#endif
					float3 PivotOS149_g251612 = staticSwitch229_g251612;
					float3 temp_output_122_0_g251617 = PivotOS149_g251612;
					float3 PivotsOnlyWS105_g251617 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g251617 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g251612 = ( appendResult20_g251617 + PivotsOnlyWS105_g251617 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g251612 = temp_output_340_7_g251612;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g251612 = temp_output_341_7_g251612;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g251612 = temp_output_341_7_g251612;
					#else
					float3 staticSwitch236_g251612 = temp_output_340_7_g251612;
					#endif
					float3 vertexToFrag76_g251612 = staticSwitch236_g251612;
					float3 PivotWS121_g251612 = vertexToFrag76_g251612;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251612 = ( PositionWS122_g251612 - PivotWS121_g251612 );
					#else
					float3 staticSwitch204_g251612 = PositionWS122_g251612;
					#endif
					float3 PositionWO132_g251612 = ( staticSwitch204_g251612 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251630 = PositionWO132_g251612;
					float3 In_PivotOS16_g251630 = PivotOS149_g251612;
					float3 In_PivotWS16_g251630 = PivotWS121_g251612;
					float3 PivotWO133_g251612 = ( PivotWS121_g251612 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251630 = PivotWO133_g251612;
					half3 NormalOS134_g251612 = v.normal;
					float3 temp_output_21_0_g251630 = NormalOS134_g251612;
					float3 In_NormalOS16_g251630 = temp_output_21_0_g251630;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g251612 = normalizedWorldNormal;
					float3 In_NormalWS16_g251630 = NormalWS95_g251612;
					half4 TangentlOS153_g251612 = v.tangent;
					float4 temp_output_6_0_g251630 = TangentlOS153_g251612;
					float4 In_TangentOS16_g251630 = temp_output_6_0_g251630;
					float3 normalizeResult296_g251612 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251612 ) );
					half3 ViewDirWS169_g251612 = normalizeResult296_g251612;
					float3 In_ViewDirWS16_g251630 = ViewDirWS169_g251612;
					float4 appendResult397_g251612 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g251612 = appendResult397_g251612;
					float4 In_CoordsData16_g251630 = CoordsData398_g251612;
					half4 VertexMasks171_g251612 = v.ase_color;
					float4 In_VertexData16_g251630 = VertexMasks171_g251612;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251624 = (PositionOS131_g251612).z;
					#else
					float staticSwitch65_g251624 = (PositionOS131_g251612).y;
					#endif
					half Object_HeightValue267_g251612 = _ObjectHeightValue;
					half Bounds_HeightMask274_g251612 = saturate( ( staticSwitch65_g251624 / Object_HeightValue267_g251612 ) );
					half3 Position387_g251612 = PositionOS131_g251612;
					half Height387_g251612 = Object_HeightValue267_g251612;
					half Object_RadiusValue268_g251612 = _ObjectRadiusValue;
					half Radius387_g251612 = Object_RadiusValue268_g251612;
					half localCapsuleMaskYUp387_g251612 = CapsuleMaskYUp( Position387_g251612 , Height387_g251612 , Radius387_g251612 );
					half3 Position408_g251612 = PositionOS131_g251612;
					half Height408_g251612 = Object_HeightValue267_g251612;
					half Radius408_g251612 = Object_RadiusValue268_g251612;
					half localCapsuleMaskZUp408_g251612 = CapsuleMaskZUp( Position408_g251612 , Height408_g251612 , Radius408_g251612 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251629 = saturate( localCapsuleMaskZUp408_g251612 );
					#else
					float staticSwitch65_g251629 = saturate( localCapsuleMaskYUp387_g251612 );
					#endif
					half Bounds_SphereMask282_g251612 = staticSwitch65_g251629;
					float4 appendResult253_g251612 = (float4(Bounds_HeightMask274_g251612 , Bounds_SphereMask282_g251612 , 1.0 , 1.0));
					half4 MasksData254_g251612 = appendResult253_g251612;
					float4 In_MasksData16_g251630 = MasksData254_g251612;
					float temp_output_17_0_g251623 = _ObjectPhaseMode;
					float Option70_g251623 = temp_output_17_0_g251623;
					float4 temp_output_3_0_g251623 = v.ase_color;
					float4 Channel70_g251623 = temp_output_3_0_g251623;
					float localSwitchChannel470_g251623 = SwitchChannel4( Option70_g251623 , Channel70_g251623 );
					half Phase_Value372_g251612 = localSwitchChannel470_g251623;
					float3 break319_g251612 = PivotWO133_g251612;
					half Pivot_Position322_g251612 = ( break319_g251612.x + break319_g251612.z );
					half Phase_Position357_g251612 = ( Phase_Value372_g251612 + Pivot_Position322_g251612 );
					float temp_output_248_0_g251612 = frac( Phase_Position357_g251612 );
					float4 appendResult177_g251612 = (float4((frac( ( Phase_Position357_g251612 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g251612));
					half4 Phase_Data176_g251612 = appendResult177_g251612;
					float4 In_PhaseData16_g251630 = Phase_Data176_g251612;
					BuildModelVertData( Data16_g251630 , In_Dummy16_g251630 , In_PositionOS16_g251630 , In_PositionWS16_g251630 , In_PositionWO16_g251630 , In_PivotOS16_g251630 , In_PivotWS16_g251630 , In_PivotWO16_g251630 , In_NormalOS16_g251630 , In_NormalWS16_g251630 , In_TangentOS16_g251630 , In_ViewDirWS16_g251630 , In_CoordsData16_g251630 , In_VertexData16_g251630 , In_MasksData16_g251630 , In_PhaseData16_g251630 );
					TVEModelData DataDefault26_g251590 = Data16_g251630;
					TVEModelData DataGeneral26_g251590 = Data16_g251630;
					TVEModelData DataBlanket26_g251590 = Data16_g251630;
					TVEModelData DataImpostor26_g251590 = Data16_g251630;
					TVEModelData Data16_g251610 =(TVEModelData)0;
					half Dummy207_g251592 = 0.0;
					float temp_output_14_0_g251610 = Dummy207_g251592;
					float In_Dummy16_g251610 = temp_output_14_0_g251610;
					float3 PositionOS131_g251592 = v.vertex.xyz;
					float3 temp_output_4_0_g251610 = PositionOS131_g251592;
					float3 In_PositionOS16_g251610 = temp_output_4_0_g251610;
					float3 temp_output_104_7_g251592 = ase_positionWS;
					float3 PositionWS122_g251592 = temp_output_104_7_g251592;
					float3 In_PositionWS16_g251610 = PositionWS122_g251592;
					float4x4 break19_g251595 = unity_ObjectToWorld;
					float3 appendResult20_g251595 = (float3(break19_g251595[ 0 ][ 3 ] , break19_g251595[ 1 ][ 3 ] , break19_g251595[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251592 = appendResult20_g251595;
					float3 PivotWS121_g251592 = temp_output_340_7_g251592;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251592 = ( PositionWS122_g251592 - PivotWS121_g251592 );
					#else
					float3 staticSwitch204_g251592 = PositionWS122_g251592;
					#endif
					float3 PositionWO132_g251592 = ( staticSwitch204_g251592 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251610 = PositionWO132_g251592;
					float3 PivotOS149_g251592 = _Vector0;
					float3 In_PivotOS16_g251610 = PivotOS149_g251592;
					float3 In_PivotWS16_g251610 = PivotWS121_g251592;
					float3 PivotWO133_g251592 = ( PivotWS121_g251592 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251610 = PivotWO133_g251592;
					half3 NormalOS134_g251592 = v.normal;
					float3 temp_output_21_0_g251610 = NormalOS134_g251592;
					float3 In_NormalOS16_g251610 = temp_output_21_0_g251610;
					half3 NormalWS95_g251592 = normalizedWorldNormal;
					float3 In_NormalWS16_g251610 = NormalWS95_g251592;
					float4 appendResult462_g251592 = (float4(cross( v.normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g251592 = appendResult462_g251592;
					float4 temp_output_6_0_g251610 = TangentlOS153_g251592;
					float4 In_TangentOS16_g251610 = temp_output_6_0_g251610;
					float3 normalizeResult296_g251592 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251592 ) );
					half3 ViewDirWS169_g251592 = normalizeResult296_g251592;
					float3 In_ViewDirWS16_g251610 = ViewDirWS169_g251592;
					float4 appendResult397_g251592 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g251592 = appendResult397_g251592;
					float4 In_CoordsData16_g251610 = CoordsData398_g251592;
					half4 VertexMasks171_g251592 = float4( 0,0,0,0 );
					float4 In_VertexData16_g251610 = VertexMasks171_g251592;
					half4 MasksData254_g251592 = float4( 0,0,0,0 );
					float4 In_MasksData16_g251610 = MasksData254_g251592;
					half4 Phase_Data176_g251592 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g251610 = Phase_Data176_g251592;
					BuildModelVertData( Data16_g251610 , In_Dummy16_g251610 , In_PositionOS16_g251610 , In_PositionWS16_g251610 , In_PositionWO16_g251610 , In_PivotOS16_g251610 , In_PivotWS16_g251610 , In_PivotWO16_g251610 , In_NormalOS16_g251610 , In_NormalWS16_g251610 , In_TangentOS16_g251610 , In_ViewDirWS16_g251610 , In_CoordsData16_g251610 , In_VertexData16_g251610 , In_MasksData16_g251610 , In_PhaseData16_g251610 );
					TVEModelData DataTerrain26_g251590 = Data16_g251610;
					half IsShaderType2544 = _IsShaderType;
					float Type26_g251590 = IsShaderType2544;
					{
					if (Type26_g251590 == 0 )
					{
					Data26_g251590 = DataDefault26_g251590;
					}
					else if (Type26_g251590 == 1 )
					{
					Data26_g251590 = DataGeneral26_g251590;
					}
					else if (Type26_g251590 == 2 )
					{
					Data26_g251590 = DataBlanket26_g251590;
					}
					else if (Type26_g251590 == 3 )
					{
					Data26_g251590 = DataImpostor26_g251590;
					}
					else if (Type26_g251590 == 4 )
					{
					Data26_g251590 = DataTerrain26_g251590;
					}
					}
					TVEModelData Data15_g251814 =(TVEModelData)Data26_g251590;
					float Out_Dummy15_g251814 = 0.0;
					float3 Out_PositionOS15_g251814 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251814 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251814 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251814 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251814 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251814 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251814 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251814 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251814 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251814 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251814 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251814 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251814 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251814 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251814 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251814 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251814 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251814 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251814 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251814 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251814 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251814 , Out_Dummy15_g251814 , Out_PositionOS15_g251814 , Out_PositionWS15_g251814 , Out_PositionWO15_g251814 , Out_PositionRawOS15_g251814 , Out_PivotOS15_g251814 , Out_PivotWS15_g251814 , Out_PivotWO15_g251814 , Out_NormalOS15_g251814 , Out_NormalWS15_g251814 , Out_NormalRawOS15_g251814 , Out_TangentOS15_g251814 , Out_TangentWS15_g251814 , Out_BitangentWS15_g251814 , Out_ViewDirWS15_g251814 , Out_CoordsData15_g251814 , Out_VertexData15_g251814 , Out_MasksData15_g251814 , Out_PhaseData15_g251814 , Out_TransformData15_g251814 , Out_RotationData15_g251814 , Out_Interpolator15_g251814 );
					float3 In_PositionOS16_g251813 = Out_PositionOS15_g251814;
					float3 In_NormalOS16_g251813 = Out_NormalOS15_g251814;
					float4 In_TangentOS16_g251813 = Out_TangentOS15_g251814;
					float4 In_TransformData16_g251813 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251813 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251813 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251813 , In_Dummy16_g251813 , In_PositionOS16_g251813 , In_NormalOS16_g251813 , In_TangentOS16_g251813 , In_TransformData16_g251813 , In_RotationData16_g251813 , In_Interpolator16_g251813 );
					TVEVertexData Data15_g251817 =(TVEVertexData)Data16_g251813;
					float Out_Dummy15_g251817 = 0.0;
					float3 Out_PositionOS15_g251817 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251817 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251817 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251817 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251817 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251817 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251817 , Out_Dummy15_g251817 , Out_PositionOS15_g251817 , Out_NormalOS15_g251817 , Out_TangentOS15_g251817 , Out_TransformData15_g251817 , Out_RotationData15_g251817 , Out_Interpolator15_g251817 );
					TVEModelData Data15_g251818 =(TVEModelData)Data15_g251814;
					float Out_Dummy15_g251818 = 0.0;
					float3 Out_PositionOS15_g251818 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251818 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251818 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251818 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251818 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251818 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251818 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251818 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251818 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251818 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251818 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251818 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251818 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251818 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251818 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251818 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251818 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251818 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251818 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251818 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251818 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251818 , Out_Dummy15_g251818 , Out_PositionOS15_g251818 , Out_PositionWS15_g251818 , Out_PositionWO15_g251818 , Out_PositionRawOS15_g251818 , Out_PivotOS15_g251818 , Out_PivotWS15_g251818 , Out_PivotWO15_g251818 , Out_NormalOS15_g251818 , Out_NormalWS15_g251818 , Out_NormalRawOS15_g251818 , Out_TangentOS15_g251818 , Out_TangentWS15_g251818 , Out_BitangentWS15_g251818 , Out_ViewDirWS15_g251818 , Out_CoordsData15_g251818 , Out_VertexData15_g251818 , Out_MasksData15_g251818 , Out_PhaseData15_g251818 , Out_TransformData15_g251818 , Out_RotationData15_g251818 , Out_Interpolator15_g251818 );
					float3 In_PositionOS16_g251819 = ( Out_PositionOS15_g251817 - Out_PivotOS15_g251818 );
					float3 In_NormalOS16_g251819 = Out_NormalOS15_g251818;
					float4 In_TangentOS16_g251819 = Out_TangentOS15_g251818;
					float4 In_TransformData16_g251819 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251819 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251819 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251819 , In_Dummy16_g251819 , In_PositionOS16_g251819 , In_NormalOS16_g251819 , In_TangentOS16_g251819 , In_TransformData16_g251819 , In_RotationData16_g251819 , In_Interpolator16_g251819 );
					TVEVertexData Data15_g251930 =(TVEVertexData)Data16_g251819;
					float Out_Dummy15_g251930 = 0.0;
					float3 Out_PositionOS15_g251930 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251930 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251930 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251930 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251930 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251930 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251930 , Out_Dummy15_g251930 , Out_PositionOS15_g251930 , Out_NormalOS15_g251930 , Out_TangentOS15_g251930 , Out_TransformData15_g251930 , Out_RotationData15_g251930 , Out_Interpolator15_g251930 );
					TVEVertexData Data16_g251931 =(TVEVertexData)Data15_g251930;
					half Dummy317_g251922 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251931 = Dummy317_g251922;
					float3 In_PositionOS16_g251931 = Out_PositionOS15_g251930;
					float3 In_NormalOS16_g251931 = Out_NormalOS15_g251930;
					float4 In_TangentOS16_g251931 = Out_TangentOS15_g251930;
					half4 Model_TransformData356_g251922 = Out_TransformData15_g251930;
					float localBuildGlobalData204_g251489 = ( 0.0 );
					TVEGlobalData Data204_g251489 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251489 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251489 = Dummy211_g251489;
					float4 temp_output_203_0_g251508 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g251632 = ( 0.0 );
					TVEModelData Data26_g251632 = (TVEModelData)0;
					TVEModelData Data16_g251620 =(TVEModelData)0;
					float In_Dummy16_g251620 = 0.0;
					float3 In_PositionWS16_g251620 = PositionWS122_g251612;
					float3 In_PositionWO16_g251620 = PositionWO132_g251612;
					float3 In_PivotWS16_g251620 = PivotWS121_g251612;
					float3 In_PivotWO16_g251620 = PivotWO133_g251612;
					float3 In_NormalWS16_g251620 = NormalWS95_g251612;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g251612 = ase_tangentWS;
					float3 In_TangentWS16_g251620 = TangentWS136_g251612;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g251612 = ase_bitangentWS;
					float3 In_BitangentWS16_g251620 = BiangentWS421_g251612;
					half3 NormalWS427_g251612 = NormalWS95_g251612;
					half3 localComputeTriplanarMasks427_g251612 = ComputeTriplanarMasks( NormalWS427_g251612 );
					half3 TriplanarWeights429_g251612 = localComputeTriplanarMasks427_g251612;
					float3 In_TriplanarWeights16_g251620 = TriplanarWeights429_g251612;
					float3 In_ViewDirWS16_g251620 = ViewDirWS169_g251612;
					float4 In_CoordsData16_g251620 = CoordsData398_g251612;
					float4 In_VertexData16_g251620 = VertexMasks171_g251612;
					float4 In_Interpolator16_g251620 = Phase_Data176_g251612;
					BuildModelFragData( Data16_g251620 , In_Dummy16_g251620 , In_PositionWS16_g251620 , In_PositionWO16_g251620 , In_PivotWS16_g251620 , In_PivotWO16_g251620 , In_NormalWS16_g251620 , In_TangentWS16_g251620 , In_BitangentWS16_g251620 , In_TriplanarWeights16_g251620 , In_ViewDirWS16_g251620 , In_CoordsData16_g251620 , In_VertexData16_g251620 , In_Interpolator16_g251620 );
					TVEModelData DataDefault26_g251632 = Data16_g251620;
					TVEModelData DataGeneral26_g251632 = Data16_g251620;
					TVEModelData DataBlanket26_g251632 = Data16_g251620;
					TVEModelData DataImpostor26_g251632 = Data16_g251620;
					TVEModelData Data16_g251600 =(TVEModelData)0;
					float In_Dummy16_g251600 = 0.0;
					float3 In_PositionWS16_g251600 = PositionWS122_g251592;
					float3 In_PositionWO16_g251600 = PositionWO132_g251592;
					float3 In_PivotWS16_g251600 = PivotWS121_g251592;
					float3 In_PivotWO16_g251600 = PivotWO133_g251592;
					float3 In_NormalWS16_g251600 = NormalWS95_g251592;
					half3 TangentWS136_g251592 = ase_tangentWS;
					float3 In_TangentWS16_g251600 = TangentWS136_g251592;
					half3 BiangentWS421_g251592 = ase_bitangentWS;
					float3 In_BitangentWS16_g251600 = BiangentWS421_g251592;
					half3 NormalWS427_g251592 = NormalWS95_g251592;
					half3 localComputeTriplanarMasks427_g251592 = ComputeTriplanarMasks( NormalWS427_g251592 );
					half3 TriplanarWeights429_g251592 = localComputeTriplanarMasks427_g251592;
					float3 In_TriplanarWeights16_g251600 = TriplanarWeights429_g251592;
					float3 In_ViewDirWS16_g251600 = ViewDirWS169_g251592;
					float4 In_CoordsData16_g251600 = CoordsData398_g251592;
					float4 In_VertexData16_g251600 = VertexMasks171_g251592;
					float4 In_Interpolator16_g251600 = Phase_Data176_g251592;
					BuildModelFragData( Data16_g251600 , In_Dummy16_g251600 , In_PositionWS16_g251600 , In_PositionWO16_g251600 , In_PivotWS16_g251600 , In_PivotWO16_g251600 , In_NormalWS16_g251600 , In_TangentWS16_g251600 , In_BitangentWS16_g251600 , In_TriplanarWeights16_g251600 , In_ViewDirWS16_g251600 , In_CoordsData16_g251600 , In_VertexData16_g251600 , In_Interpolator16_g251600 );
					TVEModelData DataTerrain26_g251632 = Data16_g251600;
					float Type26_g251632 = IsShaderType2544;
					{
					if (Type26_g251632 == 0 )
					{
					Data26_g251632 = DataDefault26_g251632;
					}
					else if (Type26_g251632 == 1 )
					{
					Data26_g251632 = DataGeneral26_g251632;
					}
					else if (Type26_g251632 == 2 )
					{
					Data26_g251632 = DataBlanket26_g251632;
					}
					else if (Type26_g251632 == 3 )
					{
					Data26_g251632 = DataImpostor26_g251632;
					}
					else if (Type26_g251632 == 4 )
					{
					Data26_g251632 = DataTerrain26_g251632;
					}
					}
					TVEModelData Data15_g251579 =(TVEModelData)Data26_g251632;
					float Out_Dummy15_g251579 = 0.0;
					float3 Out_PositionWS15_g251579 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251579 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251579 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251579 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251579 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251579 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251579 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251579 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251579 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251579 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251579 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251579 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251579 , Out_Dummy15_g251579 , Out_PositionWS15_g251579 , Out_PositionWO15_g251579 , Out_PivotWS15_g251579 , Out_PivotWO15_g251579 , Out_NormalWS15_g251579 , Out_TangentWS15_g251579 , Out_BitangentWS15_g251579 , Out_TriplanarWeights15_g251579 , Out_ViewDirWS15_g251579 , Out_CoordsData15_g251579 , Out_VertexData15_g251579 , Out_Interpolator15_g251579 );
					float3 Model_PositionWS497_g251489 = Out_PositionWS15_g251579;
					float2 Model_PositionWS_XZ143_g251489 = (Model_PositionWS497_g251489).xz;
					float3 Model_PivotWS498_g251489 = Out_PivotWS15_g251579;
					float2 Model_PivotWS_XZ145_g251489 = (Model_PivotWS498_g251489).xz;
					float2 lerpResult300_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251508 = lerpResult300_g251489;
					float temp_output_82_0_g251506 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251508 = temp_output_82_0_g251506;
					float4 tex2DArrayNode83_g251508 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251508).zw + ( (temp_output_203_0_g251508).xy * temp_output_81_0_g251508 ) ),temp_output_82_0_g251508), 0.0 );
					float4 appendResult210_g251508 = (float4(tex2DArrayNode83_g251508.rgb , tex2DArrayNode83_g251508.a));
					float4 temp_output_204_0_g251508 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251508 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251508).zw + ( (temp_output_204_0_g251508).xy * temp_output_81_0_g251508 ) ),temp_output_82_0_g251508), 0.0 );
					float4 appendResult212_g251508 = (float4(tex2DArrayNode122_g251508.rgb , tex2DArrayNode122_g251508.a));
					float4 TVE_RenderNearPositionR628_g251489 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251489 = saturate( ( distance( Model_PositionWS497_g251489 , (TVE_RenderNearPositionR628_g251489).xyz ) / (TVE_RenderNearPositionR628_g251489).w ) );
					float temp_output_7_0_g251578 = 1.0;
					float temp_output_9_0_g251578 = ( temp_output_507_0_g251489 - temp_output_7_0_g251578 );
					half TVE_RenderNearFadeValue635_g251489 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251489 = saturate( ( temp_output_9_0_g251578 / ( ( TVE_RenderNearFadeValue635_g251489 - temp_output_7_0_g251578 ) + 0.0001 ) ) );
					float4 lerpResult131_g251508 = lerp( appendResult210_g251508 , appendResult212_g251508 , Global_TexBlend509_g251489);
					float4 temp_output_159_109_g251506 = lerpResult131_g251508;
					float4 lerpResult168_g251506 = lerp( TVE_CoatParams , temp_output_159_109_g251506 , TVE_CoatLayers[(int)temp_output_82_0_g251506]);
					float4 temp_output_589_109_g251489 = lerpResult168_g251506;
					half4 Coat_Texture302_g251489 = temp_output_589_109_g251489;
					float4 In_CoatTexture204_g251489 = Coat_Texture302_g251489;
					half4 Draw_Texture656_g251489 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g251489 = Draw_Texture656_g251489;
					float4 temp_output_203_0_g251533 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251533 = lerpResult85_g251489;
					float temp_output_82_0_g251530 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251533 = temp_output_82_0_g251530;
					float4 tex2DArrayNode83_g251533 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251533).zw + ( (temp_output_203_0_g251533).xy * temp_output_81_0_g251533 ) ),temp_output_82_0_g251533), 0.0 );
					float4 appendResult210_g251533 = (float4(tex2DArrayNode83_g251533.rgb , tex2DArrayNode83_g251533.a));
					float4 temp_output_204_0_g251533 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251533 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251533).zw + ( (temp_output_204_0_g251533).xy * temp_output_81_0_g251533 ) ),temp_output_82_0_g251533), 0.0 );
					float4 appendResult212_g251533 = (float4(tex2DArrayNode122_g251533.rgb , tex2DArrayNode122_g251533.a));
					float4 lerpResult131_g251533 = lerp( appendResult210_g251533 , appendResult212_g251533 , Global_TexBlend509_g251489);
					float4 temp_output_171_109_g251530 = lerpResult131_g251533;
					float4 lerpResult174_g251530 = lerp( TVE_PaintParams , temp_output_171_109_g251530 , TVE_PaintLayers[(int)temp_output_82_0_g251530]);
					float4 temp_output_595_109_g251489 = lerpResult174_g251530;
					half4 Paint_Texture71_g251489 = temp_output_595_109_g251489;
					float4 In_PaintTexture204_g251489 = Paint_Texture71_g251489;
					float4 temp_output_203_0_g251516 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251516 = lerpResult104_g251489;
					float temp_output_132_0_g251514 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251516 = temp_output_132_0_g251514;
					float4 tex2DArrayNode83_g251516 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251516).zw + ( (temp_output_203_0_g251516).xy * temp_output_81_0_g251516 ) ),temp_output_82_0_g251516), 0.0 );
					float4 appendResult210_g251516 = (float4(tex2DArrayNode83_g251516.rgb , tex2DArrayNode83_g251516.a));
					float4 temp_output_204_0_g251516 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251516 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251516).zw + ( (temp_output_204_0_g251516).xy * temp_output_81_0_g251516 ) ),temp_output_82_0_g251516), 0.0 );
					float4 appendResult212_g251516 = (float4(tex2DArrayNode122_g251516.rgb , tex2DArrayNode122_g251516.a));
					float4 lerpResult131_g251516 = lerp( appendResult210_g251516 , appendResult212_g251516 , Global_TexBlend509_g251489);
					float4 temp_output_137_109_g251514 = lerpResult131_g251516;
					float4 lerpResult145_g251514 = lerp( TVE_AtmoParams , temp_output_137_109_g251514 , TVE_AtmoLayers[(int)temp_output_132_0_g251514]);
					float4 temp_output_590_110_g251489 = lerpResult145_g251514;
					half4 Atmo_Texture80_g251489 = temp_output_590_110_g251489;
					float4 In_AtmoTexture204_g251489 = Atmo_Texture80_g251489;
					float4 temp_output_203_0_g251584 = TVE_EffexBaseCoord;
					float2 lerpResult414_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g251584 = lerpResult414_g251489;
					float temp_output_132_0_g251582 = _GlobalEffexLayerValue;
					float temp_output_82_0_g251584 = temp_output_132_0_g251582;
					float4 tex2DArrayNode83_g251584 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251584).zw + ( (temp_output_203_0_g251584).xy * temp_output_81_0_g251584 ) ),temp_output_82_0_g251584), 0.0 );
					float4 appendResult210_g251584 = (float4(tex2DArrayNode83_g251584.rgb , tex2DArrayNode83_g251584.a));
					float4 temp_output_204_0_g251584 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g251584 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251584).zw + ( (temp_output_204_0_g251584).xy * temp_output_81_0_g251584 ) ),temp_output_82_0_g251584), 0.0 );
					float4 appendResult212_g251584 = (float4(tex2DArrayNode122_g251584.rgb , tex2DArrayNode122_g251584.a));
					float4 lerpResult131_g251584 = lerp( appendResult210_g251584 , appendResult212_g251584 , Global_TexBlend509_g251489);
					float4 temp_output_137_109_g251582 = lerpResult131_g251584;
					float4 lerpResult145_g251582 = lerp( TVE_EffexParams , temp_output_137_109_g251582 , TVE_EffexLayers[(int)temp_output_132_0_g251582]);
					float4 temp_output_731_110_g251489 = lerpResult145_g251582;
					half4 Effex_Texture420_g251489 = temp_output_731_110_g251489;
					float4 In_EffexTexture204_g251489 = Effex_Texture420_g251489;
					float4 temp_output_203_0_g251564 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251564 = lerpResult247_g251489;
					float temp_output_82_0_g251562 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251564 = temp_output_82_0_g251562;
					float4 tex2DArrayNode83_g251564 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251564).zw + ( (temp_output_203_0_g251564).xy * temp_output_81_0_g251564 ) ),temp_output_82_0_g251564), 0.0 );
					float4 appendResult210_g251564 = (float4(tex2DArrayNode83_g251564.rgb , tex2DArrayNode83_g251564.a));
					float4 temp_output_204_0_g251564 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251564 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251564).zw + ( (temp_output_204_0_g251564).xy * temp_output_81_0_g251564 ) ),temp_output_82_0_g251564), 0.0 );
					float4 appendResult212_g251564 = (float4(tex2DArrayNode122_g251564.rgb , tex2DArrayNode122_g251564.a));
					float4 lerpResult131_g251564 = lerp( appendResult210_g251564 , appendResult212_g251564 , Global_TexBlend509_g251489);
					float4 temp_output_159_109_g251562 = lerpResult131_g251564;
					float4 lerpResult167_g251562 = lerp( TVE_GlowParams , temp_output_159_109_g251562 , TVE_GlowLayers[(int)temp_output_82_0_g251562]);
					float4 temp_output_593_109_g251489 = lerpResult167_g251562;
					half4 Glow_Texture248_g251489 = temp_output_593_109_g251489;
					float4 In_GlowTexture204_g251489 = Glow_Texture248_g251489;
					float4 temp_output_203_0_g251500 = TVE_FormBaseCoord;
					float2 lerpResult168_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251500 = lerpResult168_g251489;
					float temp_output_130_0_g251498 = _GlobalFormLayerValue;
					float temp_output_82_0_g251500 = temp_output_130_0_g251498;
					float4 tex2DArrayNode83_g251500 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251500).zw + ( (temp_output_203_0_g251500).xy * temp_output_81_0_g251500 ) ),temp_output_82_0_g251500), 0.0 );
					float4 appendResult210_g251500 = (float4(tex2DArrayNode83_g251500.rgb , tex2DArrayNode83_g251500.a));
					float4 temp_output_204_0_g251500 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251500 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251500).zw + ( (temp_output_204_0_g251500).xy * temp_output_81_0_g251500 ) ),temp_output_82_0_g251500), 0.0 );
					float4 appendResult212_g251500 = (float4(tex2DArrayNode122_g251500.rgb , tex2DArrayNode122_g251500.a));
					float4 lerpResult131_g251500 = lerp( appendResult210_g251500 , appendResult212_g251500 , Global_TexBlend509_g251489);
					float4 temp_output_135_109_g251498 = lerpResult131_g251500;
					float4 lerpResult143_g251498 = lerp( TVE_FormParams , temp_output_135_109_g251498 , TVE_FormLayers[(int)temp_output_130_0_g251498]);
					float4 temp_output_592_0_g251489 = lerpResult143_g251498;
					float4 Form_Texture112_g251489 = temp_output_592_0_g251489;
					float4 In_FormTexture204_g251489 = Form_Texture112_g251489;
					float4 In_LandTexture204_g251489 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g251548 = TVE_VertxBaseCoord;
					float2 lerpResult681_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g251548 = lerpResult681_g251489;
					float temp_output_136_0_g251546 = _GlobalVertxLayerValue;
					float temp_output_82_0_g251548 = temp_output_136_0_g251546;
					float4 tex2DArrayNode83_g251548 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251548).zw + ( (temp_output_203_0_g251548).xy * temp_output_81_0_g251548 ) ),temp_output_82_0_g251548), 0.0 );
					float4 appendResult210_g251548 = (float4(tex2DArrayNode83_g251548.rgb , tex2DArrayNode83_g251548.a));
					float4 temp_output_204_0_g251548 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g251548 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251548).zw + ( (temp_output_204_0_g251548).xy * temp_output_81_0_g251548 ) ),temp_output_82_0_g251548), 0.0 );
					float4 appendResult212_g251548 = (float4(tex2DArrayNode122_g251548.rgb , tex2DArrayNode122_g251548.a));
					float4 lerpResult131_g251548 = lerp( appendResult210_g251548 , appendResult212_g251548 , Global_TexBlend509_g251489);
					float4 temp_output_141_109_g251546 = lerpResult131_g251548;
					float4 lerpResult149_g251546 = lerp( TVE_VertxParams , temp_output_141_109_g251546 , TVE_VertxLayers[(int)temp_output_136_0_g251546]);
					float4 temp_output_695_0_g251489 = lerpResult149_g251546;
					half4 Vertx_Texture693_g251489 = temp_output_695_0_g251489;
					float4 In_VertxTexture204_g251489 = Vertx_Texture693_g251489;
					float4 temp_output_203_0_g251524 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251524 = lerpResult400_g251489;
					float temp_output_136_0_g251522 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251524 = temp_output_136_0_g251522;
					float4 tex2DArrayNode83_g251524 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251524).zw + ( (temp_output_203_0_g251524).xy * temp_output_81_0_g251524 ) ),temp_output_82_0_g251524), 0.0 );
					float4 appendResult210_g251524 = (float4(tex2DArrayNode83_g251524.rgb , tex2DArrayNode83_g251524.a));
					float4 temp_output_204_0_g251524 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251524 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251524).zw + ( (temp_output_204_0_g251524).xy * temp_output_81_0_g251524 ) ),temp_output_82_0_g251524), 0.0 );
					float4 appendResult212_g251524 = (float4(tex2DArrayNode122_g251524.rgb , tex2DArrayNode122_g251524.a));
					float4 lerpResult131_g251524 = lerp( appendResult210_g251524 , appendResult212_g251524 , Global_TexBlend509_g251489);
					float4 temp_output_141_109_g251522 = lerpResult131_g251524;
					float4 lerpResult149_g251522 = lerp( TVE_FlowParams , temp_output_141_109_g251522 , TVE_FlowLayers[(int)temp_output_136_0_g251522]);
					float4 temp_output_594_0_g251489 = lerpResult149_g251522;
					half4 Flow_Texture405_g251489 = temp_output_594_0_g251489;
					float4 In_FlowTexture204_g251489 = Flow_Texture405_g251489;
					half4 User_Texture677_g251489 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g251489 = User_Texture677_g251489;
					BuildGlobalData( Data204_g251489 , In_Dummy204_g251489 , In_CoatTexture204_g251489 , In_DrawTexture204_g251489 , In_PaintTexture204_g251489 , In_AtmoTexture204_g251489 , In_EffexTexture204_g251489 , In_GlowTexture204_g251489 , In_FormTexture204_g251489 , In_LandTexture204_g251489 , In_VertxTexture204_g251489 , In_FlowTexture204_g251489 , In_UserTexture204_g251489 );
					TVEGlobalData Data15_g251932 =(TVEGlobalData)Data204_g251489;
					float Out_Dummy15_g251932 = 0.0;
					float4 Out_CoatTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251932 = float4( 0,0,0,0 );
					BreakData( Data15_g251932 , Out_Dummy15_g251932 , Out_CoatTexture15_g251932 , Out_DrawTexture15_g251932 , Out_PaintTexture15_g251932 , Out_AtmoTexture15_g251932 , Out_EffexTexture15_g251932 , Out_GlowTexture15_g251932 , Out_FormTexture15_g251932 , Out_LandTexture15_g251932 , Out_VertxTexture15_g251932 , Out_FlowTexture15_g251932 , Out_UserTexture15_g251932 );
					float4 Global_FormTexture351_g251922 = Out_FormTexture15_g251932;
					TVEModelData Data15_g251929 =(TVEModelData)Data15_g251818;
					float Out_Dummy15_g251929 = 0.0;
					float3 Out_PositionOS15_g251929 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251929 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251929 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251929 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251929 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251929 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251929 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251929 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251929 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251929 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251929 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251929 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251929 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251929 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251929 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251929 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251929 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251929 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251929 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251929 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251929 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251929 , Out_Dummy15_g251929 , Out_PositionOS15_g251929 , Out_PositionWS15_g251929 , Out_PositionWO15_g251929 , Out_PositionRawOS15_g251929 , Out_PivotOS15_g251929 , Out_PivotWS15_g251929 , Out_PivotWO15_g251929 , Out_NormalOS15_g251929 , Out_NormalWS15_g251929 , Out_NormalRawOS15_g251929 , Out_TangentOS15_g251929 , Out_TangentWS15_g251929 , Out_BitangentWS15_g251929 , Out_ViewDirWS15_g251929 , Out_CoordsData15_g251929 , Out_VertexData15_g251929 , Out_MasksData15_g251929 , Out_PhaseData15_g251929 , Out_TransformData15_g251929 , Out_RotationData15_g251929 , Out_Interpolator15_g251929 );
					float3 Model_PivotWO353_g251922 = Out_PivotWO15_g251929;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251928 = _ConformMeshMode;
					float Option70_g251928 = temp_output_17_0_g251928;
					half4 Model_VertexData357_g251922 = Out_VertexData15_g251929;
					float4 temp_output_3_0_g251928 = Model_VertexData357_g251922;
					float4 Channel70_g251928 = temp_output_3_0_g251928;
					float localSwitchChannel470_g251928 = SwitchChannel4( Option70_g251928 , Channel70_g251928 );
					float temp_output_390_0_g251922 = localSwitchChannel470_g251928;
					float temp_output_7_0_g251925 = _ConformMeshRemap.x;
					float temp_output_9_0_g251925 = ( temp_output_390_0_g251922 - temp_output_7_0_g251925 );
					float lerpResult374_g251922 = lerp( 1.0 , saturate( ( temp_output_9_0_g251925 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251922 = lerpResult374_g251922;
					float temp_output_328_0_g251922 = ( Blend_VertMask379_g251922 * TVE_IsEnabled );
					half Conform_Mask366_g251922 = temp_output_328_0_g251922;
					float temp_output_322_0_g251922 = ( ( ( ( (Global_FormTexture351_g251922).z - ( (Model_PivotWO353_g251922).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251922 ) );
					float3 appendResult329_g251922 = (float3(0.0 , temp_output_322_0_g251922 , 0.0));
					float3 appendResult387_g251922 = (float3(0.0 , 0.0 , temp_output_322_0_g251922));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251926 = appendResult387_g251922;
					#else
					float3 staticSwitch65_g251926 = appendResult329_g251922;
					#endif
					float3 Blanket_Conform368_g251922 = staticSwitch65_g251926;
					float4 appendResult312_g251922 = (float4(Blanket_Conform368_g251922 , 0.0));
					float4 temp_output_310_0_g251922 = ( Model_TransformData356_g251922 + appendResult312_g251922 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251922 = temp_output_310_0_g251922;
					#else
					float4 staticSwitch364_g251922 = Model_TransformData356_g251922;
					#endif
					half4 Final_TransformData365_g251922 = staticSwitch364_g251922;
					float4 In_TransformData16_g251931 = Final_TransformData365_g251922;
					float4 In_RotationData16_g251931 = Out_RotationData15_g251930;
					float4 In_Interpolator16_g251931 = Out_Interpolator15_g251930;
					BuildVertexData( Data16_g251931 , In_Dummy16_g251931 , In_PositionOS16_g251931 , In_NormalOS16_g251931 , In_TangentOS16_g251931 , In_TransformData16_g251931 , In_RotationData16_g251931 , In_Interpolator16_g251931 );
					TVEVertexData Data15_g251943 =(TVEVertexData)Data16_g251931;
					float Out_Dummy15_g251943 = 0.0;
					float3 Out_PositionOS15_g251943 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251943 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251943 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251943 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251943 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251943 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251943 , Out_Dummy15_g251943 , Out_PositionOS15_g251943 , Out_NormalOS15_g251943 , Out_TangentOS15_g251943 , Out_TransformData15_g251943 , Out_RotationData15_g251943 , Out_Interpolator15_g251943 );
					TVEVertexData Data16_g251944 =(TVEVertexData)Data15_g251943;
					float In_Dummy16_g251944 = 0.0;
					float3 Vertex_PositionOS147_g251934 = Out_PositionOS15_g251943;
					half3 VertexPos40_g251938 = Vertex_PositionOS147_g251934;
					float4 temp_output_1615_33_g251934 = Out_RotationData15_g251943;
					half4 Vertex_RotationData1569_g251934 = temp_output_1615_33_g251934;
					float2 break1582_g251934 = (Vertex_RotationData1569_g251934).xy;
					half Angle44_g251938 = break1582_g251934.y;
					half CosAngle89_g251938 = cos( Angle44_g251938 );
					half SinAngle93_g251938 = sin( Angle44_g251938 );
					float3 appendResult95_g251938 = (float3((VertexPos40_g251938).x , ( ( (VertexPos40_g251938).y * CosAngle89_g251938 ) - ( (VertexPos40_g251938).z * SinAngle93_g251938 ) ) , ( ( (VertexPos40_g251938).y * SinAngle93_g251938 ) + ( (VertexPos40_g251938).z * CosAngle89_g251938 ) )));
					half3 VertexPos40_g251939 = appendResult95_g251938;
					half Angle44_g251939 = -break1582_g251934.x;
					half CosAngle94_g251939 = cos( Angle44_g251939 );
					half SinAngle95_g251939 = sin( Angle44_g251939 );
					float3 appendResult98_g251939 = (float3(( ( (VertexPos40_g251939).x * CosAngle94_g251939 ) - ( (VertexPos40_g251939).y * SinAngle95_g251939 ) ) , ( ( (VertexPos40_g251939).x * SinAngle95_g251939 ) + ( (VertexPos40_g251939).y * CosAngle94_g251939 ) ) , (VertexPos40_g251939).z));
					half3 VertexPos40_g251937 = Vertex_PositionOS147_g251934;
					half Angle44_g251937 = break1582_g251934.y;
					half CosAngle89_g251937 = cos( Angle44_g251937 );
					half SinAngle93_g251937 = sin( Angle44_g251937 );
					float3 appendResult95_g251937 = (float3((VertexPos40_g251937).x , ( ( (VertexPos40_g251937).y * CosAngle89_g251937 ) - ( (VertexPos40_g251937).z * SinAngle93_g251937 ) ) , ( ( (VertexPos40_g251937).y * SinAngle93_g251937 ) + ( (VertexPos40_g251937).z * CosAngle89_g251937 ) )));
					half3 VertexPos40_g251942 = appendResult95_g251937;
					half Angle44_g251942 = break1582_g251934.x;
					half CosAngle91_g251942 = cos( Angle44_g251942 );
					half SinAngle92_g251942 = sin( Angle44_g251942 );
					float3 appendResult93_g251942 = (float3(( ( (VertexPos40_g251942).x * CosAngle91_g251942 ) + ( (VertexPos40_g251942).z * SinAngle92_g251942 ) ) , (VertexPos40_g251942).y , ( ( -(VertexPos40_g251942).x * SinAngle92_g251942 ) + ( (VertexPos40_g251942).z * CosAngle91_g251942 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251940 = appendResult93_g251942;
					#else
					float3 staticSwitch65_g251940 = appendResult98_g251939;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251935 = staticSwitch65_g251940;
					#else
					float3 staticSwitch65_g251935 = Vertex_PositionOS147_g251934;
					#endif
					float3 temp_output_1608_0_g251934 = staticSwitch65_g251935;
					half3 VertexPos40_g251941 = temp_output_1608_0_g251934;
					half Angle44_g251941 = (Vertex_RotationData1569_g251934).z;
					half CosAngle91_g251941 = cos( Angle44_g251941 );
					half SinAngle92_g251941 = sin( Angle44_g251941 );
					float3 appendResult93_g251941 = (float3(( ( (VertexPos40_g251941).x * CosAngle91_g251941 ) + ( (VertexPos40_g251941).z * SinAngle92_g251941 ) ) , (VertexPos40_g251941).y , ( ( -(VertexPos40_g251941).x * SinAngle92_g251941 ) + ( (VertexPos40_g251941).z * CosAngle91_g251941 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251936 = appendResult93_g251941;
					#else
					float3 staticSwitch65_g251936 = temp_output_1608_0_g251934;
					#endif
					float4 temp_output_1615_31_g251934 = Out_TransformData15_g251943;
					half4 Vertex_TransformData1568_g251934 = temp_output_1615_31_g251934;
					half3 Final_PositionOS178_g251934 = ( ( staticSwitch65_g251936 * (Vertex_TransformData1568_g251934).w ) + (Vertex_TransformData1568_g251934).xyz );
					float3 In_PositionOS16_g251944 = Final_PositionOS178_g251934;
					float3 In_NormalOS16_g251944 = Out_NormalOS15_g251943;
					float4 In_TangentOS16_g251944 = Out_TangentOS15_g251943;
					float4 In_TransformData16_g251944 = temp_output_1615_31_g251934;
					float4 In_RotationData16_g251944 = temp_output_1615_33_g251934;
					float4 In_Interpolator16_g251944 = Out_Interpolator15_g251943;
					BuildVertexData( Data16_g251944 , In_Dummy16_g251944 , In_PositionOS16_g251944 , In_NormalOS16_g251944 , In_TangentOS16_g251944 , In_TransformData16_g251944 , In_RotationData16_g251944 , In_Interpolator16_g251944 );
					TVEVertexData Data15_g252048 =(TVEVertexData)Data16_g251944;
					float Out_Dummy15_g252048 = 0.0;
					float3 Out_PositionOS15_g252048 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252048 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252048 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252048 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252048 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252048 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252048 , Out_Dummy15_g252048 , Out_PositionOS15_g252048 , Out_NormalOS15_g252048 , Out_TangentOS15_g252048 , Out_TransformData15_g252048 , Out_RotationData15_g252048 , Out_Interpolator15_g252048 );
					TVEVertexData Data16_g252049 =(TVEVertexData)Data15_g252048;
					float In_Dummy16_g252049 = 0.0;
					TVEModelData Data15_g252047 =(TVEModelData)Data15_g251929;
					float Out_Dummy15_g252047 = 0.0;
					float3 Out_PositionOS15_g252047 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252047 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252047 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252047 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252047 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252047 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252047 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252047 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252047 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252047 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252047 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252047 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252047 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252047 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252047 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252047 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252047 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252047 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252047 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252047 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252047 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252047 , Out_Dummy15_g252047 , Out_PositionOS15_g252047 , Out_PositionWS15_g252047 , Out_PositionWO15_g252047 , Out_PositionRawOS15_g252047 , Out_PivotOS15_g252047 , Out_PivotWS15_g252047 , Out_PivotWO15_g252047 , Out_NormalOS15_g252047 , Out_NormalWS15_g252047 , Out_NormalRawOS15_g252047 , Out_TangentOS15_g252047 , Out_TangentWS15_g252047 , Out_BitangentWS15_g252047 , Out_ViewDirWS15_g252047 , Out_CoordsData15_g252047 , Out_VertexData15_g252047 , Out_MasksData15_g252047 , Out_PhaseData15_g252047 , Out_TransformData15_g252047 , Out_RotationData15_g252047 , Out_Interpolator15_g252047 );
					float3 In_PositionOS16_g252049 = ( Out_PositionOS15_g252048 + Out_PivotOS15_g252047 );
					float3 In_NormalOS16_g252049 = Out_NormalOS15_g252048;
					float4 In_TangentOS16_g252049 = Out_TangentOS15_g252048;
					float4 In_TransformData16_g252049 = Out_TransformData15_g252048;
					float4 In_RotationData16_g252049 = Out_RotationData15_g252048;
					float4 In_Interpolator16_g252049 = Out_Interpolator15_g252048;
					BuildVertexData( Data16_g252049 , In_Dummy16_g252049 , In_PositionOS16_g252049 , In_NormalOS16_g252049 , In_TangentOS16_g252049 , In_TransformData16_g252049 , In_RotationData16_g252049 , In_Interpolator16_g252049 );
					TVEVertexData Data15_g252196 =(TVEVertexData)Data16_g252049;
					float Out_Dummy15_g252196 = 0.0;
					float3 Out_PositionOS15_g252196 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252196 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252196 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252196 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252196 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252196 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252196 , Out_Dummy15_g252196 , Out_PositionOS15_g252196 , Out_NormalOS15_g252196 , Out_TangentOS15_g252196 , Out_TransformData15_g252196 , Out_RotationData15_g252196 , Out_Interpolator15_g252196 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g252196;
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

				uniform half TVE_DEBUG_Index;
				uniform half TVE_DEBUG_Clip;
				uniform half TVE_DEBUG_Min;
				uniform half TVE_DEBUG_Max;
				uniform half TVE_DEBUG_Shading;
				uniform half _IsTVEShader;
				uniform half TVE_DEBUG_Filter;
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

					TVEVertexData Data16_g251819 =(TVEVertexData)0;
					float In_Dummy16_g251819 = 0.0;
					TVEVertexData Data16_g251813 =(TVEVertexData)0;
					float In_Dummy16_g251813 = 0.0;
					float localIfModelDataByShader26_g251590 = ( 0.0 );
					TVEModelData Data26_g251590 = (TVEModelData)0;
					TVEModelData Data16_g251630 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g251612 = _ObjectCoordMode;
					#else
					float staticSwitch343_g251612 = _ObjectCoordMode;
					#endif
					half Dummy207_g251612 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g251612 );
					float temp_output_14_0_g251630 = Dummy207_g251612;
					float In_Dummy16_g251630 = temp_output_14_0_g251630;
					float3 PositionOS131_g251612 = v.vertex.xyz;
					float3 temp_output_4_0_g251630 = PositionOS131_g251612;
					float3 In_PositionOS16_g251630 = temp_output_4_0_g251630;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g251612 = ase_positionWS;
					float3 vertexToFrag73_g251612 = temp_output_104_7_g251612;
					float3 PositionWS122_g251612 = vertexToFrag73_g251612;
					float3 In_PositionWS16_g251630 = PositionWS122_g251612;
					float4x4 break19_g251615 = unity_ObjectToWorld;
					float3 appendResult20_g251615 = (float3(break19_g251615[ 0 ][ 3 ] , break19_g251615[ 1 ][ 3 ] , break19_g251615[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251612 = appendResult20_g251615;
					float4x4 break19_g251617 = unity_ObjectToWorld;
					float3 appendResult20_g251617 = (float3(break19_g251617[ 0 ][ 3 ] , break19_g251617[ 1 ][ 3 ] , break19_g251617[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g251613 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g251612 = PositionOS131_g251612;
					float3 appendResult234_g251612 = (float3(break233_g251612.x , 0.0 , break233_g251612.z));
					float3 break413_g251612 = PositionOS131_g251612;
					float3 appendResult414_g251612 = (float3(break413_g251612.x , break413_g251612.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251619 = appendResult414_g251612;
					#else
					float3 staticSwitch65_g251619 = appendResult234_g251612;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g251612 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g251612 = appendResult60_g251613;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g251612 = staticSwitch65_g251619;
					#else
					float3 staticSwitch229_g251612 = _Vector0;
					#endif
					float3 PivotOS149_g251612 = staticSwitch229_g251612;
					float3 temp_output_122_0_g251617 = PivotOS149_g251612;
					float3 PivotsOnlyWS105_g251617 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g251617 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g251612 = ( appendResult20_g251617 + PivotsOnlyWS105_g251617 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g251612 = temp_output_340_7_g251612;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g251612 = temp_output_341_7_g251612;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g251612 = temp_output_341_7_g251612;
					#else
					float3 staticSwitch236_g251612 = temp_output_340_7_g251612;
					#endif
					float3 vertexToFrag76_g251612 = staticSwitch236_g251612;
					float3 PivotWS121_g251612 = vertexToFrag76_g251612;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251612 = ( PositionWS122_g251612 - PivotWS121_g251612 );
					#else
					float3 staticSwitch204_g251612 = PositionWS122_g251612;
					#endif
					float3 PositionWO132_g251612 = ( staticSwitch204_g251612 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251630 = PositionWO132_g251612;
					float3 In_PivotOS16_g251630 = PivotOS149_g251612;
					float3 In_PivotWS16_g251630 = PivotWS121_g251612;
					float3 PivotWO133_g251612 = ( PivotWS121_g251612 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251630 = PivotWO133_g251612;
					half3 NormalOS134_g251612 = v.normal;
					float3 temp_output_21_0_g251630 = NormalOS134_g251612;
					float3 In_NormalOS16_g251630 = temp_output_21_0_g251630;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g251612 = normalizedWorldNormal;
					float3 In_NormalWS16_g251630 = NormalWS95_g251612;
					half4 TangentlOS153_g251612 = v.tangent;
					float4 temp_output_6_0_g251630 = TangentlOS153_g251612;
					float4 In_TangentOS16_g251630 = temp_output_6_0_g251630;
					float3 normalizeResult296_g251612 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251612 ) );
					half3 ViewDirWS169_g251612 = normalizeResult296_g251612;
					float3 In_ViewDirWS16_g251630 = ViewDirWS169_g251612;
					float4 appendResult397_g251612 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g251612 = appendResult397_g251612;
					float4 In_CoordsData16_g251630 = CoordsData398_g251612;
					half4 VertexMasks171_g251612 = v.ase_color;
					float4 In_VertexData16_g251630 = VertexMasks171_g251612;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251624 = (PositionOS131_g251612).z;
					#else
					float staticSwitch65_g251624 = (PositionOS131_g251612).y;
					#endif
					half Object_HeightValue267_g251612 = _ObjectHeightValue;
					half Bounds_HeightMask274_g251612 = saturate( ( staticSwitch65_g251624 / Object_HeightValue267_g251612 ) );
					half3 Position387_g251612 = PositionOS131_g251612;
					half Height387_g251612 = Object_HeightValue267_g251612;
					half Object_RadiusValue268_g251612 = _ObjectRadiusValue;
					half Radius387_g251612 = Object_RadiusValue268_g251612;
					half localCapsuleMaskYUp387_g251612 = CapsuleMaskYUp( Position387_g251612 , Height387_g251612 , Radius387_g251612 );
					half3 Position408_g251612 = PositionOS131_g251612;
					half Height408_g251612 = Object_HeightValue267_g251612;
					half Radius408_g251612 = Object_RadiusValue268_g251612;
					half localCapsuleMaskZUp408_g251612 = CapsuleMaskZUp( Position408_g251612 , Height408_g251612 , Radius408_g251612 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g251629 = saturate( localCapsuleMaskZUp408_g251612 );
					#else
					float staticSwitch65_g251629 = saturate( localCapsuleMaskYUp387_g251612 );
					#endif
					half Bounds_SphereMask282_g251612 = staticSwitch65_g251629;
					float4 appendResult253_g251612 = (float4(Bounds_HeightMask274_g251612 , Bounds_SphereMask282_g251612 , 1.0 , 1.0));
					half4 MasksData254_g251612 = appendResult253_g251612;
					float4 In_MasksData16_g251630 = MasksData254_g251612;
					float temp_output_17_0_g251623 = _ObjectPhaseMode;
					float Option70_g251623 = temp_output_17_0_g251623;
					float4 temp_output_3_0_g251623 = v.ase_color;
					float4 Channel70_g251623 = temp_output_3_0_g251623;
					float localSwitchChannel470_g251623 = SwitchChannel4( Option70_g251623 , Channel70_g251623 );
					half Phase_Value372_g251612 = localSwitchChannel470_g251623;
					float3 break319_g251612 = PivotWO133_g251612;
					half Pivot_Position322_g251612 = ( break319_g251612.x + break319_g251612.z );
					half Phase_Position357_g251612 = ( Phase_Value372_g251612 + Pivot_Position322_g251612 );
					float temp_output_248_0_g251612 = frac( Phase_Position357_g251612 );
					float4 appendResult177_g251612 = (float4((frac( ( Phase_Position357_g251612 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g251612));
					half4 Phase_Data176_g251612 = appendResult177_g251612;
					float4 In_PhaseData16_g251630 = Phase_Data176_g251612;
					BuildModelVertData( Data16_g251630 , In_Dummy16_g251630 , In_PositionOS16_g251630 , In_PositionWS16_g251630 , In_PositionWO16_g251630 , In_PivotOS16_g251630 , In_PivotWS16_g251630 , In_PivotWO16_g251630 , In_NormalOS16_g251630 , In_NormalWS16_g251630 , In_TangentOS16_g251630 , In_ViewDirWS16_g251630 , In_CoordsData16_g251630 , In_VertexData16_g251630 , In_MasksData16_g251630 , In_PhaseData16_g251630 );
					TVEModelData DataDefault26_g251590 = Data16_g251630;
					TVEModelData DataGeneral26_g251590 = Data16_g251630;
					TVEModelData DataBlanket26_g251590 = Data16_g251630;
					TVEModelData DataImpostor26_g251590 = Data16_g251630;
					TVEModelData Data16_g251610 =(TVEModelData)0;
					half Dummy207_g251592 = 0.0;
					float temp_output_14_0_g251610 = Dummy207_g251592;
					float In_Dummy16_g251610 = temp_output_14_0_g251610;
					float3 PositionOS131_g251592 = v.vertex.xyz;
					float3 temp_output_4_0_g251610 = PositionOS131_g251592;
					float3 In_PositionOS16_g251610 = temp_output_4_0_g251610;
					float3 temp_output_104_7_g251592 = ase_positionWS;
					float3 PositionWS122_g251592 = temp_output_104_7_g251592;
					float3 In_PositionWS16_g251610 = PositionWS122_g251592;
					float4x4 break19_g251595 = unity_ObjectToWorld;
					float3 appendResult20_g251595 = (float3(break19_g251595[ 0 ][ 3 ] , break19_g251595[ 1 ][ 3 ] , break19_g251595[ 2 ][ 3 ]));
					float3 temp_output_340_7_g251592 = appendResult20_g251595;
					float3 PivotWS121_g251592 = temp_output_340_7_g251592;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g251592 = ( PositionWS122_g251592 - PivotWS121_g251592 );
					#else
					float3 staticSwitch204_g251592 = PositionWS122_g251592;
					#endif
					float3 PositionWO132_g251592 = ( staticSwitch204_g251592 - TVE_WorldOrigin );
					float3 In_PositionWO16_g251610 = PositionWO132_g251592;
					float3 PivotOS149_g251592 = _Vector0;
					float3 In_PivotOS16_g251610 = PivotOS149_g251592;
					float3 In_PivotWS16_g251610 = PivotWS121_g251592;
					float3 PivotWO133_g251592 = ( PivotWS121_g251592 - TVE_WorldOrigin );
					float3 In_PivotWO16_g251610 = PivotWO133_g251592;
					half3 NormalOS134_g251592 = v.normal;
					float3 temp_output_21_0_g251610 = NormalOS134_g251592;
					float3 In_NormalOS16_g251610 = temp_output_21_0_g251610;
					half3 NormalWS95_g251592 = normalizedWorldNormal;
					float3 In_NormalWS16_g251610 = NormalWS95_g251592;
					float4 appendResult462_g251592 = (float4(cross( v.normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g251592 = appendResult462_g251592;
					float4 temp_output_6_0_g251610 = TangentlOS153_g251592;
					float4 In_TangentOS16_g251610 = temp_output_6_0_g251610;
					float3 normalizeResult296_g251592 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g251592 ) );
					half3 ViewDirWS169_g251592 = normalizeResult296_g251592;
					float3 In_ViewDirWS16_g251610 = ViewDirWS169_g251592;
					float4 appendResult397_g251592 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g251592 = appendResult397_g251592;
					float4 In_CoordsData16_g251610 = CoordsData398_g251592;
					half4 VertexMasks171_g251592 = float4( 0,0,0,0 );
					float4 In_VertexData16_g251610 = VertexMasks171_g251592;
					half4 MasksData254_g251592 = float4( 0,0,0,0 );
					float4 In_MasksData16_g251610 = MasksData254_g251592;
					half4 Phase_Data176_g251592 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g251610 = Phase_Data176_g251592;
					BuildModelVertData( Data16_g251610 , In_Dummy16_g251610 , In_PositionOS16_g251610 , In_PositionWS16_g251610 , In_PositionWO16_g251610 , In_PivotOS16_g251610 , In_PivotWS16_g251610 , In_PivotWO16_g251610 , In_NormalOS16_g251610 , In_NormalWS16_g251610 , In_TangentOS16_g251610 , In_ViewDirWS16_g251610 , In_CoordsData16_g251610 , In_VertexData16_g251610 , In_MasksData16_g251610 , In_PhaseData16_g251610 );
					TVEModelData DataTerrain26_g251590 = Data16_g251610;
					half IsShaderType2544 = _IsShaderType;
					float Type26_g251590 = IsShaderType2544;
					{
					if (Type26_g251590 == 0 )
					{
					Data26_g251590 = DataDefault26_g251590;
					}
					else if (Type26_g251590 == 1 )
					{
					Data26_g251590 = DataGeneral26_g251590;
					}
					else if (Type26_g251590 == 2 )
					{
					Data26_g251590 = DataBlanket26_g251590;
					}
					else if (Type26_g251590 == 3 )
					{
					Data26_g251590 = DataImpostor26_g251590;
					}
					else if (Type26_g251590 == 4 )
					{
					Data26_g251590 = DataTerrain26_g251590;
					}
					}
					TVEModelData Data15_g251814 =(TVEModelData)Data26_g251590;
					float Out_Dummy15_g251814 = 0.0;
					float3 Out_PositionOS15_g251814 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251814 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251814 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251814 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251814 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251814 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251814 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251814 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251814 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251814 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251814 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251814 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251814 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251814 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251814 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251814 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251814 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251814 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251814 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251814 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251814 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251814 , Out_Dummy15_g251814 , Out_PositionOS15_g251814 , Out_PositionWS15_g251814 , Out_PositionWO15_g251814 , Out_PositionRawOS15_g251814 , Out_PivotOS15_g251814 , Out_PivotWS15_g251814 , Out_PivotWO15_g251814 , Out_NormalOS15_g251814 , Out_NormalWS15_g251814 , Out_NormalRawOS15_g251814 , Out_TangentOS15_g251814 , Out_TangentWS15_g251814 , Out_BitangentWS15_g251814 , Out_ViewDirWS15_g251814 , Out_CoordsData15_g251814 , Out_VertexData15_g251814 , Out_MasksData15_g251814 , Out_PhaseData15_g251814 , Out_TransformData15_g251814 , Out_RotationData15_g251814 , Out_Interpolator15_g251814 );
					float3 In_PositionOS16_g251813 = Out_PositionOS15_g251814;
					float3 In_NormalOS16_g251813 = Out_NormalOS15_g251814;
					float4 In_TangentOS16_g251813 = Out_TangentOS15_g251814;
					float4 In_TransformData16_g251813 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251813 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251813 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251813 , In_Dummy16_g251813 , In_PositionOS16_g251813 , In_NormalOS16_g251813 , In_TangentOS16_g251813 , In_TransformData16_g251813 , In_RotationData16_g251813 , In_Interpolator16_g251813 );
					TVEVertexData Data15_g251817 =(TVEVertexData)Data16_g251813;
					float Out_Dummy15_g251817 = 0.0;
					float3 Out_PositionOS15_g251817 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251817 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251817 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251817 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251817 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251817 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251817 , Out_Dummy15_g251817 , Out_PositionOS15_g251817 , Out_NormalOS15_g251817 , Out_TangentOS15_g251817 , Out_TransformData15_g251817 , Out_RotationData15_g251817 , Out_Interpolator15_g251817 );
					TVEModelData Data15_g251818 =(TVEModelData)Data15_g251814;
					float Out_Dummy15_g251818 = 0.0;
					float3 Out_PositionOS15_g251818 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251818 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251818 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251818 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251818 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251818 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251818 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251818 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251818 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251818 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251818 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251818 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251818 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251818 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251818 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251818 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251818 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251818 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251818 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251818 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251818 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251818 , Out_Dummy15_g251818 , Out_PositionOS15_g251818 , Out_PositionWS15_g251818 , Out_PositionWO15_g251818 , Out_PositionRawOS15_g251818 , Out_PivotOS15_g251818 , Out_PivotWS15_g251818 , Out_PivotWO15_g251818 , Out_NormalOS15_g251818 , Out_NormalWS15_g251818 , Out_NormalRawOS15_g251818 , Out_TangentOS15_g251818 , Out_TangentWS15_g251818 , Out_BitangentWS15_g251818 , Out_ViewDirWS15_g251818 , Out_CoordsData15_g251818 , Out_VertexData15_g251818 , Out_MasksData15_g251818 , Out_PhaseData15_g251818 , Out_TransformData15_g251818 , Out_RotationData15_g251818 , Out_Interpolator15_g251818 );
					float3 In_PositionOS16_g251819 = ( Out_PositionOS15_g251817 - Out_PivotOS15_g251818 );
					float3 In_NormalOS16_g251819 = Out_NormalOS15_g251818;
					float4 In_TangentOS16_g251819 = Out_TangentOS15_g251818;
					float4 In_TransformData16_g251819 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251819 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251819 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251819 , In_Dummy16_g251819 , In_PositionOS16_g251819 , In_NormalOS16_g251819 , In_TangentOS16_g251819 , In_TransformData16_g251819 , In_RotationData16_g251819 , In_Interpolator16_g251819 );
					TVEVertexData Data15_g251930 =(TVEVertexData)Data16_g251819;
					float Out_Dummy15_g251930 = 0.0;
					float3 Out_PositionOS15_g251930 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251930 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251930 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251930 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251930 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251930 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251930 , Out_Dummy15_g251930 , Out_PositionOS15_g251930 , Out_NormalOS15_g251930 , Out_TangentOS15_g251930 , Out_TransformData15_g251930 , Out_RotationData15_g251930 , Out_Interpolator15_g251930 );
					TVEVertexData Data16_g251931 =(TVEVertexData)Data15_g251930;
					half Dummy317_g251922 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251931 = Dummy317_g251922;
					float3 In_PositionOS16_g251931 = Out_PositionOS15_g251930;
					float3 In_NormalOS16_g251931 = Out_NormalOS15_g251930;
					float4 In_TangentOS16_g251931 = Out_TangentOS15_g251930;
					half4 Model_TransformData356_g251922 = Out_TransformData15_g251930;
					float localBuildGlobalData204_g251489 = ( 0.0 );
					TVEGlobalData Data204_g251489 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g251489 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g251489 = Dummy211_g251489;
					float4 temp_output_203_0_g251508 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g251632 = ( 0.0 );
					TVEModelData Data26_g251632 = (TVEModelData)0;
					TVEModelData Data16_g251620 =(TVEModelData)0;
					float In_Dummy16_g251620 = 0.0;
					float3 In_PositionWS16_g251620 = PositionWS122_g251612;
					float3 In_PositionWO16_g251620 = PositionWO132_g251612;
					float3 In_PivotWS16_g251620 = PivotWS121_g251612;
					float3 In_PivotWO16_g251620 = PivotWO133_g251612;
					float3 In_NormalWS16_g251620 = NormalWS95_g251612;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g251612 = ase_tangentWS;
					float3 In_TangentWS16_g251620 = TangentWS136_g251612;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g251612 = ase_bitangentWS;
					float3 In_BitangentWS16_g251620 = BiangentWS421_g251612;
					half3 NormalWS427_g251612 = NormalWS95_g251612;
					half3 localComputeTriplanarMasks427_g251612 = ComputeTriplanarMasks( NormalWS427_g251612 );
					half3 TriplanarWeights429_g251612 = localComputeTriplanarMasks427_g251612;
					float3 In_TriplanarWeights16_g251620 = TriplanarWeights429_g251612;
					float3 In_ViewDirWS16_g251620 = ViewDirWS169_g251612;
					float4 In_CoordsData16_g251620 = CoordsData398_g251612;
					float4 In_VertexData16_g251620 = VertexMasks171_g251612;
					float4 In_Interpolator16_g251620 = Phase_Data176_g251612;
					BuildModelFragData( Data16_g251620 , In_Dummy16_g251620 , In_PositionWS16_g251620 , In_PositionWO16_g251620 , In_PivotWS16_g251620 , In_PivotWO16_g251620 , In_NormalWS16_g251620 , In_TangentWS16_g251620 , In_BitangentWS16_g251620 , In_TriplanarWeights16_g251620 , In_ViewDirWS16_g251620 , In_CoordsData16_g251620 , In_VertexData16_g251620 , In_Interpolator16_g251620 );
					TVEModelData DataDefault26_g251632 = Data16_g251620;
					TVEModelData DataGeneral26_g251632 = Data16_g251620;
					TVEModelData DataBlanket26_g251632 = Data16_g251620;
					TVEModelData DataImpostor26_g251632 = Data16_g251620;
					TVEModelData Data16_g251600 =(TVEModelData)0;
					float In_Dummy16_g251600 = 0.0;
					float3 In_PositionWS16_g251600 = PositionWS122_g251592;
					float3 In_PositionWO16_g251600 = PositionWO132_g251592;
					float3 In_PivotWS16_g251600 = PivotWS121_g251592;
					float3 In_PivotWO16_g251600 = PivotWO133_g251592;
					float3 In_NormalWS16_g251600 = NormalWS95_g251592;
					half3 TangentWS136_g251592 = ase_tangentWS;
					float3 In_TangentWS16_g251600 = TangentWS136_g251592;
					half3 BiangentWS421_g251592 = ase_bitangentWS;
					float3 In_BitangentWS16_g251600 = BiangentWS421_g251592;
					half3 NormalWS427_g251592 = NormalWS95_g251592;
					half3 localComputeTriplanarMasks427_g251592 = ComputeTriplanarMasks( NormalWS427_g251592 );
					half3 TriplanarWeights429_g251592 = localComputeTriplanarMasks427_g251592;
					float3 In_TriplanarWeights16_g251600 = TriplanarWeights429_g251592;
					float3 In_ViewDirWS16_g251600 = ViewDirWS169_g251592;
					float4 In_CoordsData16_g251600 = CoordsData398_g251592;
					float4 In_VertexData16_g251600 = VertexMasks171_g251592;
					float4 In_Interpolator16_g251600 = Phase_Data176_g251592;
					BuildModelFragData( Data16_g251600 , In_Dummy16_g251600 , In_PositionWS16_g251600 , In_PositionWO16_g251600 , In_PivotWS16_g251600 , In_PivotWO16_g251600 , In_NormalWS16_g251600 , In_TangentWS16_g251600 , In_BitangentWS16_g251600 , In_TriplanarWeights16_g251600 , In_ViewDirWS16_g251600 , In_CoordsData16_g251600 , In_VertexData16_g251600 , In_Interpolator16_g251600 );
					TVEModelData DataTerrain26_g251632 = Data16_g251600;
					float Type26_g251632 = IsShaderType2544;
					{
					if (Type26_g251632 == 0 )
					{
					Data26_g251632 = DataDefault26_g251632;
					}
					else if (Type26_g251632 == 1 )
					{
					Data26_g251632 = DataGeneral26_g251632;
					}
					else if (Type26_g251632 == 2 )
					{
					Data26_g251632 = DataBlanket26_g251632;
					}
					else if (Type26_g251632 == 3 )
					{
					Data26_g251632 = DataImpostor26_g251632;
					}
					else if (Type26_g251632 == 4 )
					{
					Data26_g251632 = DataTerrain26_g251632;
					}
					}
					TVEModelData Data15_g251579 =(TVEModelData)Data26_g251632;
					float Out_Dummy15_g251579 = 0.0;
					float3 Out_PositionWS15_g251579 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251579 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251579 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251579 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251579 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251579 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251579 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251579 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251579 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251579 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251579 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251579 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251579 , Out_Dummy15_g251579 , Out_PositionWS15_g251579 , Out_PositionWO15_g251579 , Out_PivotWS15_g251579 , Out_PivotWO15_g251579 , Out_NormalWS15_g251579 , Out_TangentWS15_g251579 , Out_BitangentWS15_g251579 , Out_TriplanarWeights15_g251579 , Out_ViewDirWS15_g251579 , Out_CoordsData15_g251579 , Out_VertexData15_g251579 , Out_Interpolator15_g251579 );
					float3 Model_PositionWS497_g251489 = Out_PositionWS15_g251579;
					float2 Model_PositionWS_XZ143_g251489 = (Model_PositionWS497_g251489).xz;
					float3 Model_PivotWS498_g251489 = Out_PivotWS15_g251579;
					float2 Model_PivotWS_XZ145_g251489 = (Model_PivotWS498_g251489).xz;
					float2 lerpResult300_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g251508 = lerpResult300_g251489;
					float temp_output_82_0_g251506 = _GlobalCoatLayerValue;
					float temp_output_82_0_g251508 = temp_output_82_0_g251506;
					float4 tex2DArrayNode83_g251508 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251508).zw + ( (temp_output_203_0_g251508).xy * temp_output_81_0_g251508 ) ),temp_output_82_0_g251508), 0.0 );
					float4 appendResult210_g251508 = (float4(tex2DArrayNode83_g251508.rgb , tex2DArrayNode83_g251508.a));
					float4 temp_output_204_0_g251508 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g251508 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251508).zw + ( (temp_output_204_0_g251508).xy * temp_output_81_0_g251508 ) ),temp_output_82_0_g251508), 0.0 );
					float4 appendResult212_g251508 = (float4(tex2DArrayNode122_g251508.rgb , tex2DArrayNode122_g251508.a));
					float4 TVE_RenderNearPositionR628_g251489 = TVE_RenderNearPositionR;
					float temp_output_507_0_g251489 = saturate( ( distance( Model_PositionWS497_g251489 , (TVE_RenderNearPositionR628_g251489).xyz ) / (TVE_RenderNearPositionR628_g251489).w ) );
					float temp_output_7_0_g251578 = 1.0;
					float temp_output_9_0_g251578 = ( temp_output_507_0_g251489 - temp_output_7_0_g251578 );
					half TVE_RenderNearFadeValue635_g251489 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g251489 = saturate( ( temp_output_9_0_g251578 / ( ( TVE_RenderNearFadeValue635_g251489 - temp_output_7_0_g251578 ) + 0.0001 ) ) );
					float4 lerpResult131_g251508 = lerp( appendResult210_g251508 , appendResult212_g251508 , Global_TexBlend509_g251489);
					float4 temp_output_159_109_g251506 = lerpResult131_g251508;
					float4 lerpResult168_g251506 = lerp( TVE_CoatParams , temp_output_159_109_g251506 , TVE_CoatLayers[(int)temp_output_82_0_g251506]);
					float4 temp_output_589_109_g251489 = lerpResult168_g251506;
					half4 Coat_Texture302_g251489 = temp_output_589_109_g251489;
					float4 In_CoatTexture204_g251489 = Coat_Texture302_g251489;
					half4 Draw_Texture656_g251489 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g251489 = Draw_Texture656_g251489;
					float4 temp_output_203_0_g251533 = TVE_PaintBaseCoord;
					float2 lerpResult85_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g251533 = lerpResult85_g251489;
					float temp_output_82_0_g251530 = _GlobalPaintLayerValue;
					float temp_output_82_0_g251533 = temp_output_82_0_g251530;
					float4 tex2DArrayNode83_g251533 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251533).zw + ( (temp_output_203_0_g251533).xy * temp_output_81_0_g251533 ) ),temp_output_82_0_g251533), 0.0 );
					float4 appendResult210_g251533 = (float4(tex2DArrayNode83_g251533.rgb , tex2DArrayNode83_g251533.a));
					float4 temp_output_204_0_g251533 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g251533 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251533).zw + ( (temp_output_204_0_g251533).xy * temp_output_81_0_g251533 ) ),temp_output_82_0_g251533), 0.0 );
					float4 appendResult212_g251533 = (float4(tex2DArrayNode122_g251533.rgb , tex2DArrayNode122_g251533.a));
					float4 lerpResult131_g251533 = lerp( appendResult210_g251533 , appendResult212_g251533 , Global_TexBlend509_g251489);
					float4 temp_output_171_109_g251530 = lerpResult131_g251533;
					float4 lerpResult174_g251530 = lerp( TVE_PaintParams , temp_output_171_109_g251530 , TVE_PaintLayers[(int)temp_output_82_0_g251530]);
					float4 temp_output_595_109_g251489 = lerpResult174_g251530;
					half4 Paint_Texture71_g251489 = temp_output_595_109_g251489;
					float4 In_PaintTexture204_g251489 = Paint_Texture71_g251489;
					float4 temp_output_203_0_g251516 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g251516 = lerpResult104_g251489;
					float temp_output_132_0_g251514 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g251516 = temp_output_132_0_g251514;
					float4 tex2DArrayNode83_g251516 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251516).zw + ( (temp_output_203_0_g251516).xy * temp_output_81_0_g251516 ) ),temp_output_82_0_g251516), 0.0 );
					float4 appendResult210_g251516 = (float4(tex2DArrayNode83_g251516.rgb , tex2DArrayNode83_g251516.a));
					float4 temp_output_204_0_g251516 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g251516 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251516).zw + ( (temp_output_204_0_g251516).xy * temp_output_81_0_g251516 ) ),temp_output_82_0_g251516), 0.0 );
					float4 appendResult212_g251516 = (float4(tex2DArrayNode122_g251516.rgb , tex2DArrayNode122_g251516.a));
					float4 lerpResult131_g251516 = lerp( appendResult210_g251516 , appendResult212_g251516 , Global_TexBlend509_g251489);
					float4 temp_output_137_109_g251514 = lerpResult131_g251516;
					float4 lerpResult145_g251514 = lerp( TVE_AtmoParams , temp_output_137_109_g251514 , TVE_AtmoLayers[(int)temp_output_132_0_g251514]);
					float4 temp_output_590_110_g251489 = lerpResult145_g251514;
					half4 Atmo_Texture80_g251489 = temp_output_590_110_g251489;
					float4 In_AtmoTexture204_g251489 = Atmo_Texture80_g251489;
					float4 temp_output_203_0_g251584 = TVE_EffexBaseCoord;
					float2 lerpResult414_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g251584 = lerpResult414_g251489;
					float temp_output_132_0_g251582 = _GlobalEffexLayerValue;
					float temp_output_82_0_g251584 = temp_output_132_0_g251582;
					float4 tex2DArrayNode83_g251584 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251584).zw + ( (temp_output_203_0_g251584).xy * temp_output_81_0_g251584 ) ),temp_output_82_0_g251584), 0.0 );
					float4 appendResult210_g251584 = (float4(tex2DArrayNode83_g251584.rgb , tex2DArrayNode83_g251584.a));
					float4 temp_output_204_0_g251584 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g251584 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251584).zw + ( (temp_output_204_0_g251584).xy * temp_output_81_0_g251584 ) ),temp_output_82_0_g251584), 0.0 );
					float4 appendResult212_g251584 = (float4(tex2DArrayNode122_g251584.rgb , tex2DArrayNode122_g251584.a));
					float4 lerpResult131_g251584 = lerp( appendResult210_g251584 , appendResult212_g251584 , Global_TexBlend509_g251489);
					float4 temp_output_137_109_g251582 = lerpResult131_g251584;
					float4 lerpResult145_g251582 = lerp( TVE_EffexParams , temp_output_137_109_g251582 , TVE_EffexLayers[(int)temp_output_132_0_g251582]);
					float4 temp_output_731_110_g251489 = lerpResult145_g251582;
					half4 Effex_Texture420_g251489 = temp_output_731_110_g251489;
					float4 In_EffexTexture204_g251489 = Effex_Texture420_g251489;
					float4 temp_output_203_0_g251564 = TVE_GlowBaseCoord;
					float2 lerpResult247_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g251564 = lerpResult247_g251489;
					float temp_output_82_0_g251562 = _GlobalGlowLayerValue;
					float temp_output_82_0_g251564 = temp_output_82_0_g251562;
					float4 tex2DArrayNode83_g251564 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251564).zw + ( (temp_output_203_0_g251564).xy * temp_output_81_0_g251564 ) ),temp_output_82_0_g251564), 0.0 );
					float4 appendResult210_g251564 = (float4(tex2DArrayNode83_g251564.rgb , tex2DArrayNode83_g251564.a));
					float4 temp_output_204_0_g251564 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g251564 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251564).zw + ( (temp_output_204_0_g251564).xy * temp_output_81_0_g251564 ) ),temp_output_82_0_g251564), 0.0 );
					float4 appendResult212_g251564 = (float4(tex2DArrayNode122_g251564.rgb , tex2DArrayNode122_g251564.a));
					float4 lerpResult131_g251564 = lerp( appendResult210_g251564 , appendResult212_g251564 , Global_TexBlend509_g251489);
					float4 temp_output_159_109_g251562 = lerpResult131_g251564;
					float4 lerpResult167_g251562 = lerp( TVE_GlowParams , temp_output_159_109_g251562 , TVE_GlowLayers[(int)temp_output_82_0_g251562]);
					float4 temp_output_593_109_g251489 = lerpResult167_g251562;
					half4 Glow_Texture248_g251489 = temp_output_593_109_g251489;
					float4 In_GlowTexture204_g251489 = Glow_Texture248_g251489;
					float4 temp_output_203_0_g251500 = TVE_FormBaseCoord;
					float2 lerpResult168_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g251500 = lerpResult168_g251489;
					float temp_output_130_0_g251498 = _GlobalFormLayerValue;
					float temp_output_82_0_g251500 = temp_output_130_0_g251498;
					float4 tex2DArrayNode83_g251500 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251500).zw + ( (temp_output_203_0_g251500).xy * temp_output_81_0_g251500 ) ),temp_output_82_0_g251500), 0.0 );
					float4 appendResult210_g251500 = (float4(tex2DArrayNode83_g251500.rgb , tex2DArrayNode83_g251500.a));
					float4 temp_output_204_0_g251500 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g251500 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251500).zw + ( (temp_output_204_0_g251500).xy * temp_output_81_0_g251500 ) ),temp_output_82_0_g251500), 0.0 );
					float4 appendResult212_g251500 = (float4(tex2DArrayNode122_g251500.rgb , tex2DArrayNode122_g251500.a));
					float4 lerpResult131_g251500 = lerp( appendResult210_g251500 , appendResult212_g251500 , Global_TexBlend509_g251489);
					float4 temp_output_135_109_g251498 = lerpResult131_g251500;
					float4 lerpResult143_g251498 = lerp( TVE_FormParams , temp_output_135_109_g251498 , TVE_FormLayers[(int)temp_output_130_0_g251498]);
					float4 temp_output_592_0_g251489 = lerpResult143_g251498;
					float4 Form_Texture112_g251489 = temp_output_592_0_g251489;
					float4 In_FormTexture204_g251489 = Form_Texture112_g251489;
					float4 In_LandTexture204_g251489 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g251548 = TVE_VertxBaseCoord;
					float2 lerpResult681_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g251548 = lerpResult681_g251489;
					float temp_output_136_0_g251546 = _GlobalVertxLayerValue;
					float temp_output_82_0_g251548 = temp_output_136_0_g251546;
					float4 tex2DArrayNode83_g251548 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251548).zw + ( (temp_output_203_0_g251548).xy * temp_output_81_0_g251548 ) ),temp_output_82_0_g251548), 0.0 );
					float4 appendResult210_g251548 = (float4(tex2DArrayNode83_g251548.rgb , tex2DArrayNode83_g251548.a));
					float4 temp_output_204_0_g251548 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g251548 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251548).zw + ( (temp_output_204_0_g251548).xy * temp_output_81_0_g251548 ) ),temp_output_82_0_g251548), 0.0 );
					float4 appendResult212_g251548 = (float4(tex2DArrayNode122_g251548.rgb , tex2DArrayNode122_g251548.a));
					float4 lerpResult131_g251548 = lerp( appendResult210_g251548 , appendResult212_g251548 , Global_TexBlend509_g251489);
					float4 temp_output_141_109_g251546 = lerpResult131_g251548;
					float4 lerpResult149_g251546 = lerp( TVE_VertxParams , temp_output_141_109_g251546 , TVE_VertxLayers[(int)temp_output_136_0_g251546]);
					float4 temp_output_695_0_g251489 = lerpResult149_g251546;
					half4 Vertx_Texture693_g251489 = temp_output_695_0_g251489;
					float4 In_VertxTexture204_g251489 = Vertx_Texture693_g251489;
					float4 temp_output_203_0_g251524 = TVE_FlowBaseCoord;
					float2 lerpResult400_g251489 = lerp( Model_PositionWS_XZ143_g251489 , Model_PivotWS_XZ145_g251489 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g251524 = lerpResult400_g251489;
					float temp_output_136_0_g251522 = _GlobalFlowLayerValue;
					float temp_output_82_0_g251524 = temp_output_136_0_g251522;
					float4 tex2DArrayNode83_g251524 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g251524).zw + ( (temp_output_203_0_g251524).xy * temp_output_81_0_g251524 ) ),temp_output_82_0_g251524), 0.0 );
					float4 appendResult210_g251524 = (float4(tex2DArrayNode83_g251524.rgb , tex2DArrayNode83_g251524.a));
					float4 temp_output_204_0_g251524 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g251524 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g251524).zw + ( (temp_output_204_0_g251524).xy * temp_output_81_0_g251524 ) ),temp_output_82_0_g251524), 0.0 );
					float4 appendResult212_g251524 = (float4(tex2DArrayNode122_g251524.rgb , tex2DArrayNode122_g251524.a));
					float4 lerpResult131_g251524 = lerp( appendResult210_g251524 , appendResult212_g251524 , Global_TexBlend509_g251489);
					float4 temp_output_141_109_g251522 = lerpResult131_g251524;
					float4 lerpResult149_g251522 = lerp( TVE_FlowParams , temp_output_141_109_g251522 , TVE_FlowLayers[(int)temp_output_136_0_g251522]);
					float4 temp_output_594_0_g251489 = lerpResult149_g251522;
					half4 Flow_Texture405_g251489 = temp_output_594_0_g251489;
					float4 In_FlowTexture204_g251489 = Flow_Texture405_g251489;
					half4 User_Texture677_g251489 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g251489 = User_Texture677_g251489;
					BuildGlobalData( Data204_g251489 , In_Dummy204_g251489 , In_CoatTexture204_g251489 , In_DrawTexture204_g251489 , In_PaintTexture204_g251489 , In_AtmoTexture204_g251489 , In_EffexTexture204_g251489 , In_GlowTexture204_g251489 , In_FormTexture204_g251489 , In_LandTexture204_g251489 , In_VertxTexture204_g251489 , In_FlowTexture204_g251489 , In_UserTexture204_g251489 );
					TVEGlobalData Data15_g251932 =(TVEGlobalData)Data204_g251489;
					float Out_Dummy15_g251932 = 0.0;
					float4 Out_CoatTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251932 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251932 = float4( 0,0,0,0 );
					BreakData( Data15_g251932 , Out_Dummy15_g251932 , Out_CoatTexture15_g251932 , Out_DrawTexture15_g251932 , Out_PaintTexture15_g251932 , Out_AtmoTexture15_g251932 , Out_EffexTexture15_g251932 , Out_GlowTexture15_g251932 , Out_FormTexture15_g251932 , Out_LandTexture15_g251932 , Out_VertxTexture15_g251932 , Out_FlowTexture15_g251932 , Out_UserTexture15_g251932 );
					float4 Global_FormTexture351_g251922 = Out_FormTexture15_g251932;
					TVEModelData Data15_g251929 =(TVEModelData)Data15_g251818;
					float Out_Dummy15_g251929 = 0.0;
					float3 Out_PositionOS15_g251929 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251929 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251929 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251929 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251929 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251929 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251929 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251929 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251929 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251929 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251929 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251929 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251929 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251929 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251929 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251929 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251929 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251929 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251929 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251929 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251929 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251929 , Out_Dummy15_g251929 , Out_PositionOS15_g251929 , Out_PositionWS15_g251929 , Out_PositionWO15_g251929 , Out_PositionRawOS15_g251929 , Out_PivotOS15_g251929 , Out_PivotWS15_g251929 , Out_PivotWO15_g251929 , Out_NormalOS15_g251929 , Out_NormalWS15_g251929 , Out_NormalRawOS15_g251929 , Out_TangentOS15_g251929 , Out_TangentWS15_g251929 , Out_BitangentWS15_g251929 , Out_ViewDirWS15_g251929 , Out_CoordsData15_g251929 , Out_VertexData15_g251929 , Out_MasksData15_g251929 , Out_PhaseData15_g251929 , Out_TransformData15_g251929 , Out_RotationData15_g251929 , Out_Interpolator15_g251929 );
					float3 Model_PivotWO353_g251922 = Out_PivotWO15_g251929;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251928 = _ConformMeshMode;
					float Option70_g251928 = temp_output_17_0_g251928;
					half4 Model_VertexData357_g251922 = Out_VertexData15_g251929;
					float4 temp_output_3_0_g251928 = Model_VertexData357_g251922;
					float4 Channel70_g251928 = temp_output_3_0_g251928;
					float localSwitchChannel470_g251928 = SwitchChannel4( Option70_g251928 , Channel70_g251928 );
					float temp_output_390_0_g251922 = localSwitchChannel470_g251928;
					float temp_output_7_0_g251925 = _ConformMeshRemap.x;
					float temp_output_9_0_g251925 = ( temp_output_390_0_g251922 - temp_output_7_0_g251925 );
					float lerpResult374_g251922 = lerp( 1.0 , saturate( ( temp_output_9_0_g251925 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251922 = lerpResult374_g251922;
					float temp_output_328_0_g251922 = ( Blend_VertMask379_g251922 * TVE_IsEnabled );
					half Conform_Mask366_g251922 = temp_output_328_0_g251922;
					float temp_output_322_0_g251922 = ( ( ( ( (Global_FormTexture351_g251922).z - ( (Model_PivotWO353_g251922).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251922 ) );
					float3 appendResult329_g251922 = (float3(0.0 , temp_output_322_0_g251922 , 0.0));
					float3 appendResult387_g251922 = (float3(0.0 , 0.0 , temp_output_322_0_g251922));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251926 = appendResult387_g251922;
					#else
					float3 staticSwitch65_g251926 = appendResult329_g251922;
					#endif
					float3 Blanket_Conform368_g251922 = staticSwitch65_g251926;
					float4 appendResult312_g251922 = (float4(Blanket_Conform368_g251922 , 0.0));
					float4 temp_output_310_0_g251922 = ( Model_TransformData356_g251922 + appendResult312_g251922 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251922 = temp_output_310_0_g251922;
					#else
					float4 staticSwitch364_g251922 = Model_TransformData356_g251922;
					#endif
					half4 Final_TransformData365_g251922 = staticSwitch364_g251922;
					float4 In_TransformData16_g251931 = Final_TransformData365_g251922;
					float4 In_RotationData16_g251931 = Out_RotationData15_g251930;
					float4 In_Interpolator16_g251931 = Out_Interpolator15_g251930;
					BuildVertexData( Data16_g251931 , In_Dummy16_g251931 , In_PositionOS16_g251931 , In_NormalOS16_g251931 , In_TangentOS16_g251931 , In_TransformData16_g251931 , In_RotationData16_g251931 , In_Interpolator16_g251931 );
					TVEVertexData Data15_g251943 =(TVEVertexData)Data16_g251931;
					float Out_Dummy15_g251943 = 0.0;
					float3 Out_PositionOS15_g251943 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251943 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251943 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251943 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251943 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251943 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251943 , Out_Dummy15_g251943 , Out_PositionOS15_g251943 , Out_NormalOS15_g251943 , Out_TangentOS15_g251943 , Out_TransformData15_g251943 , Out_RotationData15_g251943 , Out_Interpolator15_g251943 );
					TVEVertexData Data16_g251944 =(TVEVertexData)Data15_g251943;
					float In_Dummy16_g251944 = 0.0;
					float3 Vertex_PositionOS147_g251934 = Out_PositionOS15_g251943;
					half3 VertexPos40_g251938 = Vertex_PositionOS147_g251934;
					float4 temp_output_1615_33_g251934 = Out_RotationData15_g251943;
					half4 Vertex_RotationData1569_g251934 = temp_output_1615_33_g251934;
					float2 break1582_g251934 = (Vertex_RotationData1569_g251934).xy;
					half Angle44_g251938 = break1582_g251934.y;
					half CosAngle89_g251938 = cos( Angle44_g251938 );
					half SinAngle93_g251938 = sin( Angle44_g251938 );
					float3 appendResult95_g251938 = (float3((VertexPos40_g251938).x , ( ( (VertexPos40_g251938).y * CosAngle89_g251938 ) - ( (VertexPos40_g251938).z * SinAngle93_g251938 ) ) , ( ( (VertexPos40_g251938).y * SinAngle93_g251938 ) + ( (VertexPos40_g251938).z * CosAngle89_g251938 ) )));
					half3 VertexPos40_g251939 = appendResult95_g251938;
					half Angle44_g251939 = -break1582_g251934.x;
					half CosAngle94_g251939 = cos( Angle44_g251939 );
					half SinAngle95_g251939 = sin( Angle44_g251939 );
					float3 appendResult98_g251939 = (float3(( ( (VertexPos40_g251939).x * CosAngle94_g251939 ) - ( (VertexPos40_g251939).y * SinAngle95_g251939 ) ) , ( ( (VertexPos40_g251939).x * SinAngle95_g251939 ) + ( (VertexPos40_g251939).y * CosAngle94_g251939 ) ) , (VertexPos40_g251939).z));
					half3 VertexPos40_g251937 = Vertex_PositionOS147_g251934;
					half Angle44_g251937 = break1582_g251934.y;
					half CosAngle89_g251937 = cos( Angle44_g251937 );
					half SinAngle93_g251937 = sin( Angle44_g251937 );
					float3 appendResult95_g251937 = (float3((VertexPos40_g251937).x , ( ( (VertexPos40_g251937).y * CosAngle89_g251937 ) - ( (VertexPos40_g251937).z * SinAngle93_g251937 ) ) , ( ( (VertexPos40_g251937).y * SinAngle93_g251937 ) + ( (VertexPos40_g251937).z * CosAngle89_g251937 ) )));
					half3 VertexPos40_g251942 = appendResult95_g251937;
					half Angle44_g251942 = break1582_g251934.x;
					half CosAngle91_g251942 = cos( Angle44_g251942 );
					half SinAngle92_g251942 = sin( Angle44_g251942 );
					float3 appendResult93_g251942 = (float3(( ( (VertexPos40_g251942).x * CosAngle91_g251942 ) + ( (VertexPos40_g251942).z * SinAngle92_g251942 ) ) , (VertexPos40_g251942).y , ( ( -(VertexPos40_g251942).x * SinAngle92_g251942 ) + ( (VertexPos40_g251942).z * CosAngle91_g251942 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251940 = appendResult93_g251942;
					#else
					float3 staticSwitch65_g251940 = appendResult98_g251939;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251935 = staticSwitch65_g251940;
					#else
					float3 staticSwitch65_g251935 = Vertex_PositionOS147_g251934;
					#endif
					float3 temp_output_1608_0_g251934 = staticSwitch65_g251935;
					half3 VertexPos40_g251941 = temp_output_1608_0_g251934;
					half Angle44_g251941 = (Vertex_RotationData1569_g251934).z;
					half CosAngle91_g251941 = cos( Angle44_g251941 );
					half SinAngle92_g251941 = sin( Angle44_g251941 );
					float3 appendResult93_g251941 = (float3(( ( (VertexPos40_g251941).x * CosAngle91_g251941 ) + ( (VertexPos40_g251941).z * SinAngle92_g251941 ) ) , (VertexPos40_g251941).y , ( ( -(VertexPos40_g251941).x * SinAngle92_g251941 ) + ( (VertexPos40_g251941).z * CosAngle91_g251941 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251936 = appendResult93_g251941;
					#else
					float3 staticSwitch65_g251936 = temp_output_1608_0_g251934;
					#endif
					float4 temp_output_1615_31_g251934 = Out_TransformData15_g251943;
					half4 Vertex_TransformData1568_g251934 = temp_output_1615_31_g251934;
					half3 Final_PositionOS178_g251934 = ( ( staticSwitch65_g251936 * (Vertex_TransformData1568_g251934).w ) + (Vertex_TransformData1568_g251934).xyz );
					float3 In_PositionOS16_g251944 = Final_PositionOS178_g251934;
					float3 In_NormalOS16_g251944 = Out_NormalOS15_g251943;
					float4 In_TangentOS16_g251944 = Out_TangentOS15_g251943;
					float4 In_TransformData16_g251944 = temp_output_1615_31_g251934;
					float4 In_RotationData16_g251944 = temp_output_1615_33_g251934;
					float4 In_Interpolator16_g251944 = Out_Interpolator15_g251943;
					BuildVertexData( Data16_g251944 , In_Dummy16_g251944 , In_PositionOS16_g251944 , In_NormalOS16_g251944 , In_TangentOS16_g251944 , In_TransformData16_g251944 , In_RotationData16_g251944 , In_Interpolator16_g251944 );
					TVEVertexData Data15_g252048 =(TVEVertexData)Data16_g251944;
					float Out_Dummy15_g252048 = 0.0;
					float3 Out_PositionOS15_g252048 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252048 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252048 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252048 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252048 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252048 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252048 , Out_Dummy15_g252048 , Out_PositionOS15_g252048 , Out_NormalOS15_g252048 , Out_TangentOS15_g252048 , Out_TransformData15_g252048 , Out_RotationData15_g252048 , Out_Interpolator15_g252048 );
					TVEVertexData Data16_g252049 =(TVEVertexData)Data15_g252048;
					float In_Dummy16_g252049 = 0.0;
					TVEModelData Data15_g252047 =(TVEModelData)Data15_g251929;
					float Out_Dummy15_g252047 = 0.0;
					float3 Out_PositionOS15_g252047 = float3( 0,0,0 );
					float3 Out_PositionWS15_g252047 = float3( 0,0,0 );
					float3 Out_PositionWO15_g252047 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g252047 = float3( 0,0,0 );
					float3 Out_PivotOS15_g252047 = float3( 0,0,0 );
					float3 Out_PivotWS15_g252047 = float3( 0,0,0 );
					float3 Out_PivotWO15_g252047 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252047 = float3( 0,0,0 );
					float3 Out_NormalWS15_g252047 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g252047 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252047 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g252047 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g252047 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g252047 = float3( 0,0,0 );
					float4 Out_CoordsData15_g252047 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g252047 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g252047 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g252047 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252047 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252047 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252047 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g252047 , Out_Dummy15_g252047 , Out_PositionOS15_g252047 , Out_PositionWS15_g252047 , Out_PositionWO15_g252047 , Out_PositionRawOS15_g252047 , Out_PivotOS15_g252047 , Out_PivotWS15_g252047 , Out_PivotWO15_g252047 , Out_NormalOS15_g252047 , Out_NormalWS15_g252047 , Out_NormalRawOS15_g252047 , Out_TangentOS15_g252047 , Out_TangentWS15_g252047 , Out_BitangentWS15_g252047 , Out_ViewDirWS15_g252047 , Out_CoordsData15_g252047 , Out_VertexData15_g252047 , Out_MasksData15_g252047 , Out_PhaseData15_g252047 , Out_TransformData15_g252047 , Out_RotationData15_g252047 , Out_Interpolator15_g252047 );
					float3 In_PositionOS16_g252049 = ( Out_PositionOS15_g252048 + Out_PivotOS15_g252047 );
					float3 In_NormalOS16_g252049 = Out_NormalOS15_g252048;
					float4 In_TangentOS16_g252049 = Out_TangentOS15_g252048;
					float4 In_TransformData16_g252049 = Out_TransformData15_g252048;
					float4 In_RotationData16_g252049 = Out_RotationData15_g252048;
					float4 In_Interpolator16_g252049 = Out_Interpolator15_g252048;
					BuildVertexData( Data16_g252049 , In_Dummy16_g252049 , In_PositionOS16_g252049 , In_NormalOS16_g252049 , In_TangentOS16_g252049 , In_TransformData16_g252049 , In_RotationData16_g252049 , In_Interpolator16_g252049 );
					TVEVertexData Data15_g252196 =(TVEVertexData)Data16_g252049;
					float Out_Dummy15_g252196 = 0.0;
					float3 Out_PositionOS15_g252196 = float3( 0,0,0 );
					float3 Out_NormalOS15_g252196 = float3( 0,0,0 );
					float4 Out_TangentOS15_g252196 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g252196 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g252196 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g252196 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g252196 , Out_Dummy15_g252196 , Out_PositionOS15_g252196 , Out_NormalOS15_g252196 , Out_TangentOS15_g252196 , Out_TransformData15_g252196 , Out_RotationData15_g252196 , Out_Interpolator15_g252196 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g252196;
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
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2519,"pos":[-7168,-4992],"params":["Inherit","False","2373","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2563,"pos":[-2048,-6256],"params":["Inherit","False","Get Global Volume","-1","","251442","f768f57f9fe20884881af88e78b0e3a0","0","0","3","FLOAT4","148","FLOAT4","145","FLOAT","150"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":2543,"pos":[-8320,-5376],"params":["Inherit","False","Property","_IsShaderType","_IsShaderType","20","0","Create","True","0","0","0","False","0","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2560,"pos":[-6912,-4992],"params":["Inherit","False","Block Global","21","","251489","212e17d4006dc88449d56ce0340cb5ff","46,385,1,692,1,667,1,276,1,396,1,417,1,282,1,402,1,560,1,285,1,283,1,308,1,650,1,483,0,484,0,486,0,488,0,561,0,487,0,652,0,482,0,485,0,668,0,691,0,315,1,703,1,719,1,716,1,715,1,709,1,710,1,706,1,701,1,704,1,707,1,655,0,311,1,317,1,421,1,321,1,398,1,700,0,694,1,713,1,404,1,675,0","1","206","OBJECT","0,0,0,0","False","1","OBJECT","151"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2491,"pos":[-7936,-4992],"params":["Inherit","False","If Model Data","-1","","251590","d269c9c511ff160419055604aade1e70","1,32,1","9","3","OBJECT","0","False","17","OBJECT","0","False","19","FLOAT","0","False","33","OBJECT","0","False","27","OBJECT","0","False","28","OBJECT","0","False","29","OBJECT","0","False","30","OBJECT","0","False","31","FLOAT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2549,"pos":[-1792,-6336],"params":["Inherit","False","FLOAT3","0","1","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.WorldPosInputsNode, AmplifyShaderEditor","id":2559,"pos":[-2048,-6400],"params":["Inherit","False","0","4","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2582,"pos":[-2048,-5824],"params":["Inherit","False","Get Global Volume","-1","","251591","f768f57f9fe20884881af88e78b0e3a0","0","0","3","FLOAT4","148","FLOAT4","145","FLOAT","150"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2544,"pos":[-8128,-5376],"params":["Half","False","IsShaderType","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2521,"pos":[-6592,-4992],"params":["Half","False","Global Data","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2377,"pos":[-7616,-4992],"params":["Half","False","Model Vert","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2570,"pos":[-1792,-5824],"params":["Inherit","False","FLOAT3","0","1","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2550,"pos":[-1792,-6272],"params":["Inherit","False","FLOAT","3","1","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.WorldPosInputsNode, AmplifyShaderEditor","id":2581,"pos":[-2048,-6016],"params":["Inherit","False","0","4","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3"]}
{"type":"AmplifyShaderEditor.DistanceOpNode, AmplifyShaderEditor","id":2552,"pos":[-1536,-6400],"params":["Inherit","False","2","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2492,"pos":[-8320,-4864],"params":["Inherit","False","Block Model","7","","251592","7ad7765e793a6714babedee0033c36e9","19,463,0,289,0,240,0,437,0,291,0,431,0,404,0,290,0,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0","11","102","FLOAT3","0,0,0","False","163","FLOAT3","0,0,0","False","186","FLOAT3","0,0,0","False","187","FLOAT3","0,0,0","False","166","FLOAT3","0,0,0","False","164","FLOAT3","0,0,0","False","301","FLOAT3","0,0,0","False","418","FLOAT3","0,0,0","False","167","FLOAT4","0,0,0,0","False","172","FLOAT4","0,0,0,0","False","175","FLOAT4","0,0,0,0","False","2","OBJECT","128","OBJECT","314"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2372,"pos":[-8320,-4992],"params":["Inherit","False","Block Model","7","","251612","7ad7765e793a6714babedee0033c36e9","19,463,1,289,1,240,1,437,1,291,1,431,1,404,1,290,1,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0","11","102","FLOAT3","0,0,0","False","163","FLOAT3","0,0,0","False","186","FLOAT3","0,0,0","False","187","FLOAT3","0,0,0","False","166","FLOAT3","0,0,0","False","164","FLOAT3","0,0,0","False","301","FLOAT3","0,0,0","False","418","FLOAT3","0,0,0","False","167","FLOAT4","0,0,0,0","False","172","FLOAT4","0,0,0,0","False","175","FLOAT4","0,0,0,0","False","2","OBJECT","128","OBJECT","314"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2497,"pos":[-8320,-4608],"params":["Inherit","False","2544","IsShaderType","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2596,"pos":[-6144,-4992],"params":["Inherit","False","2377","Model Vert","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2597,"pos":[-6144,-4928],"params":["Inherit","False","2521","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.DistanceOpNode, AmplifyShaderEditor","id":2568,"pos":[-1536,-6016],"params":["Inherit","False","2","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2571,"pos":[-1792,-5760],"params":["Inherit","False","FLOAT","3","1","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleDivideOpNode, AmplifyShaderEditor","id":2553,"pos":[-1280,-6400],"params":["Inherit","False","2","0","FLOAT","0","False","1","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2545,"pos":[-7936,-4736],"params":["Inherit","False","If Model Data","-1","","251632","d269c9c511ff160419055604aade1e70","1,32,1","9","3","OBJECT","0","False","17","OBJECT","0","False","19","FLOAT","0","False","33","OBJECT","0","False","27","OBJECT","0","False","28","OBJECT","0","False","29","OBJECT","0","False","30","OBJECT","0","False","31","FLOAT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2595,"pos":[-5888,-4992],"params":["Inherit","False","Block Vertex","-1","","251812","79888a886ac7456468e9ffe3eda11f4f","0","2","1894","OBJECT","0,0,0,0","False","1896","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","1895","OBJECT","1897"]}
{"type":"AmplifyShaderEditor.SimpleDivideOpNode, AmplifyShaderEditor","id":2577,"pos":[-1280,-6016],"params":["Inherit","False","2","0","FLOAT","0","False","1","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor","id":2554,"pos":[-1152,-6400],"params":["Inherit","False","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2373,"pos":[-7616,-4736],"params":["Half","False","Model Frag","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2523,"pos":[-5504,-4992],"params":["Inherit","False","Block Pivots Sub","-1","","251816","186f08b1bbe15894d9c677d50398679b","0","3","224","OBJECT","0,0,0,0","False","146","OBJECT","0,0,0,0","False","231","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","229","OBJECT","232"]}
{"type":"AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor","id":2573,"pos":[-1152,-6016],"params":["Inherit","False","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2557,"pos":[-896,-6400],"params":["Inherit","False","Math Remap","-1","","251820","5eda8a2bb94ebef4ab0e43d19291cd8b","3,18,0,21,1,14,1","4","6","FLOAT","0","False","7","FLOAT","1","False","8","FLOAT","1","False","19","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2525,"pos":[-5120,-4992],"params":["Inherit","False","Block Blanket Conform","126","","251922","3ce1684c4351aeb42b79a955aa483301","2,389,0,377,1","3","146","OBJECT","0,0,0,0","False","397","OBJECT","0,0,0,0","False","186","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","398","OBJECT","399"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2374,"pos":[-1664,-4992],"params":["Inherit","False","2373","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2574,"pos":[-896,-6016],"params":["Inherit","False","Math Remap","-1","","251933","5eda8a2bb94ebef4ab0e43d19291cd8b","3,18,0,21,1,14,1","4","6","FLOAT","0","False","7","FLOAT","1","False","8","FLOAT","0.9999","False","19","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2558,"pos":[-576,-6400],"params":["Half","False","Global_Blend","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2526,"pos":[-4736,-4992],"params":["Inherit","False","Block Transform","-1","","251934","5ac6202bdddd8b34a85c261af6b8de8b","0","3","146","OBJECT","0,0,0,0","False","1620","OBJECT","0,0,0,0","False","1619","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","1617","OBJECT","1618"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2561,"pos":[-1408,-4992],"params":["Inherit","False","Block Global","21","","251945","212e17d4006dc88449d56ce0340cb5ff","46,385,1,692,1,667,1,276,1,396,1,417,1,282,1,402,1,560,1,285,1,283,1,308,1,650,1,483,0,484,0,486,0,488,0,561,0,487,0,652,0,482,0,485,0,668,0,691,0,315,1,703,1,719,1,716,1,715,1,709,1,710,1,706,1,701,1,704,1,707,1,655,0,311,1,317,1,421,1,321,1,398,1,700,0,694,1,713,1,404,1,675,0","1","206","OBJECT","0,0,0,0","False","1","OBJECT","151"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2427,"pos":[-384,-2752],"params":["Inherit","False","FLOAT2","0","1","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2435,"pos":[-384,-1920],"params":["Inherit","False","FLOAT2","0","1","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2578,"pos":[-576,-6016],"params":["Half","False","Global_Edge","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2527,"pos":[-4352,-4992],"params":["Inherit","False","Block Pivots Add","-1","","252046","016babe9e3e643242aa4d123a988150c","0","3","146","OBJECT","0,0,0,0","False","225","OBJECT","0,0,0,0","False","227","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","226","OBJECT","228"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2419,"pos":[-1024,-4992],"params":["Inherit","False","Break Global Data","-1","","252050","5f0a1052cfecd8a4da416d9b8f1dc3bc","0","1","6","OBJECT","0","False","13","OBJECT","26","FLOAT","14","FLOAT4","27","FLOAT4","38","FLOAT4","0","FLOAT4","16","FLOAT4","32","FLOAT4","19","FLOAT4","18","FLOAT4","36","FLOAT4","34","FLOAT4","24","FLOAT4","39"]}
{"type":"AmplifyShaderEditor.ColorNode, AmplifyShaderEditor","id":2564,"pos":[-384,-4992],"params":["Inherit","False","Constant","_Color2","Color 2","26","0","Create","True","0","0","0","False","0","False","Object","-1","","1,0,0.3576326,0","0,0,0,0","True","False","0","6","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.ColorNode, AmplifyShaderEditor","id":2565,"pos":[-384,-4848],"params":["Inherit","False","Constant","_Color3","Color 2","26","0","Create","True","0","0","0","False","0","False","Object","-1","","0,0.5347826,1,0","0,0,0,0","True","False","0","6","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2566,"pos":[-384,-4704],"params":["Inherit","False","2558","Global_Blend","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2428,"pos":[-384,-2624],"params":["Inherit","False","FLOAT3","2","2","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":2539,"pos":[-384,-2560],"params":["Inherit","False","Constant","_Float16","Float 16","26","0","Create","True","0","0","0","False","0","False","Object","-1","","0.1","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor","id":2536,"pos":[-128,-2752],"params":["Inherit","False","FLOAT3","4","0","FLOAT2","0,0","False","1","FLOAT","0","False","2","FLOAT","0","False","3","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor","id":2501,"pos":[0,-1920],"params":["Inherit","False","FLOAT3","4","0","FLOAT2","0,0","False","1","FLOAT","0","False","2","FLOAT","0","False","3","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2528,"pos":[-4032,-4992],"params":["Half","False","Vertex Data","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":2567,"pos":[0,-4992],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2585,"pos":[0,-4736],"params":["Inherit","False","2578","Global_Edge","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.ColorNode, AmplifyShaderEditor","id":2584,"pos":[0,-5184],"params":["Inherit","False","Constant","_Color4","Color 2","26","0","Create","True","0","0","0","False","0","False","Object","-1","","0.3867925,0.3867925,0.3867925,0","0,0,0,0","True","False","0","6","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2406,"pos":[-384,-4608],"params":["Inherit","False","FLOAT3","0","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2407,"pos":[-384,-4512],"params":["Inherit","False","FLOAT3","1","1","1","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2589,"pos":[-384,-4400],"params":["Inherit","False","FLOAT3","2","2","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":2537,"pos":[-128,-2624],"params":["Inherit","False","2","2","0","FLOAT3","0,0,0","False","1","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2425,"pos":[-384,-2944],"params":["Inherit","False","FLOAT3","3","3","3","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":2542,"pos":[256,-2752],"params":["Inherit","False","2","2","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2603,"pos":[-384,-4160],"params":["Inherit","False","FLOAT3","3","3","3","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2411,"pos":[-384,-3456],"params":["Inherit","False","FLOAT3","0","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2412,"pos":[-384,-3392],"params":["Inherit","False","FLOAT3","1","1","1","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2415,"pos":[-384,-3328],"params":["Inherit","False","FLOAT3","2","2","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2416,"pos":[-384,-3264],"params":["Inherit","False","FLOAT3","3","3","3","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2409,"pos":[-384,-3904],"params":["Inherit","False","FLOAT3","3","3","3","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2408,"pos":[-384,-3968],"params":["Inherit","False","FLOAT3","0","1","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2609,"pos":[-384,-3712],"params":["Inherit","False","FLOAT3","0","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2424,"pos":[-384,-3008],"params":["Inherit","False","FLOAT3","0","1","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2438,"pos":[-384,-1856],"params":["Inherit","False","FLOAT3","2","2","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":2541,"pos":[256,-1920],"params":["Inherit","False","2","2","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2610,"pos":[-384,-2176],"params":["Inherit","False","FLOAT3","0","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2439,"pos":[-384,-1792],"params":["Inherit","False","FLOAT3","3","3","3","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2613,"pos":[-384,-1536],"params":["Inherit","False","FLOAT3","0","1","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2614,"pos":[-384,-1472],"params":["Inherit","False","FLOAT3","0","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2615,"pos":[-384,-1408],"params":["Inherit","False","FLOAT3","1","1","1","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2616,"pos":[-384,-1344],"params":["Inherit","False","FLOAT3","2","2","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2617,"pos":[-384,-1280],"params":["Inherit","False","FLOAT3","3","3","3","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2433,"pos":[-384,-2496],"params":["Inherit","False","FLOAT3","3","3","3","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2602,"pos":[-384,-4224],"params":["Inherit","False","FLOAT3","0","1","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2598,"pos":[-3584,-4864],"params":["Inherit","False","2521","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2599,"pos":[-3584,-4928],"params":["Inherit","False","2373","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2601,"pos":[-3584,-4992],"params":["Inherit","False","2528","Vertex Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2477,"pos":[512,-4608],"params":["Inherit","False","Tool Debug Index","-1","","252051","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","2","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":2583,"pos":[256,-4992],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2478,"pos":[512,-4512],"params":["Inherit","False","Tool Debug Index","-1","","252052","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","3","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2588,"pos":[512,-4416],"params":["Inherit","False","Tool Debug Index","-1","","252053","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","4","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2604,"pos":[512,-4224],"params":["Inherit","False","Tool Debug Index","-1","","252120","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","6","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2605,"pos":[512,-4128],"params":["Inherit","False","Tool Debug Index","-1","","252121","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","7","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2487,"pos":[512,-3872],"params":["Inherit","False","Tool Debug Index","-1","","252122","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","10","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2486,"pos":[512,-3968],"params":["Inherit","False","Tool Debug Index","-1","","252123","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","9","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2608,"pos":[512,-3712],"params":["Inherit","False","Tool Debug Index","-1","","252124","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","12","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2479,"pos":[512,-3456],"params":["Inherit","False","Tool Debug Index","-1","","252125","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","14","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2480,"pos":[512,-3360],"params":["Inherit","False","Tool Debug Index","-1","","252126","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","15","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2481,"pos":[512,-3264],"params":["Inherit","False","Tool Debug Index","-1","","252127","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","16","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2482,"pos":[512,-3168],"params":["Inherit","False","Tool Debug Index","-1","","252128","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","17","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2488,"pos":[512,-3008],"params":["Inherit","False","Tool Debug Index","-1","","252129","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","19","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2489,"pos":[512,-2912],"params":["Inherit","False","Tool Debug Index","-1","","252130","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","20","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2483,"pos":[512,-2752],"params":["Inherit","False","Tool Debug Index","-1","","252131","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","22","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2484,"pos":[512,-2624],"params":["Inherit","False","Tool Debug Index","-1","","252132","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","23","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2612,"pos":[512,-2176],"params":["Inherit","False","Tool Debug Index","-1","","252133","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","26","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2485,"pos":[512,-2496],"params":["Inherit","False","Tool Debug Index","-1","","252134","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","24","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2474,"pos":[512,-1920],"params":["Inherit","False","Tool Debug Index","-1","","252135","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","30","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2475,"pos":[512,-1824],"params":["Inherit","False","Tool Debug Index","-1","","252136","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","31","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2476,"pos":[512,-1728],"params":["Inherit","False","Tool Debug Index","-1","","252137","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","32","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2618,"pos":[512,-1536],"params":["Inherit","False","Tool Debug Index","-1","","252138","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","34","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2619,"pos":[512,-1448],"params":["Inherit","False","Tool Debug Index","-1","","252139","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","35","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2620,"pos":[512,-1360],"params":["Inherit","False","Tool Debug Index","-1","","252140","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","36","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2621,"pos":[512,-1272],"params":["Inherit","False","Tool Debug Index","-1","","252141","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","37","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2622,"pos":[512,-1184],"params":["Inherit","False","Tool Debug Index","-1","","252142","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","38","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2600,"pos":[-3328,-4992],"params":["Inherit","False","Block Visual","-1","","252143","9511980f05dcfdf4d8967cd55c0d1784","1,1910,1","3","1904","OBJECT","0,0,0,0","False","1894","OBJECT","0,0,0,0","False","1896","OBJECT","0,0,0,0","False","3","OBJECT","1900","OBJECT","1895","OBJECT","1897"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2397,"pos":[896,-4608],"params":["Inherit","False","3","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2586,"pos":[512,-4992],"params":["Inherit","False","Tool Debug Index","-1","","252147","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2426,"pos":[896,-3008],"params":["Inherit","False","2","2","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2434,"pos":[896,-2752],"params":["Inherit","False","4","4","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","3","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2606,"pos":[896,-4224],"params":["Inherit","False","2","2","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2421,"pos":[896,-3968],"params":["Inherit","False","3","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2420,"pos":[896,-3456],"params":["Inherit","False","4","4","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","3","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2441,"pos":[896,-1920],"params":["Inherit","False","3","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2623,"pos":[896,-1536],"params":["Inherit","False","5","5","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","3","FLOAT3","0,0,0","False","4","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2380,"pos":[-2944,-4992],"params":["Inherit","False","Block Main","100","","252148","b04cfed9a7b4c0841afdb49a38c282c5","13,65,1,136,1,41,1,133,1,40,1,344,0,347,0,342,0,346,0,343,0,345,0,329,1,408,1","3","430","OBJECT","0,0,0,0","False","225","OBJECT","0,0,0,0","False","414","OBJECT","0,0,0,0","False","3","OBJECT","106","OBJECT","417","OBJECT","415"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2443,"pos":[1280,-4992],"params":["Inherit","False","9","9","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","3","FLOAT3","0,0,0","False","4","FLOAT3","0,0,0","False","5","FLOAT3","0,0,0","False","6","FLOAT3","0,0,0","False","7","FLOAT3","0,0,0","False","8","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2505,"pos":[-2624,-4992],"params":["Half","False","Visual Data","-1","True","1","0","OBJECT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2399,"pos":[1472,-4992],"params":["Half","False","Final_Debug","-1","True","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2400,"pos":[2688,-4992],"params":["Inherit","False","2399","Final_Debug","1","0","OBJECT","","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2506,"pos":[2688,-4864],"params":["Inherit","False","2528","Vertex Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2456,"pos":[2688,-4928],"params":["Inherit","False","2505","Visual Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.ConditionalIfNode, AmplifyShaderEditor","id":1774,"pos":[-880,2944],"params":["Inherit","False","True","5","0","FLOAT","0","False","1","FLOAT","1","False","2","FLOAT","0","False","3","FLOAT","0","False","4","COLOR","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TFHCRemapNode, AmplifyShaderEditor","id":1803,"pos":[-1344,2944],"params":["Inherit","False","5","0","FLOAT","0","False","1","FLOAT","-1","False","2","FLOAT","1","False","3","FLOAT","0.3","False","4","FLOAT","0.7","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":1772,"pos":[-1088,3072],"params":["Float","False","Constant","_Float3","Float 3","31","0","Create","True","0","0","0","False","0","False","Object","-1","","24","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleTimeNode, AmplifyShaderEditor","id":1843,"pos":[-1632,2944],"params":["Inherit","False","1","0","FLOAT","1","False","5","FLOAT","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":1771,"pos":[-1088,2944],"params":["Inherit","False","-1","","1","0","OBJECT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SinOpNode, AmplifyShaderEditor","id":1800,"pos":[-1472,2944],"params":["Inherit","False","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":1804,"pos":[-1792,2944],"params":["Inherit","False","Constant","_Float1","Float 1","0","0","Create","True","0","0","0","False","0","False","Object","-1","","3","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2203,"pos":[3328,-5120],"params":["Inherit","False","Base Compile","-1","","252187","e67c8238031dbf04ab79a5d4d63d1b4f","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2587,"pos":[2944,-4992],"params":["Inherit","False","Tool Debug Color","0","","252188","d992d3ed4a7539141ba053d3e0c12277","0","3","80","FLOAT3","0,0,0","False","106","OBJECT","0,0,0","False","107","OBJECT","0,0,0","False","5","FLOAT","114","FLOAT3","0","FLOAT3","113","FLOAT3","148","FLOAT4","149"]}
{"type":"AmplifyShaderEditor.GammaToLinearNode, AmplifyShaderEditor","id":2540,"pos":[256,-2592],"params":["Inherit","False","0","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FractNode, AmplifyShaderEditor","id":2529,"pos":[32,-2656],"params":["Inherit","False","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor","id":2442,"pos":[-224,-1920],"params":["Inherit","False","3","0","FLOAT2","0,0","False","1","FLOAT","0.5","False","2","FLOAT","0.5","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2355,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","3","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ForwardAdd","0","2","ForwardAdd","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","4","1","False","","1","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","","False","False","False","True","1","LightMode=ForwardAdd","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2356,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","3","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","Deferred","0","3","Deferred","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=Deferred","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2357,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","3","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","Meta","0","4","Meta","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=Meta","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2358,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","3","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ShadowCaster","0","5","ShadowCaster","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","True","3","False","","False","False","True","1","LightMode=ShadowCaster","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2353,"pos":[2944,-5008],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","3","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ExtraPrePass","0","0","ExtraPrePass","5","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2354,"pos":[3328,-5008],"params":["Float","False","True","-1","3","","0","3","Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Global","28cd5599e02859647ae1798e4fcaef6c","True","ForwardBase","0","1","ForwardBase","15","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","2","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","40","Category","0","0","Workflow","0","638874882197810641","Surface","0","0","  Blend","0","0","  Dither Shadows","1","0","Two Sided","0","638874603607655403","Deferred Pass","1","0","Normal Space","0","0","Transmission","0","0","  Transmission Shadow","0.5,False,","0","Translucency","0","0","  Translucency Strength","1,False,","0","  Normal Distortion","0.5,False,","0","  Scattering","2,False,","0","  Direct","0.9,False,","0","  Ambient","0.1,False,","0","  Shadow","0.5,False,","0","Cast Shadows","0","638814711411603618","Receive Shadows","0","638814711415148256","Receive Specular","0","638814711419031593","GPU Instancing","1","638874881145939632","LOD CrossFade","0","638814711429956434","Built-in Fog","0","638814711441065168","Ambient Light","0","638814711449050123","Meta Pass","0","638814711456998358","Add Pass","0","638814711466594157","Override Baked GI","0","0","Write Depth","0","0","Extra Pre Pass","0","0","Tessellation","0","0","  Phong","0","0","  Strength","0.5,False,","0","  Type","0","0","  Tess","16,False,","0","  Min","10,False,","0","  Max","25,False,","0","  Edge Length","16,False,","0","  Max Displacement","25,False,","0","Disable Batching","0","638874882298697380","Vertex Position","0","638874601191422915","0","8","False","True","False","True","False","False","True","True","False","","True","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2546,"pos":[2688,-4948],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","3","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","SceneSelectionPass","0","6","SceneSelectionPass","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","False","False","False","True","1","LightMode=SceneSelectionPass","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2547,"pos":[3328,-5008],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","3","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ScenePickingPass","0","7","ScenePickingPass","1","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","False","False","False","True","1","LightMode=Picking","False","False","0","","0","0","Standard","0","False","0"]}
{"wire":[2560,206,2519,0]}
{"wire":[2491,33,2372,128]}
{"wire":[2491,27,2372,128]}
{"wire":[2491,28,2372,128]}
{"wire":[2491,29,2372,128]}
{"wire":[2491,30,2492,128]}
{"wire":[2491,31,2497,0]}
{"wire":[2549,0,2563,145]}
{"wire":[2544,0,2543,0]}
{"wire":[2521,0,2560,151]}
{"wire":[2377,0,2491,0]}
{"wire":[2570,0,2582,148]}
{"wire":[2550,0,2563,145]}
{"wire":[2552,0,2559,0]}
{"wire":[2552,1,2549,0]}
{"wire":[2568,0,2581,0]}
{"wire":[2568,1,2570,0]}
{"wire":[2571,0,2582,148]}
{"wire":[2553,0,2552,0]}
{"wire":[2553,1,2550,0]}
{"wire":[2545,33,2372,314]}
{"wire":[2545,27,2372,314]}
{"wire":[2545,28,2372,314]}
{"wire":[2545,29,2372,314]}
{"wire":[2545,30,2492,314]}
{"wire":[2545,31,2497,0]}
{"wire":[2595,1894,2596,0]}
{"wire":[2595,1896,2597,0]}
{"wire":[2577,0,2568,0]}
{"wire":[2577,1,2571,0]}
{"wire":[2554,0,2553,0]}
{"wire":[2373,0,2545,0]}
{"wire":[2523,224,2595,128]}
{"wire":[2523,146,2595,1895]}
{"wire":[2523,231,2595,1897]}
{"wire":[2573,0,2577,0]}
{"wire":[2557,6,2554,0]}
{"wire":[2557,8,2563,150]}
{"wire":[2525,146,2523,128]}
{"wire":[2525,397,2523,229]}
{"wire":[2525,186,2523,232]}
{"wire":[2574,6,2573,0]}
{"wire":[2558,0,2557,0]}
{"wire":[2526,146,2525,128]}
{"wire":[2526,1620,2525,398]}
{"wire":[2526,1619,2525,399]}
{"wire":[2561,206,2374,0]}
{"wire":[2427,0,2419,18]}
{"wire":[2435,0,2419,24]}
{"wire":[2578,0,2574,0]}
{"wire":[2527,146,2526,128]}
{"wire":[2527,225,2526,1617]}
{"wire":[2527,227,2526,1618]}
{"wire":[2419,6,2561,151]}
{"wire":[2428,0,2419,18]}
{"wire":[2536,0,2427,0]}
{"wire":[2501,0,2435,0]}
{"wire":[2528,0,2527,128]}
{"wire":[2567,0,2564,0]}
{"wire":[2567,1,2565,0]}
{"wire":[2567,2,2566,0]}
{"wire":[2406,0,2419,27]}
{"wire":[2407,0,2419,27]}
{"wire":[2589,0,2419,27]}
{"wire":[2537,0,2428,0]}
{"wire":[2537,1,2539,0]}
{"wire":[2425,0,2419,19]}
{"wire":[2542,0,2536,0]}
{"wire":[2542,1,2536,0]}
{"wire":[2603,0,2419,38]}
{"wire":[2411,0,2419,16]}
{"wire":[2412,0,2419,16]}
{"wire":[2415,0,2419,16]}
{"wire":[2416,0,2419,16]}
{"wire":[2409,0,2419,0]}
{"wire":[2408,0,2419,0]}
{"wire":[2609,0,2419,32]}
{"wire":[2424,0,2419,19]}
{"wire":[2438,0,2419,24]}
{"wire":[2541,0,2501,0]}
{"wire":[2541,1,2501,0]}
{"wire":[2610,0,2419,34]}
{"wire":[2439,0,2419,24]}
{"wire":[2613,0,2419,39]}
{"wire":[2614,0,2419,39]}
{"wire":[2615,0,2419,39]}
{"wire":[2616,0,2419,39]}
{"wire":[2617,0,2419,39]}
{"wire":[2433,0,2419,18]}
{"wire":[2602,0,2419,38]}
{"wire":[2477,39,2406,0]}
{"wire":[2583,0,2584,0]}
{"wire":[2583,1,2567,0]}
{"wire":[2583,2,2585,0]}
{"wire":[2478,39,2407,0]}
{"wire":[2588,39,2589,0]}
{"wire":[2604,39,2602,0]}
{"wire":[2605,39,2603,0]}
{"wire":[2487,39,2409,0]}
{"wire":[2486,39,2408,0]}
{"wire":[2608,39,2609,0]}
{"wire":[2479,39,2411,0]}
{"wire":[2480,39,2412,0]}
{"wire":[2481,39,2415,0]}
{"wire":[2482,39,2416,0]}
{"wire":[2488,39,2424,0]}
{"wire":[2489,39,2425,0]}
{"wire":[2483,39,2542,0]}
{"wire":[2484,39,2537,0]}
{"wire":[2612,39,2610,0]}
{"wire":[2485,39,2433,0]}
{"wire":[2474,39,2541,0]}
{"wire":[2475,39,2438,0]}
{"wire":[2476,39,2439,0]}
{"wire":[2618,39,2613,0]}
{"wire":[2619,39,2614,0]}
{"wire":[2620,39,2615,0]}
{"wire":[2621,39,2616,0]}
{"wire":[2622,39,2617,0]}
{"wire":[2600,1904,2601,0]}
{"wire":[2600,1894,2599,0]}
{"wire":[2600,1896,2598,0]}
{"wire":[2397,0,2477,0]}
{"wire":[2397,1,2478,0]}
{"wire":[2397,2,2588,0]}
{"wire":[2586,39,2583,0]}
{"wire":[2426,0,2488,0]}
{"wire":[2426,1,2489,0]}
{"wire":[2434,0,2483,0]}
{"wire":[2434,1,2484,0]}
{"wire":[2434,2,2485,0]}
{"wire":[2434,3,2612,0]}
{"wire":[2606,0,2604,0]}
{"wire":[2606,1,2605,0]}
{"wire":[2421,0,2486,0]}
{"wire":[2421,1,2487,0]}
{"wire":[2421,2,2608,0]}
{"wire":[2420,0,2479,0]}
{"wire":[2420,1,2480,0]}
{"wire":[2420,2,2481,0]}
{"wire":[2420,3,2482,0]}
{"wire":[2441,0,2474,0]}
{"wire":[2441,1,2475,0]}
{"wire":[2441,2,2476,0]}
{"wire":[2623,0,2618,0]}
{"wire":[2623,1,2619,0]}
{"wire":[2623,2,2620,0]}
{"wire":[2623,3,2621,0]}
{"wire":[2623,4,2622,0]}
{"wire":[2380,430,2600,1900]}
{"wire":[2380,225,2600,1895]}
{"wire":[2380,414,2600,1897]}
{"wire":[2443,0,2586,0]}
{"wire":[2443,1,2397,0]}
{"wire":[2443,2,2606,0]}
{"wire":[2443,3,2421,0]}
{"wire":[2443,4,2420,0]}
{"wire":[2443,5,2426,0]}
{"wire":[2443,6,2434,0]}
{"wire":[2443,7,2441,0]}
{"wire":[2443,8,2623,0]}
{"wire":[2505,0,2380,106]}
{"wire":[2399,0,2443,0]}
{"wire":[1774,0,1771,0]}
{"wire":[1774,1,1772,0]}
{"wire":[1774,3,1803,0]}
{"wire":[1803,0,1800,0]}
{"wire":[1843,0,1804,0]}
{"wire":[1800,0,1843,0]}
{"wire":[2587,80,2400,0]}
{"wire":[2587,106,2456,0]}
{"wire":[2587,107,2506,0]}
{"wire":[2540,0,2537,0]}
{"wire":[2529,0,2537,0]}
{"wire":[2442,0,2435,0]}
{"wire":[2354,0,2587,114]}
{"wire":[2354,3,2587,114]}
{"wire":[2354,5,2587,114]}
{"wire":[2354,2,2587,0]}
{"wire":[2354,15,2587,113]}
ASEEND*/
//CHKSM=3D295DF2AA51A68CEF496F38F19B9740D9FFFC98