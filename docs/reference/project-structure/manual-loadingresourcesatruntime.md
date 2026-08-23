---
title: "Introduction to the Resources system"
page_title: "Unity - Manual: Introduction to the Resources system"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/LoadingResourcesatRuntime.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/LoadingResourcesatRuntime.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to the Resources system

The Resources system provides a simple way of managing assets in memory. To use the Resources system, you create a folder called `Resources` in your project and add assets to it. During the build process, Unity finds the assets in the `Resources` folder and bundles them into a serialized file with metadata and indexing information. You can then use the [`Resources`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.html) API to load and unload the assets in your application.

However, having the content constantly available at runtime has a [significant performance impact on your project](https://docs.unity3d.com/6000.3/Documentation/Manual/LoadingResourcesatRuntime.html#impact-of-large-asset-sets-on-the-resources-system), especially if it contains a large amount of assets. The [Addressables](https://docs.unity3d.com/Packages/com.unity.addressables@latest) package provides a better way of managing complex sets of assets.

It’s an ideal system for prototyping, or for smaller projects which need assets throughout the lifetime of the application.

## Limitations

The Resources system has the following limitations:

-   Assets in `Resources` folders are always included in the Player build, even if they’re not referenced by anything. This can lead to large build sizes.
-   If you need to make changes to the assets in your project, you need to rebuild and redeploy your entire application, whereas AssetBundles and Addressables allow you to create incremental content updates.
-   It doesn’t support content delivery from a remote server.
-   Assets loaded with `Resources.Load` remain in memory until explicitly unloaded with `Resources.UnloadUnusedAssets`, which unloads all unused assets loaded by `Resources`, or until the scene that used them is unloaded.
-   If you have a lot of assets in the `Resources` folder, then building and starting your application can take a long time.
-   If your code loads an asset by string, but that asset is missing, then `Resources.Load` returns `null` and becomes a runtime error, so you need to manually track which assets are needed.

## Using the Resources system

The `Resources` system can be helpful in the following situations:

-   In smaller projects if the content meets the following criteria:
    -   It’s needed throughout the project’s lifetime.
    -   It’s not memory-intensive.
    -   It doesn’t need patching, or doesn’t vary across platforms and devices.
    -   It’s used for minimal bootstrapping.

Examples of the latter include MonoBehaviour singletons used to host prefabs, or ScriptableObject instances containing third-party configuration data, such as a Facebook App ID.

<span id="impact-of-large-asset-sets-on-the-resources-system"></span>

## Impact of large asset sets on the Resources system

It’s best practice to avoid putting a lot of content into the Resources system for the following reasons:

-   It makes memory management more difficult.
-   Placing a lot of content in the `Resources` folder slows down application startup and the length of builds.
-   The `Resources` system makes it harder to deliver custom content to specific platforms and prevents incremental content upgrades.
-   Making changes to assets in the `Resources` folder requires a player rebuild and redeployment, whereas AssetBundles are better suited for incremental content updates.

If you need to manage content via a CDN, or do regular patch updates, then [AssetBundles](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetBundlesIntro.html) and the Addressables package are the recommended alternative. You can also use [direct references](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-direct-reference.html) if you don’t need the extra control that the Resources system provides.

Unity combines all objects referenced from assets in the `Resources` folder into a single serialized file when you build a project, similar to building one large [AssetBundle](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetBundlesIntro.html). Unity takes time to construct the data structures that index all the objects in the file, and uses memory proportional to the number of objects, even if they aren’t loaded. This has an impact on performance if the number of individual assets in Resource folders are large, or if there are prefabs that contain a lot of objects. For example, initializing a Resources system containing 10 thousand assets takes several seconds on low-end mobile devices, even though most of the objects contained in Resources folders are rarely needed in an application’s first scene.

## Additional resources

-   [Load and unload assets with the Resources system](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-resources-system-load.html)
-   [Addressables](https://docs.unity3d.com/Packages/com.unity.addressables@latest)
-   [Optimizing assets](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-optimizing.html)
-   [AssetBundles](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetBundlesIntro.html)
