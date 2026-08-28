// SDF text for a canvas that lives in the world, drawn the way HDRP will actually draw it.
//
// TextMeshPro's own SDF shaders render nothing on this project's diegetic screens: the report
// canvas sits at a local scale of about 1e-4 (a 1060-unit layout mapped onto a 10 cm plate), and
// TMP's antialiasing width is derived from the transform's scale, which collapses to zero there —
// the glyphs are emitted, batched and simply come out fully transparent. Images on the same canvas
// are fine because UI/Default does no such maths, which is what made this look like "the text was
// deleted" rather than a rendering fault.
//
// So this keeps UI/Default's pass structure verbatim and derives the edge width from the screen
// derivative of the atlas UV instead. That is independent of how small the canvas is, so the same
// material reads correctly on a 10 cm plate and on a full-screen overlay.
Shader "RootsDance/UI/WorldSpaceText"
{
    Properties
    {
        [PerRendererData] _MainTex ("Font Atlas", 2D) = "white" {}
        _FaceColor ("Face Colour", Color) = (1, 1, 1, 1)
        _Sharpness ("Edge Sharpness", Range(0.1, 4)) = 1

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
            Name "WorldSpaceText"
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 2.0
            #include "UnityCG.cginc"
            #include "UnityUI.cginc"
            #pragma multi_compile_local _ UNITY_UI_CLIP_RECT
            #pragma multi_compile_local _ UNITY_UI_ALPHACLIP

            struct appdata
            {
                float4 vertex : POSITION;
                float4 color : COLOR;
                float2 uv : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                fixed4 color : COLOR;
                float2 uv : TEXCOORD0;
                float4 worldPosition : TEXCOORD1;
                UNITY_VERTEX_OUTPUT_STEREO
            };

            sampler2D _MainTex;
            fixed4 _FaceColor;
            float _Sharpness;
            float4 _ClipRect;

            v2f vert(appdata input)
            {
                v2f output;
                UNITY_SETUP_INSTANCE_ID(input);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);
                output.worldPosition = input.vertex;
                output.vertex = UnityObjectToClipPos(input.vertex);
                output.uv = input.uv;
                output.color = input.color * _FaceColor;
                return output;
            }

            fixed4 frag(v2f input) : SV_Target
            {
                // TMP packs the signed distance in alpha, 0.5 on the outline. The edge width comes
                // from how fast the atlas UV moves across one pixel — a screen-space quantity, so
                // it holds whatever the canvas's world scale happens to be.
                float distance = tex2D(_MainTex, input.uv).a - 0.5;
                float width = max(length(float2(ddx(input.uv.x), ddy(input.uv.y))), 1e-6);
                float coverage = saturate(distance / (width * 64.0 / max(_Sharpness, 0.1)) + 0.5);

                fixed4 result = input.color;
                result.a *= coverage;

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
