---
title: "What's Next: Unity Engine 2025 Roadmap"
page_title: "What’s Next: Unity Engine 2025 Roadmap"
source_url: "https://unity.com/blog/unity-engine-2025-roadmap"
final_url: "https://unity.com/blog/unity-engine-2025-roadmap"
topic: "unity6-release"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# What’s Next: Unity Engine 2025 Roadmap

Event

# What’s next: A look at Unity’s 2025 roadmap

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">ADAM SMITH / UNITY TECHNOLOGIES</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Senior Vice President, Product – Engine</span>

<span class="mr-2">Mar 19, 2025</span><span class="mr-2">\|</span><span class="mr-2">6:24 Min</span>

Programming and DevOps

Game design

Testing and performance

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

At this year’s Game Developers Conference (GDC), we shared an overview of the [Unity Engine](https://unity.com/products/unity-engine) roadmap for 2025. We highlighted our commitment to making Unity more stable and production-tested for game development and live operation for all users. We also provided clarity on how Unity 6.0 will be supported, a preview of what’s coming in Unity 6.1, and a look ahead to what’s next.

Catch up on the key points here, or watch the full session below for more details.

This content is hosted by a third party provider that does not allow video views without acceptance of Targeting Cookies. Please set your cookie preferences for Targeting Cookies to yes if you wish to view videos from these providers.

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Cookie settings</span>

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

### Building for stability, reach, and performance

As the nature of game development evolves, we’re making targeted improvements to ensure the Unity Editor experience is performant and stable and that your creative output can reach the widest possible device range across the most-supported platforms, with the best performance.

Unity has always been about creating tools that enable you to bring your ideas to life and maximize your player reach – whether they’re on mobile, console, desktop, or the latest XR devices. Continued investment in these areas allows you to build the largest global audience of passionate players possible, while providing them with the widest variety of game genres and graphical styles.

At the Unity Dev Summit at GDC, we heard from multiple game studios on how they are doing just that. Scopely shared how they used Unity to expand their mobile-first battle royale game [*Stumble Guys*](https://www.stumbleguys.com/) to new platforms, becoming one of the top F2P console games released in 2024. Metacore spoke about leveraging Unity to deliver player-first monetization, blending IAP and in-game ads to create a thriving free-to-play experience for their hit mobile game *[Merge Mansion](https://mergemansion.com/).* We heard from Kinetic Games about the core mechanics and AI-driven behavior system behind their popular multiplayer ghost-hunting game, [*Phasmophobia*](https://www.kineticgames.co.uk/phasmophobia).

The work we’re doing in 2025 will expand our platform reach and improve Engine performance and stability for games across genres and devices.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

**Production Verification: Testing our technology in live productions**  

We’ve heard one piece of feedback from our community consistently: Developers need tools that are production-tested. It’s one thing to test features internally, but it’s another to validate them in live, real-world projects that handle production-scale demands. That’s why we’ve launched Production Verification, a new internal program where Unity works alongside developers to test our tools in real production environments.

We’ve worked closely with studios building games across different genres and platforms to validate Unity 6 features in the field. These teams are using the latest versions of Unity, and in some projects, we’re acting as co-developers to directly embed our engineers in their production teams.

For example, we are working with 10 Chambers to validate Engine graphics improvements in their upcoming co-op FPS heist game, [*Den of Wolves*](https://www.denofwolves.com/en). Kinetic Games has helped us validate improvements in live operations tools – like Remote Config, Leaderboards, and Build Automation – in [*Phasmophobia*](https://www.kineticgames.co.uk/phasmophobia). We’re also working closely with Litesport and TRIPP to validate readiness of new platforms like Android XR.

Testing Unity in complex production environments allows us to identify performance bottlenecks, stability issues, and usability pain points that wouldn’t show up in isolated tests. Those findings directly influence what we deliver to you in Unity 6.0 and beyond, making the Engine more stable and reliable for all developers.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

### How will Unity 6.0 be supported?

While we look forward to delivering new, production-verified features with Unity 6.1, we also recognize the benefits that the Long Term Support (LTS) model has provided, especially for projects requiring extended stability. Unity 6.0 is supported with two-year LTS, starting from when it was released on October 17, 2024, with an additional year of support for Unity Enterprise and Unity Industry users. We will continue to apply fixes to Unity 6.0 to ensure you have a stable version you can rely on for a long time.

For previous LTS versions, support will remain the same. Here’s a recap:

-   **Unity 2021 LTS**: Currently supported for Unity Enterprise and Unity Industry customers through October 2025
-   **Unity 2022 LTS**: Fully supported through May 2025. Unity Enterprise and Unity Industry customers receive an additional year of support.
-   **Unity 6.0**: Fully supported through October 2026. Unity Enterprise and Unity Industry customers receive an additional year of support.

Unity 6 marks a new era for Unity, combining the stability of LTS with the flexibility to deliver new features more frequently with Update releases.

We’re also investing in improved compatibility between versions. Upgrading to the next Update release or LTS should now be easier and less time-consuming, helping you keep your tools up to date with fewer headaches.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

### Shipping Unity 6.1 in April 2025

Unity 6.1 builds on the stability and performance shipped in Unity 6.0 to enable you to deliver to more platforms, with better visuals, more efficiently. Here are some highlights coming in this next Update release:

**Performance**

-   **Deferred+** - Build richer worlds with the Universal Render Pipeline’s (URP) new deferred rendering path that accelerates GPU performance using advanced Cluster-based light culling for more lights, and with support for GPU Resident Drawer for more objects.
-   **Variable Rate Shading** - Improve GPU performance with minimal impact to visuals. Set the shading rate of custom passes within URP/HDRP, and generate Shading Rate Images (SRIs) from textures and shaders.
-   **Project Auditor for static analysis -** Analyze scripts, assets, project settings and builds. Learn how to resolve issues and optimize the quality and performance of your game.

**Platforms**

-   **Large screens and foldables** - Access enhanced support for large screens and foldables with the latest Android APIs
-   **Unity Web** - Run your Unity games anywhere the web exists, including mobile browsers. Experiment with the latest WebGPU graphics API integration and unlock compute acceleration for web browsers
-   **Android XR** **and Meta Quest** - Save time and streamline the build process with the ability to create multiple build configurations for release and development builds
-   **Instant Games on Facebook and Messenger** - Streamline building, optimizing, and uploading instant games to Facebook and Messenger
-   **PC and console** - Improve CPU performance, PSO caching, and ray tracing with enhanced DirectX 12 support

These updates are powered by the insights we’ve gained from Production Verification. With each release, we’re iterating faster and delivering tools that perform better in real-world scenarios.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

### Looking ahead

Unity is built around a clear focus in 2025: providing you with a performant, optimized, and stable engine that helps you succeed on any platform. Whether you’re a solo developer or a large studio, the Unity Engine is designed to support the unique challenges of modern game development – whether that’s reaching a global audience, optimizing performance, operating a live service game, or shipping on tomorrow’s hardware.

Here’s a small glimpse of what we’re working on bringing to you this year beyond Unity 6.1:

-   **AI assistance and asset generators** - Deeper integration in the Unity Editor workflows to improve productivity, more advanced code generation, and the ability to automate repetitive tasks
-   **Project Center** - Guided experimentation with reliable first-party and third-party tools, services, and features from the Unity ecosystem tailored to your vision
-   **Swappable physics backend** - Simple switching of physics engines through Project Settings

But we aren’t stopping there. We’re investing in several initiatives to update our Engine foundations with support for CoreCLR. We are modernizing Unity’s content pipeline, unlocking a step change in iteration time. We will also preview a new animation system with improved tools and workflows, including procedural and runtime rigging for all skeletal asset types, and a new, powerful hierarchical state machine built to handle thousands of states, blend graphs and transitions. We look forward to sharing more with you as we make progress on these initiatives in the future.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We’re excited about this next chapter and can’t wait to see what you’ll create. As always, thank you for your feedback and collaboration – it’s critical to everything we do. Join the [Unity Discussions](https://discussions.unity.com/t/a-look-at-unity-s-roadmap-gdc-2025/1615217) forum to share your thoughts, ask questions, and stay connected.
