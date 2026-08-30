// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Effects/CustomRT Drops"
{
    Properties
    {
		[StyledBanner(CustomRT Drops)] _BANNER( "[ BANNER ]", Float ) = 0
		[NoScaleOffset][StyledTextureSingleLine] _DropsTex( "Drops Texture", 2D ) = "white" {}
		[Space(10)] _RingsSpeedValue( "Rings Speed", Range( 0, 4 ) ) = 1
		_RingsNormalValue( "Rings Normal", Range( -8, 8 ) ) = 1
		[IntRange] _RingsSinMinValue( "Rings Sin Min", Range( 1, 20 ) ) = 1
		[IntRange] _RingsSinMaxValue( "Rings Sin Max", Range( 1, 20 ) ) = 2
		[Space(10)] _DropsSpeedValue( "Drops Speed", Range( 0, 4 ) ) = 1
		_DropsNormalValue( "Drops Normal", Range( -8, 8 ) ) = 1
		[IntRange] _DropsSinMinValue( "Drops Sin Min", Range( 1, 20 ) ) = 2
		[IntRange] _DropsSinMaxValue( "Drops Sin Max", Range( 1, 20 ) ) = 1
		[IntRange] _DropsTillingValue( "Drops Tilling", Range( 1, 10 ) ) = 6
		[Space(10)][StyledTextureSingleLine] _DropsMaskTex( "Drops Mask", 2D ) = "white" {}
		[Space(10)] _DropsMaskIntensityValue( "Drops Mask Intensity", Range( 0, 1 ) ) = 1
		_DropsMaskSpeedValue( "Drops Mask Speed", Range( 0, 2 ) ) = 1
		[IntRange] _DropsMaskTillingValue( "Drops Mask Tilling", Range( 1, 10 ) ) = 1
		[StyledRemapSlider] _DropsMaskRemap( "Drops Mask Remap", Vector ) = ( 0, 0, 0, 0 )
		[Space(10)][StyledTextureSingleLine] _WaterTex( "Water Texture", 2D ) = "white" {}
		[Space(10)] _WaterRipplesIntensityValue( "Water Ripples Intensity", Range( 0, 1 ) ) = 1
		[IntRange] _WaterRipplesTillingValue( "Water Ripples Tilling", Range( 0, 20 ) ) = 20
		_WaterRipplesSpeedValue( "Water Ripples Speed", Range( 0, 4 ) ) = 1
		[Space(10)] _WaterMotionIntensityValue( "Water Motion Intensity", Range( 0, 1 ) ) = 1
		[IntRange] _WaterMotionTillingValue( "Water Motion Tilling", Range( 1, 20 ) ) = 2
		_WaterMotionSpeedValue( "Water Motion Speed", Range( 0, 4 ) ) = 1

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
			UNITY_DECLARE_TEX2D_NOSAMPLER(_DropsTex);
			SamplerState sampler_DropsTex;
			uniform half4 TVE_TimeParams;
			uniform half _RingsSpeedValue;
			uniform half _RingsSinMinValue;
			uniform half _RingsSinMaxValue;
			uniform half _RingsNormalValue;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_WaterTex);
			uniform half _WaterRipplesTillingValue;
			uniform half _WaterRipplesSpeedValue;
			SamplerState sampler_Linear_Repeat;
			uniform float _WaterRipplesIntensityValue;
			uniform half _WaterMotionTillingValue;
			uniform half4 TVE_WindParams;
			uniform half TVE_IsEnabled;
			uniform half _WaterMotionSpeedValue;
			uniform half4 TVE_WIndEditor;
			uniform float _WaterMotionIntensityValue;
			uniform half _DropsTillingValue;
			uniform half _DropsSpeedValue;
			uniform half _DropsSinMinValue;
			uniform half _DropsSinMaxValue;
			uniform half _DropsNormalValue;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_DropsMaskTex);
			uniform half _DropsMaskTillingValue;
			uniform half _DropsMaskSpeedValue;
			SamplerState sampler_DropsMaskTex;
			uniform half4 _DropsMaskRemap;
			uniform half _DropsMaskIntensityValue;


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

				half2 Rings_CoordA184 = IN.localTexcoord.xy;
				float4 tex2DNode57_g77258 = SAMPLE_TEXTURE2D( _DropsTex, sampler_DropsTex, Rings_CoordA184 );
				float temp_output_66_0_g77258 = (tex2DNode57_g77258).b;
				half Rain_RippleHeight68_g77258 = temp_output_66_0_g77258;
				half Rain_RippleVariation59_g77258 = (tex2DNode57_g77258).a;
				float lerpResult128_g77252 = lerp( _Time.y , ( ( _Time.y * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				float temp_output_171_0 = ( lerpResult128_g77252 * _RingsSpeedValue );
				half Rings_SpeedA190 = temp_output_171_0;
				half Rain_RippleFrac67_g77258 = frac( ( Rain_RippleVariation59_g77258 + Rings_SpeedA190 ) );
				half Rain_TimeFrac74_g77258 = ( ( Rain_RippleFrac67_g77258 - 1.0 ) + Rain_RippleHeight68_g77258 );
				float clampResult79_g77258 = clamp( ( Rain_TimeFrac74_g77258 * _RingsSinMinValue ) , 0.0 , _RingsSinMaxValue );
				half Rain_RingsFactor88_g77258 = ( ( Rain_RippleHeight68_g77258 * Rain_RippleHeight68_g77258 * Rain_RippleHeight68_g77258 ) * sin( ( clampResult79_g77258 * UNITY_PI ) ) );
				float2 temp_output_85_0_g77258 = (tex2DNode57_g77258).rg;
				half2 Rain_RippleNormal87_g77258 = temp_output_85_0_g77258;
				half2 Wetness_Normal102_g77258 = ( Rain_RingsFactor88_g77258 * ( (Rain_RippleNormal87_g77258*2.0 + -1.0) * _RingsNormalValue ) );
				half2 Rings_CoordB186 = ( IN.localTexcoord.xy + float2( 0.6,0.6 ) );
				float4 tex2DNode57_g77260 = SAMPLE_TEXTURE2D( _DropsTex, sampler_DropsTex, Rings_CoordB186 );
				float temp_output_66_0_g77260 = (tex2DNode57_g77260).b;
				half Rain_RippleHeight68_g77260 = temp_output_66_0_g77260;
				half Rain_RippleVariation59_g77260 = (tex2DNode57_g77260).a;
				half Rings_SpeedB251 = ( temp_output_171_0 + 0.4567 );
				half Rain_RippleFrac67_g77260 = frac( ( Rain_RippleVariation59_g77260 + Rings_SpeedB251 ) );
				half Rain_TimeFrac74_g77260 = ( ( Rain_RippleFrac67_g77260 - 1.0 ) + Rain_RippleHeight68_g77260 );
				float clampResult79_g77260 = clamp( ( Rain_TimeFrac74_g77260 * _RingsSinMinValue ) , 0.0 , _RingsSinMaxValue );
				half Rain_RingsFactor88_g77260 = ( ( Rain_RippleHeight68_g77260 * Rain_RippleHeight68_g77260 * Rain_RippleHeight68_g77260 ) * sin( ( clampResult79_g77260 * UNITY_PI ) ) );
				float2 temp_output_85_0_g77260 = (tex2DNode57_g77260).rg;
				half2 Rain_RippleNormal87_g77260 = temp_output_85_0_g77260;
				half2 Wetness_Normal102_g77260 = ( Rain_RingsFactor88_g77260 * ( (Rain_RippleNormal87_g77260*2.0 + -1.0) * _RingsNormalValue ) );
				float2 Input_Coords80_g77247 = ( IN.localTexcoord.xy * _WaterRipplesTillingValue );
				half2 Rings_Dir343 = ( (temp_output_85_0_g77258*2.0 + -1.0) + (temp_output_85_0_g77260*2.0 + -1.0) );
				half2 Input_Direction82_g77247 = -Rings_Dir343;
				float mulTime113_g77245 = _Time.y * _WaterRipplesSpeedValue;
				float lerpResult128_g77245 = lerp( mulTime113_g77245 , ( ( mulTime113_g77245 * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				float Input_Time88_g77247 = lerpResult128_g77245;
				float temp_output_23_0_g77247 = frac( Input_Time88_g77247 );
				float4 lerpResult39_g77247 = lerp( SAMPLE_TEXTURE2D( _WaterTex, sampler_Linear_Repeat, ( Input_Coords80_g77247 + ( Input_Direction82_g77247 * temp_output_23_0_g77247 ) ) ) , SAMPLE_TEXTURE2D( _WaterTex, sampler_Linear_Repeat, ( Input_Coords80_g77247 + ( Input_Direction82_g77247 * ( temp_output_23_0_g77247 - 1.0 ) ) ) ) , temp_output_23_0_g77247);
				float2 temp_output_423_0 = ( ((lerpResult39_g77247).ag*2.0 + -1.0) * _WaterRipplesIntensityValue );
				float2 Input_Coords80_g77233 = ( IN.localTexcoord.xy * _WaterMotionTillingValue );
				float4 lerpResult130_g77120 = lerp( half4( 0, 1, 1, 0 ) , TVE_WindParams , TVE_IsEnabled);
				half2 Wind_DirWS311 = -((lerpResult130_g77120).xy*2.0 + -1.0);
				half2 Input_Direction82_g77233 = Wind_DirWS311;
				float mulTime113_g77232 = _Time.y * _WaterMotionSpeedValue;
				float lerpResult128_g77232 = lerp( mulTime113_g77232 , ( ( mulTime113_g77232 * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				float Input_Time88_g77233 = lerpResult128_g77232;
				float temp_output_23_0_g77233 = frac( Input_Time88_g77233 );
				float4 lerpResult39_g77233 = lerp( SAMPLE_TEXTURE2D( _WaterTex, sampler_Linear_Repeat, ( Input_Coords80_g77233 + ( Input_Direction82_g77233 * temp_output_23_0_g77233 ) ) ) , SAMPLE_TEXTURE2D( _WaterTex, sampler_Linear_Repeat, ( Input_Coords80_g77233 + ( Input_Direction82_g77233 * ( temp_output_23_0_g77233 - 1.0 ) ) ) ) , temp_output_23_0_g77233);
				float2 Input_Coords80_g77237 = IN.localTexcoord.xy;
				half2 Input_Direction82_g77237 = Wind_DirWS311;
				float mulTime113_g77231 = _Time.y * _WaterMotionSpeedValue;
				float lerpResult128_g77231 = lerp( mulTime113_g77231 , ( ( mulTime113_g77231 * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				float Input_Time88_g77237 = ( lerpResult128_g77231 * 0.2 );
				float temp_output_23_0_g77237 = frac( Input_Time88_g77237 );
				float4 lerpResult39_g77237 = lerp( SAMPLE_TEXTURE2D( _WaterTex, sampler_Linear_Repeat, ( Input_Coords80_g77237 + ( Input_Direction82_g77237 * temp_output_23_0_g77237 ) ) ) , SAMPLE_TEXTURE2D( _WaterTex, sampler_Linear_Repeat, ( Input_Coords80_g77237 + ( Input_Direction82_g77237 * ( temp_output_23_0_g77237 - 1.0 ) ) ) ) , temp_output_23_0_g77237);
				float temp_output_136_0_g77120 = (lerpResult130_g77120).z;
				float lerpResult149_g77120 = lerp( temp_output_136_0_g77120 , saturate( (temp_output_136_0_g77120*TVE_WIndEditor.x + TVE_WIndEditor.y) ) , TVE_WIndEditor.w);
				half WInd_Value310 = lerpResult149_g77120;
				float lerpResult432 = lerp( 0.2 , 1.0 , WInd_Value310);
				float2 temp_output_353_0 = ( max( ((lerpResult39_g77233).ag*2.0 + -1.0), ((lerpResult39_g77237).ag*2.0 + -1.0) ) * lerpResult432 * _WaterMotionIntensityValue );
				half2 WindNoise320 = ( temp_output_423_0 + temp_output_353_0 );
				half2 Rings_Final180 = (( Wetness_Normal102_g77258 + Wetness_Normal102_g77260 + WindNoise320 )*0.5 + 0.5);
				float2 temp_output_201_0 = ( IN.localTexcoord.xy * _DropsTillingValue );
				half2 Drops_CoordA248 = temp_output_201_0;
				float4 tex2DNode57_g77254 = SAMPLE_TEXTURE2D( _DropsTex, sampler_DropsTex, Drops_CoordA248 );
				float temp_output_66_0_g77254 = (tex2DNode57_g77254).b;
				half Rain_RippleHeight68_g77254 = temp_output_66_0_g77254;
				half Rain_RippleVariation59_g77254 = (tex2DNode57_g77254).a;
				float lerpResult128_g77251 = lerp( _Time.y , ( ( _Time.y * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				float temp_output_203_0 = ( lerpResult128_g77251 * _DropsSpeedValue );
				half Drops_SpeedA246 = temp_output_203_0;
				half Rain_RippleFrac67_g77254 = frac( ( Rain_RippleVariation59_g77254 + Drops_SpeedA246 ) );
				half Rain_TimeFrac74_g77254 = ( ( Rain_RippleFrac67_g77254 - 1.0 ) + Rain_RippleHeight68_g77254 );
				float clampResult79_g77254 = clamp( ( Rain_TimeFrac74_g77254 * _DropsSinMinValue ) , 0.0 , _DropsSinMaxValue );
				half Rain_RingsFactor88_g77254 = ( ( Rain_RippleHeight68_g77254 * Rain_RippleHeight68_g77254 * Rain_RippleHeight68_g77254 ) * sin( ( clampResult79_g77254 * UNITY_PI ) ) );
				float2 temp_output_85_0_g77254 = (tex2DNode57_g77254).rg;
				half2 Rain_RippleNormal87_g77254 = temp_output_85_0_g77254;
				half2 Wetness_Normal102_g77254 = ( Rain_RingsFactor88_g77254 * ( (Rain_RippleNormal87_g77254*2.0 + -1.0) * _DropsNormalValue ) );
				half2 Drops_CoordB249 = ( temp_output_201_0 + float2( 0.6,0.6 ) );
				float4 tex2DNode57_g77256 = SAMPLE_TEXTURE2D( _DropsTex, sampler_DropsTex, Drops_CoordB249 );
				float temp_output_66_0_g77256 = (tex2DNode57_g77256).b;
				half Rain_RippleHeight68_g77256 = temp_output_66_0_g77256;
				half Rain_RippleVariation59_g77256 = (tex2DNode57_g77256).a;
				half Drops_SpeedB254 = ( temp_output_203_0 + 0.2 );
				half Rain_RippleFrac67_g77256 = frac( ( Rain_RippleVariation59_g77256 + Drops_SpeedB254 ) );
				half Rain_TimeFrac74_g77256 = ( ( Rain_RippleFrac67_g77256 - 1.0 ) + Rain_RippleHeight68_g77256 );
				float clampResult79_g77256 = clamp( ( Rain_TimeFrac74_g77256 * _DropsSinMinValue ) , 0.0 , _DropsSinMaxValue );
				half Rain_RingsFactor88_g77256 = ( ( Rain_RippleHeight68_g77256 * Rain_RippleHeight68_g77256 * Rain_RippleHeight68_g77256 ) * sin( ( clampResult79_g77256 * UNITY_PI ) ) );
				float2 temp_output_85_0_g77256 = (tex2DNode57_g77256).rg;
				half2 Rain_RippleNormal87_g77256 = temp_output_85_0_g77256;
				half2 Wetness_Normal102_g77256 = ( Rain_RingsFactor88_g77256 * ( (Rain_RippleNormal87_g77256*2.0 + -1.0) * _DropsNormalValue ) );
				float lerpResult128_g77246 = lerp( _Time.y , ( ( _Time.y * TVE_TimeParams.x ) + TVE_TimeParams.y ) , TVE_TimeParams.w);
				float temp_output_7_0_g77253 = _DropsMaskRemap.x;
				float temp_output_9_0_g77253 = ( SAMPLE_TEXTURE2D( _DropsMaskTex, sampler_DropsMaskTex, ( ( IN.localTexcoord.xy * _DropsMaskTillingValue ) + ( lerpResult128_g77246 * _DropsMaskSpeedValue ) ) ).r - temp_output_7_0_g77253 );
				float lerpResult261 = lerp( 1.0 , saturate( ( temp_output_9_0_g77253 / ( ( _DropsMaskRemap.y - temp_output_7_0_g77253 ) + 0.0001 ) ) ) , _DropsMaskIntensityValue);
				half Drops_Mask270 = lerpResult261;
				half2 Drops_Final205 = (( ( Wetness_Normal102_g77254 + Wetness_Normal102_g77256 ) * Drops_Mask270 )*0.5 + 0.5);
				float4 appendResult139 = (float4(Rings_Final180 , Drops_Final205));
				

                float4 finalColor = appendResult139;

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
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":469,"pos":[-1792,5504],"params":["Inherit","False","Get Global Wind","0","","77120","bedd4b0cdedc6ee42aedeb9811b5fcae","0","0","2","FLOAT2","144","FLOAT","146"]}
{"type":"AmplifyShaderEditor.NegateNode, AmplifyShaderEditor","id":437,"pos":[-1536,5504],"params":["Inherit","False","1","0","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":463,"pos":[640,2304],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.TexturePropertyNode, AmplifyShaderEditor","id":296,"pos":[-1152,4992],"params":["Inherit","True","Property","_WaterTex","Water Texture","20","0","Create","False","0","0","0","False","2","Space(10)","StyledTextureSingleLine","False","","None","1dbdaff51ef624d4cabbecfcea3e75ca","True","white","Auto","Texture2D","False","-1","0","2","SAMPLER2D","0","SAMPLERSTATE","1"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":311,"pos":[-1392,5504],"params":["Half","False","Wind_DirWS","-1","True","1","0","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":335,"pos":[-512,6592],"params":["Half","False","Property","_WaterMotionSpeedValue","Water Motion Speed","29","0","Create","False","0","0","0","False","0","False","Object","-1","","1","1","0","4","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor","id":325,"pos":[-512,6336],"params":["Inherit","False","0","2","0","5","FLOAT2","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":326,"pos":[-512,6448],"params":["Half","False","Property","_WaterMotionTillingValue","Water Motion Tilling","28","1","[IntRange]","Create","False","0","0","0","False","0","False","Object","-1","","2","8","1","20","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":343,"pos":[1024,2304],"params":["Half","False","Rings_Dir","-1","True","1","0","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":507,"pos":[-160,7104],"params":["Inherit","False","Get Global Time","-1","","77231","2b2f842f8071fb945821b595284b5848","1,132,0","1","129","FLOAT","1","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor","id":438,"pos":[-512,6848],"params":["Inherit","False","0","2","0","5","FLOAT2","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":436,"pos":[-512,6272],"params":["Inherit","False","434","MotionTex","1","0","OBJECT","","False","1","SAMPLER2D","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":327,"pos":[-128,6336],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT","0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":441,"pos":[-512,6784],"params":["Inherit","False","434","MotionTex","1","0","OBJECT","","False","1","SAMPLER2D","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":446,"pos":[32,7104],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT","0.2","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":443,"pos":[-512,7040],"params":["Inherit","False","311","Wind_DirWS","1","0","OBJECT","","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":312,"pos":[-512,6528],"params":["Inherit","False","311","Wind_DirWS","1","0","OBJECT","","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor","id":299,"pos":[-512,5056],"params":["Inherit","False","0","2","0","5","FLOAT2","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":334,"pos":[-512,5376],"params":["Half","False","Property","_WaterRipplesSpeedValue","Water Ripples Speed","25","0","Create","False","0","0","0","False","0","False","Object","-1","","1","1","0","4","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":300,"pos":[-512,5168],"params":["Half","False","Property","_WaterRipplesTillingValue","Water Ripples Tilling","24","1","[IntRange]","Create","False","0","0","0","False","0","False","Object","-1","","20","20","0","20","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":346,"pos":[-512,5248],"params":["Inherit","False","343","Rings_Dir","1","0","OBJECT","","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":434,"pos":[-896,4992],"params":["Half","False","MotionTex","-1","True","1","0","SAMPLER2D","","False","1","SAMPLER2D","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":508,"pos":[-104.1904,6699.439],"params":["Inherit","False","Get Global Time","-1","","77232","2b2f842f8071fb945821b595284b5848","1,132,0","1","129","FLOAT","1","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":324,"pos":[128,6272],"params":["Inherit","False","Compute Flow Map","-1","","77233","47b4a92df17039e4d8b606acbee2f25e","1,66,0","5","20","SAMPLER2D","0,0","False","3","FLOAT2","0,0","False","21","FLOAT2","0,0","False","15","FLOAT","0.5","False","68","FLOAT","0.5","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":445,"pos":[128,6784],"params":["Inherit","False","Compute Flow Map","-1","","77237","47b4a92df17039e4d8b606acbee2f25e","1,66,0","5","20","SAMPLER2D","0,0","False","3","FLOAT2","0,0","False","21","FLOAT2","0,0","False","15","FLOAT","0.5","False","68","FLOAT","0.5","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":301,"pos":[-128,5056],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT","0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.NegateNode, AmplifyShaderEditor","id":347,"pos":[-128,5248],"params":["Inherit","False","1","0","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":435,"pos":[-512,4992],"params":["Inherit","False","434","MotionTex","1","0","OBJECT","","False","1","SAMPLER2D","0"]}
{"type":"AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor","id":235,"pos":[-512,3968],"params":["Inherit","False","0","2","0","5","FLOAT2","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":238,"pos":[-512,4096],"params":["Half","False","Property","_DropsMaskTillingValue","Drops Mask Tilling","18","1","[IntRange]","Create","False","0","0","0","False","0","False","Object","-1","","1","1","1","10","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":241,"pos":[-512,4288],"params":["Half","False","Property","_DropsMaskSpeedValue","Drops Mask Speed","17","0","Create","False","0","0","0","False","0","False","Object","-1","","1","0.03","0","2","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":517,"pos":[-160,5376],"params":["Inherit","False","Get Global Time","-1","","77245","2b2f842f8071fb945821b595284b5848","1,132,0","1","129","FLOAT","1","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":509,"pos":[-512,4224],"params":["Inherit","False","Get Global Time","-1","","77246","2b2f842f8071fb945821b595284b5848","1,132,0","1","129","FLOAT","1","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":310,"pos":[-1392,5568],"params":["Half","False","WInd_Value","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":329,"pos":[384,6272],"params":["Inherit","False","FLOAT2","3","1","2","3","1","0","COLOR","0,0,0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":447,"pos":[384,6784],"params":["Inherit","False","FLOAT2","3","1","2","3","1","0","COLOR","0,0,0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":243,"pos":[-192,3968],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT","0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":242,"pos":[-192,4224],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":298,"pos":[128,4992],"params":["Inherit","False","Compute Flow Map","-1","","77247","47b4a92df17039e4d8b606acbee2f25e","1,66,0","5","20","SAMPLER2D","0,0","False","3","FLOAT2","0,0","False","21","FLOAT2","0,0","False","15","FLOAT","0.5","False","68","FLOAT","0.5","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor","id":330,"pos":[640,6272],"params":["Inherit","False","3","0","FLOAT2","0,0","False","1","FLOAT","2","False","2","FLOAT","-1","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor","id":449,"pos":[640,6784],"params":["Inherit","False","3","0","FLOAT2","0,0","False","1","FLOAT","2","False","2","FLOAT","-1","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":318,"pos":[1024,6528],"params":["Inherit","False","310","WInd_Value","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":315,"pos":[384,4992],"params":["Inherit","False","FLOAT2","3","1","2","3","1","0","COLOR","0,0,0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":245,"pos":[0,3968],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT","0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor","id":199,"pos":[-512,768],"params":["Inherit","False","0","2","0","5","FLOAT2","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":162,"pos":[-512,896],"params":["Half","False","Property","_DropsTillingValue","Drops Tilling","14","1","[IntRange]","Create","False","0","0","0","False","0","False","Object","-1","","6","6","1","10","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":161,"pos":[-512,1216],"params":["Half","False","Property","_DropsSpeedValue","Drops Speed","10","0","Create","False","0","0","0","False","1","Space(10)","False","Object","-1","","1","3","0","4","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":510,"pos":[-512,1152],"params":["Inherit","False","Get Global Time","-1","","77251","2b2f842f8071fb945821b595284b5848","1,132,0","1","129","FLOAT","1","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":169,"pos":[-512,448],"params":["Half","False","Property","_RingsSpeedValue","Rings Speed","6","0","Create","False","0","0","0","False","1","Space(10)","False","Object","-1","","1","1.5","0","4","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleMaxOpNode, AmplifyShaderEditor","id":467,"pos":[896,6272],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":432,"pos":[1264,6528],"params":["Inherit","False","3","0","FLOAT","0.2","False","1","FLOAT","1","False","2","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":317,"pos":[1152,6720],"params":["Inherit","False","Property","_WaterMotionIntensityValue","Water Motion Intensity","27","0","Create","False","0","0","0","False","1","Space(10)","False","Object","-1","","1","0.2","0","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor","id":314,"pos":[576,4992],"params":["Inherit","False","3","0","FLOAT2","0,0","False","1","FLOAT","2","False","2","FLOAT","-1","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":424,"pos":[576,5120],"params":["Inherit","False","Property","_WaterRipplesIntensityValue","Water Ripples Intensity","21","0","Create","False","0","0","0","False","1","Space(10)","False","Object","-1","","1","0.1","0","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.Vector4Node, AmplifyShaderEditor","id":266,"pos":[256,4224],"params":["Half","False","Property","_DropsMaskRemap","Drops Mask Remap","19","0","Create","False","0","0","0","False","1","StyledRemapSlider","False","Object","-1","","0,0,0,0","0,0.25,0,0","0","5","FLOAT4","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor","id":234,"pos":[256,3968],"params":["Inherit","True","Property","_DropsMaskTex","Drops Mask","15","0","Create","False","0","0","0","False","2","Space(10)","StyledTextureSingleLine","False","","-1","None","13cbbb9d5b1a07749b1fa6918940dfe3","True","0","False","white","Auto","False","Object","-1","Auto","Texture2D","False","8","0","SAMPLER2D","","False","1","FLOAT2","0,0","False","2","FLOAT","0","False","3","FLOAT2","0,0","False","4","FLOAT2","0,0","False","5","FLOAT","1","False","6","FLOAT","0","False","7","SAMPLERSTATE","","False","6","COLOR","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4","FLOAT3","5"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":203,"pos":[-192,1152],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":201,"pos":[-192,768],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT","0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":252,"pos":[128,896],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT2","0.6,0.6","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":253,"pos":[128,1280],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT","0.2","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":511,"pos":[-512,384],"params":["Inherit","False","Get Global Time","-1","","77252","2b2f842f8071fb945821b595284b5848","1,132,0","1","129","FLOAT","1","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":171,"pos":[-192,384],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor","id":106,"pos":[-512,128],"params":["Inherit","False","0","2","0","5","FLOAT2","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":187,"pos":[128,256],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT2","0.6,0.6","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":250,"pos":[128,512],"params":["Inherit","False","2","2","0","FLOAT","0","False","1","FLOAT","0.4567","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TexturePropertyNode, AmplifyShaderEditor","id":104,"pos":[-512,-128],"params":["Inherit","True","Property","_DropsTex","Drops Texture","5","1","[NoScaleOffset]","Create","False","0","0","0","False","1","StyledTextureSingleLine","False","","None","226a76398d819eb40b921c0023fa0af2","False","white","Auto","Texture2D","False","-1","0","2","SAMPLER2D","0","SAMPLERSTATE","1"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":353,"pos":[1616,6272],"params":["Inherit","False","3","3","0","FLOAT2","0,0","False","1","FLOAT","0","False","2","FLOAT","0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":423,"pos":[896,4992],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT","0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":268,"pos":[640,3968],"params":["Inherit","False","Math Remap","-1","","77253","5eda8a2bb94ebef4ab0e43d19291cd8b","3,18,0,21,1,14,0","4","6","FLOAT","0","False","7","FLOAT","0","False","8","FLOAT","0","False","19","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":262,"pos":[256,4416],"params":["Half","False","Property","_DropsMaskIntensityValue","Drops Mask Intensity","16","0","Create","False","0","0","0","False","1","Space(10)","False","Object","-1","","1","1","0","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":246,"pos":[320,1152],"params":["Half","False","Drops_SpeedA","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":248,"pos":[320,768],"params":["Half","False","Drops_CoordA","-1","True","1","0","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":254,"pos":[320,1280],"params":["Half","False","Drops_SpeedB","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":249,"pos":[320,896],"params":["Half","False","Drops_CoordB","-1","True","1","0","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":163,"pos":[320,-128],"params":["Half","False","DropsTex","-1","True","1","0","SAMPLER2D","","False","1","SAMPLER2D","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":190,"pos":[320,384],"params":["Half","False","Rings_SpeedA","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":184,"pos":[320,128],"params":["Half","False","Rings_CoordA","-1","True","1","0","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":186,"pos":[320,256],"params":["Half","False","Rings_CoordB","-1","True","1","0","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":251,"pos":[320,512],"params":["Half","False","Rings_SpeedB","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":332,"pos":[1232,5248],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.LerpOp, AmplifyShaderEditor","id":261,"pos":[896,3968],"params":["Inherit","False","3","0","FLOAT","1","False","1","FLOAT","0","False","2","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":158,"pos":[-512,3584],"params":["Half","False","Property","_DropsSinMinValue","Drops Sin Min","12","1","[IntRange]","Create","False","0","0","0","False","0","False","Object","-1","","2","3","1","20","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":159,"pos":[-512,3648],"params":["Half","False","Property","_DropsSinMaxValue","Drops Sin Max","13","1","[IntRange]","Create","False","0","0","0","False","0","False","Object","-1","","1","1","1","20","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":198,"pos":[-512,2944],"params":["Inherit","False","163","DropsTex","1","0","OBJECT","","False","1","SAMPLER2D","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":247,"pos":[-512,3072],"params":["Inherit","False","246","Drops_SpeedA","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":160,"pos":[-512,3712],"params":["Half","False","Property","_DropsNormalValue","Drops Normal","11","0","Create","False","0","0","0","False","0","False","Object","-1","","1","1","-8","8","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":255,"pos":[-512,3008],"params":["Inherit","False","248","Drops_CoordA","1","0","OBJECT","","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":257,"pos":[-512,3200],"params":["Inherit","False","163","DropsTex","1","0","OBJECT","","False","1","SAMPLER2D","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":258,"pos":[-512,3264],"params":["Inherit","False","249","Drops_CoordB","1","0","OBJECT","","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":259,"pos":[-512,3328],"params":["Inherit","False","254","Drops_SpeedB","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":168,"pos":[-512,2624],"params":["Half","False","Property","_RingsSinMaxValue","Rings Sin Max","9","1","[IntRange]","Create","False","0","0","0","False","0","False","Object","-1","","2","2","1","20","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":179,"pos":[-512,2688],"params":["Half","False","Property","_RingsNormalValue","Rings Normal","7","0","Create","False","0","0","0","False","0","False","Object","-1","","1","0.5","-8","8","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":188,"pos":[-512,2112],"params":["Inherit","False","184","Rings_CoordA","1","0","OBJECT","","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":164,"pos":[-512,2048],"params":["Inherit","False","163","DropsTex","1","0","OBJECT","","False","1","SAMPLER2D","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":192,"pos":[-512,2176],"params":["Inherit","False","190","Rings_SpeedA","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":167,"pos":[-512,2560],"params":["Half","False","Property","_RingsSinMinValue","Rings Sin Min","8","1","[IntRange]","Create","False","0","0","0","False","0","False","Object","-1","","1","10","1","20","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":193,"pos":[-512,2432],"params":["Inherit","False","251","Rings_SpeedB","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":195,"pos":[-512,2368],"params":["Inherit","False","186","Rings_CoordB","1","0","OBJECT","","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":191,"pos":[-512,2304],"params":["Inherit","False","163","DropsTex","1","0","OBJECT","","False","1","SAMPLER2D","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":320,"pos":[1504,5296],"params":["Half","False","WindNoise","-1","True","1","0","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":270,"pos":[1152,3968],"params":["Half","False","Drops_Mask","-1","True","1","0","FLOAT","0","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":512,"pos":[256,2944],"params":["Inherit","False","Compute Rain Drops","-1","","77254","ab995bbff019b914ea1ee54bf23794b6","0","7","113","SAMPLER2D","0","False","114","FLOAT2","0,0","False","121","FLOAT","0","False","132","FLOAT","0","False","123","FLOAT","0","False","124","FLOAT","0","False","125","FLOAT","0","False","3","FLOAT2","0","FLOAT2","133","FLOAT","134"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":513,"pos":[256,3200],"params":["Inherit","False","Compute Rain Drops","-1","","77256","ab995bbff019b914ea1ee54bf23794b6","0","7","113","SAMPLER2D","0","False","114","FLOAT2","0,0","False","121","FLOAT","0","False","132","FLOAT","0","False","123","FLOAT","0","False","124","FLOAT","0","False","125","FLOAT","0","False","3","FLOAT2","0","FLOAT2","133","FLOAT","134"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":271,"pos":[576,3072],"params":["Inherit","False","270","Drops_Mask","1","0","OBJECT","","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":321,"pos":[256,2560],"params":["Inherit","False","320","WindNoise","1","0","OBJECT","","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":473,"pos":[576,2944],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":514,"pos":[256,2048],"params":["Inherit","False","Compute Rain Drops","-1","","77258","ab995bbff019b914ea1ee54bf23794b6","0","7","113","SAMPLER2D","0","False","114","FLOAT2","0,0","False","121","FLOAT","0","False","132","FLOAT","0","False","123","FLOAT","0","False","124","FLOAT","0","False","125","FLOAT","0","False","3","FLOAT2","0","FLOAT2","133","FLOAT","134"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":515,"pos":[256,2304],"params":["Inherit","False","Compute Rain Drops","-1","","77260","ab995bbff019b914ea1ee54bf23794b6","0","7","113","SAMPLER2D","0","False","114","FLOAT2","0,0","False","121","FLOAT","0","False","132","FLOAT","0","False","123","FLOAT","0","False","124","FLOAT","0","False","125","FLOAT","0","False","3","FLOAT2","0","FLOAT2","133","FLOAT","134"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":233,"pos":[768,2944],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT","0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor","id":135,"pos":[640,2048],"params":["Inherit","False","3","3","0","FLOAT2","0,0","False","1","FLOAT2","0,0","False","2","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor","id":138,"pos":[1024,2048],"params":["Inherit","False","3","0","FLOAT2","0,0","False","1","FLOAT","0.5","False","2","FLOAT","0.5","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor","id":204,"pos":[1280,2944],"params":["Inherit","False","3","0","FLOAT2","0,0","False","1","FLOAT","0.5","False","2","FLOAT","0.5","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":180,"pos":[1344,2048],"params":["Half","False","Rings_Final","-1","True","1","0","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":205,"pos":[1600,2944],"params":["Half","False","Drops_Final","-1","True","1","0","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":196,"pos":[2304,2048],"params":["Inherit","False","180","Rings_Final","1","0","OBJECT","","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":206,"pos":[2304,2112],"params":["Inherit","False","205","Drops_Final","1","0","OBJECT","","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":494,"pos":[-128,6592],"params":["Inherit","False","Get Global Motion Time","-1","","77262","da6e3b339ab8a0646b79248b6ff23cdd","1,132,0","1","129","FLOAT","1","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":470,"pos":[1792,6272],"params":["Half","False","Noise_Wind","-1","True","1","0","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":474,"pos":[1152,4992],"params":["Half","False","Noise_Rings","-1","True","1","0","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor","id":475,"pos":[-512,5696],"params":["Inherit","False","0","2","0","5","FLOAT2","0","FLOAT","1","FLOAT","2","FLOAT","3","FLOAT","4"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":487,"pos":[-512,5888],"params":["Inherit","False","-1","","1","0","OBJECT","","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor","id":476,"pos":[-512,5632],"params":["Inherit","False","434","MotionTex","1","0","OBJECT","","False","1","SAMPLER2D","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":477,"pos":[-128,5696],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT","0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.NegateNode, AmplifyShaderEditor","id":478,"pos":[-128,5888],"params":["Inherit","False","1","0","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.SwizzleNode, AmplifyShaderEditor","id":481,"pos":[384,5632],"params":["Inherit","False","FLOAT2","3","1","2","3","1","0","COLOR","0,0,0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor","id":482,"pos":[576,5632],"params":["Inherit","False","3","0","FLOAT2","0,0","False","1","FLOAT","2","False","2","FLOAT","-1","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":493,"pos":[585.8488,5829.448],"params":["Inherit","False","Constant","_Float1","Float 1","26","0","Create","True","0","0","0","False","0","False","Object","-1","","0.5","0.5","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":483,"pos":[896,5632],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT","0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor","id":491,"pos":[1152,5632],"params":["Half","False","Noise_Drops","-1","True","1","0","FLOAT2","0,0","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":108,"pos":[-512,-256],"params":["Inherit","False","Property","_BANNER","[ BANNER ]","4","0","Create","True","0","0","0","True","1","StyledBanner(CustomRT Drops)","False","Object","-1","","0","0","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor","id":139,"pos":[2560,2048],"params":["Inherit","False","FLOAT4","4","0","FLOAT2","0,0","False","1","FLOAT","0","False","2","FLOAT2","0,0","False","3","FLOAT","0","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":272,"pos":[2816,1920],"params":["Inherit","False","Base Compile","-1","","77263","e67c8238031dbf04ab79a5d4d63d1b4f","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor","id":442,"pos":[-128,6848],"params":["Inherit","False","2","2","0","FLOAT2","0,0","False","1","FLOAT2","1,1","False","1","FLOAT2","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":484,"pos":[-512,6016],"params":["Half","False","Property","_WaterRipplesSpeedValue1","Water Ripples Speed","26","0","Create","False","0","0","0","False","0","False","Object","-1","","0","6","0","4","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":485,"pos":[-512,5808],"params":["Half","False","Property","_WaterRipplesTillingValue1","Water Ripples Tilling","23","1","[IntRange]","Create","False","0","0","0","False","0","False","Object","-1","","20","6","0","20","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":486,"pos":[576,5760],"params":["Inherit","False","Property","_WaterRipplesIntensityValue1","Water Ripples Intensity","22","0","Create","False","0","0","0","False","1","Space(10)","False","Object","-1","","1","0","0","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":480,"pos":[128,5632],"params":["Inherit","False","Compute Flow Map","-1","","77264","47b4a92df17039e4d8b606acbee2f25e","1,66,0","5","20","SAMPLER2D","0,0","False","3","FLOAT2","0,0","False","21","FLOAT2","0,0","False","15","FLOAT","0.5","False","68","FLOAT","0.5","False","1","COLOR","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":516,"pos":[-160,6016],"params":["Inherit","False","Get Global Time","-1","","77268","2b2f842f8071fb945821b595284b5848","1,132,0","1","129","FLOAT","1","False","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":0,"pos":[2816,2048],"params":["Float","False","True","-1","2","TheVisualEngine.HelperGUI","0","16","BOXOPHOBIC/The Visual Engine/Effects/CustomRT Drops","32120270d1b3a8746af2aca8bc749736","True","Custom RT Update","0","0","Custom RT Update","1","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","0","True","2","False","0","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","2","False","0","","0","0","Standard","0","0","1","True","False","","True","0"]}
{"wire":[437,0,469,144]}
{"wire":[463,0,514,133]}
{"wire":[463,1,515,133]}
{"wire":[311,0,437,0]}
{"wire":[343,0,463,0]}
{"wire":[507,129,335,0]}
{"wire":[327,0,325,0]}
{"wire":[327,1,326,0]}
{"wire":[446,0,507,0]}
{"wire":[434,0,296,0]}
{"wire":[508,129,335,0]}
{"wire":[324,20,436,0]}
{"wire":[324,3,327,0]}
{"wire":[324,21,312,0]}
{"wire":[324,15,508,0]}
{"wire":[445,20,441,0]}
{"wire":[445,3,438,0]}
{"wire":[445,21,443,0]}
{"wire":[445,15,446,0]}
{"wire":[301,0,299,0]}
{"wire":[301,1,300,0]}
{"wire":[347,0,346,0]}
{"wire":[517,129,334,0]}
{"wire":[310,0,469,146]}
{"wire":[329,0,324,0]}
{"wire":[447,0,445,0]}
{"wire":[243,0,235,0]}
{"wire":[243,1,238,0]}
{"wire":[242,0,509,0]}
{"wire":[242,1,241,0]}
{"wire":[298,20,435,0]}
{"wire":[298,3,301,0]}
{"wire":[298,21,347,0]}
{"wire":[298,15,517,0]}
{"wire":[330,0,329,0]}
{"wire":[449,0,447,0]}
{"wire":[315,0,298,0]}
{"wire":[245,0,243,0]}
{"wire":[245,1,242,0]}
{"wire":[467,0,330,0]}
{"wire":[467,1,449,0]}
{"wire":[432,2,318,0]}
{"wire":[314,0,315,0]}
{"wire":[234,1,245,0]}
{"wire":[203,0,510,0]}
{"wire":[203,1,161,0]}
{"wire":[201,0,199,0]}
{"wire":[201,1,162,0]}
{"wire":[252,0,201,0]}
{"wire":[253,0,203,0]}
{"wire":[171,0,511,0]}
{"wire":[171,1,169,0]}
{"wire":[187,0,106,0]}
{"wire":[250,0,171,0]}
{"wire":[353,0,467,0]}
{"wire":[353,1,432,0]}
{"wire":[353,2,317,0]}
{"wire":[423,0,314,0]}
{"wire":[423,1,424,0]}
{"wire":[268,6,234,1]}
{"wire":[268,7,266,1]}
{"wire":[268,8,266,2]}
{"wire":[246,0,203,0]}
{"wire":[248,0,201,0]}
{"wire":[254,0,253,0]}
{"wire":[249,0,252,0]}
{"wire":[163,0,104,0]}
{"wire":[190,0,171,0]}
{"wire":[184,0,106,0]}
{"wire":[186,0,187,0]}
{"wire":[251,0,250,0]}
{"wire":[332,0,423,0]}
{"wire":[332,1,353,0]}
{"wire":[261,1,268,0]}
{"wire":[261,2,262,0]}
{"wire":[320,0,332,0]}
{"wire":[270,0,261,0]}
{"wire":[512,113,198,0]}
{"wire":[512,114,255,0]}
{"wire":[512,121,247,0]}
{"wire":[512,123,158,0]}
{"wire":[512,124,159,0]}
{"wire":[512,125,160,0]}
{"wire":[513,113,257,0]}
{"wire":[513,114,258,0]}
{"wire":[513,121,259,0]}
{"wire":[513,123,158,0]}
{"wire":[513,124,159,0]}
{"wire":[513,125,160,0]}
{"wire":[473,0,512,0]}
{"wire":[473,1,513,0]}
{"wire":[514,113,164,0]}
{"wire":[514,114,188,0]}
{"wire":[514,121,192,0]}
{"wire":[514,123,167,0]}
{"wire":[514,124,168,0]}
{"wire":[514,125,179,0]}
{"wire":[515,113,191,0]}
{"wire":[515,114,195,0]}
{"wire":[515,121,193,0]}
{"wire":[515,123,167,0]}
{"wire":[515,124,168,0]}
{"wire":[515,125,179,0]}
{"wire":[233,0,473,0]}
{"wire":[233,1,271,0]}
{"wire":[135,0,514,0]}
{"wire":[135,1,515,0]}
{"wire":[135,2,321,0]}
{"wire":[138,0,135,0]}
{"wire":[204,0,233,0]}
{"wire":[180,0,138,0]}
{"wire":[205,0,204,0]}
{"wire":[494,129,335,0]}
{"wire":[470,0,353,0]}
{"wire":[474,0,423,0]}
{"wire":[477,0,475,0]}
{"wire":[477,1,300,0]}
{"wire":[478,0,487,0]}
{"wire":[481,0,480,0]}
{"wire":[482,0,481,0]}
{"wire":[483,0,482,0]}
{"wire":[483,1,493,0]}
{"wire":[491,0,483,0]}
{"wire":[139,0,196,0]}
{"wire":[139,2,206,0]}
{"wire":[442,0,438,0]}
{"wire":[480,20,476,0]}
{"wire":[480,3,477,0]}
{"wire":[480,21,478,0]}
{"wire":[480,15,516,0]}
{"wire":[516,129,334,0]}
{"wire":[0,0,139,0]}
ASEEND*/
//CHKSM=09441B64CA812A0C7A6175D38725A6953674911B