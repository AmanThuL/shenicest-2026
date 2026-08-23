---
title: "Unity 6 Optimization Guides for console, PC, mobile, web and XR"
page_title: "Unity 6 Optimization Guides for console, PC, mobile, web and XR"
source_url: "https://unity.com/blog/unity-6-game-optimization-guides"
final_url: "https://unity.com/blog/unity-6-game-optimization-guides"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Unity 6 Optimization Guides for console, PC, mobile, web and XR

<a href="https://unity.com/blog" class="text-xxs mt-8 flex items-center font-bold uppercase hover:underline"><span class="ml-1">Unity Blog</span></a>

# Get hundreds of tips from new Unity 6 optimization guides for console, PC, mobile, web, and XR

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">THOMAS KROGH-JACOBSEN / UNITY TECHNOLOGIES</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Senior Technical Content Marketing Manager</span>

<span class="mr-2">Nov 11, 2024</span>

Programming and DevOps

XR

Testing and performance

Target platforms

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Back in 2021, I started to write a blog post on performance optimization tips. As I did research for it, with help from an expert team of Unity support engineers (who assist both small and large game studios), it became clear that a single blog post wouldn’t suffice. Instead, we ended up creating two optimization e-books, both close to 80 pages: One for mobile games, and one for PC and consoles.

I'm excited to announce the third edition of these two e-books, now updated for [Unity 6](https://unity.com/releases/unity-6). As with previous editions, the two guides consolidate valuable knowledge and advice from Unity engineers who have collaborated with developers across the industry to help them create exceptional games. The new editions include tips on how to use Unity 6 features to enhance your performance toolkit, and platform-specific advice for developers working on [web](https://unity.com/solutions/web) and [XR games](https://unity.com/solutions/xr).

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The idea with the very first edition was to share a list of actionable tips and advice on how you can optimize your game to run smoothly on as many devices as possible while providing players with the best experience. Since then, we received even more tips from both the community and original contributors.

While the process of identifying performance bottlenecks is very similar across all platforms and a lot of the general recommendations also apply for all platforms, there are also some key differences in approaches, project scope and choice of rendering and asset pipeline.

Let’s take a brief look at what’s new in each e-book, as well as recently published video tutorials on the Unity Profiler, one of the most important tool sets you’ll use for optimizing the performance of your Unity projects.

Optimize your game performance for mobile, XR, and the web in Unity (Unity 6 edition)

Pages from the 'Optimize your game performance for mobile, XR, and the web in Unity (Unity 6 edition)' e-book

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

In the latest edition of this e-book, we've expanded the scope from focusing on mobile to also include XR and web-specific tips. This includes advice on input handling in XR, leveraging the WebAssembly 2023 feature set for better performance, and using tools like Chrome DevTools for profiling Unity Web builds.

This guide also mainly focuses on projects using the Universal Render Pipeline (URP) where our PC/console guide is dedicated mainly to providing tips for projects based on the High Definition Render Pipeline (HDRP). In total, you will find around 100 pages of tips that will be useful to both new and experienced mobile game developers.

Get the latest tips for mobile, XR, and the web in Unity 6

<a href="https://unity.com/resources/mobile-xr-web-game-performance-optimization-unity-6" class="cursor-pointer inline-block items-center outline-hidden overflow-x-hidden btn-primary btn-md caption-sm-bold px-3 py-2.5 inline-flex rounded-full btn-arrow"></a>

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Download the latest e-book</span>

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

To accompany this e-book, we also created an in-depth, 40-minute video tutorial that covers key techniques to enhance your game’s performance and ensure a smooth experience for every player. In the tutorial, we demonstrate how to profile a non-optimized VR game built in Unity 6 using URP and the XR Interaction Toolkit. We identify bottlenecks and then address the issues using a selection of tips from the e-books. The idea is to provide you with a practical example showing one of the many ways to improve performance using the techniques covered in the e-book.

This content is hosted by a third party provider that does not allow video views without acceptance of Targeting Cookies. Please set your cookie preferences for Targeting Cookies to yes if you wish to view videos from these providers.

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Cookie settings</span>

Optimize your game performance for consoles and PCs in Unity (Unity 6 edition)

