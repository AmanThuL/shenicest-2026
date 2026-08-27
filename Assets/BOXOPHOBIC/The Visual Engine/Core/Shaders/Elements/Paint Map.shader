// Upgrade NOTE: upgraded instancing buffer 'BOXOPHOBICTheVisualEngineElementsPaintMap' to new syntax.

// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Elements/Paint Map"
{
	Properties
	{
		[StyledMessage(Info, Use Paint Map elements to add color tinting to the vegetation assets. Element Texture RGB is used as tint color and Texture A is used as alpha mask., 0, 15)] _ElementMessage( "Element Message", Float ) = 0
		[HideInInspector] _IsVersion( "_IsVersion", Float ) = 2200
		[HideInInspector] _IsElementShader( "_IsElementShader", Float ) = 1
		[HideInInspector] _IsIdentifier( "_IsIdentifier", Float ) = 0
		[StyledCategory(Render Settings, true, 0, 10)] _RenderCategory( "[ Render Category ]", Float ) = 1
		_ElementIntensity( "Render Intensity", Range( 0, 1 ) ) = 1
		[StyledMessage(Info, When using a higher Layer number the Global Volume will create more render textures to render the elements. Try using fewer layers when possible., _ElementLayerMessage, 1, 10, 10)] _ElementLayerMessage( "Render Layer Message", Float ) = 0
		[StyledMessage(Warning, When using all layers the Global Volume will create one render texture for each layer to render the elements. Try using fewer layers when possible., _ElementLayerWarning, 1, 10, 10)] _ElementLayerWarning( "Render Layer Warning", Float ) = 0
		[StyledMask(Paint Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _ElementLayerMask( "Render Layer", Float ) = 1
		[StyledSpace(10)] _RenderEnd( "[ Render End ]", Float ) = 0
		[StyledCategory(Element Settings, true, 0, 10)] _ElementCategory( "[ Element Category ]", Float ) = 1
		[NoScaleOffset][StyledTextureSingleLine] _MainTex( "Element Texture", 2D ) = "white" {}
		[HDR][Gamma][Space(10)] _MainColor( "Element Value", Color ) = ( 0.5019608, 0.5019608, 0.5019608, 1 )
		[Space(10)] _AdditionalValue1( "Season Winter", Range( 0, 1 ) ) = 1
		_AdditionalValue2( "Season Spring", Range( 0, 1 ) ) = 1
		_AdditionalValue3( "Season Summer", Range( 0, 1 ) ) = 1
		_AdditionalValue4( "Season Autumn", Range( 0, 1 ) ) = 1
		[Space(10)][StyledRemapSlider] _SeasonRemap( "Season Curve", Vector ) = ( 0, 1, 0, 0 )
		[Space(10)] _SpeedTresholdValue( "Particle Speed Treshold", Float ) = 10
		[StyledSpace(10)] _ElementEnd( "[ Element End ]", Float ) = 0
		[HideInInspector] _UseTerrainAlbedo( "_UseTerrainAlbedo", Float ) = 1
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
			uniform half _ElementMessage;
			uniform half _UseTerrainAlbedo;
			uniform half4 _MainColor;
			uniform sampler2D _MainTex;
			uniform half _ElementIntensity;
			uniform half4 TVE_SeasonOption;
			uniform half _AdditionalValue1;
			uniform half _AdditionalValue2;
			uniform half TVE_SeasonLerp;
			uniform half4 _SeasonRemap;
			uniform half _AdditionalValue3;
			uniform half _AdditionalValue4;
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsPaintMap)
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsPaintMap)

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				half TVE_SeasonOptions_X50_g77511 = TVE_SeasonOption.x;
				half Value_Winter158_g77511 = _AdditionalValue1;
				half Value_Spring159_g77511 = _AdditionalValue2;
				half temp_output_7_0_g77522 = _SeasonRemap.x;
				half temp_output_9_0_g77522 = ( TVE_SeasonLerp - temp_output_7_0_g77522 );
				half smoothstepResult2286_g77511 = smoothstep( 0.0 , 1.0 , saturate( ( temp_output_9_0_g77522 * _SeasonRemap.z ) ));
				half SeasonLerp54_g77511 = smoothstepResult2286_g77511;
				half lerpResult168_g77511 = lerp( Value_Winter158_g77511 , Value_Spring159_g77511 , SeasonLerp54_g77511);
				half TVE_SeasonOptions_Y51_g77511 = TVE_SeasonOption.y;
				half Value_Summer160_g77511 = _AdditionalValue3;
				half lerpResult167_g77511 = lerp( Value_Spring159_g77511 , Value_Summer160_g77511 , SeasonLerp54_g77511);
				half TVE_SeasonOptions_Z52_g77511 = TVE_SeasonOption.z;
				half Value_Autumn161_g77511 = _AdditionalValue4;
				half lerpResult166_g77511 = lerp( Value_Summer160_g77511 , Value_Autumn161_g77511 , SeasonLerp54_g77511);
				half TVE_SeasonOptions_W53_g77511 = TVE_SeasonOption.w;
				half lerpResult165_g77511 = lerp( Value_Autumn161_g77511 , Value_Winter158_g77511 , SeasonLerp54_g77511);
				half temp_output_175_0_g77511 = ( ( TVE_SeasonOptions_X50_g77511 * lerpResult168_g77511 ) + ( TVE_SeasonOptions_Y51_g77511 * lerpResult167_g77511 ) + ( TVE_SeasonOptions_Z52_g77511 * lerpResult166_g77511 ) + ( TVE_SeasonOptions_W53_g77511 * lerpResult165_g77511 ) );
				half vertexToFrag11_g77516 = temp_output_175_0_g77511;
				o.ase_texcoord1.z = vertexToFrag11_g77516;
				
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
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
				half4 Color_Main_RGBA49_g77511 = _MainColor;
				half4 MainTex_RGBA587_g77511 = tex2D( _MainTex, ( 1.0 - i.ase_texcoord1.xy ) );
				half3 Final_ColorsMap_RGB598_g77511 = ( (Color_Main_RGBA49_g77511).rgb * (MainTex_RGBA587_g77511).rgb );
				half vertexToFrag11_g77516 = i.ase_texcoord1.z;
				half Value_Seasons1721_g77511 = vertexToFrag11_g77516;
				half Final_ColorsMap_A603_g77511 = ( _ElementIntensity * Value_Seasons1721_g77511 );
				half4 appendResult622_g77511 = (half4(Final_ColorsMap_RGB598_g77511 , Final_ColorsMap_A603_g77511));
				
				
				finalColor = appendResult622_g77511;
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
			uniform half _SpeedTresholdValue;
			uniform half _render_colormask;
			uniform half _ElementMessage;
			uniform half _UseTerrainAlbedo;
			uniform half4 _MainColor;
			uniform sampler2D _MainTex;
			uniform half _ElementIntensity;
			uniform half4 TVE_SeasonOption;
			uniform half _AdditionalValue1;
			uniform half _AdditionalValue2;
			uniform half TVE_SeasonLerp;
			uniform half4 _SeasonRemap;
			uniform half _AdditionalValue3;
			uniform half _AdditionalValue4;
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsPaintMap)
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsPaintMap)

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				half TVE_SeasonOptions_X50_g77511 = TVE_SeasonOption.x;
				half Value_Winter158_g77511 = _AdditionalValue1;
				half Value_Spring159_g77511 = _AdditionalValue2;
				half temp_output_7_0_g77522 = _SeasonRemap.x;
				half temp_output_9_0_g77522 = ( TVE_SeasonLerp - temp_output_7_0_g77522 );
				half smoothstepResult2286_g77511 = smoothstep( 0.0 , 1.0 , saturate( ( temp_output_9_0_g77522 * _SeasonRemap.z ) ));
				half SeasonLerp54_g77511 = smoothstepResult2286_g77511;
				half lerpResult168_g77511 = lerp( Value_Winter158_g77511 , Value_Spring159_g77511 , SeasonLerp54_g77511);
				half TVE_SeasonOptions_Y51_g77511 = TVE_SeasonOption.y;
				half Value_Summer160_g77511 = _AdditionalValue3;
				half lerpResult167_g77511 = lerp( Value_Spring159_g77511 , Value_Summer160_g77511 , SeasonLerp54_g77511);
				half TVE_SeasonOptions_Z52_g77511 = TVE_SeasonOption.z;
				half Value_Autumn161_g77511 = _AdditionalValue4;
				half lerpResult166_g77511 = lerp( Value_Summer160_g77511 , Value_Autumn161_g77511 , SeasonLerp54_g77511);
				half TVE_SeasonOptions_W53_g77511 = TVE_SeasonOption.w;
				half lerpResult165_g77511 = lerp( Value_Autumn161_g77511 , Value_Winter158_g77511 , SeasonLerp54_g77511);
				half temp_output_175_0_g77511 = ( ( TVE_SeasonOptions_X50_g77511 * lerpResult168_g77511 ) + ( TVE_SeasonOptions_Y51_g77511 * lerpResult167_g77511 ) + ( TVE_SeasonOptions_Z52_g77511 * lerpResult166_g77511 ) + ( TVE_SeasonOptions_W53_g77511 * lerpResult165_g77511 ) );
				half vertexToFrag11_g77516 = temp_output_175_0_g77511;
				o.ase_texcoord1.z = vertexToFrag11_g77516;
				
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
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
				half4 Color_Main_RGBA49_g77511 = _MainColor;
				half4 MainTex_RGBA587_g77511 = tex2D( _MainTex, ( 1.0 - i.ase_texcoord1.xy ) );
				half3 Final_ColorsMap_RGB598_g77511 = ( (Color_Main_RGBA49_g77511).rgb * (MainTex_RGBA587_g77511).rgb );
				half vertexToFrag11_g77516 = i.ase_texcoord1.z;
				half Value_Seasons1721_g77511 = vertexToFrag11_g77516;
				half Final_ColorsMap_A603_g77511 = ( _ElementIntensity * Value_Seasons1721_g77511 );
				half4 appendResult2465_g77511 = (half4(Final_ColorsMap_RGB598_g77511 , Final_ColorsMap_A603_g77511));
				half4 Input_Visual94_g77559 = appendResult2465_g77511;
				half3 Element_Color47_g77559 = saturate( (Input_Visual94_g77559).xyz );
				half4 appendResult131_g77559 = (half4(Element_Color47_g77559 , (Input_Visual94_g77559).w));
				
				
				finalColor = appendResult131_g77559;
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
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":161,"pos":[-640,-384],"params":["Inherit","False","Element Type Paint","1","","24792","5810d2854679b554b88f8bb18ff3bfa0","0","0","1","FLOAT","4"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":175,"pos":[-384,-384],"params":["Inherit","False","Element Shader","11","","77511","0e972c73cae2ee54ea51acc9738801d0","15,1778,0,477,0,478,1,1824,1,1814,0,145,0,1784,0,481,0,2614,0,2618,0,1904,0,1907,0,2377,0,2310,0,2311,1","2","1974","FLOAT","0","False","2378","FLOAT","1","False","2","FLOAT4","0","FLOAT4","1779"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":139,"pos":[-640,-640],"params":["Half","False","Property","_render_colormask","_render_colormask","108","1","[HideInInspector]","Create","True","0","0","0","True","0","False","Object","-1","","15","15","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":152,"pos":[64,-768],"params":["Inherit","False","Element Compile","-1","","77558","5302407fc6d65554791e558e67d59358","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":176,"pos":[-128,-256],"params":["Inherit","False","Element Visuals","-1","","77559","78cf0f00cfd72824e84597f2db54a76e","1,64,0","2","59","FLOAT4","0,0,0,0","False","77","FLOAT3","1,1,1","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":168,"pos":[-384,-768],"params":["Half","False","Property","_UseTerrainAlbedo","_UseTerrainAlbedo","107","1","[HideInInspector]","Create","True","0","0","0","True","0","False","Object","-1","","1","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":100,"pos":[-640,-768],"params":["Half","False","Property","_ElementMessage","Element Message","0","0","Create","True","0","0","0","True","1","StyledMessage(Info, Use Paint Map elements to add color tinting to the vegetation assets. Element Texture RGB is used as tint color and Texture A is used as alpha mask., 0, 15)","False","Object","-1","","0","0","1","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":162,"pos":[-64,-384],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","15","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass1","0","1","VolumePass1","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass1","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":163,"pos":[-64,-384],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","15","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass2","0","2","VolumePass2","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass2","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":153,"pos":[64,-384],"params":["Half","False","True","-1","2","TheVisualEngine.ElementGUI","100","2","BOXOPHOBIC/The Visual Engine/Elements/Paint Map","f4f273c3bb6262d4396be458405e60f9","True","VolumePass","0","0","VolumePass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","3","RenderType=Transparent=RenderType","Queue=Transparent=Queue=0","DisableBatching=True=DisableBatching","False","False","0","True","True","2","5","False","","10","False","","2","5","False","","10","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","True","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass","True","2","False","0","","0","0","Standard","3","VolumePass1","0","0","VolumePass2","0","0","Vertex Position","1","0","0","4","True","False","False","True","False","","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":154,"pos":[64,-256],"params":["Float","False","False","-1","2","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VisualPass","0","3","VisualPass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","True","True","2","5","False","","10","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","False","True","2","False","0","","0","0","Standard","0","False","0"]}
{"wire":[175,2378,161,4]}
{"wire":[176,59,175,1779]}
{"wire":[153,0,175,0]}
{"wire":[154,0,176,0]}
ASEEND*/
//CHKSM=0B20175ECDADE2697DCB6320B5ADC384BF1CAAEA