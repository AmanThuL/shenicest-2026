// Upgrade NOTE: upgraded instancing buffer 'BOXOPHOBICTheVisualEngineElementsCoatStack' to new syntax.

// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Elements/Coat Stack"
{
	Properties
	{
		[StyledMessage(Info, Use Stack elements to control the Stack feature intensity. Element Texture A and Particle Color A are used as alpha masks., 0, 15)] _ElementMessage( "Element Message", Float ) = 0
		[HideInInspector] _IsVersion( "_IsVersion", Float ) = 2200
		[HideInInspector] _IsElementShader( "_IsElementShader", Float ) = 1
		[HideInInspector] _IsIdentifier( "_IsIdentifier", Float ) = 0
		[StyledCategory(Render Settings, true, 0, 10)] _RenderCategory( "[ Render Category ]", Float ) = 1
		_ElementIntensity( "Render Intensity", Range( 0, 1 ) ) = 1
		[StyledMessage(Info, When using a higher Layer number the Global Volume will create more render textures to render the elements. Try using fewer layers when possible., _ElementLayerMessage, 1, 10, 10)] _ElementLayerMessage( "Render Layer Message", Float ) = 0
		[StyledMessage(Warning, When using all layers the Global Volume will create one render texture for each layer to render the elements. Try using fewer layers when possible., _ElementLayerWarning, 1, 10, 10)] _ElementLayerWarning( "Render Layer Warning", Float ) = 0
		[StyledMask(Coat Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _ElementLayerMask( "Render Layer", Float ) = 1
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
			ColorMask B
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
				float4 ase_color : COLOR;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
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
			uniform half _MainValue;
			uniform half4 TVE_SeasonOption;
			uniform half _AdditionalValue1;
			uniform half _AdditionalValue2;
			uniform half TVE_SeasonLerp;
			uniform half4 _SeasonRemap;
			uniform half _AdditionalValue3;
			uniform half _AdditionalValue4;
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
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsCoatStack)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr BOXOPHOBICTheVisualEngineElementsCoatStack
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsCoatStack)

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				half TVE_SeasonOptions_X50_g77224 = TVE_SeasonOption.x;
				half Value_Winter158_g77224 = _AdditionalValue1;
				half Value_Spring159_g77224 = _AdditionalValue2;
				half temp_output_7_0_g77235 = _SeasonRemap.x;
				half temp_output_9_0_g77235 = ( TVE_SeasonLerp - temp_output_7_0_g77235 );
				half smoothstepResult2286_g77224 = smoothstep( 0.0 , 1.0 , saturate( ( temp_output_9_0_g77235 * _SeasonRemap.z ) ));
				half SeasonLerp54_g77224 = smoothstepResult2286_g77224;
				half lerpResult168_g77224 = lerp( Value_Winter158_g77224 , Value_Spring159_g77224 , SeasonLerp54_g77224);
				half TVE_SeasonOptions_Y51_g77224 = TVE_SeasonOption.y;
				half Value_Summer160_g77224 = _AdditionalValue3;
				half lerpResult167_g77224 = lerp( Value_Spring159_g77224 , Value_Summer160_g77224 , SeasonLerp54_g77224);
				half TVE_SeasonOptions_Z52_g77224 = TVE_SeasonOption.z;
				half Value_Autumn161_g77224 = _AdditionalValue4;
				half lerpResult166_g77224 = lerp( Value_Summer160_g77224 , Value_Autumn161_g77224 , SeasonLerp54_g77224);
				half TVE_SeasonOptions_W53_g77224 = TVE_SeasonOption.w;
				half lerpResult165_g77224 = lerp( Value_Autumn161_g77224 , Value_Winter158_g77224 , SeasonLerp54_g77224);
				half temp_output_175_0_g77224 = ( ( TVE_SeasonOptions_X50_g77224 * lerpResult168_g77224 ) + ( TVE_SeasonOptions_Y51_g77224 * lerpResult167_g77224 ) + ( TVE_SeasonOptions_Z52_g77224 * lerpResult166_g77224 ) + ( TVE_SeasonOptions_W53_g77224 * lerpResult165_g77224 ) );
				half vertexToFrag11_g77229 = temp_output_175_0_g77224;
				o.ase_texcoord1.x = vertexToFrag11_g77229;
				float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
				half2 appendResult1900_g77224 = (half2(ase_positionWS.x , ase_positionWS.z));
				half2 lerpResult1899_g77224 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult1900_g77224 , _ElementUVsMode);
				half2 vertexToFrag11_g77238 = ( ( lerpResult1899_g77224 * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord1.yz = vertexToFrag11_g77238;
				half2 appendResult60_g77245 = (half2(ase_positionWS.x , ase_positionWS.z));
				half2 lerpResult58_g77245 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult60_g77245 , _ElementMaskCoordMode);
				half2 vertexToFrag11_g77248 = ( ( lerpResult58_g77245 * (_ElementMaskCoordValue).xy ) + (_ElementMaskCoordValue).zw );
				o.ase_texcoord2.zw = vertexToFrag11_g77248;
				half3 ase_normalWS = UnityObjectToWorldNormal( v.ase_normal );
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
				half Value_Main157_g77224 = _MainValue;
				half vertexToFrag11_g77229 = i.ase_texcoord1.x;
				half Value_Seasons1721_g77224 = vertexToFrag11_g77229;
				half Element_Mode55_g77224 = _ElementMode;
				half lerpResult181_g77224 = lerp( Value_Main157_g77224 , Value_Seasons1721_g77224 , Element_Mode55_g77224);
				half2 vertexToFrag11_g77238 = i.ase_texcoord1.yz;
				half4 MainTex_RGBA587_g77224 = tex2D( _MainTex, vertexToFrag11_g77238 );
				half3 temp_output_6_0_g77241 = (MainTex_RGBA587_g77224).rgb;
				half SpaceTexture2395_g77224 = _SpaceTexture;
				half temp_output_7_0_g77241 = SpaceTexture2395_g77224;
				#ifdef TVE_DUMMY
				half3 staticSwitch14_g77241 = ( temp_output_6_0_g77241 + temp_output_7_0_g77241 );
				#else
				half3 staticSwitch14_g77241 = temp_output_6_0_g77241;
				#endif
				half3 temp_cast_0 = (0.0001).xxx;
				half3 temp_cast_1 = (0.9999).xxx;
				half3 clampResult17_g77236 = clamp( staticSwitch14_g77241 , temp_cast_0 , temp_cast_1 );
				half temp_output_7_0_g77239 = _MainTexColorRemap.x;
				half3 temp_cast_2 = (temp_output_7_0_g77239).xxx;
				half3 temp_output_9_0_g77239 = ( clampResult17_g77236 - temp_cast_2 );
				half3 temp_output_1765_0_g77224 = saturate( ( temp_output_9_0_g77239 * _MainTexColorRemap.z ) );
				half Element_Remap_R73_g77224 = (temp_output_1765_0_g77224).x;
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half Element_Params_R1738_g77224 = _ElementParams_Instance.x;
				half Element_Value1744_g77224 = ( Element_Remap_R73_g77224 * Element_Params_R1738_g77224 * i.ase_color.r );
				half temp_output_468_0_g77224 = ( lerpResult181_g77224 * Element_Value1744_g77224 );
				half3 appendResult2402_g77224 = (half3(temp_output_468_0_g77224 , temp_output_468_0_g77224 , temp_output_468_0_g77224));
				half3 FInal_RGB213_g77224 = appendResult2402_g77224;
				half Element_Intensity2580_g77224 = _ElementIntensity;
				half temp_output_6_0_g77242 = (MainTex_RGBA587_g77224).a;
				half temp_output_7_0_g77242 = SpaceTexture2395_g77224;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77242 = ( temp_output_6_0_g77242 + temp_output_7_0_g77242 );
				#else
				half staticSwitch14_g77242 = temp_output_6_0_g77242;
				#endif
				half clampResult17_g77237 = clamp( staticSwitch14_g77242 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77240 = _MainTexAlphaRemap.x;
				half temp_output_9_0_g77240 = ( clampResult17_g77237 - temp_output_7_0_g77240 );
				half Element_Remap_A74_g77224 = saturate( ( temp_output_9_0_g77240 * _MainTexAlphaRemap.z ) );
				half Element_Params_A1737_g77224 = _ElementParams_Instance.w;
				half temp_output_6_0_g77244 = saturate( ( 1.0 - distance( (i.ase_texcoord2.xy*2.0 + -1.0) , float2( 0,0 ) ) ) );
				half temp_output_7_0_g77244 = SpaceTexture2395_g77224;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77244 = ( temp_output_6_0_g77244 + temp_output_7_0_g77244 );
				#else
				half staticSwitch14_g77244 = temp_output_6_0_g77244;
				#endif
				half clampResult17_g77243 = clamp( staticSwitch14_g77244 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77234 = _MainTexFalloffRemap.x;
				half temp_output_9_0_g77234 = ( clampResult17_g77243 - temp_output_7_0_g77234 );
				half Element_Falloff1883_g77224 = saturate( ( temp_output_9_0_g77234 * _MainTexFalloffRemap.z ) );
				half temp_output_7_0_g77227 = 1.0;
				half temp_output_9_0_g77227 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g77227 );
				half lerpResult18_g77225 = lerp( 1.0 , saturate( ( temp_output_9_0_g77227 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g77227 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g77225 = lerpResult18_g77225;
				half temp_output_6_0_g77228 = Blend_Edge69_g77225;
				half Dummy72_g77225 = ( _BoundsCategory + _BoundsEnd );
				half temp_output_7_0_g77228 = Dummy72_g77225;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77228 = ( temp_output_6_0_g77228 + temp_output_7_0_g77228 );
				#else
				half staticSwitch14_g77228 = temp_output_6_0_g77228;
				#endif
				half2 vertexToFrag11_g77248 = i.ase_texcoord2.zw;
				half4 MainTex_RGBA53_g77245 = tex2D( _ElementMaskTex, vertexToFrag11_g77248 );
				half lerpResult148_g77245 = lerp( (MainTex_RGBA53_g77245).r , (MainTex_RGBA53_g77245).a , _ElementMaskMode);
				half clampResult17_g77254 = clamp( lerpResult148_g77245 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77255 = _ElementMaskRemap.x;
				half temp_output_9_0_g77255 = ( clampResult17_g77254 - temp_output_7_0_g77255 );
				half lerpResult73_g77245 = lerp( 1.0 , saturate( ( temp_output_9_0_g77255 * _ElementMaskRemap.z ) ) , _ElementMaskValue);
				half Blend_Mask45_g77245 = lerpResult73_g77245;
				#ifdef TVE_ELEMENT_MASK
				half staticSwitch159_g77245 = Blend_Mask45_g77245;
				#else
				half staticSwitch159_g77245 = 1.0;
				#endif
				half3 ase_normalWS = i.ase_texcoord3.xyz;
				half4 appendResult108_g77245 = (half4(_TerrainPosition.x , _TerrainPosition.z , _TerrainSize.x , _TerrainSize.z));
				half4 Terrain_Coords111_g77245 = appendResult108_g77245;
				half4 temp_output_35_0_g77253 = Terrain_Coords111_g77245;
				float2 InputScale48_g77253 = (temp_output_35_0_g77253).zw;
				half2 FinalScale53_g77253 = ( 1.0 / InputScale48_g77253 );
				float2 InputPosition52_g77253 = (temp_output_35_0_g77253).xy;
				half2 FinalPosition58_g77253 = -( FinalScale53_g77253 * InputPosition52_g77253 );
				half2 temp_output_65_0_g77253 = ( ( (WorldPosition).xz * FinalScale53_g77253 ) + FinalPosition58_g77253 );
				half Terrain_InputMode136_g77245 = _TerrainInputMode;
				half3 lerpResult141_g77245 = lerp( ase_normalWS , tex2D( _TerrainNormalTex, temp_output_65_0_g77253 ).rgb , Terrain_InputMode136_g77245);
				half3 Terrain_Normal107_g77245 = lerpResult141_g77245;
				half dotResult113_g77245 = dot( Terrain_Normal107_g77245 , half3( 0, 1, 0 ) );
				half clampResult17_g77250 = clamp( dotResult113_g77245 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77251 = _ElementProjRemap.x;
				half temp_output_9_0_g77251 = ( clampResult17_g77250 - temp_output_7_0_g77251 );
				half lerpResult123_g77245 = lerp( 1.0 , saturate( ( temp_output_9_0_g77251 * _ElementProjRemap.z ) ) , _ElementProjValue);
				half Blend_Proj117_g77245 = lerpResult123_g77245;
				#ifdef TVE_ELEMENT_PROJ
				half staticSwitch160_g77245 = Blend_Proj117_g77245;
				#else
				half staticSwitch160_g77245 = 1.0;
				#endif
				half4 temp_output_35_0_g77246 = Terrain_Coords111_g77245;
				float2 InputScale48_g77246 = (temp_output_35_0_g77246).zw;
				half2 FinalScale53_g77246 = ( 1.0 / InputScale48_g77246 );
				float2 InputPosition52_g77246 = (temp_output_35_0_g77246).xy;
				half2 FinalPosition58_g77246 = -( FinalScale53_g77246 * InputPosition52_g77246 );
				half2 temp_output_65_0_g77246 = ( ( (WorldPosition).xz * FinalScale53_g77246 ) + FinalPosition58_g77246 );
				half4 temp_output_70_0_g77246 = _TerrainHeightTex_TexelSize;
				float2 InputTexelSize68_g77246 = (temp_output_70_0_g77246).zw;
				half2 temp_cast_3 = (1.0).xx;
				float2 InputTexelRecip69_g77246 = (temp_output_70_0_g77246).xy;
				float4 Terrain_Height_Raw104_g77245 = tex2D( _TerrainHeightTex, ( ( ( temp_output_65_0_g77246 / ( 1.0 / ( InputTexelSize68_g77246 - temp_cast_3 ) ) ) + 0.5 ) * InputTexelRecip69_g77246 ) );
				half temp_output_90_0_g77245 = ( ( (Terrain_Height_Raw104_g77245).r + ( (Terrain_Height_Raw104_g77245).g * 256.0 ) ) / 257.0 );
				#ifdef SHADER_API_VULKAN
				half staticSwitch91_g77245 = temp_output_90_0_g77245;
				#else
				half staticSwitch91_g77245 = (Terrain_Height_Raw104_g77245).r;
				#endif
				#ifdef SHADER_API_GLES
				half staticSwitch92_g77245 = temp_output_90_0_g77245;
				#else
				half staticSwitch92_g77245 = staticSwitch91_g77245;
				#endif
				#ifdef SHADER_API_GLES3
				half staticSwitch93_g77245 = temp_output_90_0_g77245;
				#else
				half staticSwitch93_g77245 = staticSwitch92_g77245;
				#endif
				float Terrain_Height_Platform105_g77245 = staticSwitch93_g77245;
				half Terrain_SizeY109_g77245 = _TerrainSize.y;
				half Terrain_PosY110_g77245 = _TerrainPosition.y;
				half lerpResult137_g77245 = lerp( WorldPosition.y , ( ( Terrain_Height_Platform105_g77245 * Terrain_SizeY109_g77245 * 2.0 ) + Terrain_PosY110_g77245 ) , Terrain_InputMode136_g77245);
				float Terrain_Height106_g77245 = lerpResult137_g77245;
				half temp_output_7_0_g77252 = _ElementPosMaxValue;
				half temp_output_9_0_g77252 = ( Terrain_Height106_g77245 - temp_output_7_0_g77252 );
				half lerpResult129_g77245 = lerp( 1.0 , saturate( ( temp_output_9_0_g77252 / ( ( _ElementPosMinValue - temp_output_7_0_g77252 ) + 0.0001 ) ) ) , _ElementPosValue);
				half Blend_Pos131_g77245 = lerpResult129_g77245;
				#ifdef TVE_ELEMENT_POS
				half staticSwitch161_g77245 = Blend_Pos131_g77245;
				#else
				half staticSwitch161_g77245 = 1.0;
				#endif
				half temp_output_6_0_g77256 = ( staticSwitch159_g77245 * staticSwitch160_g77245 * staticSwitch161_g77245 );
				half Dummy144_g77245 = ( _MaskingCategory + _MaskingEnd + ( _MaskingTerrainInfo + _MaskingModelInfo ) );
				half temp_output_7_0_g77256 = Dummy144_g77245;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77256 = ( temp_output_6_0_g77256 + temp_output_7_0_g77256 );
				#else
				half staticSwitch14_g77256 = temp_output_6_0_g77256;
				#endif
				half temp_output_145_0_g77245 = staticSwitch14_g77256;
				half temp_output_6_0_g77233 = 1.0;
				half temp_output_7_0_g77233 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				half staticSwitch14_g77233 = ( temp_output_6_0_g77233 + temp_output_7_0_g77233 );
				#else
				half staticSwitch14_g77233 = temp_output_6_0_g77233;
				#endif
				half Element_Alpha56_g77224 = ( Element_Intensity2580_g77224 * Element_Remap_A74_g77224 * Element_Params_A1737_g77224 * i.ase_color.a * Element_Falloff1883_g77224 * staticSwitch14_g77228 * temp_output_145_0_g77245 * staticSwitch14_g77233 );
				half Final_A241_g77224 = Element_Alpha56_g77224;
				half4 appendResult882_g77224 = (half4(FInal_RGB213_g77224 , Final_A241_g77224));
				
				
				finalColor = appendResult882_g77224;
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
				float4 ase_color : COLOR;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
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
			uniform half _ElementMessage;
			uniform half _MainValue;
			uniform half4 TVE_SeasonOption;
			uniform half _AdditionalValue1;
			uniform half _AdditionalValue2;
			uniform half TVE_SeasonLerp;
			uniform half4 _SeasonRemap;
			uniform half _AdditionalValue3;
			uniform half _AdditionalValue4;
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
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsCoatStack)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr BOXOPHOBICTheVisualEngineElementsCoatStack
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsCoatStack)

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				half TVE_SeasonOptions_X50_g77224 = TVE_SeasonOption.x;
				half Value_Winter158_g77224 = _AdditionalValue1;
				half Value_Spring159_g77224 = _AdditionalValue2;
				half temp_output_7_0_g77235 = _SeasonRemap.x;
				half temp_output_9_0_g77235 = ( TVE_SeasonLerp - temp_output_7_0_g77235 );
				half smoothstepResult2286_g77224 = smoothstep( 0.0 , 1.0 , saturate( ( temp_output_9_0_g77235 * _SeasonRemap.z ) ));
				half SeasonLerp54_g77224 = smoothstepResult2286_g77224;
				half lerpResult168_g77224 = lerp( Value_Winter158_g77224 , Value_Spring159_g77224 , SeasonLerp54_g77224);
				half TVE_SeasonOptions_Y51_g77224 = TVE_SeasonOption.y;
				half Value_Summer160_g77224 = _AdditionalValue3;
				half lerpResult167_g77224 = lerp( Value_Spring159_g77224 , Value_Summer160_g77224 , SeasonLerp54_g77224);
				half TVE_SeasonOptions_Z52_g77224 = TVE_SeasonOption.z;
				half Value_Autumn161_g77224 = _AdditionalValue4;
				half lerpResult166_g77224 = lerp( Value_Summer160_g77224 , Value_Autumn161_g77224 , SeasonLerp54_g77224);
				half TVE_SeasonOptions_W53_g77224 = TVE_SeasonOption.w;
				half lerpResult165_g77224 = lerp( Value_Autumn161_g77224 , Value_Winter158_g77224 , SeasonLerp54_g77224);
				half temp_output_175_0_g77224 = ( ( TVE_SeasonOptions_X50_g77224 * lerpResult168_g77224 ) + ( TVE_SeasonOptions_Y51_g77224 * lerpResult167_g77224 ) + ( TVE_SeasonOptions_Z52_g77224 * lerpResult166_g77224 ) + ( TVE_SeasonOptions_W53_g77224 * lerpResult165_g77224 ) );
				half vertexToFrag11_g77229 = temp_output_175_0_g77224;
				o.ase_texcoord1.x = vertexToFrag11_g77229;
				float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
				half2 appendResult1900_g77224 = (half2(ase_positionWS.x , ase_positionWS.z));
				half2 lerpResult1899_g77224 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult1900_g77224 , _ElementUVsMode);
				half2 vertexToFrag11_g77238 = ( ( lerpResult1899_g77224 * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord1.yz = vertexToFrag11_g77238;
				half2 appendResult60_g77245 = (half2(ase_positionWS.x , ase_positionWS.z));
				half2 lerpResult58_g77245 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult60_g77245 , _ElementMaskCoordMode);
				half2 vertexToFrag11_g77248 = ( ( lerpResult58_g77245 * (_ElementMaskCoordValue).xy ) + (_ElementMaskCoordValue).zw );
				o.ase_texcoord2.zw = vertexToFrag11_g77248;
				half3 ase_normalWS = UnityObjectToWorldNormal( v.ase_normal );
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
				half Value_Main157_g77224 = _MainValue;
				half vertexToFrag11_g77229 = i.ase_texcoord1.x;
				half Value_Seasons1721_g77224 = vertexToFrag11_g77229;
				half Element_Mode55_g77224 = _ElementMode;
				half lerpResult181_g77224 = lerp( Value_Main157_g77224 , Value_Seasons1721_g77224 , Element_Mode55_g77224);
				half2 vertexToFrag11_g77238 = i.ase_texcoord1.yz;
				half4 MainTex_RGBA587_g77224 = tex2D( _MainTex, vertexToFrag11_g77238 );
				half3 temp_output_6_0_g77241 = (MainTex_RGBA587_g77224).rgb;
				half SpaceTexture2395_g77224 = _SpaceTexture;
				half temp_output_7_0_g77241 = SpaceTexture2395_g77224;
				#ifdef TVE_DUMMY
				half3 staticSwitch14_g77241 = ( temp_output_6_0_g77241 + temp_output_7_0_g77241 );
				#else
				half3 staticSwitch14_g77241 = temp_output_6_0_g77241;
				#endif
				half3 temp_cast_0 = (0.0001).xxx;
				half3 temp_cast_1 = (0.9999).xxx;
				half3 clampResult17_g77236 = clamp( staticSwitch14_g77241 , temp_cast_0 , temp_cast_1 );
				half temp_output_7_0_g77239 = _MainTexColorRemap.x;
				half3 temp_cast_2 = (temp_output_7_0_g77239).xxx;
				half3 temp_output_9_0_g77239 = ( clampResult17_g77236 - temp_cast_2 );
				half3 temp_output_1765_0_g77224 = saturate( ( temp_output_9_0_g77239 * _MainTexColorRemap.z ) );
				half Element_Remap_R73_g77224 = (temp_output_1765_0_g77224).x;
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half Element_Params_R1738_g77224 = _ElementParams_Instance.x;
				half Element_Value1744_g77224 = ( Element_Remap_R73_g77224 * Element_Params_R1738_g77224 * i.ase_color.r );
				half temp_output_468_0_g77224 = ( lerpResult181_g77224 * Element_Value1744_g77224 );
				half3 appendResult2402_g77224 = (half3(temp_output_468_0_g77224 , temp_output_468_0_g77224 , temp_output_468_0_g77224));
				half3 FInal_RGB213_g77224 = appendResult2402_g77224;
				half Element_Intensity2580_g77224 = _ElementIntensity;
				half temp_output_6_0_g77242 = (MainTex_RGBA587_g77224).a;
				half temp_output_7_0_g77242 = SpaceTexture2395_g77224;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77242 = ( temp_output_6_0_g77242 + temp_output_7_0_g77242 );
				#else
				half staticSwitch14_g77242 = temp_output_6_0_g77242;
				#endif
				half clampResult17_g77237 = clamp( staticSwitch14_g77242 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77240 = _MainTexAlphaRemap.x;
				half temp_output_9_0_g77240 = ( clampResult17_g77237 - temp_output_7_0_g77240 );
				half Element_Remap_A74_g77224 = saturate( ( temp_output_9_0_g77240 * _MainTexAlphaRemap.z ) );
				half Element_Params_A1737_g77224 = _ElementParams_Instance.w;
				half temp_output_6_0_g77244 = saturate( ( 1.0 - distance( (i.ase_texcoord2.xy*2.0 + -1.0) , float2( 0,0 ) ) ) );
				half temp_output_7_0_g77244 = SpaceTexture2395_g77224;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77244 = ( temp_output_6_0_g77244 + temp_output_7_0_g77244 );
				#else
				half staticSwitch14_g77244 = temp_output_6_0_g77244;
				#endif
				half clampResult17_g77243 = clamp( staticSwitch14_g77244 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77234 = _MainTexFalloffRemap.x;
				half temp_output_9_0_g77234 = ( clampResult17_g77243 - temp_output_7_0_g77234 );
				half Element_Falloff1883_g77224 = saturate( ( temp_output_9_0_g77234 * _MainTexFalloffRemap.z ) );
				half temp_output_7_0_g77227 = 1.0;
				half temp_output_9_0_g77227 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g77227 );
				half lerpResult18_g77225 = lerp( 1.0 , saturate( ( temp_output_9_0_g77227 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g77227 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g77225 = lerpResult18_g77225;
				half temp_output_6_0_g77228 = Blend_Edge69_g77225;
				half Dummy72_g77225 = ( _BoundsCategory + _BoundsEnd );
				half temp_output_7_0_g77228 = Dummy72_g77225;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77228 = ( temp_output_6_0_g77228 + temp_output_7_0_g77228 );
				#else
				half staticSwitch14_g77228 = temp_output_6_0_g77228;
				#endif
				half2 vertexToFrag11_g77248 = i.ase_texcoord2.zw;
				half4 MainTex_RGBA53_g77245 = tex2D( _ElementMaskTex, vertexToFrag11_g77248 );
				half lerpResult148_g77245 = lerp( (MainTex_RGBA53_g77245).r , (MainTex_RGBA53_g77245).a , _ElementMaskMode);
				half clampResult17_g77254 = clamp( lerpResult148_g77245 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77255 = _ElementMaskRemap.x;
				half temp_output_9_0_g77255 = ( clampResult17_g77254 - temp_output_7_0_g77255 );
				half lerpResult73_g77245 = lerp( 1.0 , saturate( ( temp_output_9_0_g77255 * _ElementMaskRemap.z ) ) , _ElementMaskValue);
				half Blend_Mask45_g77245 = lerpResult73_g77245;
				#ifdef TVE_ELEMENT_MASK
				half staticSwitch159_g77245 = Blend_Mask45_g77245;
				#else
				half staticSwitch159_g77245 = 1.0;
				#endif
				half3 ase_normalWS = i.ase_texcoord3.xyz;
				half4 appendResult108_g77245 = (half4(_TerrainPosition.x , _TerrainPosition.z , _TerrainSize.x , _TerrainSize.z));
				half4 Terrain_Coords111_g77245 = appendResult108_g77245;
				half4 temp_output_35_0_g77253 = Terrain_Coords111_g77245;
				float2 InputScale48_g77253 = (temp_output_35_0_g77253).zw;
				half2 FinalScale53_g77253 = ( 1.0 / InputScale48_g77253 );
				float2 InputPosition52_g77253 = (temp_output_35_0_g77253).xy;
				half2 FinalPosition58_g77253 = -( FinalScale53_g77253 * InputPosition52_g77253 );
				half2 temp_output_65_0_g77253 = ( ( (WorldPosition).xz * FinalScale53_g77253 ) + FinalPosition58_g77253 );
				half Terrain_InputMode136_g77245 = _TerrainInputMode;
				half3 lerpResult141_g77245 = lerp( ase_normalWS , tex2D( _TerrainNormalTex, temp_output_65_0_g77253 ).rgb , Terrain_InputMode136_g77245);
				half3 Terrain_Normal107_g77245 = lerpResult141_g77245;
				half dotResult113_g77245 = dot( Terrain_Normal107_g77245 , half3( 0, 1, 0 ) );
				half clampResult17_g77250 = clamp( dotResult113_g77245 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77251 = _ElementProjRemap.x;
				half temp_output_9_0_g77251 = ( clampResult17_g77250 - temp_output_7_0_g77251 );
				half lerpResult123_g77245 = lerp( 1.0 , saturate( ( temp_output_9_0_g77251 * _ElementProjRemap.z ) ) , _ElementProjValue);
				half Blend_Proj117_g77245 = lerpResult123_g77245;
				#ifdef TVE_ELEMENT_PROJ
				half staticSwitch160_g77245 = Blend_Proj117_g77245;
				#else
				half staticSwitch160_g77245 = 1.0;
				#endif
				half4 temp_output_35_0_g77246 = Terrain_Coords111_g77245;
				float2 InputScale48_g77246 = (temp_output_35_0_g77246).zw;
				half2 FinalScale53_g77246 = ( 1.0 / InputScale48_g77246 );
				float2 InputPosition52_g77246 = (temp_output_35_0_g77246).xy;
				half2 FinalPosition58_g77246 = -( FinalScale53_g77246 * InputPosition52_g77246 );
				half2 temp_output_65_0_g77246 = ( ( (WorldPosition).xz * FinalScale53_g77246 ) + FinalPosition58_g77246 );
				half4 temp_output_70_0_g77246 = _TerrainHeightTex_TexelSize;
				float2 InputTexelSize68_g77246 = (temp_output_70_0_g77246).zw;
				half2 temp_cast_3 = (1.0).xx;
				float2 InputTexelRecip69_g77246 = (temp_output_70_0_g77246).xy;
				float4 Terrain_Height_Raw104_g77245 = tex2D( _TerrainHeightTex, ( ( ( temp_output_65_0_g77246 / ( 1.0 / ( InputTexelSize68_g77246 - temp_cast_3 ) ) ) + 0.5 ) * InputTexelRecip69_g77246 ) );
				half temp_output_90_0_g77245 = ( ( (Terrain_Height_Raw104_g77245).r + ( (Terrain_Height_Raw104_g77245).g * 256.0 ) ) / 257.0 );
				#ifdef SHADER_API_VULKAN
				half staticSwitch91_g77245 = temp_output_90_0_g77245;
				#else
				half staticSwitch91_g77245 = (Terrain_Height_Raw104_g77245).r;
				#endif
				#ifdef SHADER_API_GLES
				half staticSwitch92_g77245 = temp_output_90_0_g77245;
				#else
				half staticSwitch92_g77245 = staticSwitch91_g77245;
				#endif
				#ifdef SHADER_API_GLES3
				half staticSwitch93_g77245 = temp_output_90_0_g77245;
				#else
				half staticSwitch93_g77245 = staticSwitch92_g77245;
				#endif
				float Terrain_Height_Platform105_g77245 = staticSwitch93_g77245;
				half Terrain_SizeY109_g77245 = _TerrainSize.y;
				half Terrain_PosY110_g77245 = _TerrainPosition.y;
				half lerpResult137_g77245 = lerp( WorldPosition.y , ( ( Terrain_Height_Platform105_g77245 * Terrain_SizeY109_g77245 * 2.0 ) + Terrain_PosY110_g77245 ) , Terrain_InputMode136_g77245);
				float Terrain_Height106_g77245 = lerpResult137_g77245;
				half temp_output_7_0_g77252 = _ElementPosMaxValue;
				half temp_output_9_0_g77252 = ( Terrain_Height106_g77245 - temp_output_7_0_g77252 );
				half lerpResult129_g77245 = lerp( 1.0 , saturate( ( temp_output_9_0_g77252 / ( ( _ElementPosMinValue - temp_output_7_0_g77252 ) + 0.0001 ) ) ) , _ElementPosValue);
				half Blend_Pos131_g77245 = lerpResult129_g77245;
				#ifdef TVE_ELEMENT_POS
				half staticSwitch161_g77245 = Blend_Pos131_g77245;
				#else
				half staticSwitch161_g77245 = 1.0;
				#endif
				half temp_output_6_0_g77256 = ( staticSwitch159_g77245 * staticSwitch160_g77245 * staticSwitch161_g77245 );
				half Dummy144_g77245 = ( _MaskingCategory + _MaskingEnd + ( _MaskingTerrainInfo + _MaskingModelInfo ) );
				half temp_output_7_0_g77256 = Dummy144_g77245;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77256 = ( temp_output_6_0_g77256 + temp_output_7_0_g77256 );
				#else
				half staticSwitch14_g77256 = temp_output_6_0_g77256;
				#endif
				half temp_output_145_0_g77245 = staticSwitch14_g77256;
				half temp_output_6_0_g77233 = 1.0;
				half temp_output_7_0_g77233 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				half staticSwitch14_g77233 = ( temp_output_6_0_g77233 + temp_output_7_0_g77233 );
				#else
				half staticSwitch14_g77233 = temp_output_6_0_g77233;
				#endif
				half Element_Alpha56_g77224 = ( Element_Intensity2580_g77224 * Element_Remap_A74_g77224 * Element_Params_A1737_g77224 * i.ase_color.a * Element_Falloff1883_g77224 * staticSwitch14_g77228 * temp_output_145_0_g77245 * staticSwitch14_g77233 );
				half Final_A241_g77224 = Element_Alpha56_g77224;
				half4 appendResult2468_g77224 = (half4(FInal_RGB213_g77224 , Final_A241_g77224));
				half4 Input_Visual94_g77283 = appendResult2468_g77224;
				half clampResult80_g77283 = clamp( (Input_Visual94_g77283).x , 0.1 , 10000.0 );
				half3 appendResult139_g77283 = (half3(clampResult80_g77283 , clampResult80_g77283 , clampResult80_g77283));
				half3 color184 = IsGammaSpace() ? half3( 0.2078431, 0.5647059, 0.972549 ) : half3( 0.0356013, 0.2788943, 0.9386859 );
				half3 Input_Tint76_g77283 = color184;
				half3 Element_Color47_g77283 = saturate( ( appendResult139_g77283 * Input_Tint76_g77283 ) );
				half4 appendResult131_g77283 = (half4(Element_Color47_g77283 , (Input_Visual94_g77283).w));
				
				
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
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":170,"pos":[-256,-1280],"params":["Inherit","False","Element Type Coat","1","","24056","4e3b30f5ed0011b43b960e98331fd8e6","0","0","1","FLOAT","4"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":182,"pos":[0,-1280],"params":["Inherit","False","Element Shader","11","","77224","0e972c73cae2ee54ea51acc9738801d0","15,1778,1,477,1,478,0,1824,0,1814,0,145,0,1784,0,481,0,2614,0,2618,0,1904,1,1907,1,2377,1,2310,1,2311,1","2","1974","FLOAT","0","False","2378","FLOAT","1","False","2","FLOAT4","0","FLOAT4","1779"]}
{"type":"AmplifyShaderEditor.ColorNode, AmplifyShaderEditor","id":184,"pos":[0,-1152],"params":["Inherit","False","Constant","_Color11","Color 1","63","0","Create","True","0","0","0","False","0","False","Object","-1","","0.2078431,0.5647059,0.972549,1","0,0,0,0","True","False","0","6","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":141,"pos":[576,-1536],"params":["Inherit","False","Element Compile","-1","","77282","5302407fc6d65554791e558e67d59358","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":183,"pos":[256,-1152],"params":["Inherit","False","Element Visuals","-1","","77283","78cf0f00cfd72824e84597f2db54a76e","1,64,1","2","59","FLOAT4","0,0,0,0","False","77","FLOAT3","1,1,1","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":120,"pos":[-256,-1536],"params":["Half","False","Property","_ElementMessage","Element Message","0","0","Create","True","0","0","0","True","1","StyledMessage(Info, Use Stack elements to control the Stack feature intensity. Element Texture A and Particle Color A are used as alpha masks., 0, 15)","False","Object","-1","","0","0","1","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":171,"pos":[320,-1280],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","1","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass1","0","1","VolumePass1","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass1","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":172,"pos":[320,-1280],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","1","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass2","0","2","VolumePass2","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass2","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":142,"pos":[576,-1280],"params":["Half","False","True","-1","2","TheVisualEngine.ElementGUI","100","2","BOXOPHOBIC/The Visual Engine/Elements/Coat Stack","f4f273c3bb6262d4396be458405e60f9","True","VolumePass","0","0","VolumePass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","3","RenderType=Transparent=RenderType","Queue=Transparent=Queue=0","DisableBatching=True=DisableBatching","False","False","0","True","True","2","5","False","","10","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","True","True","False","False","True","False","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass","True","2","False","0","","0","0","Standard","3","VolumePass1","0","0","VolumePass2","0","0","Vertex Position","1","0","0","4","True","False","False","True","False","","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":143,"pos":[576,-1152],"params":["Float","False","False","-1","2","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VisualPass","0","3","VisualPass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","True","True","2","5","False","","10","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","False","True","2","False","0","","0","0","Standard","0","False","0"]}
{"wire":[182,1974,170,4]}
{"wire":[183,59,182,1779]}
{"wire":[183,77,184,0]}
{"wire":[142,0,182,0]}
{"wire":[143,0,183,0]}
ASEEND*/
//CHKSM=F3672EF7578EF51247B5799EDEF882B4B8F426B9