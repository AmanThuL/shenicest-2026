// Fluorescent reveal: marks that are invisible in ordinary light and glow where the flashlight
// beam falls on them, the way a UV-reactive ink reads under a black light.
//
// This is an ordinary HDRP material, not a custom pass: it goes on a thin quad laid over the
// surface that carries the marks, so the surface underneath keeps its own HDRP/Lit material and
// nothing about the base asset has to change. The quad draws additively in the transparent queue
// at Before Post Process, so the glow feeds bloom.
//
// The pass structure is HDRP's own Unlit ForwardOnly pass with one substitution: UnlitData.hlsl,
// which normally fills SurfaceData from the unlit properties, is replaced by the
// GetSurfaceAndBuiltinData below. Same trick RootsDance/Props/ScannerLines uses, so the two
// shaders fail and are fixed the same way if HDRP changes its unlit plumbing.
//
// Where the beam comes from is *not* material state. FlashlightBeamBroadcaster writes it as shader
// globals once per camera, because the flashlight lives in the gameplay scene and the marked
// surfaces live in environment scenes - there is no serialized reference that could cross that
// boundary. Globals sit outside the UnityPerMaterial cbuffer, so SRP batching survives.
Shader "RootsDance/Environment/FluorescentReveal"
{
    Properties
    {
        [NoScaleOffset] _RuneMask("Mark coverage (R)", 2D) = "black" {}

        [HDR] _GlowColor("Glow colour", Color) = (0.35, 1.0, 0.55, 1)
        _GlowIntensity("Glow intensity", Float) = 6.0

        // 0 keeps the marks completely invisible until the beam arrives; a little is useful while
        // dressing the scene, and to hint that something is there at all.
        _RestingGlow("Resting glow", Range(0, 1)) = 0.0

        // >1 makes the marks hold back until the beam is squarely on them, which reads as a
        // material that needs real UV energy rather than a switch.
        _RevealSharpness("Reveal sharpness", Range(0.25, 8)) = 2.0

        // How much the beam has to face the surface. 0 lights the marks from any grazing angle.
        _FacingBias("Facing bias", Range(0, 1)) = 0.35

        // HDRP's transparent path reads this even though the blend state below is hard-coded, so
        // it has to exist. 1 is Additive, which is what that state does.
        [HideInInspector] _BlendMode("Blend mode", Float) = 1
    }

    HLSLINCLUDE

    #pragma target 4.5
    #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch switch2

    #pragma multi_compile_instancing
    #pragma multi_compile _ DOTS_INSTANCING_ON

    // Transparent from the shader's point of view: additive, never in the depth prepass.
    #define _SURFACE_TYPE_TRANSPARENT

    // The reveal is evaluated in world space against the beam, so the fragment needs its world
    // position and its normal on top of the UVs UnlitSharePass already asks for.
    #define VARYINGS_NEED_POSITION_WS
    #define ATTRIBUTES_NEED_NORMAL
    #define VARYINGS_NEED_TANGENT_TO_WORLD

    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"

    TEXTURE2D(_RuneMask);
    SAMPLER(sampler_RuneMask);

    CBUFFER_START(UnityPerMaterial)
    float4 _GlowColor;
    float _GlowIntensity;
    float _RestingGlow;
    float _RevealSharpness;
    float _FacingBias;
    float _BlendMode;
    CBUFFER_END

    // --- Beam state, written by FlashlightBeamBroadcaster once per camera ------------------------

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
            "RenderType" = "Transparent"
            "Queue" = "Transparent+10"
        }

        Pass
        {
            Name "ForwardOnly"
            Tags { "LightMode" = "ForwardOnly" }

            // Additive on colour, destination alpha untouched: HDRP keeps coverage there for
            // after-post-process compositing and a glow overlay has no business editing it.
            Blend One One, Zero One
            ZWrite Off
            ZTest LEqual

            // Two-sided on purpose: the overlay is a flat quad whose front face is whichever way
            // the dressing tool happened to aim it, and getting that backwards should show as a
            // glow in the wrong place, not as nothing at all. Depth still hides it from behind the
            // wall it sits on, so nothing leaks through solid geometry.
            Cull Off

            HLSLPROGRAM

            #pragma vertex Vert
            #pragma fragment Frag

            #define SHADERPASS SHADERPASS_FORWARD_UNLIT

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/ShaderPass/UnlitSharePass.hlsl"

            /// How much energy the beam delivers to this fragment, 0..1, before the mark's own
            /// response curve. Cone, range and facing are separate factors so each can be read on
            /// its own when the effect looks wrong.
            float BeamEnergy(float3 positionWS, float3 normalWS)
            {
                float3 toFragment = positionWS - _RootsFlashlightPosition.xyz;
                float distance = length(toFragment);
                float3 direction = toFragment / max(distance, 1e-5);

                float axis = dot(direction, _RootsFlashlightDirection.xyz);

                // Outer to inner, so the fragment brightens across the cone's penumbra exactly
                // where the real spot light's own falloff puts it.
                float cone = smoothstep(_RootsFlashlightCone.x, _RootsFlashlightCone.y, axis);

                // A torch does not stop at the edge of its bright pool: a wide, weak wash carries
                // past it. Without this a mark is either fully read or invisible, and the player
                // has no way to notice one is there before the beam is already square on it. Taken
                // as a max rather than a sum so the bright cone is exactly as bright as before.
                float spill = smoothstep(_RootsFlashlightSpill.x, _RootsFlashlightCone.x, axis)
                            * saturate(_RootsFlashlightSpill.y);

                cone = max(cone, spill);

                // Fades over the last quarter of the range rather than at a hard edge.
                float range = 1.0 - smoothstep(_RootsFlashlightCone.z * 0.75,
                                              _RootsFlashlightCone.z, distance);

                // A mark on a wall does not light up from the beam skimming along it. Bias 0 drops
                // the term entirely, for marks on geometry whose normals cannot be trusted.
                float facing = lerp(1.0, saturate(dot(normalWS, -direction)), saturate(_FacingBias));

                return cone * range * facing * saturate(_RootsFlashlightCone.w);
            }

            void GetSurfaceAndBuiltinData(FragInputs input, float3 V, inout PositionInputs posInput,
                out SurfaceData surfaceData, out BuiltinData builtinData)
            {
                ZERO_BUILTIN_INITIALIZE(builtinData); // unlit: nothing to light
                ZERO_INITIALIZE(SurfaceData, surfaceData);
                builtinData.opacity = 1.0;
                builtinData.emissiveColor = 0.0;
                surfaceData.normalWS = 0.0;

                float coverage = SAMPLE_TEXTURE2D(_RuneMask, sampler_RuneMask, input.texCoord0.xy).r;

                float3 positionWS = GetAbsolutePositionWS(input.positionRWS);
                float3 normalWS = normalize(input.tangentToWorld[2].xyz);

                float energy = BeamEnergy(positionWS, normalWS);
                float reveal = pow(saturate(energy), max(_RevealSharpness, 1e-3));

                // The resting level is a floor, not a summand: at full beam the mark is exactly as
                // bright as it would be with no resting glow at all.
                float lit = max(reveal, saturate(_RestingGlow));

                // Additive: the black between the strokes contributes nothing, so no cutout needed.
                surfaceData.color = _GlowColor.rgb * (_GlowIntensity * coverage * lit);
            }

            #include_with_pragmas "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassForwardUnlit.hlsl"

            ENDHLSL
        }
    }

    Fallback Off
}
