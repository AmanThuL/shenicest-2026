// Upgrade NOTE: upgraded instancing buffer 'HiddenBOXOPHOBICTheVisualEngineElementsMotionWindControl' to new syntax.

// Made with Amplify Shader Editor v1.9.9.4
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Visual Engine/Elements/Motion Wind Control"
{
	Properties
	{
		[StyledBanner(Motion Control Element)] _Banner( "Banner", Float ) = 0
		[StyledMessage(Info, Use the Motion Wind Control elements to change the wind power and direction based on the element forward direction. Element Texture A is used as alpha mask. Particle Color A is used as Element Intensity multiplier. , 0,0)] _Message( "Message", Float ) = 0
		_ElementIntensity( "Render Intensity", Range( 0, 1 ) ) = 1
		[HideInInspector] _ElementParams( "Render Params", Vector ) = ( 1, 1, 1, 1 )
		[Enum(Constant,0,Seasons,1)] _ElementMode( "Render Mode", Float ) = 0
		[Enum(Multiply,0,Additive,1)] _ElementBlendA( "Render Blend", Float ) = 0
		[StyledSpace(10)] _RenderEnd( "[ Render End ]", Float ) = 0
		[StyledCategory(Element Settings, true, 0, 10)] _ElementCategory( "[ Element Category ]", Float ) = 1
		[NoScaleOffset][StyledTextureSingleLine] _MainTex( "Element Texture", 2D ) = "white" {}
		[StyledSpace(10)] _SpaceTexture( "#SpaceTexture", Float ) = 0
		[Enum(Main UV,0,Planar,1)] _ElementUVsMode( "Element Sampling", Float ) = 0
		[StyledVector(9)] _MainUVs( "Element UV Value", Vector ) = ( 1, 1, 0, 0 )
		[StyledRemapSlider] _MainTexColorRemap( "Element Value", Vector ) = ( 0, 1, 0, 0 )
		[StyledRemapSlider] _MainTexAlphaRemap( "Element Alpha", Vector ) = ( 0, 1, 0, 0 )
		[StyledRemapSlider] _MainTexFalloffRemap( "Element Falloff", Vector ) = ( 0, 0, 0, 0 )
		[Space(10)] _MainValue( "Element Value", Range( 0, 1 ) ) = 1
		[Space(10)] _AdditionalValue1( "Winter Value", Range( 0, 1 ) ) = 1
		_AdditionalValue2( "Spring Value", Range( 0, 1 ) ) = 1
		_AdditionalValue3( "Summer Value", Range( 0, 1 ) ) = 1
		_AdditionalValue4( "Autumn Value", Range( 0, 1 ) ) = 1
		[Space(10)][StyledRemapSlider] _SeasonRemap( "Seasons Curve", Vector ) = ( 0, 1, 0, 0 )
		[Space(10)] _SpeedTresholdValue( "Particle Speed Treshold", Float ) = 10
		[StyledSpace(10)] _ElementEnd( "[ Element End ]", Float ) = 0
		[StyledCategory(Masking Settings, true, 0, 10)] _MaskingCategory( "[ Masking Category ]", Float ) = 1
		[StyledMessage(Info, When the Terrain Data object is assigned__ the ProjY and PosY features use the terrain height and normal textures for masking. Make sure to set the Terrain Mask dropdown to Auto., 0, 10)] _MaskingTerrainInfo( "Masking Terrain Info", Float ) = 0
		[StyledMessage(Info, When the Terrain Data object is not assigned__ the ProjY and PosY features use the element mesh world space height and normal for masking., 0, 10)] _MaskingModelInfo( "Masking Model Info", Float ) = 0
		[HideInInspector][StyledTextureSingleLine] _TerrainHeightTex( "Element Height", 2D ) = "white" {}
		[HideInInspector][StyledTextureSingleLine] _TerrainNormalTex( "Element Normal", 2D ) = "linearGrey" {}
		[HideInInspector] _TerrainPosition( "Terrain Position", Vector ) = ( 0, 0, 0, 0 )
		[HideInInspector] _TerrainSize( "Terrain Size", Vector ) = ( 0, 0, 0, 0 )
		[HideInInspector] _TerrainInputMode( "Terrain Input", Float ) = 0
		[NoScaleOffset][StyledTextureSingleLine] _ElementMaskTex( "Element Mask", 2D ) = "white" {}
		[Enum(Main UV,0,Planar,1)][Space(10)] _ElementMaskCoordMode( "Mask Sampling", Float ) = 0
		[StyledVector(9)] _ElementMaskCoordValue( "Mask UV Value", Vector ) = ( 1, 1, 0, 0 )
		_ElementMaskValue( "Element TexR Mask", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _ElementMaskRemap( "Element TexR Mask", Vector ) = ( 0, 1, 0, 0 )
		_ElementProjValue( "Element ProjY Mask", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _ElementProjRemap( "Element ProjY Mask", Vector ) = ( 0, 1, 0, 0 )
		_ElementPosValue( "Element PosY Mask", Range( 0, 1 ) ) = 0
		_ElementPosMinValue( "Element PosY Start", Float ) = 0
		_ElementPosMaxValue( "Element PosY Limit", Float ) = 0
		[StyledSpace(10)] _MaskingEnd( "[ Masking End ]", Float ) = 0
		[StyledCategory(Raycast Settings, true, 0, 10)] _RaycastCategory( "[ Raycast Category ]", Float ) = 1
		[HDR][Enum(Off,0,On,1)] _ElementRaycastMode( "Raycast Fade", Float ) = 0
		[StyledLayers()] _RaycastLayerMask( "Raycast Layer", Float ) = 1
		_RaycastDistanceMinValue( "Raycast Start", Float ) = 0
		_RaycastDistanceMaxValue( "Raycast Limit", Float ) = 2
		_RaycastDistanceCheckValue( "Raycast Max Distance", Float ) = 20
		[StyledSpace(10)] _RaycastEnd( "[ Raycast End ]", Float ) = 0
		[StyledCategory(Bounds Settings, true, 0, 10)] _BoundsCategory( "[ Bounds Category ]", Float ) = 1
		[Enum(Off,0,On,1)] _ElementVolumeFadeMode( "Bounds Fade", Float ) = 0
		_ElementVolumeFadeValue( "Bounds Fade Blend", Range( 0, 1 ) ) = 0.75
		[StyledSpace(10)] _BoundsEnd( "[ Bounds End ]", Float ) = 0

	}

	SubShader
	{
		

		Tags { "RenderType"="Transparent" "Queue"="Transparent" "PreviewType"="Plane" "DisableBatching"="True" }

	LOD 0

		

		Blend SrcAlpha OneMinusSrcAlpha
		AlphaToMask Off
		Cull Off
		ColorMask RGB
		ZWrite Off
		ZTest LEqual
		

		CGINCLUDE
			#pragma target 3.0

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
			Name "Unlit"

			CGPROGRAM
				#define ASE_VERSION 19904

				#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
					#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
				#endif
				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_instancing
				#include "UnityCG.cginc"

				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_COLOR
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0


				struct appdata
				{
					float4 vertex : POSITION;
					float4 ase_texcoord : TEXCOORD0;
					float4 ase_color : COLOR;
					float3 ase_normal : NORMAL;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					float4 ase_texcoord : TEXCOORD0;
					float4 ase_color : COLOR;
					float4 ase_texcoord1 : TEXCOORD1;
					float4 ase_texcoord2 : TEXCOORD2;
					float4 ase_texcoord3 : TEXCOORD3;
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				uniform half _Banner;
				uniform half _Message;
				uniform half _SpaceTexture;
				uniform half _ElementCategory;
				uniform half _ElementEnd;
				uniform half _RenderEnd;
				uniform float _SpeedTresholdValue;
				uniform half _RaycastLayerMask;
				uniform half _RaycastDistanceMinValue;
				uniform half _RaycastDistanceMaxValue;
				uniform half _RaycastDistanceCheckValue;
				uniform half _RaycastCategory;
				uniform half _RaycastEnd;
				uniform half _ElementRaycastMode;
				uniform half4 _MainTexColorRemap;
				uniform half _MainValue;
				uniform half4 TVE_SeasonOption;
				uniform half _AdditionalValue1;
				uniform half _AdditionalValue2;
				uniform half TVE_SeasonLerp;
				uniform half4 _SeasonRemap;
				uniform half _AdditionalValue3;
				uniform half _AdditionalValue4;
				uniform float _ElementMode;
				uniform sampler2D _MainTex;
				uniform float _ElementUVsMode;
				uniform half4 _MainUVs;
				uniform float _ElementIntensity;
				uniform half4 _MainTexAlphaRemap;
				uniform half4 _MainTexFalloffRemap;
				uniform half4 TVE_RenderBasePositionR;
				uniform float _ElementVolumeFadeValue;
				uniform float _ElementVolumeFadeMode;
				uniform half _BoundsCategory;
				uniform half _BoundsEnd;
				uniform sampler2D _ElementMaskTex;
				uniform float _ElementMaskCoordMode;
				uniform half4 _ElementMaskCoordValue;
				uniform half4 _ElementMaskRemap;
				uniform float _ElementMaskValue;
				uniform sampler2D _TerrainNormalTex;
				uniform float3 _TerrainPosition;
				uniform float3 _TerrainSize;
				uniform float _TerrainInputMode;
				uniform half4 _ElementProjRemap;
				uniform float _ElementProjValue;
				uniform sampler2D _TerrainHeightTex;
				float4 _TerrainHeightTex_TexelSize;
				uniform float _ElementPosMaxValue;
				uniform float _ElementPosMinValue;
				uniform float _ElementPosValue;
				uniform half _MaskingCategory;
				uniform half _MaskingEnd;
				uniform half _MaskingTerrainInfo;
				uniform half _MaskingModelInfo;
				uniform half _ElementBlendA;
				UNITY_INSTANCING_BUFFER_START(HiddenBOXOPHOBICTheVisualEngineElementsMotionWindControl)
					UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr HiddenBOXOPHOBICTheVisualEngineElementsMotionWindControl
				UNITY_INSTANCING_BUFFER_END(HiddenBOXOPHOBICTheVisualEngineElementsMotionWindControl)


				
				v2f vert ( appdata v )
				{
					v2f o;
					UNITY_SETUP_INSTANCE_ID( v );
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
					UNITY_TRANSFER_INSTANCE_ID( v, o );

					half TVE_SeasonOptions_X50_g53317 = TVE_SeasonOption.x;
					half Value_Winter158_g53317 = _AdditionalValue1;
					half Value_Spring159_g53317 = _AdditionalValue2;
					float temp_output_7_0_g76933 = _SeasonRemap.x;
					float temp_output_9_0_g76933 = ( TVE_SeasonLerp - temp_output_7_0_g76933 );
					float smoothstepResult2286_g53317 = smoothstep( 0.0 , 1.0 , saturate( ( temp_output_9_0_g76933 * _SeasonRemap.z ) ));
					half TVE_SeasonLerp54_g53317 = smoothstepResult2286_g53317;
					float lerpResult168_g53317 = lerp( Value_Winter158_g53317 , Value_Spring159_g53317 , TVE_SeasonLerp54_g53317);
					half TVE_SeasonOptions_Y51_g53317 = TVE_SeasonOption.y;
					half Value_Summer160_g53317 = _AdditionalValue3;
					float lerpResult167_g53317 = lerp( Value_Spring159_g53317 , Value_Summer160_g53317 , TVE_SeasonLerp54_g53317);
					half TVE_SeasonOptions_Z52_g53317 = TVE_SeasonOption.z;
					half Value_Autumn161_g53317 = _AdditionalValue4;
					float lerpResult166_g53317 = lerp( Value_Summer160_g53317 , Value_Autumn161_g53317 , TVE_SeasonLerp54_g53317);
					half TVE_SeasonOptions_W53_g53317 = TVE_SeasonOption.w;
					float lerpResult165_g53317 = lerp( Value_Autumn161_g53317 , Value_Winter158_g53317 , TVE_SeasonLerp54_g53317);
					float vertexToFrag11_g76925 = ( ( TVE_SeasonOptions_X50_g53317 * lerpResult168_g53317 ) + ( TVE_SeasonOptions_Y51_g53317 * lerpResult167_g53317 ) + ( TVE_SeasonOptions_Z52_g53317 * lerpResult166_g53317 ) + ( TVE_SeasonOptions_W53_g53317 * lerpResult165_g53317 ) );
					o.ase_texcoord.x = vertexToFrag11_g76925;
					float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
					float2 appendResult1900_g53317 = (float2(ase_positionWS.x , ase_positionWS.z));
					float2 lerpResult1899_g53317 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult1900_g53317 , _ElementUVsMode);
					float2 vertexToFrag11_g53321 = ( ( lerpResult1899_g53317 * (_MainUVs).xy ) + (_MainUVs).zw );
					o.ase_texcoord.yz = vertexToFrag11_g53321;
					o.ase_texcoord2.xyz = ase_positionWS;
					float2 appendResult60_g76912 = (float2(ase_positionWS.x , ase_positionWS.z));
					float2 lerpResult58_g76912 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult60_g76912 , _ElementMaskCoordMode);
					float2 vertexToFrag11_g76915 = ( ( lerpResult58_g76912 * (_ElementMaskCoordValue).xy ) + (_ElementMaskCoordValue).zw );
					o.ase_texcoord1.zw = vertexToFrag11_g76915;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.ase_normal );
					o.ase_texcoord3.xyz = ase_normalWS;
					
					o.ase_color = v.ase_color;
					o.ase_texcoord1.xy = v.ase_texcoord.xy;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord.w = 0;
					o.ase_texcoord2.w = 0;
					o.ase_texcoord3.w = 0;

					float3 vertexValue = float3( 0, 0, 0 );
					#if ASE_ABSOLUTE_VERTEX_POS
						vertexValue = v.vertex.xyz;
					#endif
					vertexValue = vertexValue;
					#if ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif

					o.pos = UnityObjectToClipPos( v.vertex );
					return o;
				}

				half4 frag( v2f IN  ) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID( IN );
					UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );
					half4 finalColor;

					float4 ScreenPosNorm = float4( IN.pos.xy * ( _ScreenParams.zw - 1.0 ), IN.pos.zw );
					float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, IN.pos.z ) * IN.pos.w;
					float4 ScreenPos = ComputeScreenPos( ClipPos );

					half Value_Main157_g53317 = _MainValue;
					float vertexToFrag11_g76925 = IN.ase_texcoord.x;
					half Value_Seasons1721_g53317 = vertexToFrag11_g76925;
					half Element_Mode55_g53317 = _ElementMode;
					float lerpResult181_g53317 = lerp( Value_Main157_g53317 , Value_Seasons1721_g53317 , Element_Mode55_g53317);
					float2 vertexToFrag11_g53321 = IN.ase_texcoord.yz;
					half4 MainTex_RGBA587_g53317 = tex2D( _MainTex, vertexToFrag11_g53321 );
					float3 temp_cast_0 = (0.0001).xxx;
					float3 temp_cast_1 = (0.9999).xxx;
					float3 clampResult17_g53319 = clamp( (MainTex_RGBA587_g53317).rgb , temp_cast_0 , temp_cast_1 );
					float temp_output_7_0_g76931 = _MainTexColorRemap.x;
					float3 temp_cast_2 = (temp_output_7_0_g76931).xxx;
					float3 temp_output_9_0_g76931 = ( clampResult17_g53319 - temp_cast_2 );
					float3 temp_output_1765_0_g53317 = saturate( ( temp_output_9_0_g76931 * _MainTexColorRemap.z ) );
					half Element_Remap_R73_g53317 = (temp_output_1765_0_g53317).x;
					half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
					half Element_Params_R1738_g53317 = _ElementParams_Instance.x;
					half Element_Value1744_g53317 = ( Element_Remap_R73_g53317 * Element_Params_R1738_g53317 * IN.ase_color.r );
					half Final_Extras_RGB213_g53317 = ( lerpResult181_g53317 * Element_Value1744_g53317 );
					float clampResult17_g53320 = clamp( (MainTex_RGBA587_g53317).a , 0.0001 , 0.9999 );
					float temp_output_7_0_g76932 = _MainTexAlphaRemap.x;
					float temp_output_9_0_g76932 = ( clampResult17_g53320 - temp_output_7_0_g76932 );
					half Element_Remap_A74_g53317 = saturate( ( ( temp_output_9_0_g76932 * _MainTexAlphaRemap.z ) + 0.0001 ) );
					half Element_Params_A1737_g53317 = _ElementParams_Instance.w;
					float clampResult17_g53318 = clamp( saturate( ( 1.0 - distance( (IN.ase_texcoord1.xy*2.0 + -1.0) , float2( 0,0 ) ) ) ) , 0.0001 , 0.9999 );
					float temp_output_7_0_g76935 = _MainTexFalloffRemap.x;
					float temp_output_9_0_g76935 = ( clampResult17_g53318 - temp_output_7_0_g76935 );
					half Element_Falloff1883_g53317 = saturate( ( ( temp_output_9_0_g76935 * _MainTexFalloffRemap.z ) + 0.0001 ) );
					float3 ase_positionWS = IN.ase_texcoord2.xyz;
					float temp_output_7_0_g76929 = 1.0;
					float temp_output_9_0_g76929 = ( saturate( ( distance( ase_positionWS , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g76929 );
					float lerpResult18_g76927 = lerp( 1.0 , saturate( ( temp_output_9_0_g76929 / ( _ElementVolumeFadeValue - temp_output_7_0_g76929 ) ) ) , _ElementVolumeFadeMode);
					half Blend_Edge69_g76927 = lerpResult18_g76927;
					float temp_output_6_0_g76930 = Blend_Edge69_g76927;
					half Dummy72_g76927 = ( _BoundsCategory + _BoundsEnd );
					#ifdef TVE_DUMMY
					float staticSwitch14_g76930 = ( temp_output_6_0_g76930 + Dummy72_g76927 );
					#else
					float staticSwitch14_g76930 = temp_output_6_0_g76930;
					#endif
					float2 vertexToFrag11_g76915 = IN.ase_texcoord1.zw;
					half4 MainTex_RGBA53_g76912 = tex2D( _ElementMaskTex, vertexToFrag11_g76915 );
					float clampResult17_g76917 = clamp( (MainTex_RGBA53_g76912).r , 0.0001 , 0.9999 );
					float temp_output_7_0_g76918 = _ElementMaskRemap.x;
					float temp_output_9_0_g76918 = ( clampResult17_g76917 - temp_output_7_0_g76918 );
					float lerpResult73_g76912 = lerp( 1.0 , saturate( ( ( temp_output_9_0_g76918 * _ElementMaskRemap.z ) + 0.0001 ) ) , _ElementMaskValue);
					half Blend_Mask45_g76912 = lerpResult73_g76912;
					float3 ase_normalWS = IN.ase_texcoord3.xyz;
					float4 appendResult108_g76912 = (float4(_TerrainPosition.x , _TerrainPosition.z , _TerrainSize.x , _TerrainSize.z));
					half4 Terrain_Coords111_g76912 = appendResult108_g76912;
					float4 temp_output_35_0_g76922 = Terrain_Coords111_g76912;
					float2 InputScale48_g76922 = (temp_output_35_0_g76922).zw;
					half2 FinalScale53_g76922 = ( 1.0 / InputScale48_g76922 );
					float2 InputPosition52_g76922 = (temp_output_35_0_g76922).xy;
					half2 FinalPosition58_g76922 = -( FinalScale53_g76922 * InputPosition52_g76922 );
					float2 temp_output_65_0_g76922 = ( ( (ase_positionWS).xz * FinalScale53_g76922 ) + FinalPosition58_g76922 );
					half Terrain_InputMode136_g76912 = _TerrainInputMode;
					float3 lerpResult141_g76912 = lerp( ase_normalWS , tex2D( _TerrainNormalTex, temp_output_65_0_g76922 ).rgb , Terrain_InputMode136_g76912);
					float3 Terrain_Normal107_g76912 = lerpResult141_g76912;
					float dotResult113_g76912 = dot( Terrain_Normal107_g76912 , half3( 0, 1, 0 ) );
					float clampResult17_g76919 = clamp( dotResult113_g76912 , 0.0001 , 0.9999 );
					float temp_output_7_0_g76920 = _ElementProjRemap.x;
					float temp_output_9_0_g76920 = ( clampResult17_g76919 - temp_output_7_0_g76920 );
					float lerpResult123_g76912 = lerp( 1.0 , saturate( ( ( temp_output_9_0_g76920 * _ElementProjRemap.z ) + 0.0001 ) ) , _ElementProjValue);
					half Blend_Proj117_g76912 = lerpResult123_g76912;
					float4 temp_output_35_0_g76913 = Terrain_Coords111_g76912;
					float2 InputScale48_g76913 = (temp_output_35_0_g76913).zw;
					half2 FinalScale53_g76913 = ( 1.0 / InputScale48_g76913 );
					float2 InputPosition52_g76913 = (temp_output_35_0_g76913).xy;
					half2 FinalPosition58_g76913 = -( FinalScale53_g76913 * InputPosition52_g76913 );
					float2 temp_output_65_0_g76913 = ( ( (ase_positionWS).xz * FinalScale53_g76913 ) + FinalPosition58_g76913 );
					float4 temp_output_70_0_g76913 = _TerrainHeightTex_TexelSize;
					float2 InputTexelSize68_g76913 = (temp_output_70_0_g76913).zw;
					float2 temp_cast_3 = (1.0).xx;
					float2 InputTexelRecip69_g76913 = (temp_output_70_0_g76913).xy;
					float4 Terrain_Height_Raw104_g76912 = tex2D( _TerrainHeightTex, ( ( ( temp_output_65_0_g76913 / ( 1.0 / ( InputTexelSize68_g76913 - temp_cast_3 ) ) ) + 0.5 ) * InputTexelRecip69_g76913 ) );
					float temp_output_90_0_g76912 = ( ( (Terrain_Height_Raw104_g76912).r + ( (Terrain_Height_Raw104_g76912).g * 256.0 ) ) / 257.0 );
					#ifdef SHADER_API_VULKAN
					float staticSwitch91_g76912 = temp_output_90_0_g76912;
					#else
					float staticSwitch91_g76912 = (Terrain_Height_Raw104_g76912).r;
					#endif
					#ifdef SHADER_API_GLES
					float staticSwitch92_g76912 = temp_output_90_0_g76912;
					#else
					float staticSwitch92_g76912 = staticSwitch91_g76912;
					#endif
					#ifdef SHADER_API_GLES3
					float staticSwitch93_g76912 = temp_output_90_0_g76912;
					#else
					float staticSwitch93_g76912 = staticSwitch92_g76912;
					#endif
					float Terrain_Height_Platform105_g76912 = staticSwitch93_g76912;
					float Terrain_SizeY109_g76912 = _TerrainSize.y;
					float Terrain_PosY110_g76912 = _TerrainPosition.y;
					float lerpResult137_g76912 = lerp( ase_positionWS.y , ( ( Terrain_Height_Platform105_g76912 * Terrain_SizeY109_g76912 * 2.0 ) + Terrain_PosY110_g76912 ) , Terrain_InputMode136_g76912);
					float Terrain_Height106_g76912 = lerpResult137_g76912;
					float temp_output_7_0_g76921 = _ElementPosMaxValue;
					float temp_output_9_0_g76921 = ( Terrain_Height106_g76912 - temp_output_7_0_g76921 );
					float lerpResult129_g76912 = lerp( 1.0 , saturate( ( temp_output_9_0_g76921 / ( _ElementPosMinValue - temp_output_7_0_g76921 ) ) ) , _ElementPosValue);
					half Blend_Pos131_g76912 = lerpResult129_g76912;
					float temp_output_6_0_g76923 = ( Blend_Mask45_g76912 * Blend_Proj117_g76912 * Blend_Pos131_g76912 );
					half Dummy144_g76912 = ( _MaskingCategory + _MaskingEnd + _MaskingTerrainInfo + _MaskingModelInfo );
					#ifdef TVE_DUMMY
					float staticSwitch14_g76923 = ( temp_output_6_0_g76923 + Dummy144_g76912 );
					#else
					float staticSwitch14_g76923 = temp_output_6_0_g76923;
					#endif
					half Element_Alpha56_g53317 = ( _ElementIntensity * Element_Remap_A74_g53317 * Element_Params_A1737_g53317 * IN.ase_color.a * Element_Falloff1883_g53317 * staticSwitch14_g76930 * staticSwitch14_g76923 );
					float lerpResult1634_g53317 = lerp( 1.0 , Final_Extras_RGB213_g53317 , Element_Alpha56_g53317);
					half Element_BlendA918_g53317 = _ElementBlendA;
					float lerpResult933_g53317 = lerp( lerpResult1634_g53317 , ( Final_Extras_RGB213_g53317 * Element_Alpha56_g53317 ) , Element_BlendA918_g53317);
					half Final_Blend_A211_g53317 = lerpResult933_g53317;
					float4 appendResult1732_g53317 = (float4(0.0 , 0.0 , 0.0 , Final_Blend_A211_g53317));
					

					finalColor = appendResult1732_g53317;

					return finalColor;
				}
			ENDCG
		}
	}
	CustomEditor "OOShaderGUIElement"
	
	Fallback Off
}
/*ASEBEGIN
Version=19904
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;117;-640,-1280;Inherit;False;Element Base Motion;-1;;19292;;0;0;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;95;-384,-1280;Half;False;Property;_Banner;Banner;0;0;Create;True;0;0;0;True;1;StyledBanner(Motion Control Element);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;115;-256,-1280;Half;False;Property;_Message;Message;1;0;Create;True;0;0;0;True;1;StyledMessage(Info, Use the Motion Wind Control elements to change the wind power and direction based on the element forward direction. Element Texture A is used as alpha mask. Particle Color A is used as Element Intensity multiplier. , 0,0);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;197;-640,-1024;Inherit;False;Element Shader;2;;53317;0e972c73cae2ee54ea51acc9738801d0;14,1778,2,477,2,478,0,1824,0,1814,3,145,3,1784,0,481,0,1935,1,1933,1,1904,1,1907,1,2310,1,2311,1;1;1974;FLOAT;0;False;2;FLOAT4;0;FLOAT4;1779
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;0;-320,-1024;Float;False;True;-1;2;OOShaderGUIElement;0;5;Hidden/BOXOPHOBIC/The Visual Engine/Elements/Motion Wind Control;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;False;True;2;5;False;;10;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;True;True;True;True;True;False;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;2;False;;True;0;False;;True;False;0;False;;0;False;;True;4;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;PreviewType=Plane;DisableBatching=True=DisableBatching;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;0;;0;0;Standard;1;Vertex Position;1;0;0;1;True;False;;False;0
WireConnection;0;0;197;0
ASEEND*/
//CHKSM=86582F21E54839CD32BBF65EA66AA02D735B0BC0