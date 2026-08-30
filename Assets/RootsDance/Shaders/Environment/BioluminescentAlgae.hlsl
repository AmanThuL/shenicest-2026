// Surface function for RootsDance/Environment/BioluminescentAlgae.
//
// It lives in its own file, rather than in the shader's SubShader-level HLSLINCLUDE, because it
// names SurfaceData -- a type that only exists after a pass has included Unlit.hlsl. Hoisted above
// the passes it compiles in whichever pass happens to include the most and fails in the other,
// which is where the "unrecognized identifier 'SurfaceData'" on DepthForwardOnly came from. Every
// pass includes this file after Unlit.hlsl and before its ShaderPass*, the same way
// Environment/StatueBloom includes StatueBloom.hlsl. Environment/FluorescentReveal states the
// function inline instead; it has one pass, so it has nowhere for the two to disagree.
//
// The three vertex-colour channels are written by the patch generator:
//   R  rim falloff, 1 well inside the patch and 0 at the authored outline
//   G  a constant per patch, so neighbouring patches pulse out of phase instead of breathing as one
//   B  growth order, the normalised distance from that patch's seed point outwards
// Those channels are DATA: the FBX is exported with LINEAR colours and the model importer must not
// be left on sRGB, or the rim falloff bends and the outline moves.

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

    float3 normalTS = UnpackNormalMapRGorAG(
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
