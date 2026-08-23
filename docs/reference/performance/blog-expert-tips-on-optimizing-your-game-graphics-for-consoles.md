---
title: "Expert tips on optimizing your game graphics for consoles"
page_title: "Expert tips on optimizing your game graphics for consoles"
source_url: "https://unity.com/blog/games/expert-tips-on-optimizing-your-game-graphics-for-consoles"
final_url: "https://unity.com/blog/games/expert-tips-on-optimizing-your-game-graphics-for-consoles"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Expert tips on optimizing your game graphics for consoles

<a href="https://unity.com/blog" class="text-xxs mt-8 flex items-center font-bold uppercase hover:underline"><span class="ml-1">Unity Blog</span></a>

# Expert tips on optimizing your game graphics for consoles

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">THOMAS KROGH-JACOBSEN / UNITY TECHNOLOGIES</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Senior Technical Content Marketing Manager</span>

<span class="mr-2">Nov 3, 2021</span><span class="mr-2">\|</span><span class="mr-2">12 Min</span>

Game design

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

If you’re a regular reader of the Unity blog then you probably noticed the recent series of posts that shared many great tips for optimizing mobile games, including [graphics and assets](https://blog.unity.com/technology/optimize-your-mobile-game-performance-expert-tips-on-graphics-and-assets),[ profiling, memory, and code architecture](https://blog.unity.com/technology/optimize-your-mobile-game-performance-tips-on-profiling-memory-and-code-architecture), and [physics, UI, and audio](https://blog.unity.com/technology/optimize-your-mobile-game-performance-get-expert-tips-on-physics-ui-and-audio-settings).

And today we’re back with more handy tips, this time for optimizing high-end graphics on consoles. Get pointers on how to reduce batch count, what shaders to avoid, rendering options, and more. These tips come from a new e-book of advanced optimization techniques for PC and console games, available for you to [download for free](https://resources.unity.com/games/performance-optimization-e-book-console-pc).

Optimizing graphics for consoles

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Though developing for Xbox and PlayStation does resemble working with their PC counterparts, those platforms do present their own challenges. Achieving smooth frame rates often means focusing on GPU optimization.

Identify your performance bottlenecks

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

To begin, locate a frame with a high GPU load. Microsoft and Sony provide excellent tools for analyzing your project’s performance on both the CPU and on the GPU. Make PIX for Xbox and Razor for PlayStationpart of your toolbox when it comes to optimization on these platforms.

Use your respective native profiler to break down the frame cost into its specific parts. This will be your starting point to improve graphics performance.

Reduce the batch count

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

As with other platforms, optimization on console will often mean reducing draw call batches. There are a few techniques that might help.

-   Use [Occlusion Culling](https://docs.unity3d.com/Manual/OcclusionCulling.html?utm_source=demand-gen&utm_medium=pdf&utm_campaign=asset-links-gmg-choose-unity-for-multiplatform&utm_content=optimize-game-performance-2020-lts-ebook) to remove objects hidden behind foreground objects and reduce overdraw. Be aware this requires additional CPU processing, so use the Profiler to ensure moving work from the GPU to CPU is beneficial.
-   [GPU instancing](https://docs.unity3d.com/Manual/GPUInstancing.html?utm_source=demand-gen&utm_medium=pdf&utm_campaign=asset-links-gmg-choose-unity-for-multiplatform&utm_content=optimize-game-performance-2020-lts-ebook) can also reduce your batches if you have many objects that share the same mesh and material. Limiting the number of models in your scene can improve performance. If it’s done artfully, you can build a complex scene without making it look repetitive.

The [SRP Batcher](https://blog.unity.com/technology/srp-batcher-speed-up-your-rendering?utm_source=demand-gen&utm_medium=pdf&utm_campaign=asset-links-gmg-choose-unity-for-multiplatform&utm_content=optimize-game-performance-2020-lts-ebook) can reduce the GPU setup between DrawCalls by batching [Bind and Draw GPU commands](https://docs.unity3d.com/Manual/SRPBatcher.html?utm_source=demand-gen&utm_medium=pdf&utm_campaign=asset-links-gmg-choose-unity-for-multiplatform&utm_content=optimize-game-performance-2020-lts-ebook). To benefit from this SRP batching, use as many Materials as needed, but restrict them to a small number of compatible shaders (e.g., Lit and Unlit Shaders in URP and HDRP).

Activate Graphics Jobs

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Enable this option in **Player Settings \> Other Settings** to take advantage of the PlayStation’s or Xbox’s multi-core processors. **Graphics Jobs (Experimental)** allows Unity to spread the rendering work across multiple CPU cores, removing pressure from the render thread. See [Multithreaded Rendering and Graphics Jobs tutorial](https://learn.unity.com/tutorial/optimizing-graphics-in-unity?utm_source=demand-gen&utm_medium=pdf&utm_campaign=asset-links-gmg-choose-unity-for-multiplatform&utm_content=optimize-game-performance-2020-lts-ebook) for details.

Profile the post-processing

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Be sure to use post-processing assets that are optimized for consoles. Tools from the Asset Store that were originally authored for PC may consume more resources than necessary on Xbox or PlayStation. Profile using native profilers to be certain.

Avoid tessellation shaders

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Tessellation subdivides shapes into smaller versions of that shape. This can enhance detail through increased geometry. Though there *are* examples where tessellation does make sense (e.g.,[*Book of the Dead*](https://assetstore.unity.com/packages/essentials/tutorial-projects/book-of-the-dead-environment-121175?utm_source=demand-gen&utm_medium=pdf&utm_campaign=asset-links-gmg-choose-unity-for-multiplatform&utm_content=optimize-game-performance-2020-lts-ebook)’s realistic tree bark), in general, avoid tessellation on consoles. They can be expensive on the GPU.

Replace geometry shaders with compute shaders

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Like tessellation shaders, geometry and vertex shaders can run twice per frame on the GPU – once during the depth pre-pass, and again during the shadow pass.

If you want to generate or modify vertex data on the GPU, a [compute shader](https://docs.unity3d.com/Manual/class-ComputeShader.html?utm_source=demand-gen&utm_medium=pdf&utm_campaign=asset-links-gmg-choose-unity-for-multiplatform&utm_content=optimize-game-performance-2020-lts-ebook) is often a better choice than a geometry shader. Doing the work in a compute shader means that the vertex shader that actually renders the geometry can be comparatively fast and simple.

Aim for good wavefront occupancy

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

When you send a draw call to the GPU, that work splits into many wavefronts that Unity distributes throughout the available SIMDs within the GPU.

Each SIMD has a maximum number of wavefronts that can be running at one time. *Wavefront occupancy* refers to how many wavefronts are currently in use relative to the maximum. This measures how well you are using the GPU’s potential. PIX and Razor show wavefront occupancy in great detail.

Good versus bad wavefront occupancy

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

In this example from *Book of the Dead*, vertex shader wavefronts appear in green. Pixel shader wavefronts appear in blue. On the bottom graph, many vertex shader wavefronts appear without much pixel shader activity. This shows an underutilization of the GPU’s potential.

If you’re doing a lot of vertex shader work that doesn’t result in pixels, that may indicate an inefficiency. While low wavefront occupancy is not necessarily bad, it’s a metric to start optimizing your shaders and checking for other bottlenecks. For example, if you have a stall due to memory or compute operations, increasing occupancy may help performance. On the other hand, too many in-flight wavefronts can cause cache thrashing and *decrease* performance.

Use HDRP built-in and custom passes

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

If your project uses HDRP, take advantage of its built-in and custom passes. These can assist in rendering the scene. The built-in passes can help you optimize your shaders. HDRP includes several injection points where you can add custom passes to your shaders.

Use HDRP injection points to customize the pipeline.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

For optimizing the behavior of transparent materials, refer to this page on [Renderer and Material Priority](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@6.7/manual/Renderer-And-Material-Priority.html?utm_source=demand-gen&utm_medium=pdf&utm_campaign=asset-links-gmg-choose-unity-for-multiplatform&utm_content=optimize-game-performance-2020-lts-ebook).

Reduce the size of shadow mapping render targets

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The High Quality setting of HDRP defaults to using a 4K shadow map. Reduce the shadow map resolution and measure the impact on the frame cost. Just be aware that you may need to compensate for any changes in visual quality with the light’s settings.

Utilize Async Compute

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

If you have intervals where you are underutilizing the GPU, Async Compute allows you to move useful compute shader work in parallel to your graphics queue. This makes better use of those GPU resources.

For example, during shadow map generation, the GPU performs depth-only rendering. Very little pixel shader work happens at this point, and many wavefronts remain unoccupied.

Async Compute can move compute shader work in parallel to the graphics queue.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

If you can synchronize some compute shader work with the depth-only rendering, this makes for a better overall use of the GPU. The unused wavefronts could help with Screen Space Ambient Occlusion or any task that complements the current work.

Optimized render at 30 fps

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

In this example from *Book of the Dead*, several optimizations shaved several milliseconds off the shadow mapping, lighting pass, and atmospherics. The resulting frame cost allowed the application to run at 30 fps on a PS4 Pro.

Watch a performance case study in [Optimizing Performance for High-End Consoles](https://www.youtube.com/watch?v=I5lzlGiJW0k), where Unity Graphics Developer Rob Thompson discusses porting the *Book of the Dead* to PlayStation 4.

Download the complete guide on performance optimization

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

If you want access to the full list of tips and tricks from the team, we’ve also published a 92-page e-book available here, packed with actionable insights.

[**DOWNLOAD E-BOOK**](https://resources.unity.com/games/performance-optimization-e-book-console-pc)

If you’re interested in learning more about Integrated Support services and want to give your team direct access to engineers, expert advice, and best practice guidance for your projects, then check out Unity’s success plans [here](https://unity.com/success-plans).

**Didn’t find what you were looking for?**

We want to help you make your Unity applications as performant as they can be. If there’s any optimization topic that you’d like to know more about, please keep us posted in the comments.
