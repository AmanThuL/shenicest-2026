// Upgrade NOTE: upgraded instancing buffer 'BOXOPHOBICTheVisualEngineElementsFlowIntensity' to new syntax.

// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Elements/Flow Intensity"
{
	Properties
	{
		[StyledMessage(Info, Use Motion Intensity elements to control the wind intensity locally. Element Texture R and Particle Color R are used as value multipliers. Element Texture A and Particle Color A are used as alpha masks., 0, 15)] _ElementMessage( "Element Message", Float ) = 0
		[HideInInspector] _IsVersion( "_IsVersion", Float ) = 2200
		[HideInInspector] _IsElementShader( "_IsElementShader", Float ) = 1
		[HideInInspector] _IsIdentifier( "_IsIdentifier", Float ) = 0
		[StyledCategory(Render Settings, true, 0, 10)] _RenderCategory( "[ Render Category ]", Float ) = 1
		_ElementIntensity( "Render Intensity", Range( 0, 1 ) ) = 1
		[StyledMessage(Info, When using a higher Layer number the Global Volume will create more render textures to render the elements. Try using fewer layers when possible., _ElementLayerMessage, 1, 10, 10)] _ElementLayerMessage( "Render Layer Message", Float ) = 0
		[StyledMessage(Warning, When using all layers the Global Volume will create one render texture for each layer to render the elements. Try using fewer layers when possible., _ElementLayerWarning, 1, 10, 10)] _ElementLayerWarning( "Render Layer Warning", Float ) = 0
		[StyledMask(Flow Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _ElementLayerMask( "Render Layer", Float ) = 1
		[HideInInspector] _ElementParams( "Render Params", Vector ) = ( 1, 1, 1, 1 )
		[Enum(Constant,0,Seasons,1)] _ElementMode( "Render Mode", Float ) = 0
		[StyledSpace(10)] _RenderEnd( "[ Render End ]", Float ) = 0
		[StyledCategory(Element Settings, true, 0, 10)] _ElementCategory( "[ Element Category ]", Float ) = 1
		[NoScaleOffset][StyledTextureSingleLine] _MainTex( "Element Texture", 2D ) = "white" {}
		[StyledSpace(10)] _SpaceTexture( "#SpaceTexture", Float ) = 0
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
		[HideInInspector] _render_dst( "_render_dst", Float ) = 0

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
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_COLOR
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
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
			uniform float _render_src;
			uniform float _render_dst;
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
			uniform half _RaycastCategory;
			uniform half _RaycastEnd;
			uniform half _ElementRaycastMode;
			uniform half _RaycastLayerMask;
			uniform half _RaycastDistanceMinValue;
			uniform half _RaycastDistanceMaxValue;
			uniform half _RaycastDistanceCheckValue;
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsFlowIntensity)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr BOXOPHOBICTheVisualEngineElementsFlowIntensity
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsFlowIntensity)

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				half TVE_SeasonOptions_X50_g77547 = TVE_SeasonOption.x;
				half Value_Winter158_g77547 = _AdditionalValue1;
				half Value_Spring159_g77547 = _AdditionalValue2;
				float temp_output_7_0_g77558 = _SeasonRemap.x;
				float temp_output_9_0_g77558 = ( TVE_SeasonLerp - temp_output_7_0_g77558 );
				float smoothstepResult2286_g77547 = smoothstep( 0.0 , 1.0 , saturate( ( temp_output_9_0_g77558 * _SeasonRemap.z ) ));
				half SeasonLerp54_g77547 = smoothstepResult2286_g77547;
				float lerpResult168_g77547 = lerp( Value_Winter158_g77547 , Value_Spring159_g77547 , SeasonLerp54_g77547);
				half TVE_SeasonOptions_Y51_g77547 = TVE_SeasonOption.y;
				half Value_Summer160_g77547 = _AdditionalValue3;
				float lerpResult167_g77547 = lerp( Value_Spring159_g77547 , Value_Summer160_g77547 , SeasonLerp54_g77547);
				half TVE_SeasonOptions_Z52_g77547 = TVE_SeasonOption.z;
				half Value_Autumn161_g77547 = _AdditionalValue4;
				float lerpResult166_g77547 = lerp( Value_Summer160_g77547 , Value_Autumn161_g77547 , SeasonLerp54_g77547);
				half TVE_SeasonOptions_W53_g77547 = TVE_SeasonOption.w;
				float lerpResult165_g77547 = lerp( Value_Autumn161_g77547 , Value_Winter158_g77547 , SeasonLerp54_g77547);
				float temp_output_175_0_g77547 = ( ( TVE_SeasonOptions_X50_g77547 * lerpResult168_g77547 ) + ( TVE_SeasonOptions_Y51_g77547 * lerpResult167_g77547 ) + ( TVE_SeasonOptions_Z52_g77547 * lerpResult166_g77547 ) + ( TVE_SeasonOptions_W53_g77547 * lerpResult165_g77547 ) );
				float vertexToFrag11_g77552 = temp_output_175_0_g77547;
				o.ase_texcoord1.x = vertexToFrag11_g77552;
				
				o.ase_texcoord1.yz = v.ase_texcoord.xy;
				o.ase_color = v.color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.w = 0;
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
				half Value_Main157_g77547 = _MainValue;
				float vertexToFrag11_g77552 = i.ase_texcoord1.x;
				half Value_Seasons1721_g77547 = vertexToFrag11_g77552;
				half Element_Mode55_g77547 = _ElementMode;
				float lerpResult181_g77547 = lerp( Value_Main157_g77547 , Value_Seasons1721_g77547 , Element_Mode55_g77547);
				half4 MainTex_RGBA587_g77547 = tex2D( _MainTex, ( 1.0 - i.ase_texcoord1.yz ) );
				float3 temp_output_6_0_g77564 = (MainTex_RGBA587_g77547).rgb;
				half SpaceTexture2395_g77547 = _SpaceTexture;
				float temp_output_7_0_g77564 = SpaceTexture2395_g77547;
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g77564 = ( temp_output_6_0_g77564 + temp_output_7_0_g77564 );
				#else
				float3 staticSwitch14_g77564 = temp_output_6_0_g77564;
				#endif
				float3 temp_cast_0 = (0.0001).xxx;
				float3 temp_cast_1 = (0.9999).xxx;
				float3 clampResult17_g77559 = clamp( staticSwitch14_g77564 , temp_cast_0 , temp_cast_1 );
				float temp_output_7_0_g77562 = _MainTexColorRemap.x;
				float3 temp_cast_2 = (temp_output_7_0_g77562).xxx;
				float3 temp_output_9_0_g77562 = ( clampResult17_g77559 - temp_cast_2 );
				float3 temp_output_1765_0_g77547 = saturate( ( temp_output_9_0_g77562 * _MainTexColorRemap.z ) );
				half Element_Remap_R73_g77547 = (temp_output_1765_0_g77547).x;
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half Element_Params_R1738_g77547 = _ElementParams_Instance.x;
				half Element_Value1744_g77547 = ( Element_Remap_R73_g77547 * Element_Params_R1738_g77547 * i.ase_color.r );
				float temp_output_468_0_g77547 = ( lerpResult181_g77547 * Element_Value1744_g77547 );
				float3 appendResult2402_g77547 = (float3(temp_output_468_0_g77547 , temp_output_468_0_g77547 , temp_output_468_0_g77547));
				half3 FInal_RGB213_g77547 = appendResult2402_g77547;
				half Element_Intensity2580_g77547 = _ElementIntensity;
				float temp_output_6_0_g77565 = (MainTex_RGBA587_g77547).a;
				float temp_output_7_0_g77565 = SpaceTexture2395_g77547;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77565 = ( temp_output_6_0_g77565 + temp_output_7_0_g77565 );
				#else
				float staticSwitch14_g77565 = temp_output_6_0_g77565;
				#endif
				float clampResult17_g77560 = clamp( staticSwitch14_g77565 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77563 = _MainTexAlphaRemap.x;
				float temp_output_9_0_g77563 = ( clampResult17_g77560 - temp_output_7_0_g77563 );
				half Element_Remap_A74_g77547 = saturate( ( temp_output_9_0_g77563 * _MainTexAlphaRemap.z ) );
				half Element_Params_A1737_g77547 = _ElementParams_Instance.w;
				float temp_output_6_0_g77567 = saturate( ( 1.0 - distance( (i.ase_texcoord1.yz*2.0 + -1.0) , float2( 0,0 ) ) ) );
				float temp_output_7_0_g77567 = SpaceTexture2395_g77547;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77567 = ( temp_output_6_0_g77567 + temp_output_7_0_g77567 );
				#else
				float staticSwitch14_g77567 = temp_output_6_0_g77567;
				#endif
				float clampResult17_g77566 = clamp( staticSwitch14_g77567 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77557 = _MainTexFalloffRemap.x;
				float temp_output_9_0_g77557 = ( clampResult17_g77566 - temp_output_7_0_g77557 );
				half Element_Falloff1883_g77547 = saturate( ( temp_output_9_0_g77557 * _MainTexFalloffRemap.z ) );
				float temp_output_7_0_g77550 = 1.0;
				float temp_output_9_0_g77550 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g77550 );
				float lerpResult18_g77548 = lerp( 1.0 , saturate( ( temp_output_9_0_g77550 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g77550 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g77548 = lerpResult18_g77548;
				float temp_output_6_0_g77551 = Blend_Edge69_g77548;
				half Dummy72_g77548 = ( _BoundsCategory + _BoundsEnd );
				float temp_output_7_0_g77551 = Dummy72_g77548;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77551 = ( temp_output_6_0_g77551 + temp_output_7_0_g77551 );
				#else
				float staticSwitch14_g77551 = temp_output_6_0_g77551;
				#endif
				float temp_output_6_0_g77556 = 1.0;
				float temp_output_7_0_g77556 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				float staticSwitch14_g77556 = ( temp_output_6_0_g77556 + temp_output_7_0_g77556 );
				#else
				float staticSwitch14_g77556 = temp_output_6_0_g77556;
				#endif
				half Element_Alpha56_g77547 = ( Element_Intensity2580_g77547 * Element_Remap_A74_g77547 * Element_Params_A1737_g77547 * i.ase_color.a * Element_Falloff1883_g77547 * staticSwitch14_g77551 * 1.0 * staticSwitch14_g77556 );
				half Final_A241_g77547 = Element_Alpha56_g77547;
				float4 appendResult882_g77547 = (float4(FInal_RGB213_g77547 , Final_A241_g77547));
				
				
				finalColor = appendResult882_g77547;
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
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_COLOR
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
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
			uniform float _render_src;
			uniform float _render_dst;
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
			uniform half _RaycastCategory;
			uniform half _RaycastEnd;
			uniform half _ElementRaycastMode;
			uniform half _RaycastLayerMask;
			uniform half _RaycastDistanceMinValue;
			uniform half _RaycastDistanceMaxValue;
			uniform half _RaycastDistanceCheckValue;
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsFlowIntensity)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr BOXOPHOBICTheVisualEngineElementsFlowIntensity
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsFlowIntensity)

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				half TVE_SeasonOptions_X50_g77547 = TVE_SeasonOption.x;
				half Value_Winter158_g77547 = _AdditionalValue1;
				half Value_Spring159_g77547 = _AdditionalValue2;
				float temp_output_7_0_g77558 = _SeasonRemap.x;
				float temp_output_9_0_g77558 = ( TVE_SeasonLerp - temp_output_7_0_g77558 );
				float smoothstepResult2286_g77547 = smoothstep( 0.0 , 1.0 , saturate( ( temp_output_9_0_g77558 * _SeasonRemap.z ) ));
				half SeasonLerp54_g77547 = smoothstepResult2286_g77547;
				float lerpResult168_g77547 = lerp( Value_Winter158_g77547 , Value_Spring159_g77547 , SeasonLerp54_g77547);
				half TVE_SeasonOptions_Y51_g77547 = TVE_SeasonOption.y;
				half Value_Summer160_g77547 = _AdditionalValue3;
				float lerpResult167_g77547 = lerp( Value_Spring159_g77547 , Value_Summer160_g77547 , SeasonLerp54_g77547);
				half TVE_SeasonOptions_Z52_g77547 = TVE_SeasonOption.z;
				half Value_Autumn161_g77547 = _AdditionalValue4;
				float lerpResult166_g77547 = lerp( Value_Summer160_g77547 , Value_Autumn161_g77547 , SeasonLerp54_g77547);
				half TVE_SeasonOptions_W53_g77547 = TVE_SeasonOption.w;
				float lerpResult165_g77547 = lerp( Value_Autumn161_g77547 , Value_Winter158_g77547 , SeasonLerp54_g77547);
				float temp_output_175_0_g77547 = ( ( TVE_SeasonOptions_X50_g77547 * lerpResult168_g77547 ) + ( TVE_SeasonOptions_Y51_g77547 * lerpResult167_g77547 ) + ( TVE_SeasonOptions_Z52_g77547 * lerpResult166_g77547 ) + ( TVE_SeasonOptions_W53_g77547 * lerpResult165_g77547 ) );
				float vertexToFrag11_g77552 = temp_output_175_0_g77547;
				o.ase_texcoord1.x = vertexToFrag11_g77552;
				
				o.ase_texcoord1.yz = v.ase_texcoord.xy;
				o.ase_color = v.color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.w = 0;
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
				half Value_Main157_g77547 = _MainValue;
				float vertexToFrag11_g77552 = i.ase_texcoord1.x;
				half Value_Seasons1721_g77547 = vertexToFrag11_g77552;
				half Element_Mode55_g77547 = _ElementMode;
				float lerpResult181_g77547 = lerp( Value_Main157_g77547 , Value_Seasons1721_g77547 , Element_Mode55_g77547);
				half4 MainTex_RGBA587_g77547 = tex2D( _MainTex, ( 1.0 - i.ase_texcoord1.yz ) );
				float3 temp_output_6_0_g77564 = (MainTex_RGBA587_g77547).rgb;
				half SpaceTexture2395_g77547 = _SpaceTexture;
				float temp_output_7_0_g77564 = SpaceTexture2395_g77547;
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g77564 = ( temp_output_6_0_g77564 + temp_output_7_0_g77564 );
				#else
				float3 staticSwitch14_g77564 = temp_output_6_0_g77564;
				#endif
				float3 temp_cast_0 = (0.0001).xxx;
				float3 temp_cast_1 = (0.9999).xxx;
				float3 clampResult17_g77559 = clamp( staticSwitch14_g77564 , temp_cast_0 , temp_cast_1 );
				float temp_output_7_0_g77562 = _MainTexColorRemap.x;
				float3 temp_cast_2 = (temp_output_7_0_g77562).xxx;
				float3 temp_output_9_0_g77562 = ( clampResult17_g77559 - temp_cast_2 );
				float3 temp_output_1765_0_g77547 = saturate( ( temp_output_9_0_g77562 * _MainTexColorRemap.z ) );
				half Element_Remap_R73_g77547 = (temp_output_1765_0_g77547).x;
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half Element_Params_R1738_g77547 = _ElementParams_Instance.x;
				half Element_Value1744_g77547 = ( Element_Remap_R73_g77547 * Element_Params_R1738_g77547 * i.ase_color.r );
				float temp_output_468_0_g77547 = ( lerpResult181_g77547 * Element_Value1744_g77547 );
				float3 appendResult2402_g77547 = (float3(temp_output_468_0_g77547 , temp_output_468_0_g77547 , temp_output_468_0_g77547));
				half3 FInal_RGB213_g77547 = appendResult2402_g77547;
				half Element_Intensity2580_g77547 = _ElementIntensity;
				float temp_output_6_0_g77565 = (MainTex_RGBA587_g77547).a;
				float temp_output_7_0_g77565 = SpaceTexture2395_g77547;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77565 = ( temp_output_6_0_g77565 + temp_output_7_0_g77565 );
				#else
				float staticSwitch14_g77565 = temp_output_6_0_g77565;
				#endif
				float clampResult17_g77560 = clamp( staticSwitch14_g77565 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77563 = _MainTexAlphaRemap.x;
				float temp_output_9_0_g77563 = ( clampResult17_g77560 - temp_output_7_0_g77563 );
				half Element_Remap_A74_g77547 = saturate( ( temp_output_9_0_g77563 * _MainTexAlphaRemap.z ) );
				half Element_Params_A1737_g77547 = _ElementParams_Instance.w;
				float temp_output_6_0_g77567 = saturate( ( 1.0 - distance( (i.ase_texcoord1.yz*2.0 + -1.0) , float2( 0,0 ) ) ) );
				float temp_output_7_0_g77567 = SpaceTexture2395_g77547;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77567 = ( temp_output_6_0_g77567 + temp_output_7_0_g77567 );
				#else
				float staticSwitch14_g77567 = temp_output_6_0_g77567;
				#endif
				float clampResult17_g77566 = clamp( staticSwitch14_g77567 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77557 = _MainTexFalloffRemap.x;
				float temp_output_9_0_g77557 = ( clampResult17_g77566 - temp_output_7_0_g77557 );
				half Element_Falloff1883_g77547 = saturate( ( temp_output_9_0_g77557 * _MainTexFalloffRemap.z ) );
				float temp_output_7_0_g77550 = 1.0;
				float temp_output_9_0_g77550 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g77550 );
				float lerpResult18_g77548 = lerp( 1.0 , saturate( ( temp_output_9_0_g77550 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g77550 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g77548 = lerpResult18_g77548;
				float temp_output_6_0_g77551 = Blend_Edge69_g77548;
				half Dummy72_g77548 = ( _BoundsCategory + _BoundsEnd );
				float temp_output_7_0_g77551 = Dummy72_g77548;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77551 = ( temp_output_6_0_g77551 + temp_output_7_0_g77551 );
				#else
				float staticSwitch14_g77551 = temp_output_6_0_g77551;
				#endif
				float temp_output_6_0_g77556 = 1.0;
				float temp_output_7_0_g77556 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				float staticSwitch14_g77556 = ( temp_output_6_0_g77556 + temp_output_7_0_g77556 );
				#else
				float staticSwitch14_g77556 = temp_output_6_0_g77556;
				#endif
				half Element_Alpha56_g77547 = ( Element_Intensity2580_g77547 * Element_Remap_A74_g77547 * Element_Params_A1737_g77547 * i.ase_color.a * Element_Falloff1883_g77547 * staticSwitch14_g77551 * 1.0 * staticSwitch14_g77556 );
				half Final_A241_g77547 = Element_Alpha56_g77547;
				float4 appendResult2468_g77547 = (float4(FInal_RGB213_g77547 , Final_A241_g77547));
				half4 Input_Visual94_g77596 = appendResult2468_g77547;
				float clampResult80_g77596 = clamp( (Input_Visual94_g77596).x , 0.1 , 10000.0 );
				float3 appendResult139_g77596 = (float3(clampResult80_g77596 , clampResult80_g77596 , clampResult80_g77596));
				float3 color655 = IsGammaSpace() ? float3( 0.6589649, 0.627451, 1 ) : float3( 0.3917586, 0.3515327, 1 );
				half3 Input_Tint76_g77596 = color655;
				half3 Element_Color47_g77596 = saturate( ( appendResult139_g77596 * Input_Tint76_g77596 ) );
				float4 appendResult131_g77596 = (float4(Element_Color47_g77596 , (Input_Visual94_g77596).w));
				
				
				finalColor = appendResult131_g77596;
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
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":654,"pos":[-640,-768],"params":["Inherit","False","Element Type Flow","1","","77544","c08e6ab33dbacc04780022d2dbd4852d","0","0","1","FLOAT","4"]}
{"type":"AmplifyShaderEditor.ColorNode, AmplifyShaderEditor","id":655,"pos":[-384,-640],"params":["Inherit","False","Constant","_Color11","Color 1","63","0","Create","True","0","0","0","False","0","False","Object","-1","","0.6589649,0.627451,1,1","0,0,0,0","True","False","0","6","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":652,"pos":[-384,-768],"params":["Inherit","False","Element Shader","11","","77547","0e972c73cae2ee54ea51acc9738801d0","15,1778,1,477,1,478,0,1824,0,1814,0,145,0,1784,0,481,0,2614,0,2618,0,1904,0,1907,1,2377,1,2310,0,2311,1","2","1974","FLOAT","0","False","2378","FLOAT","1","False","2","FLOAT4","0","FLOAT4","1779"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":644,"pos":[-640,-1152],"params":["Inherit","False","Property","_render_src","_render_src","107","1","[HideInInspector]","Create","True","0","0","0","True","0","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":645,"pos":[-480,-1152],"params":["Inherit","False","Property","_render_dst","_render_dst","108","1","[HideInInspector]","Create","True","0","0","0","True","0","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":416,"pos":[64,-1280],"params":["Inherit","False","Element Compile","-1","","77595","5302407fc6d65554791e558e67d59358","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":656,"pos":[-128,-640],"params":["Inherit","False","Element Visuals","-1","","77596","78cf0f00cfd72824e84597f2db54a76e","1,64,1","2","59","FLOAT4","0,0,0,0","False","77","FLOAT3","1,1,1","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":636,"pos":[-640,-1280],"params":["Half","False","Property","_ElementMessage","Element Message","0","0","Create","True","0","0","0","True","1","StyledMessage(Info, Use Motion Intensity elements to control the wind intensity locally. Element Texture R and Particle Color R are used as value multipliers. Element Texture A and Particle Color A are used as alpha masks., 0, 15)","False","Object","-1","","0","0","1","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":649,"pos":[-64,-768],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","1","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass1","0","1","VolumePass1","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass1","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":650,"pos":[-64,-768],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","1","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass2","0","2","VolumePass2","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass2","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":417,"pos":[64,-768],"params":["Float","False","True","-1","2","TheVisualEngine.ElementGUI","100","2","BOXOPHOBIC/The Visual Engine/Elements/Flow Intensity","f4f273c3bb6262d4396be458405e60f9","True","VolumePass","0","0","VolumePass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","3","RenderType=Transparent=RenderType","Queue=Transparent=Queue=0","DisableBatching=True=DisableBatching","False","False","0","True","True","2","5","False","","10","False","","0","0","True","_render_src","0","True","_render_dst","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","True","True","False","False","True","False","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass","True","2","False","0","","0","0","Standard","3","VolumePass1","0","0","VolumePass2","0","0","Vertex Position","1","0","0","4","True","False","False","True","False","","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":418,"pos":[64,-640],"params":["Float","False","False","-1","2","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VisualPass","0","3","VisualPass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","True","True","2","5","False","","10","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","False","True","2","False","0","","0","0","Standard","0","False","0"]}
{"wire":[652,1974,654,4]}
{"wire":[656,59,652,1779]}
{"wire":[656,77,655,0]}
{"wire":[417,0,652,0]}
{"wire":[418,0,656,0]}
ASEEND*/
//CHKSM=EB14822BB2AF0D0581B8EC66653AC2E6765FD193