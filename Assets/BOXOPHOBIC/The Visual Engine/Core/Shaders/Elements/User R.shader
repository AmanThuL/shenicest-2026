// Upgrade NOTE: upgraded instancing buffer 'BOXOPHOBICTheVisualEngineElementsUserR' to new syntax.

// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Elements/User R"
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
		[Space(10)] _MainValue( "Element Value", Range( 0, 1 ) ) = 1
		[Space(10)] _AdditionalValue1( "Season Winter", Range( 0, 1 ) ) = 1
		_AdditionalValue2( "Season Spring", Range( 0, 1 ) ) = 1
		_AdditionalValue3( "Season Summer", Range( 0, 1 ) ) = 1
		_AdditionalValue4( "Season Autumn", Range( 0, 1 ) ) = 1
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
		[HideInInspector] _render_src( "_render_src", Float ) = 0
		[HideInInspector] _render_dst( "_render_dst", Float ) = 2

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
			ColorMask R
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
				float4 ase_color : COLOR;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform float _SpeedTresholdValue;
			uniform half _ElementCategory;
			uniform half _ElementEnd;
			uniform half _RenderEnd;
			uniform float _render_src;
			uniform float _render_dst;
			uniform half _IsVersion;
			uniform half _IsElementShader;
			uniform half _RenderCategory;
			uniform half _ElementLayerMessage;
			uniform half _ElementLayerWarning;
			uniform half _IsIdentifier;
			uniform half _ElementLayerMask;
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
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsUserR)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr BOXOPHOBICTheVisualEngineElementsUserR
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsUserR)

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				half TVE_SeasonOptions_X50_g76908 = TVE_SeasonOption.x;
				half Value_Winter158_g76908 = _AdditionalValue1;
				half Value_Spring159_g76908 = _AdditionalValue2;
				float temp_output_7_0_g77044 = _SeasonRemap.x;
				float temp_output_9_0_g77044 = ( TVE_SeasonLerp - temp_output_7_0_g77044 );
				float smoothstepResult2286_g76908 = smoothstep( 0.0 , 1.0 , saturate( ( temp_output_9_0_g77044 * _SeasonRemap.z ) ));
				half SeasonLerp54_g76908 = smoothstepResult2286_g76908;
				float lerpResult168_g76908 = lerp( Value_Winter158_g76908 , Value_Spring159_g76908 , SeasonLerp54_g76908);
				half TVE_SeasonOptions_Y51_g76908 = TVE_SeasonOption.y;
				half Value_Summer160_g76908 = _AdditionalValue3;
				float lerpResult167_g76908 = lerp( Value_Spring159_g76908 , Value_Summer160_g76908 , SeasonLerp54_g76908);
				half TVE_SeasonOptions_Z52_g76908 = TVE_SeasonOption.z;
				half Value_Autumn161_g76908 = _AdditionalValue4;
				float lerpResult166_g76908 = lerp( Value_Summer160_g76908 , Value_Autumn161_g76908 , SeasonLerp54_g76908);
				half TVE_SeasonOptions_W53_g76908 = TVE_SeasonOption.w;
				float lerpResult165_g76908 = lerp( Value_Autumn161_g76908 , Value_Winter158_g76908 , SeasonLerp54_g76908);
				float temp_output_175_0_g76908 = ( ( TVE_SeasonOptions_X50_g76908 * lerpResult168_g76908 ) + ( TVE_SeasonOptions_Y51_g76908 * lerpResult167_g76908 ) + ( TVE_SeasonOptions_Z52_g76908 * lerpResult166_g76908 ) + ( TVE_SeasonOptions_W53_g76908 * lerpResult165_g76908 ) );
				float vertexToFrag11_g76972 = temp_output_175_0_g76908;
				o.ase_texcoord1.x = vertexToFrag11_g76972;
				float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
				float2 appendResult1900_g76908 = (float2(ase_positionWS.x , ase_positionWS.z));
				float2 lerpResult1899_g76908 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult1900_g76908 , _ElementUVsMode);
				float2 vertexToFrag11_g77047 = ( ( lerpResult1899_g76908 * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord1.yz = vertexToFrag11_g77047;
				float2 appendResult60_g77068 = (float2(ase_positionWS.x , ase_positionWS.z));
				float2 lerpResult58_g77068 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult60_g77068 , _ElementMaskCoordMode);
				float2 vertexToFrag11_g77071 = ( ( lerpResult58_g77068 * (_ElementMaskCoordValue).xy ) + (_ElementMaskCoordValue).zw );
				o.ase_texcoord2.zw = vertexToFrag11_g77071;
				float3 ase_normalWS = UnityObjectToWorldNormal( v.ase_normal );
				o.ase_texcoord3.xyz = ase_normalWS;
				
				o.ase_color = v.color;
				o.ase_texcoord2.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.w = 0;
				o.ase_texcoord3.w = 0;
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
				half Value_Main157_g76908 = _MainValue;
				float vertexToFrag11_g76972 = i.ase_texcoord1.x;
				half Value_Seasons1721_g76908 = vertexToFrag11_g76972;
				half Element_Mode55_g76908 = _ElementMode;
				float lerpResult181_g76908 = lerp( Value_Main157_g76908 , Value_Seasons1721_g76908 , Element_Mode55_g76908);
				float2 vertexToFrag11_g77047 = i.ase_texcoord1.yz;
				half4 MainTex_RGBA587_g76908 = tex2D( _MainTex, vertexToFrag11_g77047 );
				float3 temp_output_6_0_g77050 = (MainTex_RGBA587_g76908).rgb;
				half SpaceTexture2395_g76908 = _SpaceTexture;
				float temp_output_7_0_g77050 = SpaceTexture2395_g76908;
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
				float3 temp_output_1765_0_g76908 = saturate( ( temp_output_9_0_g77048 * _MainTexColorRemap.z ) );
				half Element_Remap_R73_g76908 = (temp_output_1765_0_g76908).x;
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half Element_Params_R1738_g76908 = _ElementParams_Instance.x;
				half Element_Value1744_g76908 = ( Element_Remap_R73_g76908 * Element_Params_R1738_g76908 * i.ase_color.r );
				float temp_output_468_0_g76908 = ( lerpResult181_g76908 * Element_Value1744_g76908 );
				float3 appendResult2402_g76908 = (float3(temp_output_468_0_g76908 , temp_output_468_0_g76908 , temp_output_468_0_g76908));
				half3 FInal_RGB213_g76908 = appendResult2402_g76908;
				float temp_output_6_0_g77051 = (MainTex_RGBA587_g76908).a;
				float temp_output_7_0_g77051 = SpaceTexture2395_g76908;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77051 = ( temp_output_6_0_g77051 + temp_output_7_0_g77051 );
				#else
				float staticSwitch14_g77051 = temp_output_6_0_g77051;
				#endif
				float clampResult17_g77046 = clamp( staticSwitch14_g77051 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77049 = _MainTexAlphaRemap.x;
				float temp_output_9_0_g77049 = ( clampResult17_g77046 - temp_output_7_0_g77049 );
				half Element_Remap_A74_g76908 = saturate( ( temp_output_9_0_g77049 * _MainTexAlphaRemap.z ) );
				half Element_Params_A1737_g76908 = _ElementParams_Instance.w;
				float temp_output_6_0_g77053 = saturate( ( 1.0 - distance( (i.ase_texcoord2.xy*2.0 + -1.0) , float2( 0,0 ) ) ) );
				float temp_output_7_0_g77053 = SpaceTexture2395_g76908;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77053 = ( temp_output_6_0_g77053 + temp_output_7_0_g77053 );
				#else
				float staticSwitch14_g77053 = temp_output_6_0_g77053;
				#endif
				float clampResult17_g77052 = clamp( staticSwitch14_g77053 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77043 = _MainTexFalloffRemap.x;
				float temp_output_9_0_g77043 = ( clampResult17_g77052 - temp_output_7_0_g77043 );
				half Element_Falloff1883_g76908 = saturate( ( temp_output_9_0_g77043 * _MainTexFalloffRemap.z ) );
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
				float2 vertexToFrag11_g77071 = i.ase_texcoord2.zw;
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
				float3 ase_normalWS = i.ase_texcoord3.xyz;
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
				half Element_Alpha56_g76908 = ( _ElementIntensity * Element_Remap_A74_g76908 * Element_Params_A1737_g76908 * i.ase_color.a * Element_Falloff1883_g76908 * staticSwitch14_g76930 * temp_output_145_0_g77068 * staticSwitch14_g76982 );
				half Final_A241_g76908 = Element_Alpha56_g76908;
				float4 appendResult882_g76908 = (float4(FInal_RGB213_g76908 , Final_A241_g76908));
				
				
				finalColor = appendResult882_g76908;
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
				float4 ase_color : COLOR;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform float _SpeedTresholdValue;
			uniform half _ElementCategory;
			uniform half _ElementEnd;
			uniform half _RenderEnd;
			uniform float _render_src;
			uniform float _render_dst;
			uniform half _IsVersion;
			uniform half _IsElementShader;
			uniform half _RenderCategory;
			uniform half _ElementLayerMessage;
			uniform half _ElementLayerWarning;
			uniform half _IsIdentifier;
			uniform half _ElementLayerMask;
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
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsUserR)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr BOXOPHOBICTheVisualEngineElementsUserR
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsUserR)

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				half TVE_SeasonOptions_X50_g76908 = TVE_SeasonOption.x;
				half Value_Winter158_g76908 = _AdditionalValue1;
				half Value_Spring159_g76908 = _AdditionalValue2;
				float temp_output_7_0_g77044 = _SeasonRemap.x;
				float temp_output_9_0_g77044 = ( TVE_SeasonLerp - temp_output_7_0_g77044 );
				float smoothstepResult2286_g76908 = smoothstep( 0.0 , 1.0 , saturate( ( temp_output_9_0_g77044 * _SeasonRemap.z ) ));
				half SeasonLerp54_g76908 = smoothstepResult2286_g76908;
				float lerpResult168_g76908 = lerp( Value_Winter158_g76908 , Value_Spring159_g76908 , SeasonLerp54_g76908);
				half TVE_SeasonOptions_Y51_g76908 = TVE_SeasonOption.y;
				half Value_Summer160_g76908 = _AdditionalValue3;
				float lerpResult167_g76908 = lerp( Value_Spring159_g76908 , Value_Summer160_g76908 , SeasonLerp54_g76908);
				half TVE_SeasonOptions_Z52_g76908 = TVE_SeasonOption.z;
				half Value_Autumn161_g76908 = _AdditionalValue4;
				float lerpResult166_g76908 = lerp( Value_Summer160_g76908 , Value_Autumn161_g76908 , SeasonLerp54_g76908);
				half TVE_SeasonOptions_W53_g76908 = TVE_SeasonOption.w;
				float lerpResult165_g76908 = lerp( Value_Autumn161_g76908 , Value_Winter158_g76908 , SeasonLerp54_g76908);
				float temp_output_175_0_g76908 = ( ( TVE_SeasonOptions_X50_g76908 * lerpResult168_g76908 ) + ( TVE_SeasonOptions_Y51_g76908 * lerpResult167_g76908 ) + ( TVE_SeasonOptions_Z52_g76908 * lerpResult166_g76908 ) + ( TVE_SeasonOptions_W53_g76908 * lerpResult165_g76908 ) );
				float vertexToFrag11_g76972 = temp_output_175_0_g76908;
				o.ase_texcoord1.x = vertexToFrag11_g76972;
				float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
				float2 appendResult1900_g76908 = (float2(ase_positionWS.x , ase_positionWS.z));
				float2 lerpResult1899_g76908 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult1900_g76908 , _ElementUVsMode);
				float2 vertexToFrag11_g77047 = ( ( lerpResult1899_g76908 * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord1.yz = vertexToFrag11_g77047;
				float2 appendResult60_g77068 = (float2(ase_positionWS.x , ase_positionWS.z));
				float2 lerpResult58_g77068 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult60_g77068 , _ElementMaskCoordMode);
				float2 vertexToFrag11_g77071 = ( ( lerpResult58_g77068 * (_ElementMaskCoordValue).xy ) + (_ElementMaskCoordValue).zw );
				o.ase_texcoord2.zw = vertexToFrag11_g77071;
				float3 ase_normalWS = UnityObjectToWorldNormal( v.ase_normal );
				o.ase_texcoord3.xyz = ase_normalWS;
				
				o.ase_color = v.color;
				o.ase_texcoord2.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.w = 0;
				o.ase_texcoord3.w = 0;
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
				half Value_Main157_g76908 = _MainValue;
				float vertexToFrag11_g76972 = i.ase_texcoord1.x;
				half Value_Seasons1721_g76908 = vertexToFrag11_g76972;
				half Element_Mode55_g76908 = _ElementMode;
				float lerpResult181_g76908 = lerp( Value_Main157_g76908 , Value_Seasons1721_g76908 , Element_Mode55_g76908);
				float2 vertexToFrag11_g77047 = i.ase_texcoord1.yz;
				half4 MainTex_RGBA587_g76908 = tex2D( _MainTex, vertexToFrag11_g77047 );
				float3 temp_output_6_0_g77050 = (MainTex_RGBA587_g76908).rgb;
				half SpaceTexture2395_g76908 = _SpaceTexture;
				float temp_output_7_0_g77050 = SpaceTexture2395_g76908;
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
				float3 temp_output_1765_0_g76908 = saturate( ( temp_output_9_0_g77048 * _MainTexColorRemap.z ) );
				half Element_Remap_R73_g76908 = (temp_output_1765_0_g76908).x;
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half Element_Params_R1738_g76908 = _ElementParams_Instance.x;
				half Element_Value1744_g76908 = ( Element_Remap_R73_g76908 * Element_Params_R1738_g76908 * i.ase_color.r );
				float temp_output_468_0_g76908 = ( lerpResult181_g76908 * Element_Value1744_g76908 );
				float3 appendResult2402_g76908 = (float3(temp_output_468_0_g76908 , temp_output_468_0_g76908 , temp_output_468_0_g76908));
				half3 FInal_RGB213_g76908 = appendResult2402_g76908;
				float temp_output_6_0_g77051 = (MainTex_RGBA587_g76908).a;
				float temp_output_7_0_g77051 = SpaceTexture2395_g76908;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77051 = ( temp_output_6_0_g77051 + temp_output_7_0_g77051 );
				#else
				float staticSwitch14_g77051 = temp_output_6_0_g77051;
				#endif
				float clampResult17_g77046 = clamp( staticSwitch14_g77051 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77049 = _MainTexAlphaRemap.x;
				float temp_output_9_0_g77049 = ( clampResult17_g77046 - temp_output_7_0_g77049 );
				half Element_Remap_A74_g76908 = saturate( ( temp_output_9_0_g77049 * _MainTexAlphaRemap.z ) );
				half Element_Params_A1737_g76908 = _ElementParams_Instance.w;
				float temp_output_6_0_g77053 = saturate( ( 1.0 - distance( (i.ase_texcoord2.xy*2.0 + -1.0) , float2( 0,0 ) ) ) );
				float temp_output_7_0_g77053 = SpaceTexture2395_g76908;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77053 = ( temp_output_6_0_g77053 + temp_output_7_0_g77053 );
				#else
				float staticSwitch14_g77053 = temp_output_6_0_g77053;
				#endif
				float clampResult17_g77052 = clamp( staticSwitch14_g77053 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77043 = _MainTexFalloffRemap.x;
				float temp_output_9_0_g77043 = ( clampResult17_g77052 - temp_output_7_0_g77043 );
				half Element_Falloff1883_g76908 = saturate( ( temp_output_9_0_g77043 * _MainTexFalloffRemap.z ) );
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
				float2 vertexToFrag11_g77071 = i.ase_texcoord2.zw;
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
				float3 ase_normalWS = i.ase_texcoord3.xyz;
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
				half Element_Alpha56_g76908 = ( _ElementIntensity * Element_Remap_A74_g76908 * Element_Params_A1737_g76908 * i.ase_color.a * Element_Falloff1883_g76908 * staticSwitch14_g76930 * temp_output_145_0_g77068 * staticSwitch14_g76982 );
				half Final_A241_g76908 = Element_Alpha56_g76908;
				float4 appendResult2468_g76908 = (float4(FInal_RGB213_g76908 , Final_A241_g76908));
				half4 Input_Visual94_g77283 = appendResult2468_g76908;
				float clampResult80_g77283 = clamp( (Input_Visual94_g77283).x , 0.1 , 10000.0 );
				float3 appendResult139_g77283 = (float3(clampResult80_g77283 , clampResult80_g77283 , clampResult80_g77283));
				float3 color234 = IsGammaSpace() ? float3( 1, 0, 0 ) : float3( 1, 0, 0 );
				half3 Input_Tint76_g77283 = color234;
				half3 Element_Color47_g77283 = saturate( ( appendResult139_g77283 * Input_Tint76_g77283 ) );
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
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":239,"pos":[-1920,-1408],"params":["Inherit","False","Element Type User","1","","77284","daa0c184d51931349a355c16f19e76f4","0","0","1","FLOAT","4"]}
{"type":"AmplifyShaderEditor.ColorNode, AmplifyShaderEditor","id":234,"pos":[-1664,-1280],"params":["Inherit","False","Constant","_Color11","Color 1","63","0","Create","True","0","0","0","False","0","False","Object","-1","","1,0,0,1","0,0,0,0","True","False","0","6","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":235,"pos":[-1664,-1408],"params":["Inherit","False","Element Shader","11","","76908","0e972c73cae2ee54ea51acc9738801d0","14,477,1,1778,1,478,2,1824,2,1814,0,145,0,481,0,1784,0,2346,1,1904,1,1907,1,2377,1,2310,1,2311,1","2","1974","FLOAT","0","False","2378","FLOAT","1","False","2","FLOAT4","0","FLOAT4","1779"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":167,"pos":[-704,-1664],"params":["Inherit","False","Element Compile","-1","","77086","5302407fc6d65554791e558e67d59358","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":238,"pos":[-1408,-1280],"params":["Inherit","False","Element Visuals","-1","","77283","78cf0f00cfd72824e84597f2db54a76e","1,64,1","2","59","FLOAT4","0,0,0,0","False","77","FLOAT3","1,1,1","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":231,"pos":[-1344,-1664],"params":["Inherit","False","Property","_render_src","_render_src","107","1","[HideInInspector]","Create","True","0","0","0","True","0","False","Object","-1","","0","2","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":232,"pos":[-1184,-1664],"params":["Inherit","False","Property","_render_dst","_render_dst","108","1","[HideInInspector]","Create","True","0","0","0","True","0","False","Object","-1","","2","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":112,"pos":[-1920,-1664],"params":["Half","False","Property","_ElementMessage","Element Message","0","0","Create","True","0","0","0","False","1","StyledMessage(Info, User element writing to R channel., 0, 15)","False","Object","-1","","0","0","1","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":218,"pos":[-960,-1408],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","1","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass1","0","1","VolumePass1","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass1","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":219,"pos":[-960,-1408],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","1","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass2","0","2","VolumePass2","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass2","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":177,"pos":[-1216,-1408],"params":["Float","False","True","-1","2","TheVisualEngine.ElementGUI","100","2","BOXOPHOBIC/The Visual Engine/Elements/User R","f4f273c3bb6262d4396be458405e60f9","True","VolumePass","0","0","VolumePass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","3","RenderType=Transparent=RenderType","Queue=Transparent=Queue=0","DisableBatching=True=DisableBatching","False","False","0","True","True","2","5","False","","10","False","","0","0","True","_render_src","0","True","_render_dst","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","True","True","True","False","False","False","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass","True","2","False","0","","0","0","Standard","3","VolumePass1","0","0","VolumePass2","0","0","Vertex Position","1","0","0","4","True","False","False","True","False","","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":178,"pos":[-1216,-1280],"params":["Float","False","False","-1","2","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VisualPass","0","3","VisualPass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","True","True","2","5","False","","10","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","False","True","2","False","0","","0","0","Standard","0","False","0"]}
{"wire":[235,1974,239,4]}
{"wire":[238,59,235,1779]}
{"wire":[238,77,234,0]}
{"wire":[177,0,235,0]}
{"wire":[178,0,238,0]}
ASEEND*/
//CHKSM=208A5AB57EB2BD2562DF245049DF278848CCDCDF