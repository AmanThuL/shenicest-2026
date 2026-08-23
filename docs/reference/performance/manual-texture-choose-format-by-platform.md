---
title: "Choose a GPU texture format by platform"
page_title: "Unity - Manual: Choose a GPU texture format by platform"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/texture-choose-format-by-platform.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/texture-choose-format-by-platform.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Choose a GPU texture format by platform

<span id="desktop"></span>

## Desktop

For devices with DirectX 11 or better class GPUs, where support for BC7 and BC6H formats is guaranteed to be available, the recommended choice of compression formats is: RGB textures - DXT1 at four bits/pixel. RGBA textures - BC7 (higher quality, slower to compress) or DXT5 (faster to compress), both at eight bits/pixel. HDR textures - BC6H at eight bits/pixel. If you need to support DirectX 10 class GPUs on PC (NVIDIA GPUs before 2010, AMD before 2009, Intel before 2012), then DXT5 instead of BC7 would be preferred, since these GPUs do not support BC7 nor BC6H.

See the [Supported texture formats reference table](https://docs.unity3d.com/6000.3/Documentation/Manual/texture-formats-reference.html) for detailed information about all supported formats.

<span id="ios-and-tvos"></span>

## iOS and tvOS

For Apple devices that use the A8 chip (2014) or above, ASTC is the recommended texture format for RGB and RGBA textures. This format allows you to choose between texture quality and size on a granular level: all the way from eight bits/pixel (4x4 block size) down to 0.89 bits/pixel (12x12 block size). If support for older devices is needed, or you want additional Crunch compression, then Apple devices support ETC/ETC2 formats starting with A7 chip (2013). On iOS you can configure the default texture format in the [Player Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/iphone.html). ASTC is preferred, but is not supported on A7 devices (the very first Metal-enabled devices) and will be unpacked at runtime.

For detailed information on all supported formats, refer to the [Supported texture formats reference table](https://docs.unity3d.com/6000.3/Documentation/Manual/texture-formats-reference.html).

<span id="android"></span>

## Android

Texture format support on Android is complicated. You might need to build several application versions with different [sub-targets](https://docs.unity3d.com/6000.3/Documentation/Manual/android-BuildProcess.html).

You can select the default format in [Player Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettingsAndroid.html#Rendering). Your options are ASTC, ETC2 and ETC (ETC1 for RGB, ETC2 for RGBA). See [Texture compression settings](https://docs.unity3d.com/6000.3/Documentation/Manual/android-requirements-and-compatibility.html#texture-compression) for more details on how the different settings interact.

For LDR RGB and RGBA textures, most modern Android GPUs that support OpenGL ES 3.1 or Vulkan also support ASTC format, including: Qualcomm GPUs since Adreno 4xx / Snapdragon 415 (2015), ARM GPUs since Mali T624 (2012), NVIDIA GPUs since Tegra K1 (2014), PowerVR GPUs since GX6250 (2014).

If you need support for older devices, or you want additional Crunch compression, then all GPUs that run Vulkan or OpenGL ES 3.0 support the ETC2 format. The resulting image quality is quite high, and it supports one- to four-component texture data. For even older devices, usually only ETC format is available. The drawback is that there is no direct alpha channel support. For Sprites, Unity offers an option to use ETC1 compression by splitting a texture into two ETC1 textures: one for RGB, one for alpha. To enable this, enable the Android-specific [Split Alpha Channel](https://docs.unity3d.com/6000.3/Documentation/Manual/class-TextureImporter.html#splitalpha) option for the Texture when importing a [Sprite Atlas](https://docs.unity3d.com/6000.3/Documentation/Manual/sprite/atlas/atlas-landing.html). The sprite shader samples both textures and combines them into the final result.

For older Android devices that don’t support the ASTC format, the texture is decompressed into an uncompressed RGBA 32-bit format. This increases memory usage and can slow down the decompression performed on the CPU.

For HDR textures, ASTC HDR is the only compressed format available on Android devices. ASTC HDR requires Vulkan or [GL_KHR_texture_compression_astc_hdr](https://opengles.gpuinfo.org/listreports.php?extension=GL_KHR_texture_compression_astc_hdr) support. ASTC is the most flexible format. If a device doesn’t support ASTC HDR the texture is decompressed at runtime to RGB9e5 or RGBA Half, depending on alpha channel usage.

For devices that don’t support ASTC HDR, all devices running Vulkan, Metal, or OpenGL ES 3.0 support RGB9e5, which is suitable for textures without an alpha channel. If an alpha channel or even wider support is needed, use RGBA Half. This takes twice as much memory as RGB9e5.

If you want to distribute your application to Google Play, it’s best practice to use [texture compression targeting](https://docs.unity3d.com/6000.3/Documentation/Manual/android-distribution-google-play.html#texture-compression-targeting).

See the [Supported texture formats reference table](https://docs.unity3d.com/6000.3/Documentation/Manual/texture-formats-reference.html) for detailed information about all supported formats.

### Android texture AssetBundle compatibility

To use [AssetBundle variants](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetBundles-Preparing.html#assetbundle-variants), all textures that can’t be cleanly compressed using ETC1 must be isolated into texture-only AssetBundles. Next, create sufficient variants of these AssetBundles to support the non-ETC2-capable slices of the Android ecosystem, using vendor-specific texture compression formats such as DXT5. For each AssetBundle variant, change the included textures’ TextureImporter settings to the compression format appropriate to the variant.

At runtime, support for the different texture compression formats can be detected using the [`SystemInfo.SupportsTextureFormat`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SystemInfo.SupportsTextureFormat.html) API. This information should be used to select and load the AssetBundle variant containing textures compressed in a supported format.

For more information on texture compression formats, refer to the Android documentation on [Texture compression support](http://developer.android.com/guide/topics/graphics/opengl.html#textures).

## Additional resources

-   [Texture compression in Web](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-texture-compression.html)
