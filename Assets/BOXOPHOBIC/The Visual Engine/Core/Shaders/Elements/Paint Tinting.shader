// Upgrade NOTE: upgraded instancing buffer 'BOXOPHOBICTheVisualEngineElementsPaintTinting' to new syntax.

// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Elements/Paint Tinting"
{
	Properties
	{
		[StyledMessage(Info, Use Tinting elements to add color tinting to the vegetation assets. Element Texture RGB and Particle Color RGB are used as value multipliers. Element Texture A and Particle Color A are used as alpha masks., 0, 15)] _ElementMessage( "Element Message", Float ) = 0
		[HideInInspector] _IsVersion( "_IsVersion", Float ) = 2200
		[HideInInspector] _IsElementShader( "_IsElementShader", Float ) = 1
		[HideInInspector] _IsIdentifier( "_IsIdentifier", Float ) = 0
		[StyledCategory(Render Settings, true, 0, 10)] _RenderCategory( "[ Render Category ]", Float ) = 1
		_ElementIntensity( "Render Intensity", Range( 0, 1 ) ) = 1
		[StyledMessage(Info, When using a higher Layer number the Global Volume will create more render textures to render the elements. Try using fewer layers when possible., _ElementLayerMessage, 1, 10, 10)] _ElementLayerMessage( "Render Layer Message", Float ) = 0
		[StyledMessage(Warning, When using all layers the Global Volume will create one render texture for each layer to render the elements. Try using fewer layers when possible., _ElementLayerWarning, 1, 10, 10)] _ElementLayerWarning( "Render Layer Warning", Float ) = 0
		[StyledMask(Paint Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _ElementLayerMask( "Render Layer", Float ) = 1
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
		[HideInInspector] _render_colormask( "_render_colormask", Float ) = 15

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
				half3 ase_normal : NORMAL;
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
			uniform half _render_colormask;
			uniform half _ElementMessage;
			uniform half4 _MainColor;
			uniform half4 TVE_SeasonOption;
			uniform half4 _AdditionalColor1;
			uniform half4 _AdditionalColor2;
			uniform half TVE_SeasonLerp;
			uniform half4 _SeasonRemap;
			uniform half4 _AdditionalColor3;
			uniform half4 _AdditionalColor4;
			uniform half _ElementMode;
			uniform sampler2D _MainTex;
			uniform half _ElementUVsMode;
			uniform half4 _MainUVs;
			uniform half _SpaceTexture;
			uniform half4 _MainTexColorRemap;
			uniform half _ElementIntensity;
			uniform half4 _MainTexAlphaRemap;
			uniform half4 _MainTexFalloffRemap;
			uniform half4 TVE_RenderBasePositionR;
			uniform half _ElementVolumeFadeValue;
			uniform half _ElementVolumeFadeMode;
			uniform half _BoundsCategory;
			uniform half _BoundsEnd;
			uniform sampler2D _ElementMaskTex;
			uniform half _ElementMaskCoordMode;
			uniform half4 _ElementMaskCoordValue;
			uniform half _ElementMaskMode;
			uniform half4 _ElementMaskRemap;
			uniform half _ElementMaskValue;
			uniform sampler2D _TerrainNormalTex;
			uniform half3 _TerrainPosition;
			uniform half3 _TerrainSize;
			uniform half _TerrainInputMode;
			uniform half4 _ElementProjRemap;
			uniform half _ElementProjValue;
			uniform sampler2D _TerrainHeightTex;
			float4 _TerrainHeightTex_TexelSize;
			uniform half _ElementPosMaxValue;
			uniform half _ElementPosMinValue;
			uniform half _ElementPosValue;
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
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsPaintTinting)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr BOXOPHOBICTheVisualEngineElementsPaintTinting
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsPaintTinting)

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				half TVE_SeasonOptions_X50_g77339 = TVE_SeasonOption.x;
				half4 Color_Winter_RGBA58_g77339 = _AdditionalColor1;
				half4 Color_Spring_RGBA59_g77339 = _AdditionalColor2;
				half temp_output_7_0_g77350 = _SeasonRemap.x;
				half temp_output_9_0_g77350 = ( TVE_SeasonLerp - temp_output_7_0_g77350 );
				half smoothstepResult2286_g77339 = smoothstep( 0.0 , 1.0 , saturate( ( temp_output_9_0_g77350 * _SeasonRemap.z ) ));
				half SeasonLerp54_g77339 = smoothstepResult2286_g77339;
				half4 lerpResult13_g77339 = lerp( Color_Winter_RGBA58_g77339 , Color_Spring_RGBA59_g77339 , SeasonLerp54_g77339);
				half TVE_SeasonOptions_Y51_g77339 = TVE_SeasonOption.y;
				half4 Color_Summer_RGBA60_g77339 = _AdditionalColor3;
				half4 lerpResult14_g77339 = lerp( Color_Spring_RGBA59_g77339 , Color_Summer_RGBA60_g77339 , SeasonLerp54_g77339);
				half TVE_SeasonOptions_Z52_g77339 = TVE_SeasonOption.z;
				half4 Color_Autumn_RGBA61_g77339 = _AdditionalColor4;
				half4 lerpResult15_g77339 = lerp( Color_Summer_RGBA60_g77339 , Color_Autumn_RGBA61_g77339 , SeasonLerp54_g77339);
				half TVE_SeasonOptions_W53_g77339 = TVE_SeasonOption.w;
				half4 lerpResult12_g77339 = lerp( Color_Autumn_RGBA61_g77339 , Color_Winter_RGBA58_g77339 , SeasonLerp54_g77339);
				half4 temp_output_25_0_g77339 = ( ( TVE_SeasonOptions_X50_g77339 * lerpResult13_g77339 ) + ( TVE_SeasonOptions_Y51_g77339 * lerpResult14_g77339 ) + ( TVE_SeasonOptions_Z52_g77339 * lerpResult15_g77339 ) + ( TVE_SeasonOptions_W53_g77339 * lerpResult12_g77339 ) );
				half4 vertexToFrag11_g77346 = temp_output_25_0_g77339;
				o.ase_texcoord1 = vertexToFrag11_g77346;
				float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
				half2 appendResult1900_g77339 = (half2(ase_positionWS.x , ase_positionWS.z));
				half2 lerpResult1899_g77339 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult1900_g77339 , _ElementUVsMode);
				half2 vertexToFrag11_g77353 = ( ( lerpResult1899_g77339 * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord2.xy = vertexToFrag11_g77353;
				half2 appendResult60_g77360 = (half2(ase_positionWS.x , ase_positionWS.z));
				half2 lerpResult58_g77360 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult60_g77360 , _ElementMaskCoordMode);
				half2 vertexToFrag11_g77363 = ( ( lerpResult58_g77360 * (_ElementMaskCoordValue).xy ) + (_ElementMaskCoordValue).zw );
				o.ase_texcoord3.xy = vertexToFrag11_g77363;
				half3 ase_normalWS = UnityObjectToWorldNormal( v.ase_normal );
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
				half4 vertexToFrag11_g77346 = i.ase_texcoord1;
				half4 Color_Seasons1715_g77339 = vertexToFrag11_g77346;
				half Element_Mode55_g77339 = _ElementMode;
				half4 lerpResult30_g77339 = lerp( Color_Main_RGBA49_g77339 , Color_Seasons1715_g77339 , Element_Mode55_g77339);
				half2 vertexToFrag11_g77353 = i.ase_texcoord2.xy;
				half4 MainTex_RGBA587_g77339 = tex2D( _MainTex, vertexToFrag11_g77353 );
				half3 temp_output_6_0_g77356 = (MainTex_RGBA587_g77339).rgb;
				half SpaceTexture2395_g77339 = _SpaceTexture;
				half temp_output_7_0_g77356 = SpaceTexture2395_g77339;
				#ifdef TVE_DUMMY
				half3 staticSwitch14_g77356 = ( temp_output_6_0_g77356 + temp_output_7_0_g77356 );
				#else
				half3 staticSwitch14_g77356 = temp_output_6_0_g77356;
				#endif
				half3 temp_cast_0 = (0.0001).xxx;
				half3 temp_cast_1 = (0.9999).xxx;
				half3 clampResult17_g77351 = clamp( staticSwitch14_g77356 , temp_cast_0 , temp_cast_1 );
				half temp_output_7_0_g77354 = _MainTexColorRemap.x;
				half3 temp_cast_2 = (temp_output_7_0_g77354).xxx;
				half3 temp_output_9_0_g77354 = ( clampResult17_g77351 - temp_cast_2 );
				half3 temp_output_1765_0_g77339 = saturate( ( temp_output_9_0_g77354 * _MainTexColorRemap.z ) );
				half3 Element_Remap_RGB1555_g77339 = temp_output_1765_0_g77339;
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half3 Element_Params_RGB1735_g77339 = (_ElementParams_Instance).xyz;
				half3 Element_Color1756_g77339 = ( Element_Remap_RGB1555_g77339 * Element_Params_RGB1735_g77339 * (i.ase_color).rgb );
				half3 Final_Colors_RGB142_g77339 = ( (lerpResult30_g77339).rgb * Element_Color1756_g77339 );
				half Element_Intensity2580_g77339 = _ElementIntensity;
				half temp_output_6_0_g77357 = (MainTex_RGBA587_g77339).a;
				half temp_output_7_0_g77357 = SpaceTexture2395_g77339;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77357 = ( temp_output_6_0_g77357 + temp_output_7_0_g77357 );
				#else
				half staticSwitch14_g77357 = temp_output_6_0_g77357;
				#endif
				half clampResult17_g77352 = clamp( staticSwitch14_g77357 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77355 = _MainTexAlphaRemap.x;
				half temp_output_9_0_g77355 = ( clampResult17_g77352 - temp_output_7_0_g77355 );
				half Element_Remap_A74_g77339 = saturate( ( temp_output_9_0_g77355 * _MainTexAlphaRemap.z ) );
				half Element_Params_A1737_g77339 = _ElementParams_Instance.w;
				half temp_output_6_0_g77359 = saturate( ( 1.0 - distance( (i.ase_texcoord2.zw*2.0 + -1.0) , float2( 0,0 ) ) ) );
				half temp_output_7_0_g77359 = SpaceTexture2395_g77339;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77359 = ( temp_output_6_0_g77359 + temp_output_7_0_g77359 );
				#else
				half staticSwitch14_g77359 = temp_output_6_0_g77359;
				#endif
				half clampResult17_g77358 = clamp( staticSwitch14_g77359 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77349 = _MainTexFalloffRemap.x;
				half temp_output_9_0_g77349 = ( clampResult17_g77358 - temp_output_7_0_g77349 );
				half Element_Falloff1883_g77339 = saturate( ( temp_output_9_0_g77349 * _MainTexFalloffRemap.z ) );
				half temp_output_7_0_g77342 = 1.0;
				half temp_output_9_0_g77342 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g77342 );
				half lerpResult18_g77340 = lerp( 1.0 , saturate( ( temp_output_9_0_g77342 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g77342 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g77340 = lerpResult18_g77340;
				half temp_output_6_0_g77343 = Blend_Edge69_g77340;
				half Dummy72_g77340 = ( _BoundsCategory + _BoundsEnd );
				half temp_output_7_0_g77343 = Dummy72_g77340;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77343 = ( temp_output_6_0_g77343 + temp_output_7_0_g77343 );
				#else
				half staticSwitch14_g77343 = temp_output_6_0_g77343;
				#endif
				half2 vertexToFrag11_g77363 = i.ase_texcoord3.xy;
				half4 MainTex_RGBA53_g77360 = tex2D( _ElementMaskTex, vertexToFrag11_g77363 );
				half lerpResult148_g77360 = lerp( (MainTex_RGBA53_g77360).r , (MainTex_RGBA53_g77360).a , _ElementMaskMode);
				half clampResult17_g77369 = clamp( lerpResult148_g77360 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77370 = _ElementMaskRemap.x;
				half temp_output_9_0_g77370 = ( clampResult17_g77369 - temp_output_7_0_g77370 );
				half lerpResult73_g77360 = lerp( 1.0 , saturate( ( temp_output_9_0_g77370 * _ElementMaskRemap.z ) ) , _ElementMaskValue);
				half Blend_Mask45_g77360 = lerpResult73_g77360;
				#ifdef TVE_ELEMENT_MASK
				half staticSwitch159_g77360 = Blend_Mask45_g77360;
				#else
				half staticSwitch159_g77360 = 1.0;
				#endif
				half3 ase_normalWS = i.ase_texcoord4.xyz;
				half4 appendResult108_g77360 = (half4(_TerrainPosition.x , _TerrainPosition.z , _TerrainSize.x , _TerrainSize.z));
				half4 Terrain_Coords111_g77360 = appendResult108_g77360;
				half4 temp_output_35_0_g77368 = Terrain_Coords111_g77360;
				float2 InputScale48_g77368 = (temp_output_35_0_g77368).zw;
				half2 FinalScale53_g77368 = ( 1.0 / InputScale48_g77368 );
				float2 InputPosition52_g77368 = (temp_output_35_0_g77368).xy;
				half2 FinalPosition58_g77368 = -( FinalScale53_g77368 * InputPosition52_g77368 );
				half2 temp_output_65_0_g77368 = ( ( (WorldPosition).xz * FinalScale53_g77368 ) + FinalPosition58_g77368 );
				half Terrain_InputMode136_g77360 = _TerrainInputMode;
				half3 lerpResult141_g77360 = lerp( ase_normalWS , tex2D( _TerrainNormalTex, temp_output_65_0_g77368 ).rgb , Terrain_InputMode136_g77360);
				half3 Terrain_Normal107_g77360 = lerpResult141_g77360;
				half dotResult113_g77360 = dot( Terrain_Normal107_g77360 , half3( 0, 1, 0 ) );
				half clampResult17_g77365 = clamp( dotResult113_g77360 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77366 = _ElementProjRemap.x;
				half temp_output_9_0_g77366 = ( clampResult17_g77365 - temp_output_7_0_g77366 );
				half lerpResult123_g77360 = lerp( 1.0 , saturate( ( temp_output_9_0_g77366 * _ElementProjRemap.z ) ) , _ElementProjValue);
				half Blend_Proj117_g77360 = lerpResult123_g77360;
				#ifdef TVE_ELEMENT_PROJ
				half staticSwitch160_g77360 = Blend_Proj117_g77360;
				#else
				half staticSwitch160_g77360 = 1.0;
				#endif
				half4 temp_output_35_0_g77361 = Terrain_Coords111_g77360;
				float2 InputScale48_g77361 = (temp_output_35_0_g77361).zw;
				half2 FinalScale53_g77361 = ( 1.0 / InputScale48_g77361 );
				float2 InputPosition52_g77361 = (temp_output_35_0_g77361).xy;
				half2 FinalPosition58_g77361 = -( FinalScale53_g77361 * InputPosition52_g77361 );
				half2 temp_output_65_0_g77361 = ( ( (WorldPosition).xz * FinalScale53_g77361 ) + FinalPosition58_g77361 );
				half4 temp_output_70_0_g77361 = _TerrainHeightTex_TexelSize;
				float2 InputTexelSize68_g77361 = (temp_output_70_0_g77361).zw;
				half2 temp_cast_3 = (1.0).xx;
				float2 InputTexelRecip69_g77361 = (temp_output_70_0_g77361).xy;
				float4 Terrain_Height_Raw104_g77360 = tex2D( _TerrainHeightTex, ( ( ( temp_output_65_0_g77361 / ( 1.0 / ( InputTexelSize68_g77361 - temp_cast_3 ) ) ) + 0.5 ) * InputTexelRecip69_g77361 ) );
				half temp_output_90_0_g77360 = ( ( (Terrain_Height_Raw104_g77360).r + ( (Terrain_Height_Raw104_g77360).g * 256.0 ) ) / 257.0 );
				#ifdef SHADER_API_VULKAN
				half staticSwitch91_g77360 = temp_output_90_0_g77360;
				#else
				half staticSwitch91_g77360 = (Terrain_Height_Raw104_g77360).r;
				#endif
				#ifdef SHADER_API_GLES
				half staticSwitch92_g77360 = temp_output_90_0_g77360;
				#else
				half staticSwitch92_g77360 = staticSwitch91_g77360;
				#endif
				#ifdef SHADER_API_GLES3
				half staticSwitch93_g77360 = temp_output_90_0_g77360;
				#else
				half staticSwitch93_g77360 = staticSwitch92_g77360;
				#endif
				float Terrain_Height_Platform105_g77360 = staticSwitch93_g77360;
				half Terrain_SizeY109_g77360 = _TerrainSize.y;
				half Terrain_PosY110_g77360 = _TerrainPosition.y;
				half lerpResult137_g77360 = lerp( WorldPosition.y , ( ( Terrain_Height_Platform105_g77360 * Terrain_SizeY109_g77360 * 2.0 ) + Terrain_PosY110_g77360 ) , Terrain_InputMode136_g77360);
				float Terrain_Height106_g77360 = lerpResult137_g77360;
				half temp_output_7_0_g77367 = _ElementPosMaxValue;
				half temp_output_9_0_g77367 = ( Terrain_Height106_g77360 - temp_output_7_0_g77367 );
				half lerpResult129_g77360 = lerp( 1.0 , saturate( ( temp_output_9_0_g77367 / ( ( _ElementPosMinValue - temp_output_7_0_g77367 ) + 0.0001 ) ) ) , _ElementPosValue);
				half Blend_Pos131_g77360 = lerpResult129_g77360;
				#ifdef TVE_ELEMENT_POS
				half staticSwitch161_g77360 = Blend_Pos131_g77360;
				#else
				half staticSwitch161_g77360 = 1.0;
				#endif
				half temp_output_6_0_g77371 = ( staticSwitch159_g77360 * staticSwitch160_g77360 * staticSwitch161_g77360 );
				half Dummy144_g77360 = ( _MaskingCategory + _MaskingEnd + ( _MaskingTerrainInfo + _MaskingModelInfo ) );
				half temp_output_7_0_g77371 = Dummy144_g77360;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77371 = ( temp_output_6_0_g77371 + temp_output_7_0_g77371 );
				#else
				half staticSwitch14_g77371 = temp_output_6_0_g77371;
				#endif
				half temp_output_145_0_g77360 = staticSwitch14_g77371;
				half temp_output_6_0_g77348 = 1.0;
				half temp_output_7_0_g77348 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				half staticSwitch14_g77348 = ( temp_output_6_0_g77348 + temp_output_7_0_g77348 );
				#else
				half staticSwitch14_g77348 = temp_output_6_0_g77348;
				#endif
				half Element_Alpha56_g77339 = ( Element_Intensity2580_g77339 * Element_Remap_A74_g77339 * Element_Params_A1737_g77339 * i.ase_color.a * Element_Falloff1883_g77339 * staticSwitch14_g77343 * temp_output_145_0_g77360 * staticSwitch14_g77348 );
				half Final_Colors_A144_g77339 = ( (lerpResult30_g77339).a * Element_Alpha56_g77339 );
				half4 appendResult470_g77339 = (half4(Final_Colors_RGB142_g77339 , Final_Colors_A144_g77339));
				
				
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
				half3 ase_normal : NORMAL;
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
			uniform half _SpeedTresholdValue;
			uniform half _render_colormask;
			uniform half _ElementMessage;
			uniform half4 _MainColor;
			uniform half4 TVE_SeasonOption;
			uniform half4 _AdditionalColor1;
			uniform half4 _AdditionalColor2;
			uniform half TVE_SeasonLerp;
			uniform half4 _SeasonRemap;
			uniform half4 _AdditionalColor3;
			uniform half4 _AdditionalColor4;
			uniform half _ElementMode;
			uniform sampler2D _MainTex;
			uniform half _ElementUVsMode;
			uniform half4 _MainUVs;
			uniform half _SpaceTexture;
			uniform half4 _MainTexColorRemap;
			uniform half _ElementIntensity;
			uniform half4 _MainTexAlphaRemap;
			uniform half4 _MainTexFalloffRemap;
			uniform half4 TVE_RenderBasePositionR;
			uniform half _ElementVolumeFadeValue;
			uniform half _ElementVolumeFadeMode;
			uniform half _BoundsCategory;
			uniform half _BoundsEnd;
			uniform sampler2D _ElementMaskTex;
			uniform half _ElementMaskCoordMode;
			uniform half4 _ElementMaskCoordValue;
			uniform half _ElementMaskMode;
			uniform half4 _ElementMaskRemap;
			uniform half _ElementMaskValue;
			uniform sampler2D _TerrainNormalTex;
			uniform half3 _TerrainPosition;
			uniform half3 _TerrainSize;
			uniform half _TerrainInputMode;
			uniform half4 _ElementProjRemap;
			uniform half _ElementProjValue;
			uniform sampler2D _TerrainHeightTex;
			float4 _TerrainHeightTex_TexelSize;
			uniform half _ElementPosMaxValue;
			uniform half _ElementPosMinValue;
			uniform half _ElementPosValue;
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
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsPaintTinting)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr BOXOPHOBICTheVisualEngineElementsPaintTinting
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsPaintTinting)

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				half TVE_SeasonOptions_X50_g77339 = TVE_SeasonOption.x;
				half4 Color_Winter_RGBA58_g77339 = _AdditionalColor1;
				half4 Color_Spring_RGBA59_g77339 = _AdditionalColor2;
				half temp_output_7_0_g77350 = _SeasonRemap.x;
				half temp_output_9_0_g77350 = ( TVE_SeasonLerp - temp_output_7_0_g77350 );
				half smoothstepResult2286_g77339 = smoothstep( 0.0 , 1.0 , saturate( ( temp_output_9_0_g77350 * _SeasonRemap.z ) ));
				half SeasonLerp54_g77339 = smoothstepResult2286_g77339;
				half4 lerpResult13_g77339 = lerp( Color_Winter_RGBA58_g77339 , Color_Spring_RGBA59_g77339 , SeasonLerp54_g77339);
				half TVE_SeasonOptions_Y51_g77339 = TVE_SeasonOption.y;
				half4 Color_Summer_RGBA60_g77339 = _AdditionalColor3;
				half4 lerpResult14_g77339 = lerp( Color_Spring_RGBA59_g77339 , Color_Summer_RGBA60_g77339 , SeasonLerp54_g77339);
				half TVE_SeasonOptions_Z52_g77339 = TVE_SeasonOption.z;
				half4 Color_Autumn_RGBA61_g77339 = _AdditionalColor4;
				half4 lerpResult15_g77339 = lerp( Color_Summer_RGBA60_g77339 , Color_Autumn_RGBA61_g77339 , SeasonLerp54_g77339);
				half TVE_SeasonOptions_W53_g77339 = TVE_SeasonOption.w;
				half4 lerpResult12_g77339 = lerp( Color_Autumn_RGBA61_g77339 , Color_Winter_RGBA58_g77339 , SeasonLerp54_g77339);
				half4 temp_output_25_0_g77339 = ( ( TVE_SeasonOptions_X50_g77339 * lerpResult13_g77339 ) + ( TVE_SeasonOptions_Y51_g77339 * lerpResult14_g77339 ) + ( TVE_SeasonOptions_Z52_g77339 * lerpResult15_g77339 ) + ( TVE_SeasonOptions_W53_g77339 * lerpResult12_g77339 ) );
				half4 vertexToFrag11_g77346 = temp_output_25_0_g77339;
				o.ase_texcoord1 = vertexToFrag11_g77346;
				float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
				half2 appendResult1900_g77339 = (half2(ase_positionWS.x , ase_positionWS.z));
				half2 lerpResult1899_g77339 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult1900_g77339 , _ElementUVsMode);
				half2 vertexToFrag11_g77353 = ( ( lerpResult1899_g77339 * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord2.xy = vertexToFrag11_g77353;
				half2 appendResult60_g77360 = (half2(ase_positionWS.x , ase_positionWS.z));
				half2 lerpResult58_g77360 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult60_g77360 , _ElementMaskCoordMode);
				half2 vertexToFrag11_g77363 = ( ( lerpResult58_g77360 * (_ElementMaskCoordValue).xy ) + (_ElementMaskCoordValue).zw );
				o.ase_texcoord3.xy = vertexToFrag11_g77363;
				half3 ase_normalWS = UnityObjectToWorldNormal( v.ase_normal );
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
				half4 vertexToFrag11_g77346 = i.ase_texcoord1;
				half4 Color_Seasons1715_g77339 = vertexToFrag11_g77346;
				half Element_Mode55_g77339 = _ElementMode;
				half4 lerpResult30_g77339 = lerp( Color_Main_RGBA49_g77339 , Color_Seasons1715_g77339 , Element_Mode55_g77339);
				half2 vertexToFrag11_g77353 = i.ase_texcoord2.xy;
				half4 MainTex_RGBA587_g77339 = tex2D( _MainTex, vertexToFrag11_g77353 );
				half3 temp_output_6_0_g77356 = (MainTex_RGBA587_g77339).rgb;
				half SpaceTexture2395_g77339 = _SpaceTexture;
				half temp_output_7_0_g77356 = SpaceTexture2395_g77339;
				#ifdef TVE_DUMMY
				half3 staticSwitch14_g77356 = ( temp_output_6_0_g77356 + temp_output_7_0_g77356 );
				#else
				half3 staticSwitch14_g77356 = temp_output_6_0_g77356;
				#endif
				half3 temp_cast_0 = (0.0001).xxx;
				half3 temp_cast_1 = (0.9999).xxx;
				half3 clampResult17_g77351 = clamp( staticSwitch14_g77356 , temp_cast_0 , temp_cast_1 );
				half temp_output_7_0_g77354 = _MainTexColorRemap.x;
				half3 temp_cast_2 = (temp_output_7_0_g77354).xxx;
				half3 temp_output_9_0_g77354 = ( clampResult17_g77351 - temp_cast_2 );
				half3 temp_output_1765_0_g77339 = saturate( ( temp_output_9_0_g77354 * _MainTexColorRemap.z ) );
				half3 Element_Remap_RGB1555_g77339 = temp_output_1765_0_g77339;
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half3 Element_Params_RGB1735_g77339 = (_ElementParams_Instance).xyz;
				half3 Element_Color1756_g77339 = ( Element_Remap_RGB1555_g77339 * Element_Params_RGB1735_g77339 * (i.ase_color).rgb );
				half3 Final_Colors_RGB142_g77339 = ( (lerpResult30_g77339).rgb * Element_Color1756_g77339 );
				half Element_Intensity2580_g77339 = _ElementIntensity;
				half temp_output_6_0_g77357 = (MainTex_RGBA587_g77339).a;
				half temp_output_7_0_g77357 = SpaceTexture2395_g77339;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77357 = ( temp_output_6_0_g77357 + temp_output_7_0_g77357 );
				#else
				half staticSwitch14_g77357 = temp_output_6_0_g77357;
				#endif
				half clampResult17_g77352 = clamp( staticSwitch14_g77357 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77355 = _MainTexAlphaRemap.x;
				half temp_output_9_0_g77355 = ( clampResult17_g77352 - temp_output_7_0_g77355 );
				half Element_Remap_A74_g77339 = saturate( ( temp_output_9_0_g77355 * _MainTexAlphaRemap.z ) );
				half Element_Params_A1737_g77339 = _ElementParams_Instance.w;
				half temp_output_6_0_g77359 = saturate( ( 1.0 - distance( (i.ase_texcoord2.zw*2.0 + -1.0) , float2( 0,0 ) ) ) );
				half temp_output_7_0_g77359 = SpaceTexture2395_g77339;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77359 = ( temp_output_6_0_g77359 + temp_output_7_0_g77359 );
				#else
				half staticSwitch14_g77359 = temp_output_6_0_g77359;
				#endif
				half clampResult17_g77358 = clamp( staticSwitch14_g77359 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77349 = _MainTexFalloffRemap.x;
				half temp_output_9_0_g77349 = ( clampResult17_g77358 - temp_output_7_0_g77349 );
				half Element_Falloff1883_g77339 = saturate( ( temp_output_9_0_g77349 * _MainTexFalloffRemap.z ) );
				half temp_output_7_0_g77342 = 1.0;
				half temp_output_9_0_g77342 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g77342 );
				half lerpResult18_g77340 = lerp( 1.0 , saturate( ( temp_output_9_0_g77342 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g77342 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g77340 = lerpResult18_g77340;
				half temp_output_6_0_g77343 = Blend_Edge69_g77340;
				half Dummy72_g77340 = ( _BoundsCategory + _BoundsEnd );
				half temp_output_7_0_g77343 = Dummy72_g77340;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77343 = ( temp_output_6_0_g77343 + temp_output_7_0_g77343 );
				#else
				half staticSwitch14_g77343 = temp_output_6_0_g77343;
				#endif
				half2 vertexToFrag11_g77363 = i.ase_texcoord3.xy;
				half4 MainTex_RGBA53_g77360 = tex2D( _ElementMaskTex, vertexToFrag11_g77363 );
				half lerpResult148_g77360 = lerp( (MainTex_RGBA53_g77360).r , (MainTex_RGBA53_g77360).a , _ElementMaskMode);
				half clampResult17_g77369 = clamp( lerpResult148_g77360 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77370 = _ElementMaskRemap.x;
				half temp_output_9_0_g77370 = ( clampResult17_g77369 - temp_output_7_0_g77370 );
				half lerpResult73_g77360 = lerp( 1.0 , saturate( ( temp_output_9_0_g77370 * _ElementMaskRemap.z ) ) , _ElementMaskValue);
				half Blend_Mask45_g77360 = lerpResult73_g77360;
				#ifdef TVE_ELEMENT_MASK
				half staticSwitch159_g77360 = Blend_Mask45_g77360;
				#else
				half staticSwitch159_g77360 = 1.0;
				#endif
				half3 ase_normalWS = i.ase_texcoord4.xyz;
				half4 appendResult108_g77360 = (half4(_TerrainPosition.x , _TerrainPosition.z , _TerrainSize.x , _TerrainSize.z));
				half4 Terrain_Coords111_g77360 = appendResult108_g77360;
				half4 temp_output_35_0_g77368 = Terrain_Coords111_g77360;
				float2 InputScale48_g77368 = (temp_output_35_0_g77368).zw;
				half2 FinalScale53_g77368 = ( 1.0 / InputScale48_g77368 );
				float2 InputPosition52_g77368 = (temp_output_35_0_g77368).xy;
				half2 FinalPosition58_g77368 = -( FinalScale53_g77368 * InputPosition52_g77368 );
				half2 temp_output_65_0_g77368 = ( ( (WorldPosition).xz * FinalScale53_g77368 ) + FinalPosition58_g77368 );
				half Terrain_InputMode136_g77360 = _TerrainInputMode;
				half3 lerpResult141_g77360 = lerp( ase_normalWS , tex2D( _TerrainNormalTex, temp_output_65_0_g77368 ).rgb , Terrain_InputMode136_g77360);
				half3 Terrain_Normal107_g77360 = lerpResult141_g77360;
				half dotResult113_g77360 = dot( Terrain_Normal107_g77360 , half3( 0, 1, 0 ) );
				half clampResult17_g77365 = clamp( dotResult113_g77360 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77366 = _ElementProjRemap.x;
				half temp_output_9_0_g77366 = ( clampResult17_g77365 - temp_output_7_0_g77366 );
				half lerpResult123_g77360 = lerp( 1.0 , saturate( ( temp_output_9_0_g77366 * _ElementProjRemap.z ) ) , _ElementProjValue);
				half Blend_Proj117_g77360 = lerpResult123_g77360;
				#ifdef TVE_ELEMENT_PROJ
				half staticSwitch160_g77360 = Blend_Proj117_g77360;
				#else
				half staticSwitch160_g77360 = 1.0;
				#endif
				half4 temp_output_35_0_g77361 = Terrain_Coords111_g77360;
				float2 InputScale48_g77361 = (temp_output_35_0_g77361).zw;
				half2 FinalScale53_g77361 = ( 1.0 / InputScale48_g77361 );
				float2 InputPosition52_g77361 = (temp_output_35_0_g77361).xy;
				half2 FinalPosition58_g77361 = -( FinalScale53_g77361 * InputPosition52_g77361 );
				half2 temp_output_65_0_g77361 = ( ( (WorldPosition).xz * FinalScale53_g77361 ) + FinalPosition58_g77361 );
				half4 temp_output_70_0_g77361 = _TerrainHeightTex_TexelSize;
				float2 InputTexelSize68_g77361 = (temp_output_70_0_g77361).zw;
				half2 temp_cast_3 = (1.0).xx;
				float2 InputTexelRecip69_g77361 = (temp_output_70_0_g77361).xy;
				float4 Terrain_Height_Raw104_g77360 = tex2D( _TerrainHeightTex, ( ( ( temp_output_65_0_g77361 / ( 1.0 / ( InputTexelSize68_g77361 - temp_cast_3 ) ) ) + 0.5 ) * InputTexelRecip69_g77361 ) );
				half temp_output_90_0_g77360 = ( ( (Terrain_Height_Raw104_g77360).r + ( (Terrain_Height_Raw104_g77360).g * 256.0 ) ) / 257.0 );
				#ifdef SHADER_API_VULKAN
				half staticSwitch91_g77360 = temp_output_90_0_g77360;
				#else
				half staticSwitch91_g77360 = (Terrain_Height_Raw104_g77360).r;
				#endif
				#ifdef SHADER_API_GLES
				half staticSwitch92_g77360 = temp_output_90_0_g77360;
				#else
				half staticSwitch92_g77360 = staticSwitch91_g77360;
				#endif
				#ifdef SHADER_API_GLES3
				half staticSwitch93_g77360 = temp_output_90_0_g77360;
				#else
				half staticSwitch93_g77360 = staticSwitch92_g77360;
				#endif
				float Terrain_Height_Platform105_g77360 = staticSwitch93_g77360;
				half Terrain_SizeY109_g77360 = _TerrainSize.y;
				half Terrain_PosY110_g77360 = _TerrainPosition.y;
				half lerpResult137_g77360 = lerp( WorldPosition.y , ( ( Terrain_Height_Platform105_g77360 * Terrain_SizeY109_g77360 * 2.0 ) + Terrain_PosY110_g77360 ) , Terrain_InputMode136_g77360);
				float Terrain_Height106_g77360 = lerpResult137_g77360;
				half temp_output_7_0_g77367 = _ElementPosMaxValue;
				half temp_output_9_0_g77367 = ( Terrain_Height106_g77360 - temp_output_7_0_g77367 );
				half lerpResult129_g77360 = lerp( 1.0 , saturate( ( temp_output_9_0_g77367 / ( ( _ElementPosMinValue - temp_output_7_0_g77367 ) + 0.0001 ) ) ) , _ElementPosValue);
				half Blend_Pos131_g77360 = lerpResult129_g77360;
				#ifdef TVE_ELEMENT_POS
				half staticSwitch161_g77360 = Blend_Pos131_g77360;
				#else
				half staticSwitch161_g77360 = 1.0;
				#endif
				half temp_output_6_0_g77371 = ( staticSwitch159_g77360 * staticSwitch160_g77360 * staticSwitch161_g77360 );
				half Dummy144_g77360 = ( _MaskingCategory + _MaskingEnd + ( _MaskingTerrainInfo + _MaskingModelInfo ) );
				half temp_output_7_0_g77371 = Dummy144_g77360;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77371 = ( temp_output_6_0_g77371 + temp_output_7_0_g77371 );
				#else
				half staticSwitch14_g77371 = temp_output_6_0_g77371;
				#endif
				half temp_output_145_0_g77360 = staticSwitch14_g77371;
				half temp_output_6_0_g77348 = 1.0;
				half temp_output_7_0_g77348 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				half staticSwitch14_g77348 = ( temp_output_6_0_g77348 + temp_output_7_0_g77348 );
				#else
				half staticSwitch14_g77348 = temp_output_6_0_g77348;
				#endif
				half Element_Alpha56_g77339 = ( Element_Intensity2580_g77339 * Element_Remap_A74_g77339 * Element_Params_A1737_g77339 * i.ase_color.a * Element_Falloff1883_g77339 * staticSwitch14_g77343 * temp_output_145_0_g77360 * staticSwitch14_g77348 );
				half Final_Colors_A144_g77339 = ( (lerpResult30_g77339).a * Element_Alpha56_g77339 );
				half4 appendResult2464_g77339 = (half4(Final_Colors_RGB142_g77339 , Final_Colors_A144_g77339));
				half4 Input_Visual94_g77386 = appendResult2464_g77339;
				half3 Element_Color47_g77386 = saturate( (Input_Visual94_g77386).xyz );
				half4 appendResult131_g77386 = (half4(Element_Color47_g77386 , (Input_Visual94_g77386).w));
				
				
				finalColor = appendResult131_g77386;
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
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":402,"pos":[-640,-384],"params":["Inherit","False","Element Type Paint","1","","25569","5810d2854679b554b88f8bb18ff3bfa0","0","0","1","FLOAT","4"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":425,"pos":[-384,-384],"params":["Inherit","False","Element Shader","11","","77339","0e972c73cae2ee54ea51acc9738801d0","15,1778,0,477,0,478,0,1824,0,1814,0,145,0,1784,0,481,0,2614,0,2618,0,1904,1,1907,1,2377,1,2310,1,2311,1","2","1974","FLOAT","0","False","2378","FLOAT","1","False","2","FLOAT4","0","FLOAT4","1779"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":178,"pos":[-640,-640],"params":["Half","False","Property","_render_colormask","_render_colormask","107","1","[HideInInspector]","Create","True","0","0","0","True","0","False","Object","-1","","15","15","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":422,"pos":[-128,-256],"params":["Inherit","False","Element Visuals","-1","","77386","78cf0f00cfd72824e84597f2db54a76e","1,64,0","2","59","FLOAT4","0,0,0,0","False","77","FLOAT3","1,1,1","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":248,"pos":[64,-768],"params":["Inherit","False","Element Compile","-1","","77387","5302407fc6d65554791e558e67d59358","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":100,"pos":[-640,-768],"params":["Half","False","Property","_ElementMessage","Element Message","0","0","Create","True","0","0","0","True","1","StyledMessage(Info, Use Tinting elements to add color tinting to the vegetation assets. Element Texture RGB and Particle Color RGB are used as value multipliers. Element Texture A and Particle Color A are used as alpha masks., 0, 15)","False","Object","-1","","0","0","1","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":409,"pos":[-64,-258],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass1","0","1","VolumePass1","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass1","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":410,"pos":[-64,-137],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass2","0","2","VolumePass2","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass2","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":272,"pos":[64,-384],"params":["Half","False","True","-1","2","TheVisualEngine.ElementGUI","100","2","BOXOPHOBIC/The Visual Engine/Elements/Paint Tinting","f4f273c3bb6262d4396be458405e60f9","True","VolumePass","0","0","VolumePass","2","True","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","False","False","False","False","True","3","RenderType=Transparent=RenderType","Queue=Transparent=Queue=0","DisableBatching=True=DisableBatching","False","False","0","True","True","2","5","False","","10","False","","2","5","False","","10","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","True","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass","True","2","False","0","","0","0","Standard","3","VolumePass1","0","0","VolumePass2","0","0","Vertex Position","1","0","0","4","True","False","False","True","False","","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":273,"pos":[64,-256],"params":["Float","False","False","-1","2","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VisualPass","0","3","VisualPass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","True","True","2","5","False","","10","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","False","True","2","False","0","","0","0","Standard","0","False","0"]}
{"wire":[425,1974,402,4]}
{"wire":[422,59,425,1779]}
{"wire":[272,0,425,0]}
{"wire":[273,0,422,0]}
ASEEND*/
//CHKSM=9C374EB393F205E93E3E77AECC862A49CA6ACEAB