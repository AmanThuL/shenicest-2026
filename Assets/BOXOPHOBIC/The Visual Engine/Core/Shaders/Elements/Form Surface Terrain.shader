// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Elements/Form Surface (Terrain)"
{
	Properties
	{
		[StyledMessage(Info, Use Surface Terrain elements for conforming and aligning object to terrain surfaces. When using terrains with high altitude__ make sure to set the Form elements rendering to high precision HDR 32 under Manager RAR Elements Rendering RAR Overrides__ for the conforming to work properlyEXC The Normal texture is only available when the terrain is instanced or when using the Terrain Shaders Module., 0, 15)] _ElementMessage( "Element Message", Float ) = 0
		[HideInInspector] _IsVersion( "_IsVersion", Float ) = 2200
		[HideInInspector] _IsElementShader( "_IsElementShader", Float ) = 1
		[HideInInspector] _IsIdentifier( "_IsIdentifier", Float ) = 0
		[StyledCategory(Render Settings, true, 0, 10)] _RenderCategory( "[ Render Category ]", Float ) = 1
		_ElementIntensity( "Render Intensity", Range( 0, 1 ) ) = 1
		[StyledMessage(Info, When using a higher Layer number the Global Volume will create more render textures to render the elements. Try using fewer layers when possible., _ElementLayerMessage, 1, 10, 10)] _ElementLayerMessage( "Render Layer Message", Float ) = 0
		[StyledMessage(Warning, When using all layers the Global Volume will create one render texture for each layer to render the elements. Try using fewer layers when possible., _ElementLayerWarning, 1, 10, 10)] _ElementLayerWarning( "Render Layer Warning", Float ) = 0
		[StyledMask(Form Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _ElementLayerMask( "Render Layer", Float ) = 1
		[StyledSpace(10)] _EndRender( "[ End Render ]", Float ) = 1
		[StyledCategory(Element Settings, true, 0, 10)] _CategoryElement( "[ Category Element ]", Float ) = 1
		[StyledTextureSingleLine] _TerrainHeightTex( "Element Height", 2D ) = "white" {}
		[StyledTextureSingleLine] _TerrainNormalTex( "Element Normal", 2D ) = "linearGrey" {}
		[Space(10)] _HeightOffsetValue( "Height Offset", Float ) = 0
		[HideInInspector] _TerrainPosition( "Terrain Position", Vector ) = ( 0, 0, 0, 0 )
		[HideInInspector] _TerrainSize( "Terrain Size", Vector ) = ( 0, 0, 0, 0 )
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
			Blend SrcAlpha OneMinusSrcAlpha
			BlendOp Add, Max
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
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				
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
			uniform half _ElementMessage;
			uniform sampler2D _TerrainNormalTex;
			uniform float3 _TerrainPosition;
			uniform float3 _TerrainSize;
			uniform sampler2D _TerrainHeightTex;
			float4 _TerrainHeightTex_TexelSize;
			uniform float _HeightOffsetValue;
			uniform float3 TVE_WorldOrigin;
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
				float4 appendResult232 = (float4(_TerrainPosition.x , _TerrainPosition.z , _TerrainSize.x , _TerrainSize.z));
				half4 Terrain_Coords233 = appendResult232;
				float4 temp_output_35_0_g23079 = Terrain_Coords233;
				float2 InputScale48_g23079 = (temp_output_35_0_g23079).zw;
				half2 FinalScale53_g23079 = ( 1.0 / InputScale48_g23079 );
				float2 InputPosition52_g23079 = (temp_output_35_0_g23079).xy;
				half2 FinalPosition58_g23079 = -( FinalScale53_g23079 * InputPosition52_g23079 );
				float2 temp_output_65_0_g23079 = ( ( (WorldPosition).xz * FinalScale53_g23079 ) + FinalPosition58_g23079 );
				float4 tex2DNode248 = tex2D( _TerrainNormalTex, temp_output_65_0_g23079 );
				float2 appendResult249 = (float2(tex2DNode248.r , tex2DNode248.b));
				float2 Terrain_Normal250 = appendResult249;
				float4 temp_output_35_0_g23060 = Terrain_Coords233;
				float2 InputScale48_g23060 = (temp_output_35_0_g23060).zw;
				half2 FinalScale53_g23060 = ( 1.0 / InputScale48_g23060 );
				float2 InputPosition52_g23060 = (temp_output_35_0_g23060).xy;
				half2 FinalPosition58_g23060 = -( FinalScale53_g23060 * InputPosition52_g23060 );
				float2 temp_output_65_0_g23060 = ( ( (WorldPosition).xz * FinalScale53_g23060 ) + FinalPosition58_g23060 );
				float4 temp_output_70_0_g23060 = _TerrainHeightTex_TexelSize;
				float2 InputTexelSize68_g23060 = (temp_output_70_0_g23060).zw;
				float2 temp_cast_0 = (1.0).xx;
				float2 InputTexelRecip69_g23060 = (temp_output_70_0_g23060).xy;
				float4 Terrain_Height_Raw175 = tex2D( _TerrainHeightTex, ( ( ( temp_output_65_0_g23060 / ( 1.0 / ( InputTexelSize68_g23060 - temp_cast_0 ) ) ) + 0.5 ) * InputTexelRecip69_g23060 ) );
				float temp_output_223_0 = ( ( (Terrain_Height_Raw175).r + ( (Terrain_Height_Raw175).g * 256.0 ) ) / 257.0 );
				#ifdef SHADER_API_VULKAN
				float staticSwitch212 = temp_output_223_0;
				#else
				float staticSwitch212 = (Terrain_Height_Raw175).r;
				#endif
				#ifdef SHADER_API_GLES
				float staticSwitch213 = temp_output_223_0;
				#else
				float staticSwitch213 = staticSwitch212;
				#endif
				#ifdef SHADER_API_GLES3
				float staticSwitch214 = temp_output_223_0;
				#else
				float staticSwitch214 = staticSwitch213;
				#endif
				float Terrain_Height_Platform215 = staticSwitch214;
				float Terrain_SizeY143 = _TerrainSize.y;
				float Terrain_Height_Final206 = ( Terrain_Height_Platform215 * Terrain_SizeY143 * 2.0 );
				float Terrain_PosY200 = _TerrainPosition.y;
				half Element_Offset280 = _HeightOffsetValue;
				float temp_output_7_0_g23099 = 1.0;
				float temp_output_9_0_g23099 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g23099 );
				float lerpResult18_g23097 = lerp( 1.0 , saturate( ( temp_output_9_0_g23099 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g23099 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g23097 = lerpResult18_g23097;
				float temp_output_6_0_g23100 = Blend_Edge69_g23097;
				half Dummy72_g23097 = ( _BoundsCategory + _BoundsEnd );
				float temp_output_7_0_g23100 = Dummy72_g23097;
				#ifdef TVE_DUMMY
				float staticSwitch14_g23100 = ( temp_output_6_0_g23100 + temp_output_7_0_g23100 );
				#else
				float staticSwitch14_g23100 = temp_output_6_0_g23100;
				#endif
				half Element_Alpha182 = ( _ElementIntensity * staticSwitch14_g23100 );
				float4 appendResult169 = (float4(Terrain_Normal250 , ( ( Terrain_Height_Final206 + Terrain_PosY200 + Element_Offset280 ) - (TVE_WorldOrigin).y ) , Element_Alpha182));
				
				
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
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				
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
			uniform half _ElementMessage;
			uniform sampler2D _TerrainNormalTex;
			uniform float3 _TerrainPosition;
			uniform float3 _TerrainSize;
			uniform sampler2D _TerrainHeightTex;
			float4 _TerrainHeightTex_TexelSize;
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
				float4 appendResult232 = (float4(_TerrainPosition.x , _TerrainPosition.z , _TerrainSize.x , _TerrainSize.z));
				half4 Terrain_Coords233 = appendResult232;
				float4 temp_output_35_0_g23079 = Terrain_Coords233;
				float2 InputScale48_g23079 = (temp_output_35_0_g23079).zw;
				half2 FinalScale53_g23079 = ( 1.0 / InputScale48_g23079 );
				float2 InputPosition52_g23079 = (temp_output_35_0_g23079).xy;
				half2 FinalPosition58_g23079 = -( FinalScale53_g23079 * InputPosition52_g23079 );
				float2 temp_output_65_0_g23079 = ( ( (WorldPosition).xz * FinalScale53_g23079 ) + FinalPosition58_g23079 );
				float4 tex2DNode248 = tex2D( _TerrainNormalTex, temp_output_65_0_g23079 );
				float2 appendResult249 = (float2(tex2DNode248.r , tex2DNode248.b));
				float2 Terrain_Normal250 = appendResult249;
				float4 temp_output_35_0_g23060 = Terrain_Coords233;
				float2 InputScale48_g23060 = (temp_output_35_0_g23060).zw;
				half2 FinalScale53_g23060 = ( 1.0 / InputScale48_g23060 );
				float2 InputPosition52_g23060 = (temp_output_35_0_g23060).xy;
				half2 FinalPosition58_g23060 = -( FinalScale53_g23060 * InputPosition52_g23060 );
				float2 temp_output_65_0_g23060 = ( ( (WorldPosition).xz * FinalScale53_g23060 ) + FinalPosition58_g23060 );
				float4 temp_output_70_0_g23060 = _TerrainHeightTex_TexelSize;
				float2 InputTexelSize68_g23060 = (temp_output_70_0_g23060).zw;
				float2 temp_cast_0 = (1.0).xx;
				float2 InputTexelRecip69_g23060 = (temp_output_70_0_g23060).xy;
				float4 Terrain_Height_Raw175 = tex2D( _TerrainHeightTex, ( ( ( temp_output_65_0_g23060 / ( 1.0 / ( InputTexelSize68_g23060 - temp_cast_0 ) ) ) + 0.5 ) * InputTexelRecip69_g23060 ) );
				float temp_output_223_0 = ( ( (Terrain_Height_Raw175).r + ( (Terrain_Height_Raw175).g * 256.0 ) ) / 257.0 );
				#ifdef SHADER_API_VULKAN
				float staticSwitch212 = temp_output_223_0;
				#else
				float staticSwitch212 = (Terrain_Height_Raw175).r;
				#endif
				#ifdef SHADER_API_GLES
				float staticSwitch213 = temp_output_223_0;
				#else
				float staticSwitch213 = staticSwitch212;
				#endif
				#ifdef SHADER_API_GLES3
				float staticSwitch214 = temp_output_223_0;
				#else
				float staticSwitch214 = staticSwitch213;
				#endif
				float Terrain_Height_Platform215 = staticSwitch214;
				float Terrain_SizeY143 = _TerrainSize.y;
				float Terrain_Height_Final206 = ( Terrain_Height_Platform215 * Terrain_SizeY143 * 2.0 );
				float3 appendResult253 = (float3(Terrain_Normal250 , ( Terrain_Height_Final206 * 0.1 )));
				float temp_output_7_0_g23099 = 1.0;
				float temp_output_9_0_g23099 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g23099 );
				float lerpResult18_g23097 = lerp( 1.0 , saturate( ( temp_output_9_0_g23099 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g23099 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g23097 = lerpResult18_g23097;
				float temp_output_6_0_g23100 = Blend_Edge69_g23097;
				half Dummy72_g23097 = ( _BoundsCategory + _BoundsEnd );
				float temp_output_7_0_g23100 = Dummy72_g23097;
				#ifdef TVE_DUMMY
				float staticSwitch14_g23100 = ( temp_output_6_0_g23100 + temp_output_7_0_g23100 );
				#else
				float staticSwitch14_g23100 = temp_output_6_0_g23100;
				#endif
				half Element_Alpha182 = ( _ElementIntensity * staticSwitch14_g23100 );
				float4 appendResult268 = (float4(appendResult253 , Element_Alpha182));
				half4 Input_Visual94_g23104 = appendResult268;
				float2 temp_output_135_0_g23104 = (Input_Visual94_g23104).xy;
				float3 appendResult140_g23104 = (float3(( temp_output_135_0_g23104 * temp_output_135_0_g23104 ) , (Input_Visual94_g23104).z));
				half3 Element_Color47_g23104 = saturate( appendResult140_g23104 );
				float4 appendResult131_g23104 = (float4(Element_Color47_g23104 , (Input_Visual94_g23104).w));
				
				
				finalColor = appendResult131_g23104;
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
{"type":"AmplifyShaderEditor.TexelSizeNode, AmplifyShaderEditor","id":234,"pos":[-2176,-448],"params":["Inherit","False","146","Create","1","0","SAMPLER2D","","False","5","FLOAT4","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":236,"pos":[-2176,-512],"params":["Inherit","False","233","Terrain_Coords","1","0","OBJECT","","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":241,"pos":[-1792,-512],"params":["Inherit","False","Compute Coords Terrain","11","","23060","d0444d471efe7f1408b5cbe1e3f402c9","1,83,1","2","35","FLOAT4","0,0,0,0","False","70","FLOAT4","0,0,0,0","False","1","FLOAT2","38"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":218,"pos":[-1920,64],"params":["Inherit","False","FLOAT","1","1","2","3","1","0","COLOR","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":220,"pos":[-1920,128],"params":["Float","False","Constant","_Float5","Float 5","10","0","Create","True","0","0","0","False","0","False","Object","-1","","256","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor","id":146,"pos":[-1408,-512],"params":["Inherit","True","Property","_TerrainHeightTex","Element Height","16","0","Create","False","0","0","0","False","1","StyledTextureSingleLine","False","","-1","None","None","True","0","False","white","Auto","False","Object","-1","Auto","Texture2D","False","8","0","SAMPLER2D","","False","1","FLOAT2","0,0","False","2","FLOAT","0","False","3","FLOAT2","0,0","False","4","FLOAT2","0,0","False","5","FLOAT","1","False","6","FLOAT","0","False","7","SAMPLERSTATE","","False","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":217,"pos":[-1920,0],"params":["Inherit","False","FLOAT","0","1","2","3","1","0","COLOR","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":219,"pos":[-1728,64],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":175,"pos":[-864,-512],"params":["Float","False","Terrain_Height_Raw","-1","True","1","0","COLOR","0,0,0,0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":211,"pos":[-2176,-128],"params":["Inherit","False","175","Terrain_Height_Raw","1","0","OBJECT","","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":221,"pos":[-1536,0],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":222,"pos":[-1536,128],"params":["Float","False","Constant","_Float6","Float 5","10","0","Create","True","0","0","0","False","0","False","Object","-1","","257","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":216,"pos":[-1920,-128],"params":["Inherit","False","FLOAT","0","1","2","3","1","0","COLOR","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleDivideOpNode, AmplifyShaderEditor","id":223,"pos":[-1280,0],"params":["Inherit","False","2","0","FLOAT","0","False","1","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.StaticSwitch, AmplifyShaderEditor","id":212,"pos":[-1760,-128],"params":["Inherit","False","Property","_Keyword0","Keyword 0","10","0","Create","True","0","0","0","False","0","False","","0","0","0","False","SHADER_API_VULKAN","Toggle","2","Key0","Key1","Fetch","False","True","All","9","1","FLOAT","0","False","0","FLOAT","0","False","2","FLOAT","0","False","3","FLOAT","0","False","4","FLOAT","0","False","5","FLOAT","0","False","6","FLOAT","0","False","7","FLOAT","0","False","8","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.Vector3Node, AmplifyShaderEditor","id":201,"pos":[-2176,-1280],"params":["Float","False","Property","_TerrainPosition","Terrain Position","21","1","[HideInInspector]","Create","True","0","0","0","False","0","False","Object","-1","","0,0,0","0,0,0","0","4","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3"]}
{"type":"AmplifyShaderEditor.Vector3Node, AmplifyShaderEditor","id":141,"pos":[-2176,-1120],"params":["Float","False","Property","_TerrainSize","Terrain Size","22","1","[HideInInspector]","Create","True","0","0","0","False","0","False","Object","-1","","0,0,0","0,0,0","0","4","FLOAT3","0","FLOAT","1","FLOAT","2","FLOAT","3"]}
{"type":"AmplifyShaderEditor.StaticSwitch, AmplifyShaderEditor","id":213,"pos":[-1504,-128],"params":["Inherit","False","Property","_Keyword1","Keyword 0","10","0","Create","True","0","0","0","False","0","False","","0","0","0","False","SHADER_API_GLES","Toggle","2","Key0","Key1","Fetch","False","True","All","9","1","FLOAT","0","False","0","FLOAT","0","False","2","FLOAT","0","False","3","FLOAT","0","False","4","FLOAT","0","False","5","FLOAT","0","False","6","FLOAT","0","False","7","FLOAT","0","False","8","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor","id":232,"pos":[-1792,-1120],"params":["Inherit","False","FLOAT4","4","0","FLOAT","0","False","1","FLOAT","0","False","2","FLOAT","0","False","3","FLOAT","0","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.StaticSwitch, AmplifyShaderEditor","id":214,"pos":[-1280,-128],"params":["Inherit","False","Property","_Keyword2","Keyword 0","10","0","Create","True","0","0","0","False","0","False","","0","0","0","False","SHADER_API_GLES3","Toggle","2","Key0","Key1","Fetch","False","True","All","9","1","FLOAT","0","False","0","FLOAT","0","False","2","FLOAT","0","False","3","FLOAT","0","False","4","FLOAT","0","False","5","FLOAT","0","False","6","FLOAT","0","False","7","FLOAT","0","False","8","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":233,"pos":[-1600,-1120],"params":["Half","False","Terrain_Coords","-1","True","1","0","FLOAT4","0,0,0,0","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":215,"pos":[-864,-128],"params":["Float","False","Terrain_Height_Platform","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":143,"pos":[-1792,-1216],"params":["Inherit","False","Terrain_SizeY","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":263,"pos":[-2176,640],"params":["Inherit","False","233","Terrain_Coords","1","0","OBJECT","","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":144,"pos":[640,-448],"params":["Inherit","False","143","Terrain_SizeY","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":210,"pos":[640,-384],"params":["Half","False","Constant","_Float4","Float 4","16","0","Create","True","0","0","0","False","0","False","Object","-1","","2","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":176,"pos":[640,-512],"params":["Inherit","False","215","Terrain_Height_Platform","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":262,"pos":[-1920,640],"params":["Inherit","False","Compute Coords Terrain","11","","23079","d0444d471efe7f1408b5cbe1e3f402c9","1,83,0","2","35","FLOAT4","0,0,0,0","False","70","FLOAT4","0,0,0,0","False","1","FLOAT2","38"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":149,"pos":[1024,-512],"params":["Inherit","False","3","3","0","FLOAT","0","False","1","FLOAT","0","False","2","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor","id":248,"pos":[-1408,640],"params":["Inherit","True","Property","_TerrainNormalTex","Element Normal","17","0","Create","False","0","0","0","False","1","StyledTextureSingleLine","False","","-1","None","None","True","0","False","linearGrey","Auto","False","Object","-1","Auto","Texture2D","False","8","0","SAMPLER2D","","False","1","FLOAT2","0,0","False","2","FLOAT","0","False","3","FLOAT2","0,0","False","4","FLOAT2","0,0","False","5","FLOAT","1","False","6","FLOAT","0","False","7","SAMPLERSTATE","","False","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":206,"pos":[1824,-512],"params":["Float","False","Terrain_Height_Final","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor","id":249,"pos":[-1024,640],"params":["Inherit","False","FLOAT2","4","0","FLOAT","0","False","1","FLOAT","0","False","2","FLOAT","0","False","3","FLOAT","0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":256,"pos":[-2176,2432],"params":["Inherit","False","Element Type Form","1","","23086","bc58488265c2ed6408843a733b1a9124","0","0","1","FLOAT","4"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":265,"pos":[-2176,2496],"params":["Inherit","False","Element Bounds","24","","23097","4935729172cdadd45b9b14c3fa9c1db4","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":208,"pos":[640,384],"params":["Inherit","False","206","Terrain_Height_Final","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":250,"pos":[-832,640],"params":["Inherit","False","Terrain_Normal","-1","True","1","0","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":170,"pos":[-1536,2432],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":205,"pos":[896,384],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT","0.1","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":254,"pos":[640,256],"params":["Inherit","False","250","Terrain_Normal","1","0","OBJECT","","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":182,"pos":[-832,2432],"params":["Half","False","Element_Alpha","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor","id":253,"pos":[1152,256],"params":["Inherit","False","FLOAT3","4","0","FLOAT2","0,0","False","1","FLOAT","0","False","2","FLOAT","0","False","3","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":184,"pos":[1152,384],"params":["Inherit","False","182","Element_Alpha","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor","id":268,"pos":[1408,256],"params":["Inherit","False","FLOAT4","4","0","FLOAT3","0,0,0","False","1","FLOAT","0","False","2","FLOAT","0","False","3","FLOAT","0","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":167,"pos":[-1472,-1792],"params":["Inherit","False","Element Compile","-1","","23101","5302407fc6d65554791e558e67d59358","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":225,"pos":[-1920,-1792],"params":["Half","False","Property","_CategoryElement","[ Category Element ]","15","0","Create","True","0","0","0","True","1","StyledCategory(Element Settings, true, 0, 10)","False","Object","-1","","1","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":228,"pos":[-1920,-1728],"params":["Half","False","Property","_EndElement","[ End Element ]","23","0","Create","True","0","0","0","True","1","StyledSpace(10)","False","Object","-1","","1","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":229,"pos":[-1920,-1664],"params":["Half","False","Property","_EndRender","[ End Render ]","14","0","Create","True","0","0","0","True","1","StyledSpace(10)","False","Object","-1","","1","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":207,"pos":[640,-64],"params":["Inherit","False","206","Terrain_Height_Final","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":148,"pos":[1024,-64],"params":["Inherit","False","3","3","0","FLOAT","0","False","1","FLOAT","0","False","2","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.ColorNode, AmplifyShaderEditor","id":185,"pos":[640,704],"params":["Inherit","False","Constant","_Color1","Color 1","15","0","Create","True","0","0","0","False","0","False","Object","-1","","0,0.2,1,0","0,0,0,0","True","True","0","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":203,"pos":[640,0],"params":["Inherit","False","200","Terrain_PosY","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor","id":169,"pos":[1664,-128],"params":["Inherit","False","FLOAT4","4","0","FLOAT2","0,0","False","1","FLOAT","0","False","2","FLOAT","0","False","3","FLOAT","0","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":183,"pos":[1408,64],"params":["Inherit","False","182","Element_Alpha","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":252,"pos":[640,-128],"params":["Inherit","False","250","Terrain_Normal","1","0","OBJECT","","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":180,"pos":[1664,256],"params":["Inherit","False","Element Visuals","-1","","23104","78cf0f00cfd72824e84597f2db54a76e","1,64,2","2","59","FLOAT4","0,0,0,0","False","77","FLOAT3","1,1,1","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":260,"pos":[1024,64],"params":["Inherit","False","Get World Origin","-1","","23105","af05f671095c8ce41be1f6d3c2b9cc38","0","0","1","FLOAT3","7"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":259,"pos":[1216,64],"params":["Inherit","False","FLOAT","1","1","2","3","1","0","FLOAT3","0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleSubtractOpNode, AmplifyShaderEditor","id":261,"pos":[1408,-64],"params":["Inherit","False","2","0","FLOAT","0","False","1","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":269,"pos":[-2176,1152],"params":["Inherit","False","233","Terrain_Coords","1","0","OBJECT","","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":270,"pos":[-1920,1152],"params":["Inherit","False","Compute Coords Terrain","11","","23106","d0444d471efe7f1408b5cbe1e3f402c9","1,83,0","2","35","FLOAT4","0,0,0,0","False","70","FLOAT4","0,0,0,0","False","1","FLOAT2","38"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":272,"pos":[-832,1152],"params":["Half","False","Terrain_ShaderTex","-1","True","1","0","COLOR","0,0,0,0","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor","id":271,"pos":[-1408,1152],"params":["Inherit","True","Property","_TerrainShaderTex","Element Shader","18","0","Create","False","0","0","0","False","1","StyledTextureSingleLine","False","","-1","None","None","True","0","False","white","Auto","False","Object","-1","Auto","Texture2D","False","8","0","SAMPLER2D","","False","1","FLOAT2","0,0","False","2","FLOAT","0","False","3","FLOAT2","0,0","False","4","FLOAT2","0,0","False","5","FLOAT","1","False","6","FLOAT","0","False","7","SAMPLERSTATE","","False","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":273,"pos":[-2176,1792],"params":["Inherit","False","272","Terrain_ShaderTex","1","0","OBJECT","","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":274,"pos":[-1984,1792],"params":["Inherit","False","FLOAT","2","1","2","3","1","0","COLOR","0,0,0,0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor","id":275,"pos":[-1792,1792],"params":["Inherit","False","3","0","FLOAT","0","False","1","FLOAT","2","False","2","FLOAT","-1","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":277,"pos":[-1536,1760],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":279,"pos":[-1056,1664],"params":["Inherit","False","3","0","FLOAT","0","False","1","FLOAT","0","False","2","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":280,"pos":[-832,1664],"params":["Half","False","Element_Offset","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":200,"pos":[-1792,-1280],"params":["Inherit","False","Terrain_PosY","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":278,"pos":[-1280,1856],"params":["Inherit","False","Property","_HeightOffsetMode","Height Offset","19","1","[Enum]","Create","False","0","2","Constant","0","Per Pixel Terrain Height","1","0","False","1","Space(10)","False","Object","-1","","0","1","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":276,"pos":[-2176,1664],"params":["Inherit","False","Property","_HeightOffsetValue","Height Offset","20","0","Create","False","0","0","0","False","1","Space(10)","False","Object","-1","","0","1","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":281,"pos":[640,64],"params":["Inherit","False","280","Element_Offset","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":112,"pos":[-2176,-1792],"params":["Half","False","Property","_ElementMessage","Element Message","0","0","Create","True","0","0","0","True","1","StyledMessage(Info, Use Surface Terrain elements for conforming and aligning object to terrain surfaces. When using terrains with high altitude__ make sure to set the Form elements rendering to high precision HDR 32 under Manager RAR Elements Rendering RAR Overrides__ for the conforming to work properlyEXC The Normal texture is only available when the terrain is instanced or when using the Terrain Shaders Module., 0, 15)","False","Object","-1","","0","0","1","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":177,"pos":[1856,-128],"params":["Float","False","True","-1","2","TheVisualEngine.ElementGUI","100","2","BOXOPHOBIC/The Visual Engine/Elements/Form Surface (Terrain)","f4f273c3bb6262d4396be458405e60f9","True","VolumePass","0","0","VolumePass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","3","RenderType=Transparent=RenderType","Queue=Transparent=Queue=0","DisableBatching=True=DisableBatching","False","False","0","True","True","2","5","False","","10","False","","0","5","False","","10","False","","True","0","False","","5","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","True","True","True","True","True","False","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass","True","2","False","0","","0","0","Standard","3","VolumePass1","0","0","VolumePass2","0","0","Vertex Position","1","0","0","4","True","False","False","True","False","","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":266,"pos":[1856,-128],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass1","0","1","VolumePass1","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass1","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":267,"pos":[1856,-128],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass2","0","2","VolumePass2","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass2","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":178,"pos":[1856,256],"params":["Float","False","False","-1","2","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VisualPass","0","3","VisualPass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","True","True","2","5","False","","10","False","","0","5","False","","10","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","True","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","False","True","2","False","0","","0","0","Standard","0","False","0"]}
{"wire":[241,35,236,0]}
{"wire":[241,70,234,0]}
{"wire":[218,0,211,0]}
{"wire":[146,1,241,38]}
{"wire":[217,0,211,0]}
{"wire":[219,0,218,0]}
{"wire":[219,1,220,0]}
{"wire":[175,0,146,0]}
{"wire":[221,0,217,0]}
{"wire":[221,1,219,0]}
{"wire":[216,0,211,0]}
{"wire":[223,0,221,0]}
{"wire":[223,1,222,0]}
{"wire":[212,1,216,0]}
{"wire":[212,0,223,0]}
{"wire":[213,1,212,0]}
{"wire":[213,0,223,0]}
{"wire":[232,0,201,1]}
{"wire":[232,1,201,3]}
{"wire":[232,2,141,1]}
{"wire":[232,3,141,3]}
{"wire":[214,1,213,0]}
{"wire":[214,0,223,0]}
{"wire":[233,0,232,0]}
{"wire":[215,0,214,0]}
{"wire":[143,0,141,2]}
{"wire":[262,35,263,0]}
{"wire":[149,0,176,0]}
{"wire":[149,1,144,0]}
{"wire":[149,2,210,0]}
{"wire":[248,1,262,38]}
{"wire":[206,0,149,0]}
{"wire":[249,0,248,1]}
{"wire":[249,1,248,3]}
{"wire":[250,0,249,0]}
{"wire":[170,0,256,4]}
{"wire":[170,1,265,0]}
{"wire":[205,0,208,0]}
{"wire":[182,0,170,0]}
{"wire":[253,0,254,0]}
{"wire":[253,2,205,0]}
{"wire":[268,0,253,0]}
{"wire":[268,3,184,0]}
{"wire":[148,0,207,0]}
{"wire":[148,1,203,0]}
{"wire":[148,2,281,0]}
{"wire":[169,0,252,0]}
{"wire":[169,2,261,0]}
{"wire":[169,3,183,0]}
{"wire":[180,59,268,0]}
{"wire":[259,0,260,7]}
{"wire":[261,0,148,0]}
{"wire":[261,1,259,0]}
{"wire":[270,35,269,0]}
{"wire":[272,0,271,0]}
{"wire":[271,1,270,38]}
{"wire":[274,0,273,0]}
{"wire":[275,0,274,0]}
{"wire":[277,0,276,0]}
{"wire":[277,1,275,0]}
{"wire":[279,0,276,0]}
{"wire":[279,1,277,0]}
{"wire":[279,2,278,0]}
{"wire":[280,0,276,0]}
{"wire":[200,0,201,2]}
{"wire":[177,0,169,0]}
{"wire":[178,0,180,0]}
ASEEND*/
//CHKSM=12BA4CF77FE440A02CA4EAEE07B7ECA985D4592E