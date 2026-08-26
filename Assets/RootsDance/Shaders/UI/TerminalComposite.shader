// The whole screen as one signal (docs/effects/低保真终端式UI规范.md §6, §8).
//
// The chrome, the text and the stage are all drawn into one low-resolution RenderTexture, and this
// material blits it to the screen. That is the correction to the first reproduction, which drew crisp
// 1080p uGUI chrome and only filtered the stage: in the reference every edge is a glow ramp (a rail
// measures 94 -> 159 -> 76 across ~9 px, not a 9 px flat bar), grain covers the empty field, and the
// labels are dot-matrix glyphs bleeding into each other — the gap between two letters only falls to
// about 45% of the stroke peak, so the text is more glow than glyph.
//
// It stays a plain uGUI material: no renderer feature, no Render Graph, unaffected by the pipeline
// version.
Shader "RootsDance/UI/TerminalComposite"
{
    Properties
    {
        [PerRendererData] _MainTex ("Low-res Screen", 2D) = "black" {}
        _Color ("Tint", Color) = (1, 1, 1, 1)

        _GlowStrength ("Glow Strength", Range(0, 4)) = 1.35
        _GlowRadius ("Glow Radius (buffer px)", Range(0.5, 4)) = 1.6
        _GlowThreshold ("Glow Threshold", Range(0, 1)) = 0.26

        _ScanlinePeriod ("Scanline Period (buffer px)", Float) = 4.2
        _ScanlineStrength ("Scanline Strength", Range(0, 0.2)) = 0.0021
        _GrainStrength ("Grain Strength", Range(0, 0.2)) = 0.0255
        _GrainRate ("Grain Steps Per Second", Float) = 24
        _VignetteStrength ("Vignette Strength", Range(0, 1)) = 0.42
        _LumaCeiling ("Luma Ceiling", Range(0, 1)) = 0.9

        _StencilComp ("Stencil Comparison", Float) = 8
        _Stencil ("Stencil ID", Float) = 0
        _StencilOp ("Stencil Operation", Float) = 0
        _StencilWriteMask ("Stencil Write Mask", Float) = 255
        _StencilReadMask ("Stencil Read Mask", Float) = 255
        _ColorMask ("Color Mask", Float) = 15
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Transparent"
            "IgnoreProjector" = "True"
            "RenderType" = "Transparent"
            "PreviewType" = "Plane"
            "CanUseSpriteAtlas" = "True"
            "RenderPipeline" = "UniversalPipeline"
        }

        Stencil
        {
            Ref [_Stencil]
            Comp [_StencilComp]
            Pass [_StencilOp]
            ReadMask [_StencilReadMask]
            WriteMask [_StencilWriteMask]
        }

        Cull Off
        Lighting Off
        ZWrite Off
        ZTest [unity_GUIZTestMode]
        Blend SrcAlpha OneMinusSrcAlpha
        ColorMask [_ColorMask]

        Pass
        {
            Name "TerminalComposite"

            HLSLPROGRAM
            #pragma vertex Vert
            #pragma fragment Frag
            #pragma target 3.0

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct Attributes
            {
                float4 positionOS : POSITION;
                float4 color : COLOR;
                float2 uv : TEXCOORD0;
            };

            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float4 color : COLOR;
                float2 uv : TEXCOORD0;
            };

            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);

            CBUFFER_START(UnityPerMaterial)
                float4 _MainTex_ST;
                float4 _MainTex_TexelSize;
                float4 _Color;
                float _GlowStrength;
                float _GlowRadius;
                float _GlowThreshold;
                float _ScanlinePeriod;
                float _ScanlineStrength;
                float _GrainStrength;
                float _GrainRate;
                float _VignetteStrength;
                float _LumaCeiling;
            CBUFFER_END

            // Integer bit-mixing rather than the usual sin() hash: at these coordinates sin() hashing
            // correlates along diagonals and lays a visible weave over the whole screen.
            float Hash21(float2 p)
            {
                uint2 q = (uint2)(int2)p;
                uint n = q.x * 1597334677u ^ q.y * 3812015801u;
                n = (n ^ (n >> 15)) * 2246822519u;
                n = (n ^ (n >> 13)) * 3266489917u;
                n = n ^ (n >> 16);
                return (n & 0x00FFFFFFu) / 16777216.0;
            }

            float Luma(float3 rgb)
            {
                return dot(rgb, float3(0.299, 0.587, 0.114));
            }

            float3 BrightPass(float3 rgb)
            {
                float excess = max(0.0, Luma(rgb) - _GlowThreshold);
                return rgb * excess;
            }

            Varyings Vert(Attributes input)
            {
                Varyings output;
                output.positionCS = TransformObjectToHClip(input.positionOS.xyz);
                output.uv = TRANSFORM_TEX(input.uv, _MainTex);
                output.color = input.color * _Color;
                return output;
            }

            half4 Frag(Varyings input) : SV_Target
            {
                float2 texel = _MainTex_TexelSize.xy;
                float3 base = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, input.uv).rgb;

                // Phosphor spread: a 5x5 gaussian on the bright part of the buffer. This is what turns
                // a one-pixel line into the measured 94 -> 159 -> 76 ramp and what makes neighbouring
                // dot-matrix strokes bleed together instead of standing apart.
                float3 glow = 0;
                float weightSum = 0;

                [unroll]
                for (int y = -2; y <= 2; y++)
                {
                    [unroll]
                    for (int x = -2; x <= 2; x++)
                    {
                        float2 offset = float2(x, y);
                        float weight = exp(-dot(offset, offset) / (2.0 * _GlowRadius * _GlowRadius));
                        float2 uv = input.uv + offset * texel * _GlowRadius;
                        glow += BrightPass(SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, uv).rgb) * weight;
                        weightSum += weight;
                    }
                }

                glow /= max(weightSum, 1e-4);

                float3 signalOut = base + glow * _GlowStrength;

                // Scanlines, in buffer pixels: 13 px on the 1116-tall reference frame. At the measured
                // 0.2% modulation they are almost invisible, which is correct — the tube is quiet.
                float scan = sin(input.uv.y / max(texel.y, 1e-6) / max(_ScanlinePeriod, 1) * 6.2831853);
                signalOut *= 1.0 + scan * _ScanlineStrength;

                // Grain: the strongest layer, about 12x the scanlines, and it covers the empty field
                // too — the reference's background pixels wander over a range of ~9 levels. It is
                // sampled per OUTPUT pixel, not per buffer texel: this is film grain sitting in front
                // of the tube, so it does not inherit the raster's coarseness.
                float grainStep = floor(_Time.y * max(_GrainRate, 1));
                float2 grainCell = floor(input.uv * _ScreenParams.xy);
                float grain = Hash21(grainCell + float2(grainStep * 37.0, grainStep * 17.0)) - 0.5;
                signalOut += grain * _GrainStrength * 2.0;

                // Vignette: flat across x, falling off toward the bottom.
                float drop = saturate(1.0 - input.uv.y);
                signalOut *= 1.0 - _VignetteStrength * drop * drop;

                // Gamut ceiling: the brightest thing measured on the reference is the logo core at
                // (228, 213, 179). Nothing reaches white.
                signalOut = saturate(signalOut);
                float luma = Luma(signalOut);
                signalOut *= luma > _LumaCeiling ? _LumaCeiling / max(luma, 1e-4) : 1.0;

                return half4(signalOut * input.color.rgb, input.color.a);
            }
            ENDHLSL
        }
    }

    Fallback "UI/Default"
}
