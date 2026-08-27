// Made with Amplify Shader Editor v1.9.9.9
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Packer"
{
	Properties
	{
		[HideInInspector] _MainTex( "Dummy Texture", 2D ) = "white" {}
		[NoScaleOffset] _PackerTexR( "PackerTexR", 2D ) = "white" {}
		[NoScaleOffset] _PackerTexG( "PackerTexG", 2D ) = "white" {}
		[NoScaleOffset] _PackerTexB( "PackerTexB", 2D ) = "white" {}
		[NoScaleOffset] _PackerTexA( "PackerTexA", 2D ) = "white" {}
		[Space(10)] _PackerFloatR( "PackerFloatR", Range( 0, 1 ) ) = 0
		_PackerFloatG( "PackerFloatG", Range( 0, 1 ) ) = 0
		_PackerFloatB( "PackerFloatB", Range( 0, 1 ) ) = 0
		_PackerFloatA( "PackerFloatA", Range( 0, 1 ) ) = 0
		[Space(10)] _PackerActionB1( "PackerActionB1", Float ) = 0
		[Space(10)] _PackerActionB0( "PackerActionB0", Float ) = 0
		[Space(10)] _PackerValueB0( "PackerValueB0", Float ) = 0
		[Space(10)] _PackerValueB1( "PackerValueB1", Float ) = 0
		[Space(10)] _PackerActionG0( "PackerActionG0", Float ) = 0
		[Space(10)] _PackerActionG1( "PackerActionG1", Float ) = 0
		[Space(10)] _PackerValueR0( "PackerValueR0", Float ) = 0
		[Space(10)] _PackerValueR1( "PackerValueR1", Float ) = 0
		[Space(10)] _PackerActionA1( "PackerActionA1", Float ) = 0
		[Space(10)] _PackerActionA0( "PackerActionA0", Float ) = 0
		[Space(10)] _PackerValueG0( "PackerValueG0", Float ) = 0
		[Space(10)] _PackerValueG1( "PackerValueG1", Float ) = 0
		[Space(10)] _PackerTexGammaModeR( "PackerTexGammaModeR", Float ) = 0
		[Space(10)] _PackerTexGammaModeG( "PackerTexGammaModeG", Float ) = 0
		[Space(10)] _PackerTexGammaModeA( "PackerTexGammaModeA", Float ) = 0
		[Space(10)] _PackerTexGammaModeB( "PackerTexGammaModeB", Float ) = 0
		[Space(10)] _PackerActionR1( "PackerActionR1", Float ) = 0
		[Space(10)] _PackerActionR0( "PackerActionR0", Float ) = 0
		[Space(10)] _PackerTransformMode( "PackerTransformMode", Float ) = 0
		[Space(10)] _PackerValueA1( "PackerValueA1", Float ) = 0
		[Space(10)] _PackerValueA0( "PackerValueA0", Float ) = 0
		[IntRange] _PackerCoordR( "PackerCoordR", Range( 0, 4 ) ) = 0
		[IntRange] _PackerCoordB( "PackerCoordB", Range( 0, 4 ) ) = 0
		[IntRange] _PackerCoordG( "PackerCoordG", Range( 0, 4 ) ) = 0
		[IntRange] _PackerCoordA( "PackerCoordA", Range( 0, 4 ) ) = 0
		[IntRange][Space(10)] _PackerChannelR( "PackerChannelR", Range( 0, 4 ) ) = 0
		[IntRange] _PackerChannelG( "PackerChannelG", Range( 0, 4 ) ) = 0
		[IntRange] _PackerChannelB( "PackerChannelB", Range( 0, 4 ) ) = 0
		[IntRange] _PackerChannelA( "PackerChannelA", Range( 0, 4 ) ) = 0

	}

	SubShader
	{
		

		

		Tags { "RenderType"="Opaque" "PreviewType"="Plane" }

	LOD 0

		

		Blend Off
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZClip True
		ZTest LEqual
		Offset 0 , 0
		

		CGINCLUDE
			#pragma target 3.0
			// ensure rendering platforms toggle list is visible

			float4 ComputeClipSpacePosition( float2 screenPosNorm, float deviceDepth )
			{
				float4 positionCS = float4( screenPosNorm * 2.0 - 1.0, deviceDepth, 1.0 );
			#if UNITY_UV_STARTS_AT_TOP
				positionCS.y = -positionCS.y;
			#endif
				return positionCS;
			}
		ENDCG

		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }

			CGPROGRAM
				#define ASE_ABSOLUTE_VERTEX_POS 1
				#define ASE_VERSION 19909

				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_instancing
				#include "UnityCG.cginc"

				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
				#define ASE_NEEDS_TEXTURE_COORDINATES1
				#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
				#define ASE_NEEDS_VERT_NORMAL


				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					float4 ase_texcoord : TEXCOORD0;
					float4 ase_texcoord1 : TEXCOORD1;
					float4 ase_tangent : TANGENT;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					float4 ase_texcoord : TEXCOORD0;
					float4 ase_texcoord1 : TEXCOORD1;
					float4 ase_texcoord2 : TEXCOORD2;
					float4 ase_texcoord3 : TEXCOORD3;
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				uniform sampler2D _MainTex;
				uniform float _PackerTransformMode;
				uniform float _PackerActionR1;
				uniform float _PackerActionR0;
				uniform float _PackerChannelR;
				uniform float _PackerFloatR;
				uniform sampler2D _PackerTexR;
				uniform float _PackerCoordR;
				uniform float _PackerTexGammaModeR;
				uniform float _PackerValueR0;
				uniform float _PackerValueR1;
				uniform float _PackerActionG1;
				uniform float _PackerActionG0;
				uniform float _PackerChannelG;
				uniform float _PackerFloatG;
				uniform sampler2D _PackerTexG;
				uniform float _PackerCoordG;
				uniform float _PackerTexGammaModeG;
				uniform float _PackerValueG0;
				uniform float _PackerValueG1;
				uniform float _PackerActionB1;
				uniform float _PackerActionB0;
				uniform float _PackerChannelB;
				uniform float _PackerFloatB;
				uniform sampler2D _PackerTexB;
				uniform float _PackerCoordB;
				uniform float _PackerTexGammaModeB;
				uniform float _PackerValueB0;
				uniform float _PackerValueB1;
				uniform float _PackerActionA1;
				uniform float _PackerActionA0;
				uniform float _PackerChannelA;
				uniform float _PackerFloatA;
				uniform sampler2D _PackerTexA;
				uniform float _PackerCoordA;
				uniform float _PackerTexGammaModeA;
				uniform float _PackerValueA0;
				uniform float _PackerValueA1;


				half3 LinearToGammaFloatFast( half3 linRGB )
				{
					return max(1.055h * pow(abs(linRGB), 0.416666667h) - 0.055h, 0.h);
				}
				
				half GammaToLinearFloatFast( half sRGB )
				{
					return sRGB * (sRGB * (sRGB * 0.305306011h + 0.682171111h) + 0.012522878h);
				}
				
				float3 ASESafeNormalize(float3 inVec)
				{
					float dp3 = max(1.175494351e-38, dot(inVec, inVec));
					return inVec* rsqrt(dp3);
				}
				
				float3x3 Inverse3x3(float3x3 input)
				{
					float3 a = input._11_21_31;
					float3 b = input._12_22_32;
					float3 c = input._13_23_33;
					return float3x3(cross(b,c), cross(c,a), cross(a,b)) * (1.0 / dot(a,cross(b,c)));
				}
				

				v2f vert( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID(v);
					v2f o;
					UNITY_INITIALIZE_OUTPUT(v2f,o);
					UNITY_TRANSFER_INSTANCE_ID(v,o);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

					float3 appendResult410 = (float3(v.ase_texcoord.xy , 0.0));
					
					float3 ase_tangentWS = UnityObjectToWorldDir( v.ase_tangent );
					o.ase_texcoord1.xyz = ase_tangentWS;
					float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
					o.ase_texcoord2.xyz = ase_normalWS;
					float ase_tangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
					float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
					o.ase_texcoord3.xyz = ase_bitangentWS;
					
					o.ase_texcoord.xy = v.ase_texcoord.xy;
					o.ase_texcoord.zw = v.ase_texcoord1.xy;
					
					//setting value to unused interpolator channels and avoid initialization warnings
					o.ase_texcoord1.w = 0;
					o.ase_texcoord2.w = 0;
					o.ase_texcoord3.w = 0;

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = appendResult410;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = v.normal;

					o.pos = UnityObjectToClipPos( v.vertex );

					#if defined( ASE_SHADOWS )
						UNITY_TRANSFER_SHADOW( o, v.texcoord );
					#endif
					return o;
				}

				half4 frag( v2f IN 
							#if defined( ASE_DEPTH_WRITE_ON )
								, out float outputDepth : SV_Depth
							#endif
				) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID( IN );
					UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

					float4 ScreenPosNorm = float4( IN.pos.xy * ( _ScreenParams.zw - 1.0 ), IN.pos.zw );
					float4 ClipPos = ComputeClipSpacePosition( ScreenPosNorm.xy, IN.pos.z ) * IN.pos.w;
					float4 ScreenPos = ComputeScreenPos( ClipPos );

					float Packer_Transform362 = _PackerTransformMode;
					float Action1554_g251750 = _PackerActionR1;
					float Action0173_g251750 = _PackerActionR0;
					float Channel31_g251750 = _PackerChannelR;
					float ifLocalVar40_g251751 = 0;
					if( Channel31_g251750 == 0.0 )
					ifLocalVar40_g251751 = _PackerFloatR;
					float Index42_g375 = _PackerCoordR;
					float2 ifLocalVar40_g375 = 0;
					if( Index42_g375 == 0.0 )
					ifLocalVar40_g375 = IN.ase_texcoord.xy;
					float2 ifLocalVar47_g375 = 0;
					if( Index42_g375 == 1.0 )
					ifLocalVar47_g375 = IN.ase_texcoord.zw;
					float2 ifLocalVar50_g375 = 0;
					if( Index42_g375 == 2.0 )
					ifLocalVar50_g375 = IN.ase_texcoord.zw;
					float2 ifLocalVar54_g375 = 0;
					if( Index42_g375 == 3.0 )
					ifLocalVar54_g375 = IN.ase_texcoord.zw;
					float4 temp_output_19_0_g251750 = tex2Dlod( _PackerTexR, float4( ( ifLocalVar40_g375 + ifLocalVar47_g375 + ifLocalVar50_g375 + ifLocalVar54_g375 ), 0, 0.0) );
					float4 temp_output_28_0_g251756 = temp_output_19_0_g251750;
					float3 temp_output_29_0_g251756 = (temp_output_28_0_g251756).xyz;
					half3 linRGB27_g251756 = temp_output_29_0_g251756;
					half3 localLinearToGammaFloatFast27_g251756 = LinearToGammaFloatFast( linRGB27_g251756 );
					#ifdef UNITY_COLORSPACE_GAMMA
					float3 staticSwitch26_g251756 = temp_output_29_0_g251756;
					#else
					float3 staticSwitch26_g251756 = localLinearToGammaFloatFast27_g251756;
					#endif
					float4 appendResult31_g251756 = (float4(staticSwitch26_g251756 , (temp_output_28_0_g251756).w));
					float IsGamma528_g251750 = _PackerTexGammaModeR;
					float4 lerpResult531_g251750 = lerp( temp_output_19_0_g251750 , appendResult31_g251756 , IsGamma528_g251750);
					float4 break23_g251750 = lerpResult531_g251750;
					float R39_g251750 = break23_g251750.x;
					float ifLocalVar40_g251752 = 0;
					if( Channel31_g251750 == 1.0 )
					ifLocalVar40_g251752 = R39_g251750;
					float G40_g251750 = break23_g251750.y;
					float ifLocalVar40_g251753 = 0;
					if( Channel31_g251750 == 2.0 )
					ifLocalVar40_g251753 = G40_g251750;
					float B41_g251750 = break23_g251750.z;
					float ifLocalVar40_g251754 = 0;
					if( Channel31_g251750 == 3.0 )
					ifLocalVar40_g251754 = B41_g251750;
					float A42_g251750 = break23_g251750.w;
					float ifLocalVar40_g251755 = 0;
					if( Channel31_g251750 == 4.0 )
					ifLocalVar40_g251755 = A42_g251750;
					float Compute_Max265_g251750 = max( max( R39_g251750, G40_g251750 ), B41_g251750 );
					float ifLocalVar40_g251777 = 0;
					if( Channel31_g251750 == 111.0 )
					ifLocalVar40_g251777 = Compute_Max265_g251750;
					float Compute_MaxAll596_g251750 = max( max( max( R39_g251750, G40_g251750 ), B41_g251750 ), A42_g251750 );
					float ifLocalVar40_g251778 = 0;
					if( Channel31_g251750 == 222.0 )
					ifLocalVar40_g251778 = Compute_MaxAll596_g251750;
					float3 RGB258_g251750 = (lerpResult531_g251750).xyz;
					float3 temp_output_3_0_g251757 = RGB258_g251750;
					float dotResult20_g251757 = dot( temp_output_3_0_g251757 , float3( 0.2126, 0.7152, 0.0722 ) );
					float Compute_Gray135_g251750 = dotResult20_g251757;
					float ifLocalVar40_g251776 = 0;
					if( Channel31_g251750 == 555.0 )
					ifLocalVar40_g251776 = Compute_Gray135_g251750;
					float Packed_Raw182_g251750 = ( ifLocalVar40_g251751 + ( ifLocalVar40_g251752 + ifLocalVar40_g251753 + ifLocalVar40_g251754 + ifLocalVar40_g251755 ) + ( ifLocalVar40_g251777 + ifLocalVar40_g251778 + ifLocalVar40_g251776 ) );
					float ifLocalVar40_g251758 = 0;
					if( Action0173_g251750 == 0.0 )
					ifLocalVar40_g251758 = Packed_Raw182_g251750;
					float ifLocalVar40_g251759 = 0;
					if( Action0173_g251750 == 1.0 )
					ifLocalVar40_g251759 = ( 1.0 - Packed_Raw182_g251750 );
					float Value0187_g251750 = _PackerValueR0;
					float ifLocalVar40_g251760 = 0;
					if( Action0173_g251750 == 2.0 )
					ifLocalVar40_g251760 = ( Packed_Raw182_g251750 * Value0187_g251750 );
					float ifLocalVar335_g251750 = 0;
					if( Packed_Raw182_g251750 <= 0.99 )
					ifLocalVar335_g251750 = 0.0;
					else
					ifLocalVar335_g251750 = 1.0;
					float ifLocalVar40_g251761 = 0;
					if( Action0173_g251750 == 11.0 )
					ifLocalVar40_g251761 = ifLocalVar335_g251750;
					float ifLocalVar346_g251750 = 0;
					if( Packed_Raw182_g251750 <= 0.01 )
					ifLocalVar346_g251750 = 1.0;
					else
					ifLocalVar346_g251750 = 0.0;
					float ifLocalVar40_g251762 = 0;
					if( Action0173_g251750 == 12.0 )
					ifLocalVar40_g251762 = ifLocalVar346_g251750;
					float temp_output_15_0_g251765 = Packed_Raw182_g251750;
					half linRGB24_g251765 = temp_output_15_0_g251765;
					half localLinearToGammaFloatFast24_g251765 = LinearToGammaFloatFast( linRGB24_g251765 );
					#ifdef UNITY_COLORSPACE_GAMMA
					float staticSwitch14_g251765 = temp_output_15_0_g251765;
					#else
					float staticSwitch14_g251765 = localLinearToGammaFloatFast24_g251765;
					#endif
					float ifLocalVar40_g251763 = 0;
					if( Action0173_g251750 == 20.0 )
					ifLocalVar40_g251763 = staticSwitch14_g251765;
					float temp_output_9_0_g251766 = Packed_Raw182_g251750;
					half sRGB8_g251766 = temp_output_9_0_g251766;
					half localGammaToLinearFloatFast8_g251766 = GammaToLinearFloatFast( sRGB8_g251766 );
					#ifdef UNITY_COLORSPACE_GAMMA
					float staticSwitch1_g251766 = temp_output_9_0_g251766;
					#else
					float staticSwitch1_g251766 = localGammaToLinearFloatFast8_g251766;
					#endif
					float ifLocalVar40_g251764 = 0;
					if( Action0173_g251750 == 21.0 )
					ifLocalVar40_g251764 = staticSwitch1_g251766;
					float Packed_Action0550_g251750 = saturate( ( ( ifLocalVar40_g251758 + ifLocalVar40_g251759 ) + ( ifLocalVar40_g251760 + 0.0 ) + ( ifLocalVar40_g251761 + ifLocalVar40_g251762 ) + ( ifLocalVar40_g251763 + ifLocalVar40_g251764 ) ) );
					float ifLocalVar40_g251767 = 0;
					if( Action1554_g251750 == 0.0 )
					ifLocalVar40_g251767 = Packed_Action0550_g251750;
					float ifLocalVar40_g251768 = 0;
					if( Action1554_g251750 == 1.0 )
					ifLocalVar40_g251768 = ( 1.0 - Packed_Action0550_g251750 );
					float Value1553_g251750 = _PackerValueR1;
					float ifLocalVar40_g251769 = 0;
					if( Action1554_g251750 == 2.0 )
					ifLocalVar40_g251769 = ( Packed_Action0550_g251750 * Value1553_g251750 );
					float ifLocalVar577_g251750 = 0;
					if( Packed_Action0550_g251750 <= 0.99 )
					ifLocalVar577_g251750 = 0.0;
					else
					ifLocalVar577_g251750 = 1.0;
					float ifLocalVar40_g251770 = 0;
					if( Action1554_g251750 == 11.0 )
					ifLocalVar40_g251770 = ifLocalVar577_g251750;
					float ifLocalVar578_g251750 = 0;
					if( Packed_Action0550_g251750 <= 0.01 )
					ifLocalVar578_g251750 = 1.0;
					else
					ifLocalVar578_g251750 = 0.0;
					float ifLocalVar40_g251771 = 0;
					if( Action1554_g251750 == 12.0 )
					ifLocalVar40_g251771 = ifLocalVar578_g251750;
					float temp_output_15_0_g251774 = Packed_Action0550_g251750;
					half linRGB24_g251774 = temp_output_15_0_g251774;
					half localLinearToGammaFloatFast24_g251774 = LinearToGammaFloatFast( linRGB24_g251774 );
					#ifdef UNITY_COLORSPACE_GAMMA
					float staticSwitch14_g251774 = temp_output_15_0_g251774;
					#else
					float staticSwitch14_g251774 = localLinearToGammaFloatFast24_g251774;
					#endif
					float ifLocalVar40_g251772 = 0;
					if( Action1554_g251750 == 20.0 )
					ifLocalVar40_g251772 = staticSwitch14_g251774;
					float temp_output_9_0_g251775 = Packed_Action0550_g251750;
					half sRGB8_g251775 = temp_output_9_0_g251775;
					half localGammaToLinearFloatFast8_g251775 = GammaToLinearFloatFast( sRGB8_g251775 );
					#ifdef UNITY_COLORSPACE_GAMMA
					float staticSwitch1_g251775 = temp_output_9_0_g251775;
					#else
					float staticSwitch1_g251775 = localGammaToLinearFloatFast8_g251775;
					#endif
					float ifLocalVar40_g251773 = 0;
					if( Action1554_g251750 == 21.0 )
					ifLocalVar40_g251773 = staticSwitch1_g251775;
					float R74 = saturate( ( ( ifLocalVar40_g251767 + ifLocalVar40_g251768 ) + ( ifLocalVar40_g251769 + 0.0 ) + ( ifLocalVar40_g251770 + ifLocalVar40_g251771 ) + ( ifLocalVar40_g251772 + ifLocalVar40_g251773 ) ) );
					float Action1554_g251721 = _PackerActionG1;
					float Action0173_g251721 = _PackerActionG0;
					float Channel31_g251721 = _PackerChannelG;
					float ifLocalVar40_g251722 = 0;
					if( Channel31_g251721 == 0.0 )
					ifLocalVar40_g251722 = _PackerFloatG;
					float Index42_g374 = _PackerCoordG;
					float2 ifLocalVar40_g374 = 0;
					if( Index42_g374 == 0.0 )
					ifLocalVar40_g374 = IN.ase_texcoord.xy;
					float2 ifLocalVar47_g374 = 0;
					if( Index42_g374 == 1.0 )
					ifLocalVar47_g374 = IN.ase_texcoord.zw;
					float2 ifLocalVar50_g374 = 0;
					if( Index42_g374 == 2.0 )
					ifLocalVar50_g374 = IN.ase_texcoord.zw;
					float2 ifLocalVar54_g374 = 0;
					if( Index42_g374 == 3.0 )
					ifLocalVar54_g374 = IN.ase_texcoord.zw;
					float4 temp_output_19_0_g251721 = tex2Dlod( _PackerTexG, float4( ( ifLocalVar40_g374 + ifLocalVar47_g374 + ifLocalVar50_g374 + ifLocalVar54_g374 ), 0, 0.0) );
					float4 temp_output_28_0_g251727 = temp_output_19_0_g251721;
					float3 temp_output_29_0_g251727 = (temp_output_28_0_g251727).xyz;
					half3 linRGB27_g251727 = temp_output_29_0_g251727;
					half3 localLinearToGammaFloatFast27_g251727 = LinearToGammaFloatFast( linRGB27_g251727 );
					#ifdef UNITY_COLORSPACE_GAMMA
					float3 staticSwitch26_g251727 = temp_output_29_0_g251727;
					#else
					float3 staticSwitch26_g251727 = localLinearToGammaFloatFast27_g251727;
					#endif
					float4 appendResult31_g251727 = (float4(staticSwitch26_g251727 , (temp_output_28_0_g251727).w));
					float IsGamma528_g251721 = _PackerTexGammaModeG;
					float4 lerpResult531_g251721 = lerp( temp_output_19_0_g251721 , appendResult31_g251727 , IsGamma528_g251721);
					float4 break23_g251721 = lerpResult531_g251721;
					float R39_g251721 = break23_g251721.x;
					float ifLocalVar40_g251723 = 0;
					if( Channel31_g251721 == 1.0 )
					ifLocalVar40_g251723 = R39_g251721;
					float G40_g251721 = break23_g251721.y;
					float ifLocalVar40_g251724 = 0;
					if( Channel31_g251721 == 2.0 )
					ifLocalVar40_g251724 = G40_g251721;
					float B41_g251721 = break23_g251721.z;
					float ifLocalVar40_g251725 = 0;
					if( Channel31_g251721 == 3.0 )
					ifLocalVar40_g251725 = B41_g251721;
					float A42_g251721 = break23_g251721.w;
					float ifLocalVar40_g251726 = 0;
					if( Channel31_g251721 == 4.0 )
					ifLocalVar40_g251726 = A42_g251721;
					float Compute_Max265_g251721 = max( max( R39_g251721, G40_g251721 ), B41_g251721 );
					float ifLocalVar40_g251748 = 0;
					if( Channel31_g251721 == 111.0 )
					ifLocalVar40_g251748 = Compute_Max265_g251721;
					float Compute_MaxAll596_g251721 = max( max( max( R39_g251721, G40_g251721 ), B41_g251721 ), A42_g251721 );
					float ifLocalVar40_g251749 = 0;
					if( Channel31_g251721 == 222.0 )
					ifLocalVar40_g251749 = Compute_MaxAll596_g251721;
					float3 RGB258_g251721 = (lerpResult531_g251721).xyz;
					float3 temp_output_3_0_g251728 = RGB258_g251721;
					float dotResult20_g251728 = dot( temp_output_3_0_g251728 , float3( 0.2126, 0.7152, 0.0722 ) );
					float Compute_Gray135_g251721 = dotResult20_g251728;
					float ifLocalVar40_g251747 = 0;
					if( Channel31_g251721 == 555.0 )
					ifLocalVar40_g251747 = Compute_Gray135_g251721;
					float Packed_Raw182_g251721 = ( ifLocalVar40_g251722 + ( ifLocalVar40_g251723 + ifLocalVar40_g251724 + ifLocalVar40_g251725 + ifLocalVar40_g251726 ) + ( ifLocalVar40_g251748 + ifLocalVar40_g251749 + ifLocalVar40_g251747 ) );
					float ifLocalVar40_g251729 = 0;
					if( Action0173_g251721 == 0.0 )
					ifLocalVar40_g251729 = Packed_Raw182_g251721;
					float ifLocalVar40_g251730 = 0;
					if( Action0173_g251721 == 1.0 )
					ifLocalVar40_g251730 = ( 1.0 - Packed_Raw182_g251721 );
					float Value0187_g251721 = _PackerValueG0;
					float ifLocalVar40_g251731 = 0;
					if( Action0173_g251721 == 2.0 )
					ifLocalVar40_g251731 = ( Packed_Raw182_g251721 * Value0187_g251721 );
					float ifLocalVar335_g251721 = 0;
					if( Packed_Raw182_g251721 <= 0.99 )
					ifLocalVar335_g251721 = 0.0;
					else
					ifLocalVar335_g251721 = 1.0;
					float ifLocalVar40_g251732 = 0;
					if( Action0173_g251721 == 11.0 )
					ifLocalVar40_g251732 = ifLocalVar335_g251721;
					float ifLocalVar346_g251721 = 0;
					if( Packed_Raw182_g251721 <= 0.01 )
					ifLocalVar346_g251721 = 1.0;
					else
					ifLocalVar346_g251721 = 0.0;
					float ifLocalVar40_g251733 = 0;
					if( Action0173_g251721 == 12.0 )
					ifLocalVar40_g251733 = ifLocalVar346_g251721;
					float temp_output_15_0_g251736 = Packed_Raw182_g251721;
					half linRGB24_g251736 = temp_output_15_0_g251736;
					half localLinearToGammaFloatFast24_g251736 = LinearToGammaFloatFast( linRGB24_g251736 );
					#ifdef UNITY_COLORSPACE_GAMMA
					float staticSwitch14_g251736 = temp_output_15_0_g251736;
					#else
					float staticSwitch14_g251736 = localLinearToGammaFloatFast24_g251736;
					#endif
					float ifLocalVar40_g251734 = 0;
					if( Action0173_g251721 == 20.0 )
					ifLocalVar40_g251734 = staticSwitch14_g251736;
					float temp_output_9_0_g251737 = Packed_Raw182_g251721;
					half sRGB8_g251737 = temp_output_9_0_g251737;
					half localGammaToLinearFloatFast8_g251737 = GammaToLinearFloatFast( sRGB8_g251737 );
					#ifdef UNITY_COLORSPACE_GAMMA
					float staticSwitch1_g251737 = temp_output_9_0_g251737;
					#else
					float staticSwitch1_g251737 = localGammaToLinearFloatFast8_g251737;
					#endif
					float ifLocalVar40_g251735 = 0;
					if( Action0173_g251721 == 21.0 )
					ifLocalVar40_g251735 = staticSwitch1_g251737;
					float Packed_Action0550_g251721 = saturate( ( ( ifLocalVar40_g251729 + ifLocalVar40_g251730 ) + ( ifLocalVar40_g251731 + 0.0 ) + ( ifLocalVar40_g251732 + ifLocalVar40_g251733 ) + ( ifLocalVar40_g251734 + ifLocalVar40_g251735 ) ) );
					float ifLocalVar40_g251738 = 0;
					if( Action1554_g251721 == 0.0 )
					ifLocalVar40_g251738 = Packed_Action0550_g251721;
					float ifLocalVar40_g251739 = 0;
					if( Action1554_g251721 == 1.0 )
					ifLocalVar40_g251739 = ( 1.0 - Packed_Action0550_g251721 );
					float Value1553_g251721 = _PackerValueG1;
					float ifLocalVar40_g251740 = 0;
					if( Action1554_g251721 == 2.0 )
					ifLocalVar40_g251740 = ( Packed_Action0550_g251721 * Value1553_g251721 );
					float ifLocalVar577_g251721 = 0;
					if( Packed_Action0550_g251721 <= 0.99 )
					ifLocalVar577_g251721 = 0.0;
					else
					ifLocalVar577_g251721 = 1.0;
					float ifLocalVar40_g251741 = 0;
					if( Action1554_g251721 == 11.0 )
					ifLocalVar40_g251741 = ifLocalVar577_g251721;
					float ifLocalVar578_g251721 = 0;
					if( Packed_Action0550_g251721 <= 0.01 )
					ifLocalVar578_g251721 = 1.0;
					else
					ifLocalVar578_g251721 = 0.0;
					float ifLocalVar40_g251742 = 0;
					if( Action1554_g251721 == 12.0 )
					ifLocalVar40_g251742 = ifLocalVar578_g251721;
					float temp_output_15_0_g251745 = Packed_Action0550_g251721;
					half linRGB24_g251745 = temp_output_15_0_g251745;
					half localLinearToGammaFloatFast24_g251745 = LinearToGammaFloatFast( linRGB24_g251745 );
					#ifdef UNITY_COLORSPACE_GAMMA
					float staticSwitch14_g251745 = temp_output_15_0_g251745;
					#else
					float staticSwitch14_g251745 = localLinearToGammaFloatFast24_g251745;
					#endif
					float ifLocalVar40_g251743 = 0;
					if( Action1554_g251721 == 20.0 )
					ifLocalVar40_g251743 = staticSwitch14_g251745;
					float temp_output_9_0_g251746 = Packed_Action0550_g251721;
					half sRGB8_g251746 = temp_output_9_0_g251746;
					half localGammaToLinearFloatFast8_g251746 = GammaToLinearFloatFast( sRGB8_g251746 );
					#ifdef UNITY_COLORSPACE_GAMMA
					float staticSwitch1_g251746 = temp_output_9_0_g251746;
					#else
					float staticSwitch1_g251746 = localGammaToLinearFloatFast8_g251746;
					#endif
					float ifLocalVar40_g251744 = 0;
					if( Action1554_g251721 == 21.0 )
					ifLocalVar40_g251744 = staticSwitch1_g251746;
					float G78 = saturate( ( ( ifLocalVar40_g251738 + ifLocalVar40_g251739 ) + ( ifLocalVar40_g251740 + 0.0 ) + ( ifLocalVar40_g251741 + ifLocalVar40_g251742 ) + ( ifLocalVar40_g251743 + ifLocalVar40_g251744 ) ) );
					float Action1554_g251692 = _PackerActionB1;
					float Action0173_g251692 = _PackerActionB0;
					float Channel31_g251692 = _PackerChannelB;
					float ifLocalVar40_g251693 = 0;
					if( Channel31_g251692 == 0.0 )
					ifLocalVar40_g251693 = _PackerFloatB;
					float Index42_g373 = _PackerCoordB;
					float2 ifLocalVar40_g373 = 0;
					if( Index42_g373 == 0.0 )
					ifLocalVar40_g373 = IN.ase_texcoord.xy;
					float2 ifLocalVar47_g373 = 0;
					if( Index42_g373 == 1.0 )
					ifLocalVar47_g373 = IN.ase_texcoord.zw;
					float2 ifLocalVar50_g373 = 0;
					if( Index42_g373 == 2.0 )
					ifLocalVar50_g373 = IN.ase_texcoord.zw;
					float2 ifLocalVar54_g373 = 0;
					if( Index42_g373 == 3.0 )
					ifLocalVar54_g373 = IN.ase_texcoord.zw;
					float4 temp_output_19_0_g251692 = tex2Dlod( _PackerTexB, float4( ( ifLocalVar40_g373 + ifLocalVar47_g373 + ifLocalVar50_g373 + ifLocalVar54_g373 ), 0, 0.0) );
					float4 temp_output_28_0_g251698 = temp_output_19_0_g251692;
					float3 temp_output_29_0_g251698 = (temp_output_28_0_g251698).xyz;
					half3 linRGB27_g251698 = temp_output_29_0_g251698;
					half3 localLinearToGammaFloatFast27_g251698 = LinearToGammaFloatFast( linRGB27_g251698 );
					#ifdef UNITY_COLORSPACE_GAMMA
					float3 staticSwitch26_g251698 = temp_output_29_0_g251698;
					#else
					float3 staticSwitch26_g251698 = localLinearToGammaFloatFast27_g251698;
					#endif
					float4 appendResult31_g251698 = (float4(staticSwitch26_g251698 , (temp_output_28_0_g251698).w));
					float IsGamma528_g251692 = _PackerTexGammaModeB;
					float4 lerpResult531_g251692 = lerp( temp_output_19_0_g251692 , appendResult31_g251698 , IsGamma528_g251692);
					float4 break23_g251692 = lerpResult531_g251692;
					float R39_g251692 = break23_g251692.x;
					float ifLocalVar40_g251694 = 0;
					if( Channel31_g251692 == 1.0 )
					ifLocalVar40_g251694 = R39_g251692;
					float G40_g251692 = break23_g251692.y;
					float ifLocalVar40_g251695 = 0;
					if( Channel31_g251692 == 2.0 )
					ifLocalVar40_g251695 = G40_g251692;
					float B41_g251692 = break23_g251692.z;
					float ifLocalVar40_g251696 = 0;
					if( Channel31_g251692 == 3.0 )
					ifLocalVar40_g251696 = B41_g251692;
					float A42_g251692 = break23_g251692.w;
					float ifLocalVar40_g251697 = 0;
					if( Channel31_g251692 == 4.0 )
					ifLocalVar40_g251697 = A42_g251692;
					float Compute_Max265_g251692 = max( max( R39_g251692, G40_g251692 ), B41_g251692 );
					float ifLocalVar40_g251719 = 0;
					if( Channel31_g251692 == 111.0 )
					ifLocalVar40_g251719 = Compute_Max265_g251692;
					float Compute_MaxAll596_g251692 = max( max( max( R39_g251692, G40_g251692 ), B41_g251692 ), A42_g251692 );
					float ifLocalVar40_g251720 = 0;
					if( Channel31_g251692 == 222.0 )
					ifLocalVar40_g251720 = Compute_MaxAll596_g251692;
					float3 RGB258_g251692 = (lerpResult531_g251692).xyz;
					float3 temp_output_3_0_g251699 = RGB258_g251692;
					float dotResult20_g251699 = dot( temp_output_3_0_g251699 , float3( 0.2126, 0.7152, 0.0722 ) );
					float Compute_Gray135_g251692 = dotResult20_g251699;
					float ifLocalVar40_g251718 = 0;
					if( Channel31_g251692 == 555.0 )
					ifLocalVar40_g251718 = Compute_Gray135_g251692;
					float Packed_Raw182_g251692 = ( ifLocalVar40_g251693 + ( ifLocalVar40_g251694 + ifLocalVar40_g251695 + ifLocalVar40_g251696 + ifLocalVar40_g251697 ) + ( ifLocalVar40_g251719 + ifLocalVar40_g251720 + ifLocalVar40_g251718 ) );
					float ifLocalVar40_g251700 = 0;
					if( Action0173_g251692 == 0.0 )
					ifLocalVar40_g251700 = Packed_Raw182_g251692;
					float ifLocalVar40_g251701 = 0;
					if( Action0173_g251692 == 1.0 )
					ifLocalVar40_g251701 = ( 1.0 - Packed_Raw182_g251692 );
					float Value0187_g251692 = _PackerValueB0;
					float ifLocalVar40_g251702 = 0;
					if( Action0173_g251692 == 2.0 )
					ifLocalVar40_g251702 = ( Packed_Raw182_g251692 * Value0187_g251692 );
					float ifLocalVar335_g251692 = 0;
					if( Packed_Raw182_g251692 <= 0.99 )
					ifLocalVar335_g251692 = 0.0;
					else
					ifLocalVar335_g251692 = 1.0;
					float ifLocalVar40_g251703 = 0;
					if( Action0173_g251692 == 11.0 )
					ifLocalVar40_g251703 = ifLocalVar335_g251692;
					float ifLocalVar346_g251692 = 0;
					if( Packed_Raw182_g251692 <= 0.01 )
					ifLocalVar346_g251692 = 1.0;
					else
					ifLocalVar346_g251692 = 0.0;
					float ifLocalVar40_g251704 = 0;
					if( Action0173_g251692 == 12.0 )
					ifLocalVar40_g251704 = ifLocalVar346_g251692;
					float temp_output_15_0_g251707 = Packed_Raw182_g251692;
					half linRGB24_g251707 = temp_output_15_0_g251707;
					half localLinearToGammaFloatFast24_g251707 = LinearToGammaFloatFast( linRGB24_g251707 );
					#ifdef UNITY_COLORSPACE_GAMMA
					float staticSwitch14_g251707 = temp_output_15_0_g251707;
					#else
					float staticSwitch14_g251707 = localLinearToGammaFloatFast24_g251707;
					#endif
					float ifLocalVar40_g251705 = 0;
					if( Action0173_g251692 == 20.0 )
					ifLocalVar40_g251705 = staticSwitch14_g251707;
					float temp_output_9_0_g251708 = Packed_Raw182_g251692;
					half sRGB8_g251708 = temp_output_9_0_g251708;
					half localGammaToLinearFloatFast8_g251708 = GammaToLinearFloatFast( sRGB8_g251708 );
					#ifdef UNITY_COLORSPACE_GAMMA
					float staticSwitch1_g251708 = temp_output_9_0_g251708;
					#else
					float staticSwitch1_g251708 = localGammaToLinearFloatFast8_g251708;
					#endif
					float ifLocalVar40_g251706 = 0;
					if( Action0173_g251692 == 21.0 )
					ifLocalVar40_g251706 = staticSwitch1_g251708;
					float Packed_Action0550_g251692 = saturate( ( ( ifLocalVar40_g251700 + ifLocalVar40_g251701 ) + ( ifLocalVar40_g251702 + 0.0 ) + ( ifLocalVar40_g251703 + ifLocalVar40_g251704 ) + ( ifLocalVar40_g251705 + ifLocalVar40_g251706 ) ) );
					float ifLocalVar40_g251709 = 0;
					if( Action1554_g251692 == 0.0 )
					ifLocalVar40_g251709 = Packed_Action0550_g251692;
					float ifLocalVar40_g251710 = 0;
					if( Action1554_g251692 == 1.0 )
					ifLocalVar40_g251710 = ( 1.0 - Packed_Action0550_g251692 );
					float Value1553_g251692 = _PackerValueB1;
					float ifLocalVar40_g251711 = 0;
					if( Action1554_g251692 == 2.0 )
					ifLocalVar40_g251711 = ( Packed_Action0550_g251692 * Value1553_g251692 );
					float ifLocalVar577_g251692 = 0;
					if( Packed_Action0550_g251692 <= 0.99 )
					ifLocalVar577_g251692 = 0.0;
					else
					ifLocalVar577_g251692 = 1.0;
					float ifLocalVar40_g251712 = 0;
					if( Action1554_g251692 == 11.0 )
					ifLocalVar40_g251712 = ifLocalVar577_g251692;
					float ifLocalVar578_g251692 = 0;
					if( Packed_Action0550_g251692 <= 0.01 )
					ifLocalVar578_g251692 = 1.0;
					else
					ifLocalVar578_g251692 = 0.0;
					float ifLocalVar40_g251713 = 0;
					if( Action1554_g251692 == 12.0 )
					ifLocalVar40_g251713 = ifLocalVar578_g251692;
					float temp_output_15_0_g251716 = Packed_Action0550_g251692;
					half linRGB24_g251716 = temp_output_15_0_g251716;
					half localLinearToGammaFloatFast24_g251716 = LinearToGammaFloatFast( linRGB24_g251716 );
					#ifdef UNITY_COLORSPACE_GAMMA
					float staticSwitch14_g251716 = temp_output_15_0_g251716;
					#else
					float staticSwitch14_g251716 = localLinearToGammaFloatFast24_g251716;
					#endif
					float ifLocalVar40_g251714 = 0;
					if( Action1554_g251692 == 20.0 )
					ifLocalVar40_g251714 = staticSwitch14_g251716;
					float temp_output_9_0_g251717 = Packed_Action0550_g251692;
					half sRGB8_g251717 = temp_output_9_0_g251717;
					half localGammaToLinearFloatFast8_g251717 = GammaToLinearFloatFast( sRGB8_g251717 );
					#ifdef UNITY_COLORSPACE_GAMMA
					float staticSwitch1_g251717 = temp_output_9_0_g251717;
					#else
					float staticSwitch1_g251717 = localGammaToLinearFloatFast8_g251717;
					#endif
					float ifLocalVar40_g251715 = 0;
					if( Action1554_g251692 == 21.0 )
					ifLocalVar40_g251715 = staticSwitch1_g251717;
					float B79 = saturate( ( ( ifLocalVar40_g251709 + ifLocalVar40_g251710 ) + ( ifLocalVar40_g251711 + 0.0 ) + ( ifLocalVar40_g251712 + ifLocalVar40_g251713 ) + ( ifLocalVar40_g251714 + ifLocalVar40_g251715 ) ) );
					float Action1554_g251779 = _PackerActionA1;
					float Action0173_g251779 = _PackerActionA0;
					float Channel31_g251779 = _PackerChannelA;
					float ifLocalVar40_g251780 = 0;
					if( Channel31_g251779 == 0.0 )
					ifLocalVar40_g251780 = _PackerFloatA;
					float Index42_g372 = _PackerCoordA;
					float2 ifLocalVar40_g372 = 0;
					if( Index42_g372 == 0.0 )
					ifLocalVar40_g372 = IN.ase_texcoord.xy;
					float2 ifLocalVar47_g372 = 0;
					if( Index42_g372 == 1.0 )
					ifLocalVar47_g372 = IN.ase_texcoord.zw;
					float2 ifLocalVar50_g372 = 0;
					if( Index42_g372 == 2.0 )
					ifLocalVar50_g372 = IN.ase_texcoord.zw;
					float2 ifLocalVar54_g372 = 0;
					if( Index42_g372 == 3.0 )
					ifLocalVar54_g372 = IN.ase_texcoord.zw;
					float4 temp_output_19_0_g251779 = tex2Dlod( _PackerTexA, float4( ( ifLocalVar40_g372 + ifLocalVar47_g372 + ifLocalVar50_g372 + ifLocalVar54_g372 ), 0, 0.0) );
					float4 temp_output_28_0_g251785 = temp_output_19_0_g251779;
					float3 temp_output_29_0_g251785 = (temp_output_28_0_g251785).xyz;
					half3 linRGB27_g251785 = temp_output_29_0_g251785;
					half3 localLinearToGammaFloatFast27_g251785 = LinearToGammaFloatFast( linRGB27_g251785 );
					#ifdef UNITY_COLORSPACE_GAMMA
					float3 staticSwitch26_g251785 = temp_output_29_0_g251785;
					#else
					float3 staticSwitch26_g251785 = localLinearToGammaFloatFast27_g251785;
					#endif
					float4 appendResult31_g251785 = (float4(staticSwitch26_g251785 , (temp_output_28_0_g251785).w));
					float IsGamma528_g251779 = _PackerTexGammaModeA;
					float4 lerpResult531_g251779 = lerp( temp_output_19_0_g251779 , appendResult31_g251785 , IsGamma528_g251779);
					float4 break23_g251779 = lerpResult531_g251779;
					float R39_g251779 = break23_g251779.x;
					float ifLocalVar40_g251781 = 0;
					if( Channel31_g251779 == 1.0 )
					ifLocalVar40_g251781 = R39_g251779;
					float G40_g251779 = break23_g251779.y;
					float ifLocalVar40_g251782 = 0;
					if( Channel31_g251779 == 2.0 )
					ifLocalVar40_g251782 = G40_g251779;
					float B41_g251779 = break23_g251779.z;
					float ifLocalVar40_g251783 = 0;
					if( Channel31_g251779 == 3.0 )
					ifLocalVar40_g251783 = B41_g251779;
					float A42_g251779 = break23_g251779.w;
					float ifLocalVar40_g251784 = 0;
					if( Channel31_g251779 == 4.0 )
					ifLocalVar40_g251784 = A42_g251779;
					float Compute_Max265_g251779 = max( max( R39_g251779, G40_g251779 ), B41_g251779 );
					float ifLocalVar40_g251806 = 0;
					if( Channel31_g251779 == 111.0 )
					ifLocalVar40_g251806 = Compute_Max265_g251779;
					float Compute_MaxAll596_g251779 = max( max( max( R39_g251779, G40_g251779 ), B41_g251779 ), A42_g251779 );
					float ifLocalVar40_g251807 = 0;
					if( Channel31_g251779 == 222.0 )
					ifLocalVar40_g251807 = Compute_MaxAll596_g251779;
					float3 RGB258_g251779 = (lerpResult531_g251779).xyz;
					float3 temp_output_3_0_g251786 = RGB258_g251779;
					float dotResult20_g251786 = dot( temp_output_3_0_g251786 , float3( 0.2126, 0.7152, 0.0722 ) );
					float Compute_Gray135_g251779 = dotResult20_g251786;
					float ifLocalVar40_g251805 = 0;
					if( Channel31_g251779 == 555.0 )
					ifLocalVar40_g251805 = Compute_Gray135_g251779;
					float Packed_Raw182_g251779 = ( ifLocalVar40_g251780 + ( ifLocalVar40_g251781 + ifLocalVar40_g251782 + ifLocalVar40_g251783 + ifLocalVar40_g251784 ) + ( ifLocalVar40_g251806 + ifLocalVar40_g251807 + ifLocalVar40_g251805 ) );
					float ifLocalVar40_g251787 = 0;
					if( Action0173_g251779 == 0.0 )
					ifLocalVar40_g251787 = Packed_Raw182_g251779;
					float ifLocalVar40_g251788 = 0;
					if( Action0173_g251779 == 1.0 )
					ifLocalVar40_g251788 = ( 1.0 - Packed_Raw182_g251779 );
					float Value0187_g251779 = _PackerValueA0;
					float ifLocalVar40_g251789 = 0;
					if( Action0173_g251779 == 2.0 )
					ifLocalVar40_g251789 = ( Packed_Raw182_g251779 * Value0187_g251779 );
					float ifLocalVar335_g251779 = 0;
					if( Packed_Raw182_g251779 <= 0.99 )
					ifLocalVar335_g251779 = 0.0;
					else
					ifLocalVar335_g251779 = 1.0;
					float ifLocalVar40_g251790 = 0;
					if( Action0173_g251779 == 11.0 )
					ifLocalVar40_g251790 = ifLocalVar335_g251779;
					float ifLocalVar346_g251779 = 0;
					if( Packed_Raw182_g251779 <= 0.01 )
					ifLocalVar346_g251779 = 1.0;
					else
					ifLocalVar346_g251779 = 0.0;
					float ifLocalVar40_g251791 = 0;
					if( Action0173_g251779 == 12.0 )
					ifLocalVar40_g251791 = ifLocalVar346_g251779;
					float temp_output_15_0_g251794 = Packed_Raw182_g251779;
					half linRGB24_g251794 = temp_output_15_0_g251794;
					half localLinearToGammaFloatFast24_g251794 = LinearToGammaFloatFast( linRGB24_g251794 );
					#ifdef UNITY_COLORSPACE_GAMMA
					float staticSwitch14_g251794 = temp_output_15_0_g251794;
					#else
					float staticSwitch14_g251794 = localLinearToGammaFloatFast24_g251794;
					#endif
					float ifLocalVar40_g251792 = 0;
					if( Action0173_g251779 == 20.0 )
					ifLocalVar40_g251792 = staticSwitch14_g251794;
					float temp_output_9_0_g251795 = Packed_Raw182_g251779;
					half sRGB8_g251795 = temp_output_9_0_g251795;
					half localGammaToLinearFloatFast8_g251795 = GammaToLinearFloatFast( sRGB8_g251795 );
					#ifdef UNITY_COLORSPACE_GAMMA
					float staticSwitch1_g251795 = temp_output_9_0_g251795;
					#else
					float staticSwitch1_g251795 = localGammaToLinearFloatFast8_g251795;
					#endif
					float ifLocalVar40_g251793 = 0;
					if( Action0173_g251779 == 21.0 )
					ifLocalVar40_g251793 = staticSwitch1_g251795;
					float Packed_Action0550_g251779 = saturate( ( ( ifLocalVar40_g251787 + ifLocalVar40_g251788 ) + ( ifLocalVar40_g251789 + 0.0 ) + ( ifLocalVar40_g251790 + ifLocalVar40_g251791 ) + ( ifLocalVar40_g251792 + ifLocalVar40_g251793 ) ) );
					float ifLocalVar40_g251796 = 0;
					if( Action1554_g251779 == 0.0 )
					ifLocalVar40_g251796 = Packed_Action0550_g251779;
					float ifLocalVar40_g251797 = 0;
					if( Action1554_g251779 == 1.0 )
					ifLocalVar40_g251797 = ( 1.0 - Packed_Action0550_g251779 );
					float Value1553_g251779 = _PackerValueA1;
					float ifLocalVar40_g251798 = 0;
					if( Action1554_g251779 == 2.0 )
					ifLocalVar40_g251798 = ( Packed_Action0550_g251779 * Value1553_g251779 );
					float ifLocalVar577_g251779 = 0;
					if( Packed_Action0550_g251779 <= 0.99 )
					ifLocalVar577_g251779 = 0.0;
					else
					ifLocalVar577_g251779 = 1.0;
					float ifLocalVar40_g251799 = 0;
					if( Action1554_g251779 == 11.0 )
					ifLocalVar40_g251799 = ifLocalVar577_g251779;
					float ifLocalVar578_g251779 = 0;
					if( Packed_Action0550_g251779 <= 0.01 )
					ifLocalVar578_g251779 = 1.0;
					else
					ifLocalVar578_g251779 = 0.0;
					float ifLocalVar40_g251800 = 0;
					if( Action1554_g251779 == 12.0 )
					ifLocalVar40_g251800 = ifLocalVar578_g251779;
					float temp_output_15_0_g251803 = Packed_Action0550_g251779;
					half linRGB24_g251803 = temp_output_15_0_g251803;
					half localLinearToGammaFloatFast24_g251803 = LinearToGammaFloatFast( linRGB24_g251803 );
					#ifdef UNITY_COLORSPACE_GAMMA
					float staticSwitch14_g251803 = temp_output_15_0_g251803;
					#else
					float staticSwitch14_g251803 = localLinearToGammaFloatFast24_g251803;
					#endif
					float ifLocalVar40_g251801 = 0;
					if( Action1554_g251779 == 20.0 )
					ifLocalVar40_g251801 = staticSwitch14_g251803;
					float temp_output_9_0_g251804 = Packed_Action0550_g251779;
					half sRGB8_g251804 = temp_output_9_0_g251804;
					half localGammaToLinearFloatFast8_g251804 = GammaToLinearFloatFast( sRGB8_g251804 );
					#ifdef UNITY_COLORSPACE_GAMMA
					float staticSwitch1_g251804 = temp_output_9_0_g251804;
					#else
					float staticSwitch1_g251804 = localGammaToLinearFloatFast8_g251804;
					#endif
					float ifLocalVar40_g251802 = 0;
					if( Action1554_g251779 == 21.0 )
					ifLocalVar40_g251802 = staticSwitch1_g251804;
					float A80 = saturate( ( ( ifLocalVar40_g251796 + ifLocalVar40_g251797 ) + ( ifLocalVar40_g251798 + 0.0 ) + ( ifLocalVar40_g251799 + ifLocalVar40_g251800 ) + ( ifLocalVar40_g251801 + ifLocalVar40_g251802 ) ) );
					float4 appendResult48 = (float4(R74 , G78 , B79 , A80));
					float4 Final_Color343 = appendResult48;
					float4 ifLocalVar360 = 0;
					if( Packer_Transform362 == 0.0 )
					ifLocalVar360 = Final_Color343;
					float3 appendResult379 = (float3(R74 , G78 , B79));
					half3 linearToGamma389 = appendResult379;
					linearToGamma389 = half3( LinearToGammaSpaceExact(linearToGamma389.r), LinearToGammaSpaceExact(linearToGamma389.g), LinearToGammaSpaceExact(linearToGamma389.b) );
					float4 appendResult380 = (float4(linearToGamma389 , A80));
					float4 Final_LinearToGamma388 = appendResult380;
					float4 ifLocalVar364 = 0;
					if( Packer_Transform362 == 1.0 )
					ifLocalVar364 = Final_LinearToGamma388;
					float3 appendResult384 = (float3(R74 , G78 , B79));
					float3 gammaToLinear390 = GammaToLinearSpace( appendResult384 );
					float4 appendResult385 = (float4(gammaToLinear390 , A80));
					float4 Final_GammaToLinear387 = appendResult385;
					float4 ifLocalVar369 = 0;
					if( Packer_Transform362 == 2.0 )
					ifLocalVar369 = Final_GammaToLinear387;
					float3 appendResult345 = (float3(R74 , G78 , B79));
					float3 ase_tangentWS = IN.ase_texcoord1.xyz;
					float3 ase_normalWS = IN.ase_texcoord2.xyz;
					float3 ase_bitangentWS = IN.ase_texcoord3.xyz;
					float3x3 ase_worldToTangent = float3x3( ase_tangentWS, ase_bitangentWS, ase_normalWS );
					float3 objectToTangentDir349 = ASESafeNormalize( mul( ase_worldToTangent, mul( unity_ObjectToWorld, float4( (appendResult345*2.0 + -1.0), 0.0 ) ).xyz ) );
					float4 appendResult350 = (float4((objectToTangentDir349*0.5 + 0.5) , A80));
					float4 Final_ObjectToTangent348 = appendResult350;
					float4 ifLocalVar392 = 0;
					if( Packer_Transform362 == 3.0 )
					ifLocalVar392 = Final_ObjectToTangent348;
					float3 appendResult358 = (float3(R74 , G78 , B79));
					float3x3 ase_tangentToWorldPrecise = Inverse3x3( ase_worldToTangent );
					float3 tangentTobjectDir356 = ASESafeNormalize( mul( unity_WorldToObject, float4( mul( ase_tangentToWorldPrecise, (appendResult358*2.0 + -1.0) ), 0.0 ) ).xyz );
					float4 appendResult359 = (float4((tangentTobjectDir356*0.5 + 0.5) , A80));
					float4 Final_TangentToObject357 = appendResult359;
					float4 ifLocalVar395 = 0;
					if( Packer_Transform362 == 4.0 )
					ifLocalVar395 = Final_TangentToObject357;
					

					float4 Color = ( ifLocalVar360 + ifLocalVar364 + ifLocalVar369 + ifLocalVar392 + ifLocalVar395 );
					float Alpha = 1;
					half AlphaClipThreshold = 0.5;
					half AlphaClipThresholdShadow = 0.5;

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_ON
						clip( Alpha - AlphaClipThreshold );
					#endif

					return Color;
				}
			ENDCG
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }
			ZWrite On
			ZTest LEqual
			AlphaToMask Off

			CGPROGRAM
				#define ASE_ABSOLUTE_VERTEX_POS 1
				#define ASE_VERSION 19909

				#pragma vertex vert
				#pragma fragment frag
				#pragma multi_compile_shadowcaster
				#ifndef UNITY_PASS_SHADOWCASTER
					#define UNITY_PASS_SHADOWCASTER
				#endif
				#include "HLSLSupport.cginc"
				#include "UnityShaderVariables.cginc"
				#include "UnityCG.cginc"
				#include "Lighting.cginc"
				#include "UnityPBSLighting.cginc"

				#define ASE_NEEDS_TEXTURE_COORDINATES0
				#define ASE_NEEDS_VERT_TEXTURE_COORDINATES0


				struct appdata
				{
					float4 vertex : POSITION;
					half3 normal : NORMAL;
					float4 ase_texcoord : TEXCOORD0;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f
				{
					V2F_SHADOW_CASTER;
					
					UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
				};

				#ifdef UNITY_STANDARD_USE_DITHER_MASK
					sampler3D _DitherMaskLOD;
				#endif
				#ifdef ASE_TESSELLATION
					float _TessPhongStrength;
					float _TessValue;
					float _TessMin;
					float _TessMax;
					float _TessEdgeLength;
					float _TessMaxDisp;
				#endif

				uniform sampler2D _MainTex;


				
				v2f vert( appdata v  )
				{
					UNITY_SETUP_INSTANCE_ID( v );
					v2f o;
					UNITY_INITIALIZE_OUTPUT( v2f, o );
					UNITY_TRANSFER_INSTANCE_ID( v, o );
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

					float3 appendResult410 = (float3(v.ase_texcoord.xy , 0.0));
					

					#ifdef ASE_ABSOLUTE_VERTEX_POS
						float3 defaultVertexValue = v.vertex.xyz;
					#else
						float3 defaultVertexValue = float3(0, 0, 0);
					#endif
					float3 vertexValue = appendResult410;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
						v.vertex.xyz = vertexValue;
					#else
						v.vertex.xyz += vertexValue;
					#endif
					v.vertex.w = 1;
					v.normal = v.normal;

					TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
					return o;
				}

				half4 frag( v2f IN 
							#if defined( ASE_DEPTH_WRITE_ON )
								, out float outputDepth : SV_Depth
							#endif
							) : SV_Target
				{
					UNITY_SETUP_INSTANCE_ID(IN);

					#ifdef LOD_FADE_CROSSFADE
						UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
					#endif

					

					float Alpha = 1;
					half AlphaClipThreshold = 0.5;
					half AlphaClipThresholdShadow = 0.5;

					#if defined( ASE_DEPTH_WRITE_ON )
						outputDepth = IN.pos.z;
					#endif

					#ifdef _ALPHATEST_SHADOW_ON
						if (unity_LightShadowBias.z != 0.0)
							clip(Alpha - AlphaClipThresholdShadow);
						#ifdef _ALPHATEST_ON
						else
							clip(Alpha - AlphaClipThreshold);
						#endif
					#else
						#ifdef _ALPHATEST_ON
							clip(Alpha - AlphaClipThreshold);
						#endif
					#endif

					#ifdef UNITY_STANDARD_USE_DITHER_MASK
						half alphaRef = tex3D(_DitherMaskLOD, float3(IN.pos.xy*0.25,Alpha*0.9375)).a;
						clip(alphaRef - 0.01);
					#endif

					SHADOW_CASTER_FRAGMENT(IN)
				}
			ENDCG
		}
		
	}
	
	
	Fallback Off
}
/*ASEBEGIN
Version=19909
Node;AmplifyShaderEditor.TexCoordVertexDataNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;409;4736,256;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;309;-768,0;Float;False;Property;_PackerCoordR;PackerCoordR;30;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;317;-768,896;Float;False;Property;_PackerCoordG;PackerCoordG;35;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;320;-768,1792;Float;False;Property;_PackerCoordB;PackerCoordB;33;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;323;-768,2688;Float;False;Property;_PackerCoordA;PackerCoordA;37;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;344;1664,1152;Inherit;False;74;R;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;346;1664,1216;Inherit;False;78;G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;347;1664,1280;Inherit;False;79;B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;353;1664,1536;Inherit;False;74;R;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;354;1664,1600;Inherit;False;78;G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;355;1664,1664;Inherit;False;79;B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;423;-384,2688;Inherit;False;Tool Coords;-1;;372;da63d4e23383c5c4298f6ecca9db7d6f;0;1;34;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;424;-384,1792;Inherit;False;Tool Coords;-1;;373;da63d4e23383c5c4298f6ecca9db7d6f;0;1;34;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;425;-384,896;Inherit;False;Tool Coords;-1;;374;da63d4e23383c5c4298f6ecca9db7d6f;0;1;34;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;426;-384,0;Inherit;False;Tool Coords;-1;;375;da63d4e23383c5c4298f6ecca9db7d6f;0;1;34;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;358;1920,1536;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;345;1920,1152;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;50;-128,1088;Float;False;Property;_PackerFloatG;PackerFloatG;6;0;Create;True;0;0;0;False;0;False;0;0.356;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;59;-128,1984;Float;False;Property;_PackerFloatB;PackerFloatB;7;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;64;-128,2880;Float;False;Property;_PackerFloatA;PackerFloatA;8;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;26;-128,0;Inherit;True;Property;_PackerTexR;PackerTexR;1;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;LockedToTexture2D;False;Object;-1;MipLevel;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;51;-128,896;Inherit;True;Property;_PackerTexG;PackerTexG;2;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;LockedToTexture2D;False;Object;-1;MipLevel;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;57;-128,1792;Inherit;True;Property;_PackerTexB;PackerTexB;3;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;LockedToTexture2D;False;Object;-1;MipLevel;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;60;-128,2688;Inherit;True;Property;_PackerTexA;PackerTexA;4;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;LockedToTexture2D;False;Object;-1;MipLevel;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;375;1664,384;Inherit;False;74;R;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;376;1664,448;Inherit;False;78;G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;377;1664,512;Inherit;False;79;B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;381;1664,768;Inherit;False;74;R;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;382;1664,832;Inherit;False;78;G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;383;1664,896;Inherit;False;79;B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;403;2112,1536;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT;2;False;2;FLOAT;-1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;401;2112,1152;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT;2;False;2;FLOAT;-1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;74;720,0;Float;False;R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;78;720,896;Float;False;G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;79;720,1792;Float;False;B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;80;720,2672;Float;False;A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;379;1920,384;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;384;1920,768;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TransformDirectionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;356;2304,1536;Inherit;False;Tangent;Object;True;Precise;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TransformDirectionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;349;2304,1152;Inherit;False;Object;Tangent;True;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;144;1664,64;Inherit;False;78;G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;146;1664,128;Inherit;False;79;B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;145;1664,192;Inherit;False;80;A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;399;2560,1344;Inherit;False;80;A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;400;2560,1728;Inherit;False;80;A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;402;2560,1152;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT;0.5;False;2;FLOAT;0.5;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;404;2560,1536;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT;0.5;False;2;FLOAT;0.5;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LinearToGammaNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;389;2304,384;Inherit;False;1;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GammaToLinearNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;390;2304,768;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;143;1664,0;Inherit;False;74;R;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;397;2560,512;Inherit;False;80;A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;48;1920,0;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;380;2944,384;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;385;2944,768;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;359;2944,1536;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;350;2944,1152;Inherit;False;FLOAT4;4;0;FLOAT3;0.5,0,0;False;1;FLOAT;0.5;False;2;FLOAT;0.5;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;388;3120,384;Inherit;False;Final_LinearToGamma;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;357;3104,1536;Inherit;False;Final_TangentToObject;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;348;3120,1152;Inherit;False;Final_ObjectToTangent;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;343;3152,0;Inherit;False;Final_Color;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;351;3840,64;Inherit;False;343;Final_Color;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;367;3840,512;Inherit;False;362;Packer_Transform;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;368;3840,576;Inherit;False;387;Final_GammaToLinear;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;394;3840,1024;Inherit;False;362;Packer_Transform;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;396;3840,1088;Inherit;False;357;Final_TangentToObject;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;391;3840,768;Inherit;False;362;Packer_Transform;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;363;3840,0;Inherit;False;362;Packer_Transform;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;393;3840,832;Inherit;False;348;Final_ObjectToTangent;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ConditionalIfNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;360;4224,0;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ConditionalIfNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;364;4224,256;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ConditionalIfNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;369;4224,512;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;2;False;2;FLOAT;0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ConditionalIfNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;392;4224,768;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;3;False;2;FLOAT;0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ConditionalIfNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;395;4224,1024;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;4;False;2;FLOAT;0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;155;-128,-896;Inherit;True;Property;_MainTex;Dummy Texture;0;1;[HideInInspector];Create;False;0;0;0;True;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;370;4736,0;Inherit;False;5;5;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;410;4992,256;Inherit;False;FLOAT3;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;324;-768,2752;Float;False;Property;_PackerLayerA;PackerLayerA;36;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;321;-768,1856;Float;False;Property;_PackerLayerB;PackerLayerB;34;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;318;-768,960;Float;False;Property;_PackerLayerG;PackerLayerG;31;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;315;-768,64;Float;False;Property;_PackerLayerR;PackerLayerR;32;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;365;3840,256;Inherit;False;362;Packer_Transform;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;361;-128,-640;Float;False;Property;_PackerTransformMode;PackerTransformMode;27;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;362;128,-640;Inherit;False;Packer_Transform;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;366;3840,320;Inherit;False;388;Final_LinearToGamma;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;66;-128,1152;Float;False;Property;_PackerChannelG;PackerChannelG;39;1;[IntRange];Create;True;0;0;0;False;0;False;0;2;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;67;-128,2048;Float;False;Property;_PackerChannelB;PackerChannelB;40;1;[IntRange];Create;True;0;0;0;False;0;False;0;3;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;68;-128,2944;Float;False;Property;_PackerChannelA;PackerChannelA;41;1;[IntRange];Create;True;0;0;0;False;0;False;0;4;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;440;-128,320;Float;False;Property;_PackerTexGammaModeR;PackerTexGammaModeR;21;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;441;-128,1216;Float;False;Property;_PackerTexGammaModeG;PackerTexGammaModeG;22;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;442;-128,2112;Float;False;Property;_PackerTexGammaModeB;PackerTexGammaModeB;24;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;443;-128,3008;Float;False;Property;_PackerTexGammaModeA;PackerTexGammaModeA;23;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;398;2560,896;Inherit;False;80;A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;387;3120,768;Inherit;False;Final_GammaToLinear;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;47;-128,192;Float;False;Property;_PackerFloatR;PackerFloatR;5;0;Create;True;0;0;0;False;1;Space(10);False;0;0.519;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;257;-128,384;Float;False;Property;_PackerActionR0;PackerActionR0;26;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;456;-128,448;Float;False;Property;_PackerActionR1;PackerActionR1;25;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;65;-128,256;Float;False;Property;_PackerChannelR;PackerChannelR;38;1;[IntRange];Create;True;0;0;0;False;1;Space(10);False;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;457;-128,576;Float;False;Property;_PackerValueR1;PackerValueR1;16;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;282;-128,512;Float;False;Property;_PackerValueR0;PackerValueR0;15;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;284;-128,1280;Float;False;Property;_PackerActionG0;PackerActionG0;13;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;458;-128,1344;Float;False;Property;_PackerActionG1;PackerActionG1;14;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;285;-128,1408;Float;False;Property;_PackerValueG0;PackerValueG0;19;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;459;-128,1472;Float;False;Property;_PackerValueG1;PackerValueG1;20;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;287;-128,2176;Float;False;Property;_PackerActionB0;PackerActionB0;10;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;460;-128,2240;Float;False;Property;_PackerActionB1;PackerActionB1;9;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;288;-128,2304;Float;False;Property;_PackerValueB0;PackerValueB0;11;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;461;-128,2368;Float;False;Property;_PackerValueB1;PackerValueB1;12;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;290;-128,3072;Float;False;Property;_PackerActionA0;PackerActionA0;18;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;462;-128,3136;Float;False;Property;_PackerActionA1;PackerActionA1;17;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;291;-128,3200;Float;False;Property;_PackerValueA0;PackerValueA0;29;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;463;-128,3264;Float;False;Property;_PackerValueA1;PackerValueA1;28;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;464;384,1792;Inherit;False;Tool Packer;-1;;251692;7c427933118005a479c95a1271b737a6;0;8;19;COLOR;0,0,0,0;False;25;FLOAT;0;False;10;FLOAT;0;False;529;FLOAT;0;False;172;FLOAT;0;False;551;FLOAT;0;False;241;FLOAT;0;False;552;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;465;384,896;Inherit;False;Tool Packer;-1;;251721;7c427933118005a479c95a1271b737a6;0;8;19;COLOR;0,0,0,0;False;25;FLOAT;0;False;10;FLOAT;0;False;529;FLOAT;0;False;172;FLOAT;0;False;551;FLOAT;0;False;241;FLOAT;0;False;552;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;466;384,0;Inherit;False;Tool Packer;-1;;251750;7c427933118005a479c95a1271b737a6;0;8;19;COLOR;0,0,0,0;False;25;FLOAT;0;False;10;FLOAT;0;False;529;FLOAT;0;False;172;FLOAT;0;False;551;FLOAT;0;False;241;FLOAT;0;False;552;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;467;384,2688;Inherit;False;Tool Packer;-1;;251779;7c427933118005a479c95a1271b737a6;0;8;19;COLOR;0,0,0,0;False;25;FLOAT;0;False;10;FLOAT;0;False;529;FLOAT;0;False;172;FLOAT;0;False;551;FLOAT;0;False;241;FLOAT;0;False;552;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;0;5504,0;Float;False;True;-1;2;;0;12;Hidden/BOXOPHOBIC/The Visual Engine/Helpers/Packer;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;7;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;2;RenderType=Opaque=RenderType;PreviewType=Plane;True;2;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;0;0;Standard;5;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Cast Shadows;1;0;Write Depth;0;0;Vertex Position;0;638156234381087878;0;2;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;435;5504,10;Float;False;False;-1;3;AmplifyShaderEditor.MaterialInspector;0;1;New Amplify Shader;0770190933193b94aaa3065e307002fa;True;ShadowCaster;0;1;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;False;;True;1;RenderType=Opaque=RenderType;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
WireConnection;423;34;323;0
WireConnection;424;34;320;0
WireConnection;425;34;317;0
WireConnection;426;34;309;0
WireConnection;358;0;353;0
WireConnection;358;1;354;0
WireConnection;358;2;355;0
WireConnection;345;0;344;0
WireConnection;345;1;346;0
WireConnection;345;2;347;0
WireConnection;26;1;426;0
WireConnection;51;1;425;0
WireConnection;57;1;424;0
WireConnection;60;1;423;0
WireConnection;403;0;358;0
WireConnection;401;0;345;0
WireConnection;74;0;466;0
WireConnection;78;0;465;0
WireConnection;79;0;464;0
WireConnection;80;0;467;0
WireConnection;379;0;375;0
WireConnection;379;1;376;0
WireConnection;379;2;377;0
WireConnection;384;0;381;0
WireConnection;384;1;382;0
WireConnection;384;2;383;0
WireConnection;356;0;403;0
WireConnection;349;0;401;0
WireConnection;402;0;349;0
WireConnection;404;0;356;0
WireConnection;389;0;379;0
WireConnection;390;0;384;0
WireConnection;48;0;143;0
WireConnection;48;1;144;0
WireConnection;48;2;146;0
WireConnection;48;3;145;0
WireConnection;380;0;389;0
WireConnection;380;3;397;0
WireConnection;385;0;390;0
WireConnection;385;3;398;0
WireConnection;359;0;404;0
WireConnection;359;3;400;0
WireConnection;350;0;402;0
WireConnection;350;3;399;0
WireConnection;388;0;380;0
WireConnection;357;0;359;0
WireConnection;348;0;350;0
WireConnection;343;0;48;0
WireConnection;360;0;363;0
WireConnection;360;3;351;0
WireConnection;364;0;365;0
WireConnection;364;3;366;0
WireConnection;369;0;367;0
WireConnection;369;3;368;0
WireConnection;392;0;391;0
WireConnection;392;3;393;0
WireConnection;395;0;394;0
WireConnection;395;3;396;0
WireConnection;370;0;360;0
WireConnection;370;1;364;0
WireConnection;370;2;369;0
WireConnection;370;3;392;0
WireConnection;370;4;395;0
WireConnection;410;0;409;0
WireConnection;362;0;361;0
WireConnection;387;0;385;0
WireConnection;464;19;57;0
WireConnection;464;25;59;0
WireConnection;464;10;67;0
WireConnection;464;529;442;0
WireConnection;464;172;287;0
WireConnection;464;551;460;0
WireConnection;464;241;288;0
WireConnection;464;552;461;0
WireConnection;465;19;51;0
WireConnection;465;25;50;0
WireConnection;465;10;66;0
WireConnection;465;529;441;0
WireConnection;465;172;284;0
WireConnection;465;551;458;0
WireConnection;465;241;285;0
WireConnection;465;552;459;0
WireConnection;466;19;26;0
WireConnection;466;25;47;0
WireConnection;466;10;65;0
WireConnection;466;529;440;0
WireConnection;466;172;257;0
WireConnection;466;551;456;0
WireConnection;466;241;282;0
WireConnection;466;552;457;0
WireConnection;467;19;60;0
WireConnection;467;25;64;0
WireConnection;467;10;68;0
WireConnection;467;529;443;0
WireConnection;467;172;290;0
WireConnection;467;551;462;0
WireConnection;467;241;291;0
WireConnection;467;552;463;0
WireConnection;0;0;370;0
WireConnection;0;15;410;0
ASEEND*/
//CHKSM=AB1CF101C3CD858299FCFA73D33ED4A888ADC1CD