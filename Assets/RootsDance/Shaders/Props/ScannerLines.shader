// Structured-light scan lines: a travelling group of thin laser stripes that conforms to whatever
// geometry it lands on, plus a faint residue on the surface it already crossed.
//
// This is an *override material* for an HDRP DrawRenderersCustomPass, not a material you put on a
// prop. The scannable object keeps its own HDRP/Lit material; the custom pass re-draws that same
// geometry a second time with this shader on top, additively, at the Before Post Process injection
// point so the stripes feed bloom. Because the stripe pattern is evaluated from world position
// rather than UVs, it wraps across arbitrary meshes - a leaf, a trunk, a wall behind them - with no
// per-asset authoring, and it occludes correctly against the depth buffer (ZTest LEqual, ZWrite Off:
// the second draw lands at exactly the depth the first one wrote).
//
// Stripe geometry, all in metres of world space measured from the emitter:
//
//     emitter ->  | | | | | |  ......fading residue......
//                 ^-- band, _ScanHead at its leading edge
//
// The stripes are phase-locked to _ScanHead, so the whole group travels rigidly with the head the
// way a real projector's lines do; the residue behind it is a smooth fade with no stripes, which is
// what makes "already scanned" read differently from "being scanned right now".
//
// Everything is driven by Shader.SetGlobal* from ScannerScanEffect.cs - deliberately NOT material
// properties. UnlitProperties.hlsl (pulled in by CustomPassRenderers.hlsl) already opens the
// UnityPerMaterial cbuffer, so any property declared here would have to sit outside it and would
// break SRP Batcher compatibility for every object the pass draws. Globals live outside that cbuffer
// by design, and the tunables belong on a component anyway (guideline 01/12: no public material
// state). Same pattern as HDRP's own _FadeValue in CustomPassRenderers.hlsl.
Shader "RootsDance/Props/ScannerLines"
{
    Properties
    {
    }

    HLSLINCLUDE

    #pragma target 4.5
    #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch switch2

    #pragma multi_compile_instancing
    #pragma multi_compile _ DOTS_INSTANCING_ON

    // Vertex inputs: normal + tangent are what VARYINGS_NEED_TANGENT_TO_WORLD is built from, and the
    // world normal is what gives the stripes their silhouette boost.
    #define ATTRIBUTES_NEED_NORMAL
    #define ATTRIBUTES_NEED_TANGENT

    #define VARYINGS_NEED_POSITION_WS
    #define VARYINGS_NEED_TANGENT_TO_WORLD

    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/RenderPass/CustomPass/CustomPassRenderers.hlsl"

    #pragma vertex Vert
    #pragma fragment Frag

    // --- Scan state, pushed from C# every frame while a scan is running ---------------------------

    float4 _ScanOrigin;      // xyz: emitter position in absolute world space
    float4 _ScanAxis;        // xyz: sweep direction, normalised by C# (renormalised here for safety)
    float4 _ScanLineColor;   // rgb: HDR stripe colour
    float4 _ScanTrailColor;  // rgb: HDR residue colour

    float _ScanHead;         // metres from the emitter to the leading edge of the band
    float _ScanStrength;     // 0 = pass contributes nothing, 1 = full effect (fade in/out lives here)
    float _ScanBandWidth;    // metres of band behind the head that carries stripes
    float _ScanLineSpacing;  // metres between stripe centres
    float _ScanLineWidth;    // stripe thickness as a fraction of half the spacing, 0..1
    float _ScanTrailLength;  // metres of residue behind the band
    float _ScanIntensity;    // overall multiplier, in exposure-compensated units
    float _ScanEdgeBoost;    // extra brightness at grazing angles, 0 = off
    float _ScanRadial;       // 0 = parallel planes (projector), 1 = concentric shells (point emitter)
    float _ScanConeCos;      // cosine of the half-angle of the emission cone
    float _ScanConeSoftness; // width of the soft edge of that cone, in cosine units
    float _ScanMaxRange;     // metres at which the effect has fully faded out
    float _ScanDepthMatch;   // 1 = reject fragments the opaque pass never wrote (see below)

    ENDHLSL

    SubShader
    {
        Tags { "RenderPipeline" = "HDRenderPipeline" }

        Pass
        {
            Name "ForwardOnly"
            Tags { "LightMode" = "ForwardOnly" }

            // Additive on colour, and leave the destination alpha alone: HDRP keeps coverage there
            // for after-post-process compositing, and an emissive overlay has no business editing it.
            Blend One One, Zero One
            ZWrite Off
            ZTest LEqual
            Cull Back

            HLSLPROGRAM

            // Thin stripe from a repeating phase, antialiased against its own screen-space
            // derivative: at grazing angles fwidth grows, the stripes blur into a wash instead of
            // shimmering, which is exactly what a real projected line does at a glancing surface.
            float StripeMask(float phase, float width)
            {
                float s = abs(frac(phase - 0.5) - 0.5) * 2.0; // 0 at a stripe centre, 1 between them
                float aa = max(fwidth(phase) * 2.0, 1e-5);
                return 1.0 - smoothstep(width, width + aa, s);
            }

            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 viewDirection, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
            {
                ZERO_BUILTIN_INITIALIZE(builtinData); // unlit: no lighting data to initialise
                ZERO_INITIALIZE(SurfaceData, surfaceData);
                builtinData.opacity = 1.0;
                builtinData.emissiveColor = 0.0;
                surfaceData.normalWS = 0.0;

                float3 positionWS = GetAbsolutePositionWS(fragInputs.positionRWS);
                float3 toPoint = positionWS - _ScanOrigin.xyz;
                float3 axis = SafeNormalize(_ScanAxis.xyz);

                float distanceToPoint = length(toPoint);
                float3 toPointDir = toPoint / max(distanceToPoint, 1e-5);

                // Distance along the scan. Planar reads as a projector throwing parallel lines,
                // radial as a point emitter throwing shells; _ScanRadial blends the two.
                float planar = dot(toPoint, axis);
                float depthAlongScan = lerp(planar, distanceToPoint, saturate(_ScanRadial));

                // How far this pixel sits behind the leading edge. Negative = not reached yet.
                float behind = _ScanHead - depthAlongScan;

                float spacing = max(_ScanLineSpacing, 1e-4);
                float band = max(_ScanBandWidth, 1e-4);

                // Stripes are phase-locked to the head, so the group travels rigidly with it and the
                // phase stays small and precise no matter how far the scan has run.
                float stripes = StripeMask(behind / spacing, saturate(_ScanLineWidth));

                // Band: full at the head, gone one band-width behind it, nothing ahead of it.
                float bandMask = saturate(1.0 - behind / band) * step(0.0, behind);

                // Residue: picks up where the band ends and fades over _ScanTrailLength.
                float trailStart = behind - band;
                float trailMask = saturate(1.0 - trailStart / max(_ScanTrailLength, 1e-4)) * step(0.0, trailStart);

                // Grazing-angle boost so silhouettes read against a dark scene.
                float3 normalWS = normalize(fragInputs.tangentToWorld[2].xyz);
                float fresnel = pow(1.0 - saturate(dot(normalWS, viewDirection)), 4.0);
                float edge = 1.0 + _ScanEdgeBoost * fresnel;

                // Emission cone and range: keeps the beam in front of the emitter instead of
                // wrapping the far side of the object.
                float cone = smoothstep(_ScanConeCos - max(_ScanConeSoftness, 1e-4), _ScanConeCos, dot(toPointDir, axis));
                float range = 1.0 - smoothstep(_ScanMaxRange * 0.75, _ScanMaxRange, distanceToPoint);

                // Alpha-cutout guard. The override material replaces the object's own shader, so
                // the holes an alpha-clipped leaf card punched during the opaque pass come back as
                // solid geometry here and would be striped like a solid surface. Compare this
                // fragment's depth against what the opaque pass actually left in the depth buffer:
                // over a hole the buffer holds whatever was behind the card, not the card itself,
                // so the stripe is rejected. Material-agnostic, which is the point - the pass never
                // has to know which base map or cutoff the scanned object was authored with.
                float sceneEye = LinearEyeDepth(CustomPassLoadCameraDepth(posInput.positionSS), _ZBufferParams);
                float tolerance = max(0.002, posInput.linearDepth * 0.002);
                float depthMatch = step(abs(sceneEye - posInput.linearDepth), tolerance);
                depthMatch = lerp(1.0, depthMatch, saturate(_ScanDepthMatch));

                float3 color = _ScanLineColor.rgb * (stripes * bandMask * edge)
                             + _ScanTrailColor.rgb * trailMask;

                surfaceData.color = color * (_ScanIntensity * _ScanStrength * cone * range * depthMatch);
            }

            #include_with_pragmas "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPassForwardUnlit.hlsl"

            ENDHLSL
        }
    }

    Fallback Off
}
