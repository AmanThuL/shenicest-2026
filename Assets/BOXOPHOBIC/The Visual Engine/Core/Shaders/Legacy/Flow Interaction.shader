// Upgrade NOTE: upgraded instancing buffer 'HiddenBOXOPHOBICTheVisualEngineElementsFlowInteractionLegacy' to new syntax.

// Made with Amplify Shader Editor v1.9.9.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Visual Engine/Elements/Flow Interaction (Legacy)"
{
	Properties
	{
		[StyledMessage(Info, Use the Motion elements to control the wind intensity locally. Element Texture R and Particle Color R are used as value multipliers. Element Texture A and Particle Color A are used as alpha masks., 0, 15)] _ElementMessage( "Element Message", Float ) = 0
		[HideInInspector] _ElementParams( "Render Params", Vector ) = ( 1, 1, 1, 1 )
		[StyledSpace(10)] _RenderEnd( "[ Render End ]", Float ) = 0
		[StyledCategory(Element Settings, true, 0, 10)] _ElementCategory( "[ Element Category ]", Float ) = 1
		[NoScaleOffset][StyledTextureSingleLine] _MainTex( "Element Texture", 2D ) = "white" {}
		[StyledSpace(10)] _SpaceTexture( "#SpaceTexture", Float ) = 0
		[StyledRemapSlider] _MainTexColorRemap( "Element Value", Vector ) = ( 0, 1, 0, 0 )
		[StyledRemapSlider] _MainTexAlphaRemap( "Element Alpha", Vector ) = ( 0, 1, 0, 0 )
		[StyledRemapSlider] _MainTexFalloffRemap( "Element Falloff", Vector ) = ( 0, 0, 0, 0 )
		[Space(10)][StyledTextureSingleLine] _MotionTex( "Motion Texture", 2D ) = "linearGrey" {}
		[HideInInspector] _MotionPhaseValue( "Motion Phase", Float ) = 0
		[Enum(Element Forward,0,Element Texture,1,Particle Translate,2,Particle Velocity,3)][Space(10)] _MotionDirectionMode( "Motion Direction", Float ) = 1
		_MotionNoiseValue( "Motion Noise", Range( 0, 1 ) ) = 0
		_MotionTillingValue( "Motion Tilling", Range( 0, 100 ) ) = 5
		_MotionSpeedValue( "Motion Speed", Range( 0, 50 ) ) = 5
		[Space(10)] _SpeedTresholdValue( "Particle Speed Treshold", Float ) = 10
		[Space(10)][StyledToggle] _ElementInvertMode( "Use Inverted Direction", Float ) = 0
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
		[HideInInspector] _motion_direction_mode( "_motion_direction_mode", Vector ) = ( 0, 0, 0, 0 )
		[HideInInspector] _IsVersion( "_IsVersion", Float ) = 2160
		[HideInInspector] _IsElementShader( "_IsElementShader", Float ) = 1
		[HideInInspector] _IsIdentifier( "_IsIdentifier", Float ) = 0
		[StyledCategory(Render Settings, true, 0, 10)] _RenderCategory( "[ Render Category ]", Float ) = 1
		_ElementIntensity( "Render Intensity", Range( 0, 1 ) ) = 1
		[StyledMessage(Info, When using a higher Layer number the Global Volume will create more render textures to render the elements. Try using fewer layers when possible., _ElementLayerMessage, 1, 10, 10)] _ElementLayerMessage( "Render Layer Message", Float ) = 0
		[StyledMessage(Warning, When using all layers the Global Volume will create one render texture for each layer to render the elements. Try using fewer layers when possible., _ElementLayerWarning, 1, 10, 10)] _ElementLayerWarning( "Render Layer Warning", Float ) = 0
		[StyledMask(Flow Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _ElementLayerMask( "Render Layer", Float ) = 1

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
			ColorMask RGB
			ZWrite Off
			ZClip True
			ZTest LEqual
			
			CGPROGRAM

			#define ASE_VERSION 19908


			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_COLOR
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
			#pragma multi_compile_local_fragment __ TVE_ELEMENT_MASK
			#pragma multi_compile_local_fragment __ TVE_ELEMENT_PROJ
			#pragma multi_compile_local_fragment __ TVE_ELEMENT_POS


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
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
			uniform float _SpeedTresholdValue;
			uniform half _ElementCategory;
			uniform half _ElementEnd;
			uniform half _RenderEnd;
			uniform half _ElementMessage;
			uniform half4 _motion_direction_mode;
			uniform sampler2D _MainTex;
			uniform half _SpaceTexture;
			uniform half4 _MainTexColorRemap;
			uniform float _ElementInvertMode;
			uniform sampler2D _MotionTex;
			uniform float3 TVE_WorldOrigin;
			uniform half _MotionTillingValue;
			uniform half4 TVE_TimeParams;
			uniform half _MotionSpeedValue;
			uniform half _MotionPhaseValue;
			uniform half _MotionNoiseValue;
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
			uniform half _MotionDirectionMode;
			UNITY_INSTANCING_BUFFER_START(HiddenBOXOPHOBICTheVisualEngineElementsFlowInteractionLegacy)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr HiddenBOXOPHOBICTheVisualEngineElementsFlowInteractionLegacy
			UNITY_INSTANCING_BUFFER_END(HiddenBOXOPHOBICTheVisualEngineElementsFlowInteractionLegacy)

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
				float2 appendResult60_g77247 = (float2(ase_positionWS.x , ase_positionWS.z));
				float2 lerpResult58_g77247 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult60_g77247 , _ElementMaskCoordMode);
				float2 vertexToFrag11_g77250 = ( ( lerpResult58_g77247 * (_ElementMaskCoordValue).xy ) + (_ElementMaskCoordValue).zw );
				o.ase_texcoord3.xy = vertexToFrag11_g77250;
				float3 ase_normalWS = UnityObjectToWorldNormal( v.ase_normal );
				o.ase_texcoord4.xyz = ase_normalWS;
				
				o.ase_texcoord1 = v.ase_texcoord;
				o.ase_color = v.color;
				o.ase_texcoord2 = v.ase_texcoord1;
				
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
				float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
				half2 Direction_Transform1406_g77221 = (( mul( unity_ObjectToWorld, float4( float3( 0, 0, 1 ) , 0.0 ) ).xyz / ase_objectScale )).xz;
				half4 MainTex_RGBA587_g77221 = tex2D( _MainTex, ( 1.0 - i.ase_texcoord1.xy ) );
				float3 temp_output_6_0_g77241 = (MainTex_RGBA587_g77221).rgb;
				half SpaceTexture2395_g77221 = _SpaceTexture;
				float temp_output_7_0_g77241 = SpaceTexture2395_g77221;
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g77241 = ( temp_output_6_0_g77241 + temp_output_7_0_g77241 );
				#else
				float3 staticSwitch14_g77241 = temp_output_6_0_g77241;
				#endif
				float3 temp_cast_2 = (0.0001).xxx;
				float3 temp_cast_3 = (0.9999).xxx;
				float3 clampResult17_g77236 = clamp( staticSwitch14_g77241 , temp_cast_2 , temp_cast_3 );
				float temp_output_7_0_g77239 = _MainTexColorRemap.x;
				float3 temp_cast_4 = (temp_output_7_0_g77239).xxx;
				float3 temp_output_9_0_g77239 = ( clampResult17_g77236 - temp_cast_4 );
				float3 temp_output_1765_0_g77221 = saturate( ( temp_output_9_0_g77239 * _MainTexColorRemap.z ) );
				half Element_Remap_R73_g77221 = (temp_output_1765_0_g77221).x;
				half Element_Remap_G265_g77221 = (temp_output_1765_0_g77221).y;
				float3 appendResult274_g77221 = (float3((Element_Remap_R73_g77221*2.0 + -1.0) , 0.0 , (Element_Remap_G265_g77221*2.0 + -1.0)));
				float3 break281_g77221 = ( mul( unity_ObjectToWorld, float4( appendResult274_g77221 , 0.0 ) ).xyz / ase_objectScale );
				float2 appendResult1403_g77221 = (float2(break281_g77221.x , break281_g77221.z));
				half2 Direction_Texture284_g77221 = appendResult1403_g77221;
				float2 appendResult1404_g77221 = (float2(i.ase_color.r , i.ase_color.g));
				half2 Direction_VertexColor1150_g77221 = (appendResult1404_g77221*2.0 + -1.0);
				float2 appendResult1382_g77221 = (float2(i.ase_texcoord1.z , i.ase_texcoord2.x));
				half2 Direction_Velocity1394_g77221 = ( appendResult1382_g77221 / i.ase_texcoord2.y );
				float2 temp_output_1452_0_g77221 = ( ( _motion_direction_mode.x * Direction_Transform1406_g77221 ) + ( _motion_direction_mode.y * Direction_Texture284_g77221 ) + ( _motion_direction_mode.z * Direction_VertexColor1150_g77221 ) + ( _motion_direction_mode.w * Direction_Velocity1394_g77221 ) );
				half Element_InvertMode489_g77221 = _ElementInvertMode;
				float2 lerpResult1468_g77221 = lerp( temp_output_1452_0_g77221 , -temp_output_1452_0_g77221 , Element_InvertMode489_g77221);
				half2 Direction_Advanced1454_g77221 = lerpResult1468_g77221;
				half2 Motion_Coords2098_g77221 = -(( WorldPosition - TVE_WorldOrigin )).xz;
				half2 Motion_Tilling1409_g77221 = ( Motion_Coords2098_g77221 * 0.005 * _MotionTillingValue );
				float2 Input_Coords80_g77259 = Motion_Tilling1409_g77221;
				half2 Input_Direction82_g77259 = Direction_Advanced1454_g77221;
				float mulTime113_g77263 = _Time.y * 0.02;
				float lerpResult128_g77263 = lerp( mulTime113_g77263 , ( ( mulTime113_g77263 * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				float Input_Time88_g77259 = (lerpResult128_g77263*_MotionSpeedValue + _MotionPhaseValue);
				float temp_output_23_0_g77259 = frac( Input_Time88_g77259 );
				float4 lerpResult39_g77259 = lerp( tex2D( _MotionTex, ( Input_Coords80_g77259 + ( Input_Direction82_g77259 * temp_output_23_0_g77259 ) ) ) , tex2D( _MotionTex, ( Input_Coords80_g77259 + ( Input_Direction82_g77259 * frac( ( Input_Time88_g77259 + 0.5 ) ) ) ) ) , ( abs( ( temp_output_23_0_g77259 - 0.5 ) ) / 0.5 ));
				float4 temp_output_1423_0_g77221 = lerpResult39_g77259;
				half2 Motion_FlowRG1427_g77221 = ((temp_output_1423_0_g77221).rg*2.0 + -1.0);
				half Motion_Noise2056_g77221 = _MotionNoiseValue;
				float2 lerpResult2141_g77221 = lerp( Direction_Advanced1454_g77221 , Motion_FlowRG1427_g77221 , Motion_Noise2056_g77221);
				float2 temp_cast_7 = (0.001).xx;
				float2 temp_cast_8 = (0.999).xx;
				float2 clampResult2359_g77221 = clamp( (lerpResult2141_g77221*0.5 + 0.5) , temp_cast_7 , temp_cast_8 );
				float3 appendResult1436_g77221 = (float3(clampResult2359_g77221 , Motion_Noise2056_g77221));
				half3 Final_MotionAdvanced_RGB1438_g77221 = appendResult1436_g77221;
				float temp_output_6_0_g77242 = (MainTex_RGBA587_g77221).a;
				float temp_output_7_0_g77242 = SpaceTexture2395_g77221;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77242 = ( temp_output_6_0_g77242 + temp_output_7_0_g77242 );
				#else
				float staticSwitch14_g77242 = temp_output_6_0_g77242;
				#endif
				float clampResult17_g77237 = clamp( staticSwitch14_g77242 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77240 = _MainTexAlphaRemap.x;
				float temp_output_9_0_g77240 = ( clampResult17_g77237 - temp_output_7_0_g77240 );
				half Element_Remap_A74_g77221 = saturate( ( temp_output_9_0_g77240 * _MainTexAlphaRemap.z ) );
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half Element_Params_A1737_g77221 = _ElementParams_Instance.w;
				float temp_output_6_0_g77244 = saturate( ( 1.0 - distance( (i.ase_texcoord1.xy*2.0 + -1.0) , float2( 0,0 ) ) ) );
				float temp_output_7_0_g77244 = SpaceTexture2395_g77221;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77244 = ( temp_output_6_0_g77244 + temp_output_7_0_g77244 );
				#else
				float staticSwitch14_g77244 = temp_output_6_0_g77244;
				#endif
				float clampResult17_g77243 = clamp( staticSwitch14_g77244 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77234 = _MainTexFalloffRemap.x;
				float temp_output_9_0_g77234 = ( clampResult17_g77243 - temp_output_7_0_g77234 );
				half Element_Falloff1883_g77221 = saturate( ( temp_output_9_0_g77234 * _MainTexFalloffRemap.z ) );
				float temp_output_7_0_g77226 = 1.0;
				float temp_output_9_0_g77226 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g77226 );
				float lerpResult18_g77224 = lerp( 1.0 , saturate( ( temp_output_9_0_g77226 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g77226 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g77224 = lerpResult18_g77224;
				float temp_output_6_0_g77227 = Blend_Edge69_g77224;
				half Dummy72_g77224 = ( _BoundsCategory + _BoundsEnd );
				float temp_output_7_0_g77227 = Dummy72_g77224;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77227 = ( temp_output_6_0_g77227 + temp_output_7_0_g77227 );
				#else
				float staticSwitch14_g77227 = temp_output_6_0_g77227;
				#endif
				float2 vertexToFrag11_g77250 = i.ase_texcoord3.xy;
				half4 MainTex_RGBA53_g77247 = tex2D( _ElementMaskTex, vertexToFrag11_g77250 );
				float lerpResult148_g77247 = lerp( (MainTex_RGBA53_g77247).r , (MainTex_RGBA53_g77247).a , _ElementMaskMode);
				float clampResult17_g77256 = clamp( lerpResult148_g77247 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77257 = _ElementMaskRemap.x;
				float temp_output_9_0_g77257 = ( clampResult17_g77256 - temp_output_7_0_g77257 );
				float lerpResult73_g77247 = lerp( 1.0 , saturate( ( temp_output_9_0_g77257 * _ElementMaskRemap.z ) ) , _ElementMaskValue);
				half Blend_Mask45_g77247 = lerpResult73_g77247;
				#ifdef TVE_ELEMENT_MASK
				float staticSwitch159_g77247 = Blend_Mask45_g77247;
				#else
				float staticSwitch159_g77247 = 1.0;
				#endif
				float3 ase_normalWS = i.ase_texcoord4.xyz;
				float4 appendResult108_g77247 = (float4(_TerrainPosition.x , _TerrainPosition.z , _TerrainSize.x , _TerrainSize.z));
				half4 Terrain_Coords111_g77247 = appendResult108_g77247;
				float4 temp_output_35_0_g77255 = Terrain_Coords111_g77247;
				float2 InputScale48_g77255 = (temp_output_35_0_g77255).zw;
				half2 FinalScale53_g77255 = ( 1.0 / InputScale48_g77255 );
				float2 InputPosition52_g77255 = (temp_output_35_0_g77255).xy;
				half2 FinalPosition58_g77255 = -( FinalScale53_g77255 * InputPosition52_g77255 );
				float2 temp_output_65_0_g77255 = ( ( (WorldPosition).xz * FinalScale53_g77255 ) + FinalPosition58_g77255 );
				half Terrain_InputMode136_g77247 = _TerrainInputMode;
				float3 lerpResult141_g77247 = lerp( ase_normalWS , tex2D( _TerrainNormalTex, temp_output_65_0_g77255 ).rgb , Terrain_InputMode136_g77247);
				float3 Terrain_Normal107_g77247 = lerpResult141_g77247;
				float dotResult113_g77247 = dot( Terrain_Normal107_g77247 , half3( 0, 1, 0 ) );
				float clampResult17_g77252 = clamp( dotResult113_g77247 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77253 = _ElementProjRemap.x;
				float temp_output_9_0_g77253 = ( clampResult17_g77252 - temp_output_7_0_g77253 );
				float lerpResult123_g77247 = lerp( 1.0 , saturate( ( temp_output_9_0_g77253 * _ElementProjRemap.z ) ) , _ElementProjValue);
				half Blend_Proj117_g77247 = lerpResult123_g77247;
				#ifdef TVE_ELEMENT_PROJ
				float staticSwitch160_g77247 = Blend_Proj117_g77247;
				#else
				float staticSwitch160_g77247 = 1.0;
				#endif
				float4 temp_output_35_0_g77248 = Terrain_Coords111_g77247;
				float2 InputScale48_g77248 = (temp_output_35_0_g77248).zw;
				half2 FinalScale53_g77248 = ( 1.0 / InputScale48_g77248 );
				float2 InputPosition52_g77248 = (temp_output_35_0_g77248).xy;
				half2 FinalPosition58_g77248 = -( FinalScale53_g77248 * InputPosition52_g77248 );
				float2 temp_output_65_0_g77248 = ( ( (WorldPosition).xz * FinalScale53_g77248 ) + FinalPosition58_g77248 );
				float4 temp_output_70_0_g77248 = _TerrainHeightTex_TexelSize;
				float2 InputTexelSize68_g77248 = (temp_output_70_0_g77248).zw;
				float2 temp_cast_9 = (1.0).xx;
				float2 InputTexelRecip69_g77248 = (temp_output_70_0_g77248).xy;
				float4 Terrain_Height_Raw104_g77247 = tex2D( _TerrainHeightTex, ( ( ( temp_output_65_0_g77248 / ( 1.0 / ( InputTexelSize68_g77248 - temp_cast_9 ) ) ) + 0.5 ) * InputTexelRecip69_g77248 ) );
				float temp_output_90_0_g77247 = ( ( (Terrain_Height_Raw104_g77247).r + ( (Terrain_Height_Raw104_g77247).g * 256.0 ) ) / 257.0 );
				#ifdef SHADER_API_VULKAN
				float staticSwitch91_g77247 = temp_output_90_0_g77247;
				#else
				float staticSwitch91_g77247 = (Terrain_Height_Raw104_g77247).r;
				#endif
				#ifdef SHADER_API_GLES
				float staticSwitch92_g77247 = temp_output_90_0_g77247;
				#else
				float staticSwitch92_g77247 = staticSwitch91_g77247;
				#endif
				#ifdef SHADER_API_GLES3
				float staticSwitch93_g77247 = temp_output_90_0_g77247;
				#else
				float staticSwitch93_g77247 = staticSwitch92_g77247;
				#endif
				float Terrain_Height_Platform105_g77247 = staticSwitch93_g77247;
				float Terrain_SizeY109_g77247 = _TerrainSize.y;
				float Terrain_PosY110_g77247 = _TerrainPosition.y;
				float lerpResult137_g77247 = lerp( WorldPosition.y , ( ( Terrain_Height_Platform105_g77247 * Terrain_SizeY109_g77247 * 2.0 ) + Terrain_PosY110_g77247 ) , Terrain_InputMode136_g77247);
				float Terrain_Height106_g77247 = lerpResult137_g77247;
				float temp_output_7_0_g77254 = _ElementPosMaxValue;
				float temp_output_9_0_g77254 = ( Terrain_Height106_g77247 - temp_output_7_0_g77254 );
				float lerpResult129_g77247 = lerp( 1.0 , saturate( ( temp_output_9_0_g77254 / ( ( _ElementPosMinValue - temp_output_7_0_g77254 ) + 0.0001 ) ) ) , _ElementPosValue);
				half Blend_Pos131_g77247 = lerpResult129_g77247;
				#ifdef TVE_ELEMENT_POS
				float staticSwitch161_g77247 = Blend_Pos131_g77247;
				#else
				float staticSwitch161_g77247 = 1.0;
				#endif
				float temp_output_6_0_g77258 = ( staticSwitch159_g77247 * staticSwitch160_g77247 * staticSwitch161_g77247 );
				half Dummy144_g77247 = ( _MaskingCategory + _MaskingEnd + ( _MaskingTerrainInfo + _MaskingModelInfo ) );
				float temp_output_7_0_g77258 = Dummy144_g77247;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77258 = ( temp_output_6_0_g77258 + temp_output_7_0_g77258 );
				#else
				float staticSwitch14_g77258 = temp_output_6_0_g77258;
				#endif
				float temp_output_145_0_g77247 = staticSwitch14_g77258;
				float temp_output_6_0_g77233 = 1.0;
				float temp_output_7_0_g77233 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				float staticSwitch14_g77233 = ( temp_output_6_0_g77233 + temp_output_7_0_g77233 );
				#else
				float staticSwitch14_g77233 = temp_output_6_0_g77233;
				#endif
				half Element_Alpha56_g77221 = ( _ElementIntensity * Element_Remap_A74_g77221 * Element_Params_A1737_g77221 * i.ase_color.a * Element_Falloff1883_g77221 * staticSwitch14_g77227 * temp_output_145_0_g77247 * staticSwitch14_g77233 );
				half Final_MotionAdvanced_A1439_g77221 = Element_Alpha56_g77221;
				float4 appendResult1463_g77221 = (float4(Final_MotionAdvanced_RGB1438_g77221 , Final_MotionAdvanced_A1439_g77221));
				float4 temp_output_6_0_g77245 = appendResult1463_g77221;
				half Motion_Direction1013_g77221 = _MotionDirectionMode;
				float temp_output_7_0_g77245 = Motion_Direction1013_g77221;
				#ifdef TVE_DUMMY
				float4 staticSwitch14_g77245 = ( temp_output_6_0_g77245 + temp_output_7_0_g77245 );
				#else
				float4 staticSwitch14_g77245 = temp_output_6_0_g77245;
				#endif
				
				
				finalColor = staticSwitch14_g77245;
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

			#define ASE_VERSION 19908


			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_COLOR
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
			#pragma multi_compile_local_fragment __ TVE_ELEMENT_MASK
			#pragma multi_compile_local_fragment __ TVE_ELEMENT_PROJ
			#pragma multi_compile_local_fragment __ TVE_ELEMENT_POS


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
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
			uniform float _SpeedTresholdValue;
			uniform half _ElementCategory;
			uniform half _ElementEnd;
			uniform half _RenderEnd;
			uniform half _ElementMessage;
			uniform half4 _motion_direction_mode;
			uniform sampler2D _MainTex;
			uniform half _SpaceTexture;
			uniform half4 _MainTexColorRemap;
			uniform float _ElementInvertMode;
			uniform sampler2D _MotionTex;
			uniform float3 TVE_WorldOrigin;
			uniform half _MotionTillingValue;
			uniform half4 TVE_TimeParams;
			uniform half _MotionSpeedValue;
			uniform half _MotionPhaseValue;
			uniform half _MotionNoiseValue;
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
			UNITY_INSTANCING_BUFFER_START(HiddenBOXOPHOBICTheVisualEngineElementsFlowInteractionLegacy)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr HiddenBOXOPHOBICTheVisualEngineElementsFlowInteractionLegacy
			UNITY_INSTANCING_BUFFER_END(HiddenBOXOPHOBICTheVisualEngineElementsFlowInteractionLegacy)

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
				float2 appendResult60_g77247 = (float2(ase_positionWS.x , ase_positionWS.z));
				float2 lerpResult58_g77247 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult60_g77247 , _ElementMaskCoordMode);
				float2 vertexToFrag11_g77250 = ( ( lerpResult58_g77247 * (_ElementMaskCoordValue).xy ) + (_ElementMaskCoordValue).zw );
				o.ase_texcoord3.xy = vertexToFrag11_g77250;
				float3 ase_normalWS = UnityObjectToWorldNormal( v.ase_normal );
				o.ase_texcoord4.xyz = ase_normalWS;
				
				o.ase_texcoord1 = v.ase_texcoord;
				o.ase_color = v.color;
				o.ase_texcoord2 = v.ase_texcoord1;
				
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
				float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
				half2 Direction_Transform1406_g77221 = (( mul( unity_ObjectToWorld, float4( float3( 0, 0, 1 ) , 0.0 ) ).xyz / ase_objectScale )).xz;
				half4 MainTex_RGBA587_g77221 = tex2D( _MainTex, ( 1.0 - i.ase_texcoord1.xy ) );
				float3 temp_output_6_0_g77241 = (MainTex_RGBA587_g77221).rgb;
				half SpaceTexture2395_g77221 = _SpaceTexture;
				float temp_output_7_0_g77241 = SpaceTexture2395_g77221;
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g77241 = ( temp_output_6_0_g77241 + temp_output_7_0_g77241 );
				#else
				float3 staticSwitch14_g77241 = temp_output_6_0_g77241;
				#endif
				float3 temp_cast_2 = (0.0001).xxx;
				float3 temp_cast_3 = (0.9999).xxx;
				float3 clampResult17_g77236 = clamp( staticSwitch14_g77241 , temp_cast_2 , temp_cast_3 );
				float temp_output_7_0_g77239 = _MainTexColorRemap.x;
				float3 temp_cast_4 = (temp_output_7_0_g77239).xxx;
				float3 temp_output_9_0_g77239 = ( clampResult17_g77236 - temp_cast_4 );
				float3 temp_output_1765_0_g77221 = saturate( ( temp_output_9_0_g77239 * _MainTexColorRemap.z ) );
				half Element_Remap_R73_g77221 = (temp_output_1765_0_g77221).x;
				half Element_Remap_G265_g77221 = (temp_output_1765_0_g77221).y;
				float3 appendResult274_g77221 = (float3((Element_Remap_R73_g77221*2.0 + -1.0) , 0.0 , (Element_Remap_G265_g77221*2.0 + -1.0)));
				float3 break281_g77221 = ( mul( unity_ObjectToWorld, float4( appendResult274_g77221 , 0.0 ) ).xyz / ase_objectScale );
				float2 appendResult1403_g77221 = (float2(break281_g77221.x , break281_g77221.z));
				half2 Direction_Texture284_g77221 = appendResult1403_g77221;
				float2 appendResult1404_g77221 = (float2(i.ase_color.r , i.ase_color.g));
				half2 Direction_VertexColor1150_g77221 = (appendResult1404_g77221*2.0 + -1.0);
				float2 appendResult1382_g77221 = (float2(i.ase_texcoord1.z , i.ase_texcoord2.x));
				half2 Direction_Velocity1394_g77221 = ( appendResult1382_g77221 / i.ase_texcoord2.y );
				float2 temp_output_1452_0_g77221 = ( ( _motion_direction_mode.x * Direction_Transform1406_g77221 ) + ( _motion_direction_mode.y * Direction_Texture284_g77221 ) + ( _motion_direction_mode.z * Direction_VertexColor1150_g77221 ) + ( _motion_direction_mode.w * Direction_Velocity1394_g77221 ) );
				half Element_InvertMode489_g77221 = _ElementInvertMode;
				float2 lerpResult1468_g77221 = lerp( temp_output_1452_0_g77221 , -temp_output_1452_0_g77221 , Element_InvertMode489_g77221);
				half2 Direction_Advanced1454_g77221 = lerpResult1468_g77221;
				half2 Motion_Coords2098_g77221 = -(( WorldPosition - TVE_WorldOrigin )).xz;
				half2 Motion_Tilling1409_g77221 = ( Motion_Coords2098_g77221 * 0.005 * _MotionTillingValue );
				float2 Input_Coords80_g77259 = Motion_Tilling1409_g77221;
				half2 Input_Direction82_g77259 = Direction_Advanced1454_g77221;
				float mulTime113_g77263 = _Time.y * 0.02;
				float lerpResult128_g77263 = lerp( mulTime113_g77263 , ( ( mulTime113_g77263 * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				float Input_Time88_g77259 = (lerpResult128_g77263*_MotionSpeedValue + _MotionPhaseValue);
				float temp_output_23_0_g77259 = frac( Input_Time88_g77259 );
				float4 lerpResult39_g77259 = lerp( tex2D( _MotionTex, ( Input_Coords80_g77259 + ( Input_Direction82_g77259 * temp_output_23_0_g77259 ) ) ) , tex2D( _MotionTex, ( Input_Coords80_g77259 + ( Input_Direction82_g77259 * frac( ( Input_Time88_g77259 + 0.5 ) ) ) ) ) , ( abs( ( temp_output_23_0_g77259 - 0.5 ) ) / 0.5 ));
				float4 temp_output_1423_0_g77221 = lerpResult39_g77259;
				half2 Motion_FlowRG1427_g77221 = ((temp_output_1423_0_g77221).rg*2.0 + -1.0);
				half Motion_Noise2056_g77221 = _MotionNoiseValue;
				float2 lerpResult2141_g77221 = lerp( Direction_Advanced1454_g77221 , Motion_FlowRG1427_g77221 , Motion_Noise2056_g77221);
				float2 temp_cast_7 = (0.001).xx;
				float2 temp_cast_8 = (0.999).xx;
				float2 clampResult2359_g77221 = clamp( (lerpResult2141_g77221*0.5 + 0.5) , temp_cast_7 , temp_cast_8 );
				float3 appendResult1436_g77221 = (float3(clampResult2359_g77221 , Motion_Noise2056_g77221));
				half3 Final_MotionAdvanced_Visual2200_g77221 = appendResult1436_g77221;
				float temp_output_6_0_g77242 = (MainTex_RGBA587_g77221).a;
				float temp_output_7_0_g77242 = SpaceTexture2395_g77221;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77242 = ( temp_output_6_0_g77242 + temp_output_7_0_g77242 );
				#else
				float staticSwitch14_g77242 = temp_output_6_0_g77242;
				#endif
				float clampResult17_g77237 = clamp( staticSwitch14_g77242 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77240 = _MainTexAlphaRemap.x;
				float temp_output_9_0_g77240 = ( clampResult17_g77237 - temp_output_7_0_g77240 );
				half Element_Remap_A74_g77221 = saturate( ( temp_output_9_0_g77240 * _MainTexAlphaRemap.z ) );
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half Element_Params_A1737_g77221 = _ElementParams_Instance.w;
				float temp_output_6_0_g77244 = saturate( ( 1.0 - distance( (i.ase_texcoord1.xy*2.0 + -1.0) , float2( 0,0 ) ) ) );
				float temp_output_7_0_g77244 = SpaceTexture2395_g77221;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77244 = ( temp_output_6_0_g77244 + temp_output_7_0_g77244 );
				#else
				float staticSwitch14_g77244 = temp_output_6_0_g77244;
				#endif
				float clampResult17_g77243 = clamp( staticSwitch14_g77244 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77234 = _MainTexFalloffRemap.x;
				float temp_output_9_0_g77234 = ( clampResult17_g77243 - temp_output_7_0_g77234 );
				half Element_Falloff1883_g77221 = saturate( ( temp_output_9_0_g77234 * _MainTexFalloffRemap.z ) );
				float temp_output_7_0_g77226 = 1.0;
				float temp_output_9_0_g77226 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g77226 );
				float lerpResult18_g77224 = lerp( 1.0 , saturate( ( temp_output_9_0_g77226 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g77226 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g77224 = lerpResult18_g77224;
				float temp_output_6_0_g77227 = Blend_Edge69_g77224;
				half Dummy72_g77224 = ( _BoundsCategory + _BoundsEnd );
				float temp_output_7_0_g77227 = Dummy72_g77224;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77227 = ( temp_output_6_0_g77227 + temp_output_7_0_g77227 );
				#else
				float staticSwitch14_g77227 = temp_output_6_0_g77227;
				#endif
				float2 vertexToFrag11_g77250 = i.ase_texcoord3.xy;
				half4 MainTex_RGBA53_g77247 = tex2D( _ElementMaskTex, vertexToFrag11_g77250 );
				float lerpResult148_g77247 = lerp( (MainTex_RGBA53_g77247).r , (MainTex_RGBA53_g77247).a , _ElementMaskMode);
				float clampResult17_g77256 = clamp( lerpResult148_g77247 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77257 = _ElementMaskRemap.x;
				float temp_output_9_0_g77257 = ( clampResult17_g77256 - temp_output_7_0_g77257 );
				float lerpResult73_g77247 = lerp( 1.0 , saturate( ( temp_output_9_0_g77257 * _ElementMaskRemap.z ) ) , _ElementMaskValue);
				half Blend_Mask45_g77247 = lerpResult73_g77247;
				#ifdef TVE_ELEMENT_MASK
				float staticSwitch159_g77247 = Blend_Mask45_g77247;
				#else
				float staticSwitch159_g77247 = 1.0;
				#endif
				float3 ase_normalWS = i.ase_texcoord4.xyz;
				float4 appendResult108_g77247 = (float4(_TerrainPosition.x , _TerrainPosition.z , _TerrainSize.x , _TerrainSize.z));
				half4 Terrain_Coords111_g77247 = appendResult108_g77247;
				float4 temp_output_35_0_g77255 = Terrain_Coords111_g77247;
				float2 InputScale48_g77255 = (temp_output_35_0_g77255).zw;
				half2 FinalScale53_g77255 = ( 1.0 / InputScale48_g77255 );
				float2 InputPosition52_g77255 = (temp_output_35_0_g77255).xy;
				half2 FinalPosition58_g77255 = -( FinalScale53_g77255 * InputPosition52_g77255 );
				float2 temp_output_65_0_g77255 = ( ( (WorldPosition).xz * FinalScale53_g77255 ) + FinalPosition58_g77255 );
				half Terrain_InputMode136_g77247 = _TerrainInputMode;
				float3 lerpResult141_g77247 = lerp( ase_normalWS , tex2D( _TerrainNormalTex, temp_output_65_0_g77255 ).rgb , Terrain_InputMode136_g77247);
				float3 Terrain_Normal107_g77247 = lerpResult141_g77247;
				float dotResult113_g77247 = dot( Terrain_Normal107_g77247 , half3( 0, 1, 0 ) );
				float clampResult17_g77252 = clamp( dotResult113_g77247 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77253 = _ElementProjRemap.x;
				float temp_output_9_0_g77253 = ( clampResult17_g77252 - temp_output_7_0_g77253 );
				float lerpResult123_g77247 = lerp( 1.0 , saturate( ( temp_output_9_0_g77253 * _ElementProjRemap.z ) ) , _ElementProjValue);
				half Blend_Proj117_g77247 = lerpResult123_g77247;
				#ifdef TVE_ELEMENT_PROJ
				float staticSwitch160_g77247 = Blend_Proj117_g77247;
				#else
				float staticSwitch160_g77247 = 1.0;
				#endif
				float4 temp_output_35_0_g77248 = Terrain_Coords111_g77247;
				float2 InputScale48_g77248 = (temp_output_35_0_g77248).zw;
				half2 FinalScale53_g77248 = ( 1.0 / InputScale48_g77248 );
				float2 InputPosition52_g77248 = (temp_output_35_0_g77248).xy;
				half2 FinalPosition58_g77248 = -( FinalScale53_g77248 * InputPosition52_g77248 );
				float2 temp_output_65_0_g77248 = ( ( (WorldPosition).xz * FinalScale53_g77248 ) + FinalPosition58_g77248 );
				float4 temp_output_70_0_g77248 = _TerrainHeightTex_TexelSize;
				float2 InputTexelSize68_g77248 = (temp_output_70_0_g77248).zw;
				float2 temp_cast_9 = (1.0).xx;
				float2 InputTexelRecip69_g77248 = (temp_output_70_0_g77248).xy;
				float4 Terrain_Height_Raw104_g77247 = tex2D( _TerrainHeightTex, ( ( ( temp_output_65_0_g77248 / ( 1.0 / ( InputTexelSize68_g77248 - temp_cast_9 ) ) ) + 0.5 ) * InputTexelRecip69_g77248 ) );
				float temp_output_90_0_g77247 = ( ( (Terrain_Height_Raw104_g77247).r + ( (Terrain_Height_Raw104_g77247).g * 256.0 ) ) / 257.0 );
				#ifdef SHADER_API_VULKAN
				float staticSwitch91_g77247 = temp_output_90_0_g77247;
				#else
				float staticSwitch91_g77247 = (Terrain_Height_Raw104_g77247).r;
				#endif
				#ifdef SHADER_API_GLES
				float staticSwitch92_g77247 = temp_output_90_0_g77247;
				#else
				float staticSwitch92_g77247 = staticSwitch91_g77247;
				#endif
				#ifdef SHADER_API_GLES3
				float staticSwitch93_g77247 = temp_output_90_0_g77247;
				#else
				float staticSwitch93_g77247 = staticSwitch92_g77247;
				#endif
				float Terrain_Height_Platform105_g77247 = staticSwitch93_g77247;
				float Terrain_SizeY109_g77247 = _TerrainSize.y;
				float Terrain_PosY110_g77247 = _TerrainPosition.y;
				float lerpResult137_g77247 = lerp( WorldPosition.y , ( ( Terrain_Height_Platform105_g77247 * Terrain_SizeY109_g77247 * 2.0 ) + Terrain_PosY110_g77247 ) , Terrain_InputMode136_g77247);
				float Terrain_Height106_g77247 = lerpResult137_g77247;
				float temp_output_7_0_g77254 = _ElementPosMaxValue;
				float temp_output_9_0_g77254 = ( Terrain_Height106_g77247 - temp_output_7_0_g77254 );
				float lerpResult129_g77247 = lerp( 1.0 , saturate( ( temp_output_9_0_g77254 / ( ( _ElementPosMinValue - temp_output_7_0_g77254 ) + 0.0001 ) ) ) , _ElementPosValue);
				half Blend_Pos131_g77247 = lerpResult129_g77247;
				#ifdef TVE_ELEMENT_POS
				float staticSwitch161_g77247 = Blend_Pos131_g77247;
				#else
				float staticSwitch161_g77247 = 1.0;
				#endif
				float temp_output_6_0_g77258 = ( staticSwitch159_g77247 * staticSwitch160_g77247 * staticSwitch161_g77247 );
				half Dummy144_g77247 = ( _MaskingCategory + _MaskingEnd + ( _MaskingTerrainInfo + _MaskingModelInfo ) );
				float temp_output_7_0_g77258 = Dummy144_g77247;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77258 = ( temp_output_6_0_g77258 + temp_output_7_0_g77258 );
				#else
				float staticSwitch14_g77258 = temp_output_6_0_g77258;
				#endif
				float temp_output_145_0_g77247 = staticSwitch14_g77258;
				float temp_output_6_0_g77233 = 1.0;
				float temp_output_7_0_g77233 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				float staticSwitch14_g77233 = ( temp_output_6_0_g77233 + temp_output_7_0_g77233 );
				#else
				float staticSwitch14_g77233 = temp_output_6_0_g77233;
				#endif
				half Element_Alpha56_g77221 = ( _ElementIntensity * Element_Remap_A74_g77221 * Element_Params_A1737_g77221 * i.ase_color.a * Element_Falloff1883_g77221 * staticSwitch14_g77227 * temp_output_145_0_g77247 * staticSwitch14_g77233 );
				half Final_MotionAdvanced_A1439_g77221 = Element_Alpha56_g77221;
				float4 appendResult2474_g77221 = (float4(Final_MotionAdvanced_Visual2200_g77221 , Final_MotionAdvanced_A1439_g77221));
				half4 Input_Visual94_g77266 = appendResult2474_g77221;
				float2 temp_output_135_0_g77266 = (Input_Visual94_g77266).xy;
				float3 appendResult140_g77266 = (float3(( temp_output_135_0_g77266 * temp_output_135_0_g77266 ) , (Input_Visual94_g77266).z));
				half3 Element_Color47_g77266 = saturate( appendResult140_g77266 );
				float4 appendResult131_g77266 = (float4(Element_Color47_g77266 , (Input_Visual94_g77266).w));
				
				
				finalColor = appendResult131_g77266;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "TheVisualEngine.ElementGUI"
	
	Fallback Off
}
/*ASEBEGIN
Version=19908
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;642;-640,-768;Inherit;False;Element Type Flow;97;;77218;c08e6ab33dbacc04780022d2dbd4852d;0;0;1;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;638;-384,-768;Inherit;False;Element Shader;1;;77221;0e972c73cae2ee54ea51acc9738801d0;14,477,2,1778,2,478,0,1824,0,1814,1,145,1,481,1,1784,1,2346,1,1904,0,1907,1,2377,1,2310,1,2311,1;2;1974;FLOAT;0;False;2378;FLOAT;1;False;2;FLOAT4;0;FLOAT4;1779
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;636;-640,-1280;Half;False;Property;_ElementMessage;Element Message;0;0;Create;True;0;0;0;True;1;StyledMessage(Info, Use the Motion elements to control the wind intensity locally. Element Texture R and Particle Color R are used as value multipliers. Element Texture A and Particle Color A are used as alpha masks., 0, 15);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;643;-128,-640;Inherit;False;Element Visuals;-1;;77266;78cf0f00cfd72824e84597f2db54a76e;1,64,2;2;59;FLOAT4;0,0,0,0;False;77;FLOAT3;1,1,1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;416;64,-1280;Inherit;False;Element Compile;-1;;77267;5302407fc6d65554791e558e67d59358;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;640;-64,-768;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;100;1;New Amplify Shader;f4f273c3bb6262d4396be458405e60f9;True;VolumePass1;0;1;VolumePass1;2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;RenderType=Opaque=RenderType;False;False;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;1;LightMode=VolumePass1;True;2;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;641;-64,-768;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;100;1;New Amplify Shader;f4f273c3bb6262d4396be458405e60f9;True;VolumePass2;0;2;VolumePass2;2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;RenderType=Opaque=RenderType;False;False;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;1;LightMode=VolumePass2;True;2;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;418;64,-640;Float;False;False;-1;2;AmplifyShaderEditor.MaterialInspector;100;2;New Amplify Shader;f4f273c3bb6262d4396be458405e60f9;True;VisualPass;0;3;VisualPass;2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;RenderType=Opaque=RenderType;False;False;0;True;True;2;5;False;;10;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;2;False;;True;0;False;;True;False;0;False;;0;False;;True;1;False;;False;True;2;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;417;64,-768;Float;False;True;-1;2;TheVisualEngine.ElementGUI;100;2;Hidden/BOXOPHOBIC/The Visual Engine/Elements/Flow Interaction (Legacy);f4f273c3bb6262d4396be458405e60f9;True;VolumePass;0;0;VolumePass;2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;DisableBatching=True=DisableBatching;False;False;0;True;True;2;5;False;;10;False;;2;5;False;;10;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;True;True;True;True;True;False;0;False;_render_colormask;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;2;False;;True;0;False;;True;False;0;False;;0;False;;True;1;False;;True;1;LightMode=VolumePass;True;2;False;0;;0;0;Standard;3;VolumePass1;0;0;VolumePass2;0;0;Vertex Position;1;0;0;4;True;False;False;True;False;;False;0
WireConnection;638;1974;642;4
WireConnection;643;59;638;1779
WireConnection;418;0;643;0
WireConnection;417;0;638;0
ASEEND*/
//CHKSM=71EEB9B4DF97C8F620134ED217B3A8FD5929C3D3