---
title: "Unite Seoul 2026 Keynote Recap: Announcing Unity 7"
page_title: "Unite Seoul 2026 Keynote Recap: Announcing Unity 7"
source_url: "https://unity.com/blog/unite-seoul-keynote-2026-recap"
final_url: "https://unity.com/blog/unite-seoul-keynote-2026-recap"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Unite Seoul 2026 Keynote Recap: Announcing Unity 7

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">ADAM SMITH / UNITY TECHNOLOGIES</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Senior Vice President, Product – Engine</span>

<span class="mr-2">Jul 21, 2026</span><span class="mr-2">\|</span><span class="mr-2">14 Min</span>

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Unite Seoul 2026 kicked off a new chapter for Unity. The livestreamed keynote was packed with announcements spanning the Unity Engine, monetization, and collaboration tooling that all build toward the next generation of Unity — [Unity 7](https://unity.com/releases/unity-7).

You can watch the [full presentation](https://www.youtube.com/live/ZTkvearTewE), or read on for an overview of the event’s biggest announcements.

*This post describes features, capabilities, and timing still in development. These reflect our current plans, but actual results and availability could differ materially and are subject to change without notice.*

This content is hosted by a third party provider that does not allow video views without acceptance of Targeting Cookies. Please set your cookie preferences for Targeting Cookies to yes if you wish to view videos from these providers.

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Cookie settings</span>

Welcome to Unite Seoul 2026: Unity CEO Matthew Bromberg sets the stage

Unity CEO and President Matt Bromberg

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Unity CEO and President Matthew Bromberg opened the keynote by pointing to a reel of games built entirely in Korea, framing them as proof of what he called the country’s “Ppalli Ppalli spirit” — not just speed, but a refusal to let studios with a mobile-first ambition experience creative compromise. He was candid about the moment the industry is in, acknowledging “real pain and more than a little anxiety about the future” amid rapid change.

“There has never been a more exciting time to make games,” he said. “the future belongs not to the biggest team, but to those who are able to take control of their destiny by making the technology work for them.”

He then got to the news: developers expecting to hear about continued iterations in the Unity 6 generation got something bigger instead. “A new point release wouldn’t be enough for this moment,” Bromberg said. “Instead of new point release, I’m here today to share something else. And that thing is Unity 7!

He described Unity 7 as a platform rebuilt for a world where “diverse teams of creators and coding agents” work side by side across every part of development — faster (thanks to a CoreCLR-modernized core, near-instant Play Mode, and dynamic reloads that only reload what changed), and more open (with a free MCP, CLI, and API built in). It also extends into monetization and growth, with built-in direct-to-consumer commerce, no-code webshops, and Unity Vector’s AI-driven player matching.

Crucially, he stressed Unity 7 is not a break from Unity 6: “No breaking changes, no new language to learn, none of the traditional upgrade headaches. Unity 7 is a direct continuation of Unity 6.” The Unity 7 Preview launches in December, with full release targeted for Q1 next year and some features arriving earlier in beta. He closed by saying the part he's most excited about “isn’t what we’ve built. It’s what you're going to build with it.”

Inside the Engine: CoreCLR and the push for faster iteration

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Joe Valenzuela from Unity’s engineering team kicked things off with what may be the most consequential technical announcement of the keynote: **Unity will be shipping CoreCLR**, arriving in Unity 7 next year. This brings full access to the modern .NET ecosystem — CoreCLR, .NET 10, and C# 14 — giving developers more expressive, higher-performance code, first-class integration with modern IDEs and official .NET debuggers, and support for MSBuild. That MSBuild support is also a step toward compiling code outside the Editor entirely, which unlocks faster agentic workflows.

The bigger structural change is a new code reload model. Instead of reloading an entire domain on every change, Unity will reload only what’s necessary, cumulatively saving significant time over a project’s life.

Joe Valenzuela announces CoreCLR, coming to Unity 7

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Developers don’t have to wait for Unity 7 to feel some of this speedup. **Fast Enter Play Mode** is becoming the default for new projects in Unity 6.6 and later, dramatically accelerating entry into Play Mode after small changes that used to trigger a full domain reload. Unity shared real internal and external productions’ performance data: Smilegate’s [*LORDNINE: Infinite Class*](https://www.smilegate.com/en/game/lordnine.do) enters Play Mode 2.7 times faster (from 16 seconds down to 6), Unity's own Boat Attack sample loads four times faster (from 4 seconds down to 1), and Funday Games and Ghost Ship Publishing’s [*Deep Rock Galactic: Survivo*r](https://store.steampowered.com/app/2321470/Deep_Rock_Galactic_Survivor/) has seen a 4.7x improvement (from 14 seconds down to 3).

To ease the transition to CoreCLR, Unity has already tested compatibility with the 68 most popular Asset Store packages (with more being added), published an [upgrade guide](https://discussions.unity.com/t/path-to-coreclr-2026-upgrade-guide/1714279), and integrated **Project Auditor** into Unity 6 so developers can identify compatibility issues in their own projects today. Unity is inviting early adopters to test and share feedback [via Discussions](https://discussions.unity.com/t/path-to-coreclr-2026-upgrade-guide/1714279) and its bug tracker ahead of the Unity 7 release.

Graphics: Real-time global illumination, a new 2D toolset, and Neural Rendering in Unity 7

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Charles Sanglimsuwan, who heads Unity’s Graphics Engineering teams, walked through a wave of rendering upgrades, framed by a real production example: LINE Games’s upcoming roguelike [***Ember and Blade***](https://store.steampowered.com/app/3470500/Ember_and_Blade/), which used Shader Graph for custom cel-shading, VFX Graph for higher particle counts, and Addressables. LINE Games Executive Producer Jubok Kim joined him onstage to talk about how the studio used this tech.

Charles Sanglimsuwan shows upcoming graphics features in Mecha Hangar, by Sakura Rabbit

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Moving on, Sanglimsuwan offered a peek at the latest graphics tech. The headline new feature here is **Surface Cache GI**, a first look at fully dynamic global illumination built for the Universal Render Pipeline (URP). Unity demoed it live using the Mecha Repair Hangar scene from solo dev **Sakura Rabbit** — a lighting-heavy environment that would normally take hours of lightmap and probe baking to get right. With Surface Cache GI, indirect lighting updates instantly and in real time, with no baking required, and the system fully supports dynamic geometry: the demo showed a car and objects moving through the scene with lighting responding naturally, plus a full day/night cycle with sunlight bouncing into the hangar as it shifted. It's designed to scale from high-end PCs with hardware ray tracing down to mobile — Unity ran the same complex scene on a Samsung Galaxy S26 at full resolution, holding a steady 60fps. Surface Cache GI can also be combined with **Screen Space Reflections** and **Ground Truth Ambient Occlusion (GTAO)** for richer surface detail. All three are previewable in the 6.7 alpha today and will reach broad availability with Unity 6.7 LTS.

Unity is adding support for Microsoft’s DirectX Shader Compiler (DXC), letting developers compile shaders with DXC for DX12 in Unity 6.6, unlocking newer HLSL and Shader Model 6 features, with Vulkan on Android, WebGPU, and console support planned. New **Shader Build Settings** give per-platform control over shader compilation, and a new **Fast Build Profile** arriving in Unity 6.7 can cut shader build times by up to 90%, alongside PSO tracing and warm-up to reduce runtime stutter. **WebGPU** is now production-ready in Unity 6.6, with full URP compatibility, compute shaders, and indirect rendering support. And on mobile, Unity is extending on-tile post-processing through Metal and Vulkan and introducing a new Tile-Only mode for more predictable performance and lower power draw.

Bunny Blitz 2D sample

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Rus Scammell then highlighted Unity's 2D momentum, citing the new sample game **Bunny Blitz**, which showcases the new 3D as 2D workflows, allowing 2D games to seamlessly integrate 3D characters and elements, based on this sample. He showcased the multi-threaded **Physics Core 2D** (built on Box2D v3) and new **RenderSprite APIs** that render thousands of sprites without GameObject overhead while staying compatible with 2D lights, Sprite Masks, and the SRP Batcher — holding a stable 60fps, even on older mobile devices. A new 2D profiler was also added to track sprite render counts and atlas usage. Bunny Blitz is [available now](https://assetstore.unity.com/packages/templates/tutorials/bunny-blitz-2d-and-3d-sample-project-393078) on the Asset Store.

Closing out the graphics segment, Sanglimsuwan returned to the stage to announce **Unity Neural**, a new class of technologies that bring neural inference into the compute pipeline via URP. This includes an upgraded Upscaler Framework (with partner neural upscalers), and **Neural Texture Compression (NTC)**, which uses a trained model to compress textures near-losslessly — Unity showed texture runtime memory cut by over 50% and disk size reduced by about 70% with no visible quality loss. Neural inference runs entirely on-device through an upgraded Sentis (Unity’s inference engine), with no server round-trips. Unity Neural begins rolling out in Unity 6.7, with more to come in Unity 7.

Platform reach: A new partnership, XR devices, and a first look at Unity inside Unreal

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Meta’s Director of Product Jamie Keane came onstage to detail a deepening Unity-Meta partnership aimed at making Quest/VR development faster to learn and build for. AI-assisted workflows — accessible from the Unity Editor, a preferred code editor, or an AI-native flow — can now help with project setup, platform configuration, input systems, automated testing, and performance optimization, letting developers move from intent ("make this object grabbable") straight to testable action. The segment covered AI-guided project setup, adding hand or controller input, performance trace capture and optimization, and automated scene validation. Developers can explore these tools via Meta's Quest Agentic Tools, including the Meta VR CLI and Meta XR Operator.

Next, Unity’s James Stone discussed a few new additions to Unity’s unparalleled platform reach. Last month, Unity [announced support for **XREAL AURA**](https://unity.com/blog/unity-android-xr-wired-glasses-support), the newest device in Google's Android XR ecosystem and Unity's first support for wired XR glasses, using the same Android XR workflows developers already know and supporting a single build across supported Android XR devices. Resolution Games was one of the earliest studios to bring their game *Demeo* to Samsung's Galaxy XR and then ported to XREAL AURA with only minor adjustments. As the XR industry embraces hand-tracked experiences over controller-based ones, updates to XR Hands are helping developers make the transition.

The bigger platform reveal was the first public technical demo of the Unity–Epic Games partnership [announced at Unite Barcelona](https://www.youtube.com/watch?v=MXsKt7JqX5M): **a Unity game rendering natively inside Unreal Engine.** A live demo showed the [Fantasy Kingdom sample](https://unity.com/demos/fantasy-kingdom) simulated in Unity and rendered in real-time by Unreal, with physics, lighting, and input synchronized between engines via a client-server protocol called PolySpatial, which also supports multiplayer as a first-class feature. Unity's team also showed in Editor examples spanning competitive, casual, social, and narrative genres, all currently running in Unreal. Developers can fill out an interest form for early access consideration in 2027.

Grow your game: Unity Vector's next phase focused on creatives and agentic capabilities

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

SVP of Applied Science Sean Sheng detailed the growth of **Unity Vector**, the AI foundation behind Unity Ads. With over 70% of the top 1,000 mobile games built on the Unity Engine\*, Unity Vector has unique visibility into gameworld context, player behavior, and advertiser intent to match the right players to the right games.

Sean Sheng shares Unity Vector updates onstage at Unite Seoul

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Looking ahead, Sheng announced plans to support a **new end-to-end AI creative workflow**: a centralized creative library, AI creative generation, dynamic creative optimization, and creative insights, designed to turn ad creative into a measurable growth lever rather than a manual bottleneck. Unity is also bringing agentic tools to Unity Ads later this year: **Unity Ads MCP**, which connects Unity Ads directly to AI tools so developers can manage campaigns, budgets, bids, and creatives through natural language, and **Campaign Assistant**, a conversational AI agent launching in Unity Ads that can proactively diagnose performance issues (like a spend drop) and recommend fixes from just a single prompt.

IAP SDK 5.4: Native Direct-to-Consumer Commerce Comes to Unity

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Senior Technical Product Manager Eli Bork introduced Unity's push into direct-to-consumer (D2C) commerce, framed by recent app store policy changes that are opening up previously "walled garden" purchase flows. D2C in mobile gaming is [already a $17 billion market](https://gamesbeat.com/new-research-shows-direct-to-consumer-is-already-a-12bn-market-in-mobile-gaming-and-the-rest-of-the-app-economy-is-set-to-follow-exclusive/) — about 15% of global mobile IAP — and growing.

Eli Bork describes new features in Unity IAP 5.4 SDK

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

**D2C commerce is now available** with the release of Unity IAP SDK 5.4, available now in the Package Manager, which lets developers sell directly to players in two ways: through in-game checkout flows using a web payment layer instead of app store billing, and through a branded webshop using a new **free, no-code webshop builder**, with an AI chatbot to easily help you restyle your webshop for seasonal or thematic changes. Unity is launching with Stripe and Coda as payment providers (Stash coming soon) to handle payments, compliance, and fraud detection, alongside a unified commerce management layer — one shared catalog, combined reporting, and routing rules to manage both on-platform IAP and off-platform D2C commerce, all from one SDK and dashboard.

Notably, building a D2C channel and the purchase data collected through the IAP SDK can help enrich Unity Vector models to find future players, not just monetize existing ones. All of this is available now with no extra fees charged by Unity, and an AI skill is available for both Unity's AI assistant and third-party AI tools to help install and upgrade to the latest SDK version.

Real-time 3D collaboration with Unity Studio

Sarah Lash outlines Unity's solutions for Industry at Unite Seoul 2026

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

SVP and GM of Industry Sarah Lash shifted focus to Unity's work outside of games, highlighting how immersive 3D collaboration is opening up creation to non-developers across manufacturing, healthcare, retail, and other industries. Unity's browser-based **Studio** editor, launched earlier this year, now supports real-time multi-user collaboration - an entire team working inside the same 3D scene at the same time. Lash and Senior Manager Kunwoo Chang demonstrated it live: Chang joined Lash’s scene from a shared link and placed a new asset that appeared instantly in her view, then invited teammates who joined one by one - adding assets, changing materials, and moving objects in the shared scene in real time, Lash jumped between collaborators’ camera views, and published the updated experience - all without leaving the browser. Unity is also building deeper two-way sync between Studio and the Unity Editor, plus AI-assisted tools to move faster from early concepts to production.

On the infrastructure side, **Asset Manager** — included with Studio and the foundation for governing 3D assets across the organization —— now has an option for **Self-Hosted Cloud**, letting organizations connect directly to AWS or Azure (or a customized partner setup) while keeping control over their own infrastructure and data. Unity also announced **Pipeline Automation**, built on an API compute layer that automatically pulls assets from PLM systems, transforms and optimizes them, and delivers them to live 3D applications on any device — supporting use cases from engineering reviews for immersive HMI concepting, or technician training, aircraft and automotive configurators, or transforming factory data visualization — just to name a few.

Production pipelines and CLI: Opening the Editor to everyone

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

VP of Technical Product Management Jason Mann made the case that a game isn't built in the Editor alone — artists, designers, producers, and AI agents all work in their own tools, and every change historically had to funnel back through the Editor before anyone could see results. Unity's answer is a new API and set of services that open a Unity production to the tools and roles around it, without requiring full Editor access.

In a live demo, the team showed a broken texture flagged directly in the Editor and tagged to an artist; the artist fixed and re-uploaded the asset from a web dashboard using a new **Scene Preview** feature that renders the asset in full in-game context (lighting, shaders, animation) inside a browser; the change was then checked in to version control. [**Unity CLI**](https://unity.com/blog/meet-the-unity-cli) was used to validate the asset against project standards and push updated content bundles straight to a Nintendo Switch 2 running the game live, with no Editor round-trip required.  

Unity's new CLI and collaboration pipeline were demoed onstage at Unite Seoul

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Unity confirmed the **Unity CLI and Unity MCP server will be made broadly available to everyone, free and without subscription.** Pieces of this workflow — a web dashboard, Unity CLI, project-level role-based access control, web uploads, and deep linking — are now in **closed beta**, open for teams to apply today, with read/write project APIs, in-Editor annotations, RBAC, and Perforce integration scheduled for a second beta and general availability later this year. The workflow works on Unity 6 and up, ahead of full realization in Unity 7.

Wrap-Up: Unity 7 and what comes next

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

To wrap the keynote, I talked about how everything we’d shared was part of a single throughline: closing the gap between having an idea for a game and getting it running in players' hands. I reminded that **Unity 7** will be a continuation of the Unity 6 release line rather than a break from it, meaning you can adopt it without fear of breaking changes to workflows you already depend on.

Before ending the presentation, I handed the stage to Will Goldstone for one final surprise: a live demo of **live code iteration on device** — a capability Goldstone said developers have been requesting “for years.” He framed the problem simply: testing a code change on-device has traditionally meant recompiling the game and redeploying it, eating into development time on every single tweak. He moved fluidly back and forth between his project and a mobile phone, with code changes reflected live in-game in near real-time, without a rebuild or redeploy cycle in between. It was a fitting closer for a keynote built around protecting developers’ flow state — cutting out one of the last remaining waits between an idea and seeing it work.  
  
This let me circle back to the broader shift underway: the Unity Editor remains the foundation for advanced production, but a new collaborative layer is forming around it — one where whole teams, coding agents, and even first-time creators with no coding background can contribute to a game in progress.

That's a lot of exciting announcements from Unite Seoul 2026 — and there's more to come. As these features move through preview and beta, we'll keep sharing updates as we get closer to the launch of Unity 7.

Here's where you can dig into everything announced at the keynote:

-   [Share your feedback on our path to CoreCLR](https://discussions.unity.com/t/path-to-coreclr-2026-upgrade-guide/1714279)
-   [Check out LINE Games’s *Ember & Blade* on Steam](https://store.steampowered.com/app/3470500/Ember_and_Blade/)
-   [Download Bunny Blitz on the Asset Store](https://assetstore.unity.com/packages/templates/tutorials/bunny-blitz-2d-and-3d-sample-project-393078)
-   [Start building with Meta VR CLI, Meta XR Operator, an Unity-connected AI workflows for Quest](https://github.com/meta-quest/agentic-tools)
-   [Fill out our interest form for early access consideration for running your Unity game in *Fortnite*](https://create.unity.com/unity-on-fortnite-unreal-interest-form)
-   [Sign up for our closed beta for Unity pipeline and CLI](https://unity.com/features/unity-production-pipeline)
-   [Check out *Survival Kids* on Nintendo Switch 2](https://www.konami.com/games/survival_kids/)
