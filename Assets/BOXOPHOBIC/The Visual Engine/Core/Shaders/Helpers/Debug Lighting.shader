// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Lighting"
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
		_IsLightingType( "_IsLightingType", Float ) = 0
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
				#define ASE_NO_AMBIENT 1
				#define ASE_ABSOLUTE_VERTEX_POS 1
				#pragma multi_compile_instancing
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
					float4 ase_color : COLOR;
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
				uniform float _IsLightingType;
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

					TVEVertexData Data16_g251543 =(TVEVertexData)0;
					float In_Dummy16_g251543 = 0.0;
					TVEVertexData Data16_g251538 =(TVEVertexData)0;
					float In_Dummy16_g251538 = 0.0;
					TVEModelData Data16_g240700 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g240682 = _ObjectCoordMode;
					#else
					float staticSwitch343_g240682 = _ObjectCoordMode;
					#endif
					half Dummy207_g240682 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g240682 );
					float temp_output_14_0_g240700 = Dummy207_g240682;
					float In_Dummy16_g240700 = temp_output_14_0_g240700;
					float3 PositionOS131_g240682 = v.vertex.xyz;
					float3 temp_output_4_0_g240700 = PositionOS131_g240682;
					float3 In_PositionOS16_g240700 = temp_output_4_0_g240700;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g240682 = ase_positionWS;
					float3 vertexToFrag73_g240682 = temp_output_104_7_g240682;
					float3 PositionWS122_g240682 = vertexToFrag73_g240682;
					float3 In_PositionWS16_g240700 = PositionWS122_g240682;
					float4x4 break19_g240685 = unity_ObjectToWorld;
					float3 appendResult20_g240685 = (float3(break19_g240685[ 0 ][ 3 ] , break19_g240685[ 1 ][ 3 ] , break19_g240685[ 2 ][ 3 ]));
					float3 temp_output_340_7_g240682 = appendResult20_g240685;
					float4x4 break19_g240687 = unity_ObjectToWorld;
					float3 appendResult20_g240687 = (float3(break19_g240687[ 0 ][ 3 ] , break19_g240687[ 1 ][ 3 ] , break19_g240687[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g240683 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g240682 = PositionOS131_g240682;
					float3 appendResult234_g240682 = (float3(break233_g240682.x , 0.0 , break233_g240682.z));
					float3 break413_g240682 = PositionOS131_g240682;
					float3 appendResult414_g240682 = (float3(break413_g240682.x , break413_g240682.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g240689 = appendResult414_g240682;
					#else
					float3 staticSwitch65_g240689 = appendResult234_g240682;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g240682 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g240682 = appendResult60_g240683;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g240682 = staticSwitch65_g240689;
					#else
					float3 staticSwitch229_g240682 = _Vector0;
					#endif
					float3 PivotOS149_g240682 = staticSwitch229_g240682;
					float3 temp_output_122_0_g240687 = PivotOS149_g240682;
					float3 PivotsOnlyWS105_g240687 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g240687 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g240682 = ( appendResult20_g240687 + PivotsOnlyWS105_g240687 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g240682 = temp_output_340_7_g240682;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g240682 = temp_output_341_7_g240682;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g240682 = temp_output_341_7_g240682;
					#else
					float3 staticSwitch236_g240682 = temp_output_340_7_g240682;
					#endif
					float3 vertexToFrag76_g240682 = staticSwitch236_g240682;
					float3 PivotWS121_g240682 = vertexToFrag76_g240682;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g240682 = ( PositionWS122_g240682 - PivotWS121_g240682 );
					#else
					float3 staticSwitch204_g240682 = PositionWS122_g240682;
					#endif
					float3 PositionWO132_g240682 = ( staticSwitch204_g240682 - TVE_WorldOrigin );
					float3 In_PositionWO16_g240700 = PositionWO132_g240682;
					float3 In_PivotOS16_g240700 = PivotOS149_g240682;
					float3 In_PivotWS16_g240700 = PivotWS121_g240682;
					float3 PivotWO133_g240682 = ( PivotWS121_g240682 - TVE_WorldOrigin );
					float3 In_PivotWO16_g240700 = PivotWO133_g240682;
					half3 NormalOS134_g240682 = v.normal;
					float3 temp_output_21_0_g240700 = NormalOS134_g240682;
					float3 In_NormalOS16_g240700 = temp_output_21_0_g240700;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g240682 = normalizedWorldNormal;
					float3 In_NormalWS16_g240700 = NormalWS95_g240682;
					half4 TangentlOS153_g240682 = v.tangent;
					float4 temp_output_6_0_g240700 = TangentlOS153_g240682;
					float4 In_TangentOS16_g240700 = temp_output_6_0_g240700;
					float3 normalizeResult296_g240682 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g240682 ) );
					half3 ViewDirWS169_g240682 = normalizeResult296_g240682;
					float3 In_ViewDirWS16_g240700 = ViewDirWS169_g240682;
					float4 appendResult397_g240682 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g240682 = appendResult397_g240682;
					float4 In_CoordsData16_g240700 = CoordsData398_g240682;
					half4 VertexMasks171_g240682 = v.ase_color;
					float4 In_VertexData16_g240700 = VertexMasks171_g240682;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g240694 = (PositionOS131_g240682).z;
					#else
					float staticSwitch65_g240694 = (PositionOS131_g240682).y;
					#endif
					half Object_HeightValue267_g240682 = _ObjectHeightValue;
					half Bounds_HeightMask274_g240682 = saturate( ( staticSwitch65_g240694 / Object_HeightValue267_g240682 ) );
					half3 Position387_g240682 = PositionOS131_g240682;
					half Height387_g240682 = Object_HeightValue267_g240682;
					half Object_RadiusValue268_g240682 = _ObjectRadiusValue;
					half Radius387_g240682 = Object_RadiusValue268_g240682;
					half localCapsuleMaskYUp387_g240682 = CapsuleMaskYUp( Position387_g240682 , Height387_g240682 , Radius387_g240682 );
					half3 Position408_g240682 = PositionOS131_g240682;
					half Height408_g240682 = Object_HeightValue267_g240682;
					half Radius408_g240682 = Object_RadiusValue268_g240682;
					half localCapsuleMaskZUp408_g240682 = CapsuleMaskZUp( Position408_g240682 , Height408_g240682 , Radius408_g240682 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g240699 = saturate( localCapsuleMaskZUp408_g240682 );
					#else
					float staticSwitch65_g240699 = saturate( localCapsuleMaskYUp387_g240682 );
					#endif
					half Bounds_SphereMask282_g240682 = staticSwitch65_g240699;
					float4 appendResult253_g240682 = (float4(Bounds_HeightMask274_g240682 , Bounds_SphereMask282_g240682 , 1.0 , 1.0));
					half4 MasksData254_g240682 = appendResult253_g240682;
					float4 In_MasksData16_g240700 = MasksData254_g240682;
					float temp_output_17_0_g240693 = _ObjectPhaseMode;
					float Option70_g240693 = temp_output_17_0_g240693;
					float4 temp_output_3_0_g240693 = v.ase_color;
					float4 Channel70_g240693 = temp_output_3_0_g240693;
					float localSwitchChannel470_g240693 = SwitchChannel4( Option70_g240693 , Channel70_g240693 );
					half Phase_Value372_g240682 = localSwitchChannel470_g240693;
					float3 break319_g240682 = PivotWO133_g240682;
					half Pivot_Position322_g240682 = ( break319_g240682.x + break319_g240682.z );
					half Phase_Position357_g240682 = ( Phase_Value372_g240682 + Pivot_Position322_g240682 );
					float temp_output_248_0_g240682 = frac( Phase_Position357_g240682 );
					float4 appendResult177_g240682 = (float4((frac( ( Phase_Position357_g240682 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g240682));
					half4 Phase_Data176_g240682 = appendResult177_g240682;
					float4 In_PhaseData16_g240700 = Phase_Data176_g240682;
					BuildModelVertData( Data16_g240700 , In_Dummy16_g240700 , In_PositionOS16_g240700 , In_PositionWS16_g240700 , In_PositionWO16_g240700 , In_PivotOS16_g240700 , In_PivotWS16_g240700 , In_PivotWO16_g240700 , In_NormalOS16_g240700 , In_NormalWS16_g240700 , In_TangentOS16_g240700 , In_ViewDirWS16_g240700 , In_CoordsData16_g240700 , In_VertexData16_g240700 , In_MasksData16_g240700 , In_PhaseData16_g240700 );
					TVEModelData Data15_g251539 =(TVEModelData)Data16_g240700;
					float Out_Dummy15_g251539 = 0.0;
					float3 Out_PositionOS15_g251539 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251539 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251539 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251539 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251539 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251539 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251539 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251539 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251539 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251539 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251539 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251539 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251539 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251539 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251539 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251539 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251539 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251539 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251539 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251539 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251539 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251539 , Out_Dummy15_g251539 , Out_PositionOS15_g251539 , Out_PositionWS15_g251539 , Out_PositionWO15_g251539 , Out_PositionRawOS15_g251539 , Out_PivotOS15_g251539 , Out_PivotWS15_g251539 , Out_PivotWO15_g251539 , Out_NormalOS15_g251539 , Out_NormalWS15_g251539 , Out_NormalRawOS15_g251539 , Out_TangentOS15_g251539 , Out_TangentWS15_g251539 , Out_BitangentWS15_g251539 , Out_ViewDirWS15_g251539 , Out_CoordsData15_g251539 , Out_VertexData15_g251539 , Out_MasksData15_g251539 , Out_PhaseData15_g251539 , Out_TransformData15_g251539 , Out_RotationData15_g251539 , Out_Interpolator15_g251539 );
					float3 In_PositionOS16_g251538 = Out_PositionOS15_g251539;
					float3 In_NormalOS16_g251538 = Out_NormalOS15_g251539;
					float4 In_TangentOS16_g251538 = Out_TangentOS15_g251539;
					float4 In_TransformData16_g251538 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251538 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251538 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251538 , In_Dummy16_g251538 , In_PositionOS16_g251538 , In_NormalOS16_g251538 , In_TangentOS16_g251538 , In_TransformData16_g251538 , In_RotationData16_g251538 , In_Interpolator16_g251538 );
					TVEVertexData Data15_g251541 =(TVEVertexData)Data16_g251538;
					float Out_Dummy15_g251541 = 0.0;
					float3 Out_PositionOS15_g251541 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251541 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251541 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251541 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251541 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251541 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251541 , Out_Dummy15_g251541 , Out_PositionOS15_g251541 , Out_NormalOS15_g251541 , Out_TangentOS15_g251541 , Out_TransformData15_g251541 , Out_RotationData15_g251541 , Out_Interpolator15_g251541 );
					TVEModelData Data15_g251542 =(TVEModelData)Data15_g251539;
					float Out_Dummy15_g251542 = 0.0;
					float3 Out_PositionOS15_g251542 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251542 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251542 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251542 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251542 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251542 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251542 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251542 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251542 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251542 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251542 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251542 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251542 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251542 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251542 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251542 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251542 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251542 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251542 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251542 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251542 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251542 , Out_Dummy15_g251542 , Out_PositionOS15_g251542 , Out_PositionWS15_g251542 , Out_PositionWO15_g251542 , Out_PositionRawOS15_g251542 , Out_PivotOS15_g251542 , Out_PivotWS15_g251542 , Out_PivotWO15_g251542 , Out_NormalOS15_g251542 , Out_NormalWS15_g251542 , Out_NormalRawOS15_g251542 , Out_TangentOS15_g251542 , Out_TangentWS15_g251542 , Out_BitangentWS15_g251542 , Out_ViewDirWS15_g251542 , Out_CoordsData15_g251542 , Out_VertexData15_g251542 , Out_MasksData15_g251542 , Out_PhaseData15_g251542 , Out_TransformData15_g251542 , Out_RotationData15_g251542 , Out_Interpolator15_g251542 );
					float3 In_PositionOS16_g251543 = ( Out_PositionOS15_g251541 - Out_PivotOS15_g251542 );
					float3 In_NormalOS16_g251543 = Out_NormalOS15_g251542;
					float4 In_TangentOS16_g251543 = Out_TangentOS15_g251542;
					float4 In_TransformData16_g251543 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251543 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251543 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251543 , In_Dummy16_g251543 , In_PositionOS16_g251543 , In_NormalOS16_g251543 , In_TangentOS16_g251543 , In_TransformData16_g251543 , In_RotationData16_g251543 , In_Interpolator16_g251543 );
					TVEVertexData Data15_g251552 =(TVEVertexData)Data16_g251543;
					float Out_Dummy15_g251552 = 0.0;
					float3 Out_PositionOS15_g251552 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251552 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251552 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251552 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251552 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251552 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251552 , Out_Dummy15_g251552 , Out_PositionOS15_g251552 , Out_NormalOS15_g251552 , Out_TangentOS15_g251552 , Out_TransformData15_g251552 , Out_RotationData15_g251552 , Out_Interpolator15_g251552 );
					TVEVertexData Data16_g251553 =(TVEVertexData)Data15_g251552;
					half Dummy317_g251544 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251553 = Dummy317_g251544;
					float3 In_PositionOS16_g251553 = Out_PositionOS15_g251552;
					float3 In_NormalOS16_g251553 = Out_NormalOS15_g251552;
					float4 In_TangentOS16_g251553 = Out_TangentOS15_g251552;
					half4 Model_TransformData356_g251544 = Out_TransformData15_g251552;
					float localBuildGlobalData204_g240581 = ( 0.0 );
					TVEGlobalData Data204_g240581 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g240581 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g240581 = Dummy211_g240581;
					float4 temp_output_203_0_g240600 = TVE_CoatBaseCoord;
					TVEModelData Data16_g240690 =(TVEModelData)0;
					float In_Dummy16_g240690 = 0.0;
					float3 In_PositionWS16_g240690 = PositionWS122_g240682;
					float3 In_PositionWO16_g240690 = PositionWO132_g240682;
					float3 In_PivotWS16_g240690 = PivotWS121_g240682;
					float3 In_PivotWO16_g240690 = PivotWO133_g240682;
					float3 In_NormalWS16_g240690 = NormalWS95_g240682;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g240682 = ase_tangentWS;
					float3 In_TangentWS16_g240690 = TangentWS136_g240682;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g240682 = ase_bitangentWS;
					float3 In_BitangentWS16_g240690 = BiangentWS421_g240682;
					half3 NormalWS427_g240682 = NormalWS95_g240682;
					half3 localComputeTriplanarMasks427_g240682 = ComputeTriplanarMasks( NormalWS427_g240682 );
					half3 TriplanarWeights429_g240682 = localComputeTriplanarMasks427_g240682;
					float3 In_TriplanarWeights16_g240690 = TriplanarWeights429_g240682;
					float3 In_ViewDirWS16_g240690 = ViewDirWS169_g240682;
					float4 In_CoordsData16_g240690 = CoordsData398_g240682;
					float4 In_VertexData16_g240690 = VertexMasks171_g240682;
					float4 In_Interpolator16_g240690 = Phase_Data176_g240682;
					BuildModelFragData( Data16_g240690 , In_Dummy16_g240690 , In_PositionWS16_g240690 , In_PositionWO16_g240690 , In_PivotWS16_g240690 , In_PivotWO16_g240690 , In_NormalWS16_g240690 , In_TangentWS16_g240690 , In_BitangentWS16_g240690 , In_TriplanarWeights16_g240690 , In_ViewDirWS16_g240690 , In_CoordsData16_g240690 , In_VertexData16_g240690 , In_Interpolator16_g240690 );
					TVEModelData Data15_g240671 =(TVEModelData)Data16_g240690;
					float Out_Dummy15_g240671 = 0.0;
					float3 Out_PositionWS15_g240671 = float3( 0,0,0 );
					float3 Out_PositionWO15_g240671 = float3( 0,0,0 );
					float3 Out_PivotWS15_g240671 = float3( 0,0,0 );
					float3 Out_PivotWO15_g240671 = float3( 0,0,0 );
					float3 Out_NormalWS15_g240671 = float3( 0,0,0 );
					float3 Out_TangentWS15_g240671 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g240671 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g240671 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g240671 = float3( 0,0,0 );
					float4 Out_CoordsData15_g240671 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g240671 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g240671 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g240671 , Out_Dummy15_g240671 , Out_PositionWS15_g240671 , Out_PositionWO15_g240671 , Out_PivotWS15_g240671 , Out_PivotWO15_g240671 , Out_NormalWS15_g240671 , Out_TangentWS15_g240671 , Out_BitangentWS15_g240671 , Out_TriplanarWeights15_g240671 , Out_ViewDirWS15_g240671 , Out_CoordsData15_g240671 , Out_VertexData15_g240671 , Out_Interpolator15_g240671 );
					float3 Model_PositionWS497_g240581 = Out_PositionWS15_g240671;
					float2 Model_PositionWS_XZ143_g240581 = (Model_PositionWS497_g240581).xz;
					float3 Model_PivotWS498_g240581 = Out_PivotWS15_g240671;
					float2 Model_PivotWS_XZ145_g240581 = (Model_PivotWS498_g240581).xz;
					float2 lerpResult300_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g240600 = lerpResult300_g240581;
					float temp_output_82_0_g240598 = _GlobalCoatLayerValue;
					float temp_output_82_0_g240600 = temp_output_82_0_g240598;
					float4 tex2DArrayNode83_g240600 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240600).zw + ( (temp_output_203_0_g240600).xy * temp_output_81_0_g240600 ) ),temp_output_82_0_g240600), 0.0 );
					float4 appendResult210_g240600 = (float4(tex2DArrayNode83_g240600.rgb , tex2DArrayNode83_g240600.a));
					float4 temp_output_204_0_g240600 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g240600 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240600).zw + ( (temp_output_204_0_g240600).xy * temp_output_81_0_g240600 ) ),temp_output_82_0_g240600), 0.0 );
					float4 appendResult212_g240600 = (float4(tex2DArrayNode122_g240600.rgb , tex2DArrayNode122_g240600.a));
					float4 TVE_RenderNearPositionR628_g240581 = TVE_RenderNearPositionR;
					float temp_output_507_0_g240581 = saturate( ( distance( Model_PositionWS497_g240581 , (TVE_RenderNearPositionR628_g240581).xyz ) / (TVE_RenderNearPositionR628_g240581).w ) );
					float temp_output_7_0_g240670 = 1.0;
					float temp_output_9_0_g240670 = ( temp_output_507_0_g240581 - temp_output_7_0_g240670 );
					half TVE_RenderNearFadeValue635_g240581 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g240581 = saturate( ( temp_output_9_0_g240670 / ( ( TVE_RenderNearFadeValue635_g240581 - temp_output_7_0_g240670 ) + 0.0001 ) ) );
					float4 lerpResult131_g240600 = lerp( appendResult210_g240600 , appendResult212_g240600 , Global_TexBlend509_g240581);
					float4 temp_output_159_109_g240598 = lerpResult131_g240600;
					float4 lerpResult168_g240598 = lerp( TVE_CoatParams , temp_output_159_109_g240598 , TVE_CoatLayers[(int)temp_output_82_0_g240598]);
					float4 temp_output_589_109_g240581 = lerpResult168_g240598;
					half4 Coat_Texture302_g240581 = temp_output_589_109_g240581;
					float4 In_CoatTexture204_g240581 = Coat_Texture302_g240581;
					half4 Draw_Texture656_g240581 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g240581 = Draw_Texture656_g240581;
					float4 temp_output_203_0_g240625 = TVE_PaintBaseCoord;
					float2 lerpResult85_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g240625 = lerpResult85_g240581;
					float temp_output_82_0_g240622 = _GlobalPaintLayerValue;
					float temp_output_82_0_g240625 = temp_output_82_0_g240622;
					float4 tex2DArrayNode83_g240625 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240625).zw + ( (temp_output_203_0_g240625).xy * temp_output_81_0_g240625 ) ),temp_output_82_0_g240625), 0.0 );
					float4 appendResult210_g240625 = (float4(tex2DArrayNode83_g240625.rgb , tex2DArrayNode83_g240625.a));
					float4 temp_output_204_0_g240625 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g240625 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240625).zw + ( (temp_output_204_0_g240625).xy * temp_output_81_0_g240625 ) ),temp_output_82_0_g240625), 0.0 );
					float4 appendResult212_g240625 = (float4(tex2DArrayNode122_g240625.rgb , tex2DArrayNode122_g240625.a));
					float4 lerpResult131_g240625 = lerp( appendResult210_g240625 , appendResult212_g240625 , Global_TexBlend509_g240581);
					float4 temp_output_171_109_g240622 = lerpResult131_g240625;
					float4 lerpResult174_g240622 = lerp( TVE_PaintParams , temp_output_171_109_g240622 , TVE_PaintLayers[(int)temp_output_82_0_g240622]);
					float4 temp_output_595_109_g240581 = lerpResult174_g240622;
					half4 Paint_Texture71_g240581 = temp_output_595_109_g240581;
					float4 In_PaintTexture204_g240581 = Paint_Texture71_g240581;
					float4 temp_output_203_0_g240608 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g240608 = lerpResult104_g240581;
					float temp_output_132_0_g240606 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g240608 = temp_output_132_0_g240606;
					float4 tex2DArrayNode83_g240608 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240608).zw + ( (temp_output_203_0_g240608).xy * temp_output_81_0_g240608 ) ),temp_output_82_0_g240608), 0.0 );
					float4 appendResult210_g240608 = (float4(tex2DArrayNode83_g240608.rgb , tex2DArrayNode83_g240608.a));
					float4 temp_output_204_0_g240608 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g240608 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240608).zw + ( (temp_output_204_0_g240608).xy * temp_output_81_0_g240608 ) ),temp_output_82_0_g240608), 0.0 );
					float4 appendResult212_g240608 = (float4(tex2DArrayNode122_g240608.rgb , tex2DArrayNode122_g240608.a));
					float4 lerpResult131_g240608 = lerp( appendResult210_g240608 , appendResult212_g240608 , Global_TexBlend509_g240581);
					float4 temp_output_137_109_g240606 = lerpResult131_g240608;
					float4 lerpResult145_g240606 = lerp( TVE_AtmoParams , temp_output_137_109_g240606 , TVE_AtmoLayers[(int)temp_output_132_0_g240606]);
					float4 temp_output_590_110_g240581 = lerpResult145_g240606;
					half4 Atmo_Texture80_g240581 = temp_output_590_110_g240581;
					float4 In_AtmoTexture204_g240581 = Atmo_Texture80_g240581;
					float4 temp_output_203_0_g240676 = TVE_EffexBaseCoord;
					float2 lerpResult414_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g240676 = lerpResult414_g240581;
					float temp_output_132_0_g240674 = _GlobalEffexLayerValue;
					float temp_output_82_0_g240676 = temp_output_132_0_g240674;
					float4 tex2DArrayNode83_g240676 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240676).zw + ( (temp_output_203_0_g240676).xy * temp_output_81_0_g240676 ) ),temp_output_82_0_g240676), 0.0 );
					float4 appendResult210_g240676 = (float4(tex2DArrayNode83_g240676.rgb , tex2DArrayNode83_g240676.a));
					float4 temp_output_204_0_g240676 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g240676 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240676).zw + ( (temp_output_204_0_g240676).xy * temp_output_81_0_g240676 ) ),temp_output_82_0_g240676), 0.0 );
					float4 appendResult212_g240676 = (float4(tex2DArrayNode122_g240676.rgb , tex2DArrayNode122_g240676.a));
					float4 lerpResult131_g240676 = lerp( appendResult210_g240676 , appendResult212_g240676 , Global_TexBlend509_g240581);
					float4 temp_output_137_109_g240674 = lerpResult131_g240676;
					float4 lerpResult145_g240674 = lerp( TVE_EffexParams , temp_output_137_109_g240674 , TVE_EffexLayers[(int)temp_output_132_0_g240674]);
					float4 temp_output_731_110_g240581 = lerpResult145_g240674;
					half4 Effex_Texture420_g240581 = temp_output_731_110_g240581;
					float4 In_EffexTexture204_g240581 = Effex_Texture420_g240581;
					float4 temp_output_203_0_g240656 = TVE_GlowBaseCoord;
					float2 lerpResult247_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g240656 = lerpResult247_g240581;
					float temp_output_82_0_g240654 = _GlobalGlowLayerValue;
					float temp_output_82_0_g240656 = temp_output_82_0_g240654;
					float4 tex2DArrayNode83_g240656 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240656).zw + ( (temp_output_203_0_g240656).xy * temp_output_81_0_g240656 ) ),temp_output_82_0_g240656), 0.0 );
					float4 appendResult210_g240656 = (float4(tex2DArrayNode83_g240656.rgb , tex2DArrayNode83_g240656.a));
					float4 temp_output_204_0_g240656 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g240656 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240656).zw + ( (temp_output_204_0_g240656).xy * temp_output_81_0_g240656 ) ),temp_output_82_0_g240656), 0.0 );
					float4 appendResult212_g240656 = (float4(tex2DArrayNode122_g240656.rgb , tex2DArrayNode122_g240656.a));
					float4 lerpResult131_g240656 = lerp( appendResult210_g240656 , appendResult212_g240656 , Global_TexBlend509_g240581);
					float4 temp_output_159_109_g240654 = lerpResult131_g240656;
					float4 lerpResult167_g240654 = lerp( TVE_GlowParams , temp_output_159_109_g240654 , TVE_GlowLayers[(int)temp_output_82_0_g240654]);
					float4 temp_output_593_109_g240581 = lerpResult167_g240654;
					half4 Glow_Texture248_g240581 = temp_output_593_109_g240581;
					float4 In_GlowTexture204_g240581 = Glow_Texture248_g240581;
					float4 temp_output_203_0_g240592 = TVE_FormBaseCoord;
					float2 lerpResult168_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g240592 = lerpResult168_g240581;
					float temp_output_130_0_g240590 = _GlobalFormLayerValue;
					float temp_output_82_0_g240592 = temp_output_130_0_g240590;
					float4 tex2DArrayNode83_g240592 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240592).zw + ( (temp_output_203_0_g240592).xy * temp_output_81_0_g240592 ) ),temp_output_82_0_g240592), 0.0 );
					float4 appendResult210_g240592 = (float4(tex2DArrayNode83_g240592.rgb , tex2DArrayNode83_g240592.a));
					float4 temp_output_204_0_g240592 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g240592 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240592).zw + ( (temp_output_204_0_g240592).xy * temp_output_81_0_g240592 ) ),temp_output_82_0_g240592), 0.0 );
					float4 appendResult212_g240592 = (float4(tex2DArrayNode122_g240592.rgb , tex2DArrayNode122_g240592.a));
					float4 lerpResult131_g240592 = lerp( appendResult210_g240592 , appendResult212_g240592 , Global_TexBlend509_g240581);
					float4 temp_output_135_109_g240590 = lerpResult131_g240592;
					float4 lerpResult143_g240590 = lerp( TVE_FormParams , temp_output_135_109_g240590 , TVE_FormLayers[(int)temp_output_130_0_g240590]);
					float4 temp_output_592_0_g240581 = lerpResult143_g240590;
					float4 Form_Texture112_g240581 = temp_output_592_0_g240581;
					float4 In_FormTexture204_g240581 = Form_Texture112_g240581;
					float4 In_LandTexture204_g240581 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g240640 = TVE_VertxBaseCoord;
					float2 lerpResult681_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g240640 = lerpResult681_g240581;
					float temp_output_136_0_g240638 = _GlobalVertxLayerValue;
					float temp_output_82_0_g240640 = temp_output_136_0_g240638;
					float4 tex2DArrayNode83_g240640 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240640).zw + ( (temp_output_203_0_g240640).xy * temp_output_81_0_g240640 ) ),temp_output_82_0_g240640), 0.0 );
					float4 appendResult210_g240640 = (float4(tex2DArrayNode83_g240640.rgb , tex2DArrayNode83_g240640.a));
					float4 temp_output_204_0_g240640 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g240640 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240640).zw + ( (temp_output_204_0_g240640).xy * temp_output_81_0_g240640 ) ),temp_output_82_0_g240640), 0.0 );
					float4 appendResult212_g240640 = (float4(tex2DArrayNode122_g240640.rgb , tex2DArrayNode122_g240640.a));
					float4 lerpResult131_g240640 = lerp( appendResult210_g240640 , appendResult212_g240640 , Global_TexBlend509_g240581);
					float4 temp_output_141_109_g240638 = lerpResult131_g240640;
					float4 lerpResult149_g240638 = lerp( TVE_VertxParams , temp_output_141_109_g240638 , TVE_VertxLayers[(int)temp_output_136_0_g240638]);
					float4 temp_output_695_0_g240581 = lerpResult149_g240638;
					half4 Vertx_Texture693_g240581 = temp_output_695_0_g240581;
					float4 In_VertxTexture204_g240581 = Vertx_Texture693_g240581;
					float4 temp_output_203_0_g240616 = TVE_FlowBaseCoord;
					float2 lerpResult400_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g240616 = lerpResult400_g240581;
					float temp_output_136_0_g240614 = _GlobalFlowLayerValue;
					float temp_output_82_0_g240616 = temp_output_136_0_g240614;
					float4 tex2DArrayNode83_g240616 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240616).zw + ( (temp_output_203_0_g240616).xy * temp_output_81_0_g240616 ) ),temp_output_82_0_g240616), 0.0 );
					float4 appendResult210_g240616 = (float4(tex2DArrayNode83_g240616.rgb , tex2DArrayNode83_g240616.a));
					float4 temp_output_204_0_g240616 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g240616 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240616).zw + ( (temp_output_204_0_g240616).xy * temp_output_81_0_g240616 ) ),temp_output_82_0_g240616), 0.0 );
					float4 appendResult212_g240616 = (float4(tex2DArrayNode122_g240616.rgb , tex2DArrayNode122_g240616.a));
					float4 lerpResult131_g240616 = lerp( appendResult210_g240616 , appendResult212_g240616 , Global_TexBlend509_g240581);
					float4 temp_output_141_109_g240614 = lerpResult131_g240616;
					float4 lerpResult149_g240614 = lerp( TVE_FlowParams , temp_output_141_109_g240614 , TVE_FlowLayers[(int)temp_output_136_0_g240614]);
					float4 temp_output_594_0_g240581 = lerpResult149_g240614;
					half4 Flow_Texture405_g240581 = temp_output_594_0_g240581;
					float4 In_FlowTexture204_g240581 = Flow_Texture405_g240581;
					half4 User_Texture677_g240581 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g240581 = User_Texture677_g240581;
					BuildGlobalData( Data204_g240581 , In_Dummy204_g240581 , In_CoatTexture204_g240581 , In_DrawTexture204_g240581 , In_PaintTexture204_g240581 , In_AtmoTexture204_g240581 , In_EffexTexture204_g240581 , In_GlowTexture204_g240581 , In_FormTexture204_g240581 , In_LandTexture204_g240581 , In_VertxTexture204_g240581 , In_FlowTexture204_g240581 , In_UserTexture204_g240581 );
					TVEGlobalData Data15_g251554 =(TVEGlobalData)Data204_g240581;
					float Out_Dummy15_g251554 = 0.0;
					float4 Out_CoatTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251554 = float4( 0,0,0,0 );
					BreakData( Data15_g251554 , Out_Dummy15_g251554 , Out_CoatTexture15_g251554 , Out_DrawTexture15_g251554 , Out_PaintTexture15_g251554 , Out_AtmoTexture15_g251554 , Out_EffexTexture15_g251554 , Out_GlowTexture15_g251554 , Out_FormTexture15_g251554 , Out_LandTexture15_g251554 , Out_VertxTexture15_g251554 , Out_FlowTexture15_g251554 , Out_UserTexture15_g251554 );
					float4 Global_FormTexture351_g251544 = Out_FormTexture15_g251554;
					TVEModelData Data15_g251551 =(TVEModelData)Data15_g251542;
					float Out_Dummy15_g251551 = 0.0;
					float3 Out_PositionOS15_g251551 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251551 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251551 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251551 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251551 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251551 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251551 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251551 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251551 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251551 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251551 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251551 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251551 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251551 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251551 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251551 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251551 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251551 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251551 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251551 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251551 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251551 , Out_Dummy15_g251551 , Out_PositionOS15_g251551 , Out_PositionWS15_g251551 , Out_PositionWO15_g251551 , Out_PositionRawOS15_g251551 , Out_PivotOS15_g251551 , Out_PivotWS15_g251551 , Out_PivotWO15_g251551 , Out_NormalOS15_g251551 , Out_NormalWS15_g251551 , Out_NormalRawOS15_g251551 , Out_TangentOS15_g251551 , Out_TangentWS15_g251551 , Out_BitangentWS15_g251551 , Out_ViewDirWS15_g251551 , Out_CoordsData15_g251551 , Out_VertexData15_g251551 , Out_MasksData15_g251551 , Out_PhaseData15_g251551 , Out_TransformData15_g251551 , Out_RotationData15_g251551 , Out_Interpolator15_g251551 );
					float3 Model_PivotWO353_g251544 = Out_PivotWO15_g251551;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251550 = _ConformMeshMode;
					float Option70_g251550 = temp_output_17_0_g251550;
					half4 Model_VertexData357_g251544 = Out_VertexData15_g251551;
					float4 temp_output_3_0_g251550 = Model_VertexData357_g251544;
					float4 Channel70_g251550 = temp_output_3_0_g251550;
					float localSwitchChannel470_g251550 = SwitchChannel4( Option70_g251550 , Channel70_g251550 );
					float temp_output_390_0_g251544 = localSwitchChannel470_g251550;
					float temp_output_7_0_g251547 = _ConformMeshRemap.x;
					float temp_output_9_0_g251547 = ( temp_output_390_0_g251544 - temp_output_7_0_g251547 );
					float lerpResult374_g251544 = lerp( 1.0 , saturate( ( temp_output_9_0_g251547 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251544 = lerpResult374_g251544;
					float temp_output_328_0_g251544 = ( Blend_VertMask379_g251544 * TVE_IsEnabled );
					half Conform_Mask366_g251544 = temp_output_328_0_g251544;
					float temp_output_322_0_g251544 = ( ( ( ( (Global_FormTexture351_g251544).z - ( (Model_PivotWO353_g251544).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251544 ) );
					float3 appendResult329_g251544 = (float3(0.0 , temp_output_322_0_g251544 , 0.0));
					float3 appendResult387_g251544 = (float3(0.0 , 0.0 , temp_output_322_0_g251544));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251548 = appendResult387_g251544;
					#else
					float3 staticSwitch65_g251548 = appendResult329_g251544;
					#endif
					float3 Blanket_Conform368_g251544 = staticSwitch65_g251548;
					float4 appendResult312_g251544 = (float4(Blanket_Conform368_g251544 , 0.0));
					float4 temp_output_310_0_g251544 = ( Model_TransformData356_g251544 + appendResult312_g251544 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251544 = temp_output_310_0_g251544;
					#else
					float4 staticSwitch364_g251544 = Model_TransformData356_g251544;
					#endif
					half4 Final_TransformData365_g251544 = staticSwitch364_g251544;
					float4 In_TransformData16_g251553 = Final_TransformData365_g251544;
					float4 In_RotationData16_g251553 = Out_RotationData15_g251552;
					float4 In_Interpolator16_g251553 = Out_Interpolator15_g251552;
					BuildVertexData( Data16_g251553 , In_Dummy16_g251553 , In_PositionOS16_g251553 , In_NormalOS16_g251553 , In_TangentOS16_g251553 , In_TransformData16_g251553 , In_RotationData16_g251553 , In_Interpolator16_g251553 );
					TVEVertexData Data15_g251564 =(TVEVertexData)Data16_g251553;
					float Out_Dummy15_g251564 = 0.0;
					float3 Out_PositionOS15_g251564 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251564 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251564 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251564 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251564 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251564 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251564 , Out_Dummy15_g251564 , Out_PositionOS15_g251564 , Out_NormalOS15_g251564 , Out_TangentOS15_g251564 , Out_TransformData15_g251564 , Out_RotationData15_g251564 , Out_Interpolator15_g251564 );
					TVEVertexData Data16_g251565 =(TVEVertexData)Data15_g251564;
					float In_Dummy16_g251565 = 0.0;
					float3 Vertex_PositionOS147_g251555 = Out_PositionOS15_g251564;
					half3 VertexPos40_g251559 = Vertex_PositionOS147_g251555;
					float4 temp_output_1615_33_g251555 = Out_RotationData15_g251564;
					half4 Vertex_RotationData1569_g251555 = temp_output_1615_33_g251555;
					float2 break1582_g251555 = (Vertex_RotationData1569_g251555).xy;
					half Angle44_g251559 = break1582_g251555.y;
					half CosAngle89_g251559 = cos( Angle44_g251559 );
					half SinAngle93_g251559 = sin( Angle44_g251559 );
					float3 appendResult95_g251559 = (float3((VertexPos40_g251559).x , ( ( (VertexPos40_g251559).y * CosAngle89_g251559 ) - ( (VertexPos40_g251559).z * SinAngle93_g251559 ) ) , ( ( (VertexPos40_g251559).y * SinAngle93_g251559 ) + ( (VertexPos40_g251559).z * CosAngle89_g251559 ) )));
					half3 VertexPos40_g251560 = appendResult95_g251559;
					half Angle44_g251560 = -break1582_g251555.x;
					half CosAngle94_g251560 = cos( Angle44_g251560 );
					half SinAngle95_g251560 = sin( Angle44_g251560 );
					float3 appendResult98_g251560 = (float3(( ( (VertexPos40_g251560).x * CosAngle94_g251560 ) - ( (VertexPos40_g251560).y * SinAngle95_g251560 ) ) , ( ( (VertexPos40_g251560).x * SinAngle95_g251560 ) + ( (VertexPos40_g251560).y * CosAngle94_g251560 ) ) , (VertexPos40_g251560).z));
					half3 VertexPos40_g251558 = Vertex_PositionOS147_g251555;
					half Angle44_g251558 = break1582_g251555.y;
					half CosAngle89_g251558 = cos( Angle44_g251558 );
					half SinAngle93_g251558 = sin( Angle44_g251558 );
					float3 appendResult95_g251558 = (float3((VertexPos40_g251558).x , ( ( (VertexPos40_g251558).y * CosAngle89_g251558 ) - ( (VertexPos40_g251558).z * SinAngle93_g251558 ) ) , ( ( (VertexPos40_g251558).y * SinAngle93_g251558 ) + ( (VertexPos40_g251558).z * CosAngle89_g251558 ) )));
					half3 VertexPos40_g251563 = appendResult95_g251558;
					half Angle44_g251563 = break1582_g251555.x;
					half CosAngle91_g251563 = cos( Angle44_g251563 );
					half SinAngle92_g251563 = sin( Angle44_g251563 );
					float3 appendResult93_g251563 = (float3(( ( (VertexPos40_g251563).x * CosAngle91_g251563 ) + ( (VertexPos40_g251563).z * SinAngle92_g251563 ) ) , (VertexPos40_g251563).y , ( ( -(VertexPos40_g251563).x * SinAngle92_g251563 ) + ( (VertexPos40_g251563).z * CosAngle91_g251563 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251561 = appendResult93_g251563;
					#else
					float3 staticSwitch65_g251561 = appendResult98_g251560;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251556 = staticSwitch65_g251561;
					#else
					float3 staticSwitch65_g251556 = Vertex_PositionOS147_g251555;
					#endif
					float3 temp_output_1608_0_g251555 = staticSwitch65_g251556;
					half3 VertexPos40_g251562 = temp_output_1608_0_g251555;
					half Angle44_g251562 = (Vertex_RotationData1569_g251555).z;
					half CosAngle91_g251562 = cos( Angle44_g251562 );
					half SinAngle92_g251562 = sin( Angle44_g251562 );
					float3 appendResult93_g251562 = (float3(( ( (VertexPos40_g251562).x * CosAngle91_g251562 ) + ( (VertexPos40_g251562).z * SinAngle92_g251562 ) ) , (VertexPos40_g251562).y , ( ( -(VertexPos40_g251562).x * SinAngle92_g251562 ) + ( (VertexPos40_g251562).z * CosAngle91_g251562 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251557 = appendResult93_g251562;
					#else
					float3 staticSwitch65_g251557 = temp_output_1608_0_g251555;
					#endif
					float4 temp_output_1615_31_g251555 = Out_TransformData15_g251564;
					half4 Vertex_TransformData1568_g251555 = temp_output_1615_31_g251555;
					half3 Final_PositionOS178_g251555 = ( ( staticSwitch65_g251557 * (Vertex_TransformData1568_g251555).w ) + (Vertex_TransformData1568_g251555).xyz );
					float3 In_PositionOS16_g251565 = Final_PositionOS178_g251555;
					float3 In_NormalOS16_g251565 = Out_NormalOS15_g251564;
					float4 In_TangentOS16_g251565 = Out_TangentOS15_g251564;
					float4 In_TransformData16_g251565 = temp_output_1615_31_g251555;
					float4 In_RotationData16_g251565 = temp_output_1615_33_g251555;
					float4 In_Interpolator16_g251565 = Out_Interpolator15_g251564;
					BuildVertexData( Data16_g251565 , In_Dummy16_g251565 , In_PositionOS16_g251565 , In_NormalOS16_g251565 , In_TangentOS16_g251565 , In_TransformData16_g251565 , In_RotationData16_g251565 , In_Interpolator16_g251565 );
					TVEVertexData Data15_g251568 =(TVEVertexData)Data16_g251565;
					float Out_Dummy15_g251568 = 0.0;
					float3 Out_PositionOS15_g251568 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251568 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251568 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251568 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251568 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251568 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251568 , Out_Dummy15_g251568 , Out_PositionOS15_g251568 , Out_NormalOS15_g251568 , Out_TangentOS15_g251568 , Out_TransformData15_g251568 , Out_RotationData15_g251568 , Out_Interpolator15_g251568 );
					TVEVertexData Data16_g251569 =(TVEVertexData)Data15_g251568;
					float In_Dummy16_g251569 = 0.0;
					TVEModelData Data15_g251567 =(TVEModelData)Data15_g251551;
					float Out_Dummy15_g251567 = 0.0;
					float3 Out_PositionOS15_g251567 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251567 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251567 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251567 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251567 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251567 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251567 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251567 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251567 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251567 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251567 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251567 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251567 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251567 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251567 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251567 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251567 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251567 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251567 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251567 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251567 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251567 , Out_Dummy15_g251567 , Out_PositionOS15_g251567 , Out_PositionWS15_g251567 , Out_PositionWO15_g251567 , Out_PositionRawOS15_g251567 , Out_PivotOS15_g251567 , Out_PivotWS15_g251567 , Out_PivotWO15_g251567 , Out_NormalOS15_g251567 , Out_NormalWS15_g251567 , Out_NormalRawOS15_g251567 , Out_TangentOS15_g251567 , Out_TangentWS15_g251567 , Out_BitangentWS15_g251567 , Out_ViewDirWS15_g251567 , Out_CoordsData15_g251567 , Out_VertexData15_g251567 , Out_MasksData15_g251567 , Out_PhaseData15_g251567 , Out_TransformData15_g251567 , Out_RotationData15_g251567 , Out_Interpolator15_g251567 );
					float3 In_PositionOS16_g251569 = ( Out_PositionOS15_g251568 + Out_PivotOS15_g251567 );
					float3 In_NormalOS16_g251569 = Out_NormalOS15_g251568;
					float4 In_TangentOS16_g251569 = Out_TangentOS15_g251568;
					float4 In_TransformData16_g251569 = Out_TransformData15_g251568;
					float4 In_RotationData16_g251569 = Out_RotationData15_g251568;
					float4 In_Interpolator16_g251569 = Out_Interpolator15_g251568;
					BuildVertexData( Data16_g251569 , In_Dummy16_g251569 , In_PositionOS16_g251569 , In_NormalOS16_g251569 , In_TangentOS16_g251569 , In_TransformData16_g251569 , In_RotationData16_g251569 , In_Interpolator16_g251569 );
					TVEVertexData Data15_g251675 =(TVEVertexData)Data16_g251569;
					float Out_Dummy15_g251675 = 0.0;
					float3 Out_PositionOS15_g251675 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251675 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251675 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251675 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251675 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251675 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251675 , Out_Dummy15_g251675 , Out_PositionOS15_g251675 , Out_NormalOS15_g251675 , Out_TangentOS15_g251675 , Out_TransformData15_g251675 , Out_RotationData15_g251675 , Out_Interpolator15_g251675 );
					
					float3 vertexPos57_g251667 = v.vertex.xyz;
					float4 ase_positionCS57_g251667 = UnityObjectToClipPos( vertexPos57_g251667 );
					o.ase_texcoord6 = ase_positionCS57_g251667;
					o.ase_texcoord7.xyz = vertexToFrag73_g240682;
					o.ase_texcoord8.xyz = vertexToFrag76_g240682;
					TVEVertexData Data1902_g251624 = Data16_g251569;
					float4 Out_Interpolator1902_g251624 = float4( 0,0,0,0 );
					{
					Out_Interpolator1902_g251624 = Data1902_g251624.Interpolator;
					}
					float4 vertexToFrag1901_g251624 = Out_Interpolator1902_g251624;
					o.ase_texcoord10 = vertexToFrag1901_g251624;
					
					o.ase_texcoord9.xy = v.texcoord.xyzw.xy;
					o.ase_texcoord9.zw = v.texcoord2.xyzw.xy;
					o.ase_color = v.ase_color;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord7.w = 0;
					o.ase_texcoord8.w = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251675;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251675;
					v.tangent = Out_TangentOS15_g251675;

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

					float temp_output_2419_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2419_114).xxx;
					
					float3 color130_g251667 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g251667 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_3 = (60.0).xx;
					float2 appendResult128_g251669 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g251668 = ( temp_cast_3 * ( 0.5 + appendResult128_g251669 ) );
					float2 temp_cast_4 = (0.5).xx;
					float2 temp_cast_5 = (1.0).xx;
					float4 appendResult16_g251668 = (float4(ddx( FinalUV13_g251668 ) , ddy( FinalUV13_g251668 )));
					float4 UVDerivatives17_g251668 = appendResult16_g251668;
					float4 break28_g251668 = UVDerivatives17_g251668;
					float2 appendResult19_g251668 = (float2(break28_g251668.x , break28_g251668.z));
					float2 appendResult20_g251668 = (float2(break28_g251668.x , break28_g251668.z));
					float dotResult24_g251668 = dot( appendResult19_g251668 , appendResult20_g251668 );
					float2 appendResult21_g251668 = (float2(break28_g251668.y , break28_g251668.w));
					float2 appendResult22_g251668 = (float2(break28_g251668.y , break28_g251668.w));
					float dotResult23_g251668 = dot( appendResult21_g251668 , appendResult22_g251668 );
					float2 appendResult25_g251668 = (float2(dotResult24_g251668 , dotResult23_g251668));
					float2 derivativesLength29_g251668 = sqrt( appendResult25_g251668 );
					float2 temp_cast_6 = (-1.0).xx;
					float2 temp_cast_7 = (1.0).xx;
					float2 clampResult57_g251668 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g251668 + 0.25 ) ) - temp_cast_4 ) ) * 4.0 ) - temp_cast_5 ) * ( 0.35 / derivativesLength29_g251668 ) ) , temp_cast_6 , temp_cast_7 );
					float2 break71_g251668 = clampResult57_g251668;
					float2 break55_g251668 = derivativesLength29_g251668;
					float4 lerpResult73_g251668 = lerp( float4( color130_g251667 , 0.0 ) , float4( color81_g251667 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g251668.x * break71_g251668.y * sqrt( saturate( ( 1.1 - max( break55_g251668.x, break55_g251668.y ) ) ) ) ) ) ));
					half IsLightingType2402 = _IsLightingType;
					float4 color2395 = IsGammaSpace() ? float4( 0.6196079, 0.7686275, 0.1490196, 0 ) : float4( 0.3419145, 0.5520116, 0.01938236, 0 );
					float3 ifLocalVar40_g251570 = 0;
					if( IsLightingType2402 == 1.0 )
					ifLocalVar40_g251570 = color2395.rgb;
					float4 color2398 = IsGammaSpace() ? float4( 0.3254902, 0.6117647, 0.8117647, 0 ) : float4( 0.08650047, 0.3324516, 0.6239604, 0 );
					float3 ifLocalVar40_g251571 = 0;
					if( IsLightingType2402 == 2.0 )
					ifLocalVar40_g251571 = color2398.rgb;
					float4 color2391 = IsGammaSpace() ? float4( 0.654902, 0.3411765, 0.8509804, 0 ) : float4( 0.3864295, 0.0953075, 0.6938719, 0 );
					float3 ifLocalVar40_g251572 = 0;
					if( IsLightingType2402 == 3.0 )
					ifLocalVar40_g251572 = color2391.rgb;
					float4 color2412 = IsGammaSpace() ? float4( 0.972549, 0.8862745, 0.1803922, 0 ) : float4( 0.9386859, 0.7605246, 0.0273209, 0 );
					float3 ifLocalVar40_g251573 = 0;
					if( IsLightingType2402 == 4.0 )
					ifLocalVar40_g251573 = color2412.rgb;
					half3 Final_Debug2386 = ( ifLocalVar40_g251570 + ifLocalVar40_g251571 + ifLocalVar40_g251572 + ifLocalVar40_g251573 );
					float temp_output_7_0_g251674 = TVE_DEBUG_Min;
					float3 temp_cast_8 = (temp_output_7_0_g251674).xxx;
					float3 temp_output_9_0_g251674 = ( Final_Debug2386 - temp_cast_8 );
					float lerpResult76_g251667 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g251667 = lerpResult76_g251667;
					float3 lerpResult72_g251667 = lerp( (lerpResult73_g251668).rgb , saturate( ( temp_output_9_0_g251674 / ( ( TVE_DEBUG_Max - temp_output_7_0_g251674 ) + 0.0001 ) ) ) , Filter152_g251667);
					float dotResult61_g251667 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g251667 = ( 1.0 - saturate( dotResult61_g251667 ) );
					float Shading_Fresnel59_g251667 = (( 1.0 - ( temp_output_65_0_g251667 * temp_output_65_0_g251667 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g251667 = IN.ase_texcoord6;
					float depthLinearEye57_g251667 = LinearEyeDepth( ase_positionCS57_g251667.z / ase_positionCS57_g251667.w );
					float temp_output_69_0_g251667 = saturate(  (0.0 + ( depthLinearEye57_g251667 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g251667 = (( temp_output_69_0_g251667 * temp_output_69_0_g251667 )*0.5 + 0.5);
					float lerpResult84_g251667 = lerp( 1.0 , Shading_Fresnel59_g251667 , ( Shading_Distance58_g251667 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g251672 = ( 0.0 );
					float localBuildVisualData3_g251630 = ( 0.0 );
					float localBuildVisualData3_g251625 = ( 0.0 );
					TVEVisualData Data3_g251625 =(TVEVisualData)0;
					float temp_output_14_0_g251625 = 0.0;
					float In_Dummy3_g251625 = temp_output_14_0_g251625;
					float3 temp_cast_9 = (0.5).xxx;
					float3 temp_output_4_0_g251625 = temp_cast_9;
					float3 In_Albedo3_g251625 = temp_output_4_0_g251625;
					float3 temp_cast_10 = (0.5).xxx;
					float3 temp_output_44_0_g251625 = temp_cast_10;
					float3 In_AlbedoBase3_g251625 = temp_output_44_0_g251625;
					float2 temp_cast_11 = (0.0).xx;
					float2 In_NormalTS3_g251625 = temp_cast_11;
					float3 temp_cast_12 = (0.5).xxx;
					float3 In_NormalWS3_g251625 = temp_cast_12;
					float4 In_Shader3_g251625 = half4( 0, 1, 0, 1 );
					float4 In_Feature3_g251625 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251625 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251625 = half4( 1, 1, 1, 1 );
					float temp_output_12_0_g251625 = 0.5;
					float In_Grayscale3_g251625 = temp_output_12_0_g251625;
					float temp_output_16_0_g251625 = 1.0;
					float In_Luminosity3_g251625 = temp_output_16_0_g251625;
					float In_MultiMask3_g251625 = 1.0;
					float In_AlphaClip3_g251625 = 1.0;
					float In_AlphaFade3_g251625 = 1.0;
					float3 temp_cast_13 = (1.0).xxx;
					float3 In_Translucency3_g251625 = temp_cast_13;
					float In_Transmission3_g251625 = 1.0;
					float In_Thickness3_g251625 = 0.0;
					float In_Diffusion3_g251625 = 0.0;
					float In_Depth3_g251625 = 0.0;
					BuildVisualData( Data3_g251625 , In_Dummy3_g251625 , In_Albedo3_g251625 , In_AlbedoBase3_g251625 , In_NormalTS3_g251625 , In_NormalWS3_g251625 , In_Shader3_g251625 , In_Feature3_g251625 , In_Season3_g251625 , In_Emissive3_g251625 , In_Grayscale3_g251625 , In_Luminosity3_g251625 , In_MultiMask3_g251625 , In_AlphaClip3_g251625 , In_AlphaFade3_g251625 , In_Translucency3_g251625 , In_Transmission3_g251625 , In_Thickness3_g251625 , In_Diffusion3_g251625 , In_Depth3_g251625 );
					TVEVisualData Data3_g251630 =(TVEVisualData)Data3_g251625;
					half Dummy130_g251628 = ( _MainCategory + _MainEnd );
					float temp_output_14_0_g251630 = Dummy130_g251628;
					float In_Dummy3_g251630 = temp_output_14_0_g251630;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251651) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g251633 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g251633 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g251633 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g251633 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g251633 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g251633 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g251651 = staticSwitch36_g251633;
					float localBreakTextureData456_g251651 = ( 0.0 );
					float localBuildTextureData431_g251650 = ( 0.0 );
					TVEMasksData Data431_g251650 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g251650 = ( 0.0 );
					float4 temp_output_6_0_g251666 = _main_coord_value;
					float4 temp_output_7_0_g251666 = ( _MainSampleMode + _MainCoordMode + _MainCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g251666 = ( temp_output_6_0_g251666 + temp_output_7_0_g251666 );
					#else
					float4 staticSwitch14_g251666 = temp_output_6_0_g251666;
					#endif
					half4 Local_Coords180_g251628 = staticSwitch14_g251666;
					float4 Coords444_g251650 = Local_Coords180_g251628;
					TVEModelData Data16_g240690 =(TVEModelData)0;
					float In_Dummy16_g240690 = 0.0;
					float3 vertexToFrag73_g240682 = IN.ase_texcoord7.xyz;
					float3 PositionWS122_g240682 = vertexToFrag73_g240682;
					float3 In_PositionWS16_g240690 = PositionWS122_g240682;
					float3 vertexToFrag76_g240682 = IN.ase_texcoord8.xyz;
					float3 PivotWS121_g240682 = vertexToFrag76_g240682;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g240682 = ( PositionWS122_g240682 - PivotWS121_g240682 );
					#else
					float3 staticSwitch204_g240682 = PositionWS122_g240682;
					#endif
					float3 PositionWO132_g240682 = ( staticSwitch204_g240682 - TVE_WorldOrigin );
					float3 In_PositionWO16_g240690 = PositionWO132_g240682;
					float3 In_PivotWS16_g240690 = PivotWS121_g240682;
					float3 PivotWO133_g240682 = ( PivotWS121_g240682 - TVE_WorldOrigin );
					float3 In_PivotWO16_g240690 = PivotWO133_g240682;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g240682 = normalizedWorldNormal;
					float3 In_NormalWS16_g240690 = NormalWS95_g240682;
					half3 TangentWS136_g240682 = TangentWS;
					float3 In_TangentWS16_g240690 = TangentWS136_g240682;
					half3 BiangentWS421_g240682 = BitangentWS;
					float3 In_BitangentWS16_g240690 = BiangentWS421_g240682;
					half3 NormalWS427_g240682 = NormalWS95_g240682;
					half3 localComputeTriplanarMasks427_g240682 = ComputeTriplanarMasks( NormalWS427_g240682 );
					half3 TriplanarWeights429_g240682 = localComputeTriplanarMasks427_g240682;
					float3 In_TriplanarWeights16_g240690 = TriplanarWeights429_g240682;
					float3 normalizeResult296_g240682 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g240682 ) );
					half3 ViewDirWS169_g240682 = normalizeResult296_g240682;
					float3 In_ViewDirWS16_g240690 = ViewDirWS169_g240682;
					float4 appendResult397_g240682 = (float4(IN.ase_texcoord9.xy , IN.ase_texcoord9.zw));
					float4 CoordsData398_g240682 = appendResult397_g240682;
					float4 In_CoordsData16_g240690 = CoordsData398_g240682;
					half4 VertexMasks171_g240682 = IN.ase_color;
					float4 In_VertexData16_g240690 = VertexMasks171_g240682;
					float temp_output_17_0_g240693 = _ObjectPhaseMode;
					float Option70_g240693 = temp_output_17_0_g240693;
					float4 temp_output_3_0_g240693 = IN.ase_color;
					float4 Channel70_g240693 = temp_output_3_0_g240693;
					float localSwitchChannel470_g240693 = SwitchChannel4( Option70_g240693 , Channel70_g240693 );
					half Phase_Value372_g240682 = localSwitchChannel470_g240693;
					float3 break319_g240682 = PivotWO133_g240682;
					half Pivot_Position322_g240682 = ( break319_g240682.x + break319_g240682.z );
					half Phase_Position357_g240682 = ( Phase_Value372_g240682 + Pivot_Position322_g240682 );
					float temp_output_248_0_g240682 = frac( Phase_Position357_g240682 );
					float4 appendResult177_g240682 = (float4((frac( ( Phase_Position357_g240682 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g240682));
					half4 Phase_Data176_g240682 = appendResult177_g240682;
					float4 In_Interpolator16_g240690 = Phase_Data176_g240682;
					BuildModelFragData( Data16_g240690 , In_Dummy16_g240690 , In_PositionWS16_g240690 , In_PositionWO16_g240690 , In_PivotWS16_g240690 , In_PivotWO16_g240690 , In_NormalWS16_g240690 , In_TangentWS16_g240690 , In_BitangentWS16_g240690 , In_TriplanarWeights16_g240690 , In_ViewDirWS16_g240690 , In_CoordsData16_g240690 , In_VertexData16_g240690 , In_Interpolator16_g240690 );
					TVEModelData Data15_g251626 =(TVEModelData)Data16_g240690;
					float Out_Dummy15_g251626 = 0.0;
					float3 Out_PositionWS15_g251626 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251626 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251626 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251626 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251626 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251626 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251626 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251626 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251626 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251626 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251626 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251626 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251626 , Out_Dummy15_g251626 , Out_PositionWS15_g251626 , Out_PositionWO15_g251626 , Out_PivotWS15_g251626 , Out_PivotWO15_g251626 , Out_NormalWS15_g251626 , Out_TangentWS15_g251626 , Out_BitangentWS15_g251626 , Out_TriplanarWeights15_g251626 , Out_ViewDirWS15_g251626 , Out_CoordsData15_g251626 , Out_VertexData15_g251626 , Out_Interpolator15_g251626 );
					TVEModelData Data16_g251627 =(TVEModelData)Data15_g251626;
					float In_Dummy16_g251627 = Out_Dummy15_g251626;
					float3 In_PositionWS16_g251627 = Out_PositionWS15_g251626;
					float3 In_PositionWO16_g251627 = Out_PositionWO15_g251626;
					float3 In_PivotWS16_g251627 = Out_PivotWS15_g251626;
					float3 In_PivotWO16_g251627 = Out_PivotWO15_g251626;
					float3 In_NormalWS16_g251627 = Out_NormalWS15_g251626;
					float3 In_TangentWS16_g251627 = Out_TangentWS15_g251626;
					float3 In_BitangentWS16_g251627 = Out_BitangentWS15_g251626;
					float3 In_TriplanarWeights16_g251627 = Out_TriplanarWeights15_g251626;
					float3 In_ViewDirWS16_g251627 = Out_ViewDirWS15_g251626;
					float4 In_CoordsData16_g251627 = Out_CoordsData15_g251626;
					float4 In_VertexData16_g251627 = Out_VertexData15_g251626;
					float4 vertexToFrag1901_g251624 = IN.ase_texcoord10;
					float4 In_Interpolator16_g251627 = vertexToFrag1901_g251624;
					BuildModelFragData( Data16_g251627 , In_Dummy16_g251627 , In_PositionWS16_g251627 , In_PositionWO16_g251627 , In_PivotWS16_g251627 , In_PivotWO16_g251627 , In_NormalWS16_g251627 , In_TangentWS16_g251627 , In_BitangentWS16_g251627 , In_TriplanarWeights16_g251627 , In_ViewDirWS16_g251627 , In_CoordsData16_g251627 , In_VertexData16_g251627 , In_Interpolator16_g251627 );
					TVEModelData Data15_g251629 =(TVEModelData)Data16_g251627;
					float Out_Dummy15_g251629 = 0.0;
					float3 Out_PositionWS15_g251629 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251629 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251629 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251629 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251629 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251629 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251629 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251629 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251629 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251629 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251629 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251629 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251629 , Out_Dummy15_g251629 , Out_PositionWS15_g251629 , Out_PositionWO15_g251629 , Out_PivotWS15_g251629 , Out_PivotWO15_g251629 , Out_NormalWS15_g251629 , Out_TangentWS15_g251629 , Out_BitangentWS15_g251629 , Out_TriplanarWeights15_g251629 , Out_ViewDirWS15_g251629 , Out_CoordsData15_g251629 , Out_VertexData15_g251629 , Out_Interpolator15_g251629 );
					float4 Model_CoordsData324_g251628 = Out_CoordsData15_g251629;
					float4 MeshCoords444_g251650 = Model_CoordsData324_g251628;
					float2 UV0444_g251650 = float2( 0,0 );
					float2 UV3444_g251650 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g251650 , MeshCoords444_g251650 , UV0444_g251650 , UV3444_g251650 );
					float4 appendResult430_g251650 = (float4(UV0444_g251650 , UV3444_g251650));
					float4 In_MaskA431_g251650 = appendResult430_g251650;
					float localComputeWorldCoords315_g251650 = ( 0.0 );
					float4 Coords315_g251650 = Local_Coords180_g251628;
					float3 Model_PositionWO222_g251628 = Out_PositionWO15_g251629;
					float3 PositionWS315_g251650 = Model_PositionWO222_g251628;
					float2 ZY315_g251650 = float2( 0,0 );
					float2 XZ315_g251650 = float2( 0,0 );
					float2 XY315_g251650 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g251650 , PositionWS315_g251650 , ZY315_g251650 , XZ315_g251650 , XY315_g251650 );
					float2 ZY402_g251650 = ZY315_g251650;
					float2 XZ403_g251650 = XZ315_g251650;
					float4 appendResult432_g251650 = (float4(ZY402_g251650 , XZ403_g251650));
					float4 In_MaskB431_g251650 = appendResult432_g251650;
					float2 XY404_g251650 = XY315_g251650;
					float localComputeStochasticCoords409_g251650 = ( 0.0 );
					float2 UV409_g251650 = ZY402_g251650;
					float2 UV1409_g251650 = float2( 0,0 );
					float2 UV2409_g251650 = float2( 0,0 );
					float2 UV3409_g251650 = float2( 0,0 );
					float3 Weights409_g251650 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g251650 , UV1409_g251650 , UV2409_g251650 , UV3409_g251650 , Weights409_g251650 );
					float4 appendResult433_g251650 = (float4(XY404_g251650 , UV1409_g251650));
					float4 In_MaskC431_g251650 = appendResult433_g251650;
					float4 appendResult434_g251650 = (float4(UV2409_g251650 , UV3409_g251650));
					float4 In_MaskD431_g251650 = appendResult434_g251650;
					float localComputeStochasticCoords422_g251650 = ( 0.0 );
					float2 UV422_g251650 = XZ403_g251650;
					float2 UV1422_g251650 = float2( 0,0 );
					float2 UV2422_g251650 = float2( 0,0 );
					float2 UV3422_g251650 = float2( 0,0 );
					float3 Weights422_g251650 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g251650 , UV1422_g251650 , UV2422_g251650 , UV3422_g251650 , Weights422_g251650 );
					float4 appendResult435_g251650 = (float4(UV1422_g251650 , UV2422_g251650));
					float4 In_MaskE431_g251650 = appendResult435_g251650;
					float localComputeStochasticCoords423_g251650 = ( 0.0 );
					float2 UV423_g251650 = XY404_g251650;
					float2 UV1423_g251650 = float2( 0,0 );
					float2 UV2423_g251650 = float2( 0,0 );
					float2 UV3423_g251650 = float2( 0,0 );
					float3 Weights423_g251650 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g251650 , UV1423_g251650 , UV2423_g251650 , UV3423_g251650 , Weights423_g251650 );
					float4 appendResult436_g251650 = (float4(UV3422_g251650 , UV1423_g251650));
					float4 In_MaskF431_g251650 = appendResult436_g251650;
					float4 appendResult437_g251650 = (float4(UV2423_g251650 , UV3423_g251650));
					float4 In_MaskG431_g251650 = appendResult437_g251650;
					float4 In_MaskH431_g251650 = float4( Weights409_g251650 , 0.0 );
					float4 In_MaskI431_g251650 = float4( Weights422_g251650 , 0.0 );
					float4 In_MaskJ431_g251650 = float4( Weights423_g251650 , 0.0 );
					half3 Model_NormalWS226_g251628 = Out_NormalWS15_g251629;
					float3 temp_output_449_0_g251650 = Model_NormalWS226_g251628;
					float4 In_MaskK431_g251650 = float4( temp_output_449_0_g251650 , 0.0 );
					half3 Model_TangentWS366_g251628 = Out_TangentWS15_g251629;
					float3 temp_output_450_0_g251650 = Model_TangentWS366_g251628;
					float4 In_MaskL431_g251650 = float4( temp_output_450_0_g251650 , 0.0 );
					half3 Model_BitangentWS367_g251628 = Out_BitangentWS15_g251629;
					float3 temp_output_451_0_g251650 = Model_BitangentWS367_g251628;
					float4 In_MaskM431_g251650 = float4( temp_output_451_0_g251650 , 0.0 );
					half3 Model_TriplanarWeights368_g251628 = Out_TriplanarWeights15_g251629;
					float3 temp_output_445_0_g251650 = Model_TriplanarWeights368_g251628;
					float4 In_MaskN431_g251650 = float4( temp_output_445_0_g251650 , 0.0 );
					BuildTextureData( Data431_g251650 , In_MaskA431_g251650 , In_MaskB431_g251650 , In_MaskC431_g251650 , In_MaskD431_g251650 , In_MaskE431_g251650 , In_MaskF431_g251650 , In_MaskG431_g251650 , In_MaskH431_g251650 , In_MaskI431_g251650 , In_MaskJ431_g251650 , In_MaskK431_g251650 , In_MaskL431_g251650 , In_MaskM431_g251650 , In_MaskN431_g251650 );
					TVEMasksData Data456_g251651 =(TVEMasksData)Data431_g251650;
					float4 Out_MaskA456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251651 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251651 , Out_MaskA456_g251651 , Out_MaskB456_g251651 , Out_MaskC456_g251651 , Out_MaskD456_g251651 , Out_MaskE456_g251651 , Out_MaskF456_g251651 , Out_MaskG456_g251651 , Out_MaskH456_g251651 , Out_MaskI456_g251651 , Out_MaskJ456_g251651 , Out_MaskK456_g251651 , Out_MaskL456_g251651 , Out_MaskM456_g251651 , Out_MaskN456_g251651 );
					half2 UV276_g251651 = (Out_MaskA456_g251651).xy;
					float temp_output_504_0_g251651 = 0.0;
					half Bias276_g251651 = temp_output_504_0_g251651;
					half2 Normal276_g251651 = float2( 0,0 );
					half4 localSampleCoord276_g251651 = SampleCoord( Texture276_g251651 , Sampler276_g251651 , UV276_g251651 , Bias276_g251651 , Normal276_g251651 );
					float4 temp_output_407_277_g251628 = localSampleCoord276_g251651;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251651) = _MainAlbedoTex;
					SamplerState Sampler502_g251651 = staticSwitch36_g251633;
					half2 UV502_g251651 = (Out_MaskA456_g251651).zw;
					half Bias502_g251651 = temp_output_504_0_g251651;
					half2 Normal502_g251651 = float2( 0,0 );
					half4 localSampleCoord502_g251651 = SampleCoord( Texture502_g251651 , Sampler502_g251651 , UV502_g251651 , Bias502_g251651 , Normal502_g251651 );
					float4 temp_output_407_278_g251628 = localSampleCoord502_g251651;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251651) = _MainAlbedoTex;
					SamplerState Sampler496_g251651 = staticSwitch36_g251633;
					float2 temp_output_463_0_g251651 = (Out_MaskB456_g251651).zw;
					half2 XZ496_g251651 = temp_output_463_0_g251651;
					half Bias496_g251651 = temp_output_504_0_g251651;
					half3 NormalWS512_g251651 = (Out_MaskK456_g251651).xyz;
					half3 NormalWS496_g251651 = NormalWS512_g251651;
					half3 Normal496_g251651 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251651 = SamplePlanar2D( Texture496_g251651 , Sampler496_g251651 , XZ496_g251651 , Bias496_g251651 , NormalWS496_g251651 , Normal496_g251651 );
					float4 temp_output_407_0_g251628 = localSamplePlanar2D496_g251651;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251651) = _MainAlbedoTex;
					SamplerState Sampler490_g251651 = staticSwitch36_g251633;
					float2 temp_output_462_0_g251651 = (Out_MaskB456_g251651).xy;
					half2 ZY490_g251651 = temp_output_462_0_g251651;
					half2 XZ490_g251651 = temp_output_463_0_g251651;
					float2 temp_output_464_0_g251651 = (Out_MaskC456_g251651).xy;
					half2 XY490_g251651 = temp_output_464_0_g251651;
					half Bias490_g251651 = temp_output_504_0_g251651;
					half3 Triplanar522_g251651 = (Out_MaskN456_g251651).xyz;
					half3 Triplanar490_g251651 = Triplanar522_g251651;
					half3 NormalWS490_g251651 = NormalWS512_g251651;
					half3 Normal490_g251651 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251651 = SamplePlanar3D( Texture490_g251651 , Sampler490_g251651 , ZY490_g251651 , XZ490_g251651 , XY490_g251651 , Bias490_g251651 , Triplanar490_g251651 , NormalWS490_g251651 , Normal490_g251651 );
					float4 temp_output_407_201_g251628 = localSamplePlanar3D490_g251651;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251651) = _MainAlbedoTex;
					SamplerState Sampler498_g251651 = staticSwitch36_g251633;
					half2 XZ498_g251651 = temp_output_463_0_g251651;
					float2 temp_output_473_0_g251651 = (Out_MaskE456_g251651).xy;
					half2 XZ_1498_g251651 = temp_output_473_0_g251651;
					float2 temp_output_474_0_g251651 = (Out_MaskE456_g251651).zw;
					half2 XZ_2498_g251651 = temp_output_474_0_g251651;
					float2 temp_output_475_0_g251651 = (Out_MaskF456_g251651).xy;
					half2 XZ_3498_g251651 = temp_output_475_0_g251651;
					float temp_output_510_0_g251651 = exp2( temp_output_504_0_g251651 );
					half Bias498_g251651 = temp_output_510_0_g251651;
					float3 temp_output_480_0_g251651 = (Out_MaskI456_g251651).xyz;
					half3 Weights_2498_g251651 = temp_output_480_0_g251651;
					half3 NormalWS498_g251651 = NormalWS512_g251651;
					half3 Normal498_g251651 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251651 = SampleStochastic2D( Texture498_g251651 , Sampler498_g251651 , XZ498_g251651 , XZ_1498_g251651 , XZ_2498_g251651 , XZ_3498_g251651 , Bias498_g251651 , Weights_2498_g251651 , NormalWS498_g251651 , Normal498_g251651 );
					float4 temp_output_407_202_g251628 = localSampleStochastic2D498_g251651;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251651) = _MainAlbedoTex;
					SamplerState Sampler500_g251651 = staticSwitch36_g251633;
					half2 ZY500_g251651 = temp_output_462_0_g251651;
					half2 ZY_1500_g251651 = (Out_MaskC456_g251651).zw;
					half2 ZY_2500_g251651 = (Out_MaskD456_g251651).xy;
					half2 ZY_3500_g251651 = (Out_MaskD456_g251651).zw;
					half2 XZ500_g251651 = temp_output_463_0_g251651;
					half2 XZ_1500_g251651 = temp_output_473_0_g251651;
					half2 XZ_2500_g251651 = temp_output_474_0_g251651;
					half2 XZ_3500_g251651 = temp_output_475_0_g251651;
					half2 XY500_g251651 = temp_output_464_0_g251651;
					half2 XY_1500_g251651 = (Out_MaskF456_g251651).zw;
					half2 XY_2500_g251651 = (Out_MaskG456_g251651).xy;
					half2 XY_3500_g251651 = (Out_MaskG456_g251651).zw;
					half Bias500_g251651 = temp_output_510_0_g251651;
					half3 Weights_1500_g251651 = (Out_MaskH456_g251651).xyz;
					half3 Weights_2500_g251651 = temp_output_480_0_g251651;
					half3 Weights_3500_g251651 = (Out_MaskJ456_g251651).xyz;
					half3 Triplanar500_g251651 = Triplanar522_g251651;
					half3 NormalWS500_g251651 = NormalWS512_g251651;
					half3 Normal500_g251651 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251651 = SampleStochastic3D( Texture500_g251651 , Sampler500_g251651 , ZY500_g251651 , ZY_1500_g251651 , ZY_2500_g251651 , ZY_3500_g251651 , XZ500_g251651 , XZ_1500_g251651 , XZ_2500_g251651 , XZ_3500_g251651 , XY500_g251651 , XY_1500_g251651 , XY_2500_g251651 , XY_3500_g251651 , Bias500_g251651 , Weights_1500_g251651 , Weights_2500_g251651 , Weights_3500_g251651 , Triplanar500_g251651 , NormalWS500_g251651 , Normal500_g251651 );
					float4 temp_output_407_203_g251628 = localSampleStochastic3D500_g251651;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g251628 = temp_output_407_277_g251628;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g251628 = temp_output_407_278_g251628;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g251628 = temp_output_407_0_g251628;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g251628 = temp_output_407_201_g251628;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g251628 = temp_output_407_202_g251628;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g251628 = temp_output_407_203_g251628;
					#else
					float4 staticSwitch184_g251628 = temp_output_407_277_g251628;
					#endif
					half4 Local_AlbedoSample185_g251628 = staticSwitch184_g251628;
					float3 lerpResult53_g251628 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g251628).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g251628 = lerpResult53_g251628;
					float temp_output_17_0_g251648 = _MainMultiWriteMode;
					float Option91_g251648 = temp_output_17_0_g251648;
					float4 Model_VertexData418_g251628 = Out_VertexData15_g251629;
					float4 temp_output_84_0_g251648 = Model_VertexData418_g251628;
					float4 ChannelA91_g251648 = temp_output_84_0_g251648;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251636) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g251635 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g251635 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g251635 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g251635 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g251635 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g251635 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251636 = staticSwitch38_g251635;
					float localBreakTextureData456_g251636 = ( 0.0 );
					TVEMasksData Data456_g251636 =(TVEMasksData)Data431_g251650;
					float4 Out_MaskA456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251636 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251636 , Out_MaskA456_g251636 , Out_MaskB456_g251636 , Out_MaskC456_g251636 , Out_MaskD456_g251636 , Out_MaskE456_g251636 , Out_MaskF456_g251636 , Out_MaskG456_g251636 , Out_MaskH456_g251636 , Out_MaskI456_g251636 , Out_MaskJ456_g251636 , Out_MaskK456_g251636 , Out_MaskL456_g251636 , Out_MaskM456_g251636 , Out_MaskN456_g251636 );
					half2 UV276_g251636 = (Out_MaskA456_g251636).xy;
					float temp_output_504_0_g251636 = 0.0;
					half Bias276_g251636 = temp_output_504_0_g251636;
					half2 Normal276_g251636 = float2( 0,0 );
					half4 localSampleCoord276_g251636 = SampleCoord( Texture276_g251636 , Sampler276_g251636 , UV276_g251636 , Bias276_g251636 , Normal276_g251636 );
					float4 temp_output_405_277_g251628 = localSampleCoord276_g251636;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251636) = _MainShaderTex;
					SamplerState Sampler502_g251636 = staticSwitch38_g251635;
					half2 UV502_g251636 = (Out_MaskA456_g251636).zw;
					half Bias502_g251636 = temp_output_504_0_g251636;
					half2 Normal502_g251636 = float2( 0,0 );
					half4 localSampleCoord502_g251636 = SampleCoord( Texture502_g251636 , Sampler502_g251636 , UV502_g251636 , Bias502_g251636 , Normal502_g251636 );
					float4 temp_output_405_278_g251628 = localSampleCoord502_g251636;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251636) = _MainShaderTex;
					SamplerState Sampler496_g251636 = staticSwitch38_g251635;
					float2 temp_output_463_0_g251636 = (Out_MaskB456_g251636).zw;
					half2 XZ496_g251636 = temp_output_463_0_g251636;
					half Bias496_g251636 = temp_output_504_0_g251636;
					half3 NormalWS512_g251636 = (Out_MaskK456_g251636).xyz;
					half3 NormalWS496_g251636 = NormalWS512_g251636;
					half3 Normal496_g251636 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251636 = SamplePlanar2D( Texture496_g251636 , Sampler496_g251636 , XZ496_g251636 , Bias496_g251636 , NormalWS496_g251636 , Normal496_g251636 );
					float4 temp_output_405_0_g251628 = localSamplePlanar2D496_g251636;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251636) = _MainShaderTex;
					SamplerState Sampler490_g251636 = staticSwitch38_g251635;
					float2 temp_output_462_0_g251636 = (Out_MaskB456_g251636).xy;
					half2 ZY490_g251636 = temp_output_462_0_g251636;
					half2 XZ490_g251636 = temp_output_463_0_g251636;
					float2 temp_output_464_0_g251636 = (Out_MaskC456_g251636).xy;
					half2 XY490_g251636 = temp_output_464_0_g251636;
					half Bias490_g251636 = temp_output_504_0_g251636;
					half3 Triplanar522_g251636 = (Out_MaskN456_g251636).xyz;
					half3 Triplanar490_g251636 = Triplanar522_g251636;
					half3 NormalWS490_g251636 = NormalWS512_g251636;
					half3 Normal490_g251636 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251636 = SamplePlanar3D( Texture490_g251636 , Sampler490_g251636 , ZY490_g251636 , XZ490_g251636 , XY490_g251636 , Bias490_g251636 , Triplanar490_g251636 , NormalWS490_g251636 , Normal490_g251636 );
					float4 temp_output_405_201_g251628 = localSamplePlanar3D490_g251636;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251636) = _MainShaderTex;
					SamplerState Sampler498_g251636 = staticSwitch38_g251635;
					half2 XZ498_g251636 = temp_output_463_0_g251636;
					float2 temp_output_473_0_g251636 = (Out_MaskE456_g251636).xy;
					half2 XZ_1498_g251636 = temp_output_473_0_g251636;
					float2 temp_output_474_0_g251636 = (Out_MaskE456_g251636).zw;
					half2 XZ_2498_g251636 = temp_output_474_0_g251636;
					float2 temp_output_475_0_g251636 = (Out_MaskF456_g251636).xy;
					half2 XZ_3498_g251636 = temp_output_475_0_g251636;
					float temp_output_510_0_g251636 = exp2( temp_output_504_0_g251636 );
					half Bias498_g251636 = temp_output_510_0_g251636;
					float3 temp_output_480_0_g251636 = (Out_MaskI456_g251636).xyz;
					half3 Weights_2498_g251636 = temp_output_480_0_g251636;
					half3 NormalWS498_g251636 = NormalWS512_g251636;
					half3 Normal498_g251636 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251636 = SampleStochastic2D( Texture498_g251636 , Sampler498_g251636 , XZ498_g251636 , XZ_1498_g251636 , XZ_2498_g251636 , XZ_3498_g251636 , Bias498_g251636 , Weights_2498_g251636 , NormalWS498_g251636 , Normal498_g251636 );
					float4 temp_output_405_202_g251628 = localSampleStochastic2D498_g251636;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251636) = _MainShaderTex;
					SamplerState Sampler500_g251636 = staticSwitch38_g251635;
					half2 ZY500_g251636 = temp_output_462_0_g251636;
					half2 ZY_1500_g251636 = (Out_MaskC456_g251636).zw;
					half2 ZY_2500_g251636 = (Out_MaskD456_g251636).xy;
					half2 ZY_3500_g251636 = (Out_MaskD456_g251636).zw;
					half2 XZ500_g251636 = temp_output_463_0_g251636;
					half2 XZ_1500_g251636 = temp_output_473_0_g251636;
					half2 XZ_2500_g251636 = temp_output_474_0_g251636;
					half2 XZ_3500_g251636 = temp_output_475_0_g251636;
					half2 XY500_g251636 = temp_output_464_0_g251636;
					half2 XY_1500_g251636 = (Out_MaskF456_g251636).zw;
					half2 XY_2500_g251636 = (Out_MaskG456_g251636).xy;
					half2 XY_3500_g251636 = (Out_MaskG456_g251636).zw;
					half Bias500_g251636 = temp_output_510_0_g251636;
					half3 Weights_1500_g251636 = (Out_MaskH456_g251636).xyz;
					half3 Weights_2500_g251636 = temp_output_480_0_g251636;
					half3 Weights_3500_g251636 = (Out_MaskJ456_g251636).xyz;
					half3 Triplanar500_g251636 = Triplanar522_g251636;
					half3 NormalWS500_g251636 = NormalWS512_g251636;
					half3 Normal500_g251636 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251636 = SampleStochastic3D( Texture500_g251636 , Sampler500_g251636 , ZY500_g251636 , ZY_1500_g251636 , ZY_2500_g251636 , ZY_3500_g251636 , XZ500_g251636 , XZ_1500_g251636 , XZ_2500_g251636 , XZ_3500_g251636 , XY500_g251636 , XY_1500_g251636 , XY_2500_g251636 , XY_3500_g251636 , Bias500_g251636 , Weights_1500_g251636 , Weights_2500_g251636 , Weights_3500_g251636 , Triplanar500_g251636 , NormalWS500_g251636 , Normal500_g251636 );
					float4 temp_output_405_203_g251628 = localSampleStochastic3D500_g251636;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g251628 = temp_output_405_277_g251628;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g251628 = temp_output_405_278_g251628;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g251628 = temp_output_405_0_g251628;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g251628 = temp_output_405_201_g251628;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g251628 = temp_output_405_202_g251628;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g251628 = temp_output_405_203_g251628;
					#else
					float4 staticSwitch198_g251628 = temp_output_405_277_g251628;
					#endif
					half4 Local_ShaderSample199_g251628 = staticSwitch198_g251628;
					float2 appendResult428_g251628 = (float2((Local_AlbedoSample185_g251628).w , (Local_ShaderSample199_g251628).z));
					float2 temp_output_85_0_g251648 = appendResult428_g251628;
					float4 ChannelB91_g251648 = float4( temp_output_85_0_g251648, 0.0 , 0.0 );
					float localSwitchChannel691_g251648 = SwitchChannel6( Option91_g251648 , ChannelA91_g251648 , ChannelB91_g251648 );
					float clampResult17_g251646 = clamp( localSwitchChannel691_g251648 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251647 = _MainMultiWriteRemap.x;
					float temp_output_9_0_g251647 = ( clampResult17_g251646 - temp_output_7_0_g251647 );
					half Local_MultiMask78_g251628 = saturate( ( temp_output_9_0_g251647 * _MainMultiWriteRemap.z ) );
					float lerpResult58_g251628 = lerp( 1.0 , Local_MultiMask78_g251628 , _MainColorMode);
					float4 lerpResult62_g251628 = lerp( _MainColorTwo , _MainColor , lerpResult58_g251628);
					half3 Local_ColorRGB93_g251628 = (lerpResult62_g251628).rgb;
					half3 Local_Albedo139_g251628 = ( Local_AlbedoRGB107_g251628 * Local_ColorRGB93_g251628 );
					float3 temp_output_4_0_g251630 = Local_Albedo139_g251628;
					float3 In_Albedo3_g251630 = temp_output_4_0_g251630;
					float3 temp_output_44_0_g251630 = Local_Albedo139_g251628;
					float3 In_AlbedoBase3_g251630 = temp_output_44_0_g251630;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251657) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g251634 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g251634 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g251634 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g251634 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g251634 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g251634 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251657 = staticSwitch37_g251634;
					float localBreakTextureData456_g251657 = ( 0.0 );
					TVEMasksData Data456_g251657 =(TVEMasksData)Data431_g251650;
					float4 Out_MaskA456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251657 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251657 , Out_MaskA456_g251657 , Out_MaskB456_g251657 , Out_MaskC456_g251657 , Out_MaskD456_g251657 , Out_MaskE456_g251657 , Out_MaskF456_g251657 , Out_MaskG456_g251657 , Out_MaskH456_g251657 , Out_MaskI456_g251657 , Out_MaskJ456_g251657 , Out_MaskK456_g251657 , Out_MaskL456_g251657 , Out_MaskM456_g251657 , Out_MaskN456_g251657 );
					half2 UV276_g251657 = (Out_MaskA456_g251657).xy;
					float temp_output_504_0_g251657 = 0.0;
					half Bias276_g251657 = temp_output_504_0_g251657;
					half2 Normal276_g251657 = float2( 0,0 );
					half4 localSampleCoord276_g251657 = SampleCoord( Texture276_g251657 , Sampler276_g251657 , UV276_g251657 , Bias276_g251657 , Normal276_g251657 );
					float2 temp_output_406_394_g251628 = Normal276_g251657;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251657) = _MainNormalTex;
					SamplerState Sampler502_g251657 = staticSwitch37_g251634;
					half2 UV502_g251657 = (Out_MaskA456_g251657).zw;
					half Bias502_g251657 = temp_output_504_0_g251657;
					half2 Normal502_g251657 = float2( 0,0 );
					half4 localSampleCoord502_g251657 = SampleCoord( Texture502_g251657 , Sampler502_g251657 , UV502_g251657 , Bias502_g251657 , Normal502_g251657 );
					float2 temp_output_406_397_g251628 = Normal502_g251657;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251657) = _MainNormalTex;
					SamplerState Sampler496_g251657 = staticSwitch37_g251634;
					float2 temp_output_463_0_g251657 = (Out_MaskB456_g251657).zw;
					half2 XZ496_g251657 = temp_output_463_0_g251657;
					half Bias496_g251657 = temp_output_504_0_g251657;
					half3 NormalWS512_g251657 = (Out_MaskK456_g251657).xyz;
					half3 NormalWS496_g251657 = NormalWS512_g251657;
					half3 Normal496_g251657 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251657 = SamplePlanar2D( Texture496_g251657 , Sampler496_g251657 , XZ496_g251657 , Bias496_g251657 , NormalWS496_g251657 , Normal496_g251657 );
					float3 temp_output_35_0_g251660 = Normal496_g251657;
					half3 TangentWS519_g251657 = (Out_MaskL456_g251657).xyz;
					float dotResult84_g251660 = dot( temp_output_35_0_g251660 , TangentWS519_g251657 );
					half3 BitangentWS521_g251657 = (Out_MaskM456_g251657).xyz;
					float dotResult85_g251660 = dot( temp_output_35_0_g251660 , BitangentWS521_g251657 );
					float2 appendResult87_g251660 = (float2(dotResult84_g251660 , dotResult85_g251660));
					float2 temp_output_406_375_g251628 = appendResult87_g251660;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251657) = _MainNormalTex;
					SamplerState Sampler490_g251657 = staticSwitch37_g251634;
					float2 temp_output_462_0_g251657 = (Out_MaskB456_g251657).xy;
					half2 ZY490_g251657 = temp_output_462_0_g251657;
					half2 XZ490_g251657 = temp_output_463_0_g251657;
					float2 temp_output_464_0_g251657 = (Out_MaskC456_g251657).xy;
					half2 XY490_g251657 = temp_output_464_0_g251657;
					half Bias490_g251657 = temp_output_504_0_g251657;
					half3 Triplanar522_g251657 = (Out_MaskN456_g251657).xyz;
					half3 Triplanar490_g251657 = Triplanar522_g251657;
					half3 NormalWS490_g251657 = NormalWS512_g251657;
					half3 Normal490_g251657 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251657 = SamplePlanar3D( Texture490_g251657 , Sampler490_g251657 , ZY490_g251657 , XZ490_g251657 , XY490_g251657 , Bias490_g251657 , Triplanar490_g251657 , NormalWS490_g251657 , Normal490_g251657 );
					float3 temp_output_35_0_g251661 = Normal490_g251657;
					float dotResult84_g251661 = dot( temp_output_35_0_g251661 , TangentWS519_g251657 );
					float dotResult85_g251661 = dot( temp_output_35_0_g251661 , BitangentWS521_g251657 );
					float2 appendResult87_g251661 = (float2(dotResult84_g251661 , dotResult85_g251661));
					float2 temp_output_406_353_g251628 = appendResult87_g251661;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251657) = _MainNormalTex;
					SamplerState Sampler498_g251657 = staticSwitch37_g251634;
					half2 XZ498_g251657 = temp_output_463_0_g251657;
					float2 temp_output_473_0_g251657 = (Out_MaskE456_g251657).xy;
					half2 XZ_1498_g251657 = temp_output_473_0_g251657;
					float2 temp_output_474_0_g251657 = (Out_MaskE456_g251657).zw;
					half2 XZ_2498_g251657 = temp_output_474_0_g251657;
					float2 temp_output_475_0_g251657 = (Out_MaskF456_g251657).xy;
					half2 XZ_3498_g251657 = temp_output_475_0_g251657;
					float temp_output_510_0_g251657 = exp2( temp_output_504_0_g251657 );
					half Bias498_g251657 = temp_output_510_0_g251657;
					float3 temp_output_480_0_g251657 = (Out_MaskI456_g251657).xyz;
					half3 Weights_2498_g251657 = temp_output_480_0_g251657;
					half3 NormalWS498_g251657 = NormalWS512_g251657;
					half3 Normal498_g251657 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251657 = SampleStochastic2D( Texture498_g251657 , Sampler498_g251657 , XZ498_g251657 , XZ_1498_g251657 , XZ_2498_g251657 , XZ_3498_g251657 , Bias498_g251657 , Weights_2498_g251657 , NormalWS498_g251657 , Normal498_g251657 );
					float3 temp_output_35_0_g251662 = Normal498_g251657;
					float dotResult84_g251662 = dot( temp_output_35_0_g251662 , TangentWS519_g251657 );
					float dotResult85_g251662 = dot( temp_output_35_0_g251662 , BitangentWS521_g251657 );
					float2 appendResult87_g251662 = (float2(dotResult84_g251662 , dotResult85_g251662));
					float2 temp_output_406_391_g251628 = appendResult87_g251662;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251657) = _MainNormalTex;
					SamplerState Sampler500_g251657 = staticSwitch37_g251634;
					half2 ZY500_g251657 = temp_output_462_0_g251657;
					half2 ZY_1500_g251657 = (Out_MaskC456_g251657).zw;
					half2 ZY_2500_g251657 = (Out_MaskD456_g251657).xy;
					half2 ZY_3500_g251657 = (Out_MaskD456_g251657).zw;
					half2 XZ500_g251657 = temp_output_463_0_g251657;
					half2 XZ_1500_g251657 = temp_output_473_0_g251657;
					half2 XZ_2500_g251657 = temp_output_474_0_g251657;
					half2 XZ_3500_g251657 = temp_output_475_0_g251657;
					half2 XY500_g251657 = temp_output_464_0_g251657;
					half2 XY_1500_g251657 = (Out_MaskF456_g251657).zw;
					half2 XY_2500_g251657 = (Out_MaskG456_g251657).xy;
					half2 XY_3500_g251657 = (Out_MaskG456_g251657).zw;
					half Bias500_g251657 = temp_output_510_0_g251657;
					half3 Weights_1500_g251657 = (Out_MaskH456_g251657).xyz;
					half3 Weights_2500_g251657 = temp_output_480_0_g251657;
					half3 Weights_3500_g251657 = (Out_MaskJ456_g251657).xyz;
					half3 Triplanar500_g251657 = Triplanar522_g251657;
					half3 NormalWS500_g251657 = NormalWS512_g251657;
					half3 Normal500_g251657 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251657 = SampleStochastic3D( Texture500_g251657 , Sampler500_g251657 , ZY500_g251657 , ZY_1500_g251657 , ZY_2500_g251657 , ZY_3500_g251657 , XZ500_g251657 , XZ_1500_g251657 , XZ_2500_g251657 , XZ_3500_g251657 , XY500_g251657 , XY_1500_g251657 , XY_2500_g251657 , XY_3500_g251657 , Bias500_g251657 , Weights_1500_g251657 , Weights_2500_g251657 , Weights_3500_g251657 , Triplanar500_g251657 , NormalWS500_g251657 , Normal500_g251657 );
					float3 temp_output_35_0_g251658 = Normal500_g251657;
					float dotResult84_g251658 = dot( temp_output_35_0_g251658 , TangentWS519_g251657 );
					float dotResult85_g251658 = dot( temp_output_35_0_g251658 , BitangentWS521_g251657 );
					float2 appendResult87_g251658 = (float2(dotResult84_g251658 , dotResult85_g251658));
					float2 temp_output_406_390_g251628 = appendResult87_g251658;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g251628 = temp_output_406_394_g251628;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g251628 = temp_output_406_397_g251628;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g251628 = temp_output_406_375_g251628;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g251628 = temp_output_406_353_g251628;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g251628 = temp_output_406_391_g251628;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g251628 = temp_output_406_390_g251628;
					#else
					float2 staticSwitch193_g251628 = temp_output_406_394_g251628;
					#endif
					half2 Local_NormaSample191_g251628 = staticSwitch193_g251628;
					half2 Local_NormalTS108_g251628 = ( Local_NormaSample191_g251628 * _MainNormalValue );
					float2 In_NormalTS3_g251630 = Local_NormalTS108_g251628;
					float2 break80_g251649 = Local_NormalTS108_g251628;
					float3 temp_output_77_0_g251649 = Model_TangentWS366_g251628;
					float3 temp_output_78_0_g251649 = Model_BitangentWS367_g251628;
					float3 temp_output_76_0_g251649 = Model_NormalWS226_g251628;
					half3 Local_NormalWS250_g251628 = ( ( break80_g251649.x * temp_output_77_0_g251649 ) + ( break80_g251649.y * temp_output_78_0_g251649 ) + temp_output_76_0_g251649 );
					float3 In_NormalWS3_g251630 = Local_NormalWS250_g251628;
					float temp_output_209_0_g251628 = (Local_ShaderSample199_g251628).y;
					float temp_output_7_0_g251642 = _MainOcclusionRemap.x;
					float temp_output_9_0_g251642 = ( temp_output_209_0_g251628 - temp_output_7_0_g251642 );
					float lerpResult23_g251628 = lerp( 1.0 , saturate( ( temp_output_9_0_g251642 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g251628 = lerpResult23_g251628;
					float temp_output_213_0_g251628 = (Local_ShaderSample199_g251628).w;
					float temp_output_7_0_g251645 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g251645 = ( temp_output_213_0_g251628 - temp_output_7_0_g251645 );
					half Local_Smoothness317_g251628 = ( saturate( ( temp_output_9_0_g251645 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g251628 = (float4(( (Local_ShaderSample199_g251628).x * _MainMetallicValue ) , Local_Occlusion313_g251628 , (Local_ShaderSample199_g251628).z , Local_Smoothness317_g251628));
					half4 Local_Masks109_g251628 = appendResult73_g251628;
					float4 In_Shader3_g251630 = Local_Masks109_g251628;
					float4 In_Feature3_g251630 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251630 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251630 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g251663 = Local_Albedo139_g251628;
					float dotResult20_g251663 = dot( temp_output_3_0_g251663 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g251628 = dotResult20_g251663;
					float temp_output_12_0_g251630 = Local_Grayscale110_g251628;
					float In_Grayscale3_g251630 = temp_output_12_0_g251630;
					float temp_output_3_0_g251664 = Local_Grayscale110_g251628;
					float clampResult27_g251664 = clamp( saturate( ( temp_output_3_0_g251664 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g251628 = clampResult27_g251664;
					float temp_output_16_0_g251630 = Local_Luminosity145_g251628;
					float In_Luminosity3_g251630 = temp_output_16_0_g251630;
					float In_MultiMask3_g251630 = Local_MultiMask78_g251628;
					float temp_output_187_0_g251628 = (Local_AlbedoSample185_g251628).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g251628 = ( temp_output_187_0_g251628 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g251628 = temp_output_187_0_g251628;
					#endif
					half Local_AlphaClip111_g251628 = staticSwitch236_g251628;
					float In_AlphaClip3_g251630 = Local_AlphaClip111_g251628;
					half Local_AlphaFade246_g251628 = (lerpResult62_g251628).a;
					float In_AlphaFade3_g251630 = Local_AlphaFade246_g251628;
					float3 temp_cast_24 = (1.0).xxx;
					float3 In_Translucency3_g251630 = temp_cast_24;
					float In_Transmission3_g251630 = 1.0;
					float In_Thickness3_g251630 = 0.0;
					float In_Diffusion3_g251630 = 0.0;
					float In_Depth3_g251630 = 0.0;
					BuildVisualData( Data3_g251630 , In_Dummy3_g251630 , In_Albedo3_g251630 , In_AlbedoBase3_g251630 , In_NormalTS3_g251630 , In_NormalWS3_g251630 , In_Shader3_g251630 , In_Feature3_g251630 , In_Season3_g251630 , In_Emissive3_g251630 , In_Grayscale3_g251630 , In_Luminosity3_g251630 , In_MultiMask3_g251630 , In_AlphaClip3_g251630 , In_AlphaFade3_g251630 , In_Translucency3_g251630 , In_Transmission3_g251630 , In_Thickness3_g251630 , In_Diffusion3_g251630 , In_Depth3_g251630 );
					TVEVisualData Data4_g251672 =(TVEVisualData)Data3_g251630;
					float Out_Dummy4_g251672 = 0.0;
					float3 Out_Albedo4_g251672 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g251672 = float3( 0,0,0 );
					float2 Out_NormalTS4_g251672 = float2( 0,0 );
					float3 Out_NormalWS4_g251672 = float3( 0,0,0 );
					float4 Out_Shader4_g251672 = float4( 0,0,0,0 );
					float4 Out_Feature4_g251672 = float4( 0,0,0,0 );
					float4 Out_Season4_g251672 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g251672 = float4( 0,0,0,0 );
					float Out_MultiMask4_g251672 = 0.0;
					float Out_Grayscale4_g251672 = 0.0;
					float Out_Luminosity4_g251672 = 0.0;
					float Out_AlphaClip4_g251672 = 0.0;
					float Out_AlphaFade4_g251672 = 0.0;
					float3 Out_Translucency4_g251672 = float3( 0,0,0 );
					float Out_Transmission4_g251672 = 0.0;
					float Out_Thickness4_g251672 = 0.0;
					float Out_Diffusion4_g251672 = 0.0;
					float Out_Depth4_g251672 = 0.0;
					BreakVisualData( Data4_g251672 , Out_Dummy4_g251672 , Out_Albedo4_g251672 , Out_AlbedoBase4_g251672 , Out_NormalTS4_g251672 , Out_NormalWS4_g251672 , Out_Shader4_g251672 , Out_Feature4_g251672 , Out_Season4_g251672 , Out_Emissive4_g251672 , Out_MultiMask4_g251672 , Out_Grayscale4_g251672 , Out_Luminosity4_g251672 , Out_AlphaClip4_g251672 , Out_AlphaFade4_g251672 , Out_Translucency4_g251672 , Out_Transmission4_g251672 , Out_Thickness4_g251672 , Out_Diffusion4_g251672 , Out_Depth4_g251672 );
					float Alpha109_g251667 = Out_AlphaClip4_g251672;
					float lerpResult91_g251667 = lerp( 1.0 , Alpha109_g251667 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g251667 = lerp( 1.0 , lerpResult91_g251667 , Filter152_g251667);
					clip( lerpResult154_g251667 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = half3( 0, 0, 0 );
					half Metallic = temp_output_2419_114;
					half Smoothness = temp_output_2419_114;
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

					o.Emission = ( lerpResult72_g251667 * lerpResult84_g251667 );
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
					float4 ase_color : COLOR;
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
				uniform float _IsLightingType;
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

					TVEVertexData Data16_g251543 =(TVEVertexData)0;
					float In_Dummy16_g251543 = 0.0;
					TVEVertexData Data16_g251538 =(TVEVertexData)0;
					float In_Dummy16_g251538 = 0.0;
					TVEModelData Data16_g240700 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g240682 = _ObjectCoordMode;
					#else
					float staticSwitch343_g240682 = _ObjectCoordMode;
					#endif
					half Dummy207_g240682 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g240682 );
					float temp_output_14_0_g240700 = Dummy207_g240682;
					float In_Dummy16_g240700 = temp_output_14_0_g240700;
					float3 PositionOS131_g240682 = v.vertex.xyz;
					float3 temp_output_4_0_g240700 = PositionOS131_g240682;
					float3 In_PositionOS16_g240700 = temp_output_4_0_g240700;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g240682 = ase_positionWS;
					float3 vertexToFrag73_g240682 = temp_output_104_7_g240682;
					float3 PositionWS122_g240682 = vertexToFrag73_g240682;
					float3 In_PositionWS16_g240700 = PositionWS122_g240682;
					float4x4 break19_g240685 = unity_ObjectToWorld;
					float3 appendResult20_g240685 = (float3(break19_g240685[ 0 ][ 3 ] , break19_g240685[ 1 ][ 3 ] , break19_g240685[ 2 ][ 3 ]));
					float3 temp_output_340_7_g240682 = appendResult20_g240685;
					float4x4 break19_g240687 = unity_ObjectToWorld;
					float3 appendResult20_g240687 = (float3(break19_g240687[ 0 ][ 3 ] , break19_g240687[ 1 ][ 3 ] , break19_g240687[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g240683 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g240682 = PositionOS131_g240682;
					float3 appendResult234_g240682 = (float3(break233_g240682.x , 0.0 , break233_g240682.z));
					float3 break413_g240682 = PositionOS131_g240682;
					float3 appendResult414_g240682 = (float3(break413_g240682.x , break413_g240682.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g240689 = appendResult414_g240682;
					#else
					float3 staticSwitch65_g240689 = appendResult234_g240682;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g240682 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g240682 = appendResult60_g240683;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g240682 = staticSwitch65_g240689;
					#else
					float3 staticSwitch229_g240682 = _Vector0;
					#endif
					float3 PivotOS149_g240682 = staticSwitch229_g240682;
					float3 temp_output_122_0_g240687 = PivotOS149_g240682;
					float3 PivotsOnlyWS105_g240687 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g240687 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g240682 = ( appendResult20_g240687 + PivotsOnlyWS105_g240687 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g240682 = temp_output_340_7_g240682;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g240682 = temp_output_341_7_g240682;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g240682 = temp_output_341_7_g240682;
					#else
					float3 staticSwitch236_g240682 = temp_output_340_7_g240682;
					#endif
					float3 vertexToFrag76_g240682 = staticSwitch236_g240682;
					float3 PivotWS121_g240682 = vertexToFrag76_g240682;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g240682 = ( PositionWS122_g240682 - PivotWS121_g240682 );
					#else
					float3 staticSwitch204_g240682 = PositionWS122_g240682;
					#endif
					float3 PositionWO132_g240682 = ( staticSwitch204_g240682 - TVE_WorldOrigin );
					float3 In_PositionWO16_g240700 = PositionWO132_g240682;
					float3 In_PivotOS16_g240700 = PivotOS149_g240682;
					float3 In_PivotWS16_g240700 = PivotWS121_g240682;
					float3 PivotWO133_g240682 = ( PivotWS121_g240682 - TVE_WorldOrigin );
					float3 In_PivotWO16_g240700 = PivotWO133_g240682;
					half3 NormalOS134_g240682 = v.normal;
					float3 temp_output_21_0_g240700 = NormalOS134_g240682;
					float3 In_NormalOS16_g240700 = temp_output_21_0_g240700;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g240682 = normalizedWorldNormal;
					float3 In_NormalWS16_g240700 = NormalWS95_g240682;
					half4 TangentlOS153_g240682 = v.tangent;
					float4 temp_output_6_0_g240700 = TangentlOS153_g240682;
					float4 In_TangentOS16_g240700 = temp_output_6_0_g240700;
					float3 normalizeResult296_g240682 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g240682 ) );
					half3 ViewDirWS169_g240682 = normalizeResult296_g240682;
					float3 In_ViewDirWS16_g240700 = ViewDirWS169_g240682;
					float4 appendResult397_g240682 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g240682 = appendResult397_g240682;
					float4 In_CoordsData16_g240700 = CoordsData398_g240682;
					half4 VertexMasks171_g240682 = v.ase_color;
					float4 In_VertexData16_g240700 = VertexMasks171_g240682;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g240694 = (PositionOS131_g240682).z;
					#else
					float staticSwitch65_g240694 = (PositionOS131_g240682).y;
					#endif
					half Object_HeightValue267_g240682 = _ObjectHeightValue;
					half Bounds_HeightMask274_g240682 = saturate( ( staticSwitch65_g240694 / Object_HeightValue267_g240682 ) );
					half3 Position387_g240682 = PositionOS131_g240682;
					half Height387_g240682 = Object_HeightValue267_g240682;
					half Object_RadiusValue268_g240682 = _ObjectRadiusValue;
					half Radius387_g240682 = Object_RadiusValue268_g240682;
					half localCapsuleMaskYUp387_g240682 = CapsuleMaskYUp( Position387_g240682 , Height387_g240682 , Radius387_g240682 );
					half3 Position408_g240682 = PositionOS131_g240682;
					half Height408_g240682 = Object_HeightValue267_g240682;
					half Radius408_g240682 = Object_RadiusValue268_g240682;
					half localCapsuleMaskZUp408_g240682 = CapsuleMaskZUp( Position408_g240682 , Height408_g240682 , Radius408_g240682 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g240699 = saturate( localCapsuleMaskZUp408_g240682 );
					#else
					float staticSwitch65_g240699 = saturate( localCapsuleMaskYUp387_g240682 );
					#endif
					half Bounds_SphereMask282_g240682 = staticSwitch65_g240699;
					float4 appendResult253_g240682 = (float4(Bounds_HeightMask274_g240682 , Bounds_SphereMask282_g240682 , 1.0 , 1.0));
					half4 MasksData254_g240682 = appendResult253_g240682;
					float4 In_MasksData16_g240700 = MasksData254_g240682;
					float temp_output_17_0_g240693 = _ObjectPhaseMode;
					float Option70_g240693 = temp_output_17_0_g240693;
					float4 temp_output_3_0_g240693 = v.ase_color;
					float4 Channel70_g240693 = temp_output_3_0_g240693;
					float localSwitchChannel470_g240693 = SwitchChannel4( Option70_g240693 , Channel70_g240693 );
					half Phase_Value372_g240682 = localSwitchChannel470_g240693;
					float3 break319_g240682 = PivotWO133_g240682;
					half Pivot_Position322_g240682 = ( break319_g240682.x + break319_g240682.z );
					half Phase_Position357_g240682 = ( Phase_Value372_g240682 + Pivot_Position322_g240682 );
					float temp_output_248_0_g240682 = frac( Phase_Position357_g240682 );
					float4 appendResult177_g240682 = (float4((frac( ( Phase_Position357_g240682 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g240682));
					half4 Phase_Data176_g240682 = appendResult177_g240682;
					float4 In_PhaseData16_g240700 = Phase_Data176_g240682;
					BuildModelVertData( Data16_g240700 , In_Dummy16_g240700 , In_PositionOS16_g240700 , In_PositionWS16_g240700 , In_PositionWO16_g240700 , In_PivotOS16_g240700 , In_PivotWS16_g240700 , In_PivotWO16_g240700 , In_NormalOS16_g240700 , In_NormalWS16_g240700 , In_TangentOS16_g240700 , In_ViewDirWS16_g240700 , In_CoordsData16_g240700 , In_VertexData16_g240700 , In_MasksData16_g240700 , In_PhaseData16_g240700 );
					TVEModelData Data15_g251539 =(TVEModelData)Data16_g240700;
					float Out_Dummy15_g251539 = 0.0;
					float3 Out_PositionOS15_g251539 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251539 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251539 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251539 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251539 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251539 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251539 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251539 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251539 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251539 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251539 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251539 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251539 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251539 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251539 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251539 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251539 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251539 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251539 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251539 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251539 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251539 , Out_Dummy15_g251539 , Out_PositionOS15_g251539 , Out_PositionWS15_g251539 , Out_PositionWO15_g251539 , Out_PositionRawOS15_g251539 , Out_PivotOS15_g251539 , Out_PivotWS15_g251539 , Out_PivotWO15_g251539 , Out_NormalOS15_g251539 , Out_NormalWS15_g251539 , Out_NormalRawOS15_g251539 , Out_TangentOS15_g251539 , Out_TangentWS15_g251539 , Out_BitangentWS15_g251539 , Out_ViewDirWS15_g251539 , Out_CoordsData15_g251539 , Out_VertexData15_g251539 , Out_MasksData15_g251539 , Out_PhaseData15_g251539 , Out_TransformData15_g251539 , Out_RotationData15_g251539 , Out_Interpolator15_g251539 );
					float3 In_PositionOS16_g251538 = Out_PositionOS15_g251539;
					float3 In_NormalOS16_g251538 = Out_NormalOS15_g251539;
					float4 In_TangentOS16_g251538 = Out_TangentOS15_g251539;
					float4 In_TransformData16_g251538 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251538 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251538 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251538 , In_Dummy16_g251538 , In_PositionOS16_g251538 , In_NormalOS16_g251538 , In_TangentOS16_g251538 , In_TransformData16_g251538 , In_RotationData16_g251538 , In_Interpolator16_g251538 );
					TVEVertexData Data15_g251541 =(TVEVertexData)Data16_g251538;
					float Out_Dummy15_g251541 = 0.0;
					float3 Out_PositionOS15_g251541 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251541 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251541 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251541 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251541 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251541 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251541 , Out_Dummy15_g251541 , Out_PositionOS15_g251541 , Out_NormalOS15_g251541 , Out_TangentOS15_g251541 , Out_TransformData15_g251541 , Out_RotationData15_g251541 , Out_Interpolator15_g251541 );
					TVEModelData Data15_g251542 =(TVEModelData)Data15_g251539;
					float Out_Dummy15_g251542 = 0.0;
					float3 Out_PositionOS15_g251542 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251542 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251542 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251542 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251542 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251542 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251542 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251542 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251542 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251542 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251542 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251542 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251542 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251542 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251542 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251542 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251542 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251542 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251542 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251542 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251542 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251542 , Out_Dummy15_g251542 , Out_PositionOS15_g251542 , Out_PositionWS15_g251542 , Out_PositionWO15_g251542 , Out_PositionRawOS15_g251542 , Out_PivotOS15_g251542 , Out_PivotWS15_g251542 , Out_PivotWO15_g251542 , Out_NormalOS15_g251542 , Out_NormalWS15_g251542 , Out_NormalRawOS15_g251542 , Out_TangentOS15_g251542 , Out_TangentWS15_g251542 , Out_BitangentWS15_g251542 , Out_ViewDirWS15_g251542 , Out_CoordsData15_g251542 , Out_VertexData15_g251542 , Out_MasksData15_g251542 , Out_PhaseData15_g251542 , Out_TransformData15_g251542 , Out_RotationData15_g251542 , Out_Interpolator15_g251542 );
					float3 In_PositionOS16_g251543 = ( Out_PositionOS15_g251541 - Out_PivotOS15_g251542 );
					float3 In_NormalOS16_g251543 = Out_NormalOS15_g251542;
					float4 In_TangentOS16_g251543 = Out_TangentOS15_g251542;
					float4 In_TransformData16_g251543 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251543 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251543 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251543 , In_Dummy16_g251543 , In_PositionOS16_g251543 , In_NormalOS16_g251543 , In_TangentOS16_g251543 , In_TransformData16_g251543 , In_RotationData16_g251543 , In_Interpolator16_g251543 );
					TVEVertexData Data15_g251552 =(TVEVertexData)Data16_g251543;
					float Out_Dummy15_g251552 = 0.0;
					float3 Out_PositionOS15_g251552 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251552 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251552 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251552 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251552 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251552 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251552 , Out_Dummy15_g251552 , Out_PositionOS15_g251552 , Out_NormalOS15_g251552 , Out_TangentOS15_g251552 , Out_TransformData15_g251552 , Out_RotationData15_g251552 , Out_Interpolator15_g251552 );
					TVEVertexData Data16_g251553 =(TVEVertexData)Data15_g251552;
					half Dummy317_g251544 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251553 = Dummy317_g251544;
					float3 In_PositionOS16_g251553 = Out_PositionOS15_g251552;
					float3 In_NormalOS16_g251553 = Out_NormalOS15_g251552;
					float4 In_TangentOS16_g251553 = Out_TangentOS15_g251552;
					half4 Model_TransformData356_g251544 = Out_TransformData15_g251552;
					float localBuildGlobalData204_g240581 = ( 0.0 );
					TVEGlobalData Data204_g240581 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g240581 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g240581 = Dummy211_g240581;
					float4 temp_output_203_0_g240600 = TVE_CoatBaseCoord;
					TVEModelData Data16_g240690 =(TVEModelData)0;
					float In_Dummy16_g240690 = 0.0;
					float3 In_PositionWS16_g240690 = PositionWS122_g240682;
					float3 In_PositionWO16_g240690 = PositionWO132_g240682;
					float3 In_PivotWS16_g240690 = PivotWS121_g240682;
					float3 In_PivotWO16_g240690 = PivotWO133_g240682;
					float3 In_NormalWS16_g240690 = NormalWS95_g240682;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g240682 = ase_tangentWS;
					float3 In_TangentWS16_g240690 = TangentWS136_g240682;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g240682 = ase_bitangentWS;
					float3 In_BitangentWS16_g240690 = BiangentWS421_g240682;
					half3 NormalWS427_g240682 = NormalWS95_g240682;
					half3 localComputeTriplanarMasks427_g240682 = ComputeTriplanarMasks( NormalWS427_g240682 );
					half3 TriplanarWeights429_g240682 = localComputeTriplanarMasks427_g240682;
					float3 In_TriplanarWeights16_g240690 = TriplanarWeights429_g240682;
					float3 In_ViewDirWS16_g240690 = ViewDirWS169_g240682;
					float4 In_CoordsData16_g240690 = CoordsData398_g240682;
					float4 In_VertexData16_g240690 = VertexMasks171_g240682;
					float4 In_Interpolator16_g240690 = Phase_Data176_g240682;
					BuildModelFragData( Data16_g240690 , In_Dummy16_g240690 , In_PositionWS16_g240690 , In_PositionWO16_g240690 , In_PivotWS16_g240690 , In_PivotWO16_g240690 , In_NormalWS16_g240690 , In_TangentWS16_g240690 , In_BitangentWS16_g240690 , In_TriplanarWeights16_g240690 , In_ViewDirWS16_g240690 , In_CoordsData16_g240690 , In_VertexData16_g240690 , In_Interpolator16_g240690 );
					TVEModelData Data15_g240671 =(TVEModelData)Data16_g240690;
					float Out_Dummy15_g240671 = 0.0;
					float3 Out_PositionWS15_g240671 = float3( 0,0,0 );
					float3 Out_PositionWO15_g240671 = float3( 0,0,0 );
					float3 Out_PivotWS15_g240671 = float3( 0,0,0 );
					float3 Out_PivotWO15_g240671 = float3( 0,0,0 );
					float3 Out_NormalWS15_g240671 = float3( 0,0,0 );
					float3 Out_TangentWS15_g240671 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g240671 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g240671 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g240671 = float3( 0,0,0 );
					float4 Out_CoordsData15_g240671 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g240671 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g240671 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g240671 , Out_Dummy15_g240671 , Out_PositionWS15_g240671 , Out_PositionWO15_g240671 , Out_PivotWS15_g240671 , Out_PivotWO15_g240671 , Out_NormalWS15_g240671 , Out_TangentWS15_g240671 , Out_BitangentWS15_g240671 , Out_TriplanarWeights15_g240671 , Out_ViewDirWS15_g240671 , Out_CoordsData15_g240671 , Out_VertexData15_g240671 , Out_Interpolator15_g240671 );
					float3 Model_PositionWS497_g240581 = Out_PositionWS15_g240671;
					float2 Model_PositionWS_XZ143_g240581 = (Model_PositionWS497_g240581).xz;
					float3 Model_PivotWS498_g240581 = Out_PivotWS15_g240671;
					float2 Model_PivotWS_XZ145_g240581 = (Model_PivotWS498_g240581).xz;
					float2 lerpResult300_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g240600 = lerpResult300_g240581;
					float temp_output_82_0_g240598 = _GlobalCoatLayerValue;
					float temp_output_82_0_g240600 = temp_output_82_0_g240598;
					float4 tex2DArrayNode83_g240600 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240600).zw + ( (temp_output_203_0_g240600).xy * temp_output_81_0_g240600 ) ),temp_output_82_0_g240600), 0.0 );
					float4 appendResult210_g240600 = (float4(tex2DArrayNode83_g240600.rgb , tex2DArrayNode83_g240600.a));
					float4 temp_output_204_0_g240600 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g240600 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240600).zw + ( (temp_output_204_0_g240600).xy * temp_output_81_0_g240600 ) ),temp_output_82_0_g240600), 0.0 );
					float4 appendResult212_g240600 = (float4(tex2DArrayNode122_g240600.rgb , tex2DArrayNode122_g240600.a));
					float4 TVE_RenderNearPositionR628_g240581 = TVE_RenderNearPositionR;
					float temp_output_507_0_g240581 = saturate( ( distance( Model_PositionWS497_g240581 , (TVE_RenderNearPositionR628_g240581).xyz ) / (TVE_RenderNearPositionR628_g240581).w ) );
					float temp_output_7_0_g240670 = 1.0;
					float temp_output_9_0_g240670 = ( temp_output_507_0_g240581 - temp_output_7_0_g240670 );
					half TVE_RenderNearFadeValue635_g240581 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g240581 = saturate( ( temp_output_9_0_g240670 / ( ( TVE_RenderNearFadeValue635_g240581 - temp_output_7_0_g240670 ) + 0.0001 ) ) );
					float4 lerpResult131_g240600 = lerp( appendResult210_g240600 , appendResult212_g240600 , Global_TexBlend509_g240581);
					float4 temp_output_159_109_g240598 = lerpResult131_g240600;
					float4 lerpResult168_g240598 = lerp( TVE_CoatParams , temp_output_159_109_g240598 , TVE_CoatLayers[(int)temp_output_82_0_g240598]);
					float4 temp_output_589_109_g240581 = lerpResult168_g240598;
					half4 Coat_Texture302_g240581 = temp_output_589_109_g240581;
					float4 In_CoatTexture204_g240581 = Coat_Texture302_g240581;
					half4 Draw_Texture656_g240581 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g240581 = Draw_Texture656_g240581;
					float4 temp_output_203_0_g240625 = TVE_PaintBaseCoord;
					float2 lerpResult85_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g240625 = lerpResult85_g240581;
					float temp_output_82_0_g240622 = _GlobalPaintLayerValue;
					float temp_output_82_0_g240625 = temp_output_82_0_g240622;
					float4 tex2DArrayNode83_g240625 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240625).zw + ( (temp_output_203_0_g240625).xy * temp_output_81_0_g240625 ) ),temp_output_82_0_g240625), 0.0 );
					float4 appendResult210_g240625 = (float4(tex2DArrayNode83_g240625.rgb , tex2DArrayNode83_g240625.a));
					float4 temp_output_204_0_g240625 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g240625 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240625).zw + ( (temp_output_204_0_g240625).xy * temp_output_81_0_g240625 ) ),temp_output_82_0_g240625), 0.0 );
					float4 appendResult212_g240625 = (float4(tex2DArrayNode122_g240625.rgb , tex2DArrayNode122_g240625.a));
					float4 lerpResult131_g240625 = lerp( appendResult210_g240625 , appendResult212_g240625 , Global_TexBlend509_g240581);
					float4 temp_output_171_109_g240622 = lerpResult131_g240625;
					float4 lerpResult174_g240622 = lerp( TVE_PaintParams , temp_output_171_109_g240622 , TVE_PaintLayers[(int)temp_output_82_0_g240622]);
					float4 temp_output_595_109_g240581 = lerpResult174_g240622;
					half4 Paint_Texture71_g240581 = temp_output_595_109_g240581;
					float4 In_PaintTexture204_g240581 = Paint_Texture71_g240581;
					float4 temp_output_203_0_g240608 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g240608 = lerpResult104_g240581;
					float temp_output_132_0_g240606 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g240608 = temp_output_132_0_g240606;
					float4 tex2DArrayNode83_g240608 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240608).zw + ( (temp_output_203_0_g240608).xy * temp_output_81_0_g240608 ) ),temp_output_82_0_g240608), 0.0 );
					float4 appendResult210_g240608 = (float4(tex2DArrayNode83_g240608.rgb , tex2DArrayNode83_g240608.a));
					float4 temp_output_204_0_g240608 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g240608 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240608).zw + ( (temp_output_204_0_g240608).xy * temp_output_81_0_g240608 ) ),temp_output_82_0_g240608), 0.0 );
					float4 appendResult212_g240608 = (float4(tex2DArrayNode122_g240608.rgb , tex2DArrayNode122_g240608.a));
					float4 lerpResult131_g240608 = lerp( appendResult210_g240608 , appendResult212_g240608 , Global_TexBlend509_g240581);
					float4 temp_output_137_109_g240606 = lerpResult131_g240608;
					float4 lerpResult145_g240606 = lerp( TVE_AtmoParams , temp_output_137_109_g240606 , TVE_AtmoLayers[(int)temp_output_132_0_g240606]);
					float4 temp_output_590_110_g240581 = lerpResult145_g240606;
					half4 Atmo_Texture80_g240581 = temp_output_590_110_g240581;
					float4 In_AtmoTexture204_g240581 = Atmo_Texture80_g240581;
					float4 temp_output_203_0_g240676 = TVE_EffexBaseCoord;
					float2 lerpResult414_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g240676 = lerpResult414_g240581;
					float temp_output_132_0_g240674 = _GlobalEffexLayerValue;
					float temp_output_82_0_g240676 = temp_output_132_0_g240674;
					float4 tex2DArrayNode83_g240676 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240676).zw + ( (temp_output_203_0_g240676).xy * temp_output_81_0_g240676 ) ),temp_output_82_0_g240676), 0.0 );
					float4 appendResult210_g240676 = (float4(tex2DArrayNode83_g240676.rgb , tex2DArrayNode83_g240676.a));
					float4 temp_output_204_0_g240676 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g240676 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240676).zw + ( (temp_output_204_0_g240676).xy * temp_output_81_0_g240676 ) ),temp_output_82_0_g240676), 0.0 );
					float4 appendResult212_g240676 = (float4(tex2DArrayNode122_g240676.rgb , tex2DArrayNode122_g240676.a));
					float4 lerpResult131_g240676 = lerp( appendResult210_g240676 , appendResult212_g240676 , Global_TexBlend509_g240581);
					float4 temp_output_137_109_g240674 = lerpResult131_g240676;
					float4 lerpResult145_g240674 = lerp( TVE_EffexParams , temp_output_137_109_g240674 , TVE_EffexLayers[(int)temp_output_132_0_g240674]);
					float4 temp_output_731_110_g240581 = lerpResult145_g240674;
					half4 Effex_Texture420_g240581 = temp_output_731_110_g240581;
					float4 In_EffexTexture204_g240581 = Effex_Texture420_g240581;
					float4 temp_output_203_0_g240656 = TVE_GlowBaseCoord;
					float2 lerpResult247_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g240656 = lerpResult247_g240581;
					float temp_output_82_0_g240654 = _GlobalGlowLayerValue;
					float temp_output_82_0_g240656 = temp_output_82_0_g240654;
					float4 tex2DArrayNode83_g240656 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240656).zw + ( (temp_output_203_0_g240656).xy * temp_output_81_0_g240656 ) ),temp_output_82_0_g240656), 0.0 );
					float4 appendResult210_g240656 = (float4(tex2DArrayNode83_g240656.rgb , tex2DArrayNode83_g240656.a));
					float4 temp_output_204_0_g240656 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g240656 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240656).zw + ( (temp_output_204_0_g240656).xy * temp_output_81_0_g240656 ) ),temp_output_82_0_g240656), 0.0 );
					float4 appendResult212_g240656 = (float4(tex2DArrayNode122_g240656.rgb , tex2DArrayNode122_g240656.a));
					float4 lerpResult131_g240656 = lerp( appendResult210_g240656 , appendResult212_g240656 , Global_TexBlend509_g240581);
					float4 temp_output_159_109_g240654 = lerpResult131_g240656;
					float4 lerpResult167_g240654 = lerp( TVE_GlowParams , temp_output_159_109_g240654 , TVE_GlowLayers[(int)temp_output_82_0_g240654]);
					float4 temp_output_593_109_g240581 = lerpResult167_g240654;
					half4 Glow_Texture248_g240581 = temp_output_593_109_g240581;
					float4 In_GlowTexture204_g240581 = Glow_Texture248_g240581;
					float4 temp_output_203_0_g240592 = TVE_FormBaseCoord;
					float2 lerpResult168_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g240592 = lerpResult168_g240581;
					float temp_output_130_0_g240590 = _GlobalFormLayerValue;
					float temp_output_82_0_g240592 = temp_output_130_0_g240590;
					float4 tex2DArrayNode83_g240592 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240592).zw + ( (temp_output_203_0_g240592).xy * temp_output_81_0_g240592 ) ),temp_output_82_0_g240592), 0.0 );
					float4 appendResult210_g240592 = (float4(tex2DArrayNode83_g240592.rgb , tex2DArrayNode83_g240592.a));
					float4 temp_output_204_0_g240592 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g240592 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240592).zw + ( (temp_output_204_0_g240592).xy * temp_output_81_0_g240592 ) ),temp_output_82_0_g240592), 0.0 );
					float4 appendResult212_g240592 = (float4(tex2DArrayNode122_g240592.rgb , tex2DArrayNode122_g240592.a));
					float4 lerpResult131_g240592 = lerp( appendResult210_g240592 , appendResult212_g240592 , Global_TexBlend509_g240581);
					float4 temp_output_135_109_g240590 = lerpResult131_g240592;
					float4 lerpResult143_g240590 = lerp( TVE_FormParams , temp_output_135_109_g240590 , TVE_FormLayers[(int)temp_output_130_0_g240590]);
					float4 temp_output_592_0_g240581 = lerpResult143_g240590;
					float4 Form_Texture112_g240581 = temp_output_592_0_g240581;
					float4 In_FormTexture204_g240581 = Form_Texture112_g240581;
					float4 In_LandTexture204_g240581 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g240640 = TVE_VertxBaseCoord;
					float2 lerpResult681_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g240640 = lerpResult681_g240581;
					float temp_output_136_0_g240638 = _GlobalVertxLayerValue;
					float temp_output_82_0_g240640 = temp_output_136_0_g240638;
					float4 tex2DArrayNode83_g240640 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240640).zw + ( (temp_output_203_0_g240640).xy * temp_output_81_0_g240640 ) ),temp_output_82_0_g240640), 0.0 );
					float4 appendResult210_g240640 = (float4(tex2DArrayNode83_g240640.rgb , tex2DArrayNode83_g240640.a));
					float4 temp_output_204_0_g240640 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g240640 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240640).zw + ( (temp_output_204_0_g240640).xy * temp_output_81_0_g240640 ) ),temp_output_82_0_g240640), 0.0 );
					float4 appendResult212_g240640 = (float4(tex2DArrayNode122_g240640.rgb , tex2DArrayNode122_g240640.a));
					float4 lerpResult131_g240640 = lerp( appendResult210_g240640 , appendResult212_g240640 , Global_TexBlend509_g240581);
					float4 temp_output_141_109_g240638 = lerpResult131_g240640;
					float4 lerpResult149_g240638 = lerp( TVE_VertxParams , temp_output_141_109_g240638 , TVE_VertxLayers[(int)temp_output_136_0_g240638]);
					float4 temp_output_695_0_g240581 = lerpResult149_g240638;
					half4 Vertx_Texture693_g240581 = temp_output_695_0_g240581;
					float4 In_VertxTexture204_g240581 = Vertx_Texture693_g240581;
					float4 temp_output_203_0_g240616 = TVE_FlowBaseCoord;
					float2 lerpResult400_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g240616 = lerpResult400_g240581;
					float temp_output_136_0_g240614 = _GlobalFlowLayerValue;
					float temp_output_82_0_g240616 = temp_output_136_0_g240614;
					float4 tex2DArrayNode83_g240616 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240616).zw + ( (temp_output_203_0_g240616).xy * temp_output_81_0_g240616 ) ),temp_output_82_0_g240616), 0.0 );
					float4 appendResult210_g240616 = (float4(tex2DArrayNode83_g240616.rgb , tex2DArrayNode83_g240616.a));
					float4 temp_output_204_0_g240616 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g240616 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240616).zw + ( (temp_output_204_0_g240616).xy * temp_output_81_0_g240616 ) ),temp_output_82_0_g240616), 0.0 );
					float4 appendResult212_g240616 = (float4(tex2DArrayNode122_g240616.rgb , tex2DArrayNode122_g240616.a));
					float4 lerpResult131_g240616 = lerp( appendResult210_g240616 , appendResult212_g240616 , Global_TexBlend509_g240581);
					float4 temp_output_141_109_g240614 = lerpResult131_g240616;
					float4 lerpResult149_g240614 = lerp( TVE_FlowParams , temp_output_141_109_g240614 , TVE_FlowLayers[(int)temp_output_136_0_g240614]);
					float4 temp_output_594_0_g240581 = lerpResult149_g240614;
					half4 Flow_Texture405_g240581 = temp_output_594_0_g240581;
					float4 In_FlowTexture204_g240581 = Flow_Texture405_g240581;
					half4 User_Texture677_g240581 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g240581 = User_Texture677_g240581;
					BuildGlobalData( Data204_g240581 , In_Dummy204_g240581 , In_CoatTexture204_g240581 , In_DrawTexture204_g240581 , In_PaintTexture204_g240581 , In_AtmoTexture204_g240581 , In_EffexTexture204_g240581 , In_GlowTexture204_g240581 , In_FormTexture204_g240581 , In_LandTexture204_g240581 , In_VertxTexture204_g240581 , In_FlowTexture204_g240581 , In_UserTexture204_g240581 );
					TVEGlobalData Data15_g251554 =(TVEGlobalData)Data204_g240581;
					float Out_Dummy15_g251554 = 0.0;
					float4 Out_CoatTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251554 = float4( 0,0,0,0 );
					BreakData( Data15_g251554 , Out_Dummy15_g251554 , Out_CoatTexture15_g251554 , Out_DrawTexture15_g251554 , Out_PaintTexture15_g251554 , Out_AtmoTexture15_g251554 , Out_EffexTexture15_g251554 , Out_GlowTexture15_g251554 , Out_FormTexture15_g251554 , Out_LandTexture15_g251554 , Out_VertxTexture15_g251554 , Out_FlowTexture15_g251554 , Out_UserTexture15_g251554 );
					float4 Global_FormTexture351_g251544 = Out_FormTexture15_g251554;
					TVEModelData Data15_g251551 =(TVEModelData)Data15_g251542;
					float Out_Dummy15_g251551 = 0.0;
					float3 Out_PositionOS15_g251551 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251551 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251551 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251551 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251551 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251551 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251551 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251551 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251551 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251551 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251551 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251551 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251551 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251551 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251551 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251551 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251551 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251551 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251551 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251551 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251551 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251551 , Out_Dummy15_g251551 , Out_PositionOS15_g251551 , Out_PositionWS15_g251551 , Out_PositionWO15_g251551 , Out_PositionRawOS15_g251551 , Out_PivotOS15_g251551 , Out_PivotWS15_g251551 , Out_PivotWO15_g251551 , Out_NormalOS15_g251551 , Out_NormalWS15_g251551 , Out_NormalRawOS15_g251551 , Out_TangentOS15_g251551 , Out_TangentWS15_g251551 , Out_BitangentWS15_g251551 , Out_ViewDirWS15_g251551 , Out_CoordsData15_g251551 , Out_VertexData15_g251551 , Out_MasksData15_g251551 , Out_PhaseData15_g251551 , Out_TransformData15_g251551 , Out_RotationData15_g251551 , Out_Interpolator15_g251551 );
					float3 Model_PivotWO353_g251544 = Out_PivotWO15_g251551;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251550 = _ConformMeshMode;
					float Option70_g251550 = temp_output_17_0_g251550;
					half4 Model_VertexData357_g251544 = Out_VertexData15_g251551;
					float4 temp_output_3_0_g251550 = Model_VertexData357_g251544;
					float4 Channel70_g251550 = temp_output_3_0_g251550;
					float localSwitchChannel470_g251550 = SwitchChannel4( Option70_g251550 , Channel70_g251550 );
					float temp_output_390_0_g251544 = localSwitchChannel470_g251550;
					float temp_output_7_0_g251547 = _ConformMeshRemap.x;
					float temp_output_9_0_g251547 = ( temp_output_390_0_g251544 - temp_output_7_0_g251547 );
					float lerpResult374_g251544 = lerp( 1.0 , saturate( ( temp_output_9_0_g251547 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251544 = lerpResult374_g251544;
					float temp_output_328_0_g251544 = ( Blend_VertMask379_g251544 * TVE_IsEnabled );
					half Conform_Mask366_g251544 = temp_output_328_0_g251544;
					float temp_output_322_0_g251544 = ( ( ( ( (Global_FormTexture351_g251544).z - ( (Model_PivotWO353_g251544).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251544 ) );
					float3 appendResult329_g251544 = (float3(0.0 , temp_output_322_0_g251544 , 0.0));
					float3 appendResult387_g251544 = (float3(0.0 , 0.0 , temp_output_322_0_g251544));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251548 = appendResult387_g251544;
					#else
					float3 staticSwitch65_g251548 = appendResult329_g251544;
					#endif
					float3 Blanket_Conform368_g251544 = staticSwitch65_g251548;
					float4 appendResult312_g251544 = (float4(Blanket_Conform368_g251544 , 0.0));
					float4 temp_output_310_0_g251544 = ( Model_TransformData356_g251544 + appendResult312_g251544 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251544 = temp_output_310_0_g251544;
					#else
					float4 staticSwitch364_g251544 = Model_TransformData356_g251544;
					#endif
					half4 Final_TransformData365_g251544 = staticSwitch364_g251544;
					float4 In_TransformData16_g251553 = Final_TransformData365_g251544;
					float4 In_RotationData16_g251553 = Out_RotationData15_g251552;
					float4 In_Interpolator16_g251553 = Out_Interpolator15_g251552;
					BuildVertexData( Data16_g251553 , In_Dummy16_g251553 , In_PositionOS16_g251553 , In_NormalOS16_g251553 , In_TangentOS16_g251553 , In_TransformData16_g251553 , In_RotationData16_g251553 , In_Interpolator16_g251553 );
					TVEVertexData Data15_g251564 =(TVEVertexData)Data16_g251553;
					float Out_Dummy15_g251564 = 0.0;
					float3 Out_PositionOS15_g251564 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251564 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251564 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251564 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251564 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251564 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251564 , Out_Dummy15_g251564 , Out_PositionOS15_g251564 , Out_NormalOS15_g251564 , Out_TangentOS15_g251564 , Out_TransformData15_g251564 , Out_RotationData15_g251564 , Out_Interpolator15_g251564 );
					TVEVertexData Data16_g251565 =(TVEVertexData)Data15_g251564;
					float In_Dummy16_g251565 = 0.0;
					float3 Vertex_PositionOS147_g251555 = Out_PositionOS15_g251564;
					half3 VertexPos40_g251559 = Vertex_PositionOS147_g251555;
					float4 temp_output_1615_33_g251555 = Out_RotationData15_g251564;
					half4 Vertex_RotationData1569_g251555 = temp_output_1615_33_g251555;
					float2 break1582_g251555 = (Vertex_RotationData1569_g251555).xy;
					half Angle44_g251559 = break1582_g251555.y;
					half CosAngle89_g251559 = cos( Angle44_g251559 );
					half SinAngle93_g251559 = sin( Angle44_g251559 );
					float3 appendResult95_g251559 = (float3((VertexPos40_g251559).x , ( ( (VertexPos40_g251559).y * CosAngle89_g251559 ) - ( (VertexPos40_g251559).z * SinAngle93_g251559 ) ) , ( ( (VertexPos40_g251559).y * SinAngle93_g251559 ) + ( (VertexPos40_g251559).z * CosAngle89_g251559 ) )));
					half3 VertexPos40_g251560 = appendResult95_g251559;
					half Angle44_g251560 = -break1582_g251555.x;
					half CosAngle94_g251560 = cos( Angle44_g251560 );
					half SinAngle95_g251560 = sin( Angle44_g251560 );
					float3 appendResult98_g251560 = (float3(( ( (VertexPos40_g251560).x * CosAngle94_g251560 ) - ( (VertexPos40_g251560).y * SinAngle95_g251560 ) ) , ( ( (VertexPos40_g251560).x * SinAngle95_g251560 ) + ( (VertexPos40_g251560).y * CosAngle94_g251560 ) ) , (VertexPos40_g251560).z));
					half3 VertexPos40_g251558 = Vertex_PositionOS147_g251555;
					half Angle44_g251558 = break1582_g251555.y;
					half CosAngle89_g251558 = cos( Angle44_g251558 );
					half SinAngle93_g251558 = sin( Angle44_g251558 );
					float3 appendResult95_g251558 = (float3((VertexPos40_g251558).x , ( ( (VertexPos40_g251558).y * CosAngle89_g251558 ) - ( (VertexPos40_g251558).z * SinAngle93_g251558 ) ) , ( ( (VertexPos40_g251558).y * SinAngle93_g251558 ) + ( (VertexPos40_g251558).z * CosAngle89_g251558 ) )));
					half3 VertexPos40_g251563 = appendResult95_g251558;
					half Angle44_g251563 = break1582_g251555.x;
					half CosAngle91_g251563 = cos( Angle44_g251563 );
					half SinAngle92_g251563 = sin( Angle44_g251563 );
					float3 appendResult93_g251563 = (float3(( ( (VertexPos40_g251563).x * CosAngle91_g251563 ) + ( (VertexPos40_g251563).z * SinAngle92_g251563 ) ) , (VertexPos40_g251563).y , ( ( -(VertexPos40_g251563).x * SinAngle92_g251563 ) + ( (VertexPos40_g251563).z * CosAngle91_g251563 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251561 = appendResult93_g251563;
					#else
					float3 staticSwitch65_g251561 = appendResult98_g251560;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251556 = staticSwitch65_g251561;
					#else
					float3 staticSwitch65_g251556 = Vertex_PositionOS147_g251555;
					#endif
					float3 temp_output_1608_0_g251555 = staticSwitch65_g251556;
					half3 VertexPos40_g251562 = temp_output_1608_0_g251555;
					half Angle44_g251562 = (Vertex_RotationData1569_g251555).z;
					half CosAngle91_g251562 = cos( Angle44_g251562 );
					half SinAngle92_g251562 = sin( Angle44_g251562 );
					float3 appendResult93_g251562 = (float3(( ( (VertexPos40_g251562).x * CosAngle91_g251562 ) + ( (VertexPos40_g251562).z * SinAngle92_g251562 ) ) , (VertexPos40_g251562).y , ( ( -(VertexPos40_g251562).x * SinAngle92_g251562 ) + ( (VertexPos40_g251562).z * CosAngle91_g251562 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251557 = appendResult93_g251562;
					#else
					float3 staticSwitch65_g251557 = temp_output_1608_0_g251555;
					#endif
					float4 temp_output_1615_31_g251555 = Out_TransformData15_g251564;
					half4 Vertex_TransformData1568_g251555 = temp_output_1615_31_g251555;
					half3 Final_PositionOS178_g251555 = ( ( staticSwitch65_g251557 * (Vertex_TransformData1568_g251555).w ) + (Vertex_TransformData1568_g251555).xyz );
					float3 In_PositionOS16_g251565 = Final_PositionOS178_g251555;
					float3 In_NormalOS16_g251565 = Out_NormalOS15_g251564;
					float4 In_TangentOS16_g251565 = Out_TangentOS15_g251564;
					float4 In_TransformData16_g251565 = temp_output_1615_31_g251555;
					float4 In_RotationData16_g251565 = temp_output_1615_33_g251555;
					float4 In_Interpolator16_g251565 = Out_Interpolator15_g251564;
					BuildVertexData( Data16_g251565 , In_Dummy16_g251565 , In_PositionOS16_g251565 , In_NormalOS16_g251565 , In_TangentOS16_g251565 , In_TransformData16_g251565 , In_RotationData16_g251565 , In_Interpolator16_g251565 );
					TVEVertexData Data15_g251568 =(TVEVertexData)Data16_g251565;
					float Out_Dummy15_g251568 = 0.0;
					float3 Out_PositionOS15_g251568 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251568 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251568 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251568 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251568 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251568 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251568 , Out_Dummy15_g251568 , Out_PositionOS15_g251568 , Out_NormalOS15_g251568 , Out_TangentOS15_g251568 , Out_TransformData15_g251568 , Out_RotationData15_g251568 , Out_Interpolator15_g251568 );
					TVEVertexData Data16_g251569 =(TVEVertexData)Data15_g251568;
					float In_Dummy16_g251569 = 0.0;
					TVEModelData Data15_g251567 =(TVEModelData)Data15_g251551;
					float Out_Dummy15_g251567 = 0.0;
					float3 Out_PositionOS15_g251567 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251567 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251567 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251567 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251567 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251567 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251567 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251567 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251567 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251567 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251567 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251567 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251567 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251567 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251567 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251567 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251567 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251567 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251567 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251567 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251567 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251567 , Out_Dummy15_g251567 , Out_PositionOS15_g251567 , Out_PositionWS15_g251567 , Out_PositionWO15_g251567 , Out_PositionRawOS15_g251567 , Out_PivotOS15_g251567 , Out_PivotWS15_g251567 , Out_PivotWO15_g251567 , Out_NormalOS15_g251567 , Out_NormalWS15_g251567 , Out_NormalRawOS15_g251567 , Out_TangentOS15_g251567 , Out_TangentWS15_g251567 , Out_BitangentWS15_g251567 , Out_ViewDirWS15_g251567 , Out_CoordsData15_g251567 , Out_VertexData15_g251567 , Out_MasksData15_g251567 , Out_PhaseData15_g251567 , Out_TransformData15_g251567 , Out_RotationData15_g251567 , Out_Interpolator15_g251567 );
					float3 In_PositionOS16_g251569 = ( Out_PositionOS15_g251568 + Out_PivotOS15_g251567 );
					float3 In_NormalOS16_g251569 = Out_NormalOS15_g251568;
					float4 In_TangentOS16_g251569 = Out_TangentOS15_g251568;
					float4 In_TransformData16_g251569 = Out_TransformData15_g251568;
					float4 In_RotationData16_g251569 = Out_RotationData15_g251568;
					float4 In_Interpolator16_g251569 = Out_Interpolator15_g251568;
					BuildVertexData( Data16_g251569 , In_Dummy16_g251569 , In_PositionOS16_g251569 , In_NormalOS16_g251569 , In_TangentOS16_g251569 , In_TransformData16_g251569 , In_RotationData16_g251569 , In_Interpolator16_g251569 );
					TVEVertexData Data15_g251675 =(TVEVertexData)Data16_g251569;
					float Out_Dummy15_g251675 = 0.0;
					float3 Out_PositionOS15_g251675 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251675 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251675 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251675 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251675 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251675 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251675 , Out_Dummy15_g251675 , Out_PositionOS15_g251675 , Out_NormalOS15_g251675 , Out_TangentOS15_g251675 , Out_TransformData15_g251675 , Out_RotationData15_g251675 , Out_Interpolator15_g251675 );
					
					float3 vertexPos57_g251667 = v.vertex.xyz;
					float4 ase_positionCS57_g251667 = UnityObjectToClipPos( vertexPos57_g251667 );
					o.ase_texcoord4 = ase_positionCS57_g251667;
					o.ase_texcoord5.xyz = vertexToFrag73_g240682;
					o.ase_texcoord6.xyz = vertexToFrag76_g240682;
					TVEVertexData Data1902_g251624 = Data16_g251569;
					float4 Out_Interpolator1902_g251624 = float4( 0,0,0,0 );
					{
					Out_Interpolator1902_g251624 = Data1902_g251624.Interpolator;
					}
					float4 vertexToFrag1901_g251624 = Out_Interpolator1902_g251624;
					o.ase_texcoord8 = vertexToFrag1901_g251624;
					
					o.ase_texcoord7.xy = v.texcoord.xyzw.xy;
					o.ase_texcoord7.zw = v.texcoord2.xyzw.xy;
					o.ase_color = v.ase_color;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord5.w = 0;
					o.ase_texcoord6.w = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251675;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251675;
					v.tangent = Out_TangentOS15_g251675;

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

					float temp_output_2419_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2419_114).xxx;
					
					float3 color130_g251667 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g251667 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_3 = (60.0).xx;
					float2 appendResult128_g251669 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g251668 = ( temp_cast_3 * ( 0.5 + appendResult128_g251669 ) );
					float2 temp_cast_4 = (0.5).xx;
					float2 temp_cast_5 = (1.0).xx;
					float4 appendResult16_g251668 = (float4(ddx( FinalUV13_g251668 ) , ddy( FinalUV13_g251668 )));
					float4 UVDerivatives17_g251668 = appendResult16_g251668;
					float4 break28_g251668 = UVDerivatives17_g251668;
					float2 appendResult19_g251668 = (float2(break28_g251668.x , break28_g251668.z));
					float2 appendResult20_g251668 = (float2(break28_g251668.x , break28_g251668.z));
					float dotResult24_g251668 = dot( appendResult19_g251668 , appendResult20_g251668 );
					float2 appendResult21_g251668 = (float2(break28_g251668.y , break28_g251668.w));
					float2 appendResult22_g251668 = (float2(break28_g251668.y , break28_g251668.w));
					float dotResult23_g251668 = dot( appendResult21_g251668 , appendResult22_g251668 );
					float2 appendResult25_g251668 = (float2(dotResult24_g251668 , dotResult23_g251668));
					float2 derivativesLength29_g251668 = sqrt( appendResult25_g251668 );
					float2 temp_cast_6 = (-1.0).xx;
					float2 temp_cast_7 = (1.0).xx;
					float2 clampResult57_g251668 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g251668 + 0.25 ) ) - temp_cast_4 ) ) * 4.0 ) - temp_cast_5 ) * ( 0.35 / derivativesLength29_g251668 ) ) , temp_cast_6 , temp_cast_7 );
					float2 break71_g251668 = clampResult57_g251668;
					float2 break55_g251668 = derivativesLength29_g251668;
					float4 lerpResult73_g251668 = lerp( float4( color130_g251667 , 0.0 ) , float4( color81_g251667 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g251668.x * break71_g251668.y * sqrt( saturate( ( 1.1 - max( break55_g251668.x, break55_g251668.y ) ) ) ) ) ) ));
					half IsLightingType2402 = _IsLightingType;
					float4 color2395 = IsGammaSpace() ? float4( 0.6196079, 0.7686275, 0.1490196, 0 ) : float4( 0.3419145, 0.5520116, 0.01938236, 0 );
					float3 ifLocalVar40_g251570 = 0;
					if( IsLightingType2402 == 1.0 )
					ifLocalVar40_g251570 = color2395.rgb;
					float4 color2398 = IsGammaSpace() ? float4( 0.3254902, 0.6117647, 0.8117647, 0 ) : float4( 0.08650047, 0.3324516, 0.6239604, 0 );
					float3 ifLocalVar40_g251571 = 0;
					if( IsLightingType2402 == 2.0 )
					ifLocalVar40_g251571 = color2398.rgb;
					float4 color2391 = IsGammaSpace() ? float4( 0.654902, 0.3411765, 0.8509804, 0 ) : float4( 0.3864295, 0.0953075, 0.6938719, 0 );
					float3 ifLocalVar40_g251572 = 0;
					if( IsLightingType2402 == 3.0 )
					ifLocalVar40_g251572 = color2391.rgb;
					float4 color2412 = IsGammaSpace() ? float4( 0.972549, 0.8862745, 0.1803922, 0 ) : float4( 0.9386859, 0.7605246, 0.0273209, 0 );
					float3 ifLocalVar40_g251573 = 0;
					if( IsLightingType2402 == 4.0 )
					ifLocalVar40_g251573 = color2412.rgb;
					half3 Final_Debug2386 = ( ifLocalVar40_g251570 + ifLocalVar40_g251571 + ifLocalVar40_g251572 + ifLocalVar40_g251573 );
					float temp_output_7_0_g251674 = TVE_DEBUG_Min;
					float3 temp_cast_8 = (temp_output_7_0_g251674).xxx;
					float3 temp_output_9_0_g251674 = ( Final_Debug2386 - temp_cast_8 );
					float lerpResult76_g251667 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g251667 = lerpResult76_g251667;
					float3 lerpResult72_g251667 = lerp( (lerpResult73_g251668).rgb , saturate( ( temp_output_9_0_g251674 / ( ( TVE_DEBUG_Max - temp_output_7_0_g251674 ) + 0.0001 ) ) ) , Filter152_g251667);
					float dotResult61_g251667 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g251667 = ( 1.0 - saturate( dotResult61_g251667 ) );
					float Shading_Fresnel59_g251667 = (( 1.0 - ( temp_output_65_0_g251667 * temp_output_65_0_g251667 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g251667 = IN.ase_texcoord4;
					float depthLinearEye57_g251667 = LinearEyeDepth( ase_positionCS57_g251667.z / ase_positionCS57_g251667.w );
					float temp_output_69_0_g251667 = saturate(  (0.0 + ( depthLinearEye57_g251667 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g251667 = (( temp_output_69_0_g251667 * temp_output_69_0_g251667 )*0.5 + 0.5);
					float lerpResult84_g251667 = lerp( 1.0 , Shading_Fresnel59_g251667 , ( Shading_Distance58_g251667 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g251672 = ( 0.0 );
					float localBuildVisualData3_g251630 = ( 0.0 );
					float localBuildVisualData3_g251625 = ( 0.0 );
					TVEVisualData Data3_g251625 =(TVEVisualData)0;
					float temp_output_14_0_g251625 = 0.0;
					float In_Dummy3_g251625 = temp_output_14_0_g251625;
					float3 temp_cast_9 = (0.5).xxx;
					float3 temp_output_4_0_g251625 = temp_cast_9;
					float3 In_Albedo3_g251625 = temp_output_4_0_g251625;
					float3 temp_cast_10 = (0.5).xxx;
					float3 temp_output_44_0_g251625 = temp_cast_10;
					float3 In_AlbedoBase3_g251625 = temp_output_44_0_g251625;
					float2 temp_cast_11 = (0.0).xx;
					float2 In_NormalTS3_g251625 = temp_cast_11;
					float3 temp_cast_12 = (0.5).xxx;
					float3 In_NormalWS3_g251625 = temp_cast_12;
					float4 In_Shader3_g251625 = half4( 0, 1, 0, 1 );
					float4 In_Feature3_g251625 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251625 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251625 = half4( 1, 1, 1, 1 );
					float temp_output_12_0_g251625 = 0.5;
					float In_Grayscale3_g251625 = temp_output_12_0_g251625;
					float temp_output_16_0_g251625 = 1.0;
					float In_Luminosity3_g251625 = temp_output_16_0_g251625;
					float In_MultiMask3_g251625 = 1.0;
					float In_AlphaClip3_g251625 = 1.0;
					float In_AlphaFade3_g251625 = 1.0;
					float3 temp_cast_13 = (1.0).xxx;
					float3 In_Translucency3_g251625 = temp_cast_13;
					float In_Transmission3_g251625 = 1.0;
					float In_Thickness3_g251625 = 0.0;
					float In_Diffusion3_g251625 = 0.0;
					float In_Depth3_g251625 = 0.0;
					BuildVisualData( Data3_g251625 , In_Dummy3_g251625 , In_Albedo3_g251625 , In_AlbedoBase3_g251625 , In_NormalTS3_g251625 , In_NormalWS3_g251625 , In_Shader3_g251625 , In_Feature3_g251625 , In_Season3_g251625 , In_Emissive3_g251625 , In_Grayscale3_g251625 , In_Luminosity3_g251625 , In_MultiMask3_g251625 , In_AlphaClip3_g251625 , In_AlphaFade3_g251625 , In_Translucency3_g251625 , In_Transmission3_g251625 , In_Thickness3_g251625 , In_Diffusion3_g251625 , In_Depth3_g251625 );
					TVEVisualData Data3_g251630 =(TVEVisualData)Data3_g251625;
					half Dummy130_g251628 = ( _MainCategory + _MainEnd );
					float temp_output_14_0_g251630 = Dummy130_g251628;
					float In_Dummy3_g251630 = temp_output_14_0_g251630;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251651) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g251633 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g251633 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g251633 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g251633 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g251633 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g251633 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g251651 = staticSwitch36_g251633;
					float localBreakTextureData456_g251651 = ( 0.0 );
					float localBuildTextureData431_g251650 = ( 0.0 );
					TVEMasksData Data431_g251650 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g251650 = ( 0.0 );
					float4 temp_output_6_0_g251666 = _main_coord_value;
					float4 temp_output_7_0_g251666 = ( _MainSampleMode + _MainCoordMode + _MainCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g251666 = ( temp_output_6_0_g251666 + temp_output_7_0_g251666 );
					#else
					float4 staticSwitch14_g251666 = temp_output_6_0_g251666;
					#endif
					half4 Local_Coords180_g251628 = staticSwitch14_g251666;
					float4 Coords444_g251650 = Local_Coords180_g251628;
					TVEModelData Data16_g240690 =(TVEModelData)0;
					float In_Dummy16_g240690 = 0.0;
					float3 vertexToFrag73_g240682 = IN.ase_texcoord5.xyz;
					float3 PositionWS122_g240682 = vertexToFrag73_g240682;
					float3 In_PositionWS16_g240690 = PositionWS122_g240682;
					float3 vertexToFrag76_g240682 = IN.ase_texcoord6.xyz;
					float3 PivotWS121_g240682 = vertexToFrag76_g240682;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g240682 = ( PositionWS122_g240682 - PivotWS121_g240682 );
					#else
					float3 staticSwitch204_g240682 = PositionWS122_g240682;
					#endif
					float3 PositionWO132_g240682 = ( staticSwitch204_g240682 - TVE_WorldOrigin );
					float3 In_PositionWO16_g240690 = PositionWO132_g240682;
					float3 In_PivotWS16_g240690 = PivotWS121_g240682;
					float3 PivotWO133_g240682 = ( PivotWS121_g240682 - TVE_WorldOrigin );
					float3 In_PivotWO16_g240690 = PivotWO133_g240682;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g240682 = normalizedWorldNormal;
					float3 In_NormalWS16_g240690 = NormalWS95_g240682;
					half3 TangentWS136_g240682 = TangentWS;
					float3 In_TangentWS16_g240690 = TangentWS136_g240682;
					half3 BiangentWS421_g240682 = BitangentWS;
					float3 In_BitangentWS16_g240690 = BiangentWS421_g240682;
					half3 NormalWS427_g240682 = NormalWS95_g240682;
					half3 localComputeTriplanarMasks427_g240682 = ComputeTriplanarMasks( NormalWS427_g240682 );
					half3 TriplanarWeights429_g240682 = localComputeTriplanarMasks427_g240682;
					float3 In_TriplanarWeights16_g240690 = TriplanarWeights429_g240682;
					float3 normalizeResult296_g240682 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g240682 ) );
					half3 ViewDirWS169_g240682 = normalizeResult296_g240682;
					float3 In_ViewDirWS16_g240690 = ViewDirWS169_g240682;
					float4 appendResult397_g240682 = (float4(IN.ase_texcoord7.xy , IN.ase_texcoord7.zw));
					float4 CoordsData398_g240682 = appendResult397_g240682;
					float4 In_CoordsData16_g240690 = CoordsData398_g240682;
					half4 VertexMasks171_g240682 = IN.ase_color;
					float4 In_VertexData16_g240690 = VertexMasks171_g240682;
					float temp_output_17_0_g240693 = _ObjectPhaseMode;
					float Option70_g240693 = temp_output_17_0_g240693;
					float4 temp_output_3_0_g240693 = IN.ase_color;
					float4 Channel70_g240693 = temp_output_3_0_g240693;
					float localSwitchChannel470_g240693 = SwitchChannel4( Option70_g240693 , Channel70_g240693 );
					half Phase_Value372_g240682 = localSwitchChannel470_g240693;
					float3 break319_g240682 = PivotWO133_g240682;
					half Pivot_Position322_g240682 = ( break319_g240682.x + break319_g240682.z );
					half Phase_Position357_g240682 = ( Phase_Value372_g240682 + Pivot_Position322_g240682 );
					float temp_output_248_0_g240682 = frac( Phase_Position357_g240682 );
					float4 appendResult177_g240682 = (float4((frac( ( Phase_Position357_g240682 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g240682));
					half4 Phase_Data176_g240682 = appendResult177_g240682;
					float4 In_Interpolator16_g240690 = Phase_Data176_g240682;
					BuildModelFragData( Data16_g240690 , In_Dummy16_g240690 , In_PositionWS16_g240690 , In_PositionWO16_g240690 , In_PivotWS16_g240690 , In_PivotWO16_g240690 , In_NormalWS16_g240690 , In_TangentWS16_g240690 , In_BitangentWS16_g240690 , In_TriplanarWeights16_g240690 , In_ViewDirWS16_g240690 , In_CoordsData16_g240690 , In_VertexData16_g240690 , In_Interpolator16_g240690 );
					TVEModelData Data15_g251626 =(TVEModelData)Data16_g240690;
					float Out_Dummy15_g251626 = 0.0;
					float3 Out_PositionWS15_g251626 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251626 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251626 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251626 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251626 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251626 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251626 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251626 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251626 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251626 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251626 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251626 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251626 , Out_Dummy15_g251626 , Out_PositionWS15_g251626 , Out_PositionWO15_g251626 , Out_PivotWS15_g251626 , Out_PivotWO15_g251626 , Out_NormalWS15_g251626 , Out_TangentWS15_g251626 , Out_BitangentWS15_g251626 , Out_TriplanarWeights15_g251626 , Out_ViewDirWS15_g251626 , Out_CoordsData15_g251626 , Out_VertexData15_g251626 , Out_Interpolator15_g251626 );
					TVEModelData Data16_g251627 =(TVEModelData)Data15_g251626;
					float In_Dummy16_g251627 = Out_Dummy15_g251626;
					float3 In_PositionWS16_g251627 = Out_PositionWS15_g251626;
					float3 In_PositionWO16_g251627 = Out_PositionWO15_g251626;
					float3 In_PivotWS16_g251627 = Out_PivotWS15_g251626;
					float3 In_PivotWO16_g251627 = Out_PivotWO15_g251626;
					float3 In_NormalWS16_g251627 = Out_NormalWS15_g251626;
					float3 In_TangentWS16_g251627 = Out_TangentWS15_g251626;
					float3 In_BitangentWS16_g251627 = Out_BitangentWS15_g251626;
					float3 In_TriplanarWeights16_g251627 = Out_TriplanarWeights15_g251626;
					float3 In_ViewDirWS16_g251627 = Out_ViewDirWS15_g251626;
					float4 In_CoordsData16_g251627 = Out_CoordsData15_g251626;
					float4 In_VertexData16_g251627 = Out_VertexData15_g251626;
					float4 vertexToFrag1901_g251624 = IN.ase_texcoord8;
					float4 In_Interpolator16_g251627 = vertexToFrag1901_g251624;
					BuildModelFragData( Data16_g251627 , In_Dummy16_g251627 , In_PositionWS16_g251627 , In_PositionWO16_g251627 , In_PivotWS16_g251627 , In_PivotWO16_g251627 , In_NormalWS16_g251627 , In_TangentWS16_g251627 , In_BitangentWS16_g251627 , In_TriplanarWeights16_g251627 , In_ViewDirWS16_g251627 , In_CoordsData16_g251627 , In_VertexData16_g251627 , In_Interpolator16_g251627 );
					TVEModelData Data15_g251629 =(TVEModelData)Data16_g251627;
					float Out_Dummy15_g251629 = 0.0;
					float3 Out_PositionWS15_g251629 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251629 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251629 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251629 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251629 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251629 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251629 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251629 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251629 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251629 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251629 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251629 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251629 , Out_Dummy15_g251629 , Out_PositionWS15_g251629 , Out_PositionWO15_g251629 , Out_PivotWS15_g251629 , Out_PivotWO15_g251629 , Out_NormalWS15_g251629 , Out_TangentWS15_g251629 , Out_BitangentWS15_g251629 , Out_TriplanarWeights15_g251629 , Out_ViewDirWS15_g251629 , Out_CoordsData15_g251629 , Out_VertexData15_g251629 , Out_Interpolator15_g251629 );
					float4 Model_CoordsData324_g251628 = Out_CoordsData15_g251629;
					float4 MeshCoords444_g251650 = Model_CoordsData324_g251628;
					float2 UV0444_g251650 = float2( 0,0 );
					float2 UV3444_g251650 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g251650 , MeshCoords444_g251650 , UV0444_g251650 , UV3444_g251650 );
					float4 appendResult430_g251650 = (float4(UV0444_g251650 , UV3444_g251650));
					float4 In_MaskA431_g251650 = appendResult430_g251650;
					float localComputeWorldCoords315_g251650 = ( 0.0 );
					float4 Coords315_g251650 = Local_Coords180_g251628;
					float3 Model_PositionWO222_g251628 = Out_PositionWO15_g251629;
					float3 PositionWS315_g251650 = Model_PositionWO222_g251628;
					float2 ZY315_g251650 = float2( 0,0 );
					float2 XZ315_g251650 = float2( 0,0 );
					float2 XY315_g251650 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g251650 , PositionWS315_g251650 , ZY315_g251650 , XZ315_g251650 , XY315_g251650 );
					float2 ZY402_g251650 = ZY315_g251650;
					float2 XZ403_g251650 = XZ315_g251650;
					float4 appendResult432_g251650 = (float4(ZY402_g251650 , XZ403_g251650));
					float4 In_MaskB431_g251650 = appendResult432_g251650;
					float2 XY404_g251650 = XY315_g251650;
					float localComputeStochasticCoords409_g251650 = ( 0.0 );
					float2 UV409_g251650 = ZY402_g251650;
					float2 UV1409_g251650 = float2( 0,0 );
					float2 UV2409_g251650 = float2( 0,0 );
					float2 UV3409_g251650 = float2( 0,0 );
					float3 Weights409_g251650 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g251650 , UV1409_g251650 , UV2409_g251650 , UV3409_g251650 , Weights409_g251650 );
					float4 appendResult433_g251650 = (float4(XY404_g251650 , UV1409_g251650));
					float4 In_MaskC431_g251650 = appendResult433_g251650;
					float4 appendResult434_g251650 = (float4(UV2409_g251650 , UV3409_g251650));
					float4 In_MaskD431_g251650 = appendResult434_g251650;
					float localComputeStochasticCoords422_g251650 = ( 0.0 );
					float2 UV422_g251650 = XZ403_g251650;
					float2 UV1422_g251650 = float2( 0,0 );
					float2 UV2422_g251650 = float2( 0,0 );
					float2 UV3422_g251650 = float2( 0,0 );
					float3 Weights422_g251650 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g251650 , UV1422_g251650 , UV2422_g251650 , UV3422_g251650 , Weights422_g251650 );
					float4 appendResult435_g251650 = (float4(UV1422_g251650 , UV2422_g251650));
					float4 In_MaskE431_g251650 = appendResult435_g251650;
					float localComputeStochasticCoords423_g251650 = ( 0.0 );
					float2 UV423_g251650 = XY404_g251650;
					float2 UV1423_g251650 = float2( 0,0 );
					float2 UV2423_g251650 = float2( 0,0 );
					float2 UV3423_g251650 = float2( 0,0 );
					float3 Weights423_g251650 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g251650 , UV1423_g251650 , UV2423_g251650 , UV3423_g251650 , Weights423_g251650 );
					float4 appendResult436_g251650 = (float4(UV3422_g251650 , UV1423_g251650));
					float4 In_MaskF431_g251650 = appendResult436_g251650;
					float4 appendResult437_g251650 = (float4(UV2423_g251650 , UV3423_g251650));
					float4 In_MaskG431_g251650 = appendResult437_g251650;
					float4 In_MaskH431_g251650 = float4( Weights409_g251650 , 0.0 );
					float4 In_MaskI431_g251650 = float4( Weights422_g251650 , 0.0 );
					float4 In_MaskJ431_g251650 = float4( Weights423_g251650 , 0.0 );
					half3 Model_NormalWS226_g251628 = Out_NormalWS15_g251629;
					float3 temp_output_449_0_g251650 = Model_NormalWS226_g251628;
					float4 In_MaskK431_g251650 = float4( temp_output_449_0_g251650 , 0.0 );
					half3 Model_TangentWS366_g251628 = Out_TangentWS15_g251629;
					float3 temp_output_450_0_g251650 = Model_TangentWS366_g251628;
					float4 In_MaskL431_g251650 = float4( temp_output_450_0_g251650 , 0.0 );
					half3 Model_BitangentWS367_g251628 = Out_BitangentWS15_g251629;
					float3 temp_output_451_0_g251650 = Model_BitangentWS367_g251628;
					float4 In_MaskM431_g251650 = float4( temp_output_451_0_g251650 , 0.0 );
					half3 Model_TriplanarWeights368_g251628 = Out_TriplanarWeights15_g251629;
					float3 temp_output_445_0_g251650 = Model_TriplanarWeights368_g251628;
					float4 In_MaskN431_g251650 = float4( temp_output_445_0_g251650 , 0.0 );
					BuildTextureData( Data431_g251650 , In_MaskA431_g251650 , In_MaskB431_g251650 , In_MaskC431_g251650 , In_MaskD431_g251650 , In_MaskE431_g251650 , In_MaskF431_g251650 , In_MaskG431_g251650 , In_MaskH431_g251650 , In_MaskI431_g251650 , In_MaskJ431_g251650 , In_MaskK431_g251650 , In_MaskL431_g251650 , In_MaskM431_g251650 , In_MaskN431_g251650 );
					TVEMasksData Data456_g251651 =(TVEMasksData)Data431_g251650;
					float4 Out_MaskA456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251651 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251651 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251651 , Out_MaskA456_g251651 , Out_MaskB456_g251651 , Out_MaskC456_g251651 , Out_MaskD456_g251651 , Out_MaskE456_g251651 , Out_MaskF456_g251651 , Out_MaskG456_g251651 , Out_MaskH456_g251651 , Out_MaskI456_g251651 , Out_MaskJ456_g251651 , Out_MaskK456_g251651 , Out_MaskL456_g251651 , Out_MaskM456_g251651 , Out_MaskN456_g251651 );
					half2 UV276_g251651 = (Out_MaskA456_g251651).xy;
					float temp_output_504_0_g251651 = 0.0;
					half Bias276_g251651 = temp_output_504_0_g251651;
					half2 Normal276_g251651 = float2( 0,0 );
					half4 localSampleCoord276_g251651 = SampleCoord( Texture276_g251651 , Sampler276_g251651 , UV276_g251651 , Bias276_g251651 , Normal276_g251651 );
					float4 temp_output_407_277_g251628 = localSampleCoord276_g251651;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251651) = _MainAlbedoTex;
					SamplerState Sampler502_g251651 = staticSwitch36_g251633;
					half2 UV502_g251651 = (Out_MaskA456_g251651).zw;
					half Bias502_g251651 = temp_output_504_0_g251651;
					half2 Normal502_g251651 = float2( 0,0 );
					half4 localSampleCoord502_g251651 = SampleCoord( Texture502_g251651 , Sampler502_g251651 , UV502_g251651 , Bias502_g251651 , Normal502_g251651 );
					float4 temp_output_407_278_g251628 = localSampleCoord502_g251651;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251651) = _MainAlbedoTex;
					SamplerState Sampler496_g251651 = staticSwitch36_g251633;
					float2 temp_output_463_0_g251651 = (Out_MaskB456_g251651).zw;
					half2 XZ496_g251651 = temp_output_463_0_g251651;
					half Bias496_g251651 = temp_output_504_0_g251651;
					half3 NormalWS512_g251651 = (Out_MaskK456_g251651).xyz;
					half3 NormalWS496_g251651 = NormalWS512_g251651;
					half3 Normal496_g251651 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251651 = SamplePlanar2D( Texture496_g251651 , Sampler496_g251651 , XZ496_g251651 , Bias496_g251651 , NormalWS496_g251651 , Normal496_g251651 );
					float4 temp_output_407_0_g251628 = localSamplePlanar2D496_g251651;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251651) = _MainAlbedoTex;
					SamplerState Sampler490_g251651 = staticSwitch36_g251633;
					float2 temp_output_462_0_g251651 = (Out_MaskB456_g251651).xy;
					half2 ZY490_g251651 = temp_output_462_0_g251651;
					half2 XZ490_g251651 = temp_output_463_0_g251651;
					float2 temp_output_464_0_g251651 = (Out_MaskC456_g251651).xy;
					half2 XY490_g251651 = temp_output_464_0_g251651;
					half Bias490_g251651 = temp_output_504_0_g251651;
					half3 Triplanar522_g251651 = (Out_MaskN456_g251651).xyz;
					half3 Triplanar490_g251651 = Triplanar522_g251651;
					half3 NormalWS490_g251651 = NormalWS512_g251651;
					half3 Normal490_g251651 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251651 = SamplePlanar3D( Texture490_g251651 , Sampler490_g251651 , ZY490_g251651 , XZ490_g251651 , XY490_g251651 , Bias490_g251651 , Triplanar490_g251651 , NormalWS490_g251651 , Normal490_g251651 );
					float4 temp_output_407_201_g251628 = localSamplePlanar3D490_g251651;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251651) = _MainAlbedoTex;
					SamplerState Sampler498_g251651 = staticSwitch36_g251633;
					half2 XZ498_g251651 = temp_output_463_0_g251651;
					float2 temp_output_473_0_g251651 = (Out_MaskE456_g251651).xy;
					half2 XZ_1498_g251651 = temp_output_473_0_g251651;
					float2 temp_output_474_0_g251651 = (Out_MaskE456_g251651).zw;
					half2 XZ_2498_g251651 = temp_output_474_0_g251651;
					float2 temp_output_475_0_g251651 = (Out_MaskF456_g251651).xy;
					half2 XZ_3498_g251651 = temp_output_475_0_g251651;
					float temp_output_510_0_g251651 = exp2( temp_output_504_0_g251651 );
					half Bias498_g251651 = temp_output_510_0_g251651;
					float3 temp_output_480_0_g251651 = (Out_MaskI456_g251651).xyz;
					half3 Weights_2498_g251651 = temp_output_480_0_g251651;
					half3 NormalWS498_g251651 = NormalWS512_g251651;
					half3 Normal498_g251651 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251651 = SampleStochastic2D( Texture498_g251651 , Sampler498_g251651 , XZ498_g251651 , XZ_1498_g251651 , XZ_2498_g251651 , XZ_3498_g251651 , Bias498_g251651 , Weights_2498_g251651 , NormalWS498_g251651 , Normal498_g251651 );
					float4 temp_output_407_202_g251628 = localSampleStochastic2D498_g251651;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251651) = _MainAlbedoTex;
					SamplerState Sampler500_g251651 = staticSwitch36_g251633;
					half2 ZY500_g251651 = temp_output_462_0_g251651;
					half2 ZY_1500_g251651 = (Out_MaskC456_g251651).zw;
					half2 ZY_2500_g251651 = (Out_MaskD456_g251651).xy;
					half2 ZY_3500_g251651 = (Out_MaskD456_g251651).zw;
					half2 XZ500_g251651 = temp_output_463_0_g251651;
					half2 XZ_1500_g251651 = temp_output_473_0_g251651;
					half2 XZ_2500_g251651 = temp_output_474_0_g251651;
					half2 XZ_3500_g251651 = temp_output_475_0_g251651;
					half2 XY500_g251651 = temp_output_464_0_g251651;
					half2 XY_1500_g251651 = (Out_MaskF456_g251651).zw;
					half2 XY_2500_g251651 = (Out_MaskG456_g251651).xy;
					half2 XY_3500_g251651 = (Out_MaskG456_g251651).zw;
					half Bias500_g251651 = temp_output_510_0_g251651;
					half3 Weights_1500_g251651 = (Out_MaskH456_g251651).xyz;
					half3 Weights_2500_g251651 = temp_output_480_0_g251651;
					half3 Weights_3500_g251651 = (Out_MaskJ456_g251651).xyz;
					half3 Triplanar500_g251651 = Triplanar522_g251651;
					half3 NormalWS500_g251651 = NormalWS512_g251651;
					half3 Normal500_g251651 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251651 = SampleStochastic3D( Texture500_g251651 , Sampler500_g251651 , ZY500_g251651 , ZY_1500_g251651 , ZY_2500_g251651 , ZY_3500_g251651 , XZ500_g251651 , XZ_1500_g251651 , XZ_2500_g251651 , XZ_3500_g251651 , XY500_g251651 , XY_1500_g251651 , XY_2500_g251651 , XY_3500_g251651 , Bias500_g251651 , Weights_1500_g251651 , Weights_2500_g251651 , Weights_3500_g251651 , Triplanar500_g251651 , NormalWS500_g251651 , Normal500_g251651 );
					float4 temp_output_407_203_g251628 = localSampleStochastic3D500_g251651;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g251628 = temp_output_407_277_g251628;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g251628 = temp_output_407_278_g251628;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g251628 = temp_output_407_0_g251628;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g251628 = temp_output_407_201_g251628;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g251628 = temp_output_407_202_g251628;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g251628 = temp_output_407_203_g251628;
					#else
					float4 staticSwitch184_g251628 = temp_output_407_277_g251628;
					#endif
					half4 Local_AlbedoSample185_g251628 = staticSwitch184_g251628;
					float3 lerpResult53_g251628 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g251628).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g251628 = lerpResult53_g251628;
					float temp_output_17_0_g251648 = _MainMultiWriteMode;
					float Option91_g251648 = temp_output_17_0_g251648;
					float4 Model_VertexData418_g251628 = Out_VertexData15_g251629;
					float4 temp_output_84_0_g251648 = Model_VertexData418_g251628;
					float4 ChannelA91_g251648 = temp_output_84_0_g251648;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251636) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g251635 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g251635 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g251635 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g251635 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g251635 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g251635 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251636 = staticSwitch38_g251635;
					float localBreakTextureData456_g251636 = ( 0.0 );
					TVEMasksData Data456_g251636 =(TVEMasksData)Data431_g251650;
					float4 Out_MaskA456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251636 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251636 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251636 , Out_MaskA456_g251636 , Out_MaskB456_g251636 , Out_MaskC456_g251636 , Out_MaskD456_g251636 , Out_MaskE456_g251636 , Out_MaskF456_g251636 , Out_MaskG456_g251636 , Out_MaskH456_g251636 , Out_MaskI456_g251636 , Out_MaskJ456_g251636 , Out_MaskK456_g251636 , Out_MaskL456_g251636 , Out_MaskM456_g251636 , Out_MaskN456_g251636 );
					half2 UV276_g251636 = (Out_MaskA456_g251636).xy;
					float temp_output_504_0_g251636 = 0.0;
					half Bias276_g251636 = temp_output_504_0_g251636;
					half2 Normal276_g251636 = float2( 0,0 );
					half4 localSampleCoord276_g251636 = SampleCoord( Texture276_g251636 , Sampler276_g251636 , UV276_g251636 , Bias276_g251636 , Normal276_g251636 );
					float4 temp_output_405_277_g251628 = localSampleCoord276_g251636;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251636) = _MainShaderTex;
					SamplerState Sampler502_g251636 = staticSwitch38_g251635;
					half2 UV502_g251636 = (Out_MaskA456_g251636).zw;
					half Bias502_g251636 = temp_output_504_0_g251636;
					half2 Normal502_g251636 = float2( 0,0 );
					half4 localSampleCoord502_g251636 = SampleCoord( Texture502_g251636 , Sampler502_g251636 , UV502_g251636 , Bias502_g251636 , Normal502_g251636 );
					float4 temp_output_405_278_g251628 = localSampleCoord502_g251636;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251636) = _MainShaderTex;
					SamplerState Sampler496_g251636 = staticSwitch38_g251635;
					float2 temp_output_463_0_g251636 = (Out_MaskB456_g251636).zw;
					half2 XZ496_g251636 = temp_output_463_0_g251636;
					half Bias496_g251636 = temp_output_504_0_g251636;
					half3 NormalWS512_g251636 = (Out_MaskK456_g251636).xyz;
					half3 NormalWS496_g251636 = NormalWS512_g251636;
					half3 Normal496_g251636 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251636 = SamplePlanar2D( Texture496_g251636 , Sampler496_g251636 , XZ496_g251636 , Bias496_g251636 , NormalWS496_g251636 , Normal496_g251636 );
					float4 temp_output_405_0_g251628 = localSamplePlanar2D496_g251636;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251636) = _MainShaderTex;
					SamplerState Sampler490_g251636 = staticSwitch38_g251635;
					float2 temp_output_462_0_g251636 = (Out_MaskB456_g251636).xy;
					half2 ZY490_g251636 = temp_output_462_0_g251636;
					half2 XZ490_g251636 = temp_output_463_0_g251636;
					float2 temp_output_464_0_g251636 = (Out_MaskC456_g251636).xy;
					half2 XY490_g251636 = temp_output_464_0_g251636;
					half Bias490_g251636 = temp_output_504_0_g251636;
					half3 Triplanar522_g251636 = (Out_MaskN456_g251636).xyz;
					half3 Triplanar490_g251636 = Triplanar522_g251636;
					half3 NormalWS490_g251636 = NormalWS512_g251636;
					half3 Normal490_g251636 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251636 = SamplePlanar3D( Texture490_g251636 , Sampler490_g251636 , ZY490_g251636 , XZ490_g251636 , XY490_g251636 , Bias490_g251636 , Triplanar490_g251636 , NormalWS490_g251636 , Normal490_g251636 );
					float4 temp_output_405_201_g251628 = localSamplePlanar3D490_g251636;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251636) = _MainShaderTex;
					SamplerState Sampler498_g251636 = staticSwitch38_g251635;
					half2 XZ498_g251636 = temp_output_463_0_g251636;
					float2 temp_output_473_0_g251636 = (Out_MaskE456_g251636).xy;
					half2 XZ_1498_g251636 = temp_output_473_0_g251636;
					float2 temp_output_474_0_g251636 = (Out_MaskE456_g251636).zw;
					half2 XZ_2498_g251636 = temp_output_474_0_g251636;
					float2 temp_output_475_0_g251636 = (Out_MaskF456_g251636).xy;
					half2 XZ_3498_g251636 = temp_output_475_0_g251636;
					float temp_output_510_0_g251636 = exp2( temp_output_504_0_g251636 );
					half Bias498_g251636 = temp_output_510_0_g251636;
					float3 temp_output_480_0_g251636 = (Out_MaskI456_g251636).xyz;
					half3 Weights_2498_g251636 = temp_output_480_0_g251636;
					half3 NormalWS498_g251636 = NormalWS512_g251636;
					half3 Normal498_g251636 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251636 = SampleStochastic2D( Texture498_g251636 , Sampler498_g251636 , XZ498_g251636 , XZ_1498_g251636 , XZ_2498_g251636 , XZ_3498_g251636 , Bias498_g251636 , Weights_2498_g251636 , NormalWS498_g251636 , Normal498_g251636 );
					float4 temp_output_405_202_g251628 = localSampleStochastic2D498_g251636;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251636) = _MainShaderTex;
					SamplerState Sampler500_g251636 = staticSwitch38_g251635;
					half2 ZY500_g251636 = temp_output_462_0_g251636;
					half2 ZY_1500_g251636 = (Out_MaskC456_g251636).zw;
					half2 ZY_2500_g251636 = (Out_MaskD456_g251636).xy;
					half2 ZY_3500_g251636 = (Out_MaskD456_g251636).zw;
					half2 XZ500_g251636 = temp_output_463_0_g251636;
					half2 XZ_1500_g251636 = temp_output_473_0_g251636;
					half2 XZ_2500_g251636 = temp_output_474_0_g251636;
					half2 XZ_3500_g251636 = temp_output_475_0_g251636;
					half2 XY500_g251636 = temp_output_464_0_g251636;
					half2 XY_1500_g251636 = (Out_MaskF456_g251636).zw;
					half2 XY_2500_g251636 = (Out_MaskG456_g251636).xy;
					half2 XY_3500_g251636 = (Out_MaskG456_g251636).zw;
					half Bias500_g251636 = temp_output_510_0_g251636;
					half3 Weights_1500_g251636 = (Out_MaskH456_g251636).xyz;
					half3 Weights_2500_g251636 = temp_output_480_0_g251636;
					half3 Weights_3500_g251636 = (Out_MaskJ456_g251636).xyz;
					half3 Triplanar500_g251636 = Triplanar522_g251636;
					half3 NormalWS500_g251636 = NormalWS512_g251636;
					half3 Normal500_g251636 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251636 = SampleStochastic3D( Texture500_g251636 , Sampler500_g251636 , ZY500_g251636 , ZY_1500_g251636 , ZY_2500_g251636 , ZY_3500_g251636 , XZ500_g251636 , XZ_1500_g251636 , XZ_2500_g251636 , XZ_3500_g251636 , XY500_g251636 , XY_1500_g251636 , XY_2500_g251636 , XY_3500_g251636 , Bias500_g251636 , Weights_1500_g251636 , Weights_2500_g251636 , Weights_3500_g251636 , Triplanar500_g251636 , NormalWS500_g251636 , Normal500_g251636 );
					float4 temp_output_405_203_g251628 = localSampleStochastic3D500_g251636;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g251628 = temp_output_405_277_g251628;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g251628 = temp_output_405_278_g251628;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g251628 = temp_output_405_0_g251628;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g251628 = temp_output_405_201_g251628;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g251628 = temp_output_405_202_g251628;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g251628 = temp_output_405_203_g251628;
					#else
					float4 staticSwitch198_g251628 = temp_output_405_277_g251628;
					#endif
					half4 Local_ShaderSample199_g251628 = staticSwitch198_g251628;
					float2 appendResult428_g251628 = (float2((Local_AlbedoSample185_g251628).w , (Local_ShaderSample199_g251628).z));
					float2 temp_output_85_0_g251648 = appendResult428_g251628;
					float4 ChannelB91_g251648 = float4( temp_output_85_0_g251648, 0.0 , 0.0 );
					float localSwitchChannel691_g251648 = SwitchChannel6( Option91_g251648 , ChannelA91_g251648 , ChannelB91_g251648 );
					float clampResult17_g251646 = clamp( localSwitchChannel691_g251648 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251647 = _MainMultiWriteRemap.x;
					float temp_output_9_0_g251647 = ( clampResult17_g251646 - temp_output_7_0_g251647 );
					half Local_MultiMask78_g251628 = saturate( ( temp_output_9_0_g251647 * _MainMultiWriteRemap.z ) );
					float lerpResult58_g251628 = lerp( 1.0 , Local_MultiMask78_g251628 , _MainColorMode);
					float4 lerpResult62_g251628 = lerp( _MainColorTwo , _MainColor , lerpResult58_g251628);
					half3 Local_ColorRGB93_g251628 = (lerpResult62_g251628).rgb;
					half3 Local_Albedo139_g251628 = ( Local_AlbedoRGB107_g251628 * Local_ColorRGB93_g251628 );
					float3 temp_output_4_0_g251630 = Local_Albedo139_g251628;
					float3 In_Albedo3_g251630 = temp_output_4_0_g251630;
					float3 temp_output_44_0_g251630 = Local_Albedo139_g251628;
					float3 In_AlbedoBase3_g251630 = temp_output_44_0_g251630;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251657) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g251634 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g251634 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g251634 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g251634 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g251634 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g251634 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251657 = staticSwitch37_g251634;
					float localBreakTextureData456_g251657 = ( 0.0 );
					TVEMasksData Data456_g251657 =(TVEMasksData)Data431_g251650;
					float4 Out_MaskA456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251657 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251657 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251657 , Out_MaskA456_g251657 , Out_MaskB456_g251657 , Out_MaskC456_g251657 , Out_MaskD456_g251657 , Out_MaskE456_g251657 , Out_MaskF456_g251657 , Out_MaskG456_g251657 , Out_MaskH456_g251657 , Out_MaskI456_g251657 , Out_MaskJ456_g251657 , Out_MaskK456_g251657 , Out_MaskL456_g251657 , Out_MaskM456_g251657 , Out_MaskN456_g251657 );
					half2 UV276_g251657 = (Out_MaskA456_g251657).xy;
					float temp_output_504_0_g251657 = 0.0;
					half Bias276_g251657 = temp_output_504_0_g251657;
					half2 Normal276_g251657 = float2( 0,0 );
					half4 localSampleCoord276_g251657 = SampleCoord( Texture276_g251657 , Sampler276_g251657 , UV276_g251657 , Bias276_g251657 , Normal276_g251657 );
					float2 temp_output_406_394_g251628 = Normal276_g251657;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251657) = _MainNormalTex;
					SamplerState Sampler502_g251657 = staticSwitch37_g251634;
					half2 UV502_g251657 = (Out_MaskA456_g251657).zw;
					half Bias502_g251657 = temp_output_504_0_g251657;
					half2 Normal502_g251657 = float2( 0,0 );
					half4 localSampleCoord502_g251657 = SampleCoord( Texture502_g251657 , Sampler502_g251657 , UV502_g251657 , Bias502_g251657 , Normal502_g251657 );
					float2 temp_output_406_397_g251628 = Normal502_g251657;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251657) = _MainNormalTex;
					SamplerState Sampler496_g251657 = staticSwitch37_g251634;
					float2 temp_output_463_0_g251657 = (Out_MaskB456_g251657).zw;
					half2 XZ496_g251657 = temp_output_463_0_g251657;
					half Bias496_g251657 = temp_output_504_0_g251657;
					half3 NormalWS512_g251657 = (Out_MaskK456_g251657).xyz;
					half3 NormalWS496_g251657 = NormalWS512_g251657;
					half3 Normal496_g251657 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251657 = SamplePlanar2D( Texture496_g251657 , Sampler496_g251657 , XZ496_g251657 , Bias496_g251657 , NormalWS496_g251657 , Normal496_g251657 );
					float3 temp_output_35_0_g251660 = Normal496_g251657;
					half3 TangentWS519_g251657 = (Out_MaskL456_g251657).xyz;
					float dotResult84_g251660 = dot( temp_output_35_0_g251660 , TangentWS519_g251657 );
					half3 BitangentWS521_g251657 = (Out_MaskM456_g251657).xyz;
					float dotResult85_g251660 = dot( temp_output_35_0_g251660 , BitangentWS521_g251657 );
					float2 appendResult87_g251660 = (float2(dotResult84_g251660 , dotResult85_g251660));
					float2 temp_output_406_375_g251628 = appendResult87_g251660;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251657) = _MainNormalTex;
					SamplerState Sampler490_g251657 = staticSwitch37_g251634;
					float2 temp_output_462_0_g251657 = (Out_MaskB456_g251657).xy;
					half2 ZY490_g251657 = temp_output_462_0_g251657;
					half2 XZ490_g251657 = temp_output_463_0_g251657;
					float2 temp_output_464_0_g251657 = (Out_MaskC456_g251657).xy;
					half2 XY490_g251657 = temp_output_464_0_g251657;
					half Bias490_g251657 = temp_output_504_0_g251657;
					half3 Triplanar522_g251657 = (Out_MaskN456_g251657).xyz;
					half3 Triplanar490_g251657 = Triplanar522_g251657;
					half3 NormalWS490_g251657 = NormalWS512_g251657;
					half3 Normal490_g251657 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251657 = SamplePlanar3D( Texture490_g251657 , Sampler490_g251657 , ZY490_g251657 , XZ490_g251657 , XY490_g251657 , Bias490_g251657 , Triplanar490_g251657 , NormalWS490_g251657 , Normal490_g251657 );
					float3 temp_output_35_0_g251661 = Normal490_g251657;
					float dotResult84_g251661 = dot( temp_output_35_0_g251661 , TangentWS519_g251657 );
					float dotResult85_g251661 = dot( temp_output_35_0_g251661 , BitangentWS521_g251657 );
					float2 appendResult87_g251661 = (float2(dotResult84_g251661 , dotResult85_g251661));
					float2 temp_output_406_353_g251628 = appendResult87_g251661;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251657) = _MainNormalTex;
					SamplerState Sampler498_g251657 = staticSwitch37_g251634;
					half2 XZ498_g251657 = temp_output_463_0_g251657;
					float2 temp_output_473_0_g251657 = (Out_MaskE456_g251657).xy;
					half2 XZ_1498_g251657 = temp_output_473_0_g251657;
					float2 temp_output_474_0_g251657 = (Out_MaskE456_g251657).zw;
					half2 XZ_2498_g251657 = temp_output_474_0_g251657;
					float2 temp_output_475_0_g251657 = (Out_MaskF456_g251657).xy;
					half2 XZ_3498_g251657 = temp_output_475_0_g251657;
					float temp_output_510_0_g251657 = exp2( temp_output_504_0_g251657 );
					half Bias498_g251657 = temp_output_510_0_g251657;
					float3 temp_output_480_0_g251657 = (Out_MaskI456_g251657).xyz;
					half3 Weights_2498_g251657 = temp_output_480_0_g251657;
					half3 NormalWS498_g251657 = NormalWS512_g251657;
					half3 Normal498_g251657 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251657 = SampleStochastic2D( Texture498_g251657 , Sampler498_g251657 , XZ498_g251657 , XZ_1498_g251657 , XZ_2498_g251657 , XZ_3498_g251657 , Bias498_g251657 , Weights_2498_g251657 , NormalWS498_g251657 , Normal498_g251657 );
					float3 temp_output_35_0_g251662 = Normal498_g251657;
					float dotResult84_g251662 = dot( temp_output_35_0_g251662 , TangentWS519_g251657 );
					float dotResult85_g251662 = dot( temp_output_35_0_g251662 , BitangentWS521_g251657 );
					float2 appendResult87_g251662 = (float2(dotResult84_g251662 , dotResult85_g251662));
					float2 temp_output_406_391_g251628 = appendResult87_g251662;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251657) = _MainNormalTex;
					SamplerState Sampler500_g251657 = staticSwitch37_g251634;
					half2 ZY500_g251657 = temp_output_462_0_g251657;
					half2 ZY_1500_g251657 = (Out_MaskC456_g251657).zw;
					half2 ZY_2500_g251657 = (Out_MaskD456_g251657).xy;
					half2 ZY_3500_g251657 = (Out_MaskD456_g251657).zw;
					half2 XZ500_g251657 = temp_output_463_0_g251657;
					half2 XZ_1500_g251657 = temp_output_473_0_g251657;
					half2 XZ_2500_g251657 = temp_output_474_0_g251657;
					half2 XZ_3500_g251657 = temp_output_475_0_g251657;
					half2 XY500_g251657 = temp_output_464_0_g251657;
					half2 XY_1500_g251657 = (Out_MaskF456_g251657).zw;
					half2 XY_2500_g251657 = (Out_MaskG456_g251657).xy;
					half2 XY_3500_g251657 = (Out_MaskG456_g251657).zw;
					half Bias500_g251657 = temp_output_510_0_g251657;
					half3 Weights_1500_g251657 = (Out_MaskH456_g251657).xyz;
					half3 Weights_2500_g251657 = temp_output_480_0_g251657;
					half3 Weights_3500_g251657 = (Out_MaskJ456_g251657).xyz;
					half3 Triplanar500_g251657 = Triplanar522_g251657;
					half3 NormalWS500_g251657 = NormalWS512_g251657;
					half3 Normal500_g251657 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251657 = SampleStochastic3D( Texture500_g251657 , Sampler500_g251657 , ZY500_g251657 , ZY_1500_g251657 , ZY_2500_g251657 , ZY_3500_g251657 , XZ500_g251657 , XZ_1500_g251657 , XZ_2500_g251657 , XZ_3500_g251657 , XY500_g251657 , XY_1500_g251657 , XY_2500_g251657 , XY_3500_g251657 , Bias500_g251657 , Weights_1500_g251657 , Weights_2500_g251657 , Weights_3500_g251657 , Triplanar500_g251657 , NormalWS500_g251657 , Normal500_g251657 );
					float3 temp_output_35_0_g251658 = Normal500_g251657;
					float dotResult84_g251658 = dot( temp_output_35_0_g251658 , TangentWS519_g251657 );
					float dotResult85_g251658 = dot( temp_output_35_0_g251658 , BitangentWS521_g251657 );
					float2 appendResult87_g251658 = (float2(dotResult84_g251658 , dotResult85_g251658));
					float2 temp_output_406_390_g251628 = appendResult87_g251658;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g251628 = temp_output_406_394_g251628;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g251628 = temp_output_406_397_g251628;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g251628 = temp_output_406_375_g251628;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g251628 = temp_output_406_353_g251628;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g251628 = temp_output_406_391_g251628;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g251628 = temp_output_406_390_g251628;
					#else
					float2 staticSwitch193_g251628 = temp_output_406_394_g251628;
					#endif
					half2 Local_NormaSample191_g251628 = staticSwitch193_g251628;
					half2 Local_NormalTS108_g251628 = ( Local_NormaSample191_g251628 * _MainNormalValue );
					float2 In_NormalTS3_g251630 = Local_NormalTS108_g251628;
					float2 break80_g251649 = Local_NormalTS108_g251628;
					float3 temp_output_77_0_g251649 = Model_TangentWS366_g251628;
					float3 temp_output_78_0_g251649 = Model_BitangentWS367_g251628;
					float3 temp_output_76_0_g251649 = Model_NormalWS226_g251628;
					half3 Local_NormalWS250_g251628 = ( ( break80_g251649.x * temp_output_77_0_g251649 ) + ( break80_g251649.y * temp_output_78_0_g251649 ) + temp_output_76_0_g251649 );
					float3 In_NormalWS3_g251630 = Local_NormalWS250_g251628;
					float temp_output_209_0_g251628 = (Local_ShaderSample199_g251628).y;
					float temp_output_7_0_g251642 = _MainOcclusionRemap.x;
					float temp_output_9_0_g251642 = ( temp_output_209_0_g251628 - temp_output_7_0_g251642 );
					float lerpResult23_g251628 = lerp( 1.0 , saturate( ( temp_output_9_0_g251642 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g251628 = lerpResult23_g251628;
					float temp_output_213_0_g251628 = (Local_ShaderSample199_g251628).w;
					float temp_output_7_0_g251645 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g251645 = ( temp_output_213_0_g251628 - temp_output_7_0_g251645 );
					half Local_Smoothness317_g251628 = ( saturate( ( temp_output_9_0_g251645 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g251628 = (float4(( (Local_ShaderSample199_g251628).x * _MainMetallicValue ) , Local_Occlusion313_g251628 , (Local_ShaderSample199_g251628).z , Local_Smoothness317_g251628));
					half4 Local_Masks109_g251628 = appendResult73_g251628;
					float4 In_Shader3_g251630 = Local_Masks109_g251628;
					float4 In_Feature3_g251630 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251630 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251630 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g251663 = Local_Albedo139_g251628;
					float dotResult20_g251663 = dot( temp_output_3_0_g251663 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g251628 = dotResult20_g251663;
					float temp_output_12_0_g251630 = Local_Grayscale110_g251628;
					float In_Grayscale3_g251630 = temp_output_12_0_g251630;
					float temp_output_3_0_g251664 = Local_Grayscale110_g251628;
					float clampResult27_g251664 = clamp( saturate( ( temp_output_3_0_g251664 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g251628 = clampResult27_g251664;
					float temp_output_16_0_g251630 = Local_Luminosity145_g251628;
					float In_Luminosity3_g251630 = temp_output_16_0_g251630;
					float In_MultiMask3_g251630 = Local_MultiMask78_g251628;
					float temp_output_187_0_g251628 = (Local_AlbedoSample185_g251628).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g251628 = ( temp_output_187_0_g251628 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g251628 = temp_output_187_0_g251628;
					#endif
					half Local_AlphaClip111_g251628 = staticSwitch236_g251628;
					float In_AlphaClip3_g251630 = Local_AlphaClip111_g251628;
					half Local_AlphaFade246_g251628 = (lerpResult62_g251628).a;
					float In_AlphaFade3_g251630 = Local_AlphaFade246_g251628;
					float3 temp_cast_24 = (1.0).xxx;
					float3 In_Translucency3_g251630 = temp_cast_24;
					float In_Transmission3_g251630 = 1.0;
					float In_Thickness3_g251630 = 0.0;
					float In_Diffusion3_g251630 = 0.0;
					float In_Depth3_g251630 = 0.0;
					BuildVisualData( Data3_g251630 , In_Dummy3_g251630 , In_Albedo3_g251630 , In_AlbedoBase3_g251630 , In_NormalTS3_g251630 , In_NormalWS3_g251630 , In_Shader3_g251630 , In_Feature3_g251630 , In_Season3_g251630 , In_Emissive3_g251630 , In_Grayscale3_g251630 , In_Luminosity3_g251630 , In_MultiMask3_g251630 , In_AlphaClip3_g251630 , In_AlphaFade3_g251630 , In_Translucency3_g251630 , In_Transmission3_g251630 , In_Thickness3_g251630 , In_Diffusion3_g251630 , In_Depth3_g251630 );
					TVEVisualData Data4_g251672 =(TVEVisualData)Data3_g251630;
					float Out_Dummy4_g251672 = 0.0;
					float3 Out_Albedo4_g251672 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g251672 = float3( 0,0,0 );
					float2 Out_NormalTS4_g251672 = float2( 0,0 );
					float3 Out_NormalWS4_g251672 = float3( 0,0,0 );
					float4 Out_Shader4_g251672 = float4( 0,0,0,0 );
					float4 Out_Feature4_g251672 = float4( 0,0,0,0 );
					float4 Out_Season4_g251672 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g251672 = float4( 0,0,0,0 );
					float Out_MultiMask4_g251672 = 0.0;
					float Out_Grayscale4_g251672 = 0.0;
					float Out_Luminosity4_g251672 = 0.0;
					float Out_AlphaClip4_g251672 = 0.0;
					float Out_AlphaFade4_g251672 = 0.0;
					float3 Out_Translucency4_g251672 = float3( 0,0,0 );
					float Out_Transmission4_g251672 = 0.0;
					float Out_Thickness4_g251672 = 0.0;
					float Out_Diffusion4_g251672 = 0.0;
					float Out_Depth4_g251672 = 0.0;
					BreakVisualData( Data4_g251672 , Out_Dummy4_g251672 , Out_Albedo4_g251672 , Out_AlbedoBase4_g251672 , Out_NormalTS4_g251672 , Out_NormalWS4_g251672 , Out_Shader4_g251672 , Out_Feature4_g251672 , Out_Season4_g251672 , Out_Emissive4_g251672 , Out_MultiMask4_g251672 , Out_Grayscale4_g251672 , Out_Luminosity4_g251672 , Out_AlphaClip4_g251672 , Out_AlphaFade4_g251672 , Out_Translucency4_g251672 , Out_Transmission4_g251672 , Out_Thickness4_g251672 , Out_Diffusion4_g251672 , Out_Depth4_g251672 );
					float Alpha109_g251667 = Out_AlphaClip4_g251672;
					float lerpResult91_g251667 = lerp( 1.0 , Alpha109_g251667 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g251667 = lerp( 1.0 , lerpResult91_g251667 , Filter152_g251667);
					clip( lerpResult154_g251667 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = half3( 0, 0, 0 );
					half Metallic = temp_output_2419_114;
					half Smoothness = temp_output_2419_114;
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

					o.Emission = ( lerpResult72_g251667 * lerpResult84_g251667 );
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

					TVEVertexData Data16_g251543 =(TVEVertexData)0;
					float In_Dummy16_g251543 = 0.0;
					TVEVertexData Data16_g251538 =(TVEVertexData)0;
					float In_Dummy16_g251538 = 0.0;
					TVEModelData Data16_g240700 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g240682 = _ObjectCoordMode;
					#else
					float staticSwitch343_g240682 = _ObjectCoordMode;
					#endif
					half Dummy207_g240682 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g240682 );
					float temp_output_14_0_g240700 = Dummy207_g240682;
					float In_Dummy16_g240700 = temp_output_14_0_g240700;
					float3 PositionOS131_g240682 = v.vertex.xyz;
					float3 temp_output_4_0_g240700 = PositionOS131_g240682;
					float3 In_PositionOS16_g240700 = temp_output_4_0_g240700;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g240682 = ase_positionWS;
					float3 vertexToFrag73_g240682 = temp_output_104_7_g240682;
					float3 PositionWS122_g240682 = vertexToFrag73_g240682;
					float3 In_PositionWS16_g240700 = PositionWS122_g240682;
					float4x4 break19_g240685 = unity_ObjectToWorld;
					float3 appendResult20_g240685 = (float3(break19_g240685[ 0 ][ 3 ] , break19_g240685[ 1 ][ 3 ] , break19_g240685[ 2 ][ 3 ]));
					float3 temp_output_340_7_g240682 = appendResult20_g240685;
					float4x4 break19_g240687 = unity_ObjectToWorld;
					float3 appendResult20_g240687 = (float3(break19_g240687[ 0 ][ 3 ] , break19_g240687[ 1 ][ 3 ] , break19_g240687[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g240683 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g240682 = PositionOS131_g240682;
					float3 appendResult234_g240682 = (float3(break233_g240682.x , 0.0 , break233_g240682.z));
					float3 break413_g240682 = PositionOS131_g240682;
					float3 appendResult414_g240682 = (float3(break413_g240682.x , break413_g240682.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g240689 = appendResult414_g240682;
					#else
					float3 staticSwitch65_g240689 = appendResult234_g240682;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g240682 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g240682 = appendResult60_g240683;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g240682 = staticSwitch65_g240689;
					#else
					float3 staticSwitch229_g240682 = _Vector0;
					#endif
					float3 PivotOS149_g240682 = staticSwitch229_g240682;
					float3 temp_output_122_0_g240687 = PivotOS149_g240682;
					float3 PivotsOnlyWS105_g240687 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g240687 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g240682 = ( appendResult20_g240687 + PivotsOnlyWS105_g240687 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g240682 = temp_output_340_7_g240682;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g240682 = temp_output_341_7_g240682;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g240682 = temp_output_341_7_g240682;
					#else
					float3 staticSwitch236_g240682 = temp_output_340_7_g240682;
					#endif
					float3 vertexToFrag76_g240682 = staticSwitch236_g240682;
					float3 PivotWS121_g240682 = vertexToFrag76_g240682;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g240682 = ( PositionWS122_g240682 - PivotWS121_g240682 );
					#else
					float3 staticSwitch204_g240682 = PositionWS122_g240682;
					#endif
					float3 PositionWO132_g240682 = ( staticSwitch204_g240682 - TVE_WorldOrigin );
					float3 In_PositionWO16_g240700 = PositionWO132_g240682;
					float3 In_PivotOS16_g240700 = PivotOS149_g240682;
					float3 In_PivotWS16_g240700 = PivotWS121_g240682;
					float3 PivotWO133_g240682 = ( PivotWS121_g240682 - TVE_WorldOrigin );
					float3 In_PivotWO16_g240700 = PivotWO133_g240682;
					half3 NormalOS134_g240682 = v.normal;
					float3 temp_output_21_0_g240700 = NormalOS134_g240682;
					float3 In_NormalOS16_g240700 = temp_output_21_0_g240700;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g240682 = normalizedWorldNormal;
					float3 In_NormalWS16_g240700 = NormalWS95_g240682;
					half4 TangentlOS153_g240682 = v.tangent;
					float4 temp_output_6_0_g240700 = TangentlOS153_g240682;
					float4 In_TangentOS16_g240700 = temp_output_6_0_g240700;
					float3 normalizeResult296_g240682 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g240682 ) );
					half3 ViewDirWS169_g240682 = normalizeResult296_g240682;
					float3 In_ViewDirWS16_g240700 = ViewDirWS169_g240682;
					float4 appendResult397_g240682 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g240682 = appendResult397_g240682;
					float4 In_CoordsData16_g240700 = CoordsData398_g240682;
					half4 VertexMasks171_g240682 = v.ase_color;
					float4 In_VertexData16_g240700 = VertexMasks171_g240682;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g240694 = (PositionOS131_g240682).z;
					#else
					float staticSwitch65_g240694 = (PositionOS131_g240682).y;
					#endif
					half Object_HeightValue267_g240682 = _ObjectHeightValue;
					half Bounds_HeightMask274_g240682 = saturate( ( staticSwitch65_g240694 / Object_HeightValue267_g240682 ) );
					half3 Position387_g240682 = PositionOS131_g240682;
					half Height387_g240682 = Object_HeightValue267_g240682;
					half Object_RadiusValue268_g240682 = _ObjectRadiusValue;
					half Radius387_g240682 = Object_RadiusValue268_g240682;
					half localCapsuleMaskYUp387_g240682 = CapsuleMaskYUp( Position387_g240682 , Height387_g240682 , Radius387_g240682 );
					half3 Position408_g240682 = PositionOS131_g240682;
					half Height408_g240682 = Object_HeightValue267_g240682;
					half Radius408_g240682 = Object_RadiusValue268_g240682;
					half localCapsuleMaskZUp408_g240682 = CapsuleMaskZUp( Position408_g240682 , Height408_g240682 , Radius408_g240682 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g240699 = saturate( localCapsuleMaskZUp408_g240682 );
					#else
					float staticSwitch65_g240699 = saturate( localCapsuleMaskYUp387_g240682 );
					#endif
					half Bounds_SphereMask282_g240682 = staticSwitch65_g240699;
					float4 appendResult253_g240682 = (float4(Bounds_HeightMask274_g240682 , Bounds_SphereMask282_g240682 , 1.0 , 1.0));
					half4 MasksData254_g240682 = appendResult253_g240682;
					float4 In_MasksData16_g240700 = MasksData254_g240682;
					float temp_output_17_0_g240693 = _ObjectPhaseMode;
					float Option70_g240693 = temp_output_17_0_g240693;
					float4 temp_output_3_0_g240693 = v.ase_color;
					float4 Channel70_g240693 = temp_output_3_0_g240693;
					float localSwitchChannel470_g240693 = SwitchChannel4( Option70_g240693 , Channel70_g240693 );
					half Phase_Value372_g240682 = localSwitchChannel470_g240693;
					float3 break319_g240682 = PivotWO133_g240682;
					half Pivot_Position322_g240682 = ( break319_g240682.x + break319_g240682.z );
					half Phase_Position357_g240682 = ( Phase_Value372_g240682 + Pivot_Position322_g240682 );
					float temp_output_248_0_g240682 = frac( Phase_Position357_g240682 );
					float4 appendResult177_g240682 = (float4((frac( ( Phase_Position357_g240682 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g240682));
					half4 Phase_Data176_g240682 = appendResult177_g240682;
					float4 In_PhaseData16_g240700 = Phase_Data176_g240682;
					BuildModelVertData( Data16_g240700 , In_Dummy16_g240700 , In_PositionOS16_g240700 , In_PositionWS16_g240700 , In_PositionWO16_g240700 , In_PivotOS16_g240700 , In_PivotWS16_g240700 , In_PivotWO16_g240700 , In_NormalOS16_g240700 , In_NormalWS16_g240700 , In_TangentOS16_g240700 , In_ViewDirWS16_g240700 , In_CoordsData16_g240700 , In_VertexData16_g240700 , In_MasksData16_g240700 , In_PhaseData16_g240700 );
					TVEModelData Data15_g251539 =(TVEModelData)Data16_g240700;
					float Out_Dummy15_g251539 = 0.0;
					float3 Out_PositionOS15_g251539 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251539 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251539 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251539 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251539 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251539 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251539 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251539 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251539 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251539 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251539 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251539 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251539 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251539 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251539 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251539 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251539 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251539 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251539 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251539 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251539 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251539 , Out_Dummy15_g251539 , Out_PositionOS15_g251539 , Out_PositionWS15_g251539 , Out_PositionWO15_g251539 , Out_PositionRawOS15_g251539 , Out_PivotOS15_g251539 , Out_PivotWS15_g251539 , Out_PivotWO15_g251539 , Out_NormalOS15_g251539 , Out_NormalWS15_g251539 , Out_NormalRawOS15_g251539 , Out_TangentOS15_g251539 , Out_TangentWS15_g251539 , Out_BitangentWS15_g251539 , Out_ViewDirWS15_g251539 , Out_CoordsData15_g251539 , Out_VertexData15_g251539 , Out_MasksData15_g251539 , Out_PhaseData15_g251539 , Out_TransformData15_g251539 , Out_RotationData15_g251539 , Out_Interpolator15_g251539 );
					float3 In_PositionOS16_g251538 = Out_PositionOS15_g251539;
					float3 In_NormalOS16_g251538 = Out_NormalOS15_g251539;
					float4 In_TangentOS16_g251538 = Out_TangentOS15_g251539;
					float4 In_TransformData16_g251538 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251538 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251538 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251538 , In_Dummy16_g251538 , In_PositionOS16_g251538 , In_NormalOS16_g251538 , In_TangentOS16_g251538 , In_TransformData16_g251538 , In_RotationData16_g251538 , In_Interpolator16_g251538 );
					TVEVertexData Data15_g251541 =(TVEVertexData)Data16_g251538;
					float Out_Dummy15_g251541 = 0.0;
					float3 Out_PositionOS15_g251541 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251541 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251541 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251541 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251541 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251541 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251541 , Out_Dummy15_g251541 , Out_PositionOS15_g251541 , Out_NormalOS15_g251541 , Out_TangentOS15_g251541 , Out_TransformData15_g251541 , Out_RotationData15_g251541 , Out_Interpolator15_g251541 );
					TVEModelData Data15_g251542 =(TVEModelData)Data15_g251539;
					float Out_Dummy15_g251542 = 0.0;
					float3 Out_PositionOS15_g251542 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251542 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251542 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251542 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251542 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251542 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251542 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251542 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251542 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251542 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251542 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251542 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251542 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251542 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251542 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251542 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251542 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251542 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251542 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251542 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251542 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251542 , Out_Dummy15_g251542 , Out_PositionOS15_g251542 , Out_PositionWS15_g251542 , Out_PositionWO15_g251542 , Out_PositionRawOS15_g251542 , Out_PivotOS15_g251542 , Out_PivotWS15_g251542 , Out_PivotWO15_g251542 , Out_NormalOS15_g251542 , Out_NormalWS15_g251542 , Out_NormalRawOS15_g251542 , Out_TangentOS15_g251542 , Out_TangentWS15_g251542 , Out_BitangentWS15_g251542 , Out_ViewDirWS15_g251542 , Out_CoordsData15_g251542 , Out_VertexData15_g251542 , Out_MasksData15_g251542 , Out_PhaseData15_g251542 , Out_TransformData15_g251542 , Out_RotationData15_g251542 , Out_Interpolator15_g251542 );
					float3 In_PositionOS16_g251543 = ( Out_PositionOS15_g251541 - Out_PivotOS15_g251542 );
					float3 In_NormalOS16_g251543 = Out_NormalOS15_g251542;
					float4 In_TangentOS16_g251543 = Out_TangentOS15_g251542;
					float4 In_TransformData16_g251543 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251543 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251543 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251543 , In_Dummy16_g251543 , In_PositionOS16_g251543 , In_NormalOS16_g251543 , In_TangentOS16_g251543 , In_TransformData16_g251543 , In_RotationData16_g251543 , In_Interpolator16_g251543 );
					TVEVertexData Data15_g251552 =(TVEVertexData)Data16_g251543;
					float Out_Dummy15_g251552 = 0.0;
					float3 Out_PositionOS15_g251552 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251552 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251552 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251552 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251552 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251552 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251552 , Out_Dummy15_g251552 , Out_PositionOS15_g251552 , Out_NormalOS15_g251552 , Out_TangentOS15_g251552 , Out_TransformData15_g251552 , Out_RotationData15_g251552 , Out_Interpolator15_g251552 );
					TVEVertexData Data16_g251553 =(TVEVertexData)Data15_g251552;
					half Dummy317_g251544 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251553 = Dummy317_g251544;
					float3 In_PositionOS16_g251553 = Out_PositionOS15_g251552;
					float3 In_NormalOS16_g251553 = Out_NormalOS15_g251552;
					float4 In_TangentOS16_g251553 = Out_TangentOS15_g251552;
					half4 Model_TransformData356_g251544 = Out_TransformData15_g251552;
					float localBuildGlobalData204_g240581 = ( 0.0 );
					TVEGlobalData Data204_g240581 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g240581 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g240581 = Dummy211_g240581;
					float4 temp_output_203_0_g240600 = TVE_CoatBaseCoord;
					TVEModelData Data16_g240690 =(TVEModelData)0;
					float In_Dummy16_g240690 = 0.0;
					float3 In_PositionWS16_g240690 = PositionWS122_g240682;
					float3 In_PositionWO16_g240690 = PositionWO132_g240682;
					float3 In_PivotWS16_g240690 = PivotWS121_g240682;
					float3 In_PivotWO16_g240690 = PivotWO133_g240682;
					float3 In_NormalWS16_g240690 = NormalWS95_g240682;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g240682 = ase_tangentWS;
					float3 In_TangentWS16_g240690 = TangentWS136_g240682;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g240682 = ase_bitangentWS;
					float3 In_BitangentWS16_g240690 = BiangentWS421_g240682;
					half3 NormalWS427_g240682 = NormalWS95_g240682;
					half3 localComputeTriplanarMasks427_g240682 = ComputeTriplanarMasks( NormalWS427_g240682 );
					half3 TriplanarWeights429_g240682 = localComputeTriplanarMasks427_g240682;
					float3 In_TriplanarWeights16_g240690 = TriplanarWeights429_g240682;
					float3 In_ViewDirWS16_g240690 = ViewDirWS169_g240682;
					float4 In_CoordsData16_g240690 = CoordsData398_g240682;
					float4 In_VertexData16_g240690 = VertexMasks171_g240682;
					float4 In_Interpolator16_g240690 = Phase_Data176_g240682;
					BuildModelFragData( Data16_g240690 , In_Dummy16_g240690 , In_PositionWS16_g240690 , In_PositionWO16_g240690 , In_PivotWS16_g240690 , In_PivotWO16_g240690 , In_NormalWS16_g240690 , In_TangentWS16_g240690 , In_BitangentWS16_g240690 , In_TriplanarWeights16_g240690 , In_ViewDirWS16_g240690 , In_CoordsData16_g240690 , In_VertexData16_g240690 , In_Interpolator16_g240690 );
					TVEModelData Data15_g240671 =(TVEModelData)Data16_g240690;
					float Out_Dummy15_g240671 = 0.0;
					float3 Out_PositionWS15_g240671 = float3( 0,0,0 );
					float3 Out_PositionWO15_g240671 = float3( 0,0,0 );
					float3 Out_PivotWS15_g240671 = float3( 0,0,0 );
					float3 Out_PivotWO15_g240671 = float3( 0,0,0 );
					float3 Out_NormalWS15_g240671 = float3( 0,0,0 );
					float3 Out_TangentWS15_g240671 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g240671 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g240671 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g240671 = float3( 0,0,0 );
					float4 Out_CoordsData15_g240671 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g240671 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g240671 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g240671 , Out_Dummy15_g240671 , Out_PositionWS15_g240671 , Out_PositionWO15_g240671 , Out_PivotWS15_g240671 , Out_PivotWO15_g240671 , Out_NormalWS15_g240671 , Out_TangentWS15_g240671 , Out_BitangentWS15_g240671 , Out_TriplanarWeights15_g240671 , Out_ViewDirWS15_g240671 , Out_CoordsData15_g240671 , Out_VertexData15_g240671 , Out_Interpolator15_g240671 );
					float3 Model_PositionWS497_g240581 = Out_PositionWS15_g240671;
					float2 Model_PositionWS_XZ143_g240581 = (Model_PositionWS497_g240581).xz;
					float3 Model_PivotWS498_g240581 = Out_PivotWS15_g240671;
					float2 Model_PivotWS_XZ145_g240581 = (Model_PivotWS498_g240581).xz;
					float2 lerpResult300_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g240600 = lerpResult300_g240581;
					float temp_output_82_0_g240598 = _GlobalCoatLayerValue;
					float temp_output_82_0_g240600 = temp_output_82_0_g240598;
					float4 tex2DArrayNode83_g240600 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240600).zw + ( (temp_output_203_0_g240600).xy * temp_output_81_0_g240600 ) ),temp_output_82_0_g240600), 0.0 );
					float4 appendResult210_g240600 = (float4(tex2DArrayNode83_g240600.rgb , tex2DArrayNode83_g240600.a));
					float4 temp_output_204_0_g240600 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g240600 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240600).zw + ( (temp_output_204_0_g240600).xy * temp_output_81_0_g240600 ) ),temp_output_82_0_g240600), 0.0 );
					float4 appendResult212_g240600 = (float4(tex2DArrayNode122_g240600.rgb , tex2DArrayNode122_g240600.a));
					float4 TVE_RenderNearPositionR628_g240581 = TVE_RenderNearPositionR;
					float temp_output_507_0_g240581 = saturate( ( distance( Model_PositionWS497_g240581 , (TVE_RenderNearPositionR628_g240581).xyz ) / (TVE_RenderNearPositionR628_g240581).w ) );
					float temp_output_7_0_g240670 = 1.0;
					float temp_output_9_0_g240670 = ( temp_output_507_0_g240581 - temp_output_7_0_g240670 );
					half TVE_RenderNearFadeValue635_g240581 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g240581 = saturate( ( temp_output_9_0_g240670 / ( ( TVE_RenderNearFadeValue635_g240581 - temp_output_7_0_g240670 ) + 0.0001 ) ) );
					float4 lerpResult131_g240600 = lerp( appendResult210_g240600 , appendResult212_g240600 , Global_TexBlend509_g240581);
					float4 temp_output_159_109_g240598 = lerpResult131_g240600;
					float4 lerpResult168_g240598 = lerp( TVE_CoatParams , temp_output_159_109_g240598 , TVE_CoatLayers[(int)temp_output_82_0_g240598]);
					float4 temp_output_589_109_g240581 = lerpResult168_g240598;
					half4 Coat_Texture302_g240581 = temp_output_589_109_g240581;
					float4 In_CoatTexture204_g240581 = Coat_Texture302_g240581;
					half4 Draw_Texture656_g240581 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g240581 = Draw_Texture656_g240581;
					float4 temp_output_203_0_g240625 = TVE_PaintBaseCoord;
					float2 lerpResult85_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g240625 = lerpResult85_g240581;
					float temp_output_82_0_g240622 = _GlobalPaintLayerValue;
					float temp_output_82_0_g240625 = temp_output_82_0_g240622;
					float4 tex2DArrayNode83_g240625 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240625).zw + ( (temp_output_203_0_g240625).xy * temp_output_81_0_g240625 ) ),temp_output_82_0_g240625), 0.0 );
					float4 appendResult210_g240625 = (float4(tex2DArrayNode83_g240625.rgb , tex2DArrayNode83_g240625.a));
					float4 temp_output_204_0_g240625 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g240625 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240625).zw + ( (temp_output_204_0_g240625).xy * temp_output_81_0_g240625 ) ),temp_output_82_0_g240625), 0.0 );
					float4 appendResult212_g240625 = (float4(tex2DArrayNode122_g240625.rgb , tex2DArrayNode122_g240625.a));
					float4 lerpResult131_g240625 = lerp( appendResult210_g240625 , appendResult212_g240625 , Global_TexBlend509_g240581);
					float4 temp_output_171_109_g240622 = lerpResult131_g240625;
					float4 lerpResult174_g240622 = lerp( TVE_PaintParams , temp_output_171_109_g240622 , TVE_PaintLayers[(int)temp_output_82_0_g240622]);
					float4 temp_output_595_109_g240581 = lerpResult174_g240622;
					half4 Paint_Texture71_g240581 = temp_output_595_109_g240581;
					float4 In_PaintTexture204_g240581 = Paint_Texture71_g240581;
					float4 temp_output_203_0_g240608 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g240608 = lerpResult104_g240581;
					float temp_output_132_0_g240606 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g240608 = temp_output_132_0_g240606;
					float4 tex2DArrayNode83_g240608 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240608).zw + ( (temp_output_203_0_g240608).xy * temp_output_81_0_g240608 ) ),temp_output_82_0_g240608), 0.0 );
					float4 appendResult210_g240608 = (float4(tex2DArrayNode83_g240608.rgb , tex2DArrayNode83_g240608.a));
					float4 temp_output_204_0_g240608 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g240608 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240608).zw + ( (temp_output_204_0_g240608).xy * temp_output_81_0_g240608 ) ),temp_output_82_0_g240608), 0.0 );
					float4 appendResult212_g240608 = (float4(tex2DArrayNode122_g240608.rgb , tex2DArrayNode122_g240608.a));
					float4 lerpResult131_g240608 = lerp( appendResult210_g240608 , appendResult212_g240608 , Global_TexBlend509_g240581);
					float4 temp_output_137_109_g240606 = lerpResult131_g240608;
					float4 lerpResult145_g240606 = lerp( TVE_AtmoParams , temp_output_137_109_g240606 , TVE_AtmoLayers[(int)temp_output_132_0_g240606]);
					float4 temp_output_590_110_g240581 = lerpResult145_g240606;
					half4 Atmo_Texture80_g240581 = temp_output_590_110_g240581;
					float4 In_AtmoTexture204_g240581 = Atmo_Texture80_g240581;
					float4 temp_output_203_0_g240676 = TVE_EffexBaseCoord;
					float2 lerpResult414_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g240676 = lerpResult414_g240581;
					float temp_output_132_0_g240674 = _GlobalEffexLayerValue;
					float temp_output_82_0_g240676 = temp_output_132_0_g240674;
					float4 tex2DArrayNode83_g240676 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240676).zw + ( (temp_output_203_0_g240676).xy * temp_output_81_0_g240676 ) ),temp_output_82_0_g240676), 0.0 );
					float4 appendResult210_g240676 = (float4(tex2DArrayNode83_g240676.rgb , tex2DArrayNode83_g240676.a));
					float4 temp_output_204_0_g240676 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g240676 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240676).zw + ( (temp_output_204_0_g240676).xy * temp_output_81_0_g240676 ) ),temp_output_82_0_g240676), 0.0 );
					float4 appendResult212_g240676 = (float4(tex2DArrayNode122_g240676.rgb , tex2DArrayNode122_g240676.a));
					float4 lerpResult131_g240676 = lerp( appendResult210_g240676 , appendResult212_g240676 , Global_TexBlend509_g240581);
					float4 temp_output_137_109_g240674 = lerpResult131_g240676;
					float4 lerpResult145_g240674 = lerp( TVE_EffexParams , temp_output_137_109_g240674 , TVE_EffexLayers[(int)temp_output_132_0_g240674]);
					float4 temp_output_731_110_g240581 = lerpResult145_g240674;
					half4 Effex_Texture420_g240581 = temp_output_731_110_g240581;
					float4 In_EffexTexture204_g240581 = Effex_Texture420_g240581;
					float4 temp_output_203_0_g240656 = TVE_GlowBaseCoord;
					float2 lerpResult247_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g240656 = lerpResult247_g240581;
					float temp_output_82_0_g240654 = _GlobalGlowLayerValue;
					float temp_output_82_0_g240656 = temp_output_82_0_g240654;
					float4 tex2DArrayNode83_g240656 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240656).zw + ( (temp_output_203_0_g240656).xy * temp_output_81_0_g240656 ) ),temp_output_82_0_g240656), 0.0 );
					float4 appendResult210_g240656 = (float4(tex2DArrayNode83_g240656.rgb , tex2DArrayNode83_g240656.a));
					float4 temp_output_204_0_g240656 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g240656 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240656).zw + ( (temp_output_204_0_g240656).xy * temp_output_81_0_g240656 ) ),temp_output_82_0_g240656), 0.0 );
					float4 appendResult212_g240656 = (float4(tex2DArrayNode122_g240656.rgb , tex2DArrayNode122_g240656.a));
					float4 lerpResult131_g240656 = lerp( appendResult210_g240656 , appendResult212_g240656 , Global_TexBlend509_g240581);
					float4 temp_output_159_109_g240654 = lerpResult131_g240656;
					float4 lerpResult167_g240654 = lerp( TVE_GlowParams , temp_output_159_109_g240654 , TVE_GlowLayers[(int)temp_output_82_0_g240654]);
					float4 temp_output_593_109_g240581 = lerpResult167_g240654;
					half4 Glow_Texture248_g240581 = temp_output_593_109_g240581;
					float4 In_GlowTexture204_g240581 = Glow_Texture248_g240581;
					float4 temp_output_203_0_g240592 = TVE_FormBaseCoord;
					float2 lerpResult168_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g240592 = lerpResult168_g240581;
					float temp_output_130_0_g240590 = _GlobalFormLayerValue;
					float temp_output_82_0_g240592 = temp_output_130_0_g240590;
					float4 tex2DArrayNode83_g240592 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240592).zw + ( (temp_output_203_0_g240592).xy * temp_output_81_0_g240592 ) ),temp_output_82_0_g240592), 0.0 );
					float4 appendResult210_g240592 = (float4(tex2DArrayNode83_g240592.rgb , tex2DArrayNode83_g240592.a));
					float4 temp_output_204_0_g240592 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g240592 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240592).zw + ( (temp_output_204_0_g240592).xy * temp_output_81_0_g240592 ) ),temp_output_82_0_g240592), 0.0 );
					float4 appendResult212_g240592 = (float4(tex2DArrayNode122_g240592.rgb , tex2DArrayNode122_g240592.a));
					float4 lerpResult131_g240592 = lerp( appendResult210_g240592 , appendResult212_g240592 , Global_TexBlend509_g240581);
					float4 temp_output_135_109_g240590 = lerpResult131_g240592;
					float4 lerpResult143_g240590 = lerp( TVE_FormParams , temp_output_135_109_g240590 , TVE_FormLayers[(int)temp_output_130_0_g240590]);
					float4 temp_output_592_0_g240581 = lerpResult143_g240590;
					float4 Form_Texture112_g240581 = temp_output_592_0_g240581;
					float4 In_FormTexture204_g240581 = Form_Texture112_g240581;
					float4 In_LandTexture204_g240581 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g240640 = TVE_VertxBaseCoord;
					float2 lerpResult681_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g240640 = lerpResult681_g240581;
					float temp_output_136_0_g240638 = _GlobalVertxLayerValue;
					float temp_output_82_0_g240640 = temp_output_136_0_g240638;
					float4 tex2DArrayNode83_g240640 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240640).zw + ( (temp_output_203_0_g240640).xy * temp_output_81_0_g240640 ) ),temp_output_82_0_g240640), 0.0 );
					float4 appendResult210_g240640 = (float4(tex2DArrayNode83_g240640.rgb , tex2DArrayNode83_g240640.a));
					float4 temp_output_204_0_g240640 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g240640 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240640).zw + ( (temp_output_204_0_g240640).xy * temp_output_81_0_g240640 ) ),temp_output_82_0_g240640), 0.0 );
					float4 appendResult212_g240640 = (float4(tex2DArrayNode122_g240640.rgb , tex2DArrayNode122_g240640.a));
					float4 lerpResult131_g240640 = lerp( appendResult210_g240640 , appendResult212_g240640 , Global_TexBlend509_g240581);
					float4 temp_output_141_109_g240638 = lerpResult131_g240640;
					float4 lerpResult149_g240638 = lerp( TVE_VertxParams , temp_output_141_109_g240638 , TVE_VertxLayers[(int)temp_output_136_0_g240638]);
					float4 temp_output_695_0_g240581 = lerpResult149_g240638;
					half4 Vertx_Texture693_g240581 = temp_output_695_0_g240581;
					float4 In_VertxTexture204_g240581 = Vertx_Texture693_g240581;
					float4 temp_output_203_0_g240616 = TVE_FlowBaseCoord;
					float2 lerpResult400_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g240616 = lerpResult400_g240581;
					float temp_output_136_0_g240614 = _GlobalFlowLayerValue;
					float temp_output_82_0_g240616 = temp_output_136_0_g240614;
					float4 tex2DArrayNode83_g240616 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240616).zw + ( (temp_output_203_0_g240616).xy * temp_output_81_0_g240616 ) ),temp_output_82_0_g240616), 0.0 );
					float4 appendResult210_g240616 = (float4(tex2DArrayNode83_g240616.rgb , tex2DArrayNode83_g240616.a));
					float4 temp_output_204_0_g240616 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g240616 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240616).zw + ( (temp_output_204_0_g240616).xy * temp_output_81_0_g240616 ) ),temp_output_82_0_g240616), 0.0 );
					float4 appendResult212_g240616 = (float4(tex2DArrayNode122_g240616.rgb , tex2DArrayNode122_g240616.a));
					float4 lerpResult131_g240616 = lerp( appendResult210_g240616 , appendResult212_g240616 , Global_TexBlend509_g240581);
					float4 temp_output_141_109_g240614 = lerpResult131_g240616;
					float4 lerpResult149_g240614 = lerp( TVE_FlowParams , temp_output_141_109_g240614 , TVE_FlowLayers[(int)temp_output_136_0_g240614]);
					float4 temp_output_594_0_g240581 = lerpResult149_g240614;
					half4 Flow_Texture405_g240581 = temp_output_594_0_g240581;
					float4 In_FlowTexture204_g240581 = Flow_Texture405_g240581;
					half4 User_Texture677_g240581 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g240581 = User_Texture677_g240581;
					BuildGlobalData( Data204_g240581 , In_Dummy204_g240581 , In_CoatTexture204_g240581 , In_DrawTexture204_g240581 , In_PaintTexture204_g240581 , In_AtmoTexture204_g240581 , In_EffexTexture204_g240581 , In_GlowTexture204_g240581 , In_FormTexture204_g240581 , In_LandTexture204_g240581 , In_VertxTexture204_g240581 , In_FlowTexture204_g240581 , In_UserTexture204_g240581 );
					TVEGlobalData Data15_g251554 =(TVEGlobalData)Data204_g240581;
					float Out_Dummy15_g251554 = 0.0;
					float4 Out_CoatTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251554 = float4( 0,0,0,0 );
					BreakData( Data15_g251554 , Out_Dummy15_g251554 , Out_CoatTexture15_g251554 , Out_DrawTexture15_g251554 , Out_PaintTexture15_g251554 , Out_AtmoTexture15_g251554 , Out_EffexTexture15_g251554 , Out_GlowTexture15_g251554 , Out_FormTexture15_g251554 , Out_LandTexture15_g251554 , Out_VertxTexture15_g251554 , Out_FlowTexture15_g251554 , Out_UserTexture15_g251554 );
					float4 Global_FormTexture351_g251544 = Out_FormTexture15_g251554;
					TVEModelData Data15_g251551 =(TVEModelData)Data15_g251542;
					float Out_Dummy15_g251551 = 0.0;
					float3 Out_PositionOS15_g251551 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251551 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251551 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251551 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251551 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251551 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251551 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251551 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251551 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251551 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251551 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251551 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251551 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251551 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251551 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251551 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251551 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251551 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251551 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251551 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251551 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251551 , Out_Dummy15_g251551 , Out_PositionOS15_g251551 , Out_PositionWS15_g251551 , Out_PositionWO15_g251551 , Out_PositionRawOS15_g251551 , Out_PivotOS15_g251551 , Out_PivotWS15_g251551 , Out_PivotWO15_g251551 , Out_NormalOS15_g251551 , Out_NormalWS15_g251551 , Out_NormalRawOS15_g251551 , Out_TangentOS15_g251551 , Out_TangentWS15_g251551 , Out_BitangentWS15_g251551 , Out_ViewDirWS15_g251551 , Out_CoordsData15_g251551 , Out_VertexData15_g251551 , Out_MasksData15_g251551 , Out_PhaseData15_g251551 , Out_TransformData15_g251551 , Out_RotationData15_g251551 , Out_Interpolator15_g251551 );
					float3 Model_PivotWO353_g251544 = Out_PivotWO15_g251551;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251550 = _ConformMeshMode;
					float Option70_g251550 = temp_output_17_0_g251550;
					half4 Model_VertexData357_g251544 = Out_VertexData15_g251551;
					float4 temp_output_3_0_g251550 = Model_VertexData357_g251544;
					float4 Channel70_g251550 = temp_output_3_0_g251550;
					float localSwitchChannel470_g251550 = SwitchChannel4( Option70_g251550 , Channel70_g251550 );
					float temp_output_390_0_g251544 = localSwitchChannel470_g251550;
					float temp_output_7_0_g251547 = _ConformMeshRemap.x;
					float temp_output_9_0_g251547 = ( temp_output_390_0_g251544 - temp_output_7_0_g251547 );
					float lerpResult374_g251544 = lerp( 1.0 , saturate( ( temp_output_9_0_g251547 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251544 = lerpResult374_g251544;
					float temp_output_328_0_g251544 = ( Blend_VertMask379_g251544 * TVE_IsEnabled );
					half Conform_Mask366_g251544 = temp_output_328_0_g251544;
					float temp_output_322_0_g251544 = ( ( ( ( (Global_FormTexture351_g251544).z - ( (Model_PivotWO353_g251544).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251544 ) );
					float3 appendResult329_g251544 = (float3(0.0 , temp_output_322_0_g251544 , 0.0));
					float3 appendResult387_g251544 = (float3(0.0 , 0.0 , temp_output_322_0_g251544));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251548 = appendResult387_g251544;
					#else
					float3 staticSwitch65_g251548 = appendResult329_g251544;
					#endif
					float3 Blanket_Conform368_g251544 = staticSwitch65_g251548;
					float4 appendResult312_g251544 = (float4(Blanket_Conform368_g251544 , 0.0));
					float4 temp_output_310_0_g251544 = ( Model_TransformData356_g251544 + appendResult312_g251544 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251544 = temp_output_310_0_g251544;
					#else
					float4 staticSwitch364_g251544 = Model_TransformData356_g251544;
					#endif
					half4 Final_TransformData365_g251544 = staticSwitch364_g251544;
					float4 In_TransformData16_g251553 = Final_TransformData365_g251544;
					float4 In_RotationData16_g251553 = Out_RotationData15_g251552;
					float4 In_Interpolator16_g251553 = Out_Interpolator15_g251552;
					BuildVertexData( Data16_g251553 , In_Dummy16_g251553 , In_PositionOS16_g251553 , In_NormalOS16_g251553 , In_TangentOS16_g251553 , In_TransformData16_g251553 , In_RotationData16_g251553 , In_Interpolator16_g251553 );
					TVEVertexData Data15_g251564 =(TVEVertexData)Data16_g251553;
					float Out_Dummy15_g251564 = 0.0;
					float3 Out_PositionOS15_g251564 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251564 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251564 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251564 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251564 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251564 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251564 , Out_Dummy15_g251564 , Out_PositionOS15_g251564 , Out_NormalOS15_g251564 , Out_TangentOS15_g251564 , Out_TransformData15_g251564 , Out_RotationData15_g251564 , Out_Interpolator15_g251564 );
					TVEVertexData Data16_g251565 =(TVEVertexData)Data15_g251564;
					float In_Dummy16_g251565 = 0.0;
					float3 Vertex_PositionOS147_g251555 = Out_PositionOS15_g251564;
					half3 VertexPos40_g251559 = Vertex_PositionOS147_g251555;
					float4 temp_output_1615_33_g251555 = Out_RotationData15_g251564;
					half4 Vertex_RotationData1569_g251555 = temp_output_1615_33_g251555;
					float2 break1582_g251555 = (Vertex_RotationData1569_g251555).xy;
					half Angle44_g251559 = break1582_g251555.y;
					half CosAngle89_g251559 = cos( Angle44_g251559 );
					half SinAngle93_g251559 = sin( Angle44_g251559 );
					float3 appendResult95_g251559 = (float3((VertexPos40_g251559).x , ( ( (VertexPos40_g251559).y * CosAngle89_g251559 ) - ( (VertexPos40_g251559).z * SinAngle93_g251559 ) ) , ( ( (VertexPos40_g251559).y * SinAngle93_g251559 ) + ( (VertexPos40_g251559).z * CosAngle89_g251559 ) )));
					half3 VertexPos40_g251560 = appendResult95_g251559;
					half Angle44_g251560 = -break1582_g251555.x;
					half CosAngle94_g251560 = cos( Angle44_g251560 );
					half SinAngle95_g251560 = sin( Angle44_g251560 );
					float3 appendResult98_g251560 = (float3(( ( (VertexPos40_g251560).x * CosAngle94_g251560 ) - ( (VertexPos40_g251560).y * SinAngle95_g251560 ) ) , ( ( (VertexPos40_g251560).x * SinAngle95_g251560 ) + ( (VertexPos40_g251560).y * CosAngle94_g251560 ) ) , (VertexPos40_g251560).z));
					half3 VertexPos40_g251558 = Vertex_PositionOS147_g251555;
					half Angle44_g251558 = break1582_g251555.y;
					half CosAngle89_g251558 = cos( Angle44_g251558 );
					half SinAngle93_g251558 = sin( Angle44_g251558 );
					float3 appendResult95_g251558 = (float3((VertexPos40_g251558).x , ( ( (VertexPos40_g251558).y * CosAngle89_g251558 ) - ( (VertexPos40_g251558).z * SinAngle93_g251558 ) ) , ( ( (VertexPos40_g251558).y * SinAngle93_g251558 ) + ( (VertexPos40_g251558).z * CosAngle89_g251558 ) )));
					half3 VertexPos40_g251563 = appendResult95_g251558;
					half Angle44_g251563 = break1582_g251555.x;
					half CosAngle91_g251563 = cos( Angle44_g251563 );
					half SinAngle92_g251563 = sin( Angle44_g251563 );
					float3 appendResult93_g251563 = (float3(( ( (VertexPos40_g251563).x * CosAngle91_g251563 ) + ( (VertexPos40_g251563).z * SinAngle92_g251563 ) ) , (VertexPos40_g251563).y , ( ( -(VertexPos40_g251563).x * SinAngle92_g251563 ) + ( (VertexPos40_g251563).z * CosAngle91_g251563 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251561 = appendResult93_g251563;
					#else
					float3 staticSwitch65_g251561 = appendResult98_g251560;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251556 = staticSwitch65_g251561;
					#else
					float3 staticSwitch65_g251556 = Vertex_PositionOS147_g251555;
					#endif
					float3 temp_output_1608_0_g251555 = staticSwitch65_g251556;
					half3 VertexPos40_g251562 = temp_output_1608_0_g251555;
					half Angle44_g251562 = (Vertex_RotationData1569_g251555).z;
					half CosAngle91_g251562 = cos( Angle44_g251562 );
					half SinAngle92_g251562 = sin( Angle44_g251562 );
					float3 appendResult93_g251562 = (float3(( ( (VertexPos40_g251562).x * CosAngle91_g251562 ) + ( (VertexPos40_g251562).z * SinAngle92_g251562 ) ) , (VertexPos40_g251562).y , ( ( -(VertexPos40_g251562).x * SinAngle92_g251562 ) + ( (VertexPos40_g251562).z * CosAngle91_g251562 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251557 = appendResult93_g251562;
					#else
					float3 staticSwitch65_g251557 = temp_output_1608_0_g251555;
					#endif
					float4 temp_output_1615_31_g251555 = Out_TransformData15_g251564;
					half4 Vertex_TransformData1568_g251555 = temp_output_1615_31_g251555;
					half3 Final_PositionOS178_g251555 = ( ( staticSwitch65_g251557 * (Vertex_TransformData1568_g251555).w ) + (Vertex_TransformData1568_g251555).xyz );
					float3 In_PositionOS16_g251565 = Final_PositionOS178_g251555;
					float3 In_NormalOS16_g251565 = Out_NormalOS15_g251564;
					float4 In_TangentOS16_g251565 = Out_TangentOS15_g251564;
					float4 In_TransformData16_g251565 = temp_output_1615_31_g251555;
					float4 In_RotationData16_g251565 = temp_output_1615_33_g251555;
					float4 In_Interpolator16_g251565 = Out_Interpolator15_g251564;
					BuildVertexData( Data16_g251565 , In_Dummy16_g251565 , In_PositionOS16_g251565 , In_NormalOS16_g251565 , In_TangentOS16_g251565 , In_TransformData16_g251565 , In_RotationData16_g251565 , In_Interpolator16_g251565 );
					TVEVertexData Data15_g251568 =(TVEVertexData)Data16_g251565;
					float Out_Dummy15_g251568 = 0.0;
					float3 Out_PositionOS15_g251568 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251568 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251568 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251568 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251568 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251568 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251568 , Out_Dummy15_g251568 , Out_PositionOS15_g251568 , Out_NormalOS15_g251568 , Out_TangentOS15_g251568 , Out_TransformData15_g251568 , Out_RotationData15_g251568 , Out_Interpolator15_g251568 );
					TVEVertexData Data16_g251569 =(TVEVertexData)Data15_g251568;
					float In_Dummy16_g251569 = 0.0;
					TVEModelData Data15_g251567 =(TVEModelData)Data15_g251551;
					float Out_Dummy15_g251567 = 0.0;
					float3 Out_PositionOS15_g251567 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251567 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251567 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251567 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251567 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251567 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251567 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251567 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251567 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251567 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251567 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251567 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251567 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251567 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251567 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251567 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251567 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251567 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251567 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251567 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251567 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251567 , Out_Dummy15_g251567 , Out_PositionOS15_g251567 , Out_PositionWS15_g251567 , Out_PositionWO15_g251567 , Out_PositionRawOS15_g251567 , Out_PivotOS15_g251567 , Out_PivotWS15_g251567 , Out_PivotWO15_g251567 , Out_NormalOS15_g251567 , Out_NormalWS15_g251567 , Out_NormalRawOS15_g251567 , Out_TangentOS15_g251567 , Out_TangentWS15_g251567 , Out_BitangentWS15_g251567 , Out_ViewDirWS15_g251567 , Out_CoordsData15_g251567 , Out_VertexData15_g251567 , Out_MasksData15_g251567 , Out_PhaseData15_g251567 , Out_TransformData15_g251567 , Out_RotationData15_g251567 , Out_Interpolator15_g251567 );
					float3 In_PositionOS16_g251569 = ( Out_PositionOS15_g251568 + Out_PivotOS15_g251567 );
					float3 In_NormalOS16_g251569 = Out_NormalOS15_g251568;
					float4 In_TangentOS16_g251569 = Out_TangentOS15_g251568;
					float4 In_TransformData16_g251569 = Out_TransformData15_g251568;
					float4 In_RotationData16_g251569 = Out_RotationData15_g251568;
					float4 In_Interpolator16_g251569 = Out_Interpolator15_g251568;
					BuildVertexData( Data16_g251569 , In_Dummy16_g251569 , In_PositionOS16_g251569 , In_NormalOS16_g251569 , In_TangentOS16_g251569 , In_TransformData16_g251569 , In_RotationData16_g251569 , In_Interpolator16_g251569 );
					TVEVertexData Data15_g251675 =(TVEVertexData)Data16_g251569;
					float Out_Dummy15_g251675 = 0.0;
					float3 Out_PositionOS15_g251675 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251675 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251675 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251675 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251675 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251675 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251675 , Out_Dummy15_g251675 , Out_PositionOS15_g251675 , Out_NormalOS15_g251675 , Out_TangentOS15_g251675 , Out_TransformData15_g251675 , Out_RotationData15_g251675 , Out_Interpolator15_g251675 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251675;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251675;
					v.tangent = Out_TangentOS15_g251675;

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

					TVEVertexData Data16_g251543 =(TVEVertexData)0;
					float In_Dummy16_g251543 = 0.0;
					TVEVertexData Data16_g251538 =(TVEVertexData)0;
					float In_Dummy16_g251538 = 0.0;
					TVEModelData Data16_g240700 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g240682 = _ObjectCoordMode;
					#else
					float staticSwitch343_g240682 = _ObjectCoordMode;
					#endif
					half Dummy207_g240682 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g240682 );
					float temp_output_14_0_g240700 = Dummy207_g240682;
					float In_Dummy16_g240700 = temp_output_14_0_g240700;
					float3 PositionOS131_g240682 = v.vertex.xyz;
					float3 temp_output_4_0_g240700 = PositionOS131_g240682;
					float3 In_PositionOS16_g240700 = temp_output_4_0_g240700;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g240682 = ase_positionWS;
					float3 vertexToFrag73_g240682 = temp_output_104_7_g240682;
					float3 PositionWS122_g240682 = vertexToFrag73_g240682;
					float3 In_PositionWS16_g240700 = PositionWS122_g240682;
					float4x4 break19_g240685 = unity_ObjectToWorld;
					float3 appendResult20_g240685 = (float3(break19_g240685[ 0 ][ 3 ] , break19_g240685[ 1 ][ 3 ] , break19_g240685[ 2 ][ 3 ]));
					float3 temp_output_340_7_g240682 = appendResult20_g240685;
					float4x4 break19_g240687 = unity_ObjectToWorld;
					float3 appendResult20_g240687 = (float3(break19_g240687[ 0 ][ 3 ] , break19_g240687[ 1 ][ 3 ] , break19_g240687[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g240683 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g240682 = PositionOS131_g240682;
					float3 appendResult234_g240682 = (float3(break233_g240682.x , 0.0 , break233_g240682.z));
					float3 break413_g240682 = PositionOS131_g240682;
					float3 appendResult414_g240682 = (float3(break413_g240682.x , break413_g240682.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g240689 = appendResult414_g240682;
					#else
					float3 staticSwitch65_g240689 = appendResult234_g240682;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g240682 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g240682 = appendResult60_g240683;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g240682 = staticSwitch65_g240689;
					#else
					float3 staticSwitch229_g240682 = _Vector0;
					#endif
					float3 PivotOS149_g240682 = staticSwitch229_g240682;
					float3 temp_output_122_0_g240687 = PivotOS149_g240682;
					float3 PivotsOnlyWS105_g240687 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g240687 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g240682 = ( appendResult20_g240687 + PivotsOnlyWS105_g240687 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g240682 = temp_output_340_7_g240682;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g240682 = temp_output_341_7_g240682;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g240682 = temp_output_341_7_g240682;
					#else
					float3 staticSwitch236_g240682 = temp_output_340_7_g240682;
					#endif
					float3 vertexToFrag76_g240682 = staticSwitch236_g240682;
					float3 PivotWS121_g240682 = vertexToFrag76_g240682;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g240682 = ( PositionWS122_g240682 - PivotWS121_g240682 );
					#else
					float3 staticSwitch204_g240682 = PositionWS122_g240682;
					#endif
					float3 PositionWO132_g240682 = ( staticSwitch204_g240682 - TVE_WorldOrigin );
					float3 In_PositionWO16_g240700 = PositionWO132_g240682;
					float3 In_PivotOS16_g240700 = PivotOS149_g240682;
					float3 In_PivotWS16_g240700 = PivotWS121_g240682;
					float3 PivotWO133_g240682 = ( PivotWS121_g240682 - TVE_WorldOrigin );
					float3 In_PivotWO16_g240700 = PivotWO133_g240682;
					half3 NormalOS134_g240682 = v.normal;
					float3 temp_output_21_0_g240700 = NormalOS134_g240682;
					float3 In_NormalOS16_g240700 = temp_output_21_0_g240700;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g240682 = normalizedWorldNormal;
					float3 In_NormalWS16_g240700 = NormalWS95_g240682;
					half4 TangentlOS153_g240682 = v.tangent;
					float4 temp_output_6_0_g240700 = TangentlOS153_g240682;
					float4 In_TangentOS16_g240700 = temp_output_6_0_g240700;
					float3 normalizeResult296_g240682 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g240682 ) );
					half3 ViewDirWS169_g240682 = normalizeResult296_g240682;
					float3 In_ViewDirWS16_g240700 = ViewDirWS169_g240682;
					float4 appendResult397_g240682 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g240682 = appendResult397_g240682;
					float4 In_CoordsData16_g240700 = CoordsData398_g240682;
					half4 VertexMasks171_g240682 = v.ase_color;
					float4 In_VertexData16_g240700 = VertexMasks171_g240682;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g240694 = (PositionOS131_g240682).z;
					#else
					float staticSwitch65_g240694 = (PositionOS131_g240682).y;
					#endif
					half Object_HeightValue267_g240682 = _ObjectHeightValue;
					half Bounds_HeightMask274_g240682 = saturate( ( staticSwitch65_g240694 / Object_HeightValue267_g240682 ) );
					half3 Position387_g240682 = PositionOS131_g240682;
					half Height387_g240682 = Object_HeightValue267_g240682;
					half Object_RadiusValue268_g240682 = _ObjectRadiusValue;
					half Radius387_g240682 = Object_RadiusValue268_g240682;
					half localCapsuleMaskYUp387_g240682 = CapsuleMaskYUp( Position387_g240682 , Height387_g240682 , Radius387_g240682 );
					half3 Position408_g240682 = PositionOS131_g240682;
					half Height408_g240682 = Object_HeightValue267_g240682;
					half Radius408_g240682 = Object_RadiusValue268_g240682;
					half localCapsuleMaskZUp408_g240682 = CapsuleMaskZUp( Position408_g240682 , Height408_g240682 , Radius408_g240682 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g240699 = saturate( localCapsuleMaskZUp408_g240682 );
					#else
					float staticSwitch65_g240699 = saturate( localCapsuleMaskYUp387_g240682 );
					#endif
					half Bounds_SphereMask282_g240682 = staticSwitch65_g240699;
					float4 appendResult253_g240682 = (float4(Bounds_HeightMask274_g240682 , Bounds_SphereMask282_g240682 , 1.0 , 1.0));
					half4 MasksData254_g240682 = appendResult253_g240682;
					float4 In_MasksData16_g240700 = MasksData254_g240682;
					float temp_output_17_0_g240693 = _ObjectPhaseMode;
					float Option70_g240693 = temp_output_17_0_g240693;
					float4 temp_output_3_0_g240693 = v.ase_color;
					float4 Channel70_g240693 = temp_output_3_0_g240693;
					float localSwitchChannel470_g240693 = SwitchChannel4( Option70_g240693 , Channel70_g240693 );
					half Phase_Value372_g240682 = localSwitchChannel470_g240693;
					float3 break319_g240682 = PivotWO133_g240682;
					half Pivot_Position322_g240682 = ( break319_g240682.x + break319_g240682.z );
					half Phase_Position357_g240682 = ( Phase_Value372_g240682 + Pivot_Position322_g240682 );
					float temp_output_248_0_g240682 = frac( Phase_Position357_g240682 );
					float4 appendResult177_g240682 = (float4((frac( ( Phase_Position357_g240682 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g240682));
					half4 Phase_Data176_g240682 = appendResult177_g240682;
					float4 In_PhaseData16_g240700 = Phase_Data176_g240682;
					BuildModelVertData( Data16_g240700 , In_Dummy16_g240700 , In_PositionOS16_g240700 , In_PositionWS16_g240700 , In_PositionWO16_g240700 , In_PivotOS16_g240700 , In_PivotWS16_g240700 , In_PivotWO16_g240700 , In_NormalOS16_g240700 , In_NormalWS16_g240700 , In_TangentOS16_g240700 , In_ViewDirWS16_g240700 , In_CoordsData16_g240700 , In_VertexData16_g240700 , In_MasksData16_g240700 , In_PhaseData16_g240700 );
					TVEModelData Data15_g251539 =(TVEModelData)Data16_g240700;
					float Out_Dummy15_g251539 = 0.0;
					float3 Out_PositionOS15_g251539 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251539 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251539 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251539 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251539 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251539 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251539 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251539 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251539 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251539 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251539 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251539 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251539 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251539 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251539 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251539 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251539 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251539 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251539 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251539 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251539 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251539 , Out_Dummy15_g251539 , Out_PositionOS15_g251539 , Out_PositionWS15_g251539 , Out_PositionWO15_g251539 , Out_PositionRawOS15_g251539 , Out_PivotOS15_g251539 , Out_PivotWS15_g251539 , Out_PivotWO15_g251539 , Out_NormalOS15_g251539 , Out_NormalWS15_g251539 , Out_NormalRawOS15_g251539 , Out_TangentOS15_g251539 , Out_TangentWS15_g251539 , Out_BitangentWS15_g251539 , Out_ViewDirWS15_g251539 , Out_CoordsData15_g251539 , Out_VertexData15_g251539 , Out_MasksData15_g251539 , Out_PhaseData15_g251539 , Out_TransformData15_g251539 , Out_RotationData15_g251539 , Out_Interpolator15_g251539 );
					float3 In_PositionOS16_g251538 = Out_PositionOS15_g251539;
					float3 In_NormalOS16_g251538 = Out_NormalOS15_g251539;
					float4 In_TangentOS16_g251538 = Out_TangentOS15_g251539;
					float4 In_TransformData16_g251538 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251538 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251538 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251538 , In_Dummy16_g251538 , In_PositionOS16_g251538 , In_NormalOS16_g251538 , In_TangentOS16_g251538 , In_TransformData16_g251538 , In_RotationData16_g251538 , In_Interpolator16_g251538 );
					TVEVertexData Data15_g251541 =(TVEVertexData)Data16_g251538;
					float Out_Dummy15_g251541 = 0.0;
					float3 Out_PositionOS15_g251541 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251541 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251541 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251541 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251541 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251541 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251541 , Out_Dummy15_g251541 , Out_PositionOS15_g251541 , Out_NormalOS15_g251541 , Out_TangentOS15_g251541 , Out_TransformData15_g251541 , Out_RotationData15_g251541 , Out_Interpolator15_g251541 );
					TVEModelData Data15_g251542 =(TVEModelData)Data15_g251539;
					float Out_Dummy15_g251542 = 0.0;
					float3 Out_PositionOS15_g251542 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251542 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251542 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251542 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251542 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251542 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251542 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251542 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251542 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251542 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251542 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251542 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251542 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251542 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251542 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251542 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251542 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251542 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251542 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251542 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251542 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251542 , Out_Dummy15_g251542 , Out_PositionOS15_g251542 , Out_PositionWS15_g251542 , Out_PositionWO15_g251542 , Out_PositionRawOS15_g251542 , Out_PivotOS15_g251542 , Out_PivotWS15_g251542 , Out_PivotWO15_g251542 , Out_NormalOS15_g251542 , Out_NormalWS15_g251542 , Out_NormalRawOS15_g251542 , Out_TangentOS15_g251542 , Out_TangentWS15_g251542 , Out_BitangentWS15_g251542 , Out_ViewDirWS15_g251542 , Out_CoordsData15_g251542 , Out_VertexData15_g251542 , Out_MasksData15_g251542 , Out_PhaseData15_g251542 , Out_TransformData15_g251542 , Out_RotationData15_g251542 , Out_Interpolator15_g251542 );
					float3 In_PositionOS16_g251543 = ( Out_PositionOS15_g251541 - Out_PivotOS15_g251542 );
					float3 In_NormalOS16_g251543 = Out_NormalOS15_g251542;
					float4 In_TangentOS16_g251543 = Out_TangentOS15_g251542;
					float4 In_TransformData16_g251543 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g251543 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g251543 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g251543 , In_Dummy16_g251543 , In_PositionOS16_g251543 , In_NormalOS16_g251543 , In_TangentOS16_g251543 , In_TransformData16_g251543 , In_RotationData16_g251543 , In_Interpolator16_g251543 );
					TVEVertexData Data15_g251552 =(TVEVertexData)Data16_g251543;
					float Out_Dummy15_g251552 = 0.0;
					float3 Out_PositionOS15_g251552 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251552 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251552 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251552 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251552 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251552 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251552 , Out_Dummy15_g251552 , Out_PositionOS15_g251552 , Out_NormalOS15_g251552 , Out_TangentOS15_g251552 , Out_TransformData15_g251552 , Out_RotationData15_g251552 , Out_Interpolator15_g251552 );
					TVEVertexData Data16_g251553 =(TVEVertexData)Data15_g251552;
					half Dummy317_g251544 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251553 = Dummy317_g251544;
					float3 In_PositionOS16_g251553 = Out_PositionOS15_g251552;
					float3 In_NormalOS16_g251553 = Out_NormalOS15_g251552;
					float4 In_TangentOS16_g251553 = Out_TangentOS15_g251552;
					half4 Model_TransformData356_g251544 = Out_TransformData15_g251552;
					float localBuildGlobalData204_g240581 = ( 0.0 );
					TVEGlobalData Data204_g240581 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g240581 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g240581 = Dummy211_g240581;
					float4 temp_output_203_0_g240600 = TVE_CoatBaseCoord;
					TVEModelData Data16_g240690 =(TVEModelData)0;
					float In_Dummy16_g240690 = 0.0;
					float3 In_PositionWS16_g240690 = PositionWS122_g240682;
					float3 In_PositionWO16_g240690 = PositionWO132_g240682;
					float3 In_PivotWS16_g240690 = PivotWS121_g240682;
					float3 In_PivotWO16_g240690 = PivotWO133_g240682;
					float3 In_NormalWS16_g240690 = NormalWS95_g240682;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g240682 = ase_tangentWS;
					float3 In_TangentWS16_g240690 = TangentWS136_g240682;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g240682 = ase_bitangentWS;
					float3 In_BitangentWS16_g240690 = BiangentWS421_g240682;
					half3 NormalWS427_g240682 = NormalWS95_g240682;
					half3 localComputeTriplanarMasks427_g240682 = ComputeTriplanarMasks( NormalWS427_g240682 );
					half3 TriplanarWeights429_g240682 = localComputeTriplanarMasks427_g240682;
					float3 In_TriplanarWeights16_g240690 = TriplanarWeights429_g240682;
					float3 In_ViewDirWS16_g240690 = ViewDirWS169_g240682;
					float4 In_CoordsData16_g240690 = CoordsData398_g240682;
					float4 In_VertexData16_g240690 = VertexMasks171_g240682;
					float4 In_Interpolator16_g240690 = Phase_Data176_g240682;
					BuildModelFragData( Data16_g240690 , In_Dummy16_g240690 , In_PositionWS16_g240690 , In_PositionWO16_g240690 , In_PivotWS16_g240690 , In_PivotWO16_g240690 , In_NormalWS16_g240690 , In_TangentWS16_g240690 , In_BitangentWS16_g240690 , In_TriplanarWeights16_g240690 , In_ViewDirWS16_g240690 , In_CoordsData16_g240690 , In_VertexData16_g240690 , In_Interpolator16_g240690 );
					TVEModelData Data15_g240671 =(TVEModelData)Data16_g240690;
					float Out_Dummy15_g240671 = 0.0;
					float3 Out_PositionWS15_g240671 = float3( 0,0,0 );
					float3 Out_PositionWO15_g240671 = float3( 0,0,0 );
					float3 Out_PivotWS15_g240671 = float3( 0,0,0 );
					float3 Out_PivotWO15_g240671 = float3( 0,0,0 );
					float3 Out_NormalWS15_g240671 = float3( 0,0,0 );
					float3 Out_TangentWS15_g240671 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g240671 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g240671 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g240671 = float3( 0,0,0 );
					float4 Out_CoordsData15_g240671 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g240671 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g240671 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g240671 , Out_Dummy15_g240671 , Out_PositionWS15_g240671 , Out_PositionWO15_g240671 , Out_PivotWS15_g240671 , Out_PivotWO15_g240671 , Out_NormalWS15_g240671 , Out_TangentWS15_g240671 , Out_BitangentWS15_g240671 , Out_TriplanarWeights15_g240671 , Out_ViewDirWS15_g240671 , Out_CoordsData15_g240671 , Out_VertexData15_g240671 , Out_Interpolator15_g240671 );
					float3 Model_PositionWS497_g240581 = Out_PositionWS15_g240671;
					float2 Model_PositionWS_XZ143_g240581 = (Model_PositionWS497_g240581).xz;
					float3 Model_PivotWS498_g240581 = Out_PivotWS15_g240671;
					float2 Model_PivotWS_XZ145_g240581 = (Model_PivotWS498_g240581).xz;
					float2 lerpResult300_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g240600 = lerpResult300_g240581;
					float temp_output_82_0_g240598 = _GlobalCoatLayerValue;
					float temp_output_82_0_g240600 = temp_output_82_0_g240598;
					float4 tex2DArrayNode83_g240600 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240600).zw + ( (temp_output_203_0_g240600).xy * temp_output_81_0_g240600 ) ),temp_output_82_0_g240600), 0.0 );
					float4 appendResult210_g240600 = (float4(tex2DArrayNode83_g240600.rgb , tex2DArrayNode83_g240600.a));
					float4 temp_output_204_0_g240600 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g240600 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240600).zw + ( (temp_output_204_0_g240600).xy * temp_output_81_0_g240600 ) ),temp_output_82_0_g240600), 0.0 );
					float4 appendResult212_g240600 = (float4(tex2DArrayNode122_g240600.rgb , tex2DArrayNode122_g240600.a));
					float4 TVE_RenderNearPositionR628_g240581 = TVE_RenderNearPositionR;
					float temp_output_507_0_g240581 = saturate( ( distance( Model_PositionWS497_g240581 , (TVE_RenderNearPositionR628_g240581).xyz ) / (TVE_RenderNearPositionR628_g240581).w ) );
					float temp_output_7_0_g240670 = 1.0;
					float temp_output_9_0_g240670 = ( temp_output_507_0_g240581 - temp_output_7_0_g240670 );
					half TVE_RenderNearFadeValue635_g240581 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g240581 = saturate( ( temp_output_9_0_g240670 / ( ( TVE_RenderNearFadeValue635_g240581 - temp_output_7_0_g240670 ) + 0.0001 ) ) );
					float4 lerpResult131_g240600 = lerp( appendResult210_g240600 , appendResult212_g240600 , Global_TexBlend509_g240581);
					float4 temp_output_159_109_g240598 = lerpResult131_g240600;
					float4 lerpResult168_g240598 = lerp( TVE_CoatParams , temp_output_159_109_g240598 , TVE_CoatLayers[(int)temp_output_82_0_g240598]);
					float4 temp_output_589_109_g240581 = lerpResult168_g240598;
					half4 Coat_Texture302_g240581 = temp_output_589_109_g240581;
					float4 In_CoatTexture204_g240581 = Coat_Texture302_g240581;
					half4 Draw_Texture656_g240581 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g240581 = Draw_Texture656_g240581;
					float4 temp_output_203_0_g240625 = TVE_PaintBaseCoord;
					float2 lerpResult85_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g240625 = lerpResult85_g240581;
					float temp_output_82_0_g240622 = _GlobalPaintLayerValue;
					float temp_output_82_0_g240625 = temp_output_82_0_g240622;
					float4 tex2DArrayNode83_g240625 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240625).zw + ( (temp_output_203_0_g240625).xy * temp_output_81_0_g240625 ) ),temp_output_82_0_g240625), 0.0 );
					float4 appendResult210_g240625 = (float4(tex2DArrayNode83_g240625.rgb , tex2DArrayNode83_g240625.a));
					float4 temp_output_204_0_g240625 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g240625 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240625).zw + ( (temp_output_204_0_g240625).xy * temp_output_81_0_g240625 ) ),temp_output_82_0_g240625), 0.0 );
					float4 appendResult212_g240625 = (float4(tex2DArrayNode122_g240625.rgb , tex2DArrayNode122_g240625.a));
					float4 lerpResult131_g240625 = lerp( appendResult210_g240625 , appendResult212_g240625 , Global_TexBlend509_g240581);
					float4 temp_output_171_109_g240622 = lerpResult131_g240625;
					float4 lerpResult174_g240622 = lerp( TVE_PaintParams , temp_output_171_109_g240622 , TVE_PaintLayers[(int)temp_output_82_0_g240622]);
					float4 temp_output_595_109_g240581 = lerpResult174_g240622;
					half4 Paint_Texture71_g240581 = temp_output_595_109_g240581;
					float4 In_PaintTexture204_g240581 = Paint_Texture71_g240581;
					float4 temp_output_203_0_g240608 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g240608 = lerpResult104_g240581;
					float temp_output_132_0_g240606 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g240608 = temp_output_132_0_g240606;
					float4 tex2DArrayNode83_g240608 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240608).zw + ( (temp_output_203_0_g240608).xy * temp_output_81_0_g240608 ) ),temp_output_82_0_g240608), 0.0 );
					float4 appendResult210_g240608 = (float4(tex2DArrayNode83_g240608.rgb , tex2DArrayNode83_g240608.a));
					float4 temp_output_204_0_g240608 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g240608 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240608).zw + ( (temp_output_204_0_g240608).xy * temp_output_81_0_g240608 ) ),temp_output_82_0_g240608), 0.0 );
					float4 appendResult212_g240608 = (float4(tex2DArrayNode122_g240608.rgb , tex2DArrayNode122_g240608.a));
					float4 lerpResult131_g240608 = lerp( appendResult210_g240608 , appendResult212_g240608 , Global_TexBlend509_g240581);
					float4 temp_output_137_109_g240606 = lerpResult131_g240608;
					float4 lerpResult145_g240606 = lerp( TVE_AtmoParams , temp_output_137_109_g240606 , TVE_AtmoLayers[(int)temp_output_132_0_g240606]);
					float4 temp_output_590_110_g240581 = lerpResult145_g240606;
					half4 Atmo_Texture80_g240581 = temp_output_590_110_g240581;
					float4 In_AtmoTexture204_g240581 = Atmo_Texture80_g240581;
					float4 temp_output_203_0_g240676 = TVE_EffexBaseCoord;
					float2 lerpResult414_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g240676 = lerpResult414_g240581;
					float temp_output_132_0_g240674 = _GlobalEffexLayerValue;
					float temp_output_82_0_g240676 = temp_output_132_0_g240674;
					float4 tex2DArrayNode83_g240676 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240676).zw + ( (temp_output_203_0_g240676).xy * temp_output_81_0_g240676 ) ),temp_output_82_0_g240676), 0.0 );
					float4 appendResult210_g240676 = (float4(tex2DArrayNode83_g240676.rgb , tex2DArrayNode83_g240676.a));
					float4 temp_output_204_0_g240676 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g240676 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240676).zw + ( (temp_output_204_0_g240676).xy * temp_output_81_0_g240676 ) ),temp_output_82_0_g240676), 0.0 );
					float4 appendResult212_g240676 = (float4(tex2DArrayNode122_g240676.rgb , tex2DArrayNode122_g240676.a));
					float4 lerpResult131_g240676 = lerp( appendResult210_g240676 , appendResult212_g240676 , Global_TexBlend509_g240581);
					float4 temp_output_137_109_g240674 = lerpResult131_g240676;
					float4 lerpResult145_g240674 = lerp( TVE_EffexParams , temp_output_137_109_g240674 , TVE_EffexLayers[(int)temp_output_132_0_g240674]);
					float4 temp_output_731_110_g240581 = lerpResult145_g240674;
					half4 Effex_Texture420_g240581 = temp_output_731_110_g240581;
					float4 In_EffexTexture204_g240581 = Effex_Texture420_g240581;
					float4 temp_output_203_0_g240656 = TVE_GlowBaseCoord;
					float2 lerpResult247_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g240656 = lerpResult247_g240581;
					float temp_output_82_0_g240654 = _GlobalGlowLayerValue;
					float temp_output_82_0_g240656 = temp_output_82_0_g240654;
					float4 tex2DArrayNode83_g240656 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240656).zw + ( (temp_output_203_0_g240656).xy * temp_output_81_0_g240656 ) ),temp_output_82_0_g240656), 0.0 );
					float4 appendResult210_g240656 = (float4(tex2DArrayNode83_g240656.rgb , tex2DArrayNode83_g240656.a));
					float4 temp_output_204_0_g240656 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g240656 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240656).zw + ( (temp_output_204_0_g240656).xy * temp_output_81_0_g240656 ) ),temp_output_82_0_g240656), 0.0 );
					float4 appendResult212_g240656 = (float4(tex2DArrayNode122_g240656.rgb , tex2DArrayNode122_g240656.a));
					float4 lerpResult131_g240656 = lerp( appendResult210_g240656 , appendResult212_g240656 , Global_TexBlend509_g240581);
					float4 temp_output_159_109_g240654 = lerpResult131_g240656;
					float4 lerpResult167_g240654 = lerp( TVE_GlowParams , temp_output_159_109_g240654 , TVE_GlowLayers[(int)temp_output_82_0_g240654]);
					float4 temp_output_593_109_g240581 = lerpResult167_g240654;
					half4 Glow_Texture248_g240581 = temp_output_593_109_g240581;
					float4 In_GlowTexture204_g240581 = Glow_Texture248_g240581;
					float4 temp_output_203_0_g240592 = TVE_FormBaseCoord;
					float2 lerpResult168_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g240592 = lerpResult168_g240581;
					float temp_output_130_0_g240590 = _GlobalFormLayerValue;
					float temp_output_82_0_g240592 = temp_output_130_0_g240590;
					float4 tex2DArrayNode83_g240592 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240592).zw + ( (temp_output_203_0_g240592).xy * temp_output_81_0_g240592 ) ),temp_output_82_0_g240592), 0.0 );
					float4 appendResult210_g240592 = (float4(tex2DArrayNode83_g240592.rgb , tex2DArrayNode83_g240592.a));
					float4 temp_output_204_0_g240592 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g240592 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240592).zw + ( (temp_output_204_0_g240592).xy * temp_output_81_0_g240592 ) ),temp_output_82_0_g240592), 0.0 );
					float4 appendResult212_g240592 = (float4(tex2DArrayNode122_g240592.rgb , tex2DArrayNode122_g240592.a));
					float4 lerpResult131_g240592 = lerp( appendResult210_g240592 , appendResult212_g240592 , Global_TexBlend509_g240581);
					float4 temp_output_135_109_g240590 = lerpResult131_g240592;
					float4 lerpResult143_g240590 = lerp( TVE_FormParams , temp_output_135_109_g240590 , TVE_FormLayers[(int)temp_output_130_0_g240590]);
					float4 temp_output_592_0_g240581 = lerpResult143_g240590;
					float4 Form_Texture112_g240581 = temp_output_592_0_g240581;
					float4 In_FormTexture204_g240581 = Form_Texture112_g240581;
					float4 In_LandTexture204_g240581 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g240640 = TVE_VertxBaseCoord;
					float2 lerpResult681_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g240640 = lerpResult681_g240581;
					float temp_output_136_0_g240638 = _GlobalVertxLayerValue;
					float temp_output_82_0_g240640 = temp_output_136_0_g240638;
					float4 tex2DArrayNode83_g240640 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240640).zw + ( (temp_output_203_0_g240640).xy * temp_output_81_0_g240640 ) ),temp_output_82_0_g240640), 0.0 );
					float4 appendResult210_g240640 = (float4(tex2DArrayNode83_g240640.rgb , tex2DArrayNode83_g240640.a));
					float4 temp_output_204_0_g240640 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g240640 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240640).zw + ( (temp_output_204_0_g240640).xy * temp_output_81_0_g240640 ) ),temp_output_82_0_g240640), 0.0 );
					float4 appendResult212_g240640 = (float4(tex2DArrayNode122_g240640.rgb , tex2DArrayNode122_g240640.a));
					float4 lerpResult131_g240640 = lerp( appendResult210_g240640 , appendResult212_g240640 , Global_TexBlend509_g240581);
					float4 temp_output_141_109_g240638 = lerpResult131_g240640;
					float4 lerpResult149_g240638 = lerp( TVE_VertxParams , temp_output_141_109_g240638 , TVE_VertxLayers[(int)temp_output_136_0_g240638]);
					float4 temp_output_695_0_g240581 = lerpResult149_g240638;
					half4 Vertx_Texture693_g240581 = temp_output_695_0_g240581;
					float4 In_VertxTexture204_g240581 = Vertx_Texture693_g240581;
					float4 temp_output_203_0_g240616 = TVE_FlowBaseCoord;
					float2 lerpResult400_g240581 = lerp( Model_PositionWS_XZ143_g240581 , Model_PivotWS_XZ145_g240581 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g240616 = lerpResult400_g240581;
					float temp_output_136_0_g240614 = _GlobalFlowLayerValue;
					float temp_output_82_0_g240616 = temp_output_136_0_g240614;
					float4 tex2DArrayNode83_g240616 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g240616).zw + ( (temp_output_203_0_g240616).xy * temp_output_81_0_g240616 ) ),temp_output_82_0_g240616), 0.0 );
					float4 appendResult210_g240616 = (float4(tex2DArrayNode83_g240616.rgb , tex2DArrayNode83_g240616.a));
					float4 temp_output_204_0_g240616 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g240616 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g240616).zw + ( (temp_output_204_0_g240616).xy * temp_output_81_0_g240616 ) ),temp_output_82_0_g240616), 0.0 );
					float4 appendResult212_g240616 = (float4(tex2DArrayNode122_g240616.rgb , tex2DArrayNode122_g240616.a));
					float4 lerpResult131_g240616 = lerp( appendResult210_g240616 , appendResult212_g240616 , Global_TexBlend509_g240581);
					float4 temp_output_141_109_g240614 = lerpResult131_g240616;
					float4 lerpResult149_g240614 = lerp( TVE_FlowParams , temp_output_141_109_g240614 , TVE_FlowLayers[(int)temp_output_136_0_g240614]);
					float4 temp_output_594_0_g240581 = lerpResult149_g240614;
					half4 Flow_Texture405_g240581 = temp_output_594_0_g240581;
					float4 In_FlowTexture204_g240581 = Flow_Texture405_g240581;
					half4 User_Texture677_g240581 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g240581 = User_Texture677_g240581;
					BuildGlobalData( Data204_g240581 , In_Dummy204_g240581 , In_CoatTexture204_g240581 , In_DrawTexture204_g240581 , In_PaintTexture204_g240581 , In_AtmoTexture204_g240581 , In_EffexTexture204_g240581 , In_GlowTexture204_g240581 , In_FormTexture204_g240581 , In_LandTexture204_g240581 , In_VertxTexture204_g240581 , In_FlowTexture204_g240581 , In_UserTexture204_g240581 );
					TVEGlobalData Data15_g251554 =(TVEGlobalData)Data204_g240581;
					float Out_Dummy15_g251554 = 0.0;
					float4 Out_CoatTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251554 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251554 = float4( 0,0,0,0 );
					BreakData( Data15_g251554 , Out_Dummy15_g251554 , Out_CoatTexture15_g251554 , Out_DrawTexture15_g251554 , Out_PaintTexture15_g251554 , Out_AtmoTexture15_g251554 , Out_EffexTexture15_g251554 , Out_GlowTexture15_g251554 , Out_FormTexture15_g251554 , Out_LandTexture15_g251554 , Out_VertxTexture15_g251554 , Out_FlowTexture15_g251554 , Out_UserTexture15_g251554 );
					float4 Global_FormTexture351_g251544 = Out_FormTexture15_g251554;
					TVEModelData Data15_g251551 =(TVEModelData)Data15_g251542;
					float Out_Dummy15_g251551 = 0.0;
					float3 Out_PositionOS15_g251551 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251551 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251551 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251551 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251551 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251551 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251551 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251551 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251551 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251551 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251551 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251551 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251551 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251551 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251551 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251551 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251551 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251551 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251551 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251551 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251551 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251551 , Out_Dummy15_g251551 , Out_PositionOS15_g251551 , Out_PositionWS15_g251551 , Out_PositionWO15_g251551 , Out_PositionRawOS15_g251551 , Out_PivotOS15_g251551 , Out_PivotWS15_g251551 , Out_PivotWO15_g251551 , Out_NormalOS15_g251551 , Out_NormalWS15_g251551 , Out_NormalRawOS15_g251551 , Out_TangentOS15_g251551 , Out_TangentWS15_g251551 , Out_BitangentWS15_g251551 , Out_ViewDirWS15_g251551 , Out_CoordsData15_g251551 , Out_VertexData15_g251551 , Out_MasksData15_g251551 , Out_PhaseData15_g251551 , Out_TransformData15_g251551 , Out_RotationData15_g251551 , Out_Interpolator15_g251551 );
					float3 Model_PivotWO353_g251544 = Out_PivotWO15_g251551;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251550 = _ConformMeshMode;
					float Option70_g251550 = temp_output_17_0_g251550;
					half4 Model_VertexData357_g251544 = Out_VertexData15_g251551;
					float4 temp_output_3_0_g251550 = Model_VertexData357_g251544;
					float4 Channel70_g251550 = temp_output_3_0_g251550;
					float localSwitchChannel470_g251550 = SwitchChannel4( Option70_g251550 , Channel70_g251550 );
					float temp_output_390_0_g251544 = localSwitchChannel470_g251550;
					float temp_output_7_0_g251547 = _ConformMeshRemap.x;
					float temp_output_9_0_g251547 = ( temp_output_390_0_g251544 - temp_output_7_0_g251547 );
					float lerpResult374_g251544 = lerp( 1.0 , saturate( ( temp_output_9_0_g251547 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251544 = lerpResult374_g251544;
					float temp_output_328_0_g251544 = ( Blend_VertMask379_g251544 * TVE_IsEnabled );
					half Conform_Mask366_g251544 = temp_output_328_0_g251544;
					float temp_output_322_0_g251544 = ( ( ( ( (Global_FormTexture351_g251544).z - ( (Model_PivotWO353_g251544).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251544 ) );
					float3 appendResult329_g251544 = (float3(0.0 , temp_output_322_0_g251544 , 0.0));
					float3 appendResult387_g251544 = (float3(0.0 , 0.0 , temp_output_322_0_g251544));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251548 = appendResult387_g251544;
					#else
					float3 staticSwitch65_g251548 = appendResult329_g251544;
					#endif
					float3 Blanket_Conform368_g251544 = staticSwitch65_g251548;
					float4 appendResult312_g251544 = (float4(Blanket_Conform368_g251544 , 0.0));
					float4 temp_output_310_0_g251544 = ( Model_TransformData356_g251544 + appendResult312_g251544 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251544 = temp_output_310_0_g251544;
					#else
					float4 staticSwitch364_g251544 = Model_TransformData356_g251544;
					#endif
					half4 Final_TransformData365_g251544 = staticSwitch364_g251544;
					float4 In_TransformData16_g251553 = Final_TransformData365_g251544;
					float4 In_RotationData16_g251553 = Out_RotationData15_g251552;
					float4 In_Interpolator16_g251553 = Out_Interpolator15_g251552;
					BuildVertexData( Data16_g251553 , In_Dummy16_g251553 , In_PositionOS16_g251553 , In_NormalOS16_g251553 , In_TangentOS16_g251553 , In_TransformData16_g251553 , In_RotationData16_g251553 , In_Interpolator16_g251553 );
					TVEVertexData Data15_g251564 =(TVEVertexData)Data16_g251553;
					float Out_Dummy15_g251564 = 0.0;
					float3 Out_PositionOS15_g251564 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251564 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251564 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251564 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251564 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251564 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251564 , Out_Dummy15_g251564 , Out_PositionOS15_g251564 , Out_NormalOS15_g251564 , Out_TangentOS15_g251564 , Out_TransformData15_g251564 , Out_RotationData15_g251564 , Out_Interpolator15_g251564 );
					TVEVertexData Data16_g251565 =(TVEVertexData)Data15_g251564;
					float In_Dummy16_g251565 = 0.0;
					float3 Vertex_PositionOS147_g251555 = Out_PositionOS15_g251564;
					half3 VertexPos40_g251559 = Vertex_PositionOS147_g251555;
					float4 temp_output_1615_33_g251555 = Out_RotationData15_g251564;
					half4 Vertex_RotationData1569_g251555 = temp_output_1615_33_g251555;
					float2 break1582_g251555 = (Vertex_RotationData1569_g251555).xy;
					half Angle44_g251559 = break1582_g251555.y;
					half CosAngle89_g251559 = cos( Angle44_g251559 );
					half SinAngle93_g251559 = sin( Angle44_g251559 );
					float3 appendResult95_g251559 = (float3((VertexPos40_g251559).x , ( ( (VertexPos40_g251559).y * CosAngle89_g251559 ) - ( (VertexPos40_g251559).z * SinAngle93_g251559 ) ) , ( ( (VertexPos40_g251559).y * SinAngle93_g251559 ) + ( (VertexPos40_g251559).z * CosAngle89_g251559 ) )));
					half3 VertexPos40_g251560 = appendResult95_g251559;
					half Angle44_g251560 = -break1582_g251555.x;
					half CosAngle94_g251560 = cos( Angle44_g251560 );
					half SinAngle95_g251560 = sin( Angle44_g251560 );
					float3 appendResult98_g251560 = (float3(( ( (VertexPos40_g251560).x * CosAngle94_g251560 ) - ( (VertexPos40_g251560).y * SinAngle95_g251560 ) ) , ( ( (VertexPos40_g251560).x * SinAngle95_g251560 ) + ( (VertexPos40_g251560).y * CosAngle94_g251560 ) ) , (VertexPos40_g251560).z));
					half3 VertexPos40_g251558 = Vertex_PositionOS147_g251555;
					half Angle44_g251558 = break1582_g251555.y;
					half CosAngle89_g251558 = cos( Angle44_g251558 );
					half SinAngle93_g251558 = sin( Angle44_g251558 );
					float3 appendResult95_g251558 = (float3((VertexPos40_g251558).x , ( ( (VertexPos40_g251558).y * CosAngle89_g251558 ) - ( (VertexPos40_g251558).z * SinAngle93_g251558 ) ) , ( ( (VertexPos40_g251558).y * SinAngle93_g251558 ) + ( (VertexPos40_g251558).z * CosAngle89_g251558 ) )));
					half3 VertexPos40_g251563 = appendResult95_g251558;
					half Angle44_g251563 = break1582_g251555.x;
					half CosAngle91_g251563 = cos( Angle44_g251563 );
					half SinAngle92_g251563 = sin( Angle44_g251563 );
					float3 appendResult93_g251563 = (float3(( ( (VertexPos40_g251563).x * CosAngle91_g251563 ) + ( (VertexPos40_g251563).z * SinAngle92_g251563 ) ) , (VertexPos40_g251563).y , ( ( -(VertexPos40_g251563).x * SinAngle92_g251563 ) + ( (VertexPos40_g251563).z * CosAngle91_g251563 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251561 = appendResult93_g251563;
					#else
					float3 staticSwitch65_g251561 = appendResult98_g251560;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251556 = staticSwitch65_g251561;
					#else
					float3 staticSwitch65_g251556 = Vertex_PositionOS147_g251555;
					#endif
					float3 temp_output_1608_0_g251555 = staticSwitch65_g251556;
					half3 VertexPos40_g251562 = temp_output_1608_0_g251555;
					half Angle44_g251562 = (Vertex_RotationData1569_g251555).z;
					half CosAngle91_g251562 = cos( Angle44_g251562 );
					half SinAngle92_g251562 = sin( Angle44_g251562 );
					float3 appendResult93_g251562 = (float3(( ( (VertexPos40_g251562).x * CosAngle91_g251562 ) + ( (VertexPos40_g251562).z * SinAngle92_g251562 ) ) , (VertexPos40_g251562).y , ( ( -(VertexPos40_g251562).x * SinAngle92_g251562 ) + ( (VertexPos40_g251562).z * CosAngle91_g251562 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251557 = appendResult93_g251562;
					#else
					float3 staticSwitch65_g251557 = temp_output_1608_0_g251555;
					#endif
					float4 temp_output_1615_31_g251555 = Out_TransformData15_g251564;
					half4 Vertex_TransformData1568_g251555 = temp_output_1615_31_g251555;
					half3 Final_PositionOS178_g251555 = ( ( staticSwitch65_g251557 * (Vertex_TransformData1568_g251555).w ) + (Vertex_TransformData1568_g251555).xyz );
					float3 In_PositionOS16_g251565 = Final_PositionOS178_g251555;
					float3 In_NormalOS16_g251565 = Out_NormalOS15_g251564;
					float4 In_TangentOS16_g251565 = Out_TangentOS15_g251564;
					float4 In_TransformData16_g251565 = temp_output_1615_31_g251555;
					float4 In_RotationData16_g251565 = temp_output_1615_33_g251555;
					float4 In_Interpolator16_g251565 = Out_Interpolator15_g251564;
					BuildVertexData( Data16_g251565 , In_Dummy16_g251565 , In_PositionOS16_g251565 , In_NormalOS16_g251565 , In_TangentOS16_g251565 , In_TransformData16_g251565 , In_RotationData16_g251565 , In_Interpolator16_g251565 );
					TVEVertexData Data15_g251568 =(TVEVertexData)Data16_g251565;
					float Out_Dummy15_g251568 = 0.0;
					float3 Out_PositionOS15_g251568 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251568 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251568 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251568 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251568 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251568 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251568 , Out_Dummy15_g251568 , Out_PositionOS15_g251568 , Out_NormalOS15_g251568 , Out_TangentOS15_g251568 , Out_TransformData15_g251568 , Out_RotationData15_g251568 , Out_Interpolator15_g251568 );
					TVEVertexData Data16_g251569 =(TVEVertexData)Data15_g251568;
					float In_Dummy16_g251569 = 0.0;
					TVEModelData Data15_g251567 =(TVEModelData)Data15_g251551;
					float Out_Dummy15_g251567 = 0.0;
					float3 Out_PositionOS15_g251567 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251567 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251567 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251567 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251567 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251567 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251567 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251567 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251567 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251567 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251567 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251567 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251567 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251567 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251567 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251567 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251567 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251567 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251567 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251567 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251567 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251567 , Out_Dummy15_g251567 , Out_PositionOS15_g251567 , Out_PositionWS15_g251567 , Out_PositionWO15_g251567 , Out_PositionRawOS15_g251567 , Out_PivotOS15_g251567 , Out_PivotWS15_g251567 , Out_PivotWO15_g251567 , Out_NormalOS15_g251567 , Out_NormalWS15_g251567 , Out_NormalRawOS15_g251567 , Out_TangentOS15_g251567 , Out_TangentWS15_g251567 , Out_BitangentWS15_g251567 , Out_ViewDirWS15_g251567 , Out_CoordsData15_g251567 , Out_VertexData15_g251567 , Out_MasksData15_g251567 , Out_PhaseData15_g251567 , Out_TransformData15_g251567 , Out_RotationData15_g251567 , Out_Interpolator15_g251567 );
					float3 In_PositionOS16_g251569 = ( Out_PositionOS15_g251568 + Out_PivotOS15_g251567 );
					float3 In_NormalOS16_g251569 = Out_NormalOS15_g251568;
					float4 In_TangentOS16_g251569 = Out_TangentOS15_g251568;
					float4 In_TransformData16_g251569 = Out_TransformData15_g251568;
					float4 In_RotationData16_g251569 = Out_RotationData15_g251568;
					float4 In_Interpolator16_g251569 = Out_Interpolator15_g251568;
					BuildVertexData( Data16_g251569 , In_Dummy16_g251569 , In_PositionOS16_g251569 , In_NormalOS16_g251569 , In_TangentOS16_g251569 , In_TransformData16_g251569 , In_RotationData16_g251569 , In_Interpolator16_g251569 );
					TVEVertexData Data15_g251675 =(TVEVertexData)Data16_g251569;
					float Out_Dummy15_g251675 = 0.0;
					float3 Out_PositionOS15_g251675 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251675 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251675 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251675 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251675 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251675 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251675 , Out_Dummy15_g251675 , Out_PositionOS15_g251675 , Out_NormalOS15_g251675 , Out_TangentOS15_g251675 , Out_TransformData15_g251675 , Out_RotationData15_g251675 , Out_Interpolator15_g251675 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251675;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251675;
					v.tangent = Out_TangentOS15_g251675;

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
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2374,"pos":[-6592,-5696],"params":["Half","False","Model Frag","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2420,"pos":[-6144,-5760],"params":["Inherit","False","2374","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2421,"pos":[-5888,-5760],"params":["Inherit","False","Block Global","47","","240581","212e17d4006dc88449d56ce0340cb5ff","46,385,1,692,1,667,1,276,1,396,1,417,1,282,1,402,1,560,1,285,1,283,1,308,1,650,1,483,0,484,0,486,0,488,0,561,0,487,0,652,0,482,0,485,0,668,0,691,0,315,1,703,1,719,1,716,1,715,1,709,1,710,1,706,1,701,1,704,1,707,1,655,0,311,1,317,1,421,1,321,1,398,1,700,0,694,1,713,1,404,1,675,0","1","206","OBJECT","0,0,0,0","False","1","OBJECT","151"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2373,"pos":[-6912,-5760],"params":["Inherit","False","Block Model","7","","240682","7ad7765e793a6714babedee0033c36e9","19,463,1,289,1,240,1,437,1,291,1,431,1,404,1,290,1,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0","11","102","FLOAT3","0,0,0","False","163","FLOAT3","0,0,0","False","186","FLOAT3","0,0,0","False","187","FLOAT3","0,0,0","False","166","FLOAT3","0,0,0","False","164","FLOAT3","0,0,0","False","301","FLOAT3","0,0,0","False","418","FLOAT3","0,0,0","False","167","FLOAT4","0,0,0,0","False","172","FLOAT4","0,0,0,0","False","175","FLOAT4","0,0,0,0","False","2","OBJECT","128","OBJECT","314"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2422,"pos":[-5568,-5760],"params":["Half","False","Global Data","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2379,"pos":[-6592,-5760],"params":["Half","False","Model Vert","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2437,"pos":[-5120,-5760],"params":["Inherit","False","2379","Model Vert","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2438,"pos":[-5120,-5696],"params":["Inherit","False","2422","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2436,"pos":[-4864,-5760],"params":["Inherit","False","Block Vertex","-1","","251537","79888a886ac7456468e9ffe3eda11f4f","0","2","1894","OBJECT","0,0,0,0","False","1896","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","1895","OBJECT","1897"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2424,"pos":[-4480,-5760],"params":["Inherit","False","Block Pivots Sub","-1","","251540","186f08b1bbe15894d9c677d50398679b","0","3","224","OBJECT","0,0,0,0","False","146","OBJECT","0,0,0,0","False","231","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","229","OBJECT","232"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2426,"pos":[-4096,-5760],"params":["Inherit","False","Block Blanket Conform","126","","251544","3ce1684c4351aeb42b79a955aa483301","2,389,0,377,1","3","146","OBJECT","0,0,0,0","False","397","OBJECT","0,0,0,0","False","186","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","398","OBJECT","399"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2427,"pos":[-3712,-5760],"params":["Inherit","False","Block Transform","-1","","251555","5ac6202bdddd8b34a85c261af6b8de8b","0","3","146","OBJECT","0,0,0,0","False","1620","OBJECT","0,0,0,0","False","1619","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","1617","OBJECT","1618"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2428,"pos":[-3328,-5760],"params":["Inherit","False","Block Pivots Add","-1","","251566","016babe9e3e643242aa4d123a988150c","0","3","146","OBJECT","0,0,0,0","False","225","OBJECT","0,0,0,0","False","227","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","226","OBJECT","228"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":2401,"pos":[-256,-6016],"params":["Inherit","False","Property","_IsLightingType","_IsLightingType","46","0","Create","True","0","0","0","False","0","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2429,"pos":[-3008,-5760],"params":["Half","False","Vertex Data","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2402,"pos":[0,-6016],"params":["Half","False","IsLightingType","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.ColorNode, AmplifyShaderEditor","id":2395,"pos":[-256,-5760],"params":["Inherit","False","Constant","_Color13","Color 0","10","0","Create","True","0","0","0","False","0","False","Object","-1","","0.6196079,0.7686275,0.1490196,0","0,0,0,0","True","True","0","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.ColorNode, AmplifyShaderEditor","id":2398,"pos":[-256,-5504],"params":["Inherit","False","Constant","_Color14","Color 10","10","0","Create","True","0","0","0","False","0","False","Object","-1","","0.3254902,0.6117647,0.8117647,0","0,0,0,0","True","True","0","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2407,"pos":[0,-5632],"params":["Inherit","False","2402","IsLightingType","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2409,"pos":[0,-5376],"params":["Inherit","False","2402","IsLightingType","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.ColorNode, AmplifyShaderEditor","id":2391,"pos":[-256,-5248],"params":["Inherit","False","Constant","_Color20","Color 4","10","0","Create","True","0","0","0","False","0","False","Object","-1","","0.654902,0.3411765,0.8509804,0","0,0,0,0","True","True","0","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2410,"pos":[0,-5120],"params":["Inherit","False","2402","IsLightingType","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2413,"pos":[0,-4864],"params":["Inherit","False","2402","IsLightingType","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.ColorNode, AmplifyShaderEditor","id":2412,"pos":[-256,-4992],"params":["Inherit","False","Constant","_Color21","Color 4","10","0","Create","True","0","0","0","False","0","False","Object","-1","","0.972549,0.8862745,0.1803922,0","0,0,0,0","True","True","0","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2439,"pos":[-2560,-5632],"params":["Inherit","False","2422","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2440,"pos":[-2560,-5696],"params":["Inherit","False","2374","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2442,"pos":[-2560,-5760],"params":["Inherit","False","2429","Vertex Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2406,"pos":[256,-5760],"params":["Inherit","False","Tool Branch","-1","","251570","d4048633f69bd3f44beb2beef049f6d2","0","3","39","FLOAT3","0,0,0","False","34","FLOAT","0","False","36","FLOAT","1","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2408,"pos":[256,-5504],"params":["Inherit","False","Tool Branch","-1","","251571","d4048633f69bd3f44beb2beef049f6d2","0","3","39","FLOAT3","0,0,0","False","34","FLOAT","0","False","36","FLOAT","2","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2411,"pos":[256,-5248],"params":["Inherit","False","Tool Branch","-1","","251572","d4048633f69bd3f44beb2beef049f6d2","0","3","39","FLOAT3","0,0,0","False","34","FLOAT","0","False","36","FLOAT","3","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2414,"pos":[256,-4992],"params":["Inherit","False","Tool Branch","-1","","251573","d4048633f69bd3f44beb2beef049f6d2","0","3","39","FLOAT3","0,0,0","False","34","FLOAT","0","False","36","FLOAT","4","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2441,"pos":[-2304,-5760],"params":["Inherit","False","Block Visual","-1","","251624","9511980f05dcfdf4d8967cd55c0d1784","1,1910,1","3","1904","OBJECT","0,0,0,0","False","1894","OBJECT","0,0,0,0","False","1896","OBJECT","0,0,0,0","False","3","OBJECT","1900","OBJECT","1895","OBJECT","1897"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2400,"pos":[768,-5760],"params":["Inherit","False","4","4","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","3","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2376,"pos":[-1920,-5760],"params":["Inherit","False","Block Main","20","","251628","b04cfed9a7b4c0841afdb49a38c282c5","13,65,1,136,1,41,1,133,1,40,1,344,0,347,0,342,0,346,0,343,0,345,0,329,1,408,1","3","430","OBJECT","0,0,0,0","False","225","OBJECT","0,0,0,0","False","414","OBJECT","0,0,0,0","False","3","OBJECT","106","OBJECT","417","OBJECT","415"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2386,"pos":[960,-5760],"params":["Half","False","Final_Debug","-1","True","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2416,"pos":[-1600,-5760],"params":["Half","False","Visual Data","-1","True","1","0","OBJECT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2380,"pos":[2304,-5760],"params":["Inherit","False","2386","Final_Debug","1","0","OBJECT","","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2381,"pos":[2304,-5696],"params":["Inherit","False","2416","Visual Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2417,"pos":[2304,-5632],"params":["Inherit","False","2429","Vertex Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.ConditionalIfNode, AmplifyShaderEditor","id":1774,"pos":[-880,2944],"params":["Inherit","False","True","5","0","FLOAT","0","False","1","FLOAT","1","False","2","FLOAT","0","False","3","FLOAT","0","False","4","COLOR","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TFHCRemapNode, AmplifyShaderEditor","id":1803,"pos":[-1344,2944],"params":["Inherit","False","5","0","FLOAT","0","False","1","FLOAT","-1","False","2","FLOAT","1","False","3","FLOAT","0.3","False","4","FLOAT","0.7","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":1772,"pos":[-1088,3072],"params":["Float","False","Constant","_Float3","Float 3","31","0","Create","True","0","0","0","False","0","False","Object","-1","","24","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleTimeNode, AmplifyShaderEditor","id":1843,"pos":[-1632,2944],"params":["Inherit","False","1","0","FLOAT","1","False","5","FLOAT","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":1771,"pos":[-1088,2944],"params":["Inherit","False","-1","","1","0","OBJECT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SinOpNode, AmplifyShaderEditor","id":1800,"pos":[-1472,2944],"params":["Inherit","False","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":1804,"pos":[-1792,2944],"params":["Inherit","False","Constant","_Float1","Float 1","0","0","Create","True","0","0","0","False","0","False","Object","-1","","3","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2419,"pos":[2560,-5760],"params":["Inherit","False","Tool Debug Color","0","","251667","d992d3ed4a7539141ba053d3e0c12277","0","3","80","FLOAT3","0,0,0","False","106","OBJECT","0,0,0","False","107","OBJECT","0,0,0","False","5","FLOAT","114","FLOAT3","0","FLOAT3","113","FLOAT3","148","FLOAT4","149"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2383,"pos":[2944,-5888],"params":["Inherit","False","Base Compile","-1","","251676","e67c8238031dbf04ab79a5d4d63d1b4f","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2355,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","15","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ForwardAdd","0","2","ForwardAdd","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","4","1","False","","1","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","","False","False","False","True","1","LightMode=ForwardAdd","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2356,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","15","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","Deferred","0","3","Deferred","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=Deferred","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2357,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","15","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","Meta","0","4","Meta","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=Meta","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2358,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","15","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ShadowCaster","0","5","ShadowCaster","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","True","3","False","","False","False","True","1","LightMode=ShadowCaster","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2353,"pos":[2528,-5760],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","15","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ExtraPrePass","0","0","ExtraPrePass","5","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2354,"pos":[2944,-5760],"params":["Float","False","True","-1","3","","0","3","Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Lighting","28cd5599e02859647ae1798e4fcaef6c","True","ForwardBase","0","1","ForwardBase","15","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","2","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=True=DisableBatching","True","5","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","40","Category","0","0","Workflow","1","0","Surface","0","0","  Blend","0","0","  Dither Shadows","1","0","Two Sided","0","638874603607655403","Deferred Pass","1","0","Normal Space","0","0","Transmission","0","0","  Transmission Shadow","0.5,False,","0","Translucency","0","0","  Translucency Strength","1,False,","0","  Normal Distortion","0.5,False,","0","  Scattering","2,False,","0","  Direct","0.9,False,","0","  Ambient","0.1,False,","0","  Shadow","0.5,False,","0","Cast Shadows","0","638814711411603618","Receive Shadows","0","638814711415148256","Receive Specular","0","638814711419031593","GPU Instancing","1","638874615298469630","LOD CrossFade","0","638814711429956434","Built-in Fog","0","638814711441065168","Ambient Light","0","638814711449050123","Meta Pass","0","638814711456998358","Add Pass","0","638814711466594157","Override Baked GI","0","0","Write Depth","0","0","Extra Pre Pass","0","0","Tessellation","0","0","  Phong","0","0","  Strength","0.5,False,","0","  Type","0","0","  Tess","16,False,","0","  Min","10,False,","0","  Max","25,False,","0","  Edge Length","16,False,","0","  Max Displacement","25,False,","0","Disable Batching","1","638874603033018361","Vertex Position","0","638874601191422915","0","8","False","True","False","True","False","False","True","True","False","","True","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2430,"pos":[2560,-5700],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","SceneSelectionPass","0","6","SceneSelectionPass","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","False","False","False","True","1","LightMode=SceneSelectionPass","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2431,"pos":[2944,-5760],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","1","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ScenePickingPass","0","7","ScenePickingPass","1","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","False","False","False","True","1","LightMode=Picking","False","False","0","","0","0","Standard","0","False","0"]}
{"wire":[2374,0,2373,314]}
{"wire":[2421,206,2420,0]}
{"wire":[2422,0,2421,151]}
{"wire":[2379,0,2373,128]}
{"wire":[2436,1894,2437,0]}
{"wire":[2436,1896,2438,0]}
{"wire":[2424,224,2436,128]}
{"wire":[2424,146,2436,1895]}
{"wire":[2424,231,2436,1897]}
{"wire":[2426,146,2424,128]}
{"wire":[2426,397,2424,229]}
{"wire":[2426,186,2424,232]}
{"wire":[2427,146,2426,128]}
{"wire":[2427,1620,2426,398]}
{"wire":[2427,1619,2426,399]}
{"wire":[2428,146,2427,128]}
{"wire":[2428,225,2427,1617]}
{"wire":[2428,227,2427,1618]}
{"wire":[2429,0,2428,128]}
{"wire":[2402,0,2401,0]}
{"wire":[2406,39,2395,5]}
{"wire":[2406,34,2407,0]}
{"wire":[2408,39,2398,5]}
{"wire":[2408,34,2409,0]}
{"wire":[2411,39,2391,5]}
{"wire":[2411,34,2410,0]}
{"wire":[2414,39,2412,5]}
{"wire":[2414,34,2413,0]}
{"wire":[2441,1904,2442,0]}
{"wire":[2441,1894,2440,0]}
{"wire":[2441,1896,2439,0]}
{"wire":[2400,0,2406,0]}
{"wire":[2400,1,2408,0]}
{"wire":[2400,2,2411,0]}
{"wire":[2400,3,2414,0]}
{"wire":[2376,430,2441,1900]}
{"wire":[2376,225,2441,1895]}
{"wire":[2376,414,2441,1897]}
{"wire":[2386,0,2400,0]}
{"wire":[2416,0,2376,106]}
{"wire":[1774,0,1771,0]}
{"wire":[1774,1,1772,0]}
{"wire":[1774,3,1803,0]}
{"wire":[1803,0,1800,0]}
{"wire":[1843,0,1804,0]}
{"wire":[1800,0,1843,0]}
{"wire":[2419,80,2380,0]}
{"wire":[2419,106,2381,0]}
{"wire":[2419,107,2417,0]}
{"wire":[2354,0,2419,114]}
{"wire":[2354,4,2419,114]}
{"wire":[2354,5,2419,114]}
{"wire":[2354,2,2419,0]}
{"wire":[2354,15,2419,113]}
{"wire":[2354,16,2419,148]}
{"wire":[2354,17,2419,149]}
ASEEND*/
//CHKSM=F26DCD2C7C620D9F75476F03A683E69AB48E19EB