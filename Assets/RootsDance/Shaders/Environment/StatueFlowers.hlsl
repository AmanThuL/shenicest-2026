// Vertex and surface functions for RootsDance/Environment/StatueFlowers.
//
// Two jobs, and the first one is the reason this shader exists: open every flower on the statue,
// as geometry, from the same _Growth scalar the cover already reads.
//
// The opening is baked, not simulated. Tools/pipeline/build_bloom_flowers.py builds each flower
// three times from identical topology -- shut bud, half open, open -- ships the open pose as the
// mesh and the other two as deltas in UV1..UV3, and this walks a quadratic Bezier through them:
//
//     P(t) = (1-t)^2 * bud + 2t(1-t) * mid + t^2 * open
//          = open + (1-t)^2 * dBud + 2t(1-t) * dMid
//
// The mid pose is the control point, and it is what makes a petal swing through an arc instead of
// sliding along the chord between shut and open -- a two-pose lerp shortens the petal through the
// middle of the swing and reads as the flower being sucked in and pushed back out.
//
// Channels, all written by that generator:
//   COLOR.r  part mask: 0 stem and leaf, 0.5 centre, 1 petal
//   COLOR.g  per-flower phase, for tint spread and sway
//   COLOR.b  growth order, 0 at the first flower to open and 1 at the last -- the same global
//            front StatueBloom.hlsl reads, so a flower cannot open before the cover it stands in
//   UV0      petal-local: x runs root to tip, y across the petal
//   UV1      dBud.xy      | the two closed poses, as offsets from the open one, already in the
//   UV2      dBud.z dMid.x| mesh's own space -- a UV is a number, so nothing transformed them on
//   UV3      dMid.yz      | the way out and nothing has to transform them back
//
// Those channels are DATA. The FBX is written with colors_type LINEAR and the importer must be
// left on DATA, not sRGB, or the growth order bends and the flowers open in the wrong order.

float OpenAmount(float order)
{
    // The (1 + span) factor is what makes _Growth 1 finish every flower: without it a flower whose
    // order is 0.95 only ever reaches (1 - 0.95) / span open. StatueBloom.hlsl and BloomBurst.cs
    // both run this same arithmetic, deliberately -- it is what keeps the three in step.
    float span = max(_OpenSpan, 1e-3);
    return saturate((_Growth * (1.0 + span) - order) / span);
}

AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters)
{
    float t = OpenAmount(input.color.b);
    t = t * t * (3.0 - 2.0 * t);        // ease both ends; a linear t starts and stops with a jerk

    float3 dBud = float3(input.uv1.x, input.uv1.y, input.uv2.x);
    float3 dMid = float3(input.uv2.y, input.uv3.x, input.uv3.y);

    float inv = 1.0 - t;
    input.positionOS += dBud * (inv * inv) + dMid * (2.0 * t * inv);

    // Sway. Amplitude comes from how far this vertex travels between shut and open, which is zero
    // at the root and largest at a petal tip -- so the flower bends instead of sliding, and no
    // per-vertex height channel has to be spent to say so.
    float reach = length(dBud);
    float phase = input.color.g * 6.2831853;
    float time = timeParameters.x * _SwaySpeed + phase;
    float3 wobble = float3(sin(time), sin(time * 0.7 + 1.3) * 0.35, cos(time * 0.83));
    input.positionOS += wobble * (reach * _Sway * t);

    return input;
}

float3 FlowerKeyLight(out float3 lightDirWS, out float3 ambient)
{
    float3 dir = _RootsSunDirection.xyz;
    float3 col = _RootsSunColor.rgb;
    ambient = _RootsSkyColor.rgb;

    // Nothing has broadcast a sun: a prefab preview, or the first frame before SunBroadcaster
    // runs. Same fallback as StatueBloom.hlsl, so the cover and the flowers on it never disagree
    // about where the light is.
    if (dot(col, float3(1.0, 1.0, 1.0)) < 1e-4)
    {
        dir = normalize(float3(0.4, -0.82, 0.41));
        col = float3(1.0, 0.96, 0.88);
        ambient = float3(0.32, 0.38, 0.45);
    }

    lightDirWS = -normalize(dir);
    return col;
}

void GetSurfaceAndBuiltinData(FragInputs input, float3 V, inout PositionInputs posInput,
    out SurfaceData surfaceData, out BuiltinData builtinData)
{
    ZERO_BUILTIN_INITIALIZE(builtinData);
    ZERO_INITIALIZE(SurfaceData, surfaceData);
    builtinData.opacity = 1.0;
    surfaceData.normalWS = 0.0;

    float part = saturate(input.color.r);
    float phase = input.color.g;
    float open = OpenAmount(input.color.b);

    // Part mask to colour. Two lerps rather than a texture: the whole field is one material and
    // three flat colours, and a 512² atlas for a 30-triangle flower is not worth the import.
    float3 tint = part < 0.5
        ? lerp(_FoliageTint.rgb, _CentreTint.rgb, saturate(part * 2.0))
        : lerp(_CentreTint.rgb, _PetalTint.rgb, saturate((part - 0.5) * 2.0));

    // A petal is darker where it is rooted and where it has only just opened.
    float alongPetal = saturate(input.texCoord0.x);
    float isPetal = saturate((part - 0.5) * 2.0);
    tint *= lerp(1.0, lerp(_PetalRootShade, 1.0, alongPetal), isPetal);
    tint = lerp(_YoungTint.rgb * tint, tint, saturate((open - 0.5) / 0.5));

    // Per-flower spread, keyed off the same phase that staggers the sway.
    tint *= 1.0 + _FlowerVariation * (phase - 0.5);

    // The petals are single-sided sheets and half the field is seen from underneath by a player
    // standing at the statue's feet. Facing the normal at the viewer is what keeps those flowers
    // lit instead of black; the geometry is thin enough that there is no back to shade.
    float3 N = normalize(input.tangentToWorld[2]);
    N = input.isFrontFace ? N : -N;

    float3 L;
    float3 ambient;
    float3 sun = FlowerKeyLight(L, ambient);

    // Wrapped diffuse: a petal is thin enough to keep carrying light past its own terminator.
    float w = saturate(_Wrap);
    float diffuse = saturate((dot(N, L) + w) / (1.0 + w));

    float3 H = normalize(L + V);
    float spec = pow(saturate(dot(N, H)), max(_Gloss, 1.0)) * _Specular * isPetal;

    surfaceData.color = tint * (ambient * _AmbientFloor + sun * diffuse) + sun * spec;
    builtinData.emissiveColor = tint * (_Emission * isPetal * open);
}
