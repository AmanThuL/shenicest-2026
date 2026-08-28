Shader "Hidden/RootsDance/PsxPostProcess"
{
    Properties
    {
        // Required so HDRP binds the source colour buffer to _MainTex.
        _MainTex("Main Texture", 2DArray) = "grey" {}
    }

    HLSLINCLUDE

    #pragma target 4.5
    #pragma only_renderers d3d11 playstation xboxone xboxseries vulkan metal switch switch2

    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
    #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
    #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"

    struct Attributes
    {
        uint vertexID : SV_VertexID;
        UNITY_VERTEX_INPUT_INSTANCE_ID
    };

    struct Varyings
    {
        float4 positionCS : SV_POSITION;
        float2 texcoord   : TEXCOORD0;
        UNITY_VERTEX_OUTPUT_STEREO
    };

    Varyings Vert(Attributes input)
    {
        Varyings output;
        UNITY_SETUP_INSTANCE_ID(input);
        UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);
        output.positionCS = GetFullScreenTriangleVertexPosition(input.vertexID);
        output.texcoord = GetFullScreenTriangleTexCoord(input.vertexID);
        return output;
    }

    float _Intensity;
    float _PixelScale;
    float _ColorLevels;
    float _DitherStrength;
    float _InterlaceStrength;
    float _InterlaceSize;
    float _GrainIntensity;
    float _GrainSize;
    float _GrainSeed;
    float _GrainShadowBias;
    TEXTURE2D_X(_MainTex);

    // Grain amplitude at _GrainIntensity = 1, as a fraction of the sRGB range.
    static const float k_GrainRange = 0.25;

    // 4x4 Bayer matrix, row-major, values 0..15.
    static const float k_Bayer4[16] =
    {
         0.0,  8.0,  2.0, 10.0,
        12.0,  4.0, 14.0,  6.0,
         3.0, 11.0,  1.0,  9.0,
        15.0,  7.0, 13.0,  5.0
    };

    // lowbias32 integer hash (Chris Wellons); good enough decorrelation for screen-space speckle.
    uint HashUint(uint x)
    {
        x ^= x >> 16;
        x *= 0x7feb352du;
        x ^= x >> 15;
        x *= 0x846ca68bu;
        x ^= x >> 16;
        return x;
    }

    // Signed white noise in [-1, 1] for one grain cell and one seed.
    float GrainNoise(uint2 cell, uint seed)
    {
        uint h = HashUint(cell.x + HashUint(cell.y + HashUint(seed)));
        return (float)(h & 0xffffu) / 65535.0 * 2.0 - 1.0;
    }

    float4 CustomPostProcess(Varyings input) : SV_Target
    {
        UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);

        float2 uv = input.texcoord.xy;

        // Untouched source for the intensity blend (bilinear, RTHandle-safe).
        float3 sourceColor = SAMPLE_TEXTURE2D_X(_MainTex, s_linear_clamp_sampler,
            ClampAndScaleUVForBilinearPostProcessTexture(uv)).xyz;

        // 1. Pixelate: _PixelScale is authored for 1080p, then scaled with output height. This keeps the
        // virtual resolution and the perceived dither/interlace granularity stable from 1080p through 4K.
        float2 screenSize = _PostProcessScreenSize.xy;
        float outputScale = max(screenSize.y / 1080.0, 1.0 / max(_PixelScale, 1.0));
        float effectivePixelScale = max(_PixelScale * outputScale, 1.0);
        float2 virtualSize = max(floor(screenSize / effectivePixelScale), 1.0);
        float2 cell = floor(uv * virtualSize);
        float2 snappedUv = (cell + 0.5) / virtualSize;
        float3 psxColor = SAMPLE_TEXTURE2D_X(_MainTex, s_point_clamp_sampler,
            ClampAndScaleUVPostProcessTextureForPoint(snappedUv)).xyz;

        // 2. Quantise in sRGB so the steps are perceptually even, with a Bayer offset in [-0.5, 0.5] steps.
        uint2 bayerCell = uint2(cell) & 3;
        float bayer = (k_Bayer4[bayerCell.y * 4 + bayerCell.x] + 0.5) / 16.0 - 0.5;
        float levels = max(_ColorLevels, 2.0);
        float3 srgb = LinearToSRGB(saturate(psxColor));
        float3 quantised = floor(srgb * levels + 0.5 + bayer * _DitherStrength) / levels;
        psxColor = SRGBToLinear(saturate(quantised));

        float3 color = lerp(sourceColor, psxColor, _Intensity);

        // 3. Interlacing: dim alternate horizontal bands on the same virtual grid as the pixelation. Keeping
        // the pattern grid-aligned prevents sub-pixel shimmer when the Game view resolution changes.
        if (_InterlaceStrength > 0.0)
        {
            float band = floor(cell.y / max(_InterlaceSize, 1.0));
            float alternate = fmod(band, 2.0);
            color *= 1.0 - alternate * _InterlaceStrength * _Intensity;
        }

        // 4. Grain, after quantisation so the colour steps cannot swallow it; cells follow the virtual grid.
        if (_GrainIntensity > 0.0)
        {
            uint2 grainCell = uint2(floor(cell / max(_GrainSize, 1.0)));
            float noise = GrainNoise(grainCell, (uint)max(_GrainSeed, 0.0));
            float3 grainSrgb = LinearToSRGB(saturate(color));
            float luma = dot(grainSrgb, float3(0.299, 0.587, 0.114));
            float response = lerp(1.0, 1.0 - luma, _GrainShadowBias);
            grainSrgb += noise * _GrainIntensity * k_GrainRange * response;
            color = SRGBToLinear(saturate(grainSrgb));
        }

        return float4(color, 1.0);
    }

    ENDHLSL

    SubShader
    {
        Tags { "RenderPipeline" = "HDRenderPipeline" }
        Pass
        {
            Name "RootsDance PSX"

            ZWrite Off
            ZTest Always
            Blend Off
            Cull Off

            HLSLPROGRAM
                #pragma fragment CustomPostProcess
                #pragma vertex Vert
            ENDHLSL
        }
    }
    Fallback Off
}
