// Upgrade NOTE: upgraded instancing buffer 'HiddenBOXOPHOBICTheVisualEngineElementsFlowInteractionLegacy' to new syntax.

// Made with Amplify Shader Editor v1.9.9.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Visual Engine/Elements/Flow Interaction (Legacy)"
{
	Properties
	{
		[StyledMessage(Info, Use the Motion elements to control the wind intensity locally. Element Texture R and Particle Color R are used as value multipliers. Element Texture A and Particle Color A are used as alpha masks., 0, 15)] _ElementMessage( "Element Message", Float ) = 0
		_ElementIntensity( "Render Intensity", Range( 0, 1 ) ) = 1
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
			ColorMask [_render_colormask]
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

			uniform half _ElementMessage;
			uniform float _SpeedTresholdValue;
			uniform half _ElementCategory;
			uniform half _ElementEnd;
			uniform half _RenderEnd;
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
				float2 appendResult60_g77130 = (float2(ase_positionWS.x , ase_positionWS.z));
				float2 lerpResult58_g77130 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult60_g77130 , _ElementMaskCoordMode);
				float2 vertexToFrag11_g77133 = ( ( lerpResult58_g77130 * (_ElementMaskCoordValue).xy ) + (_ElementMaskCoordValue).zw );
				o.ase_texcoord3.xy = vertexToFrag11_g77133;
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
				half2 Direction_Transform1406_g77104 = (( mul( unity_ObjectToWorld, float4( float3( 0, 0, 1 ) , 0.0 ) ).xyz / ase_objectScale )).xz;
				half4 MainTex_RGBA587_g77104 = tex2D( _MainTex, ( 1.0 - i.ase_texcoord1.xy ) );
				float3 temp_output_6_0_g77124 = (MainTex_RGBA587_g77104).rgb;
				half SpaceTexture2395_g77104 = _SpaceTexture;
				float temp_output_7_0_g77124 = SpaceTexture2395_g77104;
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g77124 = ( temp_output_6_0_g77124 + temp_output_7_0_g77124 );
				#else
				float3 staticSwitch14_g77124 = temp_output_6_0_g77124;
				#endif
				float3 temp_cast_2 = (0.0001).xxx;
				float3 temp_cast_3 = (0.9999).xxx;
				float3 clampResult17_g77119 = clamp( staticSwitch14_g77124 , temp_cast_2 , temp_cast_3 );
				float temp_output_7_0_g77122 = _MainTexColorRemap.x;
				float3 temp_cast_4 = (temp_output_7_0_g77122).xxx;
				float3 temp_output_9_0_g77122 = ( clampResult17_g77119 - temp_cast_4 );
				float3 temp_output_1765_0_g77104 = saturate( ( temp_output_9_0_g77122 * _MainTexColorRemap.z ) );
				half Element_Remap_R73_g77104 = (temp_output_1765_0_g77104).x;
				half Element_Remap_G265_g77104 = (temp_output_1765_0_g77104).y;
				float3 appendResult274_g77104 = (float3((Element_Remap_R73_g77104*2.0 + -1.0) , 0.0 , (Element_Remap_G265_g77104*2.0 + -1.0)));
				float3 break281_g77104 = ( mul( unity_ObjectToWorld, float4( appendResult274_g77104 , 0.0 ) ).xyz / ase_objectScale );
				float2 appendResult1403_g77104 = (float2(break281_g77104.x , break281_g77104.z));
				half2 Direction_Texture284_g77104 = appendResult1403_g77104;
				float2 appendResult1404_g77104 = (float2(i.ase_color.r , i.ase_color.g));
				half2 Direction_VertexColor1150_g77104 = (appendResult1404_g77104*2.0 + -1.0);
				float2 appendResult1382_g77104 = (float2(i.ase_texcoord1.z , i.ase_texcoord2.x));
				half2 Direction_Velocity1394_g77104 = ( appendResult1382_g77104 / i.ase_texcoord2.y );
				float2 temp_output_1452_0_g77104 = ( ( _motion_direction_mode.x * Direction_Transform1406_g77104 ) + ( _motion_direction_mode.y * Direction_Texture284_g77104 ) + ( _motion_direction_mode.z * Direction_VertexColor1150_g77104 ) + ( _motion_direction_mode.w * Direction_Velocity1394_g77104 ) );
				half Element_InvertMode489_g77104 = _ElementInvertMode;
				float2 lerpResult1468_g77104 = lerp( temp_output_1452_0_g77104 , -temp_output_1452_0_g77104 , Element_InvertMode489_g77104);
				half2 Direction_Advanced1454_g77104 = lerpResult1468_g77104;
				half2 Motion_Coords2098_g77104 = -(( WorldPosition - TVE_WorldOrigin )).xz;
				half2 Motion_Tilling1409_g77104 = ( Motion_Coords2098_g77104 * 0.005 * _MotionTillingValue );
				float2 Input_Coords80_g77142 = Motion_Tilling1409_g77104;
				half2 Input_Direction82_g77142 = Direction_Advanced1454_g77104;
				float mulTime113_g77146 = _Time.y * 0.02;
				float lerpResult128_g77146 = lerp( mulTime113_g77146 , ( ( mulTime113_g77146 * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				float Input_Time88_g77142 = (lerpResult128_g77146*_MotionSpeedValue + _MotionPhaseValue);
				float temp_output_23_0_g77142 = frac( Input_Time88_g77142 );
				float4 lerpResult39_g77142 = lerp( tex2D( _MotionTex, ( Input_Coords80_g77142 + ( Input_Direction82_g77142 * temp_output_23_0_g77142 ) ) ) , tex2D( _MotionTex, ( Input_Coords80_g77142 + ( Input_Direction82_g77142 * frac( ( Input_Time88_g77142 + 0.5 ) ) ) ) ) , ( abs( ( temp_output_23_0_g77142 - 0.5 ) ) / 0.5 ));
				float4 temp_output_1423_0_g77104 = lerpResult39_g77142;
				half2 Motion_FlowRG1427_g77104 = ((temp_output_1423_0_g77104).rg*2.0 + -1.0);
				half Motion_Noise2056_g77104 = _MotionNoiseValue;
				float2 lerpResult2141_g77104 = lerp( Direction_Advanced1454_g77104 , Motion_FlowRG1427_g77104 , Motion_Noise2056_g77104);
				float2 temp_cast_7 = (0.001).xx;
				float2 temp_cast_8 = (0.999).xx;
				float2 clampResult2359_g77104 = clamp( (lerpResult2141_g77104*0.5 + 0.5) , temp_cast_7 , temp_cast_8 );
				float3 appendResult1436_g77104 = (float3(clampResult2359_g77104 , Motion_Noise2056_g77104));
				half3 Final_MotionAdvanced_RGB1438_g77104 = appendResult1436_g77104;
				float temp_output_6_0_g77125 = (MainTex_RGBA587_g77104).a;
				float temp_output_7_0_g77125 = SpaceTexture2395_g77104;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77125 = ( temp_output_6_0_g77125 + temp_output_7_0_g77125 );
				#else
				float staticSwitch14_g77125 = temp_output_6_0_g77125;
				#endif
				float clampResult17_g77120 = clamp( staticSwitch14_g77125 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77123 = _MainTexAlphaRemap.x;
				float temp_output_9_0_g77123 = ( clampResult17_g77120 - temp_output_7_0_g77123 );
				half Element_Remap_A74_g77104 = saturate( ( temp_output_9_0_g77123 * _MainTexAlphaRemap.z ) );
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half Element_Params_A1737_g77104 = _ElementParams_Instance.w;
				float temp_output_6_0_g77127 = saturate( ( 1.0 - distance( (i.ase_texcoord1.xy*2.0 + -1.0) , float2( 0,0 ) ) ) );
				float temp_output_7_0_g77127 = SpaceTexture2395_g77104;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77127 = ( temp_output_6_0_g77127 + temp_output_7_0_g77127 );
				#else
				float staticSwitch14_g77127 = temp_output_6_0_g77127;
				#endif
				float clampResult17_g77126 = clamp( staticSwitch14_g77127 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77117 = _MainTexFalloffRemap.x;
				float temp_output_9_0_g77117 = ( clampResult17_g77126 - temp_output_7_0_g77117 );
				half Element_Falloff1883_g77104 = saturate( ( temp_output_9_0_g77117 * _MainTexFalloffRemap.z ) );
				float temp_output_7_0_g77109 = 1.0;
				float temp_output_9_0_g77109 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g77109 );
				float lerpResult18_g77107 = lerp( 1.0 , saturate( ( temp_output_9_0_g77109 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g77109 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g77107 = lerpResult18_g77107;
				float temp_output_6_0_g77110 = Blend_Edge69_g77107;
				half Dummy72_g77107 = ( _BoundsCategory + _BoundsEnd );
				float temp_output_7_0_g77110 = Dummy72_g77107;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77110 = ( temp_output_6_0_g77110 + temp_output_7_0_g77110 );
				#else
				float staticSwitch14_g77110 = temp_output_6_0_g77110;
				#endif
				float2 vertexToFrag11_g77133 = i.ase_texcoord3.xy;
				half4 MainTex_RGBA53_g77130 = tex2D( _ElementMaskTex, vertexToFrag11_g77133 );
				float lerpResult148_g77130 = lerp( (MainTex_RGBA53_g77130).r , (MainTex_RGBA53_g77130).a , _ElementMaskMode);
				float clampResult17_g77139 = clamp( lerpResult148_g77130 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77140 = _ElementMaskRemap.x;
				float temp_output_9_0_g77140 = ( clampResult17_g77139 - temp_output_7_0_g77140 );
				float lerpResult73_g77130 = lerp( 1.0 , saturate( ( temp_output_9_0_g77140 * _ElementMaskRemap.z ) ) , _ElementMaskValue);
				half Blend_Mask45_g77130 = lerpResult73_g77130;
				#ifdef TVE_ELEMENT_MASK
				float staticSwitch159_g77130 = Blend_Mask45_g77130;
				#else
				float staticSwitch159_g77130 = 1.0;
				#endif
				float3 ase_normalWS = i.ase_texcoord4.xyz;
				float4 appendResult108_g77130 = (float4(_TerrainPosition.x , _TerrainPosition.z , _TerrainSize.x , _TerrainSize.z));
				half4 Terrain_Coords111_g77130 = appendResult108_g77130;
				float4 temp_output_35_0_g77138 = Terrain_Coords111_g77130;
				float2 InputScale48_g77138 = (temp_output_35_0_g77138).zw;
				half2 FinalScale53_g77138 = ( 1.0 / InputScale48_g77138 );
				float2 InputPosition52_g77138 = (temp_output_35_0_g77138).xy;
				half2 FinalPosition58_g77138 = -( FinalScale53_g77138 * InputPosition52_g77138 );
				float2 temp_output_65_0_g77138 = ( ( (WorldPosition).xz * FinalScale53_g77138 ) + FinalPosition58_g77138 );
				half Terrain_InputMode136_g77130 = _TerrainInputMode;
				float3 lerpResult141_g77130 = lerp( ase_normalWS , tex2D( _TerrainNormalTex, temp_output_65_0_g77138 ).rgb , Terrain_InputMode136_g77130);
				float3 Terrain_Normal107_g77130 = lerpResult141_g77130;
				float dotResult113_g77130 = dot( Terrain_Normal107_g77130 , half3( 0, 1, 0 ) );
				float clampResult17_g77135 = clamp( dotResult113_g77130 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77136 = _ElementProjRemap.x;
				float temp_output_9_0_g77136 = ( clampResult17_g77135 - temp_output_7_0_g77136 );
				float lerpResult123_g77130 = lerp( 1.0 , saturate( ( temp_output_9_0_g77136 * _ElementProjRemap.z ) ) , _ElementProjValue);
				half Blend_Proj117_g77130 = lerpResult123_g77130;
				#ifdef TVE_ELEMENT_PROJ
				float staticSwitch160_g77130 = Blend_Proj117_g77130;
				#else
				float staticSwitch160_g77130 = 1.0;
				#endif
				float4 temp_output_35_0_g77131 = Terrain_Coords111_g77130;
				float2 InputScale48_g77131 = (temp_output_35_0_g77131).zw;
				half2 FinalScale53_g77131 = ( 1.0 / InputScale48_g77131 );
				float2 InputPosition52_g77131 = (temp_output_35_0_g77131).xy;
				half2 FinalPosition58_g77131 = -( FinalScale53_g77131 * InputPosition52_g77131 );
				float2 temp_output_65_0_g77131 = ( ( (WorldPosition).xz * FinalScale53_g77131 ) + FinalPosition58_g77131 );
				float4 temp_output_70_0_g77131 = _TerrainHeightTex_TexelSize;
				float2 InputTexelSize68_g77131 = (temp_output_70_0_g77131).zw;
				float2 temp_cast_9 = (1.0).xx;
				float2 InputTexelRecip69_g77131 = (temp_output_70_0_g77131).xy;
				float4 Terrain_Height_Raw104_g77130 = tex2D( _TerrainHeightTex, ( ( ( temp_output_65_0_g77131 / ( 1.0 / ( InputTexelSize68_g77131 - temp_cast_9 ) ) ) + 0.5 ) * InputTexelRecip69_g77131 ) );
				float temp_output_90_0_g77130 = ( ( (Terrain_Height_Raw104_g77130).r + ( (Terrain_Height_Raw104_g77130).g * 256.0 ) ) / 257.0 );
				#ifdef SHADER_API_VULKAN
				float staticSwitch91_g77130 = temp_output_90_0_g77130;
				#else
				float staticSwitch91_g77130 = (Terrain_Height_Raw104_g77130).r;
				#endif
				#ifdef SHADER_API_GLES
				float staticSwitch92_g77130 = temp_output_90_0_g77130;
				#else
				float staticSwitch92_g77130 = staticSwitch91_g77130;
				#endif
				#ifdef SHADER_API_GLES3
				float staticSwitch93_g77130 = temp_output_90_0_g77130;
				#else
				float staticSwitch93_g77130 = staticSwitch92_g77130;
				#endif
				float Terrain_Height_Platform105_g77130 = staticSwitch93_g77130;
				float Terrain_SizeY109_g77130 = _TerrainSize.y;
				float Terrain_PosY110_g77130 = _TerrainPosition.y;
				float lerpResult137_g77130 = lerp( WorldPosition.y , ( ( Terrain_Height_Platform105_g77130 * Terrain_SizeY109_g77130 * 2.0 ) + Terrain_PosY110_g77130 ) , Terrain_InputMode136_g77130);
				float Terrain_Height106_g77130 = lerpResult137_g77130;
				float temp_output_7_0_g77137 = _ElementPosMaxValue;
				float temp_output_9_0_g77137 = ( Terrain_Height106_g77130 - temp_output_7_0_g77137 );
				float lerpResult129_g77130 = lerp( 1.0 , saturate( ( temp_output_9_0_g77137 / ( ( _ElementPosMinValue - temp_output_7_0_g77137 ) + 0.0001 ) ) ) , _ElementPosValue);
				half Blend_Pos131_g77130 = lerpResult129_g77130;
				#ifdef TVE_ELEMENT_POS
				float staticSwitch161_g77130 = Blend_Pos131_g77130;
				#else
				float staticSwitch161_g77130 = 1.0;
				#endif
				float temp_output_6_0_g77141 = ( staticSwitch159_g77130 * staticSwitch160_g77130 * staticSwitch161_g77130 );
				half Dummy144_g77130 = ( _MaskingCategory + _MaskingEnd + ( _MaskingTerrainInfo + _MaskingModelInfo ) );
				float temp_output_7_0_g77141 = Dummy144_g77130;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77141 = ( temp_output_6_0_g77141 + temp_output_7_0_g77141 );
				#else
				float staticSwitch14_g77141 = temp_output_6_0_g77141;
				#endif
				float temp_output_145_0_g77130 = staticSwitch14_g77141;
				float temp_output_6_0_g77116 = 1.0;
				float temp_output_7_0_g77116 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				float staticSwitch14_g77116 = ( temp_output_6_0_g77116 + temp_output_7_0_g77116 );
				#else
				float staticSwitch14_g77116 = temp_output_6_0_g77116;
				#endif
				half Element_Alpha56_g77104 = ( _ElementIntensity * Element_Remap_A74_g77104 * Element_Params_A1737_g77104 * i.ase_color.a * Element_Falloff1883_g77104 * staticSwitch14_g77110 * temp_output_145_0_g77130 * staticSwitch14_g77116 );
				half Final_MotionAdvanced_A1439_g77104 = Element_Alpha56_g77104;
				float4 appendResult1463_g77104 = (float4(Final_MotionAdvanced_RGB1438_g77104 , Final_MotionAdvanced_A1439_g77104));
				float4 temp_output_6_0_g77128 = appendResult1463_g77104;
				half Motion_Direction1013_g77104 = _MotionDirectionMode;
				float temp_output_7_0_g77128 = Motion_Direction1013_g77104;
				#ifdef TVE_DUMMY
				float4 staticSwitch14_g77128 = ( temp_output_6_0_g77128 + temp_output_7_0_g77128 );
				#else
				float4 staticSwitch14_g77128 = temp_output_6_0_g77128;
				#endif
				
				
				finalColor = staticSwitch14_g77128;
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

			uniform half _ElementMessage;
			uniform float _SpeedTresholdValue;
			uniform half _ElementCategory;
			uniform half _ElementEnd;
			uniform half _RenderEnd;
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
				float2 appendResult60_g77130 = (float2(ase_positionWS.x , ase_positionWS.z));
				float2 lerpResult58_g77130 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult60_g77130 , _ElementMaskCoordMode);
				float2 vertexToFrag11_g77133 = ( ( lerpResult58_g77130 * (_ElementMaskCoordValue).xy ) + (_ElementMaskCoordValue).zw );
				o.ase_texcoord3.xy = vertexToFrag11_g77133;
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
				half2 Direction_Transform1406_g77104 = (( mul( unity_ObjectToWorld, float4( float3( 0, 0, 1 ) , 0.0 ) ).xyz / ase_objectScale )).xz;
				half4 MainTex_RGBA587_g77104 = tex2D( _MainTex, ( 1.0 - i.ase_texcoord1.xy ) );
				float3 temp_output_6_0_g77124 = (MainTex_RGBA587_g77104).rgb;
				half SpaceTexture2395_g77104 = _SpaceTexture;
				float temp_output_7_0_g77124 = SpaceTexture2395_g77104;
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g77124 = ( temp_output_6_0_g77124 + temp_output_7_0_g77124 );
				#else
				float3 staticSwitch14_g77124 = temp_output_6_0_g77124;
				#endif
				float3 temp_cast_2 = (0.0001).xxx;
				float3 temp_cast_3 = (0.9999).xxx;
				float3 clampResult17_g77119 = clamp( staticSwitch14_g77124 , temp_cast_2 , temp_cast_3 );
				float temp_output_7_0_g77122 = _MainTexColorRemap.x;
				float3 temp_cast_4 = (temp_output_7_0_g77122).xxx;
				float3 temp_output_9_0_g77122 = ( clampResult17_g77119 - temp_cast_4 );
				float3 temp_output_1765_0_g77104 = saturate( ( temp_output_9_0_g77122 * _MainTexColorRemap.z ) );
				half Element_Remap_R73_g77104 = (temp_output_1765_0_g77104).x;
				half Element_Remap_G265_g77104 = (temp_output_1765_0_g77104).y;
				float3 appendResult274_g77104 = (float3((Element_Remap_R73_g77104*2.0 + -1.0) , 0.0 , (Element_Remap_G265_g77104*2.0 + -1.0)));
				float3 break281_g77104 = ( mul( unity_ObjectToWorld, float4( appendResult274_g77104 , 0.0 ) ).xyz / ase_objectScale );
				float2 appendResult1403_g77104 = (float2(break281_g77104.x , break281_g77104.z));
				half2 Direction_Texture284_g77104 = appendResult1403_g77104;
				float2 appendResult1404_g77104 = (float2(i.ase_color.r , i.ase_color.g));
				half2 Direction_VertexColor1150_g77104 = (appendResult1404_g77104*2.0 + -1.0);
				float2 appendResult1382_g77104 = (float2(i.ase_texcoord1.z , i.ase_texcoord2.x));
				half2 Direction_Velocity1394_g77104 = ( appendResult1382_g77104 / i.ase_texcoord2.y );
				float2 temp_output_1452_0_g77104 = ( ( _motion_direction_mode.x * Direction_Transform1406_g77104 ) + ( _motion_direction_mode.y * Direction_Texture284_g77104 ) + ( _motion_direction_mode.z * Direction_VertexColor1150_g77104 ) + ( _motion_direction_mode.w * Direction_Velocity1394_g77104 ) );
				half Element_InvertMode489_g77104 = _ElementInvertMode;
				float2 lerpResult1468_g77104 = lerp( temp_output_1452_0_g77104 , -temp_output_1452_0_g77104 , Element_InvertMode489_g77104);
				half2 Direction_Advanced1454_g77104 = lerpResult1468_g77104;
				half2 Motion_Coords2098_g77104 = -(( WorldPosition - TVE_WorldOrigin )).xz;
				half2 Motion_Tilling1409_g77104 = ( Motion_Coords2098_g77104 * 0.005 * _MotionTillingValue );
				float2 Input_Coords80_g77142 = Motion_Tilling1409_g77104;
				half2 Input_Direction82_g77142 = Direction_Advanced1454_g77104;
				float mulTime113_g77146 = _Time.y * 0.02;
				float lerpResult128_g77146 = lerp( mulTime113_g77146 , ( ( mulTime113_g77146 * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				float Input_Time88_g77142 = (lerpResult128_g77146*_MotionSpeedValue + _MotionPhaseValue);
				float temp_output_23_0_g77142 = frac( Input_Time88_g77142 );
				float4 lerpResult39_g77142 = lerp( tex2D( _MotionTex, ( Input_Coords80_g77142 + ( Input_Direction82_g77142 * temp_output_23_0_g77142 ) ) ) , tex2D( _MotionTex, ( Input_Coords80_g77142 + ( Input_Direction82_g77142 * frac( ( Input_Time88_g77142 + 0.5 ) ) ) ) ) , ( abs( ( temp_output_23_0_g77142 - 0.5 ) ) / 0.5 ));
				float4 temp_output_1423_0_g77104 = lerpResult39_g77142;
				half2 Motion_FlowRG1427_g77104 = ((temp_output_1423_0_g77104).rg*2.0 + -1.0);
				half Motion_Noise2056_g77104 = _MotionNoiseValue;
				float2 lerpResult2141_g77104 = lerp( Direction_Advanced1454_g77104 , Motion_FlowRG1427_g77104 , Motion_Noise2056_g77104);
				float2 temp_cast_7 = (0.001).xx;
				float2 temp_cast_8 = (0.999).xx;
				float2 clampResult2359_g77104 = clamp( (lerpResult2141_g77104*0.5 + 0.5) , temp_cast_7 , temp_cast_8 );
				float3 appendResult1436_g77104 = (float3(clampResult2359_g77104 , Motion_Noise2056_g77104));
				half3 Final_MotionAdvanced_Visual2200_g77104 = appendResult1436_g77104;
				float temp_output_6_0_g77125 = (MainTex_RGBA587_g77104).a;
				float temp_output_7_0_g77125 = SpaceTexture2395_g77104;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77125 = ( temp_output_6_0_g77125 + temp_output_7_0_g77125 );
				#else
				float staticSwitch14_g77125 = temp_output_6_0_g77125;
				#endif
				float clampResult17_g77120 = clamp( staticSwitch14_g77125 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77123 = _MainTexAlphaRemap.x;
				float temp_output_9_0_g77123 = ( clampResult17_g77120 - temp_output_7_0_g77123 );
				half Element_Remap_A74_g77104 = saturate( ( temp_output_9_0_g77123 * _MainTexAlphaRemap.z ) );
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half Element_Params_A1737_g77104 = _ElementParams_Instance.w;
				float temp_output_6_0_g77127 = saturate( ( 1.0 - distance( (i.ase_texcoord1.xy*2.0 + -1.0) , float2( 0,0 ) ) ) );
				float temp_output_7_0_g77127 = SpaceTexture2395_g77104;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77127 = ( temp_output_6_0_g77127 + temp_output_7_0_g77127 );
				#else
				float staticSwitch14_g77127 = temp_output_6_0_g77127;
				#endif
				float clampResult17_g77126 = clamp( staticSwitch14_g77127 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77117 = _MainTexFalloffRemap.x;
				float temp_output_9_0_g77117 = ( clampResult17_g77126 - temp_output_7_0_g77117 );
				half Element_Falloff1883_g77104 = saturate( ( temp_output_9_0_g77117 * _MainTexFalloffRemap.z ) );
				float temp_output_7_0_g77109 = 1.0;
				float temp_output_9_0_g77109 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g77109 );
				float lerpResult18_g77107 = lerp( 1.0 , saturate( ( temp_output_9_0_g77109 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g77109 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g77107 = lerpResult18_g77107;
				float temp_output_6_0_g77110 = Blend_Edge69_g77107;
				half Dummy72_g77107 = ( _BoundsCategory + _BoundsEnd );
				float temp_output_7_0_g77110 = Dummy72_g77107;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77110 = ( temp_output_6_0_g77110 + temp_output_7_0_g77110 );
				#else
				float staticSwitch14_g77110 = temp_output_6_0_g77110;
				#endif
				float2 vertexToFrag11_g77133 = i.ase_texcoord3.xy;
				half4 MainTex_RGBA53_g77130 = tex2D( _ElementMaskTex, vertexToFrag11_g77133 );
				float lerpResult148_g77130 = lerp( (MainTex_RGBA53_g77130).r , (MainTex_RGBA53_g77130).a , _ElementMaskMode);
				float clampResult17_g77139 = clamp( lerpResult148_g77130 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77140 = _ElementMaskRemap.x;
				float temp_output_9_0_g77140 = ( clampResult17_g77139 - temp_output_7_0_g77140 );
				float lerpResult73_g77130 = lerp( 1.0 , saturate( ( temp_output_9_0_g77140 * _ElementMaskRemap.z ) ) , _ElementMaskValue);
				half Blend_Mask45_g77130 = lerpResult73_g77130;
				#ifdef TVE_ELEMENT_MASK
				float staticSwitch159_g77130 = Blend_Mask45_g77130;
				#else
				float staticSwitch159_g77130 = 1.0;
				#endif
				float3 ase_normalWS = i.ase_texcoord4.xyz;
				float4 appendResult108_g77130 = (float4(_TerrainPosition.x , _TerrainPosition.z , _TerrainSize.x , _TerrainSize.z));
				half4 Terrain_Coords111_g77130 = appendResult108_g77130;
				float4 temp_output_35_0_g77138 = Terrain_Coords111_g77130;
				float2 InputScale48_g77138 = (temp_output_35_0_g77138).zw;
				half2 FinalScale53_g77138 = ( 1.0 / InputScale48_g77138 );
				float2 InputPosition52_g77138 = (temp_output_35_0_g77138).xy;
				half2 FinalPosition58_g77138 = -( FinalScale53_g77138 * InputPosition52_g77138 );
				float2 temp_output_65_0_g77138 = ( ( (WorldPosition).xz * FinalScale53_g77138 ) + FinalPosition58_g77138 );
				half Terrain_InputMode136_g77130 = _TerrainInputMode;
				float3 lerpResult141_g77130 = lerp( ase_normalWS , tex2D( _TerrainNormalTex, temp_output_65_0_g77138 ).rgb , Terrain_InputMode136_g77130);
				float3 Terrain_Normal107_g77130 = lerpResult141_g77130;
				float dotResult113_g77130 = dot( Terrain_Normal107_g77130 , half3( 0, 1, 0 ) );
				float clampResult17_g77135 = clamp( dotResult113_g77130 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77136 = _ElementProjRemap.x;
				float temp_output_9_0_g77136 = ( clampResult17_g77135 - temp_output_7_0_g77136 );
				float lerpResult123_g77130 = lerp( 1.0 , saturate( ( temp_output_9_0_g77136 * _ElementProjRemap.z ) ) , _ElementProjValue);
				half Blend_Proj117_g77130 = lerpResult123_g77130;
				#ifdef TVE_ELEMENT_PROJ
				float staticSwitch160_g77130 = Blend_Proj117_g77130;
				#else
				float staticSwitch160_g77130 = 1.0;
				#endif
				float4 temp_output_35_0_g77131 = Terrain_Coords111_g77130;
				float2 InputScale48_g77131 = (temp_output_35_0_g77131).zw;
				half2 FinalScale53_g77131 = ( 1.0 / InputScale48_g77131 );
				float2 InputPosition52_g77131 = (temp_output_35_0_g77131).xy;
				half2 FinalPosition58_g77131 = -( FinalScale53_g77131 * InputPosition52_g77131 );
				float2 temp_output_65_0_g77131 = ( ( (WorldPosition).xz * FinalScale53_g77131 ) + FinalPosition58_g77131 );
				float4 temp_output_70_0_g77131 = _TerrainHeightTex_TexelSize;
				float2 InputTexelSize68_g77131 = (temp_output_70_0_g77131).zw;
				float2 temp_cast_9 = (1.0).xx;
				float2 InputTexelRecip69_g77131 = (temp_output_70_0_g77131).xy;
				float4 Terrain_Height_Raw104_g77130 = tex2D( _TerrainHeightTex, ( ( ( temp_output_65_0_g77131 / ( 1.0 / ( InputTexelSize68_g77131 - temp_cast_9 ) ) ) + 0.5 ) * InputTexelRecip69_g77131 ) );
				float temp_output_90_0_g77130 = ( ( (Terrain_Height_Raw104_g77130).r + ( (Terrain_Height_Raw104_g77130).g * 256.0 ) ) / 257.0 );
				#ifdef SHADER_API_VULKAN
				float staticSwitch91_g77130 = temp_output_90_0_g77130;
				#else
				float staticSwitch91_g77130 = (Terrain_Height_Raw104_g77130).r;
				#endif
				#ifdef SHADER_API_GLES
				float staticSwitch92_g77130 = temp_output_90_0_g77130;
				#else
				float staticSwitch92_g77130 = staticSwitch91_g77130;
				#endif
				#ifdef SHADER_API_GLES3
				float staticSwitch93_g77130 = temp_output_90_0_g77130;
				#else
				float staticSwitch93_g77130 = staticSwitch92_g77130;
				#endif
				float Terrain_Height_Platform105_g77130 = staticSwitch93_g77130;
				float Terrain_SizeY109_g77130 = _TerrainSize.y;
				float Terrain_PosY110_g77130 = _TerrainPosition.y;
				float lerpResult137_g77130 = lerp( WorldPosition.y , ( ( Terrain_Height_Platform105_g77130 * Terrain_SizeY109_g77130 * 2.0 ) + Terrain_PosY110_g77130 ) , Terrain_InputMode136_g77130);
				float Terrain_Height106_g77130 = lerpResult137_g77130;
				float temp_output_7_0_g77137 = _ElementPosMaxValue;
				float temp_output_9_0_g77137 = ( Terrain_Height106_g77130 - temp_output_7_0_g77137 );
				float lerpResult129_g77130 = lerp( 1.0 , saturate( ( temp_output_9_0_g77137 / ( ( _ElementPosMinValue - temp_output_7_0_g77137 ) + 0.0001 ) ) ) , _ElementPosValue);
				half Blend_Pos131_g77130 = lerpResult129_g77130;
				#ifdef TVE_ELEMENT_POS
				float staticSwitch161_g77130 = Blend_Pos131_g77130;
				#else
				float staticSwitch161_g77130 = 1.0;
				#endif
				float temp_output_6_0_g77141 = ( staticSwitch159_g77130 * staticSwitch160_g77130 * staticSwitch161_g77130 );
				half Dummy144_g77130 = ( _MaskingCategory + _MaskingEnd + ( _MaskingTerrainInfo + _MaskingModelInfo ) );
				float temp_output_7_0_g77141 = Dummy144_g77130;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77141 = ( temp_output_6_0_g77141 + temp_output_7_0_g77141 );
				#else
				float staticSwitch14_g77141 = temp_output_6_0_g77141;
				#endif
				float temp_output_145_0_g77130 = staticSwitch14_g77141;
				float temp_output_6_0_g77116 = 1.0;
				float temp_output_7_0_g77116 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				float staticSwitch14_g77116 = ( temp_output_6_0_g77116 + temp_output_7_0_g77116 );
				#else
				float staticSwitch14_g77116 = temp_output_6_0_g77116;
				#endif
				half Element_Alpha56_g77104 = ( _ElementIntensity * Element_Remap_A74_g77104 * Element_Params_A1737_g77104 * i.ase_color.a * Element_Falloff1883_g77104 * staticSwitch14_g77110 * temp_output_145_0_g77130 * staticSwitch14_g77116 );
				half Final_MotionAdvanced_A1439_g77104 = Element_Alpha56_g77104;
				float4 appendResult2474_g77104 = (float4(Final_MotionAdvanced_Visual2200_g77104 , Final_MotionAdvanced_A1439_g77104));
				
				
				finalColor = appendResult2474_g77104;
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
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;639;-640,-768;Inherit;False;Element Push;-1;;77101;;0;0;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;416;-64,-1280;Inherit;False;Element Compile;-1;;77103;5302407fc6d65554791e558e67d59358;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;636;-640,-1280;Half;False;Property;_ElementMessage;Element Message;0;0;Create;True;0;0;0;True;1;StyledMessage(Info, Use the Motion elements to control the wind intensity locally. Element Texture R and Particle Color R are used as value multipliers. Element Texture A and Particle Color A are used as alpha masks., 0, 15);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;638;-384,-768;Inherit;False;Element Shader;1;;77104;0e972c73cae2ee54ea51acc9738801d0;14,477,2,1778,2,478,0,1824,0,1814,1,145,1,481,1,1784,1,2346,1,1904,0,1907,1,2377,1,2310,1,2311,1;2;1974;FLOAT;0;False;2378;FLOAT;1;False;2;FLOAT4;0;FLOAT4;1779
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;417;-64,-768;Float;False;True;-1;2;TheVisualEngine.ElementGUI;100;2;Hidden/BOXOPHOBIC/The Visual Engine/Elements/Flow Interaction (Legacy);f4f273c3bb6262d4396be458405e60f9;True;VolumePass;0;0;VolumePass;2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;DisableBatching=True=DisableBatching;False;False;0;True;True;2;5;False;;10;False;;2;5;False;;10;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;True;True;True;True;False;True;0;True;_render_colormask;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;2;False;;True;0;False;;True;False;0;False;;0;False;;True;1;False;;True;1;LightMode=VolumePass;True;2;False;0;;0;0;Standard;3;VolumePass1;0;0;VolumePass2;0;0;Vertex Position;1;0;0;4;True;False;False;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;418;-64,-400;Float;False;False;-1;2;AmplifyShaderEditor.MaterialInspector;100;2;New Amplify Shader;f4f273c3bb6262d4396be458405e60f9;True;VisualPass;0;3;VisualPass;2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;RenderType=Opaque=RenderType;False;False;0;True;True;2;5;False;;10;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;2;False;;True;0;False;;True;False;0;False;;0;False;;True;1;False;;False;True;2;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;640;-64,-768;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;100;1;New Amplify Shader;f4f273c3bb6262d4396be458405e60f9;True;VolumePass1;0;1;VolumePass1;2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;RenderType=Opaque=RenderType;False;False;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;1;LightMode=VolumePass1;True;2;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;641;-64,-768;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;100;1;New Amplify Shader;f4f273c3bb6262d4396be458405e60f9;True;VolumePass2;0;2;VolumePass2;2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;RenderType=Opaque=RenderType;False;False;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;1;LightMode=VolumePass2;True;2;False;0;;0;0;Standard;0;False;0
WireConnection;417;0;638;0
WireConnection;418;0;638;1779
ASEEND*/
//CHKSM=D928B6455F3F61D8B7E20CB0D9F59F70A2D08399