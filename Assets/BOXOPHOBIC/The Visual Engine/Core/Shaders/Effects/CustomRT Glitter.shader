// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Effects/CustomRT Glitter"
{
    Properties
    {
		[StyledBanner(CustomRT Glitter)] _BANNER( "[ BANNER ]", Float ) = 0
		_GlitterAIntensityValue( "GlitterA Intensity", Range( 0, 8 ) ) = 1
		_GlitterAScaleValue( "GlitterA Scale", Float ) = 100
		_GlitterASpeedValue( "GlitterA Speed", Range( 0, 1 ) ) = 0.5
		_GlitterACutoutValue( "GlitterA Cutout", Range( 0, 1 ) ) = 0.9

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

			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0


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
			uniform half TVE_MainCameraSpeedValue;
			uniform half _GlitterASpeedValue;
			uniform half _GlitterAScaleValue;
			uniform half _GlitterACutoutValue;
			uniform half _GlitterAIntensityValue;
			float3 mod3D289( float3 x ) { return x - floor( x / 289.0 ) * 289.0; }
			float4 mod3D289( float4 x ) { return x - floor( x / 289.0 ) * 289.0; }
			float4 permute( float4 x ) { return mod3D289( ( x * 34.0 + 1.0 ) * x ); }
			float4 taylorInvSqrt( float4 r ) { return 1.79284291400159 - r * 0.85373472095314; }
			float snoise( float3 v )
			{
				const float2 C = float2( 1.0 / 6.0, 1.0 / 3.0 );
				float3 i = floor( v + dot( v, C.yyy ) );
				float3 x0 = v - i + dot( i, C.xxx );
				float3 g = step( x0.yzx, x0.xyz );
				float3 l = 1.0 - g;
				float3 i1 = min( g.xyz, l.zxy );
				float3 i2 = max( g.xyz, l.zxy );
				float3 x1 = x0 - i1 + C.xxx;
				float3 x2 = x0 - i2 + C.yyy;
				float3 x3 = x0 - 0.5;
				i = mod3D289( i);
				float4 p = permute( permute( permute( i.z + float4( 0.0, i1.z, i2.z, 1.0 ) ) + i.y + float4( 0.0, i1.y, i2.y, 1.0 ) ) + i.x + float4( 0.0, i1.x, i2.x, 1.0 ) );
				float4 j = p - 49.0 * floor( p / 49.0 );  // mod(p,7*7)
				float4 x_ = floor( j / 7.0 );
				float4 y_ = floor( j - 7.0 * x_ );  // mod(j,N)
				float4 x = ( x_ * 2.0 + 0.5 ) / 7.0 - 1.0;
				float4 y = ( y_ * 2.0 + 0.5 ) / 7.0 - 1.0;
				float4 h = 1.0 - abs( x ) - abs( y );
				float4 b0 = float4( x.xy, y.xy );
				float4 b1 = float4( x.zw, y.zw );
				float4 s0 = floor( b0 ) * 2.0 + 1.0;
				float4 s1 = floor( b1 ) * 2.0 + 1.0;
				float4 sh = -step( h, 0.0 );
				float4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
				float4 a1 = b1.xzyw + s1.xzyw * sh.zzww;
				float3 g0 = float3( a0.xy, h.x );
				float3 g1 = float3( a0.zw, h.y );
				float3 g2 = float3( a1.xy, h.z );
				float3 g3 = float3( a1.zw, h.w );
				float4 norm = taylorInvSqrt( float4( dot( g0, g0 ), dot( g1, g1 ), dot( g2, g2 ), dot( g3, g3 ) ) );
				g0 *= norm.x;
				g1 *= norm.y;
				g2 *= norm.z;
				g3 *= norm.w;
				float4 m = max( 0.6 - float4( dot( x0, x0 ), dot( x1, x1 ), dot( x2, x2 ), dot( x3, x3 ) ), 0.0 );
				m = m* m;
				m = m* m;
				float4 px = float4( dot( x0, g0 ), dot( x1, g1 ), dot( x2, g2 ), dot( x3, g3 ) );
				return 42.0 * dot( m, px);
			}
			


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

				half Camera_Speed178 = TVE_MainCameraSpeedValue;
				float3 appendResult131 = (float3(IN.localTexcoord.xy , ( Camera_Speed178 * _GlitterASpeedValue )));
				float simplePerlin3D132 = snoise( appendResult131*_GlitterAScaleValue );
				simplePerlin3D132 = simplePerlin3D132*0.5 + 0.5;
				float temp_output_7_0_g76772 = _GlitterACutoutValue;
				float temp_output_9_0_g76772 = ( simplePerlin3D132 - temp_output_7_0_g76772 );
				float temp_output_183_0 = ( saturate( ( temp_output_9_0_g76772 / ( ( 1.0 - temp_output_7_0_g76772 ) + 0.0001 ) ) ) * _GlitterAIntensityValue );
				float4 temp_cast_0 = (temp_output_183_0).xxxx;
				

                float4 finalColor = temp_cast_0;

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
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":166,"pos":[-768,384],"params":["Half","False","Global","TVE_MainCameraSpeedValue","TVE_MainCameraSpeedValue","8","0","Create","True","0","0","0","False","0","False","Object","-1","","0","3.893754","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":178,"pos":[-384,384],"params":["Half","False","Camera_Speed","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":127,"pos":[-768,1088],"params":["Half","False","Property","_GlitterASpeedValue","GlitterA Speed","3","0","Create","False","0","0","0","False","0","False","Object","-1","","0.5","0.5","0","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":179,"pos":[-768,1024],"params":["Inherit","False","178","Camera_Speed","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor","id":129,"pos":[-768,768],"params":["Inherit","False","0","2","0","5","FLOAT2","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":156,"pos":[-448,1024],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor","id":131,"pos":[-256,768],"params":["Inherit","False","FLOAT3","4","0","FLOAT2","0,0","False","1","FLOAT","0","False","2","FLOAT","0","False","3","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":142,"pos":[-256,1024],"params":["Half","False","Property","_GlitterAScaleValue","GlitterA Scale","2","0","Create","False","0","0","0","False","0","False","Object","-1","","100","200","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.NoiseGeneratorNode, AmplifyShaderEditor","id":132,"pos":[0,768],"params":["Inherit","False","Simplex3D","True","True","2","0","FLOAT3","0,0,0","False","1","FLOAT","100","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":137,"pos":[128,1088],"params":["Half","False","Constant","_Float1","Float 1","3","0","Create","True","0","0","0","False","0","False","Object","-1","","1","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":136,"pos":[0,1024],"params":["Half","False","Property","_GlitterACutoutValue","GlitterA Cutout","4","0","Create","False","0","0","0","False","0","False","Object","-1","","0.9","0.8","0","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":134,"pos":[384,768],"params":["Inherit","False","Math Remap","-1","","76772","5eda8a2bb94ebef4ab0e43d19291cd8b","3,18,0,21,1,14,0","4","6","FLOAT","0","False","7","FLOAT","0","False","8","FLOAT","0","False","19","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":182,"pos":[384,1024],"params":["Half","False","Property","_GlitterAIntensityValue","GlitterA Intensity","1","0","Create","False","0","0","0","False","0","False","Object","-1","","1","0.8","0","8","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":181,"pos":[-768,1664],"params":["Inherit","False","178","Camera_Speed","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":172,"pos":[-768,1728],"params":["Half","False","Property","_GlitterBSpeedValue","GlitterB Speed","7","0","Create","False","0","0","0","False","0","False","Object","-1","","0.5","0.5","0","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor","id":168,"pos":[-768,1408],"params":["Inherit","False","0","2","0","5","FLOAT2","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":173,"pos":[-448,1664],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor","id":169,"pos":[-256,1408],"params":["Inherit","False","FLOAT3","4","0","FLOAT2","0,0","False","1","FLOAT","0","False","2","FLOAT","0","False","3","FLOAT","0","False","1","FLOAT3","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":174,"pos":[-256,1664],"params":["Half","False","Property","_GlitterBScaleValue","GlitterB Scale","6","0","Create","False","0","0","0","False","0","False","Object","-1","","100","200","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.NoiseGeneratorNode, AmplifyShaderEditor","id":170,"pos":[0,1408],"params":["Inherit","False","Simplex3D","True","True","2","0","FLOAT3","0,0,0","False","1","FLOAT","100","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":175,"pos":[128,1728],"params":["Half","False","Constant","_Float2","Float 1","3","0","Create","True","0","0","0","False","0","False","Object","-1","","1","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":176,"pos":[0,1664],"params":["Half","False","Property","_GlitterBCutoutValue","GlitterB Cutout","8","0","Create","False","0","0","0","False","0","False","Object","-1","","0.9","0.8","0","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":177,"pos":[384,1408],"params":["Inherit","False","Math Remap","-1","","76773","5eda8a2bb94ebef4ab0e43d19291cd8b","3,18,0,21,1,14,0","4","6","FLOAT","0","False","7","FLOAT","0","False","8","FLOAT","0","False","19","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":185,"pos":[384,1664],"params":["Half","False","Property","_GlitterBIntensityValue","GlitterB Intensity","5","0","Create","False","0","0","0","False","1","Space(10)","False","Object","-1","","1","0.8","0","8","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":183,"pos":[704,768],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":184,"pos":[704,1408],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":108,"pos":[-768,256],"params":["Inherit","False","Property","_BANNER","[ BANNER ]","0","0","Create","True","0","0","0","True","1","StyledBanner(CustomRT Glitter)","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":180,"pos":[1024,768],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":186,"pos":[1408,640],"params":["Inherit","False","Base Compile","-1","","76890","e67c8238031dbf04ab79a5d4d63d1b4f","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":0,"pos":[1408,768],"params":["Float","False","True","-1","2","TheVisualEngine.HelperGUI","0","16","BOXOPHOBIC/The Visual Engine/Effects/CustomRT Glitter","32120270d1b3a8746af2aca8bc749736","True","Custom RT Update","0","0","Custom RT Update","1","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","0","True","2","False","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","0","","0","0","Standard","0","0","1","True","False","","True","0"]}
{"wire":[178,0,166,0]}
{"wire":[156,0,179,0]}
{"wire":[156,1,127,0]}
{"wire":[131,0,129,0]}
{"wire":[131,2,156,0]}
{"wire":[132,0,131,0]}
{"wire":[132,1,142,0]}
{"wire":[134,6,132,0]}
{"wire":[134,7,136,0]}
{"wire":[134,8,137,0]}
{"wire":[173,0,181,0]}
{"wire":[173,1,172,0]}
{"wire":[169,0,168,0]}
{"wire":[169,2,173,0]}
{"wire":[170,0,169,0]}
{"wire":[170,1,174,0]}
{"wire":[177,6,170,0]}
{"wire":[177,7,176,0]}
{"wire":[177,8,175,0]}
{"wire":[183,0,134,0]}
{"wire":[183,1,182,0]}
{"wire":[184,0,177,0]}
{"wire":[184,1,185,0]}
{"wire":[180,0,183,0]}
{"wire":[180,1,184,0]}
{"wire":[0,0,183,0]}
ASEEND*/
//CHKSM=4B6877297E3082AA39DC400E3CC217B51B4FBF66