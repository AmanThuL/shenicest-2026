// Upgrade NOTE: upgraded instancing buffer 'BOXOPHOBICTheVisualEngineElementsFlowInteractionPanner' to new syntax.

// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Elements/Flow Interaction (Panner)"
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
		[StyledSpace(10)] _RenderEnd( "[ Render End ]", Float ) = 0
		[StyledCategory(Element Settings, true, 0, 10)] _ElementCategory( "[ Element Category ]", Float ) = 1
		[Space(10)][StyledTextureSingleLine] _MotionTex( "Motion Texture", 2D ) = "linearGrey" {}
		[Enum(Model UV0 X,0,Model UV0 Y,1)][Space(10)] _MotionCoordMode( "Motion Direction", Float ) = 1
		_MotionNoiseValue( "Motion Noise", Range( 0, 1 ) ) = 0
		_MotionTillingValue( "Motion Tilling", Range( 0, 100 ) ) = 5
		_MotionSpeedValue( "Motion Speed", Range( 0, 50 ) ) = 5
		[Space(10)] _SpeedTresholdValue( "Particle Speed Treshold", Float ) = 10
		[Space(10)][StyledToggle] _ElementInvertMode( "Use Inverted Direction", Float ) = 0
		[StyledSpace(10)] _ElementEnd( "[ Element End ]", Float ) = 0
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
			#include "UnityShaderVariables.cginc"
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0


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
			uniform float _MotionCoordMode;
			uniform float _ElementInvertMode;
			uniform sampler2D _MotionTex;
			uniform half _MotionTillingValue;
			uniform half4 TVE_TimeParams;
			uniform half _MotionSpeedValue;
			uniform half _MotionNoiseValue;
			uniform float _ElementIntensity;
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsFlowInteractionPanner)
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsFlowInteractionPanner)
			float2 SwitchChannel2( half Option, float2 A, float2 B )
			{
				switch (Option) {
					default:
				                case 0:
						return A;
					case 1:
						return B;
				}
			}
			

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
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
				float Motion_CoordMode2514_g80188 = _MotionCoordMode;
				float Option2523_g80188 = Motion_CoordMode2514_g80188;
				float2 appendResult2505_g80188 = (float2(1.0 , 0.0));
				half2 Direction_UVX2506_g80188 = appendResult2505_g80188;
				float2 A2523_g80188 = Direction_UVX2506_g80188;
				float2 appendResult2507_g80188 = (float2(0.0 , 1.0));
				half2 Direction_UVY2508_g80188 = appendResult2507_g80188;
				float2 B2523_g80188 = Direction_UVY2508_g80188;
				float2 localSwitchChannel22523_g80188 = SwitchChannel2( Option2523_g80188 , A2523_g80188 , B2523_g80188 );
				half Element_InvertMode489_g80188 = _ElementInvertMode;
				float2 lerpResult2516_g80188 = lerp( localSwitchChannel22523_g80188 , -localSwitchChannel22523_g80188 , Element_InvertMode489_g80188);
				half2 Direction_Panner2518_g80188 = lerpResult2516_g80188;
				float Motion_Tilling2576_g80188 = _MotionTillingValue;
				float2 Input_Coords80_g80231 = ( i.ase_texcoord1.xy * Motion_Tilling2576_g80188 );
				half2 Input_Direction82_g80231 = Direction_Panner2518_g80188;
				float mulTime113_g80230 = _Time.y * 0.02;
				float lerpResult128_g80230 = lerp( mulTime113_g80230 , ( ( mulTime113_g80230 * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				half Motion_Speed2512_g80188 = _MotionSpeedValue;
				float Input_Time88_g80231 = ( frac( lerpResult128_g80230 ) * Motion_Speed2512_g80188 );
				float4 temp_output_2575_0_g80188 = tex2D( _MotionTex, ( Input_Coords80_g80231 + ( Input_Direction82_g80231 * Input_Time88_g80231 ) ) );
				half2 Motion_PannerRG2550_g80188 = ((temp_output_2575_0_g80188).rg*2.0 + -1.0);
				half Motion_Noise2056_g80188 = _MotionNoiseValue;
				float2 lerpResult2529_g80188 = lerp( -Direction_Panner2518_g80188 , Motion_PannerRG2550_g80188 , Motion_Noise2056_g80188);
				float2 temp_cast_0 = (0.001).xx;
				float2 temp_cast_1 = (0.999).xx;
				float2 clampResult2535_g80188 = clamp( (lerpResult2529_g80188*0.5 + 0.5) , temp_cast_0 , temp_cast_1 );
				float3 appendResult2527_g80188 = (float3(clampResult2535_g80188 , Motion_Noise2056_g80188));
				half3 Final_MotionPanner_RGB2536_g80188 = appendResult2527_g80188;
				half Element_Intensity2580_g80188 = _ElementIntensity;
				float4 appendResult2561_g80188 = (float4(Final_MotionPanner_RGB2536_g80188 , Element_Intensity2580_g80188));
				
				
				finalColor = appendResult2561_g80188;
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
			uniform float _MotionCoordMode;
			uniform float _ElementInvertMode;
			uniform sampler2D _MotionTex;
			uniform half _MotionTillingValue;
			uniform half4 TVE_TimeParams;
			uniform half _MotionSpeedValue;
			uniform half _MotionNoiseValue;
			uniform float _ElementIntensity;
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsFlowInteractionPanner)
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsFlowInteractionPanner)
			float2 SwitchChannel2( half Option, float2 A, float2 B )
			{
				switch (Option) {
					default:
				                case 0:
						return A;
					case 1:
						return B;
				}
			}
			

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
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
				float Motion_CoordMode2514_g80188 = _MotionCoordMode;
				float Option2523_g80188 = Motion_CoordMode2514_g80188;
				float2 appendResult2505_g80188 = (float2(1.0 , 0.0));
				half2 Direction_UVX2506_g80188 = appendResult2505_g80188;
				float2 A2523_g80188 = Direction_UVX2506_g80188;
				float2 appendResult2507_g80188 = (float2(0.0 , 1.0));
				half2 Direction_UVY2508_g80188 = appendResult2507_g80188;
				float2 B2523_g80188 = Direction_UVY2508_g80188;
				float2 localSwitchChannel22523_g80188 = SwitchChannel2( Option2523_g80188 , A2523_g80188 , B2523_g80188 );
				half Element_InvertMode489_g80188 = _ElementInvertMode;
				float2 lerpResult2516_g80188 = lerp( localSwitchChannel22523_g80188 , -localSwitchChannel22523_g80188 , Element_InvertMode489_g80188);
				half2 Direction_Panner2518_g80188 = lerpResult2516_g80188;
				float Motion_Tilling2576_g80188 = _MotionTillingValue;
				float2 Input_Coords80_g80231 = ( i.ase_texcoord1.xy * Motion_Tilling2576_g80188 );
				half2 Input_Direction82_g80231 = Direction_Panner2518_g80188;
				float mulTime113_g80230 = _Time.y * 0.02;
				float lerpResult128_g80230 = lerp( mulTime113_g80230 , ( ( mulTime113_g80230 * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				half Motion_Speed2512_g80188 = _MotionSpeedValue;
				float Input_Time88_g80231 = ( frac( lerpResult128_g80230 ) * Motion_Speed2512_g80188 );
				float4 temp_output_2575_0_g80188 = tex2D( _MotionTex, ( Input_Coords80_g80231 + ( Input_Direction82_g80231 * Input_Time88_g80231 ) ) );
				half2 Motion_PannerRG2550_g80188 = ((temp_output_2575_0_g80188).rg*2.0 + -1.0);
				half Motion_Noise2056_g80188 = _MotionNoiseValue;
				float2 lerpResult2529_g80188 = lerp( -Direction_Panner2518_g80188 , Motion_PannerRG2550_g80188 , Motion_Noise2056_g80188);
				float2 temp_cast_0 = (0.001).xx;
				float2 temp_cast_1 = (0.999).xx;
				float2 clampResult2535_g80188 = clamp( (lerpResult2529_g80188*0.5 + 0.5) , temp_cast_0 , temp_cast_1 );
				float3 appendResult2527_g80188 = (float3(clampResult2535_g80188 , Motion_Noise2056_g80188));
				half3 Final_MotionPanner_RGB2536_g80188 = appendResult2527_g80188;
				half Element_Intensity2580_g80188 = _ElementIntensity;
				float4 appendResult2563_g80188 = (float4(Final_MotionPanner_RGB2536_g80188 , Element_Intensity2580_g80188));
				half4 Input_Visual94_g80237 = appendResult2563_g80188;
				float2 temp_output_135_0_g80237 = (Input_Visual94_g80237).xy;
				float3 appendResult140_g80237 = (float3(( temp_output_135_0_g80237 * temp_output_135_0_g80237 ) , (Input_Visual94_g80237).z));
				half3 Element_Color47_g80237 = saturate( appendResult140_g80237 );
				float4 appendResult131_g80237 = (float4(Element_Color47_g80237 , (Input_Visual94_g80237).w));
				
				
				finalColor = appendResult131_g80237;
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
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":794,"pos":[-384,-768],"params":["Inherit","False","Element Shader","14","","80188","0e972c73cae2ee54ea51acc9738801d0","13,477,2,1778,2,478,0,1824,0,1814,1,145,1,1784,2,481,2,1904,0,1907,0,2377,0,2310,0,2311,1","2","1974","FLOAT","0","False","2378","FLOAT","1","False","2","FLOAT4","0","FLOAT4","1779"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":197,"pos":[-640,-960],"params":["Half","False","Property","_render_colormask","_render_colormask","110","1","[HideInInspector]","Create","True","0","0","0","True","0","False","Object","-1","","15","15","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":440,"pos":[-640,-1280],"params":["Half","False","Property","_ElementDirectionForwardMessage","Element Direction Message","1","0","Create","False","0","0","0","True","1","StyledMessage(Info, The Element Forward mode is setting the direction in the element transform forward axis. Element Texture A and Particle Color A are used as alpha masks., _MotionDirectionMode, 0, 0, 15)","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":441,"pos":[-640,-1216],"params":["Half","False","Property","_ElementDirectionTextureMessage","Element Direction Message","0","0","Create","False","0","0","0","True","1","StyledMessage(Info, The Element Texture mode is setting the direction based on the Element Texture__ where RG is used as World XZ direction. Element Texture A and Particle Color A are used as alpha masks., _MotionDirectionMode, 1, 0, 15)","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":442,"pos":[-640,-1152],"params":["Half","False","Property","_ElementDirectionTranslateMessage","Element Direction Message","2","0","Create","False","0","0","0","True","1","StyledMessage(Info, The Particle Translate mode is setting the direction based on the particle gameobject transform movement direction. Use the Speed Treshold to control how fast the particle movement is transformend into interaction. Element Texture A and Particle Color A are used as alpha masks., _MotionDirectionMode, 2, 0, 15)","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":439,"pos":[-640,-1088],"params":["Half","False","Property","_ElementDirectionVelocityMessage","Element Direction Message","3","0","Create","False","0","0","0","True","1","StyledMessage(Info, The Particle Velocity mode is setting the direction based on the particles motion direction. This option requires the particle to have custom vertex streams for Velocity and Speed set after the UV stream under the particle Renderer module. Element Texture A and Particle Color A are used as alpha masks., _MotionDirectionMode, 3, 0, 15)","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":416,"pos":[64,-1280],"params":["Inherit","False","Element Compile","-1","","80236","5302407fc6d65554791e558e67d59358","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":767,"pos":[-128,-640],"params":["Inherit","False","Element Visuals","-1","","80237","78cf0f00cfd72824e84597f2db54a76e","1,64,2","2","59","FLOAT4","0,0,0,0","False","77","FLOAT3","1,1,1","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":754,"pos":[-64,-768],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass1","0","1","VolumePass1","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass1","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":755,"pos":[-64,-768],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass2","0","2","VolumePass2","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass2","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":417,"pos":[64,-768],"params":["Float","False","True","-1","2","TheVisualEngine.ElementGUI","100","2","BOXOPHOBIC/The Visual Engine/Elements/Flow Interaction (Panner)","f4f273c3bb6262d4396be458405e60f9","True","VolumePass","0","0","VolumePass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","3","RenderType=Transparent=RenderType","Queue=Transparent=Queue=0","DisableBatching=True=DisableBatching","False","False","0","True","True","2","5","False","","10","False","","0","5","False","","10","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","True","True","True","True","True","False","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass","True","2","False","0","","0","0","Standard","3","VolumePass1","0","0","VolumePass2","0","0","Vertex Position","1","0","0","4","True","False","False","True","False","","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":418,"pos":[64,-640],"params":["Float","False","False","-1","2","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VisualPass","0","3","VisualPass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","True","True","2","5","False","","10","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","False","True","2","False","0","","0","0","Standard","0","False","0"]}
{"wire":[794,1974,757,4]}
{"wire":[767,59,794,1779]}
{"wire":[417,0,794,0]}
{"wire":[418,0,767,0]}
ASEEND*/
//CHKSM=03141EA013D1C4730CB14C06C3517CA5F6E10E44