// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Elements/Paint Maps"
{
	Properties
	{
		[HideInInspector] _IsVersion( "_IsVersion", Float ) = 2200
		[HideInInspector] _IsElementShader( "_IsElementShader", Float ) = 1
		[HideInInspector] _IsIdentifier( "_IsIdentifier", Float ) = 0
		[StyledCategory(Render Settings, true, 0, 10)] _RenderCategory( "[ Render Category ]", Float ) = 1
		_ElementIntensity( "Render Intensity", Range( 0, 1 ) ) = 1
		[StyledMessage(Info, When using a higher Layer number the Global Volume will create more render textures to render the elements. Try using fewer layers when possible., _ElementLayerMessage, 1, 10, 10)] _ElementLayerMessage( "Render Layer Message", Float ) = 0
		[StyledMessage(Warning, When using all layers the Global Volume will create one render texture for each layer to render the elements. Try using fewer layers when possible., _ElementLayerWarning, 1, 10, 10)] _ElementLayerWarning( "Render Layer Warning", Float ) = 0
		[StyledMask(Paint Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _ElementLayerMask( "Render Layer", Float ) = 1
		[StyledSpace(10)] _EndRender( "[ End Render ]", Float ) = 1
		[StyledCategory(Element Settings, true, 0, 10)] _CategoryElement( "[ Category Element ]", Float ) = 1
		[NoScaleOffset][StyledTextureSingleLine] _MainTex1( "Element Winter", 2D ) = "white" {}
		[NoScaleOffset][StyledTextureSingleLine] _MainTex2( "Element Spring", 2D ) = "white" {}
		[NoScaleOffset][StyledTextureSingleLine] _MainTex3( "Element Summer", 2D ) = "white" {}
		[NoScaleOffset][StyledTextureSingleLine] _MainTex4( "Element Autumn", 2D ) = "white" {}
		[Space(10)][StyledRemapSlider] _SeasonRemap( "Season Curve", Vector ) = ( 0, 1, 0, 0 )
		[StyledSpace(10)] _EndElement( "[ End Element ]", Float ) = 1
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
			uniform half _CategoryElement;
			uniform half _EndElement;
			uniform half _EndRender;
			uniform half4 TVE_SeasonOption;
			uniform sampler2D _MainTex1;
			uniform sampler2D _MainTex2;
			uniform half TVE_SeasonLerp;
			uniform half4 _SeasonRemap;
			uniform sampler2D _MainTex3;
			uniform sampler2D _MainTex4;
			uniform float _ElementIntensity;
			uniform half4 TVE_RenderBasePositionR;
			uniform float _ElementVolumeFadeValue;
			uniform float _ElementVolumeFadeMode;
			uniform half _BoundsCategory;
			uniform half _BoundsEnd;

			
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
				half TVE_SeasonOptions_X227 = TVE_SeasonOption.x;
				float2 uv_MainTex1248 = i.ase_texcoord1.xy;
				half3 Value_Winter251 = tex2D( _MainTex1, uv_MainTex1248 ).rgb;
				float2 uv_MainTex2253 = i.ase_texcoord1.xy;
				half3 Value_Spring249 = tex2D( _MainTex2, uv_MainTex2253 ).rgb;
				float temp_output_7_0_g22367 = _SeasonRemap.x;
				float temp_output_9_0_g22367 = ( TVE_SeasonLerp - temp_output_7_0_g22367 );
				half TVE_SeasonLerp218 = saturate( saturate( ( temp_output_9_0_g22367 / ( ( _SeasonRemap.z - temp_output_7_0_g22367 ) + 0.0001 ) ) ) );
				float3 lerpResult261 = lerp( Value_Winter251 , Value_Spring249 , TVE_SeasonLerp218);
				half TVE_SeasonOptions_Y219 = TVE_SeasonOption.y;
				float2 uv_MainTex3254 = i.ase_texcoord1.xy;
				half3 Value_Summer250 = tex2D( _MainTex3, uv_MainTex3254 ).rgb;
				float3 lerpResult268 = lerp( Value_Spring249 , Value_Summer250 , TVE_SeasonLerp218);
				half TVE_SeasonOptions_Z220 = TVE_SeasonOption.z;
				float2 uv_MainTex4255 = i.ase_texcoord1.xy;
				half3 Value_Autumn252 = tex2D( _MainTex4, uv_MainTex4255 ).rgb;
				float3 lerpResult269 = lerp( Value_Summer250 , Value_Autumn252 , TVE_SeasonLerp218);
				half TVE_SeasonOptions_W221 = TVE_SeasonOption.w;
				float3 lerpResult267 = lerp( Value_Autumn252 , Value_Winter251 , TVE_SeasonLerp218);
				half3 Value_Seasons277 = ( ( TVE_SeasonOptions_X227 * lerpResult261 ) + ( TVE_SeasonOptions_Y219 * lerpResult268 ) + ( TVE_SeasonOptions_Z220 * lerpResult269 ) + ( TVE_SeasonOptions_W221 * lerpResult267 ) );
				float temp_output_7_0_g22421 = 1.0;
				float temp_output_9_0_g22421 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g22421 );
				float lerpResult18_g22419 = lerp( 1.0 , saturate( ( temp_output_9_0_g22421 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g22421 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g22419 = lerpResult18_g22419;
				float temp_output_6_0_g22422 = Blend_Edge69_g22419;
				half Dummy72_g22419 = ( _BoundsCategory + _BoundsEnd );
				float temp_output_7_0_g22422 = Dummy72_g22419;
				#ifdef TVE_DUMMY
				float staticSwitch14_g22422 = ( temp_output_6_0_g22422 + temp_output_7_0_g22422 );
				#else
				float staticSwitch14_g22422 = temp_output_6_0_g22422;
				#endif
				half Element_Alpha182 = ( _ElementIntensity * staticSwitch14_g22422 );
				float4 appendResult169 = (float4(Value_Seasons277 , Element_Alpha182));
				
				
				finalColor = appendResult169;
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
			uniform half _CategoryElement;
			uniform half _EndElement;
			uniform half _EndRender;
			uniform half4 TVE_SeasonOption;
			uniform sampler2D _MainTex1;
			uniform sampler2D _MainTex2;
			uniform half TVE_SeasonLerp;
			uniform half4 _SeasonRemap;
			uniform sampler2D _MainTex3;
			uniform sampler2D _MainTex4;
			uniform float _ElementIntensity;
			uniform half4 TVE_RenderBasePositionR;
			uniform float _ElementVolumeFadeValue;
			uniform float _ElementVolumeFadeMode;
			uniform half _BoundsCategory;
			uniform half _BoundsEnd;

			
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
				half TVE_SeasonOptions_X227 = TVE_SeasonOption.x;
				float2 uv_MainTex1248 = i.ase_texcoord1.xy;
				half3 Value_Winter251 = tex2D( _MainTex1, uv_MainTex1248 ).rgb;
				float2 uv_MainTex2253 = i.ase_texcoord1.xy;
				half3 Value_Spring249 = tex2D( _MainTex2, uv_MainTex2253 ).rgb;
				float temp_output_7_0_g22367 = _SeasonRemap.x;
				float temp_output_9_0_g22367 = ( TVE_SeasonLerp - temp_output_7_0_g22367 );
				half TVE_SeasonLerp218 = saturate( saturate( ( temp_output_9_0_g22367 / ( ( _SeasonRemap.z - temp_output_7_0_g22367 ) + 0.0001 ) ) ) );
				float3 lerpResult261 = lerp( Value_Winter251 , Value_Spring249 , TVE_SeasonLerp218);
				half TVE_SeasonOptions_Y219 = TVE_SeasonOption.y;
				float2 uv_MainTex3254 = i.ase_texcoord1.xy;
				half3 Value_Summer250 = tex2D( _MainTex3, uv_MainTex3254 ).rgb;
				float3 lerpResult268 = lerp( Value_Spring249 , Value_Summer250 , TVE_SeasonLerp218);
				half TVE_SeasonOptions_Z220 = TVE_SeasonOption.z;
				float2 uv_MainTex4255 = i.ase_texcoord1.xy;
				half3 Value_Autumn252 = tex2D( _MainTex4, uv_MainTex4255 ).rgb;
				float3 lerpResult269 = lerp( Value_Summer250 , Value_Autumn252 , TVE_SeasonLerp218);
				half TVE_SeasonOptions_W221 = TVE_SeasonOption.w;
				float3 lerpResult267 = lerp( Value_Autumn252 , Value_Winter251 , TVE_SeasonLerp218);
				half3 Value_Seasons277 = ( ( TVE_SeasonOptions_X227 * lerpResult261 ) + ( TVE_SeasonOptions_Y219 * lerpResult268 ) + ( TVE_SeasonOptions_Z220 * lerpResult269 ) + ( TVE_SeasonOptions_W221 * lerpResult267 ) );
				float temp_output_7_0_g22421 = 1.0;
				float temp_output_9_0_g22421 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g22421 );
				float lerpResult18_g22419 = lerp( 1.0 , saturate( ( temp_output_9_0_g22421 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g22421 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g22419 = lerpResult18_g22419;
				float temp_output_6_0_g22422 = Blend_Edge69_g22419;
				half Dummy72_g22419 = ( _BoundsCategory + _BoundsEnd );
				float temp_output_7_0_g22422 = Dummy72_g22419;
				#ifdef TVE_DUMMY
				float staticSwitch14_g22422 = ( temp_output_6_0_g22422 + temp_output_7_0_g22422 );
				#else
				float staticSwitch14_g22422 = temp_output_6_0_g22422;
				#endif
				half Element_Alpha182 = ( _ElementIntensity * staticSwitch14_g22422 );
				float4 appendResult281 = (float4(Value_Seasons277 , Element_Alpha182));
				half4 Input_Visual94_g22424 = appendResult281;
				half3 Element_Color47_g22424 = saturate( (Input_Visual94_g22424).xyz );
				float4 appendResult131_g22424 = (float4(Element_Color47_g22424 , (Input_Visual94_g22424).w));
				
				
				finalColor = appendResult131_g22424;
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
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":225,"pos":[-1920,-448],"params":["Half","False","Global","TVE_SeasonLerp","TVE_SeasonLerp","14","0","Create","True","0","0","0","False","0","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.Vector4Node, AmplifyShaderEditor","id":226,"pos":[-1920,-384],"params":["Half","False","Property","_SeasonRemap","Season Curve","17","0","Create","False","0","0","0","False","2","Space(10)","StyledRemapSlider","False","Object","-1","","0,1,0,0","0,0,0,0","0","5","FLOAT4","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":222,"pos":[-1600,-448],"params":["Inherit","False","Math Remap","-1","","22367","5eda8a2bb94ebef4ab0e43d19291cd8b","3,18,0,21,1,14,0","4","6","FLOAT","0","False","7","FLOAT","0","False","8","FLOAT","0","False","19","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor","id":223,"pos":[-1408,-448],"params":["Inherit","False","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor","id":248,"pos":[-3840,1664],"params":["Inherit","True","Property","_MainTex1","Element Winter","13","1","[NoScaleOffset]","Create","False","0","0","0","False","1","StyledTextureSingleLine","False","","-1","None","None","True","0","False","white","Auto","False","Object","-1","Auto","Texture2D","False","8","0","SAMPLER2D","","False","1","FLOAT2","0,0","False","2","FLOAT","0","False","3","FLOAT2","0,0","False","4","FLOAT2","0,0","False","5","FLOAT","1","False","6","FLOAT","0","False","7","SAMPLERSTATE","","False","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor","id":253,"pos":[-3840,1920],"params":["Inherit","True","Property","_MainTex2","Element Spring","14","1","[NoScaleOffset]","Create","False","0","0","0","False","1","StyledTextureSingleLine","False","","-1","None","None","True","0","False","white","Auto","False","Object","-1","Auto","Texture2D","False","8","0","SAMPLER2D","","False","1","FLOAT2","0,0","False","2","FLOAT","0","False","3","FLOAT2","0,0","False","4","FLOAT2","0,0","False","5","FLOAT","1","False","6","FLOAT","0","False","7","SAMPLERSTATE","","False","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor","id":254,"pos":[-3840,2176],"params":["Inherit","True","Property","_MainTex3","Element Summer","15","1","[NoScaleOffset]","Create","False","0","0","0","False","1","StyledTextureSingleLine","False","","-1","None","None","True","0","False","white","Auto","False","Object","-1","Auto","Texture2D","False","8","0","SAMPLER2D","","False","1","FLOAT2","0,0","False","2","FLOAT","0","False","3","FLOAT2","0,0","False","4","FLOAT2","0,0","False","5","FLOAT","1","False","6","FLOAT","0","False","7","SAMPLERSTATE","","False","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor","id":255,"pos":[-3840,2432],"params":["Inherit","True","Property","_MainTex4","Element Autumn","16","1","[NoScaleOffset]","Create","False","0","0","0","False","1","StyledTextureSingleLine","False","","-1","None","None","True","0","False","white","Auto","False","Object","-1","Auto","Texture2D","False","8","0","SAMPLER2D","","False","1","FLOAT2","0,0","False","2","FLOAT","0","False","3","FLOAT2","0,0","False","4","FLOAT2","0,0","False","5","FLOAT","1","False","6","FLOAT","0","False","7","SAMPLERSTATE","","False","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":218,"pos":[-1216,-448],"params":["Half","False","TVE_SeasonLerp","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":251,"pos":[-3456,1664],"params":["Half","False","Value_Winter","-1","True","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.Vector4Node, AmplifyShaderEditor","id":224,"pos":[-1920,-768],"params":["Half","False","Global","TVE_SeasonOption","TVE_SeasonOption","14","0","Create","True","0","0","0","False","0","False","Object","-1","","0,0,0,0","0,0,1,0","0","5","FLOAT4","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":249,"pos":[-3456,1920],"params":["Half","False","Value_Spring","-1","True","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":250,"pos":[-3456,2176],"params":["Half","False","Value_Summer","-1","True","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":252,"pos":[-3456,2432],"params":["Half","False","Value_Autumn","-1","True","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":257,"pos":[-1920,1920],"params":["Inherit","False","249","Value_Spring","1","0","OBJECT","","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":276,"pos":[-1920,2560],"params":["Inherit","False","218","TVE_SeasonLerp","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":219,"pos":[-1248,-672],"params":["Half","False","TVE_SeasonOptions_Y","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":220,"pos":[-1248,-608],"params":["Half","False","TVE_SeasonOptions_Z","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":221,"pos":[-1248,-544],"params":["Half","False","TVE_SeasonOptions_W","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":227,"pos":[-1248,-736],"params":["Half","False","TVE_SeasonOptions_X","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":258,"pos":[-1920,2176],"params":["Inherit","False","250","Value_Summer","1","0","OBJECT","","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":259,"pos":[-1920,2432],"params":["Inherit","False","252","Value_Autumn","1","0","OBJECT","","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":256,"pos":[-1920,1664],"params":["Inherit","False","251","Value_Winter","1","0","OBJECT","","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":261,"pos":[-1536,1792],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":260,"pos":[-1536,1664],"params":["Inherit","False","227","TVE_SeasonOptions_X","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":262,"pos":[-1536,1920],"params":["Inherit","False","219","TVE_SeasonOptions_Y","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":267,"pos":[-1536,2560],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":268,"pos":[-1536,2048],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":269,"pos":[-1536,2304],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":270,"pos":[-1536,2176],"params":["Inherit","False","220","TVE_SeasonOptions_Z","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":271,"pos":[-1536,2432],"params":["Inherit","False","221","TVE_SeasonOptions_W","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":202,"pos":[-1920,1120],"params":["Inherit","False","Element Type Paint","1","","22417","5810d2854679b554b88f8bb18ff3bfa0","0","0","1","FLOAT","4"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":263,"pos":[-1280,1920],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":264,"pos":[-1280,1664],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":272,"pos":[-1280,2432],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":273,"pos":[-1280,2176],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":195,"pos":[-1920,1184],"params":["Inherit","False","Element Bounds","19","","22419","4935729172cdadd45b9b14c3fa9c1db4","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":170,"pos":[-1664,1120],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":265,"pos":[-896,1664],"params":["Inherit","False","4","4","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT3","0,0,0","False","3","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":182,"pos":[-1216,1120],"params":["Half","False","Element_Alpha","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":277,"pos":[-576,1664],"params":["Half","False","Value_Seasons","-1","True","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":278,"pos":[256,2048],"params":["Inherit","False","277","Value_Seasons","1","0","OBJECT","","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":184,"pos":[256,2112],"params":["Inherit","False","182","Element_Alpha","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor","id":281,"pos":[640,2048],"params":["Inherit","False","FLOAT4","4","0","FLOAT3","0,0,0","False","1","FLOAT","0","False","2","FLOAT","0","False","3","FLOAT","0","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":167,"pos":[-1168,-1408],"params":["Inherit","False","Element Compile","-1","","22423","5302407fc6d65554791e558e67d59358","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":163,"pos":[-1664,-1408],"params":["Half","False","Property","_CategoryElement","[ Category Element ]","12","0","Create","True","0","0","0","True","1","StyledCategory(Element Settings, true, 0, 10)","False","Object","-1","","1","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":196,"pos":[-1664,-1344],"params":["Half","False","Property","_EndElement","[ End Element ]","18","0","Create","True","0","0","0","True","1","StyledSpace(10)","False","Object","-1","","1","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":200,"pos":[-1664,-1280],"params":["Half","False","Property","_EndRender","[ End Render ]","11","0","Create","True","0","0","0","True","1","StyledSpace(10)","False","Object","-1","","1","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":176,"pos":[256,1664],"params":["Inherit","False","277","Value_Seasons","1","0","OBJECT","","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":183,"pos":[256,1728],"params":["Inherit","False","182","Element_Alpha","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor","id":169,"pos":[640,1664],"params":["Inherit","False","FLOAT4","4","0","FLOAT3","0,0,0","False","1","FLOAT","0","False","2","FLOAT","0","False","3","FLOAT","0","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":180,"pos":[832,2048],"params":["Inherit","False","Element Visuals","-1","","22424","78cf0f00cfd72824e84597f2db54a76e","1,64,0","2","59","FLOAT4","0,0,0,0","False","77","FLOAT3","1,1,1","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":112,"pos":[-1920,-1408],"params":["Half","False","Property","_ElementMessage","Element Message","0","0","Create","True","0","0","0","False","1","StyledMessage(Info, Use Paint Maps elements to blend grass prefabs with terrains using one terrain base color per season., 0, 15)","False","Object","-1","","0","0","1","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":177,"pos":[1088,1664],"params":["Float","False","True","-1","2","TheVisualEngine.ElementGUI","100","2","BOXOPHOBIC/The Visual Engine/Elements/Paint Maps","f4f273c3bb6262d4396be458405e60f9","True","VolumePass","0","0","VolumePass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","3","RenderType=Transparent=RenderType","Queue=Transparent=Queue=0","DisableBatching=True=DisableBatching","False","False","0","True","True","2","5","False","","10","False","","2","5","False","","10","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","True","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass","True","2","False","0","","0","0","Standard","3","VolumePass1","0","0","VolumePass2","0","0","Vertex Position","1","0","0","4","True","False","False","True","False","","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":279,"pos":[1088,1664],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","1","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass1","0","1","VolumePass1","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass1","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":280,"pos":[1088,1664],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","1","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass2","0","2","VolumePass2","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass2","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":178,"pos":[1088,2048],"params":["Float","False","False","-1","2","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VisualPass","0","3","VisualPass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","True","True","2","5","False","","10","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","False","True","2","False","0","","0","0","Standard","0","False","0"]}
{"wire":[222,6,225,0]}
{"wire":[222,7,226,1]}
{"wire":[222,8,226,3]}
{"wire":[223,0,222,0]}
{"wire":[218,0,223,0]}
{"wire":[251,0,248,5]}
{"wire":[249,0,253,5]}
{"wire":[250,0,254,5]}
{"wire":[252,0,255,5]}
{"wire":[219,0,224,2]}
{"wire":[220,0,224,3]}
{"wire":[221,0,224,4]}
{"wire":[227,0,224,1]}
{"wire":[261,0,256,0]}
{"wire":[261,1,257,0]}
{"wire":[261,2,276,0]}
{"wire":[267,0,259,0]}
{"wire":[267,1,256,0]}
{"wire":[267,2,276,0]}
{"wire":[268,0,257,0]}
{"wire":[268,1,258,0]}
{"wire":[268,2,276,0]}
{"wire":[269,0,258,0]}
{"wire":[269,1,259,0]}
{"wire":[269,2,276,0]}
{"wire":[263,0,262,0]}
{"wire":[263,1,268,0]}
{"wire":[264,0,260,0]}
{"wire":[264,1,261,0]}
{"wire":[272,0,271,0]}
{"wire":[272,1,267,0]}
{"wire":[273,0,270,0]}
{"wire":[273,1,269,0]}
{"wire":[170,0,202,4]}
{"wire":[170,1,195,0]}
{"wire":[265,0,264,0]}
{"wire":[265,1,263,0]}
{"wire":[265,2,273,0]}
{"wire":[265,3,272,0]}
{"wire":[182,0,170,0]}
{"wire":[277,0,265,0]}
{"wire":[281,0,278,0]}
{"wire":[281,3,184,0]}
{"wire":[169,0,176,0]}
{"wire":[169,3,183,0]}
{"wire":[180,59,281,0]}
{"wire":[177,0,169,0]}
{"wire":[178,0,180,0]}
ASEEND*/
//CHKSM=4069AA3FFA16073E3A5CF47E0B6A8B3BAB326CE5