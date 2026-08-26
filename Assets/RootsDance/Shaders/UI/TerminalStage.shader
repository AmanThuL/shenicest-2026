// The stage image inside the window: ordered dither, plus the two image-side motion verbs.
//
// Everything that makes the screen read as a filmed CRT — glow, scanlines, grain, vignette, the gamut
// ceiling — lives in TerminalComposite instead, because it applies to the WHOLE screen, chrome and
// text included (docs/effects/低保真终端式UI规范.md §6). This material only handles what is specific
// to the stage bitmap.
//
// TerminalMotion.RasterHold drives _RasterStrength / _RasterPhase (P1) and TerminalMotion.Reconstruct
// drives _Coverage (P2-P4).
Shader "RootsDance/UI/TerminalStage"
{
    Properties
    {
        [PerRendererData] _MainTex ("Stage Image", 2D) = "black" {}
        _Color ("Tint", Color) = (1, 1, 1, 1)

        _InteriorColor ("Stage Interior", Color) = (0.188, 0.157, 0.125, 1)

        _DitherCell ("Dither Cell (buffer px)", Vector) = (1, 1, 0, 0)

        _Coverage ("Block Coverage", Range(0, 1)) = 1
        _BlockSize ("Reconstruct Block (buffer px)", Float) = 4
        _QuantSteps ("Quantization Steps", Float) = 24

        _RasterStrength ("Raster Bands", Range(0, 1)) = 0
        _RasterPhase ("Raster Phase (step)", Float) = 0
        _RasterSpacing ("Raster Spacing (buffer px)", Float) = 26
        _RasterColor ("Raster Color", Color) = (0.463, 0.282, 0.247, 1)

        // RectMask2D writes this; without it a masked graphic is not clipped at all.
        _ClipRect ("Clip Rect", Vector) = (-32767, -32767, 32767, 32767)

        // uGUI masking plumbing, same contract as UI/Default.
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
            Name "TerminalStage"

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
                float2 positionCanvas : TEXCOORD1;
            };

            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);

            CBUFFER_START(UnityPerMaterial)
                float4 _MainTex_ST;
                float4 _MainTex_TexelSize;
                float4 _Color;
                float4 _InteriorColor;
                float4 _DitherCell;
                float4 _RasterColor;
                float _Coverage;
                float _BlockSize;
                float _QuantSteps;
                float _RasterStrength;
                float _RasterPhase;
                float _RasterSpacing;
                float4 _ClipRect;
            CBUFFER_END

            // 4x4 ordered Bayer threshold, evaluated arithmetically rather than from an indexed
            // array so the pass compiles on the lowest shader targets uGUI still ships to.
            float Bayer2(float2 c)
            {
                c = floor(c);
                return frac(c.x * 0.5 + c.y * c.y * 0.75);
            }

            float Bayer4(float2 c)
            {
                return Bayer2(c * 0.5) * 0.25 + Bayer2(c);
            }

            float Hash21(float2 p)
            {
                return frac(sin(dot(p, float2(127.1, 311.7))) * 43758.5453);
            }

            Varyings Vert(Attributes input)
            {
                Varyings output;
                output.positionCS = TransformObjectToHClip(input.positionOS.xyz);
                output.positionCanvas = input.positionOS.xy;
                output.uv = TRANSFORM_TEX(input.uv, _MainTex);
                output.color = input.color * _Color;
                return output;
            }

            half4 Frag(Varyings input) : SV_Target
            {
                // Pixel coordinates of the stage image, so every effect below is sized in px exactly
                // as measured, independent of how large the stage is drawn on screen.
                float2 texel = max(_MainTex_TexelSize.zw, float2(1, 1));
                float2 pixel = input.uv * texel;

                float3 interior = _InteriorColor.rgb;
                float3 rgb = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, input.uv).rgb;

                // Ordered dither. At the buffer's native resolution the raster grid IS the dither
                // unit, so the cell is small and this mostly quantizes levels; the visible 4x3 texture
                // of the reference comes from the source art plus the upscale.
                float2 cell = max(_DitherCell.xy, float2(1, 1));
                float2 cellIndex = floor(pixel / cell);
                float threshold = Bayer4(cellIndex);
                float3 quantized = floor(rgb * _QuantSteps + threshold) / _QuantSteps;

                // Only dither where there is something to dither. Applied to the flat interior it
                // lays a checkerboard over the whole window, which the reference does not have: there
                // the pattern rides the planet and the mark, and the empty field is clean.
                float deviation = saturate(length(rgb - interior) * 8.0);
                quantized = lerp(rgb, quantized, deviation);

                // Reconstruct (P2-P4): a block is absent or complete, never faded. Blocks resolve in a
                // fixed hashed order so the same image always rebuilds the same way.
                float block = max(_BlockSize, 1);
                float blockRank = Hash21(floor(pixel / block));
                float resolved = step(blockRank, _Coverage);
                float3 stage = lerp(interior, quantized, resolved);

                // RasterHold (P1): bands only, no image. Spacing and thickness are the measured
                // 80 px / 31-57 px scaled into the buffer, and the set jumps one step per refresh.
                float spacing = max(_RasterSpacing, 1);
                float bandIndex = floor((pixel.y + _RasterPhase * 3.0) / spacing);
                float bandY = frac((pixel.y + _RasterPhase * 3.0) / spacing);
                float thickness = lerp(0.39, 0.71, Hash21(float2(bandIndex, 17.0)));
                float band = step(bandY, thickness);
                stage = lerp(stage, lerp(interior, _RasterColor.rgb, band), _RasterStrength);

                // RectMask2D clipping, same contract as UI/Default: the stage bitmap is oversized so
                // it has room to drift, and the window has to cut it off.
                float2 inside = step(_ClipRect.xy, input.positionCanvas)
                    * step(input.positionCanvas, _ClipRect.zw);
                float alpha = input.color.a * inside.x * inside.y;

                return half4(stage * input.color.rgb, alpha);
            }
            ENDHLSL
        }
    }

    Fallback "UI/Default"
}
