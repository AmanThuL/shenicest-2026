// BOT-AL-017 荧光藻: a thin, translucent blue-green film that clings to hard surfaces, glows on
// its own in the dark, and picks up a wet gelatinous highlight when the flashlight sweeps over it.
//
// Why this is a hand-written HDRP shader and not a Shader Graph: the beam interaction wants the
// same _RootsFlashlight* globals that Environment/FluorescentReveal already reads, and the two
// effects should fail and be fixed the same way if HDRP changes its unlit plumbing. Everything
// below is HDRP's own Unlit pass structure with one substitution - UnlitData.hlsl, which normally
// fills SurfaceData from the unlit properties, is replaced by the GetSurfaceAndBuiltinData here.
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

        HLSLINCLUDE

        /// How much energy the beam delivers here, 0..1, and which way it arrives. Kept as one
        /// function so the cone, the range fade and the spill can each be read on their own when
        /// the response looks wrong.
        float BeamEnergy(float3 positionWS, out float3 lightDirWS)
        {
            float3 toFragment = positionWS - _RootsFlashlightPosition.xyz;
            float dist = length(toFragment);
            float3 dir = toFragment / max(dist, 1e-5);
            lightDirWS = -dir;                       // surface -> torch

            float axis = dot(dir, _RootsFlashlightDirection.xyz);
            float cone = smoothstep(_RootsFlashlightCone.x, _RootsFlashlightCone.y, axis);

            // A torch does not stop at the edge of its bright pool. Taken as a max rather than a
            // sum so the bright cone stays exactly as bright as it was without the wash.
            float spill = smoothstep(_RootsFlashlightSpill.x, _RootsFlashlightCone.x, axis)
                        * saturate(_RootsFlashlightSpill.y);
            cone = max(cone, spill);

            float range = 1.0 - smoothstep(_RootsFlashlightCone.z * 0.75,
                                           _RootsFlashlightCone.z, dist);

            return cone * range * saturate(_RootsFlashlightCone.w);
        }

        void GetSurfaceAndBuiltinData(FragInputs input, float3 V, inout PositionInputs posInput,
            out SurfaceData surfaceData, out BuiltinData builtinData)
        {
            ZERO_BUILTIN_INITIALIZE(builtinData);    // unlit: nothing for HDRP to light
            ZERO_INITIALIZE(SurfaceData, surfaceData);
            builtinData.opacity = 1.0;
            builtinData.emissiveColor = 0.0;
            surfaceData.normalWS = 0.0;

            float2 uv = input.texCoord0.xy * _WrinkleNormal_ST.xy + _WrinkleNormal_ST.zw;
            float density = SAMPLE_TEXTURE2D(_DensityMap, sampler_DensityMap, uv).r;

            float rim   = saturate(input.color.r);
            float phase = input.color.g;
            float order = saturate(input.color.b);

            // Growth runs outwards along the seed distance stored in B. The softness is the width
            // of the advancing front, so it dissolves rather than snapping on.
            float soft = max(_GrowthSoftness, 1e-3);
            float grown = saturate((_Growth * (1.0 + soft) - order) / soft);

            // Density raises the clip threshold instead of scaling coverage, which confines the
            // erosion to the rim. Scaling coverage instead eats holes through the middle.
            float threshold = _AlphaCutoff + _EdgeErode * (1.0 - density);
            clip(rim * grown - threshold);

            float3 normalTS = UnpackNormalmapRGorAG(
                SAMPLE_TEXTURE2D(_WrinkleNormal, sampler_WrinkleNormal, uv), _NormalStrength);
            float3 N = normalize(TransformTangentToWorld(normalTS, input.tangentToWorld));

            float3 positionWS = GetAbsolutePositionWS(input.positionRWS);
            float3 L;
            float energy = BeamEnergy(positionWS, L);

            // Wrapped diffuse: a translucent film keeps carrying light past its own terminator, so
            // a hard N.L makes it read as painted-on plastic.
            float w = saturate(_Wrap);
            float diffuse = saturate((dot(N, L) + w) / (1.0 + w));

            float3 H = normalize(L + V);
            float spec = pow(saturate(dot(N, H)), max(_WetGloss, 1.0)) * _WetSpecular;

            float pulse = 1.0 + _PulseDepth * sin(TWO_PI * (_TimeParameters.x * _PulseSpeed + phase));

            // Beam boost is a floor on top of the resting glow, so switching it on never makes the
            // unlit film darker than it already was.
            float glow = _EmissionStrength * pulse * density * grown
                       * (1.0 + _InteractionBoost * energy);

            float3 lit = _BaseTint.rgb * (_AmbientFloor + diffuse * energy) + spec * energy;

            surfaceData.color = lit + _EmissionTint.rgb * glow;
        }

        ENDHLSL

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

            #include_with_pragmas "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassForwardUnlit.hlsl"

            ENDHLSL
        }
    }

    Fallback Off
}
