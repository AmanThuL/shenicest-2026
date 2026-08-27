// Upgrade NOTE: upgraded instancing buffer 'BOXOPHOBICTheVisualEngineElementsFlowInteraction' to new syntax.

// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Elements/Flow Interaction"
{
	Properties
	{
		[StyledMessage(Info, The Element Texture mode is setting the direction based on the Element Texture__ where RG is used as World XZ direction. Element Texture A and Particle Color A are used as alpha masks., _MotionDirectionMode, 1, 0, 15)] _ElementDirectionTextureMessage( "Element Direction Message", Float ) = 0
		[StyledMessage(Info, The Element Forward mode is setting the direction in the element transform forward axis. Element Texture A and Particle Color A are used as alpha masks., _MotionDirectionMode, 0, 0, 15)] _ElementDirectionForwardMessage( "Element Direction Message", Float ) = 0
		[StyledMessage(Info, The Particle Translate mode is setting the direction based on the particle gameobject transform movement direction. Use the Speed Treshold to control how fast the particle movement is transformend into interaction. Element Texture A and Particle Color A are used as alpha masks., _MotionDirectionMode, 2, 0, 15)] _ElementDirectionTranslateMessage( "Element Direction Message", Float ) = 0
		[StyledMessage(Info, The Particle Velocity mode is setting the direction based on the particles motion direction. This option requires the particle to have custom vertex streams for Velocity and Speed set after the UV stream under the particle Renderer module. Element Texture A and Particle Color A are used as alpha masks., _MotionDirectionMode, 3, 0, 15)] _ElementDirectionVelocityMessage( "Element Direction Message", Float ) = 0
		[HideInInspector] _IsVersion( "_IsVersion", Float ) = 2200
		[HideInInspector] _IsElementShader( "_IsElementShader", Float ) = 1
		[HideInInspector] _IsIdentifier( "_IsIdentifier", Float ) = 0
		[StyledCategory(Render Settings, true, 0, 10)] _RenderCategory( "[ Render Category ]", Float ) = 1
		_ElementIntensity( "Render Intensity", Range( 0, 1 ) ) = 1
		[StyledMessage(Info, When using a higher Layer number the Global Volume will create more render textures to render the elements. Try using fewer layers when possible., _ElementLayerMessage, 1, 10, 10)] _ElementLayerMessage( "Render Layer Message", Float ) = 0
		[StyledMessage(Warning, When using all layers the Global Volume will create one render texture for each layer to render the elements. Try using fewer layers when possible., _ElementLayerWarning, 1, 10, 10)] _ElementLayerWarning( "Render Layer Warning", Float ) = 0
		[StyledMask(Flow Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _ElementLayerMask( "Render Layer", Float ) = 1
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
			#include "UnityShaderVariables.cginc"
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_COLOR
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
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
			uniform half _ElementDirectionForwardMessage;
			uniform half _ElementDirectionTextureMessage;
			uniform half _ElementDirectionTranslateMessage;
			uniform half _ElementDirectionVelocityMessage;
			uniform float _MotionDirectionMode;
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
			uniform half _RaycastCategory;
			uniform half _RaycastEnd;
			uniform half _ElementRaycastMode;
			uniform half _RaycastLayerMask;
			uniform half _RaycastDistanceMinValue;
			uniform half _RaycastDistanceMaxValue;
			uniform half _RaycastDistanceCheckValue;
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsFlowInteraction)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr BOXOPHOBICTheVisualEngineElementsFlowInteraction
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsFlowInteraction)
			float2 SwitchChannel6( half Option, float2 A, float2 B, float2 C, float2 D )
			{
				switch (Option) {
					default:
				                case 0:
						return A;
					case 1:
						return B;
					case 2:
						return C;
					case 3:
						return D;
				}
			}
			

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord1 = v.ase_texcoord;
				o.ase_color = v.color;
				o.ase_texcoord2 = v.ase_texcoord1;
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
				float Motion_Direction1013_g78765 = _MotionDirectionMode;
				float Option2503_g78765 = Motion_Direction1013_g78765;
				float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
				half2 Direction_Transform1406_g78765 = (( mul( unity_ObjectToWorld, float4( float3( 0, 0, 1 ) , 0.0 ) ).xyz / ase_objectScale )).xz;
				float2 A2503_g78765 = Direction_Transform1406_g78765;
				half4 MainTex_RGBA587_g78765 = tex2D( _MainTex, ( 1.0 - i.ase_texcoord1.xy ) );
				float3 temp_output_6_0_g78783 = (MainTex_RGBA587_g78765).rgb;
				half SpaceTexture2395_g78765 = _SpaceTexture;
				float temp_output_7_0_g78783 = SpaceTexture2395_g78765;
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g78783 = ( temp_output_6_0_g78783 + temp_output_7_0_g78783 );
				#else
				float3 staticSwitch14_g78783 = temp_output_6_0_g78783;
				#endif
				float3 temp_cast_2 = (0.0001).xxx;
				float3 temp_cast_3 = (0.9999).xxx;
				float3 clampResult17_g78778 = clamp( staticSwitch14_g78783 , temp_cast_2 , temp_cast_3 );
				float temp_output_7_0_g78781 = _MainTexColorRemap.x;
				float3 temp_cast_4 = (temp_output_7_0_g78781).xxx;
				float3 temp_output_9_0_g78781 = ( clampResult17_g78778 - temp_cast_4 );
				float3 temp_output_1765_0_g78765 = saturate( ( temp_output_9_0_g78781 * _MainTexColorRemap.z ) );
				half Element_Remap_R73_g78765 = (temp_output_1765_0_g78765).x;
				half Element_Remap_G265_g78765 = (temp_output_1765_0_g78765).y;
				float3 appendResult274_g78765 = (float3((Element_Remap_R73_g78765*2.0 + -1.0) , 0.0 , (Element_Remap_G265_g78765*2.0 + -1.0)));
				float3 break281_g78765 = ( mul( unity_ObjectToWorld, float4( appendResult274_g78765 , 0.0 ) ).xyz / ase_objectScale );
				float2 appendResult1403_g78765 = (float2(break281_g78765.x , break281_g78765.z));
				half2 Direction_Texture284_g78765 = appendResult1403_g78765;
				float2 B2503_g78765 = Direction_Texture284_g78765;
				float2 appendResult1404_g78765 = (float2(i.ase_color.r , i.ase_color.g));
				half2 Direction_VertexColor1150_g78765 = (appendResult1404_g78765*2.0 + -1.0);
				float2 C2503_g78765 = Direction_VertexColor1150_g78765;
				float2 appendResult1382_g78765 = (float2(i.ase_texcoord1.z , i.ase_texcoord2.x));
				half2 Direction_Velocity1394_g78765 = ( appendResult1382_g78765 / i.ase_texcoord2.y );
				float2 D2503_g78765 = Direction_Velocity1394_g78765;
				float2 localSwitchChannel62503_g78765 = SwitchChannel6( Option2503_g78765 , A2503_g78765 , B2503_g78765 , C2503_g78765 , D2503_g78765 );
				half Element_InvertMode489_g78765 = _ElementInvertMode;
				float2 lerpResult1468_g78765 = lerp( localSwitchChannel62503_g78765 , -localSwitchChannel62503_g78765 , Element_InvertMode489_g78765);
				half2 Direction_Advanced1454_g78765 = lerpResult1468_g78765;
				half2 Motion_WorldPosition2098_g78765 = -(( WorldPosition - TVE_WorldOrigin )).xz;
				float Motion_Tilling2576_g78765 = _MotionTillingValue;
				half2 Motion_WorldCoords1409_g78765 = ( Motion_WorldPosition2098_g78765 * 0.005 * Motion_Tilling2576_g78765 );
				float2 Input_Coords80_g78803 = Motion_WorldCoords1409_g78765;
				half2 Input_Direction82_g78803 = Direction_Advanced1454_g78765;
				float mulTime113_g78801 = _Time.y * 0.02;
				float lerpResult128_g78801 = lerp( mulTime113_g78801 , ( ( mulTime113_g78801 * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				half Motion_Speed2512_g78765 = _MotionSpeedValue;
				float Input_Time88_g78803 = (frac( lerpResult128_g78801 )*Motion_Speed2512_g78765 + _MotionPhaseValue);
				float temp_output_23_0_g78803 = frac( Input_Time88_g78803 );
				float4 lerpResult39_g78803 = lerp( tex2D( _MotionTex, ( Input_Coords80_g78803 + ( Input_Direction82_g78803 * temp_output_23_0_g78803 ) ) ) , tex2D( _MotionTex, ( Input_Coords80_g78803 + ( Input_Direction82_g78803 * frac( ( Input_Time88_g78803 + 0.5 ) ) ) ) ) , ( abs( ( temp_output_23_0_g78803 - 0.5 ) ) / 0.5 ));
				float4 temp_output_2574_0_g78765 = lerpResult39_g78803;
				half2 Motion_FlowRG1427_g78765 = ((temp_output_2574_0_g78765).rg*2.0 + -1.0);
				half Motion_Noise2056_g78765 = _MotionNoiseValue;
				float2 lerpResult2141_g78765 = lerp( Direction_Advanced1454_g78765 , Motion_FlowRG1427_g78765 , Motion_Noise2056_g78765);
				float2 temp_cast_7 = (0.001).xx;
				float2 temp_cast_8 = (0.999).xx;
				float2 clampResult2359_g78765 = clamp( (lerpResult2141_g78765*0.5 + 0.5) , temp_cast_7 , temp_cast_8 );
				float3 appendResult1436_g78765 = (float3(clampResult2359_g78765 , Motion_Noise2056_g78765));
				half3 Final_MotionAdvanced_RGB1438_g78765 = appendResult1436_g78765;
				half Element_Intensity2580_g78765 = _ElementIntensity;
				float temp_output_6_0_g78784 = (MainTex_RGBA587_g78765).a;
				float temp_output_7_0_g78784 = SpaceTexture2395_g78765;
				#ifdef TVE_DUMMY
				float staticSwitch14_g78784 = ( temp_output_6_0_g78784 + temp_output_7_0_g78784 );
				#else
				float staticSwitch14_g78784 = temp_output_6_0_g78784;
				#endif
				float clampResult17_g78779 = clamp( staticSwitch14_g78784 , 0.0001 , 0.9999 );
				float temp_output_7_0_g78782 = _MainTexAlphaRemap.x;
				float temp_output_9_0_g78782 = ( clampResult17_g78779 - temp_output_7_0_g78782 );
				half Element_Remap_A74_g78765 = saturate( ( temp_output_9_0_g78782 * _MainTexAlphaRemap.z ) );
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half Element_Params_A1737_g78765 = _ElementParams_Instance.w;
				float temp_output_6_0_g78786 = saturate( ( 1.0 - distance( (i.ase_texcoord1.xy*2.0 + -1.0) , float2( 0,0 ) ) ) );
				float temp_output_7_0_g78786 = SpaceTexture2395_g78765;
				#ifdef TVE_DUMMY
				float staticSwitch14_g78786 = ( temp_output_6_0_g78786 + temp_output_7_0_g78786 );
				#else
				float staticSwitch14_g78786 = temp_output_6_0_g78786;
				#endif
				float clampResult17_g78785 = clamp( staticSwitch14_g78786 , 0.0001 , 0.9999 );
				float temp_output_7_0_g78776 = _MainTexFalloffRemap.x;
				float temp_output_9_0_g78776 = ( clampResult17_g78785 - temp_output_7_0_g78776 );
				half Element_Falloff1883_g78765 = saturate( ( temp_output_9_0_g78776 * _MainTexFalloffRemap.z ) );
				float temp_output_7_0_g78768 = 1.0;
				float temp_output_9_0_g78768 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g78768 );
				float lerpResult18_g78766 = lerp( 1.0 , saturate( ( temp_output_9_0_g78768 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g78768 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g78766 = lerpResult18_g78766;
				float temp_output_6_0_g78769 = Blend_Edge69_g78766;
				half Dummy72_g78766 = ( _BoundsCategory + _BoundsEnd );
				float temp_output_7_0_g78769 = Dummy72_g78766;
				#ifdef TVE_DUMMY
				float staticSwitch14_g78769 = ( temp_output_6_0_g78769 + temp_output_7_0_g78769 );
				#else
				float staticSwitch14_g78769 = temp_output_6_0_g78769;
				#endif
				float temp_output_6_0_g78775 = 1.0;
				float temp_output_7_0_g78775 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				float staticSwitch14_g78775 = ( temp_output_6_0_g78775 + temp_output_7_0_g78775 );
				#else
				float staticSwitch14_g78775 = temp_output_6_0_g78775;
				#endif
				half Element_Alpha56_g78765 = ( Element_Intensity2580_g78765 * Element_Remap_A74_g78765 * Element_Params_A1737_g78765 * i.ase_color.a * Element_Falloff1883_g78765 * staticSwitch14_g78769 * 1.0 * staticSwitch14_g78775 );
				half Final_MotionAdvanced_A1439_g78765 = Element_Alpha56_g78765;
				float4 appendResult1463_g78765 = (float4(Final_MotionAdvanced_RGB1438_g78765 , Final_MotionAdvanced_A1439_g78765));
				
				
				finalColor = appendResult1463_g78765;
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
			#include "UnityShaderVariables.cginc"
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_COLOR
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
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
			uniform half _ElementDirectionForwardMessage;
			uniform half _ElementDirectionTextureMessage;
			uniform half _ElementDirectionTranslateMessage;
			uniform half _ElementDirectionVelocityMessage;
			uniform float _MotionDirectionMode;
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
			uniform half _RaycastCategory;
			uniform half _RaycastEnd;
			uniform half _ElementRaycastMode;
			uniform half _RaycastLayerMask;
			uniform half _RaycastDistanceMinValue;
			uniform half _RaycastDistanceMaxValue;
			uniform half _RaycastDistanceCheckValue;
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsFlowInteraction)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr BOXOPHOBICTheVisualEngineElementsFlowInteraction
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsFlowInteraction)
			float2 SwitchChannel6( half Option, float2 A, float2 B, float2 C, float2 D )
			{
				switch (Option) {
					default:
				                case 0:
						return A;
					case 1:
						return B;
					case 2:
						return C;
					case 3:
						return D;
				}
			}
			

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord1 = v.ase_texcoord;
				o.ase_color = v.color;
				o.ase_texcoord2 = v.ase_texcoord1;
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
				float Motion_Direction1013_g78765 = _MotionDirectionMode;
				float Option2503_g78765 = Motion_Direction1013_g78765;
				float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
				half2 Direction_Transform1406_g78765 = (( mul( unity_ObjectToWorld, float4( float3( 0, 0, 1 ) , 0.0 ) ).xyz / ase_objectScale )).xz;
				float2 A2503_g78765 = Direction_Transform1406_g78765;
				half4 MainTex_RGBA587_g78765 = tex2D( _MainTex, ( 1.0 - i.ase_texcoord1.xy ) );
				float3 temp_output_6_0_g78783 = (MainTex_RGBA587_g78765).rgb;
				half SpaceTexture2395_g78765 = _SpaceTexture;
				float temp_output_7_0_g78783 = SpaceTexture2395_g78765;
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g78783 = ( temp_output_6_0_g78783 + temp_output_7_0_g78783 );
				#else
				float3 staticSwitch14_g78783 = temp_output_6_0_g78783;
				#endif
				float3 temp_cast_2 = (0.0001).xxx;
				float3 temp_cast_3 = (0.9999).xxx;
				float3 clampResult17_g78778 = clamp( staticSwitch14_g78783 , temp_cast_2 , temp_cast_3 );
				float temp_output_7_0_g78781 = _MainTexColorRemap.x;
				float3 temp_cast_4 = (temp_output_7_0_g78781).xxx;
				float3 temp_output_9_0_g78781 = ( clampResult17_g78778 - temp_cast_4 );
				float3 temp_output_1765_0_g78765 = saturate( ( temp_output_9_0_g78781 * _MainTexColorRemap.z ) );
				half Element_Remap_R73_g78765 = (temp_output_1765_0_g78765).x;
				half Element_Remap_G265_g78765 = (temp_output_1765_0_g78765).y;
				float3 appendResult274_g78765 = (float3((Element_Remap_R73_g78765*2.0 + -1.0) , 0.0 , (Element_Remap_G265_g78765*2.0 + -1.0)));
				float3 break281_g78765 = ( mul( unity_ObjectToWorld, float4( appendResult274_g78765 , 0.0 ) ).xyz / ase_objectScale );
				float2 appendResult1403_g78765 = (float2(break281_g78765.x , break281_g78765.z));
				half2 Direction_Texture284_g78765 = appendResult1403_g78765;
				float2 B2503_g78765 = Direction_Texture284_g78765;
				float2 appendResult1404_g78765 = (float2(i.ase_color.r , i.ase_color.g));
				half2 Direction_VertexColor1150_g78765 = (appendResult1404_g78765*2.0 + -1.0);
				float2 C2503_g78765 = Direction_VertexColor1150_g78765;
				float2 appendResult1382_g78765 = (float2(i.ase_texcoord1.z , i.ase_texcoord2.x));
				half2 Direction_Velocity1394_g78765 = ( appendResult1382_g78765 / i.ase_texcoord2.y );
				float2 D2503_g78765 = Direction_Velocity1394_g78765;
				float2 localSwitchChannel62503_g78765 = SwitchChannel6( Option2503_g78765 , A2503_g78765 , B2503_g78765 , C2503_g78765 , D2503_g78765 );
				half Element_InvertMode489_g78765 = _ElementInvertMode;
				float2 lerpResult1468_g78765 = lerp( localSwitchChannel62503_g78765 , -localSwitchChannel62503_g78765 , Element_InvertMode489_g78765);
				half2 Direction_Advanced1454_g78765 = lerpResult1468_g78765;
				half2 Motion_WorldPosition2098_g78765 = -(( WorldPosition - TVE_WorldOrigin )).xz;
				float Motion_Tilling2576_g78765 = _MotionTillingValue;
				half2 Motion_WorldCoords1409_g78765 = ( Motion_WorldPosition2098_g78765 * 0.005 * Motion_Tilling2576_g78765 );
				float2 Input_Coords80_g78803 = Motion_WorldCoords1409_g78765;
				half2 Input_Direction82_g78803 = Direction_Advanced1454_g78765;
				float mulTime113_g78801 = _Time.y * 0.02;
				float lerpResult128_g78801 = lerp( mulTime113_g78801 , ( ( mulTime113_g78801 * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				half Motion_Speed2512_g78765 = _MotionSpeedValue;
				float Input_Time88_g78803 = (frac( lerpResult128_g78801 )*Motion_Speed2512_g78765 + _MotionPhaseValue);
				float temp_output_23_0_g78803 = frac( Input_Time88_g78803 );
				float4 lerpResult39_g78803 = lerp( tex2D( _MotionTex, ( Input_Coords80_g78803 + ( Input_Direction82_g78803 * temp_output_23_0_g78803 ) ) ) , tex2D( _MotionTex, ( Input_Coords80_g78803 + ( Input_Direction82_g78803 * frac( ( Input_Time88_g78803 + 0.5 ) ) ) ) ) , ( abs( ( temp_output_23_0_g78803 - 0.5 ) ) / 0.5 ));
				float4 temp_output_2574_0_g78765 = lerpResult39_g78803;
				half2 Motion_FlowRG1427_g78765 = ((temp_output_2574_0_g78765).rg*2.0 + -1.0);
				half Motion_Noise2056_g78765 = _MotionNoiseValue;
				float2 lerpResult2141_g78765 = lerp( Direction_Advanced1454_g78765 , Motion_FlowRG1427_g78765 , Motion_Noise2056_g78765);
				float2 temp_cast_7 = (0.001).xx;
				float2 temp_cast_8 = (0.999).xx;
				float2 clampResult2359_g78765 = clamp( (lerpResult2141_g78765*0.5 + 0.5) , temp_cast_7 , temp_cast_8 );
				float3 appendResult1436_g78765 = (float3(clampResult2359_g78765 , Motion_Noise2056_g78765));
				half3 Final_MotionAdvanced_RGB1438_g78765 = appendResult1436_g78765;
				half Element_Intensity2580_g78765 = _ElementIntensity;
				float temp_output_6_0_g78784 = (MainTex_RGBA587_g78765).a;
				float temp_output_7_0_g78784 = SpaceTexture2395_g78765;
				#ifdef TVE_DUMMY
				float staticSwitch14_g78784 = ( temp_output_6_0_g78784 + temp_output_7_0_g78784 );
				#else
				float staticSwitch14_g78784 = temp_output_6_0_g78784;
				#endif
				float clampResult17_g78779 = clamp( staticSwitch14_g78784 , 0.0001 , 0.9999 );
				float temp_output_7_0_g78782 = _MainTexAlphaRemap.x;
				float temp_output_9_0_g78782 = ( clampResult17_g78779 - temp_output_7_0_g78782 );
				half Element_Remap_A74_g78765 = saturate( ( temp_output_9_0_g78782 * _MainTexAlphaRemap.z ) );
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half Element_Params_A1737_g78765 = _ElementParams_Instance.w;
				float temp_output_6_0_g78786 = saturate( ( 1.0 - distance( (i.ase_texcoord1.xy*2.0 + -1.0) , float2( 0,0 ) ) ) );
				float temp_output_7_0_g78786 = SpaceTexture2395_g78765;
				#ifdef TVE_DUMMY
				float staticSwitch14_g78786 = ( temp_output_6_0_g78786 + temp_output_7_0_g78786 );
				#else
				float staticSwitch14_g78786 = temp_output_6_0_g78786;
				#endif
				float clampResult17_g78785 = clamp( staticSwitch14_g78786 , 0.0001 , 0.9999 );
				float temp_output_7_0_g78776 = _MainTexFalloffRemap.x;
				float temp_output_9_0_g78776 = ( clampResult17_g78785 - temp_output_7_0_g78776 );
				half Element_Falloff1883_g78765 = saturate( ( temp_output_9_0_g78776 * _MainTexFalloffRemap.z ) );
				float temp_output_7_0_g78768 = 1.0;
				float temp_output_9_0_g78768 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g78768 );
				float lerpResult18_g78766 = lerp( 1.0 , saturate( ( temp_output_9_0_g78768 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g78768 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g78766 = lerpResult18_g78766;
				float temp_output_6_0_g78769 = Blend_Edge69_g78766;
				half Dummy72_g78766 = ( _BoundsCategory + _BoundsEnd );
				float temp_output_7_0_g78769 = Dummy72_g78766;
				#ifdef TVE_DUMMY
				float staticSwitch14_g78769 = ( temp_output_6_0_g78769 + temp_output_7_0_g78769 );
				#else
				float staticSwitch14_g78769 = temp_output_6_0_g78769;
				#endif
				float temp_output_6_0_g78775 = 1.0;
				float temp_output_7_0_g78775 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				float staticSwitch14_g78775 = ( temp_output_6_0_g78775 + temp_output_7_0_g78775 );
				#else
				float staticSwitch14_g78775 = temp_output_6_0_g78775;
				#endif
				half Element_Alpha56_g78765 = ( Element_Intensity2580_g78765 * Element_Remap_A74_g78765 * Element_Params_A1737_g78765 * i.ase_color.a * Element_Falloff1883_g78765 * staticSwitch14_g78769 * 1.0 * staticSwitch14_g78775 );
				half Final_MotionAdvanced_A1439_g78765 = Element_Alpha56_g78765;
				float4 appendResult2474_g78765 = (float4(Final_MotionAdvanced_RGB1438_g78765 , Final_MotionAdvanced_A1439_g78765));
				half4 Input_Visual94_g79666 = appendResult2474_g78765;
				float2 temp_output_135_0_g79666 = (Input_Visual94_g79666).xy;
				float3 appendResult140_g79666 = (float3(( temp_output_135_0_g79666 * temp_output_135_0_g79666 ) , (Input_Visual94_g79666).z));
				half3 Element_Color47_g79666 = saturate( appendResult140_g79666 );
				float4 appendResult131_g79666 = (float4(Element_Color47_g79666 , (Input_Visual94_g79666).w));
				
				
				finalColor = appendResult131_g79666;
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
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":757,"pos":[-640,-768],"params":["Inherit","False","Element Type Flow","4","","78763","c08e6ab33dbacc04780022d2dbd4852d","0","0","1","FLOAT","4"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":787,"pos":[-384,-768],"params":["Inherit","False","Element Shader","14","","78765","0e972c73cae2ee54ea51acc9738801d0","13,477,2,1778,2,478,0,1824,0,1814,1,145,1,1784,1,481,1,1904,0,1907,1,2377,1,2310,0,2311,1","2","1974","FLOAT","0","False","2378","FLOAT","1","False","2","FLOAT4","0","FLOAT4","1779"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":197,"pos":[-640,-960],"params":["Half","False","Property","_render_colormask","_render_colormask","110","1","[HideInInspector]","Create","True","0","0","0","True","0","False","Object","-1","","15","15","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":440,"pos":[-640,-1280],"params":["Half","False","Property","_ElementDirectionForwardMessage","Element Direction Message","1","0","Create","False","0","0","0","True","1","StyledMessage(Info, The Element Forward mode is setting the direction in the element transform forward axis. Element Texture A and Particle Color A are used as alpha masks., _MotionDirectionMode, 0, 0, 15)","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":441,"pos":[-640,-1216],"params":["Half","False","Property","_ElementDirectionTextureMessage","Element Direction Message","0","0","Create","False","0","0","0","True","1","StyledMessage(Info, The Element Texture mode is setting the direction based on the Element Texture__ where RG is used as World XZ direction. Element Texture A and Particle Color A are used as alpha masks., _MotionDirectionMode, 1, 0, 15)","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":442,"pos":[-640,-1152],"params":["Half","False","Property","_ElementDirectionTranslateMessage","Element Direction Message","2","0","Create","False","0","0","0","True","1","StyledMessage(Info, The Particle Translate mode is setting the direction based on the particle gameobject transform movement direction. Use the Speed Treshold to control how fast the particle movement is transformend into interaction. Element Texture A and Particle Color A are used as alpha masks., _MotionDirectionMode, 2, 0, 15)","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":439,"pos":[-640,-1088],"params":["Half","False","Property","_ElementDirectionVelocityMessage","Element Direction Message","3","0","Create","False","0","0","0","True","1","StyledMessage(Info, The Particle Velocity mode is setting the direction based on the particles motion direction. This option requires the particle to have custom vertex streams for Velocity and Speed set after the UV stream under the particle Renderer module. Element Texture A and Particle Color A are used as alpha masks., _MotionDirectionMode, 3, 0, 15)","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":416,"pos":[64,-1280],"params":["Inherit","False","Element Compile","-1","","79665","5302407fc6d65554791e558e67d59358","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":767,"pos":[-128,-640],"params":["Inherit","False","Element Visuals","-1","","79666","78cf0f00cfd72824e84597f2db54a76e","1,64,2","2","59","FLOAT4","0,0,0,0","False","77","FLOAT3","1,1,1","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":754,"pos":[-64,-768],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass1","0","1","VolumePass1","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass1","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":755,"pos":[-64,-768],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass2","0","2","VolumePass2","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass2","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":417,"pos":[64,-768],"params":["Float","False","True","-1","2","TheVisualEngine.ElementGUI","100","2","BOXOPHOBIC/The Visual Engine/Elements/Flow Interaction","f4f273c3bb6262d4396be458405e60f9","True","VolumePass","0","0","VolumePass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","3","RenderType=Transparent=RenderType","Queue=Transparent=Queue=0","DisableBatching=True=DisableBatching","False","False","0","True","True","2","5","False","","10","False","","0","1","False","","1","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","True","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass","True","2","False","0","","0","0","Standard","3","VolumePass1","0","0","VolumePass2","0","0","Vertex Position","1","0","0","4","True","False","False","True","False","","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":418,"pos":[64,-640],"params":["Float","False","False","-1","2","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VisualPass","0","3","VisualPass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","True","True","2","5","False","","10","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","False","True","2","False","0","","0","0","Standard","0","False","0"]}
{"wire":[787,1974,757,4]}
{"wire":[767,59,787,1779]}
{"wire":[417,0,787,0]}
{"wire":[418,0,767,0]}
ASEEND*/
//CHKSM=9B5A788827696D5226804C790C9C7C265F43EDB0