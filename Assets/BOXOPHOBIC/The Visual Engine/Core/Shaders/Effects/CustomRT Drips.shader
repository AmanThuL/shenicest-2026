// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Effects/CustomRT Drips"
{
    Properties
    {
		[StyledBanner(CustomRT Drips)] _BANNER( "[ BANNER ]", Float ) = 0
		[Space(10)][StyledTextureSingleLine] _WaterTex( "Water Texture", 2D ) = "white" {}
		[Space(10)] _FlowAIntensityValue( "FlowA Intensity", Range( 0, 1 ) ) = 1
		[IntRange] _FlowATillingValue( "FlowA Tilling", Range( 0, 20 ) ) = 1
		_FlowASpeedValue( "FlowA Speed", Range( 0, 4 ) ) = 1
		[Space(10)] _FlowBIntensityValue( "FlowB Intensity", Range( 0, 1 ) ) = 1
		[IntRange] _FlowBTillingValue( "FlowB Tilling", Range( 0, 20 ) ) = 1
		_FlowBSpeedValue( "FlowB Speed", Range( 0, 4 ) ) = 1
		[Space(10)][StyledTextureSingleLine] _DropsMaskTex( "Mask", 2D ) = "white" {}
		[Space(10)] _FlowMaskIntensityValue( "Flow Mask Intensity", Range( 0, 1 ) ) = 1
		_FlowMaskSpeedValue( "Flow Mask Speed", Range( 0, 2 ) ) = 1
		[IntRange] _FlowMaskTillingValue( "Flow Mask Tilling", Range( 1, 10 ) ) = 1
		[StyledRemapSlider] _FlowMaskRemap( "Flow Mask Remap", Vector ) = ( 0, 0, 0, 0 )

    }

	SubShader
	{
		LOD 0

		

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZClip True
		ZTest LEqual
		Offset 0 , 0
		

		
        Pass
        {
			Name "Custom RT Update"
            CGPROGRAM
            #define ASE_VERSION 19912
            #define ASE_USING_SAMPLING_MACROS 1

            #include "UnityCustomRenderTexture.cginc"
            #pragma vertex ASECustomRenderTextureVertexShader
            #pragma fragment frag
            #pragma target 3.0

			#include "UnityShaderVariables.cginc"
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
			#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
			#else//ASE Sampling Macros
			#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
			#endif//ASE Sampling Macros
			


			struct ase_appdata_customrendertexture
			{
				uint vertexID : SV_VertexID;
				
			};

			struct ase_v2f_customrendertexture
			{
				float4 vertex           : SV_POSITION;
				float3 localTexcoord    : TEXCOORD0;    // Texcoord local to the update zone (== globalTexcoord if no partial update zone is specified)
				float3 globalTexcoord   : TEXCOORD1;    // Texcoord relative to the complete custom texture
				uint primitiveID        : TEXCOORD2;    // Index of the update zone (correspond to the index in the updateZones of the Custom Texture)
				float3 position         : TEXCOORD3;    // For cube textures, position of the pixel being rendered in the cubemap
				
			};

			uniform float _BANNER;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_WaterTex);
			uniform half _FlowATillingValue;
			uniform half _FlowASpeedValue;
			uniform half4 TVE_TimeParams;
			SamplerState sampler_Linear_Repeat;
			uniform float _FlowAIntensityValue;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_DropsMaskTex);
			uniform half _FlowMaskTillingValue;
			uniform half _FlowMaskSpeedValue;
			SamplerState sampler_DropsMaskTex;
			uniform half4 _FlowMaskRemap;
			uniform half _FlowMaskIntensityValue;
			uniform half _FlowBTillingValue;
			uniform half _FlowBSpeedValue;
			uniform float _FlowBIntensityValue;


			float3 CustomRenderTextureComputeCubePosition( float2 globalTexcoord )
			{
				float2 xy = globalTexcoord * 2.0 - 1.0;
				float3 position;
				if ( _CustomRenderTextureCubeFace == 0.0 )
				{
					position = float3( 1.0, -xy.y, -xy.x );
				}
				else if ( _CustomRenderTextureCubeFace == 1.0 )
				{
					position = float3( -1.0, -xy.y, xy.x );
				}
				else if ( _CustomRenderTextureCubeFace == 2.0 )
				{
					position = float3( xy.x, 1.0, xy.y );
				}
				else if ( _CustomRenderTextureCubeFace == 3.0 )
				{
					position = float3( xy.x, -1.0, -xy.y );
				}
				else if ( _CustomRenderTextureCubeFace == 4.0 )
				{
					position = float3( xy.x, -xy.y, 1.0 );
				}
				else if ( _CustomRenderTextureCubeFace == 5.0 )
				{
					position = float3( -xy.x, -xy.y, -1.0 );
				}
				return position;
			}

			ase_v2f_customrendertexture ASECustomRenderTextureVertexShader( ase_appdata_customrendertexture IN  )
			{
				ase_v2f_customrendertexture OUT;

				

			#if UNITY_UV_STARTS_AT_TOP
				const float2 vertexPositions[6] =
				{
					{ -1.0f,  1.0f },
					{ -1.0f, -1.0f },
					{  1.0f, -1.0f },
					{  1.0f,  1.0f },
					{ -1.0f,  1.0f },
					{  1.0f, -1.0f }
				};

				const float2 texCoords[6] =
				{
					{ 0.0f, 0.0f },
					{ 0.0f, 1.0f },
					{ 1.0f, 1.0f },
					{ 1.0f, 0.0f },
					{ 0.0f, 0.0f },
					{ 1.0f, 1.0f }
				};
			#else
				const float2 vertexPositions[6] =
				{
					{  1.0f,  1.0f },
					{ -1.0f, -1.0f },
					{ -1.0f,  1.0f },
					{ -1.0f, -1.0f },
					{  1.0f,  1.0f },
					{  1.0f, -1.0f }
				};

				const float2 texCoords[6] =
				{
					{ 1.0f, 1.0f },
					{ 0.0f, 0.0f },
					{ 0.0f, 1.0f },
					{ 0.0f, 0.0f },
					{ 1.0f, 1.0f },
					{ 1.0f, 0.0f }
				};
			#endif

				uint primitiveID = IN.vertexID / 6;
				uint vertexID = IN.vertexID % 6;
				float3 updateZoneCenter = CustomRenderTextureCenters[primitiveID].xyz;
				float3 updateZoneSize = CustomRenderTextureSizesAndRotations[primitiveID].xyz;
				float rotation = CustomRenderTextureSizesAndRotations[primitiveID].w * UNITY_PI / 180.0f;

			#if !UNITY_UV_STARTS_AT_TOP
				rotation = -rotation;
			#endif

				// Normalize rect if needed
				if (CustomRenderTextureUpdateSpace > 0.0) // Pixel space
				{
					// Normalize xy because we need it in clip space.
					updateZoneCenter.xy /= _CustomRenderTextureInfo.xy;
					updateZoneSize.xy /= _CustomRenderTextureInfo.xy;
				}
				else // normalized space
				{
					// Un-normalize depth because we need actual slice index for culling
					updateZoneCenter.z *= _CustomRenderTextureInfo.z;
					updateZoneSize.z *= _CustomRenderTextureInfo.z;
				}

				// Compute rotation

				// Compute quad vertex position
				float2 clipSpaceCenter = updateZoneCenter.xy * 2.0 - 1.0;
				float2 pos = vertexPositions[vertexID] * updateZoneSize.xy;
				pos = CustomRenderTextureRotate2D(pos, rotation);
				pos.x += clipSpaceCenter.x;
			#if UNITY_UV_STARTS_AT_TOP
				pos.y += clipSpaceCenter.y;
			#else
				pos.y -= clipSpaceCenter.y;
			#endif

				// For 3D texture, cull quads outside of the update zone
				// This is neeeded in additional to the preliminary minSlice/maxSlice done on the CPU because update zones can be disjointed.
				// ie: slices [1..5] and [10..15] for two differents zones so we need to cull out slices 0 and [6..9]
				if (CustomRenderTextureIs3D > 0.0)
				{
					int minSlice = (int)(updateZoneCenter.z - updateZoneSize.z * 0.5);
					int maxSlice = minSlice + (int)updateZoneSize.z;
					if (_CustomRenderTexture3DSlice < minSlice || _CustomRenderTexture3DSlice >= maxSlice)
					{
						pos.xy = float2(1000.0, 1000.0); // Vertex outside of ncs
					}
				}

				OUT.vertex = float4(pos, UNITY_NEAR_CLIP_VALUE, 1.0);
				OUT.primitiveID = asuint(CustomRenderTexturePrimitiveIDs[primitiveID]);
				OUT.localTexcoord = float3(texCoords[vertexID], CustomRenderTexture3DTexcoordW);
				OUT.globalTexcoord = float3(pos.xy * 0.5 + 0.5, CustomRenderTexture3DTexcoordW);
			#if UNITY_UV_STARTS_AT_TOP
				OUT.globalTexcoord.y = 1.0 - OUT.globalTexcoord.y;
			#endif
				OUT.position = CustomRenderTextureComputeCubePosition( OUT.globalTexcoord.xy );
				return OUT;
			}

            float4 frag( ase_v2f_customrendertexture IN  ) : COLOR
            {
				half3 PositionWS = IN.position;
				half3 NormalWS = normalize( IN.position );

				float2 Input_Coords80_g77172 = ( IN.localTexcoord.xy * _FlowATillingValue );
				float2 appendResult487 = (float2(0.0 , 1.0));
				half2 Input_Direction82_g77172 = appendResult487;
				float mulTime113_g77165 = _Time.y * _FlowASpeedValue;
				float lerpResult128_g77165 = lerp( mulTime113_g77165 , ( ( mulTime113_g77165 * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				float Input_Time88_g77172 = lerpResult128_g77165;
				float mulTime113_g77164 = _Time.y * _FlowMaskSpeedValue;
				float lerpResult128_g77164 = lerp( mulTime113_g77164 , ( ( mulTime113_g77164 * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				float2 appendResult518 = (float2(0.0 , lerpResult128_g77164));
				float temp_output_7_0_g77171 = _FlowMaskRemap.x;
				float temp_output_9_0_g77171 = ( SAMPLE_TEXTURE2D( _DropsMaskTex, sampler_DropsMaskTex, ( ( IN.localTexcoord.xy * _FlowMaskTillingValue ) + appendResult518 ) ).r - temp_output_7_0_g77171 );
				float lerpResult514 = lerp( 1.0 , saturate( ( temp_output_9_0_g77171 / ( ( _FlowMaskRemap.y - temp_output_7_0_g77171 ) + 0.0001 ) ) ) , _FlowMaskIntensityValue);
				half Drips_Mask515 = lerpResult514;
				float2 Input_Coords80_g77177 = ( IN.localTexcoord.xy * _FlowBTillingValue );
				float2 appendResult498 = (float2(0.0 , 1.0));
				half2 Input_Direction82_g77177 = appendResult498;
				float mulTime113_g77176 = _Time.y * _FlowBSpeedValue;
				float lerpResult128_g77176 = lerp( mulTime113_g77176 , ( ( mulTime113_g77176 * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				float Input_Time88_g77177 = lerpResult128_g77176;
				half2 WindNoise320 = ( ( ( ((SAMPLE_TEXTURE2D( _WaterTex, sampler_Linear_Repeat, ( Input_Coords80_g77172 + ( Input_Direction82_g77172 * Input_Time88_g77172 ) ) )).ag*2.0 + -1.0) * _FlowAIntensityValue ) * Drips_Mask515 ) + ( ((SAMPLE_TEXTURE2D( _WaterTex, sampler_Linear_Repeat, ( Input_Coords80_g77177 + ( Input_Direction82_g77177 * Input_Time88_g77177 ) ) )).ag*2.0 + -1.0) * _FlowBIntensityValue ) );
				

                float4 finalColor = float4( (WindNoise320*0.5 + 0.5), 0.0 , 0.0 );

				return finalColor;
            }
            ENDCG
		}
    }
	
	CustomEditor "TheVisualEngine.HelperGUI"
	Fallback Off
}
/*ASEBEGIN
Version=19912
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":506,"pos":[-512,6400],"params":["Half","False","Property","_FlowMaskSpeedValue","Flow Mask Speed","10","0","Create","False","0","0","0","False","0","False","Object","-1","","1","0.4","0","2","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor","id":503,"pos":[-512,6144],"params":["Inherit","False","0","2","0","5","FLOAT2","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":504,"pos":[-512,6272],"params":["Half","False","Property","_FlowMaskTillingValue","Flow Mask Tilling","11","1","[IntRange]","Create","False","0","0","0","False","0","False","Object","-1","","1","4","1","10","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":505,"pos":[-240,6400],"params":["Inherit","False","Get Global Time","-1","","77164","2b2f842f8071fb945821b595284b5848","1,132,0","1","129","FLOAT","1","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":507,"pos":[-192,6144],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT","0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.TexturePropertyNode, AmplifyShaderEditor","id":296,"pos":[-1152,4992],"params":["Inherit","True","Property","_WaterTex","Water Texture","1","0","Create","False","0","0","0","False","2","Space(10)","StyledTextureSingleLine","False","","None","1dbdaff51ef624d4cabbecfcea3e75ca","True","white","Auto","Texture2D","False","-1","0","2","SAMPLER2D","0","SAMPLERSTATE","1"]}
{"type":"AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor","id":518,"pos":[0,6400],"params":["Inherit","False","FLOAT2","4","0","FLOAT","0","False","1","FLOAT","0","False","2","FLOAT","0","False","3","FLOAT","0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":334,"pos":[-512,5248],"params":["Half","False","Property","_FlowASpeedValue","FlowA Speed","4","0","Create","False","0","0","0","False","0","False","Object","-1","","1","1","0","4","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":434,"pos":[-896,4992],"params":["Half","False","WaterTex","-1","True","1","0","SAMPLER2D","","False","1","SAMPLER2D","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":509,"pos":[256,6144],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor","id":299,"pos":[-512,5056],"params":["Inherit","False","0","2","0","5","FLOAT2","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":300,"pos":[-512,5168],"params":["Half","False","Property","_FlowATillingValue","FlowA Tilling","3","1","[IntRange]","Create","False","0","0","0","False","0","False","Object","-1","","1","20","0","20","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":499,"pos":[-512,5760],"params":["Half","False","Property","_FlowBSpeedValue","FlowB Speed","7","0","Create","False","0","0","0","False","0","False","Object","-1","","1","0.5","0","4","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":435,"pos":[-512,4992],"params":["Inherit","False","434","WaterTex","1","0","OBJECT","","False","1","SAMPLER2D","0"]}
{"type":"AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor","id":511,"pos":[512,6144],"params":["Inherit","True","Property","_DropsMaskTex","Mask","8","0","Create","False","0","0","0","False","2","Space(10)","StyledTextureSingleLine","False","","-1","None","56205abbbb6889542acc6fe5e5c4f1f3","True","0","False","white","Auto","False","Object","-1","Auto","Texture2D","False","8","0","SAMPLER2D","","False","1","FLOAT2","0,0","False","2","FLOAT","0","False","3","FLOAT2","0,0","False","4","FLOAT2","0,0","False","5","FLOAT","1","False","6","FLOAT","0","False","7","SAMPLERSTATE","","False","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.Vector4Node, AmplifyShaderEditor","id":510,"pos":[512,6400],"params":["Half","False","Property","_FlowMaskRemap","Flow Mask Remap","12","0","Create","False","0","0","0","False","1","StyledRemapSlider","False","Object","-1","","0,0,0,0","0.4,0.6,5,0","0","5","FLOAT4","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor","id":491,"pos":[-512,5568],"params":["Inherit","False","0","2","0","5","FLOAT2","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":301,"pos":[-128,5056],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT","0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":492,"pos":[-512,5680],"params":["Half","False","Property","_FlowBTillingValue","FlowB Tilling","6","1","[IntRange]","Create","False","0","0","0","False","0","False","Object","-1","","1","4","0","20","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor","id":487,"pos":[-128,5144],"params":["Inherit","False","FLOAT2","4","0","FLOAT","0","False","1","FLOAT","1","False","2","FLOAT","0","False","3","FLOAT","0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":323,"pos":[-128,5248],"params":["Inherit","False","Get Global Time","-1","","77165","2b2f842f8071fb945821b595284b5848","1,132,0","1","129","FLOAT","1","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":501,"pos":[-512,5504],"params":["Inherit","False","434","WaterTex","1","0","OBJECT","","False","1","SAMPLER2D","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":512,"pos":[896,6144],"params":["Inherit","False","Math Remap","-1","","77171","5eda8a2bb94ebef4ab0e43d19291cd8b","3,18,0,21,1,14,0","4","6","FLOAT","0","False","7","FLOAT","0","False","8","FLOAT","0","False","19","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":513,"pos":[512,6592],"params":["Half","False","Property","_FlowMaskIntensityValue","Flow Mask Intensity","9","0","Create","False","0","0","0","False","1","Space(10)","False","Object","-1","","1","0","0","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":490,"pos":[256,4992],"params":["Inherit","False","Compute Flow Map","-1","","77172","47b4a92df17039e4d8b606acbee2f25e","1,66,1","5","20","SAMPLER2D","0,0","False","3","FLOAT2","0,0","False","21","FLOAT2","0,0","False","15","FLOAT","0.5","False","68","FLOAT","0.5","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":493,"pos":[-128,5568],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT","0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor","id":498,"pos":[-128,5656],"params":["Inherit","False","FLOAT2","4","0","FLOAT","0","False","1","FLOAT","1","False","2","FLOAT","0","False","3","FLOAT","0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":500,"pos":[-128,5760],"params":["Inherit","False","Get Global Time","-1","","77176","2b2f842f8071fb945821b595284b5848","1,132,0","1","129","FLOAT","1","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":502,"pos":[256,5504],"params":["Inherit","False","Compute Flow Map","-1","","77177","47b4a92df17039e4d8b606acbee2f25e","1,66,1","5","20","SAMPLER2D","0,0","False","3","FLOAT2","0,0","False","21","FLOAT2","0,0","False","15","FLOAT","0.5","False","68","FLOAT","0.5","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":315,"pos":[640,4992],"params":["Inherit","False","FLOAT2","3","1","2","3","1","0","COLOR","0,0,0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":514,"pos":[1152,6144],"params":["Inherit","False","3","0","FLOAT","1","False","1","FLOAT","0","False","2","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":494,"pos":[640,5504],"params":["Inherit","False","FLOAT2","3","1","2","3","1","0","COLOR","0,0,0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor","id":314,"pos":[832,4992],"params":["Inherit","False","3","0","FLOAT2","0,0","False","1","FLOAT","2","False","2","FLOAT","-1","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":424,"pos":[832,5120],"params":["Inherit","False","Property","_FlowAIntensityValue","FlowA Intensity","2","0","Create","False","0","0","0","False","1","Space(10)","False","Object","-1","","1","0","0","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":515,"pos":[1408,6144],"params":["Half","False","Drips_Mask","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor","id":495,"pos":[832,5504],"params":["Inherit","False","3","0","FLOAT2","0,0","False","1","FLOAT","2","False","2","FLOAT","-1","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":423,"pos":[1152,4992],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT","0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":517,"pos":[1152,5120],"params":["Inherit","False","515","Drips_Mask","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":496,"pos":[832,5632],"params":["Inherit","False","Property","_FlowBIntensityValue","FlowB Intensity","5","0","Create","False","0","0","0","False","1","Space(10)","False","Object","-1","","1","0","0","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":497,"pos":[1152,5504],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT","0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":516,"pos":[1408,4992],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT","0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":332,"pos":[1664,4992],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":320,"pos":[1920,4992],"params":["Half","False","WindNoise","-1","True","1","0","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":321,"pos":[2560,5248],"params":["Inherit","False","320","WindNoise","1","0","OBJECT","","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":272,"pos":[3200,5120],"params":["Inherit","False","Base Compile","-1","","77181","e67c8238031dbf04ab79a5d4d63d1b4f","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor","id":138,"pos":[2864,5248],"params":["Inherit","False","3","0","FLOAT2","0,0","False","1","FLOAT","0.5","False","2","FLOAT","0.5","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":108,"pos":[-512,4480],"params":["Inherit","False","Property","_BANNER","[ BANNER ]","0","0","Create","True","0","0","0","True","1","StyledBanner(CustomRT Drips)","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":0,"pos":[3200,5248],"params":["Float","False","True","-1","2","TheVisualEngine.HelperGUI","0","16","BOXOPHOBIC/The Visual Engine/Effects/CustomRT Drips","32120270d1b3a8746af2aca8bc749736","True","Custom RT Update","0","0","Custom RT Update","1","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","0","True","2","False","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","0","","0","0","Standard","0","0","1","True","False","","True","0"]}
{"wire":[505,129,506,0]}
{"wire":[507,0,503,0]}
{"wire":[507,1,504,0]}
{"wire":[518,1,505,0]}
{"wire":[434,0,296,0]}
{"wire":[509,0,507,0]}
{"wire":[509,1,518,0]}
{"wire":[511,1,509,0]}
{"wire":[301,0,299,0]}
{"wire":[301,1,300,0]}
{"wire":[323,129,334,0]}
{"wire":[512,6,511,1]}
{"wire":[512,7,510,1]}
{"wire":[512,8,510,2]}
{"wire":[490,20,435,0]}
{"wire":[490,3,301,0]}
{"wire":[490,21,487,0]}
{"wire":[490,15,323,0]}
{"wire":[493,0,491,0]}
{"wire":[493,1,492,0]}
{"wire":[500,129,499,0]}
{"wire":[502,20,501,0]}
{"wire":[502,3,493,0]}
{"wire":[502,21,498,0]}
{"wire":[502,15,500,0]}
{"wire":[315,0,490,0]}
{"wire":[514,1,512,0]}
{"wire":[514,2,513,0]}
{"wire":[494,0,502,0]}
{"wire":[314,0,315,0]}
{"wire":[515,0,514,0]}
{"wire":[495,0,494,0]}
{"wire":[423,0,314,0]}
{"wire":[423,1,424,0]}
{"wire":[497,0,495,0]}
{"wire":[497,1,496,0]}
{"wire":[516,0,423,0]}
{"wire":[516,1,517,0]}
{"wire":[332,0,516,0]}
{"wire":[332,1,497,0]}
{"wire":[320,0,332,0]}
{"wire":[138,0,321,0]}
{"wire":[0,0,138,0]}
ASEEND*/
//CHKSM=AE6A7D439C889454A095E11AFB4E6A1FA0AA7D93