Pages from the 'Optimize your game performance for consoles and PCs in Unity (Unity 6 edition)' e-book

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Our PC and [console](https://unity.com/solutions/console) optimization guide shares many tips and tricks with the mobile, VR, and web guide. However, in this guide, you will find more specific information about HDRP, and we dive into the complexities that come with optimizing large-scale projects, from assets to code architecture and rendering.

In the new edition, we added several more general tips, but we also provide an overview of some of the new Unity 6-specific optimization features you can consider leveraging, such as Adaptive Probe Volumes, GPU Resident Drawer for managing draw calls, and GPU Occlusion Culling, which pushes the occlusion calculations to the GPU.

Get the latest tips for performance optimization for consoles and PCs

<a href="https://unity.com/resources/console-pc-game-performance-optimization-unity-6" class="cursor-pointer inline-block items-center outline-hidden overflow-x-hidden btn-primary btn-md caption-sm-bold px-3 py-2.5 inline-flex rounded-full btn-arrow"></a>

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Download the latest e-book</span>

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We hope you find these updated optimization e-books helpful in your day-to-day work!

Know your profiling tools

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

You can find more updated guides and sample projects on the [Unity 6 Resources Hub](https://unity.com/campaign/unity-6-resources), the [how-to best practices hub](https://unity.com/how-to), or [the Advanced best practice guides on Unity Docs](https://docs.unity3d.com/Manual/best-practice-guides.html).

To wrap things up, I want to highlight three video tutorials we recently launched. These resources might be helpful if you're new to Unity or simply need a refresher on the suite of profiling tools available. The [Unity Profiler](https://docs.unity3d.com/2022.3/Documentation/Manual/Profiler.html) is where you want to kick off your optimization process and will likely spend most of your time. It measures the performance of the Unity Editor, your application in Play mode, and connects to the device running your application in Development mode. 

This content is hosted by a third party provider that does not allow video views without acceptance of Targeting Cookies. Please set your cookie preferences for Targeting Cookies to yes if you wish to view videos from these providers.

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Cookie settings</span>

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

As the name implies, the Unity [Memory Profiler](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@latest) provides insights into memory performance, helping you identify where you can reduce memory usage in various parts of your project and within the Editor. It allows you to test against hardware memory constraints and enhance CPU/GPU performance by strategically managing memory usage.

This content is hosted by a third party provider that does not allow video views without acceptance of Targeting Cookies. Please set your cookie preferences for Targeting Cookies to yes if you wish to view videos from these providers.

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Cookie settings</span>

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Finally we have a tutorial for the [Profile Analyzer](https://docs.unity3d.com/Packages/com.unity.performance.profile-analyzer@latest), which aggregates and visualizes both frame and marker data from a set of Unity Profiler frames to help you examine their behavior over many frames (complementing the single-frame analysis already available in the Unity Profiler). It also allows you to compare two profiling datasets to determine how your changes impact the application’s performance.

This content is hosted by a third party provider that does not allow video views without acceptance of Targeting Cookies. Please set your cookie preferences for Targeting Cookies to yes if you wish to view videos from these providers.

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Cookie settings</span>

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

I hope our new optimization e-books and additional profiling resources help you develop your multiplatform games as efficiently as possible with Unity 6.

Recommended resources

## Check out the latest technical e-books updated for Unity 6

[](https://unity.com/resources/introduction-to-urp-advanced-creators-unity-6)

E-book

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Read More</span>

### Introduction to URP for advanced creators (Unity 6 edition)

2024-10-17

[](https://unity.com/resources/best-practices-version-control-unity-6)

E-book

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Read More</span>

### Best practices for project organization and version control (Unity 6 edition)

2024-10-17

[](https://unity.com/resources/console-pc-game-performance-optimization-unity-6)

E-book

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Read More</span>

### Optimize your game performance for consoles and PCs in Unity (Unity 6 edition)

2024-10-17

[](https://unity.com/resources/mobile-xr-web-game-performance-optimization-unity-6)

E-book

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Read More</span>

### Optimize your game performance for mobile, XR, and the web in Unity (Unity 6 edition)

2024-10-17
