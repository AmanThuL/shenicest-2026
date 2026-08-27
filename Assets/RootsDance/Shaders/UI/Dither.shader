// Dithered image plates for the electronic UI kit (docs/effects/电子类UI组件库规范.md §3).
//
// One shader covering the three dither families the references use, because they are what makes three
// otherwise identical layouts read as three different machines: ordered/Bayer (the police file screen,
// multi-level, regular checkerboards), clustered-dot halftone (the terminal browser, 1 bit, diamond
// rosettes growing inside a fixed cell) and blue noise (the bio file screen, 1 bit, aperiodic scatter).
//
// Two things matter more than the mode. The pattern cell has to be visibly larger than a screen pixel
// (2-3 px measured) or the dither reads as dirt rather than as print, so the source is sampled at the
// cell centre and the whole plate is quantised onto that lattice. And contrast has to be crushed
// *before* dithering: fed a normally exposed photo, every cell lands mid-grey and the result is one
// flat field of pattern with no image in it.
//
// Plain uGUI shader against UnityCG/UnityUI only - no pipeline include, no renderer feature - so it
// is unaffected by the render pipeline, like the terminal materials next to it.
Shader "RootsDance/UI/Dither"
{
    Properties
    {
        [PerRendererData] _MainTex ("Source", 2D) = "white" {}
        _Color ("Tint", Color) = (1, 1, 1, 1)

        [Enum(Bayer2,0,Bayer4,1,Bayer8,2,HalftoneRound,3,HalftoneDiamond,4,HalftoneLine,5,BlueNoise,6)]
        _Mode ("Dither Mode", Float) = 1
        _Levels ("Quantisation Levels", Range(2, 16)) = 2
        _PixelSize ("Pattern Cell (screen px)", Range(1, 12)) = 3
        _Angle ("Halftone Screen Angle", Range(0, 90)) = 45

        _Contrast ("Pre-dither Contrast", Range(0.1, 6)) = 2.2
        _Brightness ("Pre-dither Brightness", Range(-1, 1)) = 0

        _ColorLow ("Low Colour", Color) = (0.016, 0.035, 0.051, 1)
        _ColorHigh ("High Colour", Color) = (0.522, 0.592, 0.647, 1)

        _StencilComp ("Stencil Comparison", Float) = 8
        _Stencil ("Stencil ID", Float) = 0
        _StencilOp ("Stencil Operation", Float) = 0
        _StencilWriteMask ("Stencil Write Mask", Float) = 255
        _StencilReadMask ("Stencil Read Mask", Float) = 255
        _ColorMask ("Color Mask", Float) = 15
        [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
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
            Name "Dither"

            CGPROGRAM
            #pragma vertex Vert
            #pragma fragment Frag
            #pragma target 3.0
            #pragma multi_compile_local _ UNITY_UI_CLIP_RECT
            #pragma multi_compile_local _ UNITY_UI_ALPHACLIP

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"

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
                float4 worldPosition : TEXCOORD1;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _MainTex_TexelSize;
            float4 _Color;
            float4 _ClipRect;

            float _Mode;
            float _Levels;
            float _PixelSize;
            float _Angle;
            float _Contrast;
            float _Brightness;
            float4 _ColorLow;
            float4 _ColorHigh;

            // Bayer thresholds, normalised to (0,1) and centred so a flat mid-grey dithers to an even
            // 50% pattern rather than drifting light or dark.
            static const float k_Bayer2[4] =
            {
                0.0 / 4.0, 2.0 / 4.0,
                3.0 / 4.0, 1.0 / 4.0
            };

            static const float k_Bayer4[16] =
            {
                 0.0 / 16.0,  8.0 / 16.0,  2.0 / 16.0, 10.0 / 16.0,
                12.0 / 16.0,  4.0 / 16.0, 14.0 / 16.0,  6.0 / 16.0,
                 3.0 / 16.0, 11.0 / 16.0,  1.0 / 16.0,  9.0 / 16.0,
                15.0 / 16.0,  7.0 / 16.0, 13.0 / 16.0,  5.0 / 16.0
            };

            float Bayer8(int2 c)
            {
                // The 8x8 matrix as the recursive expansion of the 4x4, which is cheaper than a
                // 64-entry constant array and gives the identical pattern.
                int2 q = c / 4;
                int2 r = c % 4;
                float coarse = k_Bayer4[q.y % 4 * 4 + q.x % 4];
                float fine = k_Bayer4[r.y * 4 + r.x];

                return fine + coarse / 16.0;
            }

            // Interleaved gradient noise: aperiodic, and its spectrum is close enough to blue that
            // isolated lit cells scatter the way the bio file screen's plate does. A plain hash here
            // gives white noise, which clumps and reads as damage rather than as a noisy capture.
            float BlueNoise(float2 cell)
            {
                return frac(52.9829189 * frac(dot(cell, float2(0.06711056, 0.00583715))));
            }

            // Spot function for clustered-dot screens: distance from the cell centre, so raising the
            // threshold grows one blob per cell instead of scattering pixels across it.
            float Halftone(float2 cell, float mode)
            {
                float radians = _Angle * 0.0174532925;
                float s = sin(radians);
                float c = cos(radians);
                float2 rotated = float2(cell.x * c - cell.y * s, cell.x * s + cell.y * c);
                float2 f = frac(rotated) - 0.5;

                if (mode < 3.5)
                {
                    return saturate(length(f) * 1.9);        // round
                }

                if (mode < 4.5)
                {
                    return saturate((abs(f.x) + abs(f.y)) * 1.9);  // diamond
                }

                return saturate(abs(f.y) * 2.0);             // line screen
            }

            float Threshold(float2 screenPixel)
            {
                float2 cell = screenPixel / max(_PixelSize, 1.0);
                int2 icell = int2(floor(cell));

                if (_Mode < 0.5)
                {
                    int2 m = abs(icell % 2);
                    return k_Bayer2[m.y * 2 + m.x];
                }

                if (_Mode < 1.5)
                {
                    int2 m = abs(icell % 4);
                    return k_Bayer4[m.y * 4 + m.x];
                }

                if (_Mode < 2.5)
                {
                    return Bayer8(abs(icell % 8));
                }

                if (_Mode < 5.5)
                {
                    return Halftone(cell, _Mode);
                }

                return BlueNoise(float2(icell));
            }

            Varyings Vert(Attributes input)
            {
                Varyings output;
                output.worldPosition = input.positionOS;
                output.positionCS = UnityObjectToClipPos(input.positionOS);
                output.uv = TRANSFORM_TEX(input.uv, _MainTex);
                output.color = input.color * _Color;
                return output;
            }

            fixed4 Frag(Varyings input) : SV_Target
            {
                float2 screenPixel = input.positionCS.xy;
                float cellSize = max(_PixelSize, 1.0);

                // Sample at the cell centre, not at the fragment: the plate has to live on the same
                // lattice as the pattern, or one pattern cell straddles two source tones and the image
                // edges turn to mush. The derivatives give UV-per-screen-pixel without the shader
                // needing to know how big the RectTransform ended up on screen.
                float2 uvPerPixel = float2(
                    length(float2(ddx(input.uv.x), ddy(input.uv.x))),
                    length(float2(ddx(input.uv.y), ddy(input.uv.y))));
                float2 lattice = max(uvPerPixel * cellSize, 1e-6);
                float2 uv = (floor(input.uv / lattice) + 0.5) * lattice;

                fixed4 source = tex2Dlod(_MainTex, float4(uv, 0, 0));

                float luma = dot(source.rgb, float3(0.299, 0.587, 0.114));

                // Crushed before the pattern is applied. §3: without this the whole plate lands in the
                // middle of the ramp and dithers to one even field with no picture in it.
                luma = saturate((luma - 0.5) * _Contrast + 0.5 + _Brightness);

                float levels = max(2.0, floor(_Levels));
                float threshold = Threshold(screenPixel);
                float quantised = floor(luma * (levels - 1.0) + threshold) / (levels - 1.0);
                quantised = saturate(quantised);

                fixed4 result = lerp(_ColorLow, _ColorHigh, quantised);
                result.a = _ColorLow.a + (_ColorHigh.a - _ColorLow.a) * quantised;
                result *= input.color;
                result.a *= source.a;

                #ifdef UNITY_UI_CLIP_RECT
                // Custom uGUI shaders have to clip themselves; without this a plate inside a
                // RectMask2D is not masked at all and overflows its panel.
                result.a *= UnityGet2DClipping(input.worldPosition.xy, _ClipRect);
                #endif

                #ifdef UNITY_UI_ALPHACLIP
                clip(result.a - 0.001);
                #endif

                return result;
            }
            ENDCG
        }
    }

    Fallback "UI/Default"
}
