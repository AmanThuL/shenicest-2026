// The flowers that open on the StMuerte statue: stems, petals and centres, three thousand of
// them in one mesh, each opening as the growth front reaches it.
//
// Why this exists next to Environment/StatueBloom: that shader reveals cover by clipping it in,
// which makes growth *appear* and is the right tool for something lying flat on the robe. It
// cannot make a flower open, because nothing about it moves. This one deforms geometry -- the
// petals swing out of a shut bud through a baked arc -- and that is the whole difference between
// a fade and a bloom. The two share the vertex-colour contract, the _Growth scalar, the broadcast
// sun and the (1 + span) reveal arithmetic, so they stay in step by construction.
//
// Structure follows Environment/StatueBloom exactly, plus HAVE_MESH_MODIFICATION: HDRP's
// VertMesh.hlsl calls ApplyMeshModification for every pass, so the depth pass deforms with the
// forward pass and the silhouette in the depth buffer is the one that gets shaded.
//
// Opaque rather than cutout: these are real petals, not a texture with holes in it, and an
// unnecessary clip costs the depth pass its early-z.
Shader "RootsDance/Environment/StatueFlowers"
{
    Properties
    {
        // The whole animation. 0 is bare stone, 1 is every flower open; the driver owns this and
        // writes the same value to the cover's material.
        _Growth("Growth", Range(0, 1)) = 1.0

        // How much growth one flower takes to open. Small: a flower opens far faster than the
        // front crosses the statue.
        _OpenSpan("Open span", Range(0.01, 0.5)) = 0.10

        _PetalTint("Petal", Color) = (0.86, 0.42, 0.52, 1)
        _CentreTint("Centre", Color) = (0.95, 0.82, 0.36, 1)
        _FoliageTint("Stem and leaf", Color) = (0.32, 0.45, 0.26, 1)

        // What a petal looks like in the moment it opens, before it settles into _PetalTint.
        _YoungTint("New growth", Color) = (0.95, 0.88, 0.62, 1)

        // How much darker a petal is where it is rooted.
        _PetalRootShade("Petal root shade", Range(0.3, 1)) = 0.68

        // Spread between flowers, keyed off vertex colour G.
        _FlowerVariation("Flower variation", Range(0, 0.6)) = 0.22

        // Metres the whole flower is pushed down its own axis into the stone, so the stem is
        // rooted in the robe rather than standing on it. Read from the aim baked into UV0.
        _Sink("Sink into the stone", Range(0, 0.3)) = 0.06

        _Sway("Sway", Range(0, 0.5)) = 0.06
        _SwaySpeed("Sway speed", Range(0, 6)) = 1.1

        _Wrap("Light wrap", Range(0, 1)) = 0.55
        _AmbientFloor("Ambient floor", Range(0, 2)) = 0.7
        _Specular("Specular", Range(0, 2)) = 0.2
        _Gloss("Gloss", Range(1, 128)) = 18
        _Emission("Emission", Range(0, 4)) = 0.0

        [HideInInspector] _SurfaceType("Surface type", Float) = 0
    }

    HLSLINCLUDE

    #pragma target 4.5
    #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch switch2

    #pragma multi_compile_instancing
    #pragma multi_compile _ DOTS_INSTANCING_ON

    // The opening. VertMesh.hlsl calls ApplyMeshModification only when this is defined, and it is
    // defined here rather than per pass so the depth pass cannot be left behind.
    #define HAVE_MESH_MODIFICATION

    // The baked poses live in UV1..UV3 and the growth order in vertex colour; no unlit pass header
    // asks for any of them. Without these the deltas read 0, every flower renders permanently open
    // and there is no shader error to explain it.
    #define ATTRIBUTES_NEED_COLOR
    #define ATTRIBUTES_NEED_TEXCOORD0
    #define ATTRIBUTES_NEED_TEXCOORD1
    #define ATTRIBUTES_NEED_TEXCOORD2
    #define ATTRIBUTES_NEED_TEXCOORD3
    #define VARYINGS_NEED_COLOR

    // Both passes run the surface function, and it shades a petal by which side of it is being
    // looked at. Without this input.isFrontFace is never written and every other petal picks a
    // random side to be lit from.
    #define VARYINGS_NEED_CULLFACE

    #define ATTRIBUTES_NEED_NORMAL
    #define ATTRIBUTES_NEED_TANGENT
    #define VARYINGS_NEED_POSITION_WS
    #define VARYINGS_NEED_TANGENT_TO_WORLD

    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"

    CBUFFER_START(UnityPerMaterial)
    float _Growth;
    float _OpenSpan;
    float4 _PetalTint;
    float4 _CentreTint;
    float4 _FoliageTint;
    float4 _YoungTint;
    float _PetalRootShade;
    float _FlowerVariation;
    float _Sink;
    float _Sway;
    float _SwaySpeed;
    float _Wrap;
    float _AmbientFloor;
    float _Specular;
    float _Gloss;
    float _Emission;
    CBUFFER_END

    // --- Sky and sun, written by SunBroadcaster once per camera ---------------------------------
    // Outside UnityPerMaterial, so SRP batching survives. Shared with StatueBloom.

    float4 _RootsSunDirection;
    float4 _RootsSunColor;
    float4 _RootsSkyColor;

    ENDHLSL

    SubShader
    {
        Tags
        {
            "RenderPipeline" = "HDRenderPipeline"
            "RenderType" = "Opaque"
            "Queue" = "Geometry"
        }

        Pass
        {
            Name "DepthForwardOnly"
            Tags { "LightMode" = "DepthForwardOnly" }

            // Petals are single sheets, seen from both sides as the player walks around.
            Cull Off
            ZWrite On

            HLSLPROGRAM

            #pragma vertex Vert
            #pragma fragment Frag

            #pragma multi_compile_fragment _ WRITE_MSAA_DEPTH

            #define SHADERPASS SHADERPASS_DEPTH_ONLY

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/ShaderPass/UnlitDepthPass.hlsl"

            #include "StatueFlowers.hlsl"

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassDepthOnly.hlsl"

            ENDHLSL
        }

        Pass
        {
            Name "ForwardOnly"
            Tags { "LightMode" = "ForwardOnly" }

            Blend One Zero
            ZWrite On
            ZTest LEqual
            Cull Off

            HLSLPROGRAM

            #pragma vertex Vert
            #pragma fragment Frag

            #pragma multi_compile _ DEBUG_DISPLAY

            #define SHADERPASS SHADERPASS_FORWARD_UNLIT

            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/ShaderPass/UnlitSharePass.hlsl"

            #include "StatueFlowers.hlsl"

            #include_with_pragmas "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassForwardUnlit.hlsl"

            ENDHLSL
        }
    }

    FallBack Off
}
