---
title: "Configuring your Unity project for stronger performance"
page_title: "Configuring your Unity project for stronger performance"
source_url: "https://unity.com/how-to/project-configuration-and-assets"
final_url: "https://unity.com/how-to/project-configuration-and-assets"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Configuring your Unity project for stronger performance

This is the first in a series of articles that unpacks optimization tips for your Unity projects. Use them as a guide for running at higher frame rates with fewer resources. Once you’ve tried these best practices, be sure to check out the other pages in the series:

-   [Performance optimization for high-end graphics](https://unity.com/how-to/performance-optimization-high-end-graphics)
-   [Managing GPU usage for PC and console games](https://unity.com/how-to/gpu-optimization)
-   [Advanced programming and code architecture](https://unity.com/how-to/advanced-programming-and-code-architecture)
-   [Enhanced physics performance for smooth gameplay](https://unity.com/how-to/enhanced-physics-performance-smooth-gameplay)

See our latest optimization guides for Unity 6 developers and artists:

-   [*Optimize your game performance for mobile, XR, and the web in Unity*](https://unity.com/resources/mobile-xr-web-game-performance-optimization-unity-6)
-   [*Optimize your game performance for consoles and PCs in Unity*](https://unity.com/resources/console-pc-game-performance-optimization-unity-6)

Configure your project for stronger performance

Disable unnecessary Player/Quality settings

Switch to IL2CPP

Choose the right frame rate

Reduce or disable accelerometer frequency

Avoid large hierarchies

Compress your textures

Leverage Texture Import Settings

Atlas your textures

Check your polygon counts

Manage Mesh Import Settings

See more mesh optimizations

Audit your assets

Adjust the async texture buffer

Stream Mip Maps and textures

Use Addressables

## Configure your project for stronger performance

A well-optimized asset pipeline can speed up load times, reduce memory usage, and improve runtime performance. By working with an experienced technical artist, your team can define and enforce asset formats, specifications, and import settings to ensure an efficient and streamlined workflow.

Don’t rely solely on default settings. Take advantage of the platform-specific override tab to optimize assets like textures, mesh geometry, and audio files. Incorrect settings can result in larger build sizes, longer build times, and poor memory usage.

Consider using [**Presets**](https://docs.unity3d.com/6000.0/Documentation/Manual/Presets.html) to establish baseline settings tailored to your specific project needs. This proactive approach helps ensure that assets are optimized from the start, leading to better performance and a more consistent experience across all platforms.

For more guidance, refer to the [best practices for art assets](https://docs.unity3d.com/Manual/HOWTO-ArtAssetBestPracticeGuide.html?utm_source=demand-gen&utm_medium=pdf&utm_campaign=asset-links-gmg-elevate-your-game&utm_content=optimize-mobile-game-performance-ebook) or explore the [3D Art Optimization for Mobile Applications](https://learn.unity.com/course/3d-art-optimization-for-mobile-gaming-5474?utm_source=demand-gen&utm_medium=pdf&utm_campaign=clean-code&utm_content=mobile-performance-optimization-ebook) course on Unity Learn. These resources provide valuable insights that can help you make informed decisions about asset optimization for Unity web builds, mobile, and XR applications.

THREE TYPES OF ATLASES WHEN PACKING 2D SPRITES IN UNITY

## Disable unnecessary Player or Quality settings

In the **Player** settings, disable **Auto Graphics API** for unsupported platforms to prevent generating excessive shader variants. Disable **Target Architectures** for older CPUs if your application is not supporting them.

In the **Quality** settings, disable needless Quality levels.

Learn more about the [Graphics API](https://docs.unity3d.com/Manual/GraphicsAPIs.html).

IN THE QUALITY SETTINGS, DISABLE UNNECESSARY QUALITY LEVELS.

## Switch to IL2CPP

Switching the scripting backend from **Mono** to **IL2CPP** (Intermediate Language to C++) can provide overall better runtime performance. However, it can also increase build times. Some developers prefer to use Mono locally for faster iteration, then switch to IL2CPP for build machines and/or release candidates. Refer to the [Optimizing IL2CPP build times documentation](https://docs.unity3d.com/Manual/IL2CPP-OptimizingBuildTimes.html) for more on reducing your build times.

**Note**: By using this option, Unity converts ILcode from scripts and assemblies to C++ before creating a native binary file (.exe, .apk, .xap) for your target platform.

See the [Introduction to IL2CPP internals](https://blog.unity.com/technology/an-introduction-to-ilcpp-internals) or consult the [Compiler options manual page](https://docs.unity3d.com/Manual/IL2CPP-CompilerOptions.html) to learn how the various compiler options affect runtime performance.

## Choose the right frame rate

Mobile projects must balance frame rates against battery life and thermal throttling. Instead of pushing the limits of your device at 60 fps, consider running at 30 fps as a compromise. Unity defaults to 30 fps for mobile.

When targeting XR platforms, the frame rate considerations are even more critical. A frame rate of 72 fps, 90 fps, or even 120 fps, is often necessary to maintain immersion and prevent motion sickness. These higher frame rates help ensure a smooth and responsive experience, which is crucial for comfort in VR environments. However, these come with their own challenges in terms of power consumption and thermal management, particularly in standalone VR headsets.

Choosing the right frame rate is about understanding the specific demands and constraints of your target platform, whether it's a mobile device, a standalone VR headset, or an AR device. By carefully selecting an appropriate frame rate, you can optimize both performance and user experience across different platforms.

You can also adjust the frame rate dynamically during runtime with **Application.targetFrameRate**. For example, you could drop below 30 fps for slow or relatively static scenes and reserve higher fps settings for gameplay.

More information is available in the [documentation](https://docs.unity3d.com/ScriptReference/Application-targetFrameRate.html).

## Reduce or disable accelerometer frequency

Unity pools your mobile’s accelerometer several times per second. Disable this if it’s not being used in your application, or reduce its frequency for better overall performance.

Learn more about the [accelerometer](https://docs.unity3d.com/Manual/CrossPlatformConsiderations.html).

DISABLE ACCELEROMETER FREQUENCY IF YOU ARE NOT MAKING USE OF IT IN YOUR MOBILE GAME.

## Avoid large hierarchies

Split your hierarchies. If your GameObjects do not need to be nested in a hierarchy, simplify the parenting.

Smaller hierarchies benefit from multithreading to refresh the Transforms in your scene. Complex hierarchies incur unnecessary Transform computations and more cost to garbage collection.

See [Optimizing the Hierarchy](https://blogs.unity3d.com/2017/06/29/best-practices-from-the-spotlight-team-optimizing-the-hierarchy/) and [this Unite talk](https://youtu.be/W45-fsnPhJY?t=794) for tips on Transforms.

## Compress your textures

Consider these two examples above using the same model and texture. The settings on the left consume almost 26 times the memory as those on the right, without much improvement in visual quality.

Use Adaptive Scalable Texture Compression (ATSC) for mobile, XR and the web. The vast majority of games in development tend to target min-spec devices that support ATSC compression.

The only exceptions are:

-   iOS games targeting A7 devices or lower (e.g., iPhone 5, 5S, etc.) – use PVRTC
-   Android games targeting devices prior to 2016 – use ETC2 (Ericsson Texture Compression)

If compressed formats such as PVRTC and ETC aren’t sufficiently high-quality, and if ASTC is not fully supported on your target platform, try using 16-bit textures instead of 32-bit textures.

See the manual for more information on [recommended texture compression format by platform](https://docs.unity3d.com/6000.0/Documentation/Manual/class-TextureImporterOverride.html).

UNCOMPRESSED TEXTURES REQUIRE MORE MEMORY THAN COMPRESSED ONES.

## Leverage Texture Import Settings

Textures can potentially use excess resources, so optimizing your Import Settings is critical. In general, try to follow these guidelines:

-   **Lower the Max Size**: Use the minimum settings that produce visually acceptable results. This is non-destructive and can quickly reduce your texture memory.
-   **Use powers of two (POT)**: Unity requires POT texture dimensions for texture compression formats.
-   **Toggle off the Read/Write Enabled option**: When enabled, this option creates a copy in both CPU and GPU addressable memory, doubling the texture’s memory footprint. Disable it in most cases, and only enable it if you generate a texture at runtime that you need to overwrite. You can also enforce this option via **Texture2D.Apply**, passing in **makeNoLongerReadable** set to **True**.
-   **Disable unnecessary Mip Maps**: Mip Maps are not needed for textures that remain at a consistent size onscreen, such as **2D Sprites** and **UI Graphics**. However, leave Mip Maps enabled for 3D models that vary in distance from the Camera.

Learn more about [Texture Import Settings](https://docs.unity3d.com/Manual/class-TextureImporter.html).

## Atlas your textures

Atlasing is the process of grouping together several smaller textures into a single larger texture. **Texture Atlases** reduce memory usage and require fewer draw calls, thereby decreasing the effort required by the GPU.

-   **For 2D projects**: Use a [**Sprite Atlas**](https://docs.unity3d.com/Manual/class-SpriteAtlas.html?utm_source=demand-gen&utm_medium=pdf&utm_campaign=asset-links-gmg-choose-unity-for-multiplatform&utm_content=optimize-game-performance-2020-lts-ebook) (**Asset > Create > 2D > Sprite Atlas**) rather than rendering individual sprites or textures.
-   **For 3D projects**: You can use your **Digital Content Creation** (DCC) package of choice. Several third-party tools like [**MA_TextureAtlasser**](https://maxkruf.com/ma_textureatlas/) or [**TexturePacker**](https://www.codeandweb.com/texturepacker) can also be used to build Texture Atlases.

Combine textures and remap UVs for any 3D geometry that doesn’t require high-resolution maps. A visual editor gives you the ability to set and prioritize the sizes and positions in the Texture Atlas or **Sprite Sheet**.

The **Texture Packer** consolidates the individual maps into one large texture. Unity can then issue a single draw call to access the packed textures with a smaller performance overhead.

Read more about Sprite Atlases [here](https://docs.unity3d.com/Manual/class-SpriteAtlas.html).

USE TEXTURE ATLASES TO REDUCE THE NUMBER OF DRAW CALLS.

## Check your polygon counts

Higher-resolution models mean more memory usage and potentially longer GPU times. Does your background geometry need half a million polygons? Consider cutting down models in your DCC package of choice. Delete unseen polygons from the camera’s point of view, and use textures and normal maps for fine detail instead of high-density meshes.

REMOVE ANY UNSEEN FACES TO OPTIMIZE YOUR MODELS.

## Manage Mesh Import Settings

Just like textures, meshes can consume significant memory, so choose optimal import settings for them. Reduce the memory footprint of meshes with the following practices:

-   **Compress the mesh:** Aggressive compression can reduce disk space (memory at runtime, however, is unaffected). Note that mesh quantization can result in inaccuracies, so experiment with compression levels to see what works for your models.
-   **Disable Read/Write:** Enabling this option duplicates the mesh in memory, which keeps one copy of the mesh in system memory and another in GPU memory. In most cases, you should disable it (in Unity 2019.2 and earlier, this option is checked by default).
-   **Disable rigs and blend shapes:** If your mesh does not need skeletal or blendshape animation, disable these options wherever possible.

**Disable normals and tangents:** If you are absolutely certain that the mesh material will not need normals or tangents, uncheck these options for extra savings.

CHECK YOUR MESH IMPORT SETTINGS

## See more mesh optimizations

Additional mesh optimization options are available in the Player Settings:

-   **Vertex Compression** sets the vertex compression of each channel. For example, you can enable compression for everything except positions and lightmap UVs. This can reduce runtime memory usage from your meshes.
    -   **Note**: The Mesh Compression setting in each mesh’s Import Settings overrides the Vertex Compression setting. In that event, the runtime copy of the mesh is uncompressed and might use more memory.
-   **Optimize Mesh Data** removes any data from meshes that is not required by the material applied to them (such as tangents, normals, colors, and UVs).

## Audit your assets

By automating the audit process, you can avoid accidentally changing asset settings. The [**AssetPostProcessor**](https://docs.unity3d.com/ScriptReference/AssetPostprocessor.html) can help you standardize your Import Settings or analyze existing assets. It allows you to run scripts when importing assets, and essentially, prompts you to customize settings before and/or after importing models, textures, audio, and more.

Read more about [Asset auditing](https://docs.unity3d.com/Manual/BestPracticeUnderstandingPerformanceInUnity4.html?utm_source=demand-gen&utm_medium=pdf&utm_campaign=asset-links-gmg-choose-unity-for-multiplatform&utm_content=optimize-game-performance-2020-lts-ebook) in the [Understanding optimization guide](https://docs.unity3d.com/Manual/BestPracticeUnderstandingPerformanceInUnity.html?utm_source=demand-gen&utm_medium=pdf&utm_campaign=asset-links-gmg-choose-unity-for-multiplatform&utm_content=optimize-game-performance-2020-lts-ebook).

## Adjust the async texture buffer

Unity uses a ring buffer to push textures to the GPU. You can manually adjust this async texture buffer via **QualitySettings.asyncUploadBufferSize**.

If either the upload rate is too slow or the main thread stalls while loading several textures at once, adjust [these texture buffers](https://docs.unity3d.com/ScriptReference/QualitySettings-asyncUploadBufferSize.html). You can usually set the value (in MB) to the size of the largest texture you need to load in the scene.

Keep in mind that changing the default values can lead to high memory pressure. Also, you cannot return ring buffer memory to the system after Unity allocates it. If GPU memory overloads, the GPU unloads the most recent and least-used texture, and forces the CPU to reupload it the next time it enters the Camera frustum.

Explore all the memory restrictions for texture buffers in the [Memory management tutorial](https://unity3d.com/learn/tutorials/topics/best-practices/guide-optimizing-memory?playlist=30089), and refer to [Optimizing loading performance](https://blog.unity.com/technology/optimizing-loading-performance-understanding-the-async-upload-pipeline) to see how you can improve loading times.

## Stream Mip Maps and textures

The [**Mip Map Streaming**](https://docs.unity.cn/2021.1/Documentation/Manual/TextureStreaming.html) system gives you control over which Mip Map levels should load into memory. Enable it by going to Unity’s **Quality** settings (**Edit \> Project Settings \> Quality**) and check the **Texture Streaming** option. You can enable Streaming Mip Maps in the **Texture Import Settings** under **Advanced**.

This system reduces the total amount of memory needed for textures because it only loads the Mip Maps necessary for rendering the current Camera position. Otherwise, Unity loads all of the textures by default.

Texture Streaming trades a small amount of CPU resources to save a potentially large amount of GPU memory. It also automatically reduces Mip Map levels to stay within the user-defined **Memory Budget**.

You can use the [Mip Map Streaming API](https://docs.unity3d.com/Manual/TextureStreaming-API.html?utm_source=demand-gen&utm_medium=pdf&utm_campaign=asset-links-gmg-choose-unity-for-multiplatform&utm_content=optimize-game-performance-2020-lts-ebook) for further control.

TEXTURE STREAMING SETTINGS

## Use Addressables

The [Addressable Asset System](https://docs.unity3d.com/Packages/com.unity.addressables@latest?utm_source=demand-gen&utm_medium=pdf&utm_campaign=asset-links-gmg-elevate-your-game&utm_content=optimize-mobile-game-performance-ebook) provides a simplified way to manage your content. This unified system loads AssetBundles by “address” or alias, asynchronously from either a local path or a remote content delivery network (CDN).

If you split your non-code assets (models, textures, Prefabs, audio, and even entire scenes) into an [AssetBundle](https://docs.unity3d.com/6000.0/Documentation/Manual/AssetBundlesIntro.html?), you can separate them as downloadable content (DLC).

Then, use Addressables to create a smaller initial build for your mobile application. [Cloud Content Delivery](https://unity.com/products/cloud-content-delivery?utm_source=demand-gen&utm_medium=pdf&utm_campaign=clean-code&utm_content=mobile-performance-optimization-ebook) lets you host and deliver your game content to players as they progress through the game.

See the tutorial [Get started with Addressables](https://learn.unity.com/course/get-started-with-addressables) on Unity Learn for a quick overview of how the Addressable Asset System can work in your project.

And click [here](https://unity.com/how-to/simplify-your-content-management-addressables?) to see how the Addressable Asset System can take the hassle out of asset management.

LOAD ASSETS BY "ADDRESS" USING THE ADDRESSABLE ASSET SYSTEM

## More tips for Unity 6

Find more best practices and tips for advanced Unity developers and creators from [the Unity best practices hub](https://unity.com/how-to). Choose from over 30 guides, created by industry experts, and Unity engineers and technical artists, that will help you develop efficiently with Unity’s toolsets and systems.

<a href="https://unity.com/how-to" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[3.125rem] px-[2rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">More best practices<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>
