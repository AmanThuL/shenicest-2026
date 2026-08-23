---
title: "Art optimization tips for mobile game developers part 2"
page_title: "Art optimization tips for mobile game developers part 2"
source_url: "https://unity.com/how-to/mobile-game-optimization-tips-part-2"
final_url: "https://unity.com/how-to/mobile-game-optimization-tips-part-2"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Mobile optimization tips for technical artists Part II

***What you will get from this page:*** *Part II of our collection of helpful tips* *for optimizing your art assets for your mobile game. Part I is* *[here](https://unity.com/how-to/mobile-game-optimization-tips-part-1).*

*You can find many other mobile optimization tips in* [*this comprehensive e-book*](https://create.unity3d.com/optimize-mobile-game-eBook) *and this Unity Learn course on* *[3D Art Optimization for Mobile Applications](https://learn.unity.com/course/3d-art-optimization-for-mobile-gaming-5474?utm_source=demand-gen&utm_medium=pdf&utm_campaign=asset-links-gmg-elevate-your-game&utm_content=optimize-mobile-game-performance-ebook).*

Lighting

Avoid too many dynamic lights

Disable shadows

Bake your lighting into lightmaps

Use Light Layers

Use Light Probes for moving objects

Minimize Reflection Probes

Be mindful of transparent materials

Keep shaders simple

Lit vs. Unlit shaders

Math operations in the vertex shader

SRP Batcher

Character animation

More tips

ORGANIZE YOUR GAMEOBJECTS TO TAKE ADVANTAGE OF THESE BATCHING TECHNIQUES.

## Lighting

The same physically based lighting and materials from consoles and PCs can also scale to your phone or tablet with the [Universal Render Pipeline](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@12.0/manual/index.html) (URP).

Batch your draw calls

With each frame, Unity determines the objects that must be rendered, then creates draw calls. A draw call is a call to the graphics API to draw objects (e.g., a triangle), whereas a batch is a group of draw calls to be executed together. [Batching objects](https://docs.unity3d.com/2020.3/Documentation/Manual/DrawCallBatching.html) to be drawn together minimizes the state changes needed to draw each object in a batch. This leads to improved performance by reducing the CPU cost of rendering objects.

-   **Dynamic batching:** For small meshes, Unity can group and transform vertices on the CPU, then draw them all in one go. Note: Only use this if you have enough low-poly meshes (less than 900 vertex attributes and no more than 300 vertices). The Dynamic Batcher won’t batch meshes larger than this, so enabling it will waste CPU time looking for small meshes to batch in every frame.
-   **Static batching:** For non-moving geometry, Unity can reduce draw calls for meshes that share the same material. While it is more efficient than dynamic batching, it uses more memory.
-   **GPU instancing:** If you have a large number of identical objects, this technique batches them more efficiently through the use of graphics hardware.

**SRP Batching:** Enable the SRP Batcher in your URP asset under Advanced. This can speed up your CPU rendering times significantly, depending on the scene.

## Avoid too many dynamic lights

It’s crucial to avoid adding too many dynamic lights to your mobile application. Consider alternatives like custom shader effects and light probes for dynamic meshes, as well as baked lighting for static meshes.

See this [feature comparison table](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@12.0/manual/universalrp-builtin-feature-comparison.html) for the specific limits of URP and Built-In Render Pipeline real-time lights.

## Disable shadows

Shadow casting can be disabled per MeshRenderer and light. Disable shadows whenever possible to reduce draw calls.

You can also create fake shadows using a blurred texture applied to a simple mesh or quad underneath your characters. Otherwise, you can create blob shadows with custom shaders.

DISABLE SHADOW CASTING TO REDUCE DRAW CALLS.

## Bake your lighting into lightmaps

Add dramatic lighting to your static geometry using **Global Illumination (GI)**. Mark objects with **Contribute GI** so you can store high-quality lighting in the form of lightmaps.

Baked shadows and lighting can then render without a performance hit at runtime. The Progressive CPU and GPU Lightmapper can accelerate the baking of Global Illumination.

Follow the [manual](https://docs.unity3d.com/Manual/Lightmapping.html) and [this article on light optimization](https://unity.com/how-to/advanced/optimize-lighting-mobile-games) to get started with lightmapping in Unity.

LAYERS CAN LIMIT YOUR LIGHT’S INFLUENCE TO A SPECIFIC CULLING MASK.

## Use Light Layers

For complex scenes with multiple lights, separate your objects using layers, then confine each light’s influence to a specific culling mask.

## Use Light Probes for moving objects

Light Probes store baked lighting information about the empty space in your scene, while providing high-quality lighting (both direct and indirect). They use Spherical Harmonics, which calculate quickly compared to dynamic lights.

## Minimize Reflection Probes

A [Reflection Probe](https://docs.unity3d.com/Manual/class-ReflectionProbe.html) can create realistic reflections, but can be very costly in terms of batches. Use low-resolution cubemaps, culling masks, and texture compression to improve runtime performance.

OVERDRAW VISUALIZATION MODE IN THE SCENE VIEW

## Be mindful of transparent materials

Rendering an object with transparency always uses more GPU resources than rendering an opaque object, especially when transparent objects are rendered on top of one another multiple times, a process known as overdraw. It’s a good practice to use an opaque material whenever possible, especially for mobile platforms. You can check overdraw using the [RenderDoc](https://docs.unity3d.com/Manual/RenderDocIntegration.html) graphics debugger.

## Keep shaders simple

Use the simplest shader possible (such as an unlit shader) and avoid using unnecessary features. Use Unity’s prebuilt shaders designed specifically for systems such as particles. URP includes several lightweight Lit and Unlit shaders that are already optimized for mobile platforms. To minimize overdraw, reduce the number and/or size of particles in your game.

For performance goals consider using Unlit Opaque materials with half precision, when possible, and be mindful of complex operations in the nodes. Find more tips in [this session](https://www.slideshare.net/unity3d/best-practices-for-shader-graph) on Shader Graph.

## Lit vs. Unlit shaders

When creating a shader, you can decide how the material will react to light. Most shaders are classified as either lit or unlit. An unlit shader is the fastest and computationally cheapest shading model. Use it if you’re targeting a lower-end device.

Key points to consider include:

-   Lighting does not affect an unlit shading model. This means that many calculations, such as specularity calculations, aren’t needed. The result is either cheaper or faster rendering.
-   Using a stylized art direction that resembles a cartoon works well with unlit shading. This style is worth considering when you’re developing games for mobile platforms.

VERTEX DISPLACEMENT IN SHADER GRAPH

## Math operations in the vertex shader

Vertex shaders work on every vertex while pixel (or fragment) shaders run on every pixel. Usually, there are more pixels that are being rendered than there are vertices on-screen. This means that the pixel shader runs more often than the vertex shader. Because of this, we recommend that you move computation from the pixel shader to the vertex shader whenever possible. As usual, after working on optimizations, you must do further profiling to determine the best solution for your particular situation.

Basic operations, such as addition and multiplication, are faster to process. It’s best to keep the number of slower math operations as small as possible. The amount of complicated math that is used must be kept lower on older devices, such as ones using GLES 2.0.

## SRP Batcher

When toggling the [SRP Batcher](https://docs.unity3d.com/2021.2/Documentation/Manual/SRPBatcher.html) on, watch the Statistics window and the Rendering Section’s Vertices Graph in the Profiler view. Aside from a bump in FPS, the number of triangles and vertices being processed decreases dramatically. Because our objects use a shader that is compatible with URP, the render pipeline automatically batches all relevant geometry data to reduce the amount of data processed.

## Character animation

By default, Unity imports animated models with the Generic Rig, though developers often switch to the Humanoid Rig when animating a character. A Humanoid Rig consumes 30–50% more CPU time than the equivalent generic rig because it calculates inverse kinematics and animation retargeting each frame.

Rendering [skinned meshes](https://docs.unity3d.com/2021.2/Documentation/Manual/class-SkinnedMeshRenderer.html) is expensive. Make sure that every object using a SkinnedMeshRenderer requires it. If a GameObject only needs animation some of the time, use the BakeMesh function to freeze the skinned mesh in a static pose, then swap to a simpler MeshRenderer at runtime.

Primarily intended for humanoid characters, Unity’s Mecanim system is fairly sophisticated but is often used to animate single values (e.g., the alpha channel of a UI element). Avoid overusing Animators. Particularly in conjunction with UI elements, consider creating tweening functions or using a third-party library for simple animations (e.g., DOTween or LeanTween).

CHECK THE DRAW CALLS, BATCHING AND EVERY STEP OF THE RENDERING CYCLE WITH THE FRAME DEBUGGER TOOL

## More tips

Work on a specific time budget per frame

Each frame will have a time budget based on your target frames per second (fps). Ideally, an application running at 30 fps will allow for approximately 33.33 ms per frame (1000 ms / 30 fps). Likewise, a target of 60 fps leaves 16.66 ms per frame.

Devices can exceed this budget for short periods of time (e.g., for cutscenes or loading sequences), but not for a prolonged duration.

Presets

Don’t rely on default settings. Use the platform-specific override tab to optimize assets such as textures and mesh geometry. Incorrect settings might yield larger build sizes, longer build times, and poor memory usage. Consider using the Presets feature to help customize baseline settings that will enhance a specific project.

Limit use of cameras

Each camera incurs some overhead, whether it’s doing meaningful work or not. Only use Camera components required for rendering. On lower-end mobile platforms, each camera can use up to 1 ms of CPU time.

Avoid full-screen effects

Fullscreen Post-processing effects, like glows, can dramatically slow down performance. Use them cautiously in your title’s art direction.

Be careful with *Renderer.material*

Accessing *Renderer.material* in scripts duplicates the material and returns a reference to the new copy. This breaks any existing batch that already includes the material. If you wish to access the batched object’s material, use *Renderer.sharedMaterial* instead.
