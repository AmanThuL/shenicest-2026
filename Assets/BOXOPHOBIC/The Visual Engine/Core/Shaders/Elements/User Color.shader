// Upgrade NOTE: upgraded instancing buffer 'BOXOPHOBICTheVisualEngineElementsUserColor' to new syntax.

// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Elements/User Color"
{
	Properties
	{
		[HideInInspector] _IsVersion( "_IsVersion", Float ) = 2160
		[HideInInspector] _IsElementShader( "_IsElementShader", Float ) = 1
		[HideInInspector] _IsIdentifier( "_IsIdentifier", Float ) = 0
		[StyledCategory(Render Settings, true, 0, 10)] _RenderCategory( "[ Render Category ]", Float ) = 1
		_ElementIntensity( "Render Intensity", Range( 0, 1 ) ) = 1
		[StyledMessage(Info, When using a higher Layer number the Global Volume will create more render textures to render the elements. Try using fewer layers when possible., _ElementLayerMessage, 1, 10, 10)] _ElementLayerMessage( "Render Layer Message", Float ) = 0
		[StyledMessage(Warning, When using all layers the Global Volume will create one render texture for each layer to render the elements. Try using fewer layers when possible., _ElementLayerWarning, 1, 10, 10)] _ElementLayerWarning( "Render Layer Warning", Float ) = 0
		[StyledMask(User Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _ElementLayerMask( "Render Layer", Float ) = 1
		[HideInInspector] _ElementParams( "Render Params", Vector ) = ( 1, 1, 1, 1 )
		[Enum(Constant,0,Seasons,1)] _ElementMode( "Render Mode", Float ) = 0
		[StyledSpace(10)] _RenderEnd( "[ Render End ]", Float ) = 0
		[StyledCategory(Element Settings, true, 0, 10)] _ElementCategory( "[ Element Category ]", Float ) = 1
		[NoScaleOffset][StyledTextureSingleLine] _MainTex( "Element Texture", 2D ) = "white" {}
		[StyledSpace(10)] _SpaceTexture( "#SpaceTexture", Float ) = 0
		[Enum(Main UV,0,Planar,1)] _ElementUVsMode( "Element Sampling", Float ) = 0
		[StyledVector(9)] _MainUVs( "Element UV Value", Vector ) = ( 1, 1, 0, 0 )
		[StyledRemapSlider] _MainTexColorRemap( "Element Value", Vector ) = ( 0, 1, 0, 0 )
		[StyledRemapSlider] _MainTexAlphaRemap( "Element Alpha", Vector ) = ( 0, 1, 0, 0 )
		[StyledRemapSlider] _MainTexFalloffRemap( "Element Falloff", Vector ) = ( 0, 0, 0, 0 )
		[HDR][Gamma][Space(10)] _MainColor( "Element Value", Color ) = ( 0.5019608, 0.5019608, 0.5019608, 1 )
		[HDR][Gamma][Space(10)] _AdditionalColor1( "Season Winter", Color ) = ( 0.5019608, 0.5019608, 0.5019608, 1 )
		[HDR][Gamma] _AdditionalColor2( "Season Spring", Color ) = ( 0.5019608, 0.5019608, 0.5019608, 1 )
		[HDR][Gamma] _AdditionalColor3( "Season Summer", Color ) = ( 0.5019608, 0.5019608, 0.5019608, 1 )
		[HDR][Gamma] _AdditionalColor4( "Season Autumn", Color ) = ( 0.5019608, 0.5019608, 0.5019608, 1 )
		[Space(10)][StyledRemapSlider] _SeasonRemap( "Season Curve", Vector ) = ( 0, 1, 0, 0 )
		[Space(10)] _SpeedTresholdValue( "Particle Speed Treshold", Float ) = 10
		[StyledSpace(10)] _ElementEnd( "[ Element End ]", Float ) = 0
		[StyledCategory(Masking Settings, true, 0, 10)] _MaskingCategory( "[ Masking Category ]", Float ) = 1
		[StyledMessage(Info, When the Terrain Data object is assigned__ the ProjY and PosY features use the terrain height and normal textures for masking. Make sure to set the Terrain Mask dropdown to Auto., 0, 10)] _MaskingTerrainInfo( "Masking Terrain Info", Float ) = 0
		[StyledMessage(Info, When the Terrain Data object is not assigned__ the ProjY and PosY features use the element mesh world space height and normal for masking., 0, 10)] _MaskingModelInfo( "Masking Model Info", Float ) = 0
		[HideInInspector] _TerrainPosition( "Terrain Position", Vector ) = ( 0, 0, 0, 0 )
		[HideInInspector] _TerrainSize( "Terrain Size", Vector ) = ( 0, 0, 0, 0 )
		[HideInInspector] _TerrainInputMode( "Terrain Input", Float ) = 0
		[NoScaleOffset][StyledTextureSingleLine] _ElementMaskTex( "Element Mask", 2D ) = "white" {}
		[StyledTextureSingleLine] _TerrainHeightTex( "Element Height", 2D ) = "white" {}
		[StyledTextureSingleLine] _TerrainNormalTex( "Element Normal", 2D ) = "linearGrey" {}
		[Enum(Main UV,0,Planar,1)][Space(10)] _ElementMaskCoordMode( "Mask Sampling", Float ) = 0
		[StyledVector(9)] _ElementMaskCoordValue( "Mask UV Value", Vector ) = ( 1, 1, 0, 0 )
		_ElementMaskValue( "Element TexC Mask", Range( 0, 1 ) ) = 0
		[Enum(Mask R,0,Mask A,1)] _ElementMaskMode( "Element TexC Mask", Float ) = 0
		[StyledRemapSlider] _ElementMaskRemap( "Element TexC Mask", Vector ) = ( 0, 1, 0, 0 )
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
		
		
		Tags { "RenderType"="Transparent" "Queue"="Transparent" "DisableBatching"="True" }
	LOD 100

		
		Pass
		{
			
			Name "VolumePass"
			Tags { "LightMode"="VolumePass" }
			
			CGINCLUDE
			#pragma target 3.0
			ENDCG
			Blend SrcAlpha OneMinusSrcAlpha
			AlphaToMask Off
			Cull Back
			ColorMask RGB
			ZWrite Off
			ZClip True
			ZTest LEqual
			
			CGPROGRAM

			#define ASE_VERSION 19912


			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
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
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma multi_compile_local_fragment __ TVE_ELEMENT_MASK
			#pragma multi_compile_local_fragment __ TVE_ELEMENT_PROJ
			#pragma multi_compile_local_fragment __ TVE_ELEMENT_POS


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float3 ase_normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_color : COLOR;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform float _SpeedTresholdValue;
			uniform half _ElementCategory;
			uniform half _ElementEnd;
			uniform half _RenderEnd;
			uniform half _IsVersion;
			uniform half _IsElementShader;
			uniform half _RenderCategory;
			uniform half _ElementLayerMessage;
			uniform half _ElementLayerWarning;
			uniform half _IsIdentifier;
			uniform half _ElementLayerMask;
			uniform half4 _MainColor;
			uniform half4 TVE_SeasonOption;
			uniform half4 _AdditionalColor1;
			uniform half4 _AdditionalColor2;
			uniform half TVE_SeasonLerp;
			uniform half4 _SeasonRemap;
			uniform half4 _AdditionalColor3;
			uniform half4 _AdditionalColor4;
			uniform float _ElementMode;
			uniform sampler2D _MainTex;
			uniform float _ElementUVsMode;
			uniform half4 _MainUVs;
			uniform half _SpaceTexture;
			uniform half4 _MainTexColorRemap;
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
			uniform float _ElementMaskMode;
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
			uniform half _RaycastCategory;
			uniform half _RaycastEnd;
			uniform half _ElementRaycastMode;
			uniform half _RaycastLayerMask;
			uniform half _RaycastDistanceMinValue;
			uniform half _RaycastDistanceMaxValue;
			uniform half _RaycastDistanceCheckValue;
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsUserColor)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr BOXOPHOBICTheVisualEngineElementsUserColor
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsUserColor)

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				half TVE_SeasonOptions_X50_g77339 = TVE_SeasonOption.x;
				half4 Color_Winter_RGBA58_g77339 = _AdditionalColor1;
				half4 Color_Spring_RGBA59_g77339 = _AdditionalColor2;
				float temp_output_7_0_g77353 = _SeasonRemap.x;
				float temp_output_9_0_g77353 = ( TVE_SeasonLerp - temp_output_7_0_g77353 );
				float smoothstepResult2286_g77339 = smoothstep( 0.0 , 1.0 , saturate( ( temp_output_9_0_g77353 * _SeasonRemap.z ) ));
				half SeasonLerp54_g77339 = smoothstepResult2286_g77339;
				float4 lerpResult13_g77339 = lerp( Color_Winter_RGBA58_g77339 , Color_Spring_RGBA59_g77339 , SeasonLerp54_g77339);
				half TVE_SeasonOptions_Y51_g77339 = TVE_SeasonOption.y;
				half4 Color_Summer_RGBA60_g77339 = _AdditionalColor3;
				float4 lerpResult14_g77339 = lerp( Color_Spring_RGBA59_g77339 , Color_Summer_RGBA60_g77339 , SeasonLerp54_g77339);
				half TVE_SeasonOptions_Z52_g77339 = TVE_SeasonOption.z;
				half4 Color_Autumn_RGBA61_g77339 = _AdditionalColor4;
				float4 lerpResult15_g77339 = lerp( Color_Summer_RGBA60_g77339 , Color_Autumn_RGBA61_g77339 , SeasonLerp54_g77339);
				half TVE_SeasonOptions_W53_g77339 = TVE_SeasonOption.w;
				float4 lerpResult12_g77339 = lerp( Color_Autumn_RGBA61_g77339 , Color_Winter_RGBA58_g77339 , SeasonLerp54_g77339);
				float4 temp_output_25_0_g77339 = ( ( TVE_SeasonOptions_X50_g77339 * lerpResult13_g77339 ) + ( TVE_SeasonOptions_Y51_g77339 * lerpResult14_g77339 ) + ( TVE_SeasonOptions_Z52_g77339 * lerpResult15_g77339 ) + ( TVE_SeasonOptions_W53_g77339 * lerpResult12_g77339 ) );
				float4 vertexToFrag11_g77349 = temp_output_25_0_g77339;
				o.ase_texcoord1 = vertexToFrag11_g77349;
				float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
				float2 appendResult1900_g77339 = (float2(ase_positionWS.x , ase_positionWS.z));
				float2 lerpResult1899_g77339 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult1900_g77339 , _ElementUVsMode);
				float2 vertexToFrag11_g77356 = ( ( lerpResult1899_g77339 * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord2.xy = vertexToFrag11_g77356;
				float2 appendResult60_g77365 = (float2(ase_positionWS.x , ase_positionWS.z));
				float2 lerpResult58_g77365 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult60_g77365 , _ElementMaskCoordMode);
				float2 vertexToFrag11_g77368 = ( ( lerpResult58_g77365 * (_ElementMaskCoordValue).xy ) + (_ElementMaskCoordValue).zw );
				o.ase_texcoord3.xy = vertexToFrag11_g77368;
				float3 ase_normalWS = UnityObjectToWorldNormal( v.ase_normal );
				o.ase_texcoord4.xyz = ase_normalWS;
				
				o.ase_color = v.color;
				o.ase_texcoord2.zw = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord3.zw = 0;
				o.ase_texcoord4.w = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				half4 Color_Main_RGBA49_g77339 = _MainColor;
				float4 vertexToFrag11_g77349 = i.ase_texcoord1;
				half4 Color_Seasons1715_g77339 = vertexToFrag11_g77349;
				half Element_Mode55_g77339 = _ElementMode;
				float4 lerpResult30_g77339 = lerp( Color_Main_RGBA49_g77339 , Color_Seasons1715_g77339 , Element_Mode55_g77339);
				float2 vertexToFrag11_g77356 = i.ase_texcoord2.xy;
				half4 MainTex_RGBA587_g77339 = tex2D( _MainTex, vertexToFrag11_g77356 );
				float3 temp_output_6_0_g77359 = (MainTex_RGBA587_g77339).rgb;
				half SpaceTexture2395_g77339 = _SpaceTexture;
				float temp_output_7_0_g77359 = SpaceTexture2395_g77339;
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g77359 = ( temp_output_6_0_g77359 + temp_output_7_0_g77359 );
				#else
				float3 staticSwitch14_g77359 = temp_output_6_0_g77359;
				#endif
				float3 temp_cast_0 = (0.0001).xxx;
				float3 temp_cast_1 = (0.9999).xxx;
				float3 clampResult17_g77354 = clamp( staticSwitch14_g77359 , temp_cast_0 , temp_cast_1 );
				float temp_output_7_0_g77357 = _MainTexColorRemap.x;
				float3 temp_cast_2 = (temp_output_7_0_g77357).xxx;
				float3 temp_output_9_0_g77357 = ( clampResult17_g77354 - temp_cast_2 );
				float3 temp_output_1765_0_g77339 = saturate( ( temp_output_9_0_g77357 * _MainTexColorRemap.z ) );
				half3 Element_Remap_RGB1555_g77339 = temp_output_1765_0_g77339;
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half3 Element_Params_RGB1735_g77339 = (_ElementParams_Instance).xyz;
				half3 Element_Color1756_g77339 = ( Element_Remap_RGB1555_g77339 * Element_Params_RGB1735_g77339 * (i.ase_color).rgb );
				half3 Final_Colors_RGB142_g77339 = ( (lerpResult30_g77339).rgb * Element_Color1756_g77339 );
				float temp_output_6_0_g77360 = (MainTex_RGBA587_g77339).a;
				float temp_output_7_0_g77360 = SpaceTexture2395_g77339;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77360 = ( temp_output_6_0_g77360 + temp_output_7_0_g77360 );
				#else
				float staticSwitch14_g77360 = temp_output_6_0_g77360;
				#endif
				float clampResult17_g77355 = clamp( staticSwitch14_g77360 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77358 = _MainTexAlphaRemap.x;
				float temp_output_9_0_g77358 = ( clampResult17_g77355 - temp_output_7_0_g77358 );
				half Element_Remap_A74_g77339 = saturate( ( temp_output_9_0_g77358 * _MainTexAlphaRemap.z ) );
				half Element_Params_A1737_g77339 = _ElementParams_Instance.w;
				float temp_output_6_0_g77362 = saturate( ( 1.0 - distance( (i.ase_texcoord2.zw*2.0 + -1.0) , float2( 0,0 ) ) ) );
				float temp_output_7_0_g77362 = SpaceTexture2395_g77339;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77362 = ( temp_output_6_0_g77362 + temp_output_7_0_g77362 );
				#else
				float staticSwitch14_g77362 = temp_output_6_0_g77362;
				#endif
				float clampResult17_g77361 = clamp( staticSwitch14_g77362 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77352 = _MainTexFalloffRemap.x;
				float temp_output_9_0_g77352 = ( clampResult17_g77361 - temp_output_7_0_g77352 );
				half Element_Falloff1883_g77339 = saturate( ( temp_output_9_0_g77352 * _MainTexFalloffRemap.z ) );
				float temp_output_7_0_g77344 = 1.0;
				float temp_output_9_0_g77344 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g77344 );
				float lerpResult18_g77342 = lerp( 1.0 , saturate( ( temp_output_9_0_g77344 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g77344 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g77342 = lerpResult18_g77342;
				float temp_output_6_0_g77345 = Blend_Edge69_g77342;
				half Dummy72_g77342 = ( _BoundsCategory + _BoundsEnd );
				float temp_output_7_0_g77345 = Dummy72_g77342;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77345 = ( temp_output_6_0_g77345 + temp_output_7_0_g77345 );
				#else
				float staticSwitch14_g77345 = temp_output_6_0_g77345;
				#endif
				float2 vertexToFrag11_g77368 = i.ase_texcoord3.xy;
				half4 MainTex_RGBA53_g77365 = tex2D( _ElementMaskTex, vertexToFrag11_g77368 );
				float lerpResult148_g77365 = lerp( (MainTex_RGBA53_g77365).r , (MainTex_RGBA53_g77365).a , _ElementMaskMode);
				float clampResult17_g77374 = clamp( lerpResult148_g77365 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77375 = _ElementMaskRemap.x;
				float temp_output_9_0_g77375 = ( clampResult17_g77374 - temp_output_7_0_g77375 );
				float lerpResult73_g77365 = lerp( 1.0 , saturate( ( temp_output_9_0_g77375 * _ElementMaskRemap.z ) ) , _ElementMaskValue);
				half Blend_Mask45_g77365 = lerpResult73_g77365;
				#ifdef TVE_ELEMENT_MASK
				float staticSwitch159_g77365 = Blend_Mask45_g77365;
				#else
				float staticSwitch159_g77365 = 1.0;
				#endif
				float3 ase_normalWS = i.ase_texcoord4.xyz;
				float4 appendResult108_g77365 = (float4(_TerrainPosition.x , _TerrainPosition.z , _TerrainSize.x , _TerrainSize.z));
				half4 Terrain_Coords111_g77365 = appendResult108_g77365;
				float4 temp_output_35_0_g77373 = Terrain_Coords111_g77365;
				float2 InputScale48_g77373 = (temp_output_35_0_g77373).zw;
				half2 FinalScale53_g77373 = ( 1.0 / InputScale48_g77373 );
				float2 InputPosition52_g77373 = (temp_output_35_0_g77373).xy;
				half2 FinalPosition58_g77373 = -( FinalScale53_g77373 * InputPosition52_g77373 );
				float2 temp_output_65_0_g77373 = ( ( (WorldPosition).xz * FinalScale53_g77373 ) + FinalPosition58_g77373 );
				half Terrain_InputMode136_g77365 = _TerrainInputMode;
				float3 lerpResult141_g77365 = lerp( ase_normalWS , tex2D( _TerrainNormalTex, temp_output_65_0_g77373 ).rgb , Terrain_InputMode136_g77365);
				float3 Terrain_Normal107_g77365 = lerpResult141_g77365;
				float dotResult113_g77365 = dot( Terrain_Normal107_g77365 , half3( 0, 1, 0 ) );
				float clampResult17_g77370 = clamp( dotResult113_g77365 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77371 = _ElementProjRemap.x;
				float temp_output_9_0_g77371 = ( clampResult17_g77370 - temp_output_7_0_g77371 );
				float lerpResult123_g77365 = lerp( 1.0 , saturate( ( temp_output_9_0_g77371 * _ElementProjRemap.z ) ) , _ElementProjValue);
				half Blend_Proj117_g77365 = lerpResult123_g77365;
				#ifdef TVE_ELEMENT_PROJ
				float staticSwitch160_g77365 = Blend_Proj117_g77365;
				#else
				float staticSwitch160_g77365 = 1.0;
				#endif
				float4 temp_output_35_0_g77366 = Terrain_Coords111_g77365;
				float2 InputScale48_g77366 = (temp_output_35_0_g77366).zw;
				half2 FinalScale53_g77366 = ( 1.0 / InputScale48_g77366 );
				float2 InputPosition52_g77366 = (temp_output_35_0_g77366).xy;
				half2 FinalPosition58_g77366 = -( FinalScale53_g77366 * InputPosition52_g77366 );
				float2 temp_output_65_0_g77366 = ( ( (WorldPosition).xz * FinalScale53_g77366 ) + FinalPosition58_g77366 );
				float4 temp_output_70_0_g77366 = _TerrainHeightTex_TexelSize;
				float2 InputTexelSize68_g77366 = (temp_output_70_0_g77366).zw;
				float2 temp_cast_3 = (1.0).xx;
				float2 InputTexelRecip69_g77366 = (temp_output_70_0_g77366).xy;
				float4 Terrain_Height_Raw104_g77365 = tex2D( _TerrainHeightTex, ( ( ( temp_output_65_0_g77366 / ( 1.0 / ( InputTexelSize68_g77366 - temp_cast_3 ) ) ) + 0.5 ) * InputTexelRecip69_g77366 ) );
				float temp_output_90_0_g77365 = ( ( (Terrain_Height_Raw104_g77365).r + ( (Terrain_Height_Raw104_g77365).g * 256.0 ) ) / 257.0 );
				#ifdef SHADER_API_VULKAN
				float staticSwitch91_g77365 = temp_output_90_0_g77365;
				#else
				float staticSwitch91_g77365 = (Terrain_Height_Raw104_g77365).r;
				#endif
				#ifdef SHADER_API_GLES
				float staticSwitch92_g77365 = temp_output_90_0_g77365;
				#else
				float staticSwitch92_g77365 = staticSwitch91_g77365;
				#endif
				#ifdef SHADER_API_GLES3
				float staticSwitch93_g77365 = temp_output_90_0_g77365;
				#else
				float staticSwitch93_g77365 = staticSwitch92_g77365;
				#endif
				float Terrain_Height_Platform105_g77365 = staticSwitch93_g77365;
				float Terrain_SizeY109_g77365 = _TerrainSize.y;
				float Terrain_PosY110_g77365 = _TerrainPosition.y;
				float lerpResult137_g77365 = lerp( WorldPosition.y , ( ( Terrain_Height_Platform105_g77365 * Terrain_SizeY109_g77365 * 2.0 ) + Terrain_PosY110_g77365 ) , Terrain_InputMode136_g77365);
				float Terrain_Height106_g77365 = lerpResult137_g77365;
				float temp_output_7_0_g77372 = _ElementPosMaxValue;
				float temp_output_9_0_g77372 = ( Terrain_Height106_g77365 - temp_output_7_0_g77372 );
				float lerpResult129_g77365 = lerp( 1.0 , saturate( ( temp_output_9_0_g77372 / ( ( _ElementPosMinValue - temp_output_7_0_g77372 ) + 0.0001 ) ) ) , _ElementPosValue);
				half Blend_Pos131_g77365 = lerpResult129_g77365;
				#ifdef TVE_ELEMENT_POS
				float staticSwitch161_g77365 = Blend_Pos131_g77365;
				#else
				float staticSwitch161_g77365 = 1.0;
				#endif
				float temp_output_6_0_g77376 = ( staticSwitch159_g77365 * staticSwitch160_g77365 * staticSwitch161_g77365 );
				half Dummy144_g77365 = ( _MaskingCategory + _MaskingEnd + ( _MaskingTerrainInfo + _MaskingModelInfo ) );
				float temp_output_7_0_g77376 = Dummy144_g77365;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77376 = ( temp_output_6_0_g77376 + temp_output_7_0_g77376 );
				#else
				float staticSwitch14_g77376 = temp_output_6_0_g77376;
				#endif
				float temp_output_145_0_g77365 = staticSwitch14_g77376;
				float temp_output_6_0_g77351 = 1.0;
				float temp_output_7_0_g77351 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				float staticSwitch14_g77351 = ( temp_output_6_0_g77351 + temp_output_7_0_g77351 );
				#else
				float staticSwitch14_g77351 = temp_output_6_0_g77351;
				#endif
				half Element_Alpha56_g77339 = ( _ElementIntensity * Element_Remap_A74_g77339 * Element_Params_A1737_g77339 * i.ase_color.a * Element_Falloff1883_g77339 * staticSwitch14_g77345 * temp_output_145_0_g77365 * staticSwitch14_g77351 );
				half Final_Colors_A144_g77339 = ( (lerpResult30_g77339).a * Element_Alpha56_g77339 );
				float4 appendResult470_g77339 = (float4(Final_Colors_RGB142_g77339 , Final_Colors_A144_g77339));
				
				
				finalColor = appendResult470_g77339;
				return finalColor;
			}
			ENDCG
		}

		
		Pass
		{
			
			Name "VisualPass"
			
			CGINCLUDE
			#pragma target 3.0
			ENDCG
			Blend SrcAlpha OneMinusSrcAlpha
			AlphaToMask Off
			Cull Back
			ColorMask RGBA
			ZWrite Off
			ZClip True
			ZTest LEqual
			
			CGPROGRAM

			#define ASE_VERSION 19912


			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
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
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma multi_compile_local_fragment __ TVE_ELEMENT_MASK
			#pragma multi_compile_local_fragment __ TVE_ELEMENT_PROJ
			#pragma multi_compile_local_fragment __ TVE_ELEMENT_POS


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float3 ase_normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_color : COLOR;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform float _SpeedTresholdValue;
			uniform half _ElementCategory;
			uniform half _ElementEnd;
			uniform half _RenderEnd;
			uniform half _IsVersion;
			uniform half _IsElementShader;
			uniform half _RenderCategory;
			uniform half _ElementLayerMessage;
			uniform half _ElementLayerWarning;
			uniform half _IsIdentifier;
			uniform half _ElementLayerMask;
			uniform half4 _MainColor;
			uniform half4 TVE_SeasonOption;
			uniform half4 _AdditionalColor1;
			uniform half4 _AdditionalColor2;
			uniform half TVE_SeasonLerp;
			uniform half4 _SeasonRemap;
			uniform half4 _AdditionalColor3;
			uniform half4 _AdditionalColor4;
			uniform float _ElementMode;
			uniform sampler2D _MainTex;
			uniform float _ElementUVsMode;
			uniform half4 _MainUVs;
			uniform half _SpaceTexture;
			uniform half4 _MainTexColorRemap;
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
			uniform float _ElementMaskMode;
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
			uniform half _RaycastCategory;
			uniform half _RaycastEnd;
			uniform half _ElementRaycastMode;
			uniform half _RaycastLayerMask;
			uniform half _RaycastDistanceMinValue;
			uniform half _RaycastDistanceMaxValue;
			uniform half _RaycastDistanceCheckValue;
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsUserColor)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr BOXOPHOBICTheVisualEngineElementsUserColor
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsUserColor)

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				half TVE_SeasonOptions_X50_g77339 = TVE_SeasonOption.x;
				half4 Color_Winter_RGBA58_g77339 = _AdditionalColor1;
				half4 Color_Spring_RGBA59_g77339 = _AdditionalColor2;
				float temp_output_7_0_g77353 = _SeasonRemap.x;
				float temp_output_9_0_g77353 = ( TVE_SeasonLerp - temp_output_7_0_g77353 );
				float smoothstepResult2286_g77339 = smoothstep( 0.0 , 1.0 , saturate( ( temp_output_9_0_g77353 * _SeasonRemap.z ) ));
				half SeasonLerp54_g77339 = smoothstepResult2286_g77339;
				float4 lerpResult13_g77339 = lerp( Color_Winter_RGBA58_g77339 , Color_Spring_RGBA59_g77339 , SeasonLerp54_g77339);
				half TVE_SeasonOptions_Y51_g77339 = TVE_SeasonOption.y;
				half4 Color_Summer_RGBA60_g77339 = _AdditionalColor3;
				float4 lerpResult14_g77339 = lerp( Color_Spring_RGBA59_g77339 , Color_Summer_RGBA60_g77339 , SeasonLerp54_g77339);
				half TVE_SeasonOptions_Z52_g77339 = TVE_SeasonOption.z;
				half4 Color_Autumn_RGBA61_g77339 = _AdditionalColor4;
				float4 lerpResult15_g77339 = lerp( Color_Summer_RGBA60_g77339 , Color_Autumn_RGBA61_g77339 , SeasonLerp54_g77339);
				half TVE_SeasonOptions_W53_g77339 = TVE_SeasonOption.w;
				float4 lerpResult12_g77339 = lerp( Color_Autumn_RGBA61_g77339 , Color_Winter_RGBA58_g77339 , SeasonLerp54_g77339);
				float4 temp_output_25_0_g77339 = ( ( TVE_SeasonOptions_X50_g77339 * lerpResult13_g77339 ) + ( TVE_SeasonOptions_Y51_g77339 * lerpResult14_g77339 ) + ( TVE_SeasonOptions_Z52_g77339 * lerpResult15_g77339 ) + ( TVE_SeasonOptions_W53_g77339 * lerpResult12_g77339 ) );
				float4 vertexToFrag11_g77349 = temp_output_25_0_g77339;
				o.ase_texcoord1 = vertexToFrag11_g77349;
				float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
				float2 appendResult1900_g77339 = (float2(ase_positionWS.x , ase_positionWS.z));
				float2 lerpResult1899_g77339 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult1900_g77339 , _ElementUVsMode);
				float2 vertexToFrag11_g77356 = ( ( lerpResult1899_g77339 * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord2.xy = vertexToFrag11_g77356;
				float2 appendResult60_g77365 = (float2(ase_positionWS.x , ase_positionWS.z));
				float2 lerpResult58_g77365 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult60_g77365 , _ElementMaskCoordMode);
				float2 vertexToFrag11_g77368 = ( ( lerpResult58_g77365 * (_ElementMaskCoordValue).xy ) + (_ElementMaskCoordValue).zw );
				o.ase_texcoord3.xy = vertexToFrag11_g77368;
				float3 ase_normalWS = UnityObjectToWorldNormal( v.ase_normal );
				o.ase_texcoord4.xyz = ase_normalWS;
				
				o.ase_color = v.color;
				o.ase_texcoord2.zw = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord3.zw = 0;
				o.ase_texcoord4.w = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				half4 Color_Main_RGBA49_g77339 = _MainColor;
				float4 vertexToFrag11_g77349 = i.ase_texcoord1;
				half4 Color_Seasons1715_g77339 = vertexToFrag11_g77349;
				half Element_Mode55_g77339 = _ElementMode;
				float4 lerpResult30_g77339 = lerp( Color_Main_RGBA49_g77339 , Color_Seasons1715_g77339 , Element_Mode55_g77339);
				float2 vertexToFrag11_g77356 = i.ase_texcoord2.xy;
				half4 MainTex_RGBA587_g77339 = tex2D( _MainTex, vertexToFrag11_g77356 );
				float3 temp_output_6_0_g77359 = (MainTex_RGBA587_g77339).rgb;
				half SpaceTexture2395_g77339 = _SpaceTexture;
				float temp_output_7_0_g77359 = SpaceTexture2395_g77339;
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g77359 = ( temp_output_6_0_g77359 + temp_output_7_0_g77359 );
				#else
				float3 staticSwitch14_g77359 = temp_output_6_0_g77359;
				#endif
				float3 temp_cast_0 = (0.0001).xxx;
				float3 temp_cast_1 = (0.9999).xxx;
				float3 clampResult17_g77354 = clamp( staticSwitch14_g77359 , temp_cast_0 , temp_cast_1 );
				float temp_output_7_0_g77357 = _MainTexColorRemap.x;
				float3 temp_cast_2 = (temp_output_7_0_g77357).xxx;
				float3 temp_output_9_0_g77357 = ( clampResult17_g77354 - temp_cast_2 );
				float3 temp_output_1765_0_g77339 = saturate( ( temp_output_9_0_g77357 * _MainTexColorRemap.z ) );
				half3 Element_Remap_RGB1555_g77339 = temp_output_1765_0_g77339;
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half3 Element_Params_RGB1735_g77339 = (_ElementParams_Instance).xyz;
				half3 Element_Color1756_g77339 = ( Element_Remap_RGB1555_g77339 * Element_Params_RGB1735_g77339 * (i.ase_color).rgb );
				half3 Final_Colors_RGB142_g77339 = ( (lerpResult30_g77339).rgb * Element_Color1756_g77339 );
				float temp_output_6_0_g77360 = (MainTex_RGBA587_g77339).a;
				float temp_output_7_0_g77360 = SpaceTexture2395_g77339;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77360 = ( temp_output_6_0_g77360 + temp_output_7_0_g77360 );
				#else
				float staticSwitch14_g77360 = temp_output_6_0_g77360;
				#endif
				float clampResult17_g77355 = clamp( staticSwitch14_g77360 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77358 = _MainTexAlphaRemap.x;
				float temp_output_9_0_g77358 = ( clampResult17_g77355 - temp_output_7_0_g77358 );
				half Element_Remap_A74_g77339 = saturate( ( temp_output_9_0_g77358 * _MainTexAlphaRemap.z ) );
				half Element_Params_A1737_g77339 = _ElementParams_Instance.w;
				float temp_output_6_0_g77362 = saturate( ( 1.0 - distance( (i.ase_texcoord2.zw*2.0 + -1.0) , float2( 0,0 ) ) ) );
				float temp_output_7_0_g77362 = SpaceTexture2395_g77339;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77362 = ( temp_output_6_0_g77362 + temp_output_7_0_g77362 );
				#else
				float staticSwitch14_g77362 = temp_output_6_0_g77362;
				#endif
				float clampResult17_g77361 = clamp( staticSwitch14_g77362 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77352 = _MainTexFalloffRemap.x;
				float temp_output_9_0_g77352 = ( clampResult17_g77361 - temp_output_7_0_g77352 );
				half Element_Falloff1883_g77339 = saturate( ( temp_output_9_0_g77352 * _MainTexFalloffRemap.z ) );
				float temp_output_7_0_g77344 = 1.0;
				float temp_output_9_0_g77344 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g77344 );
				float lerpResult18_g77342 = lerp( 1.0 , saturate( ( temp_output_9_0_g77344 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g77344 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g77342 = lerpResult18_g77342;
				float temp_output_6_0_g77345 = Blend_Edge69_g77342;
				half Dummy72_g77342 = ( _BoundsCategory + _BoundsEnd );
				float temp_output_7_0_g77345 = Dummy72_g77342;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77345 = ( temp_output_6_0_g77345 + temp_output_7_0_g77345 );
				#else
				float staticSwitch14_g77345 = temp_output_6_0_g77345;
				#endif
				float2 vertexToFrag11_g77368 = i.ase_texcoord3.xy;
				half4 MainTex_RGBA53_g77365 = tex2D( _ElementMaskTex, vertexToFrag11_g77368 );
				float lerpResult148_g77365 = lerp( (MainTex_RGBA53_g77365).r , (MainTex_RGBA53_g77365).a , _ElementMaskMode);
				float clampResult17_g77374 = clamp( lerpResult148_g77365 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77375 = _ElementMaskRemap.x;
				float temp_output_9_0_g77375 = ( clampResult17_g77374 - temp_output_7_0_g77375 );
				float lerpResult73_g77365 = lerp( 1.0 , saturate( ( temp_output_9_0_g77375 * _ElementMaskRemap.z ) ) , _ElementMaskValue);
				half Blend_Mask45_g77365 = lerpResult73_g77365;
				#ifdef TVE_ELEMENT_MASK
				float staticSwitch159_g77365 = Blend_Mask45_g77365;
				#else
				float staticSwitch159_g77365 = 1.0;
				#endif
				float3 ase_normalWS = i.ase_texcoord4.xyz;
				float4 appendResult108_g77365 = (float4(_TerrainPosition.x , _TerrainPosition.z , _TerrainSize.x , _TerrainSize.z));
				half4 Terrain_Coords111_g77365 = appendResult108_g77365;
				float4 temp_output_35_0_g77373 = Terrain_Coords111_g77365;
				float2 InputScale48_g77373 = (temp_output_35_0_g77373).zw;
				half2 FinalScale53_g77373 = ( 1.0 / InputScale48_g77373 );
				float2 InputPosition52_g77373 = (temp_output_35_0_g77373).xy;
				half2 FinalPosition58_g77373 = -( FinalScale53_g77373 * InputPosition52_g77373 );
				float2 temp_output_65_0_g77373 = ( ( (WorldPosition).xz * FinalScale53_g77373 ) + FinalPosition58_g77373 );
				half Terrain_InputMode136_g77365 = _TerrainInputMode;
				float3 lerpResult141_g77365 = lerp( ase_normalWS , tex2D( _TerrainNormalTex, temp_output_65_0_g77373 ).rgb , Terrain_InputMode136_g77365);
				float3 Terrain_Normal107_g77365 = lerpResult141_g77365;
				float dotResult113_g77365 = dot( Terrain_Normal107_g77365 , half3( 0, 1, 0 ) );
				float clampResult17_g77370 = clamp( dotResult113_g77365 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77371 = _ElementProjRemap.x;
				float temp_output_9_0_g77371 = ( clampResult17_g77370 - temp_output_7_0_g77371 );
				float lerpResult123_g77365 = lerp( 1.0 , saturate( ( temp_output_9_0_g77371 * _ElementProjRemap.z ) ) , _ElementProjValue);
				half Blend_Proj117_g77365 = lerpResult123_g77365;
				#ifdef TVE_ELEMENT_PROJ
				float staticSwitch160_g77365 = Blend_Proj117_g77365;
				#else
				float staticSwitch160_g77365 = 1.0;
				#endif
				float4 temp_output_35_0_g77366 = Terrain_Coords111_g77365;
				float2 InputScale48_g77366 = (temp_output_35_0_g77366).zw;
				half2 FinalScale53_g77366 = ( 1.0 / InputScale48_g77366 );
				float2 InputPosition52_g77366 = (temp_output_35_0_g77366).xy;
				half2 FinalPosition58_g77366 = -( FinalScale53_g77366 * InputPosition52_g77366 );
				float2 temp_output_65_0_g77366 = ( ( (WorldPosition).xz * FinalScale53_g77366 ) + FinalPosition58_g77366 );
				float4 temp_output_70_0_g77366 = _TerrainHeightTex_TexelSize;
				float2 InputTexelSize68_g77366 = (temp_output_70_0_g77366).zw;
				float2 temp_cast_3 = (1.0).xx;
				float2 InputTexelRecip69_g77366 = (temp_output_70_0_g77366).xy;
				float4 Terrain_Height_Raw104_g77365 = tex2D( _TerrainHeightTex, ( ( ( temp_output_65_0_g77366 / ( 1.0 / ( InputTexelSize68_g77366 - temp_cast_3 ) ) ) + 0.5 ) * InputTexelRecip69_g77366 ) );
				float temp_output_90_0_g77365 = ( ( (Terrain_Height_Raw104_g77365).r + ( (Terrain_Height_Raw104_g77365).g * 256.0 ) ) / 257.0 );
				#ifdef SHADER_API_VULKAN
				float staticSwitch91_g77365 = temp_output_90_0_g77365;
				#else
				float staticSwitch91_g77365 = (Terrain_Height_Raw104_g77365).r;
				#endif
				#ifdef SHADER_API_GLES
				float staticSwitch92_g77365 = temp_output_90_0_g77365;
				#else
				float staticSwitch92_g77365 = staticSwitch91_g77365;
				#endif
				#ifdef SHADER_API_GLES3
				float staticSwitch93_g77365 = temp_output_90_0_g77365;
				#else
				float staticSwitch93_g77365 = staticSwitch92_g77365;
				#endif
				float Terrain_Height_Platform105_g77365 = staticSwitch93_g77365;
				float Terrain_SizeY109_g77365 = _TerrainSize.y;
				float Terrain_PosY110_g77365 = _TerrainPosition.y;
				float lerpResult137_g77365 = lerp( WorldPosition.y , ( ( Terrain_Height_Platform105_g77365 * Terrain_SizeY109_g77365 * 2.0 ) + Terrain_PosY110_g77365 ) , Terrain_InputMode136_g77365);
				float Terrain_Height106_g77365 = lerpResult137_g77365;
				float temp_output_7_0_g77372 = _ElementPosMaxValue;
				float temp_output_9_0_g77372 = ( Terrain_Height106_g77365 - temp_output_7_0_g77372 );
				float lerpResult129_g77365 = lerp( 1.0 , saturate( ( temp_output_9_0_g77372 / ( ( _ElementPosMinValue - temp_output_7_0_g77372 ) + 0.0001 ) ) ) , _ElementPosValue);
				half Blend_Pos131_g77365 = lerpResult129_g77365;
				#ifdef TVE_ELEMENT_POS
				float staticSwitch161_g77365 = Blend_Pos131_g77365;
				#else
				float staticSwitch161_g77365 = 1.0;
				#endif
				float temp_output_6_0_g77376 = ( staticSwitch159_g77365 * staticSwitch160_g77365 * staticSwitch161_g77365 );
				half Dummy144_g77365 = ( _MaskingCategory + _MaskingEnd + ( _MaskingTerrainInfo + _MaskingModelInfo ) );
				float temp_output_7_0_g77376 = Dummy144_g77365;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77376 = ( temp_output_6_0_g77376 + temp_output_7_0_g77376 );
				#else
				float staticSwitch14_g77376 = temp_output_6_0_g77376;
				#endif
				float temp_output_145_0_g77365 = staticSwitch14_g77376;
				float temp_output_6_0_g77351 = 1.0;
				float temp_output_7_0_g77351 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				float staticSwitch14_g77351 = ( temp_output_6_0_g77351 + temp_output_7_0_g77351 );
				#else
				float staticSwitch14_g77351 = temp_output_6_0_g77351;
				#endif
				half Element_Alpha56_g77339 = ( _ElementIntensity * Element_Remap_A74_g77339 * Element_Params_A1737_g77339 * i.ase_color.a * Element_Falloff1883_g77339 * staticSwitch14_g77345 * temp_output_145_0_g77365 * staticSwitch14_g77351 );
				half Final_Colors_A144_g77339 = ( (lerpResult30_g77339).a * Element_Alpha56_g77339 );
				float4 appendResult2464_g77339 = (float4(Final_Colors_RGB142_g77339 , Final_Colors_A144_g77339));
				half4 Input_Visual94_g77382 = appendResult2464_g77339;
				half3 Element_Color47_g77382 = saturate( (Input_Visual94_g77382).xyz );
				float4 appendResult131_g77382 = (float4(Element_Color47_g77382 , (Input_Visual94_g77382).w));
				
				
				finalColor = appendResult131_g77382;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "TheVisualEngine.ElementGUI"
	
	Fallback Off
}
/*ASEBEGIN
Version=19912
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":225,"pos":[-1920,-1408],"params":["Inherit","False","Element Type User","1","","77383","daa0c184d51931349a355c16f19e76f4","0","0","1","FLOAT","4"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":223,"pos":[-1664,-1408],"params":["Inherit","False","Element Shader","11","","77339","0e972c73cae2ee54ea51acc9738801d0","14,477,0,1778,0,478,0,1824,0,1814,0,145,0,481,0,1784,0,2346,1,1904,1,1907,1,2377,1,2310,1,2311,1","2","1974","FLOAT","0","False","2378","FLOAT","1","False","2","FLOAT4","0","FLOAT4","1779"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":167,"pos":[-1168,-1664],"params":["Inherit","False","Element Compile","-1","","22425","5302407fc6d65554791e558e67d59358","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":224,"pos":[-1408,-1280],"params":["Inherit","False","Element Visuals","-1","","77382","78cf0f00cfd72824e84597f2db54a76e","1,64,0","2","59","FLOAT4","0,0,0,0","False","77","FLOAT3","1,1,1","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":112,"pos":[-1920,-1664],"params":["Half","False","Property","_ElementMessage","Element Message","0","0","Create","True","0","0","0","False","1","StyledMessage(Info, User element writing to RGB channels., 0, 15)","False","Object","-1","","0","0","1","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":177,"pos":[-1216,-1408],"params":["Float","False","True","-1","2","TheVisualEngine.ElementGUI","100","2","BOXOPHOBIC/The Visual Engine/Elements/User Color","f4f273c3bb6262d4396be458405e60f9","True","VolumePass","0","0","VolumePass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","3","RenderType=Transparent=RenderType","Queue=Transparent=Queue=0","DisableBatching=True=DisableBatching","False","False","0","True","True","2","5","False","","10","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","True","True","True","True","True","False","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass","True","2","False","0","","0","0","Standard","3","VolumePass1","0","0","VolumePass2","0","0","Vertex Position","1","0","0","4","True","False","False","True","False","","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":218,"pos":[-1216,-1408],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","1","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass1","0","1","VolumePass1","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass1","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":219,"pos":[-1216,-1408],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","1","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass2","0","2","VolumePass2","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass2","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":178,"pos":[-1216,-1280],"params":["Float","False","False","-1","2","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VisualPass","0","3","VisualPass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","True","True","2","5","False","","10","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","False","True","2","False","0","","0","0","Standard","0","False","0"]}
{"wire":[223,1974,225,4]}
{"wire":[224,59,223,1779]}
{"wire":[177,0,223,0]}
{"wire":[178,0,224,0]}
ASEEND*/
//CHKSM=02F00081AA69BB9B11A1FBBFC0A0A3FF6463999C