// Surface function for RootsDance/Environment/StatueBloom.
//
// It lives in its own file, rather than in the shader's SubShader-level HLSLINCLUDE, because it
// names SurfaceData -- a type that only exists after a pass has included Unlit.hlsl. Hoisting it
// above the passes compiles in whichever pass happens to include the most and fails in the other,
// which is exactly the shape of the error BioluminescentAlgae currently reports on
// DepthForwardOnly. Every pass includes this file after Unlit.hlsl and before its ShaderPass*.
//
// The three vertex-colour channels are written by Tools/pipeline/build_bloom_patch.py:
//   R  rim falloff, 1 well inside a clump and 0 at its authored or torn edge
//   G  a constant per clump, so neighbouring clumps do not open in lockstep
//   B  the statue's own bloom time at this vertex, 0 at the first stone to flower and 1 at the
//      last -- global, not per-clump, which is what lets one _Growth scalar drive all of it
//
// Those channels are DATA. The FBX is written with colors_type LINEAR and the importer must not
// be allowed to treat them as colour, or the rim bends and the growth front moves. Measured
// intact end to end on 2026-08-30; see the plan's §3.2.

float3 BloomKeyLight(out float3 lightDirWS)
{
    float3 dir = _RootsSunDirection.xyz;
    float3 col = _RootsSunColor.rgb;

    // Nothing has broadcast a sun: a prefab preview, a scene with no SunBroadcaster, or the
    // first frame before it runs. A fixed key light keeps the material readable instead of
    // rendering the clumps black and sending someone hunting for a shader bug.
    if (dot(col, float3(1.0, 1.0, 1.0)) < 1e-4)
    {
        dir = normalize(float3(0.4, -0.82, 0.41));
        col = float3(1.0, 0.96, 0.88);
    }

    lightDirWS = -normalize(dir);       // surface -> light
    return col;
}

void GetSurfaceAndBuiltinData(FragInputs input, float3 V, inout PositionInputs posInput,
    out SurfaceData surfaceData, out BuiltinData builtinData)
{
    ZERO_BUILTIN_INITIALIZE(builtinData);
    ZERO_INITIALIZE(SurfaceData, surfaceData);
    builtinData.opacity = 1.0;
    builtinData.emissiveColor = 0.0;
    surfaceData.normalWS = 0.0;

    float rim = saturate(input.color.r);
    float phase = input.color.g;
    float order = saturate(input.color.b);

    // The advancing front. Softness is its width, so the bloom dissolves outwards instead of
    // switching on; the (1 + soft) factor guarantees _Growth == 1 shows everything.
    float soft = max(_GrowthSoftness, 1e-3);
    float grown = saturate((_Growth * (1.0 + soft) - order) / soft);

    float2 uv = input.texCoord0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
    float4 base = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, uv);

    // Coverage is rim times growth, so a clump opens from its middle outwards rather than fading
    // in whole -- the geometry never moves, and this is what makes it read as growth. Erosion
    // raises the threshold at the edge only, keeping the ragged outline without eating holes
    // through the centre.
    float threshold = _AlphaCutoff + _EdgeErode * (1.0 - rim);
    clip(rim * grown * base.a - threshold);

    float3 normalTS = UnpackNormalmapRGorAG(
        SAMPLE_TEXTURE2D(_NormalMap, sampler_NormalMap, uv), _NormalStrength);
    float3 N = normalize(TransformTangentToWorld(normalTS, input.tangentToWorld));

    float3 L;
    float3 sun = BloomKeyLight(L);

    // Wrapped diffuse: a petal is thin enough to keep carrying light past its own terminator, and
    // a hard N.L makes the clumps read as painted-on plastic.
    float w = saturate(_Wrap);
    float diffuse = saturate((dot(N, L) + w) / (1.0 + w));

    float3 H = normalize(L + V);
    float spec = pow(saturate(dot(N, H)), max(_Gloss, 1.0)) * _Specular;

    // Freshly opened growth is paler and yellower than settled growth. Driven by the same front
    // that reveals it, so the colour change and the reveal cannot drift apart.
    float young = saturate((grown - 0.55) / 0.45);
    float3 tint = lerp(_YoungTint.rgb, _BaseTint.rgb, young);

    // Per-clump variation, keyed off the same phase that staggers the opening. Small: this is one
    // species growing over one statue, not a flowerbed.
    tint *= 1.0 + _ClumpVariation * (phase - 0.5);

    float3 lit = base.rgb * tint * (_RootsSkyColor.rgb * _AmbientFloor + sun * diffuse)
               + sun * spec;

    surfaceData.color = lit;
}
