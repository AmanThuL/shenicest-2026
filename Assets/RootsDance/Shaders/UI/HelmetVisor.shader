// Procedural inside-the-helmet visor frame for the first-person HUD.
//
// Drawn by a single full-screen uGUI Image, behind the HUD widgets and above the 3D scene: the dark
// helmet shell fills everything outside a superellipse opening, a narrow metal band runs along the
// boundary where the shell clamps the glass, and a soft shadow from that band bleeds a little way
// onto the glass - that bleed is what makes the rim readable "a little on the edge of sight" instead
// of a hard cookie-cutter mask. Everything inside the opening past the shadow is fully transparent.
//
// The opening is a superellipse |x/rx|^n + |y/ry|^n = 1 with separate top and bottom Y radii, so the
// brow can sit high while the chin bar cuts in flatter, like the reference frame. All distances are
// in unit-rect UV, so the same material tracks any resolution; widths are kept perceptually even by
// dividing the field by its screen-space gradient (fwidth) rather than trusting pow() spacing.
//
// Plain uGUI shader against UnityCG/UnityUI only - no pipeline include - same reasoning as
// Dither.shader next to it: overlay UI is composited after HDRP, so pipeline includes buy nothing.
Shader "RootsDance/UI/HelmetVisor"
{
    Properties
    {
        [PerRendererData] _MainTex ("Sprite", 2D) = "white" {}
        _Color ("Tint", Color) = (1, 1, 1, 1)

        _OpeningCenter ("Opening Center (UV)", Vector) = (0.5, 0.54, 0, 0)
        _RadiusX ("Radius X", Range(0.05, 1.0)) = 0.46
        _RadiusTop ("Radius Y Top", Range(0.05, 1.0)) = 0.42
        _RadiusBottom ("Radius Y Bottom", Range(0.05, 1.0)) = 0.34
        _CornerPower ("Corner Power", Range(1.5, 12)) = 3.5

        _FrameColor ("Frame Colour", Color) = (0.022, 0.024, 0.027, 1)
        _RimColor ("Rim Colour", Color) = (0.16, 0.175, 0.19, 1)
        _RimWidth ("Rim Width (UV)", Range(0, 0.1)) = 0.014
        _RimTopBrightness ("Rim Brightness Top", Range(0, 2)) = 0.45
        _RimBottomBrightness ("Rim Brightness Bottom", Range(0, 2)) = 1.15

        _GlassShadowWidth ("Glass Shadow Width (UV)", Range(0, 0.3)) = 0.075
        _GlassShadowStrength ("Glass Shadow Strength", Range(0, 1)) = 0.6
        _FrameNoise ("Frame Wear Noise", Range(0, 1)) = 0.25

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
            Name "HelmetVisor"

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
            float4 _Color;
            float4 _ClipRect;

            float4 _OpeningCenter;
            float _RadiusX;
            float _RadiusTop;
            float _RadiusBottom;
            float _CornerPower;

            float4 _FrameColor;
            float4 _RimColor;
            float _RimWidth;
            float _RimTopBrightness;
            float _RimBottomBrightness;

            float _GlassShadowWidth;
            float _GlassShadowStrength;
            float _FrameNoise;

            Varyings Vert(Attributes input)
            {
                Varyings output;
                output.worldPosition = input.positionOS;
                output.positionCS = UnityObjectToClipPos(input.positionOS);
                output.uv = TRANSFORM_TEX(input.uv, _MainTex);
                output.color = input.color * _Color;
                return output;
            }

            // Cheap value noise for shell wear; visor-space input keeps it resolution-stable.
            float Hash(float2 p)
            {
                return frac(sin(dot(p, float2(127.1, 311.7))) * 43758.5453);
            }

            float ValueNoise(float2 p)
            {
                float2 cell = floor(p);
                float2 f = frac(p);
                f = f * f * (3.0 - 2.0 * f);

                float a = Hash(cell);
                float b = Hash(cell + float2(1, 0));
                float c = Hash(cell + float2(0, 1));
                float d = Hash(cell + float2(1, 1));
                return lerp(lerp(a, b, f.x), lerp(c, d, f.x), f.y);
            }

            fixed4 Frag(Varyings input) : SV_Target
            {
                float2 delta = input.uv - _OpeningCenter.xy;
                float radiusY = delta.y >= 0.0 ? _RadiusTop : _RadiusBottom;
                float2 normalised = float2(abs(delta.x) / _RadiusX, abs(delta.y) / radiusY);

                // Superellipse field: < 1 inside the opening, 1 on the glass/frame boundary. The
                // 1/n root would compress band widths at the corners, so widths below are measured
                // against the field's own screen gradient instead.
                float field = pow(normalised.x, _CornerPower) + pow(normalised.y, _CornerPower);
                float gradient = max(fwidth(field), 1e-4);
                float pixels = (field - 1.0) / gradient;

                float shadowPixels = max(_GlassShadowWidth / gradient, 1.0);
                float rimPixels = max(_RimWidth / gradient, 1.0);

                // Inside the opening: only the frame's soft shadow, fading to fully clear glass.
                float glassShadow = _GlassShadowStrength * saturate(1.0 + pixels / shadowPixels);
                glassShadow *= glassShadow; // quadratic falloff hugs the rim instead of hazing the view

                // Frame coverage turns on across one pixel at the boundary and stays on outside.
                float frameMask = saturate(pixels + 0.5);

                // Rim band sits just outside the boundary; lit from above, so the chin catches more.
                float rimMask = frameMask * saturate(1.0 - (pixels - rimPixels) / max(rimPixels, 1.0));
                float rimLight = lerp(_RimBottomBrightness, _RimTopBrightness,
                    saturate(delta.y / max(radiusY, 1e-4) * 0.5 + 0.5));

                float wear = 1.0 - _FrameNoise * ValueNoise(input.uv * 60.0) * frameMask;

                float3 colour = _FrameColor.rgb * wear;
                colour = lerp(colour, _RimColor.rgb * rimLight, rimMask);

                float alpha = lerp(glassShadow, 1.0, frameMask);

                fixed4 result = fixed4(colour, alpha);
                result *= tex2D(_MainTex, input.uv);
                result *= input.color;

                #ifdef UNITY_UI_CLIP_RECT
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
}
