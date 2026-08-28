// Procedural inside-the-helmet visor frame for the first-person HUD.
//
// Drawn by a single full-screen uGUI Image, behind the HUD widgets and above the 3D scene: the dark
// helmet shell fills everything outside a superellipse opening, a narrow metal band runs along the
// boundary where the shell clamps the glass, and a soft shadow from that band bleeds a little way
// onto the glass - that bleed is what makes the rim readable "a little on the edge of sight" instead
// of a hard cookie-cutter mask. Everything inside the opening past the shadow is fully transparent.
//
// The opening is an SDF composition after the mech-cockpit reference: a wide rounded-box window,
// minus a rounded notch hanging from the top edge (the brow console), minus a rounded block rising
// from the bottom edge (the chin console). Distances are authored in screen-height units with x
// aspect-corrected, so the silhouette keeps its true proportions at any resolution; band widths are
// measured against the field's screen-space gradient (fwidth), so they stay even along the outline.
//
// Plain uGUI shader against UnityCG/UnityUI only - no pipeline include - same reasoning as
// Dither.shader next to it: overlay UI is composited after HDRP, so pipeline includes buy nothing.
Shader "RootsDance/UI/HelmetVisor"
{
    Properties
    {
        [PerRendererData] _MainTex ("Sprite", 2D) = "white" {}
        _Color ("Tint", Color) = (1, 1, 1, 1)

        // Opening geometry (screen-height units, x aspect-corrected): a wide rounded-box window,
        // minus a rounded notch in the top edge, minus a rounded console block rising from the
        // bottom edge - the mech-cockpit reference silhouette.
        _OpeningCenter ("Opening Center (UV)", Vector) = (0.5, 0.52, 0, 0)
        _HalfWidth ("Opening Half Width", Range(0.1, 1.5)) = 0.78
        _HalfHeight ("Opening Half Height", Range(0.1, 1.0)) = 0.37
        _CornerRadius ("Opening Corner Radius", Range(0.01, 0.5)) = 0.18
        _TopNotchWidth ("Top Notch Half Width", Range(0, 1.0)) = 0.34
        _TopNotchDepth ("Top Notch Depth", Range(0, 0.5)) = 0.13
        _TopNotchRadius ("Top Notch Corner Radius", Range(0.005, 0.2)) = 0.06
        _BottomNotchWidth ("Bottom Console Half Width", Range(0, 1.0)) = 0.44
        _BottomNotchDepth ("Bottom Console Height", Range(0, 0.5)) = 0.16
        _BottomNotchRadius ("Bottom Console Corner Radius", Range(0.005, 0.3)) = 0.1

        // Traced silhouette: a signed-distance texture (linear R, 0.5 = the outline) extracted from
        // the cockpit reference image — outline only, the artwork itself is not shipped. At blend 1
        // it replaces the parametric window entirely; the parametric SDF stays as the fallback.
        _ShapeTex ("Opening SDF (linear R)", 2D) = "gray" {}
        _ShapeBlend ("Opening SDF Blend", Range(0, 1)) = 0
        _ShapeRange ("Opening SDF Range", Range(0.1, 2)) = 0.6

        _FrameColor ("Frame Colour", Color) = (0.022, 0.024, 0.027, 1)
        _RimColor ("Rim Colour", Color) = (0.16, 0.175, 0.19, 1)
        _RimWidth ("Rim Width (UV)", Range(0, 0.1)) = 0.014
        _RimTopBrightness ("Rim Brightness Top", Range(0, 2)) = 0.45
        _RimBottomBrightness ("Rim Brightness Bottom", Range(0, 2)) = 1.15

        // At 1 the shell, the rim band and the rim shadow are all gone and the quad is glass edge
        // to edge — the faceplate reads as one continuous sheet. The smudges then spread evenly
        // instead of hugging a seal that is no longer there.
        _GlassOnly ("Glass Edge To Edge", Range(0, 1)) = 0

        _GlassShadowWidth ("Glass Shadow Width (UV)", Range(0, 0.3)) = 0.075
        _GlassShadowStrength ("Glass Shadow Strength", Range(0, 1)) = 0.6
        _FrameNoise ("Frame Wear Noise", Range(0, 1)) = 0.25

        // Material dressing (ambientCG CC0 maps, see docs/third-party.md). Grey defaults keep the
        // old flat look when no texture is assigned, so the material degrades instead of breaking.
        _ShellTex ("Shell Texture (rubber)", 2D) = "gray" {}
        _ShellTiling ("Shell Tiling", Range(0.2, 8)) = 2.5
        _ShellTexStrength ("Shell Texture Strength", Range(0, 1)) = 0.85
        _ShellMean ("Shell Map Mean (linear)", Range(0.005, 1)) = 0.026
        _ShellContrast ("Shell Grain Contrast", Range(0.2, 4)) = 1.4
        _RimTex ("Rim Texture (metal)", 2D) = "gray" {}
        _RimTiling ("Rim Tiling (around the ring)", Range(0.2, 12)) = 4
        _RimMean ("Rim Map Mean (linear)", Range(0.005, 1)) = 0.24
        _RimContrast ("Rim Streak Contrast", Range(0.2, 8)) = 3
        _SmudgeTex ("Glass Smudge Texture", 2D) = "black" {}
        _SmudgeTiling ("Smudge Tiling", Range(0.2, 4)) = 1.2
        _SmudgeStrength ("Glass Smudge Strength", Range(0, 1)) = 0.35
        _SmudgeMean ("Smudge Map Scale (linear)", Range(0.005, 1)) = 0.08

        // Grime is scattered light, so it reads by being brighter than what is behind it. The old
        // value was a mid grey that happened to match a grey environment exactly, which made the
        // smudges measurably invisible however strong they were.
        _SmudgeColor ("Smudge Colour", Color) = (0.88, 0.91, 0.95, 1)

        // Only meaningful edge to edge: how much of the middle of the view stays clean. Measured
        // in the same aspect-corrected units as the opening, where the corner sits at about 1.02.
        _SmudgeCenterClear ("Smudge Centre Clear Radius", Range(0, 1)) = 0.35

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
            float _HalfWidth;
            float _HalfHeight;
            float _CornerRadius;
            float _TopNotchWidth;
            float _TopNotchDepth;
            float _TopNotchRadius;
            float _BottomNotchWidth;
            float _BottomNotchDepth;
            float _BottomNotchRadius;
            sampler2D _ShapeTex;
            float _ShapeBlend;
            float _ShapeRange;

            float4 _FrameColor;
            float4 _RimColor;
            float _RimWidth;
            float _RimTopBrightness;
            float _RimBottomBrightness;

            float _GlassOnly;
            float _GlassShadowWidth;
            float _GlassShadowStrength;
            float _FrameNoise;

            sampler2D _ShellTex;
            float _ShellTiling;
            float _ShellTexStrength;
            float _ShellMean;
            float _ShellContrast;
            sampler2D _RimTex;
            float _RimTiling;
            float _RimMean;
            float _RimContrast;
            sampler2D _SmudgeTex;
            float _SmudgeTiling;
            float _SmudgeStrength;
            float _SmudgeMean;
            fixed4 _SmudgeColor;
            float _SmudgeCenterClear;

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

            // Signed distance to a rounded box, negative inside. The standard construction.
            float RoundedBox(float2 p, float2 half_, float radius)
            {
                float2 q = abs(p) - half_ + radius;
                return length(max(q, 0.0)) + min(max(q.x, q.y), 0.0) - radius;
            }

            fixed4 Frag(Varyings input) : SV_Target
            {
                // Aspect-corrected visor space (x scaled by the live screen aspect, units of screen
                // height) so the shape is authored in true on-screen proportions. The opening is an
                // SDF composition after the mech-cockpit reference: a wide rounded window, minus a
                // rounded notch hanging from the top edge, minus a console block rising from the
                // bottom edge. d < 0 is glass; every band below is measured off d's own screen
                // gradient, so widths stay perceptually even along any part of the outline.
                float2 delta = input.uv - _OpeningCenter.xy;
                delta.x *= _ScreenParams.x / _ScreenParams.y;

                float d = RoundedBox(delta, float2(_HalfWidth, _HalfHeight), _CornerRadius);

                float dTop = RoundedBox(delta - float2(0.0, _HalfHeight),
                    float2(_TopNotchWidth, _TopNotchDepth), _TopNotchRadius);
                d = max(d, -dTop);

                float dBottom = RoundedBox(delta + float2(0.0, _HalfHeight),
                    float2(_BottomNotchWidth, _BottomNotchDepth), _BottomNotchRadius);
                d = max(d, -dBottom);

                // The traced reference silhouette, when assigned, takes over from the parametric
                // window. Sampled straight in screen UV: the source is 3:2, so the outline widens
                // a touch on a 16:9 screen; band widths stay even regardless via the gradient.
                float shapeSample = tex2D(_ShapeTex, input.uv).r;
                d = lerp(d, (shapeSample - 0.5) * _ShapeRange, _ShapeBlend);

                float gradient = max(fwidth(d), 1e-4);
                float pixels = d / gradient;

                float shadowPixels = max(_GlassShadowWidth / gradient, 1.0);
                float rimPixels = max(_RimWidth / gradient, 1.0);

                float glassOnly = saturate(_GlassOnly);

                // Inside the opening: only the frame's soft shadow, fading to fully clear glass.
                float glassShadow = _GlassShadowStrength * saturate(1.0 + pixels / shadowPixels);
                glassShadow *= glassShadow; // quadratic falloff hugs the rim instead of hazing the view
                glassShadow *= 1.0 - glassOnly;

                // Frame coverage turns on across one pixel at the boundary and stays on outside.
                float frameMask = saturate(pixels + 0.5) * (1.0 - glassOnly);

                // Rim band sits just outside the boundary; lit from above, so the chin catches more.
                float rimMask = frameMask * saturate(1.0 - (pixels - rimPixels) / max(rimPixels, 1.0));
                float rimLight = lerp(_RimBottomBrightness, _RimTopBrightness,
                    saturate(delta.y / max(_HalfHeight, 1e-4) * 0.5 + 0.5));

                float wear = 1.0 - _FrameNoise * ValueNoise(input.uv * 60.0) * frameMask;

                // Shell: the rubber map modulates the frame colour. Samples are divided by the
                // map's own measured mean (in linear space, where the sampler hands them over) so
                // the modulation is centred on 1 whatever the map's exposure — the first pass
                // multiplied a near-black base by a near-black map and vanished. Contrast is then
                // expanded around that centre, and the shell falls off darker away from the
                // opening: the inside of a helmet is lit by the glass, not by itself. The 16:9
                // stretch on canvas UV is corrected so the grain stays square.
                float3 shellSample = tex2D(_ShellTex, input.uv * _ShellTiling * float2(1.778, 1.0)).rgb;
                float shellDetail = pow(max(dot(shellSample, float3(0.299, 0.587, 0.114)), 1e-4)
                    / max(_ShellMean, 1e-3), _ShellContrast);
                float shellShade = lerp(1.0, clamp(shellDetail, 0.35, 2.2), _ShellTexStrength);
                float shellFalloff = saturate(1.1 - d);

                // Rim: brushed metal sampled in band space — angle around the ring by depth across
                // it — so the grain follows the clamp band instead of tiling across the screen. The
                // map's streak variance is tiny, so the same mean-normalise + contrast expansion
                // turns it into visible brushing.
                float angle = atan2(delta.y, delta.x);
                float2 rimUV = float2(angle * 0.7958, saturate((pixels + rimPixels) /
                    max(rimPixels * 2.0, 1.0))) * float2(_RimTiling, 1.0);
                float rimDetail = pow(max(dot(tex2D(_RimTex, rimUV).rgb,
                    float3(0.299, 0.587, 0.114)), 1e-4) / max(_RimMean, 1e-3), _RimContrast);

                float3 colour = _FrameColor.rgb * wear * shellShade * shellFalloff;
                colour = lerp(colour, _RimColor.rgb * rimLight * clamp(rimDetail, 0.4, 1.9), rimMask);

                float alpha = lerp(glassShadow, 1.0, frameMask);

                // Glass smudges: fingerprints ghosting in near the frame, strongest just inside the
                // shadow band, gone by mid-glass — grime lives where the glass meets the seal. The
                // map is sparse bright wisps on black; dividing by its bright-end scale keeps the
                // wisps and drops the noise floor.
                // Aspect-corrected like the shell grain: a fingerprint stretched 16:9 stops
                // reading as a fingerprint and starts reading as printed pattern.
                float smudge = saturate(dot(tex2D(_SmudgeTex,
                    input.uv * _SmudgeTiling * float2(1.778, 1.0)).rgb,
                    float3(0.299, 0.587, 0.114)) / max(_SmudgeMean, 1e-3));

                // Edge to edge there is no seal for grime to collect against, and a flat mask
                // spreads the map over the whole view — which reads as patterned glass rather than
                // as dirt. Grime gathers instead where the wearer neither wipes nor looks: away
                // from the centre of the field of view.
                float2 fromCentre = (input.uv - 0.5) * float2(1.778, 1.0);
                float periphery = saturate((length(fromCentre) - _SmudgeCenterClear)
                    / max(1.02 - _SmudgeCenterClear, 1e-3));

                float smudgeMask = lerp(saturate(1.0 + pixels / max(shadowPixels * 2.2, 1.0)),
                    periphery, glassOnly) * (1.0 - frameMask);
                float smudgeAmount = smudge * _SmudgeStrength * smudgeMask * smudgeMask;
                colour = lerp(colour, _SmudgeColor.rgb, saturate(smudgeAmount * 2.0));
                alpha = saturate(alpha + smudgeAmount);

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
