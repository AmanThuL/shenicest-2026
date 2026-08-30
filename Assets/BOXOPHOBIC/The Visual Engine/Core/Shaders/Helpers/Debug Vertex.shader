// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Vertex"
{
	Properties
	{
		[HideInInspector] _IsTVEShader( "_IsTVEShader", Float ) = 0
		_RenderClip( "_RenderClip", Float ) = 0
		_IsElementShader( "_IsElementShader", Float ) = 0
		_IsHelperShader( "_IsHelperShader", Float ) = 0
		[StyledCategory(Transfer Settings, true, Use the Transfer feature to send perMINvertex terrain normals to the material. The most common usage is to blend stylized grass with terrains. Works perfectly with the Colormap feature which gets the terrain albedo__ while the Transfer ensures the same shading is used on both the terrain and the grassEXC, _TransferIntensityValue, CCCC00, 0, 10)] _TransferCategory( "[ Transfer Category ]", Float ) = 0
		[StyledMessage(Info, The Transfer normal feature requires elements to work. Use Form Surface or Form Normal elements to send perMINvertex terrain normals to the material., 0, 10)] _TransferInfo( "_TransferInfo", Float ) = 0
		_TransferIntensityValue( "Transfer Intensity", Range( 0, 1 ) ) = 0
		[StyledSpace(10)] _TransferSpace( "[ Transfer Space ]", Float ) = 1
		_TransferMeshValue( "Transfer Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _TransferMeshMode( "Transfer Mesh Mask", Float ) = 3
		[StyledRemapSlider] _TransferMeshRemap( "Transfer Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[StyledSpace(10)] _TransferEnd( "[ Transfer End ]", Float ) = 1
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
		[StyledCategory(Rotation Settings, true, Use the Rotation feature to aligning the objects to the terrain or mesh surfaces., _RotationIntensityValue, FFFF00, 0, 10)] _RotationCategory( "[ Rotation Category ]", Float ) = 0
		[StyledMessage(Info, The Rotation features require elements to work. Use Form Surface or Form Normal elements for aligning the objects to terrain surfaces., 0, 10)] _RotationInfo( "_RotationInfo", Float ) = 0
		_RotationIntensityValue( "Rotation Intensity", Range( 0, 1 ) ) = 0
		[StyledSpace(10)] _RotationEnd( "[ Rotation End ]", Float ) = 1
		[StyledCategory(Perspective Settings, true, Use the Perspective feature to QUOhideQUO the mesh quads when grass models are viewed from the top. The effect will adapt to the camera projectionCOLNEWNEWWhen Perspective camera is used__ the vertices are pushed to the edges of the screen.NEWNEWWhen Orthographic camera is used__ the vertices are pushed forward based on the camera view., _PerspectiveIntensityValue, CD75FF, 0, 10)] _PerspectiveCategory( "[ Perspective Category ]", Float ) = 0
		_PerspectiveIntensityValue( "Perspective Intensity", Range( 0, 10 ) ) = 0
		_PerspectiveAngleValue( "Perspective Angle", Range( 0, 8 ) ) = 1
		_PerspectivePhaseValue( "Perspective Phase", Range( 0, 1 ) ) = 0
		[StyledSpace(10)] _PerspectiveEnd( "[ Perspective End ]", Float ) = 1
		[StyledCategory(Size Fade Settings, true, Use the Size Fade feature to fade out the size of the objects. The most common usage is to fade out grass on winter__ fade out grass based on distance or hide objects when placing building. Please note__ setting the size to zero might cut the perMINpixel rendering cost but it is best to not render the object at allEXC, _SizeFadeIntensityValue, 008BE6, 0, 10)] _SizeFadeCategory( "[ Size Fade Category ]", Float ) = 0
		_SizeFadeIntensityValue( "Size Fade Intensity", Range( 0, 1 ) ) = 0
		[Enum(All Axis,0,Up Axis,1)] _SizeFadeScaleMode( "Size Fade Mode", Float ) = 0
		_SizeFadeScaleValue( "Size Fade Value", Range( 0, 1 ) ) = 1
		_SizeFadeDistMinValue( "Size Fade Start", Range( 0, 2000 ) ) = 0
		_SizeFadeDistMaxValue( "Size Fade Limit", Range( 0, 2000 ) ) = 0
		[Space(10)] _SizeFadeVertxValue( "Size Fade Vertx Mask", Range( 0, 1 ) ) = 1
		[Enum(Global Data Only,0,Use Vertx Elements,1)] _SizeFadeVertxMode( "Size Fade Vertx Mask", Float ) = 0
		[StyledSpace(10)] _SizeFadeEnd( "[ Size Fade End ]", Float ) = 1
		[StyledCategory(Flatten Settings, true, Use the Flatten feature to flatten or spherify the vertex normals used for shading in the pixel stage. The most common usage is to give grass a more QUOlushQUO appearance or to spherify the shading for tree cannopies.NEWNEWUse the Baking option to preMINbake the shading to the impostor normal texture., _FlattenIntensityValue, 80FF00, 0, 10)] _FlattenCategory( "[ Flatten Category ]", Float ) = 0
		_FlattenIntensityValue( "Flatten Intensity", Range( 0, 1 ) ) = 0
		_FlattenUpwardsValue( "Flatten Upwards", Range( 0, 1 ) ) = 1
		_FlattenSphereValue( "Flatten Spherical", Range( 0, 1 ) ) = 0
		[StyledVector3] _FlattenSphereOffsetValue( "Flatten Spherical Offset", Vector ) = ( 0, 0, 0, 0 )
		[Enum(Off,0,Bake Settings To Textures,1)] _FlattenBakeMode( "Flatten Baking", Float ) = 1
		[Space(10)] _FlattenMeshValue( "Flatten Mesh Mask", Range( 0, 1 ) ) = 0
		[Enum(Vertex R,0,Vertex G,1,Vertex B,2,Vertex A,3)] _FlattenMeshMode( "Flatten Mesh Mask", Float ) = 2
		[StyledRemapSlider] _FlattenMeshRemap( "Flatten Mesh Mask", Vector ) = ( 0, 1, 0, 0 )
		[StyledSpace(10)] _FlattenEnd( "[ Flatten End ]", Float ) = 1
		[StyledCategory(Reshade Settings, true, Use the Reshade feature to reMINcalculate the vertex normals when Motion Primary Bending or Blanket Rotation features are used., _ReshadeIntensityValue, 8FC0FF, 0, 10)] _ReshadeCategory( "[ Reshade Category ]", Float ) = 0
		[StyledMessage(Info, Use the Reshade feature to reMINcalculate the vertex normals when Motion Primary Bending or Blanket Rotation features are used., 0, 10)] _ReshadeInfo( "_ReshadeInfo", Float ) = 0
		_ReshadeIntensityValue( "Reshade Intensity", Range( 0, 1 ) ) = 0
		[StyledSpace(10)] _ReshadeEnd( "[ Reshade End ]", Float ) = 1


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
				#define ASE_NEEDS_TEXTURE_COORDINATES1
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES1
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
				#define ASE_NEEDS_FRAG_NORMAL
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#define ASE_NEEDS_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_BITANGENT
				#define ASE_NEEDS_FRAG_COLOR
				#pragma shader_feature_local_vertex TVE_COORD_ZUP
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_PERSPECTIVE
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_vertex TVE_ROTATION
				#pragma shader_feature_local_vertex TVE_SIZEFADE
				#pragma shader_feature_local_vertex TVE_SIZEFADE_VERTX
				#pragma shader_feature_local_vertex TVE_MOTION
				#pragma shader_feature_local_vertex TVE_MOTION_FLOW
				#pragma shader_feature_local TVE_LEGACY
				#pragma shader_feature_local_vertex TVE_FLATTEN
				#pragma shader_feature_local_vertex TVE_RESHADE
				#pragma shader_feature_local_vertex TVE_TRANSFER
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
				#if defined (TVE_CONFORM_ROTATION) //Conform Rotation
					#define TVE_ROTATION_BEND //Conform Rotation
				#endif //Conform Rotation
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
					float3 ase_normal : NORMAL;
					float4 ase_texcoord9 : TEXCOORD9;
					float4 ase_texcoord10 : TEXCOORD10;
					float4 ase_texcoord11 : TEXCOORD11;
					float4 ase_texcoord12 : TEXCOORD12;
					float4 ase_color : COLOR;
					float4 ase_texcoord13 : TEXCOORD13;
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
				uniform half _PerspectiveCategory;
				uniform half _PerspectiveEnd;
				uniform half _PerspectivePhaseValue;
				uniform half _PerspectiveIntensityValue;
				uniform half _PerspectiveAngleValue;
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
				uniform half _RotationCategory;
				uniform half _RotationEnd;
				uniform half _RotationInfo;
				uniform half _RotationIntensityValue;
				uniform half _SizeFadeCategory;
				uniform half _SizeFadeEnd;
				uniform half4 TVE_SizeFadeParams;
				uniform float _SizeFadeDistMaxValue;
				uniform float _SizeFadeDistMinValue;
				uniform half _SizeFadeScaleValue;
				uniform half _SizeFadeVertxMode;
				uniform half _SizeFadeVertxValue;
				uniform half _SizeFadeScaleMode;
				uniform half _SizeFadeIntensityValue;
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
				uniform half _FlattenCategory;
				uniform half _FlattenEnd;
				uniform half _FlattenBakeMode;
				uniform half _FlattenUpwardsValue;
				uniform half3 _FlattenSphereOffsetValue;
				uniform half _FlattenSphereValue;
				uniform half _FlattenMeshMode;
				uniform half4 _FlattenMeshRemap;
				uniform half _FlattenMeshValue;
				uniform half _FlattenIntensityValue;
				uniform half _ReshadeCategory;
				uniform half _ReshadeEnd;
				uniform half _ReshadeInfo;
				uniform half _ReshadeIntensityValue;
				uniform half _TransferCategory;
				uniform half _TransferEnd;
				uniform half _TransferInfo;
				uniform half _TransferSpace;
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

					TVEVertexData Data16_g262854 =(TVEVertexData)0;
					float In_Dummy16_g262854 = 0.0;
					TVEVertexData Data16_g262849 =(TVEVertexData)0;
					float In_Dummy16_g262849 = 0.0;
					float localIfModelDataByShader26_g263144 = ( 0.0 );
					TVEModelData Data26_g263144 = (TVEModelData)0;
					TVEModelData Data16_g263050 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g263032 = _ObjectCoordMode;
					#else
					float staticSwitch343_g263032 = _ObjectCoordMode;
					#endif
					half Dummy207_g263032 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g263032 );
					float temp_output_14_0_g263050 = Dummy207_g263032;
					float In_Dummy16_g263050 = temp_output_14_0_g263050;
					float3 PositionOS131_g263032 = v.vertex.xyz;
					float3 temp_output_4_0_g263050 = PositionOS131_g263032;
					float3 In_PositionOS16_g263050 = temp_output_4_0_g263050;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g263032 = ase_positionWS;
					float3 vertexToFrag73_g263032 = temp_output_104_7_g263032;
					float3 PositionWS122_g263032 = vertexToFrag73_g263032;
					float3 In_PositionWS16_g263050 = PositionWS122_g263032;
					float4x4 break19_g263035 = unity_ObjectToWorld;
					float3 appendResult20_g263035 = (float3(break19_g263035[ 0 ][ 3 ] , break19_g263035[ 1 ][ 3 ] , break19_g263035[ 2 ][ 3 ]));
					float3 temp_output_340_7_g263032 = appendResult20_g263035;
					float4x4 break19_g263037 = unity_ObjectToWorld;
					float3 appendResult20_g263037 = (float3(break19_g263037[ 0 ][ 3 ] , break19_g263037[ 1 ][ 3 ] , break19_g263037[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g263033 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g263032 = PositionOS131_g263032;
					float3 appendResult234_g263032 = (float3(break233_g263032.x , 0.0 , break233_g263032.z));
					float3 break413_g263032 = PositionOS131_g263032;
					float3 appendResult414_g263032 = (float3(break413_g263032.x , break413_g263032.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g263039 = appendResult414_g263032;
					#else
					float3 staticSwitch65_g263039 = appendResult234_g263032;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g263032 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g263032 = appendResult60_g263033;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g263032 = staticSwitch65_g263039;
					#else
					float3 staticSwitch229_g263032 = _Vector0;
					#endif
					float3 PivotOS149_g263032 = staticSwitch229_g263032;
					float3 temp_output_122_0_g263037 = PivotOS149_g263032;
					float3 PivotsOnlyWS105_g263037 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g263037 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g263032 = ( appendResult20_g263037 + PivotsOnlyWS105_g263037 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g263032 = temp_output_340_7_g263032;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g263032 = temp_output_341_7_g263032;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g263032 = temp_output_341_7_g263032;
					#else
					float3 staticSwitch236_g263032 = temp_output_340_7_g263032;
					#endif
					float3 vertexToFrag76_g263032 = staticSwitch236_g263032;
					float3 PivotWS121_g263032 = vertexToFrag76_g263032;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g263032 = ( PositionWS122_g263032 - PivotWS121_g263032 );
					#else
					float3 staticSwitch204_g263032 = PositionWS122_g263032;
					#endif
					float3 PositionWO132_g263032 = ( staticSwitch204_g263032 - TVE_WorldOrigin );
					float3 In_PositionWO16_g263050 = PositionWO132_g263032;
					float3 In_PivotOS16_g263050 = PivotOS149_g263032;
					float3 In_PivotWS16_g263050 = PivotWS121_g263032;
					float3 PivotWO133_g263032 = ( PivotWS121_g263032 - TVE_WorldOrigin );
					float3 In_PivotWO16_g263050 = PivotWO133_g263032;
					half3 NormalOS134_g263032 = v.normal;
					float3 temp_output_21_0_g263050 = NormalOS134_g263032;
					float3 In_NormalOS16_g263050 = temp_output_21_0_g263050;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g263032 = normalizedWorldNormal;
					float3 In_NormalWS16_g263050 = NormalWS95_g263032;
					half4 TangentlOS153_g263032 = v.tangent;
					float4 temp_output_6_0_g263050 = TangentlOS153_g263032;
					float4 In_TangentOS16_g263050 = temp_output_6_0_g263050;
					float3 normalizeResult296_g263032 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g263032 ) );
					half3 ViewDirWS169_g263032 = normalizeResult296_g263032;
					float3 In_ViewDirWS16_g263050 = ViewDirWS169_g263032;
					float4 appendResult397_g263032 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g263032 = appendResult397_g263032;
					float4 In_CoordsData16_g263050 = CoordsData398_g263032;
					half4 VertexMasks171_g263032 = v.ase_color;
					float4 In_VertexData16_g263050 = VertexMasks171_g263032;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g263044 = (PositionOS131_g263032).z;
					#else
					float staticSwitch65_g263044 = (PositionOS131_g263032).y;
					#endif
					half Object_HeightValue267_g263032 = _ObjectHeightValue;
					half Bounds_HeightMask274_g263032 = saturate( ( staticSwitch65_g263044 / Object_HeightValue267_g263032 ) );
					half3 Position387_g263032 = PositionOS131_g263032;
					half Height387_g263032 = Object_HeightValue267_g263032;
					half Object_RadiusValue268_g263032 = _ObjectRadiusValue;
					half Radius387_g263032 = Object_RadiusValue268_g263032;
					half localCapsuleMaskYUp387_g263032 = CapsuleMaskYUp( Position387_g263032 , Height387_g263032 , Radius387_g263032 );
					half3 Position408_g263032 = PositionOS131_g263032;
					half Height408_g263032 = Object_HeightValue267_g263032;
					half Radius408_g263032 = Object_RadiusValue268_g263032;
					half localCapsuleMaskZUp408_g263032 = CapsuleMaskZUp( Position408_g263032 , Height408_g263032 , Radius408_g263032 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g263049 = saturate( localCapsuleMaskZUp408_g263032 );
					#else
					float staticSwitch65_g263049 = saturate( localCapsuleMaskYUp387_g263032 );
					#endif
					half Bounds_SphereMask282_g263032 = staticSwitch65_g263049;
					float4 appendResult253_g263032 = (float4(Bounds_HeightMask274_g263032 , Bounds_SphereMask282_g263032 , 1.0 , 1.0));
					half4 MasksData254_g263032 = appendResult253_g263032;
					float4 In_MasksData16_g263050 = MasksData254_g263032;
					float temp_output_17_0_g263043 = _ObjectPhaseMode;
					float Option70_g263043 = temp_output_17_0_g263043;
					float4 temp_output_3_0_g263043 = v.ase_color;
					float4 Channel70_g263043 = temp_output_3_0_g263043;
					float localSwitchChannel470_g263043 = SwitchChannel4( Option70_g263043 , Channel70_g263043 );
					half Phase_Value372_g263032 = localSwitchChannel470_g263043;
					float3 break319_g263032 = PivotWO133_g263032;
					half Pivot_Position322_g263032 = ( break319_g263032.x + break319_g263032.z );
					half Phase_Position357_g263032 = ( Phase_Value372_g263032 + Pivot_Position322_g263032 );
					float temp_output_248_0_g263032 = frac( Phase_Position357_g263032 );
					float4 appendResult177_g263032 = (float4((frac( ( Phase_Position357_g263032 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g263032));
					half4 Phase_Data176_g263032 = appendResult177_g263032;
					float4 In_PhaseData16_g263050 = Phase_Data176_g263032;
					BuildModelVertData( Data16_g263050 , In_Dummy16_g263050 , In_PositionOS16_g263050 , In_PositionWS16_g263050 , In_PositionWO16_g263050 , In_PivotOS16_g263050 , In_PivotWS16_g263050 , In_PivotWO16_g263050 , In_NormalOS16_g263050 , In_NormalWS16_g263050 , In_TangentOS16_g263050 , In_ViewDirWS16_g263050 , In_CoordsData16_g263050 , In_VertexData16_g263050 , In_MasksData16_g263050 , In_PhaseData16_g263050 );
					TVEModelData DataDefault26_g263144 = Data16_g263050;
					TVEModelData DataGeneral26_g263144 = Data16_g263050;
					TVEModelData DataBlanket26_g263144 = Data16_g263050;
					TVEModelData DataImpostor26_g263144 = Data16_g263050;
					TVEModelData Data16_g263030 =(TVEModelData)0;
					half Dummy207_g263012 = 0.0;
					float temp_output_14_0_g263030 = Dummy207_g263012;
					float In_Dummy16_g263030 = temp_output_14_0_g263030;
					float3 PositionOS131_g263012 = v.vertex.xyz;
					float3 temp_output_4_0_g263030 = PositionOS131_g263012;
					float3 In_PositionOS16_g263030 = temp_output_4_0_g263030;
					float3 temp_output_104_7_g263012 = ase_positionWS;
					float3 PositionWS122_g263012 = temp_output_104_7_g263012;
					float3 In_PositionWS16_g263030 = PositionWS122_g263012;
					float4x4 break19_g263015 = unity_ObjectToWorld;
					float3 appendResult20_g263015 = (float3(break19_g263015[ 0 ][ 3 ] , break19_g263015[ 1 ][ 3 ] , break19_g263015[ 2 ][ 3 ]));
					float3 temp_output_340_7_g263012 = appendResult20_g263015;
					float3 PivotWS121_g263012 = temp_output_340_7_g263012;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g263012 = ( PositionWS122_g263012 - PivotWS121_g263012 );
					#else
					float3 staticSwitch204_g263012 = PositionWS122_g263012;
					#endif
					float3 PositionWO132_g263012 = ( staticSwitch204_g263012 - TVE_WorldOrigin );
					float3 In_PositionWO16_g263030 = PositionWO132_g263012;
					float3 PivotOS149_g263012 = _Vector0;
					float3 In_PivotOS16_g263030 = PivotOS149_g263012;
					float3 In_PivotWS16_g263030 = PivotWS121_g263012;
					float3 PivotWO133_g263012 = ( PivotWS121_g263012 - TVE_WorldOrigin );
					float3 In_PivotWO16_g263030 = PivotWO133_g263012;
					half3 NormalOS134_g263012 = v.normal;
					float3 temp_output_21_0_g263030 = NormalOS134_g263012;
					float3 In_NormalOS16_g263030 = temp_output_21_0_g263030;
					half3 NormalWS95_g263012 = normalizedWorldNormal;
					float3 In_NormalWS16_g263030 = NormalWS95_g263012;
					float4 appendResult462_g263012 = (float4(cross( v.normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g263012 = appendResult462_g263012;
					float4 temp_output_6_0_g263030 = TangentlOS153_g263012;
					float4 In_TangentOS16_g263030 = temp_output_6_0_g263030;
					float3 normalizeResult296_g263012 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g263012 ) );
					half3 ViewDirWS169_g263012 = normalizeResult296_g263012;
					float3 In_ViewDirWS16_g263030 = ViewDirWS169_g263012;
					float4 appendResult397_g263012 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g263012 = appendResult397_g263012;
					float4 In_CoordsData16_g263030 = CoordsData398_g263012;
					half4 VertexMasks171_g263012 = float4( 0,0,0,0 );
					float4 In_VertexData16_g263030 = VertexMasks171_g263012;
					half4 MasksData254_g263012 = float4( 0,0,0,0 );
					float4 In_MasksData16_g263030 = MasksData254_g263012;
					half4 Phase_Data176_g263012 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g263030 = Phase_Data176_g263012;
					BuildModelVertData( Data16_g263030 , In_Dummy16_g263030 , In_PositionOS16_g263030 , In_PositionWS16_g263030 , In_PositionWO16_g263030 , In_PivotOS16_g263030 , In_PivotWS16_g263030 , In_PivotWO16_g263030 , In_NormalOS16_g263030 , In_NormalWS16_g263030 , In_TangentOS16_g263030 , In_ViewDirWS16_g263030 , In_CoordsData16_g263030 , In_VertexData16_g263030 , In_MasksData16_g263030 , In_PhaseData16_g263030 );
					TVEModelData DataTerrain26_g263144 = Data16_g263030;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g263144 = IsShaderType2637;
					{
					if (Type26_g263144 == 0 )
					{
					Data26_g263144 = DataDefault26_g263144;
					}
					else if (Type26_g263144 == 1 )
					{
					Data26_g263144 = DataGeneral26_g263144;
					}
					else if (Type26_g263144 == 2 )
					{
					Data26_g263144 = DataBlanket26_g263144;
					}
					else if (Type26_g263144 == 3 )
					{
					Data26_g263144 = DataImpostor26_g263144;
					}
					else if (Type26_g263144 == 4 )
					{
					Data26_g263144 = DataTerrain26_g263144;
					}
					}
					TVEModelData Data15_g262850 =(TVEModelData)Data26_g263144;
					float Out_Dummy15_g262850 = 0.0;
					float3 Out_PositionOS15_g262850 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262850 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262850 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262850 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262850 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262850 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262850 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262850 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262850 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262850 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262850 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262850 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262850 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262850 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262850 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262850 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262850 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262850 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262850 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262850 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262850 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262850 , Out_Dummy15_g262850 , Out_PositionOS15_g262850 , Out_PositionWS15_g262850 , Out_PositionWO15_g262850 , Out_PositionRawOS15_g262850 , Out_PivotOS15_g262850 , Out_PivotWS15_g262850 , Out_PivotWO15_g262850 , Out_NormalOS15_g262850 , Out_NormalWS15_g262850 , Out_NormalRawOS15_g262850 , Out_TangentOS15_g262850 , Out_TangentWS15_g262850 , Out_BitangentWS15_g262850 , Out_ViewDirWS15_g262850 , Out_CoordsData15_g262850 , Out_VertexData15_g262850 , Out_MasksData15_g262850 , Out_PhaseData15_g262850 , Out_TransformData15_g262850 , Out_RotationData15_g262850 , Out_Interpolator15_g262850 );
					float3 In_PositionOS16_g262849 = Out_PositionOS15_g262850;
					float3 In_NormalOS16_g262849 = Out_NormalOS15_g262850;
					float4 In_TangentOS16_g262849 = Out_TangentOS15_g262850;
					float4 In_TransformData16_g262849 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g262849 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g262849 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g262849 , In_Dummy16_g262849 , In_PositionOS16_g262849 , In_NormalOS16_g262849 , In_TangentOS16_g262849 , In_TransformData16_g262849 , In_RotationData16_g262849 , In_Interpolator16_g262849 );
					TVEVertexData Data15_g262852 =(TVEVertexData)Data16_g262849;
					float Out_Dummy15_g262852 = 0.0;
					float3 Out_PositionOS15_g262852 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262852 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262852 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262852 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262852 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262852 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262852 , Out_Dummy15_g262852 , Out_PositionOS15_g262852 , Out_NormalOS15_g262852 , Out_TangentOS15_g262852 , Out_TransformData15_g262852 , Out_RotationData15_g262852 , Out_Interpolator15_g262852 );
					TVEModelData Data15_g262853 =(TVEModelData)Data15_g262850;
					float Out_Dummy15_g262853 = 0.0;
					float3 Out_PositionOS15_g262853 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262853 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262853 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262853 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262853 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262853 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262853 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262853 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262853 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262853 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262853 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262853 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262853 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262853 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262853 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262853 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262853 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262853 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262853 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262853 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262853 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262853 , Out_Dummy15_g262853 , Out_PositionOS15_g262853 , Out_PositionWS15_g262853 , Out_PositionWO15_g262853 , Out_PositionRawOS15_g262853 , Out_PivotOS15_g262853 , Out_PivotWS15_g262853 , Out_PivotWO15_g262853 , Out_NormalOS15_g262853 , Out_NormalWS15_g262853 , Out_NormalRawOS15_g262853 , Out_TangentOS15_g262853 , Out_TangentWS15_g262853 , Out_BitangentWS15_g262853 , Out_ViewDirWS15_g262853 , Out_CoordsData15_g262853 , Out_VertexData15_g262853 , Out_MasksData15_g262853 , Out_PhaseData15_g262853 , Out_TransformData15_g262853 , Out_RotationData15_g262853 , Out_Interpolator15_g262853 );
					float3 In_PositionOS16_g262854 = ( Out_PositionOS15_g262852 - Out_PivotOS15_g262853 );
					float3 In_NormalOS16_g262854 = Out_NormalOS15_g262853;
					float4 In_TangentOS16_g262854 = Out_TangentOS15_g262853;
					float4 In_TransformData16_g262854 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g262854 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g262854 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g262854 , In_Dummy16_g262854 , In_PositionOS16_g262854 , In_NormalOS16_g262854 , In_TangentOS16_g262854 , In_TransformData16_g262854 , In_RotationData16_g262854 , In_Interpolator16_g262854 );
					TVEVertexData Data15_g262858 =(TVEVertexData)Data16_g262854;
					float Out_Dummy15_g262858 = 0.0;
					float3 Out_PositionOS15_g262858 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262858 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262858 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262858 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262858 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262858 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262858 , Out_Dummy15_g262858 , Out_PositionOS15_g262858 , Out_NormalOS15_g262858 , Out_TangentOS15_g262858 , Out_TransformData15_g262858 , Out_RotationData15_g262858 , Out_Interpolator15_g262858 );
					TVEVertexData Data16_g262859 =(TVEVertexData)Data15_g262858;
					half Dummy181_g262855 = ( _PerspectiveCategory + _PerspectiveEnd );
					float In_Dummy16_g262859 = Dummy181_g262855;
					half3 Vertex_PositionOS147_g262855 = Out_PositionOS15_g262858;
					TVEModelData Data15_g262860 =(TVEModelData)Data15_g262853;
					float Out_Dummy15_g262860 = 0.0;
					float3 Out_PositionOS15_g262860 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262860 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262860 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262860 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262860 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262860 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262860 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262860 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262860 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262860 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262860 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262860 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262860 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262860 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262860 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262860 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262860 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262860 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262860 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262860 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262860 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262860 , Out_Dummy15_g262860 , Out_PositionOS15_g262860 , Out_PositionWS15_g262860 , Out_PositionWO15_g262860 , Out_PositionRawOS15_g262860 , Out_PivotOS15_g262860 , Out_PivotWS15_g262860 , Out_PivotWO15_g262860 , Out_NormalOS15_g262860 , Out_NormalWS15_g262860 , Out_NormalRawOS15_g262860 , Out_TangentOS15_g262860 , Out_TangentWS15_g262860 , Out_BitangentWS15_g262860 , Out_ViewDirWS15_g262860 , Out_CoordsData15_g262860 , Out_VertexData15_g262860 , Out_MasksData15_g262860 , Out_PhaseData15_g262860 , Out_TransformData15_g262860 , Out_RotationData15_g262860 , Out_Interpolator15_g262860 );
					half3 Model_ViewDirWS237_g262855 = Out_ViewDirWS15_g262860;
					float4x4 break117_g262856 = unity_CameraToWorld;
					float3 appendResult118_g262856 = (float3(break117_g262856[ 0 ][ 2 ] , break117_g262856[ 1 ][ 2 ] , break117_g262856[ 2 ][ 2 ]));
					float3 lerpResult209_g262855 = lerp( Model_ViewDirWS237_g262855 , -appendResult118_g262856 , unity_OrthoParams.w);
					float3 break201_g262855 = cross( lerpResult209_g262855 , half3( 0, 1, 0 ) );
					float3 appendResult196_g262855 = (float3(-break201_g262855.z , 0.0 , break201_g262855.x));
					half4 Model_PhaseData218_g262855 = Out_PhaseData15_g262860;
					float2 break226_g262855 = ( (Model_PhaseData218_g262855).xy * 5.0 * _PerspectivePhaseValue );
					float3 appendResult224_g262855 = (float3(break226_g262855.x , 0.0 , break226_g262855.y));
					float dotResult189_g262855 = dot( Model_ViewDirWS237_g262855 , float3( 0, 1, 0 ) );
					float saferPower192_g262855 = abs( dotResult189_g262855 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g262857 = (Vertex_PositionOS147_g262855).z;
					#else
					float staticSwitch65_g262857 = (Vertex_PositionOS147_g262855).y;
					#endif
					float3 temp_output_206_0_g262855 = ( Vertex_PositionOS147_g262855 + ( ( mul( unity_WorldToObject, float4( appendResult196_g262855 , 0.0 ) ).xyz + appendResult224_g262855 ) * _PerspectiveIntensityValue * pow( saferPower192_g262855 , _PerspectiveAngleValue ) * saturate( staticSwitch65_g262857 ) ) );
					#ifdef TVE_PERSPECTIVE
					float3 staticSwitch211_g262855 = temp_output_206_0_g262855;
					#else
					float3 staticSwitch211_g262855 = Vertex_PositionOS147_g262855;
					#endif
					float3 Final_Position178_g262855 = staticSwitch211_g262855;
					float3 In_PositionOS16_g262859 = Final_Position178_g262855;
					float3 In_NormalOS16_g262859 = Out_NormalOS15_g262858;
					float4 In_TangentOS16_g262859 = Out_TangentOS15_g262858;
					float4 In_TransformData16_g262859 = Out_TransformData15_g262858;
					float4 In_RotationData16_g262859 = Out_RotationData15_g262858;
					float4 In_Interpolator16_g262859 = Out_Interpolator15_g262858;
					BuildVertexData( Data16_g262859 , In_Dummy16_g262859 , In_PositionOS16_g262859 , In_NormalOS16_g262859 , In_TangentOS16_g262859 , In_TransformData16_g262859 , In_RotationData16_g262859 , In_Interpolator16_g262859 );
					TVEVertexData Data15_g262869 =(TVEVertexData)Data16_g262859;
					float Out_Dummy15_g262869 = 0.0;
					float3 Out_PositionOS15_g262869 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262869 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262869 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262869 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262869 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262869 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262869 , Out_Dummy15_g262869 , Out_PositionOS15_g262869 , Out_NormalOS15_g262869 , Out_TangentOS15_g262869 , Out_TransformData15_g262869 , Out_RotationData15_g262869 , Out_Interpolator15_g262869 );
					TVEVertexData Data16_g262870 =(TVEVertexData)Data15_g262869;
					half Dummy317_g262861 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g262870 = Dummy317_g262861;
					float3 In_PositionOS16_g262870 = Out_PositionOS15_g262869;
					float3 In_NormalOS16_g262870 = Out_NormalOS15_g262869;
					float4 In_TangentOS16_g262870 = Out_TangentOS15_g262869;
					half4 Model_TransformData356_g262861 = Out_TransformData15_g262869;
					float localBuildGlobalData204_g262442 = ( 0.0 );
					TVEGlobalData Data204_g262442 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g262442 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g262442 = Dummy211_g262442;
					float4 temp_output_203_0_g262461 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g262420 = ( 0.0 );
					TVEModelData Data26_g262420 = (TVEModelData)0;
					TVEModelData DataDefault26_g262420 = Data16_g263030;
					TVEModelData Data16_g263040 =(TVEModelData)0;
					float In_Dummy16_g263040 = 0.0;
					float3 In_PositionWS16_g263040 = PositionWS122_g263032;
					float3 In_PositionWO16_g263040 = PositionWO132_g263032;
					float3 In_PivotWS16_g263040 = PivotWS121_g263032;
					float3 In_PivotWO16_g263040 = PivotWO133_g263032;
					float3 In_NormalWS16_g263040 = NormalWS95_g263032;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g263032 = ase_tangentWS;
					float3 In_TangentWS16_g263040 = TangentWS136_g263032;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g263032 = ase_bitangentWS;
					float3 In_BitangentWS16_g263040 = BiangentWS421_g263032;
					half3 NormalWS427_g263032 = NormalWS95_g263032;
					half3 localComputeTriplanarMasks427_g263032 = ComputeTriplanarMasks( NormalWS427_g263032 );
					half3 TriplanarWeights429_g263032 = localComputeTriplanarMasks427_g263032;
					float3 In_TriplanarWeights16_g263040 = TriplanarWeights429_g263032;
					float3 In_ViewDirWS16_g263040 = ViewDirWS169_g263032;
					float4 In_CoordsData16_g263040 = CoordsData398_g263032;
					float4 In_VertexData16_g263040 = VertexMasks171_g263032;
					float4 In_Interpolator16_g263040 = Phase_Data176_g263032;
					BuildModelFragData( Data16_g263040 , In_Dummy16_g263040 , In_PositionWS16_g263040 , In_PositionWO16_g263040 , In_PivotWS16_g263040 , In_PivotWO16_g263040 , In_NormalWS16_g263040 , In_TangentWS16_g263040 , In_BitangentWS16_g263040 , In_TriplanarWeights16_g263040 , In_ViewDirWS16_g263040 , In_CoordsData16_g263040 , In_VertexData16_g263040 , In_Interpolator16_g263040 );
					TVEModelData DataGeneral26_g262420 = Data16_g263040;
					TVEModelData DataBlanket26_g262420 = Data16_g263040;
					TVEModelData DataImpostor26_g262420 = Data16_g263040;
					TVEModelData Data16_g263020 =(TVEModelData)0;
					float In_Dummy16_g263020 = 0.0;
					float3 In_PositionWS16_g263020 = PositionWS122_g263012;
					float3 In_PositionWO16_g263020 = PositionWO132_g263012;
					float3 In_PivotWS16_g263020 = PivotWS121_g263012;
					float3 In_PivotWO16_g263020 = PivotWO133_g263012;
					float3 In_NormalWS16_g263020 = NormalWS95_g263012;
					half3 TangentWS136_g263012 = ase_tangentWS;
					float3 In_TangentWS16_g263020 = TangentWS136_g263012;
					half3 BiangentWS421_g263012 = ase_bitangentWS;
					float3 In_BitangentWS16_g263020 = BiangentWS421_g263012;
					half3 NormalWS427_g263012 = NormalWS95_g263012;
					half3 localComputeTriplanarMasks427_g263012 = ComputeTriplanarMasks( NormalWS427_g263012 );
					half3 TriplanarWeights429_g263012 = localComputeTriplanarMasks427_g263012;
					float3 In_TriplanarWeights16_g263020 = TriplanarWeights429_g263012;
					float3 In_ViewDirWS16_g263020 = ViewDirWS169_g263012;
					float4 In_CoordsData16_g263020 = CoordsData398_g263012;
					float4 In_VertexData16_g263020 = VertexMasks171_g263012;
					float4 In_Interpolator16_g263020 = Phase_Data176_g263012;
					BuildModelFragData( Data16_g263020 , In_Dummy16_g263020 , In_PositionWS16_g263020 , In_PositionWO16_g263020 , In_PivotWS16_g263020 , In_PivotWO16_g263020 , In_NormalWS16_g263020 , In_TangentWS16_g263020 , In_BitangentWS16_g263020 , In_TriplanarWeights16_g263020 , In_ViewDirWS16_g263020 , In_CoordsData16_g263020 , In_VertexData16_g263020 , In_Interpolator16_g263020 );
					TVEModelData DataTerrain26_g262420 = Data16_g263020;
					float Type26_g262420 = IsShaderType2637;
					{
					if (Type26_g262420 == 0 )
					{
					Data26_g262420 = DataDefault26_g262420;
					}
					else if (Type26_g262420 == 1 )
					{
					Data26_g262420 = DataGeneral26_g262420;
					}
					else if (Type26_g262420 == 2 )
					{
					Data26_g262420 = DataBlanket26_g262420;
					}
					else if (Type26_g262420 == 3 )
					{
					Data26_g262420 = DataImpostor26_g262420;
					}
					else if (Type26_g262420 == 4 )
					{
					Data26_g262420 = DataTerrain26_g262420;
					}
					}
					TVEModelData Data15_g262532 =(TVEModelData)Data26_g262420;
					float Out_Dummy15_g262532 = 0.0;
					float3 Out_PositionWS15_g262532 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262532 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262532 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262532 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262532 = float3( 0,0,0 );
					float3 Out_TangentWS15_g262532 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262532 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g262532 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262532 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262532 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262532 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262532 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g262532 , Out_Dummy15_g262532 , Out_PositionWS15_g262532 , Out_PositionWO15_g262532 , Out_PivotWS15_g262532 , Out_PivotWO15_g262532 , Out_NormalWS15_g262532 , Out_TangentWS15_g262532 , Out_BitangentWS15_g262532 , Out_TriplanarWeights15_g262532 , Out_ViewDirWS15_g262532 , Out_CoordsData15_g262532 , Out_VertexData15_g262532 , Out_Interpolator15_g262532 );
					float3 Model_PositionWS497_g262442 = Out_PositionWS15_g262532;
					float2 Model_PositionWS_XZ143_g262442 = (Model_PositionWS497_g262442).xz;
					float3 Model_PivotWS498_g262442 = Out_PivotWS15_g262532;
					float2 Model_PivotWS_XZ145_g262442 = (Model_PivotWS498_g262442).xz;
					float2 lerpResult300_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g262461 = lerpResult300_g262442;
					float temp_output_82_0_g262459 = _GlobalCoatLayerValue;
					float temp_output_82_0_g262461 = temp_output_82_0_g262459;
					float4 tex2DArrayNode83_g262461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262461).zw + ( (temp_output_203_0_g262461).xy * temp_output_81_0_g262461 ) ),temp_output_82_0_g262461), 0.0 );
					float4 appendResult210_g262461 = (float4(tex2DArrayNode83_g262461.rgb , tex2DArrayNode83_g262461.a));
					float4 temp_output_204_0_g262461 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g262461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262461).zw + ( (temp_output_204_0_g262461).xy * temp_output_81_0_g262461 ) ),temp_output_82_0_g262461), 0.0 );
					float4 appendResult212_g262461 = (float4(tex2DArrayNode122_g262461.rgb , tex2DArrayNode122_g262461.a));
					float4 TVE_RenderNearPositionR628_g262442 = TVE_RenderNearPositionR;
					float temp_output_507_0_g262442 = saturate( ( distance( Model_PositionWS497_g262442 , (TVE_RenderNearPositionR628_g262442).xyz ) / (TVE_RenderNearPositionR628_g262442).w ) );
					float temp_output_7_0_g262531 = 1.0;
					float temp_output_9_0_g262531 = ( temp_output_507_0_g262442 - temp_output_7_0_g262531 );
					half TVE_RenderNearFadeValue635_g262442 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g262442 = saturate( ( temp_output_9_0_g262531 / ( ( TVE_RenderNearFadeValue635_g262442 - temp_output_7_0_g262531 ) + 0.0001 ) ) );
					float4 lerpResult131_g262461 = lerp( appendResult210_g262461 , appendResult212_g262461 , Global_TexBlend509_g262442);
					float4 temp_output_159_109_g262459 = lerpResult131_g262461;
					float4 lerpResult168_g262459 = lerp( TVE_CoatParams , temp_output_159_109_g262459 , TVE_CoatLayers[(int)temp_output_82_0_g262459]);
					float4 temp_output_589_109_g262442 = lerpResult168_g262459;
					half4 Coat_Texture302_g262442 = temp_output_589_109_g262442;
					float4 In_CoatTexture204_g262442 = Coat_Texture302_g262442;
					half4 Draw_Texture656_g262442 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g262442 = Draw_Texture656_g262442;
					float4 temp_output_203_0_g262486 = TVE_PaintBaseCoord;
					float2 lerpResult85_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g262486 = lerpResult85_g262442;
					float temp_output_82_0_g262483 = _GlobalPaintLayerValue;
					float temp_output_82_0_g262486 = temp_output_82_0_g262483;
					float4 tex2DArrayNode83_g262486 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262486).zw + ( (temp_output_203_0_g262486).xy * temp_output_81_0_g262486 ) ),temp_output_82_0_g262486), 0.0 );
					float4 appendResult210_g262486 = (float4(tex2DArrayNode83_g262486.rgb , tex2DArrayNode83_g262486.a));
					float4 temp_output_204_0_g262486 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g262486 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262486).zw + ( (temp_output_204_0_g262486).xy * temp_output_81_0_g262486 ) ),temp_output_82_0_g262486), 0.0 );
					float4 appendResult212_g262486 = (float4(tex2DArrayNode122_g262486.rgb , tex2DArrayNode122_g262486.a));
					float4 lerpResult131_g262486 = lerp( appendResult210_g262486 , appendResult212_g262486 , Global_TexBlend509_g262442);
					float4 temp_output_171_109_g262483 = lerpResult131_g262486;
					float4 lerpResult174_g262483 = lerp( TVE_PaintParams , temp_output_171_109_g262483 , TVE_PaintLayers[(int)temp_output_82_0_g262483]);
					float4 temp_output_595_109_g262442 = lerpResult174_g262483;
					half4 Paint_Texture71_g262442 = temp_output_595_109_g262442;
					float4 In_PaintTexture204_g262442 = Paint_Texture71_g262442;
					float4 temp_output_203_0_g262469 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g262469 = lerpResult104_g262442;
					float temp_output_132_0_g262467 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g262469 = temp_output_132_0_g262467;
					float4 tex2DArrayNode83_g262469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262469).zw + ( (temp_output_203_0_g262469).xy * temp_output_81_0_g262469 ) ),temp_output_82_0_g262469), 0.0 );
					float4 appendResult210_g262469 = (float4(tex2DArrayNode83_g262469.rgb , tex2DArrayNode83_g262469.a));
					float4 temp_output_204_0_g262469 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g262469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262469).zw + ( (temp_output_204_0_g262469).xy * temp_output_81_0_g262469 ) ),temp_output_82_0_g262469), 0.0 );
					float4 appendResult212_g262469 = (float4(tex2DArrayNode122_g262469.rgb , tex2DArrayNode122_g262469.a));
					float4 lerpResult131_g262469 = lerp( appendResult210_g262469 , appendResult212_g262469 , Global_TexBlend509_g262442);
					float4 temp_output_137_109_g262467 = lerpResult131_g262469;
					float4 lerpResult145_g262467 = lerp( TVE_AtmoParams , temp_output_137_109_g262467 , TVE_AtmoLayers[(int)temp_output_132_0_g262467]);
					float4 temp_output_590_110_g262442 = lerpResult145_g262467;
					half4 Atmo_Texture80_g262442 = temp_output_590_110_g262442;
					float4 In_AtmoTexture204_g262442 = Atmo_Texture80_g262442;
					float4 temp_output_203_0_g262537 = TVE_EffexBaseCoord;
					float2 lerpResult414_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g262537 = lerpResult414_g262442;
					float temp_output_132_0_g262535 = _GlobalEffexLayerValue;
					float temp_output_82_0_g262537 = temp_output_132_0_g262535;
					float4 tex2DArrayNode83_g262537 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262537).zw + ( (temp_output_203_0_g262537).xy * temp_output_81_0_g262537 ) ),temp_output_82_0_g262537), 0.0 );
					float4 appendResult210_g262537 = (float4(tex2DArrayNode83_g262537.rgb , tex2DArrayNode83_g262537.a));
					float4 temp_output_204_0_g262537 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g262537 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262537).zw + ( (temp_output_204_0_g262537).xy * temp_output_81_0_g262537 ) ),temp_output_82_0_g262537), 0.0 );
					float4 appendResult212_g262537 = (float4(tex2DArrayNode122_g262537.rgb , tex2DArrayNode122_g262537.a));
					float4 lerpResult131_g262537 = lerp( appendResult210_g262537 , appendResult212_g262537 , Global_TexBlend509_g262442);
					float4 temp_output_137_109_g262535 = lerpResult131_g262537;
					float4 lerpResult145_g262535 = lerp( TVE_EffexParams , temp_output_137_109_g262535 , TVE_EffexLayers[(int)temp_output_132_0_g262535]);
					float4 temp_output_731_110_g262442 = lerpResult145_g262535;
					half4 Effex_Texture420_g262442 = temp_output_731_110_g262442;
					float4 In_EffexTexture204_g262442 = Effex_Texture420_g262442;
					float4 temp_output_203_0_g262517 = TVE_GlowBaseCoord;
					float2 lerpResult247_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g262517 = lerpResult247_g262442;
					float temp_output_82_0_g262515 = _GlobalGlowLayerValue;
					float temp_output_82_0_g262517 = temp_output_82_0_g262515;
					float4 tex2DArrayNode83_g262517 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262517).zw + ( (temp_output_203_0_g262517).xy * temp_output_81_0_g262517 ) ),temp_output_82_0_g262517), 0.0 );
					float4 appendResult210_g262517 = (float4(tex2DArrayNode83_g262517.rgb , tex2DArrayNode83_g262517.a));
					float4 temp_output_204_0_g262517 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g262517 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262517).zw + ( (temp_output_204_0_g262517).xy * temp_output_81_0_g262517 ) ),temp_output_82_0_g262517), 0.0 );
					float4 appendResult212_g262517 = (float4(tex2DArrayNode122_g262517.rgb , tex2DArrayNode122_g262517.a));
					float4 lerpResult131_g262517 = lerp( appendResult210_g262517 , appendResult212_g262517 , Global_TexBlend509_g262442);
					float4 temp_output_159_109_g262515 = lerpResult131_g262517;
					float4 lerpResult167_g262515 = lerp( TVE_GlowParams , temp_output_159_109_g262515 , TVE_GlowLayers[(int)temp_output_82_0_g262515]);
					float4 temp_output_593_109_g262442 = lerpResult167_g262515;
					half4 Glow_Texture248_g262442 = temp_output_593_109_g262442;
					float4 In_GlowTexture204_g262442 = Glow_Texture248_g262442;
					float4 temp_output_203_0_g262453 = TVE_FormBaseCoord;
					float2 lerpResult168_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g262453 = lerpResult168_g262442;
					float temp_output_130_0_g262451 = _GlobalFormLayerValue;
					float temp_output_82_0_g262453 = temp_output_130_0_g262451;
					float4 tex2DArrayNode83_g262453 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262453).zw + ( (temp_output_203_0_g262453).xy * temp_output_81_0_g262453 ) ),temp_output_82_0_g262453), 0.0 );
					float4 appendResult210_g262453 = (float4(tex2DArrayNode83_g262453.rgb , tex2DArrayNode83_g262453.a));
					float4 temp_output_204_0_g262453 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g262453 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262453).zw + ( (temp_output_204_0_g262453).xy * temp_output_81_0_g262453 ) ),temp_output_82_0_g262453), 0.0 );
					float4 appendResult212_g262453 = (float4(tex2DArrayNode122_g262453.rgb , tex2DArrayNode122_g262453.a));
					float4 lerpResult131_g262453 = lerp( appendResult210_g262453 , appendResult212_g262453 , Global_TexBlend509_g262442);
					float4 temp_output_135_109_g262451 = lerpResult131_g262453;
					float4 lerpResult143_g262451 = lerp( TVE_FormParams , temp_output_135_109_g262451 , TVE_FormLayers[(int)temp_output_130_0_g262451]);
					float4 temp_output_592_0_g262442 = lerpResult143_g262451;
					float4 Form_Texture112_g262442 = temp_output_592_0_g262442;
					float4 In_FormTexture204_g262442 = Form_Texture112_g262442;
					float4 In_LandTexture204_g262442 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g262501 = TVE_VertxBaseCoord;
					float2 lerpResult681_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g262501 = lerpResult681_g262442;
					float temp_output_136_0_g262499 = _GlobalVertxLayerValue;
					float temp_output_82_0_g262501 = temp_output_136_0_g262499;
					float4 tex2DArrayNode83_g262501 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262501).zw + ( (temp_output_203_0_g262501).xy * temp_output_81_0_g262501 ) ),temp_output_82_0_g262501), 0.0 );
					float4 appendResult210_g262501 = (float4(tex2DArrayNode83_g262501.rgb , tex2DArrayNode83_g262501.a));
					float4 temp_output_204_0_g262501 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g262501 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262501).zw + ( (temp_output_204_0_g262501).xy * temp_output_81_0_g262501 ) ),temp_output_82_0_g262501), 0.0 );
					float4 appendResult212_g262501 = (float4(tex2DArrayNode122_g262501.rgb , tex2DArrayNode122_g262501.a));
					float4 lerpResult131_g262501 = lerp( appendResult210_g262501 , appendResult212_g262501 , Global_TexBlend509_g262442);
					float4 temp_output_141_109_g262499 = lerpResult131_g262501;
					float4 lerpResult149_g262499 = lerp( TVE_VertxParams , temp_output_141_109_g262499 , TVE_VertxLayers[(int)temp_output_136_0_g262499]);
					float4 temp_output_695_0_g262442 = lerpResult149_g262499;
					half4 Vertx_Texture693_g262442 = temp_output_695_0_g262442;
					float4 In_VertxTexture204_g262442 = Vertx_Texture693_g262442;
					float4 temp_output_203_0_g262477 = TVE_FlowBaseCoord;
					float2 lerpResult400_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g262477 = lerpResult400_g262442;
					float temp_output_136_0_g262475 = _GlobalFlowLayerValue;
					float temp_output_82_0_g262477 = temp_output_136_0_g262475;
					float4 tex2DArrayNode83_g262477 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262477).zw + ( (temp_output_203_0_g262477).xy * temp_output_81_0_g262477 ) ),temp_output_82_0_g262477), 0.0 );
					float4 appendResult210_g262477 = (float4(tex2DArrayNode83_g262477.rgb , tex2DArrayNode83_g262477.a));
					float4 temp_output_204_0_g262477 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g262477 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262477).zw + ( (temp_output_204_0_g262477).xy * temp_output_81_0_g262477 ) ),temp_output_82_0_g262477), 0.0 );
					float4 appendResult212_g262477 = (float4(tex2DArrayNode122_g262477.rgb , tex2DArrayNode122_g262477.a));
					float4 lerpResult131_g262477 = lerp( appendResult210_g262477 , appendResult212_g262477 , Global_TexBlend509_g262442);
					float4 temp_output_141_109_g262475 = lerpResult131_g262477;
					float4 lerpResult149_g262475 = lerp( TVE_FlowParams , temp_output_141_109_g262475 , TVE_FlowLayers[(int)temp_output_136_0_g262475]);
					float4 temp_output_594_0_g262442 = lerpResult149_g262475;
					half4 Flow_Texture405_g262442 = temp_output_594_0_g262442;
					float4 In_FlowTexture204_g262442 = Flow_Texture405_g262442;
					half4 User_Texture677_g262442 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g262442 = User_Texture677_g262442;
					BuildGlobalData( Data204_g262442 , In_Dummy204_g262442 , In_CoatTexture204_g262442 , In_DrawTexture204_g262442 , In_PaintTexture204_g262442 , In_AtmoTexture204_g262442 , In_EffexTexture204_g262442 , In_GlowTexture204_g262442 , In_FormTexture204_g262442 , In_LandTexture204_g262442 , In_VertxTexture204_g262442 , In_FlowTexture204_g262442 , In_UserTexture204_g262442 );
					TVEGlobalData Data15_g262871 =(TVEGlobalData)Data204_g262442;
					float Out_Dummy15_g262871 = 0.0;
					float4 Out_CoatTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g262871 = float4( 0,0,0,0 );
					BreakData( Data15_g262871 , Out_Dummy15_g262871 , Out_CoatTexture15_g262871 , Out_DrawTexture15_g262871 , Out_PaintTexture15_g262871 , Out_AtmoTexture15_g262871 , Out_EffexTexture15_g262871 , Out_GlowTexture15_g262871 , Out_FormTexture15_g262871 , Out_LandTexture15_g262871 , Out_VertxTexture15_g262871 , Out_FlowTexture15_g262871 , Out_UserTexture15_g262871 );
					float4 Global_FormTexture351_g262861 = Out_FormTexture15_g262871;
					TVEModelData Data15_g262868 =(TVEModelData)Data15_g262860;
					float Out_Dummy15_g262868 = 0.0;
					float3 Out_PositionOS15_g262868 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262868 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262868 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262868 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262868 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262868 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262868 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262868 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262868 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262868 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262868 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262868 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262868 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262868 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262868 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262868 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262868 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262868 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262868 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262868 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262868 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262868 , Out_Dummy15_g262868 , Out_PositionOS15_g262868 , Out_PositionWS15_g262868 , Out_PositionWO15_g262868 , Out_PositionRawOS15_g262868 , Out_PivotOS15_g262868 , Out_PivotWS15_g262868 , Out_PivotWO15_g262868 , Out_NormalOS15_g262868 , Out_NormalWS15_g262868 , Out_NormalRawOS15_g262868 , Out_TangentOS15_g262868 , Out_TangentWS15_g262868 , Out_BitangentWS15_g262868 , Out_ViewDirWS15_g262868 , Out_CoordsData15_g262868 , Out_VertexData15_g262868 , Out_MasksData15_g262868 , Out_PhaseData15_g262868 , Out_TransformData15_g262868 , Out_RotationData15_g262868 , Out_Interpolator15_g262868 );
					float3 Model_PivotWO353_g262861 = Out_PivotWO15_g262868;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g262867 = _ConformMeshMode;
					float Option70_g262867 = temp_output_17_0_g262867;
					half4 Model_VertexData357_g262861 = Out_VertexData15_g262868;
					float4 temp_output_3_0_g262867 = Model_VertexData357_g262861;
					float4 Channel70_g262867 = temp_output_3_0_g262867;
					float localSwitchChannel470_g262867 = SwitchChannel4( Option70_g262867 , Channel70_g262867 );
					float temp_output_390_0_g262861 = localSwitchChannel470_g262867;
					float temp_output_7_0_g262864 = _ConformMeshRemap.x;
					float temp_output_9_0_g262864 = ( temp_output_390_0_g262861 - temp_output_7_0_g262864 );
					float lerpResult374_g262861 = lerp( 1.0 , saturate( ( temp_output_9_0_g262864 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g262861 = lerpResult374_g262861;
					float temp_output_328_0_g262861 = ( Blend_VertMask379_g262861 * TVE_IsEnabled );
					half Conform_Mask366_g262861 = temp_output_328_0_g262861;
					float temp_output_322_0_g262861 = ( ( ( ( (Global_FormTexture351_g262861).z - ( (Model_PivotWO353_g262861).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g262861 ) );
					float3 appendResult329_g262861 = (float3(0.0 , temp_output_322_0_g262861 , 0.0));
					float3 appendResult387_g262861 = (float3(0.0 , 0.0 , temp_output_322_0_g262861));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262865 = appendResult387_g262861;
					#else
					float3 staticSwitch65_g262865 = appendResult329_g262861;
					#endif
					float3 Blanket_Conform368_g262861 = staticSwitch65_g262865;
					float4 appendResult312_g262861 = (float4(Blanket_Conform368_g262861 , 0.0));
					float4 temp_output_310_0_g262861 = ( Model_TransformData356_g262861 + appendResult312_g262861 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g262861 = temp_output_310_0_g262861;
					#else
					float4 staticSwitch364_g262861 = Model_TransformData356_g262861;
					#endif
					half4 Final_TransformData365_g262861 = staticSwitch364_g262861;
					float4 In_TransformData16_g262870 = Final_TransformData365_g262861;
					float4 In_RotationData16_g262870 = Out_RotationData15_g262869;
					float4 In_Interpolator16_g262870 = Out_Interpolator15_g262869;
					BuildVertexData( Data16_g262870 , In_Dummy16_g262870 , In_PositionOS16_g262870 , In_NormalOS16_g262870 , In_TangentOS16_g262870 , In_TransformData16_g262870 , In_RotationData16_g262870 , In_Interpolator16_g262870 );
					TVEVertexData Data15_g262878 =(TVEVertexData)Data16_g262870;
					float Out_Dummy15_g262878 = 0.0;
					float3 Out_PositionOS15_g262878 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262878 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262878 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262878 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262878 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262878 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262878 , Out_Dummy15_g262878 , Out_PositionOS15_g262878 , Out_NormalOS15_g262878 , Out_TangentOS15_g262878 , Out_TransformData15_g262878 , Out_RotationData15_g262878 , Out_Interpolator15_g262878 );
					TVEVertexData Data16_g262879 =(TVEVertexData)Data15_g262878;
					half Dummy181_g262872 = ( _RotationCategory + _RotationEnd + _RotationInfo );
					float In_Dummy16_g262879 = Dummy181_g262872;
					float3 In_PositionOS16_g262879 = Out_PositionOS15_g262878;
					float3 In_NormalOS16_g262879 = Out_NormalOS15_g262878;
					float4 In_TangentOS16_g262879 = Out_TangentOS15_g262878;
					float4 In_TransformData16_g262879 = Out_TransformData15_g262878;
					half4 Model_RotationData212_g262872 = Out_RotationData15_g262878;
					TVEGlobalData Data15_g262873 =(TVEGlobalData)Data15_g262871;
					float Out_Dummy15_g262873 = 0.0;
					float4 Out_CoatTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g262873 = float4( 0,0,0,0 );
					BreakData( Data15_g262873 , Out_Dummy15_g262873 , Out_CoatTexture15_g262873 , Out_DrawTexture15_g262873 , Out_PaintTexture15_g262873 , Out_AtmoTexture15_g262873 , Out_EffexTexture15_g262873 , Out_GlowTexture15_g262873 , Out_FormTexture15_g262873 , Out_LandTexture15_g262873 , Out_VertxTexture15_g262873 , Out_FlowTexture15_g262873 , Out_UserTexture15_g262873 );
					half4 Global_FormTexture188_g262872 = Out_FormTexture15_g262873;
					float2 temp_output_38_0_g262874 = ((Global_FormTexture188_g262872).xy*2.0 + -1.0);
					float2 break83_g262874 = temp_output_38_0_g262874;
					float3 appendResult79_g262874 = (float3(break83_g262874.x , 0.0 , break83_g262874.y));
					float3 ase_parentObjectScale = ( 1.0 / float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ) );
					float2 lerpResult227_g262872 = lerp( float2( 0,0 ) , (( mul( unity_WorldToObject, float4( appendResult79_g262874 , 0.0 ) ).xyz * ase_parentObjectScale )).xz , ( _RotationIntensityValue * TVE_IsEnabled ));
					half2 Blanket_Orientation192_g262872 = lerpResult227_g262872;
					float4 appendResult222_g262872 = (float4(( (Model_RotationData212_g262872).xy + Blanket_Orientation192_g262872 ) , (Model_RotationData212_g262872).zw));
					#ifdef TVE_ROTATION
					float4 staticSwitch218_g262872 = appendResult222_g262872;
					#else
					float4 staticSwitch218_g262872 = Model_RotationData212_g262872;
					#endif
					half4 Final_RotationData225_g262872 = staticSwitch218_g262872;
					float4 In_RotationData16_g262879 = Final_RotationData225_g262872;
					float4 In_Interpolator16_g262879 = Out_Interpolator15_g262878;
					BuildVertexData( Data16_g262879 , In_Dummy16_g262879 , In_PositionOS16_g262879 , In_NormalOS16_g262879 , In_TangentOS16_g262879 , In_TransformData16_g262879 , In_RotationData16_g262879 , In_Interpolator16_g262879 );
					TVEVertexData Data15_g262887 =(TVEVertexData)Data16_g262879;
					float Out_Dummy15_g262887 = 0.0;
					float3 Out_PositionOS15_g262887 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262887 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262887 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262887 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262887 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262887 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262887 , Out_Dummy15_g262887 , Out_PositionOS15_g262887 , Out_NormalOS15_g262887 , Out_TangentOS15_g262887 , Out_TransformData15_g262887 , Out_RotationData15_g262887 , Out_Interpolator15_g262887 );
					TVEVertexData Data16_g262888 =(TVEVertexData)Data15_g262887;
					half Dummy181_g262880 = ( _SizeFadeCategory + _SizeFadeEnd );
					float In_Dummy16_g262888 = Dummy181_g262880;
					float3 Model_PositionOS147_g262880 = Out_PositionOS15_g262887;
					float3 temp_cast_17 = (1.0).xxx;
					TVEModelData Data15_g262877 =(TVEModelData)Data15_g262868;
					float Out_Dummy15_g262877 = 0.0;
					float3 Out_PositionOS15_g262877 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262877 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262877 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262877 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262877 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262877 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262877 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262877 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262877 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262877 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262877 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262877 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262877 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262877 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262877 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262877 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262877 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262877 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262877 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262877 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262877 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262877 , Out_Dummy15_g262877 , Out_PositionOS15_g262877 , Out_PositionWS15_g262877 , Out_PositionWO15_g262877 , Out_PositionRawOS15_g262877 , Out_PivotOS15_g262877 , Out_PivotWS15_g262877 , Out_PivotWO15_g262877 , Out_NormalOS15_g262877 , Out_NormalWS15_g262877 , Out_NormalRawOS15_g262877 , Out_TangentOS15_g262877 , Out_TangentWS15_g262877 , Out_BitangentWS15_g262877 , Out_ViewDirWS15_g262877 , Out_CoordsData15_g262877 , Out_VertexData15_g262877 , Out_MasksData15_g262877 , Out_PhaseData15_g262877 , Out_TransformData15_g262877 , Out_RotationData15_g262877 , Out_Interpolator15_g262877 );
					TVEModelData Data15_g262889 =(TVEModelData)Data15_g262877;
					float Out_Dummy15_g262889 = 0.0;
					float3 Out_PositionOS15_g262889 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262889 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262889 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262889 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262889 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262889 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262889 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262889 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262889 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262889 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262889 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262889 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262889 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262889 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262889 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262889 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262889 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262889 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262889 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262889 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262889 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262889 , Out_Dummy15_g262889 , Out_PositionOS15_g262889 , Out_PositionWS15_g262889 , Out_PositionWO15_g262889 , Out_PositionRawOS15_g262889 , Out_PivotOS15_g262889 , Out_PivotWS15_g262889 , Out_PivotWO15_g262889 , Out_NormalOS15_g262889 , Out_NormalWS15_g262889 , Out_NormalRawOS15_g262889 , Out_TangentOS15_g262889 , Out_TangentWS15_g262889 , Out_BitangentWS15_g262889 , Out_ViewDirWS15_g262889 , Out_CoordsData15_g262889 , Out_VertexData15_g262889 , Out_MasksData15_g262889 , Out_PhaseData15_g262889 , Out_TransformData15_g262889 , Out_RotationData15_g262889 , Out_Interpolator15_g262889 );
					float3 Model_PivotWS162_g262880 = Out_PivotWS15_g262889;
					float lerpResult216_g262880 = lerp( 1.0 , TVE_SizeFadeParams.z , TVE_SizeFadeParams.w);
					float temp_output_7_0_g262882 = _SizeFadeDistMaxValue;
					float temp_output_9_0_g262882 = ( ( distance( _WorldSpaceCameraPos , Model_PivotWS162_g262880 ) * lerpResult216_g262880 ) - temp_output_7_0_g262882 );
					float temp_output_245_0_g262880 = (TVE_VertxParams).x;
					TVEGlobalData Data15_g262890 =(TVEGlobalData)Data15_g262873;
					float Out_Dummy15_g262890 = 0.0;
					float4 Out_CoatTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g262890 = float4( 0,0,0,0 );
					BreakData( Data15_g262890 , Out_Dummy15_g262890 , Out_CoatTexture15_g262890 , Out_DrawTexture15_g262890 , Out_PaintTexture15_g262890 , Out_AtmoTexture15_g262890 , Out_EffexTexture15_g262890 , Out_GlowTexture15_g262890 , Out_FormTexture15_g262890 , Out_LandTexture15_g262890 , Out_VertxTexture15_g262890 , Out_FlowTexture15_g262890 , Out_UserTexture15_g262890 );
					half4 Global_VertxTexture188_g262880 = Out_VertxTexture15_g262890;
					float temp_output_6_0_g262886 = (Global_VertxTexture188_g262880).x;
					float temp_output_7_0_g262886 = _SizeFadeVertxMode;
					#ifdef TVE_DUMMY
					float staticSwitch14_g262886 = ( temp_output_6_0_g262886 + temp_output_7_0_g262886 );
					#else
					float staticSwitch14_g262886 = temp_output_6_0_g262886;
					#endif
					float temp_output_223_0_g262880 = staticSwitch14_g262886;
					#ifdef TVE_SIZEFADE_VERTX
					float staticSwitch194_g262880 = temp_output_223_0_g262880;
					#else
					float staticSwitch194_g262880 = temp_output_245_0_g262880;
					#endif
					float lerpResult213_g262880 = lerp( 1.0 , staticSwitch194_g262880 , ( _SizeFadeVertxValue * TVE_IsEnabled ));
					half Blend_GlobalMask192_g262880 = lerpResult213_g262880;
					half Blend_UserMask232_g262880 = 1.0;
					float temp_output_236_0_g262880 = ( Blend_GlobalMask192_g262880 * Blend_UserMask232_g262880 );
					half Blend_Mask240_g262880 = temp_output_236_0_g262880;
					float temp_output_189_0_g262880 = ( saturate( ( temp_output_9_0_g262882 / ( ( _SizeFadeDistMinValue - temp_output_7_0_g262882 ) + 0.0001 ) ) ) * _SizeFadeScaleValue * Blend_Mask240_g262880 );
					float3 appendResult200_g262880 = (float3(temp_output_189_0_g262880 , temp_output_189_0_g262880 , temp_output_189_0_g262880));
					float3 appendResult201_g262880 = (float3(1.0 , temp_output_189_0_g262880 , 1.0));
					float3 appendResult230_g262880 = (float3(1.0 , 1.0 , temp_output_189_0_g262880));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262883 = appendResult230_g262880;
					#else
					float3 staticSwitch65_g262883 = appendResult201_g262880;
					#endif
					float3 lerpResult202_g262880 = lerp( appendResult200_g262880 , staticSwitch65_g262883 , _SizeFadeScaleMode);
					float3 lerpResult184_g262880 = lerp( temp_cast_17 , lerpResult202_g262880 , _SizeFadeIntensityValue);
					float3 temp_output_167_0_g262880 = ( lerpResult184_g262880 * Model_PositionOS147_g262880 );
					#ifdef TVE_SIZEFADE
					float3 staticSwitch199_g262880 = temp_output_167_0_g262880;
					#else
					float3 staticSwitch199_g262880 = Model_PositionOS147_g262880;
					#endif
					float3 Final_Position178_g262880 = staticSwitch199_g262880;
					float3 In_PositionOS16_g262888 = Final_Position178_g262880;
					float3 In_NormalOS16_g262888 = Out_NormalOS15_g262887;
					float4 In_TangentOS16_g262888 = Out_TangentOS15_g262887;
					float4 In_TransformData16_g262888 = Out_TransformData15_g262887;
					float4 In_RotationData16_g262888 = Out_RotationData15_g262887;
					float4 In_Interpolator16_g262888 = Out_Interpolator15_g262887;
					BuildVertexData( Data16_g262888 , In_Dummy16_g262888 , In_PositionOS16_g262888 , In_NormalOS16_g262888 , In_TangentOS16_g262888 , In_TransformData16_g262888 , In_RotationData16_g262888 , In_Interpolator16_g262888 );
					TVEVertexData Data15_g262912 =(TVEVertexData)Data16_g262888;
					float Out_Dummy15_g262912 = 0.0;
					float3 Out_PositionOS15_g262912 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262912 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262912 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262912 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262912 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262912 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262912 , Out_Dummy15_g262912 , Out_PositionOS15_g262912 , Out_NormalOS15_g262912 , Out_TangentOS15_g262912 , Out_TransformData15_g262912 , Out_RotationData15_g262912 , Out_Interpolator15_g262912 );
					TVEVertexData Data16_g262913 =(TVEVertexData)Data15_g262912;
					half Dummy181_g262899 = ( ( _MotionCategory + _MotionEnd ) + _MotionFlowInfo );
					float In_Dummy16_g262913 = Dummy181_g262899;
					float3 temp_output_3325_0_g262899 = Out_PositionOS15_g262912;
					float3 In_PositionOS16_g262913 = temp_output_3325_0_g262899;
					float3 In_NormalOS16_g262913 = Out_NormalOS15_g262912;
					float4 In_TangentOS16_g262913 = Out_TangentOS15_g262912;
					half4 Vertex_TransformData2743_g262899 = Out_TransformData15_g262912;
					float3 temp_cast_18 = (0.0).xxx;
					half Motion_FlowValue3376_g262899 = _MotionFlowValue;
					float2 lerpResult3361_g262899 = lerp( (half4( 1, 1, 1, 0 )).xy , (TVE_WindParams).xy , ( Motion_FlowValue3376_g262899 * TVE_IsEnabled ));
					float2 Global_WindDirWS2542_g262899 = (lerpResult3361_g262899*2.0 + -1.0);
					half2 Input_WindDirWS803_g262946 = Global_WindDirWS2542_g262899;
					TVEModelData Data15_g262911 =(TVEModelData)Data15_g262889;
					float Out_Dummy15_g262911 = 0.0;
					float3 Out_PositionOS15_g262911 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262911 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262911 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262911 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262911 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262911 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262911 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262911 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262911 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262911 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262911 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262911 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262911 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262911 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262911 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262911 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262911 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262911 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262911 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262911 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262911 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262911 , Out_Dummy15_g262911 , Out_PositionOS15_g262911 , Out_PositionWS15_g262911 , Out_PositionWO15_g262911 , Out_PositionRawOS15_g262911 , Out_PivotOS15_g262911 , Out_PivotWS15_g262911 , Out_PivotWO15_g262911 , Out_NormalOS15_g262911 , Out_NormalWS15_g262911 , Out_NormalRawOS15_g262911 , Out_TangentOS15_g262911 , Out_TangentWS15_g262911 , Out_BitangentWS15_g262911 , Out_ViewDirWS15_g262911 , Out_CoordsData15_g262911 , Out_VertexData15_g262911 , Out_MasksData15_g262911 , Out_PhaseData15_g262911 , Out_TransformData15_g262911 , Out_RotationData15_g262911 , Out_Interpolator15_g262911 );
					float3 Model_PositionWO162_g262899 = Out_PositionWO15_g262911;
					half3 Input_ModelPositionWO761_g262909 = Model_PositionWO162_g262899;
					float3 Model_PivotWO402_g262899 = Out_PivotWO15_g262911;
					half3 Input_ModelPivotsWO419_g262909 = Model_PivotWO402_g262899;
					half Input_MotionPivots629_g262909 = _MotionSmallPivotValue;
					float3 lerpResult771_g262909 = lerp( Input_ModelPositionWO761_g262909 , Input_ModelPivotsWO419_g262909 , Input_MotionPivots629_g262909);
					half4 Model_PhaseData489_g262899 = Out_PhaseData15_g262911;
					half4 Input_ModelMotionData763_g262909 = Model_PhaseData489_g262899;
					half Input_MotionPhase764_g262909 = _MotionSmallPhaseValue;
					float temp_output_770_0_g262909 = ( (Input_ModelMotionData763_g262909).x * Input_MotionPhase764_g262909 );
					half3 Small_Position1421_g262899 = ( lerpResult771_g262909 + temp_output_770_0_g262909 );
					half3 Input_PositionWO419_g262946 = Small_Position1421_g262899;
					half Input_MotionTilling321_g262946 = ( _MotionSmallTillingValue + 0.2 );
					half2 Noise_Coord979_g262946 = ( -(Input_PositionWO419_g262946).xz * Input_MotionTilling321_g262946 * 0.005 );
					float2 Input_Coords80_g262950 = Noise_Coord979_g262946;
					half2 Input_Direction82_g262950 = Input_WindDirWS803_g262946;
					float mulTime113_g262964 = _Time.y * 0.02;
					float lerpResult128_g262964 = lerp( mulTime113_g262964 , ( ( mulTime113_g262964 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					#ifdef SHADER_API_MOBILE
					float staticSwitch134_g262964 = frac( lerpResult128_g262964 );
					#else
					float staticSwitch134_g262964 = lerpResult128_g262964;
					#endif
					float Global_WindTime3262_g262899 = staticSwitch134_g262964;
					half Input_WindTime1015_g262946 = Global_WindTime3262_g262899;
					half Input_MotionSpeed62_g262946 = _MotionSmallSpeedValue;
					float temp_output_986_0_g262946 = ( Input_WindTime1015_g262946 * Input_MotionSpeed62_g262946 );
					half Noise_Speed980_g262946 = temp_output_986_0_g262946;
					float Input_Time88_g262950 = Noise_Speed980_g262946;
					float temp_output_23_0_g262950 = frac( Input_Time88_g262950 );
					float4 lerpResult39_g262950 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g262950 + ( Input_Direction82_g262950 * temp_output_23_0_g262950 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g262950 + ( Input_Direction82_g262950 * ( temp_output_23_0_g262950 - 1.0 ) ) ), 0.0 ) , temp_output_23_0_g262950);
					float4 temp_output_991_0_g262946 = lerpResult39_g262950;
					half2 Noise_DirWS858_g262946 = ((temp_output_991_0_g262946).rg*2.0 + -1.0);
					half Input_MotionNoise552_g262946 = _MotionSmallNoiseValue;
					float4 temp_output_3332_0_g262899 = TVE_FlowParams;
					TVEGlobalData Data15_g262925 =(TVEGlobalData)Data15_g262890;
					float Out_Dummy15_g262925 = 0.0;
					float4 Out_CoatTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g262925 = float4( 0,0,0,0 );
					BreakData( Data15_g262925 , Out_Dummy15_g262925 , Out_CoatTexture15_g262925 , Out_DrawTexture15_g262925 , Out_PaintTexture15_g262925 , Out_AtmoTexture15_g262925 , Out_EffexTexture15_g262925 , Out_GlowTexture15_g262925 , Out_FormTexture15_g262925 , Out_LandTexture15_g262925 , Out_VertxTexture15_g262925 , Out_FlowTexture15_g262925 , Out_UserTexture15_g262925 );
					half4 Global_FlowTexture2668_g262899 = Out_FlowTexture15_g262925;
					#ifdef TVE_MOTION_FLOW
					float4 staticSwitch3075_g262899 = Global_FlowTexture2668_g262899;
					#else
					float4 staticSwitch3075_g262899 = temp_output_3332_0_g262899;
					#endif
					float4 temp_output_6_0_g262926 = staticSwitch3075_g262899;
					float temp_output_7_0_g262926 = _MotionFlowMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g262926 = ( temp_output_6_0_g262926 + temp_output_7_0_g262926 );
					#else
					float4 staticSwitch14_g262926 = temp_output_6_0_g262926;
					#endif
					float4 lerpResult3121_g262899 = lerp( half4( 1, 1, 1, 0 ) , staticSwitch14_g262926 , ( Motion_FlowValue3376_g262899 * TVE_IsEnabled ));
					float temp_output_3077_0_g262899 = (lerpResult3121_g262899).z;
					float temp_output_630_0_g262935 = temp_output_3077_0_g262899;
					float lerpResult853_g262935 = lerp( temp_output_630_0_g262935 , TVE_WindEditor.z , TVE_WindEditor.w);
					half Global_WindValue1855_g262899 = ( lerpResult853_g262935 * _MotionIntensityValue );
					half Input_WindValue881_g262946 = Global_WindValue1855_g262899;
					float temp_output_6_0_g262948 = Input_WindValue881_g262946;
					float lerpResult701_g262946 = lerp( 1.0 , Input_MotionNoise552_g262946 , ( temp_output_6_0_g262948 * temp_output_6_0_g262948 ));
					float2 lerpResult646_g262946 = lerp( Input_WindDirWS803_g262946 , Noise_DirWS858_g262946 , lerpResult701_g262946);
					half2 Small_DirWS817_g262946 = lerpResult646_g262946;
					float2 break823_g262946 = Small_DirWS817_g262946;
					half4 Noise_Params685_g262946 = temp_output_991_0_g262946;
					half Wind_Sinus820_g262946 = ( ((Noise_Params685_g262946).b*2.0 + -1.0) * 0.6 );
					float3 appendResult824_g262946 = (float3(break823_g262946.x , Wind_Sinus820_g262946 , break823_g262946.y));
					half3 Small_Dir918_g262946 = appendResult824_g262946;
					float temp_output_20_0_g262947 = ( 1.0 - Input_WindValue881_g262946 );
					float3 appendResult1006_g262946 = (float3(Input_WindValue881_g262946 , ( 1.0 - ( temp_output_20_0_g262947 * temp_output_20_0_g262947 ) ) , Input_WindValue881_g262946));
					half Input_MotionDelay753_g262946 = _MotionSmallDelayValue;
					float lerpResult756_g262946 = lerp( 1.0 , ( Input_WindValue881_g262946 * Input_WindValue881_g262946 ) , Input_MotionDelay753_g262946);
					half Wind_Delay815_g262946 = lerpResult756_g262946;
					half Input_MotionValue905_g262946 = _MotionSmallIntensityValue;
					float3 temp_output_883_0_g262946 = ( Small_Dir918_g262946 * appendResult1006_g262946 * Wind_Delay815_g262946 * Input_MotionValue905_g262946 );
					float2 break857_g262946 = Noise_DirWS858_g262946;
					float3 appendResult833_g262946 = (float3(break857_g262946.x , Wind_Sinus820_g262946 , break857_g262946.y));
					half3 Push_Dir919_g262946 = appendResult833_g262946;
					half Input_MotionReact924_g262946 = _MotionSmallPushValue;
					half Global_PushAlpha1504_g262899 = (lerpResult3121_g262899).w;
					half Input_PushAlpha806_g262946 = Global_PushAlpha1504_g262899;
					half Global_PushNoise2675_g262899 = temp_output_3077_0_g262899;
					half Input_PushNoise890_g262946 = Global_PushNoise2675_g262899;
					half Push_Mask914_g262946 = saturate( ( Input_PushAlpha806_g262946 * Input_PushNoise890_g262946 * Input_MotionReact924_g262946 ) );
					float3 lerpResult840_g262946 = lerp( temp_output_883_0_g262946 , ( Push_Dir919_g262946 * Input_MotionReact924_g262946 ) , Push_Mask914_g262946);
					#ifdef TVE_MOTION_FLOW
					float3 staticSwitch829_g262946 = lerpResult840_g262946;
					#else
					float3 staticSwitch829_g262946 = temp_output_883_0_g262946;
					#endif
					half3 Small_Squash1489_g262899 = ( mul( unity_WorldToObject, float4( staticSwitch829_g262946 , 0.0 ) ).xyz * ase_parentObjectScale );
					float temp_output_17_0_g262914 = _MotionSmallMaskMode;
					float Option92_g262914 = temp_output_17_0_g262914;
					half4 Model_VertexMasks518_g262899 = Out_VertexData15_g262911;
					float4 temp_output_84_0_g262914 = Model_VertexMasks518_g262899;
					float4 ChannelA92_g262914 = temp_output_84_0_g262914;
					half4 Model_MasksData1322_g262899 = Out_MasksData15_g262911;
					float2 uv_MotionMaskTex2818_g262899 = v.texcoord.xyzw.xy;
					half4 Motion_MaskTex2819_g262899 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex2818_g262899, 0.0 );
					float3 appendResult3227_g262899 = (float3((Model_MasksData1322_g262899).xy , (Motion_MaskTex2819_g262899).g));
					float3 temp_output_85_0_g262914 = appendResult3227_g262899;
					float4 ChannelB92_g262914 = float4( temp_output_85_0_g262914 , 0.0 );
					float localSwitchChannel792_g262914 = SwitchChannel7( Option92_g262914 , ChannelA92_g262914 , ChannelB92_g262914 );
					float enc1805_g262899 = v.texcoord.xyzw.z;
					float2 localDecodeFloatToVector21805_g262899 = DecodeFloatToVector2( enc1805_g262899 );
					float2 break1804_g262899 = localDecodeFloatToVector21805_g262899;
					half Small_Mask_Legacy1806_g262899 = break1804_g262899.x;
					#ifdef TVE_LEGACY
					float staticSwitch1800_g262899 = Small_Mask_Legacy1806_g262899;
					#else
					float staticSwitch1800_g262899 = localSwitchChannel792_g262914;
					#endif
					float clampResult17_g262900 = clamp( staticSwitch1800_g262899 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262901 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g262901 = ( clampResult17_g262900 - temp_output_7_0_g262901 );
					half Small_Mask640_g262899 = saturate( ( temp_output_9_0_g262901 * _MotionSmallMaskRemap.z ) );
					float3 lerpResult3022_g262899 = lerp( float3( 1,1,1 ) , (TVE_MotionValueParams).xyz , TVE_MotionValueParams.w);
					half3 Global_MotionParams3013_g262899 = lerpResult3022_g262899;
					half3 Small_Motion789_g262899 = ( Small_Squash1489_g262899 * Small_Mask640_g262899 * (Global_MotionParams3013_g262899).y );
					#ifdef TVE_MOTION
					float3 staticSwitch495_g262899 = Small_Motion789_g262899;
					#else
					float3 staticSwitch495_g262899 = temp_cast_18;
					#endif
					float3 temp_cast_22 = (0.0).xxx;
					half3 Tiny_Position2469_g262899 = Model_PositionWO162_g262899;
					half3 Input_PositionWO419_g262965 = Tiny_Position2469_g262899;
					half Input_MotionTilling321_g262965 = ( _MotionTinyTillingValue + 0.2 );
					half2 Noise_Coord979_g262965 = ( -(Input_PositionWO419_g262965).xz * Input_MotionTilling321_g262965 * 0.005 );
					float2 Input_Coords80_g262972 = Noise_Coord979_g262965;
					half2 Input_Direction82_g262972 = float2( 0,1 );
					half Input_WindTime1015_g262965 = Global_WindTime3262_g262899;
					half Input_MotionSpeed62_g262965 = _MotionTinySpeedValue;
					float temp_output_986_0_g262965 = ( Input_WindTime1015_g262965 * Input_MotionSpeed62_g262965 );
					half Noise_Speed980_g262965 = temp_output_986_0_g262965;
					float Input_Time88_g262972 = Noise_Speed980_g262965;
					float4 temp_output_991_0_g262965 = SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g262972 + ( Input_Direction82_g262972 * Input_Time88_g262972 ) ), 0.0 );
					half3 Noise_DirWS858_g262965 = ((temp_output_991_0_g262965).rgb*2.0 + -1.0);
					half Input_MotionNoise552_g262965 = _MotionTinyNoiseValue;
					float3 lerpResult646_g262965 = lerp( ( Noise_DirWS858_g262965 * v.normal ) , Noise_DirWS858_g262965 , Input_MotionNoise552_g262965);
					half3 Tiny_DirWS817_g262965 = lerpResult646_g262965;
					half Input_MotionValue905_g262965 = _MotionTinyIntensityValue;
					float mulTime113_g262978 = _Time.y * 2.0;
					float lerpResult128_g262978 = lerp( mulTime113_g262978 , ( ( mulTime113_g262978 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					#ifdef SHADER_API_MOBILE
					float staticSwitch134_g262978 = frac( lerpResult128_g262978 );
					#else
					float staticSwitch134_g262978 = lerpResult128_g262978;
					#endif
					float3 temp_output_1028_0_g262965 = ( Input_PositionWO419_g262965 + staticSwitch134_g262978 );
					float temp_output_1054_0_g262965 = SAMPLE_TEXTURE3D_LOD( _NoiseTex3D, sampler_Linear_Repeat, ( temp_output_1028_0_g262965 * ( 1.0 * 0.01 ) ), 0.0 ).r;
					float temp_output_6_0_g262968 = temp_output_1054_0_g262965;
					float temp_output_6_0_g262969 = temp_output_1054_0_g262965;
					half Input_WindValue881_g262965 = Global_WindValue1855_g262899;
					float temp_output_6_0_g262971 = Input_WindValue881_g262965;
					float lerpResult1029_g262965 = lerp( ( temp_output_6_0_g262968 * temp_output_6_0_g262968 * temp_output_6_0_g262968 * temp_output_6_0_g262968 ) , ( temp_output_6_0_g262969 * temp_output_6_0_g262969 ) , ( temp_output_6_0_g262971 * temp_output_6_0_g262971 ));
					float temp_output_20_0_g262970 = ( 1.0 - Input_WindValue881_g262965 );
					float temp_output_1030_0_g262965 = ( lerpResult1029_g262965 * ( 1.0 - ( temp_output_20_0_g262970 * temp_output_20_0_g262970 * temp_output_20_0_g262970 * temp_output_20_0_g262970 ) ) );
					half Wind_Gust1039_g262965 = temp_output_1030_0_g262965;
					float3 temp_output_883_0_g262965 = ( Tiny_DirWS817_g262965 * Input_MotionValue905_g262965 * Wind_Gust1039_g262965 );
					half3 Tiny_Squash859_g262899 = temp_output_883_0_g262965;
					float temp_output_17_0_g262915 = _MotionTinyMaskMode;
					float Option92_g262915 = temp_output_17_0_g262915;
					float4 temp_output_84_0_g262915 = Model_VertexMasks518_g262899;
					float4 ChannelA92_g262915 = temp_output_84_0_g262915;
					float3 appendResult3234_g262899 = (float3((Model_MasksData1322_g262899).xy , (Motion_MaskTex2819_g262899).b));
					float3 temp_output_85_0_g262915 = appendResult3234_g262899;
					float4 ChannelB92_g262915 = float4( temp_output_85_0_g262915 , 0.0 );
					float localSwitchChannel792_g262915 = SwitchChannel7( Option92_g262915 , ChannelA92_g262915 , ChannelB92_g262915 );
					half Tiny_Mask_Legacy1807_g262899 = break1804_g262899.y;
					#ifdef TVE_LEGACY
					float staticSwitch1810_g262899 = Tiny_Mask_Legacy1807_g262899;
					#else
					float staticSwitch1810_g262899 = localSwitchChannel792_g262915;
					#endif
					float clampResult17_g262902 = clamp( staticSwitch1810_g262899 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262903 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g262903 = ( clampResult17_g262902 - temp_output_7_0_g262903 );
					half Tiny_Mask218_g262899 = saturate( ( temp_output_9_0_g262903 * _MotionTinyMaskRemap.z ) );
					float3 Model_PositionWS1819_g262899 = Out_PositionWS15_g262911;
					half Global_DistMask1820_g262899 = ( 1.0 - saturate( ( distance( _WorldSpaceCameraPos , Model_PositionWS1819_g262899 ) / _MotionDistValue ) ) );
					half3 Tiny_Flutter1451_g262899 = ( Tiny_Squash859_g262899 * Tiny_Mask218_g262899 * Global_DistMask1820_g262899 * (Global_MotionParams3013_g262899).z );
					#ifdef TVE_MOTION
					float3 staticSwitch414_g262899 = Tiny_Flutter1451_g262899;
					#else
					float3 staticSwitch414_g262899 = temp_cast_22;
					#endif
					float4 appendResult2783_g262899 = (float4(( staticSwitch495_g262899 + staticSwitch414_g262899 ) , 0.0));
					half4 Final_TransformData1569_g262899 = ( Vertex_TransformData2743_g262899 + appendResult2783_g262899 );
					float4 In_TransformData16_g262913 = Final_TransformData1569_g262899;
					half4 Vertex_RotationData2740_g262899 = Out_RotationData15_g262912;
					half2 Input_WindDirWS803_g262936 = Global_WindDirWS2542_g262899;
					half3 Input_ModelPositionWO761_g262910 = Model_PositionWO162_g262899;
					half3 Input_ModelPivotsWO419_g262910 = Model_PivotWO402_g262899;
					half Input_MotionPivots629_g262910 = _MotionBasePivotValue;
					float3 lerpResult771_g262910 = lerp( Input_ModelPositionWO761_g262910 , Input_ModelPivotsWO419_g262910 , Input_MotionPivots629_g262910);
					half4 Input_ModelMotionData763_g262910 = Model_PhaseData489_g262899;
					half Input_MotionPhase764_g262910 = _MotionBasePhaseValue;
					float temp_output_770_0_g262910 = ( (Input_ModelMotionData763_g262910).x * Input_MotionPhase764_g262910 );
					half3 Base_Position1394_g262899 = ( lerpResult771_g262910 + temp_output_770_0_g262910 );
					half3 Input_PositionWO419_g262936 = Base_Position1394_g262899;
					half Input_MotionTilling321_g262936 = ( _MotionBaseTillingValue + 0.2 );
					half2 Noise_Coord515_g262936 = ( -(Input_PositionWO419_g262936).xz * Input_MotionTilling321_g262936 * 0.005 );
					float2 Input_Coords80_g262938 = Noise_Coord515_g262936;
					half2 Input_Direction82_g262938 = Input_WindDirWS803_g262936;
					half Input_WindTime963_g262936 = Global_WindTime3262_g262899;
					half Input_MotionSpeed62_g262936 = _MotionBaseSpeedValue;
					float temp_output_505_0_g262936 = ( Input_WindTime963_g262936 * Input_MotionSpeed62_g262936 );
					half Noise_Speed516_g262936 = temp_output_505_0_g262936;
					float Input_Time88_g262938 = Noise_Speed516_g262936;
					float temp_output_23_0_g262938 = frac( Input_Time88_g262938 );
					float4 lerpResult39_g262938 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g262938 + ( Input_Direction82_g262938 * temp_output_23_0_g262938 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g262938 + ( Input_Direction82_g262938 * ( temp_output_23_0_g262938 - 1.0 ) ) ), 0.0 ) , temp_output_23_0_g262938);
					float4 temp_output_635_0_g262936 = lerpResult39_g262938;
					half2 Noise_DirWS825_g262936 = ((temp_output_635_0_g262936).rg*2.0 + -1.0);
					half Input_MotionNoise552_g262936 = _MotionBaseNoiseValue;
					half Input_WindValue853_g262936 = Global_WindValue1855_g262899;
					float temp_output_6_0_g262937 = Input_WindValue853_g262936;
					float lerpResult701_g262936 = lerp( 1.0 , Input_MotionNoise552_g262936 , ( temp_output_6_0_g262937 * temp_output_6_0_g262937 ));
					float2 lerpResult646_g262936 = lerp( Input_WindDirWS803_g262936 , Noise_DirWS825_g262936 , lerpResult701_g262936);
					half2 Bend_Dir859_g262936 = lerpResult646_g262936;
					half Input_MotionValue871_g262936 = _MotionBaseIntensityValue;
					half Input_MotionDelay753_g262936 = _MotionBaseDelayValue;
					float lerpResult756_g262936 = lerp( 1.0 , ( Input_WindValue853_g262936 * Input_WindValue853_g262936 ) , Input_MotionDelay753_g262936);
					half Wind_Delay815_g262936 = lerpResult756_g262936;
					float2 temp_output_875_0_g262936 = ( Bend_Dir859_g262936 * Input_WindValue853_g262936 * Input_MotionValue871_g262936 * Wind_Delay815_g262936 );
					float2 Global_PushDirWS1972_g262899 = ((lerpResult3121_g262899).xy*2.0 + -1.0);
					half2 Input_PushDirWS807_g262936 = Global_PushDirWS1972_g262899;
					half Input_ReactValue888_g262936 = _MotionBasePushValue;
					half Input_PushAlpha806_g262936 = Global_PushAlpha1504_g262899;
					half Push_Mask883_g262936 = saturate( ( Input_PushAlpha806_g262936 * Input_ReactValue888_g262936 ) );
					float2 lerpResult811_g262936 = lerp( temp_output_875_0_g262936 , ( Input_PushDirWS807_g262936 * Input_ReactValue888_g262936 ) , Push_Mask883_g262936);
					#ifdef TVE_MOTION_FLOW
					float2 staticSwitch808_g262936 = lerpResult811_g262936;
					#else
					float2 staticSwitch808_g262936 = temp_output_875_0_g262936;
					#endif
					float2 temp_output_38_0_g262942 = staticSwitch808_g262936;
					float2 break83_g262942 = temp_output_38_0_g262942;
					float3 appendResult79_g262942 = (float3(break83_g262942.x , 0.0 , break83_g262942.y));
					half2 Base_Bending893_g262899 = (( mul( unity_WorldToObject, float4( appendResult79_g262942 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
					float temp_output_17_0_g262916 = _MotionBaseMaskMode;
					float Option92_g262916 = temp_output_17_0_g262916;
					float4 temp_output_84_0_g262916 = Model_VertexMasks518_g262899;
					float4 ChannelA92_g262916 = temp_output_84_0_g262916;
					float3 appendResult3220_g262899 = (float3((Model_MasksData1322_g262899).xy , (Motion_MaskTex2819_g262899).r));
					float3 temp_output_85_0_g262916 = appendResult3220_g262899;
					float4 ChannelB92_g262916 = float4( temp_output_85_0_g262916 , 0.0 );
					float localSwitchChannel792_g262916 = SwitchChannel7( Option92_g262916 , ChannelA92_g262916 , ChannelB92_g262916 );
					float clampResult17_g262905 = clamp( localSwitchChannel792_g262916 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262904 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g262904 = ( clampResult17_g262905 - temp_output_7_0_g262904 );
					half Base_Mask217_g262899 = saturate( ( temp_output_9_0_g262904 * _MotionBaseMaskRemap.z ) );
					half2 Base_Motion1440_g262899 = ( Base_Bending893_g262899 * Base_Mask217_g262899 * (Global_MotionParams3013_g262899).x );
					#ifdef TVE_MOTION
					float2 staticSwitch2384_g262899 = Base_Motion1440_g262899;
					#else
					float2 staticSwitch2384_g262899 = float2( 0,0 );
					#endif
					float4 appendResult2023_g262899 = (float4(staticSwitch2384_g262899 , 0.0 , 0.0));
					half4 Final_RotationData1570_g262899 = ( Vertex_RotationData2740_g262899 + appendResult2023_g262899 );
					float4 In_RotationData16_g262913 = Final_RotationData1570_g262899;
					half4 Vertex_Interpolator2773_g262899 = Out_Interpolator15_g262912;
					half4 Noise_Params685_g262936 = temp_output_635_0_g262936;
					float temp_output_6_0_g262944 = (Noise_Params685_g262936).a;
					float temp_output_913_0_g262936 = ( ( temp_output_6_0_g262944 * temp_output_6_0_g262944 * temp_output_6_0_g262944 * temp_output_6_0_g262944 ) * ( Input_WindValue853_g262936 * Wind_Delay815_g262936 ) );
					float temp_output_6_0_g262945 = length( Input_PushDirWS807_g262936 );
					float temp_output_937_0_g262936 = ( temp_output_6_0_g262945 * temp_output_6_0_g262945 );
					half Input_PushNoise858_g262936 = Global_PushNoise2675_g262899;
					float lerpResult902_g262936 = lerp( temp_output_913_0_g262936 , temp_output_937_0_g262936 , ( Push_Mask883_g262936 * Input_PushNoise858_g262936 ));
					#ifdef TVE_MOTION_FLOW
					float staticSwitch903_g262936 = lerpResult902_g262936;
					#else
					float staticSwitch903_g262936 = temp_output_913_0_g262936;
					#endif
					half Base_Wave1159_g262899 = staticSwitch903_g262936;
					float temp_output_6_0_g262949 = (Noise_Params685_g262946).a;
					float temp_output_955_0_g262946 = ( temp_output_6_0_g262949 * temp_output_6_0_g262949 * temp_output_6_0_g262949 * temp_output_6_0_g262949 );
					float temp_output_944_0_g262946 = ( temp_output_955_0_g262946 * ( Input_WindValue881_g262946 * Wind_Delay815_g262946 ) );
					float lerpResult936_g262946 = lerp( temp_output_944_0_g262946 , temp_output_955_0_g262946 , ( Push_Mask914_g262946 * Input_PushNoise890_g262946 ));
					#ifdef TVE_MOTION_FLOW
					float staticSwitch939_g262946 = lerpResult936_g262946;
					#else
					float staticSwitch939_g262946 = temp_output_944_0_g262946;
					#endif
					half Small_Wave1427_g262899 = staticSwitch939_g262946;
					float lerpResult2422_g262899 = lerp( Base_Wave1159_g262899 , Small_Wave1427_g262899 , _motion_small_mode);
					half Global_Wave1475_g262899 = saturate( lerpResult2422_g262899 );
					float temp_output_6_0_g262906 = ( _MotionHighlightValue * Global_DistMask1820_g262899 * ( Tiny_Mask218_g262899 * Tiny_Mask218_g262899 ) * Global_Wave1475_g262899 );
					float temp_output_7_0_g262906 = _MotionHighlightColor.r;
					#ifdef TVE_DUMMY
					float staticSwitch14_g262906 = ( temp_output_6_0_g262906 + temp_output_7_0_g262906 );
					#else
					float staticSwitch14_g262906 = temp_output_6_0_g262906;
					#endif
					#ifdef TVE_MOTION
					float staticSwitch2866_g262899 = staticSwitch14_g262906;
					#else
					float staticSwitch2866_g262899 = 0.0;
					#endif
					float4 appendResult2775_g262899 = (float4((Vertex_Interpolator2773_g262899).xyz , staticSwitch2866_g262899));
					half4 Final_Interpolator2774_g262899 = appendResult2775_g262899;
					float4 In_Interpolator16_g262913 = Final_Interpolator2774_g262899;
					BuildVertexData( Data16_g262913 , In_Dummy16_g262913 , In_PositionOS16_g262913 , In_NormalOS16_g262913 , In_TangentOS16_g262913 , In_TransformData16_g262913 , In_RotationData16_g262913 , In_Interpolator16_g262913 );
					TVEVertexData Data15_g262988 =(TVEVertexData)Data16_g262913;
					float Out_Dummy15_g262988 = 0.0;
					float3 Out_PositionOS15_g262988 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262988 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262988 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262988 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262988 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262988 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262988 , Out_Dummy15_g262988 , Out_PositionOS15_g262988 , Out_NormalOS15_g262988 , Out_TangentOS15_g262988 , Out_TransformData15_g262988 , Out_RotationData15_g262988 , Out_Interpolator15_g262988 );
					TVEVertexData Data16_g262989 =(TVEVertexData)Data15_g262988;
					float In_Dummy16_g262989 = 0.0;
					float3 Vertex_PositionOS147_g262979 = Out_PositionOS15_g262988;
					half3 VertexPos40_g262983 = Vertex_PositionOS147_g262979;
					float4 temp_output_1615_33_g262979 = Out_RotationData15_g262988;
					half4 Vertex_RotationData1569_g262979 = temp_output_1615_33_g262979;
					float2 break1582_g262979 = (Vertex_RotationData1569_g262979).xy;
					half Angle44_g262983 = break1582_g262979.y;
					half CosAngle89_g262983 = cos( Angle44_g262983 );
					half SinAngle93_g262983 = sin( Angle44_g262983 );
					float3 appendResult95_g262983 = (float3((VertexPos40_g262983).x , ( ( (VertexPos40_g262983).y * CosAngle89_g262983 ) - ( (VertexPos40_g262983).z * SinAngle93_g262983 ) ) , ( ( (VertexPos40_g262983).y * SinAngle93_g262983 ) + ( (VertexPos40_g262983).z * CosAngle89_g262983 ) )));
					half3 VertexPos40_g262984 = appendResult95_g262983;
					half Angle44_g262984 = -break1582_g262979.x;
					half CosAngle94_g262984 = cos( Angle44_g262984 );
					half SinAngle95_g262984 = sin( Angle44_g262984 );
					float3 appendResult98_g262984 = (float3(( ( (VertexPos40_g262984).x * CosAngle94_g262984 ) - ( (VertexPos40_g262984).y * SinAngle95_g262984 ) ) , ( ( (VertexPos40_g262984).x * SinAngle95_g262984 ) + ( (VertexPos40_g262984).y * CosAngle94_g262984 ) ) , (VertexPos40_g262984).z));
					half3 VertexPos40_g262982 = Vertex_PositionOS147_g262979;
					half Angle44_g262982 = break1582_g262979.y;
					half CosAngle89_g262982 = cos( Angle44_g262982 );
					half SinAngle93_g262982 = sin( Angle44_g262982 );
					float3 appendResult95_g262982 = (float3((VertexPos40_g262982).x , ( ( (VertexPos40_g262982).y * CosAngle89_g262982 ) - ( (VertexPos40_g262982).z * SinAngle93_g262982 ) ) , ( ( (VertexPos40_g262982).y * SinAngle93_g262982 ) + ( (VertexPos40_g262982).z * CosAngle89_g262982 ) )));
					half3 VertexPos40_g262987 = appendResult95_g262982;
					half Angle44_g262987 = break1582_g262979.x;
					half CosAngle91_g262987 = cos( Angle44_g262987 );
					half SinAngle92_g262987 = sin( Angle44_g262987 );
					float3 appendResult93_g262987 = (float3(( ( (VertexPos40_g262987).x * CosAngle91_g262987 ) + ( (VertexPos40_g262987).z * SinAngle92_g262987 ) ) , (VertexPos40_g262987).y , ( ( -(VertexPos40_g262987).x * SinAngle92_g262987 ) + ( (VertexPos40_g262987).z * CosAngle91_g262987 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262985 = appendResult93_g262987;
					#else
					float3 staticSwitch65_g262985 = appendResult98_g262984;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g262980 = staticSwitch65_g262985;
					#else
					float3 staticSwitch65_g262980 = Vertex_PositionOS147_g262979;
					#endif
					float3 temp_output_1608_0_g262979 = staticSwitch65_g262980;
					half3 VertexPos40_g262986 = temp_output_1608_0_g262979;
					half Angle44_g262986 = (Vertex_RotationData1569_g262979).z;
					half CosAngle91_g262986 = cos( Angle44_g262986 );
					half SinAngle92_g262986 = sin( Angle44_g262986 );
					float3 appendResult93_g262986 = (float3(( ( (VertexPos40_g262986).x * CosAngle91_g262986 ) + ( (VertexPos40_g262986).z * SinAngle92_g262986 ) ) , (VertexPos40_g262986).y , ( ( -(VertexPos40_g262986).x * SinAngle92_g262986 ) + ( (VertexPos40_g262986).z * CosAngle91_g262986 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g262981 = appendResult93_g262986;
					#else
					float3 staticSwitch65_g262981 = temp_output_1608_0_g262979;
					#endif
					float4 temp_output_1615_31_g262979 = Out_TransformData15_g262988;
					half4 Vertex_TransformData1568_g262979 = temp_output_1615_31_g262979;
					half3 Final_PositionOS178_g262979 = ( ( staticSwitch65_g262981 * (Vertex_TransformData1568_g262979).w ) + (Vertex_TransformData1568_g262979).xyz );
					float3 In_PositionOS16_g262989 = Final_PositionOS178_g262979;
					float3 In_NormalOS16_g262989 = Out_NormalOS15_g262988;
					float4 In_TangentOS16_g262989 = Out_TangentOS15_g262988;
					float4 In_TransformData16_g262989 = temp_output_1615_31_g262979;
					float4 In_RotationData16_g262989 = temp_output_1615_33_g262979;
					float4 In_Interpolator16_g262989 = Out_Interpolator15_g262988;
					BuildVertexData( Data16_g262989 , In_Dummy16_g262989 , In_PositionOS16_g262989 , In_NormalOS16_g262989 , In_TangentOS16_g262989 , In_TransformData16_g262989 , In_RotationData16_g262989 , In_Interpolator16_g262989 );
					TVEVertexData Data15_g262999 =(TVEVertexData)Data16_g262989;
					float Out_Dummy15_g262999 = 0.0;
					float3 Out_PositionOS15_g262999 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262999 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262999 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262999 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262999 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262999 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262999 , Out_Dummy15_g262999 , Out_PositionOS15_g262999 , Out_NormalOS15_g262999 , Out_TangentOS15_g262999 , Out_TransformData15_g262999 , Out_RotationData15_g262999 , Out_Interpolator15_g262999 );
					TVEVertexData Data16_g263000 =(TVEVertexData)Data15_g262999;
					half Dummy1823_g262990 = ( _FlattenCategory + _FlattenEnd + _FlattenBakeMode );
					float In_Dummy16_g263000 = Dummy1823_g262990;
					float3 In_PositionOS16_g263000 = Out_PositionOS15_g262999;
					half3 Vertex_NormalOS1829_g262990 = Out_NormalOS15_g262999;
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262991 = half3( 0, 0, 1 );
					#else
					float3 staticSwitch65_g262991 = half3( 0, 1, 0 );
					#endif
					float3 lerpResult1820_g262990 = lerp( Vertex_NormalOS1829_g262990 , staticSwitch65_g262991 , _FlattenUpwardsValue);
					TVEModelData Data15_g263001 =(TVEModelData)Data15_g262911;
					float Out_Dummy15_g263001 = 0.0;
					float3 Out_PositionOS15_g263001 = float3( 0,0,0 );
					float3 Out_PositionWS15_g263001 = float3( 0,0,0 );
					float3 Out_PositionWO15_g263001 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g263001 = float3( 0,0,0 );
					float3 Out_PivotOS15_g263001 = float3( 0,0,0 );
					float3 Out_PivotWS15_g263001 = float3( 0,0,0 );
					float3 Out_PivotWO15_g263001 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263001 = float3( 0,0,0 );
					float3 Out_NormalWS15_g263001 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g263001 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263001 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g263001 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g263001 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g263001 = float3( 0,0,0 );
					float4 Out_CoordsData15_g263001 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g263001 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g263001 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g263001 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263001 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263001 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263001 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g263001 , Out_Dummy15_g263001 , Out_PositionOS15_g263001 , Out_PositionWS15_g263001 , Out_PositionWO15_g263001 , Out_PositionRawOS15_g263001 , Out_PivotOS15_g263001 , Out_PivotWS15_g263001 , Out_PivotWO15_g263001 , Out_NormalOS15_g263001 , Out_NormalWS15_g263001 , Out_NormalRawOS15_g263001 , Out_TangentOS15_g263001 , Out_TangentWS15_g263001 , Out_BitangentWS15_g263001 , Out_ViewDirWS15_g263001 , Out_CoordsData15_g263001 , Out_VertexData15_g263001 , Out_MasksData15_g263001 , Out_PhaseData15_g263001 , Out_TransformData15_g263001 , Out_RotationData15_g263001 , Out_Interpolator15_g263001 );
					float3 Model_PositionOS1837_g262990 = Out_PositionOS15_g263001;
					float3 normalizeResult1816_g262990 = ASESafeNormalize( ( Model_PositionOS1837_g262990 + _FlattenSphereOffsetValue ) );
					float3 lerpResult1813_g262990 = lerp( lerpResult1820_g262990 , normalizeResult1816_g262990 , _FlattenSphereValue);
					float temp_output_17_0_g262998 = _FlattenMeshMode;
					float Option70_g262998 = temp_output_17_0_g262998;
					half4 Model_VertexData1826_g262990 = Out_VertexData15_g263001;
					float4 temp_output_3_0_g262998 = Model_VertexData1826_g262990;
					float4 Channel70_g262998 = temp_output_3_0_g262998;
					float localSwitchChannel470_g262998 = SwitchChannel4( Option70_g262998 , Channel70_g262998 );
					float clampResult17_g262992 = clamp( localSwitchChannel470_g262998 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262993 = _FlattenMeshRemap.x;
					float temp_output_9_0_g262993 = ( clampResult17_g262992 - temp_output_7_0_g262993 );
					float lerpResult1841_g262990 = lerp( 1.0 , saturate( ( temp_output_9_0_g262993 * _FlattenMeshRemap.z ) ) , _FlattenMeshValue);
					half Normal_MeskMask1847_g262990 = lerpResult1841_g262990;
					half Normal_Mask1851_g262990 = Normal_MeskMask1847_g262990;
					float3 lerpResult1856_g262990 = lerp( Vertex_NormalOS1829_g262990 , lerpResult1813_g262990 , ( Normal_Mask1851_g262990 * _FlattenIntensityValue ));
					#ifdef TVE_FLATTEN
					float3 staticSwitch1857_g262990 = lerpResult1856_g262990;
					#else
					float3 staticSwitch1857_g262990 = Vertex_NormalOS1829_g262990;
					#endif
					half3 Final_NormalOS1853_g262990 = staticSwitch1857_g262990;
					float3 In_NormalOS16_g263000 = Final_NormalOS1853_g262990;
					float4 In_TangentOS16_g263000 = Out_TangentOS15_g262999;
					float4 In_TransformData16_g263000 = Out_TransformData15_g262999;
					float4 In_RotationData16_g263000 = Out_RotationData15_g262999;
					float4 In_Interpolator16_g263000 = Out_Interpolator15_g262999;
					BuildVertexData( Data16_g263000 , In_Dummy16_g263000 , In_PositionOS16_g263000 , In_NormalOS16_g263000 , In_TangentOS16_g263000 , In_TransformData16_g263000 , In_RotationData16_g263000 , In_Interpolator16_g263000 );
					TVEVertexData Data15_g263010 =(TVEVertexData)Data16_g263000;
					float Out_Dummy15_g263010 = 0.0;
					float3 Out_PositionOS15_g263010 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263010 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263010 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263010 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263010 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263010 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g263010 , Out_Dummy15_g263010 , Out_PositionOS15_g263010 , Out_NormalOS15_g263010 , Out_TangentOS15_g263010 , Out_TransformData15_g263010 , Out_RotationData15_g263010 , Out_Interpolator15_g263010 );
					TVEVertexData Data16_g263011 =(TVEVertexData)Data15_g263010;
					half Dummy1575_g263002 = ( _ReshadeCategory + _ReshadeEnd + _ReshadeInfo );
					float In_Dummy16_g263011 = Dummy1575_g263002;
					float3 In_PositionOS16_g263011 = Out_PositionOS15_g263010;
					half3 Vertex_NormalOS1568_g263002 = Out_NormalOS15_g263010;
					half3 VertexPos40_g263004 = Vertex_NormalOS1568_g263002;
					half3 VertexPos40_g263005 = VertexPos40_g263004;
					float4 temp_output_1818_33_g263002 = Out_RotationData15_g263010;
					half4 Vertex_RotationData1583_g263002 = temp_output_1818_33_g263002;
					half2 Angle44_g263004 = Vertex_RotationData1583_g263002.xy;
					half Angle44_g263005 = (Angle44_g263004).y;
					half CosAngle89_g263005 = cos( Angle44_g263005 );
					half SinAngle93_g263005 = sin( Angle44_g263005 );
					float3 appendResult95_g263005 = (float3((VertexPos40_g263005).x , ( ( (VertexPos40_g263005).y * CosAngle89_g263005 ) - ( (VertexPos40_g263005).z * SinAngle93_g263005 ) ) , ( ( (VertexPos40_g263005).y * SinAngle93_g263005 ) + ( (VertexPos40_g263005).z * CosAngle89_g263005 ) )));
					half3 VertexPos40_g263006 = appendResult95_g263005;
					half Angle44_g263006 = -(Angle44_g263004).x;
					half CosAngle94_g263006 = cos( Angle44_g263006 );
					half SinAngle95_g263006 = sin( Angle44_g263006 );
					float3 appendResult98_g263006 = (float3(( ( (VertexPos40_g263006).x * CosAngle94_g263006 ) - ( (VertexPos40_g263006).y * SinAngle95_g263006 ) ) , ( ( (VertexPos40_g263006).x * SinAngle95_g263006 ) + ( (VertexPos40_g263006).y * CosAngle94_g263006 ) ) , (VertexPos40_g263006).z));
					float3 lerpResult1591_g263002 = lerp( Vertex_NormalOS1568_g263002 , appendResult98_g263006 , _ReshadeIntensityValue);
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g263003 = lerpResult1591_g263002;
					#else
					float3 staticSwitch65_g263003 = Vertex_NormalOS1568_g263002;
					#endif
					float3 temp_output_1732_0_g263002 = staticSwitch65_g263003;
					#ifdef TVE_RESHADE
					float3 staticSwitch1716_g263002 = temp_output_1732_0_g263002;
					#else
					float3 staticSwitch1716_g263002 = Vertex_NormalOS1568_g263002;
					#endif
					half3 Final_NormalOS178_g263002 = staticSwitch1716_g263002;
					float3 In_NormalOS16_g263011 = Final_NormalOS178_g263002;
					float4 In_TangentOS16_g263011 = Out_TangentOS15_g263010;
					float4 In_TransformData16_g263011 = Out_TransformData15_g263010;
					float4 In_RotationData16_g263011 = temp_output_1818_33_g263002;
					float4 In_Interpolator16_g263011 = Out_Interpolator15_g263010;
					BuildVertexData( Data16_g263011 , In_Dummy16_g263011 , In_PositionOS16_g263011 , In_NormalOS16_g263011 , In_TangentOS16_g263011 , In_TransformData16_g263011 , In_RotationData16_g263011 , In_Interpolator16_g263011 );
					TVEVertexData Data15_g263133 =(TVEVertexData)Data16_g263011;
					float Out_Dummy15_g263133 = 0.0;
					float3 Out_PositionOS15_g263133 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263133 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263133 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263133 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263133 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263133 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g263133 , Out_Dummy15_g263133 , Out_PositionOS15_g263133 , Out_NormalOS15_g263133 , Out_TangentOS15_g263133 , Out_TransformData15_g263133 , Out_RotationData15_g263133 , Out_Interpolator15_g263133 );
					TVEVertexData Data16_g263134 =(TVEVertexData)Data15_g263133;
					half Dummy1575_g263126 = ( _TransferCategory + _TransferEnd + _TransferInfo + _TransferSpace );
					float In_Dummy16_g263134 = Dummy1575_g263126;
					float3 In_PositionOS16_g263134 = Out_PositionOS15_g263133;
					half3 Vertex_NormalOS1568_g263126 = Out_NormalOS15_g263133;
					TVEGlobalData Data15_g263132 =(TVEGlobalData)Data15_g262925;
					float Out_Dummy15_g263132 = 0.0;
					float4 Out_CoatTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g263132 = float4( 0,0,0,0 );
					BreakData( Data15_g263132 , Out_Dummy15_g263132 , Out_CoatTexture15_g263132 , Out_DrawTexture15_g263132 , Out_PaintTexture15_g263132 , Out_AtmoTexture15_g263132 , Out_EffexTexture15_g263132 , Out_GlowTexture15_g263132 , Out_FormTexture15_g263132 , Out_LandTexture15_g263132 , Out_VertxTexture15_g263132 , Out_FlowTexture15_g263132 , Out_UserTexture15_g263132 );
					half4 Global_FormTexture1633_g263126 = Out_FormTexture15_g263132;
					float2 temp_output_1627_0_g263126 = ((Global_FormTexture1633_g263126).xy*2.0 + -1.0);
					float2 break1617_g263126 = temp_output_1627_0_g263126;
					float dotResult1619_g263126 = dot( temp_output_1627_0_g263126 , temp_output_1627_0_g263126 );
					float3 appendResult1618_g263126 = (float3(break1617_g263126.x , sqrt( ( 1.0 - saturate( dotResult1619_g263126 ) ) ) , break1617_g263126.y));
					float3 worldToObjDir1623_g263126 = mul( unity_WorldToObject, float4( appendResult1618_g263126, 0.0 ) ).xyz;
					half3 Surface_Normal1630_g263126 = worldToObjDir1623_g263126;
					float temp_output_17_0_g263137 = _TransferMeshMode;
					float Option70_g263137 = temp_output_17_0_g263137;
					TVEModelData Data15_g263127 =(TVEModelData)Data15_g263001;
					float Out_Dummy15_g263127 = 0.0;
					float3 Out_PositionOS15_g263127 = float3( 0,0,0 );
					float3 Out_PositionWS15_g263127 = float3( 0,0,0 );
					float3 Out_PositionWO15_g263127 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g263127 = float3( 0,0,0 );
					float3 Out_PivotOS15_g263127 = float3( 0,0,0 );
					float3 Out_PivotWS15_g263127 = float3( 0,0,0 );
					float3 Out_PivotWO15_g263127 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263127 = float3( 0,0,0 );
					float3 Out_NormalWS15_g263127 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g263127 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263127 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g263127 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g263127 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g263127 = float3( 0,0,0 );
					float4 Out_CoordsData15_g263127 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g263127 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g263127 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g263127 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263127 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263127 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263127 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g263127 , Out_Dummy15_g263127 , Out_PositionOS15_g263127 , Out_PositionWS15_g263127 , Out_PositionWO15_g263127 , Out_PositionRawOS15_g263127 , Out_PivotOS15_g263127 , Out_PivotWS15_g263127 , Out_PivotWO15_g263127 , Out_NormalOS15_g263127 , Out_NormalWS15_g263127 , Out_NormalRawOS15_g263127 , Out_TangentOS15_g263127 , Out_TangentWS15_g263127 , Out_BitangentWS15_g263127 , Out_ViewDirWS15_g263127 , Out_CoordsData15_g263127 , Out_VertexData15_g263127 , Out_MasksData15_g263127 , Out_PhaseData15_g263127 , Out_TransformData15_g263127 , Out_RotationData15_g263127 , Out_Interpolator15_g263127 );
					float4 temp_output_1567_29_g263126 = Out_VertexData15_g263127;
					half4 Model_VertexData1608_g263126 = temp_output_1567_29_g263126;
					float4 temp_output_3_0_g263137 = Model_VertexData1608_g263126;
					float4 Channel70_g263137 = temp_output_3_0_g263137;
					float localSwitchChannel470_g263137 = SwitchChannel4( Option70_g263137 , Channel70_g263137 );
					float temp_output_1870_0_g263126 = localSwitchChannel470_g263137;
					float temp_output_7_0_g263136 = _TransferMeshRemap.x;
					float temp_output_9_0_g263136 = ( temp_output_1870_0_g263126 - temp_output_7_0_g263136 );
					float lerpResult1868_g263126 = lerp( 1.0 , saturate( ( temp_output_9_0_g263136 * _TransferMeshRemap.z ) ) , _TransferMeshValue);
					half Blend_MeshMask1876_g263126 = lerpResult1868_g263126;
					half Blend_Mask1742_g263126 = ( _TransferIntensityValue * Blend_MeshMask1876_g263126 * TVE_IsEnabled );
					float3 lerpResult1670_g263126 = lerp( Vertex_NormalOS1568_g263126 , Surface_Normal1630_g263126 , Blend_Mask1742_g263126);
					#ifdef TVE_TRANSFER
					float3 staticSwitch1716_g263126 = lerpResult1670_g263126;
					#else
					float3 staticSwitch1716_g263126 = Vertex_NormalOS1568_g263126;
					#endif
					half3 Final_NormalOS178_g263126 = staticSwitch1716_g263126;
					float3 In_NormalOS16_g263134 = Final_NormalOS178_g263126;
					half4 Vertex_TangentOS1749_g263126 = Out_TangentOS15_g263133;
					float4 appendResult1746_g263126 = (float4(cross( worldToObjDir1623_g263126 , float3( 0, 0, 1 ) ) , -1.0));
					half4 Surface_Tangent1747_g263126 = appendResult1746_g263126;
					float4 lerpResult1757_g263126 = lerp( Vertex_TangentOS1749_g263126 , Surface_Tangent1747_g263126 , Blend_Mask1742_g263126);
					#ifdef TVE_TRANSFER
					float4 staticSwitch1760_g263126 = lerpResult1757_g263126;
					#else
					float4 staticSwitch1760_g263126 = Vertex_TangentOS1749_g263126;
					#endif
					half4 Final_TangentOS1762_g263126 = staticSwitch1760_g263126;
					float4 In_TangentOS16_g263134 = Final_TangentOS1762_g263126;
					float4 In_TransformData16_g263134 = Out_TransformData15_g263133;
					float4 In_RotationData16_g263134 = Out_RotationData15_g263133;
					float4 In_Interpolator16_g263134 = Out_Interpolator15_g263133;
					BuildVertexData( Data16_g263134 , In_Dummy16_g263134 , In_PositionOS16_g263134 , In_NormalOS16_g263134 , In_TangentOS16_g263134 , In_TransformData16_g263134 , In_RotationData16_g263134 , In_Interpolator16_g263134 );
					TVEVertexData Data15_g263142 =(TVEVertexData)Data16_g263134;
					float Out_Dummy15_g263142 = 0.0;
					float3 Out_PositionOS15_g263142 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263142 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263142 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263142 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263142 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263142 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g263142 , Out_Dummy15_g263142 , Out_PositionOS15_g263142 , Out_NormalOS15_g263142 , Out_TangentOS15_g263142 , Out_TransformData15_g263142 , Out_RotationData15_g263142 , Out_Interpolator15_g263142 );
					TVEVertexData Data16_g263143 =(TVEVertexData)Data15_g263142;
					float In_Dummy16_g263143 = 0.0;
					TVEModelData Data16_g263128 =(TVEModelData)Data15_g263127;
					float temp_output_14_0_g263128 = 0.0;
					float In_Dummy16_g263128 = temp_output_14_0_g263128;
					float3 temp_output_4_0_g263128 = Out_PositionOS15_g263127;
					float3 In_PositionOS16_g263128 = temp_output_4_0_g263128;
					float3 In_PositionWS16_g263128 = Out_PositionWS15_g263127;
					float3 temp_output_1567_17_g263126 = Out_PositionWO15_g263127;
					float3 In_PositionWO16_g263128 = temp_output_1567_17_g263126;
					float3 In_PivotOS16_g263128 = Out_PivotOS15_g263127;
					float3 In_PivotWS16_g263128 = Out_PivotWS15_g263127;
					float3 In_PivotWO16_g263128 = Out_PivotWO15_g263127;
					float3 temp_output_21_0_g263128 = Out_NormalOS15_g263127;
					float3 In_NormalOS16_g263128 = temp_output_21_0_g263128;
					float3 temp_output_1567_21_g263126 = Out_NormalWS15_g263127;
					float3 In_NormalWS16_g263128 = temp_output_1567_21_g263126;
					float4 temp_output_6_0_g263128 = Out_TangentOS15_g263127;
					float4 In_TangentOS16_g263128 = temp_output_6_0_g263128;
					float3 In_ViewDirWS16_g263128 = Out_ViewDirWS15_g263127;
					float4 In_CoordsData16_g263128 = Out_CoordsData15_g263127;
					float4 In_VertexData16_g263128 = temp_output_1567_29_g263126;
					float4 In_MasksData16_g263128 = Out_MasksData15_g263127;
					float4 In_PhaseData16_g263128 = Out_PhaseData15_g263127;
					BuildModelVertData( Data16_g263128 , In_Dummy16_g263128 , In_PositionOS16_g263128 , In_PositionWS16_g263128 , In_PositionWO16_g263128 , In_PivotOS16_g263128 , In_PivotWS16_g263128 , In_PivotWO16_g263128 , In_NormalOS16_g263128 , In_NormalWS16_g263128 , In_TangentOS16_g263128 , In_ViewDirWS16_g263128 , In_CoordsData16_g263128 , In_VertexData16_g263128 , In_MasksData16_g263128 , In_PhaseData16_g263128 );
					TVEModelData Data15_g263141 =(TVEModelData)Data16_g263128;
					float Out_Dummy15_g263141 = 0.0;
					float3 Out_PositionOS15_g263141 = float3( 0,0,0 );
					float3 Out_PositionWS15_g263141 = float3( 0,0,0 );
					float3 Out_PositionWO15_g263141 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g263141 = float3( 0,0,0 );
					float3 Out_PivotOS15_g263141 = float3( 0,0,0 );
					float3 Out_PivotWS15_g263141 = float3( 0,0,0 );
					float3 Out_PivotWO15_g263141 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263141 = float3( 0,0,0 );
					float3 Out_NormalWS15_g263141 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g263141 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263141 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g263141 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g263141 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g263141 = float3( 0,0,0 );
					float4 Out_CoordsData15_g263141 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g263141 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g263141 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g263141 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263141 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263141 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263141 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g263141 , Out_Dummy15_g263141 , Out_PositionOS15_g263141 , Out_PositionWS15_g263141 , Out_PositionWO15_g263141 , Out_PositionRawOS15_g263141 , Out_PivotOS15_g263141 , Out_PivotWS15_g263141 , Out_PivotWO15_g263141 , Out_NormalOS15_g263141 , Out_NormalWS15_g263141 , Out_NormalRawOS15_g263141 , Out_TangentOS15_g263141 , Out_TangentWS15_g263141 , Out_BitangentWS15_g263141 , Out_ViewDirWS15_g263141 , Out_CoordsData15_g263141 , Out_VertexData15_g263141 , Out_MasksData15_g263141 , Out_PhaseData15_g263141 , Out_TransformData15_g263141 , Out_RotationData15_g263141 , Out_Interpolator15_g263141 );
					float3 In_PositionOS16_g263143 = ( Out_PositionOS15_g263142 + Out_PivotOS15_g263141 );
					float3 In_NormalOS16_g263143 = Out_NormalOS15_g263142;
					float4 In_TangentOS16_g263143 = Out_TangentOS15_g263142;
					float4 In_TransformData16_g263143 = Out_TransformData15_g263142;
					float4 In_RotationData16_g263143 = Out_RotationData15_g263142;
					float4 In_Interpolator16_g263143 = Out_Interpolator15_g263142;
					BuildVertexData( Data16_g263143 , In_Dummy16_g263143 , In_PositionOS16_g263143 , In_NormalOS16_g263143 , In_TangentOS16_g263143 , In_TransformData16_g263143 , In_RotationData16_g263143 , In_Interpolator16_g263143 );
					TVEVertexData Data15_g263231 =(TVEVertexData)Data16_g263143;
					float Out_Dummy15_g263231 = 0.0;
					float3 Out_PositionOS15_g263231 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263231 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263231 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263231 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263231 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263231 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g263231 , Out_Dummy15_g263231 , Out_PositionOS15_g263231 , Out_NormalOS15_g263231 , Out_TangentOS15_g263231 , Out_TransformData15_g263231 , Out_RotationData15_g263231 , Out_Interpolator15_g263231 );
					
					float3 ifLocalVar40_g263163 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g263163 = saturate( v.vertex.xyz );
					float3 ifLocalVar40_g263164 = 0;
					if( TVE_DEBUG_Index == 1.0 )
					ifLocalVar40_g263164 = saturate( v.normal );
					float3 ifLocalVar40_g263165 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g263165 = saturate( v.tangent.xyz );
					TVEModelData Data15_g263145 =(TVEModelData)Data26_g263144;
					float Out_Dummy15_g263145 = 0.0;
					float3 Out_PositionOS15_g263145 = float3( 0,0,0 );
					float3 Out_PositionWS15_g263145 = float3( 0,0,0 );
					float3 Out_PositionWO15_g263145 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g263145 = float3( 0,0,0 );
					float3 Out_PivotOS15_g263145 = float3( 0,0,0 );
					float3 Out_PivotWS15_g263145 = float3( 0,0,0 );
					float3 Out_PivotWO15_g263145 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263145 = float3( 0,0,0 );
					float3 Out_NormalWS15_g263145 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g263145 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263145 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g263145 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g263145 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g263145 = float3( 0,0,0 );
					float4 Out_CoordsData15_g263145 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g263145 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g263145 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g263145 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263145 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263145 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263145 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g263145 , Out_Dummy15_g263145 , Out_PositionOS15_g263145 , Out_PositionWS15_g263145 , Out_PositionWO15_g263145 , Out_PositionRawOS15_g263145 , Out_PivotOS15_g263145 , Out_PivotWS15_g263145 , Out_PivotWO15_g263145 , Out_NormalOS15_g263145 , Out_NormalWS15_g263145 , Out_NormalRawOS15_g263145 , Out_TangentOS15_g263145 , Out_TangentWS15_g263145 , Out_BitangentWS15_g263145 , Out_ViewDirWS15_g263145 , Out_CoordsData15_g263145 , Out_VertexData15_g263145 , Out_MasksData15_g263145 , Out_PhaseData15_g263145 , Out_TransformData15_g263145 , Out_RotationData15_g263145 , Out_Interpolator15_g263145 );
					float3 ifLocalVar40_g263177 = 0;
					if( TVE_DEBUG_Index == 3.0 )
					ifLocalVar40_g263177 = saturate( Out_PivotOS15_g263145 );
					TVEVertexData Data15_g263146 =(TVEVertexData)Data16_g263143;
					float Out_Dummy15_g263146 = 0.0;
					float3 Out_PositionOS15_g263146 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263146 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263146 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263146 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263146 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263146 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g263146 , Out_Dummy15_g263146 , Out_PositionOS15_g263146 , Out_NormalOS15_g263146 , Out_TangentOS15_g263146 , Out_TransformData15_g263146 , Out_RotationData15_g263146 , Out_Interpolator15_g263146 );
					float3 ifLocalVar40_g263166 = 0;
					if( TVE_DEBUG_Index == 5.0 )
					ifLocalVar40_g263166 = saturate( Out_PositionOS15_g263146 );
					float3 ifLocalVar40_g263168 = 0;
					if( TVE_DEBUG_Index == 6.0 )
					ifLocalVar40_g263168 = saturate( Out_NormalOS15_g263146 );
					float3 ifLocalVar40_g263167 = 0;
					if( TVE_DEBUG_Index == 7.0 )
					ifLocalVar40_g263167 = (Out_TangentOS15_g263146).xyz;
					float4 temp_output_2671_29 = Out_VertexData15_g263145;
					float3 ifLocalVar40_g263169 = 0;
					if( TVE_DEBUG_Index == 9.0 )
					ifLocalVar40_g263169 = (temp_output_2671_29).xxx;
					float3 ifLocalVar40_g263170 = 0;
					if( TVE_DEBUG_Index == 10.0 )
					ifLocalVar40_g263170 = (temp_output_2671_29).yyy;
					float3 ifLocalVar40_g263171 = 0;
					if( TVE_DEBUG_Index == 11.0 )
					ifLocalVar40_g263171 = (temp_output_2671_29).zzz;
					float3 ifLocalVar40_g263172 = 0;
					if( TVE_DEBUG_Index == 12.0 )
					ifLocalVar40_g263172 = (temp_output_2671_29).www;
					float4 temp_output_2671_30 = Out_MasksData15_g263145;
					float3 ifLocalVar40_g263173 = 0;
					if( TVE_DEBUG_Index == 14.0 )
					ifLocalVar40_g263173 = (temp_output_2671_30).xxx;
					float3 ifLocalVar40_g263174 = 0;
					if( TVE_DEBUG_Index == 15.0 )
					ifLocalVar40_g263174 = (temp_output_2671_30).yyy;
					float4 temp_output_2671_38 = Out_CoordsData15_g263145;
					float3 appendResult2701 = (float3((temp_output_2671_38).xy , 0.0));
					float3 ifLocalVar40_g263178 = 0;
					if( TVE_DEBUG_Index == 17.0 )
					ifLocalVar40_g263178 = appendResult2701;
					float3 appendResult2702 = (float3((v.texcoord1.xyzw.xy).xy , 0.0));
					float3 ifLocalVar40_g263175 = 0;
					if( TVE_DEBUG_Index == 18.0 )
					ifLocalVar40_g263175 = appendResult2702;
					float3 appendResult2706 = (float3((temp_output_2671_38).xy , 0.0));
					float3 ifLocalVar40_g263176 = 0;
					if( TVE_DEBUG_Index == 19.0 )
					ifLocalVar40_g263176 = appendResult2706;
					float3 ifLocalVar40_g263147 = 0;
					if( TVE_DEBUG_Index == 21.0 )
					ifLocalVar40_g263147 = (v.texcoord.xyzw.x).xxx;
					float3 ifLocalVar40_g263148 = 0;
					if( TVE_DEBUG_Index == 22.0 )
					ifLocalVar40_g263148 = (v.texcoord.xyzw.y).xxx;
					float3 ifLocalVar40_g263149 = 0;
					if( TVE_DEBUG_Index == 23.0 )
					ifLocalVar40_g263149 = (v.texcoord.xyzw.z).xxx;
					float3 ifLocalVar40_g263150 = 0;
					if( TVE_DEBUG_Index == 24.0 )
					ifLocalVar40_g263150 = (v.texcoord.xyzw.w).xxx;
					float3 ifLocalVar40_g263151 = 0;
					if( TVE_DEBUG_Index == 26.0 )
					ifLocalVar40_g263151 = (v.texcoord1.xyzw.x).xxx;
					float3 ifLocalVar40_g263152 = 0;
					if( TVE_DEBUG_Index == 27.0 )
					ifLocalVar40_g263152 = (v.texcoord1.xyzw.y).xxx;
					float3 ifLocalVar40_g263153 = 0;
					if( TVE_DEBUG_Index == 28.0 )
					ifLocalVar40_g263153 = (v.texcoord1.xyzw.z).xxx;
					float3 ifLocalVar40_g263154 = 0;
					if( TVE_DEBUG_Index == 29.0 )
					ifLocalVar40_g263154 = (v.texcoord1.xyzw.w).xxx;
					float3 ifLocalVar40_g263155 = 0;
					if( TVE_DEBUG_Index == 31.0 )
					ifLocalVar40_g263155 = (v.texcoord2.xyzw.x).xxx;
					float3 ifLocalVar40_g263156 = 0;
					if( TVE_DEBUG_Index == 32.0 )
					ifLocalVar40_g263156 = (v.texcoord2.xyzw.y).xxx;
					float3 ifLocalVar40_g263157 = 0;
					if( TVE_DEBUG_Index == 33.0 )
					ifLocalVar40_g263157 = (v.texcoord2.xyzw.z).xxx;
					float3 ifLocalVar40_g263158 = 0;
					if( TVE_DEBUG_Index == 34.0 )
					ifLocalVar40_g263158 = (v.texcoord2.xyzw.w).xxx;
					float3 ifLocalVar40_g263159 = 0;
					if( TVE_DEBUG_Index == 36.0 )
					ifLocalVar40_g263159 = (v.ase_texcoord3.x).xxx;
					float3 ifLocalVar40_g263160 = 0;
					if( TVE_DEBUG_Index == 37.0 )
					ifLocalVar40_g263160 = (v.ase_texcoord3.y).xxx;
					float3 ifLocalVar40_g263161 = 0;
					if( TVE_DEBUG_Index == 38.0 )
					ifLocalVar40_g263161 = (v.ase_texcoord3.z).xxx;
					float3 ifLocalVar40_g263162 = 0;
					if( TVE_DEBUG_Index == 39.0 )
					ifLocalVar40_g263162 = (v.ase_texcoord3.w).xxx;
					float3 vertexToFrag2524 = ( ( ifLocalVar40_g263163 + ifLocalVar40_g263164 + ifLocalVar40_g263165 + ifLocalVar40_g263177 ) + ( ifLocalVar40_g263166 + ifLocalVar40_g263168 + ifLocalVar40_g263167 ) + ( ifLocalVar40_g263169 + ifLocalVar40_g263170 + ifLocalVar40_g263171 + ifLocalVar40_g263172 ) + ( ifLocalVar40_g263173 + ifLocalVar40_g263174 ) + ( ifLocalVar40_g263178 + ifLocalVar40_g263175 + ifLocalVar40_g263176 ) + ( ( ifLocalVar40_g263147 + ifLocalVar40_g263148 + ifLocalVar40_g263149 + ifLocalVar40_g263150 ) + ( ifLocalVar40_g263151 + ifLocalVar40_g263152 + ifLocalVar40_g263153 + ifLocalVar40_g263154 ) + ( ifLocalVar40_g263155 + ifLocalVar40_g263156 + ifLocalVar40_g263157 + ifLocalVar40_g263158 ) + ( ifLocalVar40_g263159 + ifLocalVar40_g263160 + ifLocalVar40_g263161 + ifLocalVar40_g263162 ) ) );
					o.ase_texcoord6.xyz = vertexToFrag2524;
					float3 vertexPos57_g263223 = v.vertex.xyz;
					float4 ase_positionCS57_g263223 = UnityObjectToClipPos( vertexPos57_g263223 );
					o.ase_texcoord7 = ase_positionCS57_g263223;
					o.ase_texcoord11.xyz = vertexToFrag73_g263032;
					o.ase_texcoord12.xyz = vertexToFrag76_g263032;
					TVEVertexData Data1902_g263179 = Data16_g263143;
					float4 Out_Interpolator1902_g263179 = float4( 0,0,0,0 );
					{
					Out_Interpolator1902_g263179 = Data1902_g263179.Interpolator;
					}
					float4 vertexToFrag1901_g263179 = Out_Interpolator1902_g263179;
					o.ase_texcoord13 = vertexToFrag1901_g263179;
					
					o.ase_texcoord8 = v.vertex;
					o.ase_normal = v.normal;
					o.ase_texcoord9 = v.texcoord.xyzw;
					o.ase_texcoord10 = v.texcoord2.xyzw;
					o.ase_color = v.ase_color;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord6.w = 0;
					o.ase_texcoord11.w = 0;
					o.ase_texcoord12.w = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g263231;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g263231;
					v.tangent = Out_TangentOS15_g263231;

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

					float temp_output_2720_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2720_114).xxx;
					
					float3 temp_cast_1 = (temp_output_2720_114).xxx;
					
					float3 color130_g263223 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g263223 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g263225 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g263224 = ( temp_cast_4 * ( 0.5 + appendResult128_g263225 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g263224 = (float4(ddx( FinalUV13_g263224 ) , ddy( FinalUV13_g263224 )));
					float4 UVDerivatives17_g263224 = appendResult16_g263224;
					float4 break28_g263224 = UVDerivatives17_g263224;
					float2 appendResult19_g263224 = (float2(break28_g263224.x , break28_g263224.z));
					float2 appendResult20_g263224 = (float2(break28_g263224.x , break28_g263224.z));
					float dotResult24_g263224 = dot( appendResult19_g263224 , appendResult20_g263224 );
					float2 appendResult21_g263224 = (float2(break28_g263224.y , break28_g263224.w));
					float2 appendResult22_g263224 = (float2(break28_g263224.y , break28_g263224.w));
					float dotResult23_g263224 = dot( appendResult21_g263224 , appendResult22_g263224 );
					float2 appendResult25_g263224 = (float2(dotResult24_g263224 , dotResult23_g263224));
					float2 derivativesLength29_g263224 = sqrt( appendResult25_g263224 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g263224 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g263224 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g263224 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g263224 = clampResult57_g263224;
					float2 break55_g263224 = derivativesLength29_g263224;
					float4 lerpResult73_g263224 = lerp( float4( color130_g263223 , 0.0 ) , float4( color81_g263223 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g263224.x * break71_g263224.y * sqrt( saturate( ( 1.1 - max( break55_g263224.x, break55_g263224.y ) ) ) ) ) ) ));
					float3 vertexToFrag2524 = IN.ase_texcoord6.xyz;
					half3 Final_Debug2399 = vertexToFrag2524;
					float temp_output_7_0_g263230 = TVE_DEBUG_Min;
					float3 temp_cast_9 = (temp_output_7_0_g263230).xxx;
					float3 temp_output_9_0_g263230 = ( Final_Debug2399 - temp_cast_9 );
					float lerpResult76_g263223 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g263223 = lerpResult76_g263223;
					float3 lerpResult72_g263223 = lerp( (lerpResult73_g263224).rgb , saturate( ( temp_output_9_0_g263230 / ( ( TVE_DEBUG_Max - temp_output_7_0_g263230 ) + 0.0001 ) ) ) , Filter152_g263223);
					float dotResult61_g263223 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g263223 = ( 1.0 - saturate( dotResult61_g263223 ) );
					float Shading_Fresnel59_g263223 = (( 1.0 - ( temp_output_65_0_g263223 * temp_output_65_0_g263223 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g263223 = IN.ase_texcoord7;
					float depthLinearEye57_g263223 = LinearEyeDepth( ase_positionCS57_g263223.z / ase_positionCS57_g263223.w );
					float temp_output_69_0_g263223 = saturate(  (0.0 + ( depthLinearEye57_g263223 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g263223 = (( temp_output_69_0_g263223 * temp_output_69_0_g263223 )*0.5 + 0.5);
					float lerpResult84_g263223 = lerp( 1.0 , Shading_Fresnel59_g263223 , ( Shading_Distance58_g263223 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g263228 = ( 0.0 );
					float localBuildVisualData3_g263185 = ( 0.0 );
					float localBuildVisualData3_g263180 = ( 0.0 );
					TVEVisualData Data3_g263180 =(TVEVisualData)0;
					float temp_output_14_0_g263180 = 0.0;
					float In_Dummy3_g263180 = temp_output_14_0_g263180;
					float3 temp_cast_10 = (0.5).xxx;
					float3 temp_output_4_0_g263180 = temp_cast_10;
					float3 In_Albedo3_g263180 = temp_output_4_0_g263180;
					float3 temp_cast_11 = (0.5).xxx;
					float3 temp_output_44_0_g263180 = temp_cast_11;
					float3 In_AlbedoBase3_g263180 = temp_output_44_0_g263180;
					float2 temp_cast_12 = (0.0).xx;
					float2 In_NormalTS3_g263180 = temp_cast_12;
					float3 temp_cast_13 = (0.5).xxx;
					float3 In_NormalWS3_g263180 = temp_cast_13;
					float4 In_Shader3_g263180 = half4( 0, 1, 0, 1 );
					float4 In_Feature3_g263180 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g263180 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g263180 = half4( 1, 1, 1, 1 );
					float temp_output_12_0_g263180 = 0.5;
					float In_Grayscale3_g263180 = temp_output_12_0_g263180;
					float temp_output_16_0_g263180 = 1.0;
					float In_Luminosity3_g263180 = temp_output_16_0_g263180;
					float In_MultiMask3_g263180 = 1.0;
					float In_AlphaClip3_g263180 = 1.0;
					float In_AlphaFade3_g263180 = 1.0;
					float3 temp_cast_14 = (1.0).xxx;
					float3 In_Translucency3_g263180 = temp_cast_14;
					float In_Transmission3_g263180 = 1.0;
					float In_Thickness3_g263180 = 0.0;
					float In_Diffusion3_g263180 = 0.0;
					float In_Depth3_g263180 = 0.0;
					BuildVisualData( Data3_g263180 , In_Dummy3_g263180 , In_Albedo3_g263180 , In_AlbedoBase3_g263180 , In_NormalTS3_g263180 , In_NormalWS3_g263180 , In_Shader3_g263180 , In_Feature3_g263180 , In_Season3_g263180 , In_Emissive3_g263180 , In_Grayscale3_g263180 , In_Luminosity3_g263180 , In_MultiMask3_g263180 , In_AlphaClip3_g263180 , In_AlphaFade3_g263180 , In_Translucency3_g263180 , In_Transmission3_g263180 , In_Thickness3_g263180 , In_Diffusion3_g263180 , In_Depth3_g263180 );
					TVEVisualData Data3_g263185 =(TVEVisualData)Data3_g263180;
					half Dummy130_g263183 = ( _MainCategory + _MainEnd );
					float temp_output_14_0_g263185 = Dummy130_g263183;
					float In_Dummy3_g263185 = temp_output_14_0_g263185;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g263206) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g263188 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g263188 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g263188 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g263188 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g263188 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g263188 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g263206 = staticSwitch36_g263188;
					float localBreakTextureData456_g263206 = ( 0.0 );
					float localBuildTextureData431_g263205 = ( 0.0 );
					TVEMasksData Data431_g263205 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g263205 = ( 0.0 );
					float4 temp_output_6_0_g263221 = _main_coord_value;
					float4 temp_output_7_0_g263221 = ( _MainSampleMode + _MainCoordMode + _MainCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g263221 = ( temp_output_6_0_g263221 + temp_output_7_0_g263221 );
					#else
					float4 staticSwitch14_g263221 = temp_output_6_0_g263221;
					#endif
					half4 Local_Coords180_g263183 = staticSwitch14_g263221;
					float4 Coords444_g263205 = Local_Coords180_g263183;
					float localIfModelDataByShader26_g262420 = ( 0.0 );
					TVEModelData Data26_g262420 = (TVEModelData)0;
					TVEModelData Data16_g263030 =(TVEModelData)0;
					half Dummy207_g263012 = 0.0;
					float temp_output_14_0_g263030 = Dummy207_g263012;
					float In_Dummy16_g263030 = temp_output_14_0_g263030;
					float3 PositionOS131_g263012 = IN.ase_texcoord8.xyz;
					float3 temp_output_4_0_g263030 = PositionOS131_g263012;
					float3 In_PositionOS16_g263030 = temp_output_4_0_g263030;
					float3 temp_output_104_7_g263012 = PositionWS;
					float3 PositionWS122_g263012 = temp_output_104_7_g263012;
					float3 In_PositionWS16_g263030 = PositionWS122_g263012;
					float4x4 break19_g263015 = unity_ObjectToWorld;
					float3 appendResult20_g263015 = (float3(break19_g263015[ 0 ][ 3 ] , break19_g263015[ 1 ][ 3 ] , break19_g263015[ 2 ][ 3 ]));
					float3 temp_output_340_7_g263012 = appendResult20_g263015;
					float3 PivotWS121_g263012 = temp_output_340_7_g263012;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g263012 = ( PositionWS122_g263012 - PivotWS121_g263012 );
					#else
					float3 staticSwitch204_g263012 = PositionWS122_g263012;
					#endif
					float3 PositionWO132_g263012 = ( staticSwitch204_g263012 - TVE_WorldOrigin );
					float3 In_PositionWO16_g263030 = PositionWO132_g263012;
					float3 _Vector0 = float3(0,0,0);
					float3 PivotOS149_g263012 = _Vector0;
					float3 In_PivotOS16_g263030 = PivotOS149_g263012;
					float3 In_PivotWS16_g263030 = PivotWS121_g263012;
					float3 PivotWO133_g263012 = ( PivotWS121_g263012 - TVE_WorldOrigin );
					float3 In_PivotWO16_g263030 = PivotWO133_g263012;
					half3 NormalOS134_g263012 = IN.ase_normal;
					float3 temp_output_21_0_g263030 = NormalOS134_g263012;
					float3 In_NormalOS16_g263030 = temp_output_21_0_g263030;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g263012 = normalizedWorldNormal;
					float3 In_NormalWS16_g263030 = NormalWS95_g263012;
					float4 appendResult462_g263012 = (float4(cross( IN.ase_normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g263012 = appendResult462_g263012;
					float4 temp_output_6_0_g263030 = TangentlOS153_g263012;
					float4 In_TangentOS16_g263030 = temp_output_6_0_g263030;
					float3 normalizeResult296_g263012 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g263012 ) );
					half3 ViewDirWS169_g263012 = normalizeResult296_g263012;
					float3 In_ViewDirWS16_g263030 = ViewDirWS169_g263012;
					float4 appendResult397_g263012 = (float4(IN.ase_texcoord9.xy , IN.ase_texcoord10.xy));
					float4 CoordsData398_g263012 = appendResult397_g263012;
					float4 In_CoordsData16_g263030 = CoordsData398_g263012;
					half4 VertexMasks171_g263012 = float4( 0,0,0,0 );
					float4 In_VertexData16_g263030 = VertexMasks171_g263012;
					half4 MasksData254_g263012 = float4( 0,0,0,0 );
					float4 In_MasksData16_g263030 = MasksData254_g263012;
					half4 Phase_Data176_g263012 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g263030 = Phase_Data176_g263012;
					BuildModelVertData( Data16_g263030 , In_Dummy16_g263030 , In_PositionOS16_g263030 , In_PositionWS16_g263030 , In_PositionWO16_g263030 , In_PivotOS16_g263030 , In_PivotWS16_g263030 , In_PivotWO16_g263030 , In_NormalOS16_g263030 , In_NormalWS16_g263030 , In_TangentOS16_g263030 , In_ViewDirWS16_g263030 , In_CoordsData16_g263030 , In_VertexData16_g263030 , In_MasksData16_g263030 , In_PhaseData16_g263030 );
					TVEModelData DataDefault26_g262420 = Data16_g263030;
					TVEModelData Data16_g263040 =(TVEModelData)0;
					float In_Dummy16_g263040 = 0.0;
					float3 vertexToFrag73_g263032 = IN.ase_texcoord11.xyz;
					float3 PositionWS122_g263032 = vertexToFrag73_g263032;
					float3 In_PositionWS16_g263040 = PositionWS122_g263032;
					float3 vertexToFrag76_g263032 = IN.ase_texcoord12.xyz;
					float3 PivotWS121_g263032 = vertexToFrag76_g263032;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g263032 = ( PositionWS122_g263032 - PivotWS121_g263032 );
					#else
					float3 staticSwitch204_g263032 = PositionWS122_g263032;
					#endif
					float3 PositionWO132_g263032 = ( staticSwitch204_g263032 - TVE_WorldOrigin );
					float3 In_PositionWO16_g263040 = PositionWO132_g263032;
					float3 In_PivotWS16_g263040 = PivotWS121_g263032;
					float3 PivotWO133_g263032 = ( PivotWS121_g263032 - TVE_WorldOrigin );
					float3 In_PivotWO16_g263040 = PivotWO133_g263032;
					half3 NormalWS95_g263032 = normalizedWorldNormal;
					float3 In_NormalWS16_g263040 = NormalWS95_g263032;
					half3 TangentWS136_g263032 = TangentWS;
					float3 In_TangentWS16_g263040 = TangentWS136_g263032;
					half3 BiangentWS421_g263032 = BitangentWS;
					float3 In_BitangentWS16_g263040 = BiangentWS421_g263032;
					half3 NormalWS427_g263032 = NormalWS95_g263032;
					half3 localComputeTriplanarMasks427_g263032 = ComputeTriplanarMasks( NormalWS427_g263032 );
					half3 TriplanarWeights429_g263032 = localComputeTriplanarMasks427_g263032;
					float3 In_TriplanarWeights16_g263040 = TriplanarWeights429_g263032;
					float3 normalizeResult296_g263032 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g263032 ) );
					half3 ViewDirWS169_g263032 = normalizeResult296_g263032;
					float3 In_ViewDirWS16_g263040 = ViewDirWS169_g263032;
					float4 appendResult397_g263032 = (float4(IN.ase_texcoord9.xy , IN.ase_texcoord10.xy));
					float4 CoordsData398_g263032 = appendResult397_g263032;
					float4 In_CoordsData16_g263040 = CoordsData398_g263032;
					half4 VertexMasks171_g263032 = IN.ase_color;
					float4 In_VertexData16_g263040 = VertexMasks171_g263032;
					float temp_output_17_0_g263043 = _ObjectPhaseMode;
					float Option70_g263043 = temp_output_17_0_g263043;
					float4 temp_output_3_0_g263043 = IN.ase_color;
					float4 Channel70_g263043 = temp_output_3_0_g263043;
					float localSwitchChannel470_g263043 = SwitchChannel4( Option70_g263043 , Channel70_g263043 );
					half Phase_Value372_g263032 = localSwitchChannel470_g263043;
					float3 break319_g263032 = PivotWO133_g263032;
					half Pivot_Position322_g263032 = ( break319_g263032.x + break319_g263032.z );
					half Phase_Position357_g263032 = ( Phase_Value372_g263032 + Pivot_Position322_g263032 );
					float temp_output_248_0_g263032 = frac( Phase_Position357_g263032 );
					float4 appendResult177_g263032 = (float4((frac( ( Phase_Position357_g263032 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g263032));
					half4 Phase_Data176_g263032 = appendResult177_g263032;
					float4 In_Interpolator16_g263040 = Phase_Data176_g263032;
					BuildModelFragData( Data16_g263040 , In_Dummy16_g263040 , In_PositionWS16_g263040 , In_PositionWO16_g263040 , In_PivotWS16_g263040 , In_PivotWO16_g263040 , In_NormalWS16_g263040 , In_TangentWS16_g263040 , In_BitangentWS16_g263040 , In_TriplanarWeights16_g263040 , In_ViewDirWS16_g263040 , In_CoordsData16_g263040 , In_VertexData16_g263040 , In_Interpolator16_g263040 );
					TVEModelData DataGeneral26_g262420 = Data16_g263040;
					TVEModelData DataBlanket26_g262420 = Data16_g263040;
					TVEModelData DataImpostor26_g262420 = Data16_g263040;
					TVEModelData Data16_g263020 =(TVEModelData)0;
					float In_Dummy16_g263020 = 0.0;
					float3 In_PositionWS16_g263020 = PositionWS122_g263012;
					float3 In_PositionWO16_g263020 = PositionWO132_g263012;
					float3 In_PivotWS16_g263020 = PivotWS121_g263012;
					float3 In_PivotWO16_g263020 = PivotWO133_g263012;
					float3 In_NormalWS16_g263020 = NormalWS95_g263012;
					half3 TangentWS136_g263012 = TangentWS;
					float3 In_TangentWS16_g263020 = TangentWS136_g263012;
					half3 BiangentWS421_g263012 = BitangentWS;
					float3 In_BitangentWS16_g263020 = BiangentWS421_g263012;
					half3 NormalWS427_g263012 = NormalWS95_g263012;
					half3 localComputeTriplanarMasks427_g263012 = ComputeTriplanarMasks( NormalWS427_g263012 );
					half3 TriplanarWeights429_g263012 = localComputeTriplanarMasks427_g263012;
					float3 In_TriplanarWeights16_g263020 = TriplanarWeights429_g263012;
					float3 In_ViewDirWS16_g263020 = ViewDirWS169_g263012;
					float4 In_CoordsData16_g263020 = CoordsData398_g263012;
					float4 In_VertexData16_g263020 = VertexMasks171_g263012;
					float4 In_Interpolator16_g263020 = Phase_Data176_g263012;
					BuildModelFragData( Data16_g263020 , In_Dummy16_g263020 , In_PositionWS16_g263020 , In_PositionWO16_g263020 , In_PivotWS16_g263020 , In_PivotWO16_g263020 , In_NormalWS16_g263020 , In_TangentWS16_g263020 , In_BitangentWS16_g263020 , In_TriplanarWeights16_g263020 , In_ViewDirWS16_g263020 , In_CoordsData16_g263020 , In_VertexData16_g263020 , In_Interpolator16_g263020 );
					TVEModelData DataTerrain26_g262420 = Data16_g263020;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g262420 = IsShaderType2637;
					{
					if (Type26_g262420 == 0 )
					{
					Data26_g262420 = DataDefault26_g262420;
					}
					else if (Type26_g262420 == 1 )
					{
					Data26_g262420 = DataGeneral26_g262420;
					}
					else if (Type26_g262420 == 2 )
					{
					Data26_g262420 = DataBlanket26_g262420;
					}
					else if (Type26_g262420 == 3 )
					{
					Data26_g262420 = DataImpostor26_g262420;
					}
					else if (Type26_g262420 == 4 )
					{
					Data26_g262420 = DataTerrain26_g262420;
					}
					}
					TVEModelData Data15_g263181 =(TVEModelData)Data26_g262420;
					float Out_Dummy15_g263181 = 0.0;
					float3 Out_PositionWS15_g263181 = float3( 0,0,0 );
					float3 Out_PositionWO15_g263181 = float3( 0,0,0 );
					float3 Out_PivotWS15_g263181 = float3( 0,0,0 );
					float3 Out_PivotWO15_g263181 = float3( 0,0,0 );
					float3 Out_NormalWS15_g263181 = float3( 0,0,0 );
					float3 Out_TangentWS15_g263181 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g263181 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g263181 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g263181 = float3( 0,0,0 );
					float4 Out_CoordsData15_g263181 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g263181 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263181 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g263181 , Out_Dummy15_g263181 , Out_PositionWS15_g263181 , Out_PositionWO15_g263181 , Out_PivotWS15_g263181 , Out_PivotWO15_g263181 , Out_NormalWS15_g263181 , Out_TangentWS15_g263181 , Out_BitangentWS15_g263181 , Out_TriplanarWeights15_g263181 , Out_ViewDirWS15_g263181 , Out_CoordsData15_g263181 , Out_VertexData15_g263181 , Out_Interpolator15_g263181 );
					TVEModelData Data16_g263182 =(TVEModelData)Data15_g263181;
					float In_Dummy16_g263182 = Out_Dummy15_g263181;
					float3 In_PositionWS16_g263182 = Out_PositionWS15_g263181;
					float3 In_PositionWO16_g263182 = Out_PositionWO15_g263181;
					float3 In_PivotWS16_g263182 = Out_PivotWS15_g263181;
					float3 In_PivotWO16_g263182 = Out_PivotWO15_g263181;
					float3 In_NormalWS16_g263182 = Out_NormalWS15_g263181;
					float3 In_TangentWS16_g263182 = Out_TangentWS15_g263181;
					float3 In_BitangentWS16_g263182 = Out_BitangentWS15_g263181;
					float3 In_TriplanarWeights16_g263182 = Out_TriplanarWeights15_g263181;
					float3 In_ViewDirWS16_g263182 = Out_ViewDirWS15_g263181;
					float4 In_CoordsData16_g263182 = Out_CoordsData15_g263181;
					float4 In_VertexData16_g263182 = Out_VertexData15_g263181;
					float4 vertexToFrag1901_g263179 = IN.ase_texcoord13;
					float4 In_Interpolator16_g263182 = vertexToFrag1901_g263179;
					BuildModelFragData( Data16_g263182 , In_Dummy16_g263182 , In_PositionWS16_g263182 , In_PositionWO16_g263182 , In_PivotWS16_g263182 , In_PivotWO16_g263182 , In_NormalWS16_g263182 , In_TangentWS16_g263182 , In_BitangentWS16_g263182 , In_TriplanarWeights16_g263182 , In_ViewDirWS16_g263182 , In_CoordsData16_g263182 , In_VertexData16_g263182 , In_Interpolator16_g263182 );
					TVEModelData Data15_g263184 =(TVEModelData)Data16_g263182;
					float Out_Dummy15_g263184 = 0.0;
					float3 Out_PositionWS15_g263184 = float3( 0,0,0 );
					float3 Out_PositionWO15_g263184 = float3( 0,0,0 );
					float3 Out_PivotWS15_g263184 = float3( 0,0,0 );
					float3 Out_PivotWO15_g263184 = float3( 0,0,0 );
					float3 Out_NormalWS15_g263184 = float3( 0,0,0 );
					float3 Out_TangentWS15_g263184 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g263184 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g263184 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g263184 = float3( 0,0,0 );
					float4 Out_CoordsData15_g263184 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g263184 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263184 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g263184 , Out_Dummy15_g263184 , Out_PositionWS15_g263184 , Out_PositionWO15_g263184 , Out_PivotWS15_g263184 , Out_PivotWO15_g263184 , Out_NormalWS15_g263184 , Out_TangentWS15_g263184 , Out_BitangentWS15_g263184 , Out_TriplanarWeights15_g263184 , Out_ViewDirWS15_g263184 , Out_CoordsData15_g263184 , Out_VertexData15_g263184 , Out_Interpolator15_g263184 );
					float4 Model_CoordsData324_g263183 = Out_CoordsData15_g263184;
					float4 MeshCoords444_g263205 = Model_CoordsData324_g263183;
					float2 UV0444_g263205 = float2( 0,0 );
					float2 UV3444_g263205 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g263205 , MeshCoords444_g263205 , UV0444_g263205 , UV3444_g263205 );
					float4 appendResult430_g263205 = (float4(UV0444_g263205 , UV3444_g263205));
					float4 In_MaskA431_g263205 = appendResult430_g263205;
					float localComputeWorldCoords315_g263205 = ( 0.0 );
					float4 Coords315_g263205 = Local_Coords180_g263183;
					float3 Model_PositionWO222_g263183 = Out_PositionWO15_g263184;
					float3 PositionWS315_g263205 = Model_PositionWO222_g263183;
					float2 ZY315_g263205 = float2( 0,0 );
					float2 XZ315_g263205 = float2( 0,0 );
					float2 XY315_g263205 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g263205 , PositionWS315_g263205 , ZY315_g263205 , XZ315_g263205 , XY315_g263205 );
					float2 ZY402_g263205 = ZY315_g263205;
					float2 XZ403_g263205 = XZ315_g263205;
					float4 appendResult432_g263205 = (float4(ZY402_g263205 , XZ403_g263205));
					float4 In_MaskB431_g263205 = appendResult432_g263205;
					float2 XY404_g263205 = XY315_g263205;
					float localComputeStochasticCoords409_g263205 = ( 0.0 );
					float2 UV409_g263205 = ZY402_g263205;
					float2 UV1409_g263205 = float2( 0,0 );
					float2 UV2409_g263205 = float2( 0,0 );
					float2 UV3409_g263205 = float2( 0,0 );
					float3 Weights409_g263205 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g263205 , UV1409_g263205 , UV2409_g263205 , UV3409_g263205 , Weights409_g263205 );
					float4 appendResult433_g263205 = (float4(XY404_g263205 , UV1409_g263205));
					float4 In_MaskC431_g263205 = appendResult433_g263205;
					float4 appendResult434_g263205 = (float4(UV2409_g263205 , UV3409_g263205));
					float4 In_MaskD431_g263205 = appendResult434_g263205;
					float localComputeStochasticCoords422_g263205 = ( 0.0 );
					float2 UV422_g263205 = XZ403_g263205;
					float2 UV1422_g263205 = float2( 0,0 );
					float2 UV2422_g263205 = float2( 0,0 );
					float2 UV3422_g263205 = float2( 0,0 );
					float3 Weights422_g263205 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g263205 , UV1422_g263205 , UV2422_g263205 , UV3422_g263205 , Weights422_g263205 );
					float4 appendResult435_g263205 = (float4(UV1422_g263205 , UV2422_g263205));
					float4 In_MaskE431_g263205 = appendResult435_g263205;
					float localComputeStochasticCoords423_g263205 = ( 0.0 );
					float2 UV423_g263205 = XY404_g263205;
					float2 UV1423_g263205 = float2( 0,0 );
					float2 UV2423_g263205 = float2( 0,0 );
					float2 UV3423_g263205 = float2( 0,0 );
					float3 Weights423_g263205 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g263205 , UV1423_g263205 , UV2423_g263205 , UV3423_g263205 , Weights423_g263205 );
					float4 appendResult436_g263205 = (float4(UV3422_g263205 , UV1423_g263205));
					float4 In_MaskF431_g263205 = appendResult436_g263205;
					float4 appendResult437_g263205 = (float4(UV2423_g263205 , UV3423_g263205));
					float4 In_MaskG431_g263205 = appendResult437_g263205;
					float4 In_MaskH431_g263205 = float4( Weights409_g263205 , 0.0 );
					float4 In_MaskI431_g263205 = float4( Weights422_g263205 , 0.0 );
					float4 In_MaskJ431_g263205 = float4( Weights423_g263205 , 0.0 );
					half3 Model_NormalWS226_g263183 = Out_NormalWS15_g263184;
					float3 temp_output_449_0_g263205 = Model_NormalWS226_g263183;
					float4 In_MaskK431_g263205 = float4( temp_output_449_0_g263205 , 0.0 );
					half3 Model_TangentWS366_g263183 = Out_TangentWS15_g263184;
					float3 temp_output_450_0_g263205 = Model_TangentWS366_g263183;
					float4 In_MaskL431_g263205 = float4( temp_output_450_0_g263205 , 0.0 );
					half3 Model_BitangentWS367_g263183 = Out_BitangentWS15_g263184;
					float3 temp_output_451_0_g263205 = Model_BitangentWS367_g263183;
					float4 In_MaskM431_g263205 = float4( temp_output_451_0_g263205 , 0.0 );
					half3 Model_TriplanarWeights368_g263183 = Out_TriplanarWeights15_g263184;
					float3 temp_output_445_0_g263205 = Model_TriplanarWeights368_g263183;
					float4 In_MaskN431_g263205 = float4( temp_output_445_0_g263205 , 0.0 );
					BuildTextureData( Data431_g263205 , In_MaskA431_g263205 , In_MaskB431_g263205 , In_MaskC431_g263205 , In_MaskD431_g263205 , In_MaskE431_g263205 , In_MaskF431_g263205 , In_MaskG431_g263205 , In_MaskH431_g263205 , In_MaskI431_g263205 , In_MaskJ431_g263205 , In_MaskK431_g263205 , In_MaskL431_g263205 , In_MaskM431_g263205 , In_MaskN431_g263205 );
					TVEMasksData Data456_g263206 =(TVEMasksData)Data431_g263205;
					float4 Out_MaskA456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g263206 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g263206 , Out_MaskA456_g263206 , Out_MaskB456_g263206 , Out_MaskC456_g263206 , Out_MaskD456_g263206 , Out_MaskE456_g263206 , Out_MaskF456_g263206 , Out_MaskG456_g263206 , Out_MaskH456_g263206 , Out_MaskI456_g263206 , Out_MaskJ456_g263206 , Out_MaskK456_g263206 , Out_MaskL456_g263206 , Out_MaskM456_g263206 , Out_MaskN456_g263206 );
					half2 UV276_g263206 = (Out_MaskA456_g263206).xy;
					float temp_output_504_0_g263206 = 0.0;
					half Bias276_g263206 = temp_output_504_0_g263206;
					half2 Normal276_g263206 = float2( 0,0 );
					half4 localSampleCoord276_g263206 = SampleCoord( Texture276_g263206 , Sampler276_g263206 , UV276_g263206 , Bias276_g263206 , Normal276_g263206 );
					float4 temp_output_407_277_g263183 = localSampleCoord276_g263206;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g263206) = _MainAlbedoTex;
					SamplerState Sampler502_g263206 = staticSwitch36_g263188;
					half2 UV502_g263206 = (Out_MaskA456_g263206).zw;
					half Bias502_g263206 = temp_output_504_0_g263206;
					half2 Normal502_g263206 = float2( 0,0 );
					half4 localSampleCoord502_g263206 = SampleCoord( Texture502_g263206 , Sampler502_g263206 , UV502_g263206 , Bias502_g263206 , Normal502_g263206 );
					float4 temp_output_407_278_g263183 = localSampleCoord502_g263206;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g263206) = _MainAlbedoTex;
					SamplerState Sampler496_g263206 = staticSwitch36_g263188;
					float2 temp_output_463_0_g263206 = (Out_MaskB456_g263206).zw;
					half2 XZ496_g263206 = temp_output_463_0_g263206;
					half Bias496_g263206 = temp_output_504_0_g263206;
					half3 NormalWS512_g263206 = (Out_MaskK456_g263206).xyz;
					half3 NormalWS496_g263206 = NormalWS512_g263206;
					half3 Normal496_g263206 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g263206 = SamplePlanar2D( Texture496_g263206 , Sampler496_g263206 , XZ496_g263206 , Bias496_g263206 , NormalWS496_g263206 , Normal496_g263206 );
					float4 temp_output_407_0_g263183 = localSamplePlanar2D496_g263206;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g263206) = _MainAlbedoTex;
					SamplerState Sampler490_g263206 = staticSwitch36_g263188;
					float2 temp_output_462_0_g263206 = (Out_MaskB456_g263206).xy;
					half2 ZY490_g263206 = temp_output_462_0_g263206;
					half2 XZ490_g263206 = temp_output_463_0_g263206;
					float2 temp_output_464_0_g263206 = (Out_MaskC456_g263206).xy;
					half2 XY490_g263206 = temp_output_464_0_g263206;
					half Bias490_g263206 = temp_output_504_0_g263206;
					half3 Triplanar522_g263206 = (Out_MaskN456_g263206).xyz;
					half3 Triplanar490_g263206 = Triplanar522_g263206;
					half3 NormalWS490_g263206 = NormalWS512_g263206;
					half3 Normal490_g263206 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g263206 = SamplePlanar3D( Texture490_g263206 , Sampler490_g263206 , ZY490_g263206 , XZ490_g263206 , XY490_g263206 , Bias490_g263206 , Triplanar490_g263206 , NormalWS490_g263206 , Normal490_g263206 );
					float4 temp_output_407_201_g263183 = localSamplePlanar3D490_g263206;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g263206) = _MainAlbedoTex;
					SamplerState Sampler498_g263206 = staticSwitch36_g263188;
					half2 XZ498_g263206 = temp_output_463_0_g263206;
					float2 temp_output_473_0_g263206 = (Out_MaskE456_g263206).xy;
					half2 XZ_1498_g263206 = temp_output_473_0_g263206;
					float2 temp_output_474_0_g263206 = (Out_MaskE456_g263206).zw;
					half2 XZ_2498_g263206 = temp_output_474_0_g263206;
					float2 temp_output_475_0_g263206 = (Out_MaskF456_g263206).xy;
					half2 XZ_3498_g263206 = temp_output_475_0_g263206;
					float temp_output_510_0_g263206 = exp2( temp_output_504_0_g263206 );
					half Bias498_g263206 = temp_output_510_0_g263206;
					float3 temp_output_480_0_g263206 = (Out_MaskI456_g263206).xyz;
					half3 Weights_2498_g263206 = temp_output_480_0_g263206;
					half3 NormalWS498_g263206 = NormalWS512_g263206;
					half3 Normal498_g263206 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g263206 = SampleStochastic2D( Texture498_g263206 , Sampler498_g263206 , XZ498_g263206 , XZ_1498_g263206 , XZ_2498_g263206 , XZ_3498_g263206 , Bias498_g263206 , Weights_2498_g263206 , NormalWS498_g263206 , Normal498_g263206 );
					float4 temp_output_407_202_g263183 = localSampleStochastic2D498_g263206;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g263206) = _MainAlbedoTex;
					SamplerState Sampler500_g263206 = staticSwitch36_g263188;
					half2 ZY500_g263206 = temp_output_462_0_g263206;
					half2 ZY_1500_g263206 = (Out_MaskC456_g263206).zw;
					half2 ZY_2500_g263206 = (Out_MaskD456_g263206).xy;
					half2 ZY_3500_g263206 = (Out_MaskD456_g263206).zw;
					half2 XZ500_g263206 = temp_output_463_0_g263206;
					half2 XZ_1500_g263206 = temp_output_473_0_g263206;
					half2 XZ_2500_g263206 = temp_output_474_0_g263206;
					half2 XZ_3500_g263206 = temp_output_475_0_g263206;
					half2 XY500_g263206 = temp_output_464_0_g263206;
					half2 XY_1500_g263206 = (Out_MaskF456_g263206).zw;
					half2 XY_2500_g263206 = (Out_MaskG456_g263206).xy;
					half2 XY_3500_g263206 = (Out_MaskG456_g263206).zw;
					half Bias500_g263206 = temp_output_510_0_g263206;
					half3 Weights_1500_g263206 = (Out_MaskH456_g263206).xyz;
					half3 Weights_2500_g263206 = temp_output_480_0_g263206;
					half3 Weights_3500_g263206 = (Out_MaskJ456_g263206).xyz;
					half3 Triplanar500_g263206 = Triplanar522_g263206;
					half3 NormalWS500_g263206 = NormalWS512_g263206;
					half3 Normal500_g263206 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g263206 = SampleStochastic3D( Texture500_g263206 , Sampler500_g263206 , ZY500_g263206 , ZY_1500_g263206 , ZY_2500_g263206 , ZY_3500_g263206 , XZ500_g263206 , XZ_1500_g263206 , XZ_2500_g263206 , XZ_3500_g263206 , XY500_g263206 , XY_1500_g263206 , XY_2500_g263206 , XY_3500_g263206 , Bias500_g263206 , Weights_1500_g263206 , Weights_2500_g263206 , Weights_3500_g263206 , Triplanar500_g263206 , NormalWS500_g263206 , Normal500_g263206 );
					float4 temp_output_407_203_g263183 = localSampleStochastic3D500_g263206;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g263183 = temp_output_407_277_g263183;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g263183 = temp_output_407_278_g263183;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g263183 = temp_output_407_0_g263183;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g263183 = temp_output_407_201_g263183;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g263183 = temp_output_407_202_g263183;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g263183 = temp_output_407_203_g263183;
					#else
					float4 staticSwitch184_g263183 = temp_output_407_277_g263183;
					#endif
					half4 Local_AlbedoSample185_g263183 = staticSwitch184_g263183;
					float3 lerpResult53_g263183 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g263183).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g263183 = lerpResult53_g263183;
					float temp_output_17_0_g263203 = _MainMultiWriteMode;
					float Option91_g263203 = temp_output_17_0_g263203;
					float4 Model_VertexData418_g263183 = Out_VertexData15_g263184;
					float4 temp_output_84_0_g263203 = Model_VertexData418_g263183;
					float4 ChannelA91_g263203 = temp_output_84_0_g263203;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g263191) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g263190 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g263190 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g263190 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g263190 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g263190 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g263190 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g263191 = staticSwitch38_g263190;
					float localBreakTextureData456_g263191 = ( 0.0 );
					TVEMasksData Data456_g263191 =(TVEMasksData)Data431_g263205;
					float4 Out_MaskA456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g263191 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g263191 , Out_MaskA456_g263191 , Out_MaskB456_g263191 , Out_MaskC456_g263191 , Out_MaskD456_g263191 , Out_MaskE456_g263191 , Out_MaskF456_g263191 , Out_MaskG456_g263191 , Out_MaskH456_g263191 , Out_MaskI456_g263191 , Out_MaskJ456_g263191 , Out_MaskK456_g263191 , Out_MaskL456_g263191 , Out_MaskM456_g263191 , Out_MaskN456_g263191 );
					half2 UV276_g263191 = (Out_MaskA456_g263191).xy;
					float temp_output_504_0_g263191 = 0.0;
					half Bias276_g263191 = temp_output_504_0_g263191;
					half2 Normal276_g263191 = float2( 0,0 );
					half4 localSampleCoord276_g263191 = SampleCoord( Texture276_g263191 , Sampler276_g263191 , UV276_g263191 , Bias276_g263191 , Normal276_g263191 );
					float4 temp_output_405_277_g263183 = localSampleCoord276_g263191;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g263191) = _MainShaderTex;
					SamplerState Sampler502_g263191 = staticSwitch38_g263190;
					half2 UV502_g263191 = (Out_MaskA456_g263191).zw;
					half Bias502_g263191 = temp_output_504_0_g263191;
					half2 Normal502_g263191 = float2( 0,0 );
					half4 localSampleCoord502_g263191 = SampleCoord( Texture502_g263191 , Sampler502_g263191 , UV502_g263191 , Bias502_g263191 , Normal502_g263191 );
					float4 temp_output_405_278_g263183 = localSampleCoord502_g263191;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g263191) = _MainShaderTex;
					SamplerState Sampler496_g263191 = staticSwitch38_g263190;
					float2 temp_output_463_0_g263191 = (Out_MaskB456_g263191).zw;
					half2 XZ496_g263191 = temp_output_463_0_g263191;
					half Bias496_g263191 = temp_output_504_0_g263191;
					half3 NormalWS512_g263191 = (Out_MaskK456_g263191).xyz;
					half3 NormalWS496_g263191 = NormalWS512_g263191;
					half3 Normal496_g263191 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g263191 = SamplePlanar2D( Texture496_g263191 , Sampler496_g263191 , XZ496_g263191 , Bias496_g263191 , NormalWS496_g263191 , Normal496_g263191 );
					float4 temp_output_405_0_g263183 = localSamplePlanar2D496_g263191;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g263191) = _MainShaderTex;
					SamplerState Sampler490_g263191 = staticSwitch38_g263190;
					float2 temp_output_462_0_g263191 = (Out_MaskB456_g263191).xy;
					half2 ZY490_g263191 = temp_output_462_0_g263191;
					half2 XZ490_g263191 = temp_output_463_0_g263191;
					float2 temp_output_464_0_g263191 = (Out_MaskC456_g263191).xy;
					half2 XY490_g263191 = temp_output_464_0_g263191;
					half Bias490_g263191 = temp_output_504_0_g263191;
					half3 Triplanar522_g263191 = (Out_MaskN456_g263191).xyz;
					half3 Triplanar490_g263191 = Triplanar522_g263191;
					half3 NormalWS490_g263191 = NormalWS512_g263191;
					half3 Normal490_g263191 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g263191 = SamplePlanar3D( Texture490_g263191 , Sampler490_g263191 , ZY490_g263191 , XZ490_g263191 , XY490_g263191 , Bias490_g263191 , Triplanar490_g263191 , NormalWS490_g263191 , Normal490_g263191 );
					float4 temp_output_405_201_g263183 = localSamplePlanar3D490_g263191;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g263191) = _MainShaderTex;
					SamplerState Sampler498_g263191 = staticSwitch38_g263190;
					half2 XZ498_g263191 = temp_output_463_0_g263191;
					float2 temp_output_473_0_g263191 = (Out_MaskE456_g263191).xy;
					half2 XZ_1498_g263191 = temp_output_473_0_g263191;
					float2 temp_output_474_0_g263191 = (Out_MaskE456_g263191).zw;
					half2 XZ_2498_g263191 = temp_output_474_0_g263191;
					float2 temp_output_475_0_g263191 = (Out_MaskF456_g263191).xy;
					half2 XZ_3498_g263191 = temp_output_475_0_g263191;
					float temp_output_510_0_g263191 = exp2( temp_output_504_0_g263191 );
					half Bias498_g263191 = temp_output_510_0_g263191;
					float3 temp_output_480_0_g263191 = (Out_MaskI456_g263191).xyz;
					half3 Weights_2498_g263191 = temp_output_480_0_g263191;
					half3 NormalWS498_g263191 = NormalWS512_g263191;
					half3 Normal498_g263191 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g263191 = SampleStochastic2D( Texture498_g263191 , Sampler498_g263191 , XZ498_g263191 , XZ_1498_g263191 , XZ_2498_g263191 , XZ_3498_g263191 , Bias498_g263191 , Weights_2498_g263191 , NormalWS498_g263191 , Normal498_g263191 );
					float4 temp_output_405_202_g263183 = localSampleStochastic2D498_g263191;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g263191) = _MainShaderTex;
					SamplerState Sampler500_g263191 = staticSwitch38_g263190;
					half2 ZY500_g263191 = temp_output_462_0_g263191;
					half2 ZY_1500_g263191 = (Out_MaskC456_g263191).zw;
					half2 ZY_2500_g263191 = (Out_MaskD456_g263191).xy;
					half2 ZY_3500_g263191 = (Out_MaskD456_g263191).zw;
					half2 XZ500_g263191 = temp_output_463_0_g263191;
					half2 XZ_1500_g263191 = temp_output_473_0_g263191;
					half2 XZ_2500_g263191 = temp_output_474_0_g263191;
					half2 XZ_3500_g263191 = temp_output_475_0_g263191;
					half2 XY500_g263191 = temp_output_464_0_g263191;
					half2 XY_1500_g263191 = (Out_MaskF456_g263191).zw;
					half2 XY_2500_g263191 = (Out_MaskG456_g263191).xy;
					half2 XY_3500_g263191 = (Out_MaskG456_g263191).zw;
					half Bias500_g263191 = temp_output_510_0_g263191;
					half3 Weights_1500_g263191 = (Out_MaskH456_g263191).xyz;
					half3 Weights_2500_g263191 = temp_output_480_0_g263191;
					half3 Weights_3500_g263191 = (Out_MaskJ456_g263191).xyz;
					half3 Triplanar500_g263191 = Triplanar522_g263191;
					half3 NormalWS500_g263191 = NormalWS512_g263191;
					half3 Normal500_g263191 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g263191 = SampleStochastic3D( Texture500_g263191 , Sampler500_g263191 , ZY500_g263191 , ZY_1500_g263191 , ZY_2500_g263191 , ZY_3500_g263191 , XZ500_g263191 , XZ_1500_g263191 , XZ_2500_g263191 , XZ_3500_g263191 , XY500_g263191 , XY_1500_g263191 , XY_2500_g263191 , XY_3500_g263191 , Bias500_g263191 , Weights_1500_g263191 , Weights_2500_g263191 , Weights_3500_g263191 , Triplanar500_g263191 , NormalWS500_g263191 , Normal500_g263191 );
					float4 temp_output_405_203_g263183 = localSampleStochastic3D500_g263191;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g263183 = temp_output_405_277_g263183;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g263183 = temp_output_405_278_g263183;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g263183 = temp_output_405_0_g263183;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g263183 = temp_output_405_201_g263183;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g263183 = temp_output_405_202_g263183;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g263183 = temp_output_405_203_g263183;
					#else
					float4 staticSwitch198_g263183 = temp_output_405_277_g263183;
					#endif
					half4 Local_ShaderSample199_g263183 = staticSwitch198_g263183;
					float2 appendResult428_g263183 = (float2((Local_AlbedoSample185_g263183).w , (Local_ShaderSample199_g263183).z));
					float2 temp_output_85_0_g263203 = appendResult428_g263183;
					float4 ChannelB91_g263203 = float4( temp_output_85_0_g263203, 0.0 , 0.0 );
					float localSwitchChannel691_g263203 = SwitchChannel6( Option91_g263203 , ChannelA91_g263203 , ChannelB91_g263203 );
					float clampResult17_g263201 = clamp( localSwitchChannel691_g263203 , 0.0001 , 0.9999 );
					float temp_output_7_0_g263202 = _MainMultiWriteRemap.x;
					float temp_output_9_0_g263202 = ( clampResult17_g263201 - temp_output_7_0_g263202 );
					half Local_MultiMask78_g263183 = saturate( ( temp_output_9_0_g263202 * _MainMultiWriteRemap.z ) );
					float lerpResult58_g263183 = lerp( 1.0 , Local_MultiMask78_g263183 , _MainColorMode);
					float4 lerpResult62_g263183 = lerp( _MainColorTwo , _MainColor , lerpResult58_g263183);
					half3 Local_ColorRGB93_g263183 = (lerpResult62_g263183).rgb;
					half3 Local_Albedo139_g263183 = ( Local_AlbedoRGB107_g263183 * Local_ColorRGB93_g263183 );
					float3 temp_output_4_0_g263185 = Local_Albedo139_g263183;
					float3 In_Albedo3_g263185 = temp_output_4_0_g263185;
					float3 temp_output_44_0_g263185 = Local_Albedo139_g263183;
					float3 In_AlbedoBase3_g263185 = temp_output_44_0_g263185;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g263212) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g263189 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g263189 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g263189 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g263189 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g263189 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g263189 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g263212 = staticSwitch37_g263189;
					float localBreakTextureData456_g263212 = ( 0.0 );
					TVEMasksData Data456_g263212 =(TVEMasksData)Data431_g263205;
					float4 Out_MaskA456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g263212 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g263212 , Out_MaskA456_g263212 , Out_MaskB456_g263212 , Out_MaskC456_g263212 , Out_MaskD456_g263212 , Out_MaskE456_g263212 , Out_MaskF456_g263212 , Out_MaskG456_g263212 , Out_MaskH456_g263212 , Out_MaskI456_g263212 , Out_MaskJ456_g263212 , Out_MaskK456_g263212 , Out_MaskL456_g263212 , Out_MaskM456_g263212 , Out_MaskN456_g263212 );
					half2 UV276_g263212 = (Out_MaskA456_g263212).xy;
					float temp_output_504_0_g263212 = 0.0;
					half Bias276_g263212 = temp_output_504_0_g263212;
					half2 Normal276_g263212 = float2( 0,0 );
					half4 localSampleCoord276_g263212 = SampleCoord( Texture276_g263212 , Sampler276_g263212 , UV276_g263212 , Bias276_g263212 , Normal276_g263212 );
					float2 temp_output_406_394_g263183 = Normal276_g263212;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g263212) = _MainNormalTex;
					SamplerState Sampler502_g263212 = staticSwitch37_g263189;
					half2 UV502_g263212 = (Out_MaskA456_g263212).zw;
					half Bias502_g263212 = temp_output_504_0_g263212;
					half2 Normal502_g263212 = float2( 0,0 );
					half4 localSampleCoord502_g263212 = SampleCoord( Texture502_g263212 , Sampler502_g263212 , UV502_g263212 , Bias502_g263212 , Normal502_g263212 );
					float2 temp_output_406_397_g263183 = Normal502_g263212;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g263212) = _MainNormalTex;
					SamplerState Sampler496_g263212 = staticSwitch37_g263189;
					float2 temp_output_463_0_g263212 = (Out_MaskB456_g263212).zw;
					half2 XZ496_g263212 = temp_output_463_0_g263212;
					half Bias496_g263212 = temp_output_504_0_g263212;
					half3 NormalWS512_g263212 = (Out_MaskK456_g263212).xyz;
					half3 NormalWS496_g263212 = NormalWS512_g263212;
					half3 Normal496_g263212 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g263212 = SamplePlanar2D( Texture496_g263212 , Sampler496_g263212 , XZ496_g263212 , Bias496_g263212 , NormalWS496_g263212 , Normal496_g263212 );
					float3 temp_output_35_0_g263215 = Normal496_g263212;
					half3 TangentWS519_g263212 = (Out_MaskL456_g263212).xyz;
					float dotResult84_g263215 = dot( temp_output_35_0_g263215 , TangentWS519_g263212 );
					half3 BitangentWS521_g263212 = (Out_MaskM456_g263212).xyz;
					float dotResult85_g263215 = dot( temp_output_35_0_g263215 , BitangentWS521_g263212 );
					float2 appendResult87_g263215 = (float2(dotResult84_g263215 , dotResult85_g263215));
					float2 temp_output_406_375_g263183 = appendResult87_g263215;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g263212) = _MainNormalTex;
					SamplerState Sampler490_g263212 = staticSwitch37_g263189;
					float2 temp_output_462_0_g263212 = (Out_MaskB456_g263212).xy;
					half2 ZY490_g263212 = temp_output_462_0_g263212;
					half2 XZ490_g263212 = temp_output_463_0_g263212;
					float2 temp_output_464_0_g263212 = (Out_MaskC456_g263212).xy;
					half2 XY490_g263212 = temp_output_464_0_g263212;
					half Bias490_g263212 = temp_output_504_0_g263212;
					half3 Triplanar522_g263212 = (Out_MaskN456_g263212).xyz;
					half3 Triplanar490_g263212 = Triplanar522_g263212;
					half3 NormalWS490_g263212 = NormalWS512_g263212;
					half3 Normal490_g263212 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g263212 = SamplePlanar3D( Texture490_g263212 , Sampler490_g263212 , ZY490_g263212 , XZ490_g263212 , XY490_g263212 , Bias490_g263212 , Triplanar490_g263212 , NormalWS490_g263212 , Normal490_g263212 );
					float3 temp_output_35_0_g263216 = Normal490_g263212;
					float dotResult84_g263216 = dot( temp_output_35_0_g263216 , TangentWS519_g263212 );
					float dotResult85_g263216 = dot( temp_output_35_0_g263216 , BitangentWS521_g263212 );
					float2 appendResult87_g263216 = (float2(dotResult84_g263216 , dotResult85_g263216));
					float2 temp_output_406_353_g263183 = appendResult87_g263216;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g263212) = _MainNormalTex;
					SamplerState Sampler498_g263212 = staticSwitch37_g263189;
					half2 XZ498_g263212 = temp_output_463_0_g263212;
					float2 temp_output_473_0_g263212 = (Out_MaskE456_g263212).xy;
					half2 XZ_1498_g263212 = temp_output_473_0_g263212;
					float2 temp_output_474_0_g263212 = (Out_MaskE456_g263212).zw;
					half2 XZ_2498_g263212 = temp_output_474_0_g263212;
					float2 temp_output_475_0_g263212 = (Out_MaskF456_g263212).xy;
					half2 XZ_3498_g263212 = temp_output_475_0_g263212;
					float temp_output_510_0_g263212 = exp2( temp_output_504_0_g263212 );
					half Bias498_g263212 = temp_output_510_0_g263212;
					float3 temp_output_480_0_g263212 = (Out_MaskI456_g263212).xyz;
					half3 Weights_2498_g263212 = temp_output_480_0_g263212;
					half3 NormalWS498_g263212 = NormalWS512_g263212;
					half3 Normal498_g263212 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g263212 = SampleStochastic2D( Texture498_g263212 , Sampler498_g263212 , XZ498_g263212 , XZ_1498_g263212 , XZ_2498_g263212 , XZ_3498_g263212 , Bias498_g263212 , Weights_2498_g263212 , NormalWS498_g263212 , Normal498_g263212 );
					float3 temp_output_35_0_g263217 = Normal498_g263212;
					float dotResult84_g263217 = dot( temp_output_35_0_g263217 , TangentWS519_g263212 );
					float dotResult85_g263217 = dot( temp_output_35_0_g263217 , BitangentWS521_g263212 );
					float2 appendResult87_g263217 = (float2(dotResult84_g263217 , dotResult85_g263217));
					float2 temp_output_406_391_g263183 = appendResult87_g263217;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g263212) = _MainNormalTex;
					SamplerState Sampler500_g263212 = staticSwitch37_g263189;
					half2 ZY500_g263212 = temp_output_462_0_g263212;
					half2 ZY_1500_g263212 = (Out_MaskC456_g263212).zw;
					half2 ZY_2500_g263212 = (Out_MaskD456_g263212).xy;
					half2 ZY_3500_g263212 = (Out_MaskD456_g263212).zw;
					half2 XZ500_g263212 = temp_output_463_0_g263212;
					half2 XZ_1500_g263212 = temp_output_473_0_g263212;
					half2 XZ_2500_g263212 = temp_output_474_0_g263212;
					half2 XZ_3500_g263212 = temp_output_475_0_g263212;
					half2 XY500_g263212 = temp_output_464_0_g263212;
					half2 XY_1500_g263212 = (Out_MaskF456_g263212).zw;
					half2 XY_2500_g263212 = (Out_MaskG456_g263212).xy;
					half2 XY_3500_g263212 = (Out_MaskG456_g263212).zw;
					half Bias500_g263212 = temp_output_510_0_g263212;
					half3 Weights_1500_g263212 = (Out_MaskH456_g263212).xyz;
					half3 Weights_2500_g263212 = temp_output_480_0_g263212;
					half3 Weights_3500_g263212 = (Out_MaskJ456_g263212).xyz;
					half3 Triplanar500_g263212 = Triplanar522_g263212;
					half3 NormalWS500_g263212 = NormalWS512_g263212;
					half3 Normal500_g263212 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g263212 = SampleStochastic3D( Texture500_g263212 , Sampler500_g263212 , ZY500_g263212 , ZY_1500_g263212 , ZY_2500_g263212 , ZY_3500_g263212 , XZ500_g263212 , XZ_1500_g263212 , XZ_2500_g263212 , XZ_3500_g263212 , XY500_g263212 , XY_1500_g263212 , XY_2500_g263212 , XY_3500_g263212 , Bias500_g263212 , Weights_1500_g263212 , Weights_2500_g263212 , Weights_3500_g263212 , Triplanar500_g263212 , NormalWS500_g263212 , Normal500_g263212 );
					float3 temp_output_35_0_g263213 = Normal500_g263212;
					float dotResult84_g263213 = dot( temp_output_35_0_g263213 , TangentWS519_g263212 );
					float dotResult85_g263213 = dot( temp_output_35_0_g263213 , BitangentWS521_g263212 );
					float2 appendResult87_g263213 = (float2(dotResult84_g263213 , dotResult85_g263213));
					float2 temp_output_406_390_g263183 = appendResult87_g263213;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g263183 = temp_output_406_394_g263183;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g263183 = temp_output_406_397_g263183;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g263183 = temp_output_406_375_g263183;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g263183 = temp_output_406_353_g263183;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g263183 = temp_output_406_391_g263183;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g263183 = temp_output_406_390_g263183;
					#else
					float2 staticSwitch193_g263183 = temp_output_406_394_g263183;
					#endif
					half2 Local_NormaSample191_g263183 = staticSwitch193_g263183;
					half2 Local_NormalTS108_g263183 = ( Local_NormaSample191_g263183 * _MainNormalValue );
					float2 In_NormalTS3_g263185 = Local_NormalTS108_g263183;
					float2 break80_g263204 = Local_NormalTS108_g263183;
					float3 temp_output_77_0_g263204 = Model_TangentWS366_g263183;
					float3 temp_output_78_0_g263204 = Model_BitangentWS367_g263183;
					float3 temp_output_76_0_g263204 = Model_NormalWS226_g263183;
					half3 Local_NormalWS250_g263183 = ( ( break80_g263204.x * temp_output_77_0_g263204 ) + ( break80_g263204.y * temp_output_78_0_g263204 ) + temp_output_76_0_g263204 );
					float3 In_NormalWS3_g263185 = Local_NormalWS250_g263183;
					float temp_output_209_0_g263183 = (Local_ShaderSample199_g263183).y;
					float temp_output_7_0_g263197 = _MainOcclusionRemap.x;
					float temp_output_9_0_g263197 = ( temp_output_209_0_g263183 - temp_output_7_0_g263197 );
					float lerpResult23_g263183 = lerp( 1.0 , saturate( ( temp_output_9_0_g263197 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g263183 = lerpResult23_g263183;
					float temp_output_213_0_g263183 = (Local_ShaderSample199_g263183).w;
					float temp_output_7_0_g263200 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g263200 = ( temp_output_213_0_g263183 - temp_output_7_0_g263200 );
					half Local_Smoothness317_g263183 = ( saturate( ( temp_output_9_0_g263200 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g263183 = (float4(( (Local_ShaderSample199_g263183).x * _MainMetallicValue ) , Local_Occlusion313_g263183 , (Local_ShaderSample199_g263183).z , Local_Smoothness317_g263183));
					half4 Local_Masks109_g263183 = appendResult73_g263183;
					float4 In_Shader3_g263185 = Local_Masks109_g263183;
					float4 In_Feature3_g263185 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g263185 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g263185 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g263218 = Local_Albedo139_g263183;
					float dotResult20_g263218 = dot( temp_output_3_0_g263218 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g263183 = dotResult20_g263218;
					float temp_output_12_0_g263185 = Local_Grayscale110_g263183;
					float In_Grayscale3_g263185 = temp_output_12_0_g263185;
					float temp_output_3_0_g263219 = Local_Grayscale110_g263183;
					float clampResult27_g263219 = clamp( saturate( ( temp_output_3_0_g263219 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g263183 = clampResult27_g263219;
					float temp_output_16_0_g263185 = Local_Luminosity145_g263183;
					float In_Luminosity3_g263185 = temp_output_16_0_g263185;
					float In_MultiMask3_g263185 = Local_MultiMask78_g263183;
					float temp_output_187_0_g263183 = (Local_AlbedoSample185_g263183).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g263183 = ( temp_output_187_0_g263183 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g263183 = temp_output_187_0_g263183;
					#endif
					half Local_AlphaClip111_g263183 = staticSwitch236_g263183;
					float In_AlphaClip3_g263185 = Local_AlphaClip111_g263183;
					half Local_AlphaFade246_g263183 = (lerpResult62_g263183).a;
					float In_AlphaFade3_g263185 = Local_AlphaFade246_g263183;
					float3 temp_cast_25 = (1.0).xxx;
					float3 In_Translucency3_g263185 = temp_cast_25;
					float In_Transmission3_g263185 = 1.0;
					float In_Thickness3_g263185 = 0.0;
					float In_Diffusion3_g263185 = 0.0;
					float In_Depth3_g263185 = 0.0;
					BuildVisualData( Data3_g263185 , In_Dummy3_g263185 , In_Albedo3_g263185 , In_AlbedoBase3_g263185 , In_NormalTS3_g263185 , In_NormalWS3_g263185 , In_Shader3_g263185 , In_Feature3_g263185 , In_Season3_g263185 , In_Emissive3_g263185 , In_Grayscale3_g263185 , In_Luminosity3_g263185 , In_MultiMask3_g263185 , In_AlphaClip3_g263185 , In_AlphaFade3_g263185 , In_Translucency3_g263185 , In_Transmission3_g263185 , In_Thickness3_g263185 , In_Diffusion3_g263185 , In_Depth3_g263185 );
					TVEVisualData Data4_g263228 =(TVEVisualData)Data3_g263185;
					float Out_Dummy4_g263228 = 0.0;
					float3 Out_Albedo4_g263228 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g263228 = float3( 0,0,0 );
					float2 Out_NormalTS4_g263228 = float2( 0,0 );
					float3 Out_NormalWS4_g263228 = float3( 0,0,0 );
					float4 Out_Shader4_g263228 = float4( 0,0,0,0 );
					float4 Out_Feature4_g263228 = float4( 0,0,0,0 );
					float4 Out_Season4_g263228 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g263228 = float4( 0,0,0,0 );
					float Out_MultiMask4_g263228 = 0.0;
					float Out_Grayscale4_g263228 = 0.0;
					float Out_Luminosity4_g263228 = 0.0;
					float Out_AlphaClip4_g263228 = 0.0;
					float Out_AlphaFade4_g263228 = 0.0;
					float3 Out_Translucency4_g263228 = float3( 0,0,0 );
					float Out_Transmission4_g263228 = 0.0;
					float Out_Thickness4_g263228 = 0.0;
					float Out_Diffusion4_g263228 = 0.0;
					float Out_Depth4_g263228 = 0.0;
					BreakVisualData( Data4_g263228 , Out_Dummy4_g263228 , Out_Albedo4_g263228 , Out_AlbedoBase4_g263228 , Out_NormalTS4_g263228 , Out_NormalWS4_g263228 , Out_Shader4_g263228 , Out_Feature4_g263228 , Out_Season4_g263228 , Out_Emissive4_g263228 , Out_MultiMask4_g263228 , Out_Grayscale4_g263228 , Out_Luminosity4_g263228 , Out_AlphaClip4_g263228 , Out_AlphaFade4_g263228 , Out_Translucency4_g263228 , Out_Transmission4_g263228 , Out_Thickness4_g263228 , Out_Diffusion4_g263228 , Out_Depth4_g263228 );
					float Alpha109_g263223 = Out_AlphaClip4_g263228;
					float lerpResult91_g263223 = lerp( 1.0 , Alpha109_g263223 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g263223 = lerp( 1.0 , lerpResult91_g263223 , Filter152_g263223);
					clip( lerpResult154_g263223 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = temp_cast_1;
					half Metallic = 0;
					half Smoothness = temp_output_2720_114;
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

					o.Emission = ( lerpResult72_g263223 * lerpResult84_g263223 );
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
				#define ASE_NEEDS_TEXTURE_COORDINATES1
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES1
				#define ASE_NEEDS_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_NORMAL
				#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
				#define ASE_NEEDS_WORLD_POSITION
				#define ASE_NEEDS_FRAG_WORLD_POSITION
				#define ASE_NEEDS_FRAG_NORMAL
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES2
				#define ASE_NEEDS_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_TANGENT
				#define ASE_NEEDS_FRAG_WORLD_BITANGENT
				#define ASE_NEEDS_FRAG_COLOR
				#pragma shader_feature_local_vertex TVE_COORD_ZUP
				#pragma shader_feature_local_vertex TVE_PIVOT_SINGLE TVE_PIVOT_BAKED TVE_PIVOT_PROC
				#pragma shader_feature_local_vertex TVE_PERSPECTIVE
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_vertex TVE_ROTATION
				#pragma shader_feature_local_vertex TVE_SIZEFADE
				#pragma shader_feature_local_vertex TVE_SIZEFADE_VERTX
				#pragma shader_feature_local_vertex TVE_MOTION
				#pragma shader_feature_local_vertex TVE_MOTION_FLOW
				#pragma shader_feature_local TVE_LEGACY
				#pragma shader_feature_local_vertex TVE_FLATTEN
				#pragma shader_feature_local_vertex TVE_RESHADE
				#pragma shader_feature_local_vertex TVE_TRANSFER
				#pragma shader_feature_local_fragment TVE_MAIN_SAMPLE_MAIN_UV TVE_MAIN_SAMPLE_EXTRA_UV TVE_MAIN_SAMPLE_PLANAR_2D TVE_MAIN_SAMPLE_PLANAR_3D TVE_MAIN_SAMPLE_STOCHASTIC_2D TVE_MAIN_SAMPLE_STOCHASTIC_3D
				#pragma shader_feature_local_fragment TVE_FILTER_DEFAULT TVE_FILTER_POINT TVE_FILTER_LOW TVE_FILTER_MEDIUM TVE_FILTER_HIGH
				#pragma shader_feature_local_fragment TVE_CLIPPING
				#if defined (TVE_CONFORM_ROTATION) //Conform Rotation
					#define TVE_ROTATION_BEND //Conform Rotation
				#endif //Conform Rotation
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
					float3 ase_normal : NORMAL;
					float4 ase_texcoord7 : TEXCOORD7;
					float4 ase_texcoord8 : TEXCOORD8;
					float4 ase_texcoord9 : TEXCOORD9;
					float4 ase_texcoord10 : TEXCOORD10;
					float4 ase_color : COLOR;
					float4 ase_texcoord11 : TEXCOORD11;
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
				uniform half _PerspectiveCategory;
				uniform half _PerspectiveEnd;
				uniform half _PerspectivePhaseValue;
				uniform half _PerspectiveIntensityValue;
				uniform half _PerspectiveAngleValue;
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
				uniform half _RotationCategory;
				uniform half _RotationEnd;
				uniform half _RotationInfo;
				uniform half _RotationIntensityValue;
				uniform half _SizeFadeCategory;
				uniform half _SizeFadeEnd;
				uniform half4 TVE_SizeFadeParams;
				uniform float _SizeFadeDistMaxValue;
				uniform float _SizeFadeDistMinValue;
				uniform half _SizeFadeScaleValue;
				uniform half _SizeFadeVertxMode;
				uniform half _SizeFadeVertxValue;
				uniform half _SizeFadeScaleMode;
				uniform half _SizeFadeIntensityValue;
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
				uniform half _FlattenCategory;
				uniform half _FlattenEnd;
				uniform half _FlattenBakeMode;
				uniform half _FlattenUpwardsValue;
				uniform half3 _FlattenSphereOffsetValue;
				uniform half _FlattenSphereValue;
				uniform half _FlattenMeshMode;
				uniform half4 _FlattenMeshRemap;
				uniform half _FlattenMeshValue;
				uniform half _FlattenIntensityValue;
				uniform half _ReshadeCategory;
				uniform half _ReshadeEnd;
				uniform half _ReshadeInfo;
				uniform half _ReshadeIntensityValue;
				uniform half _TransferCategory;
				uniform half _TransferEnd;
				uniform half _TransferInfo;
				uniform half _TransferSpace;
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

					TVEVertexData Data16_g262854 =(TVEVertexData)0;
					float In_Dummy16_g262854 = 0.0;
					TVEVertexData Data16_g262849 =(TVEVertexData)0;
					float In_Dummy16_g262849 = 0.0;
					float localIfModelDataByShader26_g263144 = ( 0.0 );
					TVEModelData Data26_g263144 = (TVEModelData)0;
					TVEModelData Data16_g263050 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g263032 = _ObjectCoordMode;
					#else
					float staticSwitch343_g263032 = _ObjectCoordMode;
					#endif
					half Dummy207_g263032 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g263032 );
					float temp_output_14_0_g263050 = Dummy207_g263032;
					float In_Dummy16_g263050 = temp_output_14_0_g263050;
					float3 PositionOS131_g263032 = v.vertex.xyz;
					float3 temp_output_4_0_g263050 = PositionOS131_g263032;
					float3 In_PositionOS16_g263050 = temp_output_4_0_g263050;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g263032 = ase_positionWS;
					float3 vertexToFrag73_g263032 = temp_output_104_7_g263032;
					float3 PositionWS122_g263032 = vertexToFrag73_g263032;
					float3 In_PositionWS16_g263050 = PositionWS122_g263032;
					float4x4 break19_g263035 = unity_ObjectToWorld;
					float3 appendResult20_g263035 = (float3(break19_g263035[ 0 ][ 3 ] , break19_g263035[ 1 ][ 3 ] , break19_g263035[ 2 ][ 3 ]));
					float3 temp_output_340_7_g263032 = appendResult20_g263035;
					float4x4 break19_g263037 = unity_ObjectToWorld;
					float3 appendResult20_g263037 = (float3(break19_g263037[ 0 ][ 3 ] , break19_g263037[ 1 ][ 3 ] , break19_g263037[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g263033 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g263032 = PositionOS131_g263032;
					float3 appendResult234_g263032 = (float3(break233_g263032.x , 0.0 , break233_g263032.z));
					float3 break413_g263032 = PositionOS131_g263032;
					float3 appendResult414_g263032 = (float3(break413_g263032.x , break413_g263032.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g263039 = appendResult414_g263032;
					#else
					float3 staticSwitch65_g263039 = appendResult234_g263032;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g263032 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g263032 = appendResult60_g263033;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g263032 = staticSwitch65_g263039;
					#else
					float3 staticSwitch229_g263032 = _Vector0;
					#endif
					float3 PivotOS149_g263032 = staticSwitch229_g263032;
					float3 temp_output_122_0_g263037 = PivotOS149_g263032;
					float3 PivotsOnlyWS105_g263037 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g263037 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g263032 = ( appendResult20_g263037 + PivotsOnlyWS105_g263037 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g263032 = temp_output_340_7_g263032;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g263032 = temp_output_341_7_g263032;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g263032 = temp_output_341_7_g263032;
					#else
					float3 staticSwitch236_g263032 = temp_output_340_7_g263032;
					#endif
					float3 vertexToFrag76_g263032 = staticSwitch236_g263032;
					float3 PivotWS121_g263032 = vertexToFrag76_g263032;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g263032 = ( PositionWS122_g263032 - PivotWS121_g263032 );
					#else
					float3 staticSwitch204_g263032 = PositionWS122_g263032;
					#endif
					float3 PositionWO132_g263032 = ( staticSwitch204_g263032 - TVE_WorldOrigin );
					float3 In_PositionWO16_g263050 = PositionWO132_g263032;
					float3 In_PivotOS16_g263050 = PivotOS149_g263032;
					float3 In_PivotWS16_g263050 = PivotWS121_g263032;
					float3 PivotWO133_g263032 = ( PivotWS121_g263032 - TVE_WorldOrigin );
					float3 In_PivotWO16_g263050 = PivotWO133_g263032;
					half3 NormalOS134_g263032 = v.normal;
					float3 temp_output_21_0_g263050 = NormalOS134_g263032;
					float3 In_NormalOS16_g263050 = temp_output_21_0_g263050;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g263032 = normalizedWorldNormal;
					float3 In_NormalWS16_g263050 = NormalWS95_g263032;
					half4 TangentlOS153_g263032 = v.tangent;
					float4 temp_output_6_0_g263050 = TangentlOS153_g263032;
					float4 In_TangentOS16_g263050 = temp_output_6_0_g263050;
					float3 normalizeResult296_g263032 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g263032 ) );
					half3 ViewDirWS169_g263032 = normalizeResult296_g263032;
					float3 In_ViewDirWS16_g263050 = ViewDirWS169_g263032;
					float4 appendResult397_g263032 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g263032 = appendResult397_g263032;
					float4 In_CoordsData16_g263050 = CoordsData398_g263032;
					half4 VertexMasks171_g263032 = v.ase_color;
					float4 In_VertexData16_g263050 = VertexMasks171_g263032;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g263044 = (PositionOS131_g263032).z;
					#else
					float staticSwitch65_g263044 = (PositionOS131_g263032).y;
					#endif
					half Object_HeightValue267_g263032 = _ObjectHeightValue;
					half Bounds_HeightMask274_g263032 = saturate( ( staticSwitch65_g263044 / Object_HeightValue267_g263032 ) );
					half3 Position387_g263032 = PositionOS131_g263032;
					half Height387_g263032 = Object_HeightValue267_g263032;
					half Object_RadiusValue268_g263032 = _ObjectRadiusValue;
					half Radius387_g263032 = Object_RadiusValue268_g263032;
					half localCapsuleMaskYUp387_g263032 = CapsuleMaskYUp( Position387_g263032 , Height387_g263032 , Radius387_g263032 );
					half3 Position408_g263032 = PositionOS131_g263032;
					half Height408_g263032 = Object_HeightValue267_g263032;
					half Radius408_g263032 = Object_RadiusValue268_g263032;
					half localCapsuleMaskZUp408_g263032 = CapsuleMaskZUp( Position408_g263032 , Height408_g263032 , Radius408_g263032 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g263049 = saturate( localCapsuleMaskZUp408_g263032 );
					#else
					float staticSwitch65_g263049 = saturate( localCapsuleMaskYUp387_g263032 );
					#endif
					half Bounds_SphereMask282_g263032 = staticSwitch65_g263049;
					float4 appendResult253_g263032 = (float4(Bounds_HeightMask274_g263032 , Bounds_SphereMask282_g263032 , 1.0 , 1.0));
					half4 MasksData254_g263032 = appendResult253_g263032;
					float4 In_MasksData16_g263050 = MasksData254_g263032;
					float temp_output_17_0_g263043 = _ObjectPhaseMode;
					float Option70_g263043 = temp_output_17_0_g263043;
					float4 temp_output_3_0_g263043 = v.ase_color;
					float4 Channel70_g263043 = temp_output_3_0_g263043;
					float localSwitchChannel470_g263043 = SwitchChannel4( Option70_g263043 , Channel70_g263043 );
					half Phase_Value372_g263032 = localSwitchChannel470_g263043;
					float3 break319_g263032 = PivotWO133_g263032;
					half Pivot_Position322_g263032 = ( break319_g263032.x + break319_g263032.z );
					half Phase_Position357_g263032 = ( Phase_Value372_g263032 + Pivot_Position322_g263032 );
					float temp_output_248_0_g263032 = frac( Phase_Position357_g263032 );
					float4 appendResult177_g263032 = (float4((frac( ( Phase_Position357_g263032 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g263032));
					half4 Phase_Data176_g263032 = appendResult177_g263032;
					float4 In_PhaseData16_g263050 = Phase_Data176_g263032;
					BuildModelVertData( Data16_g263050 , In_Dummy16_g263050 , In_PositionOS16_g263050 , In_PositionWS16_g263050 , In_PositionWO16_g263050 , In_PivotOS16_g263050 , In_PivotWS16_g263050 , In_PivotWO16_g263050 , In_NormalOS16_g263050 , In_NormalWS16_g263050 , In_TangentOS16_g263050 , In_ViewDirWS16_g263050 , In_CoordsData16_g263050 , In_VertexData16_g263050 , In_MasksData16_g263050 , In_PhaseData16_g263050 );
					TVEModelData DataDefault26_g263144 = Data16_g263050;
					TVEModelData DataGeneral26_g263144 = Data16_g263050;
					TVEModelData DataBlanket26_g263144 = Data16_g263050;
					TVEModelData DataImpostor26_g263144 = Data16_g263050;
					TVEModelData Data16_g263030 =(TVEModelData)0;
					half Dummy207_g263012 = 0.0;
					float temp_output_14_0_g263030 = Dummy207_g263012;
					float In_Dummy16_g263030 = temp_output_14_0_g263030;
					float3 PositionOS131_g263012 = v.vertex.xyz;
					float3 temp_output_4_0_g263030 = PositionOS131_g263012;
					float3 In_PositionOS16_g263030 = temp_output_4_0_g263030;
					float3 temp_output_104_7_g263012 = ase_positionWS;
					float3 PositionWS122_g263012 = temp_output_104_7_g263012;
					float3 In_PositionWS16_g263030 = PositionWS122_g263012;
					float4x4 break19_g263015 = unity_ObjectToWorld;
					float3 appendResult20_g263015 = (float3(break19_g263015[ 0 ][ 3 ] , break19_g263015[ 1 ][ 3 ] , break19_g263015[ 2 ][ 3 ]));
					float3 temp_output_340_7_g263012 = appendResult20_g263015;
					float3 PivotWS121_g263012 = temp_output_340_7_g263012;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g263012 = ( PositionWS122_g263012 - PivotWS121_g263012 );
					#else
					float3 staticSwitch204_g263012 = PositionWS122_g263012;
					#endif
					float3 PositionWO132_g263012 = ( staticSwitch204_g263012 - TVE_WorldOrigin );
					float3 In_PositionWO16_g263030 = PositionWO132_g263012;
					float3 PivotOS149_g263012 = _Vector0;
					float3 In_PivotOS16_g263030 = PivotOS149_g263012;
					float3 In_PivotWS16_g263030 = PivotWS121_g263012;
					float3 PivotWO133_g263012 = ( PivotWS121_g263012 - TVE_WorldOrigin );
					float3 In_PivotWO16_g263030 = PivotWO133_g263012;
					half3 NormalOS134_g263012 = v.normal;
					float3 temp_output_21_0_g263030 = NormalOS134_g263012;
					float3 In_NormalOS16_g263030 = temp_output_21_0_g263030;
					half3 NormalWS95_g263012 = normalizedWorldNormal;
					float3 In_NormalWS16_g263030 = NormalWS95_g263012;
					float4 appendResult462_g263012 = (float4(cross( v.normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g263012 = appendResult462_g263012;
					float4 temp_output_6_0_g263030 = TangentlOS153_g263012;
					float4 In_TangentOS16_g263030 = temp_output_6_0_g263030;
					float3 normalizeResult296_g263012 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g263012 ) );
					half3 ViewDirWS169_g263012 = normalizeResult296_g263012;
					float3 In_ViewDirWS16_g263030 = ViewDirWS169_g263012;
					float4 appendResult397_g263012 = (float4(v.texcoord.xyzw.xy , v.texcoord2.xyzw.xy));
					float4 CoordsData398_g263012 = appendResult397_g263012;
					float4 In_CoordsData16_g263030 = CoordsData398_g263012;
					half4 VertexMasks171_g263012 = float4( 0,0,0,0 );
					float4 In_VertexData16_g263030 = VertexMasks171_g263012;
					half4 MasksData254_g263012 = float4( 0,0,0,0 );
					float4 In_MasksData16_g263030 = MasksData254_g263012;
					half4 Phase_Data176_g263012 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g263030 = Phase_Data176_g263012;
					BuildModelVertData( Data16_g263030 , In_Dummy16_g263030 , In_PositionOS16_g263030 , In_PositionWS16_g263030 , In_PositionWO16_g263030 , In_PivotOS16_g263030 , In_PivotWS16_g263030 , In_PivotWO16_g263030 , In_NormalOS16_g263030 , In_NormalWS16_g263030 , In_TangentOS16_g263030 , In_ViewDirWS16_g263030 , In_CoordsData16_g263030 , In_VertexData16_g263030 , In_MasksData16_g263030 , In_PhaseData16_g263030 );
					TVEModelData DataTerrain26_g263144 = Data16_g263030;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g263144 = IsShaderType2637;
					{
					if (Type26_g263144 == 0 )
					{
					Data26_g263144 = DataDefault26_g263144;
					}
					else if (Type26_g263144 == 1 )
					{
					Data26_g263144 = DataGeneral26_g263144;
					}
					else if (Type26_g263144 == 2 )
					{
					Data26_g263144 = DataBlanket26_g263144;
					}
					else if (Type26_g263144 == 3 )
					{
					Data26_g263144 = DataImpostor26_g263144;
					}
					else if (Type26_g263144 == 4 )
					{
					Data26_g263144 = DataTerrain26_g263144;
					}
					}
					TVEModelData Data15_g262850 =(TVEModelData)Data26_g263144;
					float Out_Dummy15_g262850 = 0.0;
					float3 Out_PositionOS15_g262850 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262850 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262850 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262850 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262850 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262850 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262850 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262850 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262850 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262850 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262850 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262850 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262850 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262850 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262850 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262850 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262850 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262850 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262850 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262850 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262850 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262850 , Out_Dummy15_g262850 , Out_PositionOS15_g262850 , Out_PositionWS15_g262850 , Out_PositionWO15_g262850 , Out_PositionRawOS15_g262850 , Out_PivotOS15_g262850 , Out_PivotWS15_g262850 , Out_PivotWO15_g262850 , Out_NormalOS15_g262850 , Out_NormalWS15_g262850 , Out_NormalRawOS15_g262850 , Out_TangentOS15_g262850 , Out_TangentWS15_g262850 , Out_BitangentWS15_g262850 , Out_ViewDirWS15_g262850 , Out_CoordsData15_g262850 , Out_VertexData15_g262850 , Out_MasksData15_g262850 , Out_PhaseData15_g262850 , Out_TransformData15_g262850 , Out_RotationData15_g262850 , Out_Interpolator15_g262850 );
					float3 In_PositionOS16_g262849 = Out_PositionOS15_g262850;
					float3 In_NormalOS16_g262849 = Out_NormalOS15_g262850;
					float4 In_TangentOS16_g262849 = Out_TangentOS15_g262850;
					float4 In_TransformData16_g262849 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g262849 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g262849 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g262849 , In_Dummy16_g262849 , In_PositionOS16_g262849 , In_NormalOS16_g262849 , In_TangentOS16_g262849 , In_TransformData16_g262849 , In_RotationData16_g262849 , In_Interpolator16_g262849 );
					TVEVertexData Data15_g262852 =(TVEVertexData)Data16_g262849;
					float Out_Dummy15_g262852 = 0.0;
					float3 Out_PositionOS15_g262852 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262852 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262852 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262852 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262852 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262852 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262852 , Out_Dummy15_g262852 , Out_PositionOS15_g262852 , Out_NormalOS15_g262852 , Out_TangentOS15_g262852 , Out_TransformData15_g262852 , Out_RotationData15_g262852 , Out_Interpolator15_g262852 );
					TVEModelData Data15_g262853 =(TVEModelData)Data15_g262850;
					float Out_Dummy15_g262853 = 0.0;
					float3 Out_PositionOS15_g262853 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262853 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262853 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262853 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262853 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262853 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262853 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262853 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262853 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262853 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262853 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262853 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262853 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262853 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262853 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262853 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262853 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262853 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262853 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262853 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262853 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262853 , Out_Dummy15_g262853 , Out_PositionOS15_g262853 , Out_PositionWS15_g262853 , Out_PositionWO15_g262853 , Out_PositionRawOS15_g262853 , Out_PivotOS15_g262853 , Out_PivotWS15_g262853 , Out_PivotWO15_g262853 , Out_NormalOS15_g262853 , Out_NormalWS15_g262853 , Out_NormalRawOS15_g262853 , Out_TangentOS15_g262853 , Out_TangentWS15_g262853 , Out_BitangentWS15_g262853 , Out_ViewDirWS15_g262853 , Out_CoordsData15_g262853 , Out_VertexData15_g262853 , Out_MasksData15_g262853 , Out_PhaseData15_g262853 , Out_TransformData15_g262853 , Out_RotationData15_g262853 , Out_Interpolator15_g262853 );
					float3 In_PositionOS16_g262854 = ( Out_PositionOS15_g262852 - Out_PivotOS15_g262853 );
					float3 In_NormalOS16_g262854 = Out_NormalOS15_g262853;
					float4 In_TangentOS16_g262854 = Out_TangentOS15_g262853;
					float4 In_TransformData16_g262854 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g262854 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g262854 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g262854 , In_Dummy16_g262854 , In_PositionOS16_g262854 , In_NormalOS16_g262854 , In_TangentOS16_g262854 , In_TransformData16_g262854 , In_RotationData16_g262854 , In_Interpolator16_g262854 );
					TVEVertexData Data15_g262858 =(TVEVertexData)Data16_g262854;
					float Out_Dummy15_g262858 = 0.0;
					float3 Out_PositionOS15_g262858 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262858 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262858 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262858 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262858 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262858 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262858 , Out_Dummy15_g262858 , Out_PositionOS15_g262858 , Out_NormalOS15_g262858 , Out_TangentOS15_g262858 , Out_TransformData15_g262858 , Out_RotationData15_g262858 , Out_Interpolator15_g262858 );
					TVEVertexData Data16_g262859 =(TVEVertexData)Data15_g262858;
					half Dummy181_g262855 = ( _PerspectiveCategory + _PerspectiveEnd );
					float In_Dummy16_g262859 = Dummy181_g262855;
					half3 Vertex_PositionOS147_g262855 = Out_PositionOS15_g262858;
					TVEModelData Data15_g262860 =(TVEModelData)Data15_g262853;
					float Out_Dummy15_g262860 = 0.0;
					float3 Out_PositionOS15_g262860 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262860 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262860 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262860 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262860 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262860 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262860 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262860 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262860 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262860 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262860 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262860 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262860 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262860 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262860 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262860 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262860 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262860 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262860 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262860 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262860 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262860 , Out_Dummy15_g262860 , Out_PositionOS15_g262860 , Out_PositionWS15_g262860 , Out_PositionWO15_g262860 , Out_PositionRawOS15_g262860 , Out_PivotOS15_g262860 , Out_PivotWS15_g262860 , Out_PivotWO15_g262860 , Out_NormalOS15_g262860 , Out_NormalWS15_g262860 , Out_NormalRawOS15_g262860 , Out_TangentOS15_g262860 , Out_TangentWS15_g262860 , Out_BitangentWS15_g262860 , Out_ViewDirWS15_g262860 , Out_CoordsData15_g262860 , Out_VertexData15_g262860 , Out_MasksData15_g262860 , Out_PhaseData15_g262860 , Out_TransformData15_g262860 , Out_RotationData15_g262860 , Out_Interpolator15_g262860 );
					half3 Model_ViewDirWS237_g262855 = Out_ViewDirWS15_g262860;
					float4x4 break117_g262856 = unity_CameraToWorld;
					float3 appendResult118_g262856 = (float3(break117_g262856[ 0 ][ 2 ] , break117_g262856[ 1 ][ 2 ] , break117_g262856[ 2 ][ 2 ]));
					float3 lerpResult209_g262855 = lerp( Model_ViewDirWS237_g262855 , -appendResult118_g262856 , unity_OrthoParams.w);
					float3 break201_g262855 = cross( lerpResult209_g262855 , half3( 0, 1, 0 ) );
					float3 appendResult196_g262855 = (float3(-break201_g262855.z , 0.0 , break201_g262855.x));
					half4 Model_PhaseData218_g262855 = Out_PhaseData15_g262860;
					float2 break226_g262855 = ( (Model_PhaseData218_g262855).xy * 5.0 * _PerspectivePhaseValue );
					float3 appendResult224_g262855 = (float3(break226_g262855.x , 0.0 , break226_g262855.y));
					float dotResult189_g262855 = dot( Model_ViewDirWS237_g262855 , float3( 0, 1, 0 ) );
					float saferPower192_g262855 = abs( dotResult189_g262855 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g262857 = (Vertex_PositionOS147_g262855).z;
					#else
					float staticSwitch65_g262857 = (Vertex_PositionOS147_g262855).y;
					#endif
					float3 temp_output_206_0_g262855 = ( Vertex_PositionOS147_g262855 + ( ( mul( unity_WorldToObject, float4( appendResult196_g262855 , 0.0 ) ).xyz + appendResult224_g262855 ) * _PerspectiveIntensityValue * pow( saferPower192_g262855 , _PerspectiveAngleValue ) * saturate( staticSwitch65_g262857 ) ) );
					#ifdef TVE_PERSPECTIVE
					float3 staticSwitch211_g262855 = temp_output_206_0_g262855;
					#else
					float3 staticSwitch211_g262855 = Vertex_PositionOS147_g262855;
					#endif
					float3 Final_Position178_g262855 = staticSwitch211_g262855;
					float3 In_PositionOS16_g262859 = Final_Position178_g262855;
					float3 In_NormalOS16_g262859 = Out_NormalOS15_g262858;
					float4 In_TangentOS16_g262859 = Out_TangentOS15_g262858;
					float4 In_TransformData16_g262859 = Out_TransformData15_g262858;
					float4 In_RotationData16_g262859 = Out_RotationData15_g262858;
					float4 In_Interpolator16_g262859 = Out_Interpolator15_g262858;
					BuildVertexData( Data16_g262859 , In_Dummy16_g262859 , In_PositionOS16_g262859 , In_NormalOS16_g262859 , In_TangentOS16_g262859 , In_TransformData16_g262859 , In_RotationData16_g262859 , In_Interpolator16_g262859 );
					TVEVertexData Data15_g262869 =(TVEVertexData)Data16_g262859;
					float Out_Dummy15_g262869 = 0.0;
					float3 Out_PositionOS15_g262869 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262869 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262869 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262869 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262869 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262869 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262869 , Out_Dummy15_g262869 , Out_PositionOS15_g262869 , Out_NormalOS15_g262869 , Out_TangentOS15_g262869 , Out_TransformData15_g262869 , Out_RotationData15_g262869 , Out_Interpolator15_g262869 );
					TVEVertexData Data16_g262870 =(TVEVertexData)Data15_g262869;
					half Dummy317_g262861 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g262870 = Dummy317_g262861;
					float3 In_PositionOS16_g262870 = Out_PositionOS15_g262869;
					float3 In_NormalOS16_g262870 = Out_NormalOS15_g262869;
					float4 In_TangentOS16_g262870 = Out_TangentOS15_g262869;
					half4 Model_TransformData356_g262861 = Out_TransformData15_g262869;
					float localBuildGlobalData204_g262442 = ( 0.0 );
					TVEGlobalData Data204_g262442 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g262442 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g262442 = Dummy211_g262442;
					float4 temp_output_203_0_g262461 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g262420 = ( 0.0 );
					TVEModelData Data26_g262420 = (TVEModelData)0;
					TVEModelData DataDefault26_g262420 = Data16_g263030;
					TVEModelData Data16_g263040 =(TVEModelData)0;
					float In_Dummy16_g263040 = 0.0;
					float3 In_PositionWS16_g263040 = PositionWS122_g263032;
					float3 In_PositionWO16_g263040 = PositionWO132_g263032;
					float3 In_PivotWS16_g263040 = PivotWS121_g263032;
					float3 In_PivotWO16_g263040 = PivotWO133_g263032;
					float3 In_NormalWS16_g263040 = NormalWS95_g263032;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g263032 = ase_tangentWS;
					float3 In_TangentWS16_g263040 = TangentWS136_g263032;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g263032 = ase_bitangentWS;
					float3 In_BitangentWS16_g263040 = BiangentWS421_g263032;
					half3 NormalWS427_g263032 = NormalWS95_g263032;
					half3 localComputeTriplanarMasks427_g263032 = ComputeTriplanarMasks( NormalWS427_g263032 );
					half3 TriplanarWeights429_g263032 = localComputeTriplanarMasks427_g263032;
					float3 In_TriplanarWeights16_g263040 = TriplanarWeights429_g263032;
					float3 In_ViewDirWS16_g263040 = ViewDirWS169_g263032;
					float4 In_CoordsData16_g263040 = CoordsData398_g263032;
					float4 In_VertexData16_g263040 = VertexMasks171_g263032;
					float4 In_Interpolator16_g263040 = Phase_Data176_g263032;
					BuildModelFragData( Data16_g263040 , In_Dummy16_g263040 , In_PositionWS16_g263040 , In_PositionWO16_g263040 , In_PivotWS16_g263040 , In_PivotWO16_g263040 , In_NormalWS16_g263040 , In_TangentWS16_g263040 , In_BitangentWS16_g263040 , In_TriplanarWeights16_g263040 , In_ViewDirWS16_g263040 , In_CoordsData16_g263040 , In_VertexData16_g263040 , In_Interpolator16_g263040 );
					TVEModelData DataGeneral26_g262420 = Data16_g263040;
					TVEModelData DataBlanket26_g262420 = Data16_g263040;
					TVEModelData DataImpostor26_g262420 = Data16_g263040;
					TVEModelData Data16_g263020 =(TVEModelData)0;
					float In_Dummy16_g263020 = 0.0;
					float3 In_PositionWS16_g263020 = PositionWS122_g263012;
					float3 In_PositionWO16_g263020 = PositionWO132_g263012;
					float3 In_PivotWS16_g263020 = PivotWS121_g263012;
					float3 In_PivotWO16_g263020 = PivotWO133_g263012;
					float3 In_NormalWS16_g263020 = NormalWS95_g263012;
					half3 TangentWS136_g263012 = ase_tangentWS;
					float3 In_TangentWS16_g263020 = TangentWS136_g263012;
					half3 BiangentWS421_g263012 = ase_bitangentWS;
					float3 In_BitangentWS16_g263020 = BiangentWS421_g263012;
					half3 NormalWS427_g263012 = NormalWS95_g263012;
					half3 localComputeTriplanarMasks427_g263012 = ComputeTriplanarMasks( NormalWS427_g263012 );
					half3 TriplanarWeights429_g263012 = localComputeTriplanarMasks427_g263012;
					float3 In_TriplanarWeights16_g263020 = TriplanarWeights429_g263012;
					float3 In_ViewDirWS16_g263020 = ViewDirWS169_g263012;
					float4 In_CoordsData16_g263020 = CoordsData398_g263012;
					float4 In_VertexData16_g263020 = VertexMasks171_g263012;
					float4 In_Interpolator16_g263020 = Phase_Data176_g263012;
					BuildModelFragData( Data16_g263020 , In_Dummy16_g263020 , In_PositionWS16_g263020 , In_PositionWO16_g263020 , In_PivotWS16_g263020 , In_PivotWO16_g263020 , In_NormalWS16_g263020 , In_TangentWS16_g263020 , In_BitangentWS16_g263020 , In_TriplanarWeights16_g263020 , In_ViewDirWS16_g263020 , In_CoordsData16_g263020 , In_VertexData16_g263020 , In_Interpolator16_g263020 );
					TVEModelData DataTerrain26_g262420 = Data16_g263020;
					float Type26_g262420 = IsShaderType2637;
					{
					if (Type26_g262420 == 0 )
					{
					Data26_g262420 = DataDefault26_g262420;
					}
					else if (Type26_g262420 == 1 )
					{
					Data26_g262420 = DataGeneral26_g262420;
					}
					else if (Type26_g262420 == 2 )
					{
					Data26_g262420 = DataBlanket26_g262420;
					}
					else if (Type26_g262420 == 3 )
					{
					Data26_g262420 = DataImpostor26_g262420;
					}
					else if (Type26_g262420 == 4 )
					{
					Data26_g262420 = DataTerrain26_g262420;
					}
					}
					TVEModelData Data15_g262532 =(TVEModelData)Data26_g262420;
					float Out_Dummy15_g262532 = 0.0;
					float3 Out_PositionWS15_g262532 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262532 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262532 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262532 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262532 = float3( 0,0,0 );
					float3 Out_TangentWS15_g262532 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262532 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g262532 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262532 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262532 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262532 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262532 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g262532 , Out_Dummy15_g262532 , Out_PositionWS15_g262532 , Out_PositionWO15_g262532 , Out_PivotWS15_g262532 , Out_PivotWO15_g262532 , Out_NormalWS15_g262532 , Out_TangentWS15_g262532 , Out_BitangentWS15_g262532 , Out_TriplanarWeights15_g262532 , Out_ViewDirWS15_g262532 , Out_CoordsData15_g262532 , Out_VertexData15_g262532 , Out_Interpolator15_g262532 );
					float3 Model_PositionWS497_g262442 = Out_PositionWS15_g262532;
					float2 Model_PositionWS_XZ143_g262442 = (Model_PositionWS497_g262442).xz;
					float3 Model_PivotWS498_g262442 = Out_PivotWS15_g262532;
					float2 Model_PivotWS_XZ145_g262442 = (Model_PivotWS498_g262442).xz;
					float2 lerpResult300_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g262461 = lerpResult300_g262442;
					float temp_output_82_0_g262459 = _GlobalCoatLayerValue;
					float temp_output_82_0_g262461 = temp_output_82_0_g262459;
					float4 tex2DArrayNode83_g262461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262461).zw + ( (temp_output_203_0_g262461).xy * temp_output_81_0_g262461 ) ),temp_output_82_0_g262461), 0.0 );
					float4 appendResult210_g262461 = (float4(tex2DArrayNode83_g262461.rgb , tex2DArrayNode83_g262461.a));
					float4 temp_output_204_0_g262461 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g262461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262461).zw + ( (temp_output_204_0_g262461).xy * temp_output_81_0_g262461 ) ),temp_output_82_0_g262461), 0.0 );
					float4 appendResult212_g262461 = (float4(tex2DArrayNode122_g262461.rgb , tex2DArrayNode122_g262461.a));
					float4 TVE_RenderNearPositionR628_g262442 = TVE_RenderNearPositionR;
					float temp_output_507_0_g262442 = saturate( ( distance( Model_PositionWS497_g262442 , (TVE_RenderNearPositionR628_g262442).xyz ) / (TVE_RenderNearPositionR628_g262442).w ) );
					float temp_output_7_0_g262531 = 1.0;
					float temp_output_9_0_g262531 = ( temp_output_507_0_g262442 - temp_output_7_0_g262531 );
					half TVE_RenderNearFadeValue635_g262442 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g262442 = saturate( ( temp_output_9_0_g262531 / ( ( TVE_RenderNearFadeValue635_g262442 - temp_output_7_0_g262531 ) + 0.0001 ) ) );
					float4 lerpResult131_g262461 = lerp( appendResult210_g262461 , appendResult212_g262461 , Global_TexBlend509_g262442);
					float4 temp_output_159_109_g262459 = lerpResult131_g262461;
					float4 lerpResult168_g262459 = lerp( TVE_CoatParams , temp_output_159_109_g262459 , TVE_CoatLayers[(int)temp_output_82_0_g262459]);
					float4 temp_output_589_109_g262442 = lerpResult168_g262459;
					half4 Coat_Texture302_g262442 = temp_output_589_109_g262442;
					float4 In_CoatTexture204_g262442 = Coat_Texture302_g262442;
					half4 Draw_Texture656_g262442 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g262442 = Draw_Texture656_g262442;
					float4 temp_output_203_0_g262486 = TVE_PaintBaseCoord;
					float2 lerpResult85_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g262486 = lerpResult85_g262442;
					float temp_output_82_0_g262483 = _GlobalPaintLayerValue;
					float temp_output_82_0_g262486 = temp_output_82_0_g262483;
					float4 tex2DArrayNode83_g262486 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262486).zw + ( (temp_output_203_0_g262486).xy * temp_output_81_0_g262486 ) ),temp_output_82_0_g262486), 0.0 );
					float4 appendResult210_g262486 = (float4(tex2DArrayNode83_g262486.rgb , tex2DArrayNode83_g262486.a));
					float4 temp_output_204_0_g262486 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g262486 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262486).zw + ( (temp_output_204_0_g262486).xy * temp_output_81_0_g262486 ) ),temp_output_82_0_g262486), 0.0 );
					float4 appendResult212_g262486 = (float4(tex2DArrayNode122_g262486.rgb , tex2DArrayNode122_g262486.a));
					float4 lerpResult131_g262486 = lerp( appendResult210_g262486 , appendResult212_g262486 , Global_TexBlend509_g262442);
					float4 temp_output_171_109_g262483 = lerpResult131_g262486;
					float4 lerpResult174_g262483 = lerp( TVE_PaintParams , temp_output_171_109_g262483 , TVE_PaintLayers[(int)temp_output_82_0_g262483]);
					float4 temp_output_595_109_g262442 = lerpResult174_g262483;
					half4 Paint_Texture71_g262442 = temp_output_595_109_g262442;
					float4 In_PaintTexture204_g262442 = Paint_Texture71_g262442;
					float4 temp_output_203_0_g262469 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g262469 = lerpResult104_g262442;
					float temp_output_132_0_g262467 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g262469 = temp_output_132_0_g262467;
					float4 tex2DArrayNode83_g262469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262469).zw + ( (temp_output_203_0_g262469).xy * temp_output_81_0_g262469 ) ),temp_output_82_0_g262469), 0.0 );
					float4 appendResult210_g262469 = (float4(tex2DArrayNode83_g262469.rgb , tex2DArrayNode83_g262469.a));
					float4 temp_output_204_0_g262469 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g262469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262469).zw + ( (temp_output_204_0_g262469).xy * temp_output_81_0_g262469 ) ),temp_output_82_0_g262469), 0.0 );
					float4 appendResult212_g262469 = (float4(tex2DArrayNode122_g262469.rgb , tex2DArrayNode122_g262469.a));
					float4 lerpResult131_g262469 = lerp( appendResult210_g262469 , appendResult212_g262469 , Global_TexBlend509_g262442);
					float4 temp_output_137_109_g262467 = lerpResult131_g262469;
					float4 lerpResult145_g262467 = lerp( TVE_AtmoParams , temp_output_137_109_g262467 , TVE_AtmoLayers[(int)temp_output_132_0_g262467]);
					float4 temp_output_590_110_g262442 = lerpResult145_g262467;
					half4 Atmo_Texture80_g262442 = temp_output_590_110_g262442;
					float4 In_AtmoTexture204_g262442 = Atmo_Texture80_g262442;
					float4 temp_output_203_0_g262537 = TVE_EffexBaseCoord;
					float2 lerpResult414_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g262537 = lerpResult414_g262442;
					float temp_output_132_0_g262535 = _GlobalEffexLayerValue;
					float temp_output_82_0_g262537 = temp_output_132_0_g262535;
					float4 tex2DArrayNode83_g262537 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262537).zw + ( (temp_output_203_0_g262537).xy * temp_output_81_0_g262537 ) ),temp_output_82_0_g262537), 0.0 );
					float4 appendResult210_g262537 = (float4(tex2DArrayNode83_g262537.rgb , tex2DArrayNode83_g262537.a));
					float4 temp_output_204_0_g262537 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g262537 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262537).zw + ( (temp_output_204_0_g262537).xy * temp_output_81_0_g262537 ) ),temp_output_82_0_g262537), 0.0 );
					float4 appendResult212_g262537 = (float4(tex2DArrayNode122_g262537.rgb , tex2DArrayNode122_g262537.a));
					float4 lerpResult131_g262537 = lerp( appendResult210_g262537 , appendResult212_g262537 , Global_TexBlend509_g262442);
					float4 temp_output_137_109_g262535 = lerpResult131_g262537;
					float4 lerpResult145_g262535 = lerp( TVE_EffexParams , temp_output_137_109_g262535 , TVE_EffexLayers[(int)temp_output_132_0_g262535]);
					float4 temp_output_731_110_g262442 = lerpResult145_g262535;
					half4 Effex_Texture420_g262442 = temp_output_731_110_g262442;
					float4 In_EffexTexture204_g262442 = Effex_Texture420_g262442;
					float4 temp_output_203_0_g262517 = TVE_GlowBaseCoord;
					float2 lerpResult247_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g262517 = lerpResult247_g262442;
					float temp_output_82_0_g262515 = _GlobalGlowLayerValue;
					float temp_output_82_0_g262517 = temp_output_82_0_g262515;
					float4 tex2DArrayNode83_g262517 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262517).zw + ( (temp_output_203_0_g262517).xy * temp_output_81_0_g262517 ) ),temp_output_82_0_g262517), 0.0 );
					float4 appendResult210_g262517 = (float4(tex2DArrayNode83_g262517.rgb , tex2DArrayNode83_g262517.a));
					float4 temp_output_204_0_g262517 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g262517 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262517).zw + ( (temp_output_204_0_g262517).xy * temp_output_81_0_g262517 ) ),temp_output_82_0_g262517), 0.0 );
					float4 appendResult212_g262517 = (float4(tex2DArrayNode122_g262517.rgb , tex2DArrayNode122_g262517.a));
					float4 lerpResult131_g262517 = lerp( appendResult210_g262517 , appendResult212_g262517 , Global_TexBlend509_g262442);
					float4 temp_output_159_109_g262515 = lerpResult131_g262517;
					float4 lerpResult167_g262515 = lerp( TVE_GlowParams , temp_output_159_109_g262515 , TVE_GlowLayers[(int)temp_output_82_0_g262515]);
					float4 temp_output_593_109_g262442 = lerpResult167_g262515;
					half4 Glow_Texture248_g262442 = temp_output_593_109_g262442;
					float4 In_GlowTexture204_g262442 = Glow_Texture248_g262442;
					float4 temp_output_203_0_g262453 = TVE_FormBaseCoord;
					float2 lerpResult168_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g262453 = lerpResult168_g262442;
					float temp_output_130_0_g262451 = _GlobalFormLayerValue;
					float temp_output_82_0_g262453 = temp_output_130_0_g262451;
					float4 tex2DArrayNode83_g262453 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262453).zw + ( (temp_output_203_0_g262453).xy * temp_output_81_0_g262453 ) ),temp_output_82_0_g262453), 0.0 );
					float4 appendResult210_g262453 = (float4(tex2DArrayNode83_g262453.rgb , tex2DArrayNode83_g262453.a));
					float4 temp_output_204_0_g262453 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g262453 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262453).zw + ( (temp_output_204_0_g262453).xy * temp_output_81_0_g262453 ) ),temp_output_82_0_g262453), 0.0 );
					float4 appendResult212_g262453 = (float4(tex2DArrayNode122_g262453.rgb , tex2DArrayNode122_g262453.a));
					float4 lerpResult131_g262453 = lerp( appendResult210_g262453 , appendResult212_g262453 , Global_TexBlend509_g262442);
					float4 temp_output_135_109_g262451 = lerpResult131_g262453;
					float4 lerpResult143_g262451 = lerp( TVE_FormParams , temp_output_135_109_g262451 , TVE_FormLayers[(int)temp_output_130_0_g262451]);
					float4 temp_output_592_0_g262442 = lerpResult143_g262451;
					float4 Form_Texture112_g262442 = temp_output_592_0_g262442;
					float4 In_FormTexture204_g262442 = Form_Texture112_g262442;
					float4 In_LandTexture204_g262442 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g262501 = TVE_VertxBaseCoord;
					float2 lerpResult681_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g262501 = lerpResult681_g262442;
					float temp_output_136_0_g262499 = _GlobalVertxLayerValue;
					float temp_output_82_0_g262501 = temp_output_136_0_g262499;
					float4 tex2DArrayNode83_g262501 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262501).zw + ( (temp_output_203_0_g262501).xy * temp_output_81_0_g262501 ) ),temp_output_82_0_g262501), 0.0 );
					float4 appendResult210_g262501 = (float4(tex2DArrayNode83_g262501.rgb , tex2DArrayNode83_g262501.a));
					float4 temp_output_204_0_g262501 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g262501 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262501).zw + ( (temp_output_204_0_g262501).xy * temp_output_81_0_g262501 ) ),temp_output_82_0_g262501), 0.0 );
					float4 appendResult212_g262501 = (float4(tex2DArrayNode122_g262501.rgb , tex2DArrayNode122_g262501.a));
					float4 lerpResult131_g262501 = lerp( appendResult210_g262501 , appendResult212_g262501 , Global_TexBlend509_g262442);
					float4 temp_output_141_109_g262499 = lerpResult131_g262501;
					float4 lerpResult149_g262499 = lerp( TVE_VertxParams , temp_output_141_109_g262499 , TVE_VertxLayers[(int)temp_output_136_0_g262499]);
					float4 temp_output_695_0_g262442 = lerpResult149_g262499;
					half4 Vertx_Texture693_g262442 = temp_output_695_0_g262442;
					float4 In_VertxTexture204_g262442 = Vertx_Texture693_g262442;
					float4 temp_output_203_0_g262477 = TVE_FlowBaseCoord;
					float2 lerpResult400_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g262477 = lerpResult400_g262442;
					float temp_output_136_0_g262475 = _GlobalFlowLayerValue;
					float temp_output_82_0_g262477 = temp_output_136_0_g262475;
					float4 tex2DArrayNode83_g262477 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262477).zw + ( (temp_output_203_0_g262477).xy * temp_output_81_0_g262477 ) ),temp_output_82_0_g262477), 0.0 );
					float4 appendResult210_g262477 = (float4(tex2DArrayNode83_g262477.rgb , tex2DArrayNode83_g262477.a));
					float4 temp_output_204_0_g262477 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g262477 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262477).zw + ( (temp_output_204_0_g262477).xy * temp_output_81_0_g262477 ) ),temp_output_82_0_g262477), 0.0 );
					float4 appendResult212_g262477 = (float4(tex2DArrayNode122_g262477.rgb , tex2DArrayNode122_g262477.a));
					float4 lerpResult131_g262477 = lerp( appendResult210_g262477 , appendResult212_g262477 , Global_TexBlend509_g262442);
					float4 temp_output_141_109_g262475 = lerpResult131_g262477;
					float4 lerpResult149_g262475 = lerp( TVE_FlowParams , temp_output_141_109_g262475 , TVE_FlowLayers[(int)temp_output_136_0_g262475]);
					float4 temp_output_594_0_g262442 = lerpResult149_g262475;
					half4 Flow_Texture405_g262442 = temp_output_594_0_g262442;
					float4 In_FlowTexture204_g262442 = Flow_Texture405_g262442;
					half4 User_Texture677_g262442 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g262442 = User_Texture677_g262442;
					BuildGlobalData( Data204_g262442 , In_Dummy204_g262442 , In_CoatTexture204_g262442 , In_DrawTexture204_g262442 , In_PaintTexture204_g262442 , In_AtmoTexture204_g262442 , In_EffexTexture204_g262442 , In_GlowTexture204_g262442 , In_FormTexture204_g262442 , In_LandTexture204_g262442 , In_VertxTexture204_g262442 , In_FlowTexture204_g262442 , In_UserTexture204_g262442 );
					TVEGlobalData Data15_g262871 =(TVEGlobalData)Data204_g262442;
					float Out_Dummy15_g262871 = 0.0;
					float4 Out_CoatTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g262871 = float4( 0,0,0,0 );
					BreakData( Data15_g262871 , Out_Dummy15_g262871 , Out_CoatTexture15_g262871 , Out_DrawTexture15_g262871 , Out_PaintTexture15_g262871 , Out_AtmoTexture15_g262871 , Out_EffexTexture15_g262871 , Out_GlowTexture15_g262871 , Out_FormTexture15_g262871 , Out_LandTexture15_g262871 , Out_VertxTexture15_g262871 , Out_FlowTexture15_g262871 , Out_UserTexture15_g262871 );
					float4 Global_FormTexture351_g262861 = Out_FormTexture15_g262871;
					TVEModelData Data15_g262868 =(TVEModelData)Data15_g262860;
					float Out_Dummy15_g262868 = 0.0;
					float3 Out_PositionOS15_g262868 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262868 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262868 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262868 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262868 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262868 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262868 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262868 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262868 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262868 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262868 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262868 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262868 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262868 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262868 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262868 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262868 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262868 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262868 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262868 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262868 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262868 , Out_Dummy15_g262868 , Out_PositionOS15_g262868 , Out_PositionWS15_g262868 , Out_PositionWO15_g262868 , Out_PositionRawOS15_g262868 , Out_PivotOS15_g262868 , Out_PivotWS15_g262868 , Out_PivotWO15_g262868 , Out_NormalOS15_g262868 , Out_NormalWS15_g262868 , Out_NormalRawOS15_g262868 , Out_TangentOS15_g262868 , Out_TangentWS15_g262868 , Out_BitangentWS15_g262868 , Out_ViewDirWS15_g262868 , Out_CoordsData15_g262868 , Out_VertexData15_g262868 , Out_MasksData15_g262868 , Out_PhaseData15_g262868 , Out_TransformData15_g262868 , Out_RotationData15_g262868 , Out_Interpolator15_g262868 );
					float3 Model_PivotWO353_g262861 = Out_PivotWO15_g262868;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g262867 = _ConformMeshMode;
					float Option70_g262867 = temp_output_17_0_g262867;
					half4 Model_VertexData357_g262861 = Out_VertexData15_g262868;
					float4 temp_output_3_0_g262867 = Model_VertexData357_g262861;
					float4 Channel70_g262867 = temp_output_3_0_g262867;
					float localSwitchChannel470_g262867 = SwitchChannel4( Option70_g262867 , Channel70_g262867 );
					float temp_output_390_0_g262861 = localSwitchChannel470_g262867;
					float temp_output_7_0_g262864 = _ConformMeshRemap.x;
					float temp_output_9_0_g262864 = ( temp_output_390_0_g262861 - temp_output_7_0_g262864 );
					float lerpResult374_g262861 = lerp( 1.0 , saturate( ( temp_output_9_0_g262864 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g262861 = lerpResult374_g262861;
					float temp_output_328_0_g262861 = ( Blend_VertMask379_g262861 * TVE_IsEnabled );
					half Conform_Mask366_g262861 = temp_output_328_0_g262861;
					float temp_output_322_0_g262861 = ( ( ( ( (Global_FormTexture351_g262861).z - ( (Model_PivotWO353_g262861).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g262861 ) );
					float3 appendResult329_g262861 = (float3(0.0 , temp_output_322_0_g262861 , 0.0));
					float3 appendResult387_g262861 = (float3(0.0 , 0.0 , temp_output_322_0_g262861));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262865 = appendResult387_g262861;
					#else
					float3 staticSwitch65_g262865 = appendResult329_g262861;
					#endif
					float3 Blanket_Conform368_g262861 = staticSwitch65_g262865;
					float4 appendResult312_g262861 = (float4(Blanket_Conform368_g262861 , 0.0));
					float4 temp_output_310_0_g262861 = ( Model_TransformData356_g262861 + appendResult312_g262861 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g262861 = temp_output_310_0_g262861;
					#else
					float4 staticSwitch364_g262861 = Model_TransformData356_g262861;
					#endif
					half4 Final_TransformData365_g262861 = staticSwitch364_g262861;
					float4 In_TransformData16_g262870 = Final_TransformData365_g262861;
					float4 In_RotationData16_g262870 = Out_RotationData15_g262869;
					float4 In_Interpolator16_g262870 = Out_Interpolator15_g262869;
					BuildVertexData( Data16_g262870 , In_Dummy16_g262870 , In_PositionOS16_g262870 , In_NormalOS16_g262870 , In_TangentOS16_g262870 , In_TransformData16_g262870 , In_RotationData16_g262870 , In_Interpolator16_g262870 );
					TVEVertexData Data15_g262878 =(TVEVertexData)Data16_g262870;
					float Out_Dummy15_g262878 = 0.0;
					float3 Out_PositionOS15_g262878 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262878 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262878 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262878 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262878 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262878 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262878 , Out_Dummy15_g262878 , Out_PositionOS15_g262878 , Out_NormalOS15_g262878 , Out_TangentOS15_g262878 , Out_TransformData15_g262878 , Out_RotationData15_g262878 , Out_Interpolator15_g262878 );
					TVEVertexData Data16_g262879 =(TVEVertexData)Data15_g262878;
					half Dummy181_g262872 = ( _RotationCategory + _RotationEnd + _RotationInfo );
					float In_Dummy16_g262879 = Dummy181_g262872;
					float3 In_PositionOS16_g262879 = Out_PositionOS15_g262878;
					float3 In_NormalOS16_g262879 = Out_NormalOS15_g262878;
					float4 In_TangentOS16_g262879 = Out_TangentOS15_g262878;
					float4 In_TransformData16_g262879 = Out_TransformData15_g262878;
					half4 Model_RotationData212_g262872 = Out_RotationData15_g262878;
					TVEGlobalData Data15_g262873 =(TVEGlobalData)Data15_g262871;
					float Out_Dummy15_g262873 = 0.0;
					float4 Out_CoatTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g262873 = float4( 0,0,0,0 );
					BreakData( Data15_g262873 , Out_Dummy15_g262873 , Out_CoatTexture15_g262873 , Out_DrawTexture15_g262873 , Out_PaintTexture15_g262873 , Out_AtmoTexture15_g262873 , Out_EffexTexture15_g262873 , Out_GlowTexture15_g262873 , Out_FormTexture15_g262873 , Out_LandTexture15_g262873 , Out_VertxTexture15_g262873 , Out_FlowTexture15_g262873 , Out_UserTexture15_g262873 );
					half4 Global_FormTexture188_g262872 = Out_FormTexture15_g262873;
					float2 temp_output_38_0_g262874 = ((Global_FormTexture188_g262872).xy*2.0 + -1.0);
					float2 break83_g262874 = temp_output_38_0_g262874;
					float3 appendResult79_g262874 = (float3(break83_g262874.x , 0.0 , break83_g262874.y));
					float3 ase_parentObjectScale = ( 1.0 / float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ) );
					float2 lerpResult227_g262872 = lerp( float2( 0,0 ) , (( mul( unity_WorldToObject, float4( appendResult79_g262874 , 0.0 ) ).xyz * ase_parentObjectScale )).xz , ( _RotationIntensityValue * TVE_IsEnabled ));
					half2 Blanket_Orientation192_g262872 = lerpResult227_g262872;
					float4 appendResult222_g262872 = (float4(( (Model_RotationData212_g262872).xy + Blanket_Orientation192_g262872 ) , (Model_RotationData212_g262872).zw));
					#ifdef TVE_ROTATION
					float4 staticSwitch218_g262872 = appendResult222_g262872;
					#else
					float4 staticSwitch218_g262872 = Model_RotationData212_g262872;
					#endif
					half4 Final_RotationData225_g262872 = staticSwitch218_g262872;
					float4 In_RotationData16_g262879 = Final_RotationData225_g262872;
					float4 In_Interpolator16_g262879 = Out_Interpolator15_g262878;
					BuildVertexData( Data16_g262879 , In_Dummy16_g262879 , In_PositionOS16_g262879 , In_NormalOS16_g262879 , In_TangentOS16_g262879 , In_TransformData16_g262879 , In_RotationData16_g262879 , In_Interpolator16_g262879 );
					TVEVertexData Data15_g262887 =(TVEVertexData)Data16_g262879;
					float Out_Dummy15_g262887 = 0.0;
					float3 Out_PositionOS15_g262887 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262887 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262887 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262887 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262887 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262887 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262887 , Out_Dummy15_g262887 , Out_PositionOS15_g262887 , Out_NormalOS15_g262887 , Out_TangentOS15_g262887 , Out_TransformData15_g262887 , Out_RotationData15_g262887 , Out_Interpolator15_g262887 );
					TVEVertexData Data16_g262888 =(TVEVertexData)Data15_g262887;
					half Dummy181_g262880 = ( _SizeFadeCategory + _SizeFadeEnd );
					float In_Dummy16_g262888 = Dummy181_g262880;
					float3 Model_PositionOS147_g262880 = Out_PositionOS15_g262887;
					float3 temp_cast_17 = (1.0).xxx;
					TVEModelData Data15_g262877 =(TVEModelData)Data15_g262868;
					float Out_Dummy15_g262877 = 0.0;
					float3 Out_PositionOS15_g262877 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262877 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262877 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262877 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262877 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262877 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262877 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262877 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262877 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262877 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262877 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262877 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262877 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262877 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262877 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262877 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262877 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262877 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262877 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262877 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262877 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262877 , Out_Dummy15_g262877 , Out_PositionOS15_g262877 , Out_PositionWS15_g262877 , Out_PositionWO15_g262877 , Out_PositionRawOS15_g262877 , Out_PivotOS15_g262877 , Out_PivotWS15_g262877 , Out_PivotWO15_g262877 , Out_NormalOS15_g262877 , Out_NormalWS15_g262877 , Out_NormalRawOS15_g262877 , Out_TangentOS15_g262877 , Out_TangentWS15_g262877 , Out_BitangentWS15_g262877 , Out_ViewDirWS15_g262877 , Out_CoordsData15_g262877 , Out_VertexData15_g262877 , Out_MasksData15_g262877 , Out_PhaseData15_g262877 , Out_TransformData15_g262877 , Out_RotationData15_g262877 , Out_Interpolator15_g262877 );
					TVEModelData Data15_g262889 =(TVEModelData)Data15_g262877;
					float Out_Dummy15_g262889 = 0.0;
					float3 Out_PositionOS15_g262889 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262889 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262889 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262889 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262889 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262889 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262889 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262889 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262889 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262889 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262889 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262889 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262889 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262889 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262889 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262889 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262889 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262889 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262889 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262889 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262889 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262889 , Out_Dummy15_g262889 , Out_PositionOS15_g262889 , Out_PositionWS15_g262889 , Out_PositionWO15_g262889 , Out_PositionRawOS15_g262889 , Out_PivotOS15_g262889 , Out_PivotWS15_g262889 , Out_PivotWO15_g262889 , Out_NormalOS15_g262889 , Out_NormalWS15_g262889 , Out_NormalRawOS15_g262889 , Out_TangentOS15_g262889 , Out_TangentWS15_g262889 , Out_BitangentWS15_g262889 , Out_ViewDirWS15_g262889 , Out_CoordsData15_g262889 , Out_VertexData15_g262889 , Out_MasksData15_g262889 , Out_PhaseData15_g262889 , Out_TransformData15_g262889 , Out_RotationData15_g262889 , Out_Interpolator15_g262889 );
					float3 Model_PivotWS162_g262880 = Out_PivotWS15_g262889;
					float lerpResult216_g262880 = lerp( 1.0 , TVE_SizeFadeParams.z , TVE_SizeFadeParams.w);
					float temp_output_7_0_g262882 = _SizeFadeDistMaxValue;
					float temp_output_9_0_g262882 = ( ( distance( _WorldSpaceCameraPos , Model_PivotWS162_g262880 ) * lerpResult216_g262880 ) - temp_output_7_0_g262882 );
					float temp_output_245_0_g262880 = (TVE_VertxParams).x;
					TVEGlobalData Data15_g262890 =(TVEGlobalData)Data15_g262873;
					float Out_Dummy15_g262890 = 0.0;
					float4 Out_CoatTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g262890 = float4( 0,0,0,0 );
					BreakData( Data15_g262890 , Out_Dummy15_g262890 , Out_CoatTexture15_g262890 , Out_DrawTexture15_g262890 , Out_PaintTexture15_g262890 , Out_AtmoTexture15_g262890 , Out_EffexTexture15_g262890 , Out_GlowTexture15_g262890 , Out_FormTexture15_g262890 , Out_LandTexture15_g262890 , Out_VertxTexture15_g262890 , Out_FlowTexture15_g262890 , Out_UserTexture15_g262890 );
					half4 Global_VertxTexture188_g262880 = Out_VertxTexture15_g262890;
					float temp_output_6_0_g262886 = (Global_VertxTexture188_g262880).x;
					float temp_output_7_0_g262886 = _SizeFadeVertxMode;
					#ifdef TVE_DUMMY
					float staticSwitch14_g262886 = ( temp_output_6_0_g262886 + temp_output_7_0_g262886 );
					#else
					float staticSwitch14_g262886 = temp_output_6_0_g262886;
					#endif
					float temp_output_223_0_g262880 = staticSwitch14_g262886;
					#ifdef TVE_SIZEFADE_VERTX
					float staticSwitch194_g262880 = temp_output_223_0_g262880;
					#else
					float staticSwitch194_g262880 = temp_output_245_0_g262880;
					#endif
					float lerpResult213_g262880 = lerp( 1.0 , staticSwitch194_g262880 , ( _SizeFadeVertxValue * TVE_IsEnabled ));
					half Blend_GlobalMask192_g262880 = lerpResult213_g262880;
					half Blend_UserMask232_g262880 = 1.0;
					float temp_output_236_0_g262880 = ( Blend_GlobalMask192_g262880 * Blend_UserMask232_g262880 );
					half Blend_Mask240_g262880 = temp_output_236_0_g262880;
					float temp_output_189_0_g262880 = ( saturate( ( temp_output_9_0_g262882 / ( ( _SizeFadeDistMinValue - temp_output_7_0_g262882 ) + 0.0001 ) ) ) * _SizeFadeScaleValue * Blend_Mask240_g262880 );
					float3 appendResult200_g262880 = (float3(temp_output_189_0_g262880 , temp_output_189_0_g262880 , temp_output_189_0_g262880));
					float3 appendResult201_g262880 = (float3(1.0 , temp_output_189_0_g262880 , 1.0));
					float3 appendResult230_g262880 = (float3(1.0 , 1.0 , temp_output_189_0_g262880));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262883 = appendResult230_g262880;
					#else
					float3 staticSwitch65_g262883 = appendResult201_g262880;
					#endif
					float3 lerpResult202_g262880 = lerp( appendResult200_g262880 , staticSwitch65_g262883 , _SizeFadeScaleMode);
					float3 lerpResult184_g262880 = lerp( temp_cast_17 , lerpResult202_g262880 , _SizeFadeIntensityValue);
					float3 temp_output_167_0_g262880 = ( lerpResult184_g262880 * Model_PositionOS147_g262880 );
					#ifdef TVE_SIZEFADE
					float3 staticSwitch199_g262880 = temp_output_167_0_g262880;
					#else
					float3 staticSwitch199_g262880 = Model_PositionOS147_g262880;
					#endif
					float3 Final_Position178_g262880 = staticSwitch199_g262880;
					float3 In_PositionOS16_g262888 = Final_Position178_g262880;
					float3 In_NormalOS16_g262888 = Out_NormalOS15_g262887;
					float4 In_TangentOS16_g262888 = Out_TangentOS15_g262887;
					float4 In_TransformData16_g262888 = Out_TransformData15_g262887;
					float4 In_RotationData16_g262888 = Out_RotationData15_g262887;
					float4 In_Interpolator16_g262888 = Out_Interpolator15_g262887;
					BuildVertexData( Data16_g262888 , In_Dummy16_g262888 , In_PositionOS16_g262888 , In_NormalOS16_g262888 , In_TangentOS16_g262888 , In_TransformData16_g262888 , In_RotationData16_g262888 , In_Interpolator16_g262888 );
					TVEVertexData Data15_g262912 =(TVEVertexData)Data16_g262888;
					float Out_Dummy15_g262912 = 0.0;
					float3 Out_PositionOS15_g262912 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262912 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262912 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262912 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262912 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262912 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262912 , Out_Dummy15_g262912 , Out_PositionOS15_g262912 , Out_NormalOS15_g262912 , Out_TangentOS15_g262912 , Out_TransformData15_g262912 , Out_RotationData15_g262912 , Out_Interpolator15_g262912 );
					TVEVertexData Data16_g262913 =(TVEVertexData)Data15_g262912;
					half Dummy181_g262899 = ( ( _MotionCategory + _MotionEnd ) + _MotionFlowInfo );
					float In_Dummy16_g262913 = Dummy181_g262899;
					float3 temp_output_3325_0_g262899 = Out_PositionOS15_g262912;
					float3 In_PositionOS16_g262913 = temp_output_3325_0_g262899;
					float3 In_NormalOS16_g262913 = Out_NormalOS15_g262912;
					float4 In_TangentOS16_g262913 = Out_TangentOS15_g262912;
					half4 Vertex_TransformData2743_g262899 = Out_TransformData15_g262912;
					float3 temp_cast_18 = (0.0).xxx;
					half Motion_FlowValue3376_g262899 = _MotionFlowValue;
					float2 lerpResult3361_g262899 = lerp( (half4( 1, 1, 1, 0 )).xy , (TVE_WindParams).xy , ( Motion_FlowValue3376_g262899 * TVE_IsEnabled ));
					float2 Global_WindDirWS2542_g262899 = (lerpResult3361_g262899*2.0 + -1.0);
					half2 Input_WindDirWS803_g262946 = Global_WindDirWS2542_g262899;
					TVEModelData Data15_g262911 =(TVEModelData)Data15_g262889;
					float Out_Dummy15_g262911 = 0.0;
					float3 Out_PositionOS15_g262911 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262911 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262911 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262911 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262911 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262911 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262911 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262911 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262911 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262911 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262911 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262911 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262911 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262911 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262911 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262911 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262911 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262911 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262911 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262911 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262911 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262911 , Out_Dummy15_g262911 , Out_PositionOS15_g262911 , Out_PositionWS15_g262911 , Out_PositionWO15_g262911 , Out_PositionRawOS15_g262911 , Out_PivotOS15_g262911 , Out_PivotWS15_g262911 , Out_PivotWO15_g262911 , Out_NormalOS15_g262911 , Out_NormalWS15_g262911 , Out_NormalRawOS15_g262911 , Out_TangentOS15_g262911 , Out_TangentWS15_g262911 , Out_BitangentWS15_g262911 , Out_ViewDirWS15_g262911 , Out_CoordsData15_g262911 , Out_VertexData15_g262911 , Out_MasksData15_g262911 , Out_PhaseData15_g262911 , Out_TransformData15_g262911 , Out_RotationData15_g262911 , Out_Interpolator15_g262911 );
					float3 Model_PositionWO162_g262899 = Out_PositionWO15_g262911;
					half3 Input_ModelPositionWO761_g262909 = Model_PositionWO162_g262899;
					float3 Model_PivotWO402_g262899 = Out_PivotWO15_g262911;
					half3 Input_ModelPivotsWO419_g262909 = Model_PivotWO402_g262899;
					half Input_MotionPivots629_g262909 = _MotionSmallPivotValue;
					float3 lerpResult771_g262909 = lerp( Input_ModelPositionWO761_g262909 , Input_ModelPivotsWO419_g262909 , Input_MotionPivots629_g262909);
					half4 Model_PhaseData489_g262899 = Out_PhaseData15_g262911;
					half4 Input_ModelMotionData763_g262909 = Model_PhaseData489_g262899;
					half Input_MotionPhase764_g262909 = _MotionSmallPhaseValue;
					float temp_output_770_0_g262909 = ( (Input_ModelMotionData763_g262909).x * Input_MotionPhase764_g262909 );
					half3 Small_Position1421_g262899 = ( lerpResult771_g262909 + temp_output_770_0_g262909 );
					half3 Input_PositionWO419_g262946 = Small_Position1421_g262899;
					half Input_MotionTilling321_g262946 = ( _MotionSmallTillingValue + 0.2 );
					half2 Noise_Coord979_g262946 = ( -(Input_PositionWO419_g262946).xz * Input_MotionTilling321_g262946 * 0.005 );
					float2 Input_Coords80_g262950 = Noise_Coord979_g262946;
					half2 Input_Direction82_g262950 = Input_WindDirWS803_g262946;
					float mulTime113_g262964 = _Time.y * 0.02;
					float lerpResult128_g262964 = lerp( mulTime113_g262964 , ( ( mulTime113_g262964 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					#ifdef SHADER_API_MOBILE
					float staticSwitch134_g262964 = frac( lerpResult128_g262964 );
					#else
					float staticSwitch134_g262964 = lerpResult128_g262964;
					#endif
					float Global_WindTime3262_g262899 = staticSwitch134_g262964;
					half Input_WindTime1015_g262946 = Global_WindTime3262_g262899;
					half Input_MotionSpeed62_g262946 = _MotionSmallSpeedValue;
					float temp_output_986_0_g262946 = ( Input_WindTime1015_g262946 * Input_MotionSpeed62_g262946 );
					half Noise_Speed980_g262946 = temp_output_986_0_g262946;
					float Input_Time88_g262950 = Noise_Speed980_g262946;
					float temp_output_23_0_g262950 = frac( Input_Time88_g262950 );
					float4 lerpResult39_g262950 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g262950 + ( Input_Direction82_g262950 * temp_output_23_0_g262950 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g262950 + ( Input_Direction82_g262950 * ( temp_output_23_0_g262950 - 1.0 ) ) ), 0.0 ) , temp_output_23_0_g262950);
					float4 temp_output_991_0_g262946 = lerpResult39_g262950;
					half2 Noise_DirWS858_g262946 = ((temp_output_991_0_g262946).rg*2.0 + -1.0);
					half Input_MotionNoise552_g262946 = _MotionSmallNoiseValue;
					float4 temp_output_3332_0_g262899 = TVE_FlowParams;
					TVEGlobalData Data15_g262925 =(TVEGlobalData)Data15_g262890;
					float Out_Dummy15_g262925 = 0.0;
					float4 Out_CoatTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g262925 = float4( 0,0,0,0 );
					BreakData( Data15_g262925 , Out_Dummy15_g262925 , Out_CoatTexture15_g262925 , Out_DrawTexture15_g262925 , Out_PaintTexture15_g262925 , Out_AtmoTexture15_g262925 , Out_EffexTexture15_g262925 , Out_GlowTexture15_g262925 , Out_FormTexture15_g262925 , Out_LandTexture15_g262925 , Out_VertxTexture15_g262925 , Out_FlowTexture15_g262925 , Out_UserTexture15_g262925 );
					half4 Global_FlowTexture2668_g262899 = Out_FlowTexture15_g262925;
					#ifdef TVE_MOTION_FLOW
					float4 staticSwitch3075_g262899 = Global_FlowTexture2668_g262899;
					#else
					float4 staticSwitch3075_g262899 = temp_output_3332_0_g262899;
					#endif
					float4 temp_output_6_0_g262926 = staticSwitch3075_g262899;
					float temp_output_7_0_g262926 = _MotionFlowMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g262926 = ( temp_output_6_0_g262926 + temp_output_7_0_g262926 );
					#else
					float4 staticSwitch14_g262926 = temp_output_6_0_g262926;
					#endif
					float4 lerpResult3121_g262899 = lerp( half4( 1, 1, 1, 0 ) , staticSwitch14_g262926 , ( Motion_FlowValue3376_g262899 * TVE_IsEnabled ));
					float temp_output_3077_0_g262899 = (lerpResult3121_g262899).z;
					float temp_output_630_0_g262935 = temp_output_3077_0_g262899;
					float lerpResult853_g262935 = lerp( temp_output_630_0_g262935 , TVE_WindEditor.z , TVE_WindEditor.w);
					half Global_WindValue1855_g262899 = ( lerpResult853_g262935 * _MotionIntensityValue );
					half Input_WindValue881_g262946 = Global_WindValue1855_g262899;
					float temp_output_6_0_g262948 = Input_WindValue881_g262946;
					float lerpResult701_g262946 = lerp( 1.0 , Input_MotionNoise552_g262946 , ( temp_output_6_0_g262948 * temp_output_6_0_g262948 ));
					float2 lerpResult646_g262946 = lerp( Input_WindDirWS803_g262946 , Noise_DirWS858_g262946 , lerpResult701_g262946);
					half2 Small_DirWS817_g262946 = lerpResult646_g262946;
					float2 break823_g262946 = Small_DirWS817_g262946;
					half4 Noise_Params685_g262946 = temp_output_991_0_g262946;
					half Wind_Sinus820_g262946 = ( ((Noise_Params685_g262946).b*2.0 + -1.0) * 0.6 );
					float3 appendResult824_g262946 = (float3(break823_g262946.x , Wind_Sinus820_g262946 , break823_g262946.y));
					half3 Small_Dir918_g262946 = appendResult824_g262946;
					float temp_output_20_0_g262947 = ( 1.0 - Input_WindValue881_g262946 );
					float3 appendResult1006_g262946 = (float3(Input_WindValue881_g262946 , ( 1.0 - ( temp_output_20_0_g262947 * temp_output_20_0_g262947 ) ) , Input_WindValue881_g262946));
					half Input_MotionDelay753_g262946 = _MotionSmallDelayValue;
					float lerpResult756_g262946 = lerp( 1.0 , ( Input_WindValue881_g262946 * Input_WindValue881_g262946 ) , Input_MotionDelay753_g262946);
					half Wind_Delay815_g262946 = lerpResult756_g262946;
					half Input_MotionValue905_g262946 = _MotionSmallIntensityValue;
					float3 temp_output_883_0_g262946 = ( Small_Dir918_g262946 * appendResult1006_g262946 * Wind_Delay815_g262946 * Input_MotionValue905_g262946 );
					float2 break857_g262946 = Noise_DirWS858_g262946;
					float3 appendResult833_g262946 = (float3(break857_g262946.x , Wind_Sinus820_g262946 , break857_g262946.y));
					half3 Push_Dir919_g262946 = appendResult833_g262946;
					half Input_MotionReact924_g262946 = _MotionSmallPushValue;
					half Global_PushAlpha1504_g262899 = (lerpResult3121_g262899).w;
					half Input_PushAlpha806_g262946 = Global_PushAlpha1504_g262899;
					half Global_PushNoise2675_g262899 = temp_output_3077_0_g262899;
					half Input_PushNoise890_g262946 = Global_PushNoise2675_g262899;
					half Push_Mask914_g262946 = saturate( ( Input_PushAlpha806_g262946 * Input_PushNoise890_g262946 * Input_MotionReact924_g262946 ) );
					float3 lerpResult840_g262946 = lerp( temp_output_883_0_g262946 , ( Push_Dir919_g262946 * Input_MotionReact924_g262946 ) , Push_Mask914_g262946);
					#ifdef TVE_MOTION_FLOW
					float3 staticSwitch829_g262946 = lerpResult840_g262946;
					#else
					float3 staticSwitch829_g262946 = temp_output_883_0_g262946;
					#endif
					half3 Small_Squash1489_g262899 = ( mul( unity_WorldToObject, float4( staticSwitch829_g262946 , 0.0 ) ).xyz * ase_parentObjectScale );
					float temp_output_17_0_g262914 = _MotionSmallMaskMode;
					float Option92_g262914 = temp_output_17_0_g262914;
					half4 Model_VertexMasks518_g262899 = Out_VertexData15_g262911;
					float4 temp_output_84_0_g262914 = Model_VertexMasks518_g262899;
					float4 ChannelA92_g262914 = temp_output_84_0_g262914;
					half4 Model_MasksData1322_g262899 = Out_MasksData15_g262911;
					float2 uv_MotionMaskTex2818_g262899 = v.texcoord.xyzw.xy;
					half4 Motion_MaskTex2819_g262899 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex2818_g262899, 0.0 );
					float3 appendResult3227_g262899 = (float3((Model_MasksData1322_g262899).xy , (Motion_MaskTex2819_g262899).g));
					float3 temp_output_85_0_g262914 = appendResult3227_g262899;
					float4 ChannelB92_g262914 = float4( temp_output_85_0_g262914 , 0.0 );
					float localSwitchChannel792_g262914 = SwitchChannel7( Option92_g262914 , ChannelA92_g262914 , ChannelB92_g262914 );
					float enc1805_g262899 = v.texcoord.xyzw.z;
					float2 localDecodeFloatToVector21805_g262899 = DecodeFloatToVector2( enc1805_g262899 );
					float2 break1804_g262899 = localDecodeFloatToVector21805_g262899;
					half Small_Mask_Legacy1806_g262899 = break1804_g262899.x;
					#ifdef TVE_LEGACY
					float staticSwitch1800_g262899 = Small_Mask_Legacy1806_g262899;
					#else
					float staticSwitch1800_g262899 = localSwitchChannel792_g262914;
					#endif
					float clampResult17_g262900 = clamp( staticSwitch1800_g262899 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262901 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g262901 = ( clampResult17_g262900 - temp_output_7_0_g262901 );
					half Small_Mask640_g262899 = saturate( ( temp_output_9_0_g262901 * _MotionSmallMaskRemap.z ) );
					float3 lerpResult3022_g262899 = lerp( float3( 1,1,1 ) , (TVE_MotionValueParams).xyz , TVE_MotionValueParams.w);
					half3 Global_MotionParams3013_g262899 = lerpResult3022_g262899;
					half3 Small_Motion789_g262899 = ( Small_Squash1489_g262899 * Small_Mask640_g262899 * (Global_MotionParams3013_g262899).y );
					#ifdef TVE_MOTION
					float3 staticSwitch495_g262899 = Small_Motion789_g262899;
					#else
					float3 staticSwitch495_g262899 = temp_cast_18;
					#endif
					float3 temp_cast_22 = (0.0).xxx;
					half3 Tiny_Position2469_g262899 = Model_PositionWO162_g262899;
					half3 Input_PositionWO419_g262965 = Tiny_Position2469_g262899;
					half Input_MotionTilling321_g262965 = ( _MotionTinyTillingValue + 0.2 );
					half2 Noise_Coord979_g262965 = ( -(Input_PositionWO419_g262965).xz * Input_MotionTilling321_g262965 * 0.005 );
					float2 Input_Coords80_g262972 = Noise_Coord979_g262965;
					half2 Input_Direction82_g262972 = float2( 0,1 );
					half Input_WindTime1015_g262965 = Global_WindTime3262_g262899;
					half Input_MotionSpeed62_g262965 = _MotionTinySpeedValue;
					float temp_output_986_0_g262965 = ( Input_WindTime1015_g262965 * Input_MotionSpeed62_g262965 );
					half Noise_Speed980_g262965 = temp_output_986_0_g262965;
					float Input_Time88_g262972 = Noise_Speed980_g262965;
					float4 temp_output_991_0_g262965 = SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g262972 + ( Input_Direction82_g262972 * Input_Time88_g262972 ) ), 0.0 );
					half3 Noise_DirWS858_g262965 = ((temp_output_991_0_g262965).rgb*2.0 + -1.0);
					half Input_MotionNoise552_g262965 = _MotionTinyNoiseValue;
					float3 lerpResult646_g262965 = lerp( ( Noise_DirWS858_g262965 * v.normal ) , Noise_DirWS858_g262965 , Input_MotionNoise552_g262965);
					half3 Tiny_DirWS817_g262965 = lerpResult646_g262965;
					half Input_MotionValue905_g262965 = _MotionTinyIntensityValue;
					float mulTime113_g262978 = _Time.y * 2.0;
					float lerpResult128_g262978 = lerp( mulTime113_g262978 , ( ( mulTime113_g262978 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					#ifdef SHADER_API_MOBILE
					float staticSwitch134_g262978 = frac( lerpResult128_g262978 );
					#else
					float staticSwitch134_g262978 = lerpResult128_g262978;
					#endif
					float3 temp_output_1028_0_g262965 = ( Input_PositionWO419_g262965 + staticSwitch134_g262978 );
					float temp_output_1054_0_g262965 = SAMPLE_TEXTURE3D_LOD( _NoiseTex3D, sampler_Linear_Repeat, ( temp_output_1028_0_g262965 * ( 1.0 * 0.01 ) ), 0.0 ).r;
					float temp_output_6_0_g262968 = temp_output_1054_0_g262965;
					float temp_output_6_0_g262969 = temp_output_1054_0_g262965;
					half Input_WindValue881_g262965 = Global_WindValue1855_g262899;
					float temp_output_6_0_g262971 = Input_WindValue881_g262965;
					float lerpResult1029_g262965 = lerp( ( temp_output_6_0_g262968 * temp_output_6_0_g262968 * temp_output_6_0_g262968 * temp_output_6_0_g262968 ) , ( temp_output_6_0_g262969 * temp_output_6_0_g262969 ) , ( temp_output_6_0_g262971 * temp_output_6_0_g262971 ));
					float temp_output_20_0_g262970 = ( 1.0 - Input_WindValue881_g262965 );
					float temp_output_1030_0_g262965 = ( lerpResult1029_g262965 * ( 1.0 - ( temp_output_20_0_g262970 * temp_output_20_0_g262970 * temp_output_20_0_g262970 * temp_output_20_0_g262970 ) ) );
					half Wind_Gust1039_g262965 = temp_output_1030_0_g262965;
					float3 temp_output_883_0_g262965 = ( Tiny_DirWS817_g262965 * Input_MotionValue905_g262965 * Wind_Gust1039_g262965 );
					half3 Tiny_Squash859_g262899 = temp_output_883_0_g262965;
					float temp_output_17_0_g262915 = _MotionTinyMaskMode;
					float Option92_g262915 = temp_output_17_0_g262915;
					float4 temp_output_84_0_g262915 = Model_VertexMasks518_g262899;
					float4 ChannelA92_g262915 = temp_output_84_0_g262915;
					float3 appendResult3234_g262899 = (float3((Model_MasksData1322_g262899).xy , (Motion_MaskTex2819_g262899).b));
					float3 temp_output_85_0_g262915 = appendResult3234_g262899;
					float4 ChannelB92_g262915 = float4( temp_output_85_0_g262915 , 0.0 );
					float localSwitchChannel792_g262915 = SwitchChannel7( Option92_g262915 , ChannelA92_g262915 , ChannelB92_g262915 );
					half Tiny_Mask_Legacy1807_g262899 = break1804_g262899.y;
					#ifdef TVE_LEGACY
					float staticSwitch1810_g262899 = Tiny_Mask_Legacy1807_g262899;
					#else
					float staticSwitch1810_g262899 = localSwitchChannel792_g262915;
					#endif
					float clampResult17_g262902 = clamp( staticSwitch1810_g262899 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262903 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g262903 = ( clampResult17_g262902 - temp_output_7_0_g262903 );
					half Tiny_Mask218_g262899 = saturate( ( temp_output_9_0_g262903 * _MotionTinyMaskRemap.z ) );
					float3 Model_PositionWS1819_g262899 = Out_PositionWS15_g262911;
					half Global_DistMask1820_g262899 = ( 1.0 - saturate( ( distance( _WorldSpaceCameraPos , Model_PositionWS1819_g262899 ) / _MotionDistValue ) ) );
					half3 Tiny_Flutter1451_g262899 = ( Tiny_Squash859_g262899 * Tiny_Mask218_g262899 * Global_DistMask1820_g262899 * (Global_MotionParams3013_g262899).z );
					#ifdef TVE_MOTION
					float3 staticSwitch414_g262899 = Tiny_Flutter1451_g262899;
					#else
					float3 staticSwitch414_g262899 = temp_cast_22;
					#endif
					float4 appendResult2783_g262899 = (float4(( staticSwitch495_g262899 + staticSwitch414_g262899 ) , 0.0));
					half4 Final_TransformData1569_g262899 = ( Vertex_TransformData2743_g262899 + appendResult2783_g262899 );
					float4 In_TransformData16_g262913 = Final_TransformData1569_g262899;
					half4 Vertex_RotationData2740_g262899 = Out_RotationData15_g262912;
					half2 Input_WindDirWS803_g262936 = Global_WindDirWS2542_g262899;
					half3 Input_ModelPositionWO761_g262910 = Model_PositionWO162_g262899;
					half3 Input_ModelPivotsWO419_g262910 = Model_PivotWO402_g262899;
					half Input_MotionPivots629_g262910 = _MotionBasePivotValue;
					float3 lerpResult771_g262910 = lerp( Input_ModelPositionWO761_g262910 , Input_ModelPivotsWO419_g262910 , Input_MotionPivots629_g262910);
					half4 Input_ModelMotionData763_g262910 = Model_PhaseData489_g262899;
					half Input_MotionPhase764_g262910 = _MotionBasePhaseValue;
					float temp_output_770_0_g262910 = ( (Input_ModelMotionData763_g262910).x * Input_MotionPhase764_g262910 );
					half3 Base_Position1394_g262899 = ( lerpResult771_g262910 + temp_output_770_0_g262910 );
					half3 Input_PositionWO419_g262936 = Base_Position1394_g262899;
					half Input_MotionTilling321_g262936 = ( _MotionBaseTillingValue + 0.2 );
					half2 Noise_Coord515_g262936 = ( -(Input_PositionWO419_g262936).xz * Input_MotionTilling321_g262936 * 0.005 );
					float2 Input_Coords80_g262938 = Noise_Coord515_g262936;
					half2 Input_Direction82_g262938 = Input_WindDirWS803_g262936;
					half Input_WindTime963_g262936 = Global_WindTime3262_g262899;
					half Input_MotionSpeed62_g262936 = _MotionBaseSpeedValue;
					float temp_output_505_0_g262936 = ( Input_WindTime963_g262936 * Input_MotionSpeed62_g262936 );
					half Noise_Speed516_g262936 = temp_output_505_0_g262936;
					float Input_Time88_g262938 = Noise_Speed516_g262936;
					float temp_output_23_0_g262938 = frac( Input_Time88_g262938 );
					float4 lerpResult39_g262938 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g262938 + ( Input_Direction82_g262938 * temp_output_23_0_g262938 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g262938 + ( Input_Direction82_g262938 * ( temp_output_23_0_g262938 - 1.0 ) ) ), 0.0 ) , temp_output_23_0_g262938);
					float4 temp_output_635_0_g262936 = lerpResult39_g262938;
					half2 Noise_DirWS825_g262936 = ((temp_output_635_0_g262936).rg*2.0 + -1.0);
					half Input_MotionNoise552_g262936 = _MotionBaseNoiseValue;
					half Input_WindValue853_g262936 = Global_WindValue1855_g262899;
					float temp_output_6_0_g262937 = Input_WindValue853_g262936;
					float lerpResult701_g262936 = lerp( 1.0 , Input_MotionNoise552_g262936 , ( temp_output_6_0_g262937 * temp_output_6_0_g262937 ));
					float2 lerpResult646_g262936 = lerp( Input_WindDirWS803_g262936 , Noise_DirWS825_g262936 , lerpResult701_g262936);
					half2 Bend_Dir859_g262936 = lerpResult646_g262936;
					half Input_MotionValue871_g262936 = _MotionBaseIntensityValue;
					half Input_MotionDelay753_g262936 = _MotionBaseDelayValue;
					float lerpResult756_g262936 = lerp( 1.0 , ( Input_WindValue853_g262936 * Input_WindValue853_g262936 ) , Input_MotionDelay753_g262936);
					half Wind_Delay815_g262936 = lerpResult756_g262936;
					float2 temp_output_875_0_g262936 = ( Bend_Dir859_g262936 * Input_WindValue853_g262936 * Input_MotionValue871_g262936 * Wind_Delay815_g262936 );
					float2 Global_PushDirWS1972_g262899 = ((lerpResult3121_g262899).xy*2.0 + -1.0);
					half2 Input_PushDirWS807_g262936 = Global_PushDirWS1972_g262899;
					half Input_ReactValue888_g262936 = _MotionBasePushValue;
					half Input_PushAlpha806_g262936 = Global_PushAlpha1504_g262899;
					half Push_Mask883_g262936 = saturate( ( Input_PushAlpha806_g262936 * Input_ReactValue888_g262936 ) );
					float2 lerpResult811_g262936 = lerp( temp_output_875_0_g262936 , ( Input_PushDirWS807_g262936 * Input_ReactValue888_g262936 ) , Push_Mask883_g262936);
					#ifdef TVE_MOTION_FLOW
					float2 staticSwitch808_g262936 = lerpResult811_g262936;
					#else
					float2 staticSwitch808_g262936 = temp_output_875_0_g262936;
					#endif
					float2 temp_output_38_0_g262942 = staticSwitch808_g262936;
					float2 break83_g262942 = temp_output_38_0_g262942;
					float3 appendResult79_g262942 = (float3(break83_g262942.x , 0.0 , break83_g262942.y));
					half2 Base_Bending893_g262899 = (( mul( unity_WorldToObject, float4( appendResult79_g262942 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
					float temp_output_17_0_g262916 = _MotionBaseMaskMode;
					float Option92_g262916 = temp_output_17_0_g262916;
					float4 temp_output_84_0_g262916 = Model_VertexMasks518_g262899;
					float4 ChannelA92_g262916 = temp_output_84_0_g262916;
					float3 appendResult3220_g262899 = (float3((Model_MasksData1322_g262899).xy , (Motion_MaskTex2819_g262899).r));
					float3 temp_output_85_0_g262916 = appendResult3220_g262899;
					float4 ChannelB92_g262916 = float4( temp_output_85_0_g262916 , 0.0 );
					float localSwitchChannel792_g262916 = SwitchChannel7( Option92_g262916 , ChannelA92_g262916 , ChannelB92_g262916 );
					float clampResult17_g262905 = clamp( localSwitchChannel792_g262916 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262904 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g262904 = ( clampResult17_g262905 - temp_output_7_0_g262904 );
					half Base_Mask217_g262899 = saturate( ( temp_output_9_0_g262904 * _MotionBaseMaskRemap.z ) );
					half2 Base_Motion1440_g262899 = ( Base_Bending893_g262899 * Base_Mask217_g262899 * (Global_MotionParams3013_g262899).x );
					#ifdef TVE_MOTION
					float2 staticSwitch2384_g262899 = Base_Motion1440_g262899;
					#else
					float2 staticSwitch2384_g262899 = float2( 0,0 );
					#endif
					float4 appendResult2023_g262899 = (float4(staticSwitch2384_g262899 , 0.0 , 0.0));
					half4 Final_RotationData1570_g262899 = ( Vertex_RotationData2740_g262899 + appendResult2023_g262899 );
					float4 In_RotationData16_g262913 = Final_RotationData1570_g262899;
					half4 Vertex_Interpolator2773_g262899 = Out_Interpolator15_g262912;
					half4 Noise_Params685_g262936 = temp_output_635_0_g262936;
					float temp_output_6_0_g262944 = (Noise_Params685_g262936).a;
					float temp_output_913_0_g262936 = ( ( temp_output_6_0_g262944 * temp_output_6_0_g262944 * temp_output_6_0_g262944 * temp_output_6_0_g262944 ) * ( Input_WindValue853_g262936 * Wind_Delay815_g262936 ) );
					float temp_output_6_0_g262945 = length( Input_PushDirWS807_g262936 );
					float temp_output_937_0_g262936 = ( temp_output_6_0_g262945 * temp_output_6_0_g262945 );
					half Input_PushNoise858_g262936 = Global_PushNoise2675_g262899;
					float lerpResult902_g262936 = lerp( temp_output_913_0_g262936 , temp_output_937_0_g262936 , ( Push_Mask883_g262936 * Input_PushNoise858_g262936 ));
					#ifdef TVE_MOTION_FLOW
					float staticSwitch903_g262936 = lerpResult902_g262936;
					#else
					float staticSwitch903_g262936 = temp_output_913_0_g262936;
					#endif
					half Base_Wave1159_g262899 = staticSwitch903_g262936;
					float temp_output_6_0_g262949 = (Noise_Params685_g262946).a;
					float temp_output_955_0_g262946 = ( temp_output_6_0_g262949 * temp_output_6_0_g262949 * temp_output_6_0_g262949 * temp_output_6_0_g262949 );
					float temp_output_944_0_g262946 = ( temp_output_955_0_g262946 * ( Input_WindValue881_g262946 * Wind_Delay815_g262946 ) );
					float lerpResult936_g262946 = lerp( temp_output_944_0_g262946 , temp_output_955_0_g262946 , ( Push_Mask914_g262946 * Input_PushNoise890_g262946 ));
					#ifdef TVE_MOTION_FLOW
					float staticSwitch939_g262946 = lerpResult936_g262946;
					#else
					float staticSwitch939_g262946 = temp_output_944_0_g262946;
					#endif
					half Small_Wave1427_g262899 = staticSwitch939_g262946;
					float lerpResult2422_g262899 = lerp( Base_Wave1159_g262899 , Small_Wave1427_g262899 , _motion_small_mode);
					half Global_Wave1475_g262899 = saturate( lerpResult2422_g262899 );
					float temp_output_6_0_g262906 = ( _MotionHighlightValue * Global_DistMask1820_g262899 * ( Tiny_Mask218_g262899 * Tiny_Mask218_g262899 ) * Global_Wave1475_g262899 );
					float temp_output_7_0_g262906 = _MotionHighlightColor.r;
					#ifdef TVE_DUMMY
					float staticSwitch14_g262906 = ( temp_output_6_0_g262906 + temp_output_7_0_g262906 );
					#else
					float staticSwitch14_g262906 = temp_output_6_0_g262906;
					#endif
					#ifdef TVE_MOTION
					float staticSwitch2866_g262899 = staticSwitch14_g262906;
					#else
					float staticSwitch2866_g262899 = 0.0;
					#endif
					float4 appendResult2775_g262899 = (float4((Vertex_Interpolator2773_g262899).xyz , staticSwitch2866_g262899));
					half4 Final_Interpolator2774_g262899 = appendResult2775_g262899;
					float4 In_Interpolator16_g262913 = Final_Interpolator2774_g262899;
					BuildVertexData( Data16_g262913 , In_Dummy16_g262913 , In_PositionOS16_g262913 , In_NormalOS16_g262913 , In_TangentOS16_g262913 , In_TransformData16_g262913 , In_RotationData16_g262913 , In_Interpolator16_g262913 );
					TVEVertexData Data15_g262988 =(TVEVertexData)Data16_g262913;
					float Out_Dummy15_g262988 = 0.0;
					float3 Out_PositionOS15_g262988 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262988 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262988 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262988 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262988 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262988 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262988 , Out_Dummy15_g262988 , Out_PositionOS15_g262988 , Out_NormalOS15_g262988 , Out_TangentOS15_g262988 , Out_TransformData15_g262988 , Out_RotationData15_g262988 , Out_Interpolator15_g262988 );
					TVEVertexData Data16_g262989 =(TVEVertexData)Data15_g262988;
					float In_Dummy16_g262989 = 0.0;
					float3 Vertex_PositionOS147_g262979 = Out_PositionOS15_g262988;
					half3 VertexPos40_g262983 = Vertex_PositionOS147_g262979;
					float4 temp_output_1615_33_g262979 = Out_RotationData15_g262988;
					half4 Vertex_RotationData1569_g262979 = temp_output_1615_33_g262979;
					float2 break1582_g262979 = (Vertex_RotationData1569_g262979).xy;
					half Angle44_g262983 = break1582_g262979.y;
					half CosAngle89_g262983 = cos( Angle44_g262983 );
					half SinAngle93_g262983 = sin( Angle44_g262983 );
					float3 appendResult95_g262983 = (float3((VertexPos40_g262983).x , ( ( (VertexPos40_g262983).y * CosAngle89_g262983 ) - ( (VertexPos40_g262983).z * SinAngle93_g262983 ) ) , ( ( (VertexPos40_g262983).y * SinAngle93_g262983 ) + ( (VertexPos40_g262983).z * CosAngle89_g262983 ) )));
					half3 VertexPos40_g262984 = appendResult95_g262983;
					half Angle44_g262984 = -break1582_g262979.x;
					half CosAngle94_g262984 = cos( Angle44_g262984 );
					half SinAngle95_g262984 = sin( Angle44_g262984 );
					float3 appendResult98_g262984 = (float3(( ( (VertexPos40_g262984).x * CosAngle94_g262984 ) - ( (VertexPos40_g262984).y * SinAngle95_g262984 ) ) , ( ( (VertexPos40_g262984).x * SinAngle95_g262984 ) + ( (VertexPos40_g262984).y * CosAngle94_g262984 ) ) , (VertexPos40_g262984).z));
					half3 VertexPos40_g262982 = Vertex_PositionOS147_g262979;
					half Angle44_g262982 = break1582_g262979.y;
					half CosAngle89_g262982 = cos( Angle44_g262982 );
					half SinAngle93_g262982 = sin( Angle44_g262982 );
					float3 appendResult95_g262982 = (float3((VertexPos40_g262982).x , ( ( (VertexPos40_g262982).y * CosAngle89_g262982 ) - ( (VertexPos40_g262982).z * SinAngle93_g262982 ) ) , ( ( (VertexPos40_g262982).y * SinAngle93_g262982 ) + ( (VertexPos40_g262982).z * CosAngle89_g262982 ) )));
					half3 VertexPos40_g262987 = appendResult95_g262982;
					half Angle44_g262987 = break1582_g262979.x;
					half CosAngle91_g262987 = cos( Angle44_g262987 );
					half SinAngle92_g262987 = sin( Angle44_g262987 );
					float3 appendResult93_g262987 = (float3(( ( (VertexPos40_g262987).x * CosAngle91_g262987 ) + ( (VertexPos40_g262987).z * SinAngle92_g262987 ) ) , (VertexPos40_g262987).y , ( ( -(VertexPos40_g262987).x * SinAngle92_g262987 ) + ( (VertexPos40_g262987).z * CosAngle91_g262987 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262985 = appendResult93_g262987;
					#else
					float3 staticSwitch65_g262985 = appendResult98_g262984;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g262980 = staticSwitch65_g262985;
					#else
					float3 staticSwitch65_g262980 = Vertex_PositionOS147_g262979;
					#endif
					float3 temp_output_1608_0_g262979 = staticSwitch65_g262980;
					half3 VertexPos40_g262986 = temp_output_1608_0_g262979;
					half Angle44_g262986 = (Vertex_RotationData1569_g262979).z;
					half CosAngle91_g262986 = cos( Angle44_g262986 );
					half SinAngle92_g262986 = sin( Angle44_g262986 );
					float3 appendResult93_g262986 = (float3(( ( (VertexPos40_g262986).x * CosAngle91_g262986 ) + ( (VertexPos40_g262986).z * SinAngle92_g262986 ) ) , (VertexPos40_g262986).y , ( ( -(VertexPos40_g262986).x * SinAngle92_g262986 ) + ( (VertexPos40_g262986).z * CosAngle91_g262986 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g262981 = appendResult93_g262986;
					#else
					float3 staticSwitch65_g262981 = temp_output_1608_0_g262979;
					#endif
					float4 temp_output_1615_31_g262979 = Out_TransformData15_g262988;
					half4 Vertex_TransformData1568_g262979 = temp_output_1615_31_g262979;
					half3 Final_PositionOS178_g262979 = ( ( staticSwitch65_g262981 * (Vertex_TransformData1568_g262979).w ) + (Vertex_TransformData1568_g262979).xyz );
					float3 In_PositionOS16_g262989 = Final_PositionOS178_g262979;
					float3 In_NormalOS16_g262989 = Out_NormalOS15_g262988;
					float4 In_TangentOS16_g262989 = Out_TangentOS15_g262988;
					float4 In_TransformData16_g262989 = temp_output_1615_31_g262979;
					float4 In_RotationData16_g262989 = temp_output_1615_33_g262979;
					float4 In_Interpolator16_g262989 = Out_Interpolator15_g262988;
					BuildVertexData( Data16_g262989 , In_Dummy16_g262989 , In_PositionOS16_g262989 , In_NormalOS16_g262989 , In_TangentOS16_g262989 , In_TransformData16_g262989 , In_RotationData16_g262989 , In_Interpolator16_g262989 );
					TVEVertexData Data15_g262999 =(TVEVertexData)Data16_g262989;
					float Out_Dummy15_g262999 = 0.0;
					float3 Out_PositionOS15_g262999 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262999 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262999 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262999 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262999 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262999 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262999 , Out_Dummy15_g262999 , Out_PositionOS15_g262999 , Out_NormalOS15_g262999 , Out_TangentOS15_g262999 , Out_TransformData15_g262999 , Out_RotationData15_g262999 , Out_Interpolator15_g262999 );
					TVEVertexData Data16_g263000 =(TVEVertexData)Data15_g262999;
					half Dummy1823_g262990 = ( _FlattenCategory + _FlattenEnd + _FlattenBakeMode );
					float In_Dummy16_g263000 = Dummy1823_g262990;
					float3 In_PositionOS16_g263000 = Out_PositionOS15_g262999;
					half3 Vertex_NormalOS1829_g262990 = Out_NormalOS15_g262999;
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262991 = half3( 0, 0, 1 );
					#else
					float3 staticSwitch65_g262991 = half3( 0, 1, 0 );
					#endif
					float3 lerpResult1820_g262990 = lerp( Vertex_NormalOS1829_g262990 , staticSwitch65_g262991 , _FlattenUpwardsValue);
					TVEModelData Data15_g263001 =(TVEModelData)Data15_g262911;
					float Out_Dummy15_g263001 = 0.0;
					float3 Out_PositionOS15_g263001 = float3( 0,0,0 );
					float3 Out_PositionWS15_g263001 = float3( 0,0,0 );
					float3 Out_PositionWO15_g263001 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g263001 = float3( 0,0,0 );
					float3 Out_PivotOS15_g263001 = float3( 0,0,0 );
					float3 Out_PivotWS15_g263001 = float3( 0,0,0 );
					float3 Out_PivotWO15_g263001 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263001 = float3( 0,0,0 );
					float3 Out_NormalWS15_g263001 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g263001 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263001 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g263001 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g263001 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g263001 = float3( 0,0,0 );
					float4 Out_CoordsData15_g263001 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g263001 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g263001 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g263001 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263001 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263001 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263001 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g263001 , Out_Dummy15_g263001 , Out_PositionOS15_g263001 , Out_PositionWS15_g263001 , Out_PositionWO15_g263001 , Out_PositionRawOS15_g263001 , Out_PivotOS15_g263001 , Out_PivotWS15_g263001 , Out_PivotWO15_g263001 , Out_NormalOS15_g263001 , Out_NormalWS15_g263001 , Out_NormalRawOS15_g263001 , Out_TangentOS15_g263001 , Out_TangentWS15_g263001 , Out_BitangentWS15_g263001 , Out_ViewDirWS15_g263001 , Out_CoordsData15_g263001 , Out_VertexData15_g263001 , Out_MasksData15_g263001 , Out_PhaseData15_g263001 , Out_TransformData15_g263001 , Out_RotationData15_g263001 , Out_Interpolator15_g263001 );
					float3 Model_PositionOS1837_g262990 = Out_PositionOS15_g263001;
					float3 normalizeResult1816_g262990 = ASESafeNormalize( ( Model_PositionOS1837_g262990 + _FlattenSphereOffsetValue ) );
					float3 lerpResult1813_g262990 = lerp( lerpResult1820_g262990 , normalizeResult1816_g262990 , _FlattenSphereValue);
					float temp_output_17_0_g262998 = _FlattenMeshMode;
					float Option70_g262998 = temp_output_17_0_g262998;
					half4 Model_VertexData1826_g262990 = Out_VertexData15_g263001;
					float4 temp_output_3_0_g262998 = Model_VertexData1826_g262990;
					float4 Channel70_g262998 = temp_output_3_0_g262998;
					float localSwitchChannel470_g262998 = SwitchChannel4( Option70_g262998 , Channel70_g262998 );
					float clampResult17_g262992 = clamp( localSwitchChannel470_g262998 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262993 = _FlattenMeshRemap.x;
					float temp_output_9_0_g262993 = ( clampResult17_g262992 - temp_output_7_0_g262993 );
					float lerpResult1841_g262990 = lerp( 1.0 , saturate( ( temp_output_9_0_g262993 * _FlattenMeshRemap.z ) ) , _FlattenMeshValue);
					half Normal_MeskMask1847_g262990 = lerpResult1841_g262990;
					half Normal_Mask1851_g262990 = Normal_MeskMask1847_g262990;
					float3 lerpResult1856_g262990 = lerp( Vertex_NormalOS1829_g262990 , lerpResult1813_g262990 , ( Normal_Mask1851_g262990 * _FlattenIntensityValue ));
					#ifdef TVE_FLATTEN
					float3 staticSwitch1857_g262990 = lerpResult1856_g262990;
					#else
					float3 staticSwitch1857_g262990 = Vertex_NormalOS1829_g262990;
					#endif
					half3 Final_NormalOS1853_g262990 = staticSwitch1857_g262990;
					float3 In_NormalOS16_g263000 = Final_NormalOS1853_g262990;
					float4 In_TangentOS16_g263000 = Out_TangentOS15_g262999;
					float4 In_TransformData16_g263000 = Out_TransformData15_g262999;
					float4 In_RotationData16_g263000 = Out_RotationData15_g262999;
					float4 In_Interpolator16_g263000 = Out_Interpolator15_g262999;
					BuildVertexData( Data16_g263000 , In_Dummy16_g263000 , In_PositionOS16_g263000 , In_NormalOS16_g263000 , In_TangentOS16_g263000 , In_TransformData16_g263000 , In_RotationData16_g263000 , In_Interpolator16_g263000 );
					TVEVertexData Data15_g263010 =(TVEVertexData)Data16_g263000;
					float Out_Dummy15_g263010 = 0.0;
					float3 Out_PositionOS15_g263010 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263010 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263010 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263010 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263010 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263010 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g263010 , Out_Dummy15_g263010 , Out_PositionOS15_g263010 , Out_NormalOS15_g263010 , Out_TangentOS15_g263010 , Out_TransformData15_g263010 , Out_RotationData15_g263010 , Out_Interpolator15_g263010 );
					TVEVertexData Data16_g263011 =(TVEVertexData)Data15_g263010;
					half Dummy1575_g263002 = ( _ReshadeCategory + _ReshadeEnd + _ReshadeInfo );
					float In_Dummy16_g263011 = Dummy1575_g263002;
					float3 In_PositionOS16_g263011 = Out_PositionOS15_g263010;
					half3 Vertex_NormalOS1568_g263002 = Out_NormalOS15_g263010;
					half3 VertexPos40_g263004 = Vertex_NormalOS1568_g263002;
					half3 VertexPos40_g263005 = VertexPos40_g263004;
					float4 temp_output_1818_33_g263002 = Out_RotationData15_g263010;
					half4 Vertex_RotationData1583_g263002 = temp_output_1818_33_g263002;
					half2 Angle44_g263004 = Vertex_RotationData1583_g263002.xy;
					half Angle44_g263005 = (Angle44_g263004).y;
					half CosAngle89_g263005 = cos( Angle44_g263005 );
					half SinAngle93_g263005 = sin( Angle44_g263005 );
					float3 appendResult95_g263005 = (float3((VertexPos40_g263005).x , ( ( (VertexPos40_g263005).y * CosAngle89_g263005 ) - ( (VertexPos40_g263005).z * SinAngle93_g263005 ) ) , ( ( (VertexPos40_g263005).y * SinAngle93_g263005 ) + ( (VertexPos40_g263005).z * CosAngle89_g263005 ) )));
					half3 VertexPos40_g263006 = appendResult95_g263005;
					half Angle44_g263006 = -(Angle44_g263004).x;
					half CosAngle94_g263006 = cos( Angle44_g263006 );
					half SinAngle95_g263006 = sin( Angle44_g263006 );
					float3 appendResult98_g263006 = (float3(( ( (VertexPos40_g263006).x * CosAngle94_g263006 ) - ( (VertexPos40_g263006).y * SinAngle95_g263006 ) ) , ( ( (VertexPos40_g263006).x * SinAngle95_g263006 ) + ( (VertexPos40_g263006).y * CosAngle94_g263006 ) ) , (VertexPos40_g263006).z));
					float3 lerpResult1591_g263002 = lerp( Vertex_NormalOS1568_g263002 , appendResult98_g263006 , _ReshadeIntensityValue);
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g263003 = lerpResult1591_g263002;
					#else
					float3 staticSwitch65_g263003 = Vertex_NormalOS1568_g263002;
					#endif
					float3 temp_output_1732_0_g263002 = staticSwitch65_g263003;
					#ifdef TVE_RESHADE
					float3 staticSwitch1716_g263002 = temp_output_1732_0_g263002;
					#else
					float3 staticSwitch1716_g263002 = Vertex_NormalOS1568_g263002;
					#endif
					half3 Final_NormalOS178_g263002 = staticSwitch1716_g263002;
					float3 In_NormalOS16_g263011 = Final_NormalOS178_g263002;
					float4 In_TangentOS16_g263011 = Out_TangentOS15_g263010;
					float4 In_TransformData16_g263011 = Out_TransformData15_g263010;
					float4 In_RotationData16_g263011 = temp_output_1818_33_g263002;
					float4 In_Interpolator16_g263011 = Out_Interpolator15_g263010;
					BuildVertexData( Data16_g263011 , In_Dummy16_g263011 , In_PositionOS16_g263011 , In_NormalOS16_g263011 , In_TangentOS16_g263011 , In_TransformData16_g263011 , In_RotationData16_g263011 , In_Interpolator16_g263011 );
					TVEVertexData Data15_g263133 =(TVEVertexData)Data16_g263011;
					float Out_Dummy15_g263133 = 0.0;
					float3 Out_PositionOS15_g263133 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263133 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263133 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263133 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263133 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263133 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g263133 , Out_Dummy15_g263133 , Out_PositionOS15_g263133 , Out_NormalOS15_g263133 , Out_TangentOS15_g263133 , Out_TransformData15_g263133 , Out_RotationData15_g263133 , Out_Interpolator15_g263133 );
					TVEVertexData Data16_g263134 =(TVEVertexData)Data15_g263133;
					half Dummy1575_g263126 = ( _TransferCategory + _TransferEnd + _TransferInfo + _TransferSpace );
					float In_Dummy16_g263134 = Dummy1575_g263126;
					float3 In_PositionOS16_g263134 = Out_PositionOS15_g263133;
					half3 Vertex_NormalOS1568_g263126 = Out_NormalOS15_g263133;
					TVEGlobalData Data15_g263132 =(TVEGlobalData)Data15_g262925;
					float Out_Dummy15_g263132 = 0.0;
					float4 Out_CoatTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g263132 = float4( 0,0,0,0 );
					BreakData( Data15_g263132 , Out_Dummy15_g263132 , Out_CoatTexture15_g263132 , Out_DrawTexture15_g263132 , Out_PaintTexture15_g263132 , Out_AtmoTexture15_g263132 , Out_EffexTexture15_g263132 , Out_GlowTexture15_g263132 , Out_FormTexture15_g263132 , Out_LandTexture15_g263132 , Out_VertxTexture15_g263132 , Out_FlowTexture15_g263132 , Out_UserTexture15_g263132 );
					half4 Global_FormTexture1633_g263126 = Out_FormTexture15_g263132;
					float2 temp_output_1627_0_g263126 = ((Global_FormTexture1633_g263126).xy*2.0 + -1.0);
					float2 break1617_g263126 = temp_output_1627_0_g263126;
					float dotResult1619_g263126 = dot( temp_output_1627_0_g263126 , temp_output_1627_0_g263126 );
					float3 appendResult1618_g263126 = (float3(break1617_g263126.x , sqrt( ( 1.0 - saturate( dotResult1619_g263126 ) ) ) , break1617_g263126.y));
					float3 worldToObjDir1623_g263126 = mul( unity_WorldToObject, float4( appendResult1618_g263126, 0.0 ) ).xyz;
					half3 Surface_Normal1630_g263126 = worldToObjDir1623_g263126;
					float temp_output_17_0_g263137 = _TransferMeshMode;
					float Option70_g263137 = temp_output_17_0_g263137;
					TVEModelData Data15_g263127 =(TVEModelData)Data15_g263001;
					float Out_Dummy15_g263127 = 0.0;
					float3 Out_PositionOS15_g263127 = float3( 0,0,0 );
					float3 Out_PositionWS15_g263127 = float3( 0,0,0 );
					float3 Out_PositionWO15_g263127 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g263127 = float3( 0,0,0 );
					float3 Out_PivotOS15_g263127 = float3( 0,0,0 );
					float3 Out_PivotWS15_g263127 = float3( 0,0,0 );
					float3 Out_PivotWO15_g263127 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263127 = float3( 0,0,0 );
					float3 Out_NormalWS15_g263127 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g263127 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263127 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g263127 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g263127 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g263127 = float3( 0,0,0 );
					float4 Out_CoordsData15_g263127 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g263127 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g263127 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g263127 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263127 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263127 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263127 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g263127 , Out_Dummy15_g263127 , Out_PositionOS15_g263127 , Out_PositionWS15_g263127 , Out_PositionWO15_g263127 , Out_PositionRawOS15_g263127 , Out_PivotOS15_g263127 , Out_PivotWS15_g263127 , Out_PivotWO15_g263127 , Out_NormalOS15_g263127 , Out_NormalWS15_g263127 , Out_NormalRawOS15_g263127 , Out_TangentOS15_g263127 , Out_TangentWS15_g263127 , Out_BitangentWS15_g263127 , Out_ViewDirWS15_g263127 , Out_CoordsData15_g263127 , Out_VertexData15_g263127 , Out_MasksData15_g263127 , Out_PhaseData15_g263127 , Out_TransformData15_g263127 , Out_RotationData15_g263127 , Out_Interpolator15_g263127 );
					float4 temp_output_1567_29_g263126 = Out_VertexData15_g263127;
					half4 Model_VertexData1608_g263126 = temp_output_1567_29_g263126;
					float4 temp_output_3_0_g263137 = Model_VertexData1608_g263126;
					float4 Channel70_g263137 = temp_output_3_0_g263137;
					float localSwitchChannel470_g263137 = SwitchChannel4( Option70_g263137 , Channel70_g263137 );
					float temp_output_1870_0_g263126 = localSwitchChannel470_g263137;
					float temp_output_7_0_g263136 = _TransferMeshRemap.x;
					float temp_output_9_0_g263136 = ( temp_output_1870_0_g263126 - temp_output_7_0_g263136 );
					float lerpResult1868_g263126 = lerp( 1.0 , saturate( ( temp_output_9_0_g263136 * _TransferMeshRemap.z ) ) , _TransferMeshValue);
					half Blend_MeshMask1876_g263126 = lerpResult1868_g263126;
					half Blend_Mask1742_g263126 = ( _TransferIntensityValue * Blend_MeshMask1876_g263126 * TVE_IsEnabled );
					float3 lerpResult1670_g263126 = lerp( Vertex_NormalOS1568_g263126 , Surface_Normal1630_g263126 , Blend_Mask1742_g263126);
					#ifdef TVE_TRANSFER
					float3 staticSwitch1716_g263126 = lerpResult1670_g263126;
					#else
					float3 staticSwitch1716_g263126 = Vertex_NormalOS1568_g263126;
					#endif
					half3 Final_NormalOS178_g263126 = staticSwitch1716_g263126;
					float3 In_NormalOS16_g263134 = Final_NormalOS178_g263126;
					half4 Vertex_TangentOS1749_g263126 = Out_TangentOS15_g263133;
					float4 appendResult1746_g263126 = (float4(cross( worldToObjDir1623_g263126 , float3( 0, 0, 1 ) ) , -1.0));
					half4 Surface_Tangent1747_g263126 = appendResult1746_g263126;
					float4 lerpResult1757_g263126 = lerp( Vertex_TangentOS1749_g263126 , Surface_Tangent1747_g263126 , Blend_Mask1742_g263126);
					#ifdef TVE_TRANSFER
					float4 staticSwitch1760_g263126 = lerpResult1757_g263126;
					#else
					float4 staticSwitch1760_g263126 = Vertex_TangentOS1749_g263126;
					#endif
					half4 Final_TangentOS1762_g263126 = staticSwitch1760_g263126;
					float4 In_TangentOS16_g263134 = Final_TangentOS1762_g263126;
					float4 In_TransformData16_g263134 = Out_TransformData15_g263133;
					float4 In_RotationData16_g263134 = Out_RotationData15_g263133;
					float4 In_Interpolator16_g263134 = Out_Interpolator15_g263133;
					BuildVertexData( Data16_g263134 , In_Dummy16_g263134 , In_PositionOS16_g263134 , In_NormalOS16_g263134 , In_TangentOS16_g263134 , In_TransformData16_g263134 , In_RotationData16_g263134 , In_Interpolator16_g263134 );
					TVEVertexData Data15_g263142 =(TVEVertexData)Data16_g263134;
					float Out_Dummy15_g263142 = 0.0;
					float3 Out_PositionOS15_g263142 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263142 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263142 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263142 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263142 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263142 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g263142 , Out_Dummy15_g263142 , Out_PositionOS15_g263142 , Out_NormalOS15_g263142 , Out_TangentOS15_g263142 , Out_TransformData15_g263142 , Out_RotationData15_g263142 , Out_Interpolator15_g263142 );
					TVEVertexData Data16_g263143 =(TVEVertexData)Data15_g263142;
					float In_Dummy16_g263143 = 0.0;
					TVEModelData Data16_g263128 =(TVEModelData)Data15_g263127;
					float temp_output_14_0_g263128 = 0.0;
					float In_Dummy16_g263128 = temp_output_14_0_g263128;
					float3 temp_output_4_0_g263128 = Out_PositionOS15_g263127;
					float3 In_PositionOS16_g263128 = temp_output_4_0_g263128;
					float3 In_PositionWS16_g263128 = Out_PositionWS15_g263127;
					float3 temp_output_1567_17_g263126 = Out_PositionWO15_g263127;
					float3 In_PositionWO16_g263128 = temp_output_1567_17_g263126;
					float3 In_PivotOS16_g263128 = Out_PivotOS15_g263127;
					float3 In_PivotWS16_g263128 = Out_PivotWS15_g263127;
					float3 In_PivotWO16_g263128 = Out_PivotWO15_g263127;
					float3 temp_output_21_0_g263128 = Out_NormalOS15_g263127;
					float3 In_NormalOS16_g263128 = temp_output_21_0_g263128;
					float3 temp_output_1567_21_g263126 = Out_NormalWS15_g263127;
					float3 In_NormalWS16_g263128 = temp_output_1567_21_g263126;
					float4 temp_output_6_0_g263128 = Out_TangentOS15_g263127;
					float4 In_TangentOS16_g263128 = temp_output_6_0_g263128;
					float3 In_ViewDirWS16_g263128 = Out_ViewDirWS15_g263127;
					float4 In_CoordsData16_g263128 = Out_CoordsData15_g263127;
					float4 In_VertexData16_g263128 = temp_output_1567_29_g263126;
					float4 In_MasksData16_g263128 = Out_MasksData15_g263127;
					float4 In_PhaseData16_g263128 = Out_PhaseData15_g263127;
					BuildModelVertData( Data16_g263128 , In_Dummy16_g263128 , In_PositionOS16_g263128 , In_PositionWS16_g263128 , In_PositionWO16_g263128 , In_PivotOS16_g263128 , In_PivotWS16_g263128 , In_PivotWO16_g263128 , In_NormalOS16_g263128 , In_NormalWS16_g263128 , In_TangentOS16_g263128 , In_ViewDirWS16_g263128 , In_CoordsData16_g263128 , In_VertexData16_g263128 , In_MasksData16_g263128 , In_PhaseData16_g263128 );
					TVEModelData Data15_g263141 =(TVEModelData)Data16_g263128;
					float Out_Dummy15_g263141 = 0.0;
					float3 Out_PositionOS15_g263141 = float3( 0,0,0 );
					float3 Out_PositionWS15_g263141 = float3( 0,0,0 );
					float3 Out_PositionWO15_g263141 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g263141 = float3( 0,0,0 );
					float3 Out_PivotOS15_g263141 = float3( 0,0,0 );
					float3 Out_PivotWS15_g263141 = float3( 0,0,0 );
					float3 Out_PivotWO15_g263141 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263141 = float3( 0,0,0 );
					float3 Out_NormalWS15_g263141 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g263141 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263141 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g263141 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g263141 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g263141 = float3( 0,0,0 );
					float4 Out_CoordsData15_g263141 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g263141 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g263141 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g263141 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263141 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263141 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263141 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g263141 , Out_Dummy15_g263141 , Out_PositionOS15_g263141 , Out_PositionWS15_g263141 , Out_PositionWO15_g263141 , Out_PositionRawOS15_g263141 , Out_PivotOS15_g263141 , Out_PivotWS15_g263141 , Out_PivotWO15_g263141 , Out_NormalOS15_g263141 , Out_NormalWS15_g263141 , Out_NormalRawOS15_g263141 , Out_TangentOS15_g263141 , Out_TangentWS15_g263141 , Out_BitangentWS15_g263141 , Out_ViewDirWS15_g263141 , Out_CoordsData15_g263141 , Out_VertexData15_g263141 , Out_MasksData15_g263141 , Out_PhaseData15_g263141 , Out_TransformData15_g263141 , Out_RotationData15_g263141 , Out_Interpolator15_g263141 );
					float3 In_PositionOS16_g263143 = ( Out_PositionOS15_g263142 + Out_PivotOS15_g263141 );
					float3 In_NormalOS16_g263143 = Out_NormalOS15_g263142;
					float4 In_TangentOS16_g263143 = Out_TangentOS15_g263142;
					float4 In_TransformData16_g263143 = Out_TransformData15_g263142;
					float4 In_RotationData16_g263143 = Out_RotationData15_g263142;
					float4 In_Interpolator16_g263143 = Out_Interpolator15_g263142;
					BuildVertexData( Data16_g263143 , In_Dummy16_g263143 , In_PositionOS16_g263143 , In_NormalOS16_g263143 , In_TangentOS16_g263143 , In_TransformData16_g263143 , In_RotationData16_g263143 , In_Interpolator16_g263143 );
					TVEVertexData Data15_g263231 =(TVEVertexData)Data16_g263143;
					float Out_Dummy15_g263231 = 0.0;
					float3 Out_PositionOS15_g263231 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263231 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263231 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263231 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263231 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263231 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g263231 , Out_Dummy15_g263231 , Out_PositionOS15_g263231 , Out_NormalOS15_g263231 , Out_TangentOS15_g263231 , Out_TransformData15_g263231 , Out_RotationData15_g263231 , Out_Interpolator15_g263231 );
					
					float3 ifLocalVar40_g263163 = 0;
					if( TVE_DEBUG_Index == 0.0 )
					ifLocalVar40_g263163 = saturate( v.vertex.xyz );
					float3 ifLocalVar40_g263164 = 0;
					if( TVE_DEBUG_Index == 1.0 )
					ifLocalVar40_g263164 = saturate( v.normal );
					float3 ifLocalVar40_g263165 = 0;
					if( TVE_DEBUG_Index == 2.0 )
					ifLocalVar40_g263165 = saturate( v.tangent.xyz );
					TVEModelData Data15_g263145 =(TVEModelData)Data26_g263144;
					float Out_Dummy15_g263145 = 0.0;
					float3 Out_PositionOS15_g263145 = float3( 0,0,0 );
					float3 Out_PositionWS15_g263145 = float3( 0,0,0 );
					float3 Out_PositionWO15_g263145 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g263145 = float3( 0,0,0 );
					float3 Out_PivotOS15_g263145 = float3( 0,0,0 );
					float3 Out_PivotWS15_g263145 = float3( 0,0,0 );
					float3 Out_PivotWO15_g263145 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263145 = float3( 0,0,0 );
					float3 Out_NormalWS15_g263145 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g263145 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263145 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g263145 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g263145 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g263145 = float3( 0,0,0 );
					float4 Out_CoordsData15_g263145 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g263145 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g263145 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g263145 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263145 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263145 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263145 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g263145 , Out_Dummy15_g263145 , Out_PositionOS15_g263145 , Out_PositionWS15_g263145 , Out_PositionWO15_g263145 , Out_PositionRawOS15_g263145 , Out_PivotOS15_g263145 , Out_PivotWS15_g263145 , Out_PivotWO15_g263145 , Out_NormalOS15_g263145 , Out_NormalWS15_g263145 , Out_NormalRawOS15_g263145 , Out_TangentOS15_g263145 , Out_TangentWS15_g263145 , Out_BitangentWS15_g263145 , Out_ViewDirWS15_g263145 , Out_CoordsData15_g263145 , Out_VertexData15_g263145 , Out_MasksData15_g263145 , Out_PhaseData15_g263145 , Out_TransformData15_g263145 , Out_RotationData15_g263145 , Out_Interpolator15_g263145 );
					float3 ifLocalVar40_g263177 = 0;
					if( TVE_DEBUG_Index == 3.0 )
					ifLocalVar40_g263177 = saturate( Out_PivotOS15_g263145 );
					TVEVertexData Data15_g263146 =(TVEVertexData)Data16_g263143;
					float Out_Dummy15_g263146 = 0.0;
					float3 Out_PositionOS15_g263146 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263146 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263146 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263146 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263146 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263146 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g263146 , Out_Dummy15_g263146 , Out_PositionOS15_g263146 , Out_NormalOS15_g263146 , Out_TangentOS15_g263146 , Out_TransformData15_g263146 , Out_RotationData15_g263146 , Out_Interpolator15_g263146 );
					float3 ifLocalVar40_g263166 = 0;
					if( TVE_DEBUG_Index == 5.0 )
					ifLocalVar40_g263166 = saturate( Out_PositionOS15_g263146 );
					float3 ifLocalVar40_g263168 = 0;
					if( TVE_DEBUG_Index == 6.0 )
					ifLocalVar40_g263168 = saturate( Out_NormalOS15_g263146 );
					float3 ifLocalVar40_g263167 = 0;
					if( TVE_DEBUG_Index == 7.0 )
					ifLocalVar40_g263167 = (Out_TangentOS15_g263146).xyz;
					float4 temp_output_2671_29 = Out_VertexData15_g263145;
					float3 ifLocalVar40_g263169 = 0;
					if( TVE_DEBUG_Index == 9.0 )
					ifLocalVar40_g263169 = (temp_output_2671_29).xxx;
					float3 ifLocalVar40_g263170 = 0;
					if( TVE_DEBUG_Index == 10.0 )
					ifLocalVar40_g263170 = (temp_output_2671_29).yyy;
					float3 ifLocalVar40_g263171 = 0;
					if( TVE_DEBUG_Index == 11.0 )
					ifLocalVar40_g263171 = (temp_output_2671_29).zzz;
					float3 ifLocalVar40_g263172 = 0;
					if( TVE_DEBUG_Index == 12.0 )
					ifLocalVar40_g263172 = (temp_output_2671_29).www;
					float4 temp_output_2671_30 = Out_MasksData15_g263145;
					float3 ifLocalVar40_g263173 = 0;
					if( TVE_DEBUG_Index == 14.0 )
					ifLocalVar40_g263173 = (temp_output_2671_30).xxx;
					float3 ifLocalVar40_g263174 = 0;
					if( TVE_DEBUG_Index == 15.0 )
					ifLocalVar40_g263174 = (temp_output_2671_30).yyy;
					float4 temp_output_2671_38 = Out_CoordsData15_g263145;
					float3 appendResult2701 = (float3((temp_output_2671_38).xy , 0.0));
					float3 ifLocalVar40_g263178 = 0;
					if( TVE_DEBUG_Index == 17.0 )
					ifLocalVar40_g263178 = appendResult2701;
					float3 appendResult2702 = (float3((v.texcoord1.xyzw.xy).xy , 0.0));
					float3 ifLocalVar40_g263175 = 0;
					if( TVE_DEBUG_Index == 18.0 )
					ifLocalVar40_g263175 = appendResult2702;
					float3 appendResult2706 = (float3((temp_output_2671_38).xy , 0.0));
					float3 ifLocalVar40_g263176 = 0;
					if( TVE_DEBUG_Index == 19.0 )
					ifLocalVar40_g263176 = appendResult2706;
					float3 ifLocalVar40_g263147 = 0;
					if( TVE_DEBUG_Index == 21.0 )
					ifLocalVar40_g263147 = (v.texcoord.xyzw.x).xxx;
					float3 ifLocalVar40_g263148 = 0;
					if( TVE_DEBUG_Index == 22.0 )
					ifLocalVar40_g263148 = (v.texcoord.xyzw.y).xxx;
					float3 ifLocalVar40_g263149 = 0;
					if( TVE_DEBUG_Index == 23.0 )
					ifLocalVar40_g263149 = (v.texcoord.xyzw.z).xxx;
					float3 ifLocalVar40_g263150 = 0;
					if( TVE_DEBUG_Index == 24.0 )
					ifLocalVar40_g263150 = (v.texcoord.xyzw.w).xxx;
					float3 ifLocalVar40_g263151 = 0;
					if( TVE_DEBUG_Index == 26.0 )
					ifLocalVar40_g263151 = (v.texcoord1.xyzw.x).xxx;
					float3 ifLocalVar40_g263152 = 0;
					if( TVE_DEBUG_Index == 27.0 )
					ifLocalVar40_g263152 = (v.texcoord1.xyzw.y).xxx;
					float3 ifLocalVar40_g263153 = 0;
					if( TVE_DEBUG_Index == 28.0 )
					ifLocalVar40_g263153 = (v.texcoord1.xyzw.z).xxx;
					float3 ifLocalVar40_g263154 = 0;
					if( TVE_DEBUG_Index == 29.0 )
					ifLocalVar40_g263154 = (v.texcoord1.xyzw.w).xxx;
					float3 ifLocalVar40_g263155 = 0;
					if( TVE_DEBUG_Index == 31.0 )
					ifLocalVar40_g263155 = (v.texcoord2.xyzw.x).xxx;
					float3 ifLocalVar40_g263156 = 0;
					if( TVE_DEBUG_Index == 32.0 )
					ifLocalVar40_g263156 = (v.texcoord2.xyzw.y).xxx;
					float3 ifLocalVar40_g263157 = 0;
					if( TVE_DEBUG_Index == 33.0 )
					ifLocalVar40_g263157 = (v.texcoord2.xyzw.z).xxx;
					float3 ifLocalVar40_g263158 = 0;
					if( TVE_DEBUG_Index == 34.0 )
					ifLocalVar40_g263158 = (v.texcoord2.xyzw.w).xxx;
					float3 ifLocalVar40_g263159 = 0;
					if( TVE_DEBUG_Index == 36.0 )
					ifLocalVar40_g263159 = (v.ase_texcoord3.x).xxx;
					float3 ifLocalVar40_g263160 = 0;
					if( TVE_DEBUG_Index == 37.0 )
					ifLocalVar40_g263160 = (v.ase_texcoord3.y).xxx;
					float3 ifLocalVar40_g263161 = 0;
					if( TVE_DEBUG_Index == 38.0 )
					ifLocalVar40_g263161 = (v.ase_texcoord3.z).xxx;
					float3 ifLocalVar40_g263162 = 0;
					if( TVE_DEBUG_Index == 39.0 )
					ifLocalVar40_g263162 = (v.ase_texcoord3.w).xxx;
					float3 vertexToFrag2524 = ( ( ifLocalVar40_g263163 + ifLocalVar40_g263164 + ifLocalVar40_g263165 + ifLocalVar40_g263177 ) + ( ifLocalVar40_g263166 + ifLocalVar40_g263168 + ifLocalVar40_g263167 ) + ( ifLocalVar40_g263169 + ifLocalVar40_g263170 + ifLocalVar40_g263171 + ifLocalVar40_g263172 ) + ( ifLocalVar40_g263173 + ifLocalVar40_g263174 ) + ( ifLocalVar40_g263178 + ifLocalVar40_g263175 + ifLocalVar40_g263176 ) + ( ( ifLocalVar40_g263147 + ifLocalVar40_g263148 + ifLocalVar40_g263149 + ifLocalVar40_g263150 ) + ( ifLocalVar40_g263151 + ifLocalVar40_g263152 + ifLocalVar40_g263153 + ifLocalVar40_g263154 ) + ( ifLocalVar40_g263155 + ifLocalVar40_g263156 + ifLocalVar40_g263157 + ifLocalVar40_g263158 ) + ( ifLocalVar40_g263159 + ifLocalVar40_g263160 + ifLocalVar40_g263161 + ifLocalVar40_g263162 ) ) );
					o.ase_texcoord4.xyz = vertexToFrag2524;
					float3 vertexPos57_g263223 = v.vertex.xyz;
					float4 ase_positionCS57_g263223 = UnityObjectToClipPos( vertexPos57_g263223 );
					o.ase_texcoord5 = ase_positionCS57_g263223;
					o.ase_texcoord9.xyz = vertexToFrag73_g263032;
					o.ase_texcoord10.xyz = vertexToFrag76_g263032;
					TVEVertexData Data1902_g263179 = Data16_g263143;
					float4 Out_Interpolator1902_g263179 = float4( 0,0,0,0 );
					{
					Out_Interpolator1902_g263179 = Data1902_g263179.Interpolator;
					}
					float4 vertexToFrag1901_g263179 = Out_Interpolator1902_g263179;
					o.ase_texcoord11 = vertexToFrag1901_g263179;
					
					o.ase_texcoord6 = v.vertex;
					o.ase_normal = v.normal;
					o.ase_texcoord7 = v.texcoord.xyzw;
					o.ase_texcoord8 = v.texcoord2.xyzw;
					o.ase_color = v.ase_color;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord4.w = 0;
					o.ase_texcoord9.w = 0;
					o.ase_texcoord10.w = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g263231;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g263231;
					v.tangent = Out_TangentOS15_g263231;

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

					float temp_output_2720_114 = 0.0;
					float3 temp_cast_0 = (temp_output_2720_114).xxx;
					
					float3 temp_cast_1 = (temp_output_2720_114).xxx;
					
					float3 color130_g263223 = IsGammaSpace() ? float3( 0.15, 0.15, 0.15 ) : float3( 0.01960665, 0.01960665, 0.01960665 );
					float3 color81_g263223 = IsGammaSpace() ? float3( 0.2, 0.2, 0.2 ) : float3( 0.03310476, 0.03310476, 0.03310476 );
					float2 temp_cast_4 = (60.0).xx;
					float2 appendResult128_g263225 = (float2(ScreenPosNorm.x , ( ( _ScreenParams.y / _ScreenParams.x ) * ScreenPosNorm.y )));
					float2 FinalUV13_g263224 = ( temp_cast_4 * ( 0.5 + appendResult128_g263225 ) );
					float2 temp_cast_5 = (0.5).xx;
					float2 temp_cast_6 = (1.0).xx;
					float4 appendResult16_g263224 = (float4(ddx( FinalUV13_g263224 ) , ddy( FinalUV13_g263224 )));
					float4 UVDerivatives17_g263224 = appendResult16_g263224;
					float4 break28_g263224 = UVDerivatives17_g263224;
					float2 appendResult19_g263224 = (float2(break28_g263224.x , break28_g263224.z));
					float2 appendResult20_g263224 = (float2(break28_g263224.x , break28_g263224.z));
					float dotResult24_g263224 = dot( appendResult19_g263224 , appendResult20_g263224 );
					float2 appendResult21_g263224 = (float2(break28_g263224.y , break28_g263224.w));
					float2 appendResult22_g263224 = (float2(break28_g263224.y , break28_g263224.w));
					float dotResult23_g263224 = dot( appendResult21_g263224 , appendResult22_g263224 );
					float2 appendResult25_g263224 = (float2(dotResult24_g263224 , dotResult23_g263224));
					float2 derivativesLength29_g263224 = sqrt( appendResult25_g263224 );
					float2 temp_cast_7 = (-1.0).xx;
					float2 temp_cast_8 = (1.0).xx;
					float2 clampResult57_g263224 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g263224 + 0.25 ) ) - temp_cast_5 ) ) * 4.0 ) - temp_cast_6 ) * ( 0.35 / derivativesLength29_g263224 ) ) , temp_cast_7 , temp_cast_8 );
					float2 break71_g263224 = clampResult57_g263224;
					float2 break55_g263224 = derivativesLength29_g263224;
					float4 lerpResult73_g263224 = lerp( float4( color130_g263223 , 0.0 ) , float4( color81_g263223 , 0.0 ) , saturate( ( 0.5 + ( 0.5 * break71_g263224.x * break71_g263224.y * sqrt( saturate( ( 1.1 - max( break55_g263224.x, break55_g263224.y ) ) ) ) ) ) ));
					float3 vertexToFrag2524 = IN.ase_texcoord4.xyz;
					half3 Final_Debug2399 = vertexToFrag2524;
					float temp_output_7_0_g263230 = TVE_DEBUG_Min;
					float3 temp_cast_9 = (temp_output_7_0_g263230).xxx;
					float3 temp_output_9_0_g263230 = ( Final_Debug2399 - temp_cast_9 );
					float lerpResult76_g263223 = lerp( 1.0 , _IsTVEShader , TVE_DEBUG_Filter);
					float Filter152_g263223 = lerpResult76_g263223;
					float3 lerpResult72_g263223 = lerp( (lerpResult73_g263224).rgb , saturate( ( temp_output_9_0_g263230 / ( ( TVE_DEBUG_Max - temp_output_7_0_g263230 ) + 0.0001 ) ) ) , Filter152_g263223);
					float dotResult61_g263223 = dot( NormalWS , ViewDirWS );
					float temp_output_65_0_g263223 = ( 1.0 - saturate( dotResult61_g263223 ) );
					float Shading_Fresnel59_g263223 = (( 1.0 - ( temp_output_65_0_g263223 * temp_output_65_0_g263223 ) )*0.3 + 0.7);
					float4 ase_positionCS57_g263223 = IN.ase_texcoord5;
					float depthLinearEye57_g263223 = LinearEyeDepth( ase_positionCS57_g263223.z / ase_positionCS57_g263223.w );
					float temp_output_69_0_g263223 = saturate(  (0.0 + ( depthLinearEye57_g263223 - 300.0 ) * ( 1.0 - 0.0 ) / ( 0.0 - 300.0 ) ) );
					float Shading_Distance58_g263223 = (( temp_output_69_0_g263223 * temp_output_69_0_g263223 )*0.5 + 0.5);
					float lerpResult84_g263223 = lerp( 1.0 , Shading_Fresnel59_g263223 , ( Shading_Distance58_g263223 * TVE_DEBUG_Shading ));
					float localBreakVisualData4_g263228 = ( 0.0 );
					float localBuildVisualData3_g263185 = ( 0.0 );
					float localBuildVisualData3_g263180 = ( 0.0 );
					TVEVisualData Data3_g263180 =(TVEVisualData)0;
					float temp_output_14_0_g263180 = 0.0;
					float In_Dummy3_g263180 = temp_output_14_0_g263180;
					float3 temp_cast_10 = (0.5).xxx;
					float3 temp_output_4_0_g263180 = temp_cast_10;
					float3 In_Albedo3_g263180 = temp_output_4_0_g263180;
					float3 temp_cast_11 = (0.5).xxx;
					float3 temp_output_44_0_g263180 = temp_cast_11;
					float3 In_AlbedoBase3_g263180 = temp_output_44_0_g263180;
					float2 temp_cast_12 = (0.0).xx;
					float2 In_NormalTS3_g263180 = temp_cast_12;
					float3 temp_cast_13 = (0.5).xxx;
					float3 In_NormalWS3_g263180 = temp_cast_13;
					float4 In_Shader3_g263180 = half4( 0, 1, 0, 1 );
					float4 In_Feature3_g263180 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g263180 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g263180 = half4( 1, 1, 1, 1 );
					float temp_output_12_0_g263180 = 0.5;
					float In_Grayscale3_g263180 = temp_output_12_0_g263180;
					float temp_output_16_0_g263180 = 1.0;
					float In_Luminosity3_g263180 = temp_output_16_0_g263180;
					float In_MultiMask3_g263180 = 1.0;
					float In_AlphaClip3_g263180 = 1.0;
					float In_AlphaFade3_g263180 = 1.0;
					float3 temp_cast_14 = (1.0).xxx;
					float3 In_Translucency3_g263180 = temp_cast_14;
					float In_Transmission3_g263180 = 1.0;
					float In_Thickness3_g263180 = 0.0;
					float In_Diffusion3_g263180 = 0.0;
					float In_Depth3_g263180 = 0.0;
					BuildVisualData( Data3_g263180 , In_Dummy3_g263180 , In_Albedo3_g263180 , In_AlbedoBase3_g263180 , In_NormalTS3_g263180 , In_NormalWS3_g263180 , In_Shader3_g263180 , In_Feature3_g263180 , In_Season3_g263180 , In_Emissive3_g263180 , In_Grayscale3_g263180 , In_Luminosity3_g263180 , In_MultiMask3_g263180 , In_AlphaClip3_g263180 , In_AlphaFade3_g263180 , In_Translucency3_g263180 , In_Transmission3_g263180 , In_Thickness3_g263180 , In_Diffusion3_g263180 , In_Depth3_g263180 );
					TVEVisualData Data3_g263185 =(TVEVisualData)Data3_g263180;
					half Dummy130_g263183 = ( _MainCategory + _MainEnd );
					float temp_output_14_0_g263185 = Dummy130_g263183;
					float In_Dummy3_g263185 = temp_output_14_0_g263185;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g263206) = _MainAlbedoTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch36_g263188 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch36_g263188 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch36_g263188 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch36_g263188 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch36_g263188 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch36_g263188 = sampler_Linear_Repeat_Aniso8;
					#endif
					SamplerState Sampler276_g263206 = staticSwitch36_g263188;
					float localBreakTextureData456_g263206 = ( 0.0 );
					float localBuildTextureData431_g263205 = ( 0.0 );
					TVEMasksData Data431_g263205 =(TVEMasksData)(TVEMasksData)0;
					float localComputeMeshCoords444_g263205 = ( 0.0 );
					float4 temp_output_6_0_g263221 = _main_coord_value;
					float4 temp_output_7_0_g263221 = ( _MainSampleMode + _MainCoordMode + _MainCoordValue );
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g263221 = ( temp_output_6_0_g263221 + temp_output_7_0_g263221 );
					#else
					float4 staticSwitch14_g263221 = temp_output_6_0_g263221;
					#endif
					half4 Local_Coords180_g263183 = staticSwitch14_g263221;
					float4 Coords444_g263205 = Local_Coords180_g263183;
					float localIfModelDataByShader26_g262420 = ( 0.0 );
					TVEModelData Data26_g262420 = (TVEModelData)0;
					TVEModelData Data16_g263030 =(TVEModelData)0;
					half Dummy207_g263012 = 0.0;
					float temp_output_14_0_g263030 = Dummy207_g263012;
					float In_Dummy16_g263030 = temp_output_14_0_g263030;
					float3 PositionOS131_g263012 = IN.ase_texcoord6.xyz;
					float3 temp_output_4_0_g263030 = PositionOS131_g263012;
					float3 In_PositionOS16_g263030 = temp_output_4_0_g263030;
					float3 temp_output_104_7_g263012 = PositionWS;
					float3 PositionWS122_g263012 = temp_output_104_7_g263012;
					float3 In_PositionWS16_g263030 = PositionWS122_g263012;
					float4x4 break19_g263015 = unity_ObjectToWorld;
					float3 appendResult20_g263015 = (float3(break19_g263015[ 0 ][ 3 ] , break19_g263015[ 1 ][ 3 ] , break19_g263015[ 2 ][ 3 ]));
					float3 temp_output_340_7_g263012 = appendResult20_g263015;
					float3 PivotWS121_g263012 = temp_output_340_7_g263012;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g263012 = ( PositionWS122_g263012 - PivotWS121_g263012 );
					#else
					float3 staticSwitch204_g263012 = PositionWS122_g263012;
					#endif
					float3 PositionWO132_g263012 = ( staticSwitch204_g263012 - TVE_WorldOrigin );
					float3 In_PositionWO16_g263030 = PositionWO132_g263012;
					float3 _Vector0 = float3(0,0,0);
					float3 PivotOS149_g263012 = _Vector0;
					float3 In_PivotOS16_g263030 = PivotOS149_g263012;
					float3 In_PivotWS16_g263030 = PivotWS121_g263012;
					float3 PivotWO133_g263012 = ( PivotWS121_g263012 - TVE_WorldOrigin );
					float3 In_PivotWO16_g263030 = PivotWO133_g263012;
					half3 NormalOS134_g263012 = IN.ase_normal;
					float3 temp_output_21_0_g263030 = NormalOS134_g263012;
					float3 In_NormalOS16_g263030 = temp_output_21_0_g263030;
					float3 normalizedWorldNormal = normalize( NormalWS );
					half3 NormalWS95_g263012 = normalizedWorldNormal;
					float3 In_NormalWS16_g263030 = NormalWS95_g263012;
					float4 appendResult462_g263012 = (float4(cross( IN.ase_normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g263012 = appendResult462_g263012;
					float4 temp_output_6_0_g263030 = TangentlOS153_g263012;
					float4 In_TangentOS16_g263030 = temp_output_6_0_g263030;
					float3 normalizeResult296_g263012 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g263012 ) );
					half3 ViewDirWS169_g263012 = normalizeResult296_g263012;
					float3 In_ViewDirWS16_g263030 = ViewDirWS169_g263012;
					float4 appendResult397_g263012 = (float4(IN.ase_texcoord7.xy , IN.ase_texcoord8.xy));
					float4 CoordsData398_g263012 = appendResult397_g263012;
					float4 In_CoordsData16_g263030 = CoordsData398_g263012;
					half4 VertexMasks171_g263012 = float4( 0,0,0,0 );
					float4 In_VertexData16_g263030 = VertexMasks171_g263012;
					half4 MasksData254_g263012 = float4( 0,0,0,0 );
					float4 In_MasksData16_g263030 = MasksData254_g263012;
					half4 Phase_Data176_g263012 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g263030 = Phase_Data176_g263012;
					BuildModelVertData( Data16_g263030 , In_Dummy16_g263030 , In_PositionOS16_g263030 , In_PositionWS16_g263030 , In_PositionWO16_g263030 , In_PivotOS16_g263030 , In_PivotWS16_g263030 , In_PivotWO16_g263030 , In_NormalOS16_g263030 , In_NormalWS16_g263030 , In_TangentOS16_g263030 , In_ViewDirWS16_g263030 , In_CoordsData16_g263030 , In_VertexData16_g263030 , In_MasksData16_g263030 , In_PhaseData16_g263030 );
					TVEModelData DataDefault26_g262420 = Data16_g263030;
					TVEModelData Data16_g263040 =(TVEModelData)0;
					float In_Dummy16_g263040 = 0.0;
					float3 vertexToFrag73_g263032 = IN.ase_texcoord9.xyz;
					float3 PositionWS122_g263032 = vertexToFrag73_g263032;
					float3 In_PositionWS16_g263040 = PositionWS122_g263032;
					float3 vertexToFrag76_g263032 = IN.ase_texcoord10.xyz;
					float3 PivotWS121_g263032 = vertexToFrag76_g263032;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g263032 = ( PositionWS122_g263032 - PivotWS121_g263032 );
					#else
					float3 staticSwitch204_g263032 = PositionWS122_g263032;
					#endif
					float3 PositionWO132_g263032 = ( staticSwitch204_g263032 - TVE_WorldOrigin );
					float3 In_PositionWO16_g263040 = PositionWO132_g263032;
					float3 In_PivotWS16_g263040 = PivotWS121_g263032;
					float3 PivotWO133_g263032 = ( PivotWS121_g263032 - TVE_WorldOrigin );
					float3 In_PivotWO16_g263040 = PivotWO133_g263032;
					half3 NormalWS95_g263032 = normalizedWorldNormal;
					float3 In_NormalWS16_g263040 = NormalWS95_g263032;
					half3 TangentWS136_g263032 = TangentWS;
					float3 In_TangentWS16_g263040 = TangentWS136_g263032;
					half3 BiangentWS421_g263032 = BitangentWS;
					float3 In_BitangentWS16_g263040 = BiangentWS421_g263032;
					half3 NormalWS427_g263032 = NormalWS95_g263032;
					half3 localComputeTriplanarMasks427_g263032 = ComputeTriplanarMasks( NormalWS427_g263032 );
					half3 TriplanarWeights429_g263032 = localComputeTriplanarMasks427_g263032;
					float3 In_TriplanarWeights16_g263040 = TriplanarWeights429_g263032;
					float3 normalizeResult296_g263032 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g263032 ) );
					half3 ViewDirWS169_g263032 = normalizeResult296_g263032;
					float3 In_ViewDirWS16_g263040 = ViewDirWS169_g263032;
					float4 appendResult397_g263032 = (float4(IN.ase_texcoord7.xy , IN.ase_texcoord8.xy));
					float4 CoordsData398_g263032 = appendResult397_g263032;
					float4 In_CoordsData16_g263040 = CoordsData398_g263032;
					half4 VertexMasks171_g263032 = IN.ase_color;
					float4 In_VertexData16_g263040 = VertexMasks171_g263032;
					float temp_output_17_0_g263043 = _ObjectPhaseMode;
					float Option70_g263043 = temp_output_17_0_g263043;
					float4 temp_output_3_0_g263043 = IN.ase_color;
					float4 Channel70_g263043 = temp_output_3_0_g263043;
					float localSwitchChannel470_g263043 = SwitchChannel4( Option70_g263043 , Channel70_g263043 );
					half Phase_Value372_g263032 = localSwitchChannel470_g263043;
					float3 break319_g263032 = PivotWO133_g263032;
					half Pivot_Position322_g263032 = ( break319_g263032.x + break319_g263032.z );
					half Phase_Position357_g263032 = ( Phase_Value372_g263032 + Pivot_Position322_g263032 );
					float temp_output_248_0_g263032 = frac( Phase_Position357_g263032 );
					float4 appendResult177_g263032 = (float4((frac( ( Phase_Position357_g263032 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g263032));
					half4 Phase_Data176_g263032 = appendResult177_g263032;
					float4 In_Interpolator16_g263040 = Phase_Data176_g263032;
					BuildModelFragData( Data16_g263040 , In_Dummy16_g263040 , In_PositionWS16_g263040 , In_PositionWO16_g263040 , In_PivotWS16_g263040 , In_PivotWO16_g263040 , In_NormalWS16_g263040 , In_TangentWS16_g263040 , In_BitangentWS16_g263040 , In_TriplanarWeights16_g263040 , In_ViewDirWS16_g263040 , In_CoordsData16_g263040 , In_VertexData16_g263040 , In_Interpolator16_g263040 );
					TVEModelData DataGeneral26_g262420 = Data16_g263040;
					TVEModelData DataBlanket26_g262420 = Data16_g263040;
					TVEModelData DataImpostor26_g262420 = Data16_g263040;
					TVEModelData Data16_g263020 =(TVEModelData)0;
					float In_Dummy16_g263020 = 0.0;
					float3 In_PositionWS16_g263020 = PositionWS122_g263012;
					float3 In_PositionWO16_g263020 = PositionWO132_g263012;
					float3 In_PivotWS16_g263020 = PivotWS121_g263012;
					float3 In_PivotWO16_g263020 = PivotWO133_g263012;
					float3 In_NormalWS16_g263020 = NormalWS95_g263012;
					half3 TangentWS136_g263012 = TangentWS;
					float3 In_TangentWS16_g263020 = TangentWS136_g263012;
					half3 BiangentWS421_g263012 = BitangentWS;
					float3 In_BitangentWS16_g263020 = BiangentWS421_g263012;
					half3 NormalWS427_g263012 = NormalWS95_g263012;
					half3 localComputeTriplanarMasks427_g263012 = ComputeTriplanarMasks( NormalWS427_g263012 );
					half3 TriplanarWeights429_g263012 = localComputeTriplanarMasks427_g263012;
					float3 In_TriplanarWeights16_g263020 = TriplanarWeights429_g263012;
					float3 In_ViewDirWS16_g263020 = ViewDirWS169_g263012;
					float4 In_CoordsData16_g263020 = CoordsData398_g263012;
					float4 In_VertexData16_g263020 = VertexMasks171_g263012;
					float4 In_Interpolator16_g263020 = Phase_Data176_g263012;
					BuildModelFragData( Data16_g263020 , In_Dummy16_g263020 , In_PositionWS16_g263020 , In_PositionWO16_g263020 , In_PivotWS16_g263020 , In_PivotWO16_g263020 , In_NormalWS16_g263020 , In_TangentWS16_g263020 , In_BitangentWS16_g263020 , In_TriplanarWeights16_g263020 , In_ViewDirWS16_g263020 , In_CoordsData16_g263020 , In_VertexData16_g263020 , In_Interpolator16_g263020 );
					TVEModelData DataTerrain26_g262420 = Data16_g263020;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g262420 = IsShaderType2637;
					{
					if (Type26_g262420 == 0 )
					{
					Data26_g262420 = DataDefault26_g262420;
					}
					else if (Type26_g262420 == 1 )
					{
					Data26_g262420 = DataGeneral26_g262420;
					}
					else if (Type26_g262420 == 2 )
					{
					Data26_g262420 = DataBlanket26_g262420;
					}
					else if (Type26_g262420 == 3 )
					{
					Data26_g262420 = DataImpostor26_g262420;
					}
					else if (Type26_g262420 == 4 )
					{
					Data26_g262420 = DataTerrain26_g262420;
					}
					}
					TVEModelData Data15_g263181 =(TVEModelData)Data26_g262420;
					float Out_Dummy15_g263181 = 0.0;
					float3 Out_PositionWS15_g263181 = float3( 0,0,0 );
					float3 Out_PositionWO15_g263181 = float3( 0,0,0 );
					float3 Out_PivotWS15_g263181 = float3( 0,0,0 );
					float3 Out_PivotWO15_g263181 = float3( 0,0,0 );
					float3 Out_NormalWS15_g263181 = float3( 0,0,0 );
					float3 Out_TangentWS15_g263181 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g263181 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g263181 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g263181 = float3( 0,0,0 );
					float4 Out_CoordsData15_g263181 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g263181 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263181 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g263181 , Out_Dummy15_g263181 , Out_PositionWS15_g263181 , Out_PositionWO15_g263181 , Out_PivotWS15_g263181 , Out_PivotWO15_g263181 , Out_NormalWS15_g263181 , Out_TangentWS15_g263181 , Out_BitangentWS15_g263181 , Out_TriplanarWeights15_g263181 , Out_ViewDirWS15_g263181 , Out_CoordsData15_g263181 , Out_VertexData15_g263181 , Out_Interpolator15_g263181 );
					TVEModelData Data16_g263182 =(TVEModelData)Data15_g263181;
					float In_Dummy16_g263182 = Out_Dummy15_g263181;
					float3 In_PositionWS16_g263182 = Out_PositionWS15_g263181;
					float3 In_PositionWO16_g263182 = Out_PositionWO15_g263181;
					float3 In_PivotWS16_g263182 = Out_PivotWS15_g263181;
					float3 In_PivotWO16_g263182 = Out_PivotWO15_g263181;
					float3 In_NormalWS16_g263182 = Out_NormalWS15_g263181;
					float3 In_TangentWS16_g263182 = Out_TangentWS15_g263181;
					float3 In_BitangentWS16_g263182 = Out_BitangentWS15_g263181;
					float3 In_TriplanarWeights16_g263182 = Out_TriplanarWeights15_g263181;
					float3 In_ViewDirWS16_g263182 = Out_ViewDirWS15_g263181;
					float4 In_CoordsData16_g263182 = Out_CoordsData15_g263181;
					float4 In_VertexData16_g263182 = Out_VertexData15_g263181;
					float4 vertexToFrag1901_g263179 = IN.ase_texcoord11;
					float4 In_Interpolator16_g263182 = vertexToFrag1901_g263179;
					BuildModelFragData( Data16_g263182 , In_Dummy16_g263182 , In_PositionWS16_g263182 , In_PositionWO16_g263182 , In_PivotWS16_g263182 , In_PivotWO16_g263182 , In_NormalWS16_g263182 , In_TangentWS16_g263182 , In_BitangentWS16_g263182 , In_TriplanarWeights16_g263182 , In_ViewDirWS16_g263182 , In_CoordsData16_g263182 , In_VertexData16_g263182 , In_Interpolator16_g263182 );
					TVEModelData Data15_g263184 =(TVEModelData)Data16_g263182;
					float Out_Dummy15_g263184 = 0.0;
					float3 Out_PositionWS15_g263184 = float3( 0,0,0 );
					float3 Out_PositionWO15_g263184 = float3( 0,0,0 );
					float3 Out_PivotWS15_g263184 = float3( 0,0,0 );
					float3 Out_PivotWO15_g263184 = float3( 0,0,0 );
					float3 Out_NormalWS15_g263184 = float3( 0,0,0 );
					float3 Out_TangentWS15_g263184 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g263184 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g263184 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g263184 = float3( 0,0,0 );
					float4 Out_CoordsData15_g263184 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g263184 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263184 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g263184 , Out_Dummy15_g263184 , Out_PositionWS15_g263184 , Out_PositionWO15_g263184 , Out_PivotWS15_g263184 , Out_PivotWO15_g263184 , Out_NormalWS15_g263184 , Out_TangentWS15_g263184 , Out_BitangentWS15_g263184 , Out_TriplanarWeights15_g263184 , Out_ViewDirWS15_g263184 , Out_CoordsData15_g263184 , Out_VertexData15_g263184 , Out_Interpolator15_g263184 );
					float4 Model_CoordsData324_g263183 = Out_CoordsData15_g263184;
					float4 MeshCoords444_g263205 = Model_CoordsData324_g263183;
					float2 UV0444_g263205 = float2( 0,0 );
					float2 UV3444_g263205 = float2( 0,0 );
					ComputeMeshCoords( Coords444_g263205 , MeshCoords444_g263205 , UV0444_g263205 , UV3444_g263205 );
					float4 appendResult430_g263205 = (float4(UV0444_g263205 , UV3444_g263205));
					float4 In_MaskA431_g263205 = appendResult430_g263205;
					float localComputeWorldCoords315_g263205 = ( 0.0 );
					float4 Coords315_g263205 = Local_Coords180_g263183;
					float3 Model_PositionWO222_g263183 = Out_PositionWO15_g263184;
					float3 PositionWS315_g263205 = Model_PositionWO222_g263183;
					float2 ZY315_g263205 = float2( 0,0 );
					float2 XZ315_g263205 = float2( 0,0 );
					float2 XY315_g263205 = float2( 0,0 );
					ComputeWorldCoords( Coords315_g263205 , PositionWS315_g263205 , ZY315_g263205 , XZ315_g263205 , XY315_g263205 );
					float2 ZY402_g263205 = ZY315_g263205;
					float2 XZ403_g263205 = XZ315_g263205;
					float4 appendResult432_g263205 = (float4(ZY402_g263205 , XZ403_g263205));
					float4 In_MaskB431_g263205 = appendResult432_g263205;
					float2 XY404_g263205 = XY315_g263205;
					float localComputeStochasticCoords409_g263205 = ( 0.0 );
					float2 UV409_g263205 = ZY402_g263205;
					float2 UV1409_g263205 = float2( 0,0 );
					float2 UV2409_g263205 = float2( 0,0 );
					float2 UV3409_g263205 = float2( 0,0 );
					float3 Weights409_g263205 = float3( 0,0,0 );
					ComputeStochasticCoords( UV409_g263205 , UV1409_g263205 , UV2409_g263205 , UV3409_g263205 , Weights409_g263205 );
					float4 appendResult433_g263205 = (float4(XY404_g263205 , UV1409_g263205));
					float4 In_MaskC431_g263205 = appendResult433_g263205;
					float4 appendResult434_g263205 = (float4(UV2409_g263205 , UV3409_g263205));
					float4 In_MaskD431_g263205 = appendResult434_g263205;
					float localComputeStochasticCoords422_g263205 = ( 0.0 );
					float2 UV422_g263205 = XZ403_g263205;
					float2 UV1422_g263205 = float2( 0,0 );
					float2 UV2422_g263205 = float2( 0,0 );
					float2 UV3422_g263205 = float2( 0,0 );
					float3 Weights422_g263205 = float3( 0,0,0 );
					ComputeStochasticCoords( UV422_g263205 , UV1422_g263205 , UV2422_g263205 , UV3422_g263205 , Weights422_g263205 );
					float4 appendResult435_g263205 = (float4(UV1422_g263205 , UV2422_g263205));
					float4 In_MaskE431_g263205 = appendResult435_g263205;
					float localComputeStochasticCoords423_g263205 = ( 0.0 );
					float2 UV423_g263205 = XY404_g263205;
					float2 UV1423_g263205 = float2( 0,0 );
					float2 UV2423_g263205 = float2( 0,0 );
					float2 UV3423_g263205 = float2( 0,0 );
					float3 Weights423_g263205 = float3( 0,0,0 );
					ComputeStochasticCoords( UV423_g263205 , UV1423_g263205 , UV2423_g263205 , UV3423_g263205 , Weights423_g263205 );
					float4 appendResult436_g263205 = (float4(UV3422_g263205 , UV1423_g263205));
					float4 In_MaskF431_g263205 = appendResult436_g263205;
					float4 appendResult437_g263205 = (float4(UV2423_g263205 , UV3423_g263205));
					float4 In_MaskG431_g263205 = appendResult437_g263205;
					float4 In_MaskH431_g263205 = float4( Weights409_g263205 , 0.0 );
					float4 In_MaskI431_g263205 = float4( Weights422_g263205 , 0.0 );
					float4 In_MaskJ431_g263205 = float4( Weights423_g263205 , 0.0 );
					half3 Model_NormalWS226_g263183 = Out_NormalWS15_g263184;
					float3 temp_output_449_0_g263205 = Model_NormalWS226_g263183;
					float4 In_MaskK431_g263205 = float4( temp_output_449_0_g263205 , 0.0 );
					half3 Model_TangentWS366_g263183 = Out_TangentWS15_g263184;
					float3 temp_output_450_0_g263205 = Model_TangentWS366_g263183;
					float4 In_MaskL431_g263205 = float4( temp_output_450_0_g263205 , 0.0 );
					half3 Model_BitangentWS367_g263183 = Out_BitangentWS15_g263184;
					float3 temp_output_451_0_g263205 = Model_BitangentWS367_g263183;
					float4 In_MaskM431_g263205 = float4( temp_output_451_0_g263205 , 0.0 );
					half3 Model_TriplanarWeights368_g263183 = Out_TriplanarWeights15_g263184;
					float3 temp_output_445_0_g263205 = Model_TriplanarWeights368_g263183;
					float4 In_MaskN431_g263205 = float4( temp_output_445_0_g263205 , 0.0 );
					BuildTextureData( Data431_g263205 , In_MaskA431_g263205 , In_MaskB431_g263205 , In_MaskC431_g263205 , In_MaskD431_g263205 , In_MaskE431_g263205 , In_MaskF431_g263205 , In_MaskG431_g263205 , In_MaskH431_g263205 , In_MaskI431_g263205 , In_MaskJ431_g263205 , In_MaskK431_g263205 , In_MaskL431_g263205 , In_MaskM431_g263205 , In_MaskN431_g263205 );
					TVEMasksData Data456_g263206 =(TVEMasksData)Data431_g263205;
					float4 Out_MaskA456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g263206 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g263206 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g263206 , Out_MaskA456_g263206 , Out_MaskB456_g263206 , Out_MaskC456_g263206 , Out_MaskD456_g263206 , Out_MaskE456_g263206 , Out_MaskF456_g263206 , Out_MaskG456_g263206 , Out_MaskH456_g263206 , Out_MaskI456_g263206 , Out_MaskJ456_g263206 , Out_MaskK456_g263206 , Out_MaskL456_g263206 , Out_MaskM456_g263206 , Out_MaskN456_g263206 );
					half2 UV276_g263206 = (Out_MaskA456_g263206).xy;
					float temp_output_504_0_g263206 = 0.0;
					half Bias276_g263206 = temp_output_504_0_g263206;
					half2 Normal276_g263206 = float2( 0,0 );
					half4 localSampleCoord276_g263206 = SampleCoord( Texture276_g263206 , Sampler276_g263206 , UV276_g263206 , Bias276_g263206 , Normal276_g263206 );
					float4 temp_output_407_277_g263183 = localSampleCoord276_g263206;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g263206) = _MainAlbedoTex;
					SamplerState Sampler502_g263206 = staticSwitch36_g263188;
					half2 UV502_g263206 = (Out_MaskA456_g263206).zw;
					half Bias502_g263206 = temp_output_504_0_g263206;
					half2 Normal502_g263206 = float2( 0,0 );
					half4 localSampleCoord502_g263206 = SampleCoord( Texture502_g263206 , Sampler502_g263206 , UV502_g263206 , Bias502_g263206 , Normal502_g263206 );
					float4 temp_output_407_278_g263183 = localSampleCoord502_g263206;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g263206) = _MainAlbedoTex;
					SamplerState Sampler496_g263206 = staticSwitch36_g263188;
					float2 temp_output_463_0_g263206 = (Out_MaskB456_g263206).zw;
					half2 XZ496_g263206 = temp_output_463_0_g263206;
					half Bias496_g263206 = temp_output_504_0_g263206;
					half3 NormalWS512_g263206 = (Out_MaskK456_g263206).xyz;
					half3 NormalWS496_g263206 = NormalWS512_g263206;
					half3 Normal496_g263206 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g263206 = SamplePlanar2D( Texture496_g263206 , Sampler496_g263206 , XZ496_g263206 , Bias496_g263206 , NormalWS496_g263206 , Normal496_g263206 );
					float4 temp_output_407_0_g263183 = localSamplePlanar2D496_g263206;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g263206) = _MainAlbedoTex;
					SamplerState Sampler490_g263206 = staticSwitch36_g263188;
					float2 temp_output_462_0_g263206 = (Out_MaskB456_g263206).xy;
					half2 ZY490_g263206 = temp_output_462_0_g263206;
					half2 XZ490_g263206 = temp_output_463_0_g263206;
					float2 temp_output_464_0_g263206 = (Out_MaskC456_g263206).xy;
					half2 XY490_g263206 = temp_output_464_0_g263206;
					half Bias490_g263206 = temp_output_504_0_g263206;
					half3 Triplanar522_g263206 = (Out_MaskN456_g263206).xyz;
					half3 Triplanar490_g263206 = Triplanar522_g263206;
					half3 NormalWS490_g263206 = NormalWS512_g263206;
					half3 Normal490_g263206 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g263206 = SamplePlanar3D( Texture490_g263206 , Sampler490_g263206 , ZY490_g263206 , XZ490_g263206 , XY490_g263206 , Bias490_g263206 , Triplanar490_g263206 , NormalWS490_g263206 , Normal490_g263206 );
					float4 temp_output_407_201_g263183 = localSamplePlanar3D490_g263206;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g263206) = _MainAlbedoTex;
					SamplerState Sampler498_g263206 = staticSwitch36_g263188;
					half2 XZ498_g263206 = temp_output_463_0_g263206;
					float2 temp_output_473_0_g263206 = (Out_MaskE456_g263206).xy;
					half2 XZ_1498_g263206 = temp_output_473_0_g263206;
					float2 temp_output_474_0_g263206 = (Out_MaskE456_g263206).zw;
					half2 XZ_2498_g263206 = temp_output_474_0_g263206;
					float2 temp_output_475_0_g263206 = (Out_MaskF456_g263206).xy;
					half2 XZ_3498_g263206 = temp_output_475_0_g263206;
					float temp_output_510_0_g263206 = exp2( temp_output_504_0_g263206 );
					half Bias498_g263206 = temp_output_510_0_g263206;
					float3 temp_output_480_0_g263206 = (Out_MaskI456_g263206).xyz;
					half3 Weights_2498_g263206 = temp_output_480_0_g263206;
					half3 NormalWS498_g263206 = NormalWS512_g263206;
					half3 Normal498_g263206 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g263206 = SampleStochastic2D( Texture498_g263206 , Sampler498_g263206 , XZ498_g263206 , XZ_1498_g263206 , XZ_2498_g263206 , XZ_3498_g263206 , Bias498_g263206 , Weights_2498_g263206 , NormalWS498_g263206 , Normal498_g263206 );
					float4 temp_output_407_202_g263183 = localSampleStochastic2D498_g263206;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g263206) = _MainAlbedoTex;
					SamplerState Sampler500_g263206 = staticSwitch36_g263188;
					half2 ZY500_g263206 = temp_output_462_0_g263206;
					half2 ZY_1500_g263206 = (Out_MaskC456_g263206).zw;
					half2 ZY_2500_g263206 = (Out_MaskD456_g263206).xy;
					half2 ZY_3500_g263206 = (Out_MaskD456_g263206).zw;
					half2 XZ500_g263206 = temp_output_463_0_g263206;
					half2 XZ_1500_g263206 = temp_output_473_0_g263206;
					half2 XZ_2500_g263206 = temp_output_474_0_g263206;
					half2 XZ_3500_g263206 = temp_output_475_0_g263206;
					half2 XY500_g263206 = temp_output_464_0_g263206;
					half2 XY_1500_g263206 = (Out_MaskF456_g263206).zw;
					half2 XY_2500_g263206 = (Out_MaskG456_g263206).xy;
					half2 XY_3500_g263206 = (Out_MaskG456_g263206).zw;
					half Bias500_g263206 = temp_output_510_0_g263206;
					half3 Weights_1500_g263206 = (Out_MaskH456_g263206).xyz;
					half3 Weights_2500_g263206 = temp_output_480_0_g263206;
					half3 Weights_3500_g263206 = (Out_MaskJ456_g263206).xyz;
					half3 Triplanar500_g263206 = Triplanar522_g263206;
					half3 NormalWS500_g263206 = NormalWS512_g263206;
					half3 Normal500_g263206 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g263206 = SampleStochastic3D( Texture500_g263206 , Sampler500_g263206 , ZY500_g263206 , ZY_1500_g263206 , ZY_2500_g263206 , ZY_3500_g263206 , XZ500_g263206 , XZ_1500_g263206 , XZ_2500_g263206 , XZ_3500_g263206 , XY500_g263206 , XY_1500_g263206 , XY_2500_g263206 , XY_3500_g263206 , Bias500_g263206 , Weights_1500_g263206 , Weights_2500_g263206 , Weights_3500_g263206 , Triplanar500_g263206 , NormalWS500_g263206 , Normal500_g263206 );
					float4 temp_output_407_203_g263183 = localSampleStochastic3D500_g263206;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch184_g263183 = temp_output_407_277_g263183;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch184_g263183 = temp_output_407_278_g263183;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch184_g263183 = temp_output_407_0_g263183;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch184_g263183 = temp_output_407_201_g263183;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch184_g263183 = temp_output_407_202_g263183;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch184_g263183 = temp_output_407_203_g263183;
					#else
					float4 staticSwitch184_g263183 = temp_output_407_277_g263183;
					#endif
					half4 Local_AlbedoSample185_g263183 = staticSwitch184_g263183;
					float3 lerpResult53_g263183 = lerp( float3( 1,1,1 ) , (Local_AlbedoSample185_g263183).xyz , _MainAlbedoValue);
					half3 Local_AlbedoRGB107_g263183 = lerpResult53_g263183;
					float temp_output_17_0_g263203 = _MainMultiWriteMode;
					float Option91_g263203 = temp_output_17_0_g263203;
					float4 Model_VertexData418_g263183 = Out_VertexData15_g263184;
					float4 temp_output_84_0_g263203 = Model_VertexData418_g263183;
					float4 ChannelA91_g263203 = temp_output_84_0_g263203;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g263191) = _MainShaderTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch38_g263190 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch38_g263190 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch38_g263190 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch38_g263190 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch38_g263190 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch38_g263190 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g263191 = staticSwitch38_g263190;
					float localBreakTextureData456_g263191 = ( 0.0 );
					TVEMasksData Data456_g263191 =(TVEMasksData)Data431_g263205;
					float4 Out_MaskA456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g263191 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g263191 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g263191 , Out_MaskA456_g263191 , Out_MaskB456_g263191 , Out_MaskC456_g263191 , Out_MaskD456_g263191 , Out_MaskE456_g263191 , Out_MaskF456_g263191 , Out_MaskG456_g263191 , Out_MaskH456_g263191 , Out_MaskI456_g263191 , Out_MaskJ456_g263191 , Out_MaskK456_g263191 , Out_MaskL456_g263191 , Out_MaskM456_g263191 , Out_MaskN456_g263191 );
					half2 UV276_g263191 = (Out_MaskA456_g263191).xy;
					float temp_output_504_0_g263191 = 0.0;
					half Bias276_g263191 = temp_output_504_0_g263191;
					half2 Normal276_g263191 = float2( 0,0 );
					half4 localSampleCoord276_g263191 = SampleCoord( Texture276_g263191 , Sampler276_g263191 , UV276_g263191 , Bias276_g263191 , Normal276_g263191 );
					float4 temp_output_405_277_g263183 = localSampleCoord276_g263191;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g263191) = _MainShaderTex;
					SamplerState Sampler502_g263191 = staticSwitch38_g263190;
					half2 UV502_g263191 = (Out_MaskA456_g263191).zw;
					half Bias502_g263191 = temp_output_504_0_g263191;
					half2 Normal502_g263191 = float2( 0,0 );
					half4 localSampleCoord502_g263191 = SampleCoord( Texture502_g263191 , Sampler502_g263191 , UV502_g263191 , Bias502_g263191 , Normal502_g263191 );
					float4 temp_output_405_278_g263183 = localSampleCoord502_g263191;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g263191) = _MainShaderTex;
					SamplerState Sampler496_g263191 = staticSwitch38_g263190;
					float2 temp_output_463_0_g263191 = (Out_MaskB456_g263191).zw;
					half2 XZ496_g263191 = temp_output_463_0_g263191;
					half Bias496_g263191 = temp_output_504_0_g263191;
					half3 NormalWS512_g263191 = (Out_MaskK456_g263191).xyz;
					half3 NormalWS496_g263191 = NormalWS512_g263191;
					half3 Normal496_g263191 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g263191 = SamplePlanar2D( Texture496_g263191 , Sampler496_g263191 , XZ496_g263191 , Bias496_g263191 , NormalWS496_g263191 , Normal496_g263191 );
					float4 temp_output_405_0_g263183 = localSamplePlanar2D496_g263191;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g263191) = _MainShaderTex;
					SamplerState Sampler490_g263191 = staticSwitch38_g263190;
					float2 temp_output_462_0_g263191 = (Out_MaskB456_g263191).xy;
					half2 ZY490_g263191 = temp_output_462_0_g263191;
					half2 XZ490_g263191 = temp_output_463_0_g263191;
					float2 temp_output_464_0_g263191 = (Out_MaskC456_g263191).xy;
					half2 XY490_g263191 = temp_output_464_0_g263191;
					half Bias490_g263191 = temp_output_504_0_g263191;
					half3 Triplanar522_g263191 = (Out_MaskN456_g263191).xyz;
					half3 Triplanar490_g263191 = Triplanar522_g263191;
					half3 NormalWS490_g263191 = NormalWS512_g263191;
					half3 Normal490_g263191 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g263191 = SamplePlanar3D( Texture490_g263191 , Sampler490_g263191 , ZY490_g263191 , XZ490_g263191 , XY490_g263191 , Bias490_g263191 , Triplanar490_g263191 , NormalWS490_g263191 , Normal490_g263191 );
					float4 temp_output_405_201_g263183 = localSamplePlanar3D490_g263191;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g263191) = _MainShaderTex;
					SamplerState Sampler498_g263191 = staticSwitch38_g263190;
					half2 XZ498_g263191 = temp_output_463_0_g263191;
					float2 temp_output_473_0_g263191 = (Out_MaskE456_g263191).xy;
					half2 XZ_1498_g263191 = temp_output_473_0_g263191;
					float2 temp_output_474_0_g263191 = (Out_MaskE456_g263191).zw;
					half2 XZ_2498_g263191 = temp_output_474_0_g263191;
					float2 temp_output_475_0_g263191 = (Out_MaskF456_g263191).xy;
					half2 XZ_3498_g263191 = temp_output_475_0_g263191;
					float temp_output_510_0_g263191 = exp2( temp_output_504_0_g263191 );
					half Bias498_g263191 = temp_output_510_0_g263191;
					float3 temp_output_480_0_g263191 = (Out_MaskI456_g263191).xyz;
					half3 Weights_2498_g263191 = temp_output_480_0_g263191;
					half3 NormalWS498_g263191 = NormalWS512_g263191;
					half3 Normal498_g263191 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g263191 = SampleStochastic2D( Texture498_g263191 , Sampler498_g263191 , XZ498_g263191 , XZ_1498_g263191 , XZ_2498_g263191 , XZ_3498_g263191 , Bias498_g263191 , Weights_2498_g263191 , NormalWS498_g263191 , Normal498_g263191 );
					float4 temp_output_405_202_g263183 = localSampleStochastic2D498_g263191;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g263191) = _MainShaderTex;
					SamplerState Sampler500_g263191 = staticSwitch38_g263190;
					half2 ZY500_g263191 = temp_output_462_0_g263191;
					half2 ZY_1500_g263191 = (Out_MaskC456_g263191).zw;
					half2 ZY_2500_g263191 = (Out_MaskD456_g263191).xy;
					half2 ZY_3500_g263191 = (Out_MaskD456_g263191).zw;
					half2 XZ500_g263191 = temp_output_463_0_g263191;
					half2 XZ_1500_g263191 = temp_output_473_0_g263191;
					half2 XZ_2500_g263191 = temp_output_474_0_g263191;
					half2 XZ_3500_g263191 = temp_output_475_0_g263191;
					half2 XY500_g263191 = temp_output_464_0_g263191;
					half2 XY_1500_g263191 = (Out_MaskF456_g263191).zw;
					half2 XY_2500_g263191 = (Out_MaskG456_g263191).xy;
					half2 XY_3500_g263191 = (Out_MaskG456_g263191).zw;
					half Bias500_g263191 = temp_output_510_0_g263191;
					half3 Weights_1500_g263191 = (Out_MaskH456_g263191).xyz;
					half3 Weights_2500_g263191 = temp_output_480_0_g263191;
					half3 Weights_3500_g263191 = (Out_MaskJ456_g263191).xyz;
					half3 Triplanar500_g263191 = Triplanar522_g263191;
					half3 NormalWS500_g263191 = NormalWS512_g263191;
					half3 Normal500_g263191 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g263191 = SampleStochastic3D( Texture500_g263191 , Sampler500_g263191 , ZY500_g263191 , ZY_1500_g263191 , ZY_2500_g263191 , ZY_3500_g263191 , XZ500_g263191 , XZ_1500_g263191 , XZ_2500_g263191 , XZ_3500_g263191 , XY500_g263191 , XY_1500_g263191 , XY_2500_g263191 , XY_3500_g263191 , Bias500_g263191 , Weights_1500_g263191 , Weights_2500_g263191 , Weights_3500_g263191 , Triplanar500_g263191 , NormalWS500_g263191 , Normal500_g263191 );
					float4 temp_output_405_203_g263183 = localSampleStochastic3D500_g263191;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float4 staticSwitch198_g263183 = temp_output_405_277_g263183;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float4 staticSwitch198_g263183 = temp_output_405_278_g263183;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float4 staticSwitch198_g263183 = temp_output_405_0_g263183;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float4 staticSwitch198_g263183 = temp_output_405_201_g263183;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float4 staticSwitch198_g263183 = temp_output_405_202_g263183;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float4 staticSwitch198_g263183 = temp_output_405_203_g263183;
					#else
					float4 staticSwitch198_g263183 = temp_output_405_277_g263183;
					#endif
					half4 Local_ShaderSample199_g263183 = staticSwitch198_g263183;
					float2 appendResult428_g263183 = (float2((Local_AlbedoSample185_g263183).w , (Local_ShaderSample199_g263183).z));
					float2 temp_output_85_0_g263203 = appendResult428_g263183;
					float4 ChannelB91_g263203 = float4( temp_output_85_0_g263203, 0.0 , 0.0 );
					float localSwitchChannel691_g263203 = SwitchChannel6( Option91_g263203 , ChannelA91_g263203 , ChannelB91_g263203 );
					float clampResult17_g263201 = clamp( localSwitchChannel691_g263203 , 0.0001 , 0.9999 );
					float temp_output_7_0_g263202 = _MainMultiWriteRemap.x;
					float temp_output_9_0_g263202 = ( clampResult17_g263201 - temp_output_7_0_g263202 );
					half Local_MultiMask78_g263183 = saturate( ( temp_output_9_0_g263202 * _MainMultiWriteRemap.z ) );
					float lerpResult58_g263183 = lerp( 1.0 , Local_MultiMask78_g263183 , _MainColorMode);
					float4 lerpResult62_g263183 = lerp( _MainColorTwo , _MainColor , lerpResult58_g263183);
					half3 Local_ColorRGB93_g263183 = (lerpResult62_g263183).rgb;
					half3 Local_Albedo139_g263183 = ( Local_AlbedoRGB107_g263183 * Local_ColorRGB93_g263183 );
					float3 temp_output_4_0_g263185 = Local_Albedo139_g263183;
					float3 In_Albedo3_g263185 = temp_output_4_0_g263185;
					float3 temp_output_44_0_g263185 = Local_Albedo139_g263183;
					float3 In_AlbedoBase3_g263185 = temp_output_44_0_g263185;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture276_g263212) = _MainNormalTex;
					#if defined( TVE_FILTER_DEFAULT )
					SamplerState staticSwitch37_g263189 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_POINT )
					SamplerState staticSwitch37_g263189 = sampler_Point_Repeat;
					#elif defined( TVE_FILTER_LOW )
					SamplerState staticSwitch37_g263189 = sampler_Linear_Repeat;
					#elif defined( TVE_FILTER_MEDIUM )
					SamplerState staticSwitch37_g263189 = sampler_Linear_Repeat_Aniso8;
					#elif defined( TVE_FILTER_HIGH )
					SamplerState staticSwitch37_g263189 = sampler_Linear_Repeat_Aniso8;
					#else
					SamplerState staticSwitch37_g263189 = sampler_Linear_Repeat;
					#endif
					SamplerState Sampler276_g263212 = staticSwitch37_g263189;
					float localBreakTextureData456_g263212 = ( 0.0 );
					TVEMasksData Data456_g263212 =(TVEMasksData)Data431_g263205;
					float4 Out_MaskA456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskB456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskC456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskD456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskE456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskF456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskG456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskH456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskI456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskJ456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskK456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskL456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskM456_g263212 = float4( 0,0,0,0 );
					float4 Out_MaskN456_g263212 = float4( 0,0,0,0 );
					BreakTextureData( Data456_g263212 , Out_MaskA456_g263212 , Out_MaskB456_g263212 , Out_MaskC456_g263212 , Out_MaskD456_g263212 , Out_MaskE456_g263212 , Out_MaskF456_g263212 , Out_MaskG456_g263212 , Out_MaskH456_g263212 , Out_MaskI456_g263212 , Out_MaskJ456_g263212 , Out_MaskK456_g263212 , Out_MaskL456_g263212 , Out_MaskM456_g263212 , Out_MaskN456_g263212 );
					half2 UV276_g263212 = (Out_MaskA456_g263212).xy;
					float temp_output_504_0_g263212 = 0.0;
					half Bias276_g263212 = temp_output_504_0_g263212;
					half2 Normal276_g263212 = float2( 0,0 );
					half4 localSampleCoord276_g263212 = SampleCoord( Texture276_g263212 , Sampler276_g263212 , UV276_g263212 , Bias276_g263212 , Normal276_g263212 );
					float2 temp_output_406_394_g263183 = Normal276_g263212;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture502_g263212) = _MainNormalTex;
					SamplerState Sampler502_g263212 = staticSwitch37_g263189;
					half2 UV502_g263212 = (Out_MaskA456_g263212).zw;
					half Bias502_g263212 = temp_output_504_0_g263212;
					half2 Normal502_g263212 = float2( 0,0 );
					half4 localSampleCoord502_g263212 = SampleCoord( Texture502_g263212 , Sampler502_g263212 , UV502_g263212 , Bias502_g263212 , Normal502_g263212 );
					float2 temp_output_406_397_g263183 = Normal502_g263212;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture496_g263212) = _MainNormalTex;
					SamplerState Sampler496_g263212 = staticSwitch37_g263189;
					float2 temp_output_463_0_g263212 = (Out_MaskB456_g263212).zw;
					half2 XZ496_g263212 = temp_output_463_0_g263212;
					half Bias496_g263212 = temp_output_504_0_g263212;
					half3 NormalWS512_g263212 = (Out_MaskK456_g263212).xyz;
					half3 NormalWS496_g263212 = NormalWS512_g263212;
					half3 Normal496_g263212 = float3( 0,0,0 );
					half4 localSamplePlanar2D496_g263212 = SamplePlanar2D( Texture496_g263212 , Sampler496_g263212 , XZ496_g263212 , Bias496_g263212 , NormalWS496_g263212 , Normal496_g263212 );
					float3 temp_output_35_0_g263215 = Normal496_g263212;
					half3 TangentWS519_g263212 = (Out_MaskL456_g263212).xyz;
					float dotResult84_g263215 = dot( temp_output_35_0_g263215 , TangentWS519_g263212 );
					half3 BitangentWS521_g263212 = (Out_MaskM456_g263212).xyz;
					float dotResult85_g263215 = dot( temp_output_35_0_g263215 , BitangentWS521_g263212 );
					float2 appendResult87_g263215 = (float2(dotResult84_g263215 , dotResult85_g263215));
					float2 temp_output_406_375_g263183 = appendResult87_g263215;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture490_g263212) = _MainNormalTex;
					SamplerState Sampler490_g263212 = staticSwitch37_g263189;
					float2 temp_output_462_0_g263212 = (Out_MaskB456_g263212).xy;
					half2 ZY490_g263212 = temp_output_462_0_g263212;
					half2 XZ490_g263212 = temp_output_463_0_g263212;
					float2 temp_output_464_0_g263212 = (Out_MaskC456_g263212).xy;
					half2 XY490_g263212 = temp_output_464_0_g263212;
					half Bias490_g263212 = temp_output_504_0_g263212;
					half3 Triplanar522_g263212 = (Out_MaskN456_g263212).xyz;
					half3 Triplanar490_g263212 = Triplanar522_g263212;
					half3 NormalWS490_g263212 = NormalWS512_g263212;
					half3 Normal490_g263212 = float3( 0,0,0 );
					half4 localSamplePlanar3D490_g263212 = SamplePlanar3D( Texture490_g263212 , Sampler490_g263212 , ZY490_g263212 , XZ490_g263212 , XY490_g263212 , Bias490_g263212 , Triplanar490_g263212 , NormalWS490_g263212 , Normal490_g263212 );
					float3 temp_output_35_0_g263216 = Normal490_g263212;
					float dotResult84_g263216 = dot( temp_output_35_0_g263216 , TangentWS519_g263212 );
					float dotResult85_g263216 = dot( temp_output_35_0_g263216 , BitangentWS521_g263212 );
					float2 appendResult87_g263216 = (float2(dotResult84_g263216 , dotResult85_g263216));
					float2 temp_output_406_353_g263183 = appendResult87_g263216;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture498_g263212) = _MainNormalTex;
					SamplerState Sampler498_g263212 = staticSwitch37_g263189;
					half2 XZ498_g263212 = temp_output_463_0_g263212;
					float2 temp_output_473_0_g263212 = (Out_MaskE456_g263212).xy;
					half2 XZ_1498_g263212 = temp_output_473_0_g263212;
					float2 temp_output_474_0_g263212 = (Out_MaskE456_g263212).zw;
					half2 XZ_2498_g263212 = temp_output_474_0_g263212;
					float2 temp_output_475_0_g263212 = (Out_MaskF456_g263212).xy;
					half2 XZ_3498_g263212 = temp_output_475_0_g263212;
					float temp_output_510_0_g263212 = exp2( temp_output_504_0_g263212 );
					half Bias498_g263212 = temp_output_510_0_g263212;
					float3 temp_output_480_0_g263212 = (Out_MaskI456_g263212).xyz;
					half3 Weights_2498_g263212 = temp_output_480_0_g263212;
					half3 NormalWS498_g263212 = NormalWS512_g263212;
					half3 Normal498_g263212 = float3( 0,0,0 );
					half4 localSampleStochastic2D498_g263212 = SampleStochastic2D( Texture498_g263212 , Sampler498_g263212 , XZ498_g263212 , XZ_1498_g263212 , XZ_2498_g263212 , XZ_3498_g263212 , Bias498_g263212 , Weights_2498_g263212 , NormalWS498_g263212 , Normal498_g263212 );
					float3 temp_output_35_0_g263217 = Normal498_g263212;
					float dotResult84_g263217 = dot( temp_output_35_0_g263217 , TangentWS519_g263212 );
					float dotResult85_g263217 = dot( temp_output_35_0_g263217 , BitangentWS521_g263212 );
					float2 appendResult87_g263217 = (float2(dotResult84_g263217 , dotResult85_g263217));
					float2 temp_output_406_391_g263183 = appendResult87_g263217;
					UNITY_DECLARE_TEX2D_NOSAMPLER(Texture500_g263212) = _MainNormalTex;
					SamplerState Sampler500_g263212 = staticSwitch37_g263189;
					half2 ZY500_g263212 = temp_output_462_0_g263212;
					half2 ZY_1500_g263212 = (Out_MaskC456_g263212).zw;
					half2 ZY_2500_g263212 = (Out_MaskD456_g263212).xy;
					half2 ZY_3500_g263212 = (Out_MaskD456_g263212).zw;
					half2 XZ500_g263212 = temp_output_463_0_g263212;
					half2 XZ_1500_g263212 = temp_output_473_0_g263212;
					half2 XZ_2500_g263212 = temp_output_474_0_g263212;
					half2 XZ_3500_g263212 = temp_output_475_0_g263212;
					half2 XY500_g263212 = temp_output_464_0_g263212;
					half2 XY_1500_g263212 = (Out_MaskF456_g263212).zw;
					half2 XY_2500_g263212 = (Out_MaskG456_g263212).xy;
					half2 XY_3500_g263212 = (Out_MaskG456_g263212).zw;
					half Bias500_g263212 = temp_output_510_0_g263212;
					half3 Weights_1500_g263212 = (Out_MaskH456_g263212).xyz;
					half3 Weights_2500_g263212 = temp_output_480_0_g263212;
					half3 Weights_3500_g263212 = (Out_MaskJ456_g263212).xyz;
					half3 Triplanar500_g263212 = Triplanar522_g263212;
					half3 NormalWS500_g263212 = NormalWS512_g263212;
					half3 Normal500_g263212 = float3( 0,0,0 );
					half4 localSampleStochastic3D500_g263212 = SampleStochastic3D( Texture500_g263212 , Sampler500_g263212 , ZY500_g263212 , ZY_1500_g263212 , ZY_2500_g263212 , ZY_3500_g263212 , XZ500_g263212 , XZ_1500_g263212 , XZ_2500_g263212 , XZ_3500_g263212 , XY500_g263212 , XY_1500_g263212 , XY_2500_g263212 , XY_3500_g263212 , Bias500_g263212 , Weights_1500_g263212 , Weights_2500_g263212 , Weights_3500_g263212 , Triplanar500_g263212 , NormalWS500_g263212 , Normal500_g263212 );
					float3 temp_output_35_0_g263213 = Normal500_g263212;
					float dotResult84_g263213 = dot( temp_output_35_0_g263213 , TangentWS519_g263212 );
					float dotResult85_g263213 = dot( temp_output_35_0_g263213 , BitangentWS521_g263212 );
					float2 appendResult87_g263213 = (float2(dotResult84_g263213 , dotResult85_g263213));
					float2 temp_output_406_390_g263183 = appendResult87_g263213;
					#if defined( TVE_MAIN_SAMPLE_MAIN_UV )
					float2 staticSwitch193_g263183 = temp_output_406_394_g263183;
					#elif defined( TVE_MAIN_SAMPLE_EXTRA_UV )
					float2 staticSwitch193_g263183 = temp_output_406_397_g263183;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_2D )
					float2 staticSwitch193_g263183 = temp_output_406_375_g263183;
					#elif defined( TVE_MAIN_SAMPLE_PLANAR_3D )
					float2 staticSwitch193_g263183 = temp_output_406_353_g263183;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_2D )
					float2 staticSwitch193_g263183 = temp_output_406_391_g263183;
					#elif defined( TVE_MAIN_SAMPLE_STOCHASTIC_3D )
					float2 staticSwitch193_g263183 = temp_output_406_390_g263183;
					#else
					float2 staticSwitch193_g263183 = temp_output_406_394_g263183;
					#endif
					half2 Local_NormaSample191_g263183 = staticSwitch193_g263183;
					half2 Local_NormalTS108_g263183 = ( Local_NormaSample191_g263183 * _MainNormalValue );
					float2 In_NormalTS3_g263185 = Local_NormalTS108_g263183;
					float2 break80_g263204 = Local_NormalTS108_g263183;
					float3 temp_output_77_0_g263204 = Model_TangentWS366_g263183;
					float3 temp_output_78_0_g263204 = Model_BitangentWS367_g263183;
					float3 temp_output_76_0_g263204 = Model_NormalWS226_g263183;
					half3 Local_NormalWS250_g263183 = ( ( break80_g263204.x * temp_output_77_0_g263204 ) + ( break80_g263204.y * temp_output_78_0_g263204 ) + temp_output_76_0_g263204 );
					float3 In_NormalWS3_g263185 = Local_NormalWS250_g263183;
					float temp_output_209_0_g263183 = (Local_ShaderSample199_g263183).y;
					float temp_output_7_0_g263197 = _MainOcclusionRemap.x;
					float temp_output_9_0_g263197 = ( temp_output_209_0_g263183 - temp_output_7_0_g263197 );
					float lerpResult23_g263183 = lerp( 1.0 , saturate( ( temp_output_9_0_g263197 * _MainOcclusionRemap.z ) ) , _MainOcclusionValue);
					half Local_Occlusion313_g263183 = lerpResult23_g263183;
					float temp_output_213_0_g263183 = (Local_ShaderSample199_g263183).w;
					float temp_output_7_0_g263200 = _MainSmoothnessRemap.x;
					float temp_output_9_0_g263200 = ( temp_output_213_0_g263183 - temp_output_7_0_g263200 );
					half Local_Smoothness317_g263183 = ( saturate( ( temp_output_9_0_g263200 * _MainSmoothnessRemap.z ) ) * _MainSmoothnessValue );
					float4 appendResult73_g263183 = (float4(( (Local_ShaderSample199_g263183).x * _MainMetallicValue ) , Local_Occlusion313_g263183 , (Local_ShaderSample199_g263183).z , Local_Smoothness317_g263183));
					half4 Local_Masks109_g263183 = appendResult73_g263183;
					float4 In_Shader3_g263185 = Local_Masks109_g263183;
					float4 In_Feature3_g263185 = half4( 1, 1, 1, 1 );
					float4 In_Season3_g263185 = half4( 1, 1, 1, 1 );
					float4 In_Emissive3_g263185 = half4( 1, 1, 1, 1 );
					float3 temp_output_3_0_g263218 = Local_Albedo139_g263183;
					float dotResult20_g263218 = dot( temp_output_3_0_g263218 , float3( 0.2126, 0.7152, 0.0722 ) );
					half Local_Grayscale110_g263183 = dotResult20_g263218;
					float temp_output_12_0_g263185 = Local_Grayscale110_g263183;
					float In_Grayscale3_g263185 = temp_output_12_0_g263185;
					float temp_output_3_0_g263219 = Local_Grayscale110_g263183;
					float clampResult27_g263219 = clamp( saturate( ( temp_output_3_0_g263219 * 5.0 ) ) , 0.2 , 1.0 );
					half Local_Luminosity145_g263183 = clampResult27_g263219;
					float temp_output_16_0_g263185 = Local_Luminosity145_g263183;
					float In_Luminosity3_g263185 = temp_output_16_0_g263185;
					float In_MultiMask3_g263185 = Local_MultiMask78_g263183;
					float temp_output_187_0_g263183 = (Local_AlbedoSample185_g263183).w;
					#ifdef TVE_CLIPPING
					float staticSwitch236_g263183 = ( temp_output_187_0_g263183 - _MainAlphaClipValue );
					#else
					float staticSwitch236_g263183 = temp_output_187_0_g263183;
					#endif
					half Local_AlphaClip111_g263183 = staticSwitch236_g263183;
					float In_AlphaClip3_g263185 = Local_AlphaClip111_g263183;
					half Local_AlphaFade246_g263183 = (lerpResult62_g263183).a;
					float In_AlphaFade3_g263185 = Local_AlphaFade246_g263183;
					float3 temp_cast_25 = (1.0).xxx;
					float3 In_Translucency3_g263185 = temp_cast_25;
					float In_Transmission3_g263185 = 1.0;
					float In_Thickness3_g263185 = 0.0;
					float In_Diffusion3_g263185 = 0.0;
					float In_Depth3_g263185 = 0.0;
					BuildVisualData( Data3_g263185 , In_Dummy3_g263185 , In_Albedo3_g263185 , In_AlbedoBase3_g263185 , In_NormalTS3_g263185 , In_NormalWS3_g263185 , In_Shader3_g263185 , In_Feature3_g263185 , In_Season3_g263185 , In_Emissive3_g263185 , In_Grayscale3_g263185 , In_Luminosity3_g263185 , In_MultiMask3_g263185 , In_AlphaClip3_g263185 , In_AlphaFade3_g263185 , In_Translucency3_g263185 , In_Transmission3_g263185 , In_Thickness3_g263185 , In_Diffusion3_g263185 , In_Depth3_g263185 );
					TVEVisualData Data4_g263228 =(TVEVisualData)Data3_g263185;
					float Out_Dummy4_g263228 = 0.0;
					float3 Out_Albedo4_g263228 = float3( 0,0,0 );
					float3 Out_AlbedoBase4_g263228 = float3( 0,0,0 );
					float2 Out_NormalTS4_g263228 = float2( 0,0 );
					float3 Out_NormalWS4_g263228 = float3( 0,0,0 );
					float4 Out_Shader4_g263228 = float4( 0,0,0,0 );
					float4 Out_Feature4_g263228 = float4( 0,0,0,0 );
					float4 Out_Season4_g263228 = float4( 0,0,0,0 );
					float4 Out_Emissive4_g263228 = float4( 0,0,0,0 );
					float Out_MultiMask4_g263228 = 0.0;
					float Out_Grayscale4_g263228 = 0.0;
					float Out_Luminosity4_g263228 = 0.0;
					float Out_AlphaClip4_g263228 = 0.0;
					float Out_AlphaFade4_g263228 = 0.0;
					float3 Out_Translucency4_g263228 = float3( 0,0,0 );
					float Out_Transmission4_g263228 = 0.0;
					float Out_Thickness4_g263228 = 0.0;
					float Out_Diffusion4_g263228 = 0.0;
					float Out_Depth4_g263228 = 0.0;
					BreakVisualData( Data4_g263228 , Out_Dummy4_g263228 , Out_Albedo4_g263228 , Out_AlbedoBase4_g263228 , Out_NormalTS4_g263228 , Out_NormalWS4_g263228 , Out_Shader4_g263228 , Out_Feature4_g263228 , Out_Season4_g263228 , Out_Emissive4_g263228 , Out_MultiMask4_g263228 , Out_Grayscale4_g263228 , Out_Luminosity4_g263228 , Out_AlphaClip4_g263228 , Out_AlphaFade4_g263228 , Out_Translucency4_g263228 , Out_Transmission4_g263228 , Out_Thickness4_g263228 , Out_Diffusion4_g263228 , Out_Depth4_g263228 );
					float Alpha109_g263223 = Out_AlphaClip4_g263228;
					float lerpResult91_g263223 = lerp( 1.0 , Alpha109_g263223 , ( TVE_DEBUG_Clip * _RenderClip ));
					float lerpResult154_g263223 = lerp( 1.0 , lerpResult91_g263223 , Filter152_g263223);
					clip( lerpResult154_g263223 );
					clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
					

					o.Albedo = temp_cast_0;
					o.Normal = half3( 0, 0, 1 );

					half3 Specular = temp_cast_1;
					half Metallic = 0;
					half Smoothness = temp_output_2720_114;
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

					o.Emission = ( lerpResult72_g263223 * lerpResult84_g263223 );
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
				#pragma shader_feature_local_vertex TVE_PERSPECTIVE
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_vertex TVE_ROTATION
				#pragma shader_feature_local_vertex TVE_SIZEFADE
				#pragma shader_feature_local_vertex TVE_SIZEFADE_VERTX
				#pragma shader_feature_local_vertex TVE_MOTION
				#pragma shader_feature_local_vertex TVE_MOTION_FLOW
				#pragma shader_feature_local TVE_LEGACY
				#pragma shader_feature_local_vertex TVE_FLATTEN
				#pragma shader_feature_local_vertex TVE_RESHADE
				#pragma shader_feature_local_vertex TVE_TRANSFER
				#if defined (TVE_CONFORM_ROTATION) //Conform Rotation
					#define TVE_ROTATION_BEND //Conform Rotation
				#endif //Conform Rotation
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
				uniform half _PerspectiveCategory;
				uniform half _PerspectiveEnd;
				uniform half _PerspectivePhaseValue;
				uniform half _PerspectiveIntensityValue;
				uniform half _PerspectiveAngleValue;
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
				uniform half _RotationCategory;
				uniform half _RotationEnd;
				uniform half _RotationInfo;
				uniform half _RotationIntensityValue;
				uniform half _SizeFadeCategory;
				uniform half _SizeFadeEnd;
				uniform half4 TVE_SizeFadeParams;
				uniform float _SizeFadeDistMaxValue;
				uniform float _SizeFadeDistMinValue;
				uniform half _SizeFadeScaleValue;
				uniform half _SizeFadeVertxMode;
				uniform half _SizeFadeVertxValue;
				uniform half _SizeFadeScaleMode;
				uniform half _SizeFadeIntensityValue;
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
				uniform half _FlattenCategory;
				uniform half _FlattenEnd;
				uniform half _FlattenBakeMode;
				uniform half _FlattenUpwardsValue;
				uniform half3 _FlattenSphereOffsetValue;
				uniform half _FlattenSphereValue;
				uniform half _FlattenMeshMode;
				uniform half4 _FlattenMeshRemap;
				uniform half _FlattenMeshValue;
				uniform half _FlattenIntensityValue;
				uniform half _ReshadeCategory;
				uniform half _ReshadeEnd;
				uniform half _ReshadeInfo;
				uniform half _ReshadeIntensityValue;
				uniform half _TransferCategory;
				uniform half _TransferEnd;
				uniform half _TransferInfo;
				uniform half _TransferSpace;
				uniform half _TransferIntensityValue;
				uniform half _TransferMeshMode;
				uniform half4 _TransferMeshRemap;
				uniform half _TransferMeshValue;


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
				
				float3 ASESafeNormalize(float3 inVec)
				{
					float dp3 = max(1.175494351e-38, dot(inVec, inVec));
					return inVec* rsqrt(dp3);
				}
				

				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					TVEVertexData Data16_g262854 =(TVEVertexData)0;
					float In_Dummy16_g262854 = 0.0;
					TVEVertexData Data16_g262849 =(TVEVertexData)0;
					float In_Dummy16_g262849 = 0.0;
					float localIfModelDataByShader26_g263144 = ( 0.0 );
					TVEModelData Data26_g263144 = (TVEModelData)0;
					TVEModelData Data16_g263050 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g263032 = _ObjectCoordMode;
					#else
					float staticSwitch343_g263032 = _ObjectCoordMode;
					#endif
					half Dummy207_g263032 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g263032 );
					float temp_output_14_0_g263050 = Dummy207_g263032;
					float In_Dummy16_g263050 = temp_output_14_0_g263050;
					float3 PositionOS131_g263032 = v.vertex.xyz;
					float3 temp_output_4_0_g263050 = PositionOS131_g263032;
					float3 In_PositionOS16_g263050 = temp_output_4_0_g263050;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g263032 = ase_positionWS;
					float3 vertexToFrag73_g263032 = temp_output_104_7_g263032;
					float3 PositionWS122_g263032 = vertexToFrag73_g263032;
					float3 In_PositionWS16_g263050 = PositionWS122_g263032;
					float4x4 break19_g263035 = unity_ObjectToWorld;
					float3 appendResult20_g263035 = (float3(break19_g263035[ 0 ][ 3 ] , break19_g263035[ 1 ][ 3 ] , break19_g263035[ 2 ][ 3 ]));
					float3 temp_output_340_7_g263032 = appendResult20_g263035;
					float4x4 break19_g263037 = unity_ObjectToWorld;
					float3 appendResult20_g263037 = (float3(break19_g263037[ 0 ][ 3 ] , break19_g263037[ 1 ][ 3 ] , break19_g263037[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g263033 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g263032 = PositionOS131_g263032;
					float3 appendResult234_g263032 = (float3(break233_g263032.x , 0.0 , break233_g263032.z));
					float3 break413_g263032 = PositionOS131_g263032;
					float3 appendResult414_g263032 = (float3(break413_g263032.x , break413_g263032.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g263039 = appendResult414_g263032;
					#else
					float3 staticSwitch65_g263039 = appendResult234_g263032;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g263032 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g263032 = appendResult60_g263033;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g263032 = staticSwitch65_g263039;
					#else
					float3 staticSwitch229_g263032 = _Vector0;
					#endif
					float3 PivotOS149_g263032 = staticSwitch229_g263032;
					float3 temp_output_122_0_g263037 = PivotOS149_g263032;
					float3 PivotsOnlyWS105_g263037 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g263037 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g263032 = ( appendResult20_g263037 + PivotsOnlyWS105_g263037 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g263032 = temp_output_340_7_g263032;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g263032 = temp_output_341_7_g263032;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g263032 = temp_output_341_7_g263032;
					#else
					float3 staticSwitch236_g263032 = temp_output_340_7_g263032;
					#endif
					float3 vertexToFrag76_g263032 = staticSwitch236_g263032;
					float3 PivotWS121_g263032 = vertexToFrag76_g263032;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g263032 = ( PositionWS122_g263032 - PivotWS121_g263032 );
					#else
					float3 staticSwitch204_g263032 = PositionWS122_g263032;
					#endif
					float3 PositionWO132_g263032 = ( staticSwitch204_g263032 - TVE_WorldOrigin );
					float3 In_PositionWO16_g263050 = PositionWO132_g263032;
					float3 In_PivotOS16_g263050 = PivotOS149_g263032;
					float3 In_PivotWS16_g263050 = PivotWS121_g263032;
					float3 PivotWO133_g263032 = ( PivotWS121_g263032 - TVE_WorldOrigin );
					float3 In_PivotWO16_g263050 = PivotWO133_g263032;
					half3 NormalOS134_g263032 = v.normal;
					float3 temp_output_21_0_g263050 = NormalOS134_g263032;
					float3 In_NormalOS16_g263050 = temp_output_21_0_g263050;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g263032 = normalizedWorldNormal;
					float3 In_NormalWS16_g263050 = NormalWS95_g263032;
					half4 TangentlOS153_g263032 = v.tangent;
					float4 temp_output_6_0_g263050 = TangentlOS153_g263032;
					float4 In_TangentOS16_g263050 = temp_output_6_0_g263050;
					float3 normalizeResult296_g263032 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g263032 ) );
					half3 ViewDirWS169_g263032 = normalizeResult296_g263032;
					float3 In_ViewDirWS16_g263050 = ViewDirWS169_g263032;
					float4 appendResult397_g263032 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g263032 = appendResult397_g263032;
					float4 In_CoordsData16_g263050 = CoordsData398_g263032;
					half4 VertexMasks171_g263032 = v.ase_color;
					float4 In_VertexData16_g263050 = VertexMasks171_g263032;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g263044 = (PositionOS131_g263032).z;
					#else
					float staticSwitch65_g263044 = (PositionOS131_g263032).y;
					#endif
					half Object_HeightValue267_g263032 = _ObjectHeightValue;
					half Bounds_HeightMask274_g263032 = saturate( ( staticSwitch65_g263044 / Object_HeightValue267_g263032 ) );
					half3 Position387_g263032 = PositionOS131_g263032;
					half Height387_g263032 = Object_HeightValue267_g263032;
					half Object_RadiusValue268_g263032 = _ObjectRadiusValue;
					half Radius387_g263032 = Object_RadiusValue268_g263032;
					half localCapsuleMaskYUp387_g263032 = CapsuleMaskYUp( Position387_g263032 , Height387_g263032 , Radius387_g263032 );
					half3 Position408_g263032 = PositionOS131_g263032;
					half Height408_g263032 = Object_HeightValue267_g263032;
					half Radius408_g263032 = Object_RadiusValue268_g263032;
					half localCapsuleMaskZUp408_g263032 = CapsuleMaskZUp( Position408_g263032 , Height408_g263032 , Radius408_g263032 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g263049 = saturate( localCapsuleMaskZUp408_g263032 );
					#else
					float staticSwitch65_g263049 = saturate( localCapsuleMaskYUp387_g263032 );
					#endif
					half Bounds_SphereMask282_g263032 = staticSwitch65_g263049;
					float4 appendResult253_g263032 = (float4(Bounds_HeightMask274_g263032 , Bounds_SphereMask282_g263032 , 1.0 , 1.0));
					half4 MasksData254_g263032 = appendResult253_g263032;
					float4 In_MasksData16_g263050 = MasksData254_g263032;
					float temp_output_17_0_g263043 = _ObjectPhaseMode;
					float Option70_g263043 = temp_output_17_0_g263043;
					float4 temp_output_3_0_g263043 = v.ase_color;
					float4 Channel70_g263043 = temp_output_3_0_g263043;
					float localSwitchChannel470_g263043 = SwitchChannel4( Option70_g263043 , Channel70_g263043 );
					half Phase_Value372_g263032 = localSwitchChannel470_g263043;
					float3 break319_g263032 = PivotWO133_g263032;
					half Pivot_Position322_g263032 = ( break319_g263032.x + break319_g263032.z );
					half Phase_Position357_g263032 = ( Phase_Value372_g263032 + Pivot_Position322_g263032 );
					float temp_output_248_0_g263032 = frac( Phase_Position357_g263032 );
					float4 appendResult177_g263032 = (float4((frac( ( Phase_Position357_g263032 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g263032));
					half4 Phase_Data176_g263032 = appendResult177_g263032;
					float4 In_PhaseData16_g263050 = Phase_Data176_g263032;
					BuildModelVertData( Data16_g263050 , In_Dummy16_g263050 , In_PositionOS16_g263050 , In_PositionWS16_g263050 , In_PositionWO16_g263050 , In_PivotOS16_g263050 , In_PivotWS16_g263050 , In_PivotWO16_g263050 , In_NormalOS16_g263050 , In_NormalWS16_g263050 , In_TangentOS16_g263050 , In_ViewDirWS16_g263050 , In_CoordsData16_g263050 , In_VertexData16_g263050 , In_MasksData16_g263050 , In_PhaseData16_g263050 );
					TVEModelData DataDefault26_g263144 = Data16_g263050;
					TVEModelData DataGeneral26_g263144 = Data16_g263050;
					TVEModelData DataBlanket26_g263144 = Data16_g263050;
					TVEModelData DataImpostor26_g263144 = Data16_g263050;
					TVEModelData Data16_g263030 =(TVEModelData)0;
					half Dummy207_g263012 = 0.0;
					float temp_output_14_0_g263030 = Dummy207_g263012;
					float In_Dummy16_g263030 = temp_output_14_0_g263030;
					float3 PositionOS131_g263012 = v.vertex.xyz;
					float3 temp_output_4_0_g263030 = PositionOS131_g263012;
					float3 In_PositionOS16_g263030 = temp_output_4_0_g263030;
					float3 temp_output_104_7_g263012 = ase_positionWS;
					float3 PositionWS122_g263012 = temp_output_104_7_g263012;
					float3 In_PositionWS16_g263030 = PositionWS122_g263012;
					float4x4 break19_g263015 = unity_ObjectToWorld;
					float3 appendResult20_g263015 = (float3(break19_g263015[ 0 ][ 3 ] , break19_g263015[ 1 ][ 3 ] , break19_g263015[ 2 ][ 3 ]));
					float3 temp_output_340_7_g263012 = appendResult20_g263015;
					float3 PivotWS121_g263012 = temp_output_340_7_g263012;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g263012 = ( PositionWS122_g263012 - PivotWS121_g263012 );
					#else
					float3 staticSwitch204_g263012 = PositionWS122_g263012;
					#endif
					float3 PositionWO132_g263012 = ( staticSwitch204_g263012 - TVE_WorldOrigin );
					float3 In_PositionWO16_g263030 = PositionWO132_g263012;
					float3 PivotOS149_g263012 = _Vector0;
					float3 In_PivotOS16_g263030 = PivotOS149_g263012;
					float3 In_PivotWS16_g263030 = PivotWS121_g263012;
					float3 PivotWO133_g263012 = ( PivotWS121_g263012 - TVE_WorldOrigin );
					float3 In_PivotWO16_g263030 = PivotWO133_g263012;
					half3 NormalOS134_g263012 = v.normal;
					float3 temp_output_21_0_g263030 = NormalOS134_g263012;
					float3 In_NormalOS16_g263030 = temp_output_21_0_g263030;
					half3 NormalWS95_g263012 = normalizedWorldNormal;
					float3 In_NormalWS16_g263030 = NormalWS95_g263012;
					float4 appendResult462_g263012 = (float4(cross( v.normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g263012 = appendResult462_g263012;
					float4 temp_output_6_0_g263030 = TangentlOS153_g263012;
					float4 In_TangentOS16_g263030 = temp_output_6_0_g263030;
					float3 normalizeResult296_g263012 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g263012 ) );
					half3 ViewDirWS169_g263012 = normalizeResult296_g263012;
					float3 In_ViewDirWS16_g263030 = ViewDirWS169_g263012;
					float4 appendResult397_g263012 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g263012 = appendResult397_g263012;
					float4 In_CoordsData16_g263030 = CoordsData398_g263012;
					half4 VertexMasks171_g263012 = float4( 0,0,0,0 );
					float4 In_VertexData16_g263030 = VertexMasks171_g263012;
					half4 MasksData254_g263012 = float4( 0,0,0,0 );
					float4 In_MasksData16_g263030 = MasksData254_g263012;
					half4 Phase_Data176_g263012 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g263030 = Phase_Data176_g263012;
					BuildModelVertData( Data16_g263030 , In_Dummy16_g263030 , In_PositionOS16_g263030 , In_PositionWS16_g263030 , In_PositionWO16_g263030 , In_PivotOS16_g263030 , In_PivotWS16_g263030 , In_PivotWO16_g263030 , In_NormalOS16_g263030 , In_NormalWS16_g263030 , In_TangentOS16_g263030 , In_ViewDirWS16_g263030 , In_CoordsData16_g263030 , In_VertexData16_g263030 , In_MasksData16_g263030 , In_PhaseData16_g263030 );
					TVEModelData DataTerrain26_g263144 = Data16_g263030;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g263144 = IsShaderType2637;
					{
					if (Type26_g263144 == 0 )
					{
					Data26_g263144 = DataDefault26_g263144;
					}
					else if (Type26_g263144 == 1 )
					{
					Data26_g263144 = DataGeneral26_g263144;
					}
					else if (Type26_g263144 == 2 )
					{
					Data26_g263144 = DataBlanket26_g263144;
					}
					else if (Type26_g263144 == 3 )
					{
					Data26_g263144 = DataImpostor26_g263144;
					}
					else if (Type26_g263144 == 4 )
					{
					Data26_g263144 = DataTerrain26_g263144;
					}
					}
					TVEModelData Data15_g262850 =(TVEModelData)Data26_g263144;
					float Out_Dummy15_g262850 = 0.0;
					float3 Out_PositionOS15_g262850 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262850 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262850 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262850 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262850 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262850 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262850 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262850 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262850 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262850 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262850 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262850 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262850 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262850 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262850 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262850 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262850 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262850 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262850 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262850 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262850 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262850 , Out_Dummy15_g262850 , Out_PositionOS15_g262850 , Out_PositionWS15_g262850 , Out_PositionWO15_g262850 , Out_PositionRawOS15_g262850 , Out_PivotOS15_g262850 , Out_PivotWS15_g262850 , Out_PivotWO15_g262850 , Out_NormalOS15_g262850 , Out_NormalWS15_g262850 , Out_NormalRawOS15_g262850 , Out_TangentOS15_g262850 , Out_TangentWS15_g262850 , Out_BitangentWS15_g262850 , Out_ViewDirWS15_g262850 , Out_CoordsData15_g262850 , Out_VertexData15_g262850 , Out_MasksData15_g262850 , Out_PhaseData15_g262850 , Out_TransformData15_g262850 , Out_RotationData15_g262850 , Out_Interpolator15_g262850 );
					float3 In_PositionOS16_g262849 = Out_PositionOS15_g262850;
					float3 In_NormalOS16_g262849 = Out_NormalOS15_g262850;
					float4 In_TangentOS16_g262849 = Out_TangentOS15_g262850;
					float4 In_TransformData16_g262849 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g262849 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g262849 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g262849 , In_Dummy16_g262849 , In_PositionOS16_g262849 , In_NormalOS16_g262849 , In_TangentOS16_g262849 , In_TransformData16_g262849 , In_RotationData16_g262849 , In_Interpolator16_g262849 );
					TVEVertexData Data15_g262852 =(TVEVertexData)Data16_g262849;
					float Out_Dummy15_g262852 = 0.0;
					float3 Out_PositionOS15_g262852 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262852 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262852 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262852 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262852 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262852 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262852 , Out_Dummy15_g262852 , Out_PositionOS15_g262852 , Out_NormalOS15_g262852 , Out_TangentOS15_g262852 , Out_TransformData15_g262852 , Out_RotationData15_g262852 , Out_Interpolator15_g262852 );
					TVEModelData Data15_g262853 =(TVEModelData)Data15_g262850;
					float Out_Dummy15_g262853 = 0.0;
					float3 Out_PositionOS15_g262853 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262853 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262853 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262853 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262853 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262853 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262853 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262853 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262853 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262853 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262853 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262853 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262853 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262853 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262853 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262853 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262853 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262853 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262853 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262853 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262853 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262853 , Out_Dummy15_g262853 , Out_PositionOS15_g262853 , Out_PositionWS15_g262853 , Out_PositionWO15_g262853 , Out_PositionRawOS15_g262853 , Out_PivotOS15_g262853 , Out_PivotWS15_g262853 , Out_PivotWO15_g262853 , Out_NormalOS15_g262853 , Out_NormalWS15_g262853 , Out_NormalRawOS15_g262853 , Out_TangentOS15_g262853 , Out_TangentWS15_g262853 , Out_BitangentWS15_g262853 , Out_ViewDirWS15_g262853 , Out_CoordsData15_g262853 , Out_VertexData15_g262853 , Out_MasksData15_g262853 , Out_PhaseData15_g262853 , Out_TransformData15_g262853 , Out_RotationData15_g262853 , Out_Interpolator15_g262853 );
					float3 In_PositionOS16_g262854 = ( Out_PositionOS15_g262852 - Out_PivotOS15_g262853 );
					float3 In_NormalOS16_g262854 = Out_NormalOS15_g262853;
					float4 In_TangentOS16_g262854 = Out_TangentOS15_g262853;
					float4 In_TransformData16_g262854 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g262854 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g262854 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g262854 , In_Dummy16_g262854 , In_PositionOS16_g262854 , In_NormalOS16_g262854 , In_TangentOS16_g262854 , In_TransformData16_g262854 , In_RotationData16_g262854 , In_Interpolator16_g262854 );
					TVEVertexData Data15_g262858 =(TVEVertexData)Data16_g262854;
					float Out_Dummy15_g262858 = 0.0;
					float3 Out_PositionOS15_g262858 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262858 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262858 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262858 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262858 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262858 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262858 , Out_Dummy15_g262858 , Out_PositionOS15_g262858 , Out_NormalOS15_g262858 , Out_TangentOS15_g262858 , Out_TransformData15_g262858 , Out_RotationData15_g262858 , Out_Interpolator15_g262858 );
					TVEVertexData Data16_g262859 =(TVEVertexData)Data15_g262858;
					half Dummy181_g262855 = ( _PerspectiveCategory + _PerspectiveEnd );
					float In_Dummy16_g262859 = Dummy181_g262855;
					half3 Vertex_PositionOS147_g262855 = Out_PositionOS15_g262858;
					TVEModelData Data15_g262860 =(TVEModelData)Data15_g262853;
					float Out_Dummy15_g262860 = 0.0;
					float3 Out_PositionOS15_g262860 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262860 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262860 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262860 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262860 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262860 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262860 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262860 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262860 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262860 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262860 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262860 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262860 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262860 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262860 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262860 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262860 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262860 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262860 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262860 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262860 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262860 , Out_Dummy15_g262860 , Out_PositionOS15_g262860 , Out_PositionWS15_g262860 , Out_PositionWO15_g262860 , Out_PositionRawOS15_g262860 , Out_PivotOS15_g262860 , Out_PivotWS15_g262860 , Out_PivotWO15_g262860 , Out_NormalOS15_g262860 , Out_NormalWS15_g262860 , Out_NormalRawOS15_g262860 , Out_TangentOS15_g262860 , Out_TangentWS15_g262860 , Out_BitangentWS15_g262860 , Out_ViewDirWS15_g262860 , Out_CoordsData15_g262860 , Out_VertexData15_g262860 , Out_MasksData15_g262860 , Out_PhaseData15_g262860 , Out_TransformData15_g262860 , Out_RotationData15_g262860 , Out_Interpolator15_g262860 );
					half3 Model_ViewDirWS237_g262855 = Out_ViewDirWS15_g262860;
					float4x4 break117_g262856 = unity_CameraToWorld;
					float3 appendResult118_g262856 = (float3(break117_g262856[ 0 ][ 2 ] , break117_g262856[ 1 ][ 2 ] , break117_g262856[ 2 ][ 2 ]));
					float3 lerpResult209_g262855 = lerp( Model_ViewDirWS237_g262855 , -appendResult118_g262856 , unity_OrthoParams.w);
					float3 break201_g262855 = cross( lerpResult209_g262855 , half3( 0, 1, 0 ) );
					float3 appendResult196_g262855 = (float3(-break201_g262855.z , 0.0 , break201_g262855.x));
					half4 Model_PhaseData218_g262855 = Out_PhaseData15_g262860;
					float2 break226_g262855 = ( (Model_PhaseData218_g262855).xy * 5.0 * _PerspectivePhaseValue );
					float3 appendResult224_g262855 = (float3(break226_g262855.x , 0.0 , break226_g262855.y));
					float dotResult189_g262855 = dot( Model_ViewDirWS237_g262855 , float3( 0, 1, 0 ) );
					float saferPower192_g262855 = abs( dotResult189_g262855 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g262857 = (Vertex_PositionOS147_g262855).z;
					#else
					float staticSwitch65_g262857 = (Vertex_PositionOS147_g262855).y;
					#endif
					float3 temp_output_206_0_g262855 = ( Vertex_PositionOS147_g262855 + ( ( mul( unity_WorldToObject, float4( appendResult196_g262855 , 0.0 ) ).xyz + appendResult224_g262855 ) * _PerspectiveIntensityValue * pow( saferPower192_g262855 , _PerspectiveAngleValue ) * saturate( staticSwitch65_g262857 ) ) );
					#ifdef TVE_PERSPECTIVE
					float3 staticSwitch211_g262855 = temp_output_206_0_g262855;
					#else
					float3 staticSwitch211_g262855 = Vertex_PositionOS147_g262855;
					#endif
					float3 Final_Position178_g262855 = staticSwitch211_g262855;
					float3 In_PositionOS16_g262859 = Final_Position178_g262855;
					float3 In_NormalOS16_g262859 = Out_NormalOS15_g262858;
					float4 In_TangentOS16_g262859 = Out_TangentOS15_g262858;
					float4 In_TransformData16_g262859 = Out_TransformData15_g262858;
					float4 In_RotationData16_g262859 = Out_RotationData15_g262858;
					float4 In_Interpolator16_g262859 = Out_Interpolator15_g262858;
					BuildVertexData( Data16_g262859 , In_Dummy16_g262859 , In_PositionOS16_g262859 , In_NormalOS16_g262859 , In_TangentOS16_g262859 , In_TransformData16_g262859 , In_RotationData16_g262859 , In_Interpolator16_g262859 );
					TVEVertexData Data15_g262869 =(TVEVertexData)Data16_g262859;
					float Out_Dummy15_g262869 = 0.0;
					float3 Out_PositionOS15_g262869 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262869 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262869 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262869 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262869 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262869 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262869 , Out_Dummy15_g262869 , Out_PositionOS15_g262869 , Out_NormalOS15_g262869 , Out_TangentOS15_g262869 , Out_TransformData15_g262869 , Out_RotationData15_g262869 , Out_Interpolator15_g262869 );
					TVEVertexData Data16_g262870 =(TVEVertexData)Data15_g262869;
					half Dummy317_g262861 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g262870 = Dummy317_g262861;
					float3 In_PositionOS16_g262870 = Out_PositionOS15_g262869;
					float3 In_NormalOS16_g262870 = Out_NormalOS15_g262869;
					float4 In_TangentOS16_g262870 = Out_TangentOS15_g262869;
					half4 Model_TransformData356_g262861 = Out_TransformData15_g262869;
					float localBuildGlobalData204_g262442 = ( 0.0 );
					TVEGlobalData Data204_g262442 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g262442 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g262442 = Dummy211_g262442;
					float4 temp_output_203_0_g262461 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g262420 = ( 0.0 );
					TVEModelData Data26_g262420 = (TVEModelData)0;
					TVEModelData DataDefault26_g262420 = Data16_g263030;
					TVEModelData Data16_g263040 =(TVEModelData)0;
					float In_Dummy16_g263040 = 0.0;
					float3 In_PositionWS16_g263040 = PositionWS122_g263032;
					float3 In_PositionWO16_g263040 = PositionWO132_g263032;
					float3 In_PivotWS16_g263040 = PivotWS121_g263032;
					float3 In_PivotWO16_g263040 = PivotWO133_g263032;
					float3 In_NormalWS16_g263040 = NormalWS95_g263032;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g263032 = ase_tangentWS;
					float3 In_TangentWS16_g263040 = TangentWS136_g263032;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g263032 = ase_bitangentWS;
					float3 In_BitangentWS16_g263040 = BiangentWS421_g263032;
					half3 NormalWS427_g263032 = NormalWS95_g263032;
					half3 localComputeTriplanarMasks427_g263032 = ComputeTriplanarMasks( NormalWS427_g263032 );
					half3 TriplanarWeights429_g263032 = localComputeTriplanarMasks427_g263032;
					float3 In_TriplanarWeights16_g263040 = TriplanarWeights429_g263032;
					float3 In_ViewDirWS16_g263040 = ViewDirWS169_g263032;
					float4 In_CoordsData16_g263040 = CoordsData398_g263032;
					float4 In_VertexData16_g263040 = VertexMasks171_g263032;
					float4 In_Interpolator16_g263040 = Phase_Data176_g263032;
					BuildModelFragData( Data16_g263040 , In_Dummy16_g263040 , In_PositionWS16_g263040 , In_PositionWO16_g263040 , In_PivotWS16_g263040 , In_PivotWO16_g263040 , In_NormalWS16_g263040 , In_TangentWS16_g263040 , In_BitangentWS16_g263040 , In_TriplanarWeights16_g263040 , In_ViewDirWS16_g263040 , In_CoordsData16_g263040 , In_VertexData16_g263040 , In_Interpolator16_g263040 );
					TVEModelData DataGeneral26_g262420 = Data16_g263040;
					TVEModelData DataBlanket26_g262420 = Data16_g263040;
					TVEModelData DataImpostor26_g262420 = Data16_g263040;
					TVEModelData Data16_g263020 =(TVEModelData)0;
					float In_Dummy16_g263020 = 0.0;
					float3 In_PositionWS16_g263020 = PositionWS122_g263012;
					float3 In_PositionWO16_g263020 = PositionWO132_g263012;
					float3 In_PivotWS16_g263020 = PivotWS121_g263012;
					float3 In_PivotWO16_g263020 = PivotWO133_g263012;
					float3 In_NormalWS16_g263020 = NormalWS95_g263012;
					half3 TangentWS136_g263012 = ase_tangentWS;
					float3 In_TangentWS16_g263020 = TangentWS136_g263012;
					half3 BiangentWS421_g263012 = ase_bitangentWS;
					float3 In_BitangentWS16_g263020 = BiangentWS421_g263012;
					half3 NormalWS427_g263012 = NormalWS95_g263012;
					half3 localComputeTriplanarMasks427_g263012 = ComputeTriplanarMasks( NormalWS427_g263012 );
					half3 TriplanarWeights429_g263012 = localComputeTriplanarMasks427_g263012;
					float3 In_TriplanarWeights16_g263020 = TriplanarWeights429_g263012;
					float3 In_ViewDirWS16_g263020 = ViewDirWS169_g263012;
					float4 In_CoordsData16_g263020 = CoordsData398_g263012;
					float4 In_VertexData16_g263020 = VertexMasks171_g263012;
					float4 In_Interpolator16_g263020 = Phase_Data176_g263012;
					BuildModelFragData( Data16_g263020 , In_Dummy16_g263020 , In_PositionWS16_g263020 , In_PositionWO16_g263020 , In_PivotWS16_g263020 , In_PivotWO16_g263020 , In_NormalWS16_g263020 , In_TangentWS16_g263020 , In_BitangentWS16_g263020 , In_TriplanarWeights16_g263020 , In_ViewDirWS16_g263020 , In_CoordsData16_g263020 , In_VertexData16_g263020 , In_Interpolator16_g263020 );
					TVEModelData DataTerrain26_g262420 = Data16_g263020;
					float Type26_g262420 = IsShaderType2637;
					{
					if (Type26_g262420 == 0 )
					{
					Data26_g262420 = DataDefault26_g262420;
					}
					else if (Type26_g262420 == 1 )
					{
					Data26_g262420 = DataGeneral26_g262420;
					}
					else if (Type26_g262420 == 2 )
					{
					Data26_g262420 = DataBlanket26_g262420;
					}
					else if (Type26_g262420 == 3 )
					{
					Data26_g262420 = DataImpostor26_g262420;
					}
					else if (Type26_g262420 == 4 )
					{
					Data26_g262420 = DataTerrain26_g262420;
					}
					}
					TVEModelData Data15_g262532 =(TVEModelData)Data26_g262420;
					float Out_Dummy15_g262532 = 0.0;
					float3 Out_PositionWS15_g262532 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262532 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262532 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262532 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262532 = float3( 0,0,0 );
					float3 Out_TangentWS15_g262532 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262532 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g262532 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262532 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262532 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262532 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262532 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g262532 , Out_Dummy15_g262532 , Out_PositionWS15_g262532 , Out_PositionWO15_g262532 , Out_PivotWS15_g262532 , Out_PivotWO15_g262532 , Out_NormalWS15_g262532 , Out_TangentWS15_g262532 , Out_BitangentWS15_g262532 , Out_TriplanarWeights15_g262532 , Out_ViewDirWS15_g262532 , Out_CoordsData15_g262532 , Out_VertexData15_g262532 , Out_Interpolator15_g262532 );
					float3 Model_PositionWS497_g262442 = Out_PositionWS15_g262532;
					float2 Model_PositionWS_XZ143_g262442 = (Model_PositionWS497_g262442).xz;
					float3 Model_PivotWS498_g262442 = Out_PivotWS15_g262532;
					float2 Model_PivotWS_XZ145_g262442 = (Model_PivotWS498_g262442).xz;
					float2 lerpResult300_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g262461 = lerpResult300_g262442;
					float temp_output_82_0_g262459 = _GlobalCoatLayerValue;
					float temp_output_82_0_g262461 = temp_output_82_0_g262459;
					float4 tex2DArrayNode83_g262461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262461).zw + ( (temp_output_203_0_g262461).xy * temp_output_81_0_g262461 ) ),temp_output_82_0_g262461), 0.0 );
					float4 appendResult210_g262461 = (float4(tex2DArrayNode83_g262461.rgb , tex2DArrayNode83_g262461.a));
					float4 temp_output_204_0_g262461 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g262461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262461).zw + ( (temp_output_204_0_g262461).xy * temp_output_81_0_g262461 ) ),temp_output_82_0_g262461), 0.0 );
					float4 appendResult212_g262461 = (float4(tex2DArrayNode122_g262461.rgb , tex2DArrayNode122_g262461.a));
					float4 TVE_RenderNearPositionR628_g262442 = TVE_RenderNearPositionR;
					float temp_output_507_0_g262442 = saturate( ( distance( Model_PositionWS497_g262442 , (TVE_RenderNearPositionR628_g262442).xyz ) / (TVE_RenderNearPositionR628_g262442).w ) );
					float temp_output_7_0_g262531 = 1.0;
					float temp_output_9_0_g262531 = ( temp_output_507_0_g262442 - temp_output_7_0_g262531 );
					half TVE_RenderNearFadeValue635_g262442 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g262442 = saturate( ( temp_output_9_0_g262531 / ( ( TVE_RenderNearFadeValue635_g262442 - temp_output_7_0_g262531 ) + 0.0001 ) ) );
					float4 lerpResult131_g262461 = lerp( appendResult210_g262461 , appendResult212_g262461 , Global_TexBlend509_g262442);
					float4 temp_output_159_109_g262459 = lerpResult131_g262461;
					float4 lerpResult168_g262459 = lerp( TVE_CoatParams , temp_output_159_109_g262459 , TVE_CoatLayers[(int)temp_output_82_0_g262459]);
					float4 temp_output_589_109_g262442 = lerpResult168_g262459;
					half4 Coat_Texture302_g262442 = temp_output_589_109_g262442;
					float4 In_CoatTexture204_g262442 = Coat_Texture302_g262442;
					half4 Draw_Texture656_g262442 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g262442 = Draw_Texture656_g262442;
					float4 temp_output_203_0_g262486 = TVE_PaintBaseCoord;
					float2 lerpResult85_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g262486 = lerpResult85_g262442;
					float temp_output_82_0_g262483 = _GlobalPaintLayerValue;
					float temp_output_82_0_g262486 = temp_output_82_0_g262483;
					float4 tex2DArrayNode83_g262486 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262486).zw + ( (temp_output_203_0_g262486).xy * temp_output_81_0_g262486 ) ),temp_output_82_0_g262486), 0.0 );
					float4 appendResult210_g262486 = (float4(tex2DArrayNode83_g262486.rgb , tex2DArrayNode83_g262486.a));
					float4 temp_output_204_0_g262486 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g262486 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262486).zw + ( (temp_output_204_0_g262486).xy * temp_output_81_0_g262486 ) ),temp_output_82_0_g262486), 0.0 );
					float4 appendResult212_g262486 = (float4(tex2DArrayNode122_g262486.rgb , tex2DArrayNode122_g262486.a));
					float4 lerpResult131_g262486 = lerp( appendResult210_g262486 , appendResult212_g262486 , Global_TexBlend509_g262442);
					float4 temp_output_171_109_g262483 = lerpResult131_g262486;
					float4 lerpResult174_g262483 = lerp( TVE_PaintParams , temp_output_171_109_g262483 , TVE_PaintLayers[(int)temp_output_82_0_g262483]);
					float4 temp_output_595_109_g262442 = lerpResult174_g262483;
					half4 Paint_Texture71_g262442 = temp_output_595_109_g262442;
					float4 In_PaintTexture204_g262442 = Paint_Texture71_g262442;
					float4 temp_output_203_0_g262469 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g262469 = lerpResult104_g262442;
					float temp_output_132_0_g262467 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g262469 = temp_output_132_0_g262467;
					float4 tex2DArrayNode83_g262469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262469).zw + ( (temp_output_203_0_g262469).xy * temp_output_81_0_g262469 ) ),temp_output_82_0_g262469), 0.0 );
					float4 appendResult210_g262469 = (float4(tex2DArrayNode83_g262469.rgb , tex2DArrayNode83_g262469.a));
					float4 temp_output_204_0_g262469 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g262469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262469).zw + ( (temp_output_204_0_g262469).xy * temp_output_81_0_g262469 ) ),temp_output_82_0_g262469), 0.0 );
					float4 appendResult212_g262469 = (float4(tex2DArrayNode122_g262469.rgb , tex2DArrayNode122_g262469.a));
					float4 lerpResult131_g262469 = lerp( appendResult210_g262469 , appendResult212_g262469 , Global_TexBlend509_g262442);
					float4 temp_output_137_109_g262467 = lerpResult131_g262469;
					float4 lerpResult145_g262467 = lerp( TVE_AtmoParams , temp_output_137_109_g262467 , TVE_AtmoLayers[(int)temp_output_132_0_g262467]);
					float4 temp_output_590_110_g262442 = lerpResult145_g262467;
					half4 Atmo_Texture80_g262442 = temp_output_590_110_g262442;
					float4 In_AtmoTexture204_g262442 = Atmo_Texture80_g262442;
					float4 temp_output_203_0_g262537 = TVE_EffexBaseCoord;
					float2 lerpResult414_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g262537 = lerpResult414_g262442;
					float temp_output_132_0_g262535 = _GlobalEffexLayerValue;
					float temp_output_82_0_g262537 = temp_output_132_0_g262535;
					float4 tex2DArrayNode83_g262537 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262537).zw + ( (temp_output_203_0_g262537).xy * temp_output_81_0_g262537 ) ),temp_output_82_0_g262537), 0.0 );
					float4 appendResult210_g262537 = (float4(tex2DArrayNode83_g262537.rgb , tex2DArrayNode83_g262537.a));
					float4 temp_output_204_0_g262537 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g262537 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262537).zw + ( (temp_output_204_0_g262537).xy * temp_output_81_0_g262537 ) ),temp_output_82_0_g262537), 0.0 );
					float4 appendResult212_g262537 = (float4(tex2DArrayNode122_g262537.rgb , tex2DArrayNode122_g262537.a));
					float4 lerpResult131_g262537 = lerp( appendResult210_g262537 , appendResult212_g262537 , Global_TexBlend509_g262442);
					float4 temp_output_137_109_g262535 = lerpResult131_g262537;
					float4 lerpResult145_g262535 = lerp( TVE_EffexParams , temp_output_137_109_g262535 , TVE_EffexLayers[(int)temp_output_132_0_g262535]);
					float4 temp_output_731_110_g262442 = lerpResult145_g262535;
					half4 Effex_Texture420_g262442 = temp_output_731_110_g262442;
					float4 In_EffexTexture204_g262442 = Effex_Texture420_g262442;
					float4 temp_output_203_0_g262517 = TVE_GlowBaseCoord;
					float2 lerpResult247_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g262517 = lerpResult247_g262442;
					float temp_output_82_0_g262515 = _GlobalGlowLayerValue;
					float temp_output_82_0_g262517 = temp_output_82_0_g262515;
					float4 tex2DArrayNode83_g262517 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262517).zw + ( (temp_output_203_0_g262517).xy * temp_output_81_0_g262517 ) ),temp_output_82_0_g262517), 0.0 );
					float4 appendResult210_g262517 = (float4(tex2DArrayNode83_g262517.rgb , tex2DArrayNode83_g262517.a));
					float4 temp_output_204_0_g262517 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g262517 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262517).zw + ( (temp_output_204_0_g262517).xy * temp_output_81_0_g262517 ) ),temp_output_82_0_g262517), 0.0 );
					float4 appendResult212_g262517 = (float4(tex2DArrayNode122_g262517.rgb , tex2DArrayNode122_g262517.a));
					float4 lerpResult131_g262517 = lerp( appendResult210_g262517 , appendResult212_g262517 , Global_TexBlend509_g262442);
					float4 temp_output_159_109_g262515 = lerpResult131_g262517;
					float4 lerpResult167_g262515 = lerp( TVE_GlowParams , temp_output_159_109_g262515 , TVE_GlowLayers[(int)temp_output_82_0_g262515]);
					float4 temp_output_593_109_g262442 = lerpResult167_g262515;
					half4 Glow_Texture248_g262442 = temp_output_593_109_g262442;
					float4 In_GlowTexture204_g262442 = Glow_Texture248_g262442;
					float4 temp_output_203_0_g262453 = TVE_FormBaseCoord;
					float2 lerpResult168_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g262453 = lerpResult168_g262442;
					float temp_output_130_0_g262451 = _GlobalFormLayerValue;
					float temp_output_82_0_g262453 = temp_output_130_0_g262451;
					float4 tex2DArrayNode83_g262453 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262453).zw + ( (temp_output_203_0_g262453).xy * temp_output_81_0_g262453 ) ),temp_output_82_0_g262453), 0.0 );
					float4 appendResult210_g262453 = (float4(tex2DArrayNode83_g262453.rgb , tex2DArrayNode83_g262453.a));
					float4 temp_output_204_0_g262453 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g262453 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262453).zw + ( (temp_output_204_0_g262453).xy * temp_output_81_0_g262453 ) ),temp_output_82_0_g262453), 0.0 );
					float4 appendResult212_g262453 = (float4(tex2DArrayNode122_g262453.rgb , tex2DArrayNode122_g262453.a));
					float4 lerpResult131_g262453 = lerp( appendResult210_g262453 , appendResult212_g262453 , Global_TexBlend509_g262442);
					float4 temp_output_135_109_g262451 = lerpResult131_g262453;
					float4 lerpResult143_g262451 = lerp( TVE_FormParams , temp_output_135_109_g262451 , TVE_FormLayers[(int)temp_output_130_0_g262451]);
					float4 temp_output_592_0_g262442 = lerpResult143_g262451;
					float4 Form_Texture112_g262442 = temp_output_592_0_g262442;
					float4 In_FormTexture204_g262442 = Form_Texture112_g262442;
					float4 In_LandTexture204_g262442 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g262501 = TVE_VertxBaseCoord;
					float2 lerpResult681_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g262501 = lerpResult681_g262442;
					float temp_output_136_0_g262499 = _GlobalVertxLayerValue;
					float temp_output_82_0_g262501 = temp_output_136_0_g262499;
					float4 tex2DArrayNode83_g262501 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262501).zw + ( (temp_output_203_0_g262501).xy * temp_output_81_0_g262501 ) ),temp_output_82_0_g262501), 0.0 );
					float4 appendResult210_g262501 = (float4(tex2DArrayNode83_g262501.rgb , tex2DArrayNode83_g262501.a));
					float4 temp_output_204_0_g262501 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g262501 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262501).zw + ( (temp_output_204_0_g262501).xy * temp_output_81_0_g262501 ) ),temp_output_82_0_g262501), 0.0 );
					float4 appendResult212_g262501 = (float4(tex2DArrayNode122_g262501.rgb , tex2DArrayNode122_g262501.a));
					float4 lerpResult131_g262501 = lerp( appendResult210_g262501 , appendResult212_g262501 , Global_TexBlend509_g262442);
					float4 temp_output_141_109_g262499 = lerpResult131_g262501;
					float4 lerpResult149_g262499 = lerp( TVE_VertxParams , temp_output_141_109_g262499 , TVE_VertxLayers[(int)temp_output_136_0_g262499]);
					float4 temp_output_695_0_g262442 = lerpResult149_g262499;
					half4 Vertx_Texture693_g262442 = temp_output_695_0_g262442;
					float4 In_VertxTexture204_g262442 = Vertx_Texture693_g262442;
					float4 temp_output_203_0_g262477 = TVE_FlowBaseCoord;
					float2 lerpResult400_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g262477 = lerpResult400_g262442;
					float temp_output_136_0_g262475 = _GlobalFlowLayerValue;
					float temp_output_82_0_g262477 = temp_output_136_0_g262475;
					float4 tex2DArrayNode83_g262477 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262477).zw + ( (temp_output_203_0_g262477).xy * temp_output_81_0_g262477 ) ),temp_output_82_0_g262477), 0.0 );
					float4 appendResult210_g262477 = (float4(tex2DArrayNode83_g262477.rgb , tex2DArrayNode83_g262477.a));
					float4 temp_output_204_0_g262477 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g262477 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262477).zw + ( (temp_output_204_0_g262477).xy * temp_output_81_0_g262477 ) ),temp_output_82_0_g262477), 0.0 );
					float4 appendResult212_g262477 = (float4(tex2DArrayNode122_g262477.rgb , tex2DArrayNode122_g262477.a));
					float4 lerpResult131_g262477 = lerp( appendResult210_g262477 , appendResult212_g262477 , Global_TexBlend509_g262442);
					float4 temp_output_141_109_g262475 = lerpResult131_g262477;
					float4 lerpResult149_g262475 = lerp( TVE_FlowParams , temp_output_141_109_g262475 , TVE_FlowLayers[(int)temp_output_136_0_g262475]);
					float4 temp_output_594_0_g262442 = lerpResult149_g262475;
					half4 Flow_Texture405_g262442 = temp_output_594_0_g262442;
					float4 In_FlowTexture204_g262442 = Flow_Texture405_g262442;
					half4 User_Texture677_g262442 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g262442 = User_Texture677_g262442;
					BuildGlobalData( Data204_g262442 , In_Dummy204_g262442 , In_CoatTexture204_g262442 , In_DrawTexture204_g262442 , In_PaintTexture204_g262442 , In_AtmoTexture204_g262442 , In_EffexTexture204_g262442 , In_GlowTexture204_g262442 , In_FormTexture204_g262442 , In_LandTexture204_g262442 , In_VertxTexture204_g262442 , In_FlowTexture204_g262442 , In_UserTexture204_g262442 );
					TVEGlobalData Data15_g262871 =(TVEGlobalData)Data204_g262442;
					float Out_Dummy15_g262871 = 0.0;
					float4 Out_CoatTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g262871 = float4( 0,0,0,0 );
					BreakData( Data15_g262871 , Out_Dummy15_g262871 , Out_CoatTexture15_g262871 , Out_DrawTexture15_g262871 , Out_PaintTexture15_g262871 , Out_AtmoTexture15_g262871 , Out_EffexTexture15_g262871 , Out_GlowTexture15_g262871 , Out_FormTexture15_g262871 , Out_LandTexture15_g262871 , Out_VertxTexture15_g262871 , Out_FlowTexture15_g262871 , Out_UserTexture15_g262871 );
					float4 Global_FormTexture351_g262861 = Out_FormTexture15_g262871;
					TVEModelData Data15_g262868 =(TVEModelData)Data15_g262860;
					float Out_Dummy15_g262868 = 0.0;
					float3 Out_PositionOS15_g262868 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262868 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262868 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262868 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262868 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262868 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262868 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262868 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262868 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262868 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262868 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262868 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262868 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262868 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262868 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262868 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262868 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262868 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262868 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262868 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262868 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262868 , Out_Dummy15_g262868 , Out_PositionOS15_g262868 , Out_PositionWS15_g262868 , Out_PositionWO15_g262868 , Out_PositionRawOS15_g262868 , Out_PivotOS15_g262868 , Out_PivotWS15_g262868 , Out_PivotWO15_g262868 , Out_NormalOS15_g262868 , Out_NormalWS15_g262868 , Out_NormalRawOS15_g262868 , Out_TangentOS15_g262868 , Out_TangentWS15_g262868 , Out_BitangentWS15_g262868 , Out_ViewDirWS15_g262868 , Out_CoordsData15_g262868 , Out_VertexData15_g262868 , Out_MasksData15_g262868 , Out_PhaseData15_g262868 , Out_TransformData15_g262868 , Out_RotationData15_g262868 , Out_Interpolator15_g262868 );
					float3 Model_PivotWO353_g262861 = Out_PivotWO15_g262868;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g262867 = _ConformMeshMode;
					float Option70_g262867 = temp_output_17_0_g262867;
					half4 Model_VertexData357_g262861 = Out_VertexData15_g262868;
					float4 temp_output_3_0_g262867 = Model_VertexData357_g262861;
					float4 Channel70_g262867 = temp_output_3_0_g262867;
					float localSwitchChannel470_g262867 = SwitchChannel4( Option70_g262867 , Channel70_g262867 );
					float temp_output_390_0_g262861 = localSwitchChannel470_g262867;
					float temp_output_7_0_g262864 = _ConformMeshRemap.x;
					float temp_output_9_0_g262864 = ( temp_output_390_0_g262861 - temp_output_7_0_g262864 );
					float lerpResult374_g262861 = lerp( 1.0 , saturate( ( temp_output_9_0_g262864 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g262861 = lerpResult374_g262861;
					float temp_output_328_0_g262861 = ( Blend_VertMask379_g262861 * TVE_IsEnabled );
					half Conform_Mask366_g262861 = temp_output_328_0_g262861;
					float temp_output_322_0_g262861 = ( ( ( ( (Global_FormTexture351_g262861).z - ( (Model_PivotWO353_g262861).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g262861 ) );
					float3 appendResult329_g262861 = (float3(0.0 , temp_output_322_0_g262861 , 0.0));
					float3 appendResult387_g262861 = (float3(0.0 , 0.0 , temp_output_322_0_g262861));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262865 = appendResult387_g262861;
					#else
					float3 staticSwitch65_g262865 = appendResult329_g262861;
					#endif
					float3 Blanket_Conform368_g262861 = staticSwitch65_g262865;
					float4 appendResult312_g262861 = (float4(Blanket_Conform368_g262861 , 0.0));
					float4 temp_output_310_0_g262861 = ( Model_TransformData356_g262861 + appendResult312_g262861 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g262861 = temp_output_310_0_g262861;
					#else
					float4 staticSwitch364_g262861 = Model_TransformData356_g262861;
					#endif
					half4 Final_TransformData365_g262861 = staticSwitch364_g262861;
					float4 In_TransformData16_g262870 = Final_TransformData365_g262861;
					float4 In_RotationData16_g262870 = Out_RotationData15_g262869;
					float4 In_Interpolator16_g262870 = Out_Interpolator15_g262869;
					BuildVertexData( Data16_g262870 , In_Dummy16_g262870 , In_PositionOS16_g262870 , In_NormalOS16_g262870 , In_TangentOS16_g262870 , In_TransformData16_g262870 , In_RotationData16_g262870 , In_Interpolator16_g262870 );
					TVEVertexData Data15_g262878 =(TVEVertexData)Data16_g262870;
					float Out_Dummy15_g262878 = 0.0;
					float3 Out_PositionOS15_g262878 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262878 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262878 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262878 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262878 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262878 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262878 , Out_Dummy15_g262878 , Out_PositionOS15_g262878 , Out_NormalOS15_g262878 , Out_TangentOS15_g262878 , Out_TransformData15_g262878 , Out_RotationData15_g262878 , Out_Interpolator15_g262878 );
					TVEVertexData Data16_g262879 =(TVEVertexData)Data15_g262878;
					half Dummy181_g262872 = ( _RotationCategory + _RotationEnd + _RotationInfo );
					float In_Dummy16_g262879 = Dummy181_g262872;
					float3 In_PositionOS16_g262879 = Out_PositionOS15_g262878;
					float3 In_NormalOS16_g262879 = Out_NormalOS15_g262878;
					float4 In_TangentOS16_g262879 = Out_TangentOS15_g262878;
					float4 In_TransformData16_g262879 = Out_TransformData15_g262878;
					half4 Model_RotationData212_g262872 = Out_RotationData15_g262878;
					TVEGlobalData Data15_g262873 =(TVEGlobalData)Data15_g262871;
					float Out_Dummy15_g262873 = 0.0;
					float4 Out_CoatTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g262873 = float4( 0,0,0,0 );
					BreakData( Data15_g262873 , Out_Dummy15_g262873 , Out_CoatTexture15_g262873 , Out_DrawTexture15_g262873 , Out_PaintTexture15_g262873 , Out_AtmoTexture15_g262873 , Out_EffexTexture15_g262873 , Out_GlowTexture15_g262873 , Out_FormTexture15_g262873 , Out_LandTexture15_g262873 , Out_VertxTexture15_g262873 , Out_FlowTexture15_g262873 , Out_UserTexture15_g262873 );
					half4 Global_FormTexture188_g262872 = Out_FormTexture15_g262873;
					float2 temp_output_38_0_g262874 = ((Global_FormTexture188_g262872).xy*2.0 + -1.0);
					float2 break83_g262874 = temp_output_38_0_g262874;
					float3 appendResult79_g262874 = (float3(break83_g262874.x , 0.0 , break83_g262874.y));
					float3 ase_parentObjectScale = ( 1.0 / float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ) );
					float2 lerpResult227_g262872 = lerp( float2( 0,0 ) , (( mul( unity_WorldToObject, float4( appendResult79_g262874 , 0.0 ) ).xyz * ase_parentObjectScale )).xz , ( _RotationIntensityValue * TVE_IsEnabled ));
					half2 Blanket_Orientation192_g262872 = lerpResult227_g262872;
					float4 appendResult222_g262872 = (float4(( (Model_RotationData212_g262872).xy + Blanket_Orientation192_g262872 ) , (Model_RotationData212_g262872).zw));
					#ifdef TVE_ROTATION
					float4 staticSwitch218_g262872 = appendResult222_g262872;
					#else
					float4 staticSwitch218_g262872 = Model_RotationData212_g262872;
					#endif
					half4 Final_RotationData225_g262872 = staticSwitch218_g262872;
					float4 In_RotationData16_g262879 = Final_RotationData225_g262872;
					float4 In_Interpolator16_g262879 = Out_Interpolator15_g262878;
					BuildVertexData( Data16_g262879 , In_Dummy16_g262879 , In_PositionOS16_g262879 , In_NormalOS16_g262879 , In_TangentOS16_g262879 , In_TransformData16_g262879 , In_RotationData16_g262879 , In_Interpolator16_g262879 );
					TVEVertexData Data15_g262887 =(TVEVertexData)Data16_g262879;
					float Out_Dummy15_g262887 = 0.0;
					float3 Out_PositionOS15_g262887 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262887 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262887 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262887 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262887 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262887 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262887 , Out_Dummy15_g262887 , Out_PositionOS15_g262887 , Out_NormalOS15_g262887 , Out_TangentOS15_g262887 , Out_TransformData15_g262887 , Out_RotationData15_g262887 , Out_Interpolator15_g262887 );
					TVEVertexData Data16_g262888 =(TVEVertexData)Data15_g262887;
					half Dummy181_g262880 = ( _SizeFadeCategory + _SizeFadeEnd );
					float In_Dummy16_g262888 = Dummy181_g262880;
					float3 Model_PositionOS147_g262880 = Out_PositionOS15_g262887;
					float3 temp_cast_17 = (1.0).xxx;
					TVEModelData Data15_g262877 =(TVEModelData)Data15_g262868;
					float Out_Dummy15_g262877 = 0.0;
					float3 Out_PositionOS15_g262877 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262877 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262877 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262877 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262877 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262877 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262877 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262877 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262877 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262877 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262877 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262877 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262877 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262877 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262877 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262877 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262877 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262877 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262877 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262877 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262877 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262877 , Out_Dummy15_g262877 , Out_PositionOS15_g262877 , Out_PositionWS15_g262877 , Out_PositionWO15_g262877 , Out_PositionRawOS15_g262877 , Out_PivotOS15_g262877 , Out_PivotWS15_g262877 , Out_PivotWO15_g262877 , Out_NormalOS15_g262877 , Out_NormalWS15_g262877 , Out_NormalRawOS15_g262877 , Out_TangentOS15_g262877 , Out_TangentWS15_g262877 , Out_BitangentWS15_g262877 , Out_ViewDirWS15_g262877 , Out_CoordsData15_g262877 , Out_VertexData15_g262877 , Out_MasksData15_g262877 , Out_PhaseData15_g262877 , Out_TransformData15_g262877 , Out_RotationData15_g262877 , Out_Interpolator15_g262877 );
					TVEModelData Data15_g262889 =(TVEModelData)Data15_g262877;
					float Out_Dummy15_g262889 = 0.0;
					float3 Out_PositionOS15_g262889 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262889 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262889 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262889 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262889 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262889 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262889 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262889 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262889 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262889 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262889 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262889 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262889 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262889 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262889 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262889 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262889 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262889 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262889 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262889 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262889 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262889 , Out_Dummy15_g262889 , Out_PositionOS15_g262889 , Out_PositionWS15_g262889 , Out_PositionWO15_g262889 , Out_PositionRawOS15_g262889 , Out_PivotOS15_g262889 , Out_PivotWS15_g262889 , Out_PivotWO15_g262889 , Out_NormalOS15_g262889 , Out_NormalWS15_g262889 , Out_NormalRawOS15_g262889 , Out_TangentOS15_g262889 , Out_TangentWS15_g262889 , Out_BitangentWS15_g262889 , Out_ViewDirWS15_g262889 , Out_CoordsData15_g262889 , Out_VertexData15_g262889 , Out_MasksData15_g262889 , Out_PhaseData15_g262889 , Out_TransformData15_g262889 , Out_RotationData15_g262889 , Out_Interpolator15_g262889 );
					float3 Model_PivotWS162_g262880 = Out_PivotWS15_g262889;
					float lerpResult216_g262880 = lerp( 1.0 , TVE_SizeFadeParams.z , TVE_SizeFadeParams.w);
					float temp_output_7_0_g262882 = _SizeFadeDistMaxValue;
					float temp_output_9_0_g262882 = ( ( distance( _WorldSpaceCameraPos , Model_PivotWS162_g262880 ) * lerpResult216_g262880 ) - temp_output_7_0_g262882 );
					float temp_output_245_0_g262880 = (TVE_VertxParams).x;
					TVEGlobalData Data15_g262890 =(TVEGlobalData)Data15_g262873;
					float Out_Dummy15_g262890 = 0.0;
					float4 Out_CoatTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g262890 = float4( 0,0,0,0 );
					BreakData( Data15_g262890 , Out_Dummy15_g262890 , Out_CoatTexture15_g262890 , Out_DrawTexture15_g262890 , Out_PaintTexture15_g262890 , Out_AtmoTexture15_g262890 , Out_EffexTexture15_g262890 , Out_GlowTexture15_g262890 , Out_FormTexture15_g262890 , Out_LandTexture15_g262890 , Out_VertxTexture15_g262890 , Out_FlowTexture15_g262890 , Out_UserTexture15_g262890 );
					half4 Global_VertxTexture188_g262880 = Out_VertxTexture15_g262890;
					float temp_output_6_0_g262886 = (Global_VertxTexture188_g262880).x;
					float temp_output_7_0_g262886 = _SizeFadeVertxMode;
					#ifdef TVE_DUMMY
					float staticSwitch14_g262886 = ( temp_output_6_0_g262886 + temp_output_7_0_g262886 );
					#else
					float staticSwitch14_g262886 = temp_output_6_0_g262886;
					#endif
					float temp_output_223_0_g262880 = staticSwitch14_g262886;
					#ifdef TVE_SIZEFADE_VERTX
					float staticSwitch194_g262880 = temp_output_223_0_g262880;
					#else
					float staticSwitch194_g262880 = temp_output_245_0_g262880;
					#endif
					float lerpResult213_g262880 = lerp( 1.0 , staticSwitch194_g262880 , ( _SizeFadeVertxValue * TVE_IsEnabled ));
					half Blend_GlobalMask192_g262880 = lerpResult213_g262880;
					half Blend_UserMask232_g262880 = 1.0;
					float temp_output_236_0_g262880 = ( Blend_GlobalMask192_g262880 * Blend_UserMask232_g262880 );
					half Blend_Mask240_g262880 = temp_output_236_0_g262880;
					float temp_output_189_0_g262880 = ( saturate( ( temp_output_9_0_g262882 / ( ( _SizeFadeDistMinValue - temp_output_7_0_g262882 ) + 0.0001 ) ) ) * _SizeFadeScaleValue * Blend_Mask240_g262880 );
					float3 appendResult200_g262880 = (float3(temp_output_189_0_g262880 , temp_output_189_0_g262880 , temp_output_189_0_g262880));
					float3 appendResult201_g262880 = (float3(1.0 , temp_output_189_0_g262880 , 1.0));
					float3 appendResult230_g262880 = (float3(1.0 , 1.0 , temp_output_189_0_g262880));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262883 = appendResult230_g262880;
					#else
					float3 staticSwitch65_g262883 = appendResult201_g262880;
					#endif
					float3 lerpResult202_g262880 = lerp( appendResult200_g262880 , staticSwitch65_g262883 , _SizeFadeScaleMode);
					float3 lerpResult184_g262880 = lerp( temp_cast_17 , lerpResult202_g262880 , _SizeFadeIntensityValue);
					float3 temp_output_167_0_g262880 = ( lerpResult184_g262880 * Model_PositionOS147_g262880 );
					#ifdef TVE_SIZEFADE
					float3 staticSwitch199_g262880 = temp_output_167_0_g262880;
					#else
					float3 staticSwitch199_g262880 = Model_PositionOS147_g262880;
					#endif
					float3 Final_Position178_g262880 = staticSwitch199_g262880;
					float3 In_PositionOS16_g262888 = Final_Position178_g262880;
					float3 In_NormalOS16_g262888 = Out_NormalOS15_g262887;
					float4 In_TangentOS16_g262888 = Out_TangentOS15_g262887;
					float4 In_TransformData16_g262888 = Out_TransformData15_g262887;
					float4 In_RotationData16_g262888 = Out_RotationData15_g262887;
					float4 In_Interpolator16_g262888 = Out_Interpolator15_g262887;
					BuildVertexData( Data16_g262888 , In_Dummy16_g262888 , In_PositionOS16_g262888 , In_NormalOS16_g262888 , In_TangentOS16_g262888 , In_TransformData16_g262888 , In_RotationData16_g262888 , In_Interpolator16_g262888 );
					TVEVertexData Data15_g262912 =(TVEVertexData)Data16_g262888;
					float Out_Dummy15_g262912 = 0.0;
					float3 Out_PositionOS15_g262912 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262912 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262912 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262912 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262912 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262912 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262912 , Out_Dummy15_g262912 , Out_PositionOS15_g262912 , Out_NormalOS15_g262912 , Out_TangentOS15_g262912 , Out_TransformData15_g262912 , Out_RotationData15_g262912 , Out_Interpolator15_g262912 );
					TVEVertexData Data16_g262913 =(TVEVertexData)Data15_g262912;
					half Dummy181_g262899 = ( ( _MotionCategory + _MotionEnd ) + _MotionFlowInfo );
					float In_Dummy16_g262913 = Dummy181_g262899;
					float3 temp_output_3325_0_g262899 = Out_PositionOS15_g262912;
					float3 In_PositionOS16_g262913 = temp_output_3325_0_g262899;
					float3 In_NormalOS16_g262913 = Out_NormalOS15_g262912;
					float4 In_TangentOS16_g262913 = Out_TangentOS15_g262912;
					half4 Vertex_TransformData2743_g262899 = Out_TransformData15_g262912;
					float3 temp_cast_18 = (0.0).xxx;
					half Motion_FlowValue3376_g262899 = _MotionFlowValue;
					float2 lerpResult3361_g262899 = lerp( (half4( 1, 1, 1, 0 )).xy , (TVE_WindParams).xy , ( Motion_FlowValue3376_g262899 * TVE_IsEnabled ));
					float2 Global_WindDirWS2542_g262899 = (lerpResult3361_g262899*2.0 + -1.0);
					half2 Input_WindDirWS803_g262946 = Global_WindDirWS2542_g262899;
					TVEModelData Data15_g262911 =(TVEModelData)Data15_g262889;
					float Out_Dummy15_g262911 = 0.0;
					float3 Out_PositionOS15_g262911 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262911 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262911 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262911 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262911 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262911 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262911 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262911 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262911 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262911 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262911 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262911 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262911 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262911 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262911 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262911 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262911 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262911 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262911 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262911 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262911 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262911 , Out_Dummy15_g262911 , Out_PositionOS15_g262911 , Out_PositionWS15_g262911 , Out_PositionWO15_g262911 , Out_PositionRawOS15_g262911 , Out_PivotOS15_g262911 , Out_PivotWS15_g262911 , Out_PivotWO15_g262911 , Out_NormalOS15_g262911 , Out_NormalWS15_g262911 , Out_NormalRawOS15_g262911 , Out_TangentOS15_g262911 , Out_TangentWS15_g262911 , Out_BitangentWS15_g262911 , Out_ViewDirWS15_g262911 , Out_CoordsData15_g262911 , Out_VertexData15_g262911 , Out_MasksData15_g262911 , Out_PhaseData15_g262911 , Out_TransformData15_g262911 , Out_RotationData15_g262911 , Out_Interpolator15_g262911 );
					float3 Model_PositionWO162_g262899 = Out_PositionWO15_g262911;
					half3 Input_ModelPositionWO761_g262909 = Model_PositionWO162_g262899;
					float3 Model_PivotWO402_g262899 = Out_PivotWO15_g262911;
					half3 Input_ModelPivotsWO419_g262909 = Model_PivotWO402_g262899;
					half Input_MotionPivots629_g262909 = _MotionSmallPivotValue;
					float3 lerpResult771_g262909 = lerp( Input_ModelPositionWO761_g262909 , Input_ModelPivotsWO419_g262909 , Input_MotionPivots629_g262909);
					half4 Model_PhaseData489_g262899 = Out_PhaseData15_g262911;
					half4 Input_ModelMotionData763_g262909 = Model_PhaseData489_g262899;
					half Input_MotionPhase764_g262909 = _MotionSmallPhaseValue;
					float temp_output_770_0_g262909 = ( (Input_ModelMotionData763_g262909).x * Input_MotionPhase764_g262909 );
					half3 Small_Position1421_g262899 = ( lerpResult771_g262909 + temp_output_770_0_g262909 );
					half3 Input_PositionWO419_g262946 = Small_Position1421_g262899;
					half Input_MotionTilling321_g262946 = ( _MotionSmallTillingValue + 0.2 );
					half2 Noise_Coord979_g262946 = ( -(Input_PositionWO419_g262946).xz * Input_MotionTilling321_g262946 * 0.005 );
					float2 Input_Coords80_g262950 = Noise_Coord979_g262946;
					half2 Input_Direction82_g262950 = Input_WindDirWS803_g262946;
					float mulTime113_g262964 = _Time.y * 0.02;
					float lerpResult128_g262964 = lerp( mulTime113_g262964 , ( ( mulTime113_g262964 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					#ifdef SHADER_API_MOBILE
					float staticSwitch134_g262964 = frac( lerpResult128_g262964 );
					#else
					float staticSwitch134_g262964 = lerpResult128_g262964;
					#endif
					float Global_WindTime3262_g262899 = staticSwitch134_g262964;
					half Input_WindTime1015_g262946 = Global_WindTime3262_g262899;
					half Input_MotionSpeed62_g262946 = _MotionSmallSpeedValue;
					float temp_output_986_0_g262946 = ( Input_WindTime1015_g262946 * Input_MotionSpeed62_g262946 );
					half Noise_Speed980_g262946 = temp_output_986_0_g262946;
					float Input_Time88_g262950 = Noise_Speed980_g262946;
					float temp_output_23_0_g262950 = frac( Input_Time88_g262950 );
					float4 lerpResult39_g262950 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g262950 + ( Input_Direction82_g262950 * temp_output_23_0_g262950 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g262950 + ( Input_Direction82_g262950 * ( temp_output_23_0_g262950 - 1.0 ) ) ), 0.0 ) , temp_output_23_0_g262950);
					float4 temp_output_991_0_g262946 = lerpResult39_g262950;
					half2 Noise_DirWS858_g262946 = ((temp_output_991_0_g262946).rg*2.0 + -1.0);
					half Input_MotionNoise552_g262946 = _MotionSmallNoiseValue;
					float4 temp_output_3332_0_g262899 = TVE_FlowParams;
					TVEGlobalData Data15_g262925 =(TVEGlobalData)Data15_g262890;
					float Out_Dummy15_g262925 = 0.0;
					float4 Out_CoatTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g262925 = float4( 0,0,0,0 );
					BreakData( Data15_g262925 , Out_Dummy15_g262925 , Out_CoatTexture15_g262925 , Out_DrawTexture15_g262925 , Out_PaintTexture15_g262925 , Out_AtmoTexture15_g262925 , Out_EffexTexture15_g262925 , Out_GlowTexture15_g262925 , Out_FormTexture15_g262925 , Out_LandTexture15_g262925 , Out_VertxTexture15_g262925 , Out_FlowTexture15_g262925 , Out_UserTexture15_g262925 );
					half4 Global_FlowTexture2668_g262899 = Out_FlowTexture15_g262925;
					#ifdef TVE_MOTION_FLOW
					float4 staticSwitch3075_g262899 = Global_FlowTexture2668_g262899;
					#else
					float4 staticSwitch3075_g262899 = temp_output_3332_0_g262899;
					#endif
					float4 temp_output_6_0_g262926 = staticSwitch3075_g262899;
					float temp_output_7_0_g262926 = _MotionFlowMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g262926 = ( temp_output_6_0_g262926 + temp_output_7_0_g262926 );
					#else
					float4 staticSwitch14_g262926 = temp_output_6_0_g262926;
					#endif
					float4 lerpResult3121_g262899 = lerp( half4( 1, 1, 1, 0 ) , staticSwitch14_g262926 , ( Motion_FlowValue3376_g262899 * TVE_IsEnabled ));
					float temp_output_3077_0_g262899 = (lerpResult3121_g262899).z;
					float temp_output_630_0_g262935 = temp_output_3077_0_g262899;
					float lerpResult853_g262935 = lerp( temp_output_630_0_g262935 , TVE_WindEditor.z , TVE_WindEditor.w);
					half Global_WindValue1855_g262899 = ( lerpResult853_g262935 * _MotionIntensityValue );
					half Input_WindValue881_g262946 = Global_WindValue1855_g262899;
					float temp_output_6_0_g262948 = Input_WindValue881_g262946;
					float lerpResult701_g262946 = lerp( 1.0 , Input_MotionNoise552_g262946 , ( temp_output_6_0_g262948 * temp_output_6_0_g262948 ));
					float2 lerpResult646_g262946 = lerp( Input_WindDirWS803_g262946 , Noise_DirWS858_g262946 , lerpResult701_g262946);
					half2 Small_DirWS817_g262946 = lerpResult646_g262946;
					float2 break823_g262946 = Small_DirWS817_g262946;
					half4 Noise_Params685_g262946 = temp_output_991_0_g262946;
					half Wind_Sinus820_g262946 = ( ((Noise_Params685_g262946).b*2.0 + -1.0) * 0.6 );
					float3 appendResult824_g262946 = (float3(break823_g262946.x , Wind_Sinus820_g262946 , break823_g262946.y));
					half3 Small_Dir918_g262946 = appendResult824_g262946;
					float temp_output_20_0_g262947 = ( 1.0 - Input_WindValue881_g262946 );
					float3 appendResult1006_g262946 = (float3(Input_WindValue881_g262946 , ( 1.0 - ( temp_output_20_0_g262947 * temp_output_20_0_g262947 ) ) , Input_WindValue881_g262946));
					half Input_MotionDelay753_g262946 = _MotionSmallDelayValue;
					float lerpResult756_g262946 = lerp( 1.0 , ( Input_WindValue881_g262946 * Input_WindValue881_g262946 ) , Input_MotionDelay753_g262946);
					half Wind_Delay815_g262946 = lerpResult756_g262946;
					half Input_MotionValue905_g262946 = _MotionSmallIntensityValue;
					float3 temp_output_883_0_g262946 = ( Small_Dir918_g262946 * appendResult1006_g262946 * Wind_Delay815_g262946 * Input_MotionValue905_g262946 );
					float2 break857_g262946 = Noise_DirWS858_g262946;
					float3 appendResult833_g262946 = (float3(break857_g262946.x , Wind_Sinus820_g262946 , break857_g262946.y));
					half3 Push_Dir919_g262946 = appendResult833_g262946;
					half Input_MotionReact924_g262946 = _MotionSmallPushValue;
					half Global_PushAlpha1504_g262899 = (lerpResult3121_g262899).w;
					half Input_PushAlpha806_g262946 = Global_PushAlpha1504_g262899;
					half Global_PushNoise2675_g262899 = temp_output_3077_0_g262899;
					half Input_PushNoise890_g262946 = Global_PushNoise2675_g262899;
					half Push_Mask914_g262946 = saturate( ( Input_PushAlpha806_g262946 * Input_PushNoise890_g262946 * Input_MotionReact924_g262946 ) );
					float3 lerpResult840_g262946 = lerp( temp_output_883_0_g262946 , ( Push_Dir919_g262946 * Input_MotionReact924_g262946 ) , Push_Mask914_g262946);
					#ifdef TVE_MOTION_FLOW
					float3 staticSwitch829_g262946 = lerpResult840_g262946;
					#else
					float3 staticSwitch829_g262946 = temp_output_883_0_g262946;
					#endif
					half3 Small_Squash1489_g262899 = ( mul( unity_WorldToObject, float4( staticSwitch829_g262946 , 0.0 ) ).xyz * ase_parentObjectScale );
					float temp_output_17_0_g262914 = _MotionSmallMaskMode;
					float Option92_g262914 = temp_output_17_0_g262914;
					half4 Model_VertexMasks518_g262899 = Out_VertexData15_g262911;
					float4 temp_output_84_0_g262914 = Model_VertexMasks518_g262899;
					float4 ChannelA92_g262914 = temp_output_84_0_g262914;
					half4 Model_MasksData1322_g262899 = Out_MasksData15_g262911;
					float2 uv_MotionMaskTex2818_g262899 = v.ase_texcoord.xy;
					half4 Motion_MaskTex2819_g262899 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex2818_g262899, 0.0 );
					float3 appendResult3227_g262899 = (float3((Model_MasksData1322_g262899).xy , (Motion_MaskTex2819_g262899).g));
					float3 temp_output_85_0_g262914 = appendResult3227_g262899;
					float4 ChannelB92_g262914 = float4( temp_output_85_0_g262914 , 0.0 );
					float localSwitchChannel792_g262914 = SwitchChannel7( Option92_g262914 , ChannelA92_g262914 , ChannelB92_g262914 );
					float enc1805_g262899 = v.ase_texcoord.z;
					float2 localDecodeFloatToVector21805_g262899 = DecodeFloatToVector2( enc1805_g262899 );
					float2 break1804_g262899 = localDecodeFloatToVector21805_g262899;
					half Small_Mask_Legacy1806_g262899 = break1804_g262899.x;
					#ifdef TVE_LEGACY
					float staticSwitch1800_g262899 = Small_Mask_Legacy1806_g262899;
					#else
					float staticSwitch1800_g262899 = localSwitchChannel792_g262914;
					#endif
					float clampResult17_g262900 = clamp( staticSwitch1800_g262899 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262901 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g262901 = ( clampResult17_g262900 - temp_output_7_0_g262901 );
					half Small_Mask640_g262899 = saturate( ( temp_output_9_0_g262901 * _MotionSmallMaskRemap.z ) );
					float3 lerpResult3022_g262899 = lerp( float3( 1,1,1 ) , (TVE_MotionValueParams).xyz , TVE_MotionValueParams.w);
					half3 Global_MotionParams3013_g262899 = lerpResult3022_g262899;
					half3 Small_Motion789_g262899 = ( Small_Squash1489_g262899 * Small_Mask640_g262899 * (Global_MotionParams3013_g262899).y );
					#ifdef TVE_MOTION
					float3 staticSwitch495_g262899 = Small_Motion789_g262899;
					#else
					float3 staticSwitch495_g262899 = temp_cast_18;
					#endif
					float3 temp_cast_22 = (0.0).xxx;
					half3 Tiny_Position2469_g262899 = Model_PositionWO162_g262899;
					half3 Input_PositionWO419_g262965 = Tiny_Position2469_g262899;
					half Input_MotionTilling321_g262965 = ( _MotionTinyTillingValue + 0.2 );
					half2 Noise_Coord979_g262965 = ( -(Input_PositionWO419_g262965).xz * Input_MotionTilling321_g262965 * 0.005 );
					float2 Input_Coords80_g262972 = Noise_Coord979_g262965;
					half2 Input_Direction82_g262972 = float2( 0,1 );
					half Input_WindTime1015_g262965 = Global_WindTime3262_g262899;
					half Input_MotionSpeed62_g262965 = _MotionTinySpeedValue;
					float temp_output_986_0_g262965 = ( Input_WindTime1015_g262965 * Input_MotionSpeed62_g262965 );
					half Noise_Speed980_g262965 = temp_output_986_0_g262965;
					float Input_Time88_g262972 = Noise_Speed980_g262965;
					float4 temp_output_991_0_g262965 = SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g262972 + ( Input_Direction82_g262972 * Input_Time88_g262972 ) ), 0.0 );
					half3 Noise_DirWS858_g262965 = ((temp_output_991_0_g262965).rgb*2.0 + -1.0);
					half Input_MotionNoise552_g262965 = _MotionTinyNoiseValue;
					float3 lerpResult646_g262965 = lerp( ( Noise_DirWS858_g262965 * v.normal ) , Noise_DirWS858_g262965 , Input_MotionNoise552_g262965);
					half3 Tiny_DirWS817_g262965 = lerpResult646_g262965;
					half Input_MotionValue905_g262965 = _MotionTinyIntensityValue;
					float mulTime113_g262978 = _Time.y * 2.0;
					float lerpResult128_g262978 = lerp( mulTime113_g262978 , ( ( mulTime113_g262978 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					#ifdef SHADER_API_MOBILE
					float staticSwitch134_g262978 = frac( lerpResult128_g262978 );
					#else
					float staticSwitch134_g262978 = lerpResult128_g262978;
					#endif
					float3 temp_output_1028_0_g262965 = ( Input_PositionWO419_g262965 + staticSwitch134_g262978 );
					float temp_output_1054_0_g262965 = SAMPLE_TEXTURE3D_LOD( _NoiseTex3D, sampler_Linear_Repeat, ( temp_output_1028_0_g262965 * ( 1.0 * 0.01 ) ), 0.0 ).r;
					float temp_output_6_0_g262968 = temp_output_1054_0_g262965;
					float temp_output_6_0_g262969 = temp_output_1054_0_g262965;
					half Input_WindValue881_g262965 = Global_WindValue1855_g262899;
					float temp_output_6_0_g262971 = Input_WindValue881_g262965;
					float lerpResult1029_g262965 = lerp( ( temp_output_6_0_g262968 * temp_output_6_0_g262968 * temp_output_6_0_g262968 * temp_output_6_0_g262968 ) , ( temp_output_6_0_g262969 * temp_output_6_0_g262969 ) , ( temp_output_6_0_g262971 * temp_output_6_0_g262971 ));
					float temp_output_20_0_g262970 = ( 1.0 - Input_WindValue881_g262965 );
					float temp_output_1030_0_g262965 = ( lerpResult1029_g262965 * ( 1.0 - ( temp_output_20_0_g262970 * temp_output_20_0_g262970 * temp_output_20_0_g262970 * temp_output_20_0_g262970 ) ) );
					half Wind_Gust1039_g262965 = temp_output_1030_0_g262965;
					float3 temp_output_883_0_g262965 = ( Tiny_DirWS817_g262965 * Input_MotionValue905_g262965 * Wind_Gust1039_g262965 );
					half3 Tiny_Squash859_g262899 = temp_output_883_0_g262965;
					float temp_output_17_0_g262915 = _MotionTinyMaskMode;
					float Option92_g262915 = temp_output_17_0_g262915;
					float4 temp_output_84_0_g262915 = Model_VertexMasks518_g262899;
					float4 ChannelA92_g262915 = temp_output_84_0_g262915;
					float3 appendResult3234_g262899 = (float3((Model_MasksData1322_g262899).xy , (Motion_MaskTex2819_g262899).b));
					float3 temp_output_85_0_g262915 = appendResult3234_g262899;
					float4 ChannelB92_g262915 = float4( temp_output_85_0_g262915 , 0.0 );
					float localSwitchChannel792_g262915 = SwitchChannel7( Option92_g262915 , ChannelA92_g262915 , ChannelB92_g262915 );
					half Tiny_Mask_Legacy1807_g262899 = break1804_g262899.y;
					#ifdef TVE_LEGACY
					float staticSwitch1810_g262899 = Tiny_Mask_Legacy1807_g262899;
					#else
					float staticSwitch1810_g262899 = localSwitchChannel792_g262915;
					#endif
					float clampResult17_g262902 = clamp( staticSwitch1810_g262899 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262903 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g262903 = ( clampResult17_g262902 - temp_output_7_0_g262903 );
					half Tiny_Mask218_g262899 = saturate( ( temp_output_9_0_g262903 * _MotionTinyMaskRemap.z ) );
					float3 Model_PositionWS1819_g262899 = Out_PositionWS15_g262911;
					half Global_DistMask1820_g262899 = ( 1.0 - saturate( ( distance( _WorldSpaceCameraPos , Model_PositionWS1819_g262899 ) / _MotionDistValue ) ) );
					half3 Tiny_Flutter1451_g262899 = ( Tiny_Squash859_g262899 * Tiny_Mask218_g262899 * Global_DistMask1820_g262899 * (Global_MotionParams3013_g262899).z );
					#ifdef TVE_MOTION
					float3 staticSwitch414_g262899 = Tiny_Flutter1451_g262899;
					#else
					float3 staticSwitch414_g262899 = temp_cast_22;
					#endif
					float4 appendResult2783_g262899 = (float4(( staticSwitch495_g262899 + staticSwitch414_g262899 ) , 0.0));
					half4 Final_TransformData1569_g262899 = ( Vertex_TransformData2743_g262899 + appendResult2783_g262899 );
					float4 In_TransformData16_g262913 = Final_TransformData1569_g262899;
					half4 Vertex_RotationData2740_g262899 = Out_RotationData15_g262912;
					half2 Input_WindDirWS803_g262936 = Global_WindDirWS2542_g262899;
					half3 Input_ModelPositionWO761_g262910 = Model_PositionWO162_g262899;
					half3 Input_ModelPivotsWO419_g262910 = Model_PivotWO402_g262899;
					half Input_MotionPivots629_g262910 = _MotionBasePivotValue;
					float3 lerpResult771_g262910 = lerp( Input_ModelPositionWO761_g262910 , Input_ModelPivotsWO419_g262910 , Input_MotionPivots629_g262910);
					half4 Input_ModelMotionData763_g262910 = Model_PhaseData489_g262899;
					half Input_MotionPhase764_g262910 = _MotionBasePhaseValue;
					float temp_output_770_0_g262910 = ( (Input_ModelMotionData763_g262910).x * Input_MotionPhase764_g262910 );
					half3 Base_Position1394_g262899 = ( lerpResult771_g262910 + temp_output_770_0_g262910 );
					half3 Input_PositionWO419_g262936 = Base_Position1394_g262899;
					half Input_MotionTilling321_g262936 = ( _MotionBaseTillingValue + 0.2 );
					half2 Noise_Coord515_g262936 = ( -(Input_PositionWO419_g262936).xz * Input_MotionTilling321_g262936 * 0.005 );
					float2 Input_Coords80_g262938 = Noise_Coord515_g262936;
					half2 Input_Direction82_g262938 = Input_WindDirWS803_g262936;
					half Input_WindTime963_g262936 = Global_WindTime3262_g262899;
					half Input_MotionSpeed62_g262936 = _MotionBaseSpeedValue;
					float temp_output_505_0_g262936 = ( Input_WindTime963_g262936 * Input_MotionSpeed62_g262936 );
					half Noise_Speed516_g262936 = temp_output_505_0_g262936;
					float Input_Time88_g262938 = Noise_Speed516_g262936;
					float temp_output_23_0_g262938 = frac( Input_Time88_g262938 );
					float4 lerpResult39_g262938 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g262938 + ( Input_Direction82_g262938 * temp_output_23_0_g262938 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g262938 + ( Input_Direction82_g262938 * ( temp_output_23_0_g262938 - 1.0 ) ) ), 0.0 ) , temp_output_23_0_g262938);
					float4 temp_output_635_0_g262936 = lerpResult39_g262938;
					half2 Noise_DirWS825_g262936 = ((temp_output_635_0_g262936).rg*2.0 + -1.0);
					half Input_MotionNoise552_g262936 = _MotionBaseNoiseValue;
					half Input_WindValue853_g262936 = Global_WindValue1855_g262899;
					float temp_output_6_0_g262937 = Input_WindValue853_g262936;
					float lerpResult701_g262936 = lerp( 1.0 , Input_MotionNoise552_g262936 , ( temp_output_6_0_g262937 * temp_output_6_0_g262937 ));
					float2 lerpResult646_g262936 = lerp( Input_WindDirWS803_g262936 , Noise_DirWS825_g262936 , lerpResult701_g262936);
					half2 Bend_Dir859_g262936 = lerpResult646_g262936;
					half Input_MotionValue871_g262936 = _MotionBaseIntensityValue;
					half Input_MotionDelay753_g262936 = _MotionBaseDelayValue;
					float lerpResult756_g262936 = lerp( 1.0 , ( Input_WindValue853_g262936 * Input_WindValue853_g262936 ) , Input_MotionDelay753_g262936);
					half Wind_Delay815_g262936 = lerpResult756_g262936;
					float2 temp_output_875_0_g262936 = ( Bend_Dir859_g262936 * Input_WindValue853_g262936 * Input_MotionValue871_g262936 * Wind_Delay815_g262936 );
					float2 Global_PushDirWS1972_g262899 = ((lerpResult3121_g262899).xy*2.0 + -1.0);
					half2 Input_PushDirWS807_g262936 = Global_PushDirWS1972_g262899;
					half Input_ReactValue888_g262936 = _MotionBasePushValue;
					half Input_PushAlpha806_g262936 = Global_PushAlpha1504_g262899;
					half Push_Mask883_g262936 = saturate( ( Input_PushAlpha806_g262936 * Input_ReactValue888_g262936 ) );
					float2 lerpResult811_g262936 = lerp( temp_output_875_0_g262936 , ( Input_PushDirWS807_g262936 * Input_ReactValue888_g262936 ) , Push_Mask883_g262936);
					#ifdef TVE_MOTION_FLOW
					float2 staticSwitch808_g262936 = lerpResult811_g262936;
					#else
					float2 staticSwitch808_g262936 = temp_output_875_0_g262936;
					#endif
					float2 temp_output_38_0_g262942 = staticSwitch808_g262936;
					float2 break83_g262942 = temp_output_38_0_g262942;
					float3 appendResult79_g262942 = (float3(break83_g262942.x , 0.0 , break83_g262942.y));
					half2 Base_Bending893_g262899 = (( mul( unity_WorldToObject, float4( appendResult79_g262942 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
					float temp_output_17_0_g262916 = _MotionBaseMaskMode;
					float Option92_g262916 = temp_output_17_0_g262916;
					float4 temp_output_84_0_g262916 = Model_VertexMasks518_g262899;
					float4 ChannelA92_g262916 = temp_output_84_0_g262916;
					float3 appendResult3220_g262899 = (float3((Model_MasksData1322_g262899).xy , (Motion_MaskTex2819_g262899).r));
					float3 temp_output_85_0_g262916 = appendResult3220_g262899;
					float4 ChannelB92_g262916 = float4( temp_output_85_0_g262916 , 0.0 );
					float localSwitchChannel792_g262916 = SwitchChannel7( Option92_g262916 , ChannelA92_g262916 , ChannelB92_g262916 );
					float clampResult17_g262905 = clamp( localSwitchChannel792_g262916 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262904 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g262904 = ( clampResult17_g262905 - temp_output_7_0_g262904 );
					half Base_Mask217_g262899 = saturate( ( temp_output_9_0_g262904 * _MotionBaseMaskRemap.z ) );
					half2 Base_Motion1440_g262899 = ( Base_Bending893_g262899 * Base_Mask217_g262899 * (Global_MotionParams3013_g262899).x );
					#ifdef TVE_MOTION
					float2 staticSwitch2384_g262899 = Base_Motion1440_g262899;
					#else
					float2 staticSwitch2384_g262899 = float2( 0,0 );
					#endif
					float4 appendResult2023_g262899 = (float4(staticSwitch2384_g262899 , 0.0 , 0.0));
					half4 Final_RotationData1570_g262899 = ( Vertex_RotationData2740_g262899 + appendResult2023_g262899 );
					float4 In_RotationData16_g262913 = Final_RotationData1570_g262899;
					half4 Vertex_Interpolator2773_g262899 = Out_Interpolator15_g262912;
					half4 Noise_Params685_g262936 = temp_output_635_0_g262936;
					float temp_output_6_0_g262944 = (Noise_Params685_g262936).a;
					float temp_output_913_0_g262936 = ( ( temp_output_6_0_g262944 * temp_output_6_0_g262944 * temp_output_6_0_g262944 * temp_output_6_0_g262944 ) * ( Input_WindValue853_g262936 * Wind_Delay815_g262936 ) );
					float temp_output_6_0_g262945 = length( Input_PushDirWS807_g262936 );
					float temp_output_937_0_g262936 = ( temp_output_6_0_g262945 * temp_output_6_0_g262945 );
					half Input_PushNoise858_g262936 = Global_PushNoise2675_g262899;
					float lerpResult902_g262936 = lerp( temp_output_913_0_g262936 , temp_output_937_0_g262936 , ( Push_Mask883_g262936 * Input_PushNoise858_g262936 ));
					#ifdef TVE_MOTION_FLOW
					float staticSwitch903_g262936 = lerpResult902_g262936;
					#else
					float staticSwitch903_g262936 = temp_output_913_0_g262936;
					#endif
					half Base_Wave1159_g262899 = staticSwitch903_g262936;
					float temp_output_6_0_g262949 = (Noise_Params685_g262946).a;
					float temp_output_955_0_g262946 = ( temp_output_6_0_g262949 * temp_output_6_0_g262949 * temp_output_6_0_g262949 * temp_output_6_0_g262949 );
					float temp_output_944_0_g262946 = ( temp_output_955_0_g262946 * ( Input_WindValue881_g262946 * Wind_Delay815_g262946 ) );
					float lerpResult936_g262946 = lerp( temp_output_944_0_g262946 , temp_output_955_0_g262946 , ( Push_Mask914_g262946 * Input_PushNoise890_g262946 ));
					#ifdef TVE_MOTION_FLOW
					float staticSwitch939_g262946 = lerpResult936_g262946;
					#else
					float staticSwitch939_g262946 = temp_output_944_0_g262946;
					#endif
					half Small_Wave1427_g262899 = staticSwitch939_g262946;
					float lerpResult2422_g262899 = lerp( Base_Wave1159_g262899 , Small_Wave1427_g262899 , _motion_small_mode);
					half Global_Wave1475_g262899 = saturate( lerpResult2422_g262899 );
					float temp_output_6_0_g262906 = ( _MotionHighlightValue * Global_DistMask1820_g262899 * ( Tiny_Mask218_g262899 * Tiny_Mask218_g262899 ) * Global_Wave1475_g262899 );
					float temp_output_7_0_g262906 = _MotionHighlightColor.r;
					#ifdef TVE_DUMMY
					float staticSwitch14_g262906 = ( temp_output_6_0_g262906 + temp_output_7_0_g262906 );
					#else
					float staticSwitch14_g262906 = temp_output_6_0_g262906;
					#endif
					#ifdef TVE_MOTION
					float staticSwitch2866_g262899 = staticSwitch14_g262906;
					#else
					float staticSwitch2866_g262899 = 0.0;
					#endif
					float4 appendResult2775_g262899 = (float4((Vertex_Interpolator2773_g262899).xyz , staticSwitch2866_g262899));
					half4 Final_Interpolator2774_g262899 = appendResult2775_g262899;
					float4 In_Interpolator16_g262913 = Final_Interpolator2774_g262899;
					BuildVertexData( Data16_g262913 , In_Dummy16_g262913 , In_PositionOS16_g262913 , In_NormalOS16_g262913 , In_TangentOS16_g262913 , In_TransformData16_g262913 , In_RotationData16_g262913 , In_Interpolator16_g262913 );
					TVEVertexData Data15_g262988 =(TVEVertexData)Data16_g262913;
					float Out_Dummy15_g262988 = 0.0;
					float3 Out_PositionOS15_g262988 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262988 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262988 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262988 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262988 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262988 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262988 , Out_Dummy15_g262988 , Out_PositionOS15_g262988 , Out_NormalOS15_g262988 , Out_TangentOS15_g262988 , Out_TransformData15_g262988 , Out_RotationData15_g262988 , Out_Interpolator15_g262988 );
					TVEVertexData Data16_g262989 =(TVEVertexData)Data15_g262988;
					float In_Dummy16_g262989 = 0.0;
					float3 Vertex_PositionOS147_g262979 = Out_PositionOS15_g262988;
					half3 VertexPos40_g262983 = Vertex_PositionOS147_g262979;
					float4 temp_output_1615_33_g262979 = Out_RotationData15_g262988;
					half4 Vertex_RotationData1569_g262979 = temp_output_1615_33_g262979;
					float2 break1582_g262979 = (Vertex_RotationData1569_g262979).xy;
					half Angle44_g262983 = break1582_g262979.y;
					half CosAngle89_g262983 = cos( Angle44_g262983 );
					half SinAngle93_g262983 = sin( Angle44_g262983 );
					float3 appendResult95_g262983 = (float3((VertexPos40_g262983).x , ( ( (VertexPos40_g262983).y * CosAngle89_g262983 ) - ( (VertexPos40_g262983).z * SinAngle93_g262983 ) ) , ( ( (VertexPos40_g262983).y * SinAngle93_g262983 ) + ( (VertexPos40_g262983).z * CosAngle89_g262983 ) )));
					half3 VertexPos40_g262984 = appendResult95_g262983;
					half Angle44_g262984 = -break1582_g262979.x;
					half CosAngle94_g262984 = cos( Angle44_g262984 );
					half SinAngle95_g262984 = sin( Angle44_g262984 );
					float3 appendResult98_g262984 = (float3(( ( (VertexPos40_g262984).x * CosAngle94_g262984 ) - ( (VertexPos40_g262984).y * SinAngle95_g262984 ) ) , ( ( (VertexPos40_g262984).x * SinAngle95_g262984 ) + ( (VertexPos40_g262984).y * CosAngle94_g262984 ) ) , (VertexPos40_g262984).z));
					half3 VertexPos40_g262982 = Vertex_PositionOS147_g262979;
					half Angle44_g262982 = break1582_g262979.y;
					half CosAngle89_g262982 = cos( Angle44_g262982 );
					half SinAngle93_g262982 = sin( Angle44_g262982 );
					float3 appendResult95_g262982 = (float3((VertexPos40_g262982).x , ( ( (VertexPos40_g262982).y * CosAngle89_g262982 ) - ( (VertexPos40_g262982).z * SinAngle93_g262982 ) ) , ( ( (VertexPos40_g262982).y * SinAngle93_g262982 ) + ( (VertexPos40_g262982).z * CosAngle89_g262982 ) )));
					half3 VertexPos40_g262987 = appendResult95_g262982;
					half Angle44_g262987 = break1582_g262979.x;
					half CosAngle91_g262987 = cos( Angle44_g262987 );
					half SinAngle92_g262987 = sin( Angle44_g262987 );
					float3 appendResult93_g262987 = (float3(( ( (VertexPos40_g262987).x * CosAngle91_g262987 ) + ( (VertexPos40_g262987).z * SinAngle92_g262987 ) ) , (VertexPos40_g262987).y , ( ( -(VertexPos40_g262987).x * SinAngle92_g262987 ) + ( (VertexPos40_g262987).z * CosAngle91_g262987 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262985 = appendResult93_g262987;
					#else
					float3 staticSwitch65_g262985 = appendResult98_g262984;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g262980 = staticSwitch65_g262985;
					#else
					float3 staticSwitch65_g262980 = Vertex_PositionOS147_g262979;
					#endif
					float3 temp_output_1608_0_g262979 = staticSwitch65_g262980;
					half3 VertexPos40_g262986 = temp_output_1608_0_g262979;
					half Angle44_g262986 = (Vertex_RotationData1569_g262979).z;
					half CosAngle91_g262986 = cos( Angle44_g262986 );
					half SinAngle92_g262986 = sin( Angle44_g262986 );
					float3 appendResult93_g262986 = (float3(( ( (VertexPos40_g262986).x * CosAngle91_g262986 ) + ( (VertexPos40_g262986).z * SinAngle92_g262986 ) ) , (VertexPos40_g262986).y , ( ( -(VertexPos40_g262986).x * SinAngle92_g262986 ) + ( (VertexPos40_g262986).z * CosAngle91_g262986 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g262981 = appendResult93_g262986;
					#else
					float3 staticSwitch65_g262981 = temp_output_1608_0_g262979;
					#endif
					float4 temp_output_1615_31_g262979 = Out_TransformData15_g262988;
					half4 Vertex_TransformData1568_g262979 = temp_output_1615_31_g262979;
					half3 Final_PositionOS178_g262979 = ( ( staticSwitch65_g262981 * (Vertex_TransformData1568_g262979).w ) + (Vertex_TransformData1568_g262979).xyz );
					float3 In_PositionOS16_g262989 = Final_PositionOS178_g262979;
					float3 In_NormalOS16_g262989 = Out_NormalOS15_g262988;
					float4 In_TangentOS16_g262989 = Out_TangentOS15_g262988;
					float4 In_TransformData16_g262989 = temp_output_1615_31_g262979;
					float4 In_RotationData16_g262989 = temp_output_1615_33_g262979;
					float4 In_Interpolator16_g262989 = Out_Interpolator15_g262988;
					BuildVertexData( Data16_g262989 , In_Dummy16_g262989 , In_PositionOS16_g262989 , In_NormalOS16_g262989 , In_TangentOS16_g262989 , In_TransformData16_g262989 , In_RotationData16_g262989 , In_Interpolator16_g262989 );
					TVEVertexData Data15_g262999 =(TVEVertexData)Data16_g262989;
					float Out_Dummy15_g262999 = 0.0;
					float3 Out_PositionOS15_g262999 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262999 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262999 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262999 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262999 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262999 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262999 , Out_Dummy15_g262999 , Out_PositionOS15_g262999 , Out_NormalOS15_g262999 , Out_TangentOS15_g262999 , Out_TransformData15_g262999 , Out_RotationData15_g262999 , Out_Interpolator15_g262999 );
					TVEVertexData Data16_g263000 =(TVEVertexData)Data15_g262999;
					half Dummy1823_g262990 = ( _FlattenCategory + _FlattenEnd + _FlattenBakeMode );
					float In_Dummy16_g263000 = Dummy1823_g262990;
					float3 In_PositionOS16_g263000 = Out_PositionOS15_g262999;
					half3 Vertex_NormalOS1829_g262990 = Out_NormalOS15_g262999;
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262991 = half3( 0, 0, 1 );
					#else
					float3 staticSwitch65_g262991 = half3( 0, 1, 0 );
					#endif
					float3 lerpResult1820_g262990 = lerp( Vertex_NormalOS1829_g262990 , staticSwitch65_g262991 , _FlattenUpwardsValue);
					TVEModelData Data15_g263001 =(TVEModelData)Data15_g262911;
					float Out_Dummy15_g263001 = 0.0;
					float3 Out_PositionOS15_g263001 = float3( 0,0,0 );
					float3 Out_PositionWS15_g263001 = float3( 0,0,0 );
					float3 Out_PositionWO15_g263001 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g263001 = float3( 0,0,0 );
					float3 Out_PivotOS15_g263001 = float3( 0,0,0 );
					float3 Out_PivotWS15_g263001 = float3( 0,0,0 );
					float3 Out_PivotWO15_g263001 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263001 = float3( 0,0,0 );
					float3 Out_NormalWS15_g263001 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g263001 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263001 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g263001 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g263001 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g263001 = float3( 0,0,0 );
					float4 Out_CoordsData15_g263001 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g263001 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g263001 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g263001 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263001 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263001 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263001 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g263001 , Out_Dummy15_g263001 , Out_PositionOS15_g263001 , Out_PositionWS15_g263001 , Out_PositionWO15_g263001 , Out_PositionRawOS15_g263001 , Out_PivotOS15_g263001 , Out_PivotWS15_g263001 , Out_PivotWO15_g263001 , Out_NormalOS15_g263001 , Out_NormalWS15_g263001 , Out_NormalRawOS15_g263001 , Out_TangentOS15_g263001 , Out_TangentWS15_g263001 , Out_BitangentWS15_g263001 , Out_ViewDirWS15_g263001 , Out_CoordsData15_g263001 , Out_VertexData15_g263001 , Out_MasksData15_g263001 , Out_PhaseData15_g263001 , Out_TransformData15_g263001 , Out_RotationData15_g263001 , Out_Interpolator15_g263001 );
					float3 Model_PositionOS1837_g262990 = Out_PositionOS15_g263001;
					float3 normalizeResult1816_g262990 = ASESafeNormalize( ( Model_PositionOS1837_g262990 + _FlattenSphereOffsetValue ) );
					float3 lerpResult1813_g262990 = lerp( lerpResult1820_g262990 , normalizeResult1816_g262990 , _FlattenSphereValue);
					float temp_output_17_0_g262998 = _FlattenMeshMode;
					float Option70_g262998 = temp_output_17_0_g262998;
					half4 Model_VertexData1826_g262990 = Out_VertexData15_g263001;
					float4 temp_output_3_0_g262998 = Model_VertexData1826_g262990;
					float4 Channel70_g262998 = temp_output_3_0_g262998;
					float localSwitchChannel470_g262998 = SwitchChannel4( Option70_g262998 , Channel70_g262998 );
					float clampResult17_g262992 = clamp( localSwitchChannel470_g262998 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262993 = _FlattenMeshRemap.x;
					float temp_output_9_0_g262993 = ( clampResult17_g262992 - temp_output_7_0_g262993 );
					float lerpResult1841_g262990 = lerp( 1.0 , saturate( ( temp_output_9_0_g262993 * _FlattenMeshRemap.z ) ) , _FlattenMeshValue);
					half Normal_MeskMask1847_g262990 = lerpResult1841_g262990;
					half Normal_Mask1851_g262990 = Normal_MeskMask1847_g262990;
					float3 lerpResult1856_g262990 = lerp( Vertex_NormalOS1829_g262990 , lerpResult1813_g262990 , ( Normal_Mask1851_g262990 * _FlattenIntensityValue ));
					#ifdef TVE_FLATTEN
					float3 staticSwitch1857_g262990 = lerpResult1856_g262990;
					#else
					float3 staticSwitch1857_g262990 = Vertex_NormalOS1829_g262990;
					#endif
					half3 Final_NormalOS1853_g262990 = staticSwitch1857_g262990;
					float3 In_NormalOS16_g263000 = Final_NormalOS1853_g262990;
					float4 In_TangentOS16_g263000 = Out_TangentOS15_g262999;
					float4 In_TransformData16_g263000 = Out_TransformData15_g262999;
					float4 In_RotationData16_g263000 = Out_RotationData15_g262999;
					float4 In_Interpolator16_g263000 = Out_Interpolator15_g262999;
					BuildVertexData( Data16_g263000 , In_Dummy16_g263000 , In_PositionOS16_g263000 , In_NormalOS16_g263000 , In_TangentOS16_g263000 , In_TransformData16_g263000 , In_RotationData16_g263000 , In_Interpolator16_g263000 );
					TVEVertexData Data15_g263010 =(TVEVertexData)Data16_g263000;
					float Out_Dummy15_g263010 = 0.0;
					float3 Out_PositionOS15_g263010 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263010 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263010 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263010 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263010 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263010 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g263010 , Out_Dummy15_g263010 , Out_PositionOS15_g263010 , Out_NormalOS15_g263010 , Out_TangentOS15_g263010 , Out_TransformData15_g263010 , Out_RotationData15_g263010 , Out_Interpolator15_g263010 );
					TVEVertexData Data16_g263011 =(TVEVertexData)Data15_g263010;
					half Dummy1575_g263002 = ( _ReshadeCategory + _ReshadeEnd + _ReshadeInfo );
					float In_Dummy16_g263011 = Dummy1575_g263002;
					float3 In_PositionOS16_g263011 = Out_PositionOS15_g263010;
					half3 Vertex_NormalOS1568_g263002 = Out_NormalOS15_g263010;
					half3 VertexPos40_g263004 = Vertex_NormalOS1568_g263002;
					half3 VertexPos40_g263005 = VertexPos40_g263004;
					float4 temp_output_1818_33_g263002 = Out_RotationData15_g263010;
					half4 Vertex_RotationData1583_g263002 = temp_output_1818_33_g263002;
					half2 Angle44_g263004 = Vertex_RotationData1583_g263002.xy;
					half Angle44_g263005 = (Angle44_g263004).y;
					half CosAngle89_g263005 = cos( Angle44_g263005 );
					half SinAngle93_g263005 = sin( Angle44_g263005 );
					float3 appendResult95_g263005 = (float3((VertexPos40_g263005).x , ( ( (VertexPos40_g263005).y * CosAngle89_g263005 ) - ( (VertexPos40_g263005).z * SinAngle93_g263005 ) ) , ( ( (VertexPos40_g263005).y * SinAngle93_g263005 ) + ( (VertexPos40_g263005).z * CosAngle89_g263005 ) )));
					half3 VertexPos40_g263006 = appendResult95_g263005;
					half Angle44_g263006 = -(Angle44_g263004).x;
					half CosAngle94_g263006 = cos( Angle44_g263006 );
					half SinAngle95_g263006 = sin( Angle44_g263006 );
					float3 appendResult98_g263006 = (float3(( ( (VertexPos40_g263006).x * CosAngle94_g263006 ) - ( (VertexPos40_g263006).y * SinAngle95_g263006 ) ) , ( ( (VertexPos40_g263006).x * SinAngle95_g263006 ) + ( (VertexPos40_g263006).y * CosAngle94_g263006 ) ) , (VertexPos40_g263006).z));
					float3 lerpResult1591_g263002 = lerp( Vertex_NormalOS1568_g263002 , appendResult98_g263006 , _ReshadeIntensityValue);
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g263003 = lerpResult1591_g263002;
					#else
					float3 staticSwitch65_g263003 = Vertex_NormalOS1568_g263002;
					#endif
					float3 temp_output_1732_0_g263002 = staticSwitch65_g263003;
					#ifdef TVE_RESHADE
					float3 staticSwitch1716_g263002 = temp_output_1732_0_g263002;
					#else
					float3 staticSwitch1716_g263002 = Vertex_NormalOS1568_g263002;
					#endif
					half3 Final_NormalOS178_g263002 = staticSwitch1716_g263002;
					float3 In_NormalOS16_g263011 = Final_NormalOS178_g263002;
					float4 In_TangentOS16_g263011 = Out_TangentOS15_g263010;
					float4 In_TransformData16_g263011 = Out_TransformData15_g263010;
					float4 In_RotationData16_g263011 = temp_output_1818_33_g263002;
					float4 In_Interpolator16_g263011 = Out_Interpolator15_g263010;
					BuildVertexData( Data16_g263011 , In_Dummy16_g263011 , In_PositionOS16_g263011 , In_NormalOS16_g263011 , In_TangentOS16_g263011 , In_TransformData16_g263011 , In_RotationData16_g263011 , In_Interpolator16_g263011 );
					TVEVertexData Data15_g263133 =(TVEVertexData)Data16_g263011;
					float Out_Dummy15_g263133 = 0.0;
					float3 Out_PositionOS15_g263133 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263133 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263133 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263133 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263133 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263133 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g263133 , Out_Dummy15_g263133 , Out_PositionOS15_g263133 , Out_NormalOS15_g263133 , Out_TangentOS15_g263133 , Out_TransformData15_g263133 , Out_RotationData15_g263133 , Out_Interpolator15_g263133 );
					TVEVertexData Data16_g263134 =(TVEVertexData)Data15_g263133;
					half Dummy1575_g263126 = ( _TransferCategory + _TransferEnd + _TransferInfo + _TransferSpace );
					float In_Dummy16_g263134 = Dummy1575_g263126;
					float3 In_PositionOS16_g263134 = Out_PositionOS15_g263133;
					half3 Vertex_NormalOS1568_g263126 = Out_NormalOS15_g263133;
					TVEGlobalData Data15_g263132 =(TVEGlobalData)Data15_g262925;
					float Out_Dummy15_g263132 = 0.0;
					float4 Out_CoatTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g263132 = float4( 0,0,0,0 );
					BreakData( Data15_g263132 , Out_Dummy15_g263132 , Out_CoatTexture15_g263132 , Out_DrawTexture15_g263132 , Out_PaintTexture15_g263132 , Out_AtmoTexture15_g263132 , Out_EffexTexture15_g263132 , Out_GlowTexture15_g263132 , Out_FormTexture15_g263132 , Out_LandTexture15_g263132 , Out_VertxTexture15_g263132 , Out_FlowTexture15_g263132 , Out_UserTexture15_g263132 );
					half4 Global_FormTexture1633_g263126 = Out_FormTexture15_g263132;
					float2 temp_output_1627_0_g263126 = ((Global_FormTexture1633_g263126).xy*2.0 + -1.0);
					float2 break1617_g263126 = temp_output_1627_0_g263126;
					float dotResult1619_g263126 = dot( temp_output_1627_0_g263126 , temp_output_1627_0_g263126 );
					float3 appendResult1618_g263126 = (float3(break1617_g263126.x , sqrt( ( 1.0 - saturate( dotResult1619_g263126 ) ) ) , break1617_g263126.y));
					float3 worldToObjDir1623_g263126 = mul( unity_WorldToObject, float4( appendResult1618_g263126, 0.0 ) ).xyz;
					half3 Surface_Normal1630_g263126 = worldToObjDir1623_g263126;
					float temp_output_17_0_g263137 = _TransferMeshMode;
					float Option70_g263137 = temp_output_17_0_g263137;
					TVEModelData Data15_g263127 =(TVEModelData)Data15_g263001;
					float Out_Dummy15_g263127 = 0.0;
					float3 Out_PositionOS15_g263127 = float3( 0,0,0 );
					float3 Out_PositionWS15_g263127 = float3( 0,0,0 );
					float3 Out_PositionWO15_g263127 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g263127 = float3( 0,0,0 );
					float3 Out_PivotOS15_g263127 = float3( 0,0,0 );
					float3 Out_PivotWS15_g263127 = float3( 0,0,0 );
					float3 Out_PivotWO15_g263127 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263127 = float3( 0,0,0 );
					float3 Out_NormalWS15_g263127 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g263127 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263127 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g263127 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g263127 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g263127 = float3( 0,0,0 );
					float4 Out_CoordsData15_g263127 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g263127 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g263127 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g263127 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263127 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263127 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263127 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g263127 , Out_Dummy15_g263127 , Out_PositionOS15_g263127 , Out_PositionWS15_g263127 , Out_PositionWO15_g263127 , Out_PositionRawOS15_g263127 , Out_PivotOS15_g263127 , Out_PivotWS15_g263127 , Out_PivotWO15_g263127 , Out_NormalOS15_g263127 , Out_NormalWS15_g263127 , Out_NormalRawOS15_g263127 , Out_TangentOS15_g263127 , Out_TangentWS15_g263127 , Out_BitangentWS15_g263127 , Out_ViewDirWS15_g263127 , Out_CoordsData15_g263127 , Out_VertexData15_g263127 , Out_MasksData15_g263127 , Out_PhaseData15_g263127 , Out_TransformData15_g263127 , Out_RotationData15_g263127 , Out_Interpolator15_g263127 );
					float4 temp_output_1567_29_g263126 = Out_VertexData15_g263127;
					half4 Model_VertexData1608_g263126 = temp_output_1567_29_g263126;
					float4 temp_output_3_0_g263137 = Model_VertexData1608_g263126;
					float4 Channel70_g263137 = temp_output_3_0_g263137;
					float localSwitchChannel470_g263137 = SwitchChannel4( Option70_g263137 , Channel70_g263137 );
					float temp_output_1870_0_g263126 = localSwitchChannel470_g263137;
					float temp_output_7_0_g263136 = _TransferMeshRemap.x;
					float temp_output_9_0_g263136 = ( temp_output_1870_0_g263126 - temp_output_7_0_g263136 );
					float lerpResult1868_g263126 = lerp( 1.0 , saturate( ( temp_output_9_0_g263136 * _TransferMeshRemap.z ) ) , _TransferMeshValue);
					half Blend_MeshMask1876_g263126 = lerpResult1868_g263126;
					half Blend_Mask1742_g263126 = ( _TransferIntensityValue * Blend_MeshMask1876_g263126 * TVE_IsEnabled );
					float3 lerpResult1670_g263126 = lerp( Vertex_NormalOS1568_g263126 , Surface_Normal1630_g263126 , Blend_Mask1742_g263126);
					#ifdef TVE_TRANSFER
					float3 staticSwitch1716_g263126 = lerpResult1670_g263126;
					#else
					float3 staticSwitch1716_g263126 = Vertex_NormalOS1568_g263126;
					#endif
					half3 Final_NormalOS178_g263126 = staticSwitch1716_g263126;
					float3 In_NormalOS16_g263134 = Final_NormalOS178_g263126;
					half4 Vertex_TangentOS1749_g263126 = Out_TangentOS15_g263133;
					float4 appendResult1746_g263126 = (float4(cross( worldToObjDir1623_g263126 , float3( 0, 0, 1 ) ) , -1.0));
					half4 Surface_Tangent1747_g263126 = appendResult1746_g263126;
					float4 lerpResult1757_g263126 = lerp( Vertex_TangentOS1749_g263126 , Surface_Tangent1747_g263126 , Blend_Mask1742_g263126);
					#ifdef TVE_TRANSFER
					float4 staticSwitch1760_g263126 = lerpResult1757_g263126;
					#else
					float4 staticSwitch1760_g263126 = Vertex_TangentOS1749_g263126;
					#endif
					half4 Final_TangentOS1762_g263126 = staticSwitch1760_g263126;
					float4 In_TangentOS16_g263134 = Final_TangentOS1762_g263126;
					float4 In_TransformData16_g263134 = Out_TransformData15_g263133;
					float4 In_RotationData16_g263134 = Out_RotationData15_g263133;
					float4 In_Interpolator16_g263134 = Out_Interpolator15_g263133;
					BuildVertexData( Data16_g263134 , In_Dummy16_g263134 , In_PositionOS16_g263134 , In_NormalOS16_g263134 , In_TangentOS16_g263134 , In_TransformData16_g263134 , In_RotationData16_g263134 , In_Interpolator16_g263134 );
					TVEVertexData Data15_g263142 =(TVEVertexData)Data16_g263134;
					float Out_Dummy15_g263142 = 0.0;
					float3 Out_PositionOS15_g263142 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263142 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263142 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263142 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263142 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263142 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g263142 , Out_Dummy15_g263142 , Out_PositionOS15_g263142 , Out_NormalOS15_g263142 , Out_TangentOS15_g263142 , Out_TransformData15_g263142 , Out_RotationData15_g263142 , Out_Interpolator15_g263142 );
					TVEVertexData Data16_g263143 =(TVEVertexData)Data15_g263142;
					float In_Dummy16_g263143 = 0.0;
					TVEModelData Data16_g263128 =(TVEModelData)Data15_g263127;
					float temp_output_14_0_g263128 = 0.0;
					float In_Dummy16_g263128 = temp_output_14_0_g263128;
					float3 temp_output_4_0_g263128 = Out_PositionOS15_g263127;
					float3 In_PositionOS16_g263128 = temp_output_4_0_g263128;
					float3 In_PositionWS16_g263128 = Out_PositionWS15_g263127;
					float3 temp_output_1567_17_g263126 = Out_PositionWO15_g263127;
					float3 In_PositionWO16_g263128 = temp_output_1567_17_g263126;
					float3 In_PivotOS16_g263128 = Out_PivotOS15_g263127;
					float3 In_PivotWS16_g263128 = Out_PivotWS15_g263127;
					float3 In_PivotWO16_g263128 = Out_PivotWO15_g263127;
					float3 temp_output_21_0_g263128 = Out_NormalOS15_g263127;
					float3 In_NormalOS16_g263128 = temp_output_21_0_g263128;
					float3 temp_output_1567_21_g263126 = Out_NormalWS15_g263127;
					float3 In_NormalWS16_g263128 = temp_output_1567_21_g263126;
					float4 temp_output_6_0_g263128 = Out_TangentOS15_g263127;
					float4 In_TangentOS16_g263128 = temp_output_6_0_g263128;
					float3 In_ViewDirWS16_g263128 = Out_ViewDirWS15_g263127;
					float4 In_CoordsData16_g263128 = Out_CoordsData15_g263127;
					float4 In_VertexData16_g263128 = temp_output_1567_29_g263126;
					float4 In_MasksData16_g263128 = Out_MasksData15_g263127;
					float4 In_PhaseData16_g263128 = Out_PhaseData15_g263127;
					BuildModelVertData( Data16_g263128 , In_Dummy16_g263128 , In_PositionOS16_g263128 , In_PositionWS16_g263128 , In_PositionWO16_g263128 , In_PivotOS16_g263128 , In_PivotWS16_g263128 , In_PivotWO16_g263128 , In_NormalOS16_g263128 , In_NormalWS16_g263128 , In_TangentOS16_g263128 , In_ViewDirWS16_g263128 , In_CoordsData16_g263128 , In_VertexData16_g263128 , In_MasksData16_g263128 , In_PhaseData16_g263128 );
					TVEModelData Data15_g263141 =(TVEModelData)Data16_g263128;
					float Out_Dummy15_g263141 = 0.0;
					float3 Out_PositionOS15_g263141 = float3( 0,0,0 );
					float3 Out_PositionWS15_g263141 = float3( 0,0,0 );
					float3 Out_PositionWO15_g263141 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g263141 = float3( 0,0,0 );
					float3 Out_PivotOS15_g263141 = float3( 0,0,0 );
					float3 Out_PivotWS15_g263141 = float3( 0,0,0 );
					float3 Out_PivotWO15_g263141 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263141 = float3( 0,0,0 );
					float3 Out_NormalWS15_g263141 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g263141 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263141 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g263141 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g263141 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g263141 = float3( 0,0,0 );
					float4 Out_CoordsData15_g263141 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g263141 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g263141 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g263141 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263141 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263141 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263141 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g263141 , Out_Dummy15_g263141 , Out_PositionOS15_g263141 , Out_PositionWS15_g263141 , Out_PositionWO15_g263141 , Out_PositionRawOS15_g263141 , Out_PivotOS15_g263141 , Out_PivotWS15_g263141 , Out_PivotWO15_g263141 , Out_NormalOS15_g263141 , Out_NormalWS15_g263141 , Out_NormalRawOS15_g263141 , Out_TangentOS15_g263141 , Out_TangentWS15_g263141 , Out_BitangentWS15_g263141 , Out_ViewDirWS15_g263141 , Out_CoordsData15_g263141 , Out_VertexData15_g263141 , Out_MasksData15_g263141 , Out_PhaseData15_g263141 , Out_TransformData15_g263141 , Out_RotationData15_g263141 , Out_Interpolator15_g263141 );
					float3 In_PositionOS16_g263143 = ( Out_PositionOS15_g263142 + Out_PivotOS15_g263141 );
					float3 In_NormalOS16_g263143 = Out_NormalOS15_g263142;
					float4 In_TangentOS16_g263143 = Out_TangentOS15_g263142;
					float4 In_TransformData16_g263143 = Out_TransformData15_g263142;
					float4 In_RotationData16_g263143 = Out_RotationData15_g263142;
					float4 In_Interpolator16_g263143 = Out_Interpolator15_g263142;
					BuildVertexData( Data16_g263143 , In_Dummy16_g263143 , In_PositionOS16_g263143 , In_NormalOS16_g263143 , In_TangentOS16_g263143 , In_TransformData16_g263143 , In_RotationData16_g263143 , In_Interpolator16_g263143 );
					TVEVertexData Data15_g263231 =(TVEVertexData)Data16_g263143;
					float Out_Dummy15_g263231 = 0.0;
					float3 Out_PositionOS15_g263231 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263231 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263231 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263231 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263231 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263231 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g263231 , Out_Dummy15_g263231 , Out_PositionOS15_g263231 , Out_NormalOS15_g263231 , Out_TangentOS15_g263231 , Out_TransformData15_g263231 , Out_RotationData15_g263231 , Out_Interpolator15_g263231 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g263231;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g263231;
					v.tangent = Out_TangentOS15_g263231;

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
				#pragma shader_feature_local_vertex TVE_PERSPECTIVE
				#pragma shader_feature_local_vertex TVE_CONFORM
				#pragma shader_feature_local_vertex TVE_ROTATION
				#pragma shader_feature_local_vertex TVE_SIZEFADE
				#pragma shader_feature_local_vertex TVE_SIZEFADE_VERTX
				#pragma shader_feature_local_vertex TVE_MOTION
				#pragma shader_feature_local_vertex TVE_MOTION_FLOW
				#pragma shader_feature_local TVE_LEGACY
				#pragma shader_feature_local_vertex TVE_FLATTEN
				#pragma shader_feature_local_vertex TVE_RESHADE
				#pragma shader_feature_local_vertex TVE_TRANSFER
				#if defined (TVE_CONFORM_ROTATION) //Conform Rotation
					#define TVE_ROTATION_BEND //Conform Rotation
				#endif //Conform Rotation
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
				uniform half _PerspectiveCategory;
				uniform half _PerspectiveEnd;
				uniform half _PerspectivePhaseValue;
				uniform half _PerspectiveIntensityValue;
				uniform half _PerspectiveAngleValue;
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
				uniform half _RotationCategory;
				uniform half _RotationEnd;
				uniform half _RotationInfo;
				uniform half _RotationIntensityValue;
				uniform half _SizeFadeCategory;
				uniform half _SizeFadeEnd;
				uniform half4 TVE_SizeFadeParams;
				uniform float _SizeFadeDistMaxValue;
				uniform float _SizeFadeDistMinValue;
				uniform half _SizeFadeScaleValue;
				uniform half _SizeFadeVertxMode;
				uniform half _SizeFadeVertxValue;
				uniform half _SizeFadeScaleMode;
				uniform half _SizeFadeIntensityValue;
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
				uniform half _FlattenCategory;
				uniform half _FlattenEnd;
				uniform half _FlattenBakeMode;
				uniform half _FlattenUpwardsValue;
				uniform half3 _FlattenSphereOffsetValue;
				uniform half _FlattenSphereValue;
				uniform half _FlattenMeshMode;
				uniform half4 _FlattenMeshRemap;
				uniform half _FlattenMeshValue;
				uniform half _FlattenIntensityValue;
				uniform half _ReshadeCategory;
				uniform half _ReshadeEnd;
				uniform half _ReshadeInfo;
				uniform half _ReshadeIntensityValue;
				uniform half _TransferCategory;
				uniform half _TransferEnd;
				uniform half _TransferInfo;
				uniform half _TransferSpace;
				uniform half _TransferIntensityValue;
				uniform half _TransferMeshMode;
				uniform half4 _TransferMeshRemap;
				uniform half _TransferMeshValue;


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
				
				float3 ASESafeNormalize(float3 inVec)
				{
					float dp3 = max(1.175494351e-38, dot(inVec, inVec));
					return inVec* rsqrt(dp3);
				}
				

				v2f VertexFunction( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					TVEVertexData Data16_g262854 =(TVEVertexData)0;
					float In_Dummy16_g262854 = 0.0;
					TVEVertexData Data16_g262849 =(TVEVertexData)0;
					float In_Dummy16_g262849 = 0.0;
					float localIfModelDataByShader26_g263144 = ( 0.0 );
					TVEModelData Data26_g263144 = (TVEModelData)0;
					TVEModelData Data16_g263050 =(TVEModelData)0;
					#ifdef TVE_COORD_ZUP
					float staticSwitch343_g263032 = _ObjectCoordMode;
					#else
					float staticSwitch343_g263032 = _ObjectCoordMode;
					#endif
					half Dummy207_g263032 = ( _ObjectCategory + _ObjectEnd + _ObjectModelMode + _ObjectPivotMode + staticSwitch343_g263032 );
					float temp_output_14_0_g263050 = Dummy207_g263032;
					float In_Dummy16_g263050 = temp_output_14_0_g263050;
					float3 PositionOS131_g263032 = v.vertex.xyz;
					float3 temp_output_4_0_g263050 = PositionOS131_g263032;
					float3 In_PositionOS16_g263050 = temp_output_4_0_g263050;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float3 temp_output_104_7_g263032 = ase_positionWS;
					float3 vertexToFrag73_g263032 = temp_output_104_7_g263032;
					float3 PositionWS122_g263032 = vertexToFrag73_g263032;
					float3 In_PositionWS16_g263050 = PositionWS122_g263032;
					float4x4 break19_g263035 = unity_ObjectToWorld;
					float3 appendResult20_g263035 = (float3(break19_g263035[ 0 ][ 3 ] , break19_g263035[ 1 ][ 3 ] , break19_g263035[ 2 ][ 3 ]));
					float3 temp_output_340_7_g263032 = appendResult20_g263035;
					float4x4 break19_g263037 = unity_ObjectToWorld;
					float3 appendResult20_g263037 = (float3(break19_g263037[ 0 ][ 3 ] , break19_g263037[ 1 ][ 3 ] , break19_g263037[ 2 ][ 3 ]));
					float3 _Vector0 = float3(0,0,0);
					float3 appendResult60_g263033 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
					float3 break233_g263032 = PositionOS131_g263032;
					float3 appendResult234_g263032 = (float3(break233_g263032.x , 0.0 , break233_g263032.z));
					float3 break413_g263032 = PositionOS131_g263032;
					float3 appendResult414_g263032 = (float3(break413_g263032.x , break413_g263032.y , 0.0));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g263039 = appendResult414_g263032;
					#else
					float3 staticSwitch65_g263039 = appendResult234_g263032;
					#endif
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch229_g263032 = _Vector0;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch229_g263032 = appendResult60_g263033;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch229_g263032 = staticSwitch65_g263039;
					#else
					float3 staticSwitch229_g263032 = _Vector0;
					#endif
					float3 PivotOS149_g263032 = staticSwitch229_g263032;
					float3 temp_output_122_0_g263037 = PivotOS149_g263032;
					float3 PivotsOnlyWS105_g263037 = mul( unity_ObjectToWorld, float4( temp_output_122_0_g263037 , 0.0 ) ).xyz;
					float3 temp_output_341_7_g263032 = ( appendResult20_g263037 + PivotsOnlyWS105_g263037 );
					#if defined( TVE_PIVOT_SINGLE )
					float3 staticSwitch236_g263032 = temp_output_340_7_g263032;
					#elif defined( TVE_PIVOT_BAKED )
					float3 staticSwitch236_g263032 = temp_output_341_7_g263032;
					#elif defined( TVE_PIVOT_PROC )
					float3 staticSwitch236_g263032 = temp_output_341_7_g263032;
					#else
					float3 staticSwitch236_g263032 = temp_output_340_7_g263032;
					#endif
					float3 vertexToFrag76_g263032 = staticSwitch236_g263032;
					float3 PivotWS121_g263032 = vertexToFrag76_g263032;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g263032 = ( PositionWS122_g263032 - PivotWS121_g263032 );
					#else
					float3 staticSwitch204_g263032 = PositionWS122_g263032;
					#endif
					float3 PositionWO132_g263032 = ( staticSwitch204_g263032 - TVE_WorldOrigin );
					float3 In_PositionWO16_g263050 = PositionWO132_g263032;
					float3 In_PivotOS16_g263050 = PivotOS149_g263032;
					float3 In_PivotWS16_g263050 = PivotWS121_g263032;
					float3 PivotWO133_g263032 = ( PivotWS121_g263032 - TVE_WorldOrigin );
					float3 In_PivotWO16_g263050 = PivotWO133_g263032;
					half3 NormalOS134_g263032 = v.normal;
					float3 temp_output_21_0_g263050 = NormalOS134_g263032;
					float3 In_NormalOS16_g263050 = temp_output_21_0_g263050;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					float3 normalizedWorldNormal = normalize( ase_normalWS );
					half3 NormalWS95_g263032 = normalizedWorldNormal;
					float3 In_NormalWS16_g263050 = NormalWS95_g263032;
					half4 TangentlOS153_g263032 = v.tangent;
					float4 temp_output_6_0_g263050 = TangentlOS153_g263032;
					float4 In_TangentOS16_g263050 = temp_output_6_0_g263050;
					float3 normalizeResult296_g263032 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g263032 ) );
					half3 ViewDirWS169_g263032 = normalizeResult296_g263032;
					float3 In_ViewDirWS16_g263050 = ViewDirWS169_g263032;
					float4 appendResult397_g263032 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g263032 = appendResult397_g263032;
					float4 In_CoordsData16_g263050 = CoordsData398_g263032;
					half4 VertexMasks171_g263032 = v.ase_color;
					float4 In_VertexData16_g263050 = VertexMasks171_g263032;
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g263044 = (PositionOS131_g263032).z;
					#else
					float staticSwitch65_g263044 = (PositionOS131_g263032).y;
					#endif
					half Object_HeightValue267_g263032 = _ObjectHeightValue;
					half Bounds_HeightMask274_g263032 = saturate( ( staticSwitch65_g263044 / Object_HeightValue267_g263032 ) );
					half3 Position387_g263032 = PositionOS131_g263032;
					half Height387_g263032 = Object_HeightValue267_g263032;
					half Object_RadiusValue268_g263032 = _ObjectRadiusValue;
					half Radius387_g263032 = Object_RadiusValue268_g263032;
					half localCapsuleMaskYUp387_g263032 = CapsuleMaskYUp( Position387_g263032 , Height387_g263032 , Radius387_g263032 );
					half3 Position408_g263032 = PositionOS131_g263032;
					half Height408_g263032 = Object_HeightValue267_g263032;
					half Radius408_g263032 = Object_RadiusValue268_g263032;
					half localCapsuleMaskZUp408_g263032 = CapsuleMaskZUp( Position408_g263032 , Height408_g263032 , Radius408_g263032 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g263049 = saturate( localCapsuleMaskZUp408_g263032 );
					#else
					float staticSwitch65_g263049 = saturate( localCapsuleMaskYUp387_g263032 );
					#endif
					half Bounds_SphereMask282_g263032 = staticSwitch65_g263049;
					float4 appendResult253_g263032 = (float4(Bounds_HeightMask274_g263032 , Bounds_SphereMask282_g263032 , 1.0 , 1.0));
					half4 MasksData254_g263032 = appendResult253_g263032;
					float4 In_MasksData16_g263050 = MasksData254_g263032;
					float temp_output_17_0_g263043 = _ObjectPhaseMode;
					float Option70_g263043 = temp_output_17_0_g263043;
					float4 temp_output_3_0_g263043 = v.ase_color;
					float4 Channel70_g263043 = temp_output_3_0_g263043;
					float localSwitchChannel470_g263043 = SwitchChannel4( Option70_g263043 , Channel70_g263043 );
					half Phase_Value372_g263032 = localSwitchChannel470_g263043;
					float3 break319_g263032 = PivotWO133_g263032;
					half Pivot_Position322_g263032 = ( break319_g263032.x + break319_g263032.z );
					half Phase_Position357_g263032 = ( Phase_Value372_g263032 + Pivot_Position322_g263032 );
					float temp_output_248_0_g263032 = frac( Phase_Position357_g263032 );
					float4 appendResult177_g263032 = (float4((frac( ( Phase_Position357_g263032 + float3( 0.1235, 0.4973, 0.7149 ) ) )*2.0 + -1.0) , temp_output_248_0_g263032));
					half4 Phase_Data176_g263032 = appendResult177_g263032;
					float4 In_PhaseData16_g263050 = Phase_Data176_g263032;
					BuildModelVertData( Data16_g263050 , In_Dummy16_g263050 , In_PositionOS16_g263050 , In_PositionWS16_g263050 , In_PositionWO16_g263050 , In_PivotOS16_g263050 , In_PivotWS16_g263050 , In_PivotWO16_g263050 , In_NormalOS16_g263050 , In_NormalWS16_g263050 , In_TangentOS16_g263050 , In_ViewDirWS16_g263050 , In_CoordsData16_g263050 , In_VertexData16_g263050 , In_MasksData16_g263050 , In_PhaseData16_g263050 );
					TVEModelData DataDefault26_g263144 = Data16_g263050;
					TVEModelData DataGeneral26_g263144 = Data16_g263050;
					TVEModelData DataBlanket26_g263144 = Data16_g263050;
					TVEModelData DataImpostor26_g263144 = Data16_g263050;
					TVEModelData Data16_g263030 =(TVEModelData)0;
					half Dummy207_g263012 = 0.0;
					float temp_output_14_0_g263030 = Dummy207_g263012;
					float In_Dummy16_g263030 = temp_output_14_0_g263030;
					float3 PositionOS131_g263012 = v.vertex.xyz;
					float3 temp_output_4_0_g263030 = PositionOS131_g263012;
					float3 In_PositionOS16_g263030 = temp_output_4_0_g263030;
					float3 temp_output_104_7_g263012 = ase_positionWS;
					float3 PositionWS122_g263012 = temp_output_104_7_g263012;
					float3 In_PositionWS16_g263030 = PositionWS122_g263012;
					float4x4 break19_g263015 = unity_ObjectToWorld;
					float3 appendResult20_g263015 = (float3(break19_g263015[ 0 ][ 3 ] , break19_g263015[ 1 ][ 3 ] , break19_g263015[ 2 ][ 3 ]));
					float3 temp_output_340_7_g263012 = appendResult20_g263015;
					float3 PivotWS121_g263012 = temp_output_340_7_g263012;
					#ifdef TVE_SCOPE_DYNAMIC
					float3 staticSwitch204_g263012 = ( PositionWS122_g263012 - PivotWS121_g263012 );
					#else
					float3 staticSwitch204_g263012 = PositionWS122_g263012;
					#endif
					float3 PositionWO132_g263012 = ( staticSwitch204_g263012 - TVE_WorldOrigin );
					float3 In_PositionWO16_g263030 = PositionWO132_g263012;
					float3 PivotOS149_g263012 = _Vector0;
					float3 In_PivotOS16_g263030 = PivotOS149_g263012;
					float3 In_PivotWS16_g263030 = PivotWS121_g263012;
					float3 PivotWO133_g263012 = ( PivotWS121_g263012 - TVE_WorldOrigin );
					float3 In_PivotWO16_g263030 = PivotWO133_g263012;
					half3 NormalOS134_g263012 = v.normal;
					float3 temp_output_21_0_g263030 = NormalOS134_g263012;
					float3 In_NormalOS16_g263030 = temp_output_21_0_g263030;
					half3 NormalWS95_g263012 = normalizedWorldNormal;
					float3 In_NormalWS16_g263030 = NormalWS95_g263012;
					float4 appendResult462_g263012 = (float4(cross( v.normal , float3( 0, 0, 1 ) ) , -1.0));
					half4 TangentlOS153_g263012 = appendResult462_g263012;
					float4 temp_output_6_0_g263030 = TangentlOS153_g263012;
					float4 In_TangentOS16_g263030 = temp_output_6_0_g263030;
					float3 normalizeResult296_g263012 = normalize( ( _WorldSpaceCameraPos - PositionWS122_g263012 ) );
					half3 ViewDirWS169_g263012 = normalizeResult296_g263012;
					float3 In_ViewDirWS16_g263030 = ViewDirWS169_g263012;
					float4 appendResult397_g263012 = (float4(v.ase_texcoord.xy , v.ase_texcoord2.xy));
					float4 CoordsData398_g263012 = appendResult397_g263012;
					float4 In_CoordsData16_g263030 = CoordsData398_g263012;
					half4 VertexMasks171_g263012 = float4( 0,0,0,0 );
					float4 In_VertexData16_g263030 = VertexMasks171_g263012;
					half4 MasksData254_g263012 = float4( 0,0,0,0 );
					float4 In_MasksData16_g263030 = MasksData254_g263012;
					half4 Phase_Data176_g263012 = float4( 0,0,0,0 );
					float4 In_PhaseData16_g263030 = Phase_Data176_g263012;
					BuildModelVertData( Data16_g263030 , In_Dummy16_g263030 , In_PositionOS16_g263030 , In_PositionWS16_g263030 , In_PositionWO16_g263030 , In_PivotOS16_g263030 , In_PivotWS16_g263030 , In_PivotWO16_g263030 , In_NormalOS16_g263030 , In_NormalWS16_g263030 , In_TangentOS16_g263030 , In_ViewDirWS16_g263030 , In_CoordsData16_g263030 , In_VertexData16_g263030 , In_MasksData16_g263030 , In_PhaseData16_g263030 );
					TVEModelData DataTerrain26_g263144 = Data16_g263030;
					half IsShaderType2637 = _IsShaderType;
					float Type26_g263144 = IsShaderType2637;
					{
					if (Type26_g263144 == 0 )
					{
					Data26_g263144 = DataDefault26_g263144;
					}
					else if (Type26_g263144 == 1 )
					{
					Data26_g263144 = DataGeneral26_g263144;
					}
					else if (Type26_g263144 == 2 )
					{
					Data26_g263144 = DataBlanket26_g263144;
					}
					else if (Type26_g263144 == 3 )
					{
					Data26_g263144 = DataImpostor26_g263144;
					}
					else if (Type26_g263144 == 4 )
					{
					Data26_g263144 = DataTerrain26_g263144;
					}
					}
					TVEModelData Data15_g262850 =(TVEModelData)Data26_g263144;
					float Out_Dummy15_g262850 = 0.0;
					float3 Out_PositionOS15_g262850 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262850 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262850 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262850 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262850 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262850 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262850 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262850 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262850 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262850 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262850 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262850 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262850 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262850 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262850 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262850 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262850 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262850 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262850 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262850 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262850 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262850 , Out_Dummy15_g262850 , Out_PositionOS15_g262850 , Out_PositionWS15_g262850 , Out_PositionWO15_g262850 , Out_PositionRawOS15_g262850 , Out_PivotOS15_g262850 , Out_PivotWS15_g262850 , Out_PivotWO15_g262850 , Out_NormalOS15_g262850 , Out_NormalWS15_g262850 , Out_NormalRawOS15_g262850 , Out_TangentOS15_g262850 , Out_TangentWS15_g262850 , Out_BitangentWS15_g262850 , Out_ViewDirWS15_g262850 , Out_CoordsData15_g262850 , Out_VertexData15_g262850 , Out_MasksData15_g262850 , Out_PhaseData15_g262850 , Out_TransformData15_g262850 , Out_RotationData15_g262850 , Out_Interpolator15_g262850 );
					float3 In_PositionOS16_g262849 = Out_PositionOS15_g262850;
					float3 In_NormalOS16_g262849 = Out_NormalOS15_g262850;
					float4 In_TangentOS16_g262849 = Out_TangentOS15_g262850;
					float4 In_TransformData16_g262849 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g262849 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g262849 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g262849 , In_Dummy16_g262849 , In_PositionOS16_g262849 , In_NormalOS16_g262849 , In_TangentOS16_g262849 , In_TransformData16_g262849 , In_RotationData16_g262849 , In_Interpolator16_g262849 );
					TVEVertexData Data15_g262852 =(TVEVertexData)Data16_g262849;
					float Out_Dummy15_g262852 = 0.0;
					float3 Out_PositionOS15_g262852 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262852 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262852 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262852 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262852 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262852 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262852 , Out_Dummy15_g262852 , Out_PositionOS15_g262852 , Out_NormalOS15_g262852 , Out_TangentOS15_g262852 , Out_TransformData15_g262852 , Out_RotationData15_g262852 , Out_Interpolator15_g262852 );
					TVEModelData Data15_g262853 =(TVEModelData)Data15_g262850;
					float Out_Dummy15_g262853 = 0.0;
					float3 Out_PositionOS15_g262853 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262853 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262853 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262853 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262853 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262853 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262853 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262853 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262853 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262853 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262853 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262853 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262853 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262853 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262853 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262853 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262853 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262853 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262853 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262853 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262853 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262853 , Out_Dummy15_g262853 , Out_PositionOS15_g262853 , Out_PositionWS15_g262853 , Out_PositionWO15_g262853 , Out_PositionRawOS15_g262853 , Out_PivotOS15_g262853 , Out_PivotWS15_g262853 , Out_PivotWO15_g262853 , Out_NormalOS15_g262853 , Out_NormalWS15_g262853 , Out_NormalRawOS15_g262853 , Out_TangentOS15_g262853 , Out_TangentWS15_g262853 , Out_BitangentWS15_g262853 , Out_ViewDirWS15_g262853 , Out_CoordsData15_g262853 , Out_VertexData15_g262853 , Out_MasksData15_g262853 , Out_PhaseData15_g262853 , Out_TransformData15_g262853 , Out_RotationData15_g262853 , Out_Interpolator15_g262853 );
					float3 In_PositionOS16_g262854 = ( Out_PositionOS15_g262852 - Out_PivotOS15_g262853 );
					float3 In_NormalOS16_g262854 = Out_NormalOS15_g262853;
					float4 In_TangentOS16_g262854 = Out_TangentOS15_g262853;
					float4 In_TransformData16_g262854 = half4( 0, 0, 0, 1 );
					float4 In_RotationData16_g262854 = float4( 0,0,0,0 );
					float4 In_Interpolator16_g262854 = float4( 0,0,0,0 );
					BuildVertexData( Data16_g262854 , In_Dummy16_g262854 , In_PositionOS16_g262854 , In_NormalOS16_g262854 , In_TangentOS16_g262854 , In_TransformData16_g262854 , In_RotationData16_g262854 , In_Interpolator16_g262854 );
					TVEVertexData Data15_g262858 =(TVEVertexData)Data16_g262854;
					float Out_Dummy15_g262858 = 0.0;
					float3 Out_PositionOS15_g262858 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262858 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262858 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262858 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262858 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262858 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262858 , Out_Dummy15_g262858 , Out_PositionOS15_g262858 , Out_NormalOS15_g262858 , Out_TangentOS15_g262858 , Out_TransformData15_g262858 , Out_RotationData15_g262858 , Out_Interpolator15_g262858 );
					TVEVertexData Data16_g262859 =(TVEVertexData)Data15_g262858;
					half Dummy181_g262855 = ( _PerspectiveCategory + _PerspectiveEnd );
					float In_Dummy16_g262859 = Dummy181_g262855;
					half3 Vertex_PositionOS147_g262855 = Out_PositionOS15_g262858;
					TVEModelData Data15_g262860 =(TVEModelData)Data15_g262853;
					float Out_Dummy15_g262860 = 0.0;
					float3 Out_PositionOS15_g262860 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262860 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262860 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262860 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262860 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262860 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262860 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262860 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262860 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262860 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262860 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262860 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262860 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262860 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262860 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262860 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262860 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262860 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262860 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262860 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262860 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262860 , Out_Dummy15_g262860 , Out_PositionOS15_g262860 , Out_PositionWS15_g262860 , Out_PositionWO15_g262860 , Out_PositionRawOS15_g262860 , Out_PivotOS15_g262860 , Out_PivotWS15_g262860 , Out_PivotWO15_g262860 , Out_NormalOS15_g262860 , Out_NormalWS15_g262860 , Out_NormalRawOS15_g262860 , Out_TangentOS15_g262860 , Out_TangentWS15_g262860 , Out_BitangentWS15_g262860 , Out_ViewDirWS15_g262860 , Out_CoordsData15_g262860 , Out_VertexData15_g262860 , Out_MasksData15_g262860 , Out_PhaseData15_g262860 , Out_TransformData15_g262860 , Out_RotationData15_g262860 , Out_Interpolator15_g262860 );
					half3 Model_ViewDirWS237_g262855 = Out_ViewDirWS15_g262860;
					float4x4 break117_g262856 = unity_CameraToWorld;
					float3 appendResult118_g262856 = (float3(break117_g262856[ 0 ][ 2 ] , break117_g262856[ 1 ][ 2 ] , break117_g262856[ 2 ][ 2 ]));
					float3 lerpResult209_g262855 = lerp( Model_ViewDirWS237_g262855 , -appendResult118_g262856 , unity_OrthoParams.w);
					float3 break201_g262855 = cross( lerpResult209_g262855 , half3( 0, 1, 0 ) );
					float3 appendResult196_g262855 = (float3(-break201_g262855.z , 0.0 , break201_g262855.x));
					half4 Model_PhaseData218_g262855 = Out_PhaseData15_g262860;
					float2 break226_g262855 = ( (Model_PhaseData218_g262855).xy * 5.0 * _PerspectivePhaseValue );
					float3 appendResult224_g262855 = (float3(break226_g262855.x , 0.0 , break226_g262855.y));
					float dotResult189_g262855 = dot( Model_ViewDirWS237_g262855 , float3( 0, 1, 0 ) );
					float saferPower192_g262855 = abs( dotResult189_g262855 );
					#ifdef TVE_COORD_ZUP
					float staticSwitch65_g262857 = (Vertex_PositionOS147_g262855).z;
					#else
					float staticSwitch65_g262857 = (Vertex_PositionOS147_g262855).y;
					#endif
					float3 temp_output_206_0_g262855 = ( Vertex_PositionOS147_g262855 + ( ( mul( unity_WorldToObject, float4( appendResult196_g262855 , 0.0 ) ).xyz + appendResult224_g262855 ) * _PerspectiveIntensityValue * pow( saferPower192_g262855 , _PerspectiveAngleValue ) * saturate( staticSwitch65_g262857 ) ) );
					#ifdef TVE_PERSPECTIVE
					float3 staticSwitch211_g262855 = temp_output_206_0_g262855;
					#else
					float3 staticSwitch211_g262855 = Vertex_PositionOS147_g262855;
					#endif
					float3 Final_Position178_g262855 = staticSwitch211_g262855;
					float3 In_PositionOS16_g262859 = Final_Position178_g262855;
					float3 In_NormalOS16_g262859 = Out_NormalOS15_g262858;
					float4 In_TangentOS16_g262859 = Out_TangentOS15_g262858;
					float4 In_TransformData16_g262859 = Out_TransformData15_g262858;
					float4 In_RotationData16_g262859 = Out_RotationData15_g262858;
					float4 In_Interpolator16_g262859 = Out_Interpolator15_g262858;
					BuildVertexData( Data16_g262859 , In_Dummy16_g262859 , In_PositionOS16_g262859 , In_NormalOS16_g262859 , In_TangentOS16_g262859 , In_TransformData16_g262859 , In_RotationData16_g262859 , In_Interpolator16_g262859 );
					TVEVertexData Data15_g262869 =(TVEVertexData)Data16_g262859;
					float Out_Dummy15_g262869 = 0.0;
					float3 Out_PositionOS15_g262869 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262869 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262869 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262869 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262869 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262869 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262869 , Out_Dummy15_g262869 , Out_PositionOS15_g262869 , Out_NormalOS15_g262869 , Out_TangentOS15_g262869 , Out_TransformData15_g262869 , Out_RotationData15_g262869 , Out_Interpolator15_g262869 );
					TVEVertexData Data16_g262870 =(TVEVertexData)Data15_g262869;
					half Dummy317_g262861 = ( _ConformCategory + _ConformEnd + _ConformInfo );
					float In_Dummy16_g262870 = Dummy317_g262861;
					float3 In_PositionOS16_g262870 = Out_PositionOS15_g262869;
					float3 In_NormalOS16_g262870 = Out_NormalOS15_g262869;
					float4 In_TangentOS16_g262870 = Out_TangentOS15_g262869;
					half4 Model_TransformData356_g262861 = Out_TransformData15_g262869;
					float localBuildGlobalData204_g262442 = ( 0.0 );
					TVEGlobalData Data204_g262442 =(TVEGlobalData)(TVEGlobalData)0;
					half Dummy211_g262442 = ( _GlobalCategory + _GlobalEnd );
					float In_Dummy204_g262442 = Dummy211_g262442;
					float4 temp_output_203_0_g262461 = TVE_CoatBaseCoord;
					float localIfModelDataByShader26_g262420 = ( 0.0 );
					TVEModelData Data26_g262420 = (TVEModelData)0;
					TVEModelData DataDefault26_g262420 = Data16_g263030;
					TVEModelData Data16_g263040 =(TVEModelData)0;
					float In_Dummy16_g263040 = 0.0;
					float3 In_PositionWS16_g263040 = PositionWS122_g263032;
					float3 In_PositionWO16_g263040 = PositionWO132_g263032;
					float3 In_PivotWS16_g263040 = PivotWS121_g263032;
					float3 In_PivotWO16_g263040 = PivotWO133_g263032;
					float3 In_NormalWS16_g263040 = NormalWS95_g263032;
					float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent );
					half3 TangentWS136_g263032 = ase_tangentWS;
					float3 In_TangentWS16_g263040 = TangentWS136_g263032;
					float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					half3 BiangentWS421_g263032 = ase_bitangentWS;
					float3 In_BitangentWS16_g263040 = BiangentWS421_g263032;
					half3 NormalWS427_g263032 = NormalWS95_g263032;
					half3 localComputeTriplanarMasks427_g263032 = ComputeTriplanarMasks( NormalWS427_g263032 );
					half3 TriplanarWeights429_g263032 = localComputeTriplanarMasks427_g263032;
					float3 In_TriplanarWeights16_g263040 = TriplanarWeights429_g263032;
					float3 In_ViewDirWS16_g263040 = ViewDirWS169_g263032;
					float4 In_CoordsData16_g263040 = CoordsData398_g263032;
					float4 In_VertexData16_g263040 = VertexMasks171_g263032;
					float4 In_Interpolator16_g263040 = Phase_Data176_g263032;
					BuildModelFragData( Data16_g263040 , In_Dummy16_g263040 , In_PositionWS16_g263040 , In_PositionWO16_g263040 , In_PivotWS16_g263040 , In_PivotWO16_g263040 , In_NormalWS16_g263040 , In_TangentWS16_g263040 , In_BitangentWS16_g263040 , In_TriplanarWeights16_g263040 , In_ViewDirWS16_g263040 , In_CoordsData16_g263040 , In_VertexData16_g263040 , In_Interpolator16_g263040 );
					TVEModelData DataGeneral26_g262420 = Data16_g263040;
					TVEModelData DataBlanket26_g262420 = Data16_g263040;
					TVEModelData DataImpostor26_g262420 = Data16_g263040;
					TVEModelData Data16_g263020 =(TVEModelData)0;
					float In_Dummy16_g263020 = 0.0;
					float3 In_PositionWS16_g263020 = PositionWS122_g263012;
					float3 In_PositionWO16_g263020 = PositionWO132_g263012;
					float3 In_PivotWS16_g263020 = PivotWS121_g263012;
					float3 In_PivotWO16_g263020 = PivotWO133_g263012;
					float3 In_NormalWS16_g263020 = NormalWS95_g263012;
					half3 TangentWS136_g263012 = ase_tangentWS;
					float3 In_TangentWS16_g263020 = TangentWS136_g263012;
					half3 BiangentWS421_g263012 = ase_bitangentWS;
					float3 In_BitangentWS16_g263020 = BiangentWS421_g263012;
					half3 NormalWS427_g263012 = NormalWS95_g263012;
					half3 localComputeTriplanarMasks427_g263012 = ComputeTriplanarMasks( NormalWS427_g263012 );
					half3 TriplanarWeights429_g263012 = localComputeTriplanarMasks427_g263012;
					float3 In_TriplanarWeights16_g263020 = TriplanarWeights429_g263012;
					float3 In_ViewDirWS16_g263020 = ViewDirWS169_g263012;
					float4 In_CoordsData16_g263020 = CoordsData398_g263012;
					float4 In_VertexData16_g263020 = VertexMasks171_g263012;
					float4 In_Interpolator16_g263020 = Phase_Data176_g263012;
					BuildModelFragData( Data16_g263020 , In_Dummy16_g263020 , In_PositionWS16_g263020 , In_PositionWO16_g263020 , In_PivotWS16_g263020 , In_PivotWO16_g263020 , In_NormalWS16_g263020 , In_TangentWS16_g263020 , In_BitangentWS16_g263020 , In_TriplanarWeights16_g263020 , In_ViewDirWS16_g263020 , In_CoordsData16_g263020 , In_VertexData16_g263020 , In_Interpolator16_g263020 );
					TVEModelData DataTerrain26_g262420 = Data16_g263020;
					float Type26_g262420 = IsShaderType2637;
					{
					if (Type26_g262420 == 0 )
					{
					Data26_g262420 = DataDefault26_g262420;
					}
					else if (Type26_g262420 == 1 )
					{
					Data26_g262420 = DataGeneral26_g262420;
					}
					else if (Type26_g262420 == 2 )
					{
					Data26_g262420 = DataBlanket26_g262420;
					}
					else if (Type26_g262420 == 3 )
					{
					Data26_g262420 = DataImpostor26_g262420;
					}
					else if (Type26_g262420 == 4 )
					{
					Data26_g262420 = DataTerrain26_g262420;
					}
					}
					TVEModelData Data15_g262532 =(TVEModelData)Data26_g262420;
					float Out_Dummy15_g262532 = 0.0;
					float3 Out_PositionWS15_g262532 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262532 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262532 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262532 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262532 = float3( 0,0,0 );
					float3 Out_TangentWS15_g262532 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262532 = float3( 0,0,0 );
					float3 Out_TriplanarWeights15_g262532 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262532 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262532 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262532 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262532 = float4( 0,0,0,0 );
					BreakModelFragData( Data15_g262532 , Out_Dummy15_g262532 , Out_PositionWS15_g262532 , Out_PositionWO15_g262532 , Out_PivotWS15_g262532 , Out_PivotWO15_g262532 , Out_NormalWS15_g262532 , Out_TangentWS15_g262532 , Out_BitangentWS15_g262532 , Out_TriplanarWeights15_g262532 , Out_ViewDirWS15_g262532 , Out_CoordsData15_g262532 , Out_VertexData15_g262532 , Out_Interpolator15_g262532 );
					float3 Model_PositionWS497_g262442 = Out_PositionWS15_g262532;
					float2 Model_PositionWS_XZ143_g262442 = (Model_PositionWS497_g262442).xz;
					float3 Model_PivotWS498_g262442 = Out_PivotWS15_g262532;
					float2 Model_PivotWS_XZ145_g262442 = (Model_PivotWS498_g262442).xz;
					float2 lerpResult300_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalCoatPivotValue);
					float2 temp_output_81_0_g262461 = lerpResult300_g262442;
					float temp_output_82_0_g262459 = _GlobalCoatLayerValue;
					float temp_output_82_0_g262461 = temp_output_82_0_g262459;
					float4 tex2DArrayNode83_g262461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262461).zw + ( (temp_output_203_0_g262461).xy * temp_output_81_0_g262461 ) ),temp_output_82_0_g262461), 0.0 );
					float4 appendResult210_g262461 = (float4(tex2DArrayNode83_g262461.rgb , tex2DArrayNode83_g262461.a));
					float4 temp_output_204_0_g262461 = TVE_CoatNearCoord;
					float4 tex2DArrayNode122_g262461 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_CoatNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262461).zw + ( (temp_output_204_0_g262461).xy * temp_output_81_0_g262461 ) ),temp_output_82_0_g262461), 0.0 );
					float4 appendResult212_g262461 = (float4(tex2DArrayNode122_g262461.rgb , tex2DArrayNode122_g262461.a));
					float4 TVE_RenderNearPositionR628_g262442 = TVE_RenderNearPositionR;
					float temp_output_507_0_g262442 = saturate( ( distance( Model_PositionWS497_g262442 , (TVE_RenderNearPositionR628_g262442).xyz ) / (TVE_RenderNearPositionR628_g262442).w ) );
					float temp_output_7_0_g262531 = 1.0;
					float temp_output_9_0_g262531 = ( temp_output_507_0_g262442 - temp_output_7_0_g262531 );
					half TVE_RenderNearFadeValue635_g262442 = TVE_RenderNearFadeValue;
					half Global_TexBlend509_g262442 = saturate( ( temp_output_9_0_g262531 / ( ( TVE_RenderNearFadeValue635_g262442 - temp_output_7_0_g262531 ) + 0.0001 ) ) );
					float4 lerpResult131_g262461 = lerp( appendResult210_g262461 , appendResult212_g262461 , Global_TexBlend509_g262442);
					float4 temp_output_159_109_g262459 = lerpResult131_g262461;
					float4 lerpResult168_g262459 = lerp( TVE_CoatParams , temp_output_159_109_g262459 , TVE_CoatLayers[(int)temp_output_82_0_g262459]);
					float4 temp_output_589_109_g262442 = lerpResult168_g262459;
					half4 Coat_Texture302_g262442 = temp_output_589_109_g262442;
					float4 In_CoatTexture204_g262442 = Coat_Texture302_g262442;
					half4 Draw_Texture656_g262442 = float4( 0,0,0,0 );
					float4 In_DrawTexture204_g262442 = Draw_Texture656_g262442;
					float4 temp_output_203_0_g262486 = TVE_PaintBaseCoord;
					float2 lerpResult85_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalPaintPivotValue);
					float2 temp_output_81_0_g262486 = lerpResult85_g262442;
					float temp_output_82_0_g262483 = _GlobalPaintLayerValue;
					float temp_output_82_0_g262486 = temp_output_82_0_g262483;
					float4 tex2DArrayNode83_g262486 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262486).zw + ( (temp_output_203_0_g262486).xy * temp_output_81_0_g262486 ) ),temp_output_82_0_g262486), 0.0 );
					float4 appendResult210_g262486 = (float4(tex2DArrayNode83_g262486.rgb , tex2DArrayNode83_g262486.a));
					float4 temp_output_204_0_g262486 = TVE_PaintNearCoord;
					float4 tex2DArrayNode122_g262486 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_PaintNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262486).zw + ( (temp_output_204_0_g262486).xy * temp_output_81_0_g262486 ) ),temp_output_82_0_g262486), 0.0 );
					float4 appendResult212_g262486 = (float4(tex2DArrayNode122_g262486.rgb , tex2DArrayNode122_g262486.a));
					float4 lerpResult131_g262486 = lerp( appendResult210_g262486 , appendResult212_g262486 , Global_TexBlend509_g262442);
					float4 temp_output_171_109_g262483 = lerpResult131_g262486;
					float4 lerpResult174_g262483 = lerp( TVE_PaintParams , temp_output_171_109_g262483 , TVE_PaintLayers[(int)temp_output_82_0_g262483]);
					float4 temp_output_595_109_g262442 = lerpResult174_g262483;
					half4 Paint_Texture71_g262442 = temp_output_595_109_g262442;
					float4 In_PaintTexture204_g262442 = Paint_Texture71_g262442;
					float4 temp_output_203_0_g262469 = TVE_AtmoBaseCoord;
					float2 lerpResult104_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalAtmoPivotValue);
					float2 temp_output_81_0_g262469 = lerpResult104_g262442;
					float temp_output_132_0_g262467 = _GlobalAtmoLayerValue;
					float temp_output_82_0_g262469 = temp_output_132_0_g262467;
					float4 tex2DArrayNode83_g262469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262469).zw + ( (temp_output_203_0_g262469).xy * temp_output_81_0_g262469 ) ),temp_output_82_0_g262469), 0.0 );
					float4 appendResult210_g262469 = (float4(tex2DArrayNode83_g262469.rgb , tex2DArrayNode83_g262469.a));
					float4 temp_output_204_0_g262469 = TVE_AtmoNearCoord;
					float4 tex2DArrayNode122_g262469 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_AtmoNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262469).zw + ( (temp_output_204_0_g262469).xy * temp_output_81_0_g262469 ) ),temp_output_82_0_g262469), 0.0 );
					float4 appendResult212_g262469 = (float4(tex2DArrayNode122_g262469.rgb , tex2DArrayNode122_g262469.a));
					float4 lerpResult131_g262469 = lerp( appendResult210_g262469 , appendResult212_g262469 , Global_TexBlend509_g262442);
					float4 temp_output_137_109_g262467 = lerpResult131_g262469;
					float4 lerpResult145_g262467 = lerp( TVE_AtmoParams , temp_output_137_109_g262467 , TVE_AtmoLayers[(int)temp_output_132_0_g262467]);
					float4 temp_output_590_110_g262442 = lerpResult145_g262467;
					half4 Atmo_Texture80_g262442 = temp_output_590_110_g262442;
					float4 In_AtmoTexture204_g262442 = Atmo_Texture80_g262442;
					float4 temp_output_203_0_g262537 = TVE_EffexBaseCoord;
					float2 lerpResult414_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalEffexPivotValue);
					float2 temp_output_81_0_g262537 = lerpResult414_g262442;
					float temp_output_132_0_g262535 = _GlobalEffexLayerValue;
					float temp_output_82_0_g262537 = temp_output_132_0_g262535;
					float4 tex2DArrayNode83_g262537 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262537).zw + ( (temp_output_203_0_g262537).xy * temp_output_81_0_g262537 ) ),temp_output_82_0_g262537), 0.0 );
					float4 appendResult210_g262537 = (float4(tex2DArrayNode83_g262537.rgb , tex2DArrayNode83_g262537.a));
					float4 temp_output_204_0_g262537 = TVE_EffexNearCoord;
					float4 tex2DArrayNode122_g262537 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_EffexNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262537).zw + ( (temp_output_204_0_g262537).xy * temp_output_81_0_g262537 ) ),temp_output_82_0_g262537), 0.0 );
					float4 appendResult212_g262537 = (float4(tex2DArrayNode122_g262537.rgb , tex2DArrayNode122_g262537.a));
					float4 lerpResult131_g262537 = lerp( appendResult210_g262537 , appendResult212_g262537 , Global_TexBlend509_g262442);
					float4 temp_output_137_109_g262535 = lerpResult131_g262537;
					float4 lerpResult145_g262535 = lerp( TVE_EffexParams , temp_output_137_109_g262535 , TVE_EffexLayers[(int)temp_output_132_0_g262535]);
					float4 temp_output_731_110_g262442 = lerpResult145_g262535;
					half4 Effex_Texture420_g262442 = temp_output_731_110_g262442;
					float4 In_EffexTexture204_g262442 = Effex_Texture420_g262442;
					float4 temp_output_203_0_g262517 = TVE_GlowBaseCoord;
					float2 lerpResult247_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalGlowPivotValue);
					float2 temp_output_81_0_g262517 = lerpResult247_g262442;
					float temp_output_82_0_g262515 = _GlobalGlowLayerValue;
					float temp_output_82_0_g262517 = temp_output_82_0_g262515;
					float4 tex2DArrayNode83_g262517 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262517).zw + ( (temp_output_203_0_g262517).xy * temp_output_81_0_g262517 ) ),temp_output_82_0_g262517), 0.0 );
					float4 appendResult210_g262517 = (float4(tex2DArrayNode83_g262517.rgb , tex2DArrayNode83_g262517.a));
					float4 temp_output_204_0_g262517 = TVE_GlowNearCoord;
					float4 tex2DArrayNode122_g262517 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_GlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262517).zw + ( (temp_output_204_0_g262517).xy * temp_output_81_0_g262517 ) ),temp_output_82_0_g262517), 0.0 );
					float4 appendResult212_g262517 = (float4(tex2DArrayNode122_g262517.rgb , tex2DArrayNode122_g262517.a));
					float4 lerpResult131_g262517 = lerp( appendResult210_g262517 , appendResult212_g262517 , Global_TexBlend509_g262442);
					float4 temp_output_159_109_g262515 = lerpResult131_g262517;
					float4 lerpResult167_g262515 = lerp( TVE_GlowParams , temp_output_159_109_g262515 , TVE_GlowLayers[(int)temp_output_82_0_g262515]);
					float4 temp_output_593_109_g262442 = lerpResult167_g262515;
					half4 Glow_Texture248_g262442 = temp_output_593_109_g262442;
					float4 In_GlowTexture204_g262442 = Glow_Texture248_g262442;
					float4 temp_output_203_0_g262453 = TVE_FormBaseCoord;
					float2 lerpResult168_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalFormPivotValue);
					float2 temp_output_81_0_g262453 = lerpResult168_g262442;
					float temp_output_130_0_g262451 = _GlobalFormLayerValue;
					float temp_output_82_0_g262453 = temp_output_130_0_g262451;
					float4 tex2DArrayNode83_g262453 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262453).zw + ( (temp_output_203_0_g262453).xy * temp_output_81_0_g262453 ) ),temp_output_82_0_g262453), 0.0 );
					float4 appendResult210_g262453 = (float4(tex2DArrayNode83_g262453.rgb , tex2DArrayNode83_g262453.a));
					float4 temp_output_204_0_g262453 = TVE_FormNearCoord;
					float4 tex2DArrayNode122_g262453 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FormNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262453).zw + ( (temp_output_204_0_g262453).xy * temp_output_81_0_g262453 ) ),temp_output_82_0_g262453), 0.0 );
					float4 appendResult212_g262453 = (float4(tex2DArrayNode122_g262453.rgb , tex2DArrayNode122_g262453.a));
					float4 lerpResult131_g262453 = lerp( appendResult210_g262453 , appendResult212_g262453 , Global_TexBlend509_g262442);
					float4 temp_output_135_109_g262451 = lerpResult131_g262453;
					float4 lerpResult143_g262451 = lerp( TVE_FormParams , temp_output_135_109_g262451 , TVE_FormLayers[(int)temp_output_130_0_g262451]);
					float4 temp_output_592_0_g262442 = lerpResult143_g262451;
					float4 Form_Texture112_g262442 = temp_output_592_0_g262442;
					float4 In_FormTexture204_g262442 = Form_Texture112_g262442;
					float4 In_LandTexture204_g262442 = float4( 0,0,0,0 );
					float4 temp_output_203_0_g262501 = TVE_VertxBaseCoord;
					float2 lerpResult681_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalVertxPivotValue);
					float2 temp_output_81_0_g262501 = lerpResult681_g262442;
					float temp_output_136_0_g262499 = _GlobalVertxLayerValue;
					float temp_output_82_0_g262501 = temp_output_136_0_g262499;
					float4 tex2DArrayNode83_g262501 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262501).zw + ( (temp_output_203_0_g262501).xy * temp_output_81_0_g262501 ) ),temp_output_82_0_g262501), 0.0 );
					float4 appendResult210_g262501 = (float4(tex2DArrayNode83_g262501.rgb , tex2DArrayNode83_g262501.a));
					float4 temp_output_204_0_g262501 = TVE_VertxNearCoord;
					float4 tex2DArrayNode122_g262501 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertxNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262501).zw + ( (temp_output_204_0_g262501).xy * temp_output_81_0_g262501 ) ),temp_output_82_0_g262501), 0.0 );
					float4 appendResult212_g262501 = (float4(tex2DArrayNode122_g262501.rgb , tex2DArrayNode122_g262501.a));
					float4 lerpResult131_g262501 = lerp( appendResult210_g262501 , appendResult212_g262501 , Global_TexBlend509_g262442);
					float4 temp_output_141_109_g262499 = lerpResult131_g262501;
					float4 lerpResult149_g262499 = lerp( TVE_VertxParams , temp_output_141_109_g262499 , TVE_VertxLayers[(int)temp_output_136_0_g262499]);
					float4 temp_output_695_0_g262442 = lerpResult149_g262499;
					half4 Vertx_Texture693_g262442 = temp_output_695_0_g262442;
					float4 In_VertxTexture204_g262442 = Vertx_Texture693_g262442;
					float4 temp_output_203_0_g262477 = TVE_FlowBaseCoord;
					float2 lerpResult400_g262442 = lerp( Model_PositionWS_XZ143_g262442 , Model_PivotWS_XZ145_g262442 , _GlobalFlowPivotValue);
					float2 temp_output_81_0_g262477 = lerpResult400_g262442;
					float temp_output_136_0_g262475 = _GlobalFlowLayerValue;
					float temp_output_82_0_g262477 = temp_output_136_0_g262475;
					float4 tex2DArrayNode83_g262477 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowBaseTex, sampler_Linear_Clamp, float3(( (temp_output_203_0_g262477).zw + ( (temp_output_203_0_g262477).xy * temp_output_81_0_g262477 ) ),temp_output_82_0_g262477), 0.0 );
					float4 appendResult210_g262477 = (float4(tex2DArrayNode83_g262477.rgb , tex2DArrayNode83_g262477.a));
					float4 temp_output_204_0_g262477 = TVE_FlowNearCoord;
					float4 tex2DArrayNode122_g262477 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_FlowNearTex, sampler_Linear_Repeat, float3(( (temp_output_204_0_g262477).zw + ( (temp_output_204_0_g262477).xy * temp_output_81_0_g262477 ) ),temp_output_82_0_g262477), 0.0 );
					float4 appendResult212_g262477 = (float4(tex2DArrayNode122_g262477.rgb , tex2DArrayNode122_g262477.a));
					float4 lerpResult131_g262477 = lerp( appendResult210_g262477 , appendResult212_g262477 , Global_TexBlend509_g262442);
					float4 temp_output_141_109_g262475 = lerpResult131_g262477;
					float4 lerpResult149_g262475 = lerp( TVE_FlowParams , temp_output_141_109_g262475 , TVE_FlowLayers[(int)temp_output_136_0_g262475]);
					float4 temp_output_594_0_g262442 = lerpResult149_g262475;
					half4 Flow_Texture405_g262442 = temp_output_594_0_g262442;
					float4 In_FlowTexture204_g262442 = Flow_Texture405_g262442;
					half4 User_Texture677_g262442 = float4( 0,0,0,0 );
					float4 In_UserTexture204_g262442 = User_Texture677_g262442;
					BuildGlobalData( Data204_g262442 , In_Dummy204_g262442 , In_CoatTexture204_g262442 , In_DrawTexture204_g262442 , In_PaintTexture204_g262442 , In_AtmoTexture204_g262442 , In_EffexTexture204_g262442 , In_GlowTexture204_g262442 , In_FormTexture204_g262442 , In_LandTexture204_g262442 , In_VertxTexture204_g262442 , In_FlowTexture204_g262442 , In_UserTexture204_g262442 );
					TVEGlobalData Data15_g262871 =(TVEGlobalData)Data204_g262442;
					float Out_Dummy15_g262871 = 0.0;
					float4 Out_CoatTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262871 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g262871 = float4( 0,0,0,0 );
					BreakData( Data15_g262871 , Out_Dummy15_g262871 , Out_CoatTexture15_g262871 , Out_DrawTexture15_g262871 , Out_PaintTexture15_g262871 , Out_AtmoTexture15_g262871 , Out_EffexTexture15_g262871 , Out_GlowTexture15_g262871 , Out_FormTexture15_g262871 , Out_LandTexture15_g262871 , Out_VertxTexture15_g262871 , Out_FlowTexture15_g262871 , Out_UserTexture15_g262871 );
					float4 Global_FormTexture351_g262861 = Out_FormTexture15_g262871;
					TVEModelData Data15_g262868 =(TVEModelData)Data15_g262860;
					float Out_Dummy15_g262868 = 0.0;
					float3 Out_PositionOS15_g262868 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262868 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262868 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262868 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262868 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262868 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262868 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262868 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262868 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262868 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262868 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262868 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262868 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262868 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262868 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262868 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262868 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262868 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262868 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262868 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262868 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262868 , Out_Dummy15_g262868 , Out_PositionOS15_g262868 , Out_PositionWS15_g262868 , Out_PositionWO15_g262868 , Out_PositionRawOS15_g262868 , Out_PivotOS15_g262868 , Out_PivotWS15_g262868 , Out_PivotWO15_g262868 , Out_NormalOS15_g262868 , Out_NormalWS15_g262868 , Out_NormalRawOS15_g262868 , Out_TangentOS15_g262868 , Out_TangentWS15_g262868 , Out_BitangentWS15_g262868 , Out_ViewDirWS15_g262868 , Out_CoordsData15_g262868 , Out_VertexData15_g262868 , Out_MasksData15_g262868 , Out_PhaseData15_g262868 , Out_TransformData15_g262868 , Out_RotationData15_g262868 , Out_Interpolator15_g262868 );
					float3 Model_PivotWO353_g262861 = Out_PivotWO15_g262868;
					float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
					float temp_output_17_0_g262867 = _ConformMeshMode;
					float Option70_g262867 = temp_output_17_0_g262867;
					half4 Model_VertexData357_g262861 = Out_VertexData15_g262868;
					float4 temp_output_3_0_g262867 = Model_VertexData357_g262861;
					float4 Channel70_g262867 = temp_output_3_0_g262867;
					float localSwitchChannel470_g262867 = SwitchChannel4( Option70_g262867 , Channel70_g262867 );
					float temp_output_390_0_g262861 = localSwitchChannel470_g262867;
					float temp_output_7_0_g262864 = _ConformMeshRemap.x;
					float temp_output_9_0_g262864 = ( temp_output_390_0_g262861 - temp_output_7_0_g262864 );
					float lerpResult374_g262861 = lerp( 1.0 , saturate( ( temp_output_9_0_g262864 * _ConformMeshRemap.z ) ) , _ConformMeshValue);
					half Blend_VertMask379_g262861 = lerpResult374_g262861;
					float temp_output_328_0_g262861 = ( Blend_VertMask379_g262861 * TVE_IsEnabled );
					half Conform_Mask366_g262861 = temp_output_328_0_g262861;
					float temp_output_322_0_g262861 = ( ( ( ( (Global_FormTexture351_g262861).z - ( (Model_PivotWO353_g262861).y * _ConformMode ) ) + _ConformOffsetValue ) / ase_objectScale.y ) * ( _ConformIntensityValue * Conform_Mask366_g262861 ) );
					float3 appendResult329_g262861 = (float3(0.0 , temp_output_322_0_g262861 , 0.0));
					float3 appendResult387_g262861 = (float3(0.0 , 0.0 , temp_output_322_0_g262861));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262865 = appendResult387_g262861;
					#else
					float3 staticSwitch65_g262865 = appendResult329_g262861;
					#endif
					float3 Blanket_Conform368_g262861 = staticSwitch65_g262865;
					float4 appendResult312_g262861 = (float4(Blanket_Conform368_g262861 , 0.0));
					float4 temp_output_310_0_g262861 = ( Model_TransformData356_g262861 + appendResult312_g262861 );
					#ifdef TVE_CONFORM
					float4 staticSwitch364_g262861 = temp_output_310_0_g262861;
					#else
					float4 staticSwitch364_g262861 = Model_TransformData356_g262861;
					#endif
					half4 Final_TransformData365_g262861 = staticSwitch364_g262861;
					float4 In_TransformData16_g262870 = Final_TransformData365_g262861;
					float4 In_RotationData16_g262870 = Out_RotationData15_g262869;
					float4 In_Interpolator16_g262870 = Out_Interpolator15_g262869;
					BuildVertexData( Data16_g262870 , In_Dummy16_g262870 , In_PositionOS16_g262870 , In_NormalOS16_g262870 , In_TangentOS16_g262870 , In_TransformData16_g262870 , In_RotationData16_g262870 , In_Interpolator16_g262870 );
					TVEVertexData Data15_g262878 =(TVEVertexData)Data16_g262870;
					float Out_Dummy15_g262878 = 0.0;
					float3 Out_PositionOS15_g262878 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262878 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262878 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262878 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262878 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262878 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262878 , Out_Dummy15_g262878 , Out_PositionOS15_g262878 , Out_NormalOS15_g262878 , Out_TangentOS15_g262878 , Out_TransformData15_g262878 , Out_RotationData15_g262878 , Out_Interpolator15_g262878 );
					TVEVertexData Data16_g262879 =(TVEVertexData)Data15_g262878;
					half Dummy181_g262872 = ( _RotationCategory + _RotationEnd + _RotationInfo );
					float In_Dummy16_g262879 = Dummy181_g262872;
					float3 In_PositionOS16_g262879 = Out_PositionOS15_g262878;
					float3 In_NormalOS16_g262879 = Out_NormalOS15_g262878;
					float4 In_TangentOS16_g262879 = Out_TangentOS15_g262878;
					float4 In_TransformData16_g262879 = Out_TransformData15_g262878;
					half4 Model_RotationData212_g262872 = Out_RotationData15_g262878;
					TVEGlobalData Data15_g262873 =(TVEGlobalData)Data15_g262871;
					float Out_Dummy15_g262873 = 0.0;
					float4 Out_CoatTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262873 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g262873 = float4( 0,0,0,0 );
					BreakData( Data15_g262873 , Out_Dummy15_g262873 , Out_CoatTexture15_g262873 , Out_DrawTexture15_g262873 , Out_PaintTexture15_g262873 , Out_AtmoTexture15_g262873 , Out_EffexTexture15_g262873 , Out_GlowTexture15_g262873 , Out_FormTexture15_g262873 , Out_LandTexture15_g262873 , Out_VertxTexture15_g262873 , Out_FlowTexture15_g262873 , Out_UserTexture15_g262873 );
					half4 Global_FormTexture188_g262872 = Out_FormTexture15_g262873;
					float2 temp_output_38_0_g262874 = ((Global_FormTexture188_g262872).xy*2.0 + -1.0);
					float2 break83_g262874 = temp_output_38_0_g262874;
					float3 appendResult79_g262874 = (float3(break83_g262874.x , 0.0 , break83_g262874.y));
					float3 ase_parentObjectScale = ( 1.0 / float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ) );
					float2 lerpResult227_g262872 = lerp( float2( 0,0 ) , (( mul( unity_WorldToObject, float4( appendResult79_g262874 , 0.0 ) ).xyz * ase_parentObjectScale )).xz , ( _RotationIntensityValue * TVE_IsEnabled ));
					half2 Blanket_Orientation192_g262872 = lerpResult227_g262872;
					float4 appendResult222_g262872 = (float4(( (Model_RotationData212_g262872).xy + Blanket_Orientation192_g262872 ) , (Model_RotationData212_g262872).zw));
					#ifdef TVE_ROTATION
					float4 staticSwitch218_g262872 = appendResult222_g262872;
					#else
					float4 staticSwitch218_g262872 = Model_RotationData212_g262872;
					#endif
					half4 Final_RotationData225_g262872 = staticSwitch218_g262872;
					float4 In_RotationData16_g262879 = Final_RotationData225_g262872;
					float4 In_Interpolator16_g262879 = Out_Interpolator15_g262878;
					BuildVertexData( Data16_g262879 , In_Dummy16_g262879 , In_PositionOS16_g262879 , In_NormalOS16_g262879 , In_TangentOS16_g262879 , In_TransformData16_g262879 , In_RotationData16_g262879 , In_Interpolator16_g262879 );
					TVEVertexData Data15_g262887 =(TVEVertexData)Data16_g262879;
					float Out_Dummy15_g262887 = 0.0;
					float3 Out_PositionOS15_g262887 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262887 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262887 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262887 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262887 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262887 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262887 , Out_Dummy15_g262887 , Out_PositionOS15_g262887 , Out_NormalOS15_g262887 , Out_TangentOS15_g262887 , Out_TransformData15_g262887 , Out_RotationData15_g262887 , Out_Interpolator15_g262887 );
					TVEVertexData Data16_g262888 =(TVEVertexData)Data15_g262887;
					half Dummy181_g262880 = ( _SizeFadeCategory + _SizeFadeEnd );
					float In_Dummy16_g262888 = Dummy181_g262880;
					float3 Model_PositionOS147_g262880 = Out_PositionOS15_g262887;
					float3 temp_cast_17 = (1.0).xxx;
					TVEModelData Data15_g262877 =(TVEModelData)Data15_g262868;
					float Out_Dummy15_g262877 = 0.0;
					float3 Out_PositionOS15_g262877 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262877 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262877 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262877 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262877 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262877 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262877 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262877 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262877 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262877 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262877 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262877 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262877 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262877 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262877 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262877 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262877 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262877 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262877 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262877 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262877 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262877 , Out_Dummy15_g262877 , Out_PositionOS15_g262877 , Out_PositionWS15_g262877 , Out_PositionWO15_g262877 , Out_PositionRawOS15_g262877 , Out_PivotOS15_g262877 , Out_PivotWS15_g262877 , Out_PivotWO15_g262877 , Out_NormalOS15_g262877 , Out_NormalWS15_g262877 , Out_NormalRawOS15_g262877 , Out_TangentOS15_g262877 , Out_TangentWS15_g262877 , Out_BitangentWS15_g262877 , Out_ViewDirWS15_g262877 , Out_CoordsData15_g262877 , Out_VertexData15_g262877 , Out_MasksData15_g262877 , Out_PhaseData15_g262877 , Out_TransformData15_g262877 , Out_RotationData15_g262877 , Out_Interpolator15_g262877 );
					TVEModelData Data15_g262889 =(TVEModelData)Data15_g262877;
					float Out_Dummy15_g262889 = 0.0;
					float3 Out_PositionOS15_g262889 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262889 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262889 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262889 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262889 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262889 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262889 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262889 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262889 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262889 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262889 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262889 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262889 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262889 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262889 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262889 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262889 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262889 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262889 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262889 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262889 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262889 , Out_Dummy15_g262889 , Out_PositionOS15_g262889 , Out_PositionWS15_g262889 , Out_PositionWO15_g262889 , Out_PositionRawOS15_g262889 , Out_PivotOS15_g262889 , Out_PivotWS15_g262889 , Out_PivotWO15_g262889 , Out_NormalOS15_g262889 , Out_NormalWS15_g262889 , Out_NormalRawOS15_g262889 , Out_TangentOS15_g262889 , Out_TangentWS15_g262889 , Out_BitangentWS15_g262889 , Out_ViewDirWS15_g262889 , Out_CoordsData15_g262889 , Out_VertexData15_g262889 , Out_MasksData15_g262889 , Out_PhaseData15_g262889 , Out_TransformData15_g262889 , Out_RotationData15_g262889 , Out_Interpolator15_g262889 );
					float3 Model_PivotWS162_g262880 = Out_PivotWS15_g262889;
					float lerpResult216_g262880 = lerp( 1.0 , TVE_SizeFadeParams.z , TVE_SizeFadeParams.w);
					float temp_output_7_0_g262882 = _SizeFadeDistMaxValue;
					float temp_output_9_0_g262882 = ( ( distance( _WorldSpaceCameraPos , Model_PivotWS162_g262880 ) * lerpResult216_g262880 ) - temp_output_7_0_g262882 );
					float temp_output_245_0_g262880 = (TVE_VertxParams).x;
					TVEGlobalData Data15_g262890 =(TVEGlobalData)Data15_g262873;
					float Out_Dummy15_g262890 = 0.0;
					float4 Out_CoatTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262890 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g262890 = float4( 0,0,0,0 );
					BreakData( Data15_g262890 , Out_Dummy15_g262890 , Out_CoatTexture15_g262890 , Out_DrawTexture15_g262890 , Out_PaintTexture15_g262890 , Out_AtmoTexture15_g262890 , Out_EffexTexture15_g262890 , Out_GlowTexture15_g262890 , Out_FormTexture15_g262890 , Out_LandTexture15_g262890 , Out_VertxTexture15_g262890 , Out_FlowTexture15_g262890 , Out_UserTexture15_g262890 );
					half4 Global_VertxTexture188_g262880 = Out_VertxTexture15_g262890;
					float temp_output_6_0_g262886 = (Global_VertxTexture188_g262880).x;
					float temp_output_7_0_g262886 = _SizeFadeVertxMode;
					#ifdef TVE_DUMMY
					float staticSwitch14_g262886 = ( temp_output_6_0_g262886 + temp_output_7_0_g262886 );
					#else
					float staticSwitch14_g262886 = temp_output_6_0_g262886;
					#endif
					float temp_output_223_0_g262880 = staticSwitch14_g262886;
					#ifdef TVE_SIZEFADE_VERTX
					float staticSwitch194_g262880 = temp_output_223_0_g262880;
					#else
					float staticSwitch194_g262880 = temp_output_245_0_g262880;
					#endif
					float lerpResult213_g262880 = lerp( 1.0 , staticSwitch194_g262880 , ( _SizeFadeVertxValue * TVE_IsEnabled ));
					half Blend_GlobalMask192_g262880 = lerpResult213_g262880;
					half Blend_UserMask232_g262880 = 1.0;
					float temp_output_236_0_g262880 = ( Blend_GlobalMask192_g262880 * Blend_UserMask232_g262880 );
					half Blend_Mask240_g262880 = temp_output_236_0_g262880;
					float temp_output_189_0_g262880 = ( saturate( ( temp_output_9_0_g262882 / ( ( _SizeFadeDistMinValue - temp_output_7_0_g262882 ) + 0.0001 ) ) ) * _SizeFadeScaleValue * Blend_Mask240_g262880 );
					float3 appendResult200_g262880 = (float3(temp_output_189_0_g262880 , temp_output_189_0_g262880 , temp_output_189_0_g262880));
					float3 appendResult201_g262880 = (float3(1.0 , temp_output_189_0_g262880 , 1.0));
					float3 appendResult230_g262880 = (float3(1.0 , 1.0 , temp_output_189_0_g262880));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262883 = appendResult230_g262880;
					#else
					float3 staticSwitch65_g262883 = appendResult201_g262880;
					#endif
					float3 lerpResult202_g262880 = lerp( appendResult200_g262880 , staticSwitch65_g262883 , _SizeFadeScaleMode);
					float3 lerpResult184_g262880 = lerp( temp_cast_17 , lerpResult202_g262880 , _SizeFadeIntensityValue);
					float3 temp_output_167_0_g262880 = ( lerpResult184_g262880 * Model_PositionOS147_g262880 );
					#ifdef TVE_SIZEFADE
					float3 staticSwitch199_g262880 = temp_output_167_0_g262880;
					#else
					float3 staticSwitch199_g262880 = Model_PositionOS147_g262880;
					#endif
					float3 Final_Position178_g262880 = staticSwitch199_g262880;
					float3 In_PositionOS16_g262888 = Final_Position178_g262880;
					float3 In_NormalOS16_g262888 = Out_NormalOS15_g262887;
					float4 In_TangentOS16_g262888 = Out_TangentOS15_g262887;
					float4 In_TransformData16_g262888 = Out_TransformData15_g262887;
					float4 In_RotationData16_g262888 = Out_RotationData15_g262887;
					float4 In_Interpolator16_g262888 = Out_Interpolator15_g262887;
					BuildVertexData( Data16_g262888 , In_Dummy16_g262888 , In_PositionOS16_g262888 , In_NormalOS16_g262888 , In_TangentOS16_g262888 , In_TransformData16_g262888 , In_RotationData16_g262888 , In_Interpolator16_g262888 );
					TVEVertexData Data15_g262912 =(TVEVertexData)Data16_g262888;
					float Out_Dummy15_g262912 = 0.0;
					float3 Out_PositionOS15_g262912 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262912 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262912 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262912 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262912 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262912 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262912 , Out_Dummy15_g262912 , Out_PositionOS15_g262912 , Out_NormalOS15_g262912 , Out_TangentOS15_g262912 , Out_TransformData15_g262912 , Out_RotationData15_g262912 , Out_Interpolator15_g262912 );
					TVEVertexData Data16_g262913 =(TVEVertexData)Data15_g262912;
					half Dummy181_g262899 = ( ( _MotionCategory + _MotionEnd ) + _MotionFlowInfo );
					float In_Dummy16_g262913 = Dummy181_g262899;
					float3 temp_output_3325_0_g262899 = Out_PositionOS15_g262912;
					float3 In_PositionOS16_g262913 = temp_output_3325_0_g262899;
					float3 In_NormalOS16_g262913 = Out_NormalOS15_g262912;
					float4 In_TangentOS16_g262913 = Out_TangentOS15_g262912;
					half4 Vertex_TransformData2743_g262899 = Out_TransformData15_g262912;
					float3 temp_cast_18 = (0.0).xxx;
					half Motion_FlowValue3376_g262899 = _MotionFlowValue;
					float2 lerpResult3361_g262899 = lerp( (half4( 1, 1, 1, 0 )).xy , (TVE_WindParams).xy , ( Motion_FlowValue3376_g262899 * TVE_IsEnabled ));
					float2 Global_WindDirWS2542_g262899 = (lerpResult3361_g262899*2.0 + -1.0);
					half2 Input_WindDirWS803_g262946 = Global_WindDirWS2542_g262899;
					TVEModelData Data15_g262911 =(TVEModelData)Data15_g262889;
					float Out_Dummy15_g262911 = 0.0;
					float3 Out_PositionOS15_g262911 = float3( 0,0,0 );
					float3 Out_PositionWS15_g262911 = float3( 0,0,0 );
					float3 Out_PositionWO15_g262911 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g262911 = float3( 0,0,0 );
					float3 Out_PivotOS15_g262911 = float3( 0,0,0 );
					float3 Out_PivotWS15_g262911 = float3( 0,0,0 );
					float3 Out_PivotWO15_g262911 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262911 = float3( 0,0,0 );
					float3 Out_NormalWS15_g262911 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g262911 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262911 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g262911 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g262911 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g262911 = float3( 0,0,0 );
					float4 Out_CoordsData15_g262911 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g262911 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g262911 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g262911 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262911 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262911 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262911 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g262911 , Out_Dummy15_g262911 , Out_PositionOS15_g262911 , Out_PositionWS15_g262911 , Out_PositionWO15_g262911 , Out_PositionRawOS15_g262911 , Out_PivotOS15_g262911 , Out_PivotWS15_g262911 , Out_PivotWO15_g262911 , Out_NormalOS15_g262911 , Out_NormalWS15_g262911 , Out_NormalRawOS15_g262911 , Out_TangentOS15_g262911 , Out_TangentWS15_g262911 , Out_BitangentWS15_g262911 , Out_ViewDirWS15_g262911 , Out_CoordsData15_g262911 , Out_VertexData15_g262911 , Out_MasksData15_g262911 , Out_PhaseData15_g262911 , Out_TransformData15_g262911 , Out_RotationData15_g262911 , Out_Interpolator15_g262911 );
					float3 Model_PositionWO162_g262899 = Out_PositionWO15_g262911;
					half3 Input_ModelPositionWO761_g262909 = Model_PositionWO162_g262899;
					float3 Model_PivotWO402_g262899 = Out_PivotWO15_g262911;
					half3 Input_ModelPivotsWO419_g262909 = Model_PivotWO402_g262899;
					half Input_MotionPivots629_g262909 = _MotionSmallPivotValue;
					float3 lerpResult771_g262909 = lerp( Input_ModelPositionWO761_g262909 , Input_ModelPivotsWO419_g262909 , Input_MotionPivots629_g262909);
					half4 Model_PhaseData489_g262899 = Out_PhaseData15_g262911;
					half4 Input_ModelMotionData763_g262909 = Model_PhaseData489_g262899;
					half Input_MotionPhase764_g262909 = _MotionSmallPhaseValue;
					float temp_output_770_0_g262909 = ( (Input_ModelMotionData763_g262909).x * Input_MotionPhase764_g262909 );
					half3 Small_Position1421_g262899 = ( lerpResult771_g262909 + temp_output_770_0_g262909 );
					half3 Input_PositionWO419_g262946 = Small_Position1421_g262899;
					half Input_MotionTilling321_g262946 = ( _MotionSmallTillingValue + 0.2 );
					half2 Noise_Coord979_g262946 = ( -(Input_PositionWO419_g262946).xz * Input_MotionTilling321_g262946 * 0.005 );
					float2 Input_Coords80_g262950 = Noise_Coord979_g262946;
					half2 Input_Direction82_g262950 = Input_WindDirWS803_g262946;
					float mulTime113_g262964 = _Time.y * 0.02;
					float lerpResult128_g262964 = lerp( mulTime113_g262964 , ( ( mulTime113_g262964 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					#ifdef SHADER_API_MOBILE
					float staticSwitch134_g262964 = frac( lerpResult128_g262964 );
					#else
					float staticSwitch134_g262964 = lerpResult128_g262964;
					#endif
					float Global_WindTime3262_g262899 = staticSwitch134_g262964;
					half Input_WindTime1015_g262946 = Global_WindTime3262_g262899;
					half Input_MotionSpeed62_g262946 = _MotionSmallSpeedValue;
					float temp_output_986_0_g262946 = ( Input_WindTime1015_g262946 * Input_MotionSpeed62_g262946 );
					half Noise_Speed980_g262946 = temp_output_986_0_g262946;
					float Input_Time88_g262950 = Noise_Speed980_g262946;
					float temp_output_23_0_g262950 = frac( Input_Time88_g262950 );
					float4 lerpResult39_g262950 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g262950 + ( Input_Direction82_g262950 * temp_output_23_0_g262950 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g262950 + ( Input_Direction82_g262950 * ( temp_output_23_0_g262950 - 1.0 ) ) ), 0.0 ) , temp_output_23_0_g262950);
					float4 temp_output_991_0_g262946 = lerpResult39_g262950;
					half2 Noise_DirWS858_g262946 = ((temp_output_991_0_g262946).rg*2.0 + -1.0);
					half Input_MotionNoise552_g262946 = _MotionSmallNoiseValue;
					float4 temp_output_3332_0_g262899 = TVE_FlowParams;
					TVEGlobalData Data15_g262925 =(TVEGlobalData)Data15_g262890;
					float Out_Dummy15_g262925 = 0.0;
					float4 Out_CoatTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g262925 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g262925 = float4( 0,0,0,0 );
					BreakData( Data15_g262925 , Out_Dummy15_g262925 , Out_CoatTexture15_g262925 , Out_DrawTexture15_g262925 , Out_PaintTexture15_g262925 , Out_AtmoTexture15_g262925 , Out_EffexTexture15_g262925 , Out_GlowTexture15_g262925 , Out_FormTexture15_g262925 , Out_LandTexture15_g262925 , Out_VertxTexture15_g262925 , Out_FlowTexture15_g262925 , Out_UserTexture15_g262925 );
					half4 Global_FlowTexture2668_g262899 = Out_FlowTexture15_g262925;
					#ifdef TVE_MOTION_FLOW
					float4 staticSwitch3075_g262899 = Global_FlowTexture2668_g262899;
					#else
					float4 staticSwitch3075_g262899 = temp_output_3332_0_g262899;
					#endif
					float4 temp_output_6_0_g262926 = staticSwitch3075_g262899;
					float temp_output_7_0_g262926 = _MotionFlowMode;
					#ifdef TVE_DUMMY
					float4 staticSwitch14_g262926 = ( temp_output_6_0_g262926 + temp_output_7_0_g262926 );
					#else
					float4 staticSwitch14_g262926 = temp_output_6_0_g262926;
					#endif
					float4 lerpResult3121_g262899 = lerp( half4( 1, 1, 1, 0 ) , staticSwitch14_g262926 , ( Motion_FlowValue3376_g262899 * TVE_IsEnabled ));
					float temp_output_3077_0_g262899 = (lerpResult3121_g262899).z;
					float temp_output_630_0_g262935 = temp_output_3077_0_g262899;
					float lerpResult853_g262935 = lerp( temp_output_630_0_g262935 , TVE_WindEditor.z , TVE_WindEditor.w);
					half Global_WindValue1855_g262899 = ( lerpResult853_g262935 * _MotionIntensityValue );
					half Input_WindValue881_g262946 = Global_WindValue1855_g262899;
					float temp_output_6_0_g262948 = Input_WindValue881_g262946;
					float lerpResult701_g262946 = lerp( 1.0 , Input_MotionNoise552_g262946 , ( temp_output_6_0_g262948 * temp_output_6_0_g262948 ));
					float2 lerpResult646_g262946 = lerp( Input_WindDirWS803_g262946 , Noise_DirWS858_g262946 , lerpResult701_g262946);
					half2 Small_DirWS817_g262946 = lerpResult646_g262946;
					float2 break823_g262946 = Small_DirWS817_g262946;
					half4 Noise_Params685_g262946 = temp_output_991_0_g262946;
					half Wind_Sinus820_g262946 = ( ((Noise_Params685_g262946).b*2.0 + -1.0) * 0.6 );
					float3 appendResult824_g262946 = (float3(break823_g262946.x , Wind_Sinus820_g262946 , break823_g262946.y));
					half3 Small_Dir918_g262946 = appendResult824_g262946;
					float temp_output_20_0_g262947 = ( 1.0 - Input_WindValue881_g262946 );
					float3 appendResult1006_g262946 = (float3(Input_WindValue881_g262946 , ( 1.0 - ( temp_output_20_0_g262947 * temp_output_20_0_g262947 ) ) , Input_WindValue881_g262946));
					half Input_MotionDelay753_g262946 = _MotionSmallDelayValue;
					float lerpResult756_g262946 = lerp( 1.0 , ( Input_WindValue881_g262946 * Input_WindValue881_g262946 ) , Input_MotionDelay753_g262946);
					half Wind_Delay815_g262946 = lerpResult756_g262946;
					half Input_MotionValue905_g262946 = _MotionSmallIntensityValue;
					float3 temp_output_883_0_g262946 = ( Small_Dir918_g262946 * appendResult1006_g262946 * Wind_Delay815_g262946 * Input_MotionValue905_g262946 );
					float2 break857_g262946 = Noise_DirWS858_g262946;
					float3 appendResult833_g262946 = (float3(break857_g262946.x , Wind_Sinus820_g262946 , break857_g262946.y));
					half3 Push_Dir919_g262946 = appendResult833_g262946;
					half Input_MotionReact924_g262946 = _MotionSmallPushValue;
					half Global_PushAlpha1504_g262899 = (lerpResult3121_g262899).w;
					half Input_PushAlpha806_g262946 = Global_PushAlpha1504_g262899;
					half Global_PushNoise2675_g262899 = temp_output_3077_0_g262899;
					half Input_PushNoise890_g262946 = Global_PushNoise2675_g262899;
					half Push_Mask914_g262946 = saturate( ( Input_PushAlpha806_g262946 * Input_PushNoise890_g262946 * Input_MotionReact924_g262946 ) );
					float3 lerpResult840_g262946 = lerp( temp_output_883_0_g262946 , ( Push_Dir919_g262946 * Input_MotionReact924_g262946 ) , Push_Mask914_g262946);
					#ifdef TVE_MOTION_FLOW
					float3 staticSwitch829_g262946 = lerpResult840_g262946;
					#else
					float3 staticSwitch829_g262946 = temp_output_883_0_g262946;
					#endif
					half3 Small_Squash1489_g262899 = ( mul( unity_WorldToObject, float4( staticSwitch829_g262946 , 0.0 ) ).xyz * ase_parentObjectScale );
					float temp_output_17_0_g262914 = _MotionSmallMaskMode;
					float Option92_g262914 = temp_output_17_0_g262914;
					half4 Model_VertexMasks518_g262899 = Out_VertexData15_g262911;
					float4 temp_output_84_0_g262914 = Model_VertexMasks518_g262899;
					float4 ChannelA92_g262914 = temp_output_84_0_g262914;
					half4 Model_MasksData1322_g262899 = Out_MasksData15_g262911;
					float2 uv_MotionMaskTex2818_g262899 = v.ase_texcoord.xy;
					half4 Motion_MaskTex2819_g262899 = SAMPLE_TEXTURE2D_LOD( _MotionMaskTex, sampler_MotionMaskTex, uv_MotionMaskTex2818_g262899, 0.0 );
					float3 appendResult3227_g262899 = (float3((Model_MasksData1322_g262899).xy , (Motion_MaskTex2819_g262899).g));
					float3 temp_output_85_0_g262914 = appendResult3227_g262899;
					float4 ChannelB92_g262914 = float4( temp_output_85_0_g262914 , 0.0 );
					float localSwitchChannel792_g262914 = SwitchChannel7( Option92_g262914 , ChannelA92_g262914 , ChannelB92_g262914 );
					float enc1805_g262899 = v.ase_texcoord.z;
					float2 localDecodeFloatToVector21805_g262899 = DecodeFloatToVector2( enc1805_g262899 );
					float2 break1804_g262899 = localDecodeFloatToVector21805_g262899;
					half Small_Mask_Legacy1806_g262899 = break1804_g262899.x;
					#ifdef TVE_LEGACY
					float staticSwitch1800_g262899 = Small_Mask_Legacy1806_g262899;
					#else
					float staticSwitch1800_g262899 = localSwitchChannel792_g262914;
					#endif
					float clampResult17_g262900 = clamp( staticSwitch1800_g262899 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262901 = _MotionSmallMaskRemap.x;
					float temp_output_9_0_g262901 = ( clampResult17_g262900 - temp_output_7_0_g262901 );
					half Small_Mask640_g262899 = saturate( ( temp_output_9_0_g262901 * _MotionSmallMaskRemap.z ) );
					float3 lerpResult3022_g262899 = lerp( float3( 1,1,1 ) , (TVE_MotionValueParams).xyz , TVE_MotionValueParams.w);
					half3 Global_MotionParams3013_g262899 = lerpResult3022_g262899;
					half3 Small_Motion789_g262899 = ( Small_Squash1489_g262899 * Small_Mask640_g262899 * (Global_MotionParams3013_g262899).y );
					#ifdef TVE_MOTION
					float3 staticSwitch495_g262899 = Small_Motion789_g262899;
					#else
					float3 staticSwitch495_g262899 = temp_cast_18;
					#endif
					float3 temp_cast_22 = (0.0).xxx;
					half3 Tiny_Position2469_g262899 = Model_PositionWO162_g262899;
					half3 Input_PositionWO419_g262965 = Tiny_Position2469_g262899;
					half Input_MotionTilling321_g262965 = ( _MotionTinyTillingValue + 0.2 );
					half2 Noise_Coord979_g262965 = ( -(Input_PositionWO419_g262965).xz * Input_MotionTilling321_g262965 * 0.005 );
					float2 Input_Coords80_g262972 = Noise_Coord979_g262965;
					half2 Input_Direction82_g262972 = float2( 0,1 );
					half Input_WindTime1015_g262965 = Global_WindTime3262_g262899;
					half Input_MotionSpeed62_g262965 = _MotionTinySpeedValue;
					float temp_output_986_0_g262965 = ( Input_WindTime1015_g262965 * Input_MotionSpeed62_g262965 );
					half Noise_Speed980_g262965 = temp_output_986_0_g262965;
					float Input_Time88_g262972 = Noise_Speed980_g262965;
					float4 temp_output_991_0_g262965 = SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g262972 + ( Input_Direction82_g262972 * Input_Time88_g262972 ) ), 0.0 );
					half3 Noise_DirWS858_g262965 = ((temp_output_991_0_g262965).rgb*2.0 + -1.0);
					half Input_MotionNoise552_g262965 = _MotionTinyNoiseValue;
					float3 lerpResult646_g262965 = lerp( ( Noise_DirWS858_g262965 * v.normal ) , Noise_DirWS858_g262965 , Input_MotionNoise552_g262965);
					half3 Tiny_DirWS817_g262965 = lerpResult646_g262965;
					half Input_MotionValue905_g262965 = _MotionTinyIntensityValue;
					float mulTime113_g262978 = _Time.y * 2.0;
					float lerpResult128_g262978 = lerp( mulTime113_g262978 , ( ( mulTime113_g262978 * TVE_MotionTimeParams.x ) + TVE_MotionTimeParams.y ) , TVE_MotionTimeParams.w);
					#ifdef SHADER_API_MOBILE
					float staticSwitch134_g262978 = frac( lerpResult128_g262978 );
					#else
					float staticSwitch134_g262978 = lerpResult128_g262978;
					#endif
					float3 temp_output_1028_0_g262965 = ( Input_PositionWO419_g262965 + staticSwitch134_g262978 );
					float temp_output_1054_0_g262965 = SAMPLE_TEXTURE3D_LOD( _NoiseTex3D, sampler_Linear_Repeat, ( temp_output_1028_0_g262965 * ( 1.0 * 0.01 ) ), 0.0 ).r;
					float temp_output_6_0_g262968 = temp_output_1054_0_g262965;
					float temp_output_6_0_g262969 = temp_output_1054_0_g262965;
					half Input_WindValue881_g262965 = Global_WindValue1855_g262899;
					float temp_output_6_0_g262971 = Input_WindValue881_g262965;
					float lerpResult1029_g262965 = lerp( ( temp_output_6_0_g262968 * temp_output_6_0_g262968 * temp_output_6_0_g262968 * temp_output_6_0_g262968 ) , ( temp_output_6_0_g262969 * temp_output_6_0_g262969 ) , ( temp_output_6_0_g262971 * temp_output_6_0_g262971 ));
					float temp_output_20_0_g262970 = ( 1.0 - Input_WindValue881_g262965 );
					float temp_output_1030_0_g262965 = ( lerpResult1029_g262965 * ( 1.0 - ( temp_output_20_0_g262970 * temp_output_20_0_g262970 * temp_output_20_0_g262970 * temp_output_20_0_g262970 ) ) );
					half Wind_Gust1039_g262965 = temp_output_1030_0_g262965;
					float3 temp_output_883_0_g262965 = ( Tiny_DirWS817_g262965 * Input_MotionValue905_g262965 * Wind_Gust1039_g262965 );
					half3 Tiny_Squash859_g262899 = temp_output_883_0_g262965;
					float temp_output_17_0_g262915 = _MotionTinyMaskMode;
					float Option92_g262915 = temp_output_17_0_g262915;
					float4 temp_output_84_0_g262915 = Model_VertexMasks518_g262899;
					float4 ChannelA92_g262915 = temp_output_84_0_g262915;
					float3 appendResult3234_g262899 = (float3((Model_MasksData1322_g262899).xy , (Motion_MaskTex2819_g262899).b));
					float3 temp_output_85_0_g262915 = appendResult3234_g262899;
					float4 ChannelB92_g262915 = float4( temp_output_85_0_g262915 , 0.0 );
					float localSwitchChannel792_g262915 = SwitchChannel7( Option92_g262915 , ChannelA92_g262915 , ChannelB92_g262915 );
					half Tiny_Mask_Legacy1807_g262899 = break1804_g262899.y;
					#ifdef TVE_LEGACY
					float staticSwitch1810_g262899 = Tiny_Mask_Legacy1807_g262899;
					#else
					float staticSwitch1810_g262899 = localSwitchChannel792_g262915;
					#endif
					float clampResult17_g262902 = clamp( staticSwitch1810_g262899 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262903 = _MotionTinyMaskRemap.x;
					float temp_output_9_0_g262903 = ( clampResult17_g262902 - temp_output_7_0_g262903 );
					half Tiny_Mask218_g262899 = saturate( ( temp_output_9_0_g262903 * _MotionTinyMaskRemap.z ) );
					float3 Model_PositionWS1819_g262899 = Out_PositionWS15_g262911;
					half Global_DistMask1820_g262899 = ( 1.0 - saturate( ( distance( _WorldSpaceCameraPos , Model_PositionWS1819_g262899 ) / _MotionDistValue ) ) );
					half3 Tiny_Flutter1451_g262899 = ( Tiny_Squash859_g262899 * Tiny_Mask218_g262899 * Global_DistMask1820_g262899 * (Global_MotionParams3013_g262899).z );
					#ifdef TVE_MOTION
					float3 staticSwitch414_g262899 = Tiny_Flutter1451_g262899;
					#else
					float3 staticSwitch414_g262899 = temp_cast_22;
					#endif
					float4 appendResult2783_g262899 = (float4(( staticSwitch495_g262899 + staticSwitch414_g262899 ) , 0.0));
					half4 Final_TransformData1569_g262899 = ( Vertex_TransformData2743_g262899 + appendResult2783_g262899 );
					float4 In_TransformData16_g262913 = Final_TransformData1569_g262899;
					half4 Vertex_RotationData2740_g262899 = Out_RotationData15_g262912;
					half2 Input_WindDirWS803_g262936 = Global_WindDirWS2542_g262899;
					half3 Input_ModelPositionWO761_g262910 = Model_PositionWO162_g262899;
					half3 Input_ModelPivotsWO419_g262910 = Model_PivotWO402_g262899;
					half Input_MotionPivots629_g262910 = _MotionBasePivotValue;
					float3 lerpResult771_g262910 = lerp( Input_ModelPositionWO761_g262910 , Input_ModelPivotsWO419_g262910 , Input_MotionPivots629_g262910);
					half4 Input_ModelMotionData763_g262910 = Model_PhaseData489_g262899;
					half Input_MotionPhase764_g262910 = _MotionBasePhaseValue;
					float temp_output_770_0_g262910 = ( (Input_ModelMotionData763_g262910).x * Input_MotionPhase764_g262910 );
					half3 Base_Position1394_g262899 = ( lerpResult771_g262910 + temp_output_770_0_g262910 );
					half3 Input_PositionWO419_g262936 = Base_Position1394_g262899;
					half Input_MotionTilling321_g262936 = ( _MotionBaseTillingValue + 0.2 );
					half2 Noise_Coord515_g262936 = ( -(Input_PositionWO419_g262936).xz * Input_MotionTilling321_g262936 * 0.005 );
					float2 Input_Coords80_g262938 = Noise_Coord515_g262936;
					half2 Input_Direction82_g262938 = Input_WindDirWS803_g262936;
					half Input_WindTime963_g262936 = Global_WindTime3262_g262899;
					half Input_MotionSpeed62_g262936 = _MotionBaseSpeedValue;
					float temp_output_505_0_g262936 = ( Input_WindTime963_g262936 * Input_MotionSpeed62_g262936 );
					half Noise_Speed516_g262936 = temp_output_505_0_g262936;
					float Input_Time88_g262938 = Noise_Speed516_g262936;
					float temp_output_23_0_g262938 = frac( Input_Time88_g262938 );
					float4 lerpResult39_g262938 = lerp( SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g262938 + ( Input_Direction82_g262938 * temp_output_23_0_g262938 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( _MotionNoiseTex, sampler_Linear_Repeat, ( Input_Coords80_g262938 + ( Input_Direction82_g262938 * ( temp_output_23_0_g262938 - 1.0 ) ) ), 0.0 ) , temp_output_23_0_g262938);
					float4 temp_output_635_0_g262936 = lerpResult39_g262938;
					half2 Noise_DirWS825_g262936 = ((temp_output_635_0_g262936).rg*2.0 + -1.0);
					half Input_MotionNoise552_g262936 = _MotionBaseNoiseValue;
					half Input_WindValue853_g262936 = Global_WindValue1855_g262899;
					float temp_output_6_0_g262937 = Input_WindValue853_g262936;
					float lerpResult701_g262936 = lerp( 1.0 , Input_MotionNoise552_g262936 , ( temp_output_6_0_g262937 * temp_output_6_0_g262937 ));
					float2 lerpResult646_g262936 = lerp( Input_WindDirWS803_g262936 , Noise_DirWS825_g262936 , lerpResult701_g262936);
					half2 Bend_Dir859_g262936 = lerpResult646_g262936;
					half Input_MotionValue871_g262936 = _MotionBaseIntensityValue;
					half Input_MotionDelay753_g262936 = _MotionBaseDelayValue;
					float lerpResult756_g262936 = lerp( 1.0 , ( Input_WindValue853_g262936 * Input_WindValue853_g262936 ) , Input_MotionDelay753_g262936);
					half Wind_Delay815_g262936 = lerpResult756_g262936;
					float2 temp_output_875_0_g262936 = ( Bend_Dir859_g262936 * Input_WindValue853_g262936 * Input_MotionValue871_g262936 * Wind_Delay815_g262936 );
					float2 Global_PushDirWS1972_g262899 = ((lerpResult3121_g262899).xy*2.0 + -1.0);
					half2 Input_PushDirWS807_g262936 = Global_PushDirWS1972_g262899;
					half Input_ReactValue888_g262936 = _MotionBasePushValue;
					half Input_PushAlpha806_g262936 = Global_PushAlpha1504_g262899;
					half Push_Mask883_g262936 = saturate( ( Input_PushAlpha806_g262936 * Input_ReactValue888_g262936 ) );
					float2 lerpResult811_g262936 = lerp( temp_output_875_0_g262936 , ( Input_PushDirWS807_g262936 * Input_ReactValue888_g262936 ) , Push_Mask883_g262936);
					#ifdef TVE_MOTION_FLOW
					float2 staticSwitch808_g262936 = lerpResult811_g262936;
					#else
					float2 staticSwitch808_g262936 = temp_output_875_0_g262936;
					#endif
					float2 temp_output_38_0_g262942 = staticSwitch808_g262936;
					float2 break83_g262942 = temp_output_38_0_g262942;
					float3 appendResult79_g262942 = (float3(break83_g262942.x , 0.0 , break83_g262942.y));
					half2 Base_Bending893_g262899 = (( mul( unity_WorldToObject, float4( appendResult79_g262942 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
					float temp_output_17_0_g262916 = _MotionBaseMaskMode;
					float Option92_g262916 = temp_output_17_0_g262916;
					float4 temp_output_84_0_g262916 = Model_VertexMasks518_g262899;
					float4 ChannelA92_g262916 = temp_output_84_0_g262916;
					float3 appendResult3220_g262899 = (float3((Model_MasksData1322_g262899).xy , (Motion_MaskTex2819_g262899).r));
					float3 temp_output_85_0_g262916 = appendResult3220_g262899;
					float4 ChannelB92_g262916 = float4( temp_output_85_0_g262916 , 0.0 );
					float localSwitchChannel792_g262916 = SwitchChannel7( Option92_g262916 , ChannelA92_g262916 , ChannelB92_g262916 );
					float clampResult17_g262905 = clamp( localSwitchChannel792_g262916 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262904 = _MotionBaseMaskRemap.x;
					float temp_output_9_0_g262904 = ( clampResult17_g262905 - temp_output_7_0_g262904 );
					half Base_Mask217_g262899 = saturate( ( temp_output_9_0_g262904 * _MotionBaseMaskRemap.z ) );
					half2 Base_Motion1440_g262899 = ( Base_Bending893_g262899 * Base_Mask217_g262899 * (Global_MotionParams3013_g262899).x );
					#ifdef TVE_MOTION
					float2 staticSwitch2384_g262899 = Base_Motion1440_g262899;
					#else
					float2 staticSwitch2384_g262899 = float2( 0,0 );
					#endif
					float4 appendResult2023_g262899 = (float4(staticSwitch2384_g262899 , 0.0 , 0.0));
					half4 Final_RotationData1570_g262899 = ( Vertex_RotationData2740_g262899 + appendResult2023_g262899 );
					float4 In_RotationData16_g262913 = Final_RotationData1570_g262899;
					half4 Vertex_Interpolator2773_g262899 = Out_Interpolator15_g262912;
					half4 Noise_Params685_g262936 = temp_output_635_0_g262936;
					float temp_output_6_0_g262944 = (Noise_Params685_g262936).a;
					float temp_output_913_0_g262936 = ( ( temp_output_6_0_g262944 * temp_output_6_0_g262944 * temp_output_6_0_g262944 * temp_output_6_0_g262944 ) * ( Input_WindValue853_g262936 * Wind_Delay815_g262936 ) );
					float temp_output_6_0_g262945 = length( Input_PushDirWS807_g262936 );
					float temp_output_937_0_g262936 = ( temp_output_6_0_g262945 * temp_output_6_0_g262945 );
					half Input_PushNoise858_g262936 = Global_PushNoise2675_g262899;
					float lerpResult902_g262936 = lerp( temp_output_913_0_g262936 , temp_output_937_0_g262936 , ( Push_Mask883_g262936 * Input_PushNoise858_g262936 ));
					#ifdef TVE_MOTION_FLOW
					float staticSwitch903_g262936 = lerpResult902_g262936;
					#else
					float staticSwitch903_g262936 = temp_output_913_0_g262936;
					#endif
					half Base_Wave1159_g262899 = staticSwitch903_g262936;
					float temp_output_6_0_g262949 = (Noise_Params685_g262946).a;
					float temp_output_955_0_g262946 = ( temp_output_6_0_g262949 * temp_output_6_0_g262949 * temp_output_6_0_g262949 * temp_output_6_0_g262949 );
					float temp_output_944_0_g262946 = ( temp_output_955_0_g262946 * ( Input_WindValue881_g262946 * Wind_Delay815_g262946 ) );
					float lerpResult936_g262946 = lerp( temp_output_944_0_g262946 , temp_output_955_0_g262946 , ( Push_Mask914_g262946 * Input_PushNoise890_g262946 ));
					#ifdef TVE_MOTION_FLOW
					float staticSwitch939_g262946 = lerpResult936_g262946;
					#else
					float staticSwitch939_g262946 = temp_output_944_0_g262946;
					#endif
					half Small_Wave1427_g262899 = staticSwitch939_g262946;
					float lerpResult2422_g262899 = lerp( Base_Wave1159_g262899 , Small_Wave1427_g262899 , _motion_small_mode);
					half Global_Wave1475_g262899 = saturate( lerpResult2422_g262899 );
					float temp_output_6_0_g262906 = ( _MotionHighlightValue * Global_DistMask1820_g262899 * ( Tiny_Mask218_g262899 * Tiny_Mask218_g262899 ) * Global_Wave1475_g262899 );
					float temp_output_7_0_g262906 = _MotionHighlightColor.r;
					#ifdef TVE_DUMMY
					float staticSwitch14_g262906 = ( temp_output_6_0_g262906 + temp_output_7_0_g262906 );
					#else
					float staticSwitch14_g262906 = temp_output_6_0_g262906;
					#endif
					#ifdef TVE_MOTION
					float staticSwitch2866_g262899 = staticSwitch14_g262906;
					#else
					float staticSwitch2866_g262899 = 0.0;
					#endif
					float4 appendResult2775_g262899 = (float4((Vertex_Interpolator2773_g262899).xyz , staticSwitch2866_g262899));
					half4 Final_Interpolator2774_g262899 = appendResult2775_g262899;
					float4 In_Interpolator16_g262913 = Final_Interpolator2774_g262899;
					BuildVertexData( Data16_g262913 , In_Dummy16_g262913 , In_PositionOS16_g262913 , In_NormalOS16_g262913 , In_TangentOS16_g262913 , In_TransformData16_g262913 , In_RotationData16_g262913 , In_Interpolator16_g262913 );
					TVEVertexData Data15_g262988 =(TVEVertexData)Data16_g262913;
					float Out_Dummy15_g262988 = 0.0;
					float3 Out_PositionOS15_g262988 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262988 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262988 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262988 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262988 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262988 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262988 , Out_Dummy15_g262988 , Out_PositionOS15_g262988 , Out_NormalOS15_g262988 , Out_TangentOS15_g262988 , Out_TransformData15_g262988 , Out_RotationData15_g262988 , Out_Interpolator15_g262988 );
					TVEVertexData Data16_g262989 =(TVEVertexData)Data15_g262988;
					float In_Dummy16_g262989 = 0.0;
					float3 Vertex_PositionOS147_g262979 = Out_PositionOS15_g262988;
					half3 VertexPos40_g262983 = Vertex_PositionOS147_g262979;
					float4 temp_output_1615_33_g262979 = Out_RotationData15_g262988;
					half4 Vertex_RotationData1569_g262979 = temp_output_1615_33_g262979;
					float2 break1582_g262979 = (Vertex_RotationData1569_g262979).xy;
					half Angle44_g262983 = break1582_g262979.y;
					half CosAngle89_g262983 = cos( Angle44_g262983 );
					half SinAngle93_g262983 = sin( Angle44_g262983 );
					float3 appendResult95_g262983 = (float3((VertexPos40_g262983).x , ( ( (VertexPos40_g262983).y * CosAngle89_g262983 ) - ( (VertexPos40_g262983).z * SinAngle93_g262983 ) ) , ( ( (VertexPos40_g262983).y * SinAngle93_g262983 ) + ( (VertexPos40_g262983).z * CosAngle89_g262983 ) )));
					half3 VertexPos40_g262984 = appendResult95_g262983;
					half Angle44_g262984 = -break1582_g262979.x;
					half CosAngle94_g262984 = cos( Angle44_g262984 );
					half SinAngle95_g262984 = sin( Angle44_g262984 );
					float3 appendResult98_g262984 = (float3(( ( (VertexPos40_g262984).x * CosAngle94_g262984 ) - ( (VertexPos40_g262984).y * SinAngle95_g262984 ) ) , ( ( (VertexPos40_g262984).x * SinAngle95_g262984 ) + ( (VertexPos40_g262984).y * CosAngle94_g262984 ) ) , (VertexPos40_g262984).z));
					half3 VertexPos40_g262982 = Vertex_PositionOS147_g262979;
					half Angle44_g262982 = break1582_g262979.y;
					half CosAngle89_g262982 = cos( Angle44_g262982 );
					half SinAngle93_g262982 = sin( Angle44_g262982 );
					float3 appendResult95_g262982 = (float3((VertexPos40_g262982).x , ( ( (VertexPos40_g262982).y * CosAngle89_g262982 ) - ( (VertexPos40_g262982).z * SinAngle93_g262982 ) ) , ( ( (VertexPos40_g262982).y * SinAngle93_g262982 ) + ( (VertexPos40_g262982).z * CosAngle89_g262982 ) )));
					half3 VertexPos40_g262987 = appendResult95_g262982;
					half Angle44_g262987 = break1582_g262979.x;
					half CosAngle91_g262987 = cos( Angle44_g262987 );
					half SinAngle92_g262987 = sin( Angle44_g262987 );
					float3 appendResult93_g262987 = (float3(( ( (VertexPos40_g262987).x * CosAngle91_g262987 ) + ( (VertexPos40_g262987).z * SinAngle92_g262987 ) ) , (VertexPos40_g262987).y , ( ( -(VertexPos40_g262987).x * SinAngle92_g262987 ) + ( (VertexPos40_g262987).z * CosAngle91_g262987 ) )));
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262985 = appendResult93_g262987;
					#else
					float3 staticSwitch65_g262985 = appendResult98_g262984;
					#endif
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g262980 = staticSwitch65_g262985;
					#else
					float3 staticSwitch65_g262980 = Vertex_PositionOS147_g262979;
					#endif
					float3 temp_output_1608_0_g262979 = staticSwitch65_g262980;
					half3 VertexPos40_g262986 = temp_output_1608_0_g262979;
					half Angle44_g262986 = (Vertex_RotationData1569_g262979).z;
					half CosAngle91_g262986 = cos( Angle44_g262986 );
					half SinAngle92_g262986 = sin( Angle44_g262986 );
					float3 appendResult93_g262986 = (float3(( ( (VertexPos40_g262986).x * CosAngle91_g262986 ) + ( (VertexPos40_g262986).z * SinAngle92_g262986 ) ) , (VertexPos40_g262986).y , ( ( -(VertexPos40_g262986).x * SinAngle92_g262986 ) + ( (VertexPos40_g262986).z * CosAngle91_g262986 ) )));
					#ifdef TVE_ROTATION_ROLL
					float3 staticSwitch65_g262981 = appendResult93_g262986;
					#else
					float3 staticSwitch65_g262981 = temp_output_1608_0_g262979;
					#endif
					float4 temp_output_1615_31_g262979 = Out_TransformData15_g262988;
					half4 Vertex_TransformData1568_g262979 = temp_output_1615_31_g262979;
					half3 Final_PositionOS178_g262979 = ( ( staticSwitch65_g262981 * (Vertex_TransformData1568_g262979).w ) + (Vertex_TransformData1568_g262979).xyz );
					float3 In_PositionOS16_g262989 = Final_PositionOS178_g262979;
					float3 In_NormalOS16_g262989 = Out_NormalOS15_g262988;
					float4 In_TangentOS16_g262989 = Out_TangentOS15_g262988;
					float4 In_TransformData16_g262989 = temp_output_1615_31_g262979;
					float4 In_RotationData16_g262989 = temp_output_1615_33_g262979;
					float4 In_Interpolator16_g262989 = Out_Interpolator15_g262988;
					BuildVertexData( Data16_g262989 , In_Dummy16_g262989 , In_PositionOS16_g262989 , In_NormalOS16_g262989 , In_TangentOS16_g262989 , In_TransformData16_g262989 , In_RotationData16_g262989 , In_Interpolator16_g262989 );
					TVEVertexData Data15_g262999 =(TVEVertexData)Data16_g262989;
					float Out_Dummy15_g262999 = 0.0;
					float3 Out_PositionOS15_g262999 = float3( 0,0,0 );
					float3 Out_NormalOS15_g262999 = float3( 0,0,0 );
					float4 Out_TangentOS15_g262999 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g262999 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g262999 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g262999 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g262999 , Out_Dummy15_g262999 , Out_PositionOS15_g262999 , Out_NormalOS15_g262999 , Out_TangentOS15_g262999 , Out_TransformData15_g262999 , Out_RotationData15_g262999 , Out_Interpolator15_g262999 );
					TVEVertexData Data16_g263000 =(TVEVertexData)Data15_g262999;
					half Dummy1823_g262990 = ( _FlattenCategory + _FlattenEnd + _FlattenBakeMode );
					float In_Dummy16_g263000 = Dummy1823_g262990;
					float3 In_PositionOS16_g263000 = Out_PositionOS15_g262999;
					half3 Vertex_NormalOS1829_g262990 = Out_NormalOS15_g262999;
					#ifdef TVE_COORD_ZUP
					float3 staticSwitch65_g262991 = half3( 0, 0, 1 );
					#else
					float3 staticSwitch65_g262991 = half3( 0, 1, 0 );
					#endif
					float3 lerpResult1820_g262990 = lerp( Vertex_NormalOS1829_g262990 , staticSwitch65_g262991 , _FlattenUpwardsValue);
					TVEModelData Data15_g263001 =(TVEModelData)Data15_g262911;
					float Out_Dummy15_g263001 = 0.0;
					float3 Out_PositionOS15_g263001 = float3( 0,0,0 );
					float3 Out_PositionWS15_g263001 = float3( 0,0,0 );
					float3 Out_PositionWO15_g263001 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g263001 = float3( 0,0,0 );
					float3 Out_PivotOS15_g263001 = float3( 0,0,0 );
					float3 Out_PivotWS15_g263001 = float3( 0,0,0 );
					float3 Out_PivotWO15_g263001 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263001 = float3( 0,0,0 );
					float3 Out_NormalWS15_g263001 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g263001 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263001 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g263001 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g263001 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g263001 = float3( 0,0,0 );
					float4 Out_CoordsData15_g263001 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g263001 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g263001 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g263001 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263001 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263001 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263001 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g263001 , Out_Dummy15_g263001 , Out_PositionOS15_g263001 , Out_PositionWS15_g263001 , Out_PositionWO15_g263001 , Out_PositionRawOS15_g263001 , Out_PivotOS15_g263001 , Out_PivotWS15_g263001 , Out_PivotWO15_g263001 , Out_NormalOS15_g263001 , Out_NormalWS15_g263001 , Out_NormalRawOS15_g263001 , Out_TangentOS15_g263001 , Out_TangentWS15_g263001 , Out_BitangentWS15_g263001 , Out_ViewDirWS15_g263001 , Out_CoordsData15_g263001 , Out_VertexData15_g263001 , Out_MasksData15_g263001 , Out_PhaseData15_g263001 , Out_TransformData15_g263001 , Out_RotationData15_g263001 , Out_Interpolator15_g263001 );
					float3 Model_PositionOS1837_g262990 = Out_PositionOS15_g263001;
					float3 normalizeResult1816_g262990 = ASESafeNormalize( ( Model_PositionOS1837_g262990 + _FlattenSphereOffsetValue ) );
					float3 lerpResult1813_g262990 = lerp( lerpResult1820_g262990 , normalizeResult1816_g262990 , _FlattenSphereValue);
					float temp_output_17_0_g262998 = _FlattenMeshMode;
					float Option70_g262998 = temp_output_17_0_g262998;
					half4 Model_VertexData1826_g262990 = Out_VertexData15_g263001;
					float4 temp_output_3_0_g262998 = Model_VertexData1826_g262990;
					float4 Channel70_g262998 = temp_output_3_0_g262998;
					float localSwitchChannel470_g262998 = SwitchChannel4( Option70_g262998 , Channel70_g262998 );
					float clampResult17_g262992 = clamp( localSwitchChannel470_g262998 , 0.0001 , 0.9999 );
					float temp_output_7_0_g262993 = _FlattenMeshRemap.x;
					float temp_output_9_0_g262993 = ( clampResult17_g262992 - temp_output_7_0_g262993 );
					float lerpResult1841_g262990 = lerp( 1.0 , saturate( ( temp_output_9_0_g262993 * _FlattenMeshRemap.z ) ) , _FlattenMeshValue);
					half Normal_MeskMask1847_g262990 = lerpResult1841_g262990;
					half Normal_Mask1851_g262990 = Normal_MeskMask1847_g262990;
					float3 lerpResult1856_g262990 = lerp( Vertex_NormalOS1829_g262990 , lerpResult1813_g262990 , ( Normal_Mask1851_g262990 * _FlattenIntensityValue ));
					#ifdef TVE_FLATTEN
					float3 staticSwitch1857_g262990 = lerpResult1856_g262990;
					#else
					float3 staticSwitch1857_g262990 = Vertex_NormalOS1829_g262990;
					#endif
					half3 Final_NormalOS1853_g262990 = staticSwitch1857_g262990;
					float3 In_NormalOS16_g263000 = Final_NormalOS1853_g262990;
					float4 In_TangentOS16_g263000 = Out_TangentOS15_g262999;
					float4 In_TransformData16_g263000 = Out_TransformData15_g262999;
					float4 In_RotationData16_g263000 = Out_RotationData15_g262999;
					float4 In_Interpolator16_g263000 = Out_Interpolator15_g262999;
					BuildVertexData( Data16_g263000 , In_Dummy16_g263000 , In_PositionOS16_g263000 , In_NormalOS16_g263000 , In_TangentOS16_g263000 , In_TransformData16_g263000 , In_RotationData16_g263000 , In_Interpolator16_g263000 );
					TVEVertexData Data15_g263010 =(TVEVertexData)Data16_g263000;
					float Out_Dummy15_g263010 = 0.0;
					float3 Out_PositionOS15_g263010 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263010 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263010 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263010 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263010 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263010 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g263010 , Out_Dummy15_g263010 , Out_PositionOS15_g263010 , Out_NormalOS15_g263010 , Out_TangentOS15_g263010 , Out_TransformData15_g263010 , Out_RotationData15_g263010 , Out_Interpolator15_g263010 );
					TVEVertexData Data16_g263011 =(TVEVertexData)Data15_g263010;
					half Dummy1575_g263002 = ( _ReshadeCategory + _ReshadeEnd + _ReshadeInfo );
					float In_Dummy16_g263011 = Dummy1575_g263002;
					float3 In_PositionOS16_g263011 = Out_PositionOS15_g263010;
					half3 Vertex_NormalOS1568_g263002 = Out_NormalOS15_g263010;
					half3 VertexPos40_g263004 = Vertex_NormalOS1568_g263002;
					half3 VertexPos40_g263005 = VertexPos40_g263004;
					float4 temp_output_1818_33_g263002 = Out_RotationData15_g263010;
					half4 Vertex_RotationData1583_g263002 = temp_output_1818_33_g263002;
					half2 Angle44_g263004 = Vertex_RotationData1583_g263002.xy;
					half Angle44_g263005 = (Angle44_g263004).y;
					half CosAngle89_g263005 = cos( Angle44_g263005 );
					half SinAngle93_g263005 = sin( Angle44_g263005 );
					float3 appendResult95_g263005 = (float3((VertexPos40_g263005).x , ( ( (VertexPos40_g263005).y * CosAngle89_g263005 ) - ( (VertexPos40_g263005).z * SinAngle93_g263005 ) ) , ( ( (VertexPos40_g263005).y * SinAngle93_g263005 ) + ( (VertexPos40_g263005).z * CosAngle89_g263005 ) )));
					half3 VertexPos40_g263006 = appendResult95_g263005;
					half Angle44_g263006 = -(Angle44_g263004).x;
					half CosAngle94_g263006 = cos( Angle44_g263006 );
					half SinAngle95_g263006 = sin( Angle44_g263006 );
					float3 appendResult98_g263006 = (float3(( ( (VertexPos40_g263006).x * CosAngle94_g263006 ) - ( (VertexPos40_g263006).y * SinAngle95_g263006 ) ) , ( ( (VertexPos40_g263006).x * SinAngle95_g263006 ) + ( (VertexPos40_g263006).y * CosAngle94_g263006 ) ) , (VertexPos40_g263006).z));
					float3 lerpResult1591_g263002 = lerp( Vertex_NormalOS1568_g263002 , appendResult98_g263006 , _ReshadeIntensityValue);
					#ifdef TVE_ROTATION_BEND
					float3 staticSwitch65_g263003 = lerpResult1591_g263002;
					#else
					float3 staticSwitch65_g263003 = Vertex_NormalOS1568_g263002;
					#endif
					float3 temp_output_1732_0_g263002 = staticSwitch65_g263003;
					#ifdef TVE_RESHADE
					float3 staticSwitch1716_g263002 = temp_output_1732_0_g263002;
					#else
					float3 staticSwitch1716_g263002 = Vertex_NormalOS1568_g263002;
					#endif
					half3 Final_NormalOS178_g263002 = staticSwitch1716_g263002;
					float3 In_NormalOS16_g263011 = Final_NormalOS178_g263002;
					float4 In_TangentOS16_g263011 = Out_TangentOS15_g263010;
					float4 In_TransformData16_g263011 = Out_TransformData15_g263010;
					float4 In_RotationData16_g263011 = temp_output_1818_33_g263002;
					float4 In_Interpolator16_g263011 = Out_Interpolator15_g263010;
					BuildVertexData( Data16_g263011 , In_Dummy16_g263011 , In_PositionOS16_g263011 , In_NormalOS16_g263011 , In_TangentOS16_g263011 , In_TransformData16_g263011 , In_RotationData16_g263011 , In_Interpolator16_g263011 );
					TVEVertexData Data15_g263133 =(TVEVertexData)Data16_g263011;
					float Out_Dummy15_g263133 = 0.0;
					float3 Out_PositionOS15_g263133 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263133 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263133 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263133 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263133 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263133 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g263133 , Out_Dummy15_g263133 , Out_PositionOS15_g263133 , Out_NormalOS15_g263133 , Out_TangentOS15_g263133 , Out_TransformData15_g263133 , Out_RotationData15_g263133 , Out_Interpolator15_g263133 );
					TVEVertexData Data16_g263134 =(TVEVertexData)Data15_g263133;
					half Dummy1575_g263126 = ( _TransferCategory + _TransferEnd + _TransferInfo + _TransferSpace );
					float In_Dummy16_g263134 = Dummy1575_g263126;
					float3 In_PositionOS16_g263134 = Out_PositionOS15_g263133;
					half3 Vertex_NormalOS1568_g263126 = Out_NormalOS15_g263133;
					TVEGlobalData Data15_g263132 =(TVEGlobalData)Data15_g262925;
					float Out_Dummy15_g263132 = 0.0;
					float4 Out_CoatTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_DrawTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_PaintTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_AtmoTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_EffexTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_GlowTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_FormTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_LandTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_VertxTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_FlowTexture15_g263132 = float4( 0,0,0,0 );
					float4 Out_UserTexture15_g263132 = float4( 0,0,0,0 );
					BreakData( Data15_g263132 , Out_Dummy15_g263132 , Out_CoatTexture15_g263132 , Out_DrawTexture15_g263132 , Out_PaintTexture15_g263132 , Out_AtmoTexture15_g263132 , Out_EffexTexture15_g263132 , Out_GlowTexture15_g263132 , Out_FormTexture15_g263132 , Out_LandTexture15_g263132 , Out_VertxTexture15_g263132 , Out_FlowTexture15_g263132 , Out_UserTexture15_g263132 );
					half4 Global_FormTexture1633_g263126 = Out_FormTexture15_g263132;
					float2 temp_output_1627_0_g263126 = ((Global_FormTexture1633_g263126).xy*2.0 + -1.0);
					float2 break1617_g263126 = temp_output_1627_0_g263126;
					float dotResult1619_g263126 = dot( temp_output_1627_0_g263126 , temp_output_1627_0_g263126 );
					float3 appendResult1618_g263126 = (float3(break1617_g263126.x , sqrt( ( 1.0 - saturate( dotResult1619_g263126 ) ) ) , break1617_g263126.y));
					float3 worldToObjDir1623_g263126 = mul( unity_WorldToObject, float4( appendResult1618_g263126, 0.0 ) ).xyz;
					half3 Surface_Normal1630_g263126 = worldToObjDir1623_g263126;
					float temp_output_17_0_g263137 = _TransferMeshMode;
					float Option70_g263137 = temp_output_17_0_g263137;
					TVEModelData Data15_g263127 =(TVEModelData)Data15_g263001;
					float Out_Dummy15_g263127 = 0.0;
					float3 Out_PositionOS15_g263127 = float3( 0,0,0 );
					float3 Out_PositionWS15_g263127 = float3( 0,0,0 );
					float3 Out_PositionWO15_g263127 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g263127 = float3( 0,0,0 );
					float3 Out_PivotOS15_g263127 = float3( 0,0,0 );
					float3 Out_PivotWS15_g263127 = float3( 0,0,0 );
					float3 Out_PivotWO15_g263127 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263127 = float3( 0,0,0 );
					float3 Out_NormalWS15_g263127 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g263127 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263127 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g263127 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g263127 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g263127 = float3( 0,0,0 );
					float4 Out_CoordsData15_g263127 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g263127 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g263127 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g263127 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263127 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263127 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263127 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g263127 , Out_Dummy15_g263127 , Out_PositionOS15_g263127 , Out_PositionWS15_g263127 , Out_PositionWO15_g263127 , Out_PositionRawOS15_g263127 , Out_PivotOS15_g263127 , Out_PivotWS15_g263127 , Out_PivotWO15_g263127 , Out_NormalOS15_g263127 , Out_NormalWS15_g263127 , Out_NormalRawOS15_g263127 , Out_TangentOS15_g263127 , Out_TangentWS15_g263127 , Out_BitangentWS15_g263127 , Out_ViewDirWS15_g263127 , Out_CoordsData15_g263127 , Out_VertexData15_g263127 , Out_MasksData15_g263127 , Out_PhaseData15_g263127 , Out_TransformData15_g263127 , Out_RotationData15_g263127 , Out_Interpolator15_g263127 );
					float4 temp_output_1567_29_g263126 = Out_VertexData15_g263127;
					half4 Model_VertexData1608_g263126 = temp_output_1567_29_g263126;
					float4 temp_output_3_0_g263137 = Model_VertexData1608_g263126;
					float4 Channel70_g263137 = temp_output_3_0_g263137;
					float localSwitchChannel470_g263137 = SwitchChannel4( Option70_g263137 , Channel70_g263137 );
					float temp_output_1870_0_g263126 = localSwitchChannel470_g263137;
					float temp_output_7_0_g263136 = _TransferMeshRemap.x;
					float temp_output_9_0_g263136 = ( temp_output_1870_0_g263126 - temp_output_7_0_g263136 );
					float lerpResult1868_g263126 = lerp( 1.0 , saturate( ( temp_output_9_0_g263136 * _TransferMeshRemap.z ) ) , _TransferMeshValue);
					half Blend_MeshMask1876_g263126 = lerpResult1868_g263126;
					half Blend_Mask1742_g263126 = ( _TransferIntensityValue * Blend_MeshMask1876_g263126 * TVE_IsEnabled );
					float3 lerpResult1670_g263126 = lerp( Vertex_NormalOS1568_g263126 , Surface_Normal1630_g263126 , Blend_Mask1742_g263126);
					#ifdef TVE_TRANSFER
					float3 staticSwitch1716_g263126 = lerpResult1670_g263126;
					#else
					float3 staticSwitch1716_g263126 = Vertex_NormalOS1568_g263126;
					#endif
					half3 Final_NormalOS178_g263126 = staticSwitch1716_g263126;
					float3 In_NormalOS16_g263134 = Final_NormalOS178_g263126;
					half4 Vertex_TangentOS1749_g263126 = Out_TangentOS15_g263133;
					float4 appendResult1746_g263126 = (float4(cross( worldToObjDir1623_g263126 , float3( 0, 0, 1 ) ) , -1.0));
					half4 Surface_Tangent1747_g263126 = appendResult1746_g263126;
					float4 lerpResult1757_g263126 = lerp( Vertex_TangentOS1749_g263126 , Surface_Tangent1747_g263126 , Blend_Mask1742_g263126);
					#ifdef TVE_TRANSFER
					float4 staticSwitch1760_g263126 = lerpResult1757_g263126;
					#else
					float4 staticSwitch1760_g263126 = Vertex_TangentOS1749_g263126;
					#endif
					half4 Final_TangentOS1762_g263126 = staticSwitch1760_g263126;
					float4 In_TangentOS16_g263134 = Final_TangentOS1762_g263126;
					float4 In_TransformData16_g263134 = Out_TransformData15_g263133;
					float4 In_RotationData16_g263134 = Out_RotationData15_g263133;
					float4 In_Interpolator16_g263134 = Out_Interpolator15_g263133;
					BuildVertexData( Data16_g263134 , In_Dummy16_g263134 , In_PositionOS16_g263134 , In_NormalOS16_g263134 , In_TangentOS16_g263134 , In_TransformData16_g263134 , In_RotationData16_g263134 , In_Interpolator16_g263134 );
					TVEVertexData Data15_g263142 =(TVEVertexData)Data16_g263134;
					float Out_Dummy15_g263142 = 0.0;
					float3 Out_PositionOS15_g263142 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263142 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263142 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263142 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263142 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263142 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g263142 , Out_Dummy15_g263142 , Out_PositionOS15_g263142 , Out_NormalOS15_g263142 , Out_TangentOS15_g263142 , Out_TransformData15_g263142 , Out_RotationData15_g263142 , Out_Interpolator15_g263142 );
					TVEVertexData Data16_g263143 =(TVEVertexData)Data15_g263142;
					float In_Dummy16_g263143 = 0.0;
					TVEModelData Data16_g263128 =(TVEModelData)Data15_g263127;
					float temp_output_14_0_g263128 = 0.0;
					float In_Dummy16_g263128 = temp_output_14_0_g263128;
					float3 temp_output_4_0_g263128 = Out_PositionOS15_g263127;
					float3 In_PositionOS16_g263128 = temp_output_4_0_g263128;
					float3 In_PositionWS16_g263128 = Out_PositionWS15_g263127;
					float3 temp_output_1567_17_g263126 = Out_PositionWO15_g263127;
					float3 In_PositionWO16_g263128 = temp_output_1567_17_g263126;
					float3 In_PivotOS16_g263128 = Out_PivotOS15_g263127;
					float3 In_PivotWS16_g263128 = Out_PivotWS15_g263127;
					float3 In_PivotWO16_g263128 = Out_PivotWO15_g263127;
					float3 temp_output_21_0_g263128 = Out_NormalOS15_g263127;
					float3 In_NormalOS16_g263128 = temp_output_21_0_g263128;
					float3 temp_output_1567_21_g263126 = Out_NormalWS15_g263127;
					float3 In_NormalWS16_g263128 = temp_output_1567_21_g263126;
					float4 temp_output_6_0_g263128 = Out_TangentOS15_g263127;
					float4 In_TangentOS16_g263128 = temp_output_6_0_g263128;
					float3 In_ViewDirWS16_g263128 = Out_ViewDirWS15_g263127;
					float4 In_CoordsData16_g263128 = Out_CoordsData15_g263127;
					float4 In_VertexData16_g263128 = temp_output_1567_29_g263126;
					float4 In_MasksData16_g263128 = Out_MasksData15_g263127;
					float4 In_PhaseData16_g263128 = Out_PhaseData15_g263127;
					BuildModelVertData( Data16_g263128 , In_Dummy16_g263128 , In_PositionOS16_g263128 , In_PositionWS16_g263128 , In_PositionWO16_g263128 , In_PivotOS16_g263128 , In_PivotWS16_g263128 , In_PivotWO16_g263128 , In_NormalOS16_g263128 , In_NormalWS16_g263128 , In_TangentOS16_g263128 , In_ViewDirWS16_g263128 , In_CoordsData16_g263128 , In_VertexData16_g263128 , In_MasksData16_g263128 , In_PhaseData16_g263128 );
					TVEModelData Data15_g263141 =(TVEModelData)Data16_g263128;
					float Out_Dummy15_g263141 = 0.0;
					float3 Out_PositionOS15_g263141 = float3( 0,0,0 );
					float3 Out_PositionWS15_g263141 = float3( 0,0,0 );
					float3 Out_PositionWO15_g263141 = float3( 0,0,0 );
					float3 Out_PositionRawOS15_g263141 = float3( 0,0,0 );
					float3 Out_PivotOS15_g263141 = float3( 0,0,0 );
					float3 Out_PivotWS15_g263141 = float3( 0,0,0 );
					float3 Out_PivotWO15_g263141 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263141 = float3( 0,0,0 );
					float3 Out_NormalWS15_g263141 = float3( 0,0,0 );
					float3 Out_NormalRawOS15_g263141 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263141 = float4( 0,0,0,0 );
					float3 Out_TangentWS15_g263141 = float3( 0,0,0 );
					float3 Out_BitangentWS15_g263141 = float3( 0,0,0 );
					float3 Out_ViewDirWS15_g263141 = float3( 0,0,0 );
					float4 Out_CoordsData15_g263141 = float4( 0,0,0,0 );
					float4 Out_VertexData15_g263141 = float4( 0,0,0,0 );
					float4 Out_MasksData15_g263141 = float4( 0,0,0,0 );
					float4 Out_PhaseData15_g263141 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263141 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263141 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263141 = float4( 0,0,0,0 );
					BreakModelVertData( Data15_g263141 , Out_Dummy15_g263141 , Out_PositionOS15_g263141 , Out_PositionWS15_g263141 , Out_PositionWO15_g263141 , Out_PositionRawOS15_g263141 , Out_PivotOS15_g263141 , Out_PivotWS15_g263141 , Out_PivotWO15_g263141 , Out_NormalOS15_g263141 , Out_NormalWS15_g263141 , Out_NormalRawOS15_g263141 , Out_TangentOS15_g263141 , Out_TangentWS15_g263141 , Out_BitangentWS15_g263141 , Out_ViewDirWS15_g263141 , Out_CoordsData15_g263141 , Out_VertexData15_g263141 , Out_MasksData15_g263141 , Out_PhaseData15_g263141 , Out_TransformData15_g263141 , Out_RotationData15_g263141 , Out_Interpolator15_g263141 );
					float3 In_PositionOS16_g263143 = ( Out_PositionOS15_g263142 + Out_PivotOS15_g263141 );
					float3 In_NormalOS16_g263143 = Out_NormalOS15_g263142;
					float4 In_TangentOS16_g263143 = Out_TangentOS15_g263142;
					float4 In_TransformData16_g263143 = Out_TransformData15_g263142;
					float4 In_RotationData16_g263143 = Out_RotationData15_g263142;
					float4 In_Interpolator16_g263143 = Out_Interpolator15_g263142;
					BuildVertexData( Data16_g263143 , In_Dummy16_g263143 , In_PositionOS16_g263143 , In_NormalOS16_g263143 , In_TangentOS16_g263143 , In_TransformData16_g263143 , In_RotationData16_g263143 , In_Interpolator16_g263143 );
					TVEVertexData Data15_g263231 =(TVEVertexData)Data16_g263143;
					float Out_Dummy15_g263231 = 0.0;
					float3 Out_PositionOS15_g263231 = float3( 0,0,0 );
					float3 Out_NormalOS15_g263231 = float3( 0,0,0 );
					float4 Out_TangentOS15_g263231 = float4( 0,0,0,0 );
					float4 Out_TransformData15_g263231 = float4( 0,0,0,0 );
					float4 Out_RotationData15_g263231 = float4( 0,0,0,0 );
					float4 Out_Interpolator15_g263231 = float4( 0,0,0,0 );
					BreakVertexData( Data15_g263231 , Out_Dummy15_g263231 , Out_PositionOS15_g263231 , Out_NormalOS15_g263231 , Out_TangentOS15_g263231 , Out_TransformData15_g263231 , Out_RotationData15_g263231 , Out_Interpolator15_g263231 );
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = Out_PositionOS15_g263231;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = Out_NormalOS15_g263231;
					v.tangent = Out_TangentOS15_g263231;

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
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2722,"pos":[-7296,-4736],"params":["Inherit","False","If Model Data","-1","","262420","d269c9c511ff160419055604aade1e70","1,32,1","9","3","OBJECT","0","False","17","OBJECT","0","False","19","FLOAT","0","False","33","OBJECT","0","False","27","OBJECT","0","False","28","OBJECT","0","False","29","OBJECT","0","False","30","OBJECT","0","False","31","FLOAT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2373,"pos":[-6976,-4736],"params":["Half","False","Model Frag","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2374,"pos":[-6528,-4992],"params":["Inherit","False","2373","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2375,"pos":[-6272,-4992],"params":["Inherit","False","Block Global","30","","262442","212e17d4006dc88449d56ce0340cb5ff","46,385,1,692,1,667,1,276,1,396,1,417,1,282,1,402,1,560,1,285,1,283,1,308,1,650,1,483,0,484,0,486,0,488,0,561,0,487,0,652,0,482,0,485,0,668,0,691,0,315,1,703,1,719,1,716,1,715,1,709,1,710,1,706,1,701,1,704,1,707,1,655,0,311,1,317,1,421,1,321,1,398,1,700,0,694,1,713,1,404,1,675,0","1","206","OBJECT","0,0,0,0","False","1","OBJECT","151"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2505,"pos":[-5952,-4992],"params":["Half","False","Global Data","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2791,"pos":[-5504,-4992],"params":["Inherit","False","2377","Model Vert","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2792,"pos":[-5504,-4928],"params":["Inherit","False","2505","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2790,"pos":[-5248,-4992],"params":["Inherit","False","Block Vertex","-1","","262848","79888a886ac7456468e9ffe3eda11f4f","0","2","1894","OBJECT","0,0,0,0","False","1896","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","1895","OBJECT","1897"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2650,"pos":[-4864,-4992],"params":["Inherit","False","Block Pivots Sub","-1","","262851","186f08b1bbe15894d9c677d50398679b","0","3","224","OBJECT","0,0,0,0","False","146","OBJECT","0,0,0,0","False","231","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","229","OBJECT","232"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2652,"pos":[-4480,-4992],"params":["Inherit","False","Block Perspective","204","","262855","df5d9c54e8e4098459ebd6b9eabbd8ca","1,243,0","3","146","OBJECT","0,0,0,0","False","245","OBJECT","0,0,0,0","False","250","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","248","OBJECT","249"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2654,"pos":[-4096,-4992],"params":["Inherit","False","Block Blanket Conform","185","","262861","3ce1684c4351aeb42b79a955aa483301","2,389,0,377,1","3","146","OBJECT","0,0,0,0","False","397","OBJECT","0,0,0,0","False","186","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","398","OBJECT","399"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2656,"pos":[-3712,-4992],"params":["Inherit","False","Block Blanket Rotation","199","","262872","397a14f11ff1a0449b911fedfcdf94e8","1,290,0","3","146","OBJECT","0,0,0,0","False","293","OBJECT","0,0,0,0","False","186","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","294","OBJECT","295"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2658,"pos":[-3328,-4992],"params":["Inherit","False","Block Size Fade","210","","262880","467c36a7402d0274b9ad844bbc95de33","6,242,0,228,1,225,1,246,0,249,0,233,0","5","146","OBJECT","0,0,0,0","False","260","OBJECT","0,0,0,0","False","186","OBJECT","0,0,0,0","False","263","OBJECT","0,0,0,0","False","231","FLOAT","1","False","3","OBJECT","128","OBJECT","261","OBJECT","262"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2659,"pos":[-2944,-4992],"params":["Inherit","False","Block Motion","109","","262899","d9ac7ad4f0387004fb72c16019bf8392","6,2748,1,2751,1,2753,1,2749,1,3080,1,3079,0","3","146","OBJECT","0,0,0,0","False","3327","OBJECT","0,0,0,0","False","212","OBJECT","0,0,0,0","False","4","OBJECT","128","OBJECT","3328","OBJECT","3329","OBJECT","2951"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2660,"pos":[-2560,-4992],"params":["Inherit","False","Block Transform","-1","","262979","5ac6202bdddd8b34a85c261af6b8de8b","0","3","146","OBJECT","0,0,0,0","False","1620","OBJECT","0,0,0,0","False","1619","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","1617","OBJECT","1618"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2661,"pos":[-2176,-4992],"params":["Inherit","False","Block Flatten","225","","262990","87f7defafe56dbf4b954caf5efc3f5ca","3,1825,1,1872,0,1843,1","3","146","OBJECT","0,0,0,0","False","1885","OBJECT","0,0,0,0","False","1886","OBJECT","0,0,0,0","False","4","OBJECT","128","OBJECT","1888","OBJECT","1887","OBJECT","1785"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":2631,"pos":[-7680,-5376],"params":["Inherit","False","Property","_IsShaderType","_IsShaderType","29","0","Create","True","0","0","0","False","0","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2663,"pos":[-1792,-4992],"params":["Inherit","False","Block Reshade","237","","263002","dee2b99295f29df4eac008b19b98e555","1,1812,0","3","146","OBJECT","0,0,0,0","False","1820","OBJECT","0,0,0,0","False","1821","OBJECT","0,0,0,0","False","4","OBJECT","128","OBJECT","1823","OBJECT","1822","OBJECT","1785"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2637,"pos":[-7488,-5376],"params":["Half","False","IsShaderType","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2632,"pos":[-7680,-4864],"params":["Inherit","False","Block Model","16","","263012","7ad7765e793a6714babedee0033c36e9","19,463,0,289,0,240,0,437,0,291,0,431,0,404,0,290,0,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0","11","102","FLOAT3","0,0,0","False","163","FLOAT3","0,0,0","False","186","FLOAT3","0,0,0","False","187","FLOAT3","0,0,0","False","166","FLOAT3","0,0,0","False","164","FLOAT3","0,0,0","False","301","FLOAT3","0,0,0","False","418","FLOAT3","0,0,0","False","167","FLOAT4","0,0,0,0","False","172","FLOAT4","0,0,0,0","False","175","FLOAT4","0,0,0,0","False","2","OBJECT","128","OBJECT","314"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2634,"pos":[-7680,-4992],"params":["Inherit","False","Block Model","16","","263032","7ad7765e793a6714babedee0033c36e9","19,463,1,289,1,240,1,437,1,291,1,431,1,404,1,290,1,181,0,183,0,185,0,184,0,188,0,190,0,192,0,189,0,300,0,419,0,193,0","11","102","FLOAT3","0,0,0","False","163","FLOAT3","0,0,0","False","186","FLOAT3","0,0,0","False","187","FLOAT3","0,0,0","False","166","FLOAT3","0,0,0","False","164","FLOAT3","0,0,0","False","301","FLOAT3","0,0,0","False","418","FLOAT3","0,0,0","False","167","FLOAT4","0,0,0,0","False","172","FLOAT4","0,0,0,0","False","175","FLOAT4","0,0,0,0","False","2","OBJECT","128","OBJECT","314"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2633,"pos":[-7680,-4608],"params":["Inherit","False","2637","IsShaderType","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2793,"pos":[-1408,-4992],"params":["Inherit","False","Block Transfer","7","","263126","763e552cdbe87d34bb26108bbb845dcd","3,1843,0,1844,0,1875,1","3","1861","OBJECT","0,0,0,0","False","146","OBJECT","0,0,0,0","False","1631","OBJECT","0,0,0,0","False","4","OBJECT","1863","OBJECT","128","OBJECT","1864","OBJECT","1785"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2665,"pos":[-1024,-4992],"params":["Inherit","False","Block Pivots Add","-1","","263140","016babe9e3e643242aa4d123a988150c","0","3","146","OBJECT","0,0,0,0","False","225","OBJECT","0,0,0,0","False","227","OBJECT","0,0,0,0","False","3","OBJECT","128","OBJECT","226","OBJECT","228"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2723,"pos":[-7296,-4992],"params":["Inherit","False","If Model Data","-1","","263144","d269c9c511ff160419055604aade1e70","1,32,1","9","3","OBJECT","0","False","17","OBJECT","0","False","19","FLOAT","0","False","33","OBJECT","0","False","27","OBJECT","0","False","28","OBJECT","0","False","29","OBJECT","0","False","30","OBJECT","0","False","31","FLOAT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2377,"pos":[-6976,-4992],"params":["Half","False","Model Vert","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2666,"pos":[-704,-4992],"params":["Half","False","Vertex Data","-1","True","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor","id":2705,"pos":[1536,-2816],"params":["Inherit","False","1","2","0","5","FLOAT2","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2789,"pos":[1152,-4992],"params":["Inherit","False","2666","Vertex Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2670,"pos":[1152,-4736],"params":["Inherit","False","2377","Model Vert","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor","id":2740,"pos":[1536,-2432],"params":["Inherit","False","0","4","0","5","FLOAT4","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor","id":2745,"pos":[1536,-1792],"params":["Inherit","False","1","4","0","5","FLOAT4","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor","id":2766,"pos":[1536,-1152],"params":["Inherit","False","2","4","0","5","FLOAT4","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor","id":2777,"pos":[1536,-512],"params":["Inherit","False","3","4","0","5","FLOAT4","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.NormalVertexDataNode, AmplifyShaderEditor","id":2676,"pos":[1792,-4864],"params":["Inherit","False","0","5","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.TangentVertexDataNode, AmplifyShaderEditor","id":2678,"pos":[1792,-4736],"params":["Inherit","False","0","0","5","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.PosVertexDataNode, AmplifyShaderEditor","id":2675,"pos":[1792,-4992],"params":["Inherit","False","0","0","5","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2709,"pos":[1792,-2688],"params":["Inherit","False","FLOAT2","0","1","3","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2699,"pos":[1792,-2944],"params":["Inherit","False","FLOAT2","0","1","3","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2703,"pos":[1792,-2816],"params":["Inherit","False","FLOAT2","0","1","3","3","1","0","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2671,"pos":[1408,-4736],"params":["Inherit","False","Break Model Vert","-1","","263145","857ca65fcb9040b469951916ec700215","0","1","6","OBJECT","0","False","23","OBJECT","40","FLOAT","14","FLOAT3","0","FLOAT3","16","FLOAT3","17","FLOAT3","26","FLOAT3","24","FLOAT3","18","FLOAT3","19","FLOAT3","20","FLOAT3","21","FLOAT3","32","FLOAT4","25","FLOAT3","36","FLOAT3","39","FLOAT3","35","FLOAT4","38","FLOAT4","29","FLOAT4","30","FLOAT4","27","FLOAT4","31","FLOAT4","33","FLOAT4","37"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2724,"pos":[1792,-2432],"params":["Inherit","False","FLOAT3","0","0","0","3","1","0","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2727,"pos":[1792,-2304],"params":["Inherit","False","FLOAT3","1","1","1","3","1","0","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2741,"pos":[1792,-2176],"params":["Inherit","False","FLOAT3","1","1","1","3","1","0","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2742,"pos":[1792,-2048],"params":["Inherit","False","FLOAT3","1","1","1","3","1","0","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2748,"pos":[1792,-1792],"params":["Inherit","False","FLOAT3","0","0","0","3","1","0","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2749,"pos":[1792,-1664],"params":["Inherit","False","FLOAT3","1","1","1","3","1","0","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2750,"pos":[1792,-1536],"params":["Inherit","False","FLOAT3","1","1","1","3","1","0","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2751,"pos":[1792,-1408],"params":["Inherit","False","FLOAT3","1","1","1","3","1","0","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2762,"pos":[1792,-1152],"params":["Inherit","False","FLOAT3","0","0","0","3","1","0","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2763,"pos":[1792,-1024],"params":["Inherit","False","FLOAT3","1","1","1","3","1","0","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2764,"pos":[1792,-896],"params":["Inherit","False","FLOAT3","1","1","1","3","1","0","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2765,"pos":[1792,-768],"params":["Inherit","False","FLOAT3","1","1","1","3","1","0","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2772,"pos":[1792,-512],"params":["Inherit","False","FLOAT3","0","0","0","3","1","0","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2773,"pos":[1792,-384],"params":["Inherit","False","FLOAT3","1","1","1","3","1","0","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2774,"pos":[1792,-256],"params":["Inherit","False","FLOAT3","1","1","1","3","1","0","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2775,"pos":[1792,-128],"params":["Inherit","False","FLOAT3","1","1","1","3","1","0","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2788,"pos":[1408,-4992],"params":["Inherit","False","Break Vertex Data","-1","","263146","a5c067fa4ff90aa4db6f78782153fb5f","0","1","6","OBJECT","0","False","8","OBJECT","40","FLOAT","14","FLOAT3","0","FLOAT3","20","FLOAT4","25","FLOAT4","31","FLOAT4","33","FLOAT4","37"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2689,"pos":[1792,-4160],"params":["Inherit","False","FLOAT3","0","1","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor","id":2672,"pos":[1984,-4992],"params":["Inherit","False","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor","id":2687,"pos":[1792,-4608],"params":["Inherit","False","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor","id":2673,"pos":[1792,-4416],"params":["Inherit","False","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2691,"pos":[1792,-3968],"params":["Inherit","False","FLOAT3","0","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2692,"pos":[1792,-3840],"params":["Inherit","False","FLOAT3","1","1","1","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2694,"pos":[1792,-3712],"params":["Inherit","False","FLOAT3","2","2","2","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2696,"pos":[1792,-3584],"params":["Inherit","False","FLOAT3","3","3","3","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2711,"pos":[1792,-3328],"params":["Inherit","False","FLOAT3","0","0","0","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":2712,"pos":[1792,-3200],"params":["Inherit","False","FLOAT3","1","1","1","3","1","0","FLOAT4","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor","id":2702,"pos":[1984,-2816],"params":["Inherit","False","FLOAT3","4","0","FLOAT2","0,0","False","1","FLOAT","0","False","2","FLOAT","0","False","3","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor","id":2706,"pos":[1984,-2688],"params":["Inherit","False","FLOAT3","4","0","FLOAT2","0,0","False","1","FLOAT","0","False","2","FLOAT","0","False","3","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor","id":2677,"pos":[2208,-4864],"params":["Inherit","False","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor","id":2679,"pos":[2208,-4736],"params":["Inherit","False","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor","id":2684,"pos":[1776,-4288],"params":["Inherit","False","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor","id":2701,"pos":[1984,-2944],"params":["Inherit","False","FLOAT3","4","0","FLOAT2","0,0","False","1","FLOAT","0","False","2","FLOAT","0","False","3","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2726,"pos":[2432,-2432],"params":["Inherit","False","Tool Debug Index","-1","","263147","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","21","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2730,"pos":[2432,-2304],"params":["Inherit","False","Tool Debug Index","-1","","263148","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","22","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2735,"pos":[2432,-2176],"params":["Inherit","False","Tool Debug Index","-1","","263149","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","23","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2736,"pos":[2432,-2048],"params":["Inherit","False","Tool Debug Index","-1","","263150","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","24","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2743,"pos":[2432,-1792],"params":["Inherit","False","Tool Debug Index","-1","","263151","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","26","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2744,"pos":[2432,-1664],"params":["Inherit","False","Tool Debug Index","-1","","263152","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","27","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2746,"pos":[2432,-1536],"params":["Inherit","False","Tool Debug Index","-1","","263153","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","28","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2747,"pos":[2432,-1408],"params":["Inherit","False","Tool Debug Index","-1","","263154","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","29","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2767,"pos":[2432,-1152],"params":["Inherit","False","Tool Debug Index","-1","","263155","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","31","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2768,"pos":[2432,-1024],"params":["Inherit","False","Tool Debug Index","-1","","263156","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","32","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2769,"pos":[2432,-896],"params":["Inherit","False","Tool Debug Index","-1","","263157","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","33","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2770,"pos":[2432,-768],"params":["Inherit","False","Tool Debug Index","-1","","263158","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","34","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2778,"pos":[2432,-512],"params":["Inherit","False","Tool Debug Index","-1","","263159","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","36","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2779,"pos":[2432,-384],"params":["Inherit","False","Tool Debug Index","-1","","263160","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","37","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2780,"pos":[2432,-256],"params":["Inherit","False","Tool Debug Index","-1","","263161","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","38","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2781,"pos":[2432,-128],"params":["Inherit","False","Tool Debug Index","-1","","263162","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","39","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2594,"pos":[2432,-4992],"params":["Inherit","False","Tool Debug Index","-1","","263163","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2674,"pos":[2432,-4864],"params":["Inherit","False","Tool Debug Index","-1","","263164","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","1","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2680,"pos":[2432,-4736],"params":["Inherit","False","Tool Debug Index","-1","","263165","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","2","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2682,"pos":[2432,-4416],"params":["Inherit","False","Tool Debug Index","-1","","263166","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","5","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2685,"pos":[2432,-4160],"params":["Inherit","False","Tool Debug Index","-1","","263167","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","7","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2683,"pos":[2432,-4288],"params":["Inherit","False","Tool Debug Index","-1","","263168","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","6","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2690,"pos":[2432,-3968],"params":["Inherit","False","Tool Debug Index","-1","","263169","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","9","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2693,"pos":[2432,-3840],"params":["Inherit","False","Tool Debug Index","-1","","263170","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","10","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2695,"pos":[2432,-3712],"params":["Inherit","False","Tool Debug Index","-1","","263171","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","11","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2697,"pos":[2432,-3584],"params":["Inherit","False","Tool Debug Index","-1","","263172","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","12","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2713,"pos":[2432,-3328],"params":["Inherit","False","Tool Debug Index","-1","","263173","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","14","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2714,"pos":[2432,-3200],"params":["Inherit","False","Tool Debug Index","-1","","263174","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","15","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2704,"pos":[2432,-2816],"params":["Inherit","False","Tool Debug Index","-1","","263175","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","18","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2708,"pos":[2432,-2688],"params":["Inherit","False","Tool Debug Index","-1","","263176","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","19","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2688,"pos":[2432,-4608],"params":["Inherit","False","Tool Debug Index","-1","","263177","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","3","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2700,"pos":[2432,-2944],"params":["Inherit","False","Tool Debug Index","-1","","263178","db6ad3771e2815f4e84bed76b862e261","0","2","39","FLOAT3","0,0,0","False","36","FLOAT","17","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2761,"pos":[2816,-1792],"params":["Inherit","False","4","4","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","3","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2771,"pos":[2816,-1152],"params":["Inherit","False","4","4","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","3","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2776,"pos":[2816,-512],"params":["Inherit","False","4","4","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","3","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2739,"pos":[2816,-2432],"params":["Inherit","False","4","4","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","3","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2681,"pos":[2816,-4416],"params":["Inherit","False","3","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2698,"pos":[2816,-3968],"params":["Inherit","False","4","4","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","3","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2550,"pos":[2816,-4992],"params":["Inherit","False","4","4","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","3","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2715,"pos":[2816,-3328],"params":["Inherit","False","2","2","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2710,"pos":[2816,-2944],"params":["Inherit","False","3","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2782,"pos":[3488,-1632],"params":["Inherit","False","4","4","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","3","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2794,"pos":[-256,-4864],"params":["Inherit","False","2505","Global Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2795,"pos":[-256,-4928],"params":["Inherit","False","2373","Model Frag","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2797,"pos":[-256,-4992],"params":["Inherit","False","2666","Vertex Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":2716,"pos":[3200,-4992],"params":["Inherit","False","6","6","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","3","FLOAT3","0,0,0","False","4","FLOAT3","0,0,0","False","5","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2796,"pos":[0,-4992],"params":["Inherit","False","Block Visual","-1","","263179","9511980f05dcfdf4d8967cd55c0d1784","1,1910,1","3","1904","OBJECT","0,0,0,0","False","1894","OBJECT","0,0,0,0","False","1896","OBJECT","0,0,0,0","False","3","OBJECT","1900","OBJECT","1895","OBJECT","1897"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2668,"pos":[384,-4992],"params":["Inherit","False","Block Main","159","","263183","b04cfed9a7b4c0841afdb49a38c282c5","13,65,1,136,1,41,1,133,1,40,1,344,0,347,0,342,0,346,0,343,0,345,0,329,1,408,1","3","430","OBJECT","0,0,0,0","False","225","OBJECT","0,0,0,0","False","414","OBJECT","0,0,0,0","False","3","OBJECT","106","OBJECT","417","OBJECT","415"]}
{"type":"AmplifyShaderEditor.VertexToFragmentNode, AmplifyShaderEditor","id":2524,"pos":[3456,-4992],"params":["Inherit","False","False","False","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2669,"pos":[704,-4992],"params":["Half","False","Visual Data","-1","True","1","0","OBJECT","0","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":2399,"pos":[3776,-4992],"params":["Half","False","Final_Debug","-1","True","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2400,"pos":[4480,-4992],"params":["Inherit","False","2399","Final_Debug","1","0","OBJECT","","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2563,"pos":[4480,-4928],"params":["Inherit","False","2669","Visual Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":2555,"pos":[4480,-4864],"params":["Inherit","False","2666","Vertex Data","1","0","OBJECT","","False","1","OBJECT","0"]}
{"type":"AmplifyShaderEditor.ConditionalIfNode, AmplifyShaderEditor","id":1774,"pos":[-880,2944],"params":["Inherit","False","True","5","0","FLOAT","0","False","1","FLOAT","1","False","2","FLOAT","0","False","3","FLOAT","0","False","4","COLOR","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TFHCRemapNode, AmplifyShaderEditor","id":1803,"pos":[-1344,2944],"params":["Inherit","False","5","0","FLOAT","0","False","1","FLOAT","-1","False","2","FLOAT","1","False","3","FLOAT","0.3","False","4","FLOAT","0.7","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":1772,"pos":[-1088,3072],"params":["Float","False","Constant","_Float3","Float 3","31","0","Create","True","0","0","0","False","0","False","Object","-1","","24","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleTimeNode, AmplifyShaderEditor","id":1843,"pos":[-1632,2944],"params":["Inherit","False","1","0","FLOAT","1","False","5","FLOAT","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":1771,"pos":[-1088,2944],"params":["Inherit","False","-1","","1","0","OBJECT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SinOpNode, AmplifyShaderEditor","id":1800,"pos":[-1472,2944],"params":["Inherit","False","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":1804,"pos":[-1792,2944],"params":["Inherit","False","Constant","_Float1","Float 1","0","0","Create","True","0","0","0","False","0","False","Object","-1","","3","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor","id":2717,"pos":[1984,-4864],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT","0.5","False","2","FLOAT","0.5","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor","id":2718,"pos":[1984,-4736],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT","0.5","False","2","FLOAT","0.5","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2203,"pos":[5120,-5120],"params":["Inherit","False","Base Compile","-1","","263222","e67c8238031dbf04ab79a5d4d63d1b4f","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":2720,"pos":[4736,-4992],"params":["Inherit","False","Tool Debug Color","0","","263223","d992d3ed4a7539141ba053d3e0c12277","0","3","80","FLOAT3","0,0,0","False","106","OBJECT","0,0,0","False","107","OBJECT","0,0,0","False","5","FLOAT","114","FLOAT3","0","FLOAT3","113","FLOAT3","148","FLOAT4","149"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2355,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","3","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ForwardAdd","0","2","ForwardAdd","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","4","1","False","","1","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","","False","False","False","True","1","LightMode=ForwardAdd","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2356,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","3","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","Deferred","0","3","Deferred","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=Deferred","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2357,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","3","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","Meta","0","4","Meta","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=Meta","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2358,"pos":[-896,-5376],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","3","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ShadowCaster","0","5","ShadowCaster","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","True","3","False","","False","False","True","1","LightMode=ShadowCaster","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2638,"pos":[3072,-4932],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","3","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","SceneSelectionPass","0","6","SceneSelectionPass","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","False","False","False","True","1","LightMode=SceneSelectionPass","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2353,"pos":[4736,-4992],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","3","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ExtraPrePass","0","0","ExtraPrePass","5","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2354,"pos":[5120,-4992],"params":["Float","False","True","-1","3","","0","3","Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Debug Vertex","28cd5599e02859647ae1798e4fcaef6c","True","ForwardBase","0","1","ForwardBase","15","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","2","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","True","1","1","False","","0","False","","0","1","False","","0","False","","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","LightMode=ForwardBase","False","False","0","","0","0","Standard","40","Category","0","0","Workflow","0","638874882197810641","Surface","0","0","  Blend","0","0","  Dither Shadows","1","0","Two Sided","0","638874603607655403","Deferred Pass","1","0","Normal Space","0","0","Transmission","0","0","  Transmission Shadow","0.5,False,","0","Translucency","0","0","  Translucency Strength","1,False,","0","  Normal Distortion","0.5,False,","0","  Scattering","2,False,","0","  Direct","0.9,False,","0","  Ambient","0.1,False,","0","  Shadow","0.5,False,","0","Cast Shadows","0","638814711411603618","Receive Shadows","0","638814711415148256","Receive Specular","0","638814711419031593","GPU Instancing","1","638874881145939632","LOD CrossFade","0","638814711429956434","Built-in Fog","0","638814711441065168","Ambient Light","0","638814711449050123","Meta Pass","0","638814711456998358","Add Pass","0","638814711466594157","Override Baked GI","0","0","Write Depth","0","0","Extra Pre Pass","0","0","Tessellation","0","0","  Phong","0","0","  Strength","0.5,False,","0","  Type","0","0","  Tess","16,False,","0","  Min","10,False,","0","  Max","25,False,","0","  Edge Length","16,False,","0","  Max Displacement","25,False,","0","Disable Batching","0","638874882298697380","Vertex Position","0","638874601191422915","0","8","False","True","False","True","False","False","True","True","False","","True","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":2639,"pos":[5120,-4992],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","0","3","New Amplify Shader","28cd5599e02859647ae1798e4fcaef6c","True","ScenePickingPass","0","7","ScenePickingPass","1","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","False","False","True","3","RenderType=Opaque=RenderType","Queue=Geometry=Queue=0","DisableBatching=False=DisableBatching","True","5","True","12","all","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","False","","False","False","False","True","1","LightMode=Picking","False","False","0","","0","0","Standard","0","False","0"]}
{"wire":[2722,33,2632,128]}
{"wire":[2722,27,2634,314]}
{"wire":[2722,28,2634,314]}
{"wire":[2722,29,2634,314]}
{"wire":[2722,30,2632,314]}
{"wire":[2722,31,2633,0]}
{"wire":[2373,0,2722,0]}
{"wire":[2375,206,2374,0]}
{"wire":[2505,0,2375,151]}
{"wire":[2790,1894,2791,0]}
{"wire":[2790,1896,2792,0]}
{"wire":[2650,224,2790,128]}
{"wire":[2650,146,2790,1895]}
{"wire":[2650,231,2790,1897]}
{"wire":[2652,146,2650,128]}
{"wire":[2652,245,2650,229]}
{"wire":[2652,250,2650,232]}
{"wire":[2654,146,2652,128]}
{"wire":[2654,397,2652,248]}
{"wire":[2654,186,2652,249]}
{"wire":[2656,146,2654,128]}
{"wire":[2656,293,2654,398]}
{"wire":[2656,186,2654,399]}
{"wire":[2658,146,2656,128]}
{"wire":[2658,260,2656,294]}
{"wire":[2658,186,2656,295]}
{"wire":[2659,146,2658,128]}
{"wire":[2659,3327,2658,261]}
{"wire":[2659,212,2658,262]}
{"wire":[2660,146,2659,128]}
{"wire":[2660,1620,2659,3328]}
{"wire":[2660,1619,2659,3329]}
{"wire":[2661,146,2660,128]}
{"wire":[2661,1885,2660,1617]}
{"wire":[2661,1886,2660,1618]}
{"wire":[2663,146,2661,128]}
{"wire":[2663,1820,2661,1888]}
{"wire":[2663,1821,2661,1887]}
{"wire":[2637,0,2631,0]}
{"wire":[2793,1861,2663,128]}
{"wire":[2793,146,2663,1823]}
{"wire":[2793,1631,2663,1822]}
{"wire":[2665,146,2793,1863]}
{"wire":[2665,225,2793,128]}
{"wire":[2665,227,2793,1864]}
{"wire":[2723,33,2634,128]}
{"wire":[2723,27,2634,128]}
{"wire":[2723,28,2634,128]}
{"wire":[2723,29,2634,128]}
{"wire":[2723,30,2632,128]}
{"wire":[2723,31,2633,0]}
{"wire":[2377,0,2723,0]}
{"wire":[2666,0,2665,128]}
{"wire":[2709,0,2671,38]}
{"wire":[2699,0,2671,38]}
{"wire":[2703,0,2705,0]}
{"wire":[2671,6,2670,0]}
{"wire":[2724,0,2740,1]}
{"wire":[2727,0,2740,2]}
{"wire":[2741,0,2740,3]}
{"wire":[2742,0,2740,4]}
{"wire":[2748,0,2745,1]}
{"wire":[2749,0,2745,2]}
{"wire":[2750,0,2745,3]}
{"wire":[2751,0,2745,4]}
{"wire":[2762,0,2766,1]}
{"wire":[2763,0,2766,2]}
{"wire":[2764,0,2766,3]}
{"wire":[2765,0,2766,4]}
{"wire":[2772,0,2777,1]}
{"wire":[2773,0,2777,2]}
{"wire":[2774,0,2777,3]}
{"wire":[2775,0,2777,4]}
{"wire":[2788,6,2789,0]}
{"wire":[2689,0,2788,25]}
{"wire":[2672,0,2675,0]}
{"wire":[2687,0,2671,24]}
{"wire":[2673,0,2788,0]}
{"wire":[2691,0,2671,29]}
{"wire":[2692,0,2671,29]}
{"wire":[2694,0,2671,29]}
{"wire":[2696,0,2671,29]}
{"wire":[2711,0,2671,30]}
{"wire":[2712,0,2671,30]}
{"wire":[2702,0,2703,0]}
{"wire":[2706,0,2709,0]}
{"wire":[2677,0,2676,0]}
{"wire":[2679,0,2678,0]}
{"wire":[2684,0,2788,20]}
{"wire":[2701,0,2699,0]}
{"wire":[2726,39,2724,0]}
{"wire":[2730,39,2727,0]}
{"wire":[2735,39,2741,0]}
{"wire":[2736,39,2742,0]}
{"wire":[2743,39,2748,0]}
{"wire":[2744,39,2749,0]}
{"wire":[2746,39,2750,0]}
{"wire":[2747,39,2751,0]}
{"wire":[2767,39,2762,0]}
{"wire":[2768,39,2763,0]}
{"wire":[2769,39,2764,0]}
{"wire":[2770,39,2765,0]}
{"wire":[2778,39,2772,0]}
{"wire":[2779,39,2773,0]}
{"wire":[2780,39,2774,0]}
{"wire":[2781,39,2775,0]}
{"wire":[2594,39,2672,0]}
{"wire":[2674,39,2677,0]}
{"wire":[2680,39,2679,0]}
{"wire":[2682,39,2673,0]}
{"wire":[2685,39,2689,0]}
{"wire":[2683,39,2684,0]}
{"wire":[2690,39,2691,0]}
{"wire":[2693,39,2692,0]}
{"wire":[2695,39,2694,0]}
{"wire":[2697,39,2696,0]}
{"wire":[2713,39,2711,0]}
{"wire":[2714,39,2712,0]}
{"wire":[2704,39,2702,0]}
{"wire":[2708,39,2706,0]}
{"wire":[2688,39,2687,0]}
{"wire":[2700,39,2701,0]}
{"wire":[2761,0,2743,0]}
{"wire":[2761,1,2744,0]}
{"wire":[2761,2,2746,0]}
{"wire":[2761,3,2747,0]}
{"wire":[2771,0,2767,0]}
{"wire":[2771,1,2768,0]}
{"wire":[2771,2,2769,0]}
{"wire":[2771,3,2770,0]}
{"wire":[2776,0,2778,0]}
{"wire":[2776,1,2779,0]}
{"wire":[2776,2,2780,0]}
{"wire":[2776,3,2781,0]}
{"wire":[2739,0,2726,0]}
{"wire":[2739,1,2730,0]}
{"wire":[2739,2,2735,0]}
{"wire":[2739,3,2736,0]}
{"wire":[2681,0,2682,0]}
{"wire":[2681,1,2683,0]}
{"wire":[2681,2,2685,0]}
{"wire":[2698,0,2690,0]}
{"wire":[2698,1,2693,0]}
{"wire":[2698,2,2695,0]}
{"wire":[2698,3,2697,0]}
{"wire":[2550,0,2594,0]}
{"wire":[2550,1,2674,0]}
{"wire":[2550,2,2680,0]}
{"wire":[2550,3,2688,0]}
{"wire":[2715,0,2713,0]}
{"wire":[2715,1,2714,0]}
{"wire":[2710,0,2700,0]}
{"wire":[2710,1,2704,0]}
{"wire":[2710,2,2708,0]}
{"wire":[2782,0,2739,0]}
{"wire":[2782,1,2761,0]}
{"wire":[2782,2,2771,0]}
{"wire":[2782,3,2776,0]}
{"wire":[2716,0,2550,0]}
{"wire":[2716,1,2681,0]}
{"wire":[2716,2,2698,0]}
{"wire":[2716,3,2715,0]}
{"wire":[2716,4,2710,0]}
{"wire":[2716,5,2782,0]}
{"wire":[2796,1904,2797,0]}
{"wire":[2796,1894,2795,0]}
{"wire":[2796,1896,2794,0]}
{"wire":[2668,430,2796,1900]}
{"wire":[2668,225,2796,1895]}
{"wire":[2668,414,2796,1897]}
{"wire":[2524,0,2716,0]}
{"wire":[2669,0,2668,106]}
{"wire":[2399,0,2524,0]}
{"wire":[1774,0,1771,0]}
{"wire":[1774,1,1772,0]}
{"wire":[1774,3,1803,0]}
{"wire":[1803,0,1800,0]}
{"wire":[1843,0,1804,0]}
{"wire":[1800,0,1843,0]}
{"wire":[2717,0,2676,0]}
{"wire":[2718,0,2678,0]}
{"wire":[2720,80,2400,0]}
{"wire":[2720,106,2563,0]}
{"wire":[2720,107,2555,0]}
{"wire":[2354,0,2720,114]}
{"wire":[2354,3,2720,114]}
{"wire":[2354,5,2720,114]}
{"wire":[2354,2,2720,0]}
{"wire":[2354,15,2720,113]}
{"wire":[2354,16,2720,148]}
{"wire":[2354,17,2720,149]}
ASEEND*/
//CHKSM=E0DFCF31811036C92CB3CA5F6E6E38005E926B1C