---
title: "Unity 6.3 LTS is now available"
page_title: "Unity 6.3 LTS is Now Available"
source_url: "https://unity.com/blog/unity-6-3-lts-is-now-available"
final_url: "https://unity.com/blog/unity-6-3-lts-is-now-available"
topic: "unity6-release"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Unity 6.3 LTS is Now Available

Announcement

# Unity 6.3 LTS is now available

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">ADAM SMITH / UNITY TECHNOLOGIES</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Senior Vice President, Product – Engine</span>

<span class="mr-2">Dec 4, 2025</span><span class="mr-2">\|</span><span class="mr-2">9:28 Min</span>

Engine

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We’re excited to announce that **Unity 6.3 LTS**, the first **Long-Term Support** release since Unity 6.0 LTS, is now available. For the full breakdown of everything in the release, please refer to the [release notes](https://unity.com/releases/editor/whats-new/6000.3.0#notes).

## Unity 6.3 LTS support and upgradeability

### Two-year support

Unity 6.3 LTS will have **two years of dedicated support**, consistent updates, a growing ecosystem of verified tools, and stable platform support. Unity Enterprise and Unity Industry users will receive an additional year of support (three years total). **Unity 6.2 Update release** is now no longer supported.

**Unity 6.0 LTS** (released October 2024) continues to be supported with the same two-year LTS commitment, with an additional year for Unity Enterprise and Industry users.

### Easier upgrades

With the Unity 6 series, we’re providing consistent quality and stability across every version, and delivering updates incrementally with each release so that you can adopt them without friction to your ongoing projects. Our goal is to make upgrading between Unity 6 versions as smooth as possible while continuing to evolve the engine.

The Unity 6.3 LTS release is recommended for live service games and developers who are about to lock in production on a specific version of Unity, as well as for new and mid-cycle productions.

While our intention is for every Unity 6 release to be a seamless upgrade experience, we also need to balance that goal against the need to evolve the product. You can keep track of the small number of planned breaking changes in Unity 6.3 LTS on [Unity Discussions](https://discussions.unity.com/t/planned-breaking-changes-in-unity-6-3/1646418) as well as the [Upgrade Guide](https://docs.unity3d.com/Manual/UpgradeGuides.html).

## What's new in Unity 6.3 LTS

### Unparalleled reach, simplified

With a number of new additions, Unity 6.3 LTS represents the simplest way to reach the broadest audience yet.

#### Platform Toolkit

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Simplify cross-platform development with a unified API for critical game features like account management, save data, controller ownership, and achievements that work across platforms, with just one codebase. Built-in workflows and Editor-based testing help you to reduce the complexity of passing certification, and test your workflows in-Editor, without building to device. Platform Toolkit provides support for the following:

-   Android**™** / Google Play Services
-   iOS / GameKit
-   Nintendo Switch**™**
-   Nintendo Switch**™** 2
-   PlayStation® 5
-   Windows / GDK
-   Windows / Steam
-   Xbox One
-   Xbox Series X \| S

#### Nintendo Switch™ 2 support

Meet your players wherever they want to play on day 1. We are excited to have built launch-day support for Nintendo Switch™ 2 earlier this year for the Unity 6 series, and we're already seeing a strong Made with Unity lineup of amazing games including *Hollow Knight: Silksong (out now)*, *Skate Story (*coming on December 8).  
*\*Nintendo Switch is a trademark of Nintendo *

#### Android XR capabilities

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We also recently introduced support for the new Android XR platform. New features for Android XR development in Version 1.1 of the OpenXR: Android XR package include:

-   **Face Tracking** – Map users’ real-time facial expressions to virtual avatars
-   **Object Trackables** – Augment real-world objects with virtual content
-   **Automated Dynamic Resolution** – Maintain consistent frame rates for a smoother user experience

#### Native desktop screen reader support

Create accessible games for users with native screen reader support across Windows, macOS, Android, and iOS using unified APIs – no complex plugins or platform-specific workarounds required. [Learn more.](https://discussions.unity.com/t/native-desktop-screen-reader-support-now-available-in-unity-6-3/1681788)

### Performance and stability

Our guiding principle with the Unity Engine is to ensure that we deliver performance and stability above all else, so that your players get the best experience wherever they play. We’ve changed how we develop Unity to make sure this will always be our top priority.

#### Production Verification

We used real games across different genres and platforms to verify Unity 6.3 LTS delivers tools that perform reliably in production, not just in isolated test environments. This includes work with projects like the following:

-   *Phasmophobia*, Kinetic Games
-   *V Rising*, Stunlock Studios
-   *Pokémon Sleep*, The Pokémon Company
-   *Den of Wolves*, 10 Chambers
-   *Survival Kids*, developed by Unity in partnership with KONAMI
-   *Thrasher*, Puddle Games

We used productions like these to validate improvements to areas including UI Toolkit, Shader Graph, Scriptable Build Pipeline, and Profiler. In addition, our work with *Whiteout Survival* by Century Games helped us better understand common challenges that users face with Sprite Atlases, ultimately leading to the development of the new Sprite Atlas Analyzer tool.

Overall, we’ve been able to deliver shorter import times, quicker Play mode entry, and faster build times, all while ensuring Unity 6.3 LTS stability is higher than ever.

Our focus on stability and quality has also delivered measurable results over the last two years:

-   **30% decline in regressions** – Fewer issues introduced with each release
-   **22% decline in user-reported issues** – Improved stability and reliability
-   **More issues resolved than received** – Resolution rate month by month has increased
-   **Lowest open backlog in three years** – 2025 is on track to close with the lowest open backlog levels in three years

Production Verification validates:

-   **Upgrade paths** – Ensuring transitions from prior Unity versions don't cause regressions
-   **Real-world scenarios** – Verifying fitness of new features in complex production environments and for new platforms
-   **Cross-platform stability** – Confirming performance across diverse development environments
-   **Developer feedback integration** – Refining tools based on direct input from experienced game developers

You can upgrade to Unity 6.3 LTS with confidence, knowing that critical areas including iteration improvements, runtime optimizations, cross-platform reach, live ops, monetization, and more have been verified in production.

#### Reduced memory usage and faster iteration times

The ongoing performance of live games is affected by the patches, updates and new content you deliver, and we know many of your titles rely on Addressables for this. We’re continuing to invest in AssetBundles - reducing their in-memory footprint through TypeTree deduplication.

Alongside this, we have targeted improvements that can unlock dramatically shorter build times for DOTS projects.

Here are just a few titles we partner with for Production Verification that have experienced significant improvements:

-   ***Disco Elysium*** (ZA/UM) - Reduced TypeTree runtime memory usage by over 97%
-   ***MARVEL SNAP*** (Second Dinner) - Reduced TypeTree runtime memory usage by 99%
-   ***V Rising*** (Stunlock Studios) - Reduced 4-hour build time by over 50%
-   ***Den of Wolves*** (10 Chambers) - Reduced 90-minute build time to just 30 minutes

Plus, we’re doubling down on Build and Distribution documentation, errors, and warning messages. We know these areas are critical for operating your live-service games, and we’ve worked our way through over a hundred pages of documentation to make that happen.

#### Shader Build Settings

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Shader compilation time can also be drastically reduced with the new Shader Build Settings, which allow you to configure (exclude and convert) Unity’s shader keywords through the Graphics and Build Profile settings - all without coding.

These improvements will particularly benefit teams working with large-scale projects and asset-heavy workflows, where every megabyte of memory and minute of build time directly impacts creativity and productivity.

#### Unity Core Standards

Build with third-party tools and SDKs with greater confidence thanks to Unity Core Standards, a new set of technology and guidelines that provide verified and signed packages to ensure more confidence. Key developers have engaged with us to sign their popular AssetStore packages, with clear labelling in the store and package manager to inform you of their status. [Learn more.](https://unity.com/core-standards)

#### Render Graph

We’ve expanded Render Graph’s utility passes, for greater flexibility, faster iteration, and smaller builds. It also introduces compatibility mode behind a compilation flag, and device connectivity for the Render Graph viewer to help with defragmentation, performance, and long-term unification across pipelines. [Learn more](https://discussions.unity.com/t/render-graph-updates-in-unity-6-3/1668122).

#### Multiplayer

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

One of the most requested features from Mobile and Desktop customers has been support for HTTP/2 and gRPC. This means reduction in server-side load, optimised transfers, improved security, and efficient bi-directional streaming.

For Unity 6.3 LTS we are launching support in UnityWebRequest for all platforms to default to HTTP/2 connections if the server is capable, and it's available for all platforms.

Early tests on Android, for multiple concurrent requests, show a reduction in server load by up to \~ 40% and on-device CPU load by up to \~15-20%.

Additionally, we added Host migration in Netcode for Entities now uses Unity Gaming Services to allow a client-hosted networking experience to continue after the loss of the host.

#### Profiler enhancements

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Summarize profiling data with a simple statistical data view in the Highlights Profiler module, integrated into the Unity Profiler. This serves as an entry point for new users and gives quick, preliminary advice for experienced users.

#### Optimized lightmap memory

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Produce more tightly packed lightmaps, saving VRAM and disk space usage, with xAtlas. [Learn more](https://discussions.unity.com/t/render-graph-updates-in-unity-6-3/1668122).

#### DX12 memory usage

Scratch buffer optimizations and support for the new “tight buffer alignment" flag led to significant reductions in graphics memory usage on DX12 Windows platforms. [Learn more](https://discussions.unity.com/t/render-graph-updates-in-unity-6-3/1668122).

#### Improved batching for renderers

Set per-renderer unsigned int values retrievable in shader code with new MeshRenderer and SkinnedMeshRenderer shader user value API. Enables Scriptable Render Pipeline (SRP) batching across renderers with dynamic custom values at runtime, as an alternative to material property blocks. [Learn more](https://discussions.unity.com/t/renderer-shader-user-value-customize-your-visual-per-renderer/1682526).

#### Optimized post-processing for mobile and untethered XR

URP Bloom options now available for mobile, including Kawase filtering optimized for smaller resolutions and Dual filtering for larger resolutions. Run effects like vignetting, tonemapping, color grading, dithering, and film grain on untethered XR devices like Meta Quest, with optimal performance and lower battery consumption on tile-based GPUs, using a new specialized (“on-tile”) post-processing renderer feature.

#### Sprite Atlas Analyser

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

In Unity 6.3 LTS, we’ve introduced the sprite atlas analyzer tool that finds inefficiencies thanks to built-in reports identifying common issues. This tool is a result of integrating Unity Studio Productions work into the engine, and is a perfect example of how we intend to accelerate engine development from Production Verification. Reports can show you coverage of your sprite atlas in the project, source texture compressions data, number of atlas pages, space wasted, sprite counts, and more.

#### 2D animation

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Gain performance improvements through multi-threading, cached deformed sprites, optimized single-bone mesh deformation, reduced bone data redundancy, and the elimination of unnecessary post-deformation operations with a refactored IK system.

#### 2D Physics

There's a growing need for scalable, consistent, and performance-optimized physics content in 2D games, so we're introducing a new 2D physics low-level API. It's built on Box 2D version 3, the latest actively developed version. Whether you're developing 2D games or physics-based assets for the asset store, you'll benefit from multi-threaded performance, enhanced determinism, and visual debugging support for both Editor and runtime.

#### Graphics device filtering

Configure the optimal graphics API (DX12/DX11) and threading mode, on a per-device basis, with Windows Player settings. This is used by default to achieve a better balance of performance and memory usage, especially on lower-end PCs.

#### Indirect Ray Tracing

Ray-trace a huge number of objects and materials using a single API call with “RTAS.AddInstancesIndirect\<T>” functions. You can also configure ray tracing parameters directly on the GPU using compute shaders to implement GPU-culling and other GPU-driven ray tracing techniques. [Learn more](https://discussions.unity.com/t/render-graph-updates-in-unity-6-3/1668122).

### Improved Authoring Workflows

As always, we remain dedicated to improving your workflow and iteration speed through Editor tooling, and Unity 6.3 LTS is no exception.

#### Shader Graph

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

This release introduces new [customized lighting content](https://discussions.unity.com/t/shader-graph-custom-lighting-sample/1681765) and [terrain shader](https://discussions.unity.com/t/terrain-shaders-in-shader-graph-new-in-unity-6-3/1683627) support, enabling you to create terrain materials without coding. [New features](https://discussions.unity.com/t/shader-graph-improvements-in-unity-6-3/1668235) also include support for 8-texture coordinates for advanced material creation across terrains, characters, and effects, as well as improved workflows for SubGraphs with nested properties and keywords for streamlined workflows.

  

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Additionally, a template browser provides pre-built options for all shaders (lit/unlit surfaces, decals, post-processing, UI, sprites, particles, and 6-way lighting).

#### Visual Effects Graph

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

With new samples and templates, as well as instancing support for GPU events, VFX Graph has never been better for effects across URP and HDRP.

#### Render 3D as 2D

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

3D renderers can now be displayed with depth or 2D sorting rules while maintaining full compatibility with 2D lighting. Works with sorting layers, orders, groups, and sprite masks.

#### UI

As Unity UI (UGUI) is the main UI tool for most Unity users, it remains a priority for the Unity 6 series that we will continue to update and improve, informed by our Unity Studio Productions engagements. Unity 6.3 LTS brings significant visual upgrades to UI Toolkit. Native [SVG support](https://discussions.unity.com/t/vector-graphics-in-ui-toolkit/1683117) delivers crisp vector graphics at any resolution, while a new UI target in Shader Graph enables [custom UI shaders](https://discussions.unity.com/t/feedback-request-custom-shaders-and-post-processing-filters/1680973) with fine rendering control. Creators gain more flexibility for stylized interfaces with post-processing effects, including blur, tint, grayscale, and custom filters. Unity 6.3 also improves how teams build and validate UI with UI Toolkit. A [new testing framework](https://discussions.unity.com/t/ui-toolkit-test-framework-is-available-in-6-3/1698228) lets you script interactions and verify hierarchy or visual state in local or CI workflows. Authoring is smoother with updates to UI Builder, aspect-ratio support, auto-resize text, and new extensibility points.

#### Scriptable Audio Pipeline and Enhanced Audio Foundation

Extend the audio signal chain via Burst-compiled C# units called Scriptable Processors.

#### Editor workflows

Customize the Main Toolbar through a unified API and enjoy faster, more consistent results with the new search backend for improved productivity.

#### Multiplayer Templates and Unity Building Blocks

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

To help you get started adding new features and functionality in Unity 6.3 LTS, we've introduced [Unity Building Blocks](https://discussions.unity.com/t/introducing-unity-building-blocks-production-ready-components-for-faster-setup/1694182), a collection of sample assets with customizable, production-ready components to simplify and accelerate the setup of complex gameplay experiences. Available now on the Unity Asset Store, these building blocks provide robust foundations for common game systems including Achievements, Leaderboards, Multiplayer Sessions, and more.

Coming soon, we're also launching two Unity Building Blocks templates in the Unity Hub: Multiplayer Third-person Gameplay template and a new Multiplayer FPS template, the latter now powered by the same proven netcode stack built for *Survival Kids* in production.

## Download Unity 6.3 LTS today

Unity 6.3 LTS delivers the long-term stability, verified ecosystem, and performance optimizations you need for confident development in production. With two years of dedicated support (three years for Unity Enterprise and Unity Industry users), seamless upgradeability, and proven reliability in real production environments, Unity 6.3 LTS is ready for your next project.

[Download Unity 6.3 LTS](https://unity.com/download) and start building with confidence.

Check out the [Unity 6.3 LTS release notes](https://unity.com/releases/editor/whats-new/6000.3.0#notes) for a comprehensive list of features, and the [Unity Manual](https://docs.unity3d.com/6000.3/Documentation/Manual/index.html) for implementation details and [What's New in Unity 6.3 LTS](https://docs.unity3d.com/Manual/WhatsNewUnity63.html). Join us for our [**Unity 6.3 LTS livestream**](https://www.youtube.com/watch?v=amTgA77p53Q), where our teams will dive deeper into the updates. Questions or feedback? Join the conversation on [Unity Discussions](https://discussions.unity.com/t/unity-6-3-lts-is-now-available/1697328).
