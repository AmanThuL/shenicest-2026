// Upgrade NOTE: upgraded instancing buffer 'BOXOPHOBICTheVisualEngineElementsGlowEmissive' to new syntax.

// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Elements/Glow Emissive"
{
	Properties
	{
		[StyledMessage(Info, Use Emissive elements to control the emissive effect on vegetation or static props. Element Texture R and Particle Color R are used as value multipliers. Element Texture A and Particle Color A are used as alpha masks., 0, 15)] _ElementMessage( "Element Message", Float ) = 0
		[HideInInspector] _IsVersion( "_IsVersion", Float ) = 2200
		[HideInInspector] _IsElementShader( "_IsElementShader", Float ) = 1
		[HideInInspector] _IsIdentifier( "_IsIdentifier", Float ) = 0
		[StyledCategory(Render Settings, true, 0, 10)] _RenderCategory( "[ Render Category ]", Float ) = 1
		_ElementIntensity( "Render Intensity", Range( 0, 1 ) ) = 1
		[StyledMessage(Info, When using a higher Layer number the Global Volume will create more render textures to render the elements. Try using fewer layers when possible., _ElementLayerMessage, 1, 10, 10)] _ElementLayerMessage( "Render Layer Message", Float ) = 0
		[StyledMessage(Warning, When using all layers the Global Volume will create one render texture for each layer to render the elements. Try using fewer layers when possible., _ElementLayerWarning, 1, 10, 10)] _ElementLayerWarning( "Render Layer Warning", Float ) = 0
		[StyledMask(Glow Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _ElementLayerMask( "Render Layer", Float ) = 1
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
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
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

			uniform half _IsVersion;
			uniform half _IsElementShader;
			uniform half _RenderCategory;
			uniform half _ElementLayerMessage;
			uniform half _ElementLayerWarning;
			uniform half _ElementLayerMask;
			uniform half _IsIdentifier;
			uniform half _ElementCategory;
			uniform half _ElementEnd;
			uniform half _RenderEnd;
			uniform float _SpeedTresholdValue;
			uniform half _ElementMessage;
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
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsGlowEmissive)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr BOXOPHOBICTheVisualEngineElementsGlowEmissive
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsGlowEmissive)

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				half TVE_SeasonOptions_X50_g23638 = TVE_SeasonOption.x;
				half4 Color_Winter_RGBA58_g23638 = _AdditionalColor1;
				half4 Color_Spring_RGBA59_g23638 = _AdditionalColor2;
				float temp_output_7_0_g77044 = _SeasonRemap.x;
				float temp_output_9_0_g77044 = ( TVE_SeasonLerp - temp_output_7_0_g77044 );
				float smoothstepResult2286_g23638 = smoothstep( 0.0 , 1.0 , saturate( ( temp_output_9_0_g77044 * _SeasonRemap.z ) ));
				half SeasonLerp54_g23638 = smoothstepResult2286_g23638;
				float4 lerpResult13_g23638 = lerp( Color_Winter_RGBA58_g23638 , Color_Spring_RGBA59_g23638 , SeasonLerp54_g23638);
				half TVE_SeasonOptions_Y51_g23638 = TVE_SeasonOption.y;
				half4 Color_Summer_RGBA60_g23638 = _AdditionalColor3;
				float4 lerpResult14_g23638 = lerp( Color_Spring_RGBA59_g23638 , Color_Summer_RGBA60_g23638 , SeasonLerp54_g23638);
				half TVE_SeasonOptions_Z52_g23638 = TVE_SeasonOption.z;
				half4 Color_Autumn_RGBA61_g23638 = _AdditionalColor4;
				float4 lerpResult15_g23638 = lerp( Color_Summer_RGBA60_g23638 , Color_Autumn_RGBA61_g23638 , SeasonLerp54_g23638);
				half TVE_SeasonOptions_W53_g23638 = TVE_SeasonOption.w;
				float4 lerpResult12_g23638 = lerp( Color_Autumn_RGBA61_g23638 , Color_Winter_RGBA58_g23638 , SeasonLerp54_g23638);
				float4 temp_output_25_0_g23638 = ( ( TVE_SeasonOptions_X50_g23638 * lerpResult13_g23638 ) + ( TVE_SeasonOptions_Y51_g23638 * lerpResult14_g23638 ) + ( TVE_SeasonOptions_Z52_g23638 * lerpResult15_g23638 ) + ( TVE_SeasonOptions_W53_g23638 * lerpResult12_g23638 ) );
				float4 vertexToFrag11_g76975 = temp_output_25_0_g23638;
				o.ase_texcoord1 = vertexToFrag11_g76975;
				float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
				float2 appendResult1900_g23638 = (float2(ase_positionWS.x , ase_positionWS.z));
				float2 lerpResult1899_g23638 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult1900_g23638 , _ElementUVsMode);
				float2 vertexToFrag11_g77047 = ( ( lerpResult1899_g23638 * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord2.xy = vertexToFrag11_g77047;
				float2 appendResult60_g77068 = (float2(ase_positionWS.x , ase_positionWS.z));
				float2 lerpResult58_g77068 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult60_g77068 , _ElementMaskCoordMode);
				float2 vertexToFrag11_g77071 = ( ( lerpResult58_g77068 * (_ElementMaskCoordValue).xy ) + (_ElementMaskCoordValue).zw );
				o.ase_texcoord3.xy = vertexToFrag11_g77071;
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
				half4 Color_Main_RGBA49_g23638 = _MainColor;
				float4 vertexToFrag11_g76975 = i.ase_texcoord1;
				half4 Color_Seasons1715_g23638 = vertexToFrag11_g76975;
				half Element_Mode55_g23638 = _ElementMode;
				float4 lerpResult30_g23638 = lerp( Color_Main_RGBA49_g23638 , Color_Seasons1715_g23638 , Element_Mode55_g23638);
				float2 vertexToFrag11_g77047 = i.ase_texcoord2.xy;
				half4 MainTex_RGBA587_g23638 = tex2D( _MainTex, vertexToFrag11_g77047 );
				float3 temp_output_6_0_g77050 = (MainTex_RGBA587_g23638).rgb;
				half SpaceTexture2395_g23638 = _SpaceTexture;
				float temp_output_7_0_g77050 = SpaceTexture2395_g23638;
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g77050 = ( temp_output_6_0_g77050 + temp_output_7_0_g77050 );
				#else
				float3 staticSwitch14_g77050 = temp_output_6_0_g77050;
				#endif
				float3 temp_cast_0 = (0.0001).xxx;
				float3 temp_cast_1 = (0.9999).xxx;
				float3 clampResult17_g77045 = clamp( staticSwitch14_g77050 , temp_cast_0 , temp_cast_1 );
				float temp_output_7_0_g77048 = _MainTexColorRemap.x;
				float3 temp_cast_2 = (temp_output_7_0_g77048).xxx;
				float3 temp_output_9_0_g77048 = ( clampResult17_g77045 - temp_cast_2 );
				float3 temp_output_1765_0_g23638 = saturate( ( temp_output_9_0_g77048 * _MainTexColorRemap.z ) );
				half3 Element_Remap_RGB1555_g23638 = temp_output_1765_0_g23638;
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half3 Element_Params_RGB1735_g23638 = (_ElementParams_Instance).xyz;
				half3 Element_Color1756_g23638 = ( Element_Remap_RGB1555_g23638 * Element_Params_RGB1735_g23638 * (i.ase_color).rgb );
				half3 Final_Colors_RGB142_g23638 = ( (lerpResult30_g23638).rgb * Element_Color1756_g23638 );
				half Element_Intensity2580_g23638 = _ElementIntensity;
				float temp_output_6_0_g77051 = (MainTex_RGBA587_g23638).a;
				float temp_output_7_0_g77051 = SpaceTexture2395_g23638;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77051 = ( temp_output_6_0_g77051 + temp_output_7_0_g77051 );
				#else
				float staticSwitch14_g77051 = temp_output_6_0_g77051;
				#endif
				float clampResult17_g77046 = clamp( staticSwitch14_g77051 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77049 = _MainTexAlphaRemap.x;
				float temp_output_9_0_g77049 = ( clampResult17_g77046 - temp_output_7_0_g77049 );
				half Element_Remap_A74_g23638 = saturate( ( temp_output_9_0_g77049 * _MainTexAlphaRemap.z ) );
				half Element_Params_A1737_g23638 = _ElementParams_Instance.w;
				float temp_output_6_0_g77053 = saturate( ( 1.0 - distance( (i.ase_texcoord2.zw*2.0 + -1.0) , float2( 0,0 ) ) ) );
				float temp_output_7_0_g77053 = SpaceTexture2395_g23638;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77053 = ( temp_output_6_0_g77053 + temp_output_7_0_g77053 );
				#else
				float staticSwitch14_g77053 = temp_output_6_0_g77053;
				#endif
				float clampResult17_g77052 = clamp( staticSwitch14_g77053 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77043 = _MainTexFalloffRemap.x;
				float temp_output_9_0_g77043 = ( clampResult17_g77052 - temp_output_7_0_g77043 );
				half Element_Falloff1883_g23638 = saturate( ( temp_output_9_0_g77043 * _MainTexFalloffRemap.z ) );
				float temp_output_7_0_g76929 = 1.0;
				float temp_output_9_0_g76929 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g76929 );
				float lerpResult18_g76927 = lerp( 1.0 , saturate( ( temp_output_9_0_g76929 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g76929 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g76927 = lerpResult18_g76927;
				float temp_output_6_0_g76930 = Blend_Edge69_g76927;
				half Dummy72_g76927 = ( _BoundsCategory + _BoundsEnd );
				float temp_output_7_0_g76930 = Dummy72_g76927;
				#ifdef TVE_DUMMY
				float staticSwitch14_g76930 = ( temp_output_6_0_g76930 + temp_output_7_0_g76930 );
				#else
				float staticSwitch14_g76930 = temp_output_6_0_g76930;
				#endif
				float2 vertexToFrag11_g77071 = i.ase_texcoord3.xy;
				half4 MainTex_RGBA53_g77068 = tex2D( _ElementMaskTex, vertexToFrag11_g77071 );
				float lerpResult148_g77068 = lerp( (MainTex_RGBA53_g77068).r , (MainTex_RGBA53_g77068).a , _ElementMaskMode);
				float clampResult17_g77077 = clamp( lerpResult148_g77068 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77078 = _ElementMaskRemap.x;
				float temp_output_9_0_g77078 = ( clampResult17_g77077 - temp_output_7_0_g77078 );
				float lerpResult73_g77068 = lerp( 1.0 , saturate( ( temp_output_9_0_g77078 * _ElementMaskRemap.z ) ) , _ElementMaskValue);
				half Blend_Mask45_g77068 = lerpResult73_g77068;
				#ifdef TVE_ELEMENT_MASK
				float staticSwitch159_g77068 = Blend_Mask45_g77068;
				#else
				float staticSwitch159_g77068 = 1.0;
				#endif
				float3 ase_normalWS = i.ase_texcoord4.xyz;
				float4 appendResult108_g77068 = (float4(_TerrainPosition.x , _TerrainPosition.z , _TerrainSize.x , _TerrainSize.z));
				half4 Terrain_Coords111_g77068 = appendResult108_g77068;
				float4 temp_output_35_0_g77076 = Terrain_Coords111_g77068;
				float2 InputScale48_g77076 = (temp_output_35_0_g77076).zw;
				half2 FinalScale53_g77076 = ( 1.0 / InputScale48_g77076 );
				float2 InputPosition52_g77076 = (temp_output_35_0_g77076).xy;
				half2 FinalPosition58_g77076 = -( FinalScale53_g77076 * InputPosition52_g77076 );
				float2 temp_output_65_0_g77076 = ( ( (WorldPosition).xz * FinalScale53_g77076 ) + FinalPosition58_g77076 );
				half Terrain_InputMode136_g77068 = _TerrainInputMode;
				float3 lerpResult141_g77068 = lerp( ase_normalWS , tex2D( _TerrainNormalTex, temp_output_65_0_g77076 ).rgb , Terrain_InputMode136_g77068);
				float3 Terrain_Normal107_g77068 = lerpResult141_g77068;
				float dotResult113_g77068 = dot( Terrain_Normal107_g77068 , half3( 0, 1, 0 ) );
				float clampResult17_g77073 = clamp( dotResult113_g77068 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77074 = _ElementProjRemap.x;
				float temp_output_9_0_g77074 = ( clampResult17_g77073 - temp_output_7_0_g77074 );
				float lerpResult123_g77068 = lerp( 1.0 , saturate( ( temp_output_9_0_g77074 * _ElementProjRemap.z ) ) , _ElementProjValue);
				half Blend_Proj117_g77068 = lerpResult123_g77068;
				#ifdef TVE_ELEMENT_PROJ
				float staticSwitch160_g77068 = Blend_Proj117_g77068;
				#else
				float staticSwitch160_g77068 = 1.0;
				#endif
				float4 temp_output_35_0_g77069 = Terrain_Coords111_g77068;
				float2 InputScale48_g77069 = (temp_output_35_0_g77069).zw;
				half2 FinalScale53_g77069 = ( 1.0 / InputScale48_g77069 );
				float2 InputPosition52_g77069 = (temp_output_35_0_g77069).xy;
				half2 FinalPosition58_g77069 = -( FinalScale53_g77069 * InputPosition52_g77069 );
				float2 temp_output_65_0_g77069 = ( ( (WorldPosition).xz * FinalScale53_g77069 ) + FinalPosition58_g77069 );
				float4 temp_output_70_0_g77069 = _TerrainHeightTex_TexelSize;
				float2 InputTexelSize68_g77069 = (temp_output_70_0_g77069).zw;
				float2 temp_cast_3 = (1.0).xx;
				float2 InputTexelRecip69_g77069 = (temp_output_70_0_g77069).xy;
				float4 Terrain_Height_Raw104_g77068 = tex2D( _TerrainHeightTex, ( ( ( temp_output_65_0_g77069 / ( 1.0 / ( InputTexelSize68_g77069 - temp_cast_3 ) ) ) + 0.5 ) * InputTexelRecip69_g77069 ) );
				float temp_output_90_0_g77068 = ( ( (Terrain_Height_Raw104_g77068).r + ( (Terrain_Height_Raw104_g77068).g * 256.0 ) ) / 257.0 );
				#ifdef SHADER_API_VULKAN
				float staticSwitch91_g77068 = temp_output_90_0_g77068;
				#else
				float staticSwitch91_g77068 = (Terrain_Height_Raw104_g77068).r;
				#endif
				#ifdef SHADER_API_GLES
				float staticSwitch92_g77068 = temp_output_90_0_g77068;
				#else
				float staticSwitch92_g77068 = staticSwitch91_g77068;
				#endif
				#ifdef SHADER_API_GLES3
				float staticSwitch93_g77068 = temp_output_90_0_g77068;
				#else
				float staticSwitch93_g77068 = staticSwitch92_g77068;
				#endif
				float Terrain_Height_Platform105_g77068 = staticSwitch93_g77068;
				float Terrain_SizeY109_g77068 = _TerrainSize.y;
				float Terrain_PosY110_g77068 = _TerrainPosition.y;
				float lerpResult137_g77068 = lerp( WorldPosition.y , ( ( Terrain_Height_Platform105_g77068 * Terrain_SizeY109_g77068 * 2.0 ) + Terrain_PosY110_g77068 ) , Terrain_InputMode136_g77068);
				float Terrain_Height106_g77068 = lerpResult137_g77068;
				float temp_output_7_0_g77075 = _ElementPosMaxValue;
				float temp_output_9_0_g77075 = ( Terrain_Height106_g77068 - temp_output_7_0_g77075 );
				float lerpResult129_g77068 = lerp( 1.0 , saturate( ( temp_output_9_0_g77075 / ( ( _ElementPosMinValue - temp_output_7_0_g77075 ) + 0.0001 ) ) ) , _ElementPosValue);
				half Blend_Pos131_g77068 = lerpResult129_g77068;
				#ifdef TVE_ELEMENT_POS
				float staticSwitch161_g77068 = Blend_Pos131_g77068;
				#else
				float staticSwitch161_g77068 = 1.0;
				#endif
				float temp_output_6_0_g77079 = ( staticSwitch159_g77068 * staticSwitch160_g77068 * staticSwitch161_g77068 );
				half Dummy144_g77068 = ( _MaskingCategory + _MaskingEnd + ( _MaskingTerrainInfo + _MaskingModelInfo ) );
				float temp_output_7_0_g77079 = Dummy144_g77068;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77079 = ( temp_output_6_0_g77079 + temp_output_7_0_g77079 );
				#else
				float staticSwitch14_g77079 = temp_output_6_0_g77079;
				#endif
				float temp_output_145_0_g77068 = staticSwitch14_g77079;
				float temp_output_6_0_g76982 = 1.0;
				float temp_output_7_0_g76982 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				float staticSwitch14_g76982 = ( temp_output_6_0_g76982 + temp_output_7_0_g76982 );
				#else
				float staticSwitch14_g76982 = temp_output_6_0_g76982;
				#endif
				half Element_Alpha56_g23638 = ( Element_Intensity2580_g23638 * Element_Remap_A74_g23638 * Element_Params_A1737_g23638 * i.ase_color.a * Element_Falloff1883_g23638 * staticSwitch14_g76930 * temp_output_145_0_g77068 * staticSwitch14_g76982 );
				half Final_Colors_A144_g23638 = ( (lerpResult30_g23638).a * Element_Alpha56_g23638 );
				float4 appendResult470_g23638 = (float4(Final_Colors_RGB142_g23638 , Final_Colors_A144_g23638));
				
				
				finalColor = appendResult470_g23638;
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

			uniform half _IsVersion;
			uniform half _IsElementShader;
			uniform half _RenderCategory;
			uniform half _ElementLayerMessage;
			uniform half _ElementLayerWarning;
			uniform half _ElementLayerMask;
			uniform half _IsIdentifier;
			uniform half _ElementCategory;
			uniform half _ElementEnd;
			uniform half _RenderEnd;
			uniform float _SpeedTresholdValue;
			uniform half _ElementMessage;
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
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsGlowEmissive)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr BOXOPHOBICTheVisualEngineElementsGlowEmissive
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsGlowEmissive)

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				half TVE_SeasonOptions_X50_g23638 = TVE_SeasonOption.x;
				half4 Color_Winter_RGBA58_g23638 = _AdditionalColor1;
				half4 Color_Spring_RGBA59_g23638 = _AdditionalColor2;
				float temp_output_7_0_g77044 = _SeasonRemap.x;
				float temp_output_9_0_g77044 = ( TVE_SeasonLerp - temp_output_7_0_g77044 );
				float smoothstepResult2286_g23638 = smoothstep( 0.0 , 1.0 , saturate( ( temp_output_9_0_g77044 * _SeasonRemap.z ) ));
				half SeasonLerp54_g23638 = smoothstepResult2286_g23638;
				float4 lerpResult13_g23638 = lerp( Color_Winter_RGBA58_g23638 , Color_Spring_RGBA59_g23638 , SeasonLerp54_g23638);
				half TVE_SeasonOptions_Y51_g23638 = TVE_SeasonOption.y;
				half4 Color_Summer_RGBA60_g23638 = _AdditionalColor3;
				float4 lerpResult14_g23638 = lerp( Color_Spring_RGBA59_g23638 , Color_Summer_RGBA60_g23638 , SeasonLerp54_g23638);
				half TVE_SeasonOptions_Z52_g23638 = TVE_SeasonOption.z;
				half4 Color_Autumn_RGBA61_g23638 = _AdditionalColor4;
				float4 lerpResult15_g23638 = lerp( Color_Summer_RGBA60_g23638 , Color_Autumn_RGBA61_g23638 , SeasonLerp54_g23638);
				half TVE_SeasonOptions_W53_g23638 = TVE_SeasonOption.w;
				float4 lerpResult12_g23638 = lerp( Color_Autumn_RGBA61_g23638 , Color_Winter_RGBA58_g23638 , SeasonLerp54_g23638);
				float4 temp_output_25_0_g23638 = ( ( TVE_SeasonOptions_X50_g23638 * lerpResult13_g23638 ) + ( TVE_SeasonOptions_Y51_g23638 * lerpResult14_g23638 ) + ( TVE_SeasonOptions_Z52_g23638 * lerpResult15_g23638 ) + ( TVE_SeasonOptions_W53_g23638 * lerpResult12_g23638 ) );
				float4 vertexToFrag11_g76975 = temp_output_25_0_g23638;
				o.ase_texcoord1 = vertexToFrag11_g76975;
				float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
				float2 appendResult1900_g23638 = (float2(ase_positionWS.x , ase_positionWS.z));
				float2 lerpResult1899_g23638 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult1900_g23638 , _ElementUVsMode);
				float2 vertexToFrag11_g77047 = ( ( lerpResult1899_g23638 * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord2.xy = vertexToFrag11_g77047;
				float2 appendResult60_g77068 = (float2(ase_positionWS.x , ase_positionWS.z));
				float2 lerpResult58_g77068 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult60_g77068 , _ElementMaskCoordMode);
				float2 vertexToFrag11_g77071 = ( ( lerpResult58_g77068 * (_ElementMaskCoordValue).xy ) + (_ElementMaskCoordValue).zw );
				o.ase_texcoord3.xy = vertexToFrag11_g77071;
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
				half4 Color_Main_RGBA49_g23638 = _MainColor;
				float4 vertexToFrag11_g76975 = i.ase_texcoord1;
				half4 Color_Seasons1715_g23638 = vertexToFrag11_g76975;
				half Element_Mode55_g23638 = _ElementMode;
				float4 lerpResult30_g23638 = lerp( Color_Main_RGBA49_g23638 , Color_Seasons1715_g23638 , Element_Mode55_g23638);
				float2 vertexToFrag11_g77047 = i.ase_texcoord2.xy;
				half4 MainTex_RGBA587_g23638 = tex2D( _MainTex, vertexToFrag11_g77047 );
				float3 temp_output_6_0_g77050 = (MainTex_RGBA587_g23638).rgb;
				half SpaceTexture2395_g23638 = _SpaceTexture;
				float temp_output_7_0_g77050 = SpaceTexture2395_g23638;
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g77050 = ( temp_output_6_0_g77050 + temp_output_7_0_g77050 );
				#else
				float3 staticSwitch14_g77050 = temp_output_6_0_g77050;
				#endif
				float3 temp_cast_0 = (0.0001).xxx;
				float3 temp_cast_1 = (0.9999).xxx;
				float3 clampResult17_g77045 = clamp( staticSwitch14_g77050 , temp_cast_0 , temp_cast_1 );
				float temp_output_7_0_g77048 = _MainTexColorRemap.x;
				float3 temp_cast_2 = (temp_output_7_0_g77048).xxx;
				float3 temp_output_9_0_g77048 = ( clampResult17_g77045 - temp_cast_2 );
				float3 temp_output_1765_0_g23638 = saturate( ( temp_output_9_0_g77048 * _MainTexColorRemap.z ) );
				half3 Element_Remap_RGB1555_g23638 = temp_output_1765_0_g23638;
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half3 Element_Params_RGB1735_g23638 = (_ElementParams_Instance).xyz;
				half3 Element_Color1756_g23638 = ( Element_Remap_RGB1555_g23638 * Element_Params_RGB1735_g23638 * (i.ase_color).rgb );
				half3 Final_Colors_RGB142_g23638 = ( (lerpResult30_g23638).rgb * Element_Color1756_g23638 );
				half Element_Intensity2580_g23638 = _ElementIntensity;
				float temp_output_6_0_g77051 = (MainTex_RGBA587_g23638).a;
				float temp_output_7_0_g77051 = SpaceTexture2395_g23638;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77051 = ( temp_output_6_0_g77051 + temp_output_7_0_g77051 );
				#else
				float staticSwitch14_g77051 = temp_output_6_0_g77051;
				#endif
				float clampResult17_g77046 = clamp( staticSwitch14_g77051 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77049 = _MainTexAlphaRemap.x;
				float temp_output_9_0_g77049 = ( clampResult17_g77046 - temp_output_7_0_g77049 );
				half Element_Remap_A74_g23638 = saturate( ( temp_output_9_0_g77049 * _MainTexAlphaRemap.z ) );
				half Element_Params_A1737_g23638 = _ElementParams_Instance.w;
				float temp_output_6_0_g77053 = saturate( ( 1.0 - distance( (i.ase_texcoord2.zw*2.0 + -1.0) , float2( 0,0 ) ) ) );
				float temp_output_7_0_g77053 = SpaceTexture2395_g23638;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77053 = ( temp_output_6_0_g77053 + temp_output_7_0_g77053 );
				#else
				float staticSwitch14_g77053 = temp_output_6_0_g77053;
				#endif
				float clampResult17_g77052 = clamp( staticSwitch14_g77053 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77043 = _MainTexFalloffRemap.x;
				float temp_output_9_0_g77043 = ( clampResult17_g77052 - temp_output_7_0_g77043 );
				half Element_Falloff1883_g23638 = saturate( ( temp_output_9_0_g77043 * _MainTexFalloffRemap.z ) );
				float temp_output_7_0_g76929 = 1.0;
				float temp_output_9_0_g76929 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g76929 );
				float lerpResult18_g76927 = lerp( 1.0 , saturate( ( temp_output_9_0_g76929 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g76929 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g76927 = lerpResult18_g76927;
				float temp_output_6_0_g76930 = Blend_Edge69_g76927;
				half Dummy72_g76927 = ( _BoundsCategory + _BoundsEnd );
				float temp_output_7_0_g76930 = Dummy72_g76927;
				#ifdef TVE_DUMMY
				float staticSwitch14_g76930 = ( temp_output_6_0_g76930 + temp_output_7_0_g76930 );
				#else
				float staticSwitch14_g76930 = temp_output_6_0_g76930;
				#endif
				float2 vertexToFrag11_g77071 = i.ase_texcoord3.xy;
				half4 MainTex_RGBA53_g77068 = tex2D( _ElementMaskTex, vertexToFrag11_g77071 );
				float lerpResult148_g77068 = lerp( (MainTex_RGBA53_g77068).r , (MainTex_RGBA53_g77068).a , _ElementMaskMode);
				float clampResult17_g77077 = clamp( lerpResult148_g77068 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77078 = _ElementMaskRemap.x;
				float temp_output_9_0_g77078 = ( clampResult17_g77077 - temp_output_7_0_g77078 );
				float lerpResult73_g77068 = lerp( 1.0 , saturate( ( temp_output_9_0_g77078 * _ElementMaskRemap.z ) ) , _ElementMaskValue);
				half Blend_Mask45_g77068 = lerpResult73_g77068;
				#ifdef TVE_ELEMENT_MASK
				float staticSwitch159_g77068 = Blend_Mask45_g77068;
				#else
				float staticSwitch159_g77068 = 1.0;
				#endif
				float3 ase_normalWS = i.ase_texcoord4.xyz;
				float4 appendResult108_g77068 = (float4(_TerrainPosition.x , _TerrainPosition.z , _TerrainSize.x , _TerrainSize.z));
				half4 Terrain_Coords111_g77068 = appendResult108_g77068;
				float4 temp_output_35_0_g77076 = Terrain_Coords111_g77068;
				float2 InputScale48_g77076 = (temp_output_35_0_g77076).zw;
				half2 FinalScale53_g77076 = ( 1.0 / InputScale48_g77076 );
				float2 InputPosition52_g77076 = (temp_output_35_0_g77076).xy;
				half2 FinalPosition58_g77076 = -( FinalScale53_g77076 * InputPosition52_g77076 );
				float2 temp_output_65_0_g77076 = ( ( (WorldPosition).xz * FinalScale53_g77076 ) + FinalPosition58_g77076 );
				half Terrain_InputMode136_g77068 = _TerrainInputMode;
				float3 lerpResult141_g77068 = lerp( ase_normalWS , tex2D( _TerrainNormalTex, temp_output_65_0_g77076 ).rgb , Terrain_InputMode136_g77068);
				float3 Terrain_Normal107_g77068 = lerpResult141_g77068;
				float dotResult113_g77068 = dot( Terrain_Normal107_g77068 , half3( 0, 1, 0 ) );
				float clampResult17_g77073 = clamp( dotResult113_g77068 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77074 = _ElementProjRemap.x;
				float temp_output_9_0_g77074 = ( clampResult17_g77073 - temp_output_7_0_g77074 );
				float lerpResult123_g77068 = lerp( 1.0 , saturate( ( temp_output_9_0_g77074 * _ElementProjRemap.z ) ) , _ElementProjValue);
				half Blend_Proj117_g77068 = lerpResult123_g77068;
				#ifdef TVE_ELEMENT_PROJ
				float staticSwitch160_g77068 = Blend_Proj117_g77068;
				#else
				float staticSwitch160_g77068 = 1.0;
				#endif
				float4 temp_output_35_0_g77069 = Terrain_Coords111_g77068;
				float2 InputScale48_g77069 = (temp_output_35_0_g77069).zw;
				half2 FinalScale53_g77069 = ( 1.0 / InputScale48_g77069 );
				float2 InputPosition52_g77069 = (temp_output_35_0_g77069).xy;
				half2 FinalPosition58_g77069 = -( FinalScale53_g77069 * InputPosition52_g77069 );
				float2 temp_output_65_0_g77069 = ( ( (WorldPosition).xz * FinalScale53_g77069 ) + FinalPosition58_g77069 );
				float4 temp_output_70_0_g77069 = _TerrainHeightTex_TexelSize;
				float2 InputTexelSize68_g77069 = (temp_output_70_0_g77069).zw;
				float2 temp_cast_3 = (1.0).xx;
				float2 InputTexelRecip69_g77069 = (temp_output_70_0_g77069).xy;
				float4 Terrain_Height_Raw104_g77068 = tex2D( _TerrainHeightTex, ( ( ( temp_output_65_0_g77069 / ( 1.0 / ( InputTexelSize68_g77069 - temp_cast_3 ) ) ) + 0.5 ) * InputTexelRecip69_g77069 ) );
				float temp_output_90_0_g77068 = ( ( (Terrain_Height_Raw104_g77068).r + ( (Terrain_Height_Raw104_g77068).g * 256.0 ) ) / 257.0 );
				#ifdef SHADER_API_VULKAN
				float staticSwitch91_g77068 = temp_output_90_0_g77068;
				#else
				float staticSwitch91_g77068 = (Terrain_Height_Raw104_g77068).r;
				#endif
				#ifdef SHADER_API_GLES
				float staticSwitch92_g77068 = temp_output_90_0_g77068;
				#else
				float staticSwitch92_g77068 = staticSwitch91_g77068;
				#endif
				#ifdef SHADER_API_GLES3
				float staticSwitch93_g77068 = temp_output_90_0_g77068;
				#else
				float staticSwitch93_g77068 = staticSwitch92_g77068;
				#endif
				float Terrain_Height_Platform105_g77068 = staticSwitch93_g77068;
				float Terrain_SizeY109_g77068 = _TerrainSize.y;
				float Terrain_PosY110_g77068 = _TerrainPosition.y;
				float lerpResult137_g77068 = lerp( WorldPosition.y , ( ( Terrain_Height_Platform105_g77068 * Terrain_SizeY109_g77068 * 2.0 ) + Terrain_PosY110_g77068 ) , Terrain_InputMode136_g77068);
				float Terrain_Height106_g77068 = lerpResult137_g77068;
				float temp_output_7_0_g77075 = _ElementPosMaxValue;
				float temp_output_9_0_g77075 = ( Terrain_Height106_g77068 - temp_output_7_0_g77075 );
				float lerpResult129_g77068 = lerp( 1.0 , saturate( ( temp_output_9_0_g77075 / ( ( _ElementPosMinValue - temp_output_7_0_g77075 ) + 0.0001 ) ) ) , _ElementPosValue);
				half Blend_Pos131_g77068 = lerpResult129_g77068;
				#ifdef TVE_ELEMENT_POS
				float staticSwitch161_g77068 = Blend_Pos131_g77068;
				#else
				float staticSwitch161_g77068 = 1.0;
				#endif
				float temp_output_6_0_g77079 = ( staticSwitch159_g77068 * staticSwitch160_g77068 * staticSwitch161_g77068 );
				half Dummy144_g77068 = ( _MaskingCategory + _MaskingEnd + ( _MaskingTerrainInfo + _MaskingModelInfo ) );
				float temp_output_7_0_g77079 = Dummy144_g77068;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77079 = ( temp_output_6_0_g77079 + temp_output_7_0_g77079 );
				#else
				float staticSwitch14_g77079 = temp_output_6_0_g77079;
				#endif
				float temp_output_145_0_g77068 = staticSwitch14_g77079;
				float temp_output_6_0_g76982 = 1.0;
				float temp_output_7_0_g76982 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				float staticSwitch14_g76982 = ( temp_output_6_0_g76982 + temp_output_7_0_g76982 );
				#else
				float staticSwitch14_g76982 = temp_output_6_0_g76982;
				#endif
				half Element_Alpha56_g23638 = ( Element_Intensity2580_g23638 * Element_Remap_A74_g23638 * Element_Params_A1737_g23638 * i.ase_color.a * Element_Falloff1883_g23638 * staticSwitch14_g76930 * temp_output_145_0_g77068 * staticSwitch14_g76982 );
				half Final_Colors_A144_g23638 = ( (lerpResult30_g23638).a * Element_Alpha56_g23638 );
				float4 appendResult2464_g23638 = (float4(Final_Colors_RGB142_g23638 , Final_Colors_A144_g23638));
				half4 Input_Visual94_g77283 = appendResult2464_g23638;
				half3 Element_Color47_g77283 = saturate( (Input_Visual94_g77283).xyz );
				float4 appendResult131_g77283 = (float4(Element_Color47_g77283 , (Input_Visual94_g77283).w));
				
				
				finalColor = appendResult131_g77283;
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
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":144,"pos":[-640,-1152],"params":["Inherit","False","Element Type Glow","1","","23635","3d1b37ca7ef3f9c4f9ae756ac35720e3","0","0","1","FLOAT","4"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":142,"pos":[-384,-1152],"params":["Inherit","False","Element Shader","11","","23638","0e972c73cae2ee54ea51acc9738801d0","15,1778,0,477,0,478,0,1824,0,1814,0,145,0,1784,0,481,0,2614,0,2618,0,1904,1,1907,1,2377,1,2310,1,2311,1","2","1974","FLOAT","1","False","2378","FLOAT","1","False","2","FLOAT4","0","FLOAT4","1779"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":131,"pos":[64,-1408],"params":["Inherit","False","Element Compile","-1","","77135","5302407fc6d65554791e558e67d59358","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":148,"pos":[-128,-1024],"params":["Inherit","False","Element Visuals","-1","","77283","78cf0f00cfd72824e84597f2db54a76e","1,64,0","2","59","FLOAT4","0,0,0,0","False","77","FLOAT3","1,1,1","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":111,"pos":[-640,-1408],"params":["Half","False","Property","_ElementMessage","Element Message","0","0","Create","True","0","0","0","True","1","StyledMessage(Info, Use Emissive elements to control the emissive effect on vegetation or static props. Element Texture R and Particle Color R are used as value multipliers. Element Texture A and Particle Color A are used as alpha masks., 0, 15)","False","Object","-1","","0","0","1","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":145,"pos":[-64,-1152],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","1","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass1","0","1","VolumePass1","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass1","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":146,"pos":[-64,-1152],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","1","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass2","0","2","VolumePass2","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass2","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":132,"pos":[64,-1152],"params":["Float","False","True","-1","2","TheVisualEngine.ElementGUI","100","2","BOXOPHOBIC/The Visual Engine/Elements/Glow Emissive","f4f273c3bb6262d4396be458405e60f9","True","VolumePass","0","0","VolumePass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","3","RenderType=Transparent=RenderType","Queue=Transparent=Queue=0","DisableBatching=True=DisableBatching","False","False","0","True","True","2","5","False","","10","False","","2","5","False","","10","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","True","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass","True","2","False","0","","0","0","Standard","3","VolumePass1","0","0","VolumePass2","0","0","Vertex Position","1","0","0","4","True","False","False","True","False","","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":133,"pos":[64,-1024],"params":["Float","False","False","-1","2","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VisualPass","0","3","VisualPass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","True","True","2","5","False","","10","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","False","True","2","False","0","","0","0","Standard","0","False","0"]}
{"wire":[142,1974,144,4]}
{"wire":[148,59,142,1779]}
{"wire":[132,0,142,0]}
{"wire":[133,0,148,0]}
ASEEND*/
//CHKSM=7F1DB864C1AD2A034D3BFCA31078881C91F0B7D1