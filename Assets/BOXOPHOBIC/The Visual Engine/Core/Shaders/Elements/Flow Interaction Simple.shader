// Upgrade NOTE: upgraded instancing buffer 'BOXOPHOBICTheVisualEngineElementsFlowInteractionSimple' to new syntax.

// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Elements/Flow Interaction (Simple)"
{
	Properties
	{
		[StyledMessage(Info, Use Motion Interaction elements to add touch bending to the vegetation objects. Element Texture RG is used a World XZ bending. Element Texture A and Particle Color A are used as alpha masks., 0, 15)] _ElementMessage( "Element Message", Float ) = 0
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
			Offset 0 , 0
			
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
			uniform half _render_colormask;
			uniform half _ElementMessage;
			uniform sampler2D _MainTex;
			uniform half _SpaceTexture;
			uniform half4 _MainTexColorRemap;
			uniform float _ElementInvertMode;
			uniform float _ElementIntensity;
			uniform half4 _MainTexAlphaRemap;
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
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsFlowInteractionSimple)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr BOXOPHOBICTheVisualEngineElementsFlowInteractionSimple
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsFlowInteractionSimple)

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				o.ase_color = v.color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
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
				half4 MainTex_RGBA587_g77407 = tex2D( _MainTex, ( 1.0 - i.ase_texcoord1.xy ) );
				float3 temp_output_6_0_g77424 = (MainTex_RGBA587_g77407).rgb;
				half SpaceTexture2395_g77407 = _SpaceTexture;
				float temp_output_7_0_g77424 = SpaceTexture2395_g77407;
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g77424 = ( temp_output_6_0_g77424 + temp_output_7_0_g77424 );
				#else
				float3 staticSwitch14_g77424 = temp_output_6_0_g77424;
				#endif
				float3 temp_cast_0 = (0.0001).xxx;
				float3 temp_cast_1 = (0.9999).xxx;
				float3 clampResult17_g77419 = clamp( staticSwitch14_g77424 , temp_cast_0 , temp_cast_1 );
				float temp_output_7_0_g77422 = _MainTexColorRemap.x;
				float3 temp_cast_2 = (temp_output_7_0_g77422).xxx;
				float3 temp_output_9_0_g77422 = ( clampResult17_g77419 - temp_cast_2 );
				float3 temp_output_1765_0_g77407 = saturate( ( temp_output_9_0_g77422 * _MainTexColorRemap.z ) );
				half Element_Remap_R73_g77407 = (temp_output_1765_0_g77407).x;
				half Element_Remap_G265_g77407 = (temp_output_1765_0_g77407).y;
				float3 appendResult274_g77407 = (float3((Element_Remap_R73_g77407*2.0 + -1.0) , 0.0 , (Element_Remap_G265_g77407*2.0 + -1.0)));
				float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
				float3 break281_g77407 = ( mul( unity_ObjectToWorld, float4( appendResult274_g77407 , 0.0 ) ).xyz / ase_objectScale );
				float2 appendResult1403_g77407 = (float2(break281_g77407.x , break281_g77407.z));
				half2 Direction_Texture284_g77407 = appendResult1403_g77407;
				half Element_InvertMode489_g77407 = _ElementInvertMode;
				float2 lerpResult1471_g77407 = lerp( Direction_Texture284_g77407 , -Direction_Texture284_g77407 , Element_InvertMode489_g77407);
				float2 temp_cast_5 = (0.001).xx;
				float2 temp_cast_6 = (0.999).xx;
				float2 clampResult2364_g77407 = clamp( (lerpResult1471_g77407*0.5 + 0.5) , temp_cast_5 , temp_cast_6 );
				float3 appendResult292_g77407 = (float3(clampResult2364_g77407 , 0.0));
				half3 Final_MotionInteraction_RGB303_g77407 = appendResult292_g77407;
				half Element_Intensity2580_g77407 = _ElementIntensity;
				float temp_output_6_0_g77425 = (MainTex_RGBA587_g77407).a;
				float temp_output_7_0_g77425 = SpaceTexture2395_g77407;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77425 = ( temp_output_6_0_g77425 + temp_output_7_0_g77425 );
				#else
				float staticSwitch14_g77425 = temp_output_6_0_g77425;
				#endif
				float clampResult17_g77420 = clamp( staticSwitch14_g77425 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77423 = _MainTexAlphaRemap.x;
				float temp_output_9_0_g77423 = ( clampResult17_g77420 - temp_output_7_0_g77423 );
				half Element_Remap_A74_g77407 = saturate( ( temp_output_9_0_g77423 * _MainTexAlphaRemap.z ) );
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half Element_Params_A1737_g77407 = _ElementParams_Instance.w;
				half Element_Falloff1883_g77407 = 1.0;
				float temp_output_7_0_g77410 = 1.0;
				float temp_output_9_0_g77410 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g77410 );
				float lerpResult18_g77408 = lerp( 1.0 , saturate( ( temp_output_9_0_g77410 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g77410 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g77408 = lerpResult18_g77408;
				float temp_output_6_0_g77411 = Blend_Edge69_g77408;
				half Dummy72_g77408 = ( _BoundsCategory + _BoundsEnd );
				float temp_output_7_0_g77411 = Dummy72_g77408;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77411 = ( temp_output_6_0_g77411 + temp_output_7_0_g77411 );
				#else
				float staticSwitch14_g77411 = temp_output_6_0_g77411;
				#endif
				float temp_output_6_0_g77416 = 1.0;
				float temp_output_7_0_g77416 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				float staticSwitch14_g77416 = ( temp_output_6_0_g77416 + temp_output_7_0_g77416 );
				#else
				float staticSwitch14_g77416 = temp_output_6_0_g77416;
				#endif
				half Element_Alpha56_g77407 = ( Element_Intensity2580_g77407 * Element_Remap_A74_g77407 * Element_Params_A1737_g77407 * i.ase_color.a * Element_Falloff1883_g77407 * staticSwitch14_g77411 * 1.0 * staticSwitch14_g77416 );
				half Final_MotionInteraction_A305_g77407 = Element_Alpha56_g77407;
				float4 appendResult479_g77407 = (float4(Final_MotionInteraction_RGB303_g77407 , Final_MotionInteraction_A305_g77407));
				
				
				finalColor = appendResult479_g77407;
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
			ColorMask [_render_colormask]
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
			uniform half _render_colormask;
			uniform half _ElementMessage;
			uniform sampler2D _MainTex;
			uniform half _SpaceTexture;
			uniform half4 _MainTexColorRemap;
			uniform float _ElementInvertMode;
			uniform float _ElementIntensity;
			uniform half4 _MainTexAlphaRemap;
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
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsFlowInteractionSimple)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr BOXOPHOBICTheVisualEngineElementsFlowInteractionSimple
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsFlowInteractionSimple)

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				o.ase_color = v.color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
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
				half4 MainTex_RGBA587_g77407 = tex2D( _MainTex, ( 1.0 - i.ase_texcoord1.xy ) );
				float3 temp_output_6_0_g77424 = (MainTex_RGBA587_g77407).rgb;
				half SpaceTexture2395_g77407 = _SpaceTexture;
				float temp_output_7_0_g77424 = SpaceTexture2395_g77407;
				#ifdef TVE_DUMMY
				float3 staticSwitch14_g77424 = ( temp_output_6_0_g77424 + temp_output_7_0_g77424 );
				#else
				float3 staticSwitch14_g77424 = temp_output_6_0_g77424;
				#endif
				float3 temp_cast_0 = (0.0001).xxx;
				float3 temp_cast_1 = (0.9999).xxx;
				float3 clampResult17_g77419 = clamp( staticSwitch14_g77424 , temp_cast_0 , temp_cast_1 );
				float temp_output_7_0_g77422 = _MainTexColorRemap.x;
				float3 temp_cast_2 = (temp_output_7_0_g77422).xxx;
				float3 temp_output_9_0_g77422 = ( clampResult17_g77419 - temp_cast_2 );
				float3 temp_output_1765_0_g77407 = saturate( ( temp_output_9_0_g77422 * _MainTexColorRemap.z ) );
				half Element_Remap_R73_g77407 = (temp_output_1765_0_g77407).x;
				half Element_Remap_G265_g77407 = (temp_output_1765_0_g77407).y;
				float3 appendResult274_g77407 = (float3((Element_Remap_R73_g77407*2.0 + -1.0) , 0.0 , (Element_Remap_G265_g77407*2.0 + -1.0)));
				float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
				float3 break281_g77407 = ( mul( unity_ObjectToWorld, float4( appendResult274_g77407 , 0.0 ) ).xyz / ase_objectScale );
				float2 appendResult1403_g77407 = (float2(break281_g77407.x , break281_g77407.z));
				half2 Direction_Texture284_g77407 = appendResult1403_g77407;
				half Element_InvertMode489_g77407 = _ElementInvertMode;
				float2 lerpResult1471_g77407 = lerp( Direction_Texture284_g77407 , -Direction_Texture284_g77407 , Element_InvertMode489_g77407);
				float2 temp_cast_5 = (0.001).xx;
				float2 temp_cast_6 = (0.999).xx;
				float2 clampResult2364_g77407 = clamp( (lerpResult1471_g77407*0.5 + 0.5) , temp_cast_5 , temp_cast_6 );
				float3 appendResult292_g77407 = (float3(clampResult2364_g77407 , 0.0));
				half3 Final_MotionInteraction_Visual2204_g77407 = appendResult292_g77407;
				half Element_Intensity2580_g77407 = _ElementIntensity;
				float temp_output_6_0_g77425 = (MainTex_RGBA587_g77407).a;
				float temp_output_7_0_g77425 = SpaceTexture2395_g77407;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77425 = ( temp_output_6_0_g77425 + temp_output_7_0_g77425 );
				#else
				float staticSwitch14_g77425 = temp_output_6_0_g77425;
				#endif
				float clampResult17_g77420 = clamp( staticSwitch14_g77425 , 0.0001 , 0.9999 );
				float temp_output_7_0_g77423 = _MainTexAlphaRemap.x;
				float temp_output_9_0_g77423 = ( clampResult17_g77420 - temp_output_7_0_g77423 );
				half Element_Remap_A74_g77407 = saturate( ( temp_output_9_0_g77423 * _MainTexAlphaRemap.z ) );
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half Element_Params_A1737_g77407 = _ElementParams_Instance.w;
				half Element_Falloff1883_g77407 = 1.0;
				float temp_output_7_0_g77410 = 1.0;
				float temp_output_9_0_g77410 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g77410 );
				float lerpResult18_g77408 = lerp( 1.0 , saturate( ( temp_output_9_0_g77410 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g77410 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g77408 = lerpResult18_g77408;
				float temp_output_6_0_g77411 = Blend_Edge69_g77408;
				half Dummy72_g77408 = ( _BoundsCategory + _BoundsEnd );
				float temp_output_7_0_g77411 = Dummy72_g77408;
				#ifdef TVE_DUMMY
				float staticSwitch14_g77411 = ( temp_output_6_0_g77411 + temp_output_7_0_g77411 );
				#else
				float staticSwitch14_g77411 = temp_output_6_0_g77411;
				#endif
				float temp_output_6_0_g77416 = 1.0;
				float temp_output_7_0_g77416 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				float staticSwitch14_g77416 = ( temp_output_6_0_g77416 + temp_output_7_0_g77416 );
				#else
				float staticSwitch14_g77416 = temp_output_6_0_g77416;
				#endif
				half Element_Alpha56_g77407 = ( Element_Intensity2580_g77407 * Element_Remap_A74_g77407 * Element_Params_A1737_g77407 * i.ase_color.a * Element_Falloff1883_g77407 * staticSwitch14_g77411 * 1.0 * staticSwitch14_g77416 );
				half Final_MotionInteraction_A305_g77407 = Element_Alpha56_g77407;
				float4 appendResult2473_g77407 = (float4(Final_MotionInteraction_Visual2204_g77407 , Final_MotionInteraction_A305_g77407));
				half4 Input_Visual94_g77455 = appendResult2473_g77407;
				float2 temp_output_135_0_g77455 = (Input_Visual94_g77455).xy;
				float3 appendResult140_g77455 = (float3(( temp_output_135_0_g77455 * temp_output_135_0_g77455 ) , (Input_Visual94_g77455).z));
				half3 Element_Color47_g77455 = saturate( appendResult140_g77455 );
				float4 appendResult131_g77455 = (float4(Element_Color47_g77455 , (Input_Visual94_g77455).w));
				
				
				finalColor = appendResult131_g77455;
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
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":461,"pos":[-640,-896],"params":["Inherit","False","Element Type Flow","1","","77218","c08e6ab33dbacc04780022d2dbd4852d","0","0","1","FLOAT","4"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":469,"pos":[-384,-896],"params":["Inherit","False","Element Shader","11","","77407","0e972c73cae2ee54ea51acc9738801d0","15,1778,2,477,2,478,0,1824,0,1814,1,145,1,1784,0,481,0,2614,0,2618,0,1904,0,1907,0,2377,1,2310,0,2311,1","2","1974","FLOAT","0","False","2378","FLOAT","1","False","2","FLOAT4","0","FLOAT4","1779"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":197,"pos":[-640,-1152],"params":["Half","False","Property","_render_colormask","_render_colormask","107","1","[HideInInspector]","Create","True","0","0","0","True","0","False","Object","-1","","15","15","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":380,"pos":[64,-1280],"params":["Inherit","False","Element Compile","-1","","77454","5302407fc6d65554791e558e67d59358","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":467,"pos":[-128,-768],"params":["Inherit","False","Element Visuals","-1","","77455","78cf0f00cfd72824e84597f2db54a76e","1,64,2","2","59","FLOAT4","0,0,0,0","False","77","FLOAT3","1,1,1","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":115,"pos":[-640,-1280],"params":["Half","False","Property","_ElementMessage","Element Message","0","0","Create","True","0","0","0","True","1","StyledMessage(Info, Use Motion Interaction elements to add touch bending to the vegetation objects. Element Texture RG is used a World XZ bending. Element Texture A and Particle Color A are used as alpha masks., 0, 15)","False","Object","-1","","0","0","1","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":463,"pos":[-64,-896],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","1","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass1","0","1","VolumePass1","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass1","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":464,"pos":[-64,-896],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","1","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass2","0","2","VolumePass2","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass2","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":382,"pos":[64,-896],"params":["Float","False","True","-1","2","TheVisualEngine.ElementGUI","100","2","BOXOPHOBIC/The Visual Engine/Elements/Flow Interaction (Simple)","f4f273c3bb6262d4396be458405e60f9","True","VolumePass","0","0","VolumePass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","3","RenderType=Transparent=RenderType","Queue=Transparent=Queue=0","DisableBatching=True=DisableBatching","False","False","0","True","True","2","5","False","","10","False","","0","5","False","","10","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","True","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass","True","2","False","0","","0","0","Standard","3","VolumePass1","0","0","VolumePass2","0","0","Vertex Position","1","0","0","4","True","False","False","True","False","","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":383,"pos":[64,-768],"params":["Float","False","False","-1","2","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VisualPass","0","3","VisualPass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","True","True","2","5","False","","10","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","True","True","True","True","True","True","0","True","_render_colormask","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","False","True","2","False","0","","0","0","Standard","0","False","0"]}
{"wire":[469,1974,461,4]}
{"wire":[467,59,469,1779]}
{"wire":[382,0,469,0]}
{"wire":[383,0,467,0]}
ASEEND*/
//CHKSM=D20662AE9947A41D758A3281511C3347355FECF2