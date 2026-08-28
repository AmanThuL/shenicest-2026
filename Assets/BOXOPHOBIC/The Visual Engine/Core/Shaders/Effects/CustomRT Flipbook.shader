// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Effects/CustomRT Flipbook"
{
    Properties
    {
		[StyledBanner(CustomRT Flipbook)] _BANNER( "[ BANNER ]", Float ) = 0
		[StyledTextureSingleLine] _FlipbookTex( "Flipbook Texture", 2D ) = "white" {}
		[Space(10)] _FlipbookColumsValue( "Flipbook Colums", Float ) = 8
		_FlipbookRows( "Flipbook Rows", Float ) = 8
		_FlipbookSpeedValue( "Flipbook Speed", Float ) = 1
		_FlipbookStartFrameValue( "Flipbook Start Frame", Float ) = 0

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
			UNITY_DECLARE_TEX2D_NOSAMPLER(_FlipbookTex);
			uniform half _FlipbookColumsValue;
			uniform half _FlipbookRows;
			uniform half _FlipbookSpeedValue;
			uniform half _FlipbookStartFrameValue;
			uniform half4 TVE_TimeParams;
			SamplerState sampler_FlipbookTex;


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

				float lerpResult128_g77217 = lerp( _Time.y , ( ( _Time.y * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				// *** BEGIN Flipbook UV Animation vars ***
				// Total tiles of Flipbook Texture
				float fbtotaltiles419 = _FlipbookColumsValue * _FlipbookRows;
				// Offsets for cols and rows of Flipbook Texture
				float fbcolsoffset419 = 1.0f / _FlipbookColumsValue;
				float fbrowsoffset419 = 1.0f / _FlipbookRows;
				// Speed of animation
				float fbspeed419 = lerpResult128_g77217 * _FlipbookSpeedValue;
				// UV Tiling (col and row offset)
				float2 fbtiling419 = float2(fbcolsoffset419, fbrowsoffset419);
				// UV Offset - calculate current tile linear index, and convert it to (X * coloffset, Y * rowoffset)
				// Calculate current tile linear index
				float fbcurrenttileindex419 = floor( fmod( fbspeed419 + _FlipbookStartFrameValue, fbtotaltiles419) );
				fbcurrenttileindex419 += ( fbcurrenttileindex419 < 0) ? fbtotaltiles419 : 0;
				// Obtain Offset X coordinate from current tile linear index
				float fblinearindextox419 = round ( fmod ( fbcurrenttileindex419, _FlipbookColumsValue ) );
				// Reverse X animation if speed is negative
				fblinearindextox419 = (_FlipbookSpeedValue > 0 ? fblinearindextox419 : (int)_FlipbookColumsValue - fblinearindextox419);
				// Multiply Offset X by coloffset
				float fboffsetx419 = fblinearindextox419 * fbcolsoffset419;
				// Obtain Offset Y coordinate from current tile linear index
				float fblinearindextoy419 = round( fmod( ( fbcurrenttileindex419 - fblinearindextox419 ) / _FlipbookColumsValue, _FlipbookRows ) );
				// Reverse Y to get tiles from Top to Bottom and Reverse Y animation if speed is negative
				fblinearindextoy419 = (_FlipbookSpeedValue <  0 ? fblinearindextoy419 : (int)_FlipbookRows - fblinearindextoy419);
				// Multiply Offset Y by rowoffset
				float fboffsety419 = fblinearindextoy419 * fbrowsoffset419;
				// UV Offset
				float2 fboffset419 = float2(fboffsetx419, fboffsety419);
				// Flipbook UV
				float2 fbuv419 = IN.localTexcoord.xy * fbtiling419 + fboffset419;
				// *** END Flipbook UV Animation vars ***
				int flipbookFrame419 = ( ( int )fbcurrenttileindex419);
				

                float4 finalColor = SAMPLE_TEXTURE2D( _FlipbookTex, sampler_FlipbookTex, fbuv419 );

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
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":424,"pos":[1664,2624],"params":["Half","False","Property","_FlipbookStartFrameValue","Flipbook Start Frame","5","0","Create","False","0","0","0","False","0","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":425,"pos":[1664,2752],"params":["Inherit","False","Get Global Time","-1","","77217","2b2f842f8071fb945821b595284b5848","1,132,0","1","129","FLOAT","1","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":422,"pos":[1664,2496],"params":["Half","False","Property","_FlipbookRows","Flipbook Rows","3","0","Create","True","0","0","0","False","0","False","Object","-1","","8","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":421,"pos":[1664,2432],"params":["Half","False","Property","_FlipbookColumsValue","Flipbook Colums","2","0","Create","False","0","0","0","False","1","Space(10)","False","Object","-1","","8","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor","id":420,"pos":[1664,2304],"params":["Inherit","False","0","2","0","5","FLOAT2","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":423,"pos":[1664,2560],"params":["Half","False","Property","_FlipbookSpeedValue","Flipbook Speed","4","0","Create","False","0","0","0","False","0","False","Object","-1","","1","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TFHCFlipBookUVAnimation, AmplifyShaderEditor","id":419,"pos":[1984,2304],"params":["Inherit","False","0","1","7","0","FLOAT2","0,0","False","1","FLOAT","0","False","2","FLOAT","0","False","3","FLOAT","0","False","4","FLOAT","0","False","5","FLOAT","0","False","6","FLOAT","-1","False","4","FLOAT2","0","FLOAT","1","FLOAT","2","INT","3"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":330,"pos":[1664,1920],"params":["Inherit","False","Property","_BANNER","[ BANNER ]","0","0","Create","True","0","0","0","True","1","StyledBanner(CustomRT Flipbook)","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor","id":426,"pos":[2304,2304],"params":["Inherit","True","Property","_FlipbookTex","Flipbook Texture","1","0","Create","False","0","0","0","False","1","StyledTextureSingleLine","False","","-1","None","None","True","0","False","white","Auto","False","Object","-1","Auto","Texture2D","False","8","0","SAMPLER2D","","False","1","FLOAT2","0,0","False","2","FLOAT","0","False","3","FLOAT2","0,0","False","4","FLOAT2","0,0","False","5","FLOAT","1","False","6","FLOAT","0","False","7","SAMPLERSTATE","","False","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":284,"pos":[1920,1920],"params":["Inherit","False","Base Compile","-1","","77218","e67c8238031dbf04ab79a5d4d63d1b4f","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":0,"pos":[2688,2304],"params":["Float","False","True","-1","2","TheVisualEngine.HelperGUI","0","16","BOXOPHOBIC/The Visual Engine/Effects/CustomRT Flipbook","32120270d1b3a8746af2aca8bc749736","True","Custom RT Update","0","0","Custom RT Update","1","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","0","True","2","False","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","0","","0","0","Standard","0","0","1","True","False","","True","0"]}
{"wire":[419,0,420,0]}
{"wire":[419,1,421,0]}
{"wire":[419,2,422,0]}
{"wire":[419,3,423,0]}
{"wire":[419,4,424,0]}
{"wire":[419,5,425,0]}
{"wire":[426,1,419,0]}
{"wire":[0,0,426,0]}
ASEEND*/
//CHKSM=7712D9C4ACCC52AE3DEC65AA4829C1C55B84DEEB