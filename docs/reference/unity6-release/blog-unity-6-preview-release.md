---
title: "Unity 6 Preview is now available"
page_title: "Unity 6 Preview is now available"
source_url: "https://unity.com/blog/engine-platform/unity-6-preview-release"
final_url: "https://unity.com/blog/engine-platform/unity-6-preview-release"
topic: "unity6-release"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Unity 6 Preview is now available

<a href="https://unity.com/blog" class="text-xxs mt-8 flex items-center font-bold uppercase hover:underline"><span class="ml-1">Unity Blog</span></a>

# Unity 6 Preview is now available

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">NANCY LARUE / UNITY </span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Sr Product Marketing Manager</span>

<span class="mr-2">May 1, 2024</span><span class="mr-2">\|</span><span class="mr-2">24 Min</span>

Programming and DevOps

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We’re excited to announce the release of Unity 6 Preview, which is available for you to [download](https://unity.com/releases/editor/whats-new/6000.0.0) today. Unity 6 Preview (formerly known as 2023.3 Tech Stream) is the last release of our development cycle for Unity 6, which is launching late this year.

Last November at Unite, we announced that we were updating our naming conventions (you can read more about these changes in [this forum post](https://forum.unity.com/threads/unity-6-new-naming-convention.1558592/)).

Unity 6 Preview is structured just like a Tech Stream release. It’s a supported release that gives you a head start using new and updated features in projects that are in discovery or prototyping stages. For projects in production, we recommend using the [Unity 2022 LTS](https://unity.com/releases/2021-lts) release for greater stability and support.

Here are a few highlights from the Unity 6 Preview, which also includes features released in [2023.1](https://blog.unity.com/engine-platform/2023-1-tech-stream-now-available), and [2023.2](https://blog.unity.com/engine-platform/2023-2-tech-stream-now-available). You can also find more details in the official [release notes](https://unity.com/releases/editor/whats-new/6000.0.0#release-notes).

Boost rendering performance

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

In Unity 6 Preview, the Universal Render Pipeline (URP) and the High Definition Render Pipeline (HDRP) both see significant performance enhancements that speed up production across platforms. Depending on your content, the improvements described here can reduce CPU workload by 30–50% while providing smoother, faster rendering across various platforms.

The new **[GPU Resident Drawer](https://forum.unity.com/threads/gpu-driven-rendering-in-unity.1502702/)** allows you to efficiently render larger, richer worlds without the need for complicated manual optimizations. You can optimize your games with up to 50% CPU frame-time reduction for GameObjects when rendering large, complex scenes across platforms, including high-end mobile, PC, and consoles.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Working alongside the GPU Resident Drawer, **GPU Occlusion Culling** boosts the performance of GameObjects by reducing the amount of overdraw for each frame, which means the renderer is not wasting resources drawing things that are not seen.

This content is hosted by a third party provider that does not allow video views without acceptance of Targeting Cookies. Please set your cookie preferences for Targeting Cookies to yes if you wish to view videos from these providers.

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Cookie settings</span>

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

You can optimize GPU performance and significantly enhance visual quality and runtime performance with **Spatial-Temporal Post-Processing (STP)**.STP is designed to take frames rendered at a lower resolution and upscale them without any loss of fidelity, delivering consistent, high-quality content to platforms with varying levels of performance capabilities and screen resolutions. STP is compatible with both URP and HDRP, across desktops, consoles, and, notably, compute-capable mobile devices.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

**Render Graph** for URP is a new rendering framework and API that simplifies the maintenance and extensibility of the render pipeline and improves rendering efficiency and performance. The new system introduces various key optimizations, such as the automatic merging and creation of native render passes, in order to reduce memory bandwidth usage along with energy consumption – especially on tile-based (mobile) GPUs.

The new Render Graph API also streamlines the custom pass injection workflow, allowing you to extend the render pipeline with your own custom Raster and Custom passes, as well as to reliably access all of the pipeline resources needed using the new Context Container.

Lastly, with the new **Render Graph Viewer** tool, you can now analyze the Engine’s render pass creation and frame resource usage directly in the Editor, simplifying render pipeline debugging and optimization.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

**Foveated Rendering API** in URP allows you to configure the Foveation Level, improving GPU performance at the cost of reduced fidelity around a user’s mid/far peripheral.

Two new foveation modes are available. With Fixed Foveated Rendering, regions in the center of the screen space benefit from higher quality, while Gazed Foveated Rendering uses eye tracking to determine which regions of the screenspace will benefit.

The Foveated Rendering API is compatible with the Sony PlayStation®VR2 plug-in and Meta Quest through the Oculus XR plug-in, with support for the OpenXR plug-in coming soon.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

**Volume framework enhancements** in both HDRP and URP optimize CPU performance on all platforms to make it viable even on low-end hardware. It allows you to set global and per-quality levels volumes in URP, similar to what was possible in HDRP with an improved user interface across the board. Additionally, it’s now easier to leverage the Volume framework with **Custom post-processing** effects for URP to build your own effects like a custom fog ([check out this demo](https://youtu.be/Z-XCk8mXJtI?t=2653) from our December live stream to learn more).

Lighting enhancements

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

**Adaptive Probe Volumes (APV)** provide a new way for you to build global illumination lighting in Unity. They enable more streamlined authoring and iteration times for Light Probe-lit objects, and open new possibilities like time-of-day scenarios and streaming.

Building on the development of **APV** delivered in the 2023.1 and 2023.2 Tech Stream releases, enhancements in Unity 6 Preview improve authoring workflows, expand streaming capabilities, and extend control and platform reach to achieve impactful lighting transitions.

We have expanded **APV Scenario Blending** to URP, enabling a wider range of platform support for you to easily blend between baked probe volume data for day/night transitions or to switch lights on and off in rooms.

This content is hosted by a third party provider that does not allow video views without acceptance of Targeting Cookies. Please set your cookie preferences for Targeting Cookies to yes if you wish to view videos from these providers.

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Cookie settings</span>

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

**APV Sky Occlusion,** supported in both URP and HDRP, enables you to apply a time-of-day lighting scenario to your virtual environments and achieve more color variations in static indirect lighting from the sky compared to APV scenario blending.

This content is hosted by a third party provider that does not allow video views without acceptance of Targeting Cookies. Please set your cookie preferences for Targeting Cookies to yes if you wish to view videos from these providers.

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Cookie settings</span>

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

**APV disk streaming** now supports a non-compute path in URP, and we’ve enabled support for AssetBundles and Addressables.

Leverage the **Probe Adjustment Volumes tool** to fine-tune your APV content and fix light leaking situations. Adjustments you can make to probes inside these volumes include Override Sample Count and Invalidate Probes. Light Probes not affected by the Adjustment Volume can be hidden, and probe lighting data can now be previewed only for impacted probes, then baked directly from the Probe Volume and Probe Adjustment Volume components.

Finally, we introduced a new **C# Light Probe Baking API**,enabling you to control how many probes to bake at a time to balance execution time against memory usage.

We’ve used the APV probe baking editor code as an example of how to use the API, and you can find this example [on GitHub](https://github.com/Unity-Technologies/Graphics/blob/9415add/Packages/com.unity.render-pipelines.core/Editor/Lighting/ProbeVolume/ProbeGIBaking.LightTransport.cs#L583).

This content is hosted by a third party provider that does not allow video views without acceptance of Targeting Cookies. Please set your cookie preferences for Targeting Cookies to yes if you wish to view videos from these providers.

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Cookie settings</span>

Richer high-fidelity environments

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

In HDRP, we improved sky rendering for sunset and sunrise to better enable your project’s time-of-day scenarios. This adds ozone layer support and atmospheric scattering to complement fog at long distances.

This content is hosted by a third party provider that does not allow video views without acceptance of Targeting Cookies. Please set your cookie preferences for Targeting Cookies to yes if you wish to view videos from these providers.

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Cookie settings</span>

This content is hosted by a third party provider that does not allow video views without acceptance of Targeting Cookies. Please set your cookie preferences for Targeting Cookies to yes if you wish to view videos from these providers.

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Cookie settings</span>

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Water has been improved with support for **Underwater Volumetric fog** that samples caustics to create volumetric light shafts. Performance optimization now includes an option to read back simulation from the GPU with a few frames of delay instead of replicating the simulation on the CPU. We also added support for transparent surfaces with mixed tracing mode to mix raytraced and screen space effects when rendering surfaces like water together with terrains and vegetation.

This content is hosted by a third party provider that does not allow video views without acceptance of Targeting Cookies. Please set your cookie preferences for Targeting Cookies to yes if you wish to view videos from these providers.

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Cookie settings</span>

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Because performance is key when rendering large dynamic worlds, we optimized **SpeedTree** vegetation rendering for both URP and HDRP, leveraging the new **GPU Resident Drawer** mentioned above.

VFX Graph artist workflows

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

For VFX artists, we’ve improved tooling and URP support so you can efficiently reach more platforms. **VFX Graph profiling tools** allow a VFX artist to find what could be optimized within a graph by getting feedback about memory and performance to tweak certain effects and maximize performance.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Build VFX shaders with the support of **Shader Graph Keywords**, and more complex effects with URP with **URP depth and color buffers** for fast collision or for spawning particles from the world.

Get a quick start in VFX Graph with new [Learning Templates](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.0/manual/sample-learningTemplates.html), a collection of VFX assets designed to help you learn about VFX Graph concepts and features.

Shader Graph artist workflows

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Unity 6 Preview addresses many of the top user pain points when using **Shader Graph** by including new editable **keyboard shortcuts**, a **heatmap color mode** to quickly identify the most GPU-intensive nodes in your graphs, and faster Undo/Redo.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Access new [**Node Reference Samples**](https://blog.unity.com/engine-platform/shader-graph-feature-examples-2022-lts) containing a set of Shader Graph assets where each graph is a description of one node, with breakdowns of how the math works under the hood, and examples of how the node can be used. Learn more in the [Node Reference Samples Tutorial](https://www.youtube.com/watch?v=vrEi6M3GjC4) video.

This content is hosted by a third party provider that does not allow video views without acceptance of Targeting Cookies. Please set your cookie preferences for Targeting Cookies to yes if you wish to view videos from these providers.

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Cookie settings</span>

Multiplatform enhancements

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Unity 6 Preview brings multiplatform enhancements across desktop, mobile, web, and XR, aimed at delivering optimizations to multiplatform development workflows and expanding reach across the most popular platforms.

Quality-of-life improvements to the Unity build window, plus all-new build profiles

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

With the new **Build Profiles** feature, managing builds will be more efficient, with a higher degree of flexibility than ever before.

As well as configuring build settings in each profile, you can now include different scene lists to customize the content of your builds, creating multiple unique, playable demos for your game with the scenes you want to share most.

Additionally, you can set custom scripting defines for any profile, which are additive over those found in player settings, to allow for fine-tuning of features and behavior of both builds and Editor Play mode. This could be used to create vertical slices or target different behavior for different platforms.

You can add an override for player settings to any profile, allowing you to customize settings that relate to the platform module. This feature makes it easier to configure publishing settings for different profiles. Overall, this new feature reduces the need to rely on custom build scripts to customize the way that builds are managed in the Editor.

Finally, we also added the **Platform Browser** to enhance platform discovery inside the Editor. The platform browser is a place where you can discover all the platforms that Unity supports and create build profiles for any you choose.

Expand mobile gaming reach with web runtimes

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Android and iOS browser support has arrived With Unity 6 Preview. Now, you can run your Unity games anywhere on the web, without limiting your browser games to desktop platforms. Additionally, you can embed your games in a web view in a native app or use our progressive web app template to make your game behave more like a native app, with its own shortcut and offline functionality. With more bells and whistles such as mobile device compass support and GPS location tracking, your web games will be able to react to wherever your gamers choose to play.

Fine-tune your web games with an update to the Emscripten 3.1.38 toolchain and the latest support for WebAssembly 2023, our collection of newer WebAssembly language features such as sign-ext opcodes, non-trapping fp-to-int, bulk-memory, BigInt, Wasm table, native Wasm exceptions, and Wasm SIMD. WebAssembly 2023 also supports up to 4GB of heap memory, unlocking access to even more RAM for you to use on the newest hardware.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Additional mobile improvements coming with Unity 6 Preview include the latest Android tooling and support for Java 17 out of the box, as well as the ability to include debug symbols within your Android App Bundle. This will save you time when submitting to the Google Play Store and ensure you always have stacktrace information in the Play Console.

Early access to the WebGPU backend

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The introduction of experimental support for a WebGPU backend marks a significant milestone for web-based graphics acceleration, paving the way for future leaps coming to graphics rendering fidelity for Unity web games.

WebGPU is designed with the goal of harnessing and exposing modern GPU capabilities, such as Compute Shader support, to the web. This new web API will achieve this by providing a modern graphics acceleration interface that’s implemented internally via native GPU APIs such as DirectX 12, Vulkan, or Metal, depending on the desktop device you use.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The WebGPU graphics backend is still in experimental state, so we do not recommend using it for production. Can’t wait? Discover how to gain early access and test WebGPU in our [graphics forum](https://forum.unity.com/threads/early-access-to-the-new-webgpu-backend-in-unity-2023-3.1516621/).

Unity Editor support for Arm-based Windows devices

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Unity delivered support for Arm-based Windows devices in 2023.1, enabling you to bring your titles to new hardware. With Unity 6 Preview we are now delivering native Unity Editor support for Arm-based Windows devices in Unity 6. This means you can now take advantage of the performance and flexibility that Arm-powered devices can offer to create your Unity games.

DirectX 12 backend improvements

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Unity’s DirectX 12 graphics backend is fully production ready, and available for use when targeting DX12-capable Windows platforms. This change is preceded by a comprehensive array of improvements to both rendering stability and performance.

Using DX12, Unity Editors and Players can benefit from significant improvements to CPU performance by using Split Graphics Jobs. Performance gains are expected to scale based on scene complexity and the amount of draw calls submitted.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Most noticeably, the DX12 graphics API unlocks support for a wide range of modern graphics capabilities in order to enable the next generation of rendering techniques, such as Unity’s ray tracing pipeline. Upcoming features will make use of DX12’s advanced capabilities, ranging from graphics to machine learning, to enable an unprecedented level of fidelity and performance.

Unlock the Microsoft platform ecosystem with the Microsoft GDK packages

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Thanks to the ongoing partnership between Microsoft and Unity, two new Microsoft GDK packages are now available with Unity 6 Preview, 2022 LTS, and 2021 LTS. The Microsoft GDK Tools and Microsoft GDK API packages can be used for Microsoft gaming platforms with the same configuration and code base. These packages make it easier than ever to build for Microsoft gaming platforms like Windows and Xbox using the same code to utilize Xbox services like user identity, player data, social, cloud storage and more.

The combined Microsoft GDK packages allow you to make games for Microsoft platforms with a shared code base and the ability to automate the build process through APIs. Additionally, new samples are provided to showcase various features available in the packages.

Previously when targeting Xbox consoles and the Microsoft Store on Windows, guidance was to install separate GDK packages provided by Microsoft and Unity. This required the maintenance of a different branch of code for different Microsoft platform targets. Using the new Microsoft GDK packages, this is no longer the case. Also, it will now be possible to modify the MicrosoftGame.config file from an API directly in the build server. Combined with the new build profiles features in Unity 6, bringing your games to the Microsoft gaming ecosystem from a single project has never been easier.

If you’ve been using the legacy Game Core Package or the Windows GDK package and want to migrate to these new Microsoft GDK packages (the Microsoft GDK API and Microsoft GDK Tools), follow the instructions detailed in [this migration guide](https://docs.unity3d.com/Packages/com.unity.microsoft.gdk@1.0/manual/migration.html).

XR experiences

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We support most popular XR platforms, including ARKit, ARCore, visionOS, Meta Quest, Playstation VR, Windows Mixed Reality, and more. In Unity 6 Preview, you’ll find cutting-edge cross-platform features like mixed reality, hand and eye input, and improved visual fidelity. Many of these new features are now integrated into our revamped templates so you can get started more quickly.

Bringing the physical world into your game

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Whether you want to expand your existing game with mixed reality or you’re making something entirely new, [AR Foundation](https://docs.unity3d.com/Packages/com.unity.xr.arfoundation@6.0/manual/whats-new.html) helps you incorporate the physical world into players’ experience in a cross-platform way. In Unity 6 Preview, we’ve added support for image stabilization on ARCore, as well as improved support for mixed reality platforms like Meta Quest, including features like meshing and bounding boxes.

XR input and interactions

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

To help you streamline your interactions, we’ve added a couple of major improvements to [XR Interaction Toolkit 3.0](https://docs.unity3d.com/Packages/com.unity.xr.interaction.toolkit@3.0/manual/whats-new-3.0.html) (XRI). This includes a new interactor called the Near-Far Interactor, enabling greater flexibility and modularity when customizing how interactors behave in your projects.

We’ve also improved how we handle input in XRI with the addition of our new Input Readers, which streamlines the input process and reduces code complexity across various types of input. Lastly, we will ship a new virtual keyboard sample, giving you the ability to build and customize in-game keyboards in a cross-platform way.

Unique hand gestures

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

More platforms now support the use of hands to interact with content. Our [XR Hands](https://docs.unity3d.com/Packages/com.unity.xr.hands@1.5/manual/version-history/whats-new.html) package enables you to implement custom hand gestures (such as thumbs up, thumbs down, pointing), as well as common OpenXR hand gestures. It includes samples to help you get started quickly. We’ve also included tools for creating, fine-tuning, and debugging your hand shapes and gestures so that your content is accessible to more people.

Improved visual fidelity

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

One way to improve the visual fidelity of your game is through a feature called [Composition Layers](https://docs.unity3d.com/Packages/com.unity.xr.compositionlayers@0.5/manual/index.html), which is currently available as an experimental package.

This feature renders text, video, UI, and images at much higher quality using native support for the runtime’s compositor layers, enabling clearer text, sharper outlines, and an overall better appearance with significantly reduced artifacts.

Simplify multiplayer creation

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Unity 6 Preview accelerates the creation, launch, and growth of multiplayer games with the simplicity of integrated end-to-end solutions.

Experimental Multiplayer Center

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We’ve made the new Experimental Multiplayer Center package (*com.unity.multiplayer.center*) available in the package registry. Multiplayer Center is a streamlined guidance tool designed to onboard you into multiplayer development. This central location in the Editor gives you access to the tools and services Unity offers for your project’s specific needs.

Multiplayer Center presents interactive guidance based on your project’s multiplayer specifications, access to resources and educational materials, and shortcuts to deploy features and experiment rapidly with multiplayer capabilities.

Multiplayer Play Mode

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We’ve released Multiplayer Play Mode version 1.0., enabling you to test multiplayer functionality across separate processes without leaving the Unity Editor. You can simulate up to four players (the main Editor player plus three virtual players) simultaneously on the same development device while using the same source assets on disk. You can use Multiplayer Play Mode to create multiplayer development workflows that reduce the time it takes to build a project, run locally, and test the server-client relationship.

Multiplayer tools

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We updated the Multiplayer Tools package to version 2.1.0, adding Network Scene Visualization as a new visual debugging tool. Network Scene Visualization (NetSceneVis) is a powerful tool included in the Multiplayer Tools package to help you visualize and debug network communication on a per-object basis in the Unity Editor Scene View of your project with visualizations such as mesh shading and text overlay.

Experimental Distributed Authority for Netcode for GameObjects

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We added [Distributed Authority](https://docs-multiplayer.unity3d.com/netcode/current/terms-concepts/distributed-authority/) mode in Netcode for GameObjects version 2.0.0-exp.2 (*com.unity.netcode.gameobjects*) when paired with the new Experimental Multiplayer Services SDK version 0.4.0 (*com.unity.services.multiplayer*). With Distributed Authority, clients have distributed ownership of/authority over spawned Netcode objects during a game session. The netcode simulation workload is distributed across clients, while the network state is coordinated through a high-performance cloud backend Unity provides.

Netcode for Entities

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We improved the experience of Netcode for Entities with support for GameObjects to render debug bounding boxes. We also added the NetCodeConfig ScriptableObject which contains most NetCode configuration variables, which you can customize without needing to modify code.

Dedicated Server package

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We’ve released the Dedicated Server package, which allows you to switch a project between the server and client role without the need to create another project. To do this, use Multiplayer roles to distribute GameObjects and components across the client and server.

[Multiplayer roles](https://docs.unity3d.com/Packages/com.unity.dedicated-server@1.0/manual/multiplayer-roles.html) allows you to decide which multiplayer role (Client, Server) to use in each build target. This breaks down into:

-   [Content Selection](https://docs.unity3d.com/Packages/com.unity.dedicated-server@1.0/manual/content-selection.html): Provides UI and API for selecting which content (GameObjects, Components) should be present/removed in the different multiplayer roles
-   [Automatic Selection](https://docs.unity3d.com/Packages/com.unity.dedicated-server@1.0/manual/automatic-selection): Provides UI and API for selecting which component types should be automatically removed in the different multiplayer roles
-   [Safety Checks](https://docs.unity3d.com/Packages/com.unity.dedicated-server@1.0/manual/safety-checks): Activates warnings that help detect potential null reference exceptions caused by stripping objects for a multiplayer role

This package also contains additional optimizations and workflow improvements for developing Dedicated Server platforms.

Experimental Multiplayer Services SDK

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The Experimental Multiplayer Services SDK is a one-stop solution for adding online multiplayer elements to a game developed in Unity 6 Preview. Powered by Unity Gaming Services (UGS), it combines capabilities from services such as Relay and Lobby into a single new “Sessions” system to help you quickly define how groups of players connect together.

The Experimental Multiplayer Services SDK version 0.4.0 (*com.unity.services.multiplayer)* enables you to create peer-to-peer (P2P) sessions while providing multiple methods for players to join those sessions, such as by a Join Code, by browsing a list of active sessions and “Quick Join.”

Multiplayer in Unity 6 Preview

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

For this Unity 6 Preview milestone, several of these capabilities are still in an [Experimental state](https://docs.unity3d.com/6000.0/Documentation/Manual/pack-exp.html), which means they are not yet supported for production. We intend to rapidly transition them to [Pre-release and Release states](https://docs.unity3d.com/6000.0/Documentation/Manual/upm-lifecycle.html) for a fully supported experience on Unity 6 that integrates your feedback. You can engage with us in our community [forums](https://forum.unity.com/threads/unity-6-preview-is-now-available.1579680/) and on our [official Discord server](https://discord.gg/g54SpMn8).

Entities workflows enhancements

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Unity 6 Preview streamlines ECS workflows and resolves common pain points. As part of this effort, we changed the way that Entities are stored in preparation for a future consolidation of Entities and GameObject workflows. Entity IDs are now globally unique, and you can now move them efficiently from one Entity’s world to another. This does not impact ECS workflows, but it does disambiguate debugging by always showing exact entities.

Additionally, the recent improvements delivered to ECS in Unity 2022 LTS are also available in Unity 6 Preview:

-   ECS 1.1: Major physics collider workflow and performance improvements, plus 80+ fixes across the ECS framework
-   ECS 1.2: Quality-of-life and performance improvements across Editor workflows, serialization, baking, plus 50+ fixes and Unity 6 compatibility

Deliver dynamic runtime experiences with AI

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The Unity 6 Preview ships with [**Unity Sentis**](https://unity.com/products/sentis), a neural engine for integrating AI models into the runtime. Sentis makes new AI-powered features possible, like object recognition, smart NPCs, graphics optimizations, and more. Recent enhancements to Sentis focus on performance and simplifying the experience of getting started

Performance

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We now support AI model weight quantization (FP16 or UINT8) in the Unity Editor if you want to reduce your model size by up to 75%. That’s a big savings when it comes to shipping games on mobile. Model scheduling speed was also improved by 2x, along with reduced memory leaks and garbage collection. Lastly, we now support even more [ONNX operators](https://docs.unity3d.com/Packages/com.unity.sentis@1.4/manual/supported-operators.html).

Getting started

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

To make it easier to find the right AI model for your project, we partnered with **Hugging Face**, the largest AI model hub in the world (600,000+ models). Now you can instantly find “grab and go” [AI models for Unity Sentis](https://huggingface.co/models?library=unity-sentis&sort=trending) to ensure easy integration.

Once you have the right model, you’ll need to hook it up to your game. To make that easier, we introduced a new Functional API that helps to build, edit, and chain AI models. It’s intuitive, stable, and optimized for inference. The Backend API is still available for those of you who need a lower-level and fully customizable API to have full control over memory management and scheduling.

To learn more about Unity Sentis, check out our [blog overview](https://blog.unity.com/games/create-next-gen-ai-models-with-unity-sentis), [documentation](https://docs.unity3d.com/Packages/com.unity.sentis@latest), or dive into the [community](https://discussions.unity.com/c/ai-beta/sentis/10).

Enhance productivity and functionality

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The Unity Engine offers tools ranging from Visual Scripting to UI Toolkit to enhance your productivity and functionality. On top of existing tools, Unity 6 Preview specifically comes with two updates within the profiling tools portfolio.

Memory Profiler

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Unity 6 Preview brings two major updates when it comes to the Memory Profiler. First, graphics memory that was previously uncategorized is now measured and reported per resource (e.g., render textures and compute shaders). Second, reporting of resident memory is more precise – for example, memory that is swapped to disk is no longer counted towards this. These updates address direct feedback around the problem of understanding native memory use in particular.

Want to know more?

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

To learn more details about what’s in the Unity 6 Preview, check out the [release notes](https://unity.com/releases/editor/whats-new/6000.0.0#release-notes) for a comprehensive list of features, and the [Unity Manual](https://docs.unity3d.com/6000.0/Documentation/Manual/index.html) for details on how to use them.

Unity 6 Preview release is supported with weekly updates until the next version. Remember to always back up your work prior to upgrading to a new version. Our [Upgrade manual](https://docs.unity3d.com/6000.0/Documentation/Manual/UpgradeGuides.html) can assist with this. For projects in production, we recommend using [Unity 2022 LTS](https://unity.com/releases/2021-lts) for greater stability and support.

Unity 6 Preview is most suitable for testing during preproduction, discovery, and prototyping phases of your development process. However, if any code, functionality, or fixes from any Unity 6 version are incorporated in a live game, it may be subject to the applicable runtime fees if the game is upgraded to Unity 6 in General Availability (provided the [Runtime Fee criteria](https://unity.com/runtime-fee-estimator) are met).

Let’s keep the conversation going

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The Unity 6 Preview release is an opportunity to both get early access to new features and to shape the development of future tech through your feedback. We want to hear how we can best support you and your projects. Let us know how we’re doing on the [forums](https://forum.unity.com/threads/unity-6-preview-is-now-available.1579680/), or share your feedback directly with our product team through the [Unity Platform Roadmap](https://unity.com/roadmap/unity-platform).
