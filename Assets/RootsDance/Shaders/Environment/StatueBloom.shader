// Growth that climbs the StMuerte statue: clumps of flowering cover, wrapped onto the robe by
// Tools/pipeline/build_bloom_patch.py, revealed by a single _Growth scalar that a driver walks
// from 0 to 1 over the ending.
//
// Why a hand-written HDRP shader and not Shader Graph: the reveal is the same arithmetic
// Environment/BioluminescentAlgae already ships, the two should fail and be fixed together if
// HDRP changes its unlit plumbing, and a graph cannot be reviewed in a diff. Why unlit rather
// than lit: HDRP's Lit is twenty passes, and the clumps need one key light and an ambient term,
// which is cheaper to state directly than to inherit. The trade is that they do not receive
// shadows -- see the plan's §6.3.
//
// Structure follows Environment/FluorescentReveal exactly, with the one difference that matters:
// GetSurfaceAndBuiltinData is included per pass from StatueBloom.hlsl, after Unlit.hlsl has
// defined SurfaceData, instead of being hoisted above the passes.
//
// ATTRIBUTES_NEED_COLOR / VARYINGS_NEED_COLOR are declared here because neither UnlitSharePass
// nor UnlitDepthPass asks for vertex colour. Without them input.color is never populated, the
// rim reads 0, the clip rejects every fragment and the statue renders bare -- with no shader
// error to explain it.
Shader "RootsDance/Environment/StatueBloom"
{
    Properties
    {
        _BaseMap("Base colour", 2D) = "white" {}
        _BaseTint("Settled tint", Color) = (0.62, 0.30, 0.45, 1)

        // What has just opened, before it settles into _BaseTint.
        _YoungTint("New growth tint", Color) = (0.86, 0.72, 0.42, 1)

        // Spread between clumps, keyed off vertex colour G.
        _ClumpVariation("Clump variation", Range(0, 0.6)) = 0.18

        _NormalMap("Normal map", 2D) = "bump" {}
        _NormalStrength("Normal strength", Range(0, 3)) = 1.0

        // The whole animation. 0 is bare stone, 1 is fully grown; the driver owns this.
        _Growth("Growth", Range(0, 1)) = 1.0

        // Width of the advancing front, in growth-order units.
        _GrowthSoftness("Growth softness", Range(0.01, 1)) = 0.25

        _AlphaCutoff("Alpha cutoff", Range(0, 1)) = 0.45

        // Raises the cutoff at a clump's edge only, so the outline stays ragged.
        _EdgeErode("Edge erosion", Range(0, 1)) = 0.35

        _Wrap("Light wrap", Range(0, 1)) = 0.45
        _AmbientFloor("Ambient floor", Range(0, 2)) = 0.6
        _Specular("Specular", Range(0, 2)) = 0.25
        _Gloss("Gloss", Range(1, 128)) = 24

        [HideInInspector] _SurfaceType("Surface type", Float) = 0
    }

    HLSLINCLUDE

    #pragma target 4.5
    #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch switch2

    #pragma multi_compile_instancing
    #pragma multi_compile _ DOTS_INSTANCING_ON

    // Opaque with a cutout: the clumps are numerous and small, and a cutout keeps them out of
    // transparent sorting entirely. _ALPHATEST_ON also makes UnlitDepthPass carry the UVs the
    // depth pass needs to run the same clip as the forward pass.
    #define _ALPHATEST_ON

    // Vertex colour is the growth data. Neither unlit pass header asks for it.
    #define ATTRIBUTES_NEED_COLOR
    #define VARYINGS_NEED_COLOR

    // Lighting is evaluated in world space against a broadcast sun, so the fragment needs its
    // normal and tangent frame on top of the UVs UnlitSharePass already asks for.
    #define ATTRIBUTES_NEED_NORMAL
    #define ATTRIBUTES_NEED_TANGENT
    #define VARYINGS_NEED_POSITION_WS
    #define VARYINGS_NEED_TANGENT_TO_WORLD

    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"

    TEXTURE2D(_BaseMap);
    SAMPLER(sampler_BaseMap);
    TEXTURE2D(_NormalMap);
    SAMPLER(sampler_NormalMap);

    CBUFFER_START(UnityPerMaterial)
    float4 _BaseMap_ST;
    float4 _BaseTint;
    float4 _YoungTint;
    float _ClumpVariation;
    float _NormalStrength;
    float _Growth;
    float _GrowthSoftness;
    float _AlphaCutoff;
    float _EdgeErode;
    float _Wrap;
    float _AmbientFloor;
    float _Specular;
    float _Gloss;
    CBUFFER_END

    // --- Sky and sun, written by SunBroadcaster once per camera ---------------------------------
    // Outside UnityPerMaterial, so SRP batching survives. The statue's light changes with the time
    // of day and the clumps have no serialized reference that could reach the scene's Sun.

    float4 _RootsSunDirection;   // xyz: the direction the sun travels, normalised by C#
    float4 _RootsSunColor;       // rgb: sun colour times intensity; black means "none broadcast"
    float4 _RootsSkyColor;       // rgb: ambient the clumps sit in

    ENDHLSL

    SubShader
    {
        Tags
        {
            "RenderPipeline" = "HDRenderPipeline"
            "RenderType" = "Opaque"
            "Queue" = "AlphaTest"
        }

        Pass
        {
            Name "DepthForwardOnly"
            Tags { "LightMode" = "DepthForwardOnly" }

            // Single-sided geometry read from both faces: a clump on the far side of the robe is
            // seen edge-on and from behind as the player walks around the statue. The clip owns
            // the silhouette, so nothing is culled.
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

            #include "StatueBloom.hlsl"

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

            #include "StatueBloom.hlsl"

            #include_with_pragmas "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassForwardUnlit.hlsl"

            ENDHLSL
        }
    }

    FallBack Off
}
