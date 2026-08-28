// A folded sheet of paper, for the archive documents.
// See docs/architecture/systems/纸张折痕研究.md for where the numbers come from.
//
// This shader draws the WHOLE page — the paper and everything written on it, already composed into
// one texture — and folds all of it together. That is the point, and it is what the first version
// got wrong: it lit the paper layer and left the writing lying flat on top, so the page read as
// text pasted onto a photograph of paper. Ink is *on* the paper. Fold the paper, fold the writing.
//
// The fold field carries the height of the creases in R, its gradient in GB, and the burnished
// shoulder in A. The gradient does two jobs:
//   * it displaces the sampled page, so the writing is pulled into the valley and stretched over
//     the shoulder, exactly as ink on a real folded sheet is;
//   * it stands in for the surface normal, so the valley shades and the shoulder catches a sheen.
//
// A crease is three zones, not a line: a narrow crushed valley (~0.3 mm on 80 g/m² paper), a wide
// burnished shoulder either side (~1.5 mm), then flat. The shoulder highlight is what actually
// reads as a fold — a dark line on its own reads as a dirty mark.
//
// Plain uGUI shader against UnityCG/UnityUI only - no pipeline include - like the terminal
// materials next to it, so it is unaffected by the render pipeline.
Shader "RootsDance/UI/ArchivePaper"
{
    Properties
    {
        [PerRendererData] _MainTex ("Composed Page", 2D) = "white" {}
        _Color ("Tint", Color) = (1, 1, 1, 1)

        _FoldTex ("Fold Field (R crease, GB panel tilt, A shoulder)", 2D) = "grey" {}
        _WarpTex ("Warp Field (RG shear across each crease)", 2D) = "grey" {}

        _PaperLight ("Paper Light", Color) = (1, 1, 1, 1)
        _LightDirection ("Light Direction (page space)", Vector) = (-0.4, 0.55, 0.73, 0)

        _WarpStrength ("Fold Warp", Range(0, 0.05)) = 0.010
        _CreaseDarken ("Crease Line", Range(0, 2)) = 0.55
        _ReliefStrength ("Relief Strength", Range(0, 8)) = 3
        _AmbientWrap ("Ambient Wrap", Range(0, 1)) = 0.55
        _Sheen ("Fold Sheen", Range(0, 2)) = 0.35
        _Gloss ("Sheen Tightness", Range(1, 64)) = 24

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
            Name "ArchivePaper"

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 2.5
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

            sampler2D _FoldTex;
            sampler2D _WarpTex;
            fixed4 _PaperLight;
            float4 _LightDirection;
            float _WarpStrength;
            float _CreaseDarken;
            float _ReliefStrength;
            float _AmbientWrap;
            float _Sheen;
            float _Gloss;

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
                float4 fold = tex2D(_FoldTex, IN.texcoord);

                // How each panel leans. This shades the sheet — but it is deliberately NOT what
                // moves the writing: a panel's tilt is constant across the whole panel, so warping
                // by it slides every glyph on that panel together and deforms none of them.
                float2 slope = fold.gb * 2.0 - 1.0;

                // What actually bends the letters. A step across each crease, so anything lying
                // over one is sheared: the sheet turns through its whole dihedral inside about a
                // millimetre, and seen flat-on the writing there is squeezed and offset.
                float2 shear = tex2D(_WarpTex, IN.texcoord).rg * 2.0 - 1.0;
                float2 folded = IN.texcoord - shear * _WarpStrength;

                half4 page = (tex2D(_MainTex, folded) + _TextureSampleAdd) * IN.color;

                // The crease line itself: narrow, and dark because the crushed fibres hold dirt
                // and shade themselves. Taken from the height rather than the slope so it stays a
                // fifth of a millimetre wide instead of spreading to the width of the bend.
                float height = fold.r * 2.0 - 1.0;
                half crease = saturate(-height) * _CreaseDarken;

                // The bend's slope doubles as the surface normal — the sheet is flat apart from
                // where it was folded, so there is nothing else for a normal to describe.
                half3 normal = normalize(half3(-slope * _ReliefStrength, 1));
                half3 lightDir = normalize(_LightDirection.xyz);

                // Wrapped diffuse: paper is thin and scatters, so the shaded side of a fold goes
                // dim rather than black. An unwrapped N·L puts hard black lines across the sheet.
                half ndl = dot(normal, lightDir);
                half diffuse = saturate((ndl + _AmbientWrap) / (1.0h + _AmbientWrap));

                // The burnished shoulder catching the light. This is the part that reads as a fold.
                half3 halfVector = normalize(lightDir + half3(0, 0, 1));
                half sheen = pow(saturate(dot(normal, halfVector)), _Gloss) * _Sheen * fold.a;

                page.rgb = (page.rgb * diffuse * (1.0h - crease) + sheen) * _PaperLight.rgb;

                #ifdef UNITY_UI_CLIP_RECT
                page.a *= UnityGet2DClipping(IN.worldPosition.xy, _ClipRect);
                #endif

                #ifdef UNITY_UI_ALPHACLIP
                clip (page.a - 0.001);
                #endif

                return page;
            }
            ENDCG
        }
    }
}
