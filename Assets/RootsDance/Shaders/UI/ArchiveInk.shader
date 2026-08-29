// Ink on old paper, for the archive sheets (docs/architecture/systems/旧档案拾取与阅读.md).
//
// HDRP shades a uGUI canvas Unlit and nothing changes that (guideline 07 §7). On a screen-space HUD
// that is what you want; on a sheet of paper lying in a dark room it is the whole problem, because
// unlit ink keeps its full brightness while the paper under it goes dark, and the writing reads as a
// decal floating in front of the prop rather than as something absorbed into it.
//
// So the paper itself is a lit HDRP/Lit surface and only the ink is drawn by this shader, which is
// handed the light the paper is actually receiving (_PaperLight, written by ArchivePaperLighting)
// and multiplies the ink by it. Two more things make the difference between "printed on glass" and
// "soaked into fibre": the grain, which eats into the ink where the paper is rough, and the bleed,
// which softens the glyph edge the way ink wicks along a fibre.
//
// There is deliberately no grain term here any more. It used to multiply the ink by the paper
// texture sampled at the sheet's own coordinates — but the page is 1000 x 1200 canvas units and
// the scale was per-unit, so it tiled a 2048px non-tileable scan six by seven times across the
// sheet and printed its seams as a grid over the whole document. The paper underneath is a real
// scan with real fibre; the ink does not need to invent any.
//
// Plain uGUI shader against UnityCG/UnityUI only - no pipeline include - like the terminal
// materials next to it, so it is unaffected by the render pipeline.
Shader "RootsDance/UI/ArchiveInk"
{
    Properties
    {
        [PerRendererData] _MainTex ("Source", 2D) = "white" {}
        _Color ("Tint", Color) = (1, 1, 1, 1)

        _PaperLight ("Paper Light", Color) = (1, 1, 1, 1)
        _Fade ("Ink Fade", Range(0, 1)) = 0.15
        _Bleed ("Ink Bleed", Range(0, 1)) = 0.35

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

        // Separate alpha blending. These layers are composed into a transparent render target so
        // the sheet's torn silhouette survives into the composed page; with the usual single-factor
        // blend the destination alpha accumulates as srcA² and the edge comes out semi-transparent.
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ColorMask [_ColorMask]

        Pass
        {
            Name "ArchiveInk"

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 2.0
            #include "UnityCG.cginc"
            #include "UnityUI.cginc"
            #pragma multi_compile_local _ UNITY_UI_CLIP_RECT
            #pragma multi_compile_local _ UNITY_UI_ALPHACLIP

            struct appdata_t
            {
                float4 vertex   : POSITION;
                float4 color    : COLOR;
                float2 texcoord : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f
            {
                float4 vertex   : SV_POSITION;
                fixed4 color    : COLOR;
                float2 texcoord : TEXCOORD0;
                float4 worldPosition : TEXCOORD1;
                UNITY_VERTEX_OUTPUT_STEREO
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed4 _Color;
            fixed4 _TextureSampleAdd;
            float4 _ClipRect;

            fixed4 _PaperLight;
            float _Fade;
            float _Bleed;

            v2f vert (appdata_t v)
            {
                v2f OUT;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
                OUT.worldPosition = v.vertex;
                OUT.vertex = UnityObjectToClipPos(OUT.worldPosition);
                OUT.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
                OUT.color = v.color * _Color;
                return OUT;
            }

            fixed4 frag (v2f IN) : SV_Target
            {
                half4 ink = (tex2D(_MainTex, IN.texcoord) + _TextureSampleAdd) * IN.color;

                // Ink wicks along the fibre, so the edge of a glyph is never a clean step. Pushing
                // the alpha through a smoothstep widens the transition without moving the middle.
                half soft = smoothstep(0.0h, 1.0h, ink.a);
                ink.a = lerp(ink.a, soft, _Bleed);

                // Age, then the light the paper under it is actually receiving.
                ink.a *= 1.0h - _Fade * 0.55h;
                ink.rgb *= _PaperLight.rgb;

                #ifdef UNITY_UI_CLIP_RECT
                ink.a *= UnityGet2DClipping(IN.worldPosition.xy, _ClipRect);
                #endif

                #ifdef UNITY_UI_ALPHACLIP
                clip (ink.a - 0.001);
                #endif

                return ink;
            }
            ENDCG
        }
    }
}
