// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Elements/Draw Colormap"
{
	Properties
	{
		[StyledMessage(Info, Use Colormap elements to blend grass materials with terrains. The elements will automatically get the preMINbaked terrain Albedo when using the Terrain Shader moduleEXC, 0, 15)] _ElementMessage( "Element Message", Float ) = 0
		[HideInInspector] _IsVersion( "_IsVersion", Float ) = 2200
		[HideInInspector] _IsElementShader( "_IsElementShader", Float ) = 1
		[HideInInspector] _IsIdentifier( "_IsIdentifier", Float ) = 0
		[StyledCategory(Render Settings, true, 0, 10)] _RenderCategory( "[ Render Category ]", Float ) = 1
		_ElementIntensity( "Render Intensity", Range( 0, 1 ) ) = 1
		[StyledMessage(Info, When using a higher Layer number the Global Volume will create more render textures to render the elements. Try using fewer layers when possible., _ElementLayerMessage, 1, 10, 10)] _ElementLayerMessage( "Render Layer Message", Float ) = 0
		[StyledMessage(Warning, When using all layers the Global Volume will create one render texture for each layer to render the elements. Try using fewer layers when possible., _ElementLayerWarning, 1, 10, 10)] _ElementLayerWarning( "Render Layer Warning", Float ) = 0
		[StyledMask(Draw Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _ElementLayerMask( "Render Layer", Float ) = 1
		[StyledSpace(10)] _EndRender( "[ End Render ]", Float ) = 1
		[StyledCategory(Element Settings, true, 0, 10)] _CategoryElement( "[ Category Element ]", Float ) = 1
		[NoScaleOffset][StyledTextureSingleLine] _MainTex( "Element Texture", 2D ) = "white" {}
		[StyledSpace(10)] _EndElement( "[ End Element ]", Float ) = 1
		[StyledCategory(Bounds Settings, true, 0, 10)] _BoundsCategory( "[ Bounds Category ]", Float ) = 1
		[Enum(Off,0,On,1)] _ElementVolumeFadeMode( "Bounds Fade", Float ) = 0
		_ElementVolumeFadeValue( "Bounds Fade Blend", Range( 0, 1 ) ) = 0.75
		[StyledSpace(10)] _BoundsEnd( "[ Bounds End ]", Float ) = 0
		[HideInInspector] _UseTerrainAlbedo( "_UseTerrainAlbedo", Float ) = 1

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
			uniform half _IsIdentifier;
			uniform half _ElementLayerMask;
			uniform half _CategoryElement;
			uniform half _EndElement;
			uniform half _EndRender;
			uniform half _UseTerrainAlbedo;
			uniform half _ElementMessage;
			uniform sampler2D _MainTex;
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
				half4 MainTex_RGBA302 = tex2D( _MainTex, ( 1.0 - i.ase_texcoord1.xy ) );
				half3 Element_Color316 = (MainTex_RGBA302).rgb;
				float temp_output_7_0_g251340 = 1.0;
				float temp_output_9_0_g251340 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g251340 );
				float lerpResult18_g251338 = lerp( 1.0 , saturate( ( temp_output_9_0_g251340 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g251340 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g251338 = lerpResult18_g251338;
				float temp_output_6_0_g251341 = Blend_Edge69_g251338;
				half Dummy72_g251338 = ( _BoundsCategory + _BoundsEnd );
				float temp_output_7_0_g251341 = Dummy72_g251338;
				#ifdef TVE_DUMMY
				float staticSwitch14_g251341 = ( temp_output_6_0_g251341 + temp_output_7_0_g251341 );
				#else
				float staticSwitch14_g251341 = temp_output_6_0_g251341;
				#endif
				half Element_Alpha317 = ( _ElementIntensity * staticSwitch14_g251341 );
				float4 appendResult169 = (float4(Element_Color316 , Element_Alpha317));
				
				
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
			uniform half _IsIdentifier;
			uniform half _ElementLayerMask;
			uniform half _CategoryElement;
			uniform half _EndElement;
			uniform half _EndRender;
			uniform half _UseTerrainAlbedo;
			uniform half _ElementMessage;
			uniform sampler2D _MainTex;
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
				half4 MainTex_RGBA302 = tex2D( _MainTex, ( 1.0 - i.ase_texcoord1.xy ) );
				half3 Element_Color316 = (MainTex_RGBA302).rgb;
				float temp_output_7_0_g251340 = 1.0;
				float temp_output_9_0_g251340 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g251340 );
				float lerpResult18_g251338 = lerp( 1.0 , saturate( ( temp_output_9_0_g251340 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g251340 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g251338 = lerpResult18_g251338;
				float temp_output_6_0_g251341 = Blend_Edge69_g251338;
				half Dummy72_g251338 = ( _BoundsCategory + _BoundsEnd );
				float temp_output_7_0_g251341 = Dummy72_g251338;
				#ifdef TVE_DUMMY
				float staticSwitch14_g251341 = ( temp_output_6_0_g251341 + temp_output_7_0_g251341 );
				#else
				float staticSwitch14_g251341 = temp_output_6_0_g251341;
				#endif
				half Element_Alpha317 = ( _ElementIntensity * staticSwitch14_g251341 );
				float4 appendResult365 = (float4(Element_Color316 , Element_Alpha317));
				half4 Input_Visual94_g251350 = appendResult365;
				half3 Element_Color47_g251350 = saturate( (Input_Visual94_g251350).xyz );
				float4 appendResult131_g251350 = (float4(Element_Color47_g251350 , (Input_Visual94_g251350).w));
				
				
				finalColor = appendResult131_g251350;
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
{"type":"AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor","id":300,"pos":[-1920,1792],"params":["Inherit","False","0","2","0","5","FLOAT2","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.OneMinusNode, AmplifyShaderEditor","id":276,"pos":[-1728,1792],"params":["Inherit","False","1","0","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor","id":301,"pos":[-1536,1792],"params":["Inherit","True","Property","_MainTex","Element Texture","13","1","[NoScaleOffset]","Create","False","0","0","0","False","1","StyledTextureSingleLine","False","","-1","None","None","True","0","False","white","Auto","False","Object","-1","Auto","Texture2D","False","8","0","SAMPLER2D","","False","1","FLOAT2","0,0","False","2","FLOAT","0","False","3","FLOAT2","0,0","False","4","FLOAT2","0,0","False","5","FLOAT","1","False","6","FLOAT","0","False","7","SAMPLERSTATE","","False","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":302,"pos":[-1088,1792],"params":["Half","False","MainTex_RGBA","-1","True","1","0","COLOR","0,0,0,0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":366,"pos":[252.9155,3633.173],"params":["Inherit","False","302","MainTex_RGBA","1","0","OBJECT","","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":368,"pos":[-1920,2688],"params":["Inherit","False","Element Type Draw","1","","251336","cc2f7980f71a7e741b31ddd8345214b0","0","0","1","FLOAT","4"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":319,"pos":[-1920,2752],"params":["Inherit","False","Element Bounds","24","","251338","4935729172cdadd45b9b14c3fa9c1db4","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":367,"pos":[444.9155,3633.173],"params":["Inherit","False","FLOAT3","0","1","2","3","1","0","COLOR","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":318,"pos":[-1536,2560],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":316,"pos":[640,3712],"params":["Half","False","Element_Color","-1","True","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":317,"pos":[-1088,2560],"params":["Half","False","Element_Alpha","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":211,"pos":[1536,-640],"params":["Inherit","False","316","Element_Color","1","0","OBJECT","","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":184,"pos":[1536,-576],"params":["Inherit","False","317","Element_Alpha","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor","id":365,"pos":[1920,-640],"params":["Inherit","False","FLOAT4","4","0","FLOAT3","0,0,0","False","1","FLOAT","0","False","2","FLOAT","0","False","3","FLOAT","1","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":271,"pos":[-1920,2048],"params":["Inherit","False","302","MainTex_RGBA","1","0","OBJECT","","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":272,"pos":[-1728,2048],"params":["Inherit","False","FLOAT","3","1","2","3","1","0","COLOR","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":282,"pos":[-1536,2048],"params":["Inherit","False","Math Clamp","-1","","251342","be0e6188e535d474483310546a0d9e78","0","1","6","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.Vector4Node, AmplifyShaderEditor","id":296,"pos":[-1536,2176],"params":["Half","False","Property","_MainTexAlphaRemap","Element Alpha","14","0","Create","False","0","0","0","False","2","Space(10)","StyledRemapSlider","False","Object","-1","","0,1,0,0","0,0,0,0","0","5","FLOAT4","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":299,"pos":[-1280,2048],"params":["Inherit","False","Math Remap","-1","","251343","5eda8a2bb94ebef4ab0e43d19291cd8b","3,18,1,21,1,14,0","4","6","FLOAT","0","False","7","FLOAT","0","False","8","FLOAT","0","False","19","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":280,"pos":[-1088,2048],"params":["Half","False","Element_Remap_A","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":340,"pos":[-1920,2560],"params":["Inherit","False","280","Element_Remap_A","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":330,"pos":[-1920,3072],"params":["Inherit","False","258","Color_Seasons","1","0","OBJECT","","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":243,"pos":[-1024,-576],"params":["Half","False","Global","TVE_SeasonLerp","TVE_SeasonLerp","14","0","Create","True","0","0","0","False","0","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":331,"pos":[-1728,3072],"params":["Inherit","False","FLOAT3","0","1","2","3","1","0","COLOR","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.Vector4Node, AmplifyShaderEditor","id":241,"pos":[-1024,-512],"params":["Half","False","Property","_SeasonRemap","Season Curve","22","0","Create","False","0","0","0","False","2","Space(10)","StyledRemapSlider","False","Object","-1","","0,1,0,0","0,0,0,0","0","5","FLOAT4","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":237,"pos":[-768,-576],"params":["Inherit","False","Math Remap","-1","","251344","5eda8a2bb94ebef4ab0e43d19291cd8b","3,18,1,21,1,14,1","4","6","FLOAT","0","False","7","FLOAT","0","False","8","FLOAT","0","False","19","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":364,"pos":[-1536,3072],"params":["Inherit","False","Space Always Gamma","-1","","251345","f2ff984f884d14c4bbbdc35cd3554af2","1,12,1","3","9","FLOAT3","0,0,0","False","28","FLOAT4","0,0,0,0","False","15","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SmoothstepOpNode, AmplifyShaderEditor","id":236,"pos":[-512,-576],"params":["Inherit","False","3","0","FLOAT","0","False","1","FLOAT","0","False","2","FLOAT","1","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor","id":323,"pos":[-1280,3072],"params":["Inherit","False","1","0","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.ColorNode, AmplifyShaderEditor","id":228,"pos":[-1920,-896],"params":["Half","False","Property","_AdditionalColor1","Season Winter","17","2","[HDR]","[Gamma]","Create","False","0","0","0","False","1","Space(10)","False","Object","-1","","0.5019608,0.5019608,0.5019608,1","0.2720588,0.2720588,0.2720588,1","True","True","0","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.ColorNode, AmplifyShaderEditor","id":229,"pos":[-1920,-704],"params":["Half","False","Property","_AdditionalColor2","Season Spring","18","2","[HDR]","[Gamma]","Create","False","0","0","0","False","0","False","Object","-1","","0.5019608,0.5019608,0.5019608,1","0.5779411,0.6397059,0,1","True","True","0","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.ColorNode, AmplifyShaderEditor","id":230,"pos":[-1920,-512],"params":["Half","False","Property","_AdditionalColor3","Season Summer","19","2","[HDR]","[Gamma]","Create","False","0","0","0","False","0","False","Object","-1","","0.5019608,0.5019608,0.5019608,1","0.1908214,0.5220588,0,1","True","True","0","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.ColorNode, AmplifyShaderEditor","id":231,"pos":[-1920,-320],"params":["Half","False","Property","_AdditionalColor4","Season Autumn","20","2","[HDR]","[Gamma]","Create","False","0","0","0","False","0","False","Object","-1","","0.5019608,0.5019608,0.5019608,1","0.7205882,0.4025353,0,1","True","True","0","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":222,"pos":[-1504,-704],"params":["Half","False","Color_Spring_RGBA","-1","True","1","0","COLOR","0,0,0,0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":224,"pos":[-1504,-512],"params":["Half","False","Color_Summer_RGBA","-1","True","1","0","COLOR","0,0,0,0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":226,"pos":[-1504,-320],"params":["Half","False","Color_Autumn_RGBA","-1","True","1","0","COLOR","0,0,0,0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.Vector4Node, AmplifyShaderEditor","id":235,"pos":[-1024,-896],"params":["Half","False","Global","TVE_SeasonOption","TVE_SeasonOption","14","0","Create","True","0","0","0","False","0","False","Object","-1","","0,0,0,0","0,0,1,0","0","5","FLOAT4","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":238,"pos":[-320,-576],"params":["Half","False","SeasonLerp","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":220,"pos":[-1504,-896],"params":["Half","False","Color_Winter_RGBA","-1","True","1","0","COLOR","0,0,0,0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor","id":324,"pos":[-1088,3072],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT","2","False","2","FLOAT","-1","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":232,"pos":[-352,-800],"params":["Half","False","TVE_SeasonOptions_Y","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":233,"pos":[-352,-736],"params":["Half","False","TVE_SeasonOptions_Z","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":234,"pos":[-352,-672],"params":["Half","False","TVE_SeasonOptions_W","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":244,"pos":[-352,-864],"params":["Half","False","TVE_SeasonOptions_X","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":245,"pos":[-1920,512],"params":["Inherit","False","222","Color_Spring_RGBA","1","0","OBJECT","","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":246,"pos":[-1920,768],"params":["Inherit","False","224","Color_Summer_RGBA","1","0","OBJECT","","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":247,"pos":[-1920,1024],"params":["Inherit","False","226","Color_Autumn_RGBA","1","0","OBJECT","","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":255,"pos":[-1920,256],"params":["Inherit","False","220","Color_Winter_RGBA","1","0","OBJECT","","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":256,"pos":[-1920,1152],"params":["Inherit","False","238","SeasonLerp","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.LengthOpNode, AmplifyShaderEditor","id":325,"pos":[-832,3072],"params":["Inherit","False","1","0","FLOAT3","0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":248,"pos":[-1536,352],"params":["Inherit","False","3","0","COLOR","0,0,0,0","False","1","COLOR","0,0,0,0","False","2","FLOAT","0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":249,"pos":[-1536,768],"params":["Inherit","False","233","TVE_SeasonOptions_Z","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":250,"pos":[-1536,608],"params":["Inherit","False","3","0","COLOR","0,0,0,0","False","1","COLOR","0,0,0,0","False","2","FLOAT","0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":251,"pos":[-1536,1024],"params":["Inherit","False","234","TVE_SeasonOptions_W","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":252,"pos":[-1536,1120],"params":["Inherit","False","3","0","COLOR","0,0,0,0","False","1","COLOR","0,0,0,0","False","2","FLOAT","0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":253,"pos":[-1536,256],"params":["Inherit","False","244","TVE_SeasonOptions_X","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":254,"pos":[-1536,864],"params":["Inherit","False","3","0","COLOR","0,0,0,0","False","1","COLOR","0,0,0,0","False","2","FLOAT","0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":257,"pos":[-1536,512],"params":["Inherit","False","232","TVE_SeasonOptions_Y","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor","id":326,"pos":[-640,3072],"params":["Inherit","False","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":259,"pos":[-1280,512],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","COLOR","0,0,0,0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":260,"pos":[-1280,768],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","COLOR","0,0,0,0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":261,"pos":[-1280,1024],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","COLOR","0,0,0,0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":262,"pos":[-1280,256],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","COLOR","0,0,0,0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.OneMinusNode, AmplifyShaderEditor","id":327,"pos":[-448,3072],"params":["Inherit","False","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":263,"pos":[-1024,256],"params":["Inherit","False","4","4","0","COLOR","0,0,0,0","False","1","COLOR","0,0,0,0","False","2","COLOR","0,0,0,0","False","3","COLOR","0,0,0,0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":328,"pos":[-256,3072],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":264,"pos":[-480,256],"params":["Inherit","False","Per Vertex","-1","","251346","db7dd586c7d3fd34786fd504127455fc","0","1","3","COLOR","0,0,0,0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.OneMinusNode, AmplifyShaderEditor","id":329,"pos":[-64,3072],"params":["Inherit","False","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.ColorNode, AmplifyShaderEditor","id":337,"pos":[-1920,-1280],"params":["Half","False","Property","_MainColor","Element Value","15","2","[HDR]","[Gamma]","Create","False","0","0","0","False","1","Space(10)","False","Object","-1","","0.5019608,0.5019608,0.5019608,1","0.2720588,0.2720588,0.2720588,1","True","True","0","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":258,"pos":[-320,256],"params":["Half","False","Color_Seasons","-1","True","1","0","COLOR","0,0,0,0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":334,"pos":[64,3072],"params":["Half","False","BlendValue","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":348,"pos":[-1920,4352],"params":["Inherit","False","302","MainTex_RGBA","1","0","OBJECT","","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":338,"pos":[-1472,-1280],"params":["Half","False","Color_Main_RGBA","-1","True","1","0","COLOR","0,0,0,0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":310,"pos":[-1920,4224],"params":["Inherit","False","258","Color_Seasons","1","0","OBJECT","","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":349,"pos":[-1728,4352],"params":["Inherit","False","FLOAT3","0","1","2","3","1","0","COLOR","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":336,"pos":[-1536,4480],"params":["Inherit","False","334","BlendValue","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":321,"pos":[-1536,4416],"params":["Inherit","False","Compute Grayscale","-1","","251347","20375d8ab5c5bc04793f124ae8c1af26","1,10,1","1","3","FLOAT3","0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":311,"pos":[-1728,4224],"params":["Inherit","False","FLOAT3","0","1","2","3","1","0","COLOR","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":347,"pos":[-1280,4352],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":342,"pos":[-1920,3776],"params":["Inherit","False","338","Color_Main_RGBA","1","0","OBJECT","","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":314,"pos":[-992,4928],"params":["Inherit","False","302","MainTex_RGBA","1","0","OBJECT","","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":359,"pos":[-1024,4352],"params":["Inherit","False","338","Color_Main_RGBA","1","0","OBJECT","","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":343,"pos":[-1728,3776],"params":["Inherit","False","FLOAT3","0","1","2","3","1","0","COLOR","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":315,"pos":[-800,4928],"params":["Inherit","False","FLOAT","3","1","2","3","1","0","COLOR","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":350,"pos":[-992,4992],"params":["Inherit","False","334","BlendValue","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":306,"pos":[-1024,4224],"params":["Inherit","False","2","2","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":360,"pos":[-832,4352],"params":["Inherit","False","FLOAT3","0","1","2","3","1","0","COLOR","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":363,"pos":[-896,4416],"params":["Inherit","False","Space Double Value","-1","","251348","7b4c368feb6af324ab9d39c85bf2b7f0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":332,"pos":[-1536,3712],"params":["Inherit","False","2","2","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":351,"pos":[-608,4928],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":361,"pos":[-640,4224],"params":["Inherit","False","3","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":309,"pos":[0,3712],"params":["Inherit","False","3","0","FLOAT3","0,0,0","False","1","FLOAT3","0,0,0","False","2","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.ColorNode, AmplifyShaderEditor","id":344,"pos":[-1810.107,3876.429],"params":["Inherit","False","Property","_Color0","Color 0","16","2","[HDR]","[Gamma]","Create","True","0","0","0","False","0","False","Object","-1","","0.5,0.5,0.5,0","0.5,0.5,0.5,0","True","False","0","6","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":266,"pos":[-1024,448],"params":["Inherit","False","239","SeasonColor","1","0","OBJECT","","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":265,"pos":[-640,256],"params":["Inherit","False","2","2","0","COLOR","0,0,0,0","False","1","COLOR","0,0,0,0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":223,"pos":[-1472,-608],"params":["Half","False","Color_Spring_A","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":225,"pos":[-1472,-416],"params":["Half","False","Color_Summer_A","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":227,"pos":[-1472,-224],"params":["Half","False","Color_Autumn_A","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":240,"pos":[-576,-160],"params":["Half","False","SeasonAlpha","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":239,"pos":[-576,-256],"params":["Half","False","SeasonColor","-1","True","1","0","COLOR","0,0,0,0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":163,"pos":[-1664,-2048],"params":["Half","False","Property","_CategoryElement","[ Category Element ]","12","0","Create","True","0","0","0","True","1","StyledCategory(Element Settings, true, 0, 10)","False","Object","-1","","1","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":196,"pos":[-1664,-1984],"params":["Half","False","Property","_EndElement","[ End Element ]","23","0","Create","True","0","0","0","True","1","StyledSpace(10)","False","Object","-1","","1","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":221,"pos":[-1472,-800],"params":["Half","False","Color_Winter_A","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":200,"pos":[-1664,-1920],"params":["Half","False","Property","_EndRender","[ End Render ]","11","0","Create","True","0","0","0","True","1","StyledSpace(10)","False","Object","-1","","1","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":167,"pos":[-896,-2048],"params":["Inherit","False","Element Compile","-1","","251349","5302407fc6d65554791e558e67d59358","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":352,"pos":[-1280,-2048],"params":["Half","False","Property","_UseTerrainAlbedo","_UseTerrainAlbedo","29","1","[HideInInspector]","Create","True","0","0","0","True","0","False","Object","-1","","1","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.ColorNode, AmplifyShaderEditor","id":242,"pos":[-1024,-256],"params":["Half","False","Property","_SeasonColor","Seasons Color","21","2","[HDR]","[Gamma]","Create","False","0","0","0","False","1","Space(10)","False","Object","-1","","1,1,1,1","0.7205882,0.4025353,0,1","True","True","0","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor","id":169,"pos":[1920,-896],"params":["Inherit","False","FLOAT4","4","0","FLOAT3","0,0,0","False","1","FLOAT","0","False","2","FLOAT","0","False","3","FLOAT","0","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":180,"pos":[2176,-640],"params":["Inherit","False","Element Visuals","-1","","251350","78cf0f00cfd72824e84597f2db54a76e","1,64,0","2","59","FLOAT4","0,0,0,0","False","77","FLOAT3","1,1,1","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":176,"pos":[1536,-896],"params":["Inherit","False","316","Element_Color","1","0","OBJECT","","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":312,"pos":[-1920,3712],"params":["Inherit","False","302","MainTex_RGBA","1","0","OBJECT","","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":313,"pos":[-1728,3712],"params":["Inherit","False","FLOAT3","0","1","2","3","1","0","COLOR","0,0,0,0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":183,"pos":[1536,-832],"params":["Inherit","False","317","Element_Alpha","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":112,"pos":[-1920,-2048],"params":["Half","False","Property","_ElementMessage","Element Message","0","0","Create","True","0","0","0","True","1","StyledMessage(Info, Use Colormap elements to blend grass materials with terrains. The elements will automatically get the preMINbaked terrain Albedo when using the Terrain Shader moduleEXC, 0, 15)","False","Object","-1","","0","0","1","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":218,"pos":[2384,-864],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","15","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass1","0","1","VolumePass1","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass1","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":219,"pos":[2384,-864],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","15","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass2","0","2","VolumePass2","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass2","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":177,"pos":[2368,-896],"params":["Float","False","True","-1","2","TheVisualEngine.ElementGUI","100","2","BOXOPHOBIC/The Visual Engine/Elements/Draw Colormap","f4f273c3bb6262d4396be458405e60f9","True","VolumePass","0","0","VolumePass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","3","RenderType=Transparent=RenderType","Queue=Transparent=Queue=0","DisableBatching=True=DisableBatching","False","False","0","True","True","2","5","False","","10","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","True","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass","True","2","False","0","","0","0","Standard","3","VolumePass1","0","0","VolumePass2","0","0","Vertex Position","1","0","0","4","True","False","False","True","False","","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":178,"pos":[2368,-640],"params":["Float","False","False","-1","2","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VisualPass","0","3","VisualPass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","True","True","2","5","False","","10","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","False","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor","id":267,"pos":[-1920,128],"params":["Inherit","False","1795.203","100","","0","","0.4810033,1,1,1","0","0"]}
{"type":"AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor","id":268,"pos":[-1920,-1408],"params":["Inherit","False","1792.142","100","","0","","0.4810033,1,1,1","0","0"]}
{"type":"AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor","id":303,"pos":[-1920,1664],"params":["Inherit","False","1791.203","100","","0","","0.4810033,1,1,1","0","0"]}
{"wire":[276,0,300,0]}
{"wire":[301,1,276,0]}
{"wire":[302,0,301,0]}
{"wire":[367,0,366,0]}
{"wire":[318,0,368,4]}
{"wire":[318,1,319,0]}
{"wire":[316,0,367,0]}
{"wire":[317,0,318,0]}
{"wire":[365,0,211,0]}
{"wire":[365,3,184,0]}
{"wire":[272,0,271,0]}
{"wire":[282,6,272,0]}
{"wire":[299,6,282,0]}
{"wire":[299,7,296,1]}
{"wire":[299,19,296,3]}
{"wire":[280,0,299,0]}
{"wire":[331,0,330,0]}
{"wire":[237,6,243,0]}
{"wire":[237,7,241,1]}
{"wire":[237,19,241,3]}
{"wire":[364,9,331,0]}
{"wire":[236,0,237,0]}
{"wire":[323,0,364,0]}
{"wire":[222,0,229,0]}
{"wire":[224,0,230,0]}
{"wire":[226,0,231,0]}
{"wire":[238,0,236,0]}
{"wire":[220,0,228,0]}
{"wire":[324,0,323,0]}
{"wire":[232,0,235,2]}
{"wire":[233,0,235,3]}
{"wire":[234,0,235,4]}
{"wire":[244,0,235,1]}
{"wire":[325,0,324,0]}
{"wire":[248,0,255,0]}
{"wire":[248,1,245,0]}
{"wire":[248,2,256,0]}
{"wire":[250,0,245,0]}
{"wire":[250,1,246,0]}
{"wire":[250,2,256,0]}
{"wire":[252,0,247,0]}
{"wire":[252,1,255,0]}
{"wire":[252,2,256,0]}
{"wire":[254,0,246,0]}
{"wire":[254,1,247,0]}
{"wire":[254,2,256,0]}
{"wire":[326,0,325,0]}
{"wire":[259,0,257,0]}
{"wire":[259,1,250,0]}
{"wire":[260,0,249,0]}
{"wire":[260,1,254,0]}
{"wire":[261,0,251,0]}
{"wire":[261,1,252,0]}
{"wire":[262,0,253,0]}
{"wire":[262,1,248,0]}
{"wire":[327,0,326,0]}
{"wire":[263,0,262,0]}
{"wire":[263,1,259,0]}
{"wire":[263,2,260,0]}
{"wire":[263,3,261,0]}
{"wire":[328,0,327,0]}
{"wire":[328,1,327,0]}
{"wire":[264,3,263,0]}
{"wire":[329,0,328,0]}
{"wire":[258,0,264,0]}
{"wire":[334,0,329,0]}
{"wire":[338,0,337,0]}
{"wire":[349,0,348,0]}
{"wire":[321,3,349,0]}
{"wire":[311,0,310,0]}
{"wire":[347,0,349,0]}
{"wire":[347,1,321,0]}
{"wire":[347,2,336,0]}
{"wire":[343,0,342,0]}
{"wire":[315,0,314,0]}
{"wire":[306,0,311,0]}
{"wire":[306,1,347,0]}
{"wire":[360,0,359,0]}
{"wire":[332,0,313,0]}
{"wire":[332,1,343,0]}
{"wire":[351,0,315,0]}
{"wire":[351,1,350,0]}
{"wire":[361,0,306,0]}
{"wire":[361,1,360,0]}
{"wire":[361,2,363,0]}
{"wire":[309,0,332,0]}
{"wire":[309,1,361,0]}
{"wire":[309,2,351,0]}
{"wire":[265,0,263,0]}
{"wire":[265,1,266,0]}
{"wire":[223,0,229,4]}
{"wire":[225,0,230,4]}
{"wire":[227,0,231,4]}
{"wire":[240,0,242,4]}
{"wire":[239,0,242,0]}
{"wire":[221,0,228,4]}
{"wire":[169,0,176,0]}
{"wire":[169,3,183,0]}
{"wire":[180,59,365,0]}
{"wire":[313,0,312,0]}
{"wire":[177,0,169,0]}
{"wire":[178,0,180,0]}
ASEEND*/
//CHKSM=34E0F0C4A608C434282CFCC1F0626D55CB930511