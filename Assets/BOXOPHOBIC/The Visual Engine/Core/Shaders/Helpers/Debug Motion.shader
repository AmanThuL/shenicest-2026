// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Motion"
{
	Properties
	{
		_RenderClip( "_RenderClip", Float ) = 0
		_IsElementShader( "_IsElementShader", Float ) = 0
		_IsHelperShader( "_IsHelperShader", Float ) = 0
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
		[HideInInspector][NoScaleOffset] _NoiseTex3D( "Noise Mask 3D", 3D ) = "white" {}
		[StyledCategory(Motion Settings, true, Use the Motion feature to add wind animation and interaction to foliage. The shaders support 3 layers of animation driven by vertex colors__ procedural masks or texture masksCOLNEWNEWUse the Primary Motion to add bending animation. The bending can work per instance for plants and trees or per baked pivots for grass so each blade is bending individually.NEWNEWUse the Second Motion to push the vertices in the wind direction. Perfect for tree cannopies__ palm or willow tree leaves.NEWNEWUse the Leaves Motion to add flutter to the leaves or leaf edges.NEWNEWUse the Ripples Motion to add a visual effect for the flowing wind texture.NEWNEWAll layers use flow maps for the wind animation. Use the Noise sliders to control how turbulent the motion is at high wind. Use the Pivots slider to control if the the flow map is sampled in world space or per pivotSLHpivots. Use the Phase slider to offset the animation based on the baked Object Phase Mode option. Use the Tiling and Speed values to control the overall flow map animation.NEWNEWUse the Details Limit value to fade out the flutter and ripples at high distances to avoid visual noise., _MotionIntensityValue, 03CC4E, 0, 10)] _MotionCategory( "[ Motion Category ]", Float ) = 0
		[StyledMessage(Info, The Interaction features require elements to work. Use Flow elements to add interaction and use the Interaction slider to control the intensity per motion layer., 0, 10)] _MotionFlowInfo( "# Message Flow", Float ) = 0
		[NoScaleOffset][StyledTextureSingleLine(Noise RGBA)] _MotionNoiseTex( "Motion Noise", 2D ) = "white" {}
		[NoScaleOffset][StyledTextureSingleLine(PrimaryMask R SecondMask G LeavesMask B)] _MotionMaskTex( "Motion Masks", 2D ) = "white" {}
		[Space(10)] _MotionIntensityValue( "Motion Intensity", Range( 0, 1 ) ) = 0
		_MotionDistValue( "Motion Details Limit", Range( 0, 2000 ) ) = 100
		[Space(10)] _MotionBaseIntensityValue( "Motion Primary Intensity", Range( 0, 10 ) ) = 0
		_MotionBaseDelayValue( "Motion Primary Delay", Range( 0, 1 ) ) = 0
		_MotionBaseNoiseValue( "Motion Primary Noise", Range( 0, 1 ) ) = 0.5
		_MotionBasePivotValue( "Motion Primary Pivots", Range( 0, 1 ) ) = 0.8
		_MotionBasePhaseValue( "Motion Primary Phase", Range( 0, 1 ) ) = 0
		_MotionBaseTillingValue( "Motion Primary Tilling", Range( 0, 100 ) ) = 5
		_MotionBaseSpeedValue( "Motion Primary Speed", Range( 0, 50 ) ) = 5
		_MotionBasePushValue( "Motion Primary Interaction", Range( 0, 10 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3,Height,4,Capsule,5,Masks R,6)] _MotionBaseMaskMode( "Motion Primary Anim Mask", Float ) = 3
		[StyledRemapSlider] _MotionBaseMaskRemap( "Motion Primary Anim Mask", Vector ) = ( 0, 1, 0, 0 )
		[Space(10)] _MotionSmallIntensityValue( "Motion Second Intensity", Range( 0, 10 ) ) = 0
		_MotionSmallDelayValue( "Motion Second Delay", Range( 0, 1 ) ) = 0
		_MotionSmallNoiseValue( "Motion Second Noise", Range( 0, 1 ) ) = 0.5
		_MotionSmallPivotValue( "Motion Second Pivots", Range( 0, 1 ) ) = 0.2
		_MotionSmallPhaseValue( "Motion Second Phase", Range( 0, 1 ) ) = 0
		_MotionSmallTillingValue( "Motion Second Tilling", Range( 0, 100 ) ) = 5
		_MotionSmallSpeedValue( "Motion Second Speed", Range( 0, 50 ) ) = 5
		_MotionSmallPushValue( "Motion Second Interaction", Range( 0, 10 ) ) = 9.588676
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3,Height,4,Capsule,5,Masks G,6)] _MotionSmallMaskMode( "Motion Second Anim Mask", Float ) = 1
		[StyledRemapSlider] _MotionSmallMaskRemap( "Motion Second Anim Mask", Vector ) = ( 0, 1, 0, 0 )
		[Space(10)] _MotionTinyIntensityValue( "Motion Leaves Intensity", Range( 0, 10 ) ) = 0
		_MotionTinyNoiseValue( "Motion Leaves Noise", Range( 0, 1 ) ) = 1
		_MotionTinyTillingValue( "Motion Leaves Tilling", Range( 0, 100 ) ) = 50
		_MotionTinySpeedValue( "Motion Leaves Speed", Range( 0, 50 ) ) = 10
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3,Height,4,Capsule,5,Masks B,6)] _MotionTinyMaskMode( "Motion Leaves Anim Mask", Float ) = 2
		[StyledRemapSlider] _MotionTinyMaskRemap( "Motion Leaves Anim Mask", Vector ) = ( 0, 1, 0, 0 )
		[Space(10)] _MotionHighlightValue( "Motion Ripples Intensity", Range( 0, 1 ) ) = 0
		[HDR][Gamma] _MotionHighlightColor( "Motion Ripples Color", Color ) = ( 1, 1, 1, 1 )
		[Space(10)] _MotionFlowValue( "Motion Flow Mask", Range( 0, 1 ) ) = 1
		[Enum(Global Wind Only,0,Use Flow Elements,1)] _MotionFlowMode( "Motion Flow Mask", Float ) = 0
		[HideInInspector] _motion_small_mode( "_motion_small_mode", Float ) = 0
		[StyledSpace(10)] _MotionEnd( "[ Motion End ]", Float ) = 1
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
				#pragma shader_feature_local_vertex TVE_MOTION
				#pragma shader_feature_local_vertex TVE_MOTION_FLOW
				#pragma shader_feature_local TVE_LEGACY
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
				#if defined (TVE_MOTION) //Motion
					#define TVE_ROTATION_BEND //Motion
				#endif //Motion
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
				#define SAMPLE_TEXTURE3D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE3D_LOD(tex,samplerTex,coord,lod) tex3Dlod(tex,float4(coord,lod))
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
					float4 ase_texcoord11 : TEXCOORD11;
					float4 ase_color : COLOR;
					float4 ase_texcoord12 : TEXCOORD12;
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
				uniform half _MotionCategory;
				uniform half _MotionEnd;
				uniform half _MotionFlowInfo;
				uniform half4 TVE_WindParams;
				uniform half _MotionFlowValue;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MotionNoiseTex);
				uniform half _MotionSmallPivotValue;
				uniform half _MotionSmallPhaseValue;
				uniform half _MotionSmallTillingValue;
				uniform half4 TVE_MotionTimeParams;
				uniform half _MotionSmallSpeedValue;
				uniform half _MotionSmallNoiseValue;
				uniform half _MotionFlowMode;
				uniform half4 TVE_WindEditor;
				uniform half _MotionIntensityValue;
				uniform half _MotionSmallDelayValue;
				uniform half _MotionSmallIntensityValue;
				uniform half _MotionSmallPushValue;
				uniform half _MotionSmallMaskMode;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MotionMaskTex);
				SamplerState sampler_MotionMaskTex;
				uniform half4 _MotionSmallMaskRemap;
				uniform half4 TVE_MotionValueParams;
				uniform half _MotionTinyTillingValue;
				uniform half _MotionTinySpeedValue;
				uniform half _MotionTinyNoiseValue;
				uniform half _MotionTinyIntensityValue;
				UNITY_DECLARE_TEX3D_NOSAMPLER(_NoiseTex3D);
				uniform half _MotionTinyMaskMode;
				uniform half4 _MotionTinyMaskRemap;
				uniform half _MotionDistValue;
				uniform half _MotionBasePivotValue;
				uniform half _MotionBasePhaseValue;
				uniform half _MotionBaseTillingValue;
				uniform half _MotionBaseSpeedValue;
				uniform half _MotionBaseNoiseValue;
				uniform half _MotionBaseIntensityValue;
				uniform half _MotionBaseDelayValue;
				uniform half _MotionBasePushValue;
				uniform half _MotionBaseMaskMode;
				uniform half4 _MotionBaseMaskRemap;
				uniform half _MotionHighlightValue;
				uniform half _motion_small_mode;
				uniform half4 _MotionHighlightColor;
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
				
				float SwitchChannel7( half Option, half4 ChannelA, half4 ChannelB )
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
					}
				}
				
				float2 DecodeFloatToVector2( float enc )
				{
					float2 result ;
					result.y = enc % 2048;
					result.x = floor(enc / 2048);
					return result / (2048 - 1);
				}
				
				float3 HSVToRGB( float3 c )
				{
					float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
					float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
					return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
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
					float localIfModelDataByShader26_g241959 = ( 0.0 );
					TVEModelData Data26_g241959 = (TVEModelData)0;
					TVEModelData Data16_g241856 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g241838 = _ObjectCoordMode;
					#else
					float staticSwitch343_g241838 = _ObjectCoordMode;
					#endif
					half Dummy207_g241838 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g241838 );
					float temp_output_14_0_g241856 = Dummy207_g241838;
					float In_Dummy16_g241856 = temp_output_14_0_g241856;
					float3 PositionOS131_g241838 = v.vertex.xyz;
					float3 temp_output_4_0_g241856 = PositionOS131_g241838;
					float3 In_PositionOS16_g241856 = temp_output_4_0_g241856;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g241838 = ase_positionWS;
					float3 vertexToFrag73_g241838 = temp_output_104_7_g241838;
					float3 PositionWS122_g241838 = vertexToFrag73_g241838;
					float3 In_PositionWS16_g241856 = PositionWS122_g241838;
					float4x4 break19_g241841 = unity_ObjectToWorld;
					float3 appendResult20_g241841 = (float3(break19_g241841[ 0 ][ 3 ] , break19_g241841[ 1 ][ 3 ] , break19_g241841[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241838 = appendResult20_g241841;
					float4x4 break19_g241843 = unity_ObjectToWorld;
					float3 appendResult20_g241843 = (float3(break19_g241843[ 0 ][ 3 ] , break19_g241843[ 1 ][ 3 ] , break19_g241843[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g241839 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g241838 = PositionOS131_g241838;
					float3 appendResult234_g241838 = (float3(break233_g241838.x , 0.0 , break233_g241838.z));
					float3 break413_g241838 = PositionOS131_g241838;
					float3 appendResult414_g241838 = (float3(break413_g241838.x , break413_g241838.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g241845 = appendResult414_g241838;
					#else
					float3 staticSwitch65_g241845 = appendResult234_g241838;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g241838 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g241838 = appendResult60_g241839;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g241838 = staticSwitch65_g241845;
					#else
					float3 staticSwitch229_g241838 = _Vector0;
					#endif
					float3 PivotOS149_g241838 = staticSwitch229_g241838;
					float3 temp_output_122_0_g241843 = PivotOS149_g241838;
					float3 PivotsOnlyWS105_g241843 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g241843 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g241838 = ( appendResult20_g241843 + PivotsOnlyWS105_g241843 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g241838 = temp_output_340_7_g241838;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g241838 = temp_output_341_7_g241838;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g241838 = temp_output_341_7_g241838;
					#else
					float3 staticSwitch236_g241838 = temp_output_340_7_g241838;
					#endif
					float3 vertexToFrag76_g241838 = staticSwitch236_g241838;
					float3 PivotWS121_g241838 = vertexToFrag76_g241838;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241838 = ( PositionWS122_g241838 - PivotWS121_g241838 );
					#else
					float3 staticSwitch204_g241838 = PositionWS122_g241838;
					#endif
					float3 PositionWO132_g241838 = ( staticSwitch204_g241838 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241856 = PositionWO132_g241838;
					float3 In_PivotOS16_g241856 = PivotOS149_g241838;
					float3 In_PivotWS16_g241856 = PivotWS121_g241838;
					float3 PivotWO133_g241838 = ( PivotWS121_g241838 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241856 = PivotWO133_g241838;
					half3 NormalOS134_g241838 = v.normal;
					float3 temp_output_21_0_g241856 = NormalOS134_g241838;
					float3 In_NormalOS16_g241856 = temp_output_21_0_g241856;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g241838 = normalizedWorldNormal;
					float3 In_NormalWS16_g241856 = NormalWS95_g241838;
					half4 TangentlOS153_g241838 = v.tangent;
					float4 temp_output_6_0_g241856 = TangentlOS153_g241838;
					float4 In_TangentOS16_g241856 = temp_output_6_0_g241856;
					float3 normalizeResult296_g241838 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241838 ) );
					half3 ViewDirWS169_g241838 = normalizeResult296_g241838;
					float3 In_ViewDirWS16_g241856 = ViewDirWS169_g241838;
					float4 appendResult397_g241838 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g241838 = appendResult397_g241838;
					float4 In_CoordsData16_g241856 = CoordsData398_g241838;
					half4 VertexMasks171_g241838 = v.ase_color;
					float4 In_VertexData16_g241856 = VertexMasks171_g241838;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241850 = (PositionOS131_g241838).z;
					#else
					float staticSwitch65_g241850 = (PositionOS131_g241838).y;
					#endif
					half Object_HeightValue267_g241838 = _ObjectHeightValue;
					half Bounds_HeightMask274_g241838 = saturate( ( staticSwitch65_g241850 / Object_HeightValue267_g241838 ) );
					half3 Position387_g241838 = PositionOS131_g241838;
					half Height387_g241838 = Object_HeightValue267_g241838;
					half Object_RadiusValue268_g241838 = _ObjectRadiusValue;
					half Radius387_g241838 = Object_RadiusValue268_g241838;
					half localCapsuleMaskYUp387_g241838 = CapsuleMaskYUp( Position387_g241838 , Height387_g241838 , Radius387_g241838 );
					half3 Position408_g241838 = PositionOS131_g241838;
					half Height408_g241838 = Object_HeightValue267_g241838;
					half Radius408_g241838 = Object_RadiusValue268_g241838;
					half localCapsuleMaskZUp408_g241838 = CapsuleMaskZUp( Position408_g241838 , Height408_g241838 , Radius408_g241838 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241855 = saturate( localCapsuleMaskZUp408_g241838 );
					#else
					float staticSwitch65_g241855 = saturate( localCapsuleMaskYUp387_g241838 );
					#endif
					half Bounds_SphereMask282_g241838 = staticSwitch65_g241855;
					float4 appendResult253_g241838 = (float4(Bounds_HeightMask274_g241838 , Bounds_SphereMask282_g241838 , 1.0 , 1.0));
					half4 MasksData254_g241838 = appendResult253_g241838;
					float4 In_MasksData16_g241856 = MasksData254_g241838;
					float temp_output_17_0_g241849 = _ObjectPhaseMode;
					float Option70_g241849 = temp_output_17_0_g241849;
					float4 temp_output_3_0_g241849 = v.ase_color;
					float4 Channel70_g241849 = temp_output_3_0_g241849;
					float localSwitchChannel470_g241849 = SwitchChannel4( Option70_g241849 , Channel70_g241849 );
					half Phase_Value372_g241838 = localSwitchChannel470_g241849;
					float3 break319_g241838 = PivotWO133_g241838;
					half Pivot_Position322_g241838 = ( break319_g241838.x + break319_g241838.z );
					half Phase_Position357_g241838 = ( Phase_Value372_g241838 + Pivot_Position322_g241838 );
					float temp_output_248_0_g241838 = frac( Phase_Position357_g241838 );
					float4 appendResult177_g241838 = (float4((frac( ( Phase_Position357_g241838 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g241838));
					half4 Phase_Data176_g241838 = appendResult177_g241838;
					float4 In_PhaseData16_g241856 = Phase_Data176_g241838;
					BuildModelVertData( Data16_g241856 , In_Dummy16_g241856 , In_PositionOS16_g241856 , In_PositionWS16_g241856 , In_PositionWO16_g241856 , In_PivotOS16_g241856 , In_PivotWS16_g241856 , In_PivotWO16_g241856 , In_NormalOS16_g241856 , In_NormalWS16_g241856 , In_TangentOS16_g241856 , In_ViewDirWS16_g241856 , In_CoordsData16_g241856 , In_VertexData16_g241856 , In_MasksData16_g241856 , In_PhaseData16_g241856 );
					TVEModelData DataDefault26_g241959 = Data16_g241856;
					TVEModelData DataGeneral26_g241959 = Data16_g241856;
					TVEModelData DataBlanket26_g241959 = Data16_g241856;
					TVEModelData DataImpostor26_g241959 = Data16_g241856;
					TVEModelData Data16_g241836 =(TVEModelData)0;
					half Dummy207_g241818 = 0.0;
					float temp_output_14_0_g241836 = Dummy207_g241818;
					float In_Dummy16_g241836 = temp_output_14_0_g241836;
					float3 PositionOS131_g241818 = v.vertex.xyz;
					float3 temp_output_4_0_g241836 = PositionOS131_g241818;
					float3 In_PositionOS16_g241836 = temp_output_4_0_g241836;
					float3 temp_output_104_7_g241818 = ase_positionWS;
					float3 PositionWS122_g241818 = temp_output_104_7_g241818;
					float3 In_PositionWS16_g241836 = PositionWS122_g241818;
					float4x4 break19_g241821 = unity_ObjectToWorld;
					float3 appendResult20_g241821 = (float3(break19_g241821[ 0 ][ 3 ] , break19_g241821[ 1 ][ 3 ] , break19_g241821[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241818 = appendResult20_g241821;
					float3 PivotWS121_g241818 = temp_output_340_7_g241818;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241818 = ( PositionWS122_g241818 - PivotWS121_g241818 );
					#else
					float3 staticSwitch204_g241818 = PositionWS122_g241818;
					#endif
					float3 PositionWO132_g241818 = ( staticSwitch204_g241818 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241836 = PositionWO132_g241818;
					float3 PivotOS149_g241818 = _Vector0;
					float3 In_PivotOS16_g241836 = PivotOS149_g241818;
					float3 In_PivotWS16_g241836 = PivotWS121_g241818;
					float3 PivotWO133_g241818 = ( PivotWS121_g241818 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241836 = PivotWO133_g241818;
					half3 NormalOS134_g241818 = v.normal;
					float3 temp_output_21_0_g241836 = NormalOS134_g241818;
					float3 In_NormalOS16_g241836 = temp_output_21_0_g241836;
					half3 NormalWS95_g241818 = normalizedWorldNormal;
					float3 In_NormalWS16_g241836 = NormalWS95_g241818;
					float4 appendResult462_g241818 = (float4(cross( v.normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g241818 = appendResult462_g241818;
					float4 temp_output_6_0_g241836 = TangentlOS153_g241818;
					float4 In_TangentOS16_g241836 = temp_output_6_0_g241836;
					float3 normalizeResult296_g241818 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241818 ) );
					half3 ViewDirWS169_g241818 = normalizeResult296_g241818;
					float3 In_ViewDirWS16_g241836 = ViewDirWS169_g241818;
					float4 appendResult397_g241818 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g241818 = appendResult397_g241818;
					float4 In_CoordsData16_g241836 = CoordsData398_g241818;
					half4 VertexMasks171_g241818 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241836 = VertexMasks171_g241818;
					half4 MasksData254_g241818 = float4( 0,0,0,0 );
					float4 In_MasksData16_g241836 = MasksData254_g241818;
					half4 Phase_Data176_g241818 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g241836 = Phase_Data176_g241818;
					BuildModelVertData( Data16_g241836 , In_Dummy16_g241836 , In_PositionOS16_g241836 , In_PositionWS16_g241836 , In_PositionWO16_g241836 , In_PivotOS16_g241836 , In_PivotWS16_g241836 , In_PivotWO16_g241836 , In_NormalOS16_g241836 , In_NormalWS16_g241836 , In_TangentOS16_g241836 , In_ViewDirWS16_g241836 , In_CoordsData16_g241836 , In_VertexData16_g241836 , In_MasksData16_g241836 , In_PhaseData16_g241836 );
					TVEModelData DataTerrain26_g241959 = Data16_g241836;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g241959 = IsShaderType2637;
					{
					if (Type26_g241959 == 0 )
					{
					Data26_g241959 = DataDefault26_g241959;
					}
					else if (Type26_g241959 == 1 )
					{
					Data26_g241959 = DataGeneral26_g241959;
					}
					else if (Type26_g241959 == 2 )
					{
					Data26_g241959 = DataBlanket26_g241959;
					}
					else if (Type26_g241959 == 3 )
					{
					Data26_g241959 = DataImpostor26_g241959;
					}
					else if (Type26_g241959 == 4 )
					{
					Data26_g241959 = DataTerrain26_g241959;
					}
					}
					TVEModelData Data15_g251553 =(TVEModelData)Data26_g241959;
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
					TVEVertexData Data15_g251569 =(TVEVertexData)Data16_g251557;
					float Out_Dummy15_g251569 = 0.0;
					float3 Out_PositionOS15_g251569 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251569 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251569 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251569 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251569 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251569 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251569 , Out_Dummy15_g251569 , Out_PositionOS15_g251569 , Out_NormalOS15_g251569 , Out_TangentOS15_g251569 , Out_TransformData15_g251569 , Out_RotationData15_g251569 , Out_Interpolator15_g251569 );
					TVEVertexData Data16_g251570 =(TVEVertexData)Data15_g251569;
					half Dummy317_g251561 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251570 = Dummy317_g251561;
					float3 In_PositionOS16_g251570 = Out_PositionOS15_g251569;
					float3 In_NormalOS16_g251570 = Out_NormalOS15_g251569;
					float4 In_TangentOS16_g251570 = Out_TangentOS15_g251569;
					half4 Model_TransformData356_g251561 = Out_TransformData15_g251569;
					float localBuildGlobalData204_g241858 = ( 0.0 );
					TVEGlobalData Data204_g241858 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g241858 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g241858 = Dummy211_g241858;
					float4 temp_output_203_0_g241877 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g241817 = ( 0.0 );
					TVEModelData Data26_g241817 = (TVEModelData)0;
					TVEModelData Data16_g241846 =(TVEModelData)0;
					float In_Dummy16_g241846 = 0.0;
					float3 In_PositionWS16_g241846 = PositionWS122_g241838;
					float3 In_PositionWO16_g241846 = PositionWO132_g241838;
					float3 In_PivotWS16_g241846 = PivotWS121_g241838;
					float3 In_PivotWO16_g241846 = PivotWO133_g241838;
					float3 In_NormalWS16_g241846 = NormalWS95_g241838;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g241838 = ase_tangentWS;
					float3 In_TangentWS16_g241846 = TangentWS136_g241838;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g241838 = ase_bitangentWS;
					float3 In_BitangentWS16_g241846 = BiangentWS421_g241838;
					half3 NormalWS427_g241838 = NormalWS95_g241838;
					half3 localComputeTriplanarMasks427_g241838 = ComputeTriplanarMasks( NormalWS427_g241838 );
					half3 TriplanarWeights429_g241838 = localComputeTriplanarMasks427_g241838;
					float3 In_TriplanarWeights16_g241846 = TriplanarWeights429_g241838;
					float3 In_ViewDirWS16_g241846 = ViewDirWS169_g241838;
					float4 In_CoordsData16_g241846 = CoordsData398_g241838;
					float4 In_VertexData16_g241846 = VertexMasks171_g241838;
					float4 In_Interpolator16_g241846 = Phase_Data176_g241838;
					BuildModelFragData( Data16_g241846 , In_Dummy16_g241846 , In_PositionWS16_g241846 , In_PositionWO16_g241846 , In_PivotWS16_g241846 , In_PivotWO16_g241846 , In_NormalWS16_g241846 , In_TangentWS16_g241846 , In_BitangentWS16_g241846 , In_TriplanarWeights16_g241846 , In_ViewDirWS16_g241846 , In_CoordsData16_g241846 , In_VertexData16_g241846 , In_Interpolator16_g241846 );
					TVEModelData DataDefault26_g241817 = Data16_g241846;
					TVEModelData DataGeneral26_g241817 = Data16_g241846;
					TVEModelData DataBlanket26_g241817 = Data16_g241846;
					TVEModelData DataImpostor26_g241817 = Data16_g241846;
					TVEModelData Data16_g241826 =(TVEModelData)0;
					float In_Dummy16_g241826 = 0.0;
					float3 In_PositionWS16_g241826 = PositionWS122_g241818;
					float3 In_PositionWO16_g241826 = PositionWO132_g241818;
					float3 In_PivotWS16_g241826 = PivotWS121_g241818;
					float3 In_PivotWO16_g241826 = PivotWO133_g241818;
					float3 In_NormalWS16_g241826 = NormalWS95_g241818;
					half3 TangentWS136_g241818 = ase_tangentWS;
					float3 In_TangentWS16_g241826 = TangentWS136_g241818;
					half3 BiangentWS421_g241818 = ase_bitangentWS;
					float3 In_BitangentWS16_g241826 = BiangentWS421_g241818;
					half3 NormalWS427_g241818 = NormalWS95_g241818;
					half3 localComputeTriplanarMasks427_g241818 = ComputeTriplanarMasks( NormalWS427_g241818 );
					half3 TriplanarWeights429_g241818 = localComputeTriplanarMasks427_g241818;
					float3 In_TriplanarWeights16_g241826 = TriplanarWeights429_g241818;
					float3 In_ViewDirWS16_g241826 = ViewDirWS169_g241818;
					float4 In_CoordsData16_g241826 = CoordsData398_g241818;
					float4 In_VertexData16_g241826 = VertexMasks171_g241818;
					float4 In_Interpolator16_g241826 = Phase_Data176_g241818;
					BuildModelFragData( Data16_g241826 , In_Dummy16_g241826 , In_PositionWS16_g241826 , In_PositionWO16_g241826 , In_PivotWS16_g241826 , In_PivotWO16_g241826 , In_NormalWS16_g241826 , In_TangentWS16_g241826 , In_BitangentWS16_g241826 , In_TriplanarWeights16_g241826 , In_ViewDirWS16_g241826 , In_CoordsData16_g241826 , In_VertexData16_g241826 , In_Interpolator16_g241826 );
					TVEModelData DataTerrain26_g241817 = Data16_g241826;
					float Type26_g241817 = IsShaderType2637;
					{
					if (Type26_g241817 == 0 )
					{
					Data26_g241817 = DataDefault26_g241817;
					}
					else if (Type26_g241817 == 1 )
					{
					Data26_g241817 = DataGeneral26_g241817;
					}
					else if (Type26_g241817 == 2 )
					{
					Data26_g241817 = DataBlanket26_g241817;
					}
					else if (Type26_g241817 == 3 )
					{
					Data26_g241817 = DataImpostor26_g241817;
					}
					else if (Type26_g241817 == 4 )
					{
					Data26_g241817 = DataTerrain26_g241817;
					}
					}
					TVEModelData Data15_g241948 =(TVEModelData)Data26_g241817;
					float Out_Dummy15_g241948 = 0.0;
					float3 Out_PositionWS15_g241948 = float3( 0,0,0 );
					float3 Out_PositionWO15_g241948 = float3( 0,0,0 );
					float3 Out_PivotWS15_g241948 = float3( 0,0,0 );
					float3 Out_PivotWO15_g241948 = float3( 0,0,0 );
					float3 Out_NormalWS15_g241948 = float3( 0,0,0 );
					float3 Out_TangentWS15_g241948 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g241948 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g241948 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g241948 = float3( 0,0,0 );
					float4 Out_CoordsData15_g241948 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g241948 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g241948 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g241948 , Out_Dummy15_g241948 , Out_PositionWS15_g241948 , Out_PositionWO15_g241948 , Out_PivotWS15_g241948 , Out_PivotWO15_g241948 , Out_NormalWS15_g241948 , Out_TangentWS15_g241948 , Out_BitangentWS15_g241948 , Out_TriplanarWeights15_g241948 , Out_ViewDirWS15_g241948 , Out_CoordsData15_g241948 , Out_VertexData15_g241948 , Out_Interpolator15_g241948 );
					float3 Model_PositionWS497_g241858 = Out_PositionWS15_g241948;
					float2 Model_PositionWS_XZ143_g241858 = (Model_PositionWS497_g241858).xz;
					float3 Model_PivotWS498_g241858 = Out_PivotWS15_g241948;
					float2 Model_PivotWS_XZ145_g241858 = (Model_PivotWS498_g241858).xz;
					float2 lerpResult300_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g241877 = lerpResult300_g241858;
					float temp_output_82_0_g241875 = _GlobalCoatLayerValue;
					float temp_output_82_0_g241877 = temp_output_82_0_g241875;
					float4 tex2DArrayNode83_g241877 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241877).zw + ( (temp_output_203_0_g241877).xy * temp_output_81_0_g241877 ) ),temp_output_82_0_g241877), 0.0 );
					float4 appendResult210_g241877 = (float4(tex2DArrayNode83_g241877.rgb , tex2DArrayNode83_g241877.a));
					float4 temp_output_204_0_g241877 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g241877 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241877).zw + ( (temp_output_204_0_g241877).xy * temp_output_81_0_g241877 ) ),temp_output_82_0_g241877), 0.0 );
					float4 appendResult212_g241877 = (float4(tex2DArrayNode122_g241877.rgb , tex2DArrayNode122_g241877.a));
					float4 TVE_RenderNearPositionR628_g241858 = TVE_RenderNearPositionR;
					float temp_output_507_0_g241858 = saturate( ( distance( Model_PositionWS497_g241858 , (TVE_RenderNearPositionR628_g241858).xyz ) / (TVE_RenderNearPositionR628_g241858).w ) );
					float temp_output_7_0_g241947 = 1.0;
					float temp_output_9_0_g241947 = ( temp_output_507_0_g241858 - temp_output_7_0_g241947 );
					half TVE_RenderNearFadeValue635_g241858 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g241858 = saturate( ( temp_output_9_0_g241947 / ( ( TVE_RenderNearFadeValue635_g241858 - temp_output_7_0_g241947 ) + 0.0001 ) ) );
					float4 lerpResult131_g241877 = lerp( appendResult210_g241877 , appendResult212_g241877 , Global_TexBlend509_g241858);
					float4 temp_output_159_109_g241875 = lerpResult131_g241877;
					float4 lerpResult168_g241875 = lerp( TVE_CoatParams , temp_output_159_109_g241875 , TVE_CoatLayers[(int)temp_output_82_0_g241875]);
					float4 temp_output_589_109_g241858 = lerpResult168_g241875;
					half4 Coat_Texture302_g241858 = temp_output_589_109_g241858;
					float4 In_CoatTexture204_g241858 = Coat_Texture302_g241858;
					half4 Draw_Texture656_g241858 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g241858 = Draw_Texture656_g241858;
					float4 temp_output_203_0_g241902 = TVE_PaintBaseCoord;
					float2 lerpResult85_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g241902 = lerpResult85_g241858;
					float temp_output_82_0_g241899 = _GlobalPaintLayerValue;
					float temp_output_82_0_g241902 = temp_output_82_0_g241899;
					float4 tex2DArrayNode83_g241902 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241902).zw + ( (temp_output_203_0_g241902).xy * temp_output_81_0_g241902 ) ),temp_output_82_0_g241902), 0.0 );
					float4 appendResult210_g241902 = (float4(tex2DArrayNode83_g241902.rgb , tex2DArrayNode83_g241902.a));
					float4 temp_output_204_0_g241902 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g241902 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241902).zw + ( (temp_output_204_0_g241902).xy * temp_output_81_0_g241902 ) ),temp_output_82_0_g241902), 0.0 );
					float4 appendResult212_g241902 = (float4(tex2DArrayNode122_g241902.rgb , tex2DArrayNode122_g241902.a));
					float4 lerpResult131_g241902 = lerp( appendResult210_g241902 , appendResult212_g241902 , Global_TexBlend509_g241858);
					float4 temp_output_171_109_g241899 = lerpResult131_g241902;
					float4 lerpResult174_g241899 = lerp( TVE_PaintParams , temp_output_171_109_g241899 , TVE_PaintLayers[(int)temp_output_82_0_g241899]);
					float4 temp_output_595_109_g241858 = lerpResult174_g241899;
					half4 Paint_Texture71_g241858 = temp_output_595_109_g241858;
					float4 In_PaintTexture204_g241858 = Paint_Texture71_g241858;
					float4 temp_output_203_0_g241885 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g241885 = lerpResult104_g241858;
					float temp_output_132_0_g241883 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g241885 = temp_output_132_0_g241883;
					float4 tex2DArrayNode83_g241885 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241885).zw + ( (temp_output_203_0_g241885).xy * temp_output_81_0_g241885 ) ),temp_output_82_0_g241885), 0.0 );
					float4 appendResult210_g241885 = (float4(tex2DArrayNode83_g241885.rgb , tex2DArrayNode83_g241885.a));
					float4 temp_output_204_0_g241885 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g241885 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241885).zw + ( (temp_output_204_0_g241885).xy * temp_output_81_0_g241885 ) ),temp_output_82_0_g241885), 0.0 );
					float4 appendResult212_g241885 = (float4(tex2DArrayNode122_g241885.rgb , tex2DArrayNode122_g241885.a));
					float4 lerpResult131_g241885 = lerp( appendResult210_g241885 , appendResult212_g241885 , Global_TexBlend509_g241858);
					float4 temp_output_137_109_g241883 = lerpResult131_g241885;
					float4 lerpResult145_g241883 = lerp( TVE_AtmoParams , temp_output_137_109_g241883 , TVE_AtmoLayers[(int)temp_output_132_0_g241883]);
					float4 temp_output_590_110_g241858 = lerpResult145_g241883;
					half4 Atmo_Texture80_g241858 = temp_output_590_110_g241858;
					float4 In_AtmoTexture204_g241858 = Atmo_Texture80_g241858;
					float4 temp_output_203_0_g241953 = TVE_EffexBaseCoord;
					float2 lerpResult414_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g241953 = lerpResult414_g241858;
					float temp_output_132_0_g241951 = _GlobalEffexLayerValue;
					float temp_output_82_0_g241953 = temp_output_132_0_g241951;
					float4 tex2DArrayNode83_g241953 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241953).zw + ( (temp_output_203_0_g241953).xy * temp_output_81_0_g241953 ) ),temp_output_82_0_g241953), 0.0 );
					float4 appendResult210_g241953 = (float4(tex2DArrayNode83_g241953.rgb , tex2DArrayNode83_g241953.a));
					float4 temp_output_204_0_g241953 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g241953 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241953).zw + ( (temp_output_204_0_g241953).xy * temp_output_81_0_g241953 ) ),temp_output_82_0_g241953), 0.0 );
					float4 appendResult212_g241953 = (float4(tex2DArrayNode122_g241953.rgb , tex2DArrayNode122_g241953.a));
					float4 lerpResult131_g241953 = lerp( appendResult210_g241953 , appendResult212_g241953 , Global_TexBlend509_g241858);
					float4 temp_output_137_109_g241951 = lerpResult131_g241953;
					float4 lerpResult145_g241951 = lerp( TVE_EffexParams , temp_output_137_109_g241951 , TVE_EffexLayers[(int)temp_output_132_0_g241951]);
					float4 temp_output_731_110_g241858 = lerpResult145_g241951;
					half4 Effex_Texture420_g241858 = temp_output_731_110_g241858;
					float4 In_EffexTexture204_g241858 = Effex_Texture420_g241858;
					float4 temp_output_203_0_g241933 = TVE_GlowBaseCoord;
					float2 lerpResult247_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g241933 = lerpResult247_g241858;
					float temp_output_82_0_g241931 = _GlobalGlowLayerValue;
					float temp_output_82_0_g241933 = temp_output_82_0_g241931;
					float4 tex2DArrayNode83_g241933 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241933).zw + ( (temp_output_203_0_g241933).xy * temp_output_81_0_g241933 ) ),temp_output_82_0_g241933), 0.0 );
					float4 appendResult210_g241933 = (float4(tex2DArrayNode83_g241933.rgb , tex2DArrayNode83_g241933.a));
					float4 temp_output_204_0_g241933 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g241933 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241933).zw + ( (temp_output_204_0_g241933).xy * temp_output_81_0_g241933 ) ),temp_output_82_0_g241933), 0.0 );
					float4 appendResult212_g241933 = (float4(tex2DArrayNode122_g241933.rgb , tex2DArrayNode122_g241933.a));
					float4 lerpResult131_g241933 = lerp( appendResult210_g241933 , appendResult212_g241933 , Global_TexBlend509_g241858);
					float4 temp_output_159_109_g241931 = lerpResult131_g241933;
					float4 lerpResult167_g241931 = lerp( TVE_GlowParams , temp_output_159_109_g241931 , TVE_GlowLayers[(int)temp_output_82_0_g241931]);
					float4 temp_output_593_109_g241858 = lerpResult167_g241931;
					half4 Glow_Texture248_g241858 = temp_output_593_109_g241858;
					float4 In_GlowTexture204_g241858 = Glow_Texture248_g241858;
					float4 temp_output_203_0_g241869 = TVE_FormBaseCoord;
					float2 lerpResult168_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g241869 = lerpResult168_g241858;
					float temp_output_130_0_g241867 = _GlobalFormLayerValue;
					float temp_output_82_0_g241869 = temp_output_130_0_g241867;
					float4 tex2DArrayNode83_g241869 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241869).zw + ( (temp_output_203_0_g241869).xy * temp_output_81_0_g241869 ) ),temp_output_82_0_g241869), 0.0 );
					float4 appendResult210_g241869 = (float4(tex2DArrayNode83_g241869.rgb , tex2DArrayNode83_g241869.a));
					float4 temp_output_204_0_g241869 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g241869 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241869).zw + ( (temp_output_204_0_g241869).xy * temp_output_81_0_g241869 ) ),temp_output_82_0_g241869), 0.0 );
					float4 appendResult212_g241869 = (float4(tex2DArrayNode122_g241869.rgb , tex2DArrayNode122_g241869.a));
					float4 lerpResult131_g241869 = lerp( appendResult210_g241869 , appendResult212_g241869 , Global_TexBlend509_g241858);
					float4 temp_output_135_109_g241867 = lerpResult131_g241869;
					float4 lerpResult143_g241867 = lerp( TVE_FormParams , temp_output_135_109_g241867 , TVE_FormLayers[(int)temp_output_130_0_g241867]);
					float4 temp_output_592_0_g241858 = lerpResult143_g241867;
					float4 Form_Texture112_g241858 = temp_output_592_0_g241858;
					float4 In_FormTexture204_g241858 = Form_Texture112_g241858;
					float4 In_LandTexture204_g241858 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g241917 = TVE_VertxBaseCoord;
					float2 lerpResult681_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g241917 = lerpResult681_g241858;
					float temp_output_136_0_g241915 = _GlobalVertxLayerValue;
					float temp_output_82_0_g241917 = temp_output_136_0_g241915;
					float4 tex2DArrayNode83_g241917 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241917).zw + ( (temp_output_203_0_g241917).xy * temp_output_81_0_g241917 ) ),temp_output_82_0_g241917), 0.0 );
					float4 appendResult210_g241917 = (float4(tex2DArrayNode83_g241917.rgb , tex2DArrayNode83_g241917.a));
					float4 temp_output_204_0_g241917 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g241917 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241917).zw + ( (temp_output_204_0_g241917).xy * temp_output_81_0_g241917 ) ),temp_output_82_0_g241917), 0.0 );
					float4 appendResult212_g241917 = (float4(tex2DArrayNode122_g241917.rgb , tex2DArrayNode122_g241917.a));
					float4 lerpResult131_g241917 = lerp( appendResult210_g241917 , appendResult212_g241917 , Global_TexBlend509_g241858);
					float4 temp_output_141_109_g241915 = lerpResult131_g241917;
					float4 lerpResult149_g241915 = lerp( TVE_VertxParams , temp_output_141_109_g241915 , TVE_VertxLayers[(int)temp_output_136_0_g241915]);
					float4 temp_output_695_0_g241858 = lerpResult149_g241915;
					half4 Vertx_Texture693_g241858 = temp_output_695_0_g241858;
					float4 In_VertxTexture204_g241858 = Vertx_Texture693_g241858;
					float4 temp_output_203_0_g241893 = TVE_FlowBaseCoord;
					float2 lerpResult400_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g241893 = lerpResult400_g241858;
					float temp_output_136_0_g241891 = _GlobalFlowLayerValue;
					float temp_output_82_0_g241893 = temp_output_136_0_g241891;
					float4 tex2DArrayNode83_g241893 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241893).zw + ( (temp_output_203_0_g241893).xy * temp_output_81_0_g241893 ) ),temp_output_82_0_g241893), 0.0 );
					float4 appendResult210_g241893 = (float4(tex2DArrayNode83_g241893.rgb , tex2DArrayNode83_g241893.a));
					float4 temp_output_204_0_g241893 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g241893 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241893).zw + ( (temp_output_204_0_g241893).xy * temp_output_81_0_g241893 ) ),temp_output_82_0_g241893), 0.0 );
					float4 appendResult212_g241893 = (float4(tex2DArrayNode122_g241893.rgb , tex2DArrayNode122_g241893.a));
					float4 lerpResult131_g241893 = lerp( appendResult210_g241893 , appendResult212_g241893 , Global_TexBlend509_g241858);
					float4 temp_output_141_109_g241891 = lerpResult131_g241893;
					float4 lerpResult149_g241891 = lerp( TVE_FlowParams , temp_output_141_109_g241891 , TVE_FlowLayers[(int)temp_output_136_0_g241891]);
					float4 temp_output_594_0_g241858 = lerpResult149_g241891;
					half4 Flow_Texture405_g241858 = temp_output_594_0_g241858;
					float4 In_FlowTexture204_g241858 = Flow_Texture405_g241858;
					half4 User_Texture677_g241858 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g241858 = User_Texture677_g241858;
					BuildGlobalData( Data204_g241858 , In_Dummy204_g241858 , In_CoatTexture204_g241858 , In_DrawTexture204_g241858 , In_PaintTexture204_g241858 , In_AtmoTexture204_g241858 , In_EffexTexture204_g241858 , In_GlowTexture204_g241858 , In_FormTexture204_g241858 , In_LandTexture204_g241858 , In_VertxTexture204_g241858 , In_FlowTexture204_g241858 , In_UserTexture204_g241858 );
					TVEGlobalData Data15_g251571 =(TVEGlobalData)Data204_g241858;
					float Out_Dummy15_g251571 = 0.0;
					float4 Out_CoatTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251571 = float4( 0,0,0,0 );
					BreakData( Data15_g251571 , Out_Dummy15_g251571 , Out_CoatTexture15_g251571 , Out_DrawTexture15_g251571 , Out_PaintTexture15_g251571 , Out_AtmoTexture15_g251571 , Out_EffexTexture15_g251571 , Out_GlowTexture15_g251571 , Out_FormTexture15_g251571 , Out_LandTexture15_g251571 , Out_VertxTexture15_g251571 , Out_FlowTexture15_g251571 , Out_UserTexture15_g251571 );
					float4 Global_FormTexture351_g251561 = Out_FormTexture15_g251571;
					TVEModelData Data15_g251568 =(TVEModelData)Data15_g251556;
					float Out_Dummy15_g251568 = 0.0;
					float3 Out_PositionOS15_g251568 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251568 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251568 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251568 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251568 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251568 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251568 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251568 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251568 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251568 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251568 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251568 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251568 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251568 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251568 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251568 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251568 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251568 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251568 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251568 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251568 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251568 , Out_Dummy15_g251568 , Out_PositionOS15_g251568 , Out_PositionWS15_g251568 , Out_PositionWO15_g251568 , Out_PositionRawOS15_g251568 , Out_PivotOS15_g251568 , Out_PivotWS15_g251568 , Out_PivotWO15_g251568 , Out_NormalOS15_g251568 , Out_NormalWS15_g251568 , Out_NormalRawOS15_g251568 , Out_TangentOS15_g251568 , Out_TangentWS15_g251568 , Out_BitangentWS15_g251568 , Out_ViewDirWS15_g251568 , Out_CoordsData15_g251568 , Out_VertexData15_g251568 , Out_MasksData15_g251568 , Out_PhaseData15_g251568 , Out_TransformData15_g251568 , Out_RotationData15_g251568 , Out_Interpolator15_g251568 );
					float3 Model_PivotWO353_g251561 = Out_PivotWO15_g251568;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251567 = _ConformMeshMode;
					float Option70_g251567 = temp_output_17_0_g251567;
					half4 Model_VertexData357_g251561 = Out_VertexData15_g251568;
					float4 temp_output_3_0_g251567 = Model_VertexData357_g251561;
					float4 Channel70_g251567 = temp_output_3_0_g251567;
					float localSwitchChannel470_g251567 = SwitchChannel4( Option70_g251567 , Channel70_g251567 );
					float temp_output_390_0_g251561 = localSwitchChannel470_g251567;
					float temp_output_7_0_g251564 = _ConformMeshRemap.x;
					float temp_output_9_0_g251564 = ( temp_output_390_0_g251561 - temp_output_7_0_g251564 );
					float lerpResult374_g251561 = lerp( 1.0 , saturate( ( temp_output_9_0_g251564 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251561 = lerpResult374_g251561;
					float temp_output_328_0_g251561 = ( Blend_VertMask379_g251561 * TVE_IsEnabled );
					half Conform_Mask366_g251561 = temp_output_328_0_g251561;
					float temp_output_322_0_g251561 = ( ( ( ( (Global_FormTexture351_g251561).z - ( (Model_PivotWO353_g251561).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251561 ) );
					float3 appendResult329_g251561 = (float3(0.0 , temp_output_322_0_g251561 , 0.0));
					float3 appendResult387_g251561 = (float3(0.0 , 0.0 , temp_output_322_0_g251561));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251565 = appendResult387_g251561;
					#else
					float3 staticSwitch65_g251565 = appendResult329_g251561;
					#endif
					float3 Blanket_Conform368_g251561 = staticSwitch65_g251565;
					float4 appendResult312_g251561 = (float4(Blanket_Conform368_g251561 , 0.0));
					float4 temp_output_310_0_g251561 = ( Model_TransformData356_g251561 + appendResult312_g251561 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251561 = temp_output_310_0_g251561;
					#else
					float4 staticSwitch364_g251561 = Model_TransformData356_g251561;
					#endif
					half4 Final_TransformData365_g251561 = staticSwitch364_g251561;
					float4 In_TransformData16_g251570 = Final_TransformData365_g251561;
					float4 In_RotationData16_g251570 = Out_RotationData15_g251569;
					float4 In_Interpolator16_g251570 = Out_Interpolator15_g251569;
					BuildVertexData( Data16_g251570 , In_Dummy16_g251570 , In_PositionOS16_g251570 , In_NormalOS16_g251570 , In_TangentOS16_g251570 , In_TransformData16_g251570 , In_RotationData16_g251570 , In_Interpolator16_g251570 );
					TVEVertexData Data15_g251653 =(TVEVertexData)Data16_g251570;
					float Out_Dummy15_g251653 = 0.0;
					float3 Out_PositionOS15_g251653 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251653 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251653 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251653 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251653 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251653 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251653 , Out_Dummy15_g251653 , Out_PositionOS15_g251653 , Out_NormalOS15_g251653 , Out_TangentOS15_g251653 , Out_TransformData15_g251653 , Out_RotationData15_g251653 , Out_Interpolator15_g251653 );
					TVEVertexData Data16_g251654 =(TVEVertexData)Data15_g251653;
					half Dummy181_g251640 = ( ( _MotionCategory + _MotionEnd ) + _MotionFlowInfo );
					float In_Dummy16_g251654 = Dummy181_g251640;
					float3 temp_output_3325_0_g251640 = Out_PositionOS15_g251653;
					float3 In_PositionOS16_g251654 = temp_output_3325_0_g251640;
					float3 In_NormalOS16_g251654 = Out_NormalOS15_g251653;
					float4 In_TangentOS16_g251654 = Out_TangentOS15_g251653;
					half4 Vertex_TransformData2743_g251640 = Out_TransformData15_g251653;
					float3 temp_cast_13 = (0.0).xxx;
					half Motion_FlowValue3376_g251640 = _MotionFlowValue;
					float2 lerpResult3361_g251640 = lerp( (half4( 1, 1, 1, 0 )).xy , (TVE_WindParams).xy , ( Motion_FlowValue3376_g251640 * TVE_IsEnabled ));
					float2 Global_WindDirWS2542_g251640 = (lerpResult3361_g251640*2.0 + -1.0);
					half2 Input_WindDirWS803_g251687 = Global_WindDirWS2542_g251640;
					TVEModelData Data15_g251652 =(TVEModelData)Data15_g251568;
					float Out_Dummy15_g251652 = 0.0;
					float3 Out_PositionOS15_g251652 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251652 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251652 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251652 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251652 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251652 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251652 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251652 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251652 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251652 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251652 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251652 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251652 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251652 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251652 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251652 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251652 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251652 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251652 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251652 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251652 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251652 , Out_Dummy15_g251652 , Out_PositionOS15_g251652 , Out_PositionWS15_g251652 , Out_PositionWO15_g251652 , Out_PositionRawOS15_g251652 , Out_PivotOS15_g251652 , Out_PivotWS15_g251652 , Out_PivotWO15_g251652 , Out_NormalOS15_g251652 , Out_NormalWS15_g251652 , Out_NormalRawOS15_g251652 , Out_TangentOS15_g251652 , Out_TangentWS15_g251652 , Out_BitangentWS15_g251652 , Out_ViewDirWS15_g251652 , Out_CoordsData15_g251652 , Out_VertexData15_g251652 , Out_MasksData15_g251652 , Out_PhaseData15_g251652 , Out_TransformData15_g251652 , Out_RotationData15_g251652 , Out_Interpolator15_g251652 );
					float3 Model_PositionWO162_g251640 = Out_PositionWO15_g251652;
					half3 Input_ModelPositionWO761_g251650 = Model_PositionWO162_g251640;
					float3 Model_PivotWO402_g251640 = Out_PivotWO15_g251652;
					half3 Input_ModelPivotsWO419_g251650 = Model_PivotWO402_g251640;
					half Input_MotionPivots629_g251650 = _MotionSmallPivotValue;
					float3 lerpResult771_g251650 = lerp( Input_ModelPositionWO761_g251650 , Input_ModelPivotsWO419_g251650 , Input_MotionPivots629_g251650);
					half4 Model_PhaseData489_g251640 = Out_PhaseData15_g251652;
					half4 Input_ModelMotionData763_g251650 = Model_PhaseData489_g251640;
					half Input_MotionPhase764_g251650 = _MotionSmallPhaseValue;
					float temp_output_770_0_g251650 = ( (Input_ModelMotionData763_g251650).x * Input_MotionPhase764_g251650 );
					half3 Small_Position1421_g251640 = ( lerpResult771_g251650 + temp_output_770_0_g251650 );
					half3 Input_PositionWO419_g251687 = Small_Position1421_g251640;
					half Input_MotionTilling321_g251687 = ( _MotionSmallTillingValue + 0.2 );
					half2 Noise_Coord979_g251687 = ( -(Input_PositionWO419_g251687).xz * Input_MotionTilling321_g251687 * 0.005 );
					float2 Input_Coords80_g251691 = Noise_Coord979_g251687;
					half2 Input_Direction82_g251691 = Input_WindDirWS803_g251687;
					float mulTime113_g251705 = _Time.y * 0.02;
					float lerpResult128_g251705 = lerp( mulTime113_g251705 , ( ( mulTime113_g251705 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					#ifdef SHADER_API_MOBILE
					float staticSwitch134_g251705 = frac( lerpResult128_g251705 );
					#else
					float staticSwitch134_g251705 = lerpResult128_g251705;
					#endif
					float Global_WindTime3262_g251640 = staticSwitch134_g251705;
					half Input_WindTime1015_g251687 = Global_WindTime3262_g251640;
					half Input_MotionSpeed62_g251687 = _MotionSmallSpeedValue;
					float temp_output_986_0_g251687 = ( Input_WindTime1015_g251687 * Input_MotionSpeed62_g251687 );
					half Noise_Speed980_g251687 = temp_output_986_0_g251687;
					float Input_Time88_g251691 = Noise_Speed980_g251687;
					float temp_output_23_0_g251691 = frac( Input_Time88_g251691 );
					float4 lerpResult39_g251691 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251691 + ( Input_Direction82_g251691 * temp_output_23_0_g251691 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251691 + ( Input_Direction82_g251691 * ( temp_output_23_0_g251691 - 1.0 ) ) ), 0.0 ) , temp_output_23_0_g251691);
					float4 temp_output_991_0_g251687 = lerpResult39_g251691;
					half2 Noise_DirWS858_g251687 = ((temp_output_991_0_g251687).rg*2.0 + -1.0);
					half Input_MotionNoise552_g251687 = _MotionSmallNoiseValue;
					float4 temp_output_3332_0_g251640 = TVE_FlowParams;
					TVEGlobalData Data15_g251666 =(TVEGlobalData)Data15_g251571;
					float Out_Dummy15_g251666 = 0.0;
					float4 Out_CoatTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251666 = float4( 0,0,0,0 );
					BreakData( Data15_g251666 , Out_Dummy15_g251666 , Out_CoatTexture15_g251666 , Out_DrawTexture15_g251666 , Out_PaintTexture15_g251666 , Out_AtmoTexture15_g251666 , Out_EffexTexture15_g251666 , Out_GlowTexture15_g251666 , Out_FormTexture15_g251666 , Out_LandTexture15_g251666 , Out_VertxTexture15_g251666 , Out_FlowTexture15_g251666 , Out_UserTexture15_g251666 );
					half4 Global_FlowTexture2668_g251640 = Out_FlowTexture15_g251666;
					#ifdef TVE_MOTION_FLOW
					float4 staticSwitch3075_g251640 = Global_FlowTexture2668_g251640;
					#else
					float4 staticSwitch3075_g251640 = temp_output_3332_0_g251640;
					#endif
					float4 temp_output_6_0_g251667 = staticSwitch3075_g251640;
					float temp_output_7_0_g251667 = _MotionFlowMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g251667 = ( temp_output_6_0_g251667 + temp_output_7_0_g251667 );
					#else
					float4 staticSwitch14_g251667 = temp_output_6_0_g251667;
					#endif
					float4 lerpResult3121_g251640 = lerp( half4( 1, 1, 1, 0 ) , staticSwitch14_g251667 , ( Motion_FlowValue3376_g251640 * TVE_IsEnabled ));
					float temp_output_3077_0_g251640 = (lerpResult3121_g251640).z;
					float temp_output_630_0_g251676 = temp_output_3077_0_g251640;
					float lerpResult853_g251676 = lerp( temp_output_630_0_g251676 , TVE_WindEditor.z , TVE_WindEditor.w);
					half Global_WindValue1855_g251640 = ( lerpResult853_g251676 * _MotionIntensityValue );
					half Input_WindValue881_g251687 = Global_WindValue1855_g251640;
					float temp_output_6_0_g251689 = Input_WindValue881_g251687;
					float lerpResult701_g251687 = lerp( 1.0 , Input_MotionNoise552_g251687 , ( temp_output_6_0_g251689 * temp_output_6_0_g251689 ));
					float2 lerpResult646_g251687 = lerp( Input_WindDirWS803_g251687 , Noise_DirWS858_g251687 , lerpResult701_g251687);
					half2 Small_DirWS817_g251687 = lerpResult646_g251687;
					float2 break823_g251687 = Small_DirWS817_g251687;
					half4 Noise_Params685_g251687 = temp_output_991_0_g251687;
					half Wind_Sinus820_g251687 = ( ((Noise_Params685_g251687).b*2.0 + -1.0) * 0.6 );
					float3 appendResult824_g251687 = (float3(break823_g251687.x , Wind_Sinus820_g251687 , break823_g251687.y));
					half3 Small_Dir918_g251687 = appendResult824_g251687;
					float temp_output_20_0_g251688 = ( 1.0 - Input_WindValue881_g251687 );
					float3 appendResult1006_g251687 = (float3(Input_WindValue881_g251687 , ( 1.0 - ( temp_output_20_0_g251688 * temp_output_20_0_g251688 ) ) , Input_WindValue881_g251687));
					half Input_MotionDelay753_g251687 = _MotionSmallDelayValue;
					float lerpResult756_g251687 = lerp( 1.0 , ( Input_WindValue881_g251687 * Input_WindValue881_g251687 ) , Input_MotionDelay753_g251687);
					half Wind_Delay815_g251687 = lerpResult756_g251687;
					half Input_MotionValue905_g251687 = _MotionSmallIntensityValue;
					float3 temp_output_883_0_g251687 = ( Small_Dir918_g251687 * appendResult1006_g251687 * Wind_Delay815_g251687 * Input_MotionValue905_g251687 );
					float2 break857_g251687 = Noise_DirWS858_g251687;
					float3 appendResult833_g251687 = (float3(break857_g251687.x , Wind_Sinus820_g251687 , break857_g251687.y));
					half3 Push_Dir919_g251687 = appendResult833_g251687;
					half Input_MotionReact924_g251687 = _MotionSmallPushValue;
					half Global_PushAlpha1504_g251640 = (lerpResult3121_g251640).w;
					half Input_PushAlpha806_g251687 = Global_PushAlpha1504_g251640;
					half Global_PushNoise2675_g251640 = temp_output_3077_0_g251640;
					half Input_PushNoise890_g251687 = Global_PushNoise2675_g251640;
					half Push_Mask914_g251687 = saturate( ( Input_PushAlpha806_g251687 * Input_PushNoise890_g251687 * Input_MotionReact924_g251687 ) );
					float3 lerpResult840_g251687 = lerp( temp_output_883_0_g251687 , ( Push_Dir919_g251687 * Input_MotionReact924_g251687 ) , Push_Mask914_g251687);
					#ifdef TVE_MOTION_FLOW
					float3 staticSwitch829_g251687 = lerpResult840_g251687;
					#else
					float3 staticSwitch829_g251687 = temp_output_883_0_g251687;
					#endif
					float3 ase_parentObjectScale = ( 1.0 / float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ) );
					half3 Small_Squash1489_g251640 = ( mul( unity_WorldToObject, float4( staticSwitch829_g251687 , 0.0 ) ).xyz * ase_parentObjectScale );
					float temp_output_17_0_g251655 = _MotionSmallMaskMode;
					float Option92_g251655 = temp_output_17_0_g251655;
					half4 Model_VertexMasks518_g251640 = Out_VertexData15_g251652;
					float4 temp_output_84_0_g251655 = Model_VertexMasks518_g251640;
					float4 ChannelA92_g251655 = temp_output_84_0_g251655;
					half4 Model_MasksData1322_g251640 = Out_MasksData15_g251652;
					float2 uv_MotionMaskTex2818_g251640 = v.texcoord.xyzw.xy;
					half4 Motion_MaskTex2819_g251640 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex2818_g251640, 0.0 );
					float3 appendResult3227_g251640 = (float3((Model_MasksData1322_g251640).xy , (Motion_MaskTex2819_g251640).g));
					float3 temp_output_85_0_g251655 = appendResult3227_g251640;
					float4 ChannelB92_g251655 = float4( temp_output_85_0_g251655 , 0.0 );
					float localSwitchChannel792_g251655 = SwitchChannel7( Option92_g251655 , ChannelA92_g251655 , ChannelB92_g251655 );
					float enc1805_g251640 = v.texcoord.xyzw.z;
					float2 localDecodeFloatToVector21805_g251640 = DecodeFloatToVector2( enc1805_g251640 );
					float2 break1804_g251640 = localDecodeFloatToVector21805_g251640;
					half Small_Mask_Legacy1806_g251640 = break1804_g251640.x;
					#ifdef TVE_LEGACY
					float staticSwitch1800_g251640 = Small_Mask_Legacy1806_g251640;
					#else
					float staticSwitch1800_g251640 = localSwitchChannel792_g251655;
					#endif
					float clampResult17_g251641 = clamp( staticSwitch1800_g251640 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251642 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g251642 = ( clampResult17_g251641 - temp_output_7_0_g251642 );
					half Small_Mask640_g251640 = saturate( ( temp_output_9_0_g251642 * _MotionSmallMaskRemap.z ) );
					float3 lerpResult3022_g251640 = lerp( float3( 1,1,1 ) , (TVE_MotionValueParams).xyz , TVE_MotionValueParams.w);
					half3 Global_MotionParams3013_g251640 = lerpResult3022_g251640;
					half3 Small_Motion789_g251640 = ( Small_Squash1489_g251640 * Small_Mask640_g251640 * (Global_MotionParams3013_g251640).y );
					#ifdef TVE_MOTION
					float3 staticSwitch495_g251640 = Small_Motion789_g251640;
					#else
					float3 staticSwitch495_g251640 = temp_cast_13;
					#endif
					float3 temp_cast_17 = (0.0).xxx;
					half3 Tiny_Position2469_g251640 = Model_PositionWO162_g251640;
					half3 Input_PositionWO419_g251706 = Tiny_Position2469_g251640;
					half Input_MotionTilling321_g251706 = ( _MotionTinyTillingValue + 0.2 );
					half2 Noise_Coord979_g251706 = ( -(Input_PositionWO419_g251706).xz * Input_MotionTilling321_g251706 * 0.005 );
					float2 Input_Coords80_g251713 = Noise_Coord979_g251706;
					half2 Input_Direction82_g251713 = float2( 0,1 );
					half Input_WindTime1015_g251706 = Global_WindTime3262_g251640;
					half Input_MotionSpeed62_g251706 = _MotionTinySpeedValue;
					float temp_output_986_0_g251706 = ( Input_WindTime1015_g251706 * Input_MotionSpeed62_g251706 );
					half Noise_Speed980_g251706 = temp_output_986_0_g251706;
					float Input_Time88_g251713 = Noise_Speed980_g251706;
					float4 temp_output_991_0_g251706 = SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251713 + ( Input_Direction82_g251713 * Input_Time88_g251713 ) ), 0.0 );
					half3 Noise_DirWS858_g251706 = ((temp_output_991_0_g251706).rgb*2.0 + -1.0);
					half Input_MotionNoise552_g251706 = _MotionTinyNoiseValue;
					float3 lerpResult646_g251706 = lerp( ( Noise_DirWS858_g251706 * v.normal ) , Noise_DirWS858_g251706 , Input_MotionNoise552_g251706);
					half3 Tiny_DirWS817_g251706 = lerpResult646_g251706;
					half Input_MotionValue905_g251706 = _MotionTinyIntensityValue;
					float mulTime113_g251719 = _Time.y * 2.0;
					float lerpResult128_g251719 = lerp( mulTime113_g251719 , ( ( mulTime113_g251719 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					#ifdef SHADER_API_MOBILE
					float staticSwitch134_g251719 = frac( lerpResult128_g251719 );
					#else
					float staticSwitch134_g251719 = lerpResult128_g251719;
					#endif
					float3 temp_output_1028_0_g251706 = ( Input_PositionWO419_g251706 + staticSwitch134_g251719 );
					float temp_output_1054_0_g251706 = SAMPLE_TEXTURE3D_LOD( _NoiseTex3D, sampler_Linear_Repeat, ( temp_output_1028_0_g251706 * ( 1.0 * 0.01 ) ), 0.0 ).r;
					float temp_output_6_0_g251709 = temp_output_1054_0_g251706;
					float temp_output_6_0_g251710 = temp_output_1054_0_g251706;
					half Input_WindValue881_g251706 = Global_WindValue1855_g251640;
					float temp_output_6_0_g251712 = Input_WindValue881_g251706;
					float lerpResult1029_g251706 = lerp( ( temp_output_6_0_g251709 * temp_output_6_0_g251709 * temp_output_6_0_g251709 * temp_output_6_0_g251709 ) , ( temp_output_6_0_g251710 * temp_output_6_0_g251710 ) , ( temp_output_6_0_g251712 * temp_output_6_0_g251712 ));
					float temp_output_20_0_g251711 = ( 1.0 - Input_WindValue881_g251706 );
					float temp_output_1030_0_g251706 = ( lerpResult1029_g251706 * ( 1.0 - ( temp_output_20_0_g251711 * temp_output_20_0_g251711 * temp_output_20_0_g251711 * temp_output_20_0_g251711 ) ) );
					half Wind_Gust1039_g251706 = temp_output_1030_0_g251706;
					float3 temp_output_883_0_g251706 = ( Tiny_DirWS817_g251706 * Input_MotionValue905_g251706 * Wind_Gust1039_g251706 );
					half3 Tiny_Squash859_g251640 = temp_output_883_0_g251706;
					float temp_output_17_0_g251656 = _MotionTinyMaskMode;
					float Option92_g251656 = temp_output_17_0_g251656;
					float4 temp_output_84_0_g251656 = Model_VertexMasks518_g251640;
					float4 ChannelA92_g251656 = temp_output_84_0_g251656;
					float3 appendResult3234_g251640 = (float3((Model_MasksData1322_g251640).xy , (Motion_MaskTex2819_g251640).b));
					float3 temp_output_85_0_g251656 = appendResult3234_g251640;
					float4 ChannelB92_g251656 = float4( temp_output_85_0_g251656 , 0.0 );
					float localSwitchChannel792_g251656 = SwitchChannel7( Option92_g251656 , ChannelA92_g251656 , ChannelB92_g251656 );
					half Tiny_Mask_Legacy1807_g251640 = break1804_g251640.y;
					#ifdef TVE_LEGACY
					float staticSwitch1810_g251640 = Tiny_Mask_Legacy1807_g251640;
					#else
					float staticSwitch1810_g251640 = localSwitchChannel792_g251656;
					#endif
					float clampResult17_g251643 = clamp( staticSwitch1810_g251640 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251644 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g251644 = ( clampResult17_g251643 - temp_output_7_0_g251644 );
					half Tiny_Mask218_g251640 = saturate( ( temp_output_9_0_g251644 * _MotionTinyMaskRemap.z ) );
					float3 Model_PositionWS1819_g251640 = Out_PositionWS15_g251652;
					half Global_DistMask1820_g251640 = ( 1.0 - saturate( ( distance( _WorldSpaceCameraPos , Model_PositionWS1819_g251640 ) / _MotionDistValue ) ) );
					half3 Tiny_Flutter1451_g251640 = ( Tiny_Squash859_g251640 * Tiny_Mask218_g251640 * Global_DistMask1820_g251640 * (Global_MotionParams3013_g251640).z );
					#ifdef TVE_MOTION
					float3 staticSwitch414_g251640 = Tiny_Flutter1451_g251640;
					#else
					float3 staticSwitch414_g251640 = temp_cast_17;
					#endif
					float4 appendResult2783_g251640 = (float4(( staticSwitch495_g251640 + staticSwitch414_g251640 ) , 0.0));
					half4 Final_TransformData1569_g251640 = ( Vertex_TransformData2743_g251640 + appendResult2783_g251640 );
					float4 In_TransformData16_g251654 = Final_TransformData1569_g251640;
					half4 Vertex_RotationData2740_g251640 = Out_RotationData15_g251653;
					half2 Input_WindDirWS803_g251677 = Global_WindDirWS2542_g251640;
					half3 Input_ModelPositionWO761_g251651 = Model_PositionWO162_g251640;
					half3 Input_ModelPivotsWO419_g251651 = Model_PivotWO402_g251640;
					half Input_MotionPivots629_g251651 = _MotionBasePivotValue;
					float3 lerpResult771_g251651 = lerp( Input_ModelPositionWO761_g251651 , Input_ModelPivotsWO419_g251651 , Input_MotionPivots629_g251651);
					half4 Input_ModelMotionData763_g251651 = Model_PhaseData489_g251640;
					half Input_MotionPhase764_g251651 = _MotionBasePhaseValue;
					float temp_output_770_0_g251651 = ( (Input_ModelMotionData763_g251651).x * Input_MotionPhase764_g251651 );
					half3 Base_Position1394_g251640 = ( lerpResult771_g251651 + temp_output_770_0_g251651 );
					half3 Input_PositionWO419_g251677 = Base_Position1394_g251640;
					half Input_MotionTilling321_g251677 = ( _MotionBaseTillingValue + 0.2 );
					half2 Noise_Coord515_g251677 = ( -(Input_PositionWO419_g251677).xz * Input_MotionTilling321_g251677 * 0.005 );
					float2 Input_Coords80_g251679 = Noise_Coord515_g251677;
					half2 Input_Direction82_g251679 = Input_WindDirWS803_g251677;
					half Input_WindTime963_g251677 = Global_WindTime3262_g251640;
					half Input_MotionSpeed62_g251677 = _MotionBaseSpeedValue;
					float temp_output_505_0_g251677 = ( Input_WindTime963_g251677 * Input_MotionSpeed62_g251677 );
					half Noise_Speed516_g251677 = temp_output_505_0_g251677;
					float Input_Time88_g251679 = Noise_Speed516_g251677;
					float temp_output_23_0_g251679 = frac( Input_Time88_g251679 );
					float4 lerpResult39_g251679 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251679 + ( Input_Direction82_g251679 * temp_output_23_0_g251679 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251679 + ( Input_Direction82_g251679 * ( temp_output_23_0_g251679 - 1.0 ) ) ), 0.0 ) , temp_output_23_0_g251679);
					float4 temp_output_635_0_g251677 = lerpResult39_g251679;
					half2 Noise_DirWS825_g251677 = ((temp_output_635_0_g251677).rg*2.0 + -1.0);
					half Input_MotionNoise552_g251677 = _MotionBaseNoiseValue;
					half Input_WindValue853_g251677 = Global_WindValue1855_g251640;
					float temp_output_6_0_g251678 = Input_WindValue853_g251677;
					float lerpResult701_g251677 = lerp( 1.0 , Input_MotionNoise552_g251677 , ( temp_output_6_0_g251678 * temp_output_6_0_g251678 ));
					float2 lerpResult646_g251677 = lerp( Input_WindDirWS803_g251677 , Noise_DirWS825_g251677 , lerpResult701_g251677);
					half2 Bend_Dir859_g251677 = lerpResult646_g251677;
					half Input_MotionValue871_g251677 = _MotionBaseIntensityValue;
					half Input_MotionDelay753_g251677 = _MotionBaseDelayValue;
					float lerpResult756_g251677 = lerp( 1.0 , ( Input_WindValue853_g251677 * Input_WindValue853_g251677 ) , Input_MotionDelay753_g251677);
					half Wind_Delay815_g251677 = lerpResult756_g251677;
					float2 temp_output_875_0_g251677 = ( Bend_Dir859_g251677 * Input_WindValue853_g251677 * Input_MotionValue871_g251677 * Wind_Delay815_g251677 );
					float2 Global_PushDirWS1972_g251640 = ((lerpResult3121_g251640).xy*2.0 + -1.0);
					half2 Input_PushDirWS807_g251677 = Global_PushDirWS1972_g251640;
					half Input_ReactValue888_g251677 = _MotionBasePushValue;
					half Input_PushAlpha806_g251677 = Global_PushAlpha1504_g251640;
					half Push_Mask883_g251677 = saturate( ( Input_PushAlpha806_g251677 * Input_ReactValue888_g251677 ) );
					float2 lerpResult811_g251677 = lerp( temp_output_875_0_g251677 , ( Input_PushDirWS807_g251677 * Input_ReactValue888_g251677 ) , Push_Mask883_g251677);
					#ifdef TVE_MOTION_FLOW
					float2 staticSwitch808_g251677 = lerpResult811_g251677;
					#else
					float2 staticSwitch808_g251677 = temp_output_875_0_g251677;
					#endif
					float2 temp_output_38_0_g251683 = staticSwitch808_g251677;
					float2 break83_g251683 = temp_output_38_0_g251683;
					float3 appendResult79_g251683 = (float3(break83_g251683.x , 0.0 , break83_g251683.y));
					half2 Base_Bending893_g251640 = (( mul( unity_WorldToObject, float4( appendResult79_g251683 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
					float temp_output_17_0_g251657 = _MotionBaseMaskMode;
					float Option92_g251657 = temp_output_17_0_g251657;
					float4 temp_output_84_0_g251657 = Model_VertexMasks518_g251640;
					float4 ChannelA92_g251657 = temp_output_84_0_g251657;
					float3 appendResult3220_g251640 = (float3((Model_MasksData1322_g251640).xy , (Motion_MaskTex2819_g251640).r));
					float3 temp_output_85_0_g251657 = appendResult3220_g251640;
					float4 ChannelB92_g251657 = float4( temp_output_85_0_g251657 , 0.0 );
					float localSwitchChannel792_g251657 = SwitchChannel7( Option92_g251657 , ChannelA92_g251657 , ChannelB92_g251657 );
					float clampResult17_g251646 = clamp( localSwitchChannel792_g251657 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251645 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g251645 = ( clampResult17_g251646 - temp_output_7_0_g251645 );
					half Base_Mask217_g251640 = saturate( ( temp_output_9_0_g251645 * _MotionBaseMaskRemap.z ) );
					half2 Base_Motion1440_g251640 = ( Base_Bending893_g251640 * Base_Mask217_g251640 * (Global_MotionParams3013_g251640).x );
					#ifdef TVE_MOTION
					float2 staticSwitch2384_g251640 = Base_Motion1440_g251640;
					#else
					float2 staticSwitch2384_g251640 = float2( 0,0 );
					#endif
					float4 appendResult2023_g251640 = (float4(staticSwitch2384_g251640 , 0.0 , 0.0));
					half4 Final_RotationData1570_g251640 = ( Vertex_RotationData2740_g251640 + appendResult2023_g251640 );
					float4 In_RotationData16_g251654 = Final_RotationData1570_g251640;
					half4 Vertex_Interpolator2773_g251640 = Out_Interpolator15_g251653;
					half4 Noise_Params685_g251677 = temp_output_635_0_g251677;
					float temp_output_6_0_g251685 = (Noise_Params685_g251677).a;
					float temp_output_913_0_g251677 = ( ( temp_output_6_0_g251685 * temp_output_6_0_g251685 * temp_output_6_0_g251685 * temp_output_6_0_g251685 ) * ( Input_WindValue853_g251677 * Wind_Delay815_g251677 ) );
					float temp_output_6_0_g251686 = length( Input_PushDirWS807_g251677 );
					float temp_output_937_0_g251677 = ( temp_output_6_0_g251686 * temp_output_6_0_g251686 );
					half Input_PushNoise858_g251677 = Global_PushNoise2675_g251640;
					float lerpResult902_g251677 = lerp( temp_output_913_0_g251677 , temp_output_937_0_g251677 , ( Push_Mask883_g251677 * Input_PushNoise858_g251677 ));
					#ifdef TVE_MOTION_FLOW
					float staticSwitch903_g251677 = lerpResult902_g251677;
					#else
					float staticSwitch903_g251677 = temp_output_913_0_g251677;
					#endif
					half Base_Wave1159_g251640 = staticSwitch903_g251677;
					float temp_output_6_0_g251690 = (Noise_Params685_g251687).a;
					float temp_output_955_0_g251687 = ( temp_output_6_0_g251690 * temp_output_6_0_g251690 * temp_output_6_0_g251690 * temp_output_6_0_g251690 );
					float temp_output_944_0_g251687 = ( temp_output_955_0_g251687 * ( Input_WindValue881_g251687 * Wind_Delay815_g251687 ) );
					float lerpResult936_g251687 = lerp( temp_output_944_0_g251687 , temp_output_955_0_g251687 , ( Push_Mask914_g251687 * Input_PushNoise890_g251687 ));
					#ifdef TVE_MOTION_FLOW
					float staticSwitch939_g251687 = lerpResult936_g251687;
					#else
					float staticSwitch939_g251687 = temp_output_944_0_g251687;
					#endif
					half Small_Wave1427_g251640 = staticSwitch939_g251687;
					float lerpResult2422_g251640 = lerp( Base_Wave1159_g251640 , Small_Wave1427_g251640 , _motion_small_mode);
					half Global_Wave1475_g251640 = saturate( lerpResult2422_g251640 );
					float temp_output_6_0_g251647 = ( _MotionHighlightValue * Global_DistMask1820_g251640 * ( Tiny_Mask218_g251640 * Tiny_Mask218_g251640 ) * Global_Wave1475_g251640 );
					float temp_output_7_0_g251647 = _MotionHighlightColor.r;
					#ifdef TVE_DUMMY
					float staticSwitch14_g251647 = ( temp_output_6_0_g251647 + temp_output_7_0_g251647 );
					#else
					float staticSwitch14_g251647 = temp_output_6_0_g251647;
					#endif
					#ifdef TVE_MOTION
					float staticSwitch2866_g251640 = staticSwitch14_g251647;
					#else
					float staticSwitch2866_g251640 = 0.0;
					#endif
					float4 appendResult2775_g251640 = (float4((Vertex_Interpolator2773_g251640).xyz , staticSwitch2866_g251640));
					half4 Final_Interpolator2774_g251640 = appendResult2775_g251640;
					float4 In_Interpolator16_g251654 = Final_Interpolator2774_g251640;
					BuildVertexData( Data16_g251654 , In_Dummy16_g251654 , In_PositionOS16_g251654 , In_NormalOS16_g251654 , In_TangentOS16_g251654 , In_TransformData16_g251654 , In_RotationData16_g251654 , In_Interpolator16_g251654 );
					TVEVertexData Data15_g251809 =(TVEVertexData)Data16_g251654;
					float Out_Dummy15_g251809 = 0.0;
					float3 Out_PositionOS15_g251809 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251809 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251809 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251809 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251809 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251809 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251809 , Out_Dummy15_g251809 , Out_PositionOS15_g251809 , Out_NormalOS15_g251809 , Out_TangentOS15_g251809 , Out_TransformData15_g251809 , Out_RotationData15_g251809 , Out_Interpolator15_g251809 );
					TVEVertexData Data16_g251810 =(TVEVertexData)Data15_g251809;
					float In_Dummy16_g251810 = 0.0;
					float3 Vertex_PositionOS147_g251800 = Out_PositionOS15_g251809;
					half3 VertexPos40_g251804 = Vertex_PositionOS147_g251800;
					float4 temp_output_1615_33_g251800 = Out_RotationData15_g251809;
					half4 Vertex_RotationData1569_g251800 = temp_output_1615_33_g251800;
					float2 break1582_g251800 = (Vertex_RotationData1569_g251800).xy;
					half Angle44_g251804 = break1582_g251800.y;
					half CosAngle89_g251804 = cos( Angle44_g251804 );
					half SinAngle93_g251804 = sin( Angle44_g251804 );
					float3 appendResult95_g251804 = (float3((VertexPos40_g251804).x , ( ( (VertexPos40_g251804).y * CosAngle89_g251804 ) - ( (VertexPos40_g251804).z * SinAngle93_g251804 ) ) , ( ( (VertexPos40_g251804).y * SinAngle93_g251804 ) + ( (VertexPos40_g251804).z * CosAngle89_g251804 ) )));
					half3 VertexPos40_g251805 = appendResult95_g251804;
					half Angle44_g251805 = -break1582_g251800.x;
					half CosAngle94_g251805 = cos( Angle44_g251805 );
					half SinAngle95_g251805 = sin( Angle44_g251805 );
					float3 appendResult98_g251805 = (float3(( ( (VertexPos40_g251805).x * CosAngle94_g251805 ) - ( (VertexPos40_g251805).y * SinAngle95_g251805 ) ) , ( ( (VertexPos40_g251805).x * SinAngle95_g251805 ) + ( (VertexPos40_g251805).y * CosAngle94_g251805 ) ) , (VertexPos40_g251805).z));
					half3 VertexPos40_g251803 = Vertex_PositionOS147_g251800;
					half Angle44_g251803 = break1582_g251800.y;
					half CosAngle89_g251803 = cos( Angle44_g251803 );
					half SinAngle93_g251803 = sin( Angle44_g251803 );
					float3 appendResult95_g251803 = (float3((VertexPos40_g251803).x , ( ( (VertexPos40_g251803).y * CosAngle89_g251803 ) - ( (VertexPos40_g251803).z * SinAngle93_g251803 ) ) , ( ( (VertexPos40_g251803).y * SinAngle93_g251803 ) + ( (VertexPos40_g251803).z * CosAngle89_g251803 ) )));
					half3 VertexPos40_g251808 = appendResult95_g251803;
					half Angle44_g251808 = break1582_g251800.x;
					half CosAngle91_g251808 = cos( Angle44_g251808 );
					half SinAngle92_g251808 = sin( Angle44_g251808 );
					float3 appendResult93_g251808 = (float3(( ( (VertexPos40_g251808).x * CosAngle91_g251808 ) + ( (VertexPos40_g251808).z * SinAngle92_g251808 ) ) , (VertexPos40_g251808).y , ( ( -(VertexPos40_g251808).x * SinAngle92_g251808 ) + ( (VertexPos40_g251808).z * CosAngle91_g251808 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251806 = appendResult93_g251808;
					#else
					float3 staticSwitch65_g251806 = appendResult98_g251805;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251801 = staticSwitch65_g251806;
					#else
					float3 staticSwitch65_g251801 = Vertex_PositionOS147_g251800;
					#endif
					float3 temp_output_1608_0_g251800 = staticSwitch65_g251801;
					half3 VertexPos40_g251807 = temp_output_1608_0_g251800;
					half Angle44_g251807 = (Vertex_RotationData1569_g251800).z;
					half CosAngle91_g251807 = cos( Angle44_g251807 );
					half SinAngle92_g251807 = sin( Angle44_g251807 );
					float3 appendResult93_g251807 = (float3(( ( (VertexPos40_g251807).x * CosAngle91_g251807 ) + ( (VertexPos40_g251807).z * SinAngle92_g251807 ) ) , (VertexPos40_g251807).y , ( ( -(VertexPos40_g251807).x * SinAngle92_g251807 ) + ( (VertexPos40_g251807).z * CosAngle91_g251807 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251802 = appendResult93_g251807;
					#else
					float3 staticSwitch65_g251802 = temp_output_1608_0_g251800;
					#endif
					float4 temp_output_1615_31_g251800 = Out_TransformData15_g251809;
					half4 Vertex_TransformData1568_g251800 = temp_output_1615_31_g251800;
					half3 Final_PositionOS178_g251800 = ( ( staticSwitch65_g251802 * (Vertex_TransformData1568_g251800).w ) + (Vertex_TransformData1568_g251800).xyz );
					float3 In_PositionOS16_g251810 = Final_PositionOS178_g251800;
					float3 In_NormalOS16_g251810 = Out_NormalOS15_g251809;
					float4 In_TangentOS16_g251810 = Out_TangentOS15_g251809;
					float4 In_TransformData16_g251810 = temp_output_1615_31_g251800;
					float4 In_RotationData16_g251810 = temp_output_1615_33_g251800;
					float4 In_Interpolator16_g251810 = Out_Interpolator15_g251809;
					BuildVertexData( Data16_g251810 , In_Dummy16_g251810 , In_PositionOS16_g251810 , In_NormalOS16_g251810 , In_TangentOS16_g251810 , In_TransformData16_g251810 , In_RotationData16_g251810 , In_Interpolator16_g251810 );
					TVEVertexData Data15_g251818 =(TVEVertexData)Data16_g251810;
					float Out_Dummy15_g251818 = 0.0;
					float3 Out_PositionOS15_g251818 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251818 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251818 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251818 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251818 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251818 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251818 , Out_Dummy15_g251818 , Out_PositionOS15_g251818 , Out_NormalOS15_g251818 , Out_TangentOS15_g251818 , Out_TransformData15_g251818 , Out_RotationData15_g251818 , Out_Interpolator15_g251818 );
					TVEVertexData Data16_g251819 =(TVEVertexData)Data15_g251818;
					float In_Dummy16_g251819 = 0.0;
					TVEModelData Data15_g251817 =(TVEModelData)Data15_g251652;
					float Out_Dummy15_g251817 = 0.0;
					float3 Out_PositionOS15_g251817 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251817 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251817 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251817 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251817 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251817 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251817 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251817 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251817 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251817 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251817 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251817 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251817 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251817 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251817 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251817 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251817 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251817 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251817 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251817 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251817 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251817 , Out_Dummy15_g251817 , Out_PositionOS15_g251817 , Out_PositionWS15_g251817 , Out_PositionWO15_g251817 , Out_PositionRawOS15_g251817 , Out_PivotOS15_g251817 , Out_PivotWS15_g251817 , Out_PivotWO15_g251817 , Out_NormalOS15_g251817 , Out_NormalWS15_g251817 , Out_NormalRawOS15_g251817 , Out_TangentOS15_g251817 , Out_TangentWS15_g251817 , Out_BitangentWS15_g251817 , Out_ViewDirWS15_g251817 , Out_CoordsData15_g251817 , Out_VertexData15_g251817 , Out_MasksData15_g251817 , Out_PhaseData15_g251817 , Out_TransformData15_g251817 , Out_RotationData15_g251817 , Out_Interpolator15_g251817 );
					float3 In_PositionOS16_g251819 = ( Out_PositionOS15_g251818 + Out_PivotOS15_g251817 );
					float3 In_NormalOS16_g251819 = Out_NormalOS15_g251818;
					float4 In_TangentOS16_g251819 = Out_TangentOS15_g251818;
					float4 In_TransformData16_g251819 = Out_TransformData15_g251818;
					float4 In_RotationData16_g251819 = Out_RotationData15_g251818;
					float4 In_Interpolator16_g251819 = Out_Interpolator15_g251818;
					BuildVertexData( Data16_g251819 , In_Dummy16_g251819 , In_PositionOS16_g251819 , In_NormalOS16_g251819 , In_TangentOS16_g251819 , In_TransformData16_g251819 , In_RotationData16_g251819 , In_Interpolator16_g251819 );
					TVEVertexData Data15_g251889 =(TVEVertexData)Data16_g251819;
					float Out_Dummy15_g251889 = 0.0;
					float3 Out_PositionOS15_g251889 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251889 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251889 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251889 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251889 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251889 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251889 , Out_Dummy15_g251889 , Out_PositionOS15_g251889 , Out_NormalOS15_g251889 , Out_TangentOS15_g251889 , Out_TransformData15_g251889 , Out_RotationData15_g251889 , Out_Interpolator15_g251889 );
					
					float3 color107_g251820 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g251820 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float localBreakData4_g251815 = ( 0.0 );
					float localBuildMasksData3_g251738 = ( 0.0 );
					TVEMasksData Data3_g251738 = (TVEMasksData)0;
					half Feature_Intensity3187_g251720 = _MotionIntensityValue;
					float ifLocalVar18_g251742 = 0;
					if( Feature_Intensity3187_g251720 <= 0.0 )
					ifLocalVar18_g251742 = 0.0;
					else
					ifLocalVar18_g251742 = 1.0;
					half Feature_Element3188_g251720 = _MotionFlowMode;
					float ifLocalVar18_g251744 = 0;
					if( Feature_Element3188_g251720 <= 0.0 )
					ifLocalVar18_g251744 = 0.0;
					else
					ifLocalVar18_g251744 = 1.0;
					float4 appendResult2992_g251720 = (float4(ifLocalVar18_g251742 , 0.0 , 0.0 , ifLocalVar18_g251744));
					float4 In_MaskA3_g251738 = appendResult2992_g251720;
					float temp_output_17_0_g251737 = _MotionBaseMaskMode;
					float Option92_g251737 = temp_output_17_0_g251737;
					TVEModelData Data15_g251574 =(TVEModelData)Data26_g241959;
					float Out_Dummy15_g251574 = 0.0;
					float3 Out_PositionOS15_g251574 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251574 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251574 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251574 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251574 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251574 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251574 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251574 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251574 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251574 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251574 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251574 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251574 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251574 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251574 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251574 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251574 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251574 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251574 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251574 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251574 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251574 , Out_Dummy15_g251574 , Out_PositionOS15_g251574 , Out_PositionWS15_g251574 , Out_PositionWO15_g251574 , Out_PositionRawOS15_g251574 , Out_PivotOS15_g251574 , Out_PivotWS15_g251574 , Out_PivotWO15_g251574 , Out_NormalOS15_g251574 , Out_NormalWS15_g251574 , Out_NormalRawOS15_g251574 , Out_TangentOS15_g251574 , Out_TangentWS15_g251574 , Out_BitangentWS15_g251574 , Out_ViewDirWS15_g251574 , Out_CoordsData15_g251574 , Out_VertexData15_g251574 , Out_MasksData15_g251574 , Out_PhaseData15_g251574 , Out_TransformData15_g251574 , Out_RotationData15_g251574 , Out_Interpolator15_g251574 );
					TVEModelData Data15_g251732 =(TVEModelData)Data15_g251574;
					float Out_Dummy15_g251732 = 0.0;
					float3 Out_PositionOS15_g251732 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251732 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251732 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251732 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251732 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251732 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251732 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251732 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251732 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251732 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251732 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251732 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251732 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251732 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251732 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251732 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251732 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251732 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251732 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251732 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251732 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251732 , Out_Dummy15_g251732 , Out_PositionOS15_g251732 , Out_PositionWS15_g251732 , Out_PositionWO15_g251732 , Out_PositionRawOS15_g251732 , Out_PivotOS15_g251732 , Out_PivotWS15_g251732 , Out_PivotWO15_g251732 , Out_NormalOS15_g251732 , Out_NormalWS15_g251732 , Out_NormalRawOS15_g251732 , Out_TangentOS15_g251732 , Out_TangentWS15_g251732 , Out_BitangentWS15_g251732 , Out_ViewDirWS15_g251732 , Out_CoordsData15_g251732 , Out_VertexData15_g251732 , Out_MasksData15_g251732 , Out_PhaseData15_g251732 , Out_TransformData15_g251732 , Out_RotationData15_g251732 , Out_Interpolator15_g251732 );
					half4 Model_VertexMasks518_g251720 = Out_VertexData15_g251732;
					float4 temp_output_84_0_g251737 = Model_VertexMasks518_g251720;
					float4 ChannelA92_g251737 = temp_output_84_0_g251737;
					half4 Model_MasksData1322_g251720 = Out_MasksData15_g251732;
					float2 uv_MotionMaskTex2818_g251720 = v.texcoord.xyzw.xy;
					half4 Motion_MaskTex2819_g251720 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex2818_g251720, 0.0 );
					float3 appendResult3220_g251720 = (float3((Model_MasksData1322_g251720).xy , (Motion_MaskTex2819_g251720).r));
					float3 temp_output_85_0_g251737 = appendResult3220_g251720;
					float4 ChannelB92_g251737 = float4( temp_output_85_0_g251737 , 0.0 );
					float localSwitchChannel792_g251737 = SwitchChannel7( Option92_g251737 , ChannelA92_g251737 , ChannelB92_g251737 );
					float clampResult17_g251726 = clamp( localSwitchChannel792_g251737 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251725 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g251725 = ( clampResult17_g251726 - temp_output_7_0_g251725 );
					half Base_Mask217_g251720 = saturate( ( temp_output_9_0_g251725 * _MotionBaseMaskRemap.z ) );
					float3 Model_PositionWO162_g251720 = Out_PositionWO15_g251732;
					half3 Input_ModelPositionWO761_g251731 = Model_PositionWO162_g251720;
					float3 Model_PivotWO402_g251720 = Out_PivotWO15_g251732;
					half3 Input_ModelPivotsWO419_g251731 = Model_PivotWO402_g251720;
					half Input_MotionPivots629_g251731 = _MotionBasePivotValue;
					float3 lerpResult771_g251731 = lerp( Input_ModelPositionWO761_g251731 , Input_ModelPivotsWO419_g251731 , Input_MotionPivots629_g251731);
					half4 Model_PhaseData489_g251720 = Out_PhaseData15_g251732;
					half4 Input_ModelMotionData763_g251731 = Model_PhaseData489_g251720;
					half Input_MotionPhase764_g251731 = _MotionBasePhaseValue;
					float temp_output_770_0_g251731 = ( (Input_ModelMotionData763_g251731).x * Input_MotionPhase764_g251731 );
					half3 Base_Position1394_g251720 = ( lerpResult771_g251731 + temp_output_770_0_g251731 );
					half3 Input_PositionWO419_g251757 = Base_Position1394_g251720;
					half Input_MotionTilling321_g251757 = ( _MotionBaseTillingValue + 0.2 );
					half2 Noise_Coord515_g251757 = ( -(Input_PositionWO419_g251757).xz * Input_MotionTilling321_g251757 * 0.005 );
					float2 Input_Coords80_g251759 = Noise_Coord515_g251757;
					half Motion_FlowValue3376_g251720 = _MotionFlowValue;
					float2 lerpResult3361_g251720 = lerp( (half4( 1, 1, 1, 0 )).xy , (TVE_WindParams).xy , ( Motion_FlowValue3376_g251720 * TVE_IsEnabled ));
					float2 Global_WindDirWS2542_g251720 = (lerpResult3361_g251720*2.0 + -1.0);
					half2 Input_WindDirWS803_g251757 = Global_WindDirWS2542_g251720;
					half2 Input_Direction82_g251759 = Input_WindDirWS803_g251757;
					float mulTime113_g251785 = _Time.y * 0.02;
					float lerpResult128_g251785 = lerp( mulTime113_g251785 , ( ( mulTime113_g251785 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					#ifdef SHADER_API_MOBILE
					float staticSwitch134_g251785 = frac( lerpResult128_g251785 );
					#else
					float staticSwitch134_g251785 = lerpResult128_g251785;
					#endif
					float Global_WindTime3262_g251720 = staticSwitch134_g251785;
					half Input_WindTime963_g251757 = Global_WindTime3262_g251720;
					half Input_MotionSpeed62_g251757 = _MotionBaseSpeedValue;
					float temp_output_505_0_g251757 = ( Input_WindTime963_g251757 * Input_MotionSpeed62_g251757 );
					half Noise_Speed516_g251757 = temp_output_505_0_g251757;
					float Input_Time88_g251759 = Noise_Speed516_g251757;
					float temp_output_23_0_g251759 = frac( Input_Time88_g251759 );
					float4 lerpResult39_g251759 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251759 + ( Input_Direction82_g251759 * temp_output_23_0_g251759 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251759 + ( Input_Direction82_g251759 * ( temp_output_23_0_g251759 - 1.0 ) ) ), 0.0 ) , temp_output_23_0_g251759);
					float4 temp_output_635_0_g251757 = lerpResult39_g251759;
					half4 Noise_Params685_g251757 = temp_output_635_0_g251757;
					half Base_Noise2949_g251720 = (Noise_Params685_g251757).g;
					half Base_Phase2971_g251720 = frac( temp_output_770_0_g251731 );
					float4 temp_output_3332_0_g251720 = TVE_FlowParams;
					TVEGlobalData Data15_g251746 =(TVEGlobalData)Data204_g241858;
					float Out_Dummy15_g251746 = 0.0;
					float4 Out_CoatTexture15_g251746 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251746 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251746 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251746 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251746 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251746 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251746 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251746 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251746 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251746 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251746 = float4( 0,0,0,0 );
					BreakData( Data15_g251746 , Out_Dummy15_g251746 , Out_CoatTexture15_g251746 , Out_DrawTexture15_g251746 , Out_PaintTexture15_g251746 , Out_AtmoTexture15_g251746 , Out_EffexTexture15_g251746 , Out_GlowTexture15_g251746 , Out_FormTexture15_g251746 , Out_LandTexture15_g251746 , Out_VertxTexture15_g251746 , Out_FlowTexture15_g251746 , Out_UserTexture15_g251746 );
					half4 Global_FlowTexture2668_g251720 = Out_FlowTexture15_g251746;
					#ifdef TVE_MOTION_FLOW
					float4 staticSwitch3075_g251720 = Global_FlowTexture2668_g251720;
					#else
					float4 staticSwitch3075_g251720 = temp_output_3332_0_g251720;
					#endif
					float4 temp_output_6_0_g251747 = staticSwitch3075_g251720;
					float temp_output_7_0_g251747 = _MotionFlowMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g251747 = ( temp_output_6_0_g251747 + temp_output_7_0_g251747 );
					#else
					float4 staticSwitch14_g251747 = temp_output_6_0_g251747;
					#endif
					float4 lerpResult3121_g251720 = lerp( half4( 1, 1, 1, 0 ) , staticSwitch14_g251747 , ( Motion_FlowValue3376_g251720 * TVE_IsEnabled ));
					half Global_PushAlpha1504_g251720 = (lerpResult3121_g251720).w;
					half Input_PushAlpha806_g251757 = Global_PushAlpha1504_g251720;
					half Input_ReactValue888_g251757 = _MotionBasePushValue;
					half Push_Mask883_g251757 = saturate( ( Input_PushAlpha806_g251757 * Input_ReactValue888_g251757 ) );
					half Base_React3000_g251720 = Push_Mask883_g251757;
					float ifLocalVar18_g251743 = 0;
					if( Feature_Element3188_g251720 <= 0.0 )
					ifLocalVar18_g251743 = 0.0;
					else
					ifLocalVar18_g251743 = Base_React3000_g251720;
					float4 appendResult2956_g251720 = (float4(Base_Mask217_g251720 , Base_Noise2949_g251720 , Base_Phase2971_g251720 , ifLocalVar18_g251743));
					float4 temp_cast_23 = (0.0).xxxx;
					float4 temp_cast_24 = (0.0).xxxx;
					float4 ifLocalVar18_g251741 = 0;
					if( Feature_Intensity3187_g251720 <= 0.0 )
					ifLocalVar18_g251741 = temp_cast_24;
					else
					ifLocalVar18_g251741 = appendResult2956_g251720;
					float4 In_MaskB3_g251738 = ifLocalVar18_g251741;
					float temp_output_17_0_g251735 = _MotionSmallMaskMode;
					float Option92_g251735 = temp_output_17_0_g251735;
					float4 temp_output_84_0_g251735 = Model_VertexMasks518_g251720;
					float4 ChannelA92_g251735 = temp_output_84_0_g251735;
					float3 appendResult3227_g251720 = (float3((Model_MasksData1322_g251720).xy , (Motion_MaskTex2819_g251720).g));
					float3 temp_output_85_0_g251735 = appendResult3227_g251720;
					float4 ChannelB92_g251735 = float4( temp_output_85_0_g251735 , 0.0 );
					float localSwitchChannel792_g251735 = SwitchChannel7( Option92_g251735 , ChannelA92_g251735 , ChannelB92_g251735 );
					float enc1805_g251720 = v.texcoord.xyzw.z;
					float2 localDecodeFloatToVector21805_g251720 = DecodeFloatToVector2( enc1805_g251720 );
					float2 break1804_g251720 = localDecodeFloatToVector21805_g251720;
					half Small_Mask_Legacy1806_g251720 = break1804_g251720.x;
					#ifdef TVE_LEGACY
					float staticSwitch1800_g251720 = Small_Mask_Legacy1806_g251720;
					#else
					float staticSwitch1800_g251720 = localSwitchChannel792_g251735;
					#endif
					float clampResult17_g251721 = clamp( staticSwitch1800_g251720 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251722 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g251722 = ( clampResult17_g251721 - temp_output_7_0_g251722 );
					half Small_Mask640_g251720 = saturate( ( temp_output_9_0_g251722 * _MotionSmallMaskRemap.z ) );
					half3 Input_ModelPositionWO761_g251730 = Model_PositionWO162_g251720;
					half3 Input_ModelPivotsWO419_g251730 = Model_PivotWO402_g251720;
					half Input_MotionPivots629_g251730 = _MotionSmallPivotValue;
					float3 lerpResult771_g251730 = lerp( Input_ModelPositionWO761_g251730 , Input_ModelPivotsWO419_g251730 , Input_MotionPivots629_g251730);
					half4 Input_ModelMotionData763_g251730 = Model_PhaseData489_g251720;
					half Input_MotionPhase764_g251730 = _MotionSmallPhaseValue;
					float temp_output_770_0_g251730 = ( (Input_ModelMotionData763_g251730).x * Input_MotionPhase764_g251730 );
					half3 Small_Position1421_g251720 = ( lerpResult771_g251730 + temp_output_770_0_g251730 );
					half3 Input_PositionWO419_g251767 = Small_Position1421_g251720;
					half Input_MotionTilling321_g251767 = ( _MotionSmallTillingValue + 0.2 );
					half2 Noise_Coord979_g251767 = ( -(Input_PositionWO419_g251767).xz * Input_MotionTilling321_g251767 * 0.005 );
					float2 Input_Coords80_g251771 = Noise_Coord979_g251767;
					half2 Input_WindDirWS803_g251767 = Global_WindDirWS2542_g251720;
					half2 Input_Direction82_g251771 = Input_WindDirWS803_g251767;
					half Input_WindTime1015_g251767 = Global_WindTime3262_g251720;
					half Input_MotionSpeed62_g251767 = _MotionSmallSpeedValue;
					float temp_output_986_0_g251767 = ( Input_WindTime1015_g251767 * Input_MotionSpeed62_g251767 );
					half Noise_Speed980_g251767 = temp_output_986_0_g251767;
					float Input_Time88_g251771 = Noise_Speed980_g251767;
					float temp_output_23_0_g251771 = frac( Input_Time88_g251771 );
					float4 lerpResult39_g251771 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251771 + ( Input_Direction82_g251771 * temp_output_23_0_g251771 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251771 + ( Input_Direction82_g251771 * ( temp_output_23_0_g251771 - 1.0 ) ) ), 0.0 ) , temp_output_23_0_g251771);
					float4 temp_output_991_0_g251767 = lerpResult39_g251771;
					half4 Noise_Params685_g251767 = temp_output_991_0_g251767;
					half Small_Noise2950_g251720 = (Noise_Params685_g251767).g;
					half Small_Phase2972_g251720 = frac( temp_output_770_0_g251730 );
					half Input_PushAlpha806_g251767 = Global_PushAlpha1504_g251720;
					float temp_output_3077_0_g251720 = (lerpResult3121_g251720).z;
					half Global_PushNoise2675_g251720 = temp_output_3077_0_g251720;
					half Input_PushNoise890_g251767 = Global_PushNoise2675_g251720;
					half Input_MotionReact924_g251767 = _MotionSmallPushValue;
					half Push_Mask914_g251767 = saturate( ( Input_PushAlpha806_g251767 * Input_PushNoise890_g251767 * Input_MotionReact924_g251767 ) );
					half Small_React3002_g251720 = Push_Mask914_g251767;
					float ifLocalVar18_g251745 = 0;
					if( Feature_Element3188_g251720 <= 0.0 )
					ifLocalVar18_g251745 = 0.0;
					else
					ifLocalVar18_g251745 = Small_React3002_g251720;
					float4 appendResult2954_g251720 = (float4(Small_Mask640_g251720 , Small_Noise2950_g251720 , Small_Phase2972_g251720 , ifLocalVar18_g251745));
					float4 temp_cast_26 = (0.0).xxxx;
					float4 temp_cast_27 = (0.0).xxxx;
					float4 ifLocalVar18_g251739 = 0;
					if( Feature_Intensity3187_g251720 <= 0.0 )
					ifLocalVar18_g251739 = temp_cast_27;
					else
					ifLocalVar18_g251739 = appendResult2954_g251720;
					float4 In_MaskC3_g251738 = ifLocalVar18_g251739;
					float temp_output_17_0_g251736 = _MotionTinyMaskMode;
					float Option92_g251736 = temp_output_17_0_g251736;
					float4 temp_output_84_0_g251736 = Model_VertexMasks518_g251720;
					float4 ChannelA92_g251736 = temp_output_84_0_g251736;
					float3 appendResult3234_g251720 = (float3((Model_MasksData1322_g251720).xy , (Motion_MaskTex2819_g251720).b));
					float3 temp_output_85_0_g251736 = appendResult3234_g251720;
					float4 ChannelB92_g251736 = float4( temp_output_85_0_g251736 , 0.0 );
					float localSwitchChannel792_g251736 = SwitchChannel7( Option92_g251736 , ChannelA92_g251736 , ChannelB92_g251736 );
					half Tiny_Mask_Legacy1807_g251720 = break1804_g251720.y;
					#ifdef TVE_LEGACY
					float staticSwitch1810_g251720 = Tiny_Mask_Legacy1807_g251720;
					#else
					float staticSwitch1810_g251720 = localSwitchChannel792_g251736;
					#endif
					float clampResult17_g251723 = clamp( staticSwitch1810_g251720 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251724 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g251724 = ( clampResult17_g251723 - temp_output_7_0_g251724 );
					half Tiny_Mask218_g251720 = saturate( ( temp_output_9_0_g251724 * _MotionTinyMaskRemap.z ) );
					half3 Tiny_Position2469_g251720 = Model_PositionWO162_g251720;
					half3 Input_PositionWO419_g251786 = Tiny_Position2469_g251720;
					half Input_MotionTilling321_g251786 = ( _MotionTinyTillingValue + 0.2 );
					half2 Noise_Coord979_g251786 = ( -(Input_PositionWO419_g251786).xz * Input_MotionTilling321_g251786 * 0.005 );
					float2 Input_Coords80_g251793 = Noise_Coord979_g251786;
					half2 Input_Direction82_g251793 = float2( 0,1 );
					half Input_WindTime1015_g251786 = Global_WindTime3262_g251720;
					half Input_MotionSpeed62_g251786 = _MotionTinySpeedValue;
					float temp_output_986_0_g251786 = ( Input_WindTime1015_g251786 * Input_MotionSpeed62_g251786 );
					half Noise_Speed980_g251786 = temp_output_986_0_g251786;
					float Input_Time88_g251793 = Noise_Speed980_g251786;
					float4 temp_output_991_0_g251786 = SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251793 + ( Input_Direction82_g251793 * Input_Time88_g251793 ) ), 0.0 );
					half4 Noise_Params685_g251786 = temp_output_991_0_g251786;
					half Tiny_Noise2967_g251720 = (Noise_Params685_g251786).g;
					float4 appendResult2975_g251720 = (float4(Tiny_Mask218_g251720 , Tiny_Noise2967_g251720 , 0.0 , 0.0));
					float4 temp_cast_29 = (0.0).xxxx;
					float4 temp_cast_30 = (0.0).xxxx;
					float4 ifLocalVar18_g251740 = 0;
					if( Feature_Intensity3187_g251720 <= 0.0 )
					ifLocalVar18_g251740 = temp_cast_30;
					else
					ifLocalVar18_g251740 = appendResult2975_g251720;
					float4 In_MaskD3_g251738 = ifLocalVar18_g251740;
					float4 temp_cast_31 = (0.0).xxxx;
					float4 In_MaskE3_g251738 = temp_cast_31;
					float4 temp_cast_32 = (0.0).xxxx;
					float4 In_MaskF3_g251738 = temp_cast_32;
					float4 temp_cast_33 = (0.0).xxxx;
					float4 In_MaskG3_g251738 = temp_cast_33;
					float4 temp_cast_34 = (0.0).xxxx;
					float4 In_MaskH3_g251738 = temp_cast_34;
					float4 temp_cast_35 = (0.0).xxxx;
					float4 In_MaskI3_g251738 = temp_cast_35;
					float4 temp_cast_36 = (0.0).xxxx;
					float4 In_MaskJ3_g251738 = temp_cast_36;
					float4 temp_cast_37 = (0.0).xxxx;
					float4 In_MaskK3_g251738 = temp_cast_37;
					float4 temp_cast_38 = (0.0).xxxx;
					float4 In_MaskL3_g251738 = temp_cast_38;
					{
					Data3_g251738.MaskA = In_MaskA3_g251738;
					Data3_g251738.MaskB = In_MaskB3_g251738;
					Data3_g251738.MaskC = In_MaskC3_g251738;
					Data3_g251738.MaskD = In_MaskD3_g251738;
					Data3_g251738.MaskE = In_MaskE3_g251738;
					Data3_g251738.MaskF = In_MaskF3_g251738;
					Data3_g251738.MaskG = In_MaskG3_g251738;
					Data3_g251738.MaskH = In_MaskH3_g251738;
					Data3_g251738.MaskI = In_MaskI3_g251738;
					Data3_g251738.MaskJ= In_MaskJ3_g251738;
					Data3_g251738.MaskK= In_MaskK3_g251738;
					Data3_g251738.MaskL = In_MaskL3_g251738;
					}
					TVEMasksData Data4_g251815 = Data3_g251738;
					float4 Out_MaskA4_g251815 = float4( 0,0,0,0 );
					float4 Out_MaskB4_g251815 = float4( 0,0,0,0 );
					float4 Out_MaskC4_g251815 = float4( 0,0,0,0 );
					float4 Out_MaskD4_g251815 = float4( 0,0,0,0 );
					float4 Out_MaskE4_g251815 = float4( 0,0,0,0 );
					float4 Out_MaskF4_g251815 = float4( 0,0,0,0 );
					float4 Out_MaskG4_g251815 = float4( 0,0,0,0 );
					float4 Out_MaskH4_g251815 = float4( 0,0,0,0 );
					{
					Out_MaskA4_g251815 = Data4_g251815.MaskA;
					Out_MaskB4_g251815 = Data4_g251815.MaskB;
					Out_MaskC4_g251815 = Data4_g251815.MaskC;
					Out_MaskD4_g251815 = Data4_g251815.MaskD;
					Out_MaskE4_g251815 = Data4_g251815.MaskE;
					Out_MaskF4_g251815 = Data4_g251815.MaskF;
					Out_MaskG4_g251815 = Data4_g251815.MaskG;
					Out_MaskH4_g251815 = Data4_g251815.MaskH;
					}
					float4 temp_output_2509_14 = Out_MaskA4_g251815;
					float3 lerpResult2568 = lerp( color107_g251820 , color106_g251820 , (temp_output_2509_14).x);
					float3 ifLocalVar40_g251836 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g251836 = lerpResult2568;
					float4 temp_output_2509_0 = Out_MaskB4_g251815;
					float3 ifLocalVar40_g251822 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g251822 = (temp_output_2509_0).xxx;
					float3 ifLocalVar40_g251823 = 0;
					if( TVE_DEBUG_Index == 3.0 )
					ifLocalVar40_g251823 = (temp_output_2509_0).yyy;
					float3 ifLocalVar40_g251831 = 0;
					if( TVE_DEBUG_Index == 4.0 )
					ifLocalVar40_g251831 = (temp_output_2509_0).zzz;
					float3 hsvTorgb2613 = HSVToRGB( float3((temp_output_2509_0).z,1.0,1.0) );
					float3 gammaToLinear2614 = GammaToLinearSpace( hsvTorgb2613 );
					float3 ifLocalVar40_g251832 = 0;
					if( TVE_DEBUG_Index == 5.0 )
					ifLocalVar40_g251832 = gammaToLinear2614;
					float3 ifLocalVar40_g251833 = 0;
					if( TVE_DEBUG_Index == 6.0 )
					ifLocalVar40_g251833 = (temp_output_2509_0).www;
					float4 temp_output_2509_23 = Out_MaskC4_g251815;
					float3 ifLocalVar40_g251824 = 0;
					if( TVE_DEBUG_Index == 8.0 )
					ifLocalVar40_g251824 = (temp_output_2509_23).xxx;
					float3 ifLocalVar40_g251825 = 0;
					if( TVE_DEBUG_Index == 9.0 )
					ifLocalVar40_g251825 = (temp_output_2509_23).yyy;
					float3 ifLocalVar40_g251826 = 0;
					if( TVE_DEBUG_Index == 10.0 )
					ifLocalVar40_g251826 = (temp_output_2509_23).zzz;
					float3 hsvTorgb2618 = HSVToRGB( float3((temp_output_2509_23).z,1.0,1.0) );
					float3 gammaToLinear2619 = GammaToLinearSpace( hsvTorgb2618 );
					float3 ifLocalVar40_g251827 = 0;
					if( TVE_DEBUG_Index == 11.0 )
					ifLocalVar40_g251827 = gammaToLinear2619;
					float3 ifLocalVar40_g251828 = 0;
					if( TVE_DEBUG_Index == 12.0 )
					ifLocalVar40_g251828 = (temp_output_2509_23).www;
					float4 temp_output_2509_5 = Out_MaskD4_g251815;
					float3 ifLocalVar40_g251829 = 0;
					if( TVE_DEBUG_Index == 14.0 )
					ifLocalVar40_g251829 = (temp_output_2509_5).xxx;
					float3 ifLocalVar40_g251830 = 0;
					if( TVE_DEBUG_Index == 15.0 )
					ifLocalVar40_g251830 = (temp_output_2509_5).yyy;
					float3 color107_g251811 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g251811 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2571 = lerp( color107_g251811 , color106_g251811 , (temp_output_2509_14).z);
					float3 ifLocalVar40_g251834 = 0;
					if( TVE_DEBUG_Index == 17.0 )
					ifLocalVar40_g251834 = lerpResult2571;
					float3 color107_g251813 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g251813 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2641 = lerp( color107_g251813 , color106_g251813 , (temp_output_2509_14).w);
					float3 ifLocalVar40_g251835 = 0;
					if( TVE_DEBUG_Index == 18.0 )
					ifLocalVar40_g251835 = lerpResult2641;
					float3 vertexToFrag2524 = ( ifLocalVar40_g251836 + ( ifLocalVar40_g251822 + ifLocalVar40_g251823 + ifLocalVar40_g251831 + ifLocalVar40_g251832 + ifLocalVar40_g251833 ) + ( ifLocalVar40_g251824 + ifLocalVar40_g251825 + ifLocalVar40_g251826 + ifLocalVar40_g251827 + ifLocalVar40_g251828 ) + ( ifLocalVar40_g251829 + ifLocalVar40_g251830 + ifLocalVar40_g251834 + ifLocalVar40_g251835 ) );
					o.ase_texcoord6.xyz = vertexToFrag2524;
					float3 vertexPos57_g251881 = v.vertex.xyz;
					float4 ase_positionCS57_g251881 = UnityObjectToClipPos( vertexPos57_g251881 );
					o.ase_texcoord7 = ase_positionCS57_g251881;
					o.ase_texcoord8.xyz = vertexToFrag73_g241838;
					o.ase_texcoord9.xyz = vertexToFrag76_g241838;
					TVEVertexData Data1902_g251837 = Data16_g251819;
					float4 Out_Interpolator1902_g251837 = float4( 0,0,0,0 );
					{
					Out_Interpolator1902_g251837 = Data1902_g251837.Interpolator;
					}
					float4 vertexToFrag1901_g251837 = Out_Interpolator1902_g251837;
					o.ase_texcoord12 = vertexToFrag1901_g251837;
					
					o.ase_texcoord10 = v.texcoord.xyzw;
					o.ase_texcoord11.xy = v.texcoord2.xyzw.xy;
					o.ase_color = v.ase_color;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord6.w = 0;
					o.ase_texcoord8.w = 0;
					o.ase_texcoord9.w = 0;
					o.ase_texcoord11.zw = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251889;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251889;
					v.tangent = Out_TangentOS15_g251889;

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
					
					float3 color130_g251881 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g251881 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g251883 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g251882 = ( temp_cast_4 * ( 0.5 + appendResult128_g251883 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g251882 = (float4(ddx( FinalUV13_g251882 ) , ddy( FinalUV13_g251882 )));
					float4 UVDerivatives17_g251882 = appendResult16_g251882;
					float4 break28_g251882 = UVDerivatives17_g251882;
					float2 appendResult19_g251882 = (float2(break28_g251882.x , break28_g251882.z));
					float2 appendResult20_g251882 = (float2(break28_g251882.x , break28_g251882.z));
					float dotResult24_g251882 = dot( appendResult19_g251882 , appendResult20_g251882 );
					float2 appendResult21_g251882 = (float2(break28_g251882.y , break28_g251882.w));
					float2 appendResult22_g251882 = (float2(break28_g251882.y , break28_g251882.w));
					float dotResult23_g251882 = dot( appendResult21_g251882 , appendResult22_g251882 );
					float2 appendResult25_g251882 = (float2(dotResult24_g251882 , dotResult23_g251882));
					float2 derivativesLength29_g251882 = sqrt( appendResult25_g251882 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g251882 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g251882 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g251882 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g251882 = clampResult57_g251882;
					float2 break55_g251882 = derivativesLength29_g251882;
					float4 lerpResult73_g251882 = lerp( float4( color130_g251881 , 0.0 ) , float4( color81_g251881 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g251882.x * break71_g251882.y * sqrt( saturate( ( 1.1 - max( break55_g251882.x, break55_g251882.y ) ) ) ) ) ) ));
					float3 vertexToFrag2524 = IN.ase_texcoord6.xyz;
					half3 Final_Debug2399 = vertexToFrag2524;
					float temp_output_7_0_g251888 = TVE_DEBUG_Min;
					float3 temp_cast_9 = (temp_output_7_0_g251888).xxx;
					float3 temp_output_9_0_g251888 = ( Final_Debug2399 - temp_cast_9 );
					float lerpResult76_g251881 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g251881 = lerpResult76_g251881;
					float3 lerpResult72_g251881 = lerp( (lerpResult73_g251882).rgb , saturate( ( temp_output_9_0_g251888 / ( ( TVE_DEBUG_Max - temp_output_7_0_g251888 ) + 0.0001 ) ) ) , Filter152_g251881);
					float dotResult61_g251881 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g251881 = ( 1.0 - saturate( dotResult61_g251881 ) );
					float Shading_Fresnel59_g251881 = (( 1.0 - ( temp_output_65_0_g251881 * temp_output_65_0_g251881 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g251881 = IN.ase_texcoord7;
					float depthLinearEye57_g251881 = LinearEyeDepth( ase_positionCS57_g251881.z / ase_positionCS57_g251881.w );
					float temp_output_69_0_g251881 = saturate(  (0.0 + ( depthLinearEye57_g251881 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g251881 = (( temp_output_69_0_g251881 * temp_output_69_0_g251881 )*0.5 + 0.5);
					float lerpResult84_g251881 = lerp( 1.0 , Shading_Fresnel59_g251881 , ( Shading_Distance58_g251881 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g251886 = ( 0.0 );
					float localBuildVisualData3_g251843 = ( 0.0 );
					float localBuildVisualData3_g251838 = ( 0.0 );
					TVEVisualData Data3_g251838 =(TVEVisualData)0;
					float temp_output_14_0_g251838 = 0.0;
					float In_Dummy3_g251838 = temp_output_14_0_g251838;
					float3 temp_cast_10 = (0.5).xxx;
					float3 temp_output_4_0_g251838 = temp_cast_10;
					float3 In_Albedo3_g251838 = temp_output_4_0_g251838;
					float3 temp_cast_11 = (0.5).xxx;
					float3 temp_output_44_0_g251838 = temp_cast_11;
					float3 In_AlbedoBase3_g251838 = temp_output_44_0_g251838;
					float2 temp_cast_12 = (0.0).xx;
					float2 In_NormalTS3_g251838 = temp_cast_12;
					float3 temp_cast_13 = (0.5).xxx;
					float3 In_NormalWS3_g251838 = temp_cast_13;
					float4 In_Shader3_g251838 = half4( 0, 1, 0, 1 );
					float4 In_Feature3_g251838 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251838 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251838 = half4( 1, 1, 1, 1 );
					float temp_output_12_0_g251838 = 0.5;
					float In_Grayscale3_g251838 = temp_output_12_0_g251838;
					float temp_output_16_0_g251838 = 1.0;
					float In_Luminosity3_g251838 = temp_output_16_0_g251838;
					float In_MultiMask3_g251838 = 1.0;
					float In_AlphaClip3_g251838 = 1.0;
					float In_AlphaFade3_g251838 = 1.0;
					float3 temp_cast_14 = (1.0).xxx;
					float3 In_Translucency3_g251838 = temp_cast_14;
					float In_Transmission3_g251838 = 1.0;
					float In_Thickness3_g251838 = 0.0;
					float In_Diffusion3_g251838 = 0.0;
					float In_Depth3_g251838 = 0.0;
					BuildVisualData( Data3_g251838 , In_Dummy3_g251838 , In_Albedo3_g251838 , In_AlbedoBase3_g251838 , In_NormalTS3_g251838 , In_NormalWS3_g251838 , In_Shader3_g251838 , In_Feature3_g251838 , In_Season3_g251838 , In_Emissive3_g251838 , In_Grayscale3_g251838 , In_Luminosity3_g251838 , In_MultiMask3_g251838 , In_AlphaClip3_g251838 , In_AlphaFade3_g251838 , In_Translucency3_g251838 , In_Transmission3_g251838 , In_Thickness3_g251838 , In_Diffusion3_g251838 , In_Depth3_g251838 );
					TVEVisualData Data3_g251843 =(TVEVisualData)Data3_g251838;
					half Dummy130_g251841 = ( _MainCategory + _MainEnd );
					float temp_output_14_0_g251843 = Dummy130_g251841;
					float In_Dummy3_g251843 = temp_output_14_0_g251843;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251864) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g251846 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g251846 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g251846 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g251846 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g251846 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g251846 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g251864 = staticSwitch36_g251846;
					float localBreakTextureData456_g251864 = ( 0.0 );
					float localBuildTextureData431_g251863 = ( 0.0 );
					TVEMasksData Data431_g251863 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g251863 = ( 0.0 );
					float4 temp_output_6_0_g251879 = _main_coord_value;
					float4 temp_output_7_0_g251879 = ( _MainSampleMode + _MainCoordMode + _MainCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g251879 = ( temp_output_6_0_g251879 + temp_output_7_0_g251879 );
					#else
					float4 staticSwitch14_g251879 = temp_output_6_0_g251879;
					#endif
					half4 Local_Coords180_g251841 = staticSwitch14_g251879;
					float4 Coords444_g251863 = Local_Coords180_g251841;
					float localIfModelDataByShader26_g241817 = ( 0.0 );
					TVEModelData Data26_g241817 = (TVEModelData)0;
					TVEModelData Data16_g241846 =(TVEModelData)0;
					float In_Dummy16_g241846 = 0.0;
					float3 vertexToFrag73_g241838 = IN.ase_texcoord8.xyz;
					float3 PositionWS122_g241838 = vertexToFrag73_g241838;
					float3 In_PositionWS16_g241846 = PositionWS122_g241838;
					float3 vertexToFrag76_g241838 = IN.ase_texcoord9.xyz;
					float3 PivotWS121_g241838 = vertexToFrag76_g241838;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241838 = ( PositionWS122_g241838 - PivotWS121_g241838 );
					#else
					float3 staticSwitch204_g241838 = PositionWS122_g241838;
					#endif
					float3 PositionWO132_g241838 = ( staticSwitch204_g241838 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241846 = PositionWO132_g241838;
					float3 In_PivotWS16_g241846 = PivotWS121_g241838;
					float3 PivotWO133_g241838 = ( PivotWS121_g241838 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241846 = PivotWO133_g241838;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g241838 = normalizedWorldNormal;
					float3 In_NormalWS16_g241846 = NormalWS95_g241838;
					half3 TangentWS136_g241838 = TangentWS;
					float3 In_TangentWS16_g241846 = TangentWS136_g241838;
					half3 BiangentWS421_g241838 = BitangentWS;
					float3 In_BitangentWS16_g241846 = BiangentWS421_g241838;
					half3 NormalWS427_g241838 = NormalWS95_g241838;
					half3 localComputeTriplanarMasks427_g241838 = ComputeTriplanarMasks( NormalWS427_g241838 );
					half3 TriplanarWeights429_g241838 = localComputeTriplanarMasks427_g241838;
					float3 In_TriplanarWeights16_g241846 = TriplanarWeights429_g241838;
					float3 normalizeResult296_g241838 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241838 ) );
					half3 ViewDirWS169_g241838 = normalizeResult296_g241838;
					float3 In_ViewDirWS16_g241846 = ViewDirWS169_g241838;
					float4 appendResult397_g241838 = (float4(IN.ase_texcoord10.xy , IN.ase_texcoord11.xy));
					float4 CoordsData398_g241838 = appendResult397_g241838;
					float4 In_CoordsData16_g241846 = CoordsData398_g241838;
					half4 VertexMasks171_g241838 = IN.ase_color;
					float4 In_VertexData16_g241846 = VertexMasks171_g241838;
					float temp_output_17_0_g241849 = _ObjectPhaseMode;
					float Option70_g241849 = temp_output_17_0_g241849;
					float4 temp_output_3_0_g241849 = IN.ase_color;
					float4 Channel70_g241849 = temp_output_3_0_g241849;
					float localSwitchChannel470_g241849 = SwitchChannel4( Option70_g241849 , Channel70_g241849 );
					half Phase_Value372_g241838 = localSwitchChannel470_g241849;
					float3 break319_g241838 = PivotWO133_g241838;
					half Pivot_Position322_g241838 = ( break319_g241838.x + break319_g241838.z );
					half Phase_Position357_g241838 = ( Phase_Value372_g241838 + Pivot_Position322_g241838 );
					float temp_output_248_0_g241838 = frac( Phase_Position357_g241838 );
					float4 appendResult177_g241838 = (float4((frac( ( Phase_Position357_g241838 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g241838));
					half4 Phase_Data176_g241838 = appendResult177_g241838;
					float4 In_Interpolator16_g241846 = Phase_Data176_g241838;
					BuildModelFragData( Data16_g241846 , In_Dummy16_g241846 , In_PositionWS16_g241846 , In_PositionWO16_g241846 , In_PivotWS16_g241846 , In_PivotWO16_g241846 , In_NormalWS16_g241846 , In_TangentWS16_g241846 , In_BitangentWS16_g241846 , In_TriplanarWeights16_g241846 , In_ViewDirWS16_g241846 , In_CoordsData16_g241846 , In_VertexData16_g241846 , In_Interpolator16_g241846 );
					TVEModelData DataDefault26_g241817 = Data16_g241846;
					TVEModelData DataGeneral26_g241817 = Data16_g241846;
					TVEModelData DataBlanket26_g241817 = Data16_g241846;
					TVEModelData DataImpostor26_g241817 = Data16_g241846;
					TVEModelData Data16_g241826 =(TVEModelData)0;
					float In_Dummy16_g241826 = 0.0;
					float3 temp_output_104_7_g241818 = PositionWS;
					float3 PositionWS122_g241818 = temp_output_104_7_g241818;
					float3 In_PositionWS16_g241826 = PositionWS122_g241818;
					float4x4 break19_g241821 = unity_ObjectToWorld;
					float3 appendResult20_g241821 = (float3(break19_g241821[ 0 ][ 3 ] , break19_g241821[ 1 ][ 3 ] , break19_g241821[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241818 = appendResult20_g241821;
					float3 PivotWS121_g241818 = temp_output_340_7_g241818;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241818 = ( PositionWS122_g241818 - PivotWS121_g241818 );
					#else
					float3 staticSwitch204_g241818 = PositionWS122_g241818;
					#endif
					float3 PositionWO132_g241818 = ( staticSwitch204_g241818 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241826 = PositionWO132_g241818;
					float3 In_PivotWS16_g241826 = PivotWS121_g241818;
					float3 PivotWO133_g241818 = ( PivotWS121_g241818 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241826 = PivotWO133_g241818;
					half3 NormalWS95_g241818 = normalizedWorldNormal;
					float3 In_NormalWS16_g241826 = NormalWS95_g241818;
					half3 TangentWS136_g241818 = TangentWS;
					float3 In_TangentWS16_g241826 = TangentWS136_g241818;
					half3 BiangentWS421_g241818 = BitangentWS;
					float3 In_BitangentWS16_g241826 = BiangentWS421_g241818;
					half3 NormalWS427_g241818 = NormalWS95_g241818;
					half3 localComputeTriplanarMasks427_g241818 = ComputeTriplanarMasks( NormalWS427_g241818 );
					half3 TriplanarWeights429_g241818 = localComputeTriplanarMasks427_g241818;
					float3 In_TriplanarWeights16_g241826 = TriplanarWeights429_g241818;
					float3 normalizeResult296_g241818 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241818 ) );
					half3 ViewDirWS169_g241818 = normalizeResult296_g241818;
					float3 In_ViewDirWS16_g241826 = ViewDirWS169_g241818;
					float4 appendResult397_g241818 = (float4(IN.ase_texcoord10.xy , IN.ase_texcoord11.xy));
					float4 CoordsData398_g241818 = appendResult397_g241818;
					float4 In_CoordsData16_g241826 = CoordsData398_g241818;
					half4 VertexMasks171_g241818 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241826 = VertexMasks171_g241818;
					half4 Phase_Data176_g241818 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g241826 = Phase_Data176_g241818;
					BuildModelFragData( Data16_g241826 , In_Dummy16_g241826 , In_PositionWS16_g241826 , In_PositionWO16_g241826 , In_PivotWS16_g241826 , In_PivotWO16_g241826 , In_NormalWS16_g241826 , In_TangentWS16_g241826 , In_BitangentWS16_g241826 , In_TriplanarWeights16_g241826 , In_ViewDirWS16_g241826 , In_CoordsData16_g241826 , In_VertexData16_g241826 , In_Interpolator16_g241826 );
					TVEModelData DataTerrain26_g241817 = Data16_g241826;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g241817 = IsShaderType2637;
					{
					if (Type26_g241817 == 0 )
					{
					Data26_g241817 = DataDefault26_g241817;
					}
					else if (Type26_g241817 == 1 )
					{
					Data26_g241817 = DataGeneral26_g241817;
					}
					else if (Type26_g241817 == 2 )
					{
					Data26_g241817 = DataBlanket26_g241817;
					}
					else if (Type26_g241817 == 3 )
					{
					Data26_g241817 = DataImpostor26_g241817;
					}
					else if (Type26_g241817 == 4 )
					{
					Data26_g241817 = DataTerrain26_g241817;
					}
					}
					TVEModelData Data15_g251839 =(TVEModelData)Data26_g241817;
					float Out_Dummy15_g251839 = 0.0;
					float3 Out_PositionWS15_g251839 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251839 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251839 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251839 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251839 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251839 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251839 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251839 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251839 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251839 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251839 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251839 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251839 , Out_Dummy15_g251839 , Out_PositionWS15_g251839 , Out_PositionWO15_g251839 , Out_PivotWS15_g251839 , Out_PivotWO15_g251839 , Out_NormalWS15_g251839 , Out_TangentWS15_g251839 , Out_BitangentWS15_g251839 , Out_TriplanarWeights15_g251839 , Out_ViewDirWS15_g251839 , Out_CoordsData15_g251839 , Out_VertexData15_g251839 , Out_Interpolator15_g251839 );
					TVEModelData Data16_g251840 =(TVEModelData)Data15_g251839;
					float In_Dummy16_g251840 = Out_Dummy15_g251839;
					float3 In_PositionWS16_g251840 = Out_PositionWS15_g251839;
					float3 In_PositionWO16_g251840 = Out_PositionWO15_g251839;
					float3 In_PivotWS16_g251840 = Out_PivotWS15_g251839;
					float3 In_PivotWO16_g251840 = Out_PivotWO15_g251839;
					float3 In_NormalWS16_g251840 = Out_NormalWS15_g251839;
					float3 In_TangentWS16_g251840 = Out_TangentWS15_g251839;
					float3 In_BitangentWS16_g251840 = Out_BitangentWS15_g251839;
					float3 In_TriplanarWeights16_g251840 = Out_TriplanarWeights15_g251839;
					float3 In_ViewDirWS16_g251840 = Out_ViewDirWS15_g251839;
					float4 In_CoordsData16_g251840 = Out_CoordsData15_g251839;
					float4 In_VertexData16_g251840 = Out_VertexData15_g251839;
					float4 vertexToFrag1901_g251837 = IN.ase_texcoord12;
					float4 In_Interpolator16_g251840 = vertexToFrag1901_g251837;
					BuildModelFragData( Data16_g251840 , In_Dummy16_g251840 , In_PositionWS16_g251840 , In_PositionWO16_g251840 , In_PivotWS16_g251840 , In_PivotWO16_g251840 , In_NormalWS16_g251840 , In_TangentWS16_g251840 , In_BitangentWS16_g251840 , In_TriplanarWeights16_g251840 , In_ViewDirWS16_g251840 , In_CoordsData16_g251840 , In_VertexData16_g251840 , In_Interpolator16_g251840 );
					TVEModelData Data15_g251842 =(TVEModelData)Data16_g251840;
					float Out_Dummy15_g251842 = 0.0;
					float3 Out_PositionWS15_g251842 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251842 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251842 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251842 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251842 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251842 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251842 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251842 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251842 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251842 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251842 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251842 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251842 , Out_Dummy15_g251842 , Out_PositionWS15_g251842 , Out_PositionWO15_g251842 , Out_PivotWS15_g251842 , Out_PivotWO15_g251842 , Out_NormalWS15_g251842 , Out_TangentWS15_g251842 , Out_BitangentWS15_g251842 , Out_TriplanarWeights15_g251842 , Out_ViewDirWS15_g251842 , Out_CoordsData15_g251842 , Out_VertexData15_g251842 , Out_Interpolator15_g251842 );
					float4 Model_CoordsData324_g251841 = Out_CoordsData15_g251842;
					float4 MeshCoords444_g251863 = Model_CoordsData324_g251841;
					float2 UV0444_g251863 = float2( 0,0 );
					float2 UV3444_g251863 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g251863 , MeshCoords444_g251863 , UV0444_g251863 , UV3444_g251863 );
					float4 appendResult430_g251863 = (float4(UV0444_g251863 , UV3444_g251863));
					float4 In_MaskA431_g251863 = appendResult430_g251863;
					float localComputeWorldCoords315_g251863 = ( 0.0 );
					float4 Coords315_g251863 = Local_Coords180_g251841;
					float3 Model_PositionWO222_g251841 = Out_PositionWO15_g251842;
					float3 PositionWS315_g251863 = Model_PositionWO222_g251841;
					float2 ZY315_g251863 = float2( 0,0 );
					float2 XZ315_g251863 = float2( 0,0 );
					float2 XY315_g251863 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g251863 , PositionWS315_g251863 , ZY315_g251863 , XZ315_g251863 , XY315_g251863 );
					float2 ZY402_g251863 = ZY315_g251863;
					float2 XZ403_g251863 = XZ315_g251863;
					float4 appendResult432_g251863 = (float4(ZY402_g251863 , XZ403_g251863));
					float4 In_MaskB431_g251863 = appendResult432_g251863;
					float2 XY404_g251863 = XY315_g251863;
					float localComputeStochasticCoords409_g251863 = ( 0.0 );
					float2 UV409_g251863 = ZY402_g251863;
					float2 UV1409_g251863 = float2( 0,0 );
					float2 UV2409_g251863 = float2( 0,0 );
					float2 UV3409_g251863 = float2( 0,0 );
					float3 Weights409_g251863 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g251863 , UV1409_g251863 , UV2409_g251863 , UV3409_g251863 , Weights409_g251863 );
					float4 appendResult433_g251863 = (float4(XY404_g251863 , UV1409_g251863));
					float4 In_MaskC431_g251863 = appendResult433_g251863;
					float4 appendResult434_g251863 = (float4(UV2409_g251863 , UV3409_g251863));
					float4 In_MaskD431_g251863 = appendResult434_g251863;
					float localComputeStochasticCoords422_g251863 = ( 0.0 );
					float2 UV422_g251863 = XZ403_g251863;
					float2 UV1422_g251863 = float2( 0,0 );
					float2 UV2422_g251863 = float2( 0,0 );
					float2 UV3422_g251863 = float2( 0,0 );
					float3 Weights422_g251863 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g251863 , UV1422_g251863 , UV2422_g251863 , UV3422_g251863 , Weights422_g251863 );
					float4 appendResult435_g251863 = (float4(UV1422_g251863 , UV2422_g251863));
					float4 In_MaskE431_g251863 = appendResult435_g251863;
					float localComputeStochasticCoords423_g251863 = ( 0.0 );
					float2 UV423_g251863 = XY404_g251863;
					float2 UV1423_g251863 = float2( 0,0 );
					float2 UV2423_g251863 = float2( 0,0 );
					float2 UV3423_g251863 = float2( 0,0 );
					float3 Weights423_g251863 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g251863 , UV1423_g251863 , UV2423_g251863 , UV3423_g251863 , Weights423_g251863 );
					float4 appendResult436_g251863 = (float4(UV3422_g251863 , UV1423_g251863));
					float4 In_MaskF431_g251863 = appendResult436_g251863;
					float4 appendResult437_g251863 = (float4(UV2423_g251863 , UV3423_g251863));
					float4 In_MaskG431_g251863 = appendResult437_g251863;
					float4 In_MaskH431_g251863 = float4( Weights409_g251863 , 0.0 );
					float4 In_MaskI431_g251863 = float4( Weights422_g251863 , 0.0 );
					float4 In_MaskJ431_g251863 = float4( Weights423_g251863 , 0.0 );
					half3 Model_NormalWS226_g251841 = Out_NormalWS15_g251842;
					float3 temp_output_449_0_g251863 = Model_NormalWS226_g251841;
					float4 In_MaskK431_g251863 = float4( temp_output_449_0_g251863 , 0.0 );
					half3 Model_TangentWS366_g251841 = Out_TangentWS15_g251842;
					float3 temp_output_450_0_g251863 = Model_TangentWS366_g251841;
					float4 In_MaskL431_g251863 = float4( temp_output_450_0_g251863 , 0.0 );
					half3 Model_BitangentWS367_g251841 = Out_BitangentWS15_g251842;
					float3 temp_output_451_0_g251863 = Model_BitangentWS367_g251841;
					float4 In_MaskM431_g251863 = float4( temp_output_451_0_g251863 , 0.0 );
					half3 Model_TriplanarWeights368_g251841 = Out_TriplanarWeights15_g251842;
					float3 temp_output_445_0_g251863 = Model_TriplanarWeights368_g251841;
					float4 In_MaskN431_g251863 = float4( temp_output_445_0_g251863 , 0.0 );
					BuildTextureData( Data431_g251863 , In_MaskA431_g251863 , In_MaskB431_g251863 , In_MaskC431_g251863 , In_MaskD431_g251863 , In_MaskE431_g251863 , In_MaskF431_g251863 , In_MaskG431_g251863 , In_MaskH431_g251863 , In_MaskI431_g251863 , In_MaskJ431_g251863 , In_MaskK431_g251863 , In_MaskL431_g251863 , In_MaskM431_g251863 , In_MaskN431_g251863 );
					TVEMasksData Data456_g251864 =(TVEMasksData)Data431_g251863;
					float4 Out_MaskA456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251864 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251864 , Out_MaskA456_g251864 , Out_MaskB456_g251864 , Out_MaskC456_g251864 , Out_MaskD456_g251864 , Out_MaskE456_g251864 , Out_MaskF456_g251864 , Out_MaskG456_g251864 , Out_MaskH456_g251864 , Out_MaskI456_g251864 , Out_MaskJ456_g251864 , Out_MaskK456_g251864 , Out_MaskL456_g251864 , Out_MaskM456_g251864 , Out_MaskN456_g251864 );
					half2 UV276_g251864 = (Out_MaskA456_g251864).xy;
					float temp_output_504_0_g251864 = 0.0;
					half Bias276_g251864 = temp_output_504_0_g251864;
					half2 Normal276_g251864 = float2( 0,0 );
					half4 localSampleCoord276_g251864 = SampleCoord( Texture276_g251864 , Sampler276_g251864 , UV276_g251864 , Bias276_g251864 , Normal276_g251864 );
					float4 temp_output_407_277_g251841 = localSampleCoord276_g251864;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251864) = _MainAlbedoTex;
					SamplerState Sampler502_g251864 = staticSwitch36_g251846;
					half2 UV502_g251864 = (Out_MaskA456_g251864).zw;
					half Bias502_g251864 = temp_output_504_0_g251864;
					half2 Normal502_g251864 = float2( 0,0 );
					half4 localSampleCoord502_g251864 = SampleCoord( Texture502_g251864 , Sampler502_g251864 , UV502_g251864 , Bias502_g251864 , Normal502_g251864 );
					float4 temp_output_407_278_g251841 = localSampleCoord502_g251864;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251864) = _MainAlbedoTex;
					SamplerState Sampler496_g251864 = staticSwitch36_g251846;
					float2 temp_output_463_0_g251864 = (Out_MaskB456_g251864).zw;
					half2 XZ496_g251864 = temp_output_463_0_g251864;
					half Bias496_g251864 = temp_output_504_0_g251864;
					half3 NormalWS512_g251864 = (Out_MaskK456_g251864).xyz;
					half3 NormalWS496_g251864 = NormalWS512_g251864;
					half3 Normal496_g251864 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251864 = SamplePlanar2D( Texture496_g251864 , Sampler496_g251864 , XZ496_g251864 , Bias496_g251864 , NormalWS496_g251864 , Normal496_g251864 );
					float4 temp_output_407_0_g251841 = localSamplePlanar2D496_g251864;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251864) = _MainAlbedoTex;
					SamplerState Sampler490_g251864 = staticSwitch36_g251846;
					float2 temp_output_462_0_g251864 = (Out_MaskB456_g251864).xy;
					half2 ZY490_g251864 = temp_output_462_0_g251864;
					half2 XZ490_g251864 = temp_output_463_0_g251864;
					float2 temp_output_464_0_g251864 = (Out_MaskC456_g251864).xy;
					half2 XY490_g251864 = temp_output_464_0_g251864;
					half Bias490_g251864 = temp_output_504_0_g251864;
					half3 Triplanar522_g251864 = (Out_MaskN456_g251864).xyz;
					half3 Triplanar490_g251864 = Triplanar522_g251864;
					half3 NormalWS490_g251864 = NormalWS512_g251864;
					half3 Normal490_g251864 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251864 = SamplePlanar3D( Texture490_g251864 , Sampler490_g251864 , ZY490_g251864 , XZ490_g251864 , XY490_g251864 , Bias490_g251864 , Triplanar490_g251864 , NormalWS490_g251864 , Normal490_g251864 );
					float4 temp_output_407_201_g251841 = localSamplePlanar3D490_g251864;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251864) = _MainAlbedoTex;
					SamplerState Sampler498_g251864 = staticSwitch36_g251846;
					half2 XZ498_g251864 = temp_output_463_0_g251864;
					float2 temp_output_473_0_g251864 = (Out_MaskE456_g251864).xy;
					half2 XZ_1498_g251864 = temp_output_473_0_g251864;
					float2 temp_output_474_0_g251864 = (Out_MaskE456_g251864).zw;
					half2 XZ_2498_g251864 = temp_output_474_0_g251864;
					float2 temp_output_475_0_g251864 = (Out_MaskF456_g251864).xy;
					half2 XZ_3498_g251864 = temp_output_475_0_g251864;
					float temp_output_510_0_g251864 = exp2( temp_output_504_0_g251864 );
					half Bias498_g251864 = temp_output_510_0_g251864;
					float3 temp_output_480_0_g251864 = (Out_MaskI456_g251864).xyz;
					half3 Weights_2498_g251864 = temp_output_480_0_g251864;
					half3 NormalWS498_g251864 = NormalWS512_g251864;
					half3 Normal498_g251864 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251864 = SampleStochastic2D( Texture498_g251864 , Sampler498_g251864 , XZ498_g251864 , XZ_1498_g251864 , XZ_2498_g251864 , XZ_3498_g251864 , Bias498_g251864 , Weights_2498_g251864 , NormalWS498_g251864 , Normal498_g251864 );
					float4 temp_output_407_202_g251841 = localSampleStochastic2D498_g251864;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251864) = _MainAlbedoTex;
					SamplerState Sampler500_g251864 = staticSwitch36_g251846;
					half2 ZY500_g251864 = temp_output_462_0_g251864;
					half2 ZY_1500_g251864 = (Out_MaskC456_g251864).zw;
					half2 ZY_2500_g251864 = (Out_MaskD456_g251864).xy;
					half2 ZY_3500_g251864 = (Out_MaskD456_g251864).zw;
					half2 XZ500_g251864 = temp_output_463_0_g251864;
					half2 XZ_1500_g251864 = temp_output_473_0_g251864;
					half2 XZ_2500_g251864 = temp_output_474_0_g251864;
					half2 XZ_3500_g251864 = temp_output_475_0_g251864;
					half2 XY500_g251864 = temp_output_464_0_g251864;
					half2 XY_1500_g251864 = (Out_MaskF456_g251864).zw;
					half2 XY_2500_g251864 = (Out_MaskG456_g251864).xy;
					half2 XY_3500_g251864 = (Out_MaskG456_g251864).zw;
					half Bias500_g251864 = temp_output_510_0_g251864;
					half3 Weights_1500_g251864 = (Out_MaskH456_g251864).xyz;
					half3 Weights_2500_g251864 = temp_output_480_0_g251864;
					half3 Weights_3500_g251864 = (Out_MaskJ456_g251864).xyz;
					half3 Triplanar500_g251864 = Triplanar522_g251864;
					half3 NormalWS500_g251864 = NormalWS512_g251864;
					half3 Normal500_g251864 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251864 = SampleStochastic3D( Texture500_g251864 , Sampler500_g251864 , ZY500_g251864 , ZY_1500_g251864 , ZY_2500_g251864 , ZY_3500_g251864 , XZ500_g251864 , XZ_1500_g251864 , XZ_2500_g251864 , XZ_3500_g251864 , XY500_g251864 , XY_1500_g251864 , XY_2500_g251864 , XY_3500_g251864 , Bias500_g251864 , Weights_1500_g251864 , Weights_2500_g251864 , Weights_3500_g251864 , Triplanar500_g251864 , NormalWS500_g251864 , Normal500_g251864 );
					float4 temp_output_407_203_g251841 = localSampleStochastic3D500_g251864;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g251841 = temp_output_407_277_g251841;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g251841 = temp_output_407_278_g251841;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g251841 = temp_output_407_0_g251841;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g251841 = temp_output_407_201_g251841;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g251841 = temp_output_407_202_g251841;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g251841 = temp_output_407_203_g251841;
					#else
					float4 staticSwitch184_g251841 = temp_output_407_277_g251841;
					#endif
					half4 Local_AlbedoSample185_g251841 = staticSwitch184_g251841;
					float3 lerpResult53_g251841 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g251841).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g251841 = lerpResult53_g251841;
					float temp_output_17_0_g251861 = _MainMultiWriteMode;
					float Option91_g251861 = temp_output_17_0_g251861;
					float4 Model_VertexData418_g251841 = Out_VertexData15_g251842;
					float4 temp_output_84_0_g251861 = Model_VertexData418_g251841;
					float4 ChannelA91_g251861 = temp_output_84_0_g251861;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251849) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g251848 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g251848 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g251848 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g251848 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g251848 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g251848 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251849 = staticSwitch38_g251848;
					float localBreakTextureData456_g251849 = ( 0.0 );
					TVEMasksData Data456_g251849 =(TVEMasksData)Data431_g251863;
					float4 Out_MaskA456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251849 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251849 , Out_MaskA456_g251849 , Out_MaskB456_g251849 , Out_MaskC456_g251849 , Out_MaskD456_g251849 , Out_MaskE456_g251849 , Out_MaskF456_g251849 , Out_MaskG456_g251849 , Out_MaskH456_g251849 , Out_MaskI456_g251849 , Out_MaskJ456_g251849 , Out_MaskK456_g251849 , Out_MaskL456_g251849 , Out_MaskM456_g251849 , Out_MaskN456_g251849 );
					half2 UV276_g251849 = (Out_MaskA456_g251849).xy;
					float temp_output_504_0_g251849 = 0.0;
					half Bias276_g251849 = temp_output_504_0_g251849;
					half2 Normal276_g251849 = float2( 0,0 );
					half4 localSampleCoord276_g251849 = SampleCoord( Texture276_g251849 , Sampler276_g251849 , UV276_g251849 , Bias276_g251849 , Normal276_g251849 );
					float4 temp_output_405_277_g251841 = localSampleCoord276_g251849;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251849) = _MainShaderTex;
					SamplerState Sampler502_g251849 = staticSwitch38_g251848;
					half2 UV502_g251849 = (Out_MaskA456_g251849).zw;
					half Bias502_g251849 = temp_output_504_0_g251849;
					half2 Normal502_g251849 = float2( 0,0 );
					half4 localSampleCoord502_g251849 = SampleCoord( Texture502_g251849 , Sampler502_g251849 , UV502_g251849 , Bias502_g251849 , Normal502_g251849 );
					float4 temp_output_405_278_g251841 = localSampleCoord502_g251849;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251849) = _MainShaderTex;
					SamplerState Sampler496_g251849 = staticSwitch38_g251848;
					float2 temp_output_463_0_g251849 = (Out_MaskB456_g251849).zw;
					half2 XZ496_g251849 = temp_output_463_0_g251849;
					half Bias496_g251849 = temp_output_504_0_g251849;
					half3 NormalWS512_g251849 = (Out_MaskK456_g251849).xyz;
					half3 NormalWS496_g251849 = NormalWS512_g251849;
					half3 Normal496_g251849 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251849 = SamplePlanar2D( Texture496_g251849 , Sampler496_g251849 , XZ496_g251849 , Bias496_g251849 , NormalWS496_g251849 , Normal496_g251849 );
					float4 temp_output_405_0_g251841 = localSamplePlanar2D496_g251849;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251849) = _MainShaderTex;
					SamplerState Sampler490_g251849 = staticSwitch38_g251848;
					float2 temp_output_462_0_g251849 = (Out_MaskB456_g251849).xy;
					half2 ZY490_g251849 = temp_output_462_0_g251849;
					half2 XZ490_g251849 = temp_output_463_0_g251849;
					float2 temp_output_464_0_g251849 = (Out_MaskC456_g251849).xy;
					half2 XY490_g251849 = temp_output_464_0_g251849;
					half Bias490_g251849 = temp_output_504_0_g251849;
					half3 Triplanar522_g251849 = (Out_MaskN456_g251849).xyz;
					half3 Triplanar490_g251849 = Triplanar522_g251849;
					half3 NormalWS490_g251849 = NormalWS512_g251849;
					half3 Normal490_g251849 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251849 = SamplePlanar3D( Texture490_g251849 , Sampler490_g251849 , ZY490_g251849 , XZ490_g251849 , XY490_g251849 , Bias490_g251849 , Triplanar490_g251849 , NormalWS490_g251849 , Normal490_g251849 );
					float4 temp_output_405_201_g251841 = localSamplePlanar3D490_g251849;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251849) = _MainShaderTex;
					SamplerState Sampler498_g251849 = staticSwitch38_g251848;
					half2 XZ498_g251849 = temp_output_463_0_g251849;
					float2 temp_output_473_0_g251849 = (Out_MaskE456_g251849).xy;
					half2 XZ_1498_g251849 = temp_output_473_0_g251849;
					float2 temp_output_474_0_g251849 = (Out_MaskE456_g251849).zw;
					half2 XZ_2498_g251849 = temp_output_474_0_g251849;
					float2 temp_output_475_0_g251849 = (Out_MaskF456_g251849).xy;
					half2 XZ_3498_g251849 = temp_output_475_0_g251849;
					float temp_output_510_0_g251849 = exp2( temp_output_504_0_g251849 );
					half Bias498_g251849 = temp_output_510_0_g251849;
					float3 temp_output_480_0_g251849 = (Out_MaskI456_g251849).xyz;
					half3 Weights_2498_g251849 = temp_output_480_0_g251849;
					half3 NormalWS498_g251849 = NormalWS512_g251849;
					half3 Normal498_g251849 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251849 = SampleStochastic2D( Texture498_g251849 , Sampler498_g251849 , XZ498_g251849 , XZ_1498_g251849 , XZ_2498_g251849 , XZ_3498_g251849 , Bias498_g251849 , Weights_2498_g251849 , NormalWS498_g251849 , Normal498_g251849 );
					float4 temp_output_405_202_g251841 = localSampleStochastic2D498_g251849;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251849) = _MainShaderTex;
					SamplerState Sampler500_g251849 = staticSwitch38_g251848;
					half2 ZY500_g251849 = temp_output_462_0_g251849;
					half2 ZY_1500_g251849 = (Out_MaskC456_g251849).zw;
					half2 ZY_2500_g251849 = (Out_MaskD456_g251849).xy;
					half2 ZY_3500_g251849 = (Out_MaskD456_g251849).zw;
					half2 XZ500_g251849 = temp_output_463_0_g251849;
					half2 XZ_1500_g251849 = temp_output_473_0_g251849;
					half2 XZ_2500_g251849 = temp_output_474_0_g251849;
					half2 XZ_3500_g251849 = temp_output_475_0_g251849;
					half2 XY500_g251849 = temp_output_464_0_g251849;
					half2 XY_1500_g251849 = (Out_MaskF456_g251849).zw;
					half2 XY_2500_g251849 = (Out_MaskG456_g251849).xy;
					half2 XY_3500_g251849 = (Out_MaskG456_g251849).zw;
					half Bias500_g251849 = temp_output_510_0_g251849;
					half3 Weights_1500_g251849 = (Out_MaskH456_g251849).xyz;
					half3 Weights_2500_g251849 = temp_output_480_0_g251849;
					half3 Weights_3500_g251849 = (Out_MaskJ456_g251849).xyz;
					half3 Triplanar500_g251849 = Triplanar522_g251849;
					half3 NormalWS500_g251849 = NormalWS512_g251849;
					half3 Normal500_g251849 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251849 = SampleStochastic3D( Texture500_g251849 , Sampler500_g251849 , ZY500_g251849 , ZY_1500_g251849 , ZY_2500_g251849 , ZY_3500_g251849 , XZ500_g251849 , XZ_1500_g251849 , XZ_2500_g251849 , XZ_3500_g251849 , XY500_g251849 , XY_1500_g251849 , XY_2500_g251849 , XY_3500_g251849 , Bias500_g251849 , Weights_1500_g251849 , Weights_2500_g251849 , Weights_3500_g251849 , Triplanar500_g251849 , NormalWS500_g251849 , Normal500_g251849 );
					float4 temp_output_405_203_g251841 = localSampleStochastic3D500_g251849;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g251841 = temp_output_405_277_g251841;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g251841 = temp_output_405_278_g251841;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g251841 = temp_output_405_0_g251841;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g251841 = temp_output_405_201_g251841;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g251841 = temp_output_405_202_g251841;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g251841 = temp_output_405_203_g251841;
					#else
					float4 staticSwitch198_g251841 = temp_output_405_277_g251841;
					#endif
					half4 Local_ShaderSample199_g251841 = staticSwitch198_g251841;
					float2 appendResult428_g251841 = (float2((Local_AlbedoSample185_g251841).w , (Local_ShaderSample199_g251841).z));
					float2 temp_output_85_0_g251861 = appendResult428_g251841;
					float4 ChannelB91_g251861 = float4( temp_output_85_0_g251861, 0.0 , 0.0 );
					float localSwitchChannel691_g251861 = SwitchChannel6( Option91_g251861 , ChannelA91_g251861 , ChannelB91_g251861 );
					float clampResult17_g251859 = clamp( localSwitchChannel691_g251861 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251860 = _MainMultiWriteRemap.x;
					float temp_output_9_0_g251860 = ( clampResult17_g251859 - temp_output_7_0_g251860 );
					half Local_MultiMask78_g251841 = saturate( ( temp_output_9_0_g251860 * _MainMultiWriteRemap.z ) );
					float lerpResult58_g251841 = lerp( 1.0 , Local_MultiMask78_g251841 , _MainColorMode);
					float4 lerpResult62_g251841 = lerp( _MainColorTwo , _MainColor , lerpResult58_g251841);
					half3 Local_ColorRGB93_g251841 = (lerpResult62_g251841).rgb;
					half3 Local_Albedo139_g251841 = ( Local_AlbedoRGB107_g251841 * Local_ColorRGB93_g251841 );
					float3 temp_output_4_0_g251843 = Local_Albedo139_g251841;
					float3 In_Albedo3_g251843 = temp_output_4_0_g251843;
					float3 temp_output_44_0_g251843 = Local_Albedo139_g251841;
					float3 In_AlbedoBase3_g251843 = temp_output_44_0_g251843;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251870) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g251847 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g251847 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g251847 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g251847 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g251847 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g251847 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251870 = staticSwitch37_g251847;
					float localBreakTextureData456_g251870 = ( 0.0 );
					TVEMasksData Data456_g251870 =(TVEMasksData)Data431_g251863;
					float4 Out_MaskA456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251870 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251870 , Out_MaskA456_g251870 , Out_MaskB456_g251870 , Out_MaskC456_g251870 , Out_MaskD456_g251870 , Out_MaskE456_g251870 , Out_MaskF456_g251870 , Out_MaskG456_g251870 , Out_MaskH456_g251870 , Out_MaskI456_g251870 , Out_MaskJ456_g251870 , Out_MaskK456_g251870 , Out_MaskL456_g251870 , Out_MaskM456_g251870 , Out_MaskN456_g251870 );
					half2 UV276_g251870 = (Out_MaskA456_g251870).xy;
					float temp_output_504_0_g251870 = 0.0;
					half Bias276_g251870 = temp_output_504_0_g251870;
					half2 Normal276_g251870 = float2( 0,0 );
					half4 localSampleCoord276_g251870 = SampleCoord( Texture276_g251870 , Sampler276_g251870 , UV276_g251870 , Bias276_g251870 , Normal276_g251870 );
					float2 temp_output_406_394_g251841 = Normal276_g251870;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251870) = _MainNormalTex;
					SamplerState Sampler502_g251870 = staticSwitch37_g251847;
					half2 UV502_g251870 = (Out_MaskA456_g251870).zw;
					half Bias502_g251870 = temp_output_504_0_g251870;
					half2 Normal502_g251870 = float2( 0,0 );
					half4 localSampleCoord502_g251870 = SampleCoord( Texture502_g251870 , Sampler502_g251870 , UV502_g251870 , Bias502_g251870 , Normal502_g251870 );
					float2 temp_output_406_397_g251841 = Normal502_g251870;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251870) = _MainNormalTex;
					SamplerState Sampler496_g251870 = staticSwitch37_g251847;
					float2 temp_output_463_0_g251870 = (Out_MaskB456_g251870).zw;
					half2 XZ496_g251870 = temp_output_463_0_g251870;
					half Bias496_g251870 = temp_output_504_0_g251870;
					half3 NormalWS512_g251870 = (Out_MaskK456_g251870).xyz;
					half3 NormalWS496_g251870 = NormalWS512_g251870;
					half3 Normal496_g251870 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251870 = SamplePlanar2D( Texture496_g251870 , Sampler496_g251870 , XZ496_g251870 , Bias496_g251870 , NormalWS496_g251870 , Normal496_g251870 );
					float3 temp_output_35_0_g251873 = Normal496_g251870;
					half3 TangentWS519_g251870 = (Out_MaskL456_g251870).xyz;
					float dotResult84_g251873 = dot( temp_output_35_0_g251873 , TangentWS519_g251870 );
					half3 BitangentWS521_g251870 = (Out_MaskM456_g251870).xyz;
					float dotResult85_g251873 = dot( temp_output_35_0_g251873 , BitangentWS521_g251870 );
					float2 appendResult87_g251873 = (float2(dotResult84_g251873 , dotResult85_g251873));
					float2 temp_output_406_375_g251841 = appendResult87_g251873;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251870) = _MainNormalTex;
					SamplerState Sampler490_g251870 = staticSwitch37_g251847;
					float2 temp_output_462_0_g251870 = (Out_MaskB456_g251870).xy;
					half2 ZY490_g251870 = temp_output_462_0_g251870;
					half2 XZ490_g251870 = temp_output_463_0_g251870;
					float2 temp_output_464_0_g251870 = (Out_MaskC456_g251870).xy;
					half2 XY490_g251870 = temp_output_464_0_g251870;
					half Bias490_g251870 = temp_output_504_0_g251870;
					half3 Triplanar522_g251870 = (Out_MaskN456_g251870).xyz;
					half3 Triplanar490_g251870 = Triplanar522_g251870;
					half3 NormalWS490_g251870 = NormalWS512_g251870;
					half3 Normal490_g251870 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251870 = SamplePlanar3D( Texture490_g251870 , Sampler490_g251870 , ZY490_g251870 , XZ490_g251870 , XY490_g251870 , Bias490_g251870 , Triplanar490_g251870 , NormalWS490_g251870 , Normal490_g251870 );
					float3 temp_output_35_0_g251874 = Normal490_g251870;
					float dotResult84_g251874 = dot( temp_output_35_0_g251874 , TangentWS519_g251870 );
					float dotResult85_g251874 = dot( temp_output_35_0_g251874 , BitangentWS521_g251870 );
					float2 appendResult87_g251874 = (float2(dotResult84_g251874 , dotResult85_g251874));
					float2 temp_output_406_353_g251841 = appendResult87_g251874;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251870) = _MainNormalTex;
					SamplerState Sampler498_g251870 = staticSwitch37_g251847;
					half2 XZ498_g251870 = temp_output_463_0_g251870;
					float2 temp_output_473_0_g251870 = (Out_MaskE456_g251870).xy;
					half2 XZ_1498_g251870 = temp_output_473_0_g251870;
					float2 temp_output_474_0_g251870 = (Out_MaskE456_g251870).zw;
					half2 XZ_2498_g251870 = temp_output_474_0_g251870;
					float2 temp_output_475_0_g251870 = (Out_MaskF456_g251870).xy;
					half2 XZ_3498_g251870 = temp_output_475_0_g251870;
					float temp_output_510_0_g251870 = exp2( temp_output_504_0_g251870 );
					half Bias498_g251870 = temp_output_510_0_g251870;
					float3 temp_output_480_0_g251870 = (Out_MaskI456_g251870).xyz;
					half3 Weights_2498_g251870 = temp_output_480_0_g251870;
					half3 NormalWS498_g251870 = NormalWS512_g251870;
					half3 Normal498_g251870 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251870 = SampleStochastic2D( Texture498_g251870 , Sampler498_g251870 , XZ498_g251870 , XZ_1498_g251870 , XZ_2498_g251870 , XZ_3498_g251870 , Bias498_g251870 , Weights_2498_g251870 , NormalWS498_g251870 , Normal498_g251870 );
					float3 temp_output_35_0_g251875 = Normal498_g251870;
					float dotResult84_g251875 = dot( temp_output_35_0_g251875 , TangentWS519_g251870 );
					float dotResult85_g251875 = dot( temp_output_35_0_g251875 , BitangentWS521_g251870 );
					float2 appendResult87_g251875 = (float2(dotResult84_g251875 , dotResult85_g251875));
					float2 temp_output_406_391_g251841 = appendResult87_g251875;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251870) = _MainNormalTex;
					SamplerState Sampler500_g251870 = staticSwitch37_g251847;
					half2 ZY500_g251870 = temp_output_462_0_g251870;
					half2 ZY_1500_g251870 = (Out_MaskC456_g251870).zw;
					half2 ZY_2500_g251870 = (Out_MaskD456_g251870).xy;
					half2 ZY_3500_g251870 = (Out_MaskD456_g251870).zw;
					half2 XZ500_g251870 = temp_output_463_0_g251870;
					half2 XZ_1500_g251870 = temp_output_473_0_g251870;
					half2 XZ_2500_g251870 = temp_output_474_0_g251870;
					half2 XZ_3500_g251870 = temp_output_475_0_g251870;
					half2 XY500_g251870 = temp_output_464_0_g251870;
					half2 XY_1500_g251870 = (Out_MaskF456_g251870).zw;
					half2 XY_2500_g251870 = (Out_MaskG456_g251870).xy;
					half2 XY_3500_g251870 = (Out_MaskG456_g251870).zw;
					half Bias500_g251870 = temp_output_510_0_g251870;
					half3 Weights_1500_g251870 = (Out_MaskH456_g251870).xyz;
					half3 Weights_2500_g251870 = temp_output_480_0_g251870;
					half3 Weights_3500_g251870 = (Out_MaskJ456_g251870).xyz;
					half3 Triplanar500_g251870 = Triplanar522_g251870;
					half3 NormalWS500_g251870 = NormalWS512_g251870;
					half3 Normal500_g251870 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251870 = SampleStochastic3D( Texture500_g251870 , Sampler500_g251870 , ZY500_g251870 , ZY_1500_g251870 , ZY_2500_g251870 , ZY_3500_g251870 , XZ500_g251870 , XZ_1500_g251870 , XZ_2500_g251870 , XZ_3500_g251870 , XY500_g251870 , XY_1500_g251870 , XY_2500_g251870 , XY_3500_g251870 , Bias500_g251870 , Weights_1500_g251870 , Weights_2500_g251870 , Weights_3500_g251870 , Triplanar500_g251870 , NormalWS500_g251870 , Normal500_g251870 );
					float3 temp_output_35_0_g251871 = Normal500_g251870;
					float dotResult84_g251871 = dot( temp_output_35_0_g251871 , TangentWS519_g251870 );
					float dotResult85_g251871 = dot( temp_output_35_0_g251871 , BitangentWS521_g251870 );
					float2 appendResult87_g251871 = (float2(dotResult84_g251871 , dotResult85_g251871));
					float2 temp_output_406_390_g251841 = appendResult87_g251871;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g251841 = temp_output_406_394_g251841;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g251841 = temp_output_406_397_g251841;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g251841 = temp_output_406_375_g251841;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g251841 = temp_output_406_353_g251841;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g251841 = temp_output_406_391_g251841;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g251841 = temp_output_406_390_g251841;
					#else
					float2 staticSwitch193_g251841 = temp_output_406_394_g251841;
					#endif
					half2 Local_NormaSample191_g251841 = staticSwitch193_g251841;
					half2 Local_NormalTS108_g251841 = ( Local_NormaSample191_g251841 * _MainNormalValue );
					float2 In_NormalTS3_g251843 = Local_NormalTS108_g251841;
					float2 break80_g251862 = Local_NormalTS108_g251841;
					float3 temp_output_77_0_g251862 = Model_TangentWS366_g251841;
					float3 temp_output_78_0_g251862 = Model_BitangentWS367_g251841;
					float3 temp_output_76_0_g251862 = Model_NormalWS226_g251841;
					half3 Local_NormalWS250_g251841 = ( ( break80_g251862.x * temp_output_77_0_g251862 ) + ( break80_g251862.y * temp_output_78_0_g251862 ) + temp_output_76_0_g251862 );
					float3 In_NormalWS3_g251843 = Local_NormalWS250_g251841;
					float temp_output_209_0_g251841 = (Local_ShaderSample199_g251841).y;
					float temp_output_7_0_g251855 = _MainOcclusionRemap.x;
					float temp_output_9_0_g251855 = ( temp_output_209_0_g251841 - temp_output_7_0_g251855 );
					float lerpResult23_g251841 = lerp( 1.0 , saturate( ( temp_output_9_0_g251855 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g251841 = lerpResult23_g251841;
					float temp_output_213_0_g251841 = (Local_ShaderSample199_g251841).w;
					float temp_output_7_0_g251858 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g251858 = ( temp_output_213_0_g251841 - temp_output_7_0_g251858 );
					half Local_Smoothness317_g251841 = ( saturate( ( temp_output_9_0_g251858 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g251841 = (float4(( (Local_ShaderSample199_g251841).x * _MainMetallicValue ) , Local_Occlusion313_g251841 , (Local_ShaderSample199_g251841).z , Local_Smoothness317_g251841));
					half4 Local_Masks109_g251841 = appendResult73_g251841;
					float4 In_Shader3_g251843 = Local_Masks109_g251841;
					float4 In_Feature3_g251843 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251843 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251843 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g251876 = Local_Albedo139_g251841;
					float dotResult20_g251876 = dot( temp_output_3_0_g251876 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g251841 = dotResult20_g251876;
					float temp_output_12_0_g251843 = Local_Grayscale110_g251841;
					float In_Grayscale3_g251843 = temp_output_12_0_g251843;
					float temp_output_3_0_g251877 = Local_Grayscale110_g251841;
					float clampResult27_g251877 = clamp( saturate( ( temp_output_3_0_g251877 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g251841 = clampResult27_g251877;
					float temp_output_16_0_g251843 = Local_Luminosity145_g251841;
					float In_Luminosity3_g251843 = temp_output_16_0_g251843;
					float In_MultiMask3_g251843 = Local_MultiMask78_g251841;
					float temp_output_187_0_g251841 = (Local_AlbedoSample185_g251841).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g251841 = ( temp_output_187_0_g251841 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g251841 = temp_output_187_0_g251841;
					#endif
					half Local_AlphaClip111_g251841 = staticSwitch236_g251841;
					float In_AlphaClip3_g251843 = Local_AlphaClip111_g251841;
					half Local_AlphaFade246_g251841 = (lerpResult62_g251841).a;
					float In_AlphaFade3_g251843 = Local_AlphaFade246_g251841;
					float3 temp_cast_25 = (1.0).xxx;
					float3 In_Translucency3_g251843 = temp_cast_25;
					float In_Transmission3_g251843 = 1.0;
					float In_Thickness3_g251843 = 0.0;
					float In_Diffusion3_g251843 = 0.0;
					float In_Depth3_g251843 = 0.0;
					BuildVisualData( Data3_g251843 , In_Dummy3_g251843 , In_Albedo3_g251843 , In_AlbedoBase3_g251843 , In_NormalTS3_g251843 , In_NormalWS3_g251843 , In_Shader3_g251843 , In_Feature3_g251843 , In_Season3_g251843 , In_Emissive3_g251843 , In_Grayscale3_g251843 , In_Luminosity3_g251843 , In_MultiMask3_g251843 , In_AlphaClip3_g251843 , In_AlphaFade3_g251843 , In_Translucency3_g251843 , In_Transmission3_g251843 , In_Thickness3_g251843 , In_Diffusion3_g251843 , In_Depth3_g251843 );
					TVEVisualData Data4_g251886 =(TVEVisualData)Data3_g251843;
					float Out_Dummy4_g251886 = 0.0;
					float3 Out_Albedo4_g251886 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g251886 = float3( 0,0,0 );
					float2 Out_NormalTS4_g251886 = float2( 0,0 );
					float3 Out_NormalWS4_g251886 = float3( 0,0,0 );
					float4 Out_Shader4_g251886 = float4( 0,0,0,0 );
					float4 Out_Feature4_g251886 = float4( 0,0,0,0 );
					float4 Out_Season4_g251886 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g251886 = float4( 0,0,0,0 );
					float Out_MultiMask4_g251886 = 0.0;
					float Out_Grayscale4_g251886 = 0.0;
					float Out_Luminosity4_g251886 = 0.0;
					float Out_AlphaClip4_g251886 = 0.0;
					float Out_AlphaFade4_g251886 = 0.0;
					float3 Out_Translucency4_g251886 = float3( 0,0,0 );
					float Out_Transmission4_g251886 = 0.0;
					float Out_Thickness4_g251886 = 0.0;
					float Out_Diffusion4_g251886 = 0.0;
					float Out_Depth4_g251886 = 0.0;
					BreakVisualData( Data4_g251886 , Out_Dummy4_g251886 , Out_Albedo4_g251886 , Out_AlbedoBase4_g251886 , Out_NormalTS4_g251886 , Out_NormalWS4_g251886 , Out_Shader4_g251886 , Out_Feature4_g251886 , Out_Season4_g251886 , Out_Emissive4_g251886 , Out_MultiMask4_g251886 , Out_Grayscale4_g251886 , Out_Luminosity4_g251886 , Out_AlphaClip4_g251886 , Out_AlphaFade4_g251886 , Out_Translucency4_g251886 , Out_Transmission4_g251886 , Out_Thickness4_g251886 , Out_Diffusion4_g251886 , Out_Depth4_g251886 );
					float Alpha109_g251881 = Out_AlphaClip4_g251886;
					float lerpResult91_g251881 = lerp( 1.0 , Alpha109_g251881 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g251881 = lerp( 1.0 , lerpResult91_g251881 , Filter152_g251881);
					clip( lerpResult154_g251881 );
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

					o.Emission = ( lerpResult72_g251881 * lerpResult84_g251881 );
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
				#pragma shader_feature_local_vertex TVE_MOTION
				#pragma shader_feature_local_vertex TVE_MOTION_FLOW
				#pragma shader_feature_local TVE_LEGACY
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
				#if defined (TVE_MOTION) //Motion
					#define TVE_ROTATION_BEND //Motion
				#endif //Motion
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
				#define SAMPLE_TEXTURE3D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE3D_LOD(tex,samplerTex,coord,lod) tex3Dlod(tex,float4(coord,lod))
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
					float4 ase_texcoord9 : TEXCOORD9;
					float4 ase_color : COLOR;
					float4 ase_texcoord10 : TEXCOORD10;
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
				uniform half _MotionCategory;
				uniform half _MotionEnd;
				uniform half _MotionFlowInfo;
				uniform half4 TVE_WindParams;
				uniform half _MotionFlowValue;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MotionNoiseTex);
				uniform half _MotionSmallPivotValue;
				uniform half _MotionSmallPhaseValue;
				uniform half _MotionSmallTillingValue;
				uniform half4 TVE_MotionTimeParams;
				uniform half _MotionSmallSpeedValue;
				uniform half _MotionSmallNoiseValue;
				uniform half _MotionFlowMode;
				uniform half4 TVE_WindEditor;
				uniform half _MotionIntensityValue;
				uniform half _MotionSmallDelayValue;
				uniform half _MotionSmallIntensityValue;
				uniform half _MotionSmallPushValue;
				uniform half _MotionSmallMaskMode;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MotionMaskTex);
				SamplerState sampler_MotionMaskTex;
				uniform half4 _MotionSmallMaskRemap;
				uniform half4 TVE_MotionValueParams;
				uniform half _MotionTinyTillingValue;
				uniform half _MotionTinySpeedValue;
				uniform half _MotionTinyNoiseValue;
				uniform half _MotionTinyIntensityValue;
				UNITY_DECLARE_TEX3D_NOSAMPLER(_NoiseTex3D);
				uniform half _MotionTinyMaskMode;
				uniform half4 _MotionTinyMaskRemap;
				uniform half _MotionDistValue;
				uniform half _MotionBasePivotValue;
				uniform half _MotionBasePhaseValue;
				uniform half _MotionBaseTillingValue;
				uniform half _MotionBaseSpeedValue;
				uniform half _MotionBaseNoiseValue;
				uniform half _MotionBaseIntensityValue;
				uniform half _MotionBaseDelayValue;
				uniform half _MotionBasePushValue;
				uniform half _MotionBaseMaskMode;
				uniform half4 _MotionBaseMaskRemap;
				uniform half _MotionHighlightValue;
				uniform half _motion_small_mode;
				uniform half4 _MotionHighlightColor;
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
				
				float SwitchChannel7( half Option, half4 ChannelA, half4 ChannelB )
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
					}
				}
				
				float2 DecodeFloatToVector2( float enc )
				{
					float2 result ;
					result.y = enc % 2048;
					result.x = floor(enc / 2048);
					return result / (2048 - 1);
				}
				
				float3 HSVToRGB( float3 c )
				{
					float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
					float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
					return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
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
					float localIfModelDataByShader26_g241959 = ( 0.0 );
					TVEModelData Data26_g241959 = (TVEModelData)0;
					TVEModelData Data16_g241856 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g241838 = _ObjectCoordMode;
					#else
					float staticSwitch343_g241838 = _ObjectCoordMode;
					#endif
					half Dummy207_g241838 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g241838 );
					float temp_output_14_0_g241856 = Dummy207_g241838;
					float In_Dummy16_g241856 = temp_output_14_0_g241856;
					float3 PositionOS131_g241838 = v.vertex.xyz;
					float3 temp_output_4_0_g241856 = PositionOS131_g241838;
					float3 In_PositionOS16_g241856 = temp_output_4_0_g241856;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g241838 = ase_positionWS;
					float3 vertexToFrag73_g241838 = temp_output_104_7_g241838;
					float3 PositionWS122_g241838 = vertexToFrag73_g241838;
					float3 In_PositionWS16_g241856 = PositionWS122_g241838;
					float4x4 break19_g241841 = unity_ObjectToWorld;
					float3 appendResult20_g241841 = (float3(break19_g241841[ 0 ][ 3 ] , break19_g241841[ 1 ][ 3 ] , break19_g241841[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241838 = appendResult20_g241841;
					float4x4 break19_g241843 = unity_ObjectToWorld;
					float3 appendResult20_g241843 = (float3(break19_g241843[ 0 ][ 3 ] , break19_g241843[ 1 ][ 3 ] , break19_g241843[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g241839 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g241838 = PositionOS131_g241838;
					float3 appendResult234_g241838 = (float3(break233_g241838.x , 0.0 , break233_g241838.z));
					float3 break413_g241838 = PositionOS131_g241838;
					float3 appendResult414_g241838 = (float3(break413_g241838.x , break413_g241838.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g241845 = appendResult414_g241838;
					#else
					float3 staticSwitch65_g241845 = appendResult234_g241838;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g241838 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g241838 = appendResult60_g241839;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g241838 = staticSwitch65_g241845;
					#else
					float3 staticSwitch229_g241838 = _Vector0;
					#endif
					float3 PivotOS149_g241838 = staticSwitch229_g241838;
					float3 temp_output_122_0_g241843 = PivotOS149_g241838;
					float3 PivotsOnlyWS105_g241843 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g241843 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g241838 = ( appendResult20_g241843 + PivotsOnlyWS105_g241843 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g241838 = temp_output_340_7_g241838;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g241838 = temp_output_341_7_g241838;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g241838 = temp_output_341_7_g241838;
					#else
					float3 staticSwitch236_g241838 = temp_output_340_7_g241838;
					#endif
					float3 vertexToFrag76_g241838 = staticSwitch236_g241838;
					float3 PivotWS121_g241838 = vertexToFrag76_g241838;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241838 = ( PositionWS122_g241838 - PivotWS121_g241838 );
					#else
					float3 staticSwitch204_g241838 = PositionWS122_g241838;
					#endif
					float3 PositionWO132_g241838 = ( staticSwitch204_g241838 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241856 = PositionWO132_g241838;
					float3 In_PivotOS16_g241856 = PivotOS149_g241838;
					float3 In_PivotWS16_g241856 = PivotWS121_g241838;
					float3 PivotWO133_g241838 = ( PivotWS121_g241838 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241856 = PivotWO133_g241838;
					half3 NormalOS134_g241838 = v.normal;
					float3 temp_output_21_0_g241856 = NormalOS134_g241838;
					float3 In_NormalOS16_g241856 = temp_output_21_0_g241856;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g241838 = normalizedWorldNormal;
					float3 In_NormalWS16_g241856 = NormalWS95_g241838;
					half4 TangentlOS153_g241838 = v.tangent;
					float4 temp_output_6_0_g241856 = TangentlOS153_g241838;
					float4 In_TangentOS16_g241856 = temp_output_6_0_g241856;
					float3 normalizeResult296_g241838 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241838 ) );
					half3 ViewDirWS169_g241838 = normalizeResult296_g241838;
					float3 In_ViewDirWS16_g241856 = ViewDirWS169_g241838;
					float4 appendResult397_g241838 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g241838 = appendResult397_g241838;
					float4 In_CoordsData16_g241856 = CoordsData398_g241838;
					half4 VertexMasks171_g241838 = v.ase_color;
					float4 In_VertexData16_g241856 = VertexMasks171_g241838;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241850 = (PositionOS131_g241838).z;
					#else
					float staticSwitch65_g241850 = (PositionOS131_g241838).y;
					#endif
					half Object_HeightValue267_g241838 = _ObjectHeightValue;
					half Bounds_HeightMask274_g241838 = saturate( ( staticSwitch65_g241850 / Object_HeightValue267_g241838 ) );
					half3 Position387_g241838 = PositionOS131_g241838;
					half Height387_g241838 = Object_HeightValue267_g241838;
					half Object_RadiusValue268_g241838 = _ObjectRadiusValue;
					half Radius387_g241838 = Object_RadiusValue268_g241838;
					half localCapsuleMaskYUp387_g241838 = CapsuleMaskYUp( Position387_g241838 , Height387_g241838 , Radius387_g241838 );
					half3 Position408_g241838 = PositionOS131_g241838;
					half Height408_g241838 = Object_HeightValue267_g241838;
					half Radius408_g241838 = Object_RadiusValue268_g241838;
					half localCapsuleMaskZUp408_g241838 = CapsuleMaskZUp( Position408_g241838 , Height408_g241838 , Radius408_g241838 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241855 = saturate( localCapsuleMaskZUp408_g241838 );
					#else
					float staticSwitch65_g241855 = saturate( localCapsuleMaskYUp387_g241838 );
					#endif
					half Bounds_SphereMask282_g241838 = staticSwitch65_g241855;
					float4 appendResult253_g241838 = (float4(Bounds_HeightMask274_g241838 , Bounds_SphereMask282_g241838 , 1.0 , 1.0));
					half4 MasksData254_g241838 = appendResult253_g241838;
					float4 In_MasksData16_g241856 = MasksData254_g241838;
					float temp_output_17_0_g241849 = _ObjectPhaseMode;
					float Option70_g241849 = temp_output_17_0_g241849;
					float4 temp_output_3_0_g241849 = v.ase_color;
					float4 Channel70_g241849 = temp_output_3_0_g241849;
					float localSwitchChannel470_g241849 = SwitchChannel4( Option70_g241849 , Channel70_g241849 );
					half Phase_Value372_g241838 = localSwitchChannel470_g241849;
					float3 break319_g241838 = PivotWO133_g241838;
					half Pivot_Position322_g241838 = ( break319_g241838.x + break319_g241838.z );
					half Phase_Position357_g241838 = ( Phase_Value372_g241838 + Pivot_Position322_g241838 );
					float temp_output_248_0_g241838 = frac( Phase_Position357_g241838 );
					float4 appendResult177_g241838 = (float4((frac( ( Phase_Position357_g241838 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g241838));
					half4 Phase_Data176_g241838 = appendResult177_g241838;
					float4 In_PhaseData16_g241856 = Phase_Data176_g241838;
					BuildModelVertData( Data16_g241856 , In_Dummy16_g241856 , In_PositionOS16_g241856 , In_PositionWS16_g241856 , In_PositionWO16_g241856 , In_PivotOS16_g241856 , In_PivotWS16_g241856 , In_PivotWO16_g241856 , In_NormalOS16_g241856 , In_NormalWS16_g241856 , In_TangentOS16_g241856 , In_ViewDirWS16_g241856 , In_CoordsData16_g241856 , In_VertexData16_g241856 , In_MasksData16_g241856 , In_PhaseData16_g241856 );
					TVEModelData DataDefault26_g241959 = Data16_g241856;
					TVEModelData DataGeneral26_g241959 = Data16_g241856;
					TVEModelData DataBlanket26_g241959 = Data16_g241856;
					TVEModelData DataImpostor26_g241959 = Data16_g241856;
					TVEModelData Data16_g241836 =(TVEModelData)0;
					half Dummy207_g241818 = 0.0;
					float temp_output_14_0_g241836 = Dummy207_g241818;
					float In_Dummy16_g241836 = temp_output_14_0_g241836;
					float3 PositionOS131_g241818 = v.vertex.xyz;
					float3 temp_output_4_0_g241836 = PositionOS131_g241818;
					float3 In_PositionOS16_g241836 = temp_output_4_0_g241836;
					float3 temp_output_104_7_g241818 = ase_positionWS;
					float3 PositionWS122_g241818 = temp_output_104_7_g241818;
					float3 In_PositionWS16_g241836 = PositionWS122_g241818;
					float4x4 break19_g241821 = unity_ObjectToWorld;
					float3 appendResult20_g241821 = (float3(break19_g241821[ 0 ][ 3 ] , break19_g241821[ 1 ][ 3 ] , break19_g241821[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241818 = appendResult20_g241821;
					float3 PivotWS121_g241818 = temp_output_340_7_g241818;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241818 = ( PositionWS122_g241818 - PivotWS121_g241818 );
					#else
					float3 staticSwitch204_g241818 = PositionWS122_g241818;
					#endif
					float3 PositionWO132_g241818 = ( staticSwitch204_g241818 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241836 = PositionWO132_g241818;
					float3 PivotOS149_g241818 = _Vector0;
					float3 In_PivotOS16_g241836 = PivotOS149_g241818;
					float3 In_PivotWS16_g241836 = PivotWS121_g241818;
					float3 PivotWO133_g241818 = ( PivotWS121_g241818 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241836 = PivotWO133_g241818;
					half3 NormalOS134_g241818 = v.normal;
					float3 temp_output_21_0_g241836 = NormalOS134_g241818;
					float3 In_NormalOS16_g241836 = temp_output_21_0_g241836;
					half3 NormalWS95_g241818 = normalizedWorldNormal;
					float3 In_NormalWS16_g241836 = NormalWS95_g241818;
					float4 appendResult462_g241818 = (float4(cross( v.normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g241818 = appendResult462_g241818;
					float4 temp_output_6_0_g241836 = TangentlOS153_g241818;
					float4 In_TangentOS16_g241836 = temp_output_6_0_g241836;
					float3 normalizeResult296_g241818 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241818 ) );
					half3 ViewDirWS169_g241818 = normalizeResult296_g241818;
					float3 In_ViewDirWS16_g241836 = ViewDirWS169_g241818;
					float4 appendResult397_g241818 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g241818 = appendResult397_g241818;
					float4 In_CoordsData16_g241836 = CoordsData398_g241818;
					half4 VertexMasks171_g241818 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241836 = VertexMasks171_g241818;
					half4 MasksData254_g241818 = float4( 0,0,0,0 );
					float4 In_MasksData16_g241836 = MasksData254_g241818;
					half4 Phase_Data176_g241818 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g241836 = Phase_Data176_g241818;
					BuildModelVertData( Data16_g241836 , In_Dummy16_g241836 , In_PositionOS16_g241836 , In_PositionWS16_g241836 , In_PositionWO16_g241836 , In_PivotOS16_g241836 , In_PivotWS16_g241836 , In_PivotWO16_g241836 , In_NormalOS16_g241836 , In_NormalWS16_g241836 , In_TangentOS16_g241836 , In_ViewDirWS16_g241836 , In_CoordsData16_g241836 , In_VertexData16_g241836 , In_MasksData16_g241836 , In_PhaseData16_g241836 );
					TVEModelData DataTerrain26_g241959 = Data16_g241836;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g241959 = IsShaderType2637;
					{
					if (Type26_g241959 == 0 )
					{
					Data26_g241959 = DataDefault26_g241959;
					}
					else if (Type26_g241959 == 1 )
					{
					Data26_g241959 = DataGeneral26_g241959;
					}
					else if (Type26_g241959 == 2 )
					{
					Data26_g241959 = DataBlanket26_g241959;
					}
					else if (Type26_g241959 == 3 )
					{
					Data26_g241959 = DataImpostor26_g241959;
					}
					else if (Type26_g241959 == 4 )
					{
					Data26_g241959 = DataTerrain26_g241959;
					}
					}
					TVEModelData Data15_g251553 =(TVEModelData)Data26_g241959;
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
					TVEVertexData Data15_g251569 =(TVEVertexData)Data16_g251557;
					float Out_Dummy15_g251569 = 0.0;
					float3 Out_PositionOS15_g251569 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251569 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251569 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251569 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251569 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251569 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251569 , Out_Dummy15_g251569 , Out_PositionOS15_g251569 , Out_NormalOS15_g251569 , Out_TangentOS15_g251569 , Out_TransformData15_g251569 , Out_RotationData15_g251569 , Out_Interpolator15_g251569 );
					TVEVertexData Data16_g251570 =(TVEVertexData)Data15_g251569;
					half Dummy317_g251561 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251570 = Dummy317_g251561;
					float3 In_PositionOS16_g251570 = Out_PositionOS15_g251569;
					float3 In_NormalOS16_g251570 = Out_NormalOS15_g251569;
					float4 In_TangentOS16_g251570 = Out_TangentOS15_g251569;
					half4 Model_TransformData356_g251561 = Out_TransformData15_g251569;
					float localBuildGlobalData204_g241858 = ( 0.0 );
					TVEGlobalData Data204_g241858 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g241858 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g241858 = Dummy211_g241858;
					float4 temp_output_203_0_g241877 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g241817 = ( 0.0 );
					TVEModelData Data26_g241817 = (TVEModelData)0;
					TVEModelData Data16_g241846 =(TVEModelData)0;
					float In_Dummy16_g241846 = 0.0;
					float3 In_PositionWS16_g241846 = PositionWS122_g241838;
					float3 In_PositionWO16_g241846 = PositionWO132_g241838;
					float3 In_PivotWS16_g241846 = PivotWS121_g241838;
					float3 In_PivotWO16_g241846 = PivotWO133_g241838;
					float3 In_NormalWS16_g241846 = NormalWS95_g241838;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g241838 = ase_tangentWS;
					float3 In_TangentWS16_g241846 = TangentWS136_g241838;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g241838 = ase_bitangentWS;
					float3 In_BitangentWS16_g241846 = BiangentWS421_g241838;
					half3 NormalWS427_g241838 = NormalWS95_g241838;
					half3 localComputeTriplanarMasks427_g241838 = ComputeTriplanarMasks( NormalWS427_g241838 );
					half3 TriplanarWeights429_g241838 = localComputeTriplanarMasks427_g241838;
					float3 In_TriplanarWeights16_g241846 = TriplanarWeights429_g241838;
					float3 In_ViewDirWS16_g241846 = ViewDirWS169_g241838;
					float4 In_CoordsData16_g241846 = CoordsData398_g241838;
					float4 In_VertexData16_g241846 = VertexMasks171_g241838;
					float4 In_Interpolator16_g241846 = Phase_Data176_g241838;
					BuildModelFragData( Data16_g241846 , In_Dummy16_g241846 , In_PositionWS16_g241846 , In_PositionWO16_g241846 , In_PivotWS16_g241846 , In_PivotWO16_g241846 , In_NormalWS16_g241846 , In_TangentWS16_g241846 , In_BitangentWS16_g241846 , In_TriplanarWeights16_g241846 , In_ViewDirWS16_g241846 , In_CoordsData16_g241846 , In_VertexData16_g241846 , In_Interpolator16_g241846 );
					TVEModelData DataDefault26_g241817 = Data16_g241846;
					TVEModelData DataGeneral26_g241817 = Data16_g241846;
					TVEModelData DataBlanket26_g241817 = Data16_g241846;
					TVEModelData DataImpostor26_g241817 = Data16_g241846;
					TVEModelData Data16_g241826 =(TVEModelData)0;
					float In_Dummy16_g241826 = 0.0;
					float3 In_PositionWS16_g241826 = PositionWS122_g241818;
					float3 In_PositionWO16_g241826 = PositionWO132_g241818;
					float3 In_PivotWS16_g241826 = PivotWS121_g241818;
					float3 In_PivotWO16_g241826 = PivotWO133_g241818;
					float3 In_NormalWS16_g241826 = NormalWS95_g241818;
					half3 TangentWS136_g241818 = ase_tangentWS;
					float3 In_TangentWS16_g241826 = TangentWS136_g241818;
					half3 BiangentWS421_g241818 = ase_bitangentWS;
					float3 In_BitangentWS16_g241826 = BiangentWS421_g241818;
					half3 NormalWS427_g241818 = NormalWS95_g241818;
					half3 localComputeTriplanarMasks427_g241818 = ComputeTriplanarMasks( NormalWS427_g241818 );
					half3 TriplanarWeights429_g241818 = localComputeTriplanarMasks427_g241818;
					float3 In_TriplanarWeights16_g241826 = TriplanarWeights429_g241818;
					float3 In_ViewDirWS16_g241826 = ViewDirWS169_g241818;
					float4 In_CoordsData16_g241826 = CoordsData398_g241818;
					float4 In_VertexData16_g241826 = VertexMasks171_g241818;
					float4 In_Interpolator16_g241826 = Phase_Data176_g241818;
					BuildModelFragData( Data16_g241826 , In_Dummy16_g241826 , In_PositionWS16_g241826 , In_PositionWO16_g241826 , In_PivotWS16_g241826 , In_PivotWO16_g241826 , In_NormalWS16_g241826 , In_TangentWS16_g241826 , In_BitangentWS16_g241826 , In_TriplanarWeights16_g241826 , In_ViewDirWS16_g241826 , In_CoordsData16_g241826 , In_VertexData16_g241826 , In_Interpolator16_g241826 );
					TVEModelData DataTerrain26_g241817 = Data16_g241826;
					float Type26_g241817 = IsShaderType2637;
					{
					if (Type26_g241817 == 0 )
					{
					Data26_g241817 = DataDefault26_g241817;
					}
					else if (Type26_g241817 == 1 )
					{
					Data26_g241817 = DataGeneral26_g241817;
					}
					else if (Type26_g241817 == 2 )
					{
					Data26_g241817 = DataBlanket26_g241817;
					}
					else if (Type26_g241817 == 3 )
					{
					Data26_g241817 = DataImpostor26_g241817;
					}
					else if (Type26_g241817 == 4 )
					{
					Data26_g241817 = DataTerrain26_g241817;
					}
					}
					TVEModelData Data15_g241948 =(TVEModelData)Data26_g241817;
					float Out_Dummy15_g241948 = 0.0;
					float3 Out_PositionWS15_g241948 = float3( 0,0,0 );
					float3 Out_PositionWO15_g241948 = float3( 0,0,0 );
					float3 Out_PivotWS15_g241948 = float3( 0,0,0 );
					float3 Out_PivotWO15_g241948 = float3( 0,0,0 );
					float3 Out_NormalWS15_g241948 = float3( 0,0,0 );
					float3 Out_TangentWS15_g241948 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g241948 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g241948 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g241948 = float3( 0,0,0 );
					float4 Out_CoordsData15_g241948 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g241948 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g241948 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g241948 , Out_Dummy15_g241948 , Out_PositionWS15_g241948 , Out_PositionWO15_g241948 , Out_PivotWS15_g241948 , Out_PivotWO15_g241948 , Out_NormalWS15_g241948 , Out_TangentWS15_g241948 , Out_BitangentWS15_g241948 , Out_TriplanarWeights15_g241948 , Out_ViewDirWS15_g241948 , Out_CoordsData15_g241948 , Out_VertexData15_g241948 , Out_Interpolator15_g241948 );
					float3 Model_PositionWS497_g241858 = Out_PositionWS15_g241948;
					float2 Model_PositionWS_XZ143_g241858 = (Model_PositionWS497_g241858).xz;
					float3 Model_PivotWS498_g241858 = Out_PivotWS15_g241948;
					float2 Model_PivotWS_XZ145_g241858 = (Model_PivotWS498_g241858).xz;
					float2 lerpResult300_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g241877 = lerpResult300_g241858;
					float temp_output_82_0_g241875 = _GlobalCoatLayerValue;
					float temp_output_82_0_g241877 = temp_output_82_0_g241875;
					float4 tex2DArrayNode83_g241877 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241877).zw + ( (temp_output_203_0_g241877).xy * temp_output_81_0_g241877 ) ),temp_output_82_0_g241877), 0.0 );
					float4 appendResult210_g241877 = (float4(tex2DArrayNode83_g241877.rgb , tex2DArrayNode83_g241877.a));
					float4 temp_output_204_0_g241877 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g241877 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241877).zw + ( (temp_output_204_0_g241877).xy * temp_output_81_0_g241877 ) ),temp_output_82_0_g241877), 0.0 );
					float4 appendResult212_g241877 = (float4(tex2DArrayNode122_g241877.rgb , tex2DArrayNode122_g241877.a));
					float4 TVE_RenderNearPositionR628_g241858 = TVE_RenderNearPositionR;
					float temp_output_507_0_g241858 = saturate( ( distance( Model_PositionWS497_g241858 , (TVE_RenderNearPositionR628_g241858).xyz ) / (TVE_RenderNearPositionR628_g241858).w ) );
					float temp_output_7_0_g241947 = 1.0;
					float temp_output_9_0_g241947 = ( temp_output_507_0_g241858 - temp_output_7_0_g241947 );
					half TVE_RenderNearFadeValue635_g241858 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g241858 = saturate( ( temp_output_9_0_g241947 / ( ( TVE_RenderNearFadeValue635_g241858 - temp_output_7_0_g241947 ) + 0.0001 ) ) );
					float4 lerpResult131_g241877 = lerp( appendResult210_g241877 , appendResult212_g241877 , Global_TexBlend509_g241858);
					float4 temp_output_159_109_g241875 = lerpResult131_g241877;
					float4 lerpResult168_g241875 = lerp( TVE_CoatParams , temp_output_159_109_g241875 , TVE_CoatLayers[(int)temp_output_82_0_g241875]);
					float4 temp_output_589_109_g241858 = lerpResult168_g241875;
					half4 Coat_Texture302_g241858 = temp_output_589_109_g241858;
					float4 In_CoatTexture204_g241858 = Coat_Texture302_g241858;
					half4 Draw_Texture656_g241858 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g241858 = Draw_Texture656_g241858;
					float4 temp_output_203_0_g241902 = TVE_PaintBaseCoord;
					float2 lerpResult85_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g241902 = lerpResult85_g241858;
					float temp_output_82_0_g241899 = _GlobalPaintLayerValue;
					float temp_output_82_0_g241902 = temp_output_82_0_g241899;
					float4 tex2DArrayNode83_g241902 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241902).zw + ( (temp_output_203_0_g241902).xy * temp_output_81_0_g241902 ) ),temp_output_82_0_g241902), 0.0 );
					float4 appendResult210_g241902 = (float4(tex2DArrayNode83_g241902.rgb , tex2DArrayNode83_g241902.a));
					float4 temp_output_204_0_g241902 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g241902 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241902).zw + ( (temp_output_204_0_g241902).xy * temp_output_81_0_g241902 ) ),temp_output_82_0_g241902), 0.0 );
					float4 appendResult212_g241902 = (float4(tex2DArrayNode122_g241902.rgb , tex2DArrayNode122_g241902.a));
					float4 lerpResult131_g241902 = lerp( appendResult210_g241902 , appendResult212_g241902 , Global_TexBlend509_g241858);
					float4 temp_output_171_109_g241899 = lerpResult131_g241902;
					float4 lerpResult174_g241899 = lerp( TVE_PaintParams , temp_output_171_109_g241899 , TVE_PaintLayers[(int)temp_output_82_0_g241899]);
					float4 temp_output_595_109_g241858 = lerpResult174_g241899;
					half4 Paint_Texture71_g241858 = temp_output_595_109_g241858;
					float4 In_PaintTexture204_g241858 = Paint_Texture71_g241858;
					float4 temp_output_203_0_g241885 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g241885 = lerpResult104_g241858;
					float temp_output_132_0_g241883 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g241885 = temp_output_132_0_g241883;
					float4 tex2DArrayNode83_g241885 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241885).zw + ( (temp_output_203_0_g241885).xy * temp_output_81_0_g241885 ) ),temp_output_82_0_g241885), 0.0 );
					float4 appendResult210_g241885 = (float4(tex2DArrayNode83_g241885.rgb , tex2DArrayNode83_g241885.a));
					float4 temp_output_204_0_g241885 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g241885 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241885).zw + ( (temp_output_204_0_g241885).xy * temp_output_81_0_g241885 ) ),temp_output_82_0_g241885), 0.0 );
					float4 appendResult212_g241885 = (float4(tex2DArrayNode122_g241885.rgb , tex2DArrayNode122_g241885.a));
					float4 lerpResult131_g241885 = lerp( appendResult210_g241885 , appendResult212_g241885 , Global_TexBlend509_g241858);
					float4 temp_output_137_109_g241883 = lerpResult131_g241885;
					float4 lerpResult145_g241883 = lerp( TVE_AtmoParams , temp_output_137_109_g241883 , TVE_AtmoLayers[(int)temp_output_132_0_g241883]);
					float4 temp_output_590_110_g241858 = lerpResult145_g241883;
					half4 Atmo_Texture80_g241858 = temp_output_590_110_g241858;
					float4 In_AtmoTexture204_g241858 = Atmo_Texture80_g241858;
					float4 temp_output_203_0_g241953 = TVE_EffexBaseCoord;
					float2 lerpResult414_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g241953 = lerpResult414_g241858;
					float temp_output_132_0_g241951 = _GlobalEffexLayerValue;
					float temp_output_82_0_g241953 = temp_output_132_0_g241951;
					float4 tex2DArrayNode83_g241953 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241953).zw + ( (temp_output_203_0_g241953).xy * temp_output_81_0_g241953 ) ),temp_output_82_0_g241953), 0.0 );
					float4 appendResult210_g241953 = (float4(tex2DArrayNode83_g241953.rgb , tex2DArrayNode83_g241953.a));
					float4 temp_output_204_0_g241953 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g241953 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241953).zw + ( (temp_output_204_0_g241953).xy * temp_output_81_0_g241953 ) ),temp_output_82_0_g241953), 0.0 );
					float4 appendResult212_g241953 = (float4(tex2DArrayNode122_g241953.rgb , tex2DArrayNode122_g241953.a));
					float4 lerpResult131_g241953 = lerp( appendResult210_g241953 , appendResult212_g241953 , Global_TexBlend509_g241858);
					float4 temp_output_137_109_g241951 = lerpResult131_g241953;
					float4 lerpResult145_g241951 = lerp( TVE_EffexParams , temp_output_137_109_g241951 , TVE_EffexLayers[(int)temp_output_132_0_g241951]);
					float4 temp_output_731_110_g241858 = lerpResult145_g241951;
					half4 Effex_Texture420_g241858 = temp_output_731_110_g241858;
					float4 In_EffexTexture204_g241858 = Effex_Texture420_g241858;
					float4 temp_output_203_0_g241933 = TVE_GlowBaseCoord;
					float2 lerpResult247_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g241933 = lerpResult247_g241858;
					float temp_output_82_0_g241931 = _GlobalGlowLayerValue;
					float temp_output_82_0_g241933 = temp_output_82_0_g241931;
					float4 tex2DArrayNode83_g241933 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241933).zw + ( (temp_output_203_0_g241933).xy * temp_output_81_0_g241933 ) ),temp_output_82_0_g241933), 0.0 );
					float4 appendResult210_g241933 = (float4(tex2DArrayNode83_g241933.rgb , tex2DArrayNode83_g241933.a));
					float4 temp_output_204_0_g241933 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g241933 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241933).zw + ( (temp_output_204_0_g241933).xy * temp_output_81_0_g241933 ) ),temp_output_82_0_g241933), 0.0 );
					float4 appendResult212_g241933 = (float4(tex2DArrayNode122_g241933.rgb , tex2DArrayNode122_g241933.a));
					float4 lerpResult131_g241933 = lerp( appendResult210_g241933 , appendResult212_g241933 , Global_TexBlend509_g241858);
					float4 temp_output_159_109_g241931 = lerpResult131_g241933;
					float4 lerpResult167_g241931 = lerp( TVE_GlowParams , temp_output_159_109_g241931 , TVE_GlowLayers[(int)temp_output_82_0_g241931]);
					float4 temp_output_593_109_g241858 = lerpResult167_g241931;
					half4 Glow_Texture248_g241858 = temp_output_593_109_g241858;
					float4 In_GlowTexture204_g241858 = Glow_Texture248_g241858;
					float4 temp_output_203_0_g241869 = TVE_FormBaseCoord;
					float2 lerpResult168_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g241869 = lerpResult168_g241858;
					float temp_output_130_0_g241867 = _GlobalFormLayerValue;
					float temp_output_82_0_g241869 = temp_output_130_0_g241867;
					float4 tex2DArrayNode83_g241869 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241869).zw + ( (temp_output_203_0_g241869).xy * temp_output_81_0_g241869 ) ),temp_output_82_0_g241869), 0.0 );
					float4 appendResult210_g241869 = (float4(tex2DArrayNode83_g241869.rgb , tex2DArrayNode83_g241869.a));
					float4 temp_output_204_0_g241869 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g241869 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241869).zw + ( (temp_output_204_0_g241869).xy * temp_output_81_0_g241869 ) ),temp_output_82_0_g241869), 0.0 );
					float4 appendResult212_g241869 = (float4(tex2DArrayNode122_g241869.rgb , tex2DArrayNode122_g241869.a));
					float4 lerpResult131_g241869 = lerp( appendResult210_g241869 , appendResult212_g241869 , Global_TexBlend509_g241858);
					float4 temp_output_135_109_g241867 = lerpResult131_g241869;
					float4 lerpResult143_g241867 = lerp( TVE_FormParams , temp_output_135_109_g241867 , TVE_FormLayers[(int)temp_output_130_0_g241867]);
					float4 temp_output_592_0_g241858 = lerpResult143_g241867;
					float4 Form_Texture112_g241858 = temp_output_592_0_g241858;
					float4 In_FormTexture204_g241858 = Form_Texture112_g241858;
					float4 In_LandTexture204_g241858 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g241917 = TVE_VertxBaseCoord;
					float2 lerpResult681_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g241917 = lerpResult681_g241858;
					float temp_output_136_0_g241915 = _GlobalVertxLayerValue;
					float temp_output_82_0_g241917 = temp_output_136_0_g241915;
					float4 tex2DArrayNode83_g241917 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241917).zw + ( (temp_output_203_0_g241917).xy * temp_output_81_0_g241917 ) ),temp_output_82_0_g241917), 0.0 );
					float4 appendResult210_g241917 = (float4(tex2DArrayNode83_g241917.rgb , tex2DArrayNode83_g241917.a));
					float4 temp_output_204_0_g241917 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g241917 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241917).zw + ( (temp_output_204_0_g241917).xy * temp_output_81_0_g241917 ) ),temp_output_82_0_g241917), 0.0 );
					float4 appendResult212_g241917 = (float4(tex2DArrayNode122_g241917.rgb , tex2DArrayNode122_g241917.a));
					float4 lerpResult131_g241917 = lerp( appendResult210_g241917 , appendResult212_g241917 , Global_TexBlend509_g241858);
					float4 temp_output_141_109_g241915 = lerpResult131_g241917;
					float4 lerpResult149_g241915 = lerp( TVE_VertxParams , temp_output_141_109_g241915 , TVE_VertxLayers[(int)temp_output_136_0_g241915]);
					float4 temp_output_695_0_g241858 = lerpResult149_g241915;
					half4 Vertx_Texture693_g241858 = temp_output_695_0_g241858;
					float4 In_VertxTexture204_g241858 = Vertx_Texture693_g241858;
					float4 temp_output_203_0_g241893 = TVE_FlowBaseCoord;
					float2 lerpResult400_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g241893 = lerpResult400_g241858;
					float temp_output_136_0_g241891 = _GlobalFlowLayerValue;
					float temp_output_82_0_g241893 = temp_output_136_0_g241891;
					float4 tex2DArrayNode83_g241893 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241893).zw + ( (temp_output_203_0_g241893).xy * temp_output_81_0_g241893 ) ),temp_output_82_0_g241893), 0.0 );
					float4 appendResult210_g241893 = (float4(tex2DArrayNode83_g241893.rgb , tex2DArrayNode83_g241893.a));
					float4 temp_output_204_0_g241893 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g241893 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241893).zw + ( (temp_output_204_0_g241893).xy * temp_output_81_0_g241893 ) ),temp_output_82_0_g241893), 0.0 );
					float4 appendResult212_g241893 = (float4(tex2DArrayNode122_g241893.rgb , tex2DArrayNode122_g241893.a));
					float4 lerpResult131_g241893 = lerp( appendResult210_g241893 , appendResult212_g241893 , Global_TexBlend509_g241858);
					float4 temp_output_141_109_g241891 = lerpResult131_g241893;
					float4 lerpResult149_g241891 = lerp( TVE_FlowParams , temp_output_141_109_g241891 , TVE_FlowLayers[(int)temp_output_136_0_g241891]);
					float4 temp_output_594_0_g241858 = lerpResult149_g241891;
					half4 Flow_Texture405_g241858 = temp_output_594_0_g241858;
					float4 In_FlowTexture204_g241858 = Flow_Texture405_g241858;
					half4 User_Texture677_g241858 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g241858 = User_Texture677_g241858;
					BuildGlobalData( Data204_g241858 , In_Dummy204_g241858 , In_CoatTexture204_g241858 , In_DrawTexture204_g241858 , In_PaintTexture204_g241858 , In_AtmoTexture204_g241858 , In_EffexTexture204_g241858 , In_GlowTexture204_g241858 , In_FormTexture204_g241858 , In_LandTexture204_g241858 , In_VertxTexture204_g241858 , In_FlowTexture204_g241858 , In_UserTexture204_g241858 );
					TVEGlobalData Data15_g251571 =(TVEGlobalData)Data204_g241858;
					float Out_Dummy15_g251571 = 0.0;
					float4 Out_CoatTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251571 = float4( 0,0,0,0 );
					BreakData( Data15_g251571 , Out_Dummy15_g251571 , Out_CoatTexture15_g251571 , Out_DrawTexture15_g251571 , Out_PaintTexture15_g251571 , Out_AtmoTexture15_g251571 , Out_EffexTexture15_g251571 , Out_GlowTexture15_g251571 , Out_FormTexture15_g251571 , Out_LandTexture15_g251571 , Out_VertxTexture15_g251571 , Out_FlowTexture15_g251571 , Out_UserTexture15_g251571 );
					float4 Global_FormTexture351_g251561 = Out_FormTexture15_g251571;
					TVEModelData Data15_g251568 =(TVEModelData)Data15_g251556;
					float Out_Dummy15_g251568 = 0.0;
					float3 Out_PositionOS15_g251568 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251568 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251568 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251568 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251568 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251568 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251568 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251568 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251568 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251568 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251568 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251568 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251568 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251568 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251568 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251568 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251568 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251568 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251568 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251568 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251568 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251568 , Out_Dummy15_g251568 , Out_PositionOS15_g251568 , Out_PositionWS15_g251568 , Out_PositionWO15_g251568 , Out_PositionRawOS15_g251568 , Out_PivotOS15_g251568 , Out_PivotWS15_g251568 , Out_PivotWO15_g251568 , Out_NormalOS15_g251568 , Out_NormalWS15_g251568 , Out_NormalRawOS15_g251568 , Out_TangentOS15_g251568 , Out_TangentWS15_g251568 , Out_BitangentWS15_g251568 , Out_ViewDirWS15_g251568 , Out_CoordsData15_g251568 , Out_VertexData15_g251568 , Out_MasksData15_g251568 , Out_PhaseData15_g251568 , Out_TransformData15_g251568 , Out_RotationData15_g251568 , Out_Interpolator15_g251568 );
					float3 Model_PivotWO353_g251561 = Out_PivotWO15_g251568;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251567 = _ConformMeshMode;
					float Option70_g251567 = temp_output_17_0_g251567;
					half4 Model_VertexData357_g251561 = Out_VertexData15_g251568;
					float4 temp_output_3_0_g251567 = Model_VertexData357_g251561;
					float4 Channel70_g251567 = temp_output_3_0_g251567;
					float localSwitchChannel470_g251567 = SwitchChannel4( Option70_g251567 , Channel70_g251567 );
					float temp_output_390_0_g251561 = localSwitchChannel470_g251567;
					float temp_output_7_0_g251564 = _ConformMeshRemap.x;
					float temp_output_9_0_g251564 = ( temp_output_390_0_g251561 - temp_output_7_0_g251564 );
					float lerpResult374_g251561 = lerp( 1.0 , saturate( ( temp_output_9_0_g251564 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251561 = lerpResult374_g251561;
					float temp_output_328_0_g251561 = ( Blend_VertMask379_g251561 * TVE_IsEnabled );
					half Conform_Mask366_g251561 = temp_output_328_0_g251561;
					float temp_output_322_0_g251561 = ( ( ( ( (Global_FormTexture351_g251561).z - ( (Model_PivotWO353_g251561).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251561 ) );
					float3 appendResult329_g251561 = (float3(0.0 , temp_output_322_0_g251561 , 0.0));
					float3 appendResult387_g251561 = (float3(0.0 , 0.0 , temp_output_322_0_g251561));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251565 = appendResult387_g251561;
					#else
					float3 staticSwitch65_g251565 = appendResult329_g251561;
					#endif
					float3 Blanket_Conform368_g251561 = staticSwitch65_g251565;
					float4 appendResult312_g251561 = (float4(Blanket_Conform368_g251561 , 0.0));
					float4 temp_output_310_0_g251561 = ( Model_TransformData356_g251561 + appendResult312_g251561 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251561 = temp_output_310_0_g251561;
					#else
					float4 staticSwitch364_g251561 = Model_TransformData356_g251561;
					#endif
					half4 Final_TransformData365_g251561 = staticSwitch364_g251561;
					float4 In_TransformData16_g251570 = Final_TransformData365_g251561;
					float4 In_RotationData16_g251570 = Out_RotationData15_g251569;
					float4 In_Interpolator16_g251570 = Out_Interpolator15_g251569;
					BuildVertexData( Data16_g251570 , In_Dummy16_g251570 , In_PositionOS16_g251570 , In_NormalOS16_g251570 , In_TangentOS16_g251570 , In_TransformData16_g251570 , In_RotationData16_g251570 , In_Interpolator16_g251570 );
					TVEVertexData Data15_g251653 =(TVEVertexData)Data16_g251570;
					float Out_Dummy15_g251653 = 0.0;
					float3 Out_PositionOS15_g251653 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251653 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251653 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251653 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251653 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251653 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251653 , Out_Dummy15_g251653 , Out_PositionOS15_g251653 , Out_NormalOS15_g251653 , Out_TangentOS15_g251653 , Out_TransformData15_g251653 , Out_RotationData15_g251653 , Out_Interpolator15_g251653 );
					TVEVertexData Data16_g251654 =(TVEVertexData)Data15_g251653;
					half Dummy181_g251640 = ( ( _MotionCategory + _MotionEnd ) + _MotionFlowInfo );
					float In_Dummy16_g251654 = Dummy181_g251640;
					float3 temp_output_3325_0_g251640 = Out_PositionOS15_g251653;
					float3 In_PositionOS16_g251654 = temp_output_3325_0_g251640;
					float3 In_NormalOS16_g251654 = Out_NormalOS15_g251653;
					float4 In_TangentOS16_g251654 = Out_TangentOS15_g251653;
					half4 Vertex_TransformData2743_g251640 = Out_TransformData15_g251653;
					float3 temp_cast_13 = (0.0).xxx;
					half Motion_FlowValue3376_g251640 = _MotionFlowValue;
					float2 lerpResult3361_g251640 = lerp( (half4( 1, 1, 1, 0 )).xy , (TVE_WindParams).xy , ( Motion_FlowValue3376_g251640 * TVE_IsEnabled ));
					float2 Global_WindDirWS2542_g251640 = (lerpResult3361_g251640*2.0 + -1.0);
					half2 Input_WindDirWS803_g251687 = Global_WindDirWS2542_g251640;
					TVEModelData Data15_g251652 =(TVEModelData)Data15_g251568;
					float Out_Dummy15_g251652 = 0.0;
					float3 Out_PositionOS15_g251652 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251652 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251652 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251652 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251652 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251652 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251652 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251652 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251652 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251652 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251652 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251652 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251652 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251652 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251652 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251652 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251652 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251652 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251652 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251652 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251652 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251652 , Out_Dummy15_g251652 , Out_PositionOS15_g251652 , Out_PositionWS15_g251652 , Out_PositionWO15_g251652 , Out_PositionRawOS15_g251652 , Out_PivotOS15_g251652 , Out_PivotWS15_g251652 , Out_PivotWO15_g251652 , Out_NormalOS15_g251652 , Out_NormalWS15_g251652 , Out_NormalRawOS15_g251652 , Out_TangentOS15_g251652 , Out_TangentWS15_g251652 , Out_BitangentWS15_g251652 , Out_ViewDirWS15_g251652 , Out_CoordsData15_g251652 , Out_VertexData15_g251652 , Out_MasksData15_g251652 , Out_PhaseData15_g251652 , Out_TransformData15_g251652 , Out_RotationData15_g251652 , Out_Interpolator15_g251652 );
					float3 Model_PositionWO162_g251640 = Out_PositionWO15_g251652;
					half3 Input_ModelPositionWO761_g251650 = Model_PositionWO162_g251640;
					float3 Model_PivotWO402_g251640 = Out_PivotWO15_g251652;
					half3 Input_ModelPivotsWO419_g251650 = Model_PivotWO402_g251640;
					half Input_MotionPivots629_g251650 = _MotionSmallPivotValue;
					float3 lerpResult771_g251650 = lerp( Input_ModelPositionWO761_g251650 , Input_ModelPivotsWO419_g251650 , Input_MotionPivots629_g251650);
					half4 Model_PhaseData489_g251640 = Out_PhaseData15_g251652;
					half4 Input_ModelMotionData763_g251650 = Model_PhaseData489_g251640;
					half Input_MotionPhase764_g251650 = _MotionSmallPhaseValue;
					float temp_output_770_0_g251650 = ( (Input_ModelMotionData763_g251650).x * Input_MotionPhase764_g251650 );
					half3 Small_Position1421_g251640 = ( lerpResult771_g251650 + temp_output_770_0_g251650 );
					half3 Input_PositionWO419_g251687 = Small_Position1421_g251640;
					half Input_MotionTilling321_g251687 = ( _MotionSmallTillingValue + 0.2 );
					half2 Noise_Coord979_g251687 = ( -(Input_PositionWO419_g251687).xz * Input_MotionTilling321_g251687 * 0.005 );
					float2 Input_Coords80_g251691 = Noise_Coord979_g251687;
					half2 Input_Direction82_g251691 = Input_WindDirWS803_g251687;
					float mulTime113_g251705 = _Time.y * 0.02;
					float lerpResult128_g251705 = lerp( mulTime113_g251705 , ( ( mulTime113_g251705 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					#ifdef SHADER_API_MOBILE
					float staticSwitch134_g251705 = frac( lerpResult128_g251705 );
					#else
					float staticSwitch134_g251705 = lerpResult128_g251705;
					#endif
					float Global_WindTime3262_g251640 = staticSwitch134_g251705;
					half Input_WindTime1015_g251687 = Global_WindTime3262_g251640;
					half Input_MotionSpeed62_g251687 = _MotionSmallSpeedValue;
					float temp_output_986_0_g251687 = ( Input_WindTime1015_g251687 * Input_MotionSpeed62_g251687 );
					half Noise_Speed980_g251687 = temp_output_986_0_g251687;
					float Input_Time88_g251691 = Noise_Speed980_g251687;
					float temp_output_23_0_g251691 = frac( Input_Time88_g251691 );
					float4 lerpResult39_g251691 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251691 + ( Input_Direction82_g251691 * temp_output_23_0_g251691 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251691 + ( Input_Direction82_g251691 * ( temp_output_23_0_g251691 - 1.0 ) ) ), 0.0 ) , temp_output_23_0_g251691);
					float4 temp_output_991_0_g251687 = lerpResult39_g251691;
					half2 Noise_DirWS858_g251687 = ((temp_output_991_0_g251687).rg*2.0 + -1.0);
					half Input_MotionNoise552_g251687 = _MotionSmallNoiseValue;
					float4 temp_output_3332_0_g251640 = TVE_FlowParams;
					TVEGlobalData Data15_g251666 =(TVEGlobalData)Data15_g251571;
					float Out_Dummy15_g251666 = 0.0;
					float4 Out_CoatTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251666 = float4( 0,0,0,0 );
					BreakData( Data15_g251666 , Out_Dummy15_g251666 , Out_CoatTexture15_g251666 , Out_DrawTexture15_g251666 , Out_PaintTexture15_g251666 , Out_AtmoTexture15_g251666 , Out_EffexTexture15_g251666 , Out_GlowTexture15_g251666 , Out_FormTexture15_g251666 , Out_LandTexture15_g251666 , Out_VertxTexture15_g251666 , Out_FlowTexture15_g251666 , Out_UserTexture15_g251666 );
					half4 Global_FlowTexture2668_g251640 = Out_FlowTexture15_g251666;
					#ifdef TVE_MOTION_FLOW
					float4 staticSwitch3075_g251640 = Global_FlowTexture2668_g251640;
					#else
					float4 staticSwitch3075_g251640 = temp_output_3332_0_g251640;
					#endif
					float4 temp_output_6_0_g251667 = staticSwitch3075_g251640;
					float temp_output_7_0_g251667 = _MotionFlowMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g251667 = ( temp_output_6_0_g251667 + temp_output_7_0_g251667 );
					#else
					float4 staticSwitch14_g251667 = temp_output_6_0_g251667;
					#endif
					float4 lerpResult3121_g251640 = lerp( half4( 1, 1, 1, 0 ) , staticSwitch14_g251667 , ( Motion_FlowValue3376_g251640 * TVE_IsEnabled ));
					float temp_output_3077_0_g251640 = (lerpResult3121_g251640).z;
					float temp_output_630_0_g251676 = temp_output_3077_0_g251640;
					float lerpResult853_g251676 = lerp( temp_output_630_0_g251676 , TVE_WindEditor.z , TVE_WindEditor.w);
					half Global_WindValue1855_g251640 = ( lerpResult853_g251676 * _MotionIntensityValue );
					half Input_WindValue881_g251687 = Global_WindValue1855_g251640;
					float temp_output_6_0_g251689 = Input_WindValue881_g251687;
					float lerpResult701_g251687 = lerp( 1.0 , Input_MotionNoise552_g251687 , ( temp_output_6_0_g251689 * temp_output_6_0_g251689 ));
					float2 lerpResult646_g251687 = lerp( Input_WindDirWS803_g251687 , Noise_DirWS858_g251687 , lerpResult701_g251687);
					half2 Small_DirWS817_g251687 = lerpResult646_g251687;
					float2 break823_g251687 = Small_DirWS817_g251687;
					half4 Noise_Params685_g251687 = temp_output_991_0_g251687;
					half Wind_Sinus820_g251687 = ( ((Noise_Params685_g251687).b*2.0 + -1.0) * 0.6 );
					float3 appendResult824_g251687 = (float3(break823_g251687.x , Wind_Sinus820_g251687 , break823_g251687.y));
					half3 Small_Dir918_g251687 = appendResult824_g251687;
					float temp_output_20_0_g251688 = ( 1.0 - Input_WindValue881_g251687 );
					float3 appendResult1006_g251687 = (float3(Input_WindValue881_g251687 , ( 1.0 - ( temp_output_20_0_g251688 * temp_output_20_0_g251688 ) ) , Input_WindValue881_g251687));
					half Input_MotionDelay753_g251687 = _MotionSmallDelayValue;
					float lerpResult756_g251687 = lerp( 1.0 , ( Input_WindValue881_g251687 * Input_WindValue881_g251687 ) , Input_MotionDelay753_g251687);
					half Wind_Delay815_g251687 = lerpResult756_g251687;
					half Input_MotionValue905_g251687 = _MotionSmallIntensityValue;
					float3 temp_output_883_0_g251687 = ( Small_Dir918_g251687 * appendResult1006_g251687 * Wind_Delay815_g251687 * Input_MotionValue905_g251687 );
					float2 break857_g251687 = Noise_DirWS858_g251687;
					float3 appendResult833_g251687 = (float3(break857_g251687.x , Wind_Sinus820_g251687 , break857_g251687.y));
					half3 Push_Dir919_g251687 = appendResult833_g251687;
					half Input_MotionReact924_g251687 = _MotionSmallPushValue;
					half Global_PushAlpha1504_g251640 = (lerpResult3121_g251640).w;
					half Input_PushAlpha806_g251687 = Global_PushAlpha1504_g251640;
					half Global_PushNoise2675_g251640 = temp_output_3077_0_g251640;
					half Input_PushNoise890_g251687 = Global_PushNoise2675_g251640;
					half Push_Mask914_g251687 = saturate( ( Input_PushAlpha806_g251687 * Input_PushNoise890_g251687 * Input_MotionReact924_g251687 ) );
					float3 lerpResult840_g251687 = lerp( temp_output_883_0_g251687 , ( Push_Dir919_g251687 * Input_MotionReact924_g251687 ) , Push_Mask914_g251687);
					#ifdef TVE_MOTION_FLOW
					float3 staticSwitch829_g251687 = lerpResult840_g251687;
					#else
					float3 staticSwitch829_g251687 = temp_output_883_0_g251687;
					#endif
					float3 ase_parentObjectScale = ( 1.0 / float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ) );
					half3 Small_Squash1489_g251640 = ( mul( unity_WorldToObject, float4( staticSwitch829_g251687 , 0.0 ) ).xyz * ase_parentObjectScale );
					float temp_output_17_0_g251655 = _MotionSmallMaskMode;
					float Option92_g251655 = temp_output_17_0_g251655;
					half4 Model_VertexMasks518_g251640 = Out_VertexData15_g251652;
					float4 temp_output_84_0_g251655 = Model_VertexMasks518_g251640;
					float4 ChannelA92_g251655 = temp_output_84_0_g251655;
					half4 Model_MasksData1322_g251640 = Out_MasksData15_g251652;
					float2 uv_MotionMaskTex2818_g251640 = v.texcoord.xyzw.xy;
					half4 Motion_MaskTex2819_g251640 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex2818_g251640, 0.0 );
					float3 appendResult3227_g251640 = (float3((Model_MasksData1322_g251640).xy , (Motion_MaskTex2819_g251640).g));
					float3 temp_output_85_0_g251655 = appendResult3227_g251640;
					float4 ChannelB92_g251655 = float4( temp_output_85_0_g251655 , 0.0 );
					float localSwitchChannel792_g251655 = SwitchChannel7( Option92_g251655 , ChannelA92_g251655 , ChannelB92_g251655 );
					float enc1805_g251640 = v.texcoord.xyzw.z;
					float2 localDecodeFloatToVector21805_g251640 = DecodeFloatToVector2( enc1805_g251640 );
					float2 break1804_g251640 = localDecodeFloatToVector21805_g251640;
					half Small_Mask_Legacy1806_g251640 = break1804_g251640.x;
					#ifdef TVE_LEGACY
					float staticSwitch1800_g251640 = Small_Mask_Legacy1806_g251640;
					#else
					float staticSwitch1800_g251640 = localSwitchChannel792_g251655;
					#endif
					float clampResult17_g251641 = clamp( staticSwitch1800_g251640 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251642 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g251642 = ( clampResult17_g251641 - temp_output_7_0_g251642 );
					half Small_Mask640_g251640 = saturate( ( temp_output_9_0_g251642 * _MotionSmallMaskRemap.z ) );
					float3 lerpResult3022_g251640 = lerp( float3( 1,1,1 ) , (TVE_MotionValueParams).xyz , TVE_MotionValueParams.w);
					half3 Global_MotionParams3013_g251640 = lerpResult3022_g251640;
					half3 Small_Motion789_g251640 = ( Small_Squash1489_g251640 * Small_Mask640_g251640 * (Global_MotionParams3013_g251640).y );
					#ifdef TVE_MOTION
					float3 staticSwitch495_g251640 = Small_Motion789_g251640;
					#else
					float3 staticSwitch495_g251640 = temp_cast_13;
					#endif
					float3 temp_cast_17 = (0.0).xxx;
					half3 Tiny_Position2469_g251640 = Model_PositionWO162_g251640;
					half3 Input_PositionWO419_g251706 = Tiny_Position2469_g251640;
					half Input_MotionTilling321_g251706 = ( _MotionTinyTillingValue + 0.2 );
					half2 Noise_Coord979_g251706 = ( -(Input_PositionWO419_g251706).xz * Input_MotionTilling321_g251706 * 0.005 );
					float2 Input_Coords80_g251713 = Noise_Coord979_g251706;
					half2 Input_Direction82_g251713 = float2( 0,1 );
					half Input_WindTime1015_g251706 = Global_WindTime3262_g251640;
					half Input_MotionSpeed62_g251706 = _MotionTinySpeedValue;
					float temp_output_986_0_g251706 = ( Input_WindTime1015_g251706 * Input_MotionSpeed62_g251706 );
					half Noise_Speed980_g251706 = temp_output_986_0_g251706;
					float Input_Time88_g251713 = Noise_Speed980_g251706;
					float4 temp_output_991_0_g251706 = SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251713 + ( Input_Direction82_g251713 * Input_Time88_g251713 ) ), 0.0 );
					half3 Noise_DirWS858_g251706 = ((temp_output_991_0_g251706).rgb*2.0 + -1.0);
					half Input_MotionNoise552_g251706 = _MotionTinyNoiseValue;
					float3 lerpResult646_g251706 = lerp( ( Noise_DirWS858_g251706 * v.normal ) , Noise_DirWS858_g251706 , Input_MotionNoise552_g251706);
					half3 Tiny_DirWS817_g251706 = lerpResult646_g251706;
					half Input_MotionValue905_g251706 = _MotionTinyIntensityValue;
					float mulTime113_g251719 = _Time.y * 2.0;
					float lerpResult128_g251719 = lerp( mulTime113_g251719 , ( ( mulTime113_g251719 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					#ifdef SHADER_API_MOBILE
					float staticSwitch134_g251719 = frac( lerpResult128_g251719 );
					#else
					float staticSwitch134_g251719 = lerpResult128_g251719;
					#endif
					float3 temp_output_1028_0_g251706 = ( Input_PositionWO419_g251706 + staticSwitch134_g251719 );
					float temp_output_1054_0_g251706 = SAMPLE_TEXTURE3D_LOD( _NoiseTex3D, sampler_Linear_Repeat, ( temp_output_1028_0_g251706 * ( 1.0 * 0.01 ) ), 0.0 ).r;
					float temp_output_6_0_g251709 = temp_output_1054_0_g251706;
					float temp_output_6_0_g251710 = temp_output_1054_0_g251706;
					half Input_WindValue881_g251706 = Global_WindValue1855_g251640;
					float temp_output_6_0_g251712 = Input_WindValue881_g251706;
					float lerpResult1029_g251706 = lerp( ( temp_output_6_0_g251709 * temp_output_6_0_g251709 * temp_output_6_0_g251709 * temp_output_6_0_g251709 ) , ( temp_output_6_0_g251710 * temp_output_6_0_g251710 ) , ( temp_output_6_0_g251712 * temp_output_6_0_g251712 ));
					float temp_output_20_0_g251711 = ( 1.0 - Input_WindValue881_g251706 );
					float temp_output_1030_0_g251706 = ( lerpResult1029_g251706 * ( 1.0 - ( temp_output_20_0_g251711 * temp_output_20_0_g251711 * temp_output_20_0_g251711 * temp_output_20_0_g251711 ) ) );
					half Wind_Gust1039_g251706 = temp_output_1030_0_g251706;
					float3 temp_output_883_0_g251706 = ( Tiny_DirWS817_g251706 * Input_MotionValue905_g251706 * Wind_Gust1039_g251706 );
					half3 Tiny_Squash859_g251640 = temp_output_883_0_g251706;
					float temp_output_17_0_g251656 = _MotionTinyMaskMode;
					float Option92_g251656 = temp_output_17_0_g251656;
					float4 temp_output_84_0_g251656 = Model_VertexMasks518_g251640;
					float4 ChannelA92_g251656 = temp_output_84_0_g251656;
					float3 appendResult3234_g251640 = (float3((Model_MasksData1322_g251640).xy , (Motion_MaskTex2819_g251640).b));
					float3 temp_output_85_0_g251656 = appendResult3234_g251640;
					float4 ChannelB92_g251656 = float4( temp_output_85_0_g251656 , 0.0 );
					float localSwitchChannel792_g251656 = SwitchChannel7( Option92_g251656 , ChannelA92_g251656 , ChannelB92_g251656 );
					half Tiny_Mask_Legacy1807_g251640 = break1804_g251640.y;
					#ifdef TVE_LEGACY
					float staticSwitch1810_g251640 = Tiny_Mask_Legacy1807_g251640;
					#else
					float staticSwitch1810_g251640 = localSwitchChannel792_g251656;
					#endif
					float clampResult17_g251643 = clamp( staticSwitch1810_g251640 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251644 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g251644 = ( clampResult17_g251643 - temp_output_7_0_g251644 );
					half Tiny_Mask218_g251640 = saturate( ( temp_output_9_0_g251644 * _MotionTinyMaskRemap.z ) );
					float3 Model_PositionWS1819_g251640 = Out_PositionWS15_g251652;
					half Global_DistMask1820_g251640 = ( 1.0 - saturate( ( distance( _WorldSpaceCameraPos , Model_PositionWS1819_g251640 ) / _MotionDistValue ) ) );
					half3 Tiny_Flutter1451_g251640 = ( Tiny_Squash859_g251640 * Tiny_Mask218_g251640 * Global_DistMask1820_g251640 * (Global_MotionParams3013_g251640).z );
					#ifdef TVE_MOTION
					float3 staticSwitch414_g251640 = Tiny_Flutter1451_g251640;
					#else
					float3 staticSwitch414_g251640 = temp_cast_17;
					#endif
					float4 appendResult2783_g251640 = (float4(( staticSwitch495_g251640 + staticSwitch414_g251640 ) , 0.0));
					half4 Final_TransformData1569_g251640 = ( Vertex_TransformData2743_g251640 + appendResult2783_g251640 );
					float4 In_TransformData16_g251654 = Final_TransformData1569_g251640;
					half4 Vertex_RotationData2740_g251640 = Out_RotationData15_g251653;
					half2 Input_WindDirWS803_g251677 = Global_WindDirWS2542_g251640;
					half3 Input_ModelPositionWO761_g251651 = Model_PositionWO162_g251640;
					half3 Input_ModelPivotsWO419_g251651 = Model_PivotWO402_g251640;
					half Input_MotionPivots629_g251651 = _MotionBasePivotValue;
					float3 lerpResult771_g251651 = lerp( Input_ModelPositionWO761_g251651 , Input_ModelPivotsWO419_g251651 , Input_MotionPivots629_g251651);
					half4 Input_ModelMotionData763_g251651 = Model_PhaseData489_g251640;
					half Input_MotionPhase764_g251651 = _MotionBasePhaseValue;
					float temp_output_770_0_g251651 = ( (Input_ModelMotionData763_g251651).x * Input_MotionPhase764_g251651 );
					half3 Base_Position1394_g251640 = ( lerpResult771_g251651 + temp_output_770_0_g251651 );
					half3 Input_PositionWO419_g251677 = Base_Position1394_g251640;
					half Input_MotionTilling321_g251677 = ( _MotionBaseTillingValue + 0.2 );
					half2 Noise_Coord515_g251677 = ( -(Input_PositionWO419_g251677).xz * Input_MotionTilling321_g251677 * 0.005 );
					float2 Input_Coords80_g251679 = Noise_Coord515_g251677;
					half2 Input_Direction82_g251679 = Input_WindDirWS803_g251677;
					half Input_WindTime963_g251677 = Global_WindTime3262_g251640;
					half Input_MotionSpeed62_g251677 = _MotionBaseSpeedValue;
					float temp_output_505_0_g251677 = ( Input_WindTime963_g251677 * Input_MotionSpeed62_g251677 );
					half Noise_Speed516_g251677 = temp_output_505_0_g251677;
					float Input_Time88_g251679 = Noise_Speed516_g251677;
					float temp_output_23_0_g251679 = frac( Input_Time88_g251679 );
					float4 lerpResult39_g251679 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251679 + ( Input_Direction82_g251679 * temp_output_23_0_g251679 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251679 + ( Input_Direction82_g251679 * ( temp_output_23_0_g251679 - 1.0 ) ) ), 0.0 ) , temp_output_23_0_g251679);
					float4 temp_output_635_0_g251677 = lerpResult39_g251679;
					half2 Noise_DirWS825_g251677 = ((temp_output_635_0_g251677).rg*2.0 + -1.0);
					half Input_MotionNoise552_g251677 = _MotionBaseNoiseValue;
					half Input_WindValue853_g251677 = Global_WindValue1855_g251640;
					float temp_output_6_0_g251678 = Input_WindValue853_g251677;
					float lerpResult701_g251677 = lerp( 1.0 , Input_MotionNoise552_g251677 , ( temp_output_6_0_g251678 * temp_output_6_0_g251678 ));
					float2 lerpResult646_g251677 = lerp( Input_WindDirWS803_g251677 , Noise_DirWS825_g251677 , lerpResult701_g251677);
					half2 Bend_Dir859_g251677 = lerpResult646_g251677;
					half Input_MotionValue871_g251677 = _MotionBaseIntensityValue;
					half Input_MotionDelay753_g251677 = _MotionBaseDelayValue;
					float lerpResult756_g251677 = lerp( 1.0 , ( Input_WindValue853_g251677 * Input_WindValue853_g251677 ) , Input_MotionDelay753_g251677);
					half Wind_Delay815_g251677 = lerpResult756_g251677;
					float2 temp_output_875_0_g251677 = ( Bend_Dir859_g251677 * Input_WindValue853_g251677 * Input_MotionValue871_g251677 * Wind_Delay815_g251677 );
					float2 Global_PushDirWS1972_g251640 = ((lerpResult3121_g251640).xy*2.0 + -1.0);
					half2 Input_PushDirWS807_g251677 = Global_PushDirWS1972_g251640;
					half Input_ReactValue888_g251677 = _MotionBasePushValue;
					half Input_PushAlpha806_g251677 = Global_PushAlpha1504_g251640;
					half Push_Mask883_g251677 = saturate( ( Input_PushAlpha806_g251677 * Input_ReactValue888_g251677 ) );
					float2 lerpResult811_g251677 = lerp( temp_output_875_0_g251677 , ( Input_PushDirWS807_g251677 * Input_ReactValue888_g251677 ) , Push_Mask883_g251677);
					#ifdef TVE_MOTION_FLOW
					float2 staticSwitch808_g251677 = lerpResult811_g251677;
					#else
					float2 staticSwitch808_g251677 = temp_output_875_0_g251677;
					#endif
					float2 temp_output_38_0_g251683 = staticSwitch808_g251677;
					float2 break83_g251683 = temp_output_38_0_g251683;
					float3 appendResult79_g251683 = (float3(break83_g251683.x , 0.0 , break83_g251683.y));
					half2 Base_Bending893_g251640 = (( mul( unity_WorldToObject, float4( appendResult79_g251683 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
					float temp_output_17_0_g251657 = _MotionBaseMaskMode;
					float Option92_g251657 = temp_output_17_0_g251657;
					float4 temp_output_84_0_g251657 = Model_VertexMasks518_g251640;
					float4 ChannelA92_g251657 = temp_output_84_0_g251657;
					float3 appendResult3220_g251640 = (float3((Model_MasksData1322_g251640).xy , (Motion_MaskTex2819_g251640).r));
					float3 temp_output_85_0_g251657 = appendResult3220_g251640;
					float4 ChannelB92_g251657 = float4( temp_output_85_0_g251657 , 0.0 );
					float localSwitchChannel792_g251657 = SwitchChannel7( Option92_g251657 , ChannelA92_g251657 , ChannelB92_g251657 );
					float clampResult17_g251646 = clamp( localSwitchChannel792_g251657 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251645 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g251645 = ( clampResult17_g251646 - temp_output_7_0_g251645 );
					half Base_Mask217_g251640 = saturate( ( temp_output_9_0_g251645 * _MotionBaseMaskRemap.z ) );
					half2 Base_Motion1440_g251640 = ( Base_Bending893_g251640 * Base_Mask217_g251640 * (Global_MotionParams3013_g251640).x );
					#ifdef TVE_MOTION
					float2 staticSwitch2384_g251640 = Base_Motion1440_g251640;
					#else
					float2 staticSwitch2384_g251640 = float2( 0,0 );
					#endif
					float4 appendResult2023_g251640 = (float4(staticSwitch2384_g251640 , 0.0 , 0.0));
					half4 Final_RotationData1570_g251640 = ( Vertex_RotationData2740_g251640 + appendResult2023_g251640 );
					float4 In_RotationData16_g251654 = Final_RotationData1570_g251640;
					half4 Vertex_Interpolator2773_g251640 = Out_Interpolator15_g251653;
					half4 Noise_Params685_g251677 = temp_output_635_0_g251677;
					float temp_output_6_0_g251685 = (Noise_Params685_g251677).a;
					float temp_output_913_0_g251677 = ( ( temp_output_6_0_g251685 * temp_output_6_0_g251685 * temp_output_6_0_g251685 * temp_output_6_0_g251685 ) * ( Input_WindValue853_g251677 * Wind_Delay815_g251677 ) );
					float temp_output_6_0_g251686 = length( Input_PushDirWS807_g251677 );
					float temp_output_937_0_g251677 = ( temp_output_6_0_g251686 * temp_output_6_0_g251686 );
					half Input_PushNoise858_g251677 = Global_PushNoise2675_g251640;
					float lerpResult902_g251677 = lerp( temp_output_913_0_g251677 , temp_output_937_0_g251677 , ( Push_Mask883_g251677 * Input_PushNoise858_g251677 ));
					#ifdef TVE_MOTION_FLOW
					float staticSwitch903_g251677 = lerpResult902_g251677;
					#else
					float staticSwitch903_g251677 = temp_output_913_0_g251677;
					#endif
					half Base_Wave1159_g251640 = staticSwitch903_g251677;
					float temp_output_6_0_g251690 = (Noise_Params685_g251687).a;
					float temp_output_955_0_g251687 = ( temp_output_6_0_g251690 * temp_output_6_0_g251690 * temp_output_6_0_g251690 * temp_output_6_0_g251690 );
					float temp_output_944_0_g251687 = ( temp_output_955_0_g251687 * ( Input_WindValue881_g251687 * Wind_Delay815_g251687 ) );
					float lerpResult936_g251687 = lerp( temp_output_944_0_g251687 , temp_output_955_0_g251687 , ( Push_Mask914_g251687 * Input_PushNoise890_g251687 ));
					#ifdef TVE_MOTION_FLOW
					float staticSwitch939_g251687 = lerpResult936_g251687;
					#else
					float staticSwitch939_g251687 = temp_output_944_0_g251687;
					#endif
					half Small_Wave1427_g251640 = staticSwitch939_g251687;
					float lerpResult2422_g251640 = lerp( Base_Wave1159_g251640 , Small_Wave1427_g251640 , _motion_small_mode);
					half Global_Wave1475_g251640 = saturate( lerpResult2422_g251640 );
					float temp_output_6_0_g251647 = ( _MotionHighlightValue * Global_DistMask1820_g251640 * ( Tiny_Mask218_g251640 * Tiny_Mask218_g251640 ) * Global_Wave1475_g251640 );
					float temp_output_7_0_g251647 = _MotionHighlightColor.r;
					#ifdef TVE_DUMMY
					float staticSwitch14_g251647 = ( temp_output_6_0_g251647 + temp_output_7_0_g251647 );
					#else
					float staticSwitch14_g251647 = temp_output_6_0_g251647;
					#endif
					#ifdef TVE_MOTION
					float staticSwitch2866_g251640 = staticSwitch14_g251647;
					#else
					float staticSwitch2866_g251640 = 0.0;
					#endif
					float4 appendResult2775_g251640 = (float4((Vertex_Interpolator2773_g251640).xyz , staticSwitch2866_g251640));
					half4 Final_Interpolator2774_g251640 = appendResult2775_g251640;
					float4 In_Interpolator16_g251654 = Final_Interpolator2774_g251640;
					BuildVertexData( Data16_g251654 , In_Dummy16_g251654 , In_PositionOS16_g251654 , In_NormalOS16_g251654 , In_TangentOS16_g251654 , In_TransformData16_g251654 , In_RotationData16_g251654 , In_Interpolator16_g251654 );
					TVEVertexData Data15_g251809 =(TVEVertexData)Data16_g251654;
					float Out_Dummy15_g251809 = 0.0;
					float3 Out_PositionOS15_g251809 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251809 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251809 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251809 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251809 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251809 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251809 , Out_Dummy15_g251809 , Out_PositionOS15_g251809 , Out_NormalOS15_g251809 , Out_TangentOS15_g251809 , Out_TransformData15_g251809 , Out_RotationData15_g251809 , Out_Interpolator15_g251809 );
					TVEVertexData Data16_g251810 =(TVEVertexData)Data15_g251809;
					float In_Dummy16_g251810 = 0.0;
					float3 Vertex_PositionOS147_g251800 = Out_PositionOS15_g251809;
					half3 VertexPos40_g251804 = Vertex_PositionOS147_g251800;
					float4 temp_output_1615_33_g251800 = Out_RotationData15_g251809;
					half4 Vertex_RotationData1569_g251800 = temp_output_1615_33_g251800;
					float2 break1582_g251800 = (Vertex_RotationData1569_g251800).xy;
					half Angle44_g251804 = break1582_g251800.y;
					half CosAngle89_g251804 = cos( Angle44_g251804 );
					half SinAngle93_g251804 = sin( Angle44_g251804 );
					float3 appendResult95_g251804 = (float3((VertexPos40_g251804).x , ( ( (VertexPos40_g251804).y * CosAngle89_g251804 ) - ( (VertexPos40_g251804).z * SinAngle93_g251804 ) ) , ( ( (VertexPos40_g251804).y * SinAngle93_g251804 ) + ( (VertexPos40_g251804).z * CosAngle89_g251804 ) )));
					half3 VertexPos40_g251805 = appendResult95_g251804;
					half Angle44_g251805 = -break1582_g251800.x;
					half CosAngle94_g251805 = cos( Angle44_g251805 );
					half SinAngle95_g251805 = sin( Angle44_g251805 );
					float3 appendResult98_g251805 = (float3(( ( (VertexPos40_g251805).x * CosAngle94_g251805 ) - ( (VertexPos40_g251805).y * SinAngle95_g251805 ) ) , ( ( (VertexPos40_g251805).x * SinAngle95_g251805 ) + ( (VertexPos40_g251805).y * CosAngle94_g251805 ) ) , (VertexPos40_g251805).z));
					half3 VertexPos40_g251803 = Vertex_PositionOS147_g251800;
					half Angle44_g251803 = break1582_g251800.y;
					half CosAngle89_g251803 = cos( Angle44_g251803 );
					half SinAngle93_g251803 = sin( Angle44_g251803 );
					float3 appendResult95_g251803 = (float3((VertexPos40_g251803).x , ( ( (VertexPos40_g251803).y * CosAngle89_g251803 ) - ( (VertexPos40_g251803).z * SinAngle93_g251803 ) ) , ( ( (VertexPos40_g251803).y * SinAngle93_g251803 ) + ( (VertexPos40_g251803).z * CosAngle89_g251803 ) )));
					half3 VertexPos40_g251808 = appendResult95_g251803;
					half Angle44_g251808 = break1582_g251800.x;
					half CosAngle91_g251808 = cos( Angle44_g251808 );
					half SinAngle92_g251808 = sin( Angle44_g251808 );
					float3 appendResult93_g251808 = (float3(( ( (VertexPos40_g251808).x * CosAngle91_g251808 ) + ( (VertexPos40_g251808).z * SinAngle92_g251808 ) ) , (VertexPos40_g251808).y , ( ( -(VertexPos40_g251808).x * SinAngle92_g251808 ) + ( (VertexPos40_g251808).z * CosAngle91_g251808 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251806 = appendResult93_g251808;
					#else
					float3 staticSwitch65_g251806 = appendResult98_g251805;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251801 = staticSwitch65_g251806;
					#else
					float3 staticSwitch65_g251801 = Vertex_PositionOS147_g251800;
					#endif
					float3 temp_output_1608_0_g251800 = staticSwitch65_g251801;
					half3 VertexPos40_g251807 = temp_output_1608_0_g251800;
					half Angle44_g251807 = (Vertex_RotationData1569_g251800).z;
					half CosAngle91_g251807 = cos( Angle44_g251807 );
					half SinAngle92_g251807 = sin( Angle44_g251807 );
					float3 appendResult93_g251807 = (float3(( ( (VertexPos40_g251807).x * CosAngle91_g251807 ) + ( (VertexPos40_g251807).z * SinAngle92_g251807 ) ) , (VertexPos40_g251807).y , ( ( -(VertexPos40_g251807).x * SinAngle92_g251807 ) + ( (VertexPos40_g251807).z * CosAngle91_g251807 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251802 = appendResult93_g251807;
					#else
					float3 staticSwitch65_g251802 = temp_output_1608_0_g251800;
					#endif
					float4 temp_output_1615_31_g251800 = Out_TransformData15_g251809;
					half4 Vertex_TransformData1568_g251800 = temp_output_1615_31_g251800;
					half3 Final_PositionOS178_g251800 = ( ( staticSwitch65_g251802 * (Vertex_TransformData1568_g251800).w ) + (Vertex_TransformData1568_g251800).xyz );
					float3 In_PositionOS16_g251810 = Final_PositionOS178_g251800;
					float3 In_NormalOS16_g251810 = Out_NormalOS15_g251809;
					float4 In_TangentOS16_g251810 = Out_TangentOS15_g251809;
					float4 In_TransformData16_g251810 = temp_output_1615_31_g251800;
					float4 In_RotationData16_g251810 = temp_output_1615_33_g251800;
					float4 In_Interpolator16_g251810 = Out_Interpolator15_g251809;
					BuildVertexData( Data16_g251810 , In_Dummy16_g251810 , In_PositionOS16_g251810 , In_NormalOS16_g251810 , In_TangentOS16_g251810 , In_TransformData16_g251810 , In_RotationData16_g251810 , In_Interpolator16_g251810 );
					TVEVertexData Data15_g251818 =(TVEVertexData)Data16_g251810;
					float Out_Dummy15_g251818 = 0.0;
					float3 Out_PositionOS15_g251818 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251818 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251818 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251818 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251818 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251818 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251818 , Out_Dummy15_g251818 , Out_PositionOS15_g251818 , Out_NormalOS15_g251818 , Out_TangentOS15_g251818 , Out_TransformData15_g251818 , Out_RotationData15_g251818 , Out_Interpolator15_g251818 );
					TVEVertexData Data16_g251819 =(TVEVertexData)Data15_g251818;
					float In_Dummy16_g251819 = 0.0;
					TVEModelData Data15_g251817 =(TVEModelData)Data15_g251652;
					float Out_Dummy15_g251817 = 0.0;
					float3 Out_PositionOS15_g251817 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251817 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251817 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251817 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251817 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251817 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251817 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251817 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251817 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251817 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251817 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251817 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251817 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251817 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251817 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251817 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251817 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251817 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251817 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251817 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251817 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251817 , Out_Dummy15_g251817 , Out_PositionOS15_g251817 , Out_PositionWS15_g251817 , Out_PositionWO15_g251817 , Out_PositionRawOS15_g251817 , Out_PivotOS15_g251817 , Out_PivotWS15_g251817 , Out_PivotWO15_g251817 , Out_NormalOS15_g251817 , Out_NormalWS15_g251817 , Out_NormalRawOS15_g251817 , Out_TangentOS15_g251817 , Out_TangentWS15_g251817 , Out_BitangentWS15_g251817 , Out_ViewDirWS15_g251817 , Out_CoordsData15_g251817 , Out_VertexData15_g251817 , Out_MasksData15_g251817 , Out_PhaseData15_g251817 , Out_TransformData15_g251817 , Out_RotationData15_g251817 , Out_Interpolator15_g251817 );
					float3 In_PositionOS16_g251819 = ( Out_PositionOS15_g251818 + Out_PivotOS15_g251817 );
					float3 In_NormalOS16_g251819 = Out_NormalOS15_g251818;
					float4 In_TangentOS16_g251819 = Out_TangentOS15_g251818;
					float4 In_TransformData16_g251819 = Out_TransformData15_g251818;
					float4 In_RotationData16_g251819 = Out_RotationData15_g251818;
					float4 In_Interpolator16_g251819 = Out_Interpolator15_g251818;
					BuildVertexData( Data16_g251819 , In_Dummy16_g251819 , In_PositionOS16_g251819 , In_NormalOS16_g251819 , In_TangentOS16_g251819 , In_TransformData16_g251819 , In_RotationData16_g251819 , In_Interpolator16_g251819 );
					TVEVertexData Data15_g251889 =(TVEVertexData)Data16_g251819;
					float Out_Dummy15_g251889 = 0.0;
					float3 Out_PositionOS15_g251889 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251889 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251889 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251889 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251889 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251889 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251889 , Out_Dummy15_g251889 , Out_PositionOS15_g251889 , Out_NormalOS15_g251889 , Out_TangentOS15_g251889 , Out_TransformData15_g251889 , Out_RotationData15_g251889 , Out_Interpolator15_g251889 );
					
					float3 color107_g251820 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g251820 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float localBreakData4_g251815 = ( 0.0 );
					float localBuildMasksData3_g251738 = ( 0.0 );
					TVEMasksData Data3_g251738 = (TVEMasksData)0;
					half Feature_Intensity3187_g251720 = _MotionIntensityValue;
					float ifLocalVar18_g251742 = 0;
					if( Feature_Intensity3187_g251720 <= 0.0 )
					ifLocalVar18_g251742 = 0.0;
					else
					ifLocalVar18_g251742 = 1.0;
					half Feature_Element3188_g251720 = _MotionFlowMode;
					float ifLocalVar18_g251744 = 0;
					if( Feature_Element3188_g251720 <= 0.0 )
					ifLocalVar18_g251744 = 0.0;
					else
					ifLocalVar18_g251744 = 1.0;
					float4 appendResult2992_g251720 = (float4(ifLocalVar18_g251742 , 0.0 , 0.0 , ifLocalVar18_g251744));
					float4 In_MaskA3_g251738 = appendResult2992_g251720;
					float temp_output_17_0_g251737 = _MotionBaseMaskMode;
					float Option92_g251737 = temp_output_17_0_g251737;
					TVEModelData Data15_g251574 =(TVEModelData)Data26_g241959;
					float Out_Dummy15_g251574 = 0.0;
					float3 Out_PositionOS15_g251574 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251574 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251574 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251574 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251574 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251574 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251574 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251574 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251574 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251574 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251574 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251574 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251574 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251574 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251574 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251574 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251574 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251574 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251574 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251574 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251574 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251574 , Out_Dummy15_g251574 , Out_PositionOS15_g251574 , Out_PositionWS15_g251574 , Out_PositionWO15_g251574 , Out_PositionRawOS15_g251574 , Out_PivotOS15_g251574 , Out_PivotWS15_g251574 , Out_PivotWO15_g251574 , Out_NormalOS15_g251574 , Out_NormalWS15_g251574 , Out_NormalRawOS15_g251574 , Out_TangentOS15_g251574 , Out_TangentWS15_g251574 , Out_BitangentWS15_g251574 , Out_ViewDirWS15_g251574 , Out_CoordsData15_g251574 , Out_VertexData15_g251574 , Out_MasksData15_g251574 , Out_PhaseData15_g251574 , Out_TransformData15_g251574 , Out_RotationData15_g251574 , Out_Interpolator15_g251574 );
					TVEModelData Data15_g251732 =(TVEModelData)Data15_g251574;
					float Out_Dummy15_g251732 = 0.0;
					float3 Out_PositionOS15_g251732 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251732 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251732 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251732 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251732 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251732 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251732 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251732 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251732 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251732 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251732 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251732 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251732 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251732 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251732 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251732 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251732 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251732 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251732 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251732 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251732 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251732 , Out_Dummy15_g251732 , Out_PositionOS15_g251732 , Out_PositionWS15_g251732 , Out_PositionWO15_g251732 , Out_PositionRawOS15_g251732 , Out_PivotOS15_g251732 , Out_PivotWS15_g251732 , Out_PivotWO15_g251732 , Out_NormalOS15_g251732 , Out_NormalWS15_g251732 , Out_NormalRawOS15_g251732 , Out_TangentOS15_g251732 , Out_TangentWS15_g251732 , Out_BitangentWS15_g251732 , Out_ViewDirWS15_g251732 , Out_CoordsData15_g251732 , Out_VertexData15_g251732 , Out_MasksData15_g251732 , Out_PhaseData15_g251732 , Out_TransformData15_g251732 , Out_RotationData15_g251732 , Out_Interpolator15_g251732 );
					half4 Model_VertexMasks518_g251720 = Out_VertexData15_g251732;
					float4 temp_output_84_0_g251737 = Model_VertexMasks518_g251720;
					float4 ChannelA92_g251737 = temp_output_84_0_g251737;
					half4 Model_MasksData1322_g251720 = Out_MasksData15_g251732;
					float2 uv_MotionMaskTex2818_g251720 = v.texcoord.xyzw.xy;
					half4 Motion_MaskTex2819_g251720 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex2818_g251720, 0.0 );
					float3 appendResult3220_g251720 = (float3((Model_MasksData1322_g251720).xy , (Motion_MaskTex2819_g251720).r));
					float3 temp_output_85_0_g251737 = appendResult3220_g251720;
					float4 ChannelB92_g251737 = float4( temp_output_85_0_g251737 , 0.0 );
					float localSwitchChannel792_g251737 = SwitchChannel7( Option92_g251737 , ChannelA92_g251737 , ChannelB92_g251737 );
					float clampResult17_g251726 = clamp( localSwitchChannel792_g251737 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251725 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g251725 = ( clampResult17_g251726 - temp_output_7_0_g251725 );
					half Base_Mask217_g251720 = saturate( ( temp_output_9_0_g251725 * _MotionBaseMaskRemap.z ) );
					float3 Model_PositionWO162_g251720 = Out_PositionWO15_g251732;
					half3 Input_ModelPositionWO761_g251731 = Model_PositionWO162_g251720;
					float3 Model_PivotWO402_g251720 = Out_PivotWO15_g251732;
					half3 Input_ModelPivotsWO419_g251731 = Model_PivotWO402_g251720;
					half Input_MotionPivots629_g251731 = _MotionBasePivotValue;
					float3 lerpResult771_g251731 = lerp( Input_ModelPositionWO761_g251731 , Input_ModelPivotsWO419_g251731 , Input_MotionPivots629_g251731);
					half4 Model_PhaseData489_g251720 = Out_PhaseData15_g251732;
					half4 Input_ModelMotionData763_g251731 = Model_PhaseData489_g251720;
					half Input_MotionPhase764_g251731 = _MotionBasePhaseValue;
					float temp_output_770_0_g251731 = ( (Input_ModelMotionData763_g251731).x * Input_MotionPhase764_g251731 );
					half3 Base_Position1394_g251720 = ( lerpResult771_g251731 + temp_output_770_0_g251731 );
					half3 Input_PositionWO419_g251757 = Base_Position1394_g251720;
					half Input_MotionTilling321_g251757 = ( _MotionBaseTillingValue + 0.2 );
					half2 Noise_Coord515_g251757 = ( -(Input_PositionWO419_g251757).xz * Input_MotionTilling321_g251757 * 0.005 );
					float2 Input_Coords80_g251759 = Noise_Coord515_g251757;
					half Motion_FlowValue3376_g251720 = _MotionFlowValue;
					float2 lerpResult3361_g251720 = lerp( (half4( 1, 1, 1, 0 )).xy , (TVE_WindParams).xy , ( Motion_FlowValue3376_g251720 * TVE_IsEnabled ));
					float2 Global_WindDirWS2542_g251720 = (lerpResult3361_g251720*2.0 + -1.0);
					half2 Input_WindDirWS803_g251757 = Global_WindDirWS2542_g251720;
					half2 Input_Direction82_g251759 = Input_WindDirWS803_g251757;
					float mulTime113_g251785 = _Time.y * 0.02;
					float lerpResult128_g251785 = lerp( mulTime113_g251785 , ( ( mulTime113_g251785 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					#ifdef SHADER_API_MOBILE
					float staticSwitch134_g251785 = frac( lerpResult128_g251785 );
					#else
					float staticSwitch134_g251785 = lerpResult128_g251785;
					#endif
					float Global_WindTime3262_g251720 = staticSwitch134_g251785;
					half Input_WindTime963_g251757 = Global_WindTime3262_g251720;
					half Input_MotionSpeed62_g251757 = _MotionBaseSpeedValue;
					float temp_output_505_0_g251757 = ( Input_WindTime963_g251757 * Input_MotionSpeed62_g251757 );
					half Noise_Speed516_g251757 = temp_output_505_0_g251757;
					float Input_Time88_g251759 = Noise_Speed516_g251757;
					float temp_output_23_0_g251759 = frac( Input_Time88_g251759 );
					float4 lerpResult39_g251759 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251759 + ( Input_Direction82_g251759 * temp_output_23_0_g251759 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251759 + ( Input_Direction82_g251759 * ( temp_output_23_0_g251759 - 1.0 ) ) ), 0.0 ) , temp_output_23_0_g251759);
					float4 temp_output_635_0_g251757 = lerpResult39_g251759;
					half4 Noise_Params685_g251757 = temp_output_635_0_g251757;
					half Base_Noise2949_g251720 = (Noise_Params685_g251757).g;
					half Base_Phase2971_g251720 = frac( temp_output_770_0_g251731 );
					float4 temp_output_3332_0_g251720 = TVE_FlowParams;
					TVEGlobalData Data15_g251746 =(TVEGlobalData)Data204_g241858;
					float Out_Dummy15_g251746 = 0.0;
					float4 Out_CoatTexture15_g251746 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251746 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251746 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251746 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251746 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251746 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251746 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251746 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251746 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251746 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251746 = float4( 0,0,0,0 );
					BreakData( Data15_g251746 , Out_Dummy15_g251746 , Out_CoatTexture15_g251746 , Out_DrawTexture15_g251746 , Out_PaintTexture15_g251746 , Out_AtmoTexture15_g251746 , Out_EffexTexture15_g251746 , Out_GlowTexture15_g251746 , Out_FormTexture15_g251746 , Out_LandTexture15_g251746 , Out_VertxTexture15_g251746 , Out_FlowTexture15_g251746 , Out_UserTexture15_g251746 );
					half4 Global_FlowTexture2668_g251720 = Out_FlowTexture15_g251746;
					#ifdef TVE_MOTION_FLOW
					float4 staticSwitch3075_g251720 = Global_FlowTexture2668_g251720;
					#else
					float4 staticSwitch3075_g251720 = temp_output_3332_0_g251720;
					#endif
					float4 temp_output_6_0_g251747 = staticSwitch3075_g251720;
					float temp_output_7_0_g251747 = _MotionFlowMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g251747 = ( temp_output_6_0_g251747 + temp_output_7_0_g251747 );
					#else
					float4 staticSwitch14_g251747 = temp_output_6_0_g251747;
					#endif
					float4 lerpResult3121_g251720 = lerp( half4( 1, 1, 1, 0 ) , staticSwitch14_g251747 , ( Motion_FlowValue3376_g251720 * TVE_IsEnabled ));
					half Global_PushAlpha1504_g251720 = (lerpResult3121_g251720).w;
					half Input_PushAlpha806_g251757 = Global_PushAlpha1504_g251720;
					half Input_ReactValue888_g251757 = _MotionBasePushValue;
					half Push_Mask883_g251757 = saturate( ( Input_PushAlpha806_g251757 * Input_ReactValue888_g251757 ) );
					half Base_React3000_g251720 = Push_Mask883_g251757;
					float ifLocalVar18_g251743 = 0;
					if( Feature_Element3188_g251720 <= 0.0 )
					ifLocalVar18_g251743 = 0.0;
					else
					ifLocalVar18_g251743 = Base_React3000_g251720;
					float4 appendResult2956_g251720 = (float4(Base_Mask217_g251720 , Base_Noise2949_g251720 , Base_Phase2971_g251720 , ifLocalVar18_g251743));
					float4 temp_cast_23 = (0.0).xxxx;
					float4 temp_cast_24 = (0.0).xxxx;
					float4 ifLocalVar18_g251741 = 0;
					if( Feature_Intensity3187_g251720 <= 0.0 )
					ifLocalVar18_g251741 = temp_cast_24;
					else
					ifLocalVar18_g251741 = appendResult2956_g251720;
					float4 In_MaskB3_g251738 = ifLocalVar18_g251741;
					float temp_output_17_0_g251735 = _MotionSmallMaskMode;
					float Option92_g251735 = temp_output_17_0_g251735;
					float4 temp_output_84_0_g251735 = Model_VertexMasks518_g251720;
					float4 ChannelA92_g251735 = temp_output_84_0_g251735;
					float3 appendResult3227_g251720 = (float3((Model_MasksData1322_g251720).xy , (Motion_MaskTex2819_g251720).g));
					float3 temp_output_85_0_g251735 = appendResult3227_g251720;
					float4 ChannelB92_g251735 = float4( temp_output_85_0_g251735 , 0.0 );
					float localSwitchChannel792_g251735 = SwitchChannel7( Option92_g251735 , ChannelA92_g251735 , ChannelB92_g251735 );
					float enc1805_g251720 = v.texcoord.xyzw.z;
					float2 localDecodeFloatToVector21805_g251720 = DecodeFloatToVector2( enc1805_g251720 );
					float2 break1804_g251720 = localDecodeFloatToVector21805_g251720;
					half Small_Mask_Legacy1806_g251720 = break1804_g251720.x;
					#ifdef TVE_LEGACY
					float staticSwitch1800_g251720 = Small_Mask_Legacy1806_g251720;
					#else
					float staticSwitch1800_g251720 = localSwitchChannel792_g251735;
					#endif
					float clampResult17_g251721 = clamp( staticSwitch1800_g251720 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251722 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g251722 = ( clampResult17_g251721 - temp_output_7_0_g251722 );
					half Small_Mask640_g251720 = saturate( ( temp_output_9_0_g251722 * _MotionSmallMaskRemap.z ) );
					half3 Input_ModelPositionWO761_g251730 = Model_PositionWO162_g251720;
					half3 Input_ModelPivotsWO419_g251730 = Model_PivotWO402_g251720;
					half Input_MotionPivots629_g251730 = _MotionSmallPivotValue;
					float3 lerpResult771_g251730 = lerp( Input_ModelPositionWO761_g251730 , Input_ModelPivotsWO419_g251730 , Input_MotionPivots629_g251730);
					half4 Input_ModelMotionData763_g251730 = Model_PhaseData489_g251720;
					half Input_MotionPhase764_g251730 = _MotionSmallPhaseValue;
					float temp_output_770_0_g251730 = ( (Input_ModelMotionData763_g251730).x * Input_MotionPhase764_g251730 );
					half3 Small_Position1421_g251720 = ( lerpResult771_g251730 + temp_output_770_0_g251730 );
					half3 Input_PositionWO419_g251767 = Small_Position1421_g251720;
					half Input_MotionTilling321_g251767 = ( _MotionSmallTillingValue + 0.2 );
					half2 Noise_Coord979_g251767 = ( -(Input_PositionWO419_g251767).xz * Input_MotionTilling321_g251767 * 0.005 );
					float2 Input_Coords80_g251771 = Noise_Coord979_g251767;
					half2 Input_WindDirWS803_g251767 = Global_WindDirWS2542_g251720;
					half2 Input_Direction82_g251771 = Input_WindDirWS803_g251767;
					half Input_WindTime1015_g251767 = Global_WindTime3262_g251720;
					half Input_MotionSpeed62_g251767 = _MotionSmallSpeedValue;
					float temp_output_986_0_g251767 = ( Input_WindTime1015_g251767 * Input_MotionSpeed62_g251767 );
					half Noise_Speed980_g251767 = temp_output_986_0_g251767;
					float Input_Time88_g251771 = Noise_Speed980_g251767;
					float temp_output_23_0_g251771 = frac( Input_Time88_g251771 );
					float4 lerpResult39_g251771 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251771 + ( Input_Direction82_g251771 * temp_output_23_0_g251771 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251771 + ( Input_Direction82_g251771 * ( temp_output_23_0_g251771 - 1.0 ) ) ), 0.0 ) , temp_output_23_0_g251771);
					float4 temp_output_991_0_g251767 = lerpResult39_g251771;
					half4 Noise_Params685_g251767 = temp_output_991_0_g251767;
					half Small_Noise2950_g251720 = (Noise_Params685_g251767).g;
					half Small_Phase2972_g251720 = frac( temp_output_770_0_g251730 );
					half Input_PushAlpha806_g251767 = Global_PushAlpha1504_g251720;
					float temp_output_3077_0_g251720 = (lerpResult3121_g251720).z;
					half Global_PushNoise2675_g251720 = temp_output_3077_0_g251720;
					half Input_PushNoise890_g251767 = Global_PushNoise2675_g251720;
					half Input_MotionReact924_g251767 = _MotionSmallPushValue;
					half Push_Mask914_g251767 = saturate( ( Input_PushAlpha806_g251767 * Input_PushNoise890_g251767 * Input_MotionReact924_g251767 ) );
					half Small_React3002_g251720 = Push_Mask914_g251767;
					float ifLocalVar18_g251745 = 0;
					if( Feature_Element3188_g251720 <= 0.0 )
					ifLocalVar18_g251745 = 0.0;
					else
					ifLocalVar18_g251745 = Small_React3002_g251720;
					float4 appendResult2954_g251720 = (float4(Small_Mask640_g251720 , Small_Noise2950_g251720 , Small_Phase2972_g251720 , ifLocalVar18_g251745));
					float4 temp_cast_26 = (0.0).xxxx;
					float4 temp_cast_27 = (0.0).xxxx;
					float4 ifLocalVar18_g251739 = 0;
					if( Feature_Intensity3187_g251720 <= 0.0 )
					ifLocalVar18_g251739 = temp_cast_27;
					else
					ifLocalVar18_g251739 = appendResult2954_g251720;
					float4 In_MaskC3_g251738 = ifLocalVar18_g251739;
					float temp_output_17_0_g251736 = _MotionTinyMaskMode;
					float Option92_g251736 = temp_output_17_0_g251736;
					float4 temp_output_84_0_g251736 = Model_VertexMasks518_g251720;
					float4 ChannelA92_g251736 = temp_output_84_0_g251736;
					float3 appendResult3234_g251720 = (float3((Model_MasksData1322_g251720).xy , (Motion_MaskTex2819_g251720).b));
					float3 temp_output_85_0_g251736 = appendResult3234_g251720;
					float4 ChannelB92_g251736 = float4( temp_output_85_0_g251736 , 0.0 );
					float localSwitchChannel792_g251736 = SwitchChannel7( Option92_g251736 , ChannelA92_g251736 , ChannelB92_g251736 );
					half Tiny_Mask_Legacy1807_g251720 = break1804_g251720.y;
					#ifdef TVE_LEGACY
					float staticSwitch1810_g251720 = Tiny_Mask_Legacy1807_g251720;
					#else
					float staticSwitch1810_g251720 = localSwitchChannel792_g251736;
					#endif
					float clampResult17_g251723 = clamp( staticSwitch1810_g251720 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251724 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g251724 = ( clampResult17_g251723 - temp_output_7_0_g251724 );
					half Tiny_Mask218_g251720 = saturate( ( temp_output_9_0_g251724 * _MotionTinyMaskRemap.z ) );
					half3 Tiny_Position2469_g251720 = Model_PositionWO162_g251720;
					half3 Input_PositionWO419_g251786 = Tiny_Position2469_g251720;
					half Input_MotionTilling321_g251786 = ( _MotionTinyTillingValue + 0.2 );
					half2 Noise_Coord979_g251786 = ( -(Input_PositionWO419_g251786).xz * Input_MotionTilling321_g251786 * 0.005 );
					float2 Input_Coords80_g251793 = Noise_Coord979_g251786;
					half2 Input_Direction82_g251793 = float2( 0,1 );
					half Input_WindTime1015_g251786 = Global_WindTime3262_g251720;
					half Input_MotionSpeed62_g251786 = _MotionTinySpeedValue;
					float temp_output_986_0_g251786 = ( Input_WindTime1015_g251786 * Input_MotionSpeed62_g251786 );
					half Noise_Speed980_g251786 = temp_output_986_0_g251786;
					float Input_Time88_g251793 = Noise_Speed980_g251786;
					float4 temp_output_991_0_g251786 = SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251793 + ( Input_Direction82_g251793 * Input_Time88_g251793 ) ), 0.0 );
					half4 Noise_Params685_g251786 = temp_output_991_0_g251786;
					half Tiny_Noise2967_g251720 = (Noise_Params685_g251786).g;
					float4 appendResult2975_g251720 = (float4(Tiny_Mask218_g251720 , Tiny_Noise2967_g251720 , 0.0 , 0.0));
					float4 temp_cast_29 = (0.0).xxxx;
					float4 temp_cast_30 = (0.0).xxxx;
					float4 ifLocalVar18_g251740 = 0;
					if( Feature_Intensity3187_g251720 <= 0.0 )
					ifLocalVar18_g251740 = temp_cast_30;
					else
					ifLocalVar18_g251740 = appendResult2975_g251720;
					float4 In_MaskD3_g251738 = ifLocalVar18_g251740;
					float4 temp_cast_31 = (0.0).xxxx;
					float4 In_MaskE3_g251738 = temp_cast_31;
					float4 temp_cast_32 = (0.0).xxxx;
					float4 In_MaskF3_g251738 = temp_cast_32;
					float4 temp_cast_33 = (0.0).xxxx;
					float4 In_MaskG3_g251738 = temp_cast_33;
					float4 temp_cast_34 = (0.0).xxxx;
					float4 In_MaskH3_g251738 = temp_cast_34;
					float4 temp_cast_35 = (0.0).xxxx;
					float4 In_MaskI3_g251738 = temp_cast_35;
					float4 temp_cast_36 = (0.0).xxxx;
					float4 In_MaskJ3_g251738 = temp_cast_36;
					float4 temp_cast_37 = (0.0).xxxx;
					float4 In_MaskK3_g251738 = temp_cast_37;
					float4 temp_cast_38 = (0.0).xxxx;
					float4 In_MaskL3_g251738 = temp_cast_38;
					{
					Data3_g251738.MaskA = In_MaskA3_g251738;
					Data3_g251738.MaskB = In_MaskB3_g251738;
					Data3_g251738.MaskC = In_MaskC3_g251738;
					Data3_g251738.MaskD = In_MaskD3_g251738;
					Data3_g251738.MaskE = In_MaskE3_g251738;
					Data3_g251738.MaskF = In_MaskF3_g251738;
					Data3_g251738.MaskG = In_MaskG3_g251738;
					Data3_g251738.MaskH = In_MaskH3_g251738;
					Data3_g251738.MaskI = In_MaskI3_g251738;
					Data3_g251738.MaskJ= In_MaskJ3_g251738;
					Data3_g251738.MaskK= In_MaskK3_g251738;
					Data3_g251738.MaskL = In_MaskL3_g251738;
					}
					TVEMasksData Data4_g251815 = Data3_g251738;
					float4 Out_MaskA4_g251815 = float4( 0,0,0,0 );
					float4 Out_MaskB4_g251815 = float4( 0,0,0,0 );
					float4 Out_MaskC4_g251815 = float4( 0,0,0,0 );
					float4 Out_MaskD4_g251815 = float4( 0,0,0,0 );
					float4 Out_MaskE4_g251815 = float4( 0,0,0,0 );
					float4 Out_MaskF4_g251815 = float4( 0,0,0,0 );
					float4 Out_MaskG4_g251815 = float4( 0,0,0,0 );
					float4 Out_MaskH4_g251815 = float4( 0,0,0,0 );
					{
					Out_MaskA4_g251815 = Data4_g251815.MaskA;
					Out_MaskB4_g251815 = Data4_g251815.MaskB;
					Out_MaskC4_g251815 = Data4_g251815.MaskC;
					Out_MaskD4_g251815 = Data4_g251815.MaskD;
					Out_MaskE4_g251815 = Data4_g251815.MaskE;
					Out_MaskF4_g251815 = Data4_g251815.MaskF;
					Out_MaskG4_g251815 = Data4_g251815.MaskG;
					Out_MaskH4_g251815 = Data4_g251815.MaskH;
					}
					float4 temp_output_2509_14 = Out_MaskA4_g251815;
					float3 lerpResult2568 = lerp( color107_g251820 , color106_g251820 , (temp_output_2509_14).x);
					float3 ifLocalVar40_g251836 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g251836 = lerpResult2568;
					float4 temp_output_2509_0 = Out_MaskB4_g251815;
					float3 ifLocalVar40_g251822 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g251822 = (temp_output_2509_0).xxx;
					float3 ifLocalVar40_g251823 = 0;
					if( TVE_DEBUG_Index == 3.0 )
					ifLocalVar40_g251823 = (temp_output_2509_0).yyy;
					float3 ifLocalVar40_g251831 = 0;
					if( TVE_DEBUG_Index == 4.0 )
					ifLocalVar40_g251831 = (temp_output_2509_0).zzz;
					float3 hsvTorgb2613 = HSVToRGB( float3((temp_output_2509_0).z,1.0,1.0) );
					float3 gammaToLinear2614 = GammaToLinearSpace( hsvTorgb2613 );
					float3 ifLocalVar40_g251832 = 0;
					if( TVE_DEBUG_Index == 5.0 )
					ifLocalVar40_g251832 = gammaToLinear2614;
					float3 ifLocalVar40_g251833 = 0;
					if( TVE_DEBUG_Index == 6.0 )
					ifLocalVar40_g251833 = (temp_output_2509_0).www;
					float4 temp_output_2509_23 = Out_MaskC4_g251815;
					float3 ifLocalVar40_g251824 = 0;
					if( TVE_DEBUG_Index == 8.0 )
					ifLocalVar40_g251824 = (temp_output_2509_23).xxx;
					float3 ifLocalVar40_g251825 = 0;
					if( TVE_DEBUG_Index == 9.0 )
					ifLocalVar40_g251825 = (temp_output_2509_23).yyy;
					float3 ifLocalVar40_g251826 = 0;
					if( TVE_DEBUG_Index == 10.0 )
					ifLocalVar40_g251826 = (temp_output_2509_23).zzz;
					float3 hsvTorgb2618 = HSVToRGB( float3((temp_output_2509_23).z,1.0,1.0) );
					float3 gammaToLinear2619 = GammaToLinearSpace( hsvTorgb2618 );
					float3 ifLocalVar40_g251827 = 0;
					if( TVE_DEBUG_Index == 11.0 )
					ifLocalVar40_g251827 = gammaToLinear2619;
					float3 ifLocalVar40_g251828 = 0;
					if( TVE_DEBUG_Index == 12.0 )
					ifLocalVar40_g251828 = (temp_output_2509_23).www;
					float4 temp_output_2509_5 = Out_MaskD4_g251815;
					float3 ifLocalVar40_g251829 = 0;
					if( TVE_DEBUG_Index == 14.0 )
					ifLocalVar40_g251829 = (temp_output_2509_5).xxx;
					float3 ifLocalVar40_g251830 = 0;
					if( TVE_DEBUG_Index == 15.0 )
					ifLocalVar40_g251830 = (temp_output_2509_5).yyy;
					float3 color107_g251811 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g251811 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2571 = lerp( color107_g251811 , color106_g251811 , (temp_output_2509_14).z);
					float3 ifLocalVar40_g251834 = 0;
					if( TVE_DEBUG_Index == 17.0 )
					ifLocalVar40_g251834 = lerpResult2571;
					float3 color107_g251813 = IsGammaSpace() ? float3( 0.8679245, 0.2898379, 0.1760413 ) : float3( 0.7254258, 0.06830776, 0.02612457 );
					float3 color106_g251813 = IsGammaSpace() ? float3( 0.5630165, 0.6901961, 0.1607843 ) : float3( 0.2770731, 0.4341537, 0.02217388 );
					float3 lerpResult2641 = lerp( color107_g251813 , color106_g251813 , (temp_output_2509_14).w);
					float3 ifLocalVar40_g251835 = 0;
					if( TVE_DEBUG_Index == 18.0 )
					ifLocalVar40_g251835 = lerpResult2641;
					float3 vertexToFrag2524 = ( ifLocalVar40_g251836 + ( ifLocalVar40_g251822 + ifLocalVar40_g251823 + ifLocalVar40_g251831 + ifLocalVar40_g251832 + ifLocalVar40_g251833 ) + ( ifLocalVar40_g251824 + ifLocalVar40_g251825 + ifLocalVar40_g251826 + ifLocalVar40_g251827 + ifLocalVar40_g251828 ) + ( ifLocalVar40_g251829 + ifLocalVar40_g251830 + ifLocalVar40_g251834 + ifLocalVar40_g251835 ) );
					o.ase_texcoord4.xyz = vertexToFrag2524;
					float3 vertexPos57_g251881 = v.vertex.xyz;
					float4 ase_positionCS57_g251881 = UnityObjectToClipPos( vertexPos57_g251881 );
					o.ase_texcoord5 = ase_positionCS57_g251881;
					o.ase_texcoord6.xyz = vertexToFrag73_g241838;
					o.ase_texcoord7.xyz = vertexToFrag76_g241838;
					TVEVertexData Data1902_g251837 = Data16_g251819;
					float4 Out_Interpolator1902_g251837 = float4( 0,0,0,0 );
					{
					Out_Interpolator1902_g251837 = Data1902_g251837.Interpolator;
					}
					float4 vertexToFrag1901_g251837 = Out_Interpolator1902_g251837;
					o.ase_texcoord10 = vertexToFrag1901_g251837;
					
					o.ase_texcoord8 = v.texcoord.xyzw;
					o.ase_texcoord9.xy = v.texcoord2.xyzw.xy;
					o.ase_color = v.ase_color;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord4.w = 0;
					o.ase_texcoord6.w = 0;
					o.ase_texcoord7.w = 0;
					o.ase_texcoord9.zw = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251889;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251889;
					v.tangent = Out_TangentOS15_g251889;

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
					
					float3 color130_g251881 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g251881 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g251883 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g251882 = ( temp_cast_4 * ( 0.5 + appendResult128_g251883 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g251882 = (float4(ddx( FinalUV13_g251882 ) , ddy( FinalUV13_g251882 )));
					float4 UVDerivatives17_g251882 = appendResult16_g251882;
					float4 break28_g251882 = UVDerivatives17_g251882;
					float2 appendResult19_g251882 = (float2(break28_g251882.x , break28_g251882.z));
					float2 appendResult20_g251882 = (float2(break28_g251882.x , break28_g251882.z));
					float dotResult24_g251882 = dot( appendResult19_g251882 , appendResult20_g251882 );
					float2 appendResult21_g251882 = (float2(break28_g251882.y , break28_g251882.w));
					float2 appendResult22_g251882 = (float2(break28_g251882.y , break28_g251882.w));
					float dotResult23_g251882 = dot( appendResult21_g251882 , appendResult22_g251882 );
					float2 appendResult25_g251882 = (float2(dotResult24_g251882 , dotResult23_g251882));
					float2 derivativesLength29_g251882 = sqrt( appendResult25_g251882 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g251882 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g251882 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g251882 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g251882 = clampResult57_g251882;
					float2 break55_g251882 = derivativesLength29_g251882;
					float4 lerpResult73_g251882 = lerp( float4( color130_g251881 , 0.0 ) , float4( color81_g251881 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g251882.x * break71_g251882.y * sqrt( saturate( ( 1.1 - max( break55_g251882.x, break55_g251882.y ) ) ) ) ) ) ));
					float3 vertexToFrag2524 = IN.ase_texcoord4.xyz;
					half3 Final_Debug2399 = vertexToFrag2524;
					float temp_output_7_0_g251888 = TVE_DEBUG_Min;
					float3 temp_cast_9 = (temp_output_7_0_g251888).xxx;
					float3 temp_output_9_0_g251888 = ( Final_Debug2399 - temp_cast_9 );
					float lerpResult76_g251881 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g251881 = lerpResult76_g251881;
					float3 lerpResult72_g251881 = lerp( (lerpResult73_g251882).rgb , saturate( ( temp_output_9_0_g251888 / ( ( TVE_DEBUG_Max - temp_output_7_0_g251888 ) + 0.0001 ) ) ) , Filter152_g251881);
					float dotResult61_g251881 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g251881 = ( 1.0 - saturate( dotResult61_g251881 ) );
					float Shading_Fresnel59_g251881 = (( 1.0 - ( temp_output_65_0_g251881 * temp_output_65_0_g251881 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g251881 = IN.ase_texcoord5;
					float depthLinearEye57_g251881 = LinearEyeDepth( ase_positionCS57_g251881.z / ase_positionCS57_g251881.w );
					float temp_output_69_0_g251881 = saturate(  (0.0 + ( depthLinearEye57_g251881 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g251881 = (( temp_output_69_0_g251881 * temp_output_69_0_g251881 )*0.5 + 0.5);
					float lerpResult84_g251881 = lerp( 1.0 , Shading_Fresnel59_g251881 , ( Shading_Distance58_g251881 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g251886 = ( 0.0 );
					float localBuildVisualData3_g251843 = ( 0.0 );
					float localBuildVisualData3_g251838 = ( 0.0 );
					TVEVisualData Data3_g251838 =(TVEVisualData)0;
					float temp_output_14_0_g251838 = 0.0;
					float In_Dummy3_g251838 = temp_output_14_0_g251838;
					float3 temp_cast_10 = (0.5).xxx;
					float3 temp_output_4_0_g251838 = temp_cast_10;
					float3 In_Albedo3_g251838 = temp_output_4_0_g251838;
					float3 temp_cast_11 = (0.5).xxx;
					float3 temp_output_44_0_g251838 = temp_cast_11;
					float3 In_AlbedoBase3_g251838 = temp_output_44_0_g251838;
					float2 temp_cast_12 = (0.0).xx;
					float2 In_NormalTS3_g251838 = temp_cast_12;
					float3 temp_cast_13 = (0.5).xxx;
					float3 In_NormalWS3_g251838 = temp_cast_13;
					float4 In_Shader3_g251838 = half4( 0, 1, 0, 1 );
					float4 In_Feature3_g251838 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251838 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251838 = half4( 1, 1, 1, 1 );
					float temp_output_12_0_g251838 = 0.5;
					float In_Grayscale3_g251838 = temp_output_12_0_g251838;
					float temp_output_16_0_g251838 = 1.0;
					float In_Luminosity3_g251838 = temp_output_16_0_g251838;
					float In_MultiMask3_g251838 = 1.0;
					float In_AlphaClip3_g251838 = 1.0;
					float In_AlphaFade3_g251838 = 1.0;
					float3 temp_cast_14 = (1.0).xxx;
					float3 In_Translucency3_g251838 = temp_cast_14;
					float In_Transmission3_g251838 = 1.0;
					float In_Thickness3_g251838 = 0.0;
					float In_Diffusion3_g251838 = 0.0;
					float In_Depth3_g251838 = 0.0;
					BuildVisualData( Data3_g251838 , In_Dummy3_g251838 , In_Albedo3_g251838 , In_AlbedoBase3_g251838 , In_NormalTS3_g251838 , In_NormalWS3_g251838 , In_Shader3_g251838 , In_Feature3_g251838 , In_Season3_g251838 , In_Emissive3_g251838 , In_Grayscale3_g251838 , In_Luminosity3_g251838 , In_MultiMask3_g251838 , In_AlphaClip3_g251838 , In_AlphaFade3_g251838 , In_Translucency3_g251838 , In_Transmission3_g251838 , In_Thickness3_g251838 , In_Diffusion3_g251838 , In_Depth3_g251838 );
					TVEVisualData Data3_g251843 =(TVEVisualData)Data3_g251838;
					half Dummy130_g251841 = ( _MainCategory + _MainEnd );
					float temp_output_14_0_g251843 = Dummy130_g251841;
					float In_Dummy3_g251843 = temp_output_14_0_g251843;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251864) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g251846 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g251846 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g251846 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g251846 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g251846 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g251846 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g251864 = staticSwitch36_g251846;
					float localBreakTextureData456_g251864 = ( 0.0 );
					float localBuildTextureData431_g251863 = ( 0.0 );
					TVEMasksData Data431_g251863 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g251863 = ( 0.0 );
					float4 temp_output_6_0_g251879 = _main_coord_value;
					float4 temp_output_7_0_g251879 = ( _MainSampleMode + _MainCoordMode + _MainCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g251879 = ( temp_output_6_0_g251879 + temp_output_7_0_g251879 );
					#else
					float4 staticSwitch14_g251879 = temp_output_6_0_g251879;
					#endif
					half4 Local_Coords180_g251841 = staticSwitch14_g251879;
					float4 Coords444_g251863 = Local_Coords180_g251841;
					float localIfModelDataByShader26_g241817 = ( 0.0 );
					TVEModelData Data26_g241817 = (TVEModelData)0;
					TVEModelData Data16_g241846 =(TVEModelData)0;
					float In_Dummy16_g241846 = 0.0;
					float3 vertexToFrag73_g241838 = IN.ase_texcoord6.xyz;
					float3 PositionWS122_g241838 = vertexToFrag73_g241838;
					float3 In_PositionWS16_g241846 = PositionWS122_g241838;
					float3 vertexToFrag76_g241838 = IN.ase_texcoord7.xyz;
					float3 PivotWS121_g241838 = vertexToFrag76_g241838;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241838 = ( PositionWS122_g241838 - PivotWS121_g241838 );
					#else
					float3 staticSwitch204_g241838 = PositionWS122_g241838;
					#endif
					float3 PositionWO132_g241838 = ( staticSwitch204_g241838 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241846 = PositionWO132_g241838;
					float3 In_PivotWS16_g241846 = PivotWS121_g241838;
					float3 PivotWO133_g241838 = ( PivotWS121_g241838 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241846 = PivotWO133_g241838;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g241838 = normalizedWorldNormal;
					float3 In_NormalWS16_g241846 = NormalWS95_g241838;
					half3 TangentWS136_g241838 = TangentWS;
					float3 In_TangentWS16_g241846 = TangentWS136_g241838;
					half3 BiangentWS421_g241838 = BitangentWS;
					float3 In_BitangentWS16_g241846 = BiangentWS421_g241838;
					half3 NormalWS427_g241838 = NormalWS95_g241838;
					half3 localComputeTriplanarMasks427_g241838 = ComputeTriplanarMasks( NormalWS427_g241838 );
					half3 TriplanarWeights429_g241838 = localComputeTriplanarMasks427_g241838;
					float3 In_TriplanarWeights16_g241846 = TriplanarWeights429_g241838;
					float3 normalizeResult296_g241838 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241838 ) );
					half3 ViewDirWS169_g241838 = normalizeResult296_g241838;
					float3 In_ViewDirWS16_g241846 = ViewDirWS169_g241838;
					float4 appendResult397_g241838 = (float4(IN.ase_texcoord8.xy , IN.ase_texcoord9.xy));
					float4 CoordsData398_g241838 = appendResult397_g241838;
					float4 In_CoordsData16_g241846 = CoordsData398_g241838;
					half4 VertexMasks171_g241838 = IN.ase_color;
					float4 In_VertexData16_g241846 = VertexMasks171_g241838;
					float temp_output_17_0_g241849 = _ObjectPhaseMode;
					float Option70_g241849 = temp_output_17_0_g241849;
					float4 temp_output_3_0_g241849 = IN.ase_color;
					float4 Channel70_g241849 = temp_output_3_0_g241849;
					float localSwitchChannel470_g241849 = SwitchChannel4( Option70_g241849 , Channel70_g241849 );
					half Phase_Value372_g241838 = localSwitchChannel470_g241849;
					float3 break319_g241838 = PivotWO133_g241838;
					half Pivot_Position322_g241838 = ( break319_g241838.x + break319_g241838.z );
					half Phase_Position357_g241838 = ( Phase_Value372_g241838 + Pivot_Position322_g241838 );
					float temp_output_248_0_g241838 = frac( Phase_Position357_g241838 );
					float4 appendResult177_g241838 = (float4((frac( ( Phase_Position357_g241838 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g241838));
					half4 Phase_Data176_g241838 = appendResult177_g241838;
					float4 In_Interpolator16_g241846 = Phase_Data176_g241838;
					BuildModelFragData( Data16_g241846 , In_Dummy16_g241846 , In_PositionWS16_g241846 , In_PositionWO16_g241846 , In_PivotWS16_g241846 , In_PivotWO16_g241846 , In_NormalWS16_g241846 , In_TangentWS16_g241846 , In_BitangentWS16_g241846 , In_TriplanarWeights16_g241846 , In_ViewDirWS16_g241846 , In_CoordsData16_g241846 , In_VertexData16_g241846 , In_Interpolator16_g241846 );
					TVEModelData DataDefault26_g241817 = Data16_g241846;
					TVEModelData DataGeneral26_g241817 = Data16_g241846;
					TVEModelData DataBlanket26_g241817 = Data16_g241846;
					TVEModelData DataImpostor26_g241817 = Data16_g241846;
					TVEModelData Data16_g241826 =(TVEModelData)0;
					float In_Dummy16_g241826 = 0.0;
					float3 temp_output_104_7_g241818 = PositionWS;
					float3 PositionWS122_g241818 = temp_output_104_7_g241818;
					float3 In_PositionWS16_g241826 = PositionWS122_g241818;
					float4x4 break19_g241821 = unity_ObjectToWorld;
					float3 appendResult20_g241821 = (float3(break19_g241821[ 0 ][ 3 ] , break19_g241821[ 1 ][ 3 ] , break19_g241821[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241818 = appendResult20_g241821;
					float3 PivotWS121_g241818 = temp_output_340_7_g241818;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241818 = ( PositionWS122_g241818 - PivotWS121_g241818 );
					#else
					float3 staticSwitch204_g241818 = PositionWS122_g241818;
					#endif
					float3 PositionWO132_g241818 = ( staticSwitch204_g241818 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241826 = PositionWO132_g241818;
					float3 In_PivotWS16_g241826 = PivotWS121_g241818;
					float3 PivotWO133_g241818 = ( PivotWS121_g241818 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241826 = PivotWO133_g241818;
					half3 NormalWS95_g241818 = normalizedWorldNormal;
					float3 In_NormalWS16_g241826 = NormalWS95_g241818;
					half3 TangentWS136_g241818 = TangentWS;
					float3 In_TangentWS16_g241826 = TangentWS136_g241818;
					half3 BiangentWS421_g241818 = BitangentWS;
					float3 In_BitangentWS16_g241826 = BiangentWS421_g241818;
					half3 NormalWS427_g241818 = NormalWS95_g241818;
					half3 localComputeTriplanarMasks427_g241818 = ComputeTriplanarMasks( NormalWS427_g241818 );
					half3 TriplanarWeights429_g241818 = localComputeTriplanarMasks427_g241818;
					float3 In_TriplanarWeights16_g241826 = TriplanarWeights429_g241818;
					float3 normalizeResult296_g241818 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241818 ) );
					half3 ViewDirWS169_g241818 = normalizeResult296_g241818;
					float3 In_ViewDirWS16_g241826 = ViewDirWS169_g241818;
					float4 appendResult397_g241818 = (float4(IN.ase_texcoord8.xy , IN.ase_texcoord9.xy));
					float4 CoordsData398_g241818 = appendResult397_g241818;
					float4 In_CoordsData16_g241826 = CoordsData398_g241818;
					half4 VertexMasks171_g241818 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241826 = VertexMasks171_g241818;
					half4 Phase_Data176_g241818 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g241826 = Phase_Data176_g241818;
					BuildModelFragData( Data16_g241826 , In_Dummy16_g241826 , In_PositionWS16_g241826 , In_PositionWO16_g241826 , In_PivotWS16_g241826 , In_PivotWO16_g241826 , In_NormalWS16_g241826 , In_TangentWS16_g241826 , In_BitangentWS16_g241826 , In_TriplanarWeights16_g241826 , In_ViewDirWS16_g241826 , In_CoordsData16_g241826 , In_VertexData16_g241826 , In_Interpolator16_g241826 );
					TVEModelData DataTerrain26_g241817 = Data16_g241826;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g241817 = IsShaderType2637;
					{
					if (Type26_g241817 == 0 )
					{
					Data26_g241817 = DataDefault26_g241817;
					}
					else if (Type26_g241817 == 1 )
					{
					Data26_g241817 = DataGeneral26_g241817;
					}
					else if (Type26_g241817 == 2 )
					{
					Data26_g241817 = DataBlanket26_g241817;
					}
					else if (Type26_g241817 == 3 )
					{
					Data26_g241817 = DataImpostor26_g241817;
					}
					else if (Type26_g241817 == 4 )
					{
					Data26_g241817 = DataTerrain26_g241817;
					}
					}
					TVEModelData Data15_g251839 =(TVEModelData)Data26_g241817;
					float Out_Dummy15_g251839 = 0.0;
					float3 Out_PositionWS15_g251839 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251839 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251839 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251839 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251839 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251839 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251839 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251839 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251839 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251839 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251839 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251839 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251839 , Out_Dummy15_g251839 , Out_PositionWS15_g251839 , Out_PositionWO15_g251839 , Out_PivotWS15_g251839 , Out_PivotWO15_g251839 , Out_NormalWS15_g251839 , Out_TangentWS15_g251839 , Out_BitangentWS15_g251839 , Out_TriplanarWeights15_g251839 , Out_ViewDirWS15_g251839 , Out_CoordsData15_g251839 , Out_VertexData15_g251839 , Out_Interpolator15_g251839 );
					TVEModelData Data16_g251840 =(TVEModelData)Data15_g251839;
					float In_Dummy16_g251840 = Out_Dummy15_g251839;
					float3 In_PositionWS16_g251840 = Out_PositionWS15_g251839;
					float3 In_PositionWO16_g251840 = Out_PositionWO15_g251839;
					float3 In_PivotWS16_g251840 = Out_PivotWS15_g251839;
					float3 In_PivotWO16_g251840 = Out_PivotWO15_g251839;
					float3 In_NormalWS16_g251840 = Out_NormalWS15_g251839;
					float3 In_TangentWS16_g251840 = Out_TangentWS15_g251839;
					float3 In_BitangentWS16_g251840 = Out_BitangentWS15_g251839;
					float3 In_TriplanarWeights16_g251840 = Out_TriplanarWeights15_g251839;
					float3 In_ViewDirWS16_g251840 = Out_ViewDirWS15_g251839;
					float4 In_CoordsData16_g251840 = Out_CoordsData15_g251839;
					float4 In_VertexData16_g251840 = Out_VertexData15_g251839;
					float4 vertexToFrag1901_g251837 = IN.ase_texcoord10;
					float4 In_Interpolator16_g251840 = vertexToFrag1901_g251837;
					BuildModelFragData( Data16_g251840 , In_Dummy16_g251840 , In_PositionWS16_g251840 , In_PositionWO16_g251840 , In_PivotWS16_g251840 , In_PivotWO16_g251840 , In_NormalWS16_g251840 , In_TangentWS16_g251840 , In_BitangentWS16_g251840 , In_TriplanarWeights16_g251840 , In_ViewDirWS16_g251840 , In_CoordsData16_g251840 , In_VertexData16_g251840 , In_Interpolator16_g251840 );
					TVEModelData Data15_g251842 =(TVEModelData)Data16_g251840;
					float Out_Dummy15_g251842 = 0.0;
					float3 Out_PositionWS15_g251842 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251842 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251842 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251842 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251842 = float3( 0,0,0 );
					float3 Out_TangentWS15_g251842 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251842 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g251842 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251842 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251842 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251842 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251842 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g251842 , Out_Dummy15_g251842 , Out_PositionWS15_g251842 , Out_PositionWO15_g251842 , Out_PivotWS15_g251842 , Out_PivotWO15_g251842 , Out_NormalWS15_g251842 , Out_TangentWS15_g251842 , Out_BitangentWS15_g251842 , Out_TriplanarWeights15_g251842 , Out_ViewDirWS15_g251842 , Out_CoordsData15_g251842 , Out_VertexData15_g251842 , Out_Interpolator15_g251842 );
					float4 Model_CoordsData324_g251841 = Out_CoordsData15_g251842;
					float4 MeshCoords444_g251863 = Model_CoordsData324_g251841;
					float2 UV0444_g251863 = float2( 0,0 );
					float2 UV3444_g251863 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g251863 , MeshCoords444_g251863 , UV0444_g251863 , UV3444_g251863 );
					float4 appendResult430_g251863 = (float4(UV0444_g251863 , UV3444_g251863));
					float4 In_MaskA431_g251863 = appendResult430_g251863;
					float localComputeWorldCoords315_g251863 = ( 0.0 );
					float4 Coords315_g251863 = Local_Coords180_g251841;
					float3 Model_PositionWO222_g251841 = Out_PositionWO15_g251842;
					float3 PositionWS315_g251863 = Model_PositionWO222_g251841;
					float2 ZY315_g251863 = float2( 0,0 );
					float2 XZ315_g251863 = float2( 0,0 );
					float2 XY315_g251863 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g251863 , PositionWS315_g251863 , ZY315_g251863 , XZ315_g251863 , XY315_g251863 );
					float2 ZY402_g251863 = ZY315_g251863;
					float2 XZ403_g251863 = XZ315_g251863;
					float4 appendResult432_g251863 = (float4(ZY402_g251863 , XZ403_g251863));
					float4 In_MaskB431_g251863 = appendResult432_g251863;
					float2 XY404_g251863 = XY315_g251863;
					float localComputeStochasticCoords409_g251863 = ( 0.0 );
					float2 UV409_g251863 = ZY402_g251863;
					float2 UV1409_g251863 = float2( 0,0 );
					float2 UV2409_g251863 = float2( 0,0 );
					float2 UV3409_g251863 = float2( 0,0 );
					float3 Weights409_g251863 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g251863 , UV1409_g251863 , UV2409_g251863 , UV3409_g251863 , Weights409_g251863 );
					float4 appendResult433_g251863 = (float4(XY404_g251863 , UV1409_g251863));
					float4 In_MaskC431_g251863 = appendResult433_g251863;
					float4 appendResult434_g251863 = (float4(UV2409_g251863 , UV3409_g251863));
					float4 In_MaskD431_g251863 = appendResult434_g251863;
					float localComputeStochasticCoords422_g251863 = ( 0.0 );
					float2 UV422_g251863 = XZ403_g251863;
					float2 UV1422_g251863 = float2( 0,0 );
					float2 UV2422_g251863 = float2( 0,0 );
					float2 UV3422_g251863 = float2( 0,0 );
					float3 Weights422_g251863 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g251863 , UV1422_g251863 , UV2422_g251863 , UV3422_g251863 , Weights422_g251863 );
					float4 appendResult435_g251863 = (float4(UV1422_g251863 , UV2422_g251863));
					float4 In_MaskE431_g251863 = appendResult435_g251863;
					float localComputeStochasticCoords423_g251863 = ( 0.0 );
					float2 UV423_g251863 = XY404_g251863;
					float2 UV1423_g251863 = float2( 0,0 );
					float2 UV2423_g251863 = float2( 0,0 );
					float2 UV3423_g251863 = float2( 0,0 );
					float3 Weights423_g251863 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g251863 , UV1423_g251863 , UV2423_g251863 , UV3423_g251863 , Weights423_g251863 );
					float4 appendResult436_g251863 = (float4(UV3422_g251863 , UV1423_g251863));
					float4 In_MaskF431_g251863 = appendResult436_g251863;
					float4 appendResult437_g251863 = (float4(UV2423_g251863 , UV3423_g251863));
					float4 In_MaskG431_g251863 = appendResult437_g251863;
					float4 In_MaskH431_g251863 = float4( Weights409_g251863 , 0.0 );
					float4 In_MaskI431_g251863 = float4( Weights422_g251863 , 0.0 );
					float4 In_MaskJ431_g251863 = float4( Weights423_g251863 , 0.0 );
					half3 Model_NormalWS226_g251841 = Out_NormalWS15_g251842;
					float3 temp_output_449_0_g251863 = Model_NormalWS226_g251841;
					float4 In_MaskK431_g251863 = float4( temp_output_449_0_g251863 , 0.0 );
					half3 Model_TangentWS366_g251841 = Out_TangentWS15_g251842;
					float3 temp_output_450_0_g251863 = Model_TangentWS366_g251841;
					float4 In_MaskL431_g251863 = float4( temp_output_450_0_g251863 , 0.0 );
					half3 Model_BitangentWS367_g251841 = Out_BitangentWS15_g251842;
					float3 temp_output_451_0_g251863 = Model_BitangentWS367_g251841;
					float4 In_MaskM431_g251863 = float4( temp_output_451_0_g251863 , 0.0 );
					half3 Model_TriplanarWeights368_g251841 = Out_TriplanarWeights15_g251842;
					float3 temp_output_445_0_g251863 = Model_TriplanarWeights368_g251841;
					float4 In_MaskN431_g251863 = float4( temp_output_445_0_g251863 , 0.0 );
					BuildTextureData( Data431_g251863 , In_MaskA431_g251863 , In_MaskB431_g251863 , In_MaskC431_g251863 , In_MaskD431_g251863 , In_MaskE431_g251863 , In_MaskF431_g251863 , In_MaskG431_g251863 , In_MaskH431_g251863 , In_MaskI431_g251863 , In_MaskJ431_g251863 , In_MaskK431_g251863 , In_MaskL431_g251863 , In_MaskM431_g251863 , In_MaskN431_g251863 );
					TVEMasksData Data456_g251864 =(TVEMasksData)Data431_g251863;
					float4 Out_MaskA456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251864 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251864 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251864 , Out_MaskA456_g251864 , Out_MaskB456_g251864 , Out_MaskC456_g251864 , Out_MaskD456_g251864 , Out_MaskE456_g251864 , Out_MaskF456_g251864 , Out_MaskG456_g251864 , Out_MaskH456_g251864 , Out_MaskI456_g251864 , Out_MaskJ456_g251864 , Out_MaskK456_g251864 , Out_MaskL456_g251864 , Out_MaskM456_g251864 , Out_MaskN456_g251864 );
					half2 UV276_g251864 = (Out_MaskA456_g251864).xy;
					float temp_output_504_0_g251864 = 0.0;
					half Bias276_g251864 = temp_output_504_0_g251864;
					half2 Normal276_g251864 = float2( 0,0 );
					half4 localSampleCoord276_g251864 = SampleCoord( Texture276_g251864 , Sampler276_g251864 , UV276_g251864 , Bias276_g251864 , Normal276_g251864 );
					float4 temp_output_407_277_g251841 = localSampleCoord276_g251864;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251864) = _MainAlbedoTex;
					SamplerState Sampler502_g251864 = staticSwitch36_g251846;
					half2 UV502_g251864 = (Out_MaskA456_g251864).zw;
					half Bias502_g251864 = temp_output_504_0_g251864;
					half2 Normal502_g251864 = float2( 0,0 );
					half4 localSampleCoord502_g251864 = SampleCoord( Texture502_g251864 , Sampler502_g251864 , UV502_g251864 , Bias502_g251864 , Normal502_g251864 );
					float4 temp_output_407_278_g251841 = localSampleCoord502_g251864;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251864) = _MainAlbedoTex;
					SamplerState Sampler496_g251864 = staticSwitch36_g251846;
					float2 temp_output_463_0_g251864 = (Out_MaskB456_g251864).zw;
					half2 XZ496_g251864 = temp_output_463_0_g251864;
					half Bias496_g251864 = temp_output_504_0_g251864;
					half3 NormalWS512_g251864 = (Out_MaskK456_g251864).xyz;
					half3 NormalWS496_g251864 = NormalWS512_g251864;
					half3 Normal496_g251864 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251864 = SamplePlanar2D( Texture496_g251864 , Sampler496_g251864 , XZ496_g251864 , Bias496_g251864 , NormalWS496_g251864 , Normal496_g251864 );
					float4 temp_output_407_0_g251841 = localSamplePlanar2D496_g251864;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251864) = _MainAlbedoTex;
					SamplerState Sampler490_g251864 = staticSwitch36_g251846;
					float2 temp_output_462_0_g251864 = (Out_MaskB456_g251864).xy;
					half2 ZY490_g251864 = temp_output_462_0_g251864;
					half2 XZ490_g251864 = temp_output_463_0_g251864;
					float2 temp_output_464_0_g251864 = (Out_MaskC456_g251864).xy;
					half2 XY490_g251864 = temp_output_464_0_g251864;
					half Bias490_g251864 = temp_output_504_0_g251864;
					half3 Triplanar522_g251864 = (Out_MaskN456_g251864).xyz;
					half3 Triplanar490_g251864 = Triplanar522_g251864;
					half3 NormalWS490_g251864 = NormalWS512_g251864;
					half3 Normal490_g251864 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251864 = SamplePlanar3D( Texture490_g251864 , Sampler490_g251864 , ZY490_g251864 , XZ490_g251864 , XY490_g251864 , Bias490_g251864 , Triplanar490_g251864 , NormalWS490_g251864 , Normal490_g251864 );
					float4 temp_output_407_201_g251841 = localSamplePlanar3D490_g251864;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251864) = _MainAlbedoTex;
					SamplerState Sampler498_g251864 = staticSwitch36_g251846;
					half2 XZ498_g251864 = temp_output_463_0_g251864;
					float2 temp_output_473_0_g251864 = (Out_MaskE456_g251864).xy;
					half2 XZ_1498_g251864 = temp_output_473_0_g251864;
					float2 temp_output_474_0_g251864 = (Out_MaskE456_g251864).zw;
					half2 XZ_2498_g251864 = temp_output_474_0_g251864;
					float2 temp_output_475_0_g251864 = (Out_MaskF456_g251864).xy;
					half2 XZ_3498_g251864 = temp_output_475_0_g251864;
					float temp_output_510_0_g251864 = exp2( temp_output_504_0_g251864 );
					half Bias498_g251864 = temp_output_510_0_g251864;
					float3 temp_output_480_0_g251864 = (Out_MaskI456_g251864).xyz;
					half3 Weights_2498_g251864 = temp_output_480_0_g251864;
					half3 NormalWS498_g251864 = NormalWS512_g251864;
					half3 Normal498_g251864 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251864 = SampleStochastic2D( Texture498_g251864 , Sampler498_g251864 , XZ498_g251864 , XZ_1498_g251864 , XZ_2498_g251864 , XZ_3498_g251864 , Bias498_g251864 , Weights_2498_g251864 , NormalWS498_g251864 , Normal498_g251864 );
					float4 temp_output_407_202_g251841 = localSampleStochastic2D498_g251864;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251864) = _MainAlbedoTex;
					SamplerState Sampler500_g251864 = staticSwitch36_g251846;
					half2 ZY500_g251864 = temp_output_462_0_g251864;
					half2 ZY_1500_g251864 = (Out_MaskC456_g251864).zw;
					half2 ZY_2500_g251864 = (Out_MaskD456_g251864).xy;
					half2 ZY_3500_g251864 = (Out_MaskD456_g251864).zw;
					half2 XZ500_g251864 = temp_output_463_0_g251864;
					half2 XZ_1500_g251864 = temp_output_473_0_g251864;
					half2 XZ_2500_g251864 = temp_output_474_0_g251864;
					half2 XZ_3500_g251864 = temp_output_475_0_g251864;
					half2 XY500_g251864 = temp_output_464_0_g251864;
					half2 XY_1500_g251864 = (Out_MaskF456_g251864).zw;
					half2 XY_2500_g251864 = (Out_MaskG456_g251864).xy;
					half2 XY_3500_g251864 = (Out_MaskG456_g251864).zw;
					half Bias500_g251864 = temp_output_510_0_g251864;
					half3 Weights_1500_g251864 = (Out_MaskH456_g251864).xyz;
					half3 Weights_2500_g251864 = temp_output_480_0_g251864;
					half3 Weights_3500_g251864 = (Out_MaskJ456_g251864).xyz;
					half3 Triplanar500_g251864 = Triplanar522_g251864;
					half3 NormalWS500_g251864 = NormalWS512_g251864;
					half3 Normal500_g251864 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251864 = SampleStochastic3D( Texture500_g251864 , Sampler500_g251864 , ZY500_g251864 , ZY_1500_g251864 , ZY_2500_g251864 , ZY_3500_g251864 , XZ500_g251864 , XZ_1500_g251864 , XZ_2500_g251864 , XZ_3500_g251864 , XY500_g251864 , XY_1500_g251864 , XY_2500_g251864 , XY_3500_g251864 , Bias500_g251864 , Weights_1500_g251864 , Weights_2500_g251864 , Weights_3500_g251864 , Triplanar500_g251864 , NormalWS500_g251864 , Normal500_g251864 );
					float4 temp_output_407_203_g251841 = localSampleStochastic3D500_g251864;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g251841 = temp_output_407_277_g251841;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g251841 = temp_output_407_278_g251841;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g251841 = temp_output_407_0_g251841;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g251841 = temp_output_407_201_g251841;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g251841 = temp_output_407_202_g251841;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g251841 = temp_output_407_203_g251841;
					#else
					float4 staticSwitch184_g251841 = temp_output_407_277_g251841;
					#endif
					half4 Local_AlbedoSample185_g251841 = staticSwitch184_g251841;
					float3 lerpResult53_g251841 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g251841).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g251841 = lerpResult53_g251841;
					float temp_output_17_0_g251861 = _MainMultiWriteMode;
					float Option91_g251861 = temp_output_17_0_g251861;
					float4 Model_VertexData418_g251841 = Out_VertexData15_g251842;
					float4 temp_output_84_0_g251861 = Model_VertexData418_g251841;
					float4 ChannelA91_g251861 = temp_output_84_0_g251861;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251849) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g251848 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g251848 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g251848 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g251848 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g251848 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g251848 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251849 = staticSwitch38_g251848;
					float localBreakTextureData456_g251849 = ( 0.0 );
					TVEMasksData Data456_g251849 =(TVEMasksData)Data431_g251863;
					float4 Out_MaskA456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251849 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251849 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251849 , Out_MaskA456_g251849 , Out_MaskB456_g251849 , Out_MaskC456_g251849 , Out_MaskD456_g251849 , Out_MaskE456_g251849 , Out_MaskF456_g251849 , Out_MaskG456_g251849 , Out_MaskH456_g251849 , Out_MaskI456_g251849 , Out_MaskJ456_g251849 , Out_MaskK456_g251849 , Out_MaskL456_g251849 , Out_MaskM456_g251849 , Out_MaskN456_g251849 );
					half2 UV276_g251849 = (Out_MaskA456_g251849).xy;
					float temp_output_504_0_g251849 = 0.0;
					half Bias276_g251849 = temp_output_504_0_g251849;
					half2 Normal276_g251849 = float2( 0,0 );
					half4 localSampleCoord276_g251849 = SampleCoord( Texture276_g251849 , Sampler276_g251849 , UV276_g251849 , Bias276_g251849 , Normal276_g251849 );
					float4 temp_output_405_277_g251841 = localSampleCoord276_g251849;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251849) = _MainShaderTex;
					SamplerState Sampler502_g251849 = staticSwitch38_g251848;
					half2 UV502_g251849 = (Out_MaskA456_g251849).zw;
					half Bias502_g251849 = temp_output_504_0_g251849;
					half2 Normal502_g251849 = float2( 0,0 );
					half4 localSampleCoord502_g251849 = SampleCoord( Texture502_g251849 , Sampler502_g251849 , UV502_g251849 , Bias502_g251849 , Normal502_g251849 );
					float4 temp_output_405_278_g251841 = localSampleCoord502_g251849;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251849) = _MainShaderTex;
					SamplerState Sampler496_g251849 = staticSwitch38_g251848;
					float2 temp_output_463_0_g251849 = (Out_MaskB456_g251849).zw;
					half2 XZ496_g251849 = temp_output_463_0_g251849;
					half Bias496_g251849 = temp_output_504_0_g251849;
					half3 NormalWS512_g251849 = (Out_MaskK456_g251849).xyz;
					half3 NormalWS496_g251849 = NormalWS512_g251849;
					half3 Normal496_g251849 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251849 = SamplePlanar2D( Texture496_g251849 , Sampler496_g251849 , XZ496_g251849 , Bias496_g251849 , NormalWS496_g251849 , Normal496_g251849 );
					float4 temp_output_405_0_g251841 = localSamplePlanar2D496_g251849;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251849) = _MainShaderTex;
					SamplerState Sampler490_g251849 = staticSwitch38_g251848;
					float2 temp_output_462_0_g251849 = (Out_MaskB456_g251849).xy;
					half2 ZY490_g251849 = temp_output_462_0_g251849;
					half2 XZ490_g251849 = temp_output_463_0_g251849;
					float2 temp_output_464_0_g251849 = (Out_MaskC456_g251849).xy;
					half2 XY490_g251849 = temp_output_464_0_g251849;
					half Bias490_g251849 = temp_output_504_0_g251849;
					half3 Triplanar522_g251849 = (Out_MaskN456_g251849).xyz;
					half3 Triplanar490_g251849 = Triplanar522_g251849;
					half3 NormalWS490_g251849 = NormalWS512_g251849;
					half3 Normal490_g251849 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251849 = SamplePlanar3D( Texture490_g251849 , Sampler490_g251849 , ZY490_g251849 , XZ490_g251849 , XY490_g251849 , Bias490_g251849 , Triplanar490_g251849 , NormalWS490_g251849 , Normal490_g251849 );
					float4 temp_output_405_201_g251841 = localSamplePlanar3D490_g251849;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251849) = _MainShaderTex;
					SamplerState Sampler498_g251849 = staticSwitch38_g251848;
					half2 XZ498_g251849 = temp_output_463_0_g251849;
					float2 temp_output_473_0_g251849 = (Out_MaskE456_g251849).xy;
					half2 XZ_1498_g251849 = temp_output_473_0_g251849;
					float2 temp_output_474_0_g251849 = (Out_MaskE456_g251849).zw;
					half2 XZ_2498_g251849 = temp_output_474_0_g251849;
					float2 temp_output_475_0_g251849 = (Out_MaskF456_g251849).xy;
					half2 XZ_3498_g251849 = temp_output_475_0_g251849;
					float temp_output_510_0_g251849 = exp2( temp_output_504_0_g251849 );
					half Bias498_g251849 = temp_output_510_0_g251849;
					float3 temp_output_480_0_g251849 = (Out_MaskI456_g251849).xyz;
					half3 Weights_2498_g251849 = temp_output_480_0_g251849;
					half3 NormalWS498_g251849 = NormalWS512_g251849;
					half3 Normal498_g251849 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251849 = SampleStochastic2D( Texture498_g251849 , Sampler498_g251849 , XZ498_g251849 , XZ_1498_g251849 , XZ_2498_g251849 , XZ_3498_g251849 , Bias498_g251849 , Weights_2498_g251849 , NormalWS498_g251849 , Normal498_g251849 );
					float4 temp_output_405_202_g251841 = localSampleStochastic2D498_g251849;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251849) = _MainShaderTex;
					SamplerState Sampler500_g251849 = staticSwitch38_g251848;
					half2 ZY500_g251849 = temp_output_462_0_g251849;
					half2 ZY_1500_g251849 = (Out_MaskC456_g251849).zw;
					half2 ZY_2500_g251849 = (Out_MaskD456_g251849).xy;
					half2 ZY_3500_g251849 = (Out_MaskD456_g251849).zw;
					half2 XZ500_g251849 = temp_output_463_0_g251849;
					half2 XZ_1500_g251849 = temp_output_473_0_g251849;
					half2 XZ_2500_g251849 = temp_output_474_0_g251849;
					half2 XZ_3500_g251849 = temp_output_475_0_g251849;
					half2 XY500_g251849 = temp_output_464_0_g251849;
					half2 XY_1500_g251849 = (Out_MaskF456_g251849).zw;
					half2 XY_2500_g251849 = (Out_MaskG456_g251849).xy;
					half2 XY_3500_g251849 = (Out_MaskG456_g251849).zw;
					half Bias500_g251849 = temp_output_510_0_g251849;
					half3 Weights_1500_g251849 = (Out_MaskH456_g251849).xyz;
					half3 Weights_2500_g251849 = temp_output_480_0_g251849;
					half3 Weights_3500_g251849 = (Out_MaskJ456_g251849).xyz;
					half3 Triplanar500_g251849 = Triplanar522_g251849;
					half3 NormalWS500_g251849 = NormalWS512_g251849;
					half3 Normal500_g251849 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251849 = SampleStochastic3D( Texture500_g251849 , Sampler500_g251849 , ZY500_g251849 , ZY_1500_g251849 , ZY_2500_g251849 , ZY_3500_g251849 , XZ500_g251849 , XZ_1500_g251849 , XZ_2500_g251849 , XZ_3500_g251849 , XY500_g251849 , XY_1500_g251849 , XY_2500_g251849 , XY_3500_g251849 , Bias500_g251849 , Weights_1500_g251849 , Weights_2500_g251849 , Weights_3500_g251849 , Triplanar500_g251849 , NormalWS500_g251849 , Normal500_g251849 );
					float4 temp_output_405_203_g251841 = localSampleStochastic3D500_g251849;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g251841 = temp_output_405_277_g251841;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g251841 = temp_output_405_278_g251841;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g251841 = temp_output_405_0_g251841;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g251841 = temp_output_405_201_g251841;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g251841 = temp_output_405_202_g251841;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g251841 = temp_output_405_203_g251841;
					#else
					float4 staticSwitch198_g251841 = temp_output_405_277_g251841;
					#endif
					half4 Local_ShaderSample199_g251841 = staticSwitch198_g251841;
					float2 appendResult428_g251841 = (float2((Local_AlbedoSample185_g251841).w , (Local_ShaderSample199_g251841).z));
					float2 temp_output_85_0_g251861 = appendResult428_g251841;
					float4 ChannelB91_g251861 = float4( temp_output_85_0_g251861, 0.0 , 0.0 );
					float localSwitchChannel691_g251861 = SwitchChannel6( Option91_g251861 , ChannelA91_g251861 , ChannelB91_g251861 );
					float clampResult17_g251859 = clamp( localSwitchChannel691_g251861 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251860 = _MainMultiWriteRemap.x;
					float temp_output_9_0_g251860 = ( clampResult17_g251859 - temp_output_7_0_g251860 );
					half Local_MultiMask78_g251841 = saturate( ( temp_output_9_0_g251860 * _MainMultiWriteRemap.z ) );
					float lerpResult58_g251841 = lerp( 1.0 , Local_MultiMask78_g251841 , _MainColorMode);
					float4 lerpResult62_g251841 = lerp( _MainColorTwo , _MainColor , lerpResult58_g251841);
					half3 Local_ColorRGB93_g251841 = (lerpResult62_g251841).rgb;
					half3 Local_Albedo139_g251841 = ( Local_AlbedoRGB107_g251841 * Local_ColorRGB93_g251841 );
					float3 temp_output_4_0_g251843 = Local_Albedo139_g251841;
					float3 In_Albedo3_g251843 = temp_output_4_0_g251843;
					float3 temp_output_44_0_g251843 = Local_Albedo139_g251841;
					float3 In_AlbedoBase3_g251843 = temp_output_44_0_g251843;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g251870) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g251847 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g251847 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g251847 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g251847 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g251847 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g251847 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g251870 = staticSwitch37_g251847;
					float localBreakTextureData456_g251870 = ( 0.0 );
					TVEMasksData Data456_g251870 =(TVEMasksData)Data431_g251863;
					float4 Out_MaskA456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g251870 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g251870 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g251870 , Out_MaskA456_g251870 , Out_MaskB456_g251870 , Out_MaskC456_g251870 , Out_MaskD456_g251870 , Out_MaskE456_g251870 , Out_MaskF456_g251870 , Out_MaskG456_g251870 , Out_MaskH456_g251870 , Out_MaskI456_g251870 , Out_MaskJ456_g251870 , Out_MaskK456_g251870 , Out_MaskL456_g251870 , Out_MaskM456_g251870 , Out_MaskN456_g251870 );
					half2 UV276_g251870 = (Out_MaskA456_g251870).xy;
					float temp_output_504_0_g251870 = 0.0;
					half Bias276_g251870 = temp_output_504_0_g251870;
					half2 Normal276_g251870 = float2( 0,0 );
					half4 localSampleCoord276_g251870 = SampleCoord( Texture276_g251870 , Sampler276_g251870 , UV276_g251870 , Bias276_g251870 , Normal276_g251870 );
					float2 temp_output_406_394_g251841 = Normal276_g251870;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g251870) = _MainNormalTex;
					SamplerState Sampler502_g251870 = staticSwitch37_g251847;
					half2 UV502_g251870 = (Out_MaskA456_g251870).zw;
					half Bias502_g251870 = temp_output_504_0_g251870;
					half2 Normal502_g251870 = float2( 0,0 );
					half4 localSampleCoord502_g251870 = SampleCoord( Texture502_g251870 , Sampler502_g251870 , UV502_g251870 , Bias502_g251870 , Normal502_g251870 );
					float2 temp_output_406_397_g251841 = Normal502_g251870;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g251870) = _MainNormalTex;
					SamplerState Sampler496_g251870 = staticSwitch37_g251847;
					float2 temp_output_463_0_g251870 = (Out_MaskB456_g251870).zw;
					half2 XZ496_g251870 = temp_output_463_0_g251870;
					half Bias496_g251870 = temp_output_504_0_g251870;
					half3 NormalWS512_g251870 = (Out_MaskK456_g251870).xyz;
					half3 NormalWS496_g251870 = NormalWS512_g251870;
					half3 Normal496_g251870 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g251870 = SamplePlanar2D( Texture496_g251870 , Sampler496_g251870 , XZ496_g251870 , Bias496_g251870 , NormalWS496_g251870 , Normal496_g251870 );
					float3 temp_output_35_0_g251873 = Normal496_g251870;
					half3 TangentWS519_g251870 = (Out_MaskL456_g251870).xyz;
					float dotResult84_g251873 = dot( temp_output_35_0_g251873 , TangentWS519_g251870 );
					half3 BitangentWS521_g251870 = (Out_MaskM456_g251870).xyz;
					float dotResult85_g251873 = dot( temp_output_35_0_g251873 , BitangentWS521_g251870 );
					float2 appendResult87_g251873 = (float2(dotResult84_g251873 , dotResult85_g251873));
					float2 temp_output_406_375_g251841 = appendResult87_g251873;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g251870) = _MainNormalTex;
					SamplerState Sampler490_g251870 = staticSwitch37_g251847;
					float2 temp_output_462_0_g251870 = (Out_MaskB456_g251870).xy;
					half2 ZY490_g251870 = temp_output_462_0_g251870;
					half2 XZ490_g251870 = temp_output_463_0_g251870;
					float2 temp_output_464_0_g251870 = (Out_MaskC456_g251870).xy;
					half2 XY490_g251870 = temp_output_464_0_g251870;
					half Bias490_g251870 = temp_output_504_0_g251870;
					half3 Triplanar522_g251870 = (Out_MaskN456_g251870).xyz;
					half3 Triplanar490_g251870 = Triplanar522_g251870;
					half3 NormalWS490_g251870 = NormalWS512_g251870;
					half3 Normal490_g251870 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g251870 = SamplePlanar3D( Texture490_g251870 , Sampler490_g251870 , ZY490_g251870 , XZ490_g251870 , XY490_g251870 , Bias490_g251870 , Triplanar490_g251870 , NormalWS490_g251870 , Normal490_g251870 );
					float3 temp_output_35_0_g251874 = Normal490_g251870;
					float dotResult84_g251874 = dot( temp_output_35_0_g251874 , TangentWS519_g251870 );
					float dotResult85_g251874 = dot( temp_output_35_0_g251874 , BitangentWS521_g251870 );
					float2 appendResult87_g251874 = (float2(dotResult84_g251874 , dotResult85_g251874));
					float2 temp_output_406_353_g251841 = appendResult87_g251874;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g251870) = _MainNormalTex;
					SamplerState Sampler498_g251870 = staticSwitch37_g251847;
					half2 XZ498_g251870 = temp_output_463_0_g251870;
					float2 temp_output_473_0_g251870 = (Out_MaskE456_g251870).xy;
					half2 XZ_1498_g251870 = temp_output_473_0_g251870;
					float2 temp_output_474_0_g251870 = (Out_MaskE456_g251870).zw;
					half2 XZ_2498_g251870 = temp_output_474_0_g251870;
					float2 temp_output_475_0_g251870 = (Out_MaskF456_g251870).xy;
					half2 XZ_3498_g251870 = temp_output_475_0_g251870;
					float temp_output_510_0_g251870 = exp2( temp_output_504_0_g251870 );
					half Bias498_g251870 = temp_output_510_0_g251870;
					float3 temp_output_480_0_g251870 = (Out_MaskI456_g251870).xyz;
					half3 Weights_2498_g251870 = temp_output_480_0_g251870;
					half3 NormalWS498_g251870 = NormalWS512_g251870;
					half3 Normal498_g251870 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g251870 = SampleStochastic2D( Texture498_g251870 , Sampler498_g251870 , XZ498_g251870 , XZ_1498_g251870 , XZ_2498_g251870 , XZ_3498_g251870 , Bias498_g251870 , Weights_2498_g251870 , NormalWS498_g251870 , Normal498_g251870 );
					float3 temp_output_35_0_g251875 = Normal498_g251870;
					float dotResult84_g251875 = dot( temp_output_35_0_g251875 , TangentWS519_g251870 );
					float dotResult85_g251875 = dot( temp_output_35_0_g251875 , BitangentWS521_g251870 );
					float2 appendResult87_g251875 = (float2(dotResult84_g251875 , dotResult85_g251875));
					float2 temp_output_406_391_g251841 = appendResult87_g251875;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g251870) = _MainNormalTex;
					SamplerState Sampler500_g251870 = staticSwitch37_g251847;
					half2 ZY500_g251870 = temp_output_462_0_g251870;
					half2 ZY_1500_g251870 = (Out_MaskC456_g251870).zw;
					half2 ZY_2500_g251870 = (Out_MaskD456_g251870).xy;
					half2 ZY_3500_g251870 = (Out_MaskD456_g251870).zw;
					half2 XZ500_g251870 = temp_output_463_0_g251870;
					half2 XZ_1500_g251870 = temp_output_473_0_g251870;
					half2 XZ_2500_g251870 = temp_output_474_0_g251870;
					half2 XZ_3500_g251870 = temp_output_475_0_g251870;
					half2 XY500_g251870 = temp_output_464_0_g251870;
					half2 XY_1500_g251870 = (Out_MaskF456_g251870).zw;
					half2 XY_2500_g251870 = (Out_MaskG456_g251870).xy;
					half2 XY_3500_g251870 = (Out_MaskG456_g251870).zw;
					half Bias500_g251870 = temp_output_510_0_g251870;
					half3 Weights_1500_g251870 = (Out_MaskH456_g251870).xyz;
					half3 Weights_2500_g251870 = temp_output_480_0_g251870;
					half3 Weights_3500_g251870 = (Out_MaskJ456_g251870).xyz;
					half3 Triplanar500_g251870 = Triplanar522_g251870;
					half3 NormalWS500_g251870 = NormalWS512_g251870;
					half3 Normal500_g251870 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g251870 = SampleStochastic3D( Texture500_g251870 , Sampler500_g251870 , ZY500_g251870 , ZY_1500_g251870 , ZY_2500_g251870 , ZY_3500_g251870 , XZ500_g251870 , XZ_1500_g251870 , XZ_2500_g251870 , XZ_3500_g251870 , XY500_g251870 , XY_1500_g251870 , XY_2500_g251870 , XY_3500_g251870 , Bias500_g251870 , Weights_1500_g251870 , Weights_2500_g251870 , Weights_3500_g251870 , Triplanar500_g251870 , NormalWS500_g251870 , Normal500_g251870 );
					float3 temp_output_35_0_g251871 = Normal500_g251870;
					float dotResult84_g251871 = dot( temp_output_35_0_g251871 , TangentWS519_g251870 );
					float dotResult85_g251871 = dot( temp_output_35_0_g251871 , BitangentWS521_g251870 );
					float2 appendResult87_g251871 = (float2(dotResult84_g251871 , dotResult85_g251871));
					float2 temp_output_406_390_g251841 = appendResult87_g251871;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g251841 = temp_output_406_394_g251841;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g251841 = temp_output_406_397_g251841;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g251841 = temp_output_406_375_g251841;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g251841 = temp_output_406_353_g251841;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g251841 = temp_output_406_391_g251841;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g251841 = temp_output_406_390_g251841;
					#else
					float2 staticSwitch193_g251841 = temp_output_406_394_g251841;
					#endif
					half2 Local_NormaSample191_g251841 = staticSwitch193_g251841;
					half2 Local_NormalTS108_g251841 = ( Local_NormaSample191_g251841 * _MainNormalValue );
					float2 In_NormalTS3_g251843 = Local_NormalTS108_g251841;
					float2 break80_g251862 = Local_NormalTS108_g251841;
					float3 temp_output_77_0_g251862 = Model_TangentWS366_g251841;
					float3 temp_output_78_0_g251862 = Model_BitangentWS367_g251841;
					float3 temp_output_76_0_g251862 = Model_NormalWS226_g251841;
					half3 Local_NormalWS250_g251841 = ( ( break80_g251862.x * temp_output_77_0_g251862 ) + ( break80_g251862.y * temp_output_78_0_g251862 ) + temp_output_76_0_g251862 );
					float3 In_NormalWS3_g251843 = Local_NormalWS250_g251841;
					float temp_output_209_0_g251841 = (Local_ShaderSample199_g251841).y;
					float temp_output_7_0_g251855 = _MainOcclusionRemap.x;
					float temp_output_9_0_g251855 = ( temp_output_209_0_g251841 - temp_output_7_0_g251855 );
					float lerpResult23_g251841 = lerp( 1.0 , saturate( ( temp_output_9_0_g251855 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g251841 = lerpResult23_g251841;
					float temp_output_213_0_g251841 = (Local_ShaderSample199_g251841).w;
					float temp_output_7_0_g251858 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g251858 = ( temp_output_213_0_g251841 - temp_output_7_0_g251858 );
					half Local_Smoothness317_g251841 = ( saturate( ( temp_output_9_0_g251858 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g251841 = (float4(( (Local_ShaderSample199_g251841).x * _MainMetallicValue ) , Local_Occlusion313_g251841 , (Local_ShaderSample199_g251841).z , Local_Smoothness317_g251841));
					half4 Local_Masks109_g251841 = appendResult73_g251841;
					float4 In_Shader3_g251843 = Local_Masks109_g251841;
					float4 In_Feature3_g251843 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g251843 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g251843 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g251876 = Local_Albedo139_g251841;
					float dotResult20_g251876 = dot( temp_output_3_0_g251876 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g251841 = dotResult20_g251876;
					float temp_output_12_0_g251843 = Local_Grayscale110_g251841;
					float In_Grayscale3_g251843 = temp_output_12_0_g251843;
					float temp_output_3_0_g251877 = Local_Grayscale110_g251841;
					float clampResult27_g251877 = clamp( saturate( ( temp_output_3_0_g251877 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g251841 = clampResult27_g251877;
					float temp_output_16_0_g251843 = Local_Luminosity145_g251841;
					float In_Luminosity3_g251843 = temp_output_16_0_g251843;
					float In_MultiMask3_g251843 = Local_MultiMask78_g251841;
					float temp_output_187_0_g251841 = (Local_AlbedoSample185_g251841).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g251841 = ( temp_output_187_0_g251841 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g251841 = temp_output_187_0_g251841;
					#endif
					half Local_AlphaClip111_g251841 = staticSwitch236_g251841;
					float In_AlphaClip3_g251843 = Local_AlphaClip111_g251841;
					half Local_AlphaFade246_g251841 = (lerpResult62_g251841).a;
					float In_AlphaFade3_g251843 = Local_AlphaFade246_g251841;
					float3 temp_cast_25 = (1.0).xxx;
					float3 In_Translucency3_g251843 = temp_cast_25;
					float In_Transmission3_g251843 = 1.0;
					float In_Thickness3_g251843 = 0.0;
					float In_Diffusion3_g251843 = 0.0;
					float In_Depth3_g251843 = 0.0;
					BuildVisualData( Data3_g251843 , In_Dummy3_g251843 , In_Albedo3_g251843 , In_AlbedoBase3_g251843 , In_NormalTS3_g251843 , In_NormalWS3_g251843 , In_Shader3_g251843 , In_Feature3_g251843 , In_Season3_g251843 , In_Emissive3_g251843 , In_Grayscale3_g251843 , In_Luminosity3_g251843 , In_MultiMask3_g251843 , In_AlphaClip3_g251843 , In_AlphaFade3_g251843 , In_Translucency3_g251843 , In_Transmission3_g251843 , In_Thickness3_g251843 , In_Diffusion3_g251843 , In_Depth3_g251843 );
					TVEVisualData Data4_g251886 =(TVEVisualData)Data3_g251843;
					float Out_Dummy4_g251886 = 0.0;
					float3 Out_Albedo4_g251886 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g251886 = float3( 0,0,0 );
					float2 Out_NormalTS4_g251886 = float2( 0,0 );
					float3 Out_NormalWS4_g251886 = float3( 0,0,0 );
					float4 Out_Shader4_g251886 = float4( 0,0,0,0 );
					float4 Out_Feature4_g251886 = float4( 0,0,0,0 );
					float4 Out_Season4_g251886 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g251886 = float4( 0,0,0,0 );
					float Out_MultiMask4_g251886 = 0.0;
					float Out_Grayscale4_g251886 = 0.0;
					float Out_Luminosity4_g251886 = 0.0;
					float Out_AlphaClip4_g251886 = 0.0;
					float Out_AlphaFade4_g251886 = 0.0;
					float3 Out_Translucency4_g251886 = float3( 0,0,0 );
					float Out_Transmission4_g251886 = 0.0;
					float Out_Thickness4_g251886 = 0.0;
					float Out_Diffusion4_g251886 = 0.0;
					float Out_Depth4_g251886 = 0.0;
					BreakVisualData( Data4_g251886 , Out_Dummy4_g251886 , Out_Albedo4_g251886 , Out_AlbedoBase4_g251886 , Out_NormalTS4_g251886 , Out_NormalWS4_g251886 , Out_Shader4_g251886 , Out_Feature4_g251886 , Out_Season4_g251886 , Out_Emissive4_g251886 , Out_MultiMask4_g251886 , Out_Grayscale4_g251886 , Out_Luminosity4_g251886 , Out_AlphaClip4_g251886 , Out_AlphaFade4_g251886 , Out_Translucency4_g251886 , Out_Transmission4_g251886 , Out_Thickness4_g251886 , Out_Diffusion4_g251886 , Out_Depth4_g251886 );
					float Alpha109_g251881 = Out_AlphaClip4_g251886;
					float lerpResult91_g251881 = lerp( 1.0 , Alpha109_g251881 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g251881 = lerp( 1.0 , lerpResult91_g251881 , Filter152_g251881);
					clip( lerpResult154_g251881 );
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

					o.Emission = ( lerpResult72_g251881 * lerpResult84_g251881 );
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
				#pragma shader_feature_local_vertex TVE_MOTION
				#pragma shader_feature_local_vertex TVE_MOTION_FLOW
				#pragma shader_feature_local TVE_LEGACY
				#if defined (TVE_MOTION) //Motion
					#define TVE_ROTATION_BEND //Motion
				#endif //Motion
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
				#define SAMPLE_TEXTURE3D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE3D_LOD(tex,samplerTex,coord,lod) tex3Dlod(tex,float4(coord,lod))
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
				uniform half _MotionCategory;
				uniform half _MotionEnd;
				uniform half _MotionFlowInfo;
				uniform half4 TVE_WindParams;
				uniform half _MotionFlowValue;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MotionNoiseTex);
				uniform half _MotionSmallPivotValue;
				uniform half _MotionSmallPhaseValue;
				uniform half _MotionSmallTillingValue;
				uniform half4 TVE_MotionTimeParams;
				uniform half _MotionSmallSpeedValue;
				uniform half _MotionSmallNoiseValue;
				uniform half _MotionFlowMode;
				uniform half4 TVE_WindEditor;
				uniform half _MotionIntensityValue;
				uniform half _MotionSmallDelayValue;
				uniform half _MotionSmallIntensityValue;
				uniform half _MotionSmallPushValue;
				uniform half _MotionSmallMaskMode;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MotionMaskTex);
				SamplerState sampler_MotionMaskTex;
				uniform half4 _MotionSmallMaskRemap;
				uniform half4 TVE_MotionValueParams;
				uniform half _MotionTinyTillingValue;
				uniform half _MotionTinySpeedValue;
				uniform half _MotionTinyNoiseValue;
				uniform half _MotionTinyIntensityValue;
				UNITY_DECLARE_TEX3D_NOSAMPLER(_NoiseTex3D);
				uniform half _MotionTinyMaskMode;
				uniform half4 _MotionTinyMaskRemap;
				uniform half _MotionDistValue;
				uniform half _MotionBasePivotValue;
				uniform half _MotionBasePhaseValue;
				uniform half _MotionBaseTillingValue;
				uniform half _MotionBaseSpeedValue;
				uniform half _MotionBaseNoiseValue;
				uniform half _MotionBaseIntensityValue;
				uniform half _MotionBaseDelayValue;
				uniform half _MotionBasePushValue;
				uniform half _MotionBaseMaskMode;
				uniform half4 _MotionBaseMaskRemap;
				uniform half _MotionHighlightValue;
				uniform half _motion_small_mode;
				uniform half4 _MotionHighlightColor;


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
				
				float SwitchChannel7( half Option, half4 ChannelA, half4 ChannelB )
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
					}
				}
				
				float2 DecodeFloatToVector2( float enc )
				{
					float2 result ;
					result.y = enc % 2048;
					result.x = floor(enc / 2048);
					return result / (2048 - 1);
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
					float localIfModelDataByShader26_g241959 = ( 0.0 );
					TVEModelData Data26_g241959 = (TVEModelData)0;
					TVEModelData Data16_g241856 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g241838 = _ObjectCoordMode;
					#else
					float staticSwitch343_g241838 = _ObjectCoordMode;
					#endif
					half Dummy207_g241838 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g241838 );
					float temp_output_14_0_g241856 = Dummy207_g241838;
					float In_Dummy16_g241856 = temp_output_14_0_g241856;
					float3 PositionOS131_g241838 = v.vertex.xyz;
					float3 temp_output_4_0_g241856 = PositionOS131_g241838;
					float3 In_PositionOS16_g241856 = temp_output_4_0_g241856;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g241838 = ase_positionWS;
					float3 vertexToFrag73_g241838 = temp_output_104_7_g241838;
					float3 PositionWS122_g241838 = vertexToFrag73_g241838;
					float3 In_PositionWS16_g241856 = PositionWS122_g241838;
					float4x4 break19_g241841 = unity_ObjectToWorld;
					float3 appendResult20_g241841 = (float3(break19_g241841[ 0 ][ 3 ] , break19_g241841[ 1 ][ 3 ] , break19_g241841[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241838 = appendResult20_g241841;
					float4x4 break19_g241843 = unity_ObjectToWorld;
					float3 appendResult20_g241843 = (float3(break19_g241843[ 0 ][ 3 ] , break19_g241843[ 1 ][ 3 ] , break19_g241843[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g241839 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g241838 = PositionOS131_g241838;
					float3 appendResult234_g241838 = (float3(break233_g241838.x , 0.0 , break233_g241838.z));
					float3 break413_g241838 = PositionOS131_g241838;
					float3 appendResult414_g241838 = (float3(break413_g241838.x , break413_g241838.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g241845 = appendResult414_g241838;
					#else
					float3 staticSwitch65_g241845 = appendResult234_g241838;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g241838 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g241838 = appendResult60_g241839;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g241838 = staticSwitch65_g241845;
					#else
					float3 staticSwitch229_g241838 = _Vector0;
					#endif
					float3 PivotOS149_g241838 = staticSwitch229_g241838;
					float3 temp_output_122_0_g241843 = PivotOS149_g241838;
					float3 PivotsOnlyWS105_g241843 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g241843 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g241838 = ( appendResult20_g241843 + PivotsOnlyWS105_g241843 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g241838 = temp_output_340_7_g241838;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g241838 = temp_output_341_7_g241838;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g241838 = temp_output_341_7_g241838;
					#else
					float3 staticSwitch236_g241838 = temp_output_340_7_g241838;
					#endif
					float3 vertexToFrag76_g241838 = staticSwitch236_g241838;
					float3 PivotWS121_g241838 = vertexToFrag76_g241838;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241838 = ( PositionWS122_g241838 - PivotWS121_g241838 );
					#else
					float3 staticSwitch204_g241838 = PositionWS122_g241838;
					#endif
					float3 PositionWO132_g241838 = ( staticSwitch204_g241838 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241856 = PositionWO132_g241838;
					float3 In_PivotOS16_g241856 = PivotOS149_g241838;
					float3 In_PivotWS16_g241856 = PivotWS121_g241838;
					float3 PivotWO133_g241838 = ( PivotWS121_g241838 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241856 = PivotWO133_g241838;
					half3 NormalOS134_g241838 = v.normal;
					float3 temp_output_21_0_g241856 = NormalOS134_g241838;
					float3 In_NormalOS16_g241856 = temp_output_21_0_g241856;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g241838 = normalizedWorldNormal;
					float3 In_NormalWS16_g241856 = NormalWS95_g241838;
					half4 TangentlOS153_g241838 = v.tangent;
					float4 temp_output_6_0_g241856 = TangentlOS153_g241838;
					float4 In_TangentOS16_g241856 = temp_output_6_0_g241856;
					float3 normalizeResult296_g241838 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241838 ) );
					half3 ViewDirWS169_g241838 = normalizeResult296_g241838;
					float3 In_ViewDirWS16_g241856 = ViewDirWS169_g241838;
					float4 appendResult397_g241838 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g241838 = appendResult397_g241838;
					float4 In_CoordsData16_g241856 = CoordsData398_g241838;
					half4 VertexMasks171_g241838 = v.ase_color;
					float4 In_VertexData16_g241856 = VertexMasks171_g241838;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241850 = (PositionOS131_g241838).z;
					#else
					float staticSwitch65_g241850 = (PositionOS131_g241838).y;
					#endif
					half Object_HeightValue267_g241838 = _ObjectHeightValue;
					half Bounds_HeightMask274_g241838 = saturate( ( staticSwitch65_g241850 / Object_HeightValue267_g241838 ) );
					half3 Position387_g241838 = PositionOS131_g241838;
					half Height387_g241838 = Object_HeightValue267_g241838;
					half Object_RadiusValue268_g241838 = _ObjectRadiusValue;
					half Radius387_g241838 = Object_RadiusValue268_g241838;
					half localCapsuleMaskYUp387_g241838 = CapsuleMaskYUp( Position387_g241838 , Height387_g241838 , Radius387_g241838 );
					half3 Position408_g241838 = PositionOS131_g241838;
					half Height408_g241838 = Object_HeightValue267_g241838;
					half Radius408_g241838 = Object_RadiusValue268_g241838;
					half localCapsuleMaskZUp408_g241838 = CapsuleMaskZUp( Position408_g241838 , Height408_g241838 , Radius408_g241838 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241855 = saturate( localCapsuleMaskZUp408_g241838 );
					#else
					float staticSwitch65_g241855 = saturate( localCapsuleMaskYUp387_g241838 );
					#endif
					half Bounds_SphereMask282_g241838 = staticSwitch65_g241855;
					float4 appendResult253_g241838 = (float4(Bounds_HeightMask274_g241838 , Bounds_SphereMask282_g241838 , 1.0 , 1.0));
					half4 MasksData254_g241838 = appendResult253_g241838;
					float4 In_MasksData16_g241856 = MasksData254_g241838;
					float temp_output_17_0_g241849 = _ObjectPhaseMode;
					float Option70_g241849 = temp_output_17_0_g241849;
					float4 temp_output_3_0_g241849 = v.ase_color;
					float4 Channel70_g241849 = temp_output_3_0_g241849;
					float localSwitchChannel470_g241849 = SwitchChannel4( Option70_g241849 , Channel70_g241849 );
					half Phase_Value372_g241838 = localSwitchChannel470_g241849;
					float3 break319_g241838 = PivotWO133_g241838;
					half Pivot_Position322_g241838 = ( break319_g241838.x + break319_g241838.z );
					half Phase_Position357_g241838 = ( Phase_Value372_g241838 + Pivot_Position322_g241838 );
					float temp_output_248_0_g241838 = frac( Phase_Position357_g241838 );
					float4 appendResult177_g241838 = (float4((frac( ( Phase_Position357_g241838 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g241838));
					half4 Phase_Data176_g241838 = appendResult177_g241838;
					float4 In_PhaseData16_g241856 = Phase_Data176_g241838;
					BuildModelVertData( Data16_g241856 , In_Dummy16_g241856 , In_PositionOS16_g241856 , In_PositionWS16_g241856 , In_PositionWO16_g241856 , In_PivotOS16_g241856 , In_PivotWS16_g241856 , In_PivotWO16_g241856 , In_NormalOS16_g241856 , In_NormalWS16_g241856 , In_TangentOS16_g241856 , In_ViewDirWS16_g241856 , In_CoordsData16_g241856 , In_VertexData16_g241856 , In_MasksData16_g241856 , In_PhaseData16_g241856 );
					TVEModelData DataDefault26_g241959 = Data16_g241856;
					TVEModelData DataGeneral26_g241959 = Data16_g241856;
					TVEModelData DataBlanket26_g241959 = Data16_g241856;
					TVEModelData DataImpostor26_g241959 = Data16_g241856;
					TVEModelData Data16_g241836 =(TVEModelData)0;
					half Dummy207_g241818 = 0.0;
					float temp_output_14_0_g241836 = Dummy207_g241818;
					float In_Dummy16_g241836 = temp_output_14_0_g241836;
					float3 PositionOS131_g241818 = v.vertex.xyz;
					float3 temp_output_4_0_g241836 = PositionOS131_g241818;
					float3 In_PositionOS16_g241836 = temp_output_4_0_g241836;
					float3 temp_output_104_7_g241818 = ase_positionWS;
					float3 PositionWS122_g241818 = temp_output_104_7_g241818;
					float3 In_PositionWS16_g241836 = PositionWS122_g241818;
					float4x4 break19_g241821 = unity_ObjectToWorld;
					float3 appendResult20_g241821 = (float3(break19_g241821[ 0 ][ 3 ] , break19_g241821[ 1 ][ 3 ] , break19_g241821[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241818 = appendResult20_g241821;
					float3 PivotWS121_g241818 = temp_output_340_7_g241818;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241818 = ( PositionWS122_g241818 - PivotWS121_g241818 );
					#else
					float3 staticSwitch204_g241818 = PositionWS122_g241818;
					#endif
					float3 PositionWO132_g241818 = ( staticSwitch204_g241818 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241836 = PositionWO132_g241818;
					float3 PivotOS149_g241818 = _Vector0;
					float3 In_PivotOS16_g241836 = PivotOS149_g241818;
					float3 In_PivotWS16_g241836 = PivotWS121_g241818;
					float3 PivotWO133_g241818 = ( PivotWS121_g241818 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241836 = PivotWO133_g241818;
					half3 NormalOS134_g241818 = v.normal;
					float3 temp_output_21_0_g241836 = NormalOS134_g241818;
					float3 In_NormalOS16_g241836 = temp_output_21_0_g241836;
					half3 NormalWS95_g241818 = normalizedWorldNormal;
					float3 In_NormalWS16_g241836 = NormalWS95_g241818;
					float4 appendResult462_g241818 = (float4(cross( v.normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g241818 = appendResult462_g241818;
					float4 temp_output_6_0_g241836 = TangentlOS153_g241818;
					float4 In_TangentOS16_g241836 = temp_output_6_0_g241836;
					float3 normalizeResult296_g241818 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241818 ) );
					half3 ViewDirWS169_g241818 = normalizeResult296_g241818;
					float3 In_ViewDirWS16_g241836 = ViewDirWS169_g241818;
					float4 appendResult397_g241818 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g241818 = appendResult397_g241818;
					float4 In_CoordsData16_g241836 = CoordsData398_g241818;
					half4 VertexMasks171_g241818 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241836 = VertexMasks171_g241818;
					half4 MasksData254_g241818 = float4( 0,0,0,0 );
					float4 In_MasksData16_g241836 = MasksData254_g241818;
					half4 Phase_Data176_g241818 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g241836 = Phase_Data176_g241818;
					BuildModelVertData( Data16_g241836 , In_Dummy16_g241836 , In_PositionOS16_g241836 , In_PositionWS16_g241836 , In_PositionWO16_g241836 , In_PivotOS16_g241836 , In_PivotWS16_g241836 , In_PivotWO16_g241836 , In_NormalOS16_g241836 , In_NormalWS16_g241836 , In_TangentOS16_g241836 , In_ViewDirWS16_g241836 , In_CoordsData16_g241836 , In_VertexData16_g241836 , In_MasksData16_g241836 , In_PhaseData16_g241836 );
					TVEModelData DataTerrain26_g241959 = Data16_g241836;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g241959 = IsShaderType2637;
					{
					if (Type26_g241959 == 0 )
					{
					Data26_g241959 = DataDefault26_g241959;
					}
					else if (Type26_g241959 == 1 )
					{
					Data26_g241959 = DataGeneral26_g241959;
					}
					else if (Type26_g241959 == 2 )
					{
					Data26_g241959 = DataBlanket26_g241959;
					}
					else if (Type26_g241959 == 3 )
					{
					Data26_g241959 = DataImpostor26_g241959;
					}
					else if (Type26_g241959 == 4 )
					{
					Data26_g241959 = DataTerrain26_g241959;
					}
					}
					TVEModelData Data15_g251553 =(TVEModelData)Data26_g241959;
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
					TVEVertexData Data15_g251569 =(TVEVertexData)Data16_g251557;
					float Out_Dummy15_g251569 = 0.0;
					float3 Out_PositionOS15_g251569 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251569 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251569 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251569 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251569 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251569 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251569 , Out_Dummy15_g251569 , Out_PositionOS15_g251569 , Out_NormalOS15_g251569 , Out_TangentOS15_g251569 , Out_TransformData15_g251569 , Out_RotationData15_g251569 , Out_Interpolator15_g251569 );
					TVEVertexData Data16_g251570 =(TVEVertexData)Data15_g251569;
					half Dummy317_g251561 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251570 = Dummy317_g251561;
					float3 In_PositionOS16_g251570 = Out_PositionOS15_g251569;
					float3 In_NormalOS16_g251570 = Out_NormalOS15_g251569;
					float4 In_TangentOS16_g251570 = Out_TangentOS15_g251569;
					half4 Model_TransformData356_g251561 = Out_TransformData15_g251569;
					float localBuildGlobalData204_g241858 = ( 0.0 );
					TVEGlobalData Data204_g241858 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g241858 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g241858 = Dummy211_g241858;
					float4 temp_output_203_0_g241877 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g241817 = ( 0.0 );
					TVEModelData Data26_g241817 = (TVEModelData)0;
					TVEModelData Data16_g241846 =(TVEModelData)0;
					float In_Dummy16_g241846 = 0.0;
					float3 In_PositionWS16_g241846 = PositionWS122_g241838;
					float3 In_PositionWO16_g241846 = PositionWO132_g241838;
					float3 In_PivotWS16_g241846 = PivotWS121_g241838;
					float3 In_PivotWO16_g241846 = PivotWO133_g241838;
					float3 In_NormalWS16_g241846 = NormalWS95_g241838;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g241838 = ase_tangentWS;
					float3 In_TangentWS16_g241846 = TangentWS136_g241838;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g241838 = ase_bitangentWS;
					float3 In_BitangentWS16_g241846 = BiangentWS421_g241838;
					half3 NormalWS427_g241838 = NormalWS95_g241838;
					half3 localComputeTriplanarMasks427_g241838 = ComputeTriplanarMasks( NormalWS427_g241838 );
					half3 TriplanarWeights429_g241838 = localComputeTriplanarMasks427_g241838;
					float3 In_TriplanarWeights16_g241846 = TriplanarWeights429_g241838;
					float3 In_ViewDirWS16_g241846 = ViewDirWS169_g241838;
					float4 In_CoordsData16_g241846 = CoordsData398_g241838;
					float4 In_VertexData16_g241846 = VertexMasks171_g241838;
					float4 In_Interpolator16_g241846 = Phase_Data176_g241838;
					BuildModelFragData( Data16_g241846 , In_Dummy16_g241846 , In_PositionWS16_g241846 , In_PositionWO16_g241846 , In_PivotWS16_g241846 , In_PivotWO16_g241846 , In_NormalWS16_g241846 , In_TangentWS16_g241846 , In_BitangentWS16_g241846 , In_TriplanarWeights16_g241846 , In_ViewDirWS16_g241846 , In_CoordsData16_g241846 , In_VertexData16_g241846 , In_Interpolator16_g241846 );
					TVEModelData DataDefault26_g241817 = Data16_g241846;
					TVEModelData DataGeneral26_g241817 = Data16_g241846;
					TVEModelData DataBlanket26_g241817 = Data16_g241846;
					TVEModelData DataImpostor26_g241817 = Data16_g241846;
					TVEModelData Data16_g241826 =(TVEModelData)0;
					float In_Dummy16_g241826 = 0.0;
					float3 In_PositionWS16_g241826 = PositionWS122_g241818;
					float3 In_PositionWO16_g241826 = PositionWO132_g241818;
					float3 In_PivotWS16_g241826 = PivotWS121_g241818;
					float3 In_PivotWO16_g241826 = PivotWO133_g241818;
					float3 In_NormalWS16_g241826 = NormalWS95_g241818;
					half3 TangentWS136_g241818 = ase_tangentWS;
					float3 In_TangentWS16_g241826 = TangentWS136_g241818;
					half3 BiangentWS421_g241818 = ase_bitangentWS;
					float3 In_BitangentWS16_g241826 = BiangentWS421_g241818;
					half3 NormalWS427_g241818 = NormalWS95_g241818;
					half3 localComputeTriplanarMasks427_g241818 = ComputeTriplanarMasks( NormalWS427_g241818 );
					half3 TriplanarWeights429_g241818 = localComputeTriplanarMasks427_g241818;
					float3 In_TriplanarWeights16_g241826 = TriplanarWeights429_g241818;
					float3 In_ViewDirWS16_g241826 = ViewDirWS169_g241818;
					float4 In_CoordsData16_g241826 = CoordsData398_g241818;
					float4 In_VertexData16_g241826 = VertexMasks171_g241818;
					float4 In_Interpolator16_g241826 = Phase_Data176_g241818;
					BuildModelFragData( Data16_g241826 , In_Dummy16_g241826 , In_PositionWS16_g241826 , In_PositionWO16_g241826 , In_PivotWS16_g241826 , In_PivotWO16_g241826 , In_NormalWS16_g241826 , In_TangentWS16_g241826 , In_BitangentWS16_g241826 , In_TriplanarWeights16_g241826 , In_ViewDirWS16_g241826 , In_CoordsData16_g241826 , In_VertexData16_g241826 , In_Interpolator16_g241826 );
					TVEModelData DataTerrain26_g241817 = Data16_g241826;
					float Type26_g241817 = IsShaderType2637;
					{
					if (Type26_g241817 == 0 )
					{
					Data26_g241817 = DataDefault26_g241817;
					}
					else if (Type26_g241817 == 1 )
					{
					Data26_g241817 = DataGeneral26_g241817;
					}
					else if (Type26_g241817 == 2 )
					{
					Data26_g241817 = DataBlanket26_g241817;
					}
					else if (Type26_g241817 == 3 )
					{
					Data26_g241817 = DataImpostor26_g241817;
					}
					else if (Type26_g241817 == 4 )
					{
					Data26_g241817 = DataTerrain26_g241817;
					}
					}
					TVEModelData Data15_g241948 =(TVEModelData)Data26_g241817;
					float Out_Dummy15_g241948 = 0.0;
					float3 Out_PositionWS15_g241948 = float3( 0,0,0 );
					float3 Out_PositionWO15_g241948 = float3( 0,0,0 );
					float3 Out_PivotWS15_g241948 = float3( 0,0,0 );
					float3 Out_PivotWO15_g241948 = float3( 0,0,0 );
					float3 Out_NormalWS15_g241948 = float3( 0,0,0 );
					float3 Out_TangentWS15_g241948 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g241948 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g241948 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g241948 = float3( 0,0,0 );
					float4 Out_CoordsData15_g241948 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g241948 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g241948 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g241948 , Out_Dummy15_g241948 , Out_PositionWS15_g241948 , Out_PositionWO15_g241948 , Out_PivotWS15_g241948 , Out_PivotWO15_g241948 , Out_NormalWS15_g241948 , Out_TangentWS15_g241948 , Out_BitangentWS15_g241948 , Out_TriplanarWeights15_g241948 , Out_ViewDirWS15_g241948 , Out_CoordsData15_g241948 , Out_VertexData15_g241948 , Out_Interpolator15_g241948 );
					float3 Model_PositionWS497_g241858 = Out_PositionWS15_g241948;
					float2 Model_PositionWS_XZ143_g241858 = (Model_PositionWS497_g241858).xz;
					float3 Model_PivotWS498_g241858 = Out_PivotWS15_g241948;
					float2 Model_PivotWS_XZ145_g241858 = (Model_PivotWS498_g241858).xz;
					float2 lerpResult300_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g241877 = lerpResult300_g241858;
					float temp_output_82_0_g241875 = _GlobalCoatLayerValue;
					float temp_output_82_0_g241877 = temp_output_82_0_g241875;
					float4 tex2DArrayNode83_g241877 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241877).zw + ( (temp_output_203_0_g241877).xy * temp_output_81_0_g241877 ) ),temp_output_82_0_g241877), 0.0 );
					float4 appendResult210_g241877 = (float4(tex2DArrayNode83_g241877.rgb , tex2DArrayNode83_g241877.a));
					float4 temp_output_204_0_g241877 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g241877 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241877).zw + ( (temp_output_204_0_g241877).xy * temp_output_81_0_g241877 ) ),temp_output_82_0_g241877), 0.0 );
					float4 appendResult212_g241877 = (float4(tex2DArrayNode122_g241877.rgb , tex2DArrayNode122_g241877.a));
					float4 TVE_RenderNearPositionR628_g241858 = TVE_RenderNearPositionR;
					float temp_output_507_0_g241858 = saturate( ( distance( Model_PositionWS497_g241858 , (TVE_RenderNearPositionR628_g241858).xyz ) / (TVE_RenderNearPositionR628_g241858).w ) );
					float temp_output_7_0_g241947 = 1.0;
					float temp_output_9_0_g241947 = ( temp_output_507_0_g241858 - temp_output_7_0_g241947 );
					half TVE_RenderNearFadeValue635_g241858 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g241858 = saturate( ( temp_output_9_0_g241947 / ( ( TVE_RenderNearFadeValue635_g241858 - temp_output_7_0_g241947 ) + 0.0001 ) ) );
					float4 lerpResult131_g241877 = lerp( appendResult210_g241877 , appendResult212_g241877 , Global_TexBlend509_g241858);
					float4 temp_output_159_109_g241875 = lerpResult131_g241877;
					float4 lerpResult168_g241875 = lerp( TVE_CoatParams , temp_output_159_109_g241875 , TVE_CoatLayers[(int)temp_output_82_0_g241875]);
					float4 temp_output_589_109_g241858 = lerpResult168_g241875;
					half4 Coat_Texture302_g241858 = temp_output_589_109_g241858;
					float4 In_CoatTexture204_g241858 = Coat_Texture302_g241858;
					half4 Draw_Texture656_g241858 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g241858 = Draw_Texture656_g241858;
					float4 temp_output_203_0_g241902 = TVE_PaintBaseCoord;
					float2 lerpResult85_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g241902 = lerpResult85_g241858;
					float temp_output_82_0_g241899 = _GlobalPaintLayerValue;
					float temp_output_82_0_g241902 = temp_output_82_0_g241899;
					float4 tex2DArrayNode83_g241902 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241902).zw + ( (temp_output_203_0_g241902).xy * temp_output_81_0_g241902 ) ),temp_output_82_0_g241902), 0.0 );
					float4 appendResult210_g241902 = (float4(tex2DArrayNode83_g241902.rgb , tex2DArrayNode83_g241902.a));
					float4 temp_output_204_0_g241902 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g241902 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241902).zw + ( (temp_output_204_0_g241902).xy * temp_output_81_0_g241902 ) ),temp_output_82_0_g241902), 0.0 );
					float4 appendResult212_g241902 = (float4(tex2DArrayNode122_g241902.rgb , tex2DArrayNode122_g241902.a));
					float4 lerpResult131_g241902 = lerp( appendResult210_g241902 , appendResult212_g241902 , Global_TexBlend509_g241858);
					float4 temp_output_171_109_g241899 = lerpResult131_g241902;
					float4 lerpResult174_g241899 = lerp( TVE_PaintParams , temp_output_171_109_g241899 , TVE_PaintLayers[(int)temp_output_82_0_g241899]);
					float4 temp_output_595_109_g241858 = lerpResult174_g241899;
					half4 Paint_Texture71_g241858 = temp_output_595_109_g241858;
					float4 In_PaintTexture204_g241858 = Paint_Texture71_g241858;
					float4 temp_output_203_0_g241885 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g241885 = lerpResult104_g241858;
					float temp_output_132_0_g241883 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g241885 = temp_output_132_0_g241883;
					float4 tex2DArrayNode83_g241885 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241885).zw + ( (temp_output_203_0_g241885).xy * temp_output_81_0_g241885 ) ),temp_output_82_0_g241885), 0.0 );
					float4 appendResult210_g241885 = (float4(tex2DArrayNode83_g241885.rgb , tex2DArrayNode83_g241885.a));
					float4 temp_output_204_0_g241885 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g241885 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241885).zw + ( (temp_output_204_0_g241885).xy * temp_output_81_0_g241885 ) ),temp_output_82_0_g241885), 0.0 );
					float4 appendResult212_g241885 = (float4(tex2DArrayNode122_g241885.rgb , tex2DArrayNode122_g241885.a));
					float4 lerpResult131_g241885 = lerp( appendResult210_g241885 , appendResult212_g241885 , Global_TexBlend509_g241858);
					float4 temp_output_137_109_g241883 = lerpResult131_g241885;
					float4 lerpResult145_g241883 = lerp( TVE_AtmoParams , temp_output_137_109_g241883 , TVE_AtmoLayers[(int)temp_output_132_0_g241883]);
					float4 temp_output_590_110_g241858 = lerpResult145_g241883;
					half4 Atmo_Texture80_g241858 = temp_output_590_110_g241858;
					float4 In_AtmoTexture204_g241858 = Atmo_Texture80_g241858;
					float4 temp_output_203_0_g241953 = TVE_EffexBaseCoord;
					float2 lerpResult414_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g241953 = lerpResult414_g241858;
					float temp_output_132_0_g241951 = _GlobalEffexLayerValue;
					float temp_output_82_0_g241953 = temp_output_132_0_g241951;
					float4 tex2DArrayNode83_g241953 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241953).zw + ( (temp_output_203_0_g241953).xy * temp_output_81_0_g241953 ) ),temp_output_82_0_g241953), 0.0 );
					float4 appendResult210_g241953 = (float4(tex2DArrayNode83_g241953.rgb , tex2DArrayNode83_g241953.a));
					float4 temp_output_204_0_g241953 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g241953 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241953).zw + ( (temp_output_204_0_g241953).xy * temp_output_81_0_g241953 ) ),temp_output_82_0_g241953), 0.0 );
					float4 appendResult212_g241953 = (float4(tex2DArrayNode122_g241953.rgb , tex2DArrayNode122_g241953.a));
					float4 lerpResult131_g241953 = lerp( appendResult210_g241953 , appendResult212_g241953 , Global_TexBlend509_g241858);
					float4 temp_output_137_109_g241951 = lerpResult131_g241953;
					float4 lerpResult145_g241951 = lerp( TVE_EffexParams , temp_output_137_109_g241951 , TVE_EffexLayers[(int)temp_output_132_0_g241951]);
					float4 temp_output_731_110_g241858 = lerpResult145_g241951;
					half4 Effex_Texture420_g241858 = temp_output_731_110_g241858;
					float4 In_EffexTexture204_g241858 = Effex_Texture420_g241858;
					float4 temp_output_203_0_g241933 = TVE_GlowBaseCoord;
					float2 lerpResult247_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g241933 = lerpResult247_g241858;
					float temp_output_82_0_g241931 = _GlobalGlowLayerValue;
					float temp_output_82_0_g241933 = temp_output_82_0_g241931;
					float4 tex2DArrayNode83_g241933 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241933).zw + ( (temp_output_203_0_g241933).xy * temp_output_81_0_g241933 ) ),temp_output_82_0_g241933), 0.0 );
					float4 appendResult210_g241933 = (float4(tex2DArrayNode83_g241933.rgb , tex2DArrayNode83_g241933.a));
					float4 temp_output_204_0_g241933 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g241933 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241933).zw + ( (temp_output_204_0_g241933).xy * temp_output_81_0_g241933 ) ),temp_output_82_0_g241933), 0.0 );
					float4 appendResult212_g241933 = (float4(tex2DArrayNode122_g241933.rgb , tex2DArrayNode122_g241933.a));
					float4 lerpResult131_g241933 = lerp( appendResult210_g241933 , appendResult212_g241933 , Global_TexBlend509_g241858);
					float4 temp_output_159_109_g241931 = lerpResult131_g241933;
					float4 lerpResult167_g241931 = lerp( TVE_GlowParams , temp_output_159_109_g241931 , TVE_GlowLayers[(int)temp_output_82_0_g241931]);
					float4 temp_output_593_109_g241858 = lerpResult167_g241931;
					half4 Glow_Texture248_g241858 = temp_output_593_109_g241858;
					float4 In_GlowTexture204_g241858 = Glow_Texture248_g241858;
					float4 temp_output_203_0_g241869 = TVE_FormBaseCoord;
					float2 lerpResult168_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g241869 = lerpResult168_g241858;
					float temp_output_130_0_g241867 = _GlobalFormLayerValue;
					float temp_output_82_0_g241869 = temp_output_130_0_g241867;
					float4 tex2DArrayNode83_g241869 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241869).zw + ( (temp_output_203_0_g241869).xy * temp_output_81_0_g241869 ) ),temp_output_82_0_g241869), 0.0 );
					float4 appendResult210_g241869 = (float4(tex2DArrayNode83_g241869.rgb , tex2DArrayNode83_g241869.a));
					float4 temp_output_204_0_g241869 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g241869 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241869).zw + ( (temp_output_204_0_g241869).xy * temp_output_81_0_g241869 ) ),temp_output_82_0_g241869), 0.0 );
					float4 appendResult212_g241869 = (float4(tex2DArrayNode122_g241869.rgb , tex2DArrayNode122_g241869.a));
					float4 lerpResult131_g241869 = lerp( appendResult210_g241869 , appendResult212_g241869 , Global_TexBlend509_g241858);
					float4 temp_output_135_109_g241867 = lerpResult131_g241869;
					float4 lerpResult143_g241867 = lerp( TVE_FormParams , temp_output_135_109_g241867 , TVE_FormLayers[(int)temp_output_130_0_g241867]);
					float4 temp_output_592_0_g241858 = lerpResult143_g241867;
					float4 Form_Texture112_g241858 = temp_output_592_0_g241858;
					float4 In_FormTexture204_g241858 = Form_Texture112_g241858;
					float4 In_LandTexture204_g241858 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g241917 = TVE_VertxBaseCoord;
					float2 lerpResult681_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g241917 = lerpResult681_g241858;
					float temp_output_136_0_g241915 = _GlobalVertxLayerValue;
					float temp_output_82_0_g241917 = temp_output_136_0_g241915;
					float4 tex2DArrayNode83_g241917 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241917).zw + ( (temp_output_203_0_g241917).xy * temp_output_81_0_g241917 ) ),temp_output_82_0_g241917), 0.0 );
					float4 appendResult210_g241917 = (float4(tex2DArrayNode83_g241917.rgb , tex2DArrayNode83_g241917.a));
					float4 temp_output_204_0_g241917 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g241917 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241917).zw + ( (temp_output_204_0_g241917).xy * temp_output_81_0_g241917 ) ),temp_output_82_0_g241917), 0.0 );
					float4 appendResult212_g241917 = (float4(tex2DArrayNode122_g241917.rgb , tex2DArrayNode122_g241917.a));
					float4 lerpResult131_g241917 = lerp( appendResult210_g241917 , appendResult212_g241917 , Global_TexBlend509_g241858);
					float4 temp_output_141_109_g241915 = lerpResult131_g241917;
					float4 lerpResult149_g241915 = lerp( TVE_VertxParams , temp_output_141_109_g241915 , TVE_VertxLayers[(int)temp_output_136_0_g241915]);
					float4 temp_output_695_0_g241858 = lerpResult149_g241915;
					half4 Vertx_Texture693_g241858 = temp_output_695_0_g241858;
					float4 In_VertxTexture204_g241858 = Vertx_Texture693_g241858;
					float4 temp_output_203_0_g241893 = TVE_FlowBaseCoord;
					float2 lerpResult400_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g241893 = lerpResult400_g241858;
					float temp_output_136_0_g241891 = _GlobalFlowLayerValue;
					float temp_output_82_0_g241893 = temp_output_136_0_g241891;
					float4 tex2DArrayNode83_g241893 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241893).zw + ( (temp_output_203_0_g241893).xy * temp_output_81_0_g241893 ) ),temp_output_82_0_g241893), 0.0 );
					float4 appendResult210_g241893 = (float4(tex2DArrayNode83_g241893.rgb , tex2DArrayNode83_g241893.a));
					float4 temp_output_204_0_g241893 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g241893 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241893).zw + ( (temp_output_204_0_g241893).xy * temp_output_81_0_g241893 ) ),temp_output_82_0_g241893), 0.0 );
					float4 appendResult212_g241893 = (float4(tex2DArrayNode122_g241893.rgb , tex2DArrayNode122_g241893.a));
					float4 lerpResult131_g241893 = lerp( appendResult210_g241893 , appendResult212_g241893 , Global_TexBlend509_g241858);
					float4 temp_output_141_109_g241891 = lerpResult131_g241893;
					float4 lerpResult149_g241891 = lerp( TVE_FlowParams , temp_output_141_109_g241891 , TVE_FlowLayers[(int)temp_output_136_0_g241891]);
					float4 temp_output_594_0_g241858 = lerpResult149_g241891;
					half4 Flow_Texture405_g241858 = temp_output_594_0_g241858;
					float4 In_FlowTexture204_g241858 = Flow_Texture405_g241858;
					half4 User_Texture677_g241858 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g241858 = User_Texture677_g241858;
					BuildGlobalData( Data204_g241858 , In_Dummy204_g241858 , In_CoatTexture204_g241858 , In_DrawTexture204_g241858 , In_PaintTexture204_g241858 , In_AtmoTexture204_g241858 , In_EffexTexture204_g241858 , In_GlowTexture204_g241858 , In_FormTexture204_g241858 , In_LandTexture204_g241858 , In_VertxTexture204_g241858 , In_FlowTexture204_g241858 , In_UserTexture204_g241858 );
					TVEGlobalData Data15_g251571 =(TVEGlobalData)Data204_g241858;
					float Out_Dummy15_g251571 = 0.0;
					float4 Out_CoatTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251571 = float4( 0,0,0,0 );
					BreakData( Data15_g251571 , Out_Dummy15_g251571 , Out_CoatTexture15_g251571 , Out_DrawTexture15_g251571 , Out_PaintTexture15_g251571 , Out_AtmoTexture15_g251571 , Out_EffexTexture15_g251571 , Out_GlowTexture15_g251571 , Out_FormTexture15_g251571 , Out_LandTexture15_g251571 , Out_VertxTexture15_g251571 , Out_FlowTexture15_g251571 , Out_UserTexture15_g251571 );
					float4 Global_FormTexture351_g251561 = Out_FormTexture15_g251571;
					TVEModelData Data15_g251568 =(TVEModelData)Data15_g251556;
					float Out_Dummy15_g251568 = 0.0;
					float3 Out_PositionOS15_g251568 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251568 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251568 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251568 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251568 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251568 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251568 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251568 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251568 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251568 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251568 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251568 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251568 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251568 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251568 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251568 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251568 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251568 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251568 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251568 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251568 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251568 , Out_Dummy15_g251568 , Out_PositionOS15_g251568 , Out_PositionWS15_g251568 , Out_PositionWO15_g251568 , Out_PositionRawOS15_g251568 , Out_PivotOS15_g251568 , Out_PivotWS15_g251568 , Out_PivotWO15_g251568 , Out_NormalOS15_g251568 , Out_NormalWS15_g251568 , Out_NormalRawOS15_g251568 , Out_TangentOS15_g251568 , Out_TangentWS15_g251568 , Out_BitangentWS15_g251568 , Out_ViewDirWS15_g251568 , Out_CoordsData15_g251568 , Out_VertexData15_g251568 , Out_MasksData15_g251568 , Out_PhaseData15_g251568 , Out_TransformData15_g251568 , Out_RotationData15_g251568 , Out_Interpolator15_g251568 );
					float3 Model_PivotWO353_g251561 = Out_PivotWO15_g251568;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251567 = _ConformMeshMode;
					float Option70_g251567 = temp_output_17_0_g251567;
					half4 Model_VertexData357_g251561 = Out_VertexData15_g251568;
					float4 temp_output_3_0_g251567 = Model_VertexData357_g251561;
					float4 Channel70_g251567 = temp_output_3_0_g251567;
					float localSwitchChannel470_g251567 = SwitchChannel4( Option70_g251567 , Channel70_g251567 );
					float temp_output_390_0_g251561 = localSwitchChannel470_g251567;
					float temp_output_7_0_g251564 = _ConformMeshRemap.x;
					float temp_output_9_0_g251564 = ( temp_output_390_0_g251561 - temp_output_7_0_g251564 );
					float lerpResult374_g251561 = lerp( 1.0 , saturate( ( temp_output_9_0_g251564 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251561 = lerpResult374_g251561;
					float temp_output_328_0_g251561 = ( Blend_VertMask379_g251561 * TVE_IsEnabled );
					half Conform_Mask366_g251561 = temp_output_328_0_g251561;
					float temp_output_322_0_g251561 = ( ( ( ( (Global_FormTexture351_g251561).z - ( (Model_PivotWO353_g251561).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251561 ) );
					float3 appendResult329_g251561 = (float3(0.0 , temp_output_322_0_g251561 , 0.0));
					float3 appendResult387_g251561 = (float3(0.0 , 0.0 , temp_output_322_0_g251561));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251565 = appendResult387_g251561;
					#else
					float3 staticSwitch65_g251565 = appendResult329_g251561;
					#endif
					float3 Blanket_Conform368_g251561 = staticSwitch65_g251565;
					float4 appendResult312_g251561 = (float4(Blanket_Conform368_g251561 , 0.0));
					float4 temp_output_310_0_g251561 = ( Model_TransformData356_g251561 + appendResult312_g251561 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251561 = temp_output_310_0_g251561;
					#else
					float4 staticSwitch364_g251561 = Model_TransformData356_g251561;
					#endif
					half4 Final_TransformData365_g251561 = staticSwitch364_g251561;
					float4 In_TransformData16_g251570 = Final_TransformData365_g251561;
					float4 In_RotationData16_g251570 = Out_RotationData15_g251569;
					float4 In_Interpolator16_g251570 = Out_Interpolator15_g251569;
					BuildVertexData( Data16_g251570 , In_Dummy16_g251570 , In_PositionOS16_g251570 , In_NormalOS16_g251570 , In_TangentOS16_g251570 , In_TransformData16_g251570 , In_RotationData16_g251570 , In_Interpolator16_g251570 );
					TVEVertexData Data15_g251653 =(TVEVertexData)Data16_g251570;
					float Out_Dummy15_g251653 = 0.0;
					float3 Out_PositionOS15_g251653 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251653 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251653 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251653 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251653 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251653 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251653 , Out_Dummy15_g251653 , Out_PositionOS15_g251653 , Out_NormalOS15_g251653 , Out_TangentOS15_g251653 , Out_TransformData15_g251653 , Out_RotationData15_g251653 , Out_Interpolator15_g251653 );
					TVEVertexData Data16_g251654 =(TVEVertexData)Data15_g251653;
					half Dummy181_g251640 = ( ( _MotionCategory + _MotionEnd ) + _MotionFlowInfo );
					float In_Dummy16_g251654 = Dummy181_g251640;
					float3 temp_output_3325_0_g251640 = Out_PositionOS15_g251653;
					float3 In_PositionOS16_g251654 = temp_output_3325_0_g251640;
					float3 In_NormalOS16_g251654 = Out_NormalOS15_g251653;
					float4 In_TangentOS16_g251654 = Out_TangentOS15_g251653;
					half4 Vertex_TransformData2743_g251640 = Out_TransformData15_g251653;
					float3 temp_cast_13 = (0.0).xxx;
					half Motion_FlowValue3376_g251640 = _MotionFlowValue;
					float2 lerpResult3361_g251640 = lerp( (half4( 1, 1, 1, 0 )).xy , (TVE_WindParams).xy , ( Motion_FlowValue3376_g251640 * TVE_IsEnabled ));
					float2 Global_WindDirWS2542_g251640 = (lerpResult3361_g251640*2.0 + -1.0);
					half2 Input_WindDirWS803_g251687 = Global_WindDirWS2542_g251640;
					TVEModelData Data15_g251652 =(TVEModelData)Data15_g251568;
					float Out_Dummy15_g251652 = 0.0;
					float3 Out_PositionOS15_g251652 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251652 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251652 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251652 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251652 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251652 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251652 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251652 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251652 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251652 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251652 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251652 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251652 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251652 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251652 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251652 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251652 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251652 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251652 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251652 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251652 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251652 , Out_Dummy15_g251652 , Out_PositionOS15_g251652 , Out_PositionWS15_g251652 , Out_PositionWO15_g251652 , Out_PositionRawOS15_g251652 , Out_PivotOS15_g251652 , Out_PivotWS15_g251652 , Out_PivotWO15_g251652 , Out_NormalOS15_g251652 , Out_NormalWS15_g251652 , Out_NormalRawOS15_g251652 , Out_TangentOS15_g251652 , Out_TangentWS15_g251652 , Out_BitangentWS15_g251652 , Out_ViewDirWS15_g251652 , Out_CoordsData15_g251652 , Out_VertexData15_g251652 , Out_MasksData15_g251652 , Out_PhaseData15_g251652 , Out_TransformData15_g251652 , Out_RotationData15_g251652 , Out_Interpolator15_g251652 );
					float3 Model_PositionWO162_g251640 = Out_PositionWO15_g251652;
					half3 Input_ModelPositionWO761_g251650 = Model_PositionWO162_g251640;
					float3 Model_PivotWO402_g251640 = Out_PivotWO15_g251652;
					half3 Input_ModelPivotsWO419_g251650 = Model_PivotWO402_g251640;
					half Input_MotionPivots629_g251650 = _MotionSmallPivotValue;
					float3 lerpResult771_g251650 = lerp( Input_ModelPositionWO761_g251650 , Input_ModelPivotsWO419_g251650 , Input_MotionPivots629_g251650);
					half4 Model_PhaseData489_g251640 = Out_PhaseData15_g251652;
					half4 Input_ModelMotionData763_g251650 = Model_PhaseData489_g251640;
					half Input_MotionPhase764_g251650 = _MotionSmallPhaseValue;
					float temp_output_770_0_g251650 = ( (Input_ModelMotionData763_g251650).x * Input_MotionPhase764_g251650 );
					half3 Small_Position1421_g251640 = ( lerpResult771_g251650 + temp_output_770_0_g251650 );
					half3 Input_PositionWO419_g251687 = Small_Position1421_g251640;
					half Input_MotionTilling321_g251687 = ( _MotionSmallTillingValue + 0.2 );
					half2 Noise_Coord979_g251687 = ( -(Input_PositionWO419_g251687).xz * Input_MotionTilling321_g251687 * 0.005 );
					float2 Input_Coords80_g251691 = Noise_Coord979_g251687;
					half2 Input_Direction82_g251691 = Input_WindDirWS803_g251687;
					float mulTime113_g251705 = _Time.y * 0.02;
					float lerpResult128_g251705 = lerp( mulTime113_g251705 , ( ( mulTime113_g251705 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					#ifdef SHADER_API_MOBILE
					float staticSwitch134_g251705 = frac( lerpResult128_g251705 );
					#else
					float staticSwitch134_g251705 = lerpResult128_g251705;
					#endif
					float Global_WindTime3262_g251640 = staticSwitch134_g251705;
					half Input_WindTime1015_g251687 = Global_WindTime3262_g251640;
					half Input_MotionSpeed62_g251687 = _MotionSmallSpeedValue;
					float temp_output_986_0_g251687 = ( Input_WindTime1015_g251687 * Input_MotionSpeed62_g251687 );
					half Noise_Speed980_g251687 = temp_output_986_0_g251687;
					float Input_Time88_g251691 = Noise_Speed980_g251687;
					float temp_output_23_0_g251691 = frac( Input_Time88_g251691 );
					float4 lerpResult39_g251691 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251691 + ( Input_Direction82_g251691 * temp_output_23_0_g251691 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251691 + ( Input_Direction82_g251691 * ( temp_output_23_0_g251691 - 1.0 ) ) ), 0.0 ) , temp_output_23_0_g251691);
					float4 temp_output_991_0_g251687 = lerpResult39_g251691;
					half2 Noise_DirWS858_g251687 = ((temp_output_991_0_g251687).rg*2.0 + -1.0);
					half Input_MotionNoise552_g251687 = _MotionSmallNoiseValue;
					float4 temp_output_3332_0_g251640 = TVE_FlowParams;
					TVEGlobalData Data15_g251666 =(TVEGlobalData)Data15_g251571;
					float Out_Dummy15_g251666 = 0.0;
					float4 Out_CoatTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251666 = float4( 0,0,0,0 );
					BreakData( Data15_g251666 , Out_Dummy15_g251666 , Out_CoatTexture15_g251666 , Out_DrawTexture15_g251666 , Out_PaintTexture15_g251666 , Out_AtmoTexture15_g251666 , Out_EffexTexture15_g251666 , Out_GlowTexture15_g251666 , Out_FormTexture15_g251666 , Out_LandTexture15_g251666 , Out_VertxTexture15_g251666 , Out_FlowTexture15_g251666 , Out_UserTexture15_g251666 );
					half4 Global_FlowTexture2668_g251640 = Out_FlowTexture15_g251666;
					#ifdef TVE_MOTION_FLOW
					float4 staticSwitch3075_g251640 = Global_FlowTexture2668_g251640;
					#else
					float4 staticSwitch3075_g251640 = temp_output_3332_0_g251640;
					#endif
					float4 temp_output_6_0_g251667 = staticSwitch3075_g251640;
					float temp_output_7_0_g251667 = _MotionFlowMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g251667 = ( temp_output_6_0_g251667 + temp_output_7_0_g251667 );
					#else
					float4 staticSwitch14_g251667 = temp_output_6_0_g251667;
					#endif
					float4 lerpResult3121_g251640 = lerp( half4( 1, 1, 1, 0 ) , staticSwitch14_g251667 , ( Motion_FlowValue3376_g251640 * TVE_IsEnabled ));
					float temp_output_3077_0_g251640 = (lerpResult3121_g251640).z;
					float temp_output_630_0_g251676 = temp_output_3077_0_g251640;
					float lerpResult853_g251676 = lerp( temp_output_630_0_g251676 , TVE_WindEditor.z , TVE_WindEditor.w);
					half Global_WindValue1855_g251640 = ( lerpResult853_g251676 * _MotionIntensityValue );
					half Input_WindValue881_g251687 = Global_WindValue1855_g251640;
					float temp_output_6_0_g251689 = Input_WindValue881_g251687;
					float lerpResult701_g251687 = lerp( 1.0 , Input_MotionNoise552_g251687 , ( temp_output_6_0_g251689 * temp_output_6_0_g251689 ));
					float2 lerpResult646_g251687 = lerp( Input_WindDirWS803_g251687 , Noise_DirWS858_g251687 , lerpResult701_g251687);
					half2 Small_DirWS817_g251687 = lerpResult646_g251687;
					float2 break823_g251687 = Small_DirWS817_g251687;
					half4 Noise_Params685_g251687 = temp_output_991_0_g251687;
					half Wind_Sinus820_g251687 = ( ((Noise_Params685_g251687).b*2.0 + -1.0) * 0.6 );
					float3 appendResult824_g251687 = (float3(break823_g251687.x , Wind_Sinus820_g251687 , break823_g251687.y));
					half3 Small_Dir918_g251687 = appendResult824_g251687;
					float temp_output_20_0_g251688 = ( 1.0 - Input_WindValue881_g251687 );
					float3 appendResult1006_g251687 = (float3(Input_WindValue881_g251687 , ( 1.0 - ( temp_output_20_0_g251688 * temp_output_20_0_g251688 ) ) , Input_WindValue881_g251687));
					half Input_MotionDelay753_g251687 = _MotionSmallDelayValue;
					float lerpResult756_g251687 = lerp( 1.0 , ( Input_WindValue881_g251687 * Input_WindValue881_g251687 ) , Input_MotionDelay753_g251687);
					half Wind_Delay815_g251687 = lerpResult756_g251687;
					half Input_MotionValue905_g251687 = _MotionSmallIntensityValue;
					float3 temp_output_883_0_g251687 = ( Small_Dir918_g251687 * appendResult1006_g251687 * Wind_Delay815_g251687 * Input_MotionValue905_g251687 );
					float2 break857_g251687 = Noise_DirWS858_g251687;
					float3 appendResult833_g251687 = (float3(break857_g251687.x , Wind_Sinus820_g251687 , break857_g251687.y));
					half3 Push_Dir919_g251687 = appendResult833_g251687;
					half Input_MotionReact924_g251687 = _MotionSmallPushValue;
					half Global_PushAlpha1504_g251640 = (lerpResult3121_g251640).w;
					half Input_PushAlpha806_g251687 = Global_PushAlpha1504_g251640;
					half Global_PushNoise2675_g251640 = temp_output_3077_0_g251640;
					half Input_PushNoise890_g251687 = Global_PushNoise2675_g251640;
					half Push_Mask914_g251687 = saturate( ( Input_PushAlpha806_g251687 * Input_PushNoise890_g251687 * Input_MotionReact924_g251687 ) );
					float3 lerpResult840_g251687 = lerp( temp_output_883_0_g251687 , ( Push_Dir919_g251687 * Input_MotionReact924_g251687 ) , Push_Mask914_g251687);
					#ifdef TVE_MOTION_FLOW
					float3 staticSwitch829_g251687 = lerpResult840_g251687;
					#else
					float3 staticSwitch829_g251687 = temp_output_883_0_g251687;
					#endif
					float3 ase_parentObjectScale = ( 1.0 / float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ) );
					half3 Small_Squash1489_g251640 = ( mul( unity_WorldToObject, float4( staticSwitch829_g251687 , 0.0 ) ).xyz * ase_parentObjectScale );
					float temp_output_17_0_g251655 = _MotionSmallMaskMode;
					float Option92_g251655 = temp_output_17_0_g251655;
					half4 Model_VertexMasks518_g251640 = Out_VertexData15_g251652;
					float4 temp_output_84_0_g251655 = Model_VertexMasks518_g251640;
					float4 ChannelA92_g251655 = temp_output_84_0_g251655;
					half4 Model_MasksData1322_g251640 = Out_MasksData15_g251652;
					float2 uv_MotionMaskTex2818_g251640 = v.ase_texcoord.xy;
					half4 Motion_MaskTex2819_g251640 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex2818_g251640, 0.0 );
					float3 appendResult3227_g251640 = (float3((Model_MasksData1322_g251640).xy , (Motion_MaskTex2819_g251640).g));
					float3 temp_output_85_0_g251655 = appendResult3227_g251640;
					float4 ChannelB92_g251655 = float4( temp_output_85_0_g251655 , 0.0 );
					float localSwitchChannel792_g251655 = SwitchChannel7( Option92_g251655 , ChannelA92_g251655 , ChannelB92_g251655 );
					float enc1805_g251640 = v.ase_texcoord.z;
					float2 localDecodeFloatToVector21805_g251640 = DecodeFloatToVector2( enc1805_g251640 );
					float2 break1804_g251640 = localDecodeFloatToVector21805_g251640;
					half Small_Mask_Legacy1806_g251640 = break1804_g251640.x;
					#ifdef TVE_LEGACY
					float staticSwitch1800_g251640 = Small_Mask_Legacy1806_g251640;
					#else
					float staticSwitch1800_g251640 = localSwitchChannel792_g251655;
					#endif
					float clampResult17_g251641 = clamp( staticSwitch1800_g251640 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251642 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g251642 = ( clampResult17_g251641 - temp_output_7_0_g251642 );
					half Small_Mask640_g251640 = saturate( ( temp_output_9_0_g251642 * _MotionSmallMaskRemap.z ) );
					float3 lerpResult3022_g251640 = lerp( float3( 1,1,1 ) , (TVE_MotionValueParams).xyz , TVE_MotionValueParams.w);
					half3 Global_MotionParams3013_g251640 = lerpResult3022_g251640;
					half3 Small_Motion789_g251640 = ( Small_Squash1489_g251640 * Small_Mask640_g251640 * (Global_MotionParams3013_g251640).y );
					#ifdef TVE_MOTION
					float3 staticSwitch495_g251640 = Small_Motion789_g251640;
					#else
					float3 staticSwitch495_g251640 = temp_cast_13;
					#endif
					float3 temp_cast_17 = (0.0).xxx;
					half3 Tiny_Position2469_g251640 = Model_PositionWO162_g251640;
					half3 Input_PositionWO419_g251706 = Tiny_Position2469_g251640;
					half Input_MotionTilling321_g251706 = ( _MotionTinyTillingValue + 0.2 );
					half2 Noise_Coord979_g251706 = ( -(Input_PositionWO419_g251706).xz * Input_MotionTilling321_g251706 * 0.005 );
					float2 Input_Coords80_g251713 = Noise_Coord979_g251706;
					half2 Input_Direction82_g251713 = float2( 0,1 );
					half Input_WindTime1015_g251706 = Global_WindTime3262_g251640;
					half Input_MotionSpeed62_g251706 = _MotionTinySpeedValue;
					float temp_output_986_0_g251706 = ( Input_WindTime1015_g251706 * Input_MotionSpeed62_g251706 );
					half Noise_Speed980_g251706 = temp_output_986_0_g251706;
					float Input_Time88_g251713 = Noise_Speed980_g251706;
					float4 temp_output_991_0_g251706 = SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251713 + ( Input_Direction82_g251713 * Input_Time88_g251713 ) ), 0.0 );
					half3 Noise_DirWS858_g251706 = ((temp_output_991_0_g251706).rgb*2.0 + -1.0);
					half Input_MotionNoise552_g251706 = _MotionTinyNoiseValue;
					float3 lerpResult646_g251706 = lerp( ( Noise_DirWS858_g251706 * v.normal ) , Noise_DirWS858_g251706 , Input_MotionNoise552_g251706);
					half3 Tiny_DirWS817_g251706 = lerpResult646_g251706;
					half Input_MotionValue905_g251706 = _MotionTinyIntensityValue;
					float mulTime113_g251719 = _Time.y * 2.0;
					float lerpResult128_g251719 = lerp( mulTime113_g251719 , ( ( mulTime113_g251719 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					#ifdef SHADER_API_MOBILE
					float staticSwitch134_g251719 = frac( lerpResult128_g251719 );
					#else
					float staticSwitch134_g251719 = lerpResult128_g251719;
					#endif
					float3 temp_output_1028_0_g251706 = ( Input_PositionWO419_g251706 + staticSwitch134_g251719 );
					float temp_output_1054_0_g251706 = SAMPLE_TEXTURE3D_LOD( _NoiseTex3D, sampler_Linear_Repeat, ( temp_output_1028_0_g251706 * ( 1.0 * 0.01 ) ), 0.0 ).r;
					float temp_output_6_0_g251709 = temp_output_1054_0_g251706;
					float temp_output_6_0_g251710 = temp_output_1054_0_g251706;
					half Input_WindValue881_g251706 = Global_WindValue1855_g251640;
					float temp_output_6_0_g251712 = Input_WindValue881_g251706;
					float lerpResult1029_g251706 = lerp( ( temp_output_6_0_g251709 * temp_output_6_0_g251709 * temp_output_6_0_g251709 * temp_output_6_0_g251709 ) , ( temp_output_6_0_g251710 * temp_output_6_0_g251710 ) , ( temp_output_6_0_g251712 * temp_output_6_0_g251712 ));
					float temp_output_20_0_g251711 = ( 1.0 - Input_WindValue881_g251706 );
					float temp_output_1030_0_g251706 = ( lerpResult1029_g251706 * ( 1.0 - ( temp_output_20_0_g251711 * temp_output_20_0_g251711 * temp_output_20_0_g251711 * temp_output_20_0_g251711 ) ) );
					half Wind_Gust1039_g251706 = temp_output_1030_0_g251706;
					float3 temp_output_883_0_g251706 = ( Tiny_DirWS817_g251706 * Input_MotionValue905_g251706 * Wind_Gust1039_g251706 );
					half3 Tiny_Squash859_g251640 = temp_output_883_0_g251706;
					float temp_output_17_0_g251656 = _MotionTinyMaskMode;
					float Option92_g251656 = temp_output_17_0_g251656;
					float4 temp_output_84_0_g251656 = Model_VertexMasks518_g251640;
					float4 ChannelA92_g251656 = temp_output_84_0_g251656;
					float3 appendResult3234_g251640 = (float3((Model_MasksData1322_g251640).xy , (Motion_MaskTex2819_g251640).b));
					float3 temp_output_85_0_g251656 = appendResult3234_g251640;
					float4 ChannelB92_g251656 = float4( temp_output_85_0_g251656 , 0.0 );
					float localSwitchChannel792_g251656 = SwitchChannel7( Option92_g251656 , ChannelA92_g251656 , ChannelB92_g251656 );
					half Tiny_Mask_Legacy1807_g251640 = break1804_g251640.y;
					#ifdef TVE_LEGACY
					float staticSwitch1810_g251640 = Tiny_Mask_Legacy1807_g251640;
					#else
					float staticSwitch1810_g251640 = localSwitchChannel792_g251656;
					#endif
					float clampResult17_g251643 = clamp( staticSwitch1810_g251640 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251644 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g251644 = ( clampResult17_g251643 - temp_output_7_0_g251644 );
					half Tiny_Mask218_g251640 = saturate( ( temp_output_9_0_g251644 * _MotionTinyMaskRemap.z ) );
					float3 Model_PositionWS1819_g251640 = Out_PositionWS15_g251652;
					half Global_DistMask1820_g251640 = ( 1.0 - saturate( ( distance( _WorldSpaceCameraPos , Model_PositionWS1819_g251640 ) / _MotionDistValue ) ) );
					half3 Tiny_Flutter1451_g251640 = ( Tiny_Squash859_g251640 * Tiny_Mask218_g251640 * Global_DistMask1820_g251640 * (Global_MotionParams3013_g251640).z );
					#ifdef TVE_MOTION
					float3 staticSwitch414_g251640 = Tiny_Flutter1451_g251640;
					#else
					float3 staticSwitch414_g251640 = temp_cast_17;
					#endif
					float4 appendResult2783_g251640 = (float4(( staticSwitch495_g251640 + staticSwitch414_g251640 ) , 0.0));
					half4 Final_TransformData1569_g251640 = ( Vertex_TransformData2743_g251640 + appendResult2783_g251640 );
					float4 In_TransformData16_g251654 = Final_TransformData1569_g251640;
					half4 Vertex_RotationData2740_g251640 = Out_RotationData15_g251653;
					half2 Input_WindDirWS803_g251677 = Global_WindDirWS2542_g251640;
					half3 Input_ModelPositionWO761_g251651 = Model_PositionWO162_g251640;
					half3 Input_ModelPivotsWO419_g251651 = Model_PivotWO402_g251640;
					half Input_MotionPivots629_g251651 = _MotionBasePivotValue;
					float3 lerpResult771_g251651 = lerp( Input_ModelPositionWO761_g251651 , Input_ModelPivotsWO419_g251651 , Input_MotionPivots629_g251651);
					half4 Input_ModelMotionData763_g251651 = Model_PhaseData489_g251640;
					half Input_MotionPhase764_g251651 = _MotionBasePhaseValue;
					float temp_output_770_0_g251651 = ( (Input_ModelMotionData763_g251651).x * Input_MotionPhase764_g251651 );
					half3 Base_Position1394_g251640 = ( lerpResult771_g251651 + temp_output_770_0_g251651 );
					half3 Input_PositionWO419_g251677 = Base_Position1394_g251640;
					half Input_MotionTilling321_g251677 = ( _MotionBaseTillingValue + 0.2 );
					half2 Noise_Coord515_g251677 = ( -(Input_PositionWO419_g251677).xz * Input_MotionTilling321_g251677 * 0.005 );
					float2 Input_Coords80_g251679 = Noise_Coord515_g251677;
					half2 Input_Direction82_g251679 = Input_WindDirWS803_g251677;
					half Input_WindTime963_g251677 = Global_WindTime3262_g251640;
					half Input_MotionSpeed62_g251677 = _MotionBaseSpeedValue;
					float temp_output_505_0_g251677 = ( Input_WindTime963_g251677 * Input_MotionSpeed62_g251677 );
					half Noise_Speed516_g251677 = temp_output_505_0_g251677;
					float Input_Time88_g251679 = Noise_Speed516_g251677;
					float temp_output_23_0_g251679 = frac( Input_Time88_g251679 );
					float4 lerpResult39_g251679 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251679 + ( Input_Direction82_g251679 * temp_output_23_0_g251679 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251679 + ( Input_Direction82_g251679 * ( temp_output_23_0_g251679 - 1.0 ) ) ), 0.0 ) , temp_output_23_0_g251679);
					float4 temp_output_635_0_g251677 = lerpResult39_g251679;
					half2 Noise_DirWS825_g251677 = ((temp_output_635_0_g251677).rg*2.0 + -1.0);
					half Input_MotionNoise552_g251677 = _MotionBaseNoiseValue;
					half Input_WindValue853_g251677 = Global_WindValue1855_g251640;
					float temp_output_6_0_g251678 = Input_WindValue853_g251677;
					float lerpResult701_g251677 = lerp( 1.0 , Input_MotionNoise552_g251677 , ( temp_output_6_0_g251678 * temp_output_6_0_g251678 ));
					float2 lerpResult646_g251677 = lerp( Input_WindDirWS803_g251677 , Noise_DirWS825_g251677 , lerpResult701_g251677);
					half2 Bend_Dir859_g251677 = lerpResult646_g251677;
					half Input_MotionValue871_g251677 = _MotionBaseIntensityValue;
					half Input_MotionDelay753_g251677 = _MotionBaseDelayValue;
					float lerpResult756_g251677 = lerp( 1.0 , ( Input_WindValue853_g251677 * Input_WindValue853_g251677 ) , Input_MotionDelay753_g251677);
					half Wind_Delay815_g251677 = lerpResult756_g251677;
					float2 temp_output_875_0_g251677 = ( Bend_Dir859_g251677 * Input_WindValue853_g251677 * Input_MotionValue871_g251677 * Wind_Delay815_g251677 );
					float2 Global_PushDirWS1972_g251640 = ((lerpResult3121_g251640).xy*2.0 + -1.0);
					half2 Input_PushDirWS807_g251677 = Global_PushDirWS1972_g251640;
					half Input_ReactValue888_g251677 = _MotionBasePushValue;
					half Input_PushAlpha806_g251677 = Global_PushAlpha1504_g251640;
					half Push_Mask883_g251677 = saturate( ( Input_PushAlpha806_g251677 * Input_ReactValue888_g251677 ) );
					float2 lerpResult811_g251677 = lerp( temp_output_875_0_g251677 , ( Input_PushDirWS807_g251677 * Input_ReactValue888_g251677 ) , Push_Mask883_g251677);
					#ifdef TVE_MOTION_FLOW
					float2 staticSwitch808_g251677 = lerpResult811_g251677;
					#else
					float2 staticSwitch808_g251677 = temp_output_875_0_g251677;
					#endif
					float2 temp_output_38_0_g251683 = staticSwitch808_g251677;
					float2 break83_g251683 = temp_output_38_0_g251683;
					float3 appendResult79_g251683 = (float3(break83_g251683.x , 0.0 , break83_g251683.y));
					half2 Base_Bending893_g251640 = (( mul( unity_WorldToObject, float4( appendResult79_g251683 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
					float temp_output_17_0_g251657 = _MotionBaseMaskMode;
					float Option92_g251657 = temp_output_17_0_g251657;
					float4 temp_output_84_0_g251657 = Model_VertexMasks518_g251640;
					float4 ChannelA92_g251657 = temp_output_84_0_g251657;
					float3 appendResult3220_g251640 = (float3((Model_MasksData1322_g251640).xy , (Motion_MaskTex2819_g251640).r));
					float3 temp_output_85_0_g251657 = appendResult3220_g251640;
					float4 ChannelB92_g251657 = float4( temp_output_85_0_g251657 , 0.0 );
					float localSwitchChannel792_g251657 = SwitchChannel7( Option92_g251657 , ChannelA92_g251657 , ChannelB92_g251657 );
					float clampResult17_g251646 = clamp( localSwitchChannel792_g251657 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251645 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g251645 = ( clampResult17_g251646 - temp_output_7_0_g251645 );
					half Base_Mask217_g251640 = saturate( ( temp_output_9_0_g251645 * _MotionBaseMaskRemap.z ) );
					half2 Base_Motion1440_g251640 = ( Base_Bending893_g251640 * Base_Mask217_g251640 * (Global_MotionParams3013_g251640).x );
					#ifdef TVE_MOTION
					float2 staticSwitch2384_g251640 = Base_Motion1440_g251640;
					#else
					float2 staticSwitch2384_g251640 = float2( 0,0 );
					#endif
					float4 appendResult2023_g251640 = (float4(staticSwitch2384_g251640 , 0.0 , 0.0));
					half4 Final_RotationData1570_g251640 = ( Vertex_RotationData2740_g251640 + appendResult2023_g251640 );
					float4 In_RotationData16_g251654 = Final_RotationData1570_g251640;
					half4 Vertex_Interpolator2773_g251640 = Out_Interpolator15_g251653;
					half4 Noise_Params685_g251677 = temp_output_635_0_g251677;
					float temp_output_6_0_g251685 = (Noise_Params685_g251677).a;
					float temp_output_913_0_g251677 = ( ( temp_output_6_0_g251685 * temp_output_6_0_g251685 * temp_output_6_0_g251685 * temp_output_6_0_g251685 ) * ( Input_WindValue853_g251677 * Wind_Delay815_g251677 ) );
					float temp_output_6_0_g251686 = length( Input_PushDirWS807_g251677 );
					float temp_output_937_0_g251677 = ( temp_output_6_0_g251686 * temp_output_6_0_g251686 );
					half Input_PushNoise858_g251677 = Global_PushNoise2675_g251640;
					float lerpResult902_g251677 = lerp( temp_output_913_0_g251677 , temp_output_937_0_g251677 , ( Push_Mask883_g251677 * Input_PushNoise858_g251677 ));
					#ifdef TVE_MOTION_FLOW
					float staticSwitch903_g251677 = lerpResult902_g251677;
					#else
					float staticSwitch903_g251677 = temp_output_913_0_g251677;
					#endif
					half Base_Wave1159_g251640 = staticSwitch903_g251677;
					float temp_output_6_0_g251690 = (Noise_Params685_g251687).a;
					float temp_output_955_0_g251687 = ( temp_output_6_0_g251690 * temp_output_6_0_g251690 * temp_output_6_0_g251690 * temp_output_6_0_g251690 );
					float temp_output_944_0_g251687 = ( temp_output_955_0_g251687 * ( Input_WindValue881_g251687 * Wind_Delay815_g251687 ) );
					float lerpResult936_g251687 = lerp( temp_output_944_0_g251687 , temp_output_955_0_g251687 , ( Push_Mask914_g251687 * Input_PushNoise890_g251687 ));
					#ifdef TVE_MOTION_FLOW
					float staticSwitch939_g251687 = lerpResult936_g251687;
					#else
					float staticSwitch939_g251687 = temp_output_944_0_g251687;
					#endif
					half Small_Wave1427_g251640 = staticSwitch939_g251687;
					float lerpResult2422_g251640 = lerp( Base_Wave1159_g251640 , Small_Wave1427_g251640 , _motion_small_mode);
					half Global_Wave1475_g251640 = saturate( lerpResult2422_g251640 );
					float temp_output_6_0_g251647 = ( _MotionHighlightValue * Global_DistMask1820_g251640 * ( Tiny_Mask218_g251640 * Tiny_Mask218_g251640 ) * Global_Wave1475_g251640 );
					float temp_output_7_0_g251647 = _MotionHighlightColor.r;
					#ifdef TVE_DUMMY
					float staticSwitch14_g251647 = ( temp_output_6_0_g251647 + temp_output_7_0_g251647 );
					#else
					float staticSwitch14_g251647 = temp_output_6_0_g251647;
					#endif
					#ifdef TVE_MOTION
					float staticSwitch2866_g251640 = staticSwitch14_g251647;
					#else
					float staticSwitch2866_g251640 = 0.0;
					#endif
					float4 appendResult2775_g251640 = (float4((Vertex_Interpolator2773_g251640).xyz , staticSwitch2866_g251640));
					half4 Final_Interpolator2774_g251640 = appendResult2775_g251640;
					float4 In_Interpolator16_g251654 = Final_Interpolator2774_g251640;
					BuildVertexData( Data16_g251654 , In_Dummy16_g251654 , In_PositionOS16_g251654 , In_NormalOS16_g251654 , In_TangentOS16_g251654 , In_TransformData16_g251654 , In_RotationData16_g251654 , In_Interpolator16_g251654 );
					TVEVertexData Data15_g251809 =(TVEVertexData)Data16_g251654;
					float Out_Dummy15_g251809 = 0.0;
					float3 Out_PositionOS15_g251809 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251809 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251809 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251809 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251809 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251809 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251809 , Out_Dummy15_g251809 , Out_PositionOS15_g251809 , Out_NormalOS15_g251809 , Out_TangentOS15_g251809 , Out_TransformData15_g251809 , Out_RotationData15_g251809 , Out_Interpolator15_g251809 );
					TVEVertexData Data16_g251810 =(TVEVertexData)Data15_g251809;
					float In_Dummy16_g251810 = 0.0;
					float3 Vertex_PositionOS147_g251800 = Out_PositionOS15_g251809;
					half3 VertexPos40_g251804 = Vertex_PositionOS147_g251800;
					float4 temp_output_1615_33_g251800 = Out_RotationData15_g251809;
					half4 Vertex_RotationData1569_g251800 = temp_output_1615_33_g251800;
					float2 break1582_g251800 = (Vertex_RotationData1569_g251800).xy;
					half Angle44_g251804 = break1582_g251800.y;
					half CosAngle89_g251804 = cos( Angle44_g251804 );
					half SinAngle93_g251804 = sin( Angle44_g251804 );
					float3 appendResult95_g251804 = (float3((VertexPos40_g251804).x , ( ( (VertexPos40_g251804).y * CosAngle89_g251804 ) - ( (VertexPos40_g251804).z * SinAngle93_g251804 ) ) , ( ( (VertexPos40_g251804).y * SinAngle93_g251804 ) + ( (VertexPos40_g251804).z * CosAngle89_g251804 ) )));
					half3 VertexPos40_g251805 = appendResult95_g251804;
					half Angle44_g251805 = -break1582_g251800.x;
					half CosAngle94_g251805 = cos( Angle44_g251805 );
					half SinAngle95_g251805 = sin( Angle44_g251805 );
					float3 appendResult98_g251805 = (float3(( ( (VertexPos40_g251805).x * CosAngle94_g251805 ) - ( (VertexPos40_g251805).y * SinAngle95_g251805 ) ) , ( ( (VertexPos40_g251805).x * SinAngle95_g251805 ) + ( (VertexPos40_g251805).y * CosAngle94_g251805 ) ) , (VertexPos40_g251805).z));
					half3 VertexPos40_g251803 = Vertex_PositionOS147_g251800;
					half Angle44_g251803 = break1582_g251800.y;
					half CosAngle89_g251803 = cos( Angle44_g251803 );
					half SinAngle93_g251803 = sin( Angle44_g251803 );
					float3 appendResult95_g251803 = (float3((VertexPos40_g251803).x , ( ( (VertexPos40_g251803).y * CosAngle89_g251803 ) - ( (VertexPos40_g251803).z * SinAngle93_g251803 ) ) , ( ( (VertexPos40_g251803).y * SinAngle93_g251803 ) + ( (VertexPos40_g251803).z * CosAngle89_g251803 ) )));
					half3 VertexPos40_g251808 = appendResult95_g251803;
					half Angle44_g251808 = break1582_g251800.x;
					half CosAngle91_g251808 = cos( Angle44_g251808 );
					half SinAngle92_g251808 = sin( Angle44_g251808 );
					float3 appendResult93_g251808 = (float3(( ( (VertexPos40_g251808).x * CosAngle91_g251808 ) + ( (VertexPos40_g251808).z * SinAngle92_g251808 ) ) , (VertexPos40_g251808).y , ( ( -(VertexPos40_g251808).x * SinAngle92_g251808 ) + ( (VertexPos40_g251808).z * CosAngle91_g251808 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251806 = appendResult93_g251808;
					#else
					float3 staticSwitch65_g251806 = appendResult98_g251805;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251801 = staticSwitch65_g251806;
					#else
					float3 staticSwitch65_g251801 = Vertex_PositionOS147_g251800;
					#endif
					float3 temp_output_1608_0_g251800 = staticSwitch65_g251801;
					half3 VertexPos40_g251807 = temp_output_1608_0_g251800;
					half Angle44_g251807 = (Vertex_RotationData1569_g251800).z;
					half CosAngle91_g251807 = cos( Angle44_g251807 );
					half SinAngle92_g251807 = sin( Angle44_g251807 );
					float3 appendResult93_g251807 = (float3(( ( (VertexPos40_g251807).x * CosAngle91_g251807 ) + ( (VertexPos40_g251807).z * SinAngle92_g251807 ) ) , (VertexPos40_g251807).y , ( ( -(VertexPos40_g251807).x * SinAngle92_g251807 ) + ( (VertexPos40_g251807).z * CosAngle91_g251807 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251802 = appendResult93_g251807;
					#else
					float3 staticSwitch65_g251802 = temp_output_1608_0_g251800;
					#endif
					float4 temp_output_1615_31_g251800 = Out_TransformData15_g251809;
					half4 Vertex_TransformData1568_g251800 = temp_output_1615_31_g251800;
					half3 Final_PositionOS178_g251800 = ( ( staticSwitch65_g251802 * (Vertex_TransformData1568_g251800).w ) + (Vertex_TransformData1568_g251800).xyz );
					float3 In_PositionOS16_g251810 = Final_PositionOS178_g251800;
					float3 In_NormalOS16_g251810 = Out_NormalOS15_g251809;
					float4 In_TangentOS16_g251810 = Out_TangentOS15_g251809;
					float4 In_TransformData16_g251810 = temp_output_1615_31_g251800;
					float4 In_RotationData16_g251810 = temp_output_1615_33_g251800;
					float4 In_Interpolator16_g251810 = Out_Interpolator15_g251809;
					BuildVertexData( Data16_g251810 , In_Dummy16_g251810 , In_PositionOS16_g251810 , In_NormalOS16_g251810 , In_TangentOS16_g251810 , In_TransformData16_g251810 , In_RotationData16_g251810 , In_Interpolator16_g251810 );
					TVEVertexData Data15_g251818 =(TVEVertexData)Data16_g251810;
					float Out_Dummy15_g251818 = 0.0;
					float3 Out_PositionOS15_g251818 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251818 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251818 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251818 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251818 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251818 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251818 , Out_Dummy15_g251818 , Out_PositionOS15_g251818 , Out_NormalOS15_g251818 , Out_TangentOS15_g251818 , Out_TransformData15_g251818 , Out_RotationData15_g251818 , Out_Interpolator15_g251818 );
					TVEVertexData Data16_g251819 =(TVEVertexData)Data15_g251818;
					float In_Dummy16_g251819 = 0.0;
					TVEModelData Data15_g251817 =(TVEModelData)Data15_g251652;
					float Out_Dummy15_g251817 = 0.0;
					float3 Out_PositionOS15_g251817 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251817 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251817 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251817 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251817 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251817 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251817 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251817 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251817 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251817 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251817 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251817 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251817 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251817 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251817 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251817 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251817 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251817 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251817 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251817 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251817 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251817 , Out_Dummy15_g251817 , Out_PositionOS15_g251817 , Out_PositionWS15_g251817 , Out_PositionWO15_g251817 , Out_PositionRawOS15_g251817 , Out_PivotOS15_g251817 , Out_PivotWS15_g251817 , Out_PivotWO15_g251817 , Out_NormalOS15_g251817 , Out_NormalWS15_g251817 , Out_NormalRawOS15_g251817 , Out_TangentOS15_g251817 , Out_TangentWS15_g251817 , Out_BitangentWS15_g251817 , Out_ViewDirWS15_g251817 , Out_CoordsData15_g251817 , Out_VertexData15_g251817 , Out_MasksData15_g251817 , Out_PhaseData15_g251817 , Out_TransformData15_g251817 , Out_RotationData15_g251817 , Out_Interpolator15_g251817 );
					float3 In_PositionOS16_g251819 = ( Out_PositionOS15_g251818 + Out_PivotOS15_g251817 );
					float3 In_NormalOS16_g251819 = Out_NormalOS15_g251818;
					float4 In_TangentOS16_g251819 = Out_TangentOS15_g251818;
					float4 In_TransformData16_g251819 = Out_TransformData15_g251818;
					float4 In_RotationData16_g251819 = Out_RotationData15_g251818;
					float4 In_Interpolator16_g251819 = Out_Interpolator15_g251818;
					BuildVertexData( Data16_g251819 , In_Dummy16_g251819 , In_PositionOS16_g251819 , In_NormalOS16_g251819 , In_TangentOS16_g251819 , In_TransformData16_g251819 , In_RotationData16_g251819 , In_Interpolator16_g251819 );
					TVEVertexData Data15_g251889 =(TVEVertexData)Data16_g251819;
					float Out_Dummy15_g251889 = 0.0;
					float3 Out_PositionOS15_g251889 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251889 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251889 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251889 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251889 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251889 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251889 , Out_Dummy15_g251889 , Out_PositionOS15_g251889 , Out_NormalOS15_g251889 , Out_TangentOS15_g251889 , Out_TransformData15_g251889 , Out_RotationData15_g251889 , Out_Interpolator15_g251889 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251889;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251889;
					v.tangent = Out_TangentOS15_g251889;

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
				#pragma shader_feature_local_vertex TVE_MOTION
				#pragma shader_feature_local_vertex TVE_MOTION_FLOW
				#pragma shader_feature_local TVE_LEGACY
				#if defined (TVE_MOTION) //Motion
					#define TVE_ROTATION_BEND //Motion
				#endif //Motion
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
				#define SAMPLE_TEXTURE3D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
				#else//ASE Sampling Macros
				#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
				#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
				#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
				#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
				#define SAMPLE_TEXTURE3D_LOD(tex,samplerTex,coord,lod) tex3Dlod(tex,float4(coord,lod))
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
				uniform half _MotionCategory;
				uniform half _MotionEnd;
				uniform half _MotionFlowInfo;
				uniform half4 TVE_WindParams;
				uniform half _MotionFlowValue;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MotionNoiseTex);
				uniform half _MotionSmallPivotValue;
				uniform half _MotionSmallPhaseValue;
				uniform half _MotionSmallTillingValue;
				uniform half4 TVE_MotionTimeParams;
				uniform half _MotionSmallSpeedValue;
				uniform half _MotionSmallNoiseValue;
				uniform half _MotionFlowMode;
				uniform half4 TVE_WindEditor;
				uniform half _MotionIntensityValue;
				uniform half _MotionSmallDelayValue;
				uniform half _MotionSmallIntensityValue;
				uniform half _MotionSmallPushValue;
				uniform half _MotionSmallMaskMode;
				UNITY_DECLARE_TEX2D_NOSAMPLER(_MotionMaskTex);
				SamplerState sampler_MotionMaskTex;
				uniform half4 _MotionSmallMaskRemap;
				uniform half4 TVE_MotionValueParams;
				uniform half _MotionTinyTillingValue;
				uniform half _MotionTinySpeedValue;
				uniform half _MotionTinyNoiseValue;
				uniform half _MotionTinyIntensityValue;
				UNITY_DECLARE_TEX3D_NOSAMPLER(_NoiseTex3D);
				uniform half _MotionTinyMaskMode;
				uniform half4 _MotionTinyMaskRemap;
				uniform half _MotionDistValue;
				uniform half _MotionBasePivotValue;
				uniform half _MotionBasePhaseValue;
				uniform half _MotionBaseTillingValue;
				uniform half _MotionBaseSpeedValue;
				uniform half _MotionBaseNoiseValue;
				uniform half _MotionBaseIntensityValue;
				uniform half _MotionBaseDelayValue;
				uniform half _MotionBasePushValue;
				uniform half _MotionBaseMaskMode;
				uniform half4 _MotionBaseMaskRemap;
				uniform half _MotionHighlightValue;
				uniform half _motion_small_mode;
				uniform half4 _MotionHighlightColor;


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
				
				float SwitchChannel7( half Option, half4 ChannelA, half4 ChannelB )
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
					}
				}
				
				float2 DecodeFloatToVector2( float enc )
				{
					float2 result ;
					result.y = enc % 2048;
					result.x = floor(enc / 2048);
					return result / (2048 - 1);
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
					float localIfModelDataByShader26_g241959 = ( 0.0 );
					TVEModelData Data26_g241959 = (TVEModelData)0;
					TVEModelData Data16_g241856 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g241838 = _ObjectCoordMode;
					#else
					float staticSwitch343_g241838 = _ObjectCoordMode;
					#endif
					half Dummy207_g241838 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g241838 );
					float temp_output_14_0_g241856 = Dummy207_g241838;
					float In_Dummy16_g241856 = temp_output_14_0_g241856;
					float3 PositionOS131_g241838 = v.vertex.xyz;
					float3 temp_output_4_0_g241856 = PositionOS131_g241838;
					float3 In_PositionOS16_g241856 = temp_output_4_0_g241856;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g241838 = ase_positionWS;
					float3 vertexToFrag73_g241838 = temp_output_104_7_g241838;
					float3 PositionWS122_g241838 = vertexToFrag73_g241838;
					float3 In_PositionWS16_g241856 = PositionWS122_g241838;
					float4x4 break19_g241841 = unity_ObjectToWorld;
					float3 appendResult20_g241841 = (float3(break19_g241841[ 0 ][ 3 ] , break19_g241841[ 1 ][ 3 ] , break19_g241841[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241838 = appendResult20_g241841;
					float4x4 break19_g241843 = unity_ObjectToWorld;
					float3 appendResult20_g241843 = (float3(break19_g241843[ 0 ][ 3 ] , break19_g241843[ 1 ][ 3 ] , break19_g241843[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g241839 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g241838 = PositionOS131_g241838;
					float3 appendResult234_g241838 = (float3(break233_g241838.x , 0.0 , break233_g241838.z));
					float3 break413_g241838 = PositionOS131_g241838;
					float3 appendResult414_g241838 = (float3(break413_g241838.x , break413_g241838.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g241845 = appendResult414_g241838;
					#else
					float3 staticSwitch65_g241845 = appendResult234_g241838;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g241838 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g241838 = appendResult60_g241839;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g241838 = staticSwitch65_g241845;
					#else
					float3 staticSwitch229_g241838 = _Vector0;
					#endif
					float3 PivotOS149_g241838 = staticSwitch229_g241838;
					float3 temp_output_122_0_g241843 = PivotOS149_g241838;
					float3 PivotsOnlyWS105_g241843 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g241843 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g241838 = ( appendResult20_g241843 + PivotsOnlyWS105_g241843 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g241838 = temp_output_340_7_g241838;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g241838 = temp_output_341_7_g241838;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g241838 = temp_output_341_7_g241838;
					#else
					float3 staticSwitch236_g241838 = temp_output_340_7_g241838;
					#endif
					float3 vertexToFrag76_g241838 = staticSwitch236_g241838;
					float3 PivotWS121_g241838 = vertexToFrag76_g241838;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241838 = ( PositionWS122_g241838 - PivotWS121_g241838 );
					#else
					float3 staticSwitch204_g241838 = PositionWS122_g241838;
					#endif
					float3 PositionWO132_g241838 = ( staticSwitch204_g241838 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241856 = PositionWO132_g241838;
					float3 In_PivotOS16_g241856 = PivotOS149_g241838;
					float3 In_PivotWS16_g241856 = PivotWS121_g241838;
					float3 PivotWO133_g241838 = ( PivotWS121_g241838 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241856 = PivotWO133_g241838;
					half3 NormalOS134_g241838 = v.normal;
					float3 temp_output_21_0_g241856 = NormalOS134_g241838;
					float3 In_NormalOS16_g241856 = temp_output_21_0_g241856;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g241838 = normalizedWorldNormal;
					float3 In_NormalWS16_g241856 = NormalWS95_g241838;
					half4 TangentlOS153_g241838 = v.tangent;
					float4 temp_output_6_0_g241856 = TangentlOS153_g241838;
					float4 In_TangentOS16_g241856 = temp_output_6_0_g241856;
					float3 normalizeResult296_g241838 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241838 ) );
					half3 ViewDirWS169_g241838 = normalizeResult296_g241838;
					float3 In_ViewDirWS16_g241856 = ViewDirWS169_g241838;
					float4 appendResult397_g241838 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g241838 = appendResult397_g241838;
					float4 In_CoordsData16_g241856 = CoordsData398_g241838;
					half4 VertexMasks171_g241838 = v.ase_color;
					float4 In_VertexData16_g241856 = VertexMasks171_g241838;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241850 = (PositionOS131_g241838).z;
					#else
					float staticSwitch65_g241850 = (PositionOS131_g241838).y;
					#endif
					half Object_HeightValue267_g241838 = _ObjectHeightValue;
					half Bounds_HeightMask274_g241838 = saturate( ( staticSwitch65_g241850 / Object_HeightValue267_g241838 ) );
					half3 Position387_g241838 = PositionOS131_g241838;
					half Height387_g241838 = Object_HeightValue267_g241838;
					half Object_RadiusValue268_g241838 = _ObjectRadiusValue;
					half Radius387_g241838 = Object_RadiusValue268_g241838;
					half localCapsuleMaskYUp387_g241838 = CapsuleMaskYUp( Position387_g241838 , Height387_g241838 , Radius387_g241838 );
					half3 Position408_g241838 = PositionOS131_g241838;
					half Height408_g241838 = Object_HeightValue267_g241838;
					half Radius408_g241838 = Object_RadiusValue268_g241838;
					half localCapsuleMaskZUp408_g241838 = CapsuleMaskZUp( Position408_g241838 , Height408_g241838 , Radius408_g241838 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g241855 = saturate( localCapsuleMaskZUp408_g241838 );
					#else
					float staticSwitch65_g241855 = saturate( localCapsuleMaskYUp387_g241838 );
					#endif
					half Bounds_SphereMask282_g241838 = staticSwitch65_g241855;
					float4 appendResult253_g241838 = (float4(Bounds_HeightMask274_g241838 , Bounds_SphereMask282_g241838 , 1.0 , 1.0));
					half4 MasksData254_g241838 = appendResult253_g241838;
					float4 In_MasksData16_g241856 = MasksData254_g241838;
					float temp_output_17_0_g241849 = _ObjectPhaseMode;
					float Option70_g241849 = temp_output_17_0_g241849;
					float4 temp_output_3_0_g241849 = v.ase_color;
					float4 Channel70_g241849 = temp_output_3_0_g241849;
					float localSwitchChannel470_g241849 = SwitchChannel4( Option70_g241849 , Channel70_g241849 );
					half Phase_Value372_g241838 = localSwitchChannel470_g241849;
					float3 break319_g241838 = PivotWO133_g241838;
					half Pivot_Position322_g241838 = ( break319_g241838.x + break319_g241838.z );
					half Phase_Position357_g241838 = ( Phase_Value372_g241838 + Pivot_Position322_g241838 );
					float temp_output_248_0_g241838 = frac( Phase_Position357_g241838 );
					float4 appendResult177_g241838 = (float4((frac( ( Phase_Position357_g241838 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g241838));
					half4 Phase_Data176_g241838 = appendResult177_g241838;
					float4 In_PhaseData16_g241856 = Phase_Data176_g241838;
					BuildModelVertData( Data16_g241856 , In_Dummy16_g241856 , In_PositionOS16_g241856 , In_PositionWS16_g241856 , In_PositionWO16_g241856 , In_PivotOS16_g241856 , In_PivotWS16_g241856 , In_PivotWO16_g241856 , In_NormalOS16_g241856 , In_NormalWS16_g241856 , In_TangentOS16_g241856 , In_ViewDirWS16_g241856 , In_CoordsData16_g241856 , In_VertexData16_g241856 , In_MasksData16_g241856 , In_PhaseData16_g241856 );
					TVEModelData DataDefault26_g241959 = Data16_g241856;
					TVEModelData DataGeneral26_g241959 = Data16_g241856;
					TVEModelData DataBlanket26_g241959 = Data16_g241856;
					TVEModelData DataImpostor26_g241959 = Data16_g241856;
					TVEModelData Data16_g241836 =(TVEModelData)0;
					half Dummy207_g241818 = 0.0;
					float temp_output_14_0_g241836 = Dummy207_g241818;
					float In_Dummy16_g241836 = temp_output_14_0_g241836;
					float3 PositionOS131_g241818 = v.vertex.xyz;
					float3 temp_output_4_0_g241836 = PositionOS131_g241818;
					float3 In_PositionOS16_g241836 = temp_output_4_0_g241836;
					float3 temp_output_104_7_g241818 = ase_positionWS;
					float3 PositionWS122_g241818 = temp_output_104_7_g241818;
					float3 In_PositionWS16_g241836 = PositionWS122_g241818;
					float4x4 break19_g241821 = unity_ObjectToWorld;
					float3 appendResult20_g241821 = (float3(break19_g241821[ 0 ][ 3 ] , break19_g241821[ 1 ][ 3 ] , break19_g241821[ 2 ][ 3 ]));
					float3 temp_output_340_7_g241818 = appendResult20_g241821;
					float3 PivotWS121_g241818 = temp_output_340_7_g241818;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g241818 = ( PositionWS122_g241818 - PivotWS121_g241818 );
					#else
					float3 staticSwitch204_g241818 = PositionWS122_g241818;
					#endif
					float3 PositionWO132_g241818 = ( staticSwitch204_g241818 - TVE_WorldOrigin );
					float3 In_PositionWO16_g241836 = PositionWO132_g241818;
					float3 PivotOS149_g241818 = _Vector0;
					float3 In_PivotOS16_g241836 = PivotOS149_g241818;
					float3 In_PivotWS16_g241836 = PivotWS121_g241818;
					float3 PivotWO133_g241818 = ( PivotWS121_g241818 - TVE_WorldOrigin );
					float3 In_PivotWO16_g241836 = PivotWO133_g241818;
					half3 NormalOS134_g241818 = v.normal;
					float3 temp_output_21_0_g241836 = NormalOS134_g241818;
					float3 In_NormalOS16_g241836 = temp_output_21_0_g241836;
					half3 NormalWS95_g241818 = normalizedWorldNormal;
					float3 In_NormalWS16_g241836 = NormalWS95_g241818;
					float4 appendResult462_g241818 = (float4(cross( v.normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g241818 = appendResult462_g241818;
					float4 temp_output_6_0_g241836 = TangentlOS153_g241818;
					float4 In_TangentOS16_g241836 = temp_output_6_0_g241836;
					float3 normalizeResult296_g241818 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g241818 ) );
					half3 ViewDirWS169_g241818 = normalizeResult296_g241818;
					float3 In_ViewDirWS16_g241836 = ViewDirWS169_g241818;
					float4 appendResult397_g241818 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g241818 = appendResult397_g241818;
					float4 In_CoordsData16_g241836 = CoordsData398_g241818;
					half4 VertexMasks171_g241818 = float4( 0,0,0,0 );
					float4 In_VertexData16_g241836 = VertexMasks171_g241818;
					half4 MasksData254_g241818 = float4( 0,0,0,0 );
					float4 In_MasksData16_g241836 = MasksData254_g241818;
					half4 Phase_Data176_g241818 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g241836 = Phase_Data176_g241818;
					BuildModelVertData( Data16_g241836 , In_Dummy16_g241836 , In_PositionOS16_g241836 , In_PositionWS16_g241836 , In_PositionWO16_g241836 , In_PivotOS16_g241836 , In_PivotWS16_g241836 , In_PivotWO16_g241836 , In_NormalOS16_g241836 , In_NormalWS16_g241836 , In_TangentOS16_g241836 , In_ViewDirWS16_g241836 , In_CoordsData16_g241836 , In_VertexData16_g241836 , In_MasksData16_g241836 , In_PhaseData16_g241836 );
					TVEModelData DataTerrain26_g241959 = Data16_g241836;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g241959 = IsShaderType2637;
					{
					if (Type26_g241959 == 0 )
					{
					Data26_g241959 = DataDefault26_g241959;
					}
					else if (Type26_g241959 == 1 )
					{
					Data26_g241959 = DataGeneral26_g241959;
					}
					else if (Type26_g241959 == 2 )
					{
					Data26_g241959 = DataBlanket26_g241959;
					}
					else if (Type26_g241959 == 3 )
					{
					Data26_g241959 = DataImpostor26_g241959;
					}
					else if (Type26_g241959 == 4 )
					{
					Data26_g241959 = DataTerrain26_g241959;
					}
					}
					TVEModelData Data15_g251553 =(TVEModelData)Data26_g241959;
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
					TVEVertexData Data15_g251569 =(TVEVertexData)Data16_g251557;
					float Out_Dummy15_g251569 = 0.0;
					float3 Out_PositionOS15_g251569 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251569 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251569 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251569 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251569 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251569 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251569 , Out_Dummy15_g251569 , Out_PositionOS15_g251569 , Out_NormalOS15_g251569 , Out_TangentOS15_g251569 , Out_TransformData15_g251569 , Out_RotationData15_g251569 , Out_Interpolator15_g251569 );
					TVEVertexData Data16_g251570 =(TVEVertexData)Data15_g251569;
					half Dummy317_g251561 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g251570 = Dummy317_g251561;
					float3 In_PositionOS16_g251570 = Out_PositionOS15_g251569;
					float3 In_NormalOS16_g251570 = Out_NormalOS15_g251569;
					float4 In_TangentOS16_g251570 = Out_TangentOS15_g251569;
					half4 Model_TransformData356_g251561 = Out_TransformData15_g251569;
					float localBuildGlobalData204_g241858 = ( 0.0 );
					TVEGlobalData Data204_g241858 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g241858 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g241858 = Dummy211_g241858;
					float4 temp_output_203_0_g241877 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g241817 = ( 0.0 );
					TVEModelData Data26_g241817 = (TVEModelData)0;
					TVEModelData Data16_g241846 =(TVEModelData)0;
					float In_Dummy16_g241846 = 0.0;
					float3 In_PositionWS16_g241846 = PositionWS122_g241838;
					float3 In_PositionWO16_g241846 = PositionWO132_g241838;
					float3 In_PivotWS16_g241846 = PivotWS121_g241838;
					float3 In_PivotWO16_g241846 = PivotWO133_g241838;
					float3 In_NormalWS16_g241846 = NormalWS95_g241838;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g241838 = ase_tangentWS;
					float3 In_TangentWS16_g241846 = TangentWS136_g241838;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g241838 = ase_bitangentWS;
					float3 In_BitangentWS16_g241846 = BiangentWS421_g241838;
					half3 NormalWS427_g241838 = NormalWS95_g241838;
					half3 localComputeTriplanarMasks427_g241838 = ComputeTriplanarMasks( NormalWS427_g241838 );
					half3 TriplanarWeights429_g241838 = localComputeTriplanarMasks427_g241838;
					float3 In_TriplanarWeights16_g241846 = TriplanarWeights429_g241838;
					float3 In_ViewDirWS16_g241846 = ViewDirWS169_g241838;
					float4 In_CoordsData16_g241846 = CoordsData398_g241838;
					float4 In_VertexData16_g241846 = VertexMasks171_g241838;
					float4 In_Interpolator16_g241846 = Phase_Data176_g241838;
					BuildModelFragData( Data16_g241846 , In_Dummy16_g241846 , In_PositionWS16_g241846 , In_PositionWO16_g241846 , In_PivotWS16_g241846 , In_PivotWO16_g241846 , In_NormalWS16_g241846 , In_TangentWS16_g241846 , In_BitangentWS16_g241846 , In_TriplanarWeights16_g241846 , In_ViewDirWS16_g241846 , In_CoordsData16_g241846 , In_VertexData16_g241846 , In_Interpolator16_g241846 );
					TVEModelData DataDefault26_g241817 = Data16_g241846;
					TVEModelData DataGeneral26_g241817 = Data16_g241846;
					TVEModelData DataBlanket26_g241817 = Data16_g241846;
					TVEModelData DataImpostor26_g241817 = Data16_g241846;
					TVEModelData Data16_g241826 =(TVEModelData)0;
					float In_Dummy16_g241826 = 0.0;
					float3 In_PositionWS16_g241826 = PositionWS122_g241818;
					float3 In_PositionWO16_g241826 = PositionWO132_g241818;
					float3 In_PivotWS16_g241826 = PivotWS121_g241818;
					float3 In_PivotWO16_g241826 = PivotWO133_g241818;
					float3 In_NormalWS16_g241826 = NormalWS95_g241818;
					half3 TangentWS136_g241818 = ase_tangentWS;
					float3 In_TangentWS16_g241826 = TangentWS136_g241818;
					half3 BiangentWS421_g241818 = ase_bitangentWS;
					float3 In_BitangentWS16_g241826 = BiangentWS421_g241818;
					half3 NormalWS427_g241818 = NormalWS95_g241818;
					half3 localComputeTriplanarMasks427_g241818 = ComputeTriplanarMasks( NormalWS427_g241818 );
					half3 TriplanarWeights429_g241818 = localComputeTriplanarMasks427_g241818;
					float3 In_TriplanarWeights16_g241826 = TriplanarWeights429_g241818;
					float3 In_ViewDirWS16_g241826 = ViewDirWS169_g241818;
					float4 In_CoordsData16_g241826 = CoordsData398_g241818;
					float4 In_VertexData16_g241826 = VertexMasks171_g241818;
					float4 In_Interpolator16_g241826 = Phase_Data176_g241818;
					BuildModelFragData( Data16_g241826 , In_Dummy16_g241826 , In_PositionWS16_g241826 , In_PositionWO16_g241826 , In_PivotWS16_g241826 , In_PivotWO16_g241826 , In_NormalWS16_g241826 , In_TangentWS16_g241826 , In_BitangentWS16_g241826 , In_TriplanarWeights16_g241826 , In_ViewDirWS16_g241826 , In_CoordsData16_g241826 , In_VertexData16_g241826 , In_Interpolator16_g241826 );
					TVEModelData DataTerrain26_g241817 = Data16_g241826;
					float Type26_g241817 = IsShaderType2637;
					{
					if (Type26_g241817 == 0 )
					{
					Data26_g241817 = DataDefault26_g241817;
					}
					else if (Type26_g241817 == 1 )
					{
					Data26_g241817 = DataGeneral26_g241817;
					}
					else if (Type26_g241817 == 2 )
					{
					Data26_g241817 = DataBlanket26_g241817;
					}
					else if (Type26_g241817 == 3 )
					{
					Data26_g241817 = DataImpostor26_g241817;
					}
					else if (Type26_g241817 == 4 )
					{
					Data26_g241817 = DataTerrain26_g241817;
					}
					}
					TVEModelData Data15_g241948 =(TVEModelData)Data26_g241817;
					float Out_Dummy15_g241948 = 0.0;
					float3 Out_PositionWS15_g241948 = float3( 0,0,0 );
					float3 Out_PositionWO15_g241948 = float3( 0,0,0 );
					float3 Out_PivotWS15_g241948 = float3( 0,0,0 );
					float3 Out_PivotWO15_g241948 = float3( 0,0,0 );
					float3 Out_NormalWS15_g241948 = float3( 0,0,0 );
					float3 Out_TangentWS15_g241948 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g241948 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g241948 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g241948 = float3( 0,0,0 );
					float4 Out_CoordsData15_g241948 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g241948 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g241948 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g241948 , Out_Dummy15_g241948 , Out_PositionWS15_g241948 , Out_PositionWO15_g241948 , Out_PivotWS15_g241948 , Out_PivotWO15_g241948 , Out_NormalWS15_g241948 , Out_TangentWS15_g241948 , Out_BitangentWS15_g241948 , Out_TriplanarWeights15_g241948 , Out_ViewDirWS15_g241948 , Out_CoordsData15_g241948 , Out_VertexData15_g241948 , Out_Interpolator15_g241948 );
					float3 Model_PositionWS497_g241858 = Out_PositionWS15_g241948;
					float2 Model_PositionWS_XZ143_g241858 = (Model_PositionWS497_g241858).xz;
					float3 Model_PivotWS498_g241858 = Out_PivotWS15_g241948;
					float2 Model_PivotWS_XZ145_g241858 = (Model_PivotWS498_g241858).xz;
					float2 lerpResult300_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g241877 = lerpResult300_g241858;
					float temp_output_82_0_g241875 = _GlobalCoatLayerValue;
					float temp_output_82_0_g241877 = temp_output_82_0_g241875;
					float4 tex2DArrayNode83_g241877 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241877).zw + ( (temp_output_203_0_g241877).xy * temp_output_81_0_g241877 ) ),temp_output_82_0_g241877), 0.0 );
					float4 appendResult210_g241877 = (float4(tex2DArrayNode83_g241877.rgb , tex2DArrayNode83_g241877.a));
					float4 temp_output_204_0_g241877 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g241877 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241877).zw + ( (temp_output_204_0_g241877).xy * temp_output_81_0_g241877 ) ),temp_output_82_0_g241877), 0.0 );
					float4 appendResult212_g241877 = (float4(tex2DArrayNode122_g241877.rgb , tex2DArrayNode122_g241877.a));
					float4 TVE_RenderNearPositionR628_g241858 = TVE_RenderNearPositionR;
					float temp_output_507_0_g241858 = saturate( ( distance( Model_PositionWS497_g241858 , (TVE_RenderNearPositionR628_g241858).xyz ) / (TVE_RenderNearPositionR628_g241858).w ) );
					float temp_output_7_0_g241947 = 1.0;
					float temp_output_9_0_g241947 = ( temp_output_507_0_g241858 - temp_output_7_0_g241947 );
					half TVE_RenderNearFadeValue635_g241858 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g241858 = saturate( ( temp_output_9_0_g241947 / ( ( TVE_RenderNearFadeValue635_g241858 - temp_output_7_0_g241947 ) + 0.0001 ) ) );
					float4 lerpResult131_g241877 = lerp( appendResult210_g241877 , appendResult212_g241877 , Global_TexBlend509_g241858);
					float4 temp_output_159_109_g241875 = lerpResult131_g241877;
					float4 lerpResult168_g241875 = lerp( TVE_CoatParams , temp_output_159_109_g241875 , TVE_CoatLayers[(int)temp_output_82_0_g241875]);
					float4 temp_output_589_109_g241858 = lerpResult168_g241875;
					half4 Coat_Texture302_g241858 = temp_output_589_109_g241858;
					float4 In_CoatTexture204_g241858 = Coat_Texture302_g241858;
					half4 Draw_Texture656_g241858 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g241858 = Draw_Texture656_g241858;
					float4 temp_output_203_0_g241902 = TVE_PaintBaseCoord;
					float2 lerpResult85_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g241902 = lerpResult85_g241858;
					float temp_output_82_0_g241899 = _GlobalPaintLayerValue;
					float temp_output_82_0_g241902 = temp_output_82_0_g241899;
					float4 tex2DArrayNode83_g241902 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241902).zw + ( (temp_output_203_0_g241902).xy * temp_output_81_0_g241902 ) ),temp_output_82_0_g241902), 0.0 );
					float4 appendResult210_g241902 = (float4(tex2DArrayNode83_g241902.rgb , tex2DArrayNode83_g241902.a));
					float4 temp_output_204_0_g241902 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g241902 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241902).zw + ( (temp_output_204_0_g241902).xy * temp_output_81_0_g241902 ) ),temp_output_82_0_g241902), 0.0 );
					float4 appendResult212_g241902 = (float4(tex2DArrayNode122_g241902.rgb , tex2DArrayNode122_g241902.a));
					float4 lerpResult131_g241902 = lerp( appendResult210_g241902 , appendResult212_g241902 , Global_TexBlend509_g241858);
					float4 temp_output_171_109_g241899 = lerpResult131_g241902;
					float4 lerpResult174_g241899 = lerp( TVE_PaintParams , temp_output_171_109_g241899 , TVE_PaintLayers[(int)temp_output_82_0_g241899]);
					float4 temp_output_595_109_g241858 = lerpResult174_g241899;
					half4 Paint_Texture71_g241858 = temp_output_595_109_g241858;
					float4 In_PaintTexture204_g241858 = Paint_Texture71_g241858;
					float4 temp_output_203_0_g241885 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g241885 = lerpResult104_g241858;
					float temp_output_132_0_g241883 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g241885 = temp_output_132_0_g241883;
					float4 tex2DArrayNode83_g241885 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241885).zw + ( (temp_output_203_0_g241885).xy * temp_output_81_0_g241885 ) ),temp_output_82_0_g241885), 0.0 );
					float4 appendResult210_g241885 = (float4(tex2DArrayNode83_g241885.rgb , tex2DArrayNode83_g241885.a));
					float4 temp_output_204_0_g241885 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g241885 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241885).zw + ( (temp_output_204_0_g241885).xy * temp_output_81_0_g241885 ) ),temp_output_82_0_g241885), 0.0 );
					float4 appendResult212_g241885 = (float4(tex2DArrayNode122_g241885.rgb , tex2DArrayNode122_g241885.a));
					float4 lerpResult131_g241885 = lerp( appendResult210_g241885 , appendResult212_g241885 , Global_TexBlend509_g241858);
					float4 temp_output_137_109_g241883 = lerpResult131_g241885;
					float4 lerpResult145_g241883 = lerp( TVE_AtmoParams , temp_output_137_109_g241883 , TVE_AtmoLayers[(int)temp_output_132_0_g241883]);
					float4 temp_output_590_110_g241858 = lerpResult145_g241883;
					half4 Atmo_Texture80_g241858 = temp_output_590_110_g241858;
					float4 In_AtmoTexture204_g241858 = Atmo_Texture80_g241858;
					float4 temp_output_203_0_g241953 = TVE_EffexBaseCoord;
					float2 lerpResult414_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g241953 = lerpResult414_g241858;
					float temp_output_132_0_g241951 = _GlobalEffexLayerValue;
					float temp_output_82_0_g241953 = temp_output_132_0_g241951;
					float4 tex2DArrayNode83_g241953 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241953).zw + ( (temp_output_203_0_g241953).xy * temp_output_81_0_g241953 ) ),temp_output_82_0_g241953), 0.0 );
					float4 appendResult210_g241953 = (float4(tex2DArrayNode83_g241953.rgb , tex2DArrayNode83_g241953.a));
					float4 temp_output_204_0_g241953 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g241953 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241953).zw + ( (temp_output_204_0_g241953).xy * temp_output_81_0_g241953 ) ),temp_output_82_0_g241953), 0.0 );
					float4 appendResult212_g241953 = (float4(tex2DArrayNode122_g241953.rgb , tex2DArrayNode122_g241953.a));
					float4 lerpResult131_g241953 = lerp( appendResult210_g241953 , appendResult212_g241953 , Global_TexBlend509_g241858);
					float4 temp_output_137_109_g241951 = lerpResult131_g241953;
					float4 lerpResult145_g241951 = lerp( TVE_EffexParams , temp_output_137_109_g241951 , TVE_EffexLayers[(int)temp_output_132_0_g241951]);
					float4 temp_output_731_110_g241858 = lerpResult145_g241951;
					half4 Effex_Texture420_g241858 = temp_output_731_110_g241858;
					float4 In_EffexTexture204_g241858 = Effex_Texture420_g241858;
					float4 temp_output_203_0_g241933 = TVE_GlowBaseCoord;
					float2 lerpResult247_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g241933 = lerpResult247_g241858;
					float temp_output_82_0_g241931 = _GlobalGlowLayerValue;
					float temp_output_82_0_g241933 = temp_output_82_0_g241931;
					float4 tex2DArrayNode83_g241933 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241933).zw + ( (temp_output_203_0_g241933).xy * temp_output_81_0_g241933 ) ),temp_output_82_0_g241933), 0.0 );
					float4 appendResult210_g241933 = (float4(tex2DArrayNode83_g241933.rgb , tex2DArrayNode83_g241933.a));
					float4 temp_output_204_0_g241933 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g241933 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241933).zw + ( (temp_output_204_0_g241933).xy * temp_output_81_0_g241933 ) ),temp_output_82_0_g241933), 0.0 );
					float4 appendResult212_g241933 = (float4(tex2DArrayNode122_g241933.rgb , tex2DArrayNode122_g241933.a));
					float4 lerpResult131_g241933 = lerp( appendResult210_g241933 , appendResult212_g241933 , Global_TexBlend509_g241858);
					float4 temp_output_159_109_g241931 = lerpResult131_g241933;
					float4 lerpResult167_g241931 = lerp( TVE_GlowParams , temp_output_159_109_g241931 , TVE_GlowLayers[(int)temp_output_82_0_g241931]);
					float4 temp_output_593_109_g241858 = lerpResult167_g241931;
					half4 Glow_Texture248_g241858 = temp_output_593_109_g241858;
					float4 In_GlowTexture204_g241858 = Glow_Texture248_g241858;
					float4 temp_output_203_0_g241869 = TVE_FormBaseCoord;
					float2 lerpResult168_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g241869 = lerpResult168_g241858;
					float temp_output_130_0_g241867 = _GlobalFormLayerValue;
					float temp_output_82_0_g241869 = temp_output_130_0_g241867;
					float4 tex2DArrayNode83_g241869 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241869).zw + ( (temp_output_203_0_g241869).xy * temp_output_81_0_g241869 ) ),temp_output_82_0_g241869), 0.0 );
					float4 appendResult210_g241869 = (float4(tex2DArrayNode83_g241869.rgb , tex2DArrayNode83_g241869.a));
					float4 temp_output_204_0_g241869 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g241869 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241869).zw + ( (temp_output_204_0_g241869).xy * temp_output_81_0_g241869 ) ),temp_output_82_0_g241869), 0.0 );
					float4 appendResult212_g241869 = (float4(tex2DArrayNode122_g241869.rgb , tex2DArrayNode122_g241869.a));
					float4 lerpResult131_g241869 = lerp( appendResult210_g241869 , appendResult212_g241869 , Global_TexBlend509_g241858);
					float4 temp_output_135_109_g241867 = lerpResult131_g241869;
					float4 lerpResult143_g241867 = lerp( TVE_FormParams , temp_output_135_109_g241867 , TVE_FormLayers[(int)temp_output_130_0_g241867]);
					float4 temp_output_592_0_g241858 = lerpResult143_g241867;
					float4 Form_Texture112_g241858 = temp_output_592_0_g241858;
					float4 In_FormTexture204_g241858 = Form_Texture112_g241858;
					float4 In_LandTexture204_g241858 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g241917 = TVE_VertxBaseCoord;
					float2 lerpResult681_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g241917 = lerpResult681_g241858;
					float temp_output_136_0_g241915 = _GlobalVertxLayerValue;
					float temp_output_82_0_g241917 = temp_output_136_0_g241915;
					float4 tex2DArrayNode83_g241917 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241917).zw + ( (temp_output_203_0_g241917).xy * temp_output_81_0_g241917 ) ),temp_output_82_0_g241917), 0.0 );
					float4 appendResult210_g241917 = (float4(tex2DArrayNode83_g241917.rgb , tex2DArrayNode83_g241917.a));
					float4 temp_output_204_0_g241917 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g241917 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241917).zw + ( (temp_output_204_0_g241917).xy * temp_output_81_0_g241917 ) ),temp_output_82_0_g241917), 0.0 );
					float4 appendResult212_g241917 = (float4(tex2DArrayNode122_g241917.rgb , tex2DArrayNode122_g241917.a));
					float4 lerpResult131_g241917 = lerp( appendResult210_g241917 , appendResult212_g241917 , Global_TexBlend509_g241858);
					float4 temp_output_141_109_g241915 = lerpResult131_g241917;
					float4 lerpResult149_g241915 = lerp( TVE_VertxParams , temp_output_141_109_g241915 , TVE_VertxLayers[(int)temp_output_136_0_g241915]);
					float4 temp_output_695_0_g241858 = lerpResult149_g241915;
					half4 Vertx_Texture693_g241858 = temp_output_695_0_g241858;
					float4 In_VertxTexture204_g241858 = Vertx_Texture693_g241858;
					float4 temp_output_203_0_g241893 = TVE_FlowBaseCoord;
					float2 lerpResult400_g241858 = lerp( Model_PositionWS_XZ143_g241858 , Model_PivotWS_XZ145_g241858 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g241893 = lerpResult400_g241858;
					float temp_output_136_0_g241891 = _GlobalFlowLayerValue;
					float temp_output_82_0_g241893 = temp_output_136_0_g241891;
					float4 tex2DArrayNode83_g241893 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g241893).zw + ( (temp_output_203_0_g241893).xy * temp_output_81_0_g241893 ) ),temp_output_82_0_g241893), 0.0 );
					float4 appendResult210_g241893 = (float4(tex2DArrayNode83_g241893.rgb , tex2DArrayNode83_g241893.a));
					float4 temp_output_204_0_g241893 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g241893 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g241893).zw + ( (temp_output_204_0_g241893).xy * temp_output_81_0_g241893 ) ),temp_output_82_0_g241893), 0.0 );
					float4 appendResult212_g241893 = (float4(tex2DArrayNode122_g241893.rgb , tex2DArrayNode122_g241893.a));
					float4 lerpResult131_g241893 = lerp( appendResult210_g241893 , appendResult212_g241893 , Global_TexBlend509_g241858);
					float4 temp_output_141_109_g241891 = lerpResult131_g241893;
					float4 lerpResult149_g241891 = lerp( TVE_FlowParams , temp_output_141_109_g241891 , TVE_FlowLayers[(int)temp_output_136_0_g241891]);
					float4 temp_output_594_0_g241858 = lerpResult149_g241891;
					half4 Flow_Texture405_g241858 = temp_output_594_0_g241858;
					float4 In_FlowTexture204_g241858 = Flow_Texture405_g241858;
					half4 User_Texture677_g241858 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g241858 = User_Texture677_g241858;
					BuildGlobalData( Data204_g241858 , In_Dummy204_g241858 , In_CoatTexture204_g241858 , In_DrawTexture204_g241858 , In_PaintTexture204_g241858 , In_AtmoTexture204_g241858 , In_EffexTexture204_g241858 , In_GlowTexture204_g241858 , In_FormTexture204_g241858 , In_LandTexture204_g241858 , In_VertxTexture204_g241858 , In_FlowTexture204_g241858 , In_UserTexture204_g241858 );
					TVEGlobalData Data15_g251571 =(TVEGlobalData)Data204_g241858;
					float Out_Dummy15_g251571 = 0.0;
					float4 Out_CoatTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251571 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251571 = float4( 0,0,0,0 );
					BreakData( Data15_g251571 , Out_Dummy15_g251571 , Out_CoatTexture15_g251571 , Out_DrawTexture15_g251571 , Out_PaintTexture15_g251571 , Out_AtmoTexture15_g251571 , Out_EffexTexture15_g251571 , Out_GlowTexture15_g251571 , Out_FormTexture15_g251571 , Out_LandTexture15_g251571 , Out_VertxTexture15_g251571 , Out_FlowTexture15_g251571 , Out_UserTexture15_g251571 );
					float4 Global_FormTexture351_g251561 = Out_FormTexture15_g251571;
					TVEModelData Data15_g251568 =(TVEModelData)Data15_g251556;
					float Out_Dummy15_g251568 = 0.0;
					float3 Out_PositionOS15_g251568 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251568 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251568 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251568 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251568 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251568 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251568 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251568 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251568 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251568 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251568 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251568 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251568 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251568 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251568 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251568 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251568 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251568 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251568 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251568 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251568 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251568 , Out_Dummy15_g251568 , Out_PositionOS15_g251568 , Out_PositionWS15_g251568 , Out_PositionWO15_g251568 , Out_PositionRawOS15_g251568 , Out_PivotOS15_g251568 , Out_PivotWS15_g251568 , Out_PivotWO15_g251568 , Out_NormalOS15_g251568 , Out_NormalWS15_g251568 , Out_NormalRawOS15_g251568 , Out_TangentOS15_g251568 , Out_TangentWS15_g251568 , Out_BitangentWS15_g251568 , Out_ViewDirWS15_g251568 , Out_CoordsData15_g251568 , Out_VertexData15_g251568 , Out_MasksData15_g251568 , Out_PhaseData15_g251568 , Out_TransformData15_g251568 , Out_RotationData15_g251568 , Out_Interpolator15_g251568 );
					float3 Model_PivotWO353_g251561 = Out_PivotWO15_g251568;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g251567 = _ConformMeshMode;
					float Option70_g251567 = temp_output_17_0_g251567;
					half4 Model_VertexData357_g251561 = Out_VertexData15_g251568;
					float4 temp_output_3_0_g251567 = Model_VertexData357_g251561;
					float4 Channel70_g251567 = temp_output_3_0_g251567;
					float localSwitchChannel470_g251567 = SwitchChannel4( Option70_g251567 , Channel70_g251567 );
					float temp_output_390_0_g251561 = localSwitchChannel470_g251567;
					float temp_output_7_0_g251564 = _ConformMeshRemap.x;
					float temp_output_9_0_g251564 = ( temp_output_390_0_g251561 - temp_output_7_0_g251564 );
					float lerpResult374_g251561 = lerp( 1.0 , saturate( ( temp_output_9_0_g251564 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g251561 = lerpResult374_g251561;
					float temp_output_328_0_g251561 = ( Blend_VertMask379_g251561 * TVE_IsEnabled );
					half Conform_Mask366_g251561 = temp_output_328_0_g251561;
					float temp_output_322_0_g251561 = ( ( ( ( (Global_FormTexture351_g251561).z - ( (Model_PivotWO353_g251561).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g251561 ) );
					float3 appendResult329_g251561 = (float3(0.0 , temp_output_322_0_g251561 , 0.0));
					float3 appendResult387_g251561 = (float3(0.0 , 0.0 , temp_output_322_0_g251561));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251565 = appendResult387_g251561;
					#else
					float3 staticSwitch65_g251565 = appendResult329_g251561;
					#endif
					float3 Blanket_Conform368_g251561 = staticSwitch65_g251565;
					float4 appendResult312_g251561 = (float4(Blanket_Conform368_g251561 , 0.0));
					float4 temp_output_310_0_g251561 = ( Model_TransformData356_g251561 + appendResult312_g251561 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g251561 = temp_output_310_0_g251561;
					#else
					float4 staticSwitch364_g251561 = Model_TransformData356_g251561;
					#endif
					half4 Final_TransformData365_g251561 = staticSwitch364_g251561;
					float4 In_TransformData16_g251570 = Final_TransformData365_g251561;
					float4 In_RotationData16_g251570 = Out_RotationData15_g251569;
					float4 In_Interpolator16_g251570 = Out_Interpolator15_g251569;
					BuildVertexData( Data16_g251570 , In_Dummy16_g251570 , In_PositionOS16_g251570 , In_NormalOS16_g251570 , In_TangentOS16_g251570 , In_TransformData16_g251570 , In_RotationData16_g251570 , In_Interpolator16_g251570 );
					TVEVertexData Data15_g251653 =(TVEVertexData)Data16_g251570;
					float Out_Dummy15_g251653 = 0.0;
					float3 Out_PositionOS15_g251653 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251653 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251653 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251653 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251653 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251653 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251653 , Out_Dummy15_g251653 , Out_PositionOS15_g251653 , Out_NormalOS15_g251653 , Out_TangentOS15_g251653 , Out_TransformData15_g251653 , Out_RotationData15_g251653 , Out_Interpolator15_g251653 );
					TVEVertexData Data16_g251654 =(TVEVertexData)Data15_g251653;
					half Dummy181_g251640 = ( ( _MotionCategory + _MotionEnd ) + _MotionFlowInfo );
					float In_Dummy16_g251654 = Dummy181_g251640;
					float3 temp_output_3325_0_g251640 = Out_PositionOS15_g251653;
					float3 In_PositionOS16_g251654 = temp_output_3325_0_g251640;
					float3 In_NormalOS16_g251654 = Out_NormalOS15_g251653;
					float4 In_TangentOS16_g251654 = Out_TangentOS15_g251653;
					half4 Vertex_TransformData2743_g251640 = Out_TransformData15_g251653;
					float3 temp_cast_13 = (0.0).xxx;
					half Motion_FlowValue3376_g251640 = _MotionFlowValue;
					float2 lerpResult3361_g251640 = lerp( (half4( 1, 1, 1, 0 )).xy , (TVE_WindParams).xy , ( Motion_FlowValue3376_g251640 * TVE_IsEnabled ));
					float2 Global_WindDirWS2542_g251640 = (lerpResult3361_g251640*2.0 + -1.0);
					half2 Input_WindDirWS803_g251687 = Global_WindDirWS2542_g251640;
					TVEModelData Data15_g251652 =(TVEModelData)Data15_g251568;
					float Out_Dummy15_g251652 = 0.0;
					float3 Out_PositionOS15_g251652 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251652 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251652 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251652 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251652 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251652 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251652 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251652 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251652 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251652 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251652 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251652 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251652 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251652 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251652 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251652 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251652 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251652 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251652 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251652 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251652 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251652 , Out_Dummy15_g251652 , Out_PositionOS15_g251652 , Out_PositionWS15_g251652 , Out_PositionWO15_g251652 , Out_PositionRawOS15_g251652 , Out_PivotOS15_g251652 , Out_PivotWS15_g251652 , Out_PivotWO15_g251652 , Out_NormalOS15_g251652 , Out_NormalWS15_g251652 , Out_NormalRawOS15_g251652 , Out_TangentOS15_g251652 , Out_TangentWS15_g251652 , Out_BitangentWS15_g251652 , Out_ViewDirWS15_g251652 , Out_CoordsData15_g251652 , Out_VertexData15_g251652 , Out_MasksData15_g251652 , Out_PhaseData15_g251652 , Out_TransformData15_g251652 , Out_RotationData15_g251652 , Out_Interpolator15_g251652 );
					float3 Model_PositionWO162_g251640 = Out_PositionWO15_g251652;
					half3 Input_ModelPositionWO761_g251650 = Model_PositionWO162_g251640;
					float3 Model_PivotWO402_g251640 = Out_PivotWO15_g251652;
					half3 Input_ModelPivotsWO419_g251650 = Model_PivotWO402_g251640;
					half Input_MotionPivots629_g251650 = _MotionSmallPivotValue;
					float3 lerpResult771_g251650 = lerp( Input_ModelPositionWO761_g251650 , Input_ModelPivotsWO419_g251650 , Input_MotionPivots629_g251650);
					half4 Model_PhaseData489_g251640 = Out_PhaseData15_g251652;
					half4 Input_ModelMotionData763_g251650 = Model_PhaseData489_g251640;
					half Input_MotionPhase764_g251650 = _MotionSmallPhaseValue;
					float temp_output_770_0_g251650 = ( (Input_ModelMotionData763_g251650).x * Input_MotionPhase764_g251650 );
					half3 Small_Position1421_g251640 = ( lerpResult771_g251650 + temp_output_770_0_g251650 );
					half3 Input_PositionWO419_g251687 = Small_Position1421_g251640;
					half Input_MotionTilling321_g251687 = ( _MotionSmallTillingValue + 0.2 );
					half2 Noise_Coord979_g251687 = ( -(Input_PositionWO419_g251687).xz * Input_MotionTilling321_g251687 * 0.005 );
					float2 Input_Coords80_g251691 = Noise_Coord979_g251687;
					half2 Input_Direction82_g251691 = Input_WindDirWS803_g251687;
					float mulTime113_g251705 = _Time.y * 0.02;
					float lerpResult128_g251705 = lerp( mulTime113_g251705 , ( ( mulTime113_g251705 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					#ifdef SHADER_API_MOBILE
					float staticSwitch134_g251705 = frac( lerpResult128_g251705 );
					#else
					float staticSwitch134_g251705 = lerpResult128_g251705;
					#endif
					float Global_WindTime3262_g251640 = staticSwitch134_g251705;
					half Input_WindTime1015_g251687 = Global_WindTime3262_g251640;
					half Input_MotionSpeed62_g251687 = _MotionSmallSpeedValue;
					float temp_output_986_0_g251687 = ( Input_WindTime1015_g251687 * Input_MotionSpeed62_g251687 );
					half Noise_Speed980_g251687 = temp_output_986_0_g251687;
					float Input_Time88_g251691 = Noise_Speed980_g251687;
					float temp_output_23_0_g251691 = frac( Input_Time88_g251691 );
					float4 lerpResult39_g251691 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251691 + ( Input_Direction82_g251691 * temp_output_23_0_g251691 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251691 + ( Input_Direction82_g251691 * ( temp_output_23_0_g251691 - 1.0 ) ) ), 0.0 ) , temp_output_23_0_g251691);
					float4 temp_output_991_0_g251687 = lerpResult39_g251691;
					half2 Noise_DirWS858_g251687 = ((temp_output_991_0_g251687).rg*2.0 + -1.0);
					half Input_MotionNoise552_g251687 = _MotionSmallNoiseValue;
					float4 temp_output_3332_0_g251640 = TVE_FlowParams;
					TVEGlobalData Data15_g251666 =(TVEGlobalData)Data15_g251571;
					float Out_Dummy15_g251666 = 0.0;
					float4 Out_CoatTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g251666 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g251666 = float4( 0,0,0,0 );
					BreakData( Data15_g251666 , Out_Dummy15_g251666 , Out_CoatTexture15_g251666 , Out_DrawTexture15_g251666 , Out_PaintTexture15_g251666 , Out_AtmoTexture15_g251666 , Out_EffexTexture15_g251666 , Out_GlowTexture15_g251666 , Out_FormTexture15_g251666 , Out_LandTexture15_g251666 , Out_VertxTexture15_g251666 , Out_FlowTexture15_g251666 , Out_UserTexture15_g251666 );
					half4 Global_FlowTexture2668_g251640 = Out_FlowTexture15_g251666;
					#ifdef TVE_MOTION_FLOW
					float4 staticSwitch3075_g251640 = Global_FlowTexture2668_g251640;
					#else
					float4 staticSwitch3075_g251640 = temp_output_3332_0_g251640;
					#endif
					float4 temp_output_6_0_g251667 = staticSwitch3075_g251640;
					float temp_output_7_0_g251667 = _MotionFlowMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g251667 = ( temp_output_6_0_g251667 + temp_output_7_0_g251667 );
					#else
					float4 staticSwitch14_g251667 = temp_output_6_0_g251667;
					#endif
					float4 lerpResult3121_g251640 = lerp( half4( 1, 1, 1, 0 ) , staticSwitch14_g251667 , ( Motion_FlowValue3376_g251640 * TVE_IsEnabled ));
					float temp_output_3077_0_g251640 = (lerpResult3121_g251640).z;
					float temp_output_630_0_g251676 = temp_output_3077_0_g251640;
					float lerpResult853_g251676 = lerp( temp_output_630_0_g251676 , TVE_WindEditor.z , TVE_WindEditor.w);
					half Global_WindValue1855_g251640 = ( lerpResult853_g251676 * _MotionIntensityValue );
					half Input_WindValue881_g251687 = Global_WindValue1855_g251640;
					float temp_output_6_0_g251689 = Input_WindValue881_g251687;
					float lerpResult701_g251687 = lerp( 1.0 , Input_MotionNoise552_g251687 , ( temp_output_6_0_g251689 * temp_output_6_0_g251689 ));
					float2 lerpResult646_g251687 = lerp( Input_WindDirWS803_g251687 , Noise_DirWS858_g251687 , lerpResult701_g251687);
					half2 Small_DirWS817_g251687 = lerpResult646_g251687;
					float2 break823_g251687 = Small_DirWS817_g251687;
					half4 Noise_Params685_g251687 = temp_output_991_0_g251687;
					half Wind_Sinus820_g251687 = ( ((Noise_Params685_g251687).b*2.0 + -1.0) * 0.6 );
					float3 appendResult824_g251687 = (float3(break823_g251687.x , Wind_Sinus820_g251687 , break823_g251687.y));
					half3 Small_Dir918_g251687 = appendResult824_g251687;
					float temp_output_20_0_g251688 = ( 1.0 - Input_WindValue881_g251687 );
					float3 appendResult1006_g251687 = (float3(Input_WindValue881_g251687 , ( 1.0 - ( temp_output_20_0_g251688 * temp_output_20_0_g251688 ) ) , Input_WindValue881_g251687));
					half Input_MotionDelay753_g251687 = _MotionSmallDelayValue;
					float lerpResult756_g251687 = lerp( 1.0 , ( Input_WindValue881_g251687 * Input_WindValue881_g251687 ) , Input_MotionDelay753_g251687);
					half Wind_Delay815_g251687 = lerpResult756_g251687;
					half Input_MotionValue905_g251687 = _MotionSmallIntensityValue;
					float3 temp_output_883_0_g251687 = ( Small_Dir918_g251687 * appendResult1006_g251687 * Wind_Delay815_g251687 * Input_MotionValue905_g251687 );
					float2 break857_g251687 = Noise_DirWS858_g251687;
					float3 appendResult833_g251687 = (float3(break857_g251687.x , Wind_Sinus820_g251687 , break857_g251687.y));
					half3 Push_Dir919_g251687 = appendResult833_g251687;
					half Input_MotionReact924_g251687 = _MotionSmallPushValue;
					half Global_PushAlpha1504_g251640 = (lerpResult3121_g251640).w;
					half Input_PushAlpha806_g251687 = Global_PushAlpha1504_g251640;
					half Global_PushNoise2675_g251640 = temp_output_3077_0_g251640;
					half Input_PushNoise890_g251687 = Global_PushNoise2675_g251640;
					half Push_Mask914_g251687 = saturate( ( Input_PushAlpha806_g251687 * Input_PushNoise890_g251687 * Input_MotionReact924_g251687 ) );
					float3 lerpResult840_g251687 = lerp( temp_output_883_0_g251687 , ( Push_Dir919_g251687 * Input_MotionReact924_g251687 ) , Push_Mask914_g251687);
					#ifdef TVE_MOTION_FLOW
					float3 staticSwitch829_g251687 = lerpResult840_g251687;
					#else
					float3 staticSwitch829_g251687 = temp_output_883_0_g251687;
					#endif
					float3 ase_parentObjectScale = ( 1.0 / float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ) );
					half3 Small_Squash1489_g251640 = ( mul( unity_WorldToObject, float4( staticSwitch829_g251687 , 0.0 ) ).xyz * ase_parentObjectScale );
					float temp_output_17_0_g251655 = _MotionSmallMaskMode;
					float Option92_g251655 = temp_output_17_0_g251655;
					half4 Model_VertexMasks518_g251640 = Out_VertexData15_g251652;
					float4 temp_output_84_0_g251655 = Model_VertexMasks518_g251640;
					float4 ChannelA92_g251655 = temp_output_84_0_g251655;
					half4 Model_MasksData1322_g251640 = Out_MasksData15_g251652;
					float2 uv_MotionMaskTex2818_g251640 = v.ase_texcoord.xy;
					half4 Motion_MaskTex2819_g251640 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex2818_g251640, 0.0 );
					float3 appendResult3227_g251640 = (float3((Model_MasksData1322_g251640).xy , (Motion_MaskTex2819_g251640).g));
					float3 temp_output_85_0_g251655 = appendResult3227_g251640;
					float4 ChannelB92_g251655 = float4( temp_output_85_0_g251655 , 0.0 );
					float localSwitchChannel792_g251655 = SwitchChannel7( Option92_g251655 , ChannelA92_g251655 , ChannelB92_g251655 );
					float enc1805_g251640 = v.ase_texcoord.z;
					float2 localDecodeFloatToVector21805_g251640 = DecodeFloatToVector2( enc1805_g251640 );
					float2 break1804_g251640 = localDecodeFloatToVector21805_g251640;
					half Small_Mask_Legacy1806_g251640 = break1804_g251640.x;
					#ifdef TVE_LEGACY
					float staticSwitch1800_g251640 = Small_Mask_Legacy1806_g251640;
					#else
					float staticSwitch1800_g251640 = localSwitchChannel792_g251655;
					#endif
					float clampResult17_g251641 = clamp( staticSwitch1800_g251640 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251642 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g251642 = ( clampResult17_g251641 - temp_output_7_0_g251642 );
					half Small_Mask640_g251640 = saturate( ( temp_output_9_0_g251642 * _MotionSmallMaskRemap.z ) );
					float3 lerpResult3022_g251640 = lerp( float3( 1,1,1 ) , (TVE_MotionValueParams).xyz , TVE_MotionValueParams.w);
					half3 Global_MotionParams3013_g251640 = lerpResult3022_g251640;
					half3 Small_Motion789_g251640 = ( Small_Squash1489_g251640 * Small_Mask640_g251640 * (Global_MotionParams3013_g251640).y );
					#ifdef TVE_MOTION
					float3 staticSwitch495_g251640 = Small_Motion789_g251640;
					#else
					float3 staticSwitch495_g251640 = temp_cast_13;
					#endif
					float3 temp_cast_17 = (0.0).xxx;
					half3 Tiny_Position2469_g251640 = Model_PositionWO162_g251640;
					half3 Input_PositionWO419_g251706 = Tiny_Position2469_g251640;
					half Input_MotionTilling321_g251706 = ( _MotionTinyTillingValue + 0.2 );
					half2 Noise_Coord979_g251706 = ( -(Input_PositionWO419_g251706).xz * Input_MotionTilling321_g251706 * 0.005 );
					float2 Input_Coords80_g251713 = Noise_Coord979_g251706;
					half2 Input_Direction82_g251713 = float2( 0,1 );
					half Input_WindTime1015_g251706 = Global_WindTime3262_g251640;
					half Input_MotionSpeed62_g251706 = _MotionTinySpeedValue;
					float temp_output_986_0_g251706 = ( Input_WindTime1015_g251706 * Input_MotionSpeed62_g251706 );
					half Noise_Speed980_g251706 = temp_output_986_0_g251706;
					float Input_Time88_g251713 = Noise_Speed980_g251706;
					float4 temp_output_991_0_g251706 = SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251713 + ( Input_Direction82_g251713 * Input_Time88_g251713 ) ), 0.0 );
					half3 Noise_DirWS858_g251706 = ((temp_output_991_0_g251706).rgb*2.0 + -1.0);
					half Input_MotionNoise552_g251706 = _MotionTinyNoiseValue;
					float3 lerpResult646_g251706 = lerp( ( Noise_DirWS858_g251706 * v.normal ) , Noise_DirWS858_g251706 , Input_MotionNoise552_g251706);
					half3 Tiny_DirWS817_g251706 = lerpResult646_g251706;
					half Input_MotionValue905_g251706 = _MotionTinyIntensityValue;
					float mulTime113_g251719 = _Time.y * 2.0;
					float lerpResult128_g251719 = lerp( mulTime113_g251719 , ( ( mulTime113_g251719 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					#ifdef SHADER_API_MOBILE
					float staticSwitch134_g251719 = frac( lerpResult128_g251719 );
					#else
					float staticSwitch134_g251719 = lerpResult128_g251719;
					#endif
					float3 temp_output_1028_0_g251706 = ( Input_PositionWO419_g251706 + staticSwitch134_g251719 );
					float temp_output_1054_0_g251706 = SAMPLE_TEXTURE3D_LOD( _NoiseTex3D, sampler_Linear_Repeat, ( temp_output_1028_0_g251706 * ( 1.0 * 0.01 ) ), 0.0 ).r;
					float temp_output_6_0_g251709 = temp_output_1054_0_g251706;
					float temp_output_6_0_g251710 = temp_output_1054_0_g251706;
					half Input_WindValue881_g251706 = Global_WindValue1855_g251640;
					float temp_output_6_0_g251712 = Input_WindValue881_g251706;
					float lerpResult1029_g251706 = lerp( ( temp_output_6_0_g251709 * temp_output_6_0_g251709 * temp_output_6_0_g251709 * temp_output_6_0_g251709 ) , ( temp_output_6_0_g251710 * temp_output_6_0_g251710 ) , ( temp_output_6_0_g251712 * temp_output_6_0_g251712 ));
					float temp_output_20_0_g251711 = ( 1.0 - Input_WindValue881_g251706 );
					float temp_output_1030_0_g251706 = ( lerpResult1029_g251706 * ( 1.0 - ( temp_output_20_0_g251711 * temp_output_20_0_g251711 * temp_output_20_0_g251711 * temp_output_20_0_g251711 ) ) );
					half Wind_Gust1039_g251706 = temp_output_1030_0_g251706;
					float3 temp_output_883_0_g251706 = ( Tiny_DirWS817_g251706 * Input_MotionValue905_g251706 * Wind_Gust1039_g251706 );
					half3 Tiny_Squash859_g251640 = temp_output_883_0_g251706;
					float temp_output_17_0_g251656 = _MotionTinyMaskMode;
					float Option92_g251656 = temp_output_17_0_g251656;
					float4 temp_output_84_0_g251656 = Model_VertexMasks518_g251640;
					float4 ChannelA92_g251656 = temp_output_84_0_g251656;
					float3 appendResult3234_g251640 = (float3((Model_MasksData1322_g251640).xy , (Motion_MaskTex2819_g251640).b));
					float3 temp_output_85_0_g251656 = appendResult3234_g251640;
					float4 ChannelB92_g251656 = float4( temp_output_85_0_g251656 , 0.0 );
					float localSwitchChannel792_g251656 = SwitchChannel7( Option92_g251656 , ChannelA92_g251656 , ChannelB92_g251656 );
					half Tiny_Mask_Legacy1807_g251640 = break1804_g251640.y;
					#ifdef TVE_LEGACY
					float staticSwitch1810_g251640 = Tiny_Mask_Legacy1807_g251640;
					#else
					float staticSwitch1810_g251640 = localSwitchChannel792_g251656;
					#endif
					float clampResult17_g251643 = clamp( staticSwitch1810_g251640 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251644 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g251644 = ( clampResult17_g251643 - temp_output_7_0_g251644 );
					half Tiny_Mask218_g251640 = saturate( ( temp_output_9_0_g251644 * _MotionTinyMaskRemap.z ) );
					float3 Model_PositionWS1819_g251640 = Out_PositionWS15_g251652;
					half Global_DistMask1820_g251640 = ( 1.0 - saturate( ( distance( _WorldSpaceCameraPos , Model_PositionWS1819_g251640 ) / _MotionDistValue ) ) );
					half3 Tiny_Flutter1451_g251640 = ( Tiny_Squash859_g251640 * Tiny_Mask218_g251640 * Global_DistMask1820_g251640 * (Global_MotionParams3013_g251640).z );
					#ifdef TVE_MOTION
					float3 staticSwitch414_g251640 = Tiny_Flutter1451_g251640;
					#else
					float3 staticSwitch414_g251640 = temp_cast_17;
					#endif
					float4 appendResult2783_g251640 = (float4(( staticSwitch495_g251640 + staticSwitch414_g251640 ) , 0.0));
					half4 Final_TransformData1569_g251640 = ( Vertex_TransformData2743_g251640 + appendResult2783_g251640 );
					float4 In_TransformData16_g251654 = Final_TransformData1569_g251640;
					half4 Vertex_RotationData2740_g251640 = Out_RotationData15_g251653;
					half2 Input_WindDirWS803_g251677 = Global_WindDirWS2542_g251640;
					half3 Input_ModelPositionWO761_g251651 = Model_PositionWO162_g251640;
					half3 Input_ModelPivotsWO419_g251651 = Model_PivotWO402_g251640;
					half Input_MotionPivots629_g251651 = _MotionBasePivotValue;
					float3 lerpResult771_g251651 = lerp( Input_ModelPositionWO761_g251651 , Input_ModelPivotsWO419_g251651 , Input_MotionPivots629_g251651);
					half4 Input_ModelMotionData763_g251651 = Model_PhaseData489_g251640;
					half Input_MotionPhase764_g251651 = _MotionBasePhaseValue;
					float temp_output_770_0_g251651 = ( (Input_ModelMotionData763_g251651).x * Input_MotionPhase764_g251651 );
					half3 Base_Position1394_g251640 = ( lerpResult771_g251651 + temp_output_770_0_g251651 );
					half3 Input_PositionWO419_g251677 = Base_Position1394_g251640;
					half Input_MotionTilling321_g251677 = ( _MotionBaseTillingValue + 0.2 );
					half2 Noise_Coord515_g251677 = ( -(Input_PositionWO419_g251677).xz * Input_MotionTilling321_g251677 * 0.005 );
					float2 Input_Coords80_g251679 = Noise_Coord515_g251677;
					half2 Input_Direction82_g251679 = Input_WindDirWS803_g251677;
					half Input_WindTime963_g251677 = Global_WindTime3262_g251640;
					half Input_MotionSpeed62_g251677 = _MotionBaseSpeedValue;
					float temp_output_505_0_g251677 = ( Input_WindTime963_g251677 * Input_MotionSpeed62_g251677 );
					half Noise_Speed516_g251677 = temp_output_505_0_g251677;
					float Input_Time88_g251679 = Noise_Speed516_g251677;
					float temp_output_23_0_g251679 = frac( Input_Time88_g251679 );
					float4 lerpResult39_g251679 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251679 + ( Input_Direction82_g251679 * temp_output_23_0_g251679 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g251679 + ( Input_Direction82_g251679 * ( temp_output_23_0_g251679 - 1.0 ) ) ), 0.0 ) , temp_output_23_0_g251679);
					float4 temp_output_635_0_g251677 = lerpResult39_g251679;
					half2 Noise_DirWS825_g251677 = ((temp_output_635_0_g251677).rg*2.0 + -1.0);
					half Input_MotionNoise552_g251677 = _MotionBaseNoiseValue;
					half Input_WindValue853_g251677 = Global_WindValue1855_g251640;
					float temp_output_6_0_g251678 = Input_WindValue853_g251677;
					float lerpResult701_g251677 = lerp( 1.0 , Input_MotionNoise552_g251677 , ( temp_output_6_0_g251678 * temp_output_6_0_g251678 ));
					float2 lerpResult646_g251677 = lerp( Input_WindDirWS803_g251677 , Noise_DirWS825_g251677 , lerpResult701_g251677);
					half2 Bend_Dir859_g251677 = lerpResult646_g251677;
					half Input_MotionValue871_g251677 = _MotionBaseIntensityValue;
					half Input_MotionDelay753_g251677 = _MotionBaseDelayValue;
					float lerpResult756_g251677 = lerp( 1.0 , ( Input_WindValue853_g251677 * Input_WindValue853_g251677 ) , Input_MotionDelay753_g251677);
					half Wind_Delay815_g251677 = lerpResult756_g251677;
					float2 temp_output_875_0_g251677 = ( Bend_Dir859_g251677 * Input_WindValue853_g251677 * Input_MotionValue871_g251677 * Wind_Delay815_g251677 );
					float2 Global_PushDirWS1972_g251640 = ((lerpResult3121_g251640).xy*2.0 + -1.0);
					half2 Input_PushDirWS807_g251677 = Global_PushDirWS1972_g251640;
					half Input_ReactValue888_g251677 = _MotionBasePushValue;
					half Input_PushAlpha806_g251677 = Global_PushAlpha1504_g251640;
					half Push_Mask883_g251677 = saturate( ( Input_PushAlpha806_g251677 * Input_ReactValue888_g251677 ) );
					float2 lerpResult811_g251677 = lerp( temp_output_875_0_g251677 , ( Input_PushDirWS807_g251677 * Input_ReactValue888_g251677 ) , Push_Mask883_g251677);
					#ifdef TVE_MOTION_FLOW
					float2 staticSwitch808_g251677 = lerpResult811_g251677;
					#else
					float2 staticSwitch808_g251677 = temp_output_875_0_g251677;
					#endif
					float2 temp_output_38_0_g251683 = staticSwitch808_g251677;
					float2 break83_g251683 = temp_output_38_0_g251683;
					float3 appendResult79_g251683 = (float3(break83_g251683.x , 0.0 , break83_g251683.y));
					half2 Base_Bending893_g251640 = (( mul( unity_WorldToObject, float4( appendResult79_g251683 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
					float temp_output_17_0_g251657 = _MotionBaseMaskMode;
					float Option92_g251657 = temp_output_17_0_g251657;
					float4 temp_output_84_0_g251657 = Model_VertexMasks518_g251640;
					float4 ChannelA92_g251657 = temp_output_84_0_g251657;
					float3 appendResult3220_g251640 = (float3((Model_MasksData1322_g251640).xy , (Motion_MaskTex2819_g251640).r));
					float3 temp_output_85_0_g251657 = appendResult3220_g251640;
					float4 ChannelB92_g251657 = float4( temp_output_85_0_g251657 , 0.0 );
					float localSwitchChannel792_g251657 = SwitchChannel7( Option92_g251657 , ChannelA92_g251657 , ChannelB92_g251657 );
					float clampResult17_g251646 = clamp( localSwitchChannel792_g251657 , 0.0001 , 0.9999 );
					float temp_output_7_0_g251645 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g251645 = ( clampResult17_g251646 - temp_output_7_0_g251645 );
					half Base_Mask217_g251640 = saturate( ( temp_output_9_0_g251645 * _MotionBaseMaskRemap.z ) );
					half2 Base_Motion1440_g251640 = ( Base_Bending893_g251640 * Base_Mask217_g251640 * (Global_MotionParams3013_g251640).x );
					#ifdef TVE_MOTION
					float2 staticSwitch2384_g251640 = Base_Motion1440_g251640;
					#else
					float2 staticSwitch2384_g251640 = float2( 0,0 );
					#endif
					float4 appendResult2023_g251640 = (float4(staticSwitch2384_g251640 , 0.0 , 0.0));
					half4 Final_RotationData1570_g251640 = ( Vertex_RotationData2740_g251640 + appendResult2023_g251640 );
					float4 In_RotationData16_g251654 = Final_RotationData1570_g251640;
					half4 Vertex_Interpolator2773_g251640 = Out_Interpolator15_g251653;
					half4 Noise_Params685_g251677 = temp_output_635_0_g251677;
					float temp_output_6_0_g251685 = (Noise_Params685_g251677).a;
					float temp_output_913_0_g251677 = ( ( temp_output_6_0_g251685 * temp_output_6_0_g251685 * temp_output_6_0_g251685 * temp_output_6_0_g251685 ) * ( Input_WindValue853_g251677 * Wind_Delay815_g251677 ) );
					float temp_output_6_0_g251686 = length( Input_PushDirWS807_g251677 );
					float temp_output_937_0_g251677 = ( temp_output_6_0_g251686 * temp_output_6_0_g251686 );
					half Input_PushNoise858_g251677 = Global_PushNoise2675_g251640;
					float lerpResult902_g251677 = lerp( temp_output_913_0_g251677 , temp_output_937_0_g251677 , ( Push_Mask883_g251677 * Input_PushNoise858_g251677 ));
					#ifdef TVE_MOTION_FLOW
					float staticSwitch903_g251677 = lerpResult902_g251677;
					#else
					float staticSwitch903_g251677 = temp_output_913_0_g251677;
					#endif
					half Base_Wave1159_g251640 = staticSwitch903_g251677;
					float temp_output_6_0_g251690 = (Noise_Params685_g251687).a;
					float temp_output_955_0_g251687 = ( temp_output_6_0_g251690 * temp_output_6_0_g251690 * temp_output_6_0_g251690 * temp_output_6_0_g251690 );
					float temp_output_944_0_g251687 = ( temp_output_955_0_g251687 * ( Input_WindValue881_g251687 * Wind_Delay815_g251687 ) );
					float lerpResult936_g251687 = lerp( temp_output_944_0_g251687 , temp_output_955_0_g251687 , ( Push_Mask914_g251687 * Input_PushNoise890_g251687 ));
					#ifdef TVE_MOTION_FLOW
					float staticSwitch939_g251687 = lerpResult936_g251687;
					#else
					float staticSwitch939_g251687 = temp_output_944_0_g251687;
					#endif
					half Small_Wave1427_g251640 = staticSwitch939_g251687;
					float lerpResult2422_g251640 = lerp( Base_Wave1159_g251640 , Small_Wave1427_g251640 , _motion_small_mode);
					half Global_Wave1475_g251640 = saturate( lerpResult2422_g251640 );
					float temp_output_6_0_g251647 = ( _MotionHighlightValue * Global_DistMask1820_g251640 * ( Tiny_Mask218_g251640 * Tiny_Mask218_g251640 ) * Global_Wave1475_g251640 );
					float temp_output_7_0_g251647 = _MotionHighlightColor.r;
					#ifdef TVE_DUMMY
					float staticSwitch14_g251647 = ( temp_output_6_0_g251647 + temp_output_7_0_g251647 );
					#else
					float staticSwitch14_g251647 = temp_output_6_0_g251647;
					#endif
					#ifdef TVE_MOTION
					float staticSwitch2866_g251640 = staticSwitch14_g251647;
					#else
					float staticSwitch2866_g251640 = 0.0;
					#endif
					float4 appendResult2775_g251640 = (float4((Vertex_Interpolator2773_g251640).xyz , staticSwitch2866_g251640));
					half4 Final_Interpolator2774_g251640 = appendResult2775_g251640;
					float4 In_Interpolator16_g251654 = Final_Interpolator2774_g251640;
					BuildVertexData( Data16_g251654 , In_Dummy16_g251654 , In_PositionOS16_g251654 , In_NormalOS16_g251654 , In_TangentOS16_g251654 , In_TransformData16_g251654 , In_RotationData16_g251654 , In_Interpolator16_g251654 );
					TVEVertexData Data15_g251809 =(TVEVertexData)Data16_g251654;
					float Out_Dummy15_g251809 = 0.0;
					float3 Out_PositionOS15_g251809 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251809 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251809 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251809 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251809 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251809 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251809 , Out_Dummy15_g251809 , Out_PositionOS15_g251809 , Out_NormalOS15_g251809 , Out_TangentOS15_g251809 , Out_TransformData15_g251809 , Out_RotationData15_g251809 , Out_Interpolator15_g251809 );
					TVEVertexData Data16_g251810 =(TVEVertexData)Data15_g251809;
					float In_Dummy16_g251810 = 0.0;
					float3 Vertex_PositionOS147_g251800 = Out_PositionOS15_g251809;
					half3 VertexPos40_g251804 = Vertex_PositionOS147_g251800;
					float4 temp_output_1615_33_g251800 = Out_RotationData15_g251809;
					half4 Vertex_RotationData1569_g251800 = temp_output_1615_33_g251800;
					float2 break1582_g251800 = (Vertex_RotationData1569_g251800).xy;
					half Angle44_g251804 = break1582_g251800.y;
					half CosAngle89_g251804 = cos( Angle44_g251804 );
					half SinAngle93_g251804 = sin( Angle44_g251804 );
					float3 appendResult95_g251804 = (float3((VertexPos40_g251804).x , ( ( (VertexPos40_g251804).y * CosAngle89_g251804 ) - ( (VertexPos40_g251804).z * SinAngle93_g251804 ) ) , ( ( (VertexPos40_g251804).y * SinAngle93_g251804 ) + ( (VertexPos40_g251804).z * CosAngle89_g251804 ) )));
					half3 VertexPos40_g251805 = appendResult95_g251804;
					half Angle44_g251805 = -break1582_g251800.x;
					half CosAngle94_g251805 = cos( Angle44_g251805 );
					half SinAngle95_g251805 = sin( Angle44_g251805 );
					float3 appendResult98_g251805 = (float3(( ( (VertexPos40_g251805).x * CosAngle94_g251805 ) - ( (VertexPos40_g251805).y * SinAngle95_g251805 ) ) , ( ( (VertexPos40_g251805).x * SinAngle95_g251805 ) + ( (VertexPos40_g251805).y * CosAngle94_g251805 ) ) , (VertexPos40_g251805).z));
					half3 VertexPos40_g251803 = Vertex_PositionOS147_g251800;
					half Angle44_g251803 = break1582_g251800.y;
					half CosAngle89_g251803 = cos( Angle44_g251803 );
					half SinAngle93_g251803 = sin( Angle44_g251803 );
					float3 appendResult95_g251803 = (float3((VertexPos40_g251803).x , ( ( (VertexPos40_g251803).y * CosAngle89_g251803 ) - ( (VertexPos40_g251803).z * SinAngle93_g251803 ) ) , ( ( (VertexPos40_g251803).y * SinAngle93_g251803 ) + ( (VertexPos40_g251803).z * CosAngle89_g251803 ) )));
					half3 VertexPos40_g251808 = appendResult95_g251803;
					half Angle44_g251808 = break1582_g251800.x;
					half CosAngle91_g251808 = cos( Angle44_g251808 );
					half SinAngle92_g251808 = sin( Angle44_g251808 );
					float3 appendResult93_g251808 = (float3(( ( (VertexPos40_g251808).x * CosAngle91_g251808 ) + ( (VertexPos40_g251808).z * SinAngle92_g251808 ) ) , (VertexPos40_g251808).y , ( ( -(VertexPos40_g251808).x * SinAngle92_g251808 ) + ( (VertexPos40_g251808).z * CosAngle91_g251808 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g251806 = appendResult93_g251808;
					#else
					float3 staticSwitch65_g251806 = appendResult98_g251805;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g251801 = staticSwitch65_g251806;
					#else
					float3 staticSwitch65_g251801 = Vertex_PositionOS147_g251800;
					#endif
					float3 temp_output_1608_0_g251800 = staticSwitch65_g251801;
					half3 VertexPos40_g251807 = temp_output_1608_0_g251800;
					half Angle44_g251807 = (Vertex_RotationData1569_g251800).z;
					half CosAngle91_g251807 = cos( Angle44_g251807 );
					half SinAngle92_g251807 = sin( Angle44_g251807 );
					float3 appendResult93_g251807 = (float3(( ( (VertexPos40_g251807).x * CosAngle91_g251807 ) + ( (VertexPos40_g251807).z * SinAngle92_g251807 ) ) , (VertexPos40_g251807).y , ( ( -(VertexPos40_g251807).x * SinAngle92_g251807 ) + ( (VertexPos40_g251807).z * CosAngle91_g251807 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g251802 = appendResult93_g251807;
					#else
					float3 staticSwitch65_g251802 = temp_output_1608_0_g251800;
					#endif
					float4 temp_output_1615_31_g251800 = Out_TransformData15_g251809;
					half4 Vertex_TransformData1568_g251800 = temp_output_1615_31_g251800;
					half3 Final_PositionOS178_g251800 = ( ( staticSwitch65_g251802 * (Vertex_TransformData1568_g251800).w ) + (Vertex_TransformData1568_g251800).xyz );
					float3 In_PositionOS16_g251810 = Final_PositionOS178_g251800;
					float3 In_NormalOS16_g251810 = Out_NormalOS15_g251809;
					float4 In_TangentOS16_g251810 = Out_TangentOS15_g251809;
					float4 In_TransformData16_g251810 = temp_output_1615_31_g251800;
					float4 In_RotationData16_g251810 = temp_output_1615_33_g251800;
					float4 In_Interpolator16_g251810 = Out_Interpolator15_g251809;
					BuildVertexData( Data16_g251810 , In_Dummy16_g251810 , In_PositionOS16_g251810 , In_NormalOS16_g251810 , In_TangentOS16_g251810 , In_TransformData16_g251810 , In_RotationData16_g251810 , In_Interpolator16_g251810 );
					TVEVertexData Data15_g251818 =(TVEVertexData)Data16_g251810;
					float Out_Dummy15_g251818 = 0.0;
					float3 Out_PositionOS15_g251818 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251818 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251818 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251818 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251818 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251818 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251818 , Out_Dummy15_g251818 , Out_PositionOS15_g251818 , Out_NormalOS15_g251818 , Out_TangentOS15_g251818 , Out_TransformData15_g251818 , Out_RotationData15_g251818 , Out_Interpolator15_g251818 );
					TVEVertexData Data16_g251819 =(TVEVertexData)Data15_g251818;
					float In_Dummy16_g251819 = 0.0;
					TVEModelData Data15_g251817 =(TVEModelData)Data15_g251652;
					float Out_Dummy15_g251817 = 0.0;
					float3 Out_PositionOS15_g251817 = float3( 0,0,0 );
					float3 Out_PositionWS15_g251817 = float3( 0,0,0 );
					float3 Out_PositionWO15_g251817 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g251817 = float3( 0,0,0 );
					float3 Out_PivotOS15_g251817 = float3( 0,0,0 );
					float3 Out_PivotWS15_g251817 = float3( 0,0,0 );
					float3 Out_PivotWO15_g251817 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251817 = float3( 0,0,0 );
					float3 Out_NormalWS15_g251817 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g251817 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251817 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g251817 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g251817 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g251817 = float3( 0,0,0 );
					float4 Out_CoordsData15_g251817 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g251817 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g251817 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g251817 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251817 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251817 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251817 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g251817 , Out_Dummy15_g251817 , Out_PositionOS15_g251817 , Out_PositionWS15_g251817 , Out_PositionWO15_g251817 , Out_PositionRawOS15_g251817 , Out_PivotOS15_g251817 , Out_PivotWS15_g251817 , Out_PivotWO15_g251817 , Out_NormalOS15_g251817 , Out_NormalWS15_g251817 , Out_NormalRawOS15_g251817 , Out_TangentOS15_g251817 , Out_TangentWS15_g251817 , Out_BitangentWS15_g251817 , Out_ViewDirWS15_g251817 , Out_CoordsData15_g251817 , Out_VertexData15_g251817 , Out_MasksData15_g251817 , Out_PhaseData15_g251817 , Out_TransformData15_g251817 , Out_RotationData15_g251817 , Out_Interpolator15_g251817 );
					float3 In_PositionOS16_g251819 = ( Out_PositionOS15_g251818 + Out_PivotOS15_g251817 );
					float3 In_NormalOS16_g251819 = Out_NormalOS15_g251818;
					float4 In_TangentOS16_g251819 = Out_TangentOS15_g251818;
					float4 In_TransformData16_g251819 = Out_TransformData15_g251818;
					float4 In_RotationData16_g251819 = Out_RotationData15_g251818;
					float4 In_Interpolator16_g251819 = Out_Interpolator15_g251818;
					BuildVertexData( Data16_g251819 , In_Dummy16_g251819 , In_PositionOS16_g251819 , In_NormalOS16_g251819 , In_TangentOS16_g251819 , In_TransformData16_g251819 , In_RotationData16_g251819 , In_Interpolator16_g251819 );
					TVEVertexData Data15_g251889 =(TVEVertexData)Data16_g251819;
					float Out_Dummy15_g251889 = 0.0;
					float3 Out_PositionOS15_g251889 = float3( 0,0,0 );
					float3 Out_NormalOS15_g251889 = float3( 0,0,0 );
					float4 Out_TangentOS15_g251889 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g251889 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g251889 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g251889 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g251889 , Out_Dummy15_g251889 , Out_PositionOS15_g251889 , Out_NormalOS15_g251889 , Out_TangentOS15_g251889 , Out_TransformData15_g251889 , Out_RotationData15_g251889 , Out_Interpolator15_g251889 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g251889;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g251889;
					v.tangent = Out_TangentOS15_g251889;

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
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":2631,"pos":[-7808,-5376],"params":["Inherit","False","Property","_IsShaderType","_IsShaderType","25","0","Create","True","0","0","0","False","0","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2635,"pos":[-7424,-4736],"params":["Inherit","False","If Model Data","-1","","241817","d269c9c511ff160419055604aade1e70","1,32,1","9","3","OBJECT","0","False","17","OBJECT","0","False","19","FLOAT","0","False","33","OBJECT","0","False","27","OBJECT","0","False","28","OBJECT","0","False","29","OBJECT","0","False","30","OBJECT","0","False","31","FLOAT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2637,"pos":[-7616,-5376],"params":["Half","False","IsShaderType","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2373,"pos":[-7104,-4736],"params":["Half","False","Model Frag","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2374,"pos":[-6656,-4992],"params":["Inherit","False","2373","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2632,"pos":[-7808,-4864],"params":["Inherit","False","Block Model","12","","241818","7ad7765e793a6714babedee0033c36e9","19,463,0,289,0,240,0,437,0,291,0,431,0,404,0,290,0,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0","11","102","FLOAT3","0,0,0","False","163","FLOAT3","0,0,0","False","186","FLOAT3","0,0,0","False","187","FLOAT3","0,0,0","False","166","FLOAT3","0,0,0","False","164","FLOAT3","0,0,0","False","301","FLOAT3","0,0,0","False","418","FLOAT3","0,0,0","False","167","FLOAT4","0,0,0,0","False","172","FLOAT4","0,0,0,0","False","175","FLOAT4","0,0,0,0","False","2","OBJECT","128","OBJECT","314"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2634,"pos":[-7808,-4992],"params":["Inherit","False","Block Model","12","","241838","7ad7765e793a6714babedee0033c36e9","19,463,1,289,1,240,1,437,1,291,1,431,1,404,1,290,1,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0","11","102","FLOAT3","0,0,0","False","163","FLOAT3","0,0,0","False","186","FLOAT3","0,0,0","False","187","FLOAT3","0,0,0","False","166","FLOAT3","0,0,0","False","164","FLOAT3","0,0,0","False","301","FLOAT3","0,0,0","False","418","FLOAT3","0,0,0","False","167","FLOAT4","0,0,0,0","False","172","FLOAT4","0,0,0,0","False","175","FLOAT4","0,0,0,0","False","2","OBJECT","128","OBJECT","314"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2633,"pos":[-7808,-4608],"params":["Inherit","False","2637","IsShaderType","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2375,"pos":[-6400,-4992],"params":["Inherit","False","Block Global","26","","241858","212e17d4006dc88449d56ce0340cb5ff","46,385,1,692,1,667,1,276,1,396,1,417,1,282,1,402,1,560,1,285,1,283,1,308,1,650,1,483,0,484,0,486,0,488,0,561,0,487,0,652,0,482,0,485,0,668,0,691,0,315,1,703,1,719,1,716,1,715,1,709,1,710,1,706,1,701,1,704,1,707,1,655,0,311,1,317,1,421,1,321,1,398,1,700,0,694,1,713,1,404,1,675,0","1","206","OBJECT","0,0,0,0","False","1","OBJECT","151"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2636,"pos":[-7424,-4992],"params":["Inherit","False","If Model Data","-1","","241959","d269c9c511ff160419055604aade1e70","1,32,1","9","3","OBJECT","0","False","17","OBJECT","0","False","19","FLOAT","0","False","33","OBJECT","0","False","27","OBJECT","0","False","28","OBJECT","0","False","29","OBJECT","0","False","30","OBJECT","0","False","31","FLOAT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2655,"pos":[-5504,-4992],"params":["Inherit","False","2377","Model Vert","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2656,"pos":[-5504,-4928],"params":["Inherit","False","2505","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2505,"pos":[-6080,-4992],"params":["Half","False","Global Data","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2377,"pos":[-7104,-4992],"params":["Half","False","Model Vert","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2654,"pos":[-5248,-4992],"params":["Inherit","False","Block Vertex","-1","","251551","79888a886ac7456468e9ffe3eda11f4f","0","2","1894","OBJECT","0,0,0,0","False","1896","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","1895","OBJECT","1897"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2604,"pos":[-4864,-4992],"params":["Inherit","False","Block Pivots Sub","-1","","251554","186f08b1bbe15894d9c677d50398679b","0","3","224","OBJECT","0,0,0,0","False","146","OBJECT","0,0,0,0","False","231","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","229","OBJECT","232"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2658,"pos":[-896,-4992],"params":["Inherit","False","2377","Model Vert","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2659,"pos":[-896,-4928],"params":["Inherit","False","2505","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2645,"pos":[-4480,-4992],"params":["Inherit","False","Block Blanket Conform","181","","251561","3ce1684c4351aeb42b79a955aa483301","2,389,0,377,1","3","146","OBJECT","0,0,0,0","False","397","OBJECT","0,0,0,0","False","186","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","398","OBJECT","399"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2657,"pos":[-640,-4992],"params":["Inherit","False","Block Vertex","-1","","251572","79888a886ac7456468e9ffe3eda11f4f","0","2","1894","OBJECT","0,0,0,0","False","1896","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","1895","OBJECT","1897"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2647,"pos":[-4096,-4992],"params":["Inherit","False","Block Motion","131","","251640","d9ac7ad4f0387004fb72c16019bf8392","6,2748,1,2751,1,2753,1,2749,1,3080,1,3079,0","3","146","OBJECT","0,0,0,0","False","3327","OBJECT","0,0,0,0","False","212","OBJECT","0,0,0,0","False","4","OBJECT","128","OBJECT","3328","OBJECT","3329","OBJECT","2951"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2621,"pos":[896,-3808],"params":["Inherit","False","FLOAT","2","2","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2611,"pos":[896,-4448],"params":["Inherit","False","FLOAT","2","2","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2646,"pos":[-256,-4992],"params":["Inherit","False","Block Motion","131","","251720","d9ac7ad4f0387004fb72c16019bf8392","6,2748,1,2751,1,2753,1,2749,1,3080,1,3079,0","3","146","OBJECT","0,0,0,0","False","3327","OBJECT","0,0,0,0","False","212","OBJECT","0,0,0,0","False","4","OBJECT","128","OBJECT","3328","OBJECT","3329","OBJECT","2951"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2610,"pos":[-3712,-4992],"params":["Inherit","False","Block Transform","-1","","251800","5ac6202bdddd8b34a85c261af6b8de8b","0","3","146","OBJECT","0,0,0,0","False","1620","OBJECT","0,0,0,0","False","1619","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","1617","OBJECT","1618"]}
{"type":"AmplifyShaderEditor.HSVToRGBNode, AmplifyShaderEditor","id":2618,"pos":[1088,-3808],"params":["Inherit","False","3","0","FLOAT","0","False","1","FLOAT","1","False","2","FLOAT","1","False","4","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3"]}
{"type":"AmplifyShaderEditor.HSVToRGBNode, AmplifyShaderEditor","id":2613,"pos":[1088,-4448],"params":["Inherit","False","3","0","FLOAT","0","False","1","FLOAT","1","False","2","FLOAT","1","False","4","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2570,"pos":[896,-3200],"params":["Inherit","False","Tool Debug Active","7","","251811","0bb5baa3fd5a859489bbfc09acf77496","0","2","80","FLOAT3","0,0,0","False","102","FLOAT","0","False","2","FLOAT3","108","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2569,"pos":[896,-3072],"params":["Inherit","False","FLOAT","2","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2640,"pos":[896,-2944],"params":["Inherit","False","Tool Debug Active","7","","251813","0bb5baa3fd5a859489bbfc09acf77496","0","2","80","FLOAT3","0,0,0","False","102","FLOAT","0","False","2","FLOAT3","108","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2643,"pos":[896,-2816],"params":["Inherit","False","FLOAT","3","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2509,"pos":[128,-4864],"params":["Inherit","False","Break Masks Data","-1","","251815","23311522ecc97b54e8b77d849401069d","0","1","6","OBJECT","0","False","8","FLOAT4","14","FLOAT4","0","FLOAT4","23","FLOAT4","5","FLOAT4","24","FLOAT4","25","FLOAT4","26","FLOAT4","27"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2607,"pos":[-3328,-4992],"params":["Inherit","False","Block Pivots Add","-1","","251816","016babe9e3e643242aa4d123a988150c","0","3","146","OBJECT","0,0,0,0","False","225","OBJECT","0,0,0,0","False","227","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","226","OBJECT","228"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2511,"pos":[896,-4736],"params":["Inherit","False","FLOAT3","0","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2551,"pos":[896,-4992],"params":["Inherit","False","Tool Debug Active","7","","251820","0bb5baa3fd5a859489bbfc09acf77496","0","2","80","FLOAT3","0,0,0","False","102","FLOAT","0","False","2","FLOAT3","108","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2567,"pos":[896,-4864],"params":["Inherit","False","FLOAT","0","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2513,"pos":[896,-4640],"params":["Inherit","False","FLOAT3","1","1","1","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2573,"pos":[896,-4000],"params":["Inherit","False","FLOAT3","1","1","1","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2574,"pos":[896,-3904],"params":["Inherit","False","FLOAT3","2","2","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2512,"pos":[896,-4096],"params":["Inherit","False","FLOAT3","0","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2548,"pos":[896,-3360],"params":["Inherit","False","FLOAT3","1","1","1","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2517,"pos":[896,-3456],"params":["Inherit","False","FLOAT3","0","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2530,"pos":[896,-4544],"params":["Inherit","False","FLOAT3","2","2","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GammaToLinearNode, AmplifyShaderEditor","id":2619,"pos":[1296,-3808],"params":["Inherit","False","0","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2623,"pos":[896,-3648],"params":["Inherit","False","FLOAT3","3","3","3","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GammaToLinearNode, AmplifyShaderEditor","id":2614,"pos":[1296,-4448],"params":["Inherit","False","0","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2616,"pos":[896,-4320],"params":["Inherit","False","FLOAT3","3","3","3","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":2571,"pos":[1152,-3200],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":2641,"pos":[1152,-2944],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2608,"pos":[-3008,-4992],"params":["Half","False","Vertex Data","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":2568,"pos":[1152,-4992],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2585,"pos":[1536,-4736],"params":["Inherit","False","Tool Debug Index","-1","","251822","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","2","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2586,"pos":[1536,-4640],"params":["Inherit","False","Tool Debug Index","-1","","251823","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","3","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2587,"pos":[1536,-4096],"params":["Inherit","False","Tool Debug Index","-1","","251824","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","8","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2588,"pos":[1536,-4000],"params":["Inherit","False","Tool Debug Index","-1","","251825","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","9","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2589,"pos":[1536,-3904],"params":["Inherit","False","Tool Debug Index","-1","","251826","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","10","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2620,"pos":[1536,-3808],"params":["Inherit","False","Tool Debug Index","-1","","251827","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","11","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2622,"pos":[1536,-3648],"params":["Inherit","False","Tool Debug Index","-1","","251828","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","12","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2590,"pos":[1536,-3456],"params":["Inherit","False","Tool Debug Index","-1","","251829","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","14","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2591,"pos":[1536,-3360],"params":["Inherit","False","Tool Debug Index","-1","","251830","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","15","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2593,"pos":[1536,-4544],"params":["Inherit","False","Tool Debug Index","-1","","251831","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","4","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2612,"pos":[1536,-4448],"params":["Inherit","False","Tool Debug Index","-1","","251832","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","5","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2615,"pos":[1536,-4320],"params":["Inherit","False","Tool Debug Index","-1","","251833","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","6","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2592,"pos":[1536,-3200],"params":["Inherit","False","Tool Debug Index","-1","","251834","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","17","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2642,"pos":[1536,-2944],"params":["Inherit","False","Tool Debug Index","-1","","251835","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","18","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2523,"pos":[1920,-4736],"params":["Inherit","False","5","5","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","3","FLOAT3","0,0,0","False","4","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2594,"pos":[1536,-4992],"params":["Inherit","False","Tool Debug Index","-1","","251836","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2545,"pos":[1920,-4096],"params":["Inherit","False","5","5","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","3","FLOAT3","0,0,0","False","4","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2549,"pos":[1920,-3456],"params":["Inherit","False","4","4","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","3","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2660,"pos":[-2560,-4864],"params":["Inherit","False","2505","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2661,"pos":[-2560,-4928],"params":["Inherit","False","2373","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2663,"pos":[-2560,-4992],"params":["Inherit","False","2608","Vertex Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2550,"pos":[2176,-4992],"params":["Inherit","False","4","4","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","3","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2662,"pos":[-2304,-4992],"params":["Inherit","False","Block Visual","-1","","251837","9511980f05dcfdf4d8967cd55c0d1784","1,1910,1","3","1904","OBJECT","0,0,0,0","False","1894","OBJECT","0,0,0,0","False","1896","OBJECT","0,0,0,0","False","3","OBJECT","1900","OBJECT","1895","OBJECT","1897"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2380,"pos":[-1920,-4992],"params":["Inherit","False","Block Main","105","","251841","b04cfed9a7b4c0841afdb49a38c282c5","13,65,1,136,1,41,1,133,1,40,1,344,0,347,0,342,0,346,0,343,0,345,0,329,1,408,1","3","430","OBJECT","0,0,0,0","False","225","OBJECT","0,0,0,0","False","414","OBJECT","0,0,0,0","False","3","OBJECT","106","OBJECT","417","OBJECT","415"]}
{"type":"AmplifyShaderEditor.VertexToFragmentNode, AmplifyShaderEditor","id":2524,"pos":[2304,-4992],"params":["Inherit","False","False","False","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2454,"pos":[-1600,-4992],"params":["Half","False","Visual Data","-1","True","1","0","OBJECT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2399,"pos":[2624,-4992],"params":["Half","False","Final_Debug","-1","True","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2400,"pos":[3200,-4992],"params":["Inherit","False","2399","Final_Debug","1","0","OBJECT","","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2563,"pos":[3200,-4928],"params":["Inherit","False","2454","Visual Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2555,"pos":[3200,-4864],"params":["Inherit","False","2608","Vertex Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.ConditionalIfNode, AmplifyShaderEditor","id":1774,"pos":[-880,2944],"params":["Inherit","False","True","5","0","FLOAT","0","False","1","FLOAT","1","False","2","FLOAT","0","False","3","FLOAT","0","False","4","COLOR","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TFHCRemapNode, AmplifyShaderEditor","id":1803,"pos":[-1344,2944],"params":["Inherit","False","5","0","FLOAT","0","False","1","FLOAT","-1","False","2","FLOAT","1","False","3","FLOAT","0.3","False","4","FLOAT","0.7","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":1772,"pos":[-1088,3072],"params":["Float","False","Constant","_Float3","Float 3","31","0","Create","True","0","0","0","False","0","False","Object","-1","","24","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleTimeNode, AmplifyShaderEditor","id":1843,"pos":[-1632,2944],"params":["Inherit","False","1","0","FLOAT","1","False","5","FLOAT","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":1771,"pos":[-1088,2944],"params":["Inherit","False","-1","","1","0","OBJECT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SinOpNode, AmplifyShaderEditor","id":1800,"pos":[-1472,2944],"params":["Inherit","False","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":1804,"pos":[-1792,2944],"params":["Inherit","False","Constant","_Float1","Float 1","0","0","Create","True","0","0","0","False","0","False","Object","-1","","3","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2203,"pos":[3456,-5120],"params":["Inherit","False","Base Compile","-1","","251880","e67c8238031dbf04ab79a5d4d63d1b4f","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2609,"pos":[3456,-4992],"params":["Inherit","False","Tool Debug Color","0","","251881","d992d3ed4a7539141ba053d3e0c12277","0","3","80","FLOAT3","0,0,0","False","106","OBJECT","0,0,0","False","107","OBJECT","0,0,0","False","5","FLOAT","114","FLOAT3","0","FLOAT3","113","FLOAT3","148","FLOAT4","149"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2355,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","14","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ForwardAdd","0","2","ForwardAdd","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","4","1","False","","1","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","","False","False","False","True","1","LightMode=ForwardAdd","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2356,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","14","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","Deferred","0","3","Deferred","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=Deferred","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2357,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","14","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","Meta","0","4","Meta","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=Meta","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2358,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","14","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ShadowCaster","0","5","ShadowCaster","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","True","3","False","","False","False","True","1","LightMode=ShadowCaster","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2353,"pos":[3456,-4992],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","14","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ExtraPrePass","0","0","ExtraPrePass","5","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2354,"pos":[3840,-4992],"params":["Float","False","True","-1","3","","0","3","Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Motion","28cd5599e02859647ae1798e4fcaef6c","True","ForwardBase","0","1","ForwardBase","15","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","2","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","40","Category","0","0","Workflow","0","638874882197810641","Surface","0","0","  Blend","0","0","  Dither Shadows","1","0","Two Sided","0","638874603607655403","Deferred Pass","1","0","Normal Space","0","0","Transmission","0","0","  Transmission Shadow","0.5,False,","0","Translucency","0","0","  Translucency Strength","1,False,","0","  Normal Distortion","0.5,False,","0","  Scattering","2,False,","0","  Direct","0.9,False,","0","  Ambient","0.1,False,","0","  Shadow","0.5,False,","0","Cast Shadows","0","638814711411603618","Receive Shadows","0","638814711415148256","Receive Specular","0","638814711419031593","GPU Instancing","1","638874881145939632","LOD CrossFade","0","638814711429956434","Built-in Fog","0","638814711441065168","Ambient Light","0","638814711449050123","Meta Pass","0","638814711456998358","Add Pass","0","638814711466594157","Override Baked GI","0","0","Write Depth","0","0","Extra Pre Pass","0","0","Tessellation","0","0","  Phong","0","0","  Strength","0.5,False,","0","  Type","0","0","  Tess","16,False,","0","  Min","10,False,","0","  Max","25,False,","0","  Edge Length","16,False,","0","  Max Displacement","25,False,","0","Disable Batching","0","638874882298697380","Vertex Position","0","638874601191422915","0","8","False","True","False","True","False","False","True","True","False","","True","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2638,"pos":[3072,-4932],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","14","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","SceneSelectionPass","0","6","SceneSelectionPass","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","False","False","False","True","1","LightMode=SceneSelectionPass","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2639,"pos":[3840,-4992],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","14","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ScenePickingPass","0","7","ScenePickingPass","1","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","False","False","False","True","1","LightMode=Picking","False","False","0","","0","0","Standard","0","False","0"]}
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
{"wire":[2645,146,2604,128]}
{"wire":[2645,397,2604,229]}
{"wire":[2645,186,2604,232]}
{"wire":[2657,1894,2658,0]}
{"wire":[2657,1896,2659,0]}
{"wire":[2647,146,2645,128]}
{"wire":[2647,3327,2645,398]}
{"wire":[2647,212,2645,399]}
{"wire":[2621,0,2509,23]}
{"wire":[2611,0,2509,0]}
{"wire":[2646,146,2657,128]}
{"wire":[2646,3327,2657,1895]}
{"wire":[2646,212,2657,1897]}
{"wire":[2610,146,2647,128]}
{"wire":[2610,1620,2647,3328]}
{"wire":[2610,1619,2647,3329]}
{"wire":[2618,0,2621,0]}
{"wire":[2613,0,2611,0]}
{"wire":[2569,0,2509,14]}
{"wire":[2643,0,2509,14]}
{"wire":[2509,6,2646,2951]}
{"wire":[2607,146,2610,128]}
{"wire":[2607,225,2610,1617]}
{"wire":[2607,227,2610,1618]}
{"wire":[2511,0,2509,0]}
{"wire":[2567,0,2509,14]}
{"wire":[2513,0,2509,0]}
{"wire":[2573,0,2509,23]}
{"wire":[2574,0,2509,23]}
{"wire":[2512,0,2509,23]}
{"wire":[2548,0,2509,5]}
{"wire":[2517,0,2509,5]}
{"wire":[2530,0,2509,0]}
{"wire":[2619,0,2618,0]}
{"wire":[2623,0,2509,23]}
{"wire":[2614,0,2613,0]}
{"wire":[2616,0,2509,0]}
{"wire":[2571,0,2570,108]}
{"wire":[2571,1,2570,0]}
{"wire":[2571,2,2569,0]}
{"wire":[2641,0,2640,108]}
{"wire":[2641,1,2640,0]}
{"wire":[2641,2,2643,0]}
{"wire":[2608,0,2607,128]}
{"wire":[2568,0,2551,108]}
{"wire":[2568,1,2551,0]}
{"wire":[2568,2,2567,0]}
{"wire":[2585,39,2511,0]}
{"wire":[2586,39,2513,0]}
{"wire":[2587,39,2512,0]}
{"wire":[2588,39,2573,0]}
{"wire":[2589,39,2574,0]}
{"wire":[2620,39,2619,0]}
{"wire":[2622,39,2623,0]}
{"wire":[2590,39,2517,0]}
{"wire":[2591,39,2548,0]}
{"wire":[2593,39,2530,0]}
{"wire":[2612,39,2614,0]}
{"wire":[2615,39,2616,0]}
{"wire":[2592,39,2571,0]}
{"wire":[2642,39,2641,0]}
{"wire":[2523,0,2585,0]}
{"wire":[2523,1,2586,0]}
{"wire":[2523,2,2593,0]}
{"wire":[2523,3,2612,0]}
{"wire":[2523,4,2615,0]}
{"wire":[2594,39,2568,0]}
{"wire":[2545,0,2587,0]}
{"wire":[2545,1,2588,0]}
{"wire":[2545,2,2589,0]}
{"wire":[2545,3,2620,0]}
{"wire":[2545,4,2622,0]}
{"wire":[2549,0,2590,0]}
{"wire":[2549,1,2591,0]}
{"wire":[2549,2,2592,0]}
{"wire":[2549,3,2642,0]}
{"wire":[2550,0,2594,0]}
{"wire":[2550,1,2523,0]}
{"wire":[2550,2,2545,0]}
{"wire":[2550,3,2549,0]}
{"wire":[2662,1904,2663,0]}
{"wire":[2662,1894,2661,0]}
{"wire":[2662,1896,2660,0]}
{"wire":[2380,430,2662,1900]}
{"wire":[2380,225,2662,1895]}
{"wire":[2380,414,2662,1897]}
{"wire":[2524,0,2550,0]}
{"wire":[2454,0,2380,106]}
{"wire":[2399,0,2524,0]}
{"wire":[1774,0,1771,0]}
{"wire":[1774,1,1772,0]}
{"wire":[1774,3,1803,0]}
{"wire":[1803,0,1800,0]}
{"wire":[1843,0,1804,0]}
{"wire":[1800,0,1843,0]}
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
//CHKSM=1A66D428994FB0AFB9F105AADBE1F3A2147772BA