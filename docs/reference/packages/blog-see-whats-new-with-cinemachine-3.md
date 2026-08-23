---
title: "See what's new with Cinemachine 3"
page_title: "See what’s new with Cinemachine 3"
source_url: "https://unity.com/blog/engine-platform/see-whats-new-with-cinemachine-3"
final_url: "https://unity.com/blog/engine-platform/see-whats-new-with-cinemachine-3"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# See what’s new with Cinemachine 3

<a href="https://unity.com/blog" class="text-xxs mt-8 flex items-center font-bold uppercase hover:underline"><span class="ml-1">Unity Blog</span></a>

# See what’s new with Cinemachine 3

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">ALICE GARDNER / UNITY</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Content Marketing Manager</span>

<span class="mr-2">Mar 27, 2023</span><span class="mr-2">\|</span><span class="mr-2">6 Min</span>

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

[Cinemachine](https://unity.com/unity/features/editor/art-and-design/cinemachine) needs no introduction. One of the most downloaded tools in Unity, Cinemachine is a suite of tools for creating complex real-time camera shots with codeless cameras, used for game cinematics and other linear production work.

We are constantly iterating to improve its functionality, and we also receive helpful feedback from our users with requests for updates. All of which has led to our latest release: Cinemachine 3. Cinemachine 3 is compatible with minimum version 2022.3. It will be official from 6000.0.

Why it’s time for Cinemachine 3

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Originally acquired, Cinemachine has been part of Unity for five years. In the beginning, it didn’t fit neatly into existing Unity frameworks and processes. As Unity evolved and focused on things like ongoing UI development, Cinemachine hasn’t always been top of mind.

In this release, we’ve taken a step back and redesigned the way some things are done in Cinemachine. The Cinemachine 3 upgrade is not so much a feature update as it is a change of format – bringing it in line with the rest of Unity.

GIF of the Cinemachine Spline Dolly

What developers need to know before upgrading

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Not everybody using Cinemachine needs to upgrade. But if you’re starting a project in Unity Editor 6000.0, you’ll have Cinemachine 3 by default.

**Please note:** Before upgrading to Cinemachine 3, check if you have custom scripts that make significant use of the Cinemachine API. If so, it may be better to stick with previous versions. And, although we provide a tool to convert project data, there is currently no automated way to migrate code. The Unity API updater can’t take care of all the API changes, so this will require a manual upgrade.

If you are using Cinemachine “out of the box” without any custom scripting, the upgrade process will be relatively easy.

Name changes in Cinemachine 3

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

To help make Cinemachine 3 clearer and easier to use, we’ve changed and standardized some of the names. For example, since Unity has another product called Virtual Camera, the virtual camera in Cinemachine is now known as CinemachineCamera. Check out this [informative video](https://www.youtube.com/watch?v=znOii5cz0RU&list=PLX2vGYjWbI0TXyj79RTqMuhUP9mWIejF5) for more details on these name changes.

An overview of what’s new

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

-   No more hidden game objects
-   Works better with prefabs and presets
-   Improved integration with Unity standards
-   API now more consistent with Unity
-   A cleaner, simpler UX
-   Streamlined workflows
-   Integration with Unity splines
-   More opportunities for customization
-   Complete overhaul of sample scenes

No more hidden game objects

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Cinemachine was previously implemented using hidden game objects that held behaviors responsible for things like controlling the position of the camera. This necessitated a complex API to get these objects, animate them, and access them from your scripts. This has been cleaned up and become more standardized.

Works better with prefabs and presets

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Since hidden game objects have been removed, Cinemachine is more compatible with prefabs and presets.

Improved integration with Unity standards

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Cinemachine was originally written using its own standard for member variable names. This was something we received a lot of feedback on (and something we didn’t like either). So, we removed all those instances of m\_.

API now more consistent with Unity

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The procedural components are now standard MonoBehaviours added to the GameObject in the usual manner, so you don’t need any special API calls to access them.

A cleaner, simpler UX

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The giant inspectors are gone. Now the UX is distributed across the new Cinemachine procedural components. Many settings are opt-in, so if you don’t need them, they don’t clutter the inspectors.

The new Cinemachine 3 UX

Streamlined workflows

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

By default, there is one Tracking Target, not two, so there are fewer things to set up. The FreeLook has also been completely overhauled; it does more, and fewer settings are required. It also now supports radius scaling out of the box, via the new Orbital Follow behavior.

Camera settings that require user input are now driven by a separate component which supports both old and new input systems. A new Cinemachine Channel setting simplifies the implementation of split-screen and frees you from using Unity layers.

The Cinemachine 3 FreeLook feature

Integration with Unity splines

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The Cinemachine spline implementation has been deprecated and replaced by an integration with the new Unity native splines.

More opportunities for customization

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

-   ClearShot can now receive a custom shot quality evaluator
-   Spline Dolly and Spline Cart can now receive custom AutoDolly implementations
-   FreeLook can receive custom modifiers for vertical camera movement
-   It’s now easier to write custom input axis controllers

Complete overhaul of sample scenes

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

All of the sample scenes in Cinemachine 3 have been redone from scratch.

Learn more

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

For an in-depth look at Cinemachine 3, head over to the [Unity YouTube channel](https://www.youtube.com/watch?v=znOii5cz0RU&list=PLX2vGYjWbI0TXyj79RTqMuhUP9mWIejF5) to learn more from our in-house expert, Gregory Labute.
