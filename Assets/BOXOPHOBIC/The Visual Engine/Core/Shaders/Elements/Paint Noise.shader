// Upgrade NOTE: upgraded instancing buffer 'BOXOPHOBICTheVisualEngineElementsPaintNoise' to new syntax.

// Made with Amplify Shader Editor v1.9.9.12
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Visual Engine/Elements/Paint Noise"
{
	Properties
	{
		[StyledMessage(Info, Use Paint Noise elements to add two colors noise tinting to the vegetation assets. Element Texture A is used as alpha mask., 0, 15)] _ElementMessage( "Element Message", Float ) = 0
		[HideInInspector] _IsVersion( "_IsVersion", Float ) = 2200
		[HideInInspector] _IsElementShader( "_IsElementShader", Float ) = 1
		[HideInInspector] _IsIdentifier( "_IsIdentifier", Float ) = 0
		[StyledCategory(Render Settings, true, 0, 10)] _RenderCategory( "[ Render Category ]", Float ) = 1
		_ElementIntensity( "Render Intensity", Range( 0, 1 ) ) = 1
		[StyledMessage(Info, When using a higher Layer number the Global Volume will create more render textures to render the elements. Try using fewer layers when possible., _ElementLayerMessage, 1, 10, 10)] _ElementLayerMessage( "Render Layer Message", Float ) = 0
		[StyledMessage(Warning, When using all layers the Global Volume will create one render texture for each layer to render the elements. Try using fewer layers when possible., _ElementLayerWarning, 1, 10, 10)] _ElementLayerWarning( "Render Layer Warning", Float ) = 0
		[StyledMask(Paint Layers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)] _ElementLayerMask( "Render Layer", Float ) = 1
		[HideInInspector] _ElementParams( "Render Params", Vector ) = ( 1, 1, 1, 1 )
		[StyledSpace(10)] _RenderEnd( "[ Render End ]", Float ) = 0
		[StyledCategory(Element Settings, true, 0, 10)] _ElementCategory( "[ Element Category ]", Float ) = 1
		[NoScaleOffset][StyledTextureSingleLine] _MainTex( "Element Texture", 2D ) = "white" {}
		[StyledSpace(10)] _SpaceTexture( "#SpaceTexture", Float ) = 0
		[Enum(Main UV,0,Planar,1)] _ElementUVsMode( "Element Sampling", Float ) = 0
		[StyledVector(9)] _MainUVs( "Element UV Value", Vector ) = ( 1, 1, 0, 0 )
		[StyledRemapSlider] _MainTexAlphaRemap( "Element Alpha", Vector ) = ( 0, 1, 0, 0 )
		[StyledRemapSlider] _MainTexFalloffRemap( "Element Falloff", Vector ) = ( 0, 0, 0, 0 )
		[HDR][Gamma][Space(10)] _NoiseColorOne( "Noise Color A", Color ) = ( 0, 1, 0, 1 )
		[HDR][Gamma] _NoiseColorTwo( "Noise Color B", Color ) = ( 1, 0, 0, 1 )
		[StyledRemapSlider] _NoiseRemap( "Noise Remap", Vector ) = ( 0, 1, 0, 0 )
		_NoiseTillingValue( "Noise Tilling", Float ) = 1
		[Space(10)] _InfluenceValue1( "Season Winter Mask", Range( 0, 1 ) ) = 1
		_InfluenceValue2( "Season Spring Mask", Range( 0, 1 ) ) = 1
		_InfluenceValue3( "Season Summer Mask", Range( 0, 1 ) ) = 1
		_InfluenceValue4( "Season Autumn Mask", Range( 0, 1 ) ) = 1
		[Space(10)][StyledRemapSlider] _SeasonRemap( "Season Curve", Vector ) = ( 0, 1, 0, 0 )
		[Space(10)] _SpeedTresholdValue( "Particle Speed Treshold", Float ) = 10
		[StyledSpace(10)] _ElementEnd( "[ Element End ]", Float ) = 0
		[StyledCategory(Masking Settings, true, 0, 10)] _MaskingCategory( "[ Masking Category ]", Float ) = 1
		[StyledMessage(Info, When the Terrain Data object is assigned__ the ProjY and PosY features use the terrain height and normal textures for masking. Make sure to set the Terrain Mask dropdown to Auto., 0, 10)] _MaskingTerrainInfo( "Masking Terrain Info", Float ) = 0
		[StyledMessage(Info, When the Terrain Data object is not assigned__ the ProjY and PosY features use the element mesh world space height and normal for masking., 0, 10)] _MaskingModelInfo( "Masking Model Info", Float ) = 0
		[HideInInspector] _TerrainPosition( "Terrain Position", Vector ) = ( 0, 0, 0, 0 )
		[HideInInspector] _TerrainSize( "Terrain Size", Vector ) = ( 0, 0, 0, 0 )
		[HideInInspector] _TerrainInputMode( "Terrain Input", Float ) = 0
		[NoScaleOffset][StyledTextureSingleLine] _ElementMaskTex( "Element Mask", 2D ) = "white" {}
		[StyledTextureSingleLine] _TerrainHeightTex( "Element Height", 2D ) = "white" {}
		[StyledTextureSingleLine] _TerrainNormalTex( "Element Normal", 2D ) = "linearGrey" {}
		[Enum(Main UV,0,Planar,1)][Space(10)] _ElementMaskCoordMode( "Mask Sampling", Float ) = 0
		[StyledVector(9)] _ElementMaskCoordValue( "Mask UV Value", Vector ) = ( 1, 1, 0, 0 )
		_ElementMaskValue( "Element TexC Mask", Range( 0, 1 ) ) = 0
		[Enum(Mask R,0,Mask A,1)] _ElementMaskMode( "Element TexC Mask", Float ) = 0
		[StyledRemapSlider] _ElementMaskRemap( "Element TexC Mask", Vector ) = ( 0, 1, 0, 0 )
		_ElementProjValue( "Element ProjY Mask", Range( 0, 1 ) ) = 0
		[StyledRemapSlider] _ElementProjRemap( "Element ProjY Mask", Vector ) = ( 0, 1, 0, 0 )
		_ElementPosValue( "Element PosY Mask", Range( 0, 1 ) ) = 0
		_ElementPosMinValue( "Element PosY Start", Float ) = 0
		_ElementPosMaxValue( "Element PosY Limit", Float ) = 0
		[StyledSpace(10)] _MaskingEnd( "[ Masking End ]", Float ) = 0
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
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma multi_compile_local_fragment __ TVE_ELEMENT_MASK
			#pragma multi_compile_local_fragment __ TVE_ELEMENT_PROJ
			#pragma multi_compile_local_fragment __ TVE_ELEMENT_POS


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				half3 ase_normal : NORMAL;
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
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
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
			uniform half4 _NoiseColorOne;
			uniform half4 _NoiseColorTwo;
			uniform half _NoiseTillingValue;
			uniform half4 _NoiseRemap;
			uniform half _ElementIntensity;
			uniform sampler2D _MainTex;
			uniform half _ElementUVsMode;
			uniform half4 _MainUVs;
			uniform half _SpaceTexture;
			uniform half4 _MainTexAlphaRemap;
			uniform half4 _MainTexFalloffRemap;
			uniform half4 TVE_RenderBasePositionR;
			uniform half _ElementVolumeFadeValue;
			uniform half _ElementVolumeFadeMode;
			uniform half _BoundsCategory;
			uniform half _BoundsEnd;
			uniform sampler2D _ElementMaskTex;
			uniform half _ElementMaskCoordMode;
			uniform half4 _ElementMaskCoordValue;
			uniform half _ElementMaskMode;
			uniform half4 _ElementMaskRemap;
			uniform half _ElementMaskValue;
			uniform sampler2D _TerrainNormalTex;
			uniform half3 _TerrainPosition;
			uniform half3 _TerrainSize;
			uniform half _TerrainInputMode;
			uniform half4 _ElementProjRemap;
			uniform half _ElementProjValue;
			uniform sampler2D _TerrainHeightTex;
			float4 _TerrainHeightTex_TexelSize;
			uniform half _ElementPosMaxValue;
			uniform half _ElementPosMinValue;
			uniform half _ElementPosValue;
			uniform half _MaskingCategory;
			uniform half _MaskingEnd;
			uniform half _MaskingTerrainInfo;
			uniform half _MaskingModelInfo;
			uniform half _RaycastCategory;
			uniform half _RaycastEnd;
			uniform half _ElementRaycastMode;
			uniform half _RaycastLayerMask;
			uniform half _RaycastDistanceMinValue;
			uniform half _RaycastDistanceMaxValue;
			uniform half _RaycastDistanceCheckValue;
			uniform half4 TVE_SeasonOption;
			uniform half _InfluenceValue1;
			uniform half _InfluenceValue2;
			uniform half TVE_SeasonLerp;
			uniform half4 _SeasonRemap;
			uniform half _InfluenceValue3;
			uniform half _InfluenceValue4;
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsPaintNoise)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr BOXOPHOBICTheVisualEngineElementsPaintNoise
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsPaintNoise)
			inline float noise_randomValue (float2 uv) { return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453); }
			inline float noise_interpolate (float a, float b, float t) { return (1.0-t)*a + (t*b); }
			inline float valueNoise (float2 uv)
			{
				float2 i = floor(uv);
				float2 f = frac( uv );
				f = f* f * (3.0 - 2.0 * f);
				uv = abs( frac(uv) - 0.5);
				float2 c0 = i + float2( 0.0, 0.0 );
				float2 c1 = i + float2( 1.0, 0.0 );
				float2 c2 = i + float2( 0.0, 1.0 );
				float2 c3 = i + float2( 1.0, 1.0 );
				float r0 = noise_randomValue( c0 );
				float r1 = noise_randomValue( c1 );
				float r2 = noise_randomValue( c2 );
				float r3 = noise_randomValue( c3 );
				float bottomOfGrid = noise_interpolate( r0, r1, f.x );
				float topOfGrid = noise_interpolate( r2, r3, f.x );
				float t = noise_interpolate( bottomOfGrid, topOfGrid, f.y );
				return t;
			}
			
			float SimpleNoise(float2 UV)
			{
				float t = 0.0;
				float freq = pow( 2.0, float( 0 ) );
				float amp = pow( 0.5, float( 3 - 0 ) );
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(1));
				amp = pow(0.5, float(3-1));
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(2));
				amp = pow(0.5, float(3-2));
				t += valueNoise( UV/freq )*amp;
				return t;
			}
			

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
				half2 appendResult1900_g76988 = (half2(ase_positionWS.x , ase_positionWS.z));
				half2 lerpResult1899_g76988 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult1900_g76988 , _ElementUVsMode);
				half2 vertexToFrag11_g77047 = ( ( lerpResult1899_g76988 * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord1.zw = vertexToFrag11_g77047;
				half2 appendResult60_g77068 = (half2(ase_positionWS.x , ase_positionWS.z));
				half2 lerpResult58_g77068 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult60_g77068 , _ElementMaskCoordMode);
				half2 vertexToFrag11_g77071 = ( ( lerpResult58_g77068 * (_ElementMaskCoordValue).xy ) + (_ElementMaskCoordValue).zw );
				o.ase_texcoord2.xy = vertexToFrag11_g77071;
				half3 ase_normalWS = UnityObjectToWorldNormal( v.ase_normal );
				o.ase_texcoord3.xyz = ase_normalWS;
				half TVE_SeasonOptions_X50_g76988 = TVE_SeasonOption.x;
				half Influence_Winter808_g76988 = _InfluenceValue1;
				half Influence_Spring814_g76988 = _InfluenceValue2;
				half temp_output_7_0_g77044 = _SeasonRemap.x;
				half temp_output_9_0_g77044 = ( TVE_SeasonLerp - temp_output_7_0_g77044 );
				half smoothstepResult2286_g76988 = smoothstep( 0.0 , 1.0 , saturate( ( temp_output_9_0_g77044 * _SeasonRemap.z ) ));
				half SeasonLerp54_g76988 = smoothstepResult2286_g76988;
				half lerpResult829_g76988 = lerp( Influence_Winter808_g76988 , Influence_Spring814_g76988 , SeasonLerp54_g76988);
				half TVE_SeasonOptions_Y51_g76988 = TVE_SeasonOption.y;
				half Influence_Summer815_g76988 = _InfluenceValue3;
				half lerpResult833_g76988 = lerp( Influence_Spring814_g76988 , Influence_Summer815_g76988 , SeasonLerp54_g76988);
				half TVE_SeasonOptions_Z52_g76988 = TVE_SeasonOption.z;
				half Influence_Autumn810_g76988 = _InfluenceValue4;
				half lerpResult816_g76988 = lerp( Influence_Summer815_g76988 , Influence_Autumn810_g76988 , SeasonLerp54_g76988);
				half TVE_SeasonOptions_W53_g76988 = TVE_SeasonOption.w;
				half lerpResult817_g76988 = lerp( Influence_Autumn810_g76988 , Influence_Winter808_g76988 , SeasonLerp54_g76988);
				half temp_output_832_0_g76988 = ( ( TVE_SeasonOptions_X50_g76988 * lerpResult829_g76988 ) + ( TVE_SeasonOptions_Y51_g76988 * lerpResult833_g76988 ) + ( TVE_SeasonOptions_Z52_g76988 * lerpResult816_g76988 ) + ( TVE_SeasonOptions_W53_g76988 * lerpResult817_g76988 ) );
				half vertexToFrag11_g76994 = temp_output_832_0_g76988;
				o.ase_texcoord2.z = vertexToFrag11_g76994;
				
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				o.ase_color = v.color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.w = 0;
				o.ase_texcoord3.w = 0;
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
				half Noise_Scale892_g76988 = _NoiseTillingValue;
				half simpleNoise775_g76988 = SimpleNoise( i.ase_texcoord1.xy*Noise_Scale892_g76988 );
				half Noise_Min893_g76988 = _NoiseRemap.x;
				half temp_output_7_0_g77134 = Noise_Min893_g76988;
				half temp_output_9_0_g77134 = ( simpleNoise775_g76988 - temp_output_7_0_g77134 );
				half Noise_Max894_g76988 = _NoiseRemap.z;
				half WorldNoise1483_g76988 = saturate( ( temp_output_9_0_g77134 * Noise_Max894_g76988 ) );
				half4 lerpResult772_g76988 = lerp( _NoiseColorOne , _NoiseColorTwo , WorldNoise1483_g76988);
				half3 Final_ColorsNoise_RGB784_g76988 = (lerpResult772_g76988).rgb;
				half Element_Intensity2580_g76988 = _ElementIntensity;
				half2 vertexToFrag11_g77047 = i.ase_texcoord1.zw;
				half4 MainTex_RGBA587_g76988 = tex2D( _MainTex, vertexToFrag11_g77047 );
				half temp_output_6_0_g77051 = (MainTex_RGBA587_g76988).a;
				half SpaceTexture2395_g76988 = _SpaceTexture;
				half temp_output_7_0_g77051 = SpaceTexture2395_g76988;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77051 = ( temp_output_6_0_g77051 + temp_output_7_0_g77051 );
				#else
				half staticSwitch14_g77051 = temp_output_6_0_g77051;
				#endif
				half clampResult17_g77046 = clamp( staticSwitch14_g77051 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77049 = _MainTexAlphaRemap.x;
				half temp_output_9_0_g77049 = ( clampResult17_g77046 - temp_output_7_0_g77049 );
				half Element_Remap_A74_g76988 = saturate( ( temp_output_9_0_g77049 * _MainTexAlphaRemap.z ) );
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half Element_Params_A1737_g76988 = _ElementParams_Instance.w;
				half temp_output_6_0_g77053 = saturate( ( 1.0 - distance( (i.ase_texcoord1.xy*2.0 + -1.0) , float2( 0,0 ) ) ) );
				half temp_output_7_0_g77053 = SpaceTexture2395_g76988;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77053 = ( temp_output_6_0_g77053 + temp_output_7_0_g77053 );
				#else
				half staticSwitch14_g77053 = temp_output_6_0_g77053;
				#endif
				half clampResult17_g77052 = clamp( staticSwitch14_g77053 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77043 = _MainTexFalloffRemap.x;
				half temp_output_9_0_g77043 = ( clampResult17_g77052 - temp_output_7_0_g77043 );
				half Element_Falloff1883_g76988 = saturate( ( temp_output_9_0_g77043 * _MainTexFalloffRemap.z ) );
				half temp_output_7_0_g76991 = 1.0;
				half temp_output_9_0_g76991 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g76991 );
				half lerpResult18_g76989 = lerp( 1.0 , saturate( ( temp_output_9_0_g76991 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g76991 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g76989 = lerpResult18_g76989;
				half temp_output_6_0_g76992 = Blend_Edge69_g76989;
				half Dummy72_g76989 = ( _BoundsCategory + _BoundsEnd );
				half temp_output_7_0_g76992 = Dummy72_g76989;
				#ifdef TVE_DUMMY
				half staticSwitch14_g76992 = ( temp_output_6_0_g76992 + temp_output_7_0_g76992 );
				#else
				half staticSwitch14_g76992 = temp_output_6_0_g76992;
				#endif
				half2 vertexToFrag11_g77071 = i.ase_texcoord2.xy;
				half4 MainTex_RGBA53_g77068 = tex2D( _ElementMaskTex, vertexToFrag11_g77071 );
				half lerpResult148_g77068 = lerp( (MainTex_RGBA53_g77068).r , (MainTex_RGBA53_g77068).a , _ElementMaskMode);
				half clampResult17_g77077 = clamp( lerpResult148_g77068 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77078 = _ElementMaskRemap.x;
				half temp_output_9_0_g77078 = ( clampResult17_g77077 - temp_output_7_0_g77078 );
				half lerpResult73_g77068 = lerp( 1.0 , saturate( ( temp_output_9_0_g77078 * _ElementMaskRemap.z ) ) , _ElementMaskValue);
				half Blend_Mask45_g77068 = lerpResult73_g77068;
				#ifdef TVE_ELEMENT_MASK
				half staticSwitch159_g77068 = Blend_Mask45_g77068;
				#else
				half staticSwitch159_g77068 = 1.0;
				#endif
				half3 ase_normalWS = i.ase_texcoord3.xyz;
				half4 appendResult108_g77068 = (half4(_TerrainPosition.x , _TerrainPosition.z , _TerrainSize.x , _TerrainSize.z));
				half4 Terrain_Coords111_g77068 = appendResult108_g77068;
				half4 temp_output_35_0_g77076 = Terrain_Coords111_g77068;
				float2 InputScale48_g77076 = (temp_output_35_0_g77076).zw;
				half2 FinalScale53_g77076 = ( 1.0 / InputScale48_g77076 );
				float2 InputPosition52_g77076 = (temp_output_35_0_g77076).xy;
				half2 FinalPosition58_g77076 = -( FinalScale53_g77076 * InputPosition52_g77076 );
				half2 temp_output_65_0_g77076 = ( ( (WorldPosition).xz * FinalScale53_g77076 ) + FinalPosition58_g77076 );
				half Terrain_InputMode136_g77068 = _TerrainInputMode;
				half3 lerpResult141_g77068 = lerp( ase_normalWS , tex2D( _TerrainNormalTex, temp_output_65_0_g77076 ).rgb , Terrain_InputMode136_g77068);
				half3 Terrain_Normal107_g77068 = lerpResult141_g77068;
				half dotResult113_g77068 = dot( Terrain_Normal107_g77068 , half3( 0, 1, 0 ) );
				half clampResult17_g77073 = clamp( dotResult113_g77068 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77074 = _ElementProjRemap.x;
				half temp_output_9_0_g77074 = ( clampResult17_g77073 - temp_output_7_0_g77074 );
				half lerpResult123_g77068 = lerp( 1.0 , saturate( ( temp_output_9_0_g77074 * _ElementProjRemap.z ) ) , _ElementProjValue);
				half Blend_Proj117_g77068 = lerpResult123_g77068;
				#ifdef TVE_ELEMENT_PROJ
				half staticSwitch160_g77068 = Blend_Proj117_g77068;
				#else
				half staticSwitch160_g77068 = 1.0;
				#endif
				half4 temp_output_35_0_g77069 = Terrain_Coords111_g77068;
				float2 InputScale48_g77069 = (temp_output_35_0_g77069).zw;
				half2 FinalScale53_g77069 = ( 1.0 / InputScale48_g77069 );
				float2 InputPosition52_g77069 = (temp_output_35_0_g77069).xy;
				half2 FinalPosition58_g77069 = -( FinalScale53_g77069 * InputPosition52_g77069 );
				half2 temp_output_65_0_g77069 = ( ( (WorldPosition).xz * FinalScale53_g77069 ) + FinalPosition58_g77069 );
				half4 temp_output_70_0_g77069 = _TerrainHeightTex_TexelSize;
				float2 InputTexelSize68_g77069 = (temp_output_70_0_g77069).zw;
				half2 temp_cast_0 = (1.0).xx;
				float2 InputTexelRecip69_g77069 = (temp_output_70_0_g77069).xy;
				float4 Terrain_Height_Raw104_g77068 = tex2D( _TerrainHeightTex, ( ( ( temp_output_65_0_g77069 / ( 1.0 / ( InputTexelSize68_g77069 - temp_cast_0 ) ) ) + 0.5 ) * InputTexelRecip69_g77069 ) );
				half temp_output_90_0_g77068 = ( ( (Terrain_Height_Raw104_g77068).r + ( (Terrain_Height_Raw104_g77068).g * 256.0 ) ) / 257.0 );
				#ifdef SHADER_API_VULKAN
				half staticSwitch91_g77068 = temp_output_90_0_g77068;
				#else
				half staticSwitch91_g77068 = (Terrain_Height_Raw104_g77068).r;
				#endif
				#ifdef SHADER_API_GLES
				half staticSwitch92_g77068 = temp_output_90_0_g77068;
				#else
				half staticSwitch92_g77068 = staticSwitch91_g77068;
				#endif
				#ifdef SHADER_API_GLES3
				half staticSwitch93_g77068 = temp_output_90_0_g77068;
				#else
				half staticSwitch93_g77068 = staticSwitch92_g77068;
				#endif
				float Terrain_Height_Platform105_g77068 = staticSwitch93_g77068;
				half Terrain_SizeY109_g77068 = _TerrainSize.y;
				half Terrain_PosY110_g77068 = _TerrainPosition.y;
				half lerpResult137_g77068 = lerp( WorldPosition.y , ( ( Terrain_Height_Platform105_g77068 * Terrain_SizeY109_g77068 * 2.0 ) + Terrain_PosY110_g77068 ) , Terrain_InputMode136_g77068);
				float Terrain_Height106_g77068 = lerpResult137_g77068;
				half temp_output_7_0_g77075 = _ElementPosMaxValue;
				half temp_output_9_0_g77075 = ( Terrain_Height106_g77068 - temp_output_7_0_g77075 );
				half lerpResult129_g77068 = lerp( 1.0 , saturate( ( temp_output_9_0_g77075 / ( ( _ElementPosMinValue - temp_output_7_0_g77075 ) + 0.0001 ) ) ) , _ElementPosValue);
				half Blend_Pos131_g77068 = lerpResult129_g77068;
				#ifdef TVE_ELEMENT_POS
				half staticSwitch161_g77068 = Blend_Pos131_g77068;
				#else
				half staticSwitch161_g77068 = 1.0;
				#endif
				half temp_output_6_0_g77079 = ( staticSwitch159_g77068 * staticSwitch160_g77068 * staticSwitch161_g77068 );
				half Dummy144_g77068 = ( _MaskingCategory + _MaskingEnd + ( _MaskingTerrainInfo + _MaskingModelInfo ) );
				half temp_output_7_0_g77079 = Dummy144_g77068;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77079 = ( temp_output_6_0_g77079 + temp_output_7_0_g77079 );
				#else
				half staticSwitch14_g77079 = temp_output_6_0_g77079;
				#endif
				half temp_output_145_0_g77068 = staticSwitch14_g77079;
				half temp_output_6_0_g76997 = 1.0;
				half temp_output_7_0_g76997 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				half staticSwitch14_g76997 = ( temp_output_6_0_g76997 + temp_output_7_0_g76997 );
				#else
				half staticSwitch14_g76997 = temp_output_6_0_g76997;
				#endif
				half Element_Alpha56_g76988 = ( Element_Intensity2580_g76988 * Element_Remap_A74_g76988 * Element_Params_A1737_g76988 * i.ase_color.a * Element_Falloff1883_g76988 * staticSwitch14_g76992 * temp_output_145_0_g77068 * staticSwitch14_g76997 );
				half vertexToFrag11_g76994 = i.ase_texcoord2.z;
				half Influence_Seasons834_g76988 = vertexToFrag11_g76994;
				half Final_ColorsNoise_A785_g76988 = ( (lerpResult772_g76988).a * Element_Alpha56_g76988 * Influence_Seasons834_g76988 );
				half4 appendResult790_g76988 = (half4(Final_ColorsNoise_RGB784_g76988 , Final_ColorsNoise_A785_g76988));
				
				
				finalColor = appendResult790_g76988;
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
			#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma multi_compile_local_fragment __ TVE_ELEMENT_MASK
			#pragma multi_compile_local_fragment __ TVE_ELEMENT_PROJ
			#pragma multi_compile_local_fragment __ TVE_ELEMENT_POS


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				half3 ase_normal : NORMAL;
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
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
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
			uniform half4 _NoiseColorOne;
			uniform half4 _NoiseColorTwo;
			uniform half _NoiseTillingValue;
			uniform half4 _NoiseRemap;
			uniform half _ElementIntensity;
			uniform sampler2D _MainTex;
			uniform half _ElementUVsMode;
			uniform half4 _MainUVs;
			uniform half _SpaceTexture;
			uniform half4 _MainTexAlphaRemap;
			uniform half4 _MainTexFalloffRemap;
			uniform half4 TVE_RenderBasePositionR;
			uniform half _ElementVolumeFadeValue;
			uniform half _ElementVolumeFadeMode;
			uniform half _BoundsCategory;
			uniform half _BoundsEnd;
			uniform sampler2D _ElementMaskTex;
			uniform half _ElementMaskCoordMode;
			uniform half4 _ElementMaskCoordValue;
			uniform half _ElementMaskMode;
			uniform half4 _ElementMaskRemap;
			uniform half _ElementMaskValue;
			uniform sampler2D _TerrainNormalTex;
			uniform half3 _TerrainPosition;
			uniform half3 _TerrainSize;
			uniform half _TerrainInputMode;
			uniform half4 _ElementProjRemap;
			uniform half _ElementProjValue;
			uniform sampler2D _TerrainHeightTex;
			float4 _TerrainHeightTex_TexelSize;
			uniform half _ElementPosMaxValue;
			uniform half _ElementPosMinValue;
			uniform half _ElementPosValue;
			uniform half _MaskingCategory;
			uniform half _MaskingEnd;
			uniform half _MaskingTerrainInfo;
			uniform half _MaskingModelInfo;
			uniform half _RaycastCategory;
			uniform half _RaycastEnd;
			uniform half _ElementRaycastMode;
			uniform half _RaycastLayerMask;
			uniform half _RaycastDistanceMinValue;
			uniform half _RaycastDistanceMaxValue;
			uniform half _RaycastDistanceCheckValue;
			uniform half4 TVE_SeasonOption;
			uniform half _InfluenceValue1;
			uniform half _InfluenceValue2;
			uniform half TVE_SeasonLerp;
			uniform half4 _SeasonRemap;
			uniform half _InfluenceValue3;
			uniform half _InfluenceValue4;
			UNITY_INSTANCING_BUFFER_START(BOXOPHOBICTheVisualEngineElementsPaintNoise)
				UNITY_DEFINE_INSTANCED_PROP(half4, _ElementParams)
#define _ElementParams_arr BOXOPHOBICTheVisualEngineElementsPaintNoise
			UNITY_INSTANCING_BUFFER_END(BOXOPHOBICTheVisualEngineElementsPaintNoise)
			inline float noise_randomValue (float2 uv) { return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453); }
			inline float noise_interpolate (float a, float b, float t) { return (1.0-t)*a + (t*b); }
			inline float valueNoise (float2 uv)
			{
				float2 i = floor(uv);
				float2 f = frac( uv );
				f = f* f * (3.0 - 2.0 * f);
				uv = abs( frac(uv) - 0.5);
				float2 c0 = i + float2( 0.0, 0.0 );
				float2 c1 = i + float2( 1.0, 0.0 );
				float2 c2 = i + float2( 0.0, 1.0 );
				float2 c3 = i + float2( 1.0, 1.0 );
				float r0 = noise_randomValue( c0 );
				float r1 = noise_randomValue( c1 );
				float r2 = noise_randomValue( c2 );
				float r3 = noise_randomValue( c3 );
				float bottomOfGrid = noise_interpolate( r0, r1, f.x );
				float topOfGrid = noise_interpolate( r2, r3, f.x );
				float t = noise_interpolate( bottomOfGrid, topOfGrid, f.y );
				return t;
			}
			
			float SimpleNoise(float2 UV)
			{
				float t = 0.0;
				float freq = pow( 2.0, float( 0 ) );
				float amp = pow( 0.5, float( 3 - 0 ) );
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(1));
				amp = pow(0.5, float(3-1));
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(2));
				amp = pow(0.5, float(3-2));
				t += valueNoise( UV/freq )*amp;
				return t;
			}
			

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float3 ase_positionWS = mul( unity_ObjectToWorld, float4( ( v.vertex ).xyz, 1 ) ).xyz;
				half2 appendResult1900_g76988 = (half2(ase_positionWS.x , ase_positionWS.z));
				half2 lerpResult1899_g76988 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult1900_g76988 , _ElementUVsMode);
				half2 vertexToFrag11_g77047 = ( ( lerpResult1899_g76988 * (_MainUVs).xy ) + (_MainUVs).zw );
				o.ase_texcoord1.zw = vertexToFrag11_g77047;
				half2 appendResult60_g77068 = (half2(ase_positionWS.x , ase_positionWS.z));
				half2 lerpResult58_g77068 = lerp( ( 1.0 - v.ase_texcoord.xy ) , appendResult60_g77068 , _ElementMaskCoordMode);
				half2 vertexToFrag11_g77071 = ( ( lerpResult58_g77068 * (_ElementMaskCoordValue).xy ) + (_ElementMaskCoordValue).zw );
				o.ase_texcoord2.xy = vertexToFrag11_g77071;
				half3 ase_normalWS = UnityObjectToWorldNormal( v.ase_normal );
				o.ase_texcoord3.xyz = ase_normalWS;
				half TVE_SeasonOptions_X50_g76988 = TVE_SeasonOption.x;
				half Influence_Winter808_g76988 = _InfluenceValue1;
				half Influence_Spring814_g76988 = _InfluenceValue2;
				half temp_output_7_0_g77044 = _SeasonRemap.x;
				half temp_output_9_0_g77044 = ( TVE_SeasonLerp - temp_output_7_0_g77044 );
				half smoothstepResult2286_g76988 = smoothstep( 0.0 , 1.0 , saturate( ( temp_output_9_0_g77044 * _SeasonRemap.z ) ));
				half SeasonLerp54_g76988 = smoothstepResult2286_g76988;
				half lerpResult829_g76988 = lerp( Influence_Winter808_g76988 , Influence_Spring814_g76988 , SeasonLerp54_g76988);
				half TVE_SeasonOptions_Y51_g76988 = TVE_SeasonOption.y;
				half Influence_Summer815_g76988 = _InfluenceValue3;
				half lerpResult833_g76988 = lerp( Influence_Spring814_g76988 , Influence_Summer815_g76988 , SeasonLerp54_g76988);
				half TVE_SeasonOptions_Z52_g76988 = TVE_SeasonOption.z;
				half Influence_Autumn810_g76988 = _InfluenceValue4;
				half lerpResult816_g76988 = lerp( Influence_Summer815_g76988 , Influence_Autumn810_g76988 , SeasonLerp54_g76988);
				half TVE_SeasonOptions_W53_g76988 = TVE_SeasonOption.w;
				half lerpResult817_g76988 = lerp( Influence_Autumn810_g76988 , Influence_Winter808_g76988 , SeasonLerp54_g76988);
				half temp_output_832_0_g76988 = ( ( TVE_SeasonOptions_X50_g76988 * lerpResult829_g76988 ) + ( TVE_SeasonOptions_Y51_g76988 * lerpResult833_g76988 ) + ( TVE_SeasonOptions_Z52_g76988 * lerpResult816_g76988 ) + ( TVE_SeasonOptions_W53_g76988 * lerpResult817_g76988 ) );
				half vertexToFrag11_g76994 = temp_output_832_0_g76988;
				o.ase_texcoord2.z = vertexToFrag11_g76994;
				
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				o.ase_color = v.color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.w = 0;
				o.ase_texcoord3.w = 0;
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
				half Noise_Scale892_g76988 = _NoiseTillingValue;
				half simpleNoise775_g76988 = SimpleNoise( i.ase_texcoord1.xy*Noise_Scale892_g76988 );
				half Noise_Min893_g76988 = _NoiseRemap.x;
				half temp_output_7_0_g77134 = Noise_Min893_g76988;
				half temp_output_9_0_g77134 = ( simpleNoise775_g76988 - temp_output_7_0_g77134 );
				half Noise_Max894_g76988 = _NoiseRemap.z;
				half WorldNoise1483_g76988 = saturate( ( temp_output_9_0_g77134 * Noise_Max894_g76988 ) );
				half4 lerpResult772_g76988 = lerp( _NoiseColorOne , _NoiseColorTwo , WorldNoise1483_g76988);
				half3 Final_ColorsNoise_RGB784_g76988 = (lerpResult772_g76988).rgb;
				half Element_Intensity2580_g76988 = _ElementIntensity;
				half2 vertexToFrag11_g77047 = i.ase_texcoord1.zw;
				half4 MainTex_RGBA587_g76988 = tex2D( _MainTex, vertexToFrag11_g77047 );
				half temp_output_6_0_g77051 = (MainTex_RGBA587_g76988).a;
				half SpaceTexture2395_g76988 = _SpaceTexture;
				half temp_output_7_0_g77051 = SpaceTexture2395_g76988;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77051 = ( temp_output_6_0_g77051 + temp_output_7_0_g77051 );
				#else
				half staticSwitch14_g77051 = temp_output_6_0_g77051;
				#endif
				half clampResult17_g77046 = clamp( staticSwitch14_g77051 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77049 = _MainTexAlphaRemap.x;
				half temp_output_9_0_g77049 = ( clampResult17_g77046 - temp_output_7_0_g77049 );
				half Element_Remap_A74_g76988 = saturate( ( temp_output_9_0_g77049 * _MainTexAlphaRemap.z ) );
				half4 _ElementParams_Instance = UNITY_ACCESS_INSTANCED_PROP(_ElementParams_arr, _ElementParams);
				half Element_Params_A1737_g76988 = _ElementParams_Instance.w;
				half temp_output_6_0_g77053 = saturate( ( 1.0 - distance( (i.ase_texcoord1.xy*2.0 + -1.0) , float2( 0,0 ) ) ) );
				half temp_output_7_0_g77053 = SpaceTexture2395_g76988;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77053 = ( temp_output_6_0_g77053 + temp_output_7_0_g77053 );
				#else
				half staticSwitch14_g77053 = temp_output_6_0_g77053;
				#endif
				half clampResult17_g77052 = clamp( staticSwitch14_g77053 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77043 = _MainTexFalloffRemap.x;
				half temp_output_9_0_g77043 = ( clampResult17_g77052 - temp_output_7_0_g77043 );
				half Element_Falloff1883_g76988 = saturate( ( temp_output_9_0_g77043 * _MainTexFalloffRemap.z ) );
				half temp_output_7_0_g76991 = 1.0;
				half temp_output_9_0_g76991 = ( saturate( ( distance( WorldPosition , (TVE_RenderBasePositionR).xyz ) / (TVE_RenderBasePositionR).w ) ) - temp_output_7_0_g76991 );
				half lerpResult18_g76989 = lerp( 1.0 , saturate( ( temp_output_9_0_g76991 / ( ( _ElementVolumeFadeValue - temp_output_7_0_g76991 ) + 0.0001 ) ) ) , _ElementVolumeFadeMode);
				half Blend_Edge69_g76989 = lerpResult18_g76989;
				half temp_output_6_0_g76992 = Blend_Edge69_g76989;
				half Dummy72_g76989 = ( _BoundsCategory + _BoundsEnd );
				half temp_output_7_0_g76992 = Dummy72_g76989;
				#ifdef TVE_DUMMY
				half staticSwitch14_g76992 = ( temp_output_6_0_g76992 + temp_output_7_0_g76992 );
				#else
				half staticSwitch14_g76992 = temp_output_6_0_g76992;
				#endif
				half2 vertexToFrag11_g77071 = i.ase_texcoord2.xy;
				half4 MainTex_RGBA53_g77068 = tex2D( _ElementMaskTex, vertexToFrag11_g77071 );
				half lerpResult148_g77068 = lerp( (MainTex_RGBA53_g77068).r , (MainTex_RGBA53_g77068).a , _ElementMaskMode);
				half clampResult17_g77077 = clamp( lerpResult148_g77068 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77078 = _ElementMaskRemap.x;
				half temp_output_9_0_g77078 = ( clampResult17_g77077 - temp_output_7_0_g77078 );
				half lerpResult73_g77068 = lerp( 1.0 , saturate( ( temp_output_9_0_g77078 * _ElementMaskRemap.z ) ) , _ElementMaskValue);
				half Blend_Mask45_g77068 = lerpResult73_g77068;
				#ifdef TVE_ELEMENT_MASK
				half staticSwitch159_g77068 = Blend_Mask45_g77068;
				#else
				half staticSwitch159_g77068 = 1.0;
				#endif
				half3 ase_normalWS = i.ase_texcoord3.xyz;
				half4 appendResult108_g77068 = (half4(_TerrainPosition.x , _TerrainPosition.z , _TerrainSize.x , _TerrainSize.z));
				half4 Terrain_Coords111_g77068 = appendResult108_g77068;
				half4 temp_output_35_0_g77076 = Terrain_Coords111_g77068;
				float2 InputScale48_g77076 = (temp_output_35_0_g77076).zw;
				half2 FinalScale53_g77076 = ( 1.0 / InputScale48_g77076 );
				float2 InputPosition52_g77076 = (temp_output_35_0_g77076).xy;
				half2 FinalPosition58_g77076 = -( FinalScale53_g77076 * InputPosition52_g77076 );
				half2 temp_output_65_0_g77076 = ( ( (WorldPosition).xz * FinalScale53_g77076 ) + FinalPosition58_g77076 );
				half Terrain_InputMode136_g77068 = _TerrainInputMode;
				half3 lerpResult141_g77068 = lerp( ase_normalWS , tex2D( _TerrainNormalTex, temp_output_65_0_g77076 ).rgb , Terrain_InputMode136_g77068);
				half3 Terrain_Normal107_g77068 = lerpResult141_g77068;
				half dotResult113_g77068 = dot( Terrain_Normal107_g77068 , half3( 0, 1, 0 ) );
				half clampResult17_g77073 = clamp( dotResult113_g77068 , 0.0001 , 0.9999 );
				half temp_output_7_0_g77074 = _ElementProjRemap.x;
				half temp_output_9_0_g77074 = ( clampResult17_g77073 - temp_output_7_0_g77074 );
				half lerpResult123_g77068 = lerp( 1.0 , saturate( ( temp_output_9_0_g77074 * _ElementProjRemap.z ) ) , _ElementProjValue);
				half Blend_Proj117_g77068 = lerpResult123_g77068;
				#ifdef TVE_ELEMENT_PROJ
				half staticSwitch160_g77068 = Blend_Proj117_g77068;
				#else
				half staticSwitch160_g77068 = 1.0;
				#endif
				half4 temp_output_35_0_g77069 = Terrain_Coords111_g77068;
				float2 InputScale48_g77069 = (temp_output_35_0_g77069).zw;
				half2 FinalScale53_g77069 = ( 1.0 / InputScale48_g77069 );
				float2 InputPosition52_g77069 = (temp_output_35_0_g77069).xy;
				half2 FinalPosition58_g77069 = -( FinalScale53_g77069 * InputPosition52_g77069 );
				half2 temp_output_65_0_g77069 = ( ( (WorldPosition).xz * FinalScale53_g77069 ) + FinalPosition58_g77069 );
				half4 temp_output_70_0_g77069 = _TerrainHeightTex_TexelSize;
				float2 InputTexelSize68_g77069 = (temp_output_70_0_g77069).zw;
				half2 temp_cast_0 = (1.0).xx;
				float2 InputTexelRecip69_g77069 = (temp_output_70_0_g77069).xy;
				float4 Terrain_Height_Raw104_g77068 = tex2D( _TerrainHeightTex, ( ( ( temp_output_65_0_g77069 / ( 1.0 / ( InputTexelSize68_g77069 - temp_cast_0 ) ) ) + 0.5 ) * InputTexelRecip69_g77069 ) );
				half temp_output_90_0_g77068 = ( ( (Terrain_Height_Raw104_g77068).r + ( (Terrain_Height_Raw104_g77068).g * 256.0 ) ) / 257.0 );
				#ifdef SHADER_API_VULKAN
				half staticSwitch91_g77068 = temp_output_90_0_g77068;
				#else
				half staticSwitch91_g77068 = (Terrain_Height_Raw104_g77068).r;
				#endif
				#ifdef SHADER_API_GLES
				half staticSwitch92_g77068 = temp_output_90_0_g77068;
				#else
				half staticSwitch92_g77068 = staticSwitch91_g77068;
				#endif
				#ifdef SHADER_API_GLES3
				half staticSwitch93_g77068 = temp_output_90_0_g77068;
				#else
				half staticSwitch93_g77068 = staticSwitch92_g77068;
				#endif
				float Terrain_Height_Platform105_g77068 = staticSwitch93_g77068;
				half Terrain_SizeY109_g77068 = _TerrainSize.y;
				half Terrain_PosY110_g77068 = _TerrainPosition.y;
				half lerpResult137_g77068 = lerp( WorldPosition.y , ( ( Terrain_Height_Platform105_g77068 * Terrain_SizeY109_g77068 * 2.0 ) + Terrain_PosY110_g77068 ) , Terrain_InputMode136_g77068);
				float Terrain_Height106_g77068 = lerpResult137_g77068;
				half temp_output_7_0_g77075 = _ElementPosMaxValue;
				half temp_output_9_0_g77075 = ( Terrain_Height106_g77068 - temp_output_7_0_g77075 );
				half lerpResult129_g77068 = lerp( 1.0 , saturate( ( temp_output_9_0_g77075 / ( ( _ElementPosMinValue - temp_output_7_0_g77075 ) + 0.0001 ) ) ) , _ElementPosValue);
				half Blend_Pos131_g77068 = lerpResult129_g77068;
				#ifdef TVE_ELEMENT_POS
				half staticSwitch161_g77068 = Blend_Pos131_g77068;
				#else
				half staticSwitch161_g77068 = 1.0;
				#endif
				half temp_output_6_0_g77079 = ( staticSwitch159_g77068 * staticSwitch160_g77068 * staticSwitch161_g77068 );
				half Dummy144_g77068 = ( _MaskingCategory + _MaskingEnd + ( _MaskingTerrainInfo + _MaskingModelInfo ) );
				half temp_output_7_0_g77079 = Dummy144_g77068;
				#ifdef TVE_DUMMY
				half staticSwitch14_g77079 = ( temp_output_6_0_g77079 + temp_output_7_0_g77079 );
				#else
				half staticSwitch14_g77079 = temp_output_6_0_g77079;
				#endif
				half temp_output_145_0_g77068 = staticSwitch14_g77079;
				half temp_output_6_0_g76997 = 1.0;
				half temp_output_7_0_g76997 = ( _RaycastCategory + _RaycastEnd + _ElementRaycastMode + _RaycastLayerMask + _RaycastDistanceMinValue + _RaycastDistanceMaxValue + _RaycastDistanceCheckValue );
				#ifdef TVE_DUMMY
				half staticSwitch14_g76997 = ( temp_output_6_0_g76997 + temp_output_7_0_g76997 );
				#else
				half staticSwitch14_g76997 = temp_output_6_0_g76997;
				#endif
				half Element_Alpha56_g76988 = ( Element_Intensity2580_g76988 * Element_Remap_A74_g76988 * Element_Params_A1737_g76988 * i.ase_color.a * Element_Falloff1883_g76988 * staticSwitch14_g76992 * temp_output_145_0_g77068 * staticSwitch14_g76997 );
				half vertexToFrag11_g76994 = i.ase_texcoord2.z;
				half Influence_Seasons834_g76988 = vertexToFrag11_g76994;
				half Final_ColorsNoise_A785_g76988 = ( (lerpResult772_g76988).a * Element_Alpha56_g76988 * Influence_Seasons834_g76988 );
				half4 appendResult2466_g76988 = (half4(Final_ColorsNoise_RGB784_g76988 , Final_ColorsNoise_A785_g76988));
				half4 Input_Visual94_g77135 = appendResult2466_g76988;
				half3 Element_Color47_g77135 = saturate( (Input_Visual94_g77135).xyz );
				half4 appendResult131_g77135 = (half4(Element_Color47_g77135 , (Input_Visual94_g77135).w));
				
				
				finalColor = appendResult131_g77135;
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
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":187,"pos":[-640,-384],"params":["Inherit","False","Element Type Paint","1","","24792","5810d2854679b554b88f8bb18ff3bfa0","0","0","1","FLOAT","4"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":188,"pos":[-384,-384],"params":["Inherit","False","Element Shader","11","","76988","0e972c73cae2ee54ea51acc9738801d0","15,1778,0,477,0,478,2,1824,2,1814,0,145,0,1784,0,481,0,2614,0,2618,0,1904,1,1907,1,2377,1,2310,1,2311,1","2","1974","FLOAT","0","False","2378","FLOAT","1","False","2","FLOAT4","0","FLOAT4","1779"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":159,"pos":[-640,-640],"params":["Half","False","Property","_render_colormask","_render_colormask","107","1","[HideInInspector]","Create","True","0","0","0","True","0","False","Object","-1","","15","15","0","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":192,"pos":[-128,-256],"params":["Inherit","False","Element Visuals","-1","","77135","78cf0f00cfd72824e84597f2db54a76e","1,64,0","2","59","FLOAT4","0,0,0,0","False","77","FLOAT3","1,1,1","False","1","FLOAT4","0"]}
{"type":"AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor","id":181,"pos":[64,-768],"params":["Inherit","False","Element Compile","-1","","77136","5302407fc6d65554791e558e67d59358","0","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor","id":100,"pos":[-640,-768],"params":["Half","False","Property","_ElementMessage","Element Message","0","0","Create","True","0","0","0","True","1","StyledMessage(Info, Use Paint Noise elements to add two colors noise tinting to the vegetation assets. Element Texture A is used as alpha mask., 0, 15)","False","Object","-1","","0","0","1","1","0","1","FLOAT","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":189,"pos":[-64,-384],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","1","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass1","0","1","VolumePass1","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass1","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":190,"pos":[-64,-384],"params":["Float","False","False","-1","3","AmplifyShaderEditor.MaterialInspector","100","1","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VolumePass2","0","2","VolumePass2","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","False","True","0","1","False","","0","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","False","True","1","False","","True","3","False","","True","True","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass2","True","2","False","0","","0","0","Standard","0","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":182,"pos":[64,-384],"params":["Half","False","True","-1","2","TheVisualEngine.ElementGUI","100","2","BOXOPHOBIC/The Visual Engine/Elements/Paint Noise","f4f273c3bb6262d4396be458405e60f9","True","VolumePass","0","0","VolumePass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","3","RenderType=Transparent=RenderType","Queue=Transparent=Queue=0","DisableBatching=True=DisableBatching","False","False","0","True","True","2","5","False","","10","False","","2","5","False","","10","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","True","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","True","1","LightMode=VolumePass","True","2","False","0","","0","0","Standard","3","VolumePass1","0","0","VolumePass2","0","0","Vertex Position","1","0","0","4","True","False","False","True","False","","False","0"]}
{"type":"AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor","id":183,"pos":[64,-256],"params":["Float","False","False","-1","2","AmplifyShaderEditor.MaterialInspector","100","2","New Amplify Shader","f4f273c3bb6262d4396be458405e60f9","True","VisualPass","0","3","VisualPass","2","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","False","True","1","RenderType=Opaque=RenderType","False","False","0","True","True","2","5","False","","10","False","","0","1","False","","0","False","","True","0","False","","0","False","","False","False","False","False","False","False","False","False","False","True","0","False","","False","True","0","False","","False","True","True","True","True","True","0","False","","False","False","False","False","False","False","False","True","False","0","False","","255","False","","255","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","0","False","","True","True","2","False","","True","0","False","","True","False","0","False","","0","False","","True","1","False","","False","True","2","False","0","","0","0","Standard","0","False","0"]}
{"wire":[188,1974,187,4]}
{"wire":[192,59,188,1779]}
{"wire":[182,0,188,0]}
{"wire":[183,0,192,0]}
ASEEND*/
//CHKSM=A93FCBAA74885AC9DE11F14AEBF325CF187EA4A5