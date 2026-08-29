// BOT-AL-017 荧光藻: a thin, translucent blue-green film that clings to hard surfaces, glows on
// its own in the dark, and picks up a wet gelatinous highlight when the flashlight sweeps over it.
//
// Why this is a hand-written HDRP shader and not a Shader Graph: the beam interaction wants the
// same _RootsFlashlight* globals that Environment/FluorescentReveal already reads, and the two
// effects should fail and be fixed the same way if HDRP changes its unlit plumbing. Everything
// below is HDRP's own Unlit pass structure with one substitution - UnlitData.hlsl, which normally
// fills SurfaceData from the unlit properties, is replaced by the GetSurfaceAndBuiltinData in the
// sibling BioluminescentAlgae.hlsl. That function is included per pass, after Unlit.hlsl has
// defined SurfaceData, rather than being hoisted above the passes; hoisted, it compiles in
// whichever pass includes the most and fails in the other. Environment/StatueBloom is laid out
// the same way.
//
// Opaque with alpha clip, not blended: the patches are small and numerous, and a cutout keeps them
// out of transparent sorting entirely. The ragged rim comes from clipping, so the mesh silhouette
// stays cheap.
//
// The mesh carries three data channels in its vertex colour, written by the patch generator:
//   R  rim falloff, 1 well inside the patch and 0 at the authored outline
//   G  a constant per patch, so neighbouring patches pulse out of phase instead of breathing as one
//   B  growth order, the normalised distance from that patch's seed point outwards
// Vertex colours must import as DATA, not colour: the FBX is exported with LINEAR colours and the
// model importer must not be left on sRGB, or the rim falloff bends and the outline moves.
//
// _WrinkleNormal must be imported as a Normal Map, and _DensityMap as a non-sRGB texture. The UVs
// are world-scaled at authoring time (one tile per 0.45 m of surface), so every patch shows the
// same wrinkle density no matter how it is scaled in the scene.
Shader "RootsDance/Environment/BioluminescentAlgae"
{
    Properties
    {
        _WrinkleNormal("Wrinkle normal", 2D) = "bump" {}
        _NormalStrength("Wrinkle strength", Range(0, 3)) = 1.15

        // Thickness of the film. Drives where it glows brightest and where the rim erodes away.
        [NoScaleOffset] _DensityMap("Density (R)", 2D) = "white" {}

        _BaseTint("Base tint", Color) = (0.030, 0.150, 0.165, 1)
        [HDR] _EmissionTint("Emission tint", Color) = (0.075, 0.560, 0.640, 1)
        _EmissionStrength("Emission strength", Float) = 1.4

        // 2 to 3 seconds is the pulse the chapter asks for; 0.4 is a 2.5 s period.
        _PulseSpeed("Pulse speed (Hz)", Range(0, 2)) = 0.4
        _PulseDepth("Pulse depth", Range(0, 1)) = 0.22

        // The rim is clipped, not blended. Cutoff + erode must stay below 1 or the middle of the
        // patch starts punching holes as well, which reads as rot rather than as a thin edge.
        _AlphaCutoff("Alpha cutoff", Range(0, 1)) = 0.30
        _EdgeErode("Edge erosion", Range(0, 0.6)) = 0.28

        // Wet gel response to the flashlight. Diffuse is wrapped because a translucent film keeps
        // carrying light well past its own terminator.
        _WetGloss("Wet gloss", Range(4, 256)) = 64
        _WetSpecular("Wet specular", Range(0, 4)) = 1.1
        _Wrap("Translucency wrap", Range(0, 1)) = 0.55
        _AmbientFloor("Ambient floor", Range(0, 1)) = 0.06

        // How much brighter the film glows while the beam is on it. Chapter 02 lists this as P1;
        // 0 turns it off without touching anything else.
        _InteractionBoost("Beam boost", Range(0, 4)) = 0.0

        // Growth reveal. 1 shows the whole patch; animate towards 0 to retract it along vertex B.
        _Growth("Growth", Range(0, 1)) = 1.0
        _GrowthSoftness("Growth softness", Range(0.01, 1)) = 0.25
    }

    HLSLINCLUDE

    #pragma target 4.5
    #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch switch2

    #pragma multi_compile_instancing
    #pragma multi_compile _ DOTS_INSTANCING_ON

    // The film is shaded by hand against the beam, so the fragment needs its world position, a
    // tangent frame for the wrinkle normal, the UVs, and the vertex colour that carries rim,
    // phase and growth order.
    #define ATTRIBUTES_NEED_NORMAL
    #define ATTRIBUTES_NEED_TANGENT
    #define ATTRIBUTES_NEED_TEXCOORD0
    #define ATTRIBUTES_NEED_COLOR
    #define VARYINGS_NEED_POSITION_WS
    #define VARYINGS_NEED_TANGENT_TO_WORLD
    #define VARYINGS_NEED_TEXCOORD0
    #define VARYINGS_NEED_COLOR

    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"

    TEXTURE2D(_WrinkleNormal);
    SAMPLER(sampler_WrinkleNormal);
    TEXTURE2D(_DensityMap);
    SAMPLER(sampler_DensityMap);

    CBUFFER_START(UnityPerMaterial)
    float4 _WrinkleNormal_ST;
    float4 _BaseTint;
    float4 _EmissionTint;
    float _NormalStrength;
    float _EmissionStrength;
    float _PulseSpeed;
    float _PulseDepth;
    float _AlphaCutoff;
    float _EdgeErode;
    float _WetGloss;
    float _WetSpecular;
    float _Wrap;
    float _AmbientFloor;
    float _InteractionBoost;
    float _Growth;
    float _GrowthSoftness;
    CBUFFER_END

    // --- Beam state, written by FlashlightBeamBroadcaster once per camera ------------------------
    // Same globals Environment/FluorescentReveal reads. They sit outside UnityPerMaterial so SRP
    // batching survives.

    float4 _RootsFlashlightPosition;   // xyz: cone apex in absolute world space
    float4 _RootsFlashlightDirection;  // xyz: beam axis, normalised by C#
    float4 _RootsFlashlightCone;       // x: cos(outer half-angle)  y: cos(inner half-angle)
                                       // z: range in metres        w: 0..1 fade of the beam itself
    float4 _RootsFlashlightSpill;      // x: cos(spill half-angle)  y: 0..1 level of the wash

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

            // Single-sided film: it has to stay visible when the player walks past it and sees the
            // back, so nothing is culled and the clip decides the silhouette.
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

            #include "BioluminescentAlgae.hlsl"

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

            #include "BioluminescentAlgae.hlsl"

            #include_with_pragmas "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassForwardUnlit.hlsl"

            ENDHLSL
        }
    }

    Fallback Off
}
