---
title: "Introduction to runtime asset management"
page_title: "Unity - Manual: Introduction to runtime asset management"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/assets-managing-introduction.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/assets-managing-introduction.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to runtime asset management

How you load and manage assets in your project impacts on your application’s memory usage, load times, and build size. Unity provides several asset management systems, each designed for specific use cases and project sizes. Small applications with fixed content sizes can usually use Unity’s [default asset management system](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-managing-introduction.html#direct-references). Systems like [AssetBundles](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-managing-introduction.html#assetbundle-system) and [Addressables](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-managing-introduction.html#addressables-package) provide better management for complex asset layouts, or applications that need to stream assets from remote servers.

## Effect of runtime asset management on builds

By default, Unity uses the [Scene List](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profile-scene-list.html) to determine which scenes and assets to include in a build and their load order. Unity only includes scenes in the Scene List in a build, and unused scenes and assets not referenced from these scenes are excluded from a build. You can also use the [`SceneManager` API](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.html) to determine how to load scenes in your project.

The exception to this is if you include any scenes in a [Resources folder](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-managing-introduction.html#resources-system), or mark them as [Addressable](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-managing-introduction.html#addressables-package), then Unity handles scenes differently.

To determine what content to build, Unity uses the following information:

-   Scenes included in the [Scene List](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profile-scene-list.html).
-   Any [Preferences](https://docs.unity3d.com/6000.3/Documentation/Manual/Preferences.html) that affect building.
-   Any assets [directly referenced](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-managing-introduction.html#direct-references).
-   If you use the [Resources system](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-managing-introduction.html#resources-system), Unity includes any assets in the `Resources` folder.
-   If you use [AssetBundles](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-managing-introduction.html#assetbundle-system), Unity includes any assets and scenes assigned to an AssetBundle, plus any direct references from those assets or scenes.
-   If you use [Addressables](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-managing-introduction.html#addressables-package), Unity includes any assets and scenes assigned to an Addressable group, plus any direct references from those assets or scenes.

## Runtime asset management options

Choosing the right approach depends on factors like your target platform, content delivery requirements, and whether you need dynamic loading capabilities. The following management systems are available:

| **System**                                                                                                  | **Remote/CDN delivery** | **Incremental updates** | **Automatic dependencies** | **Dynamic load/unload**        | **Best suited for**                                                                                          |
|:------------------------------------------------------------------------------------------------------------|:------------------------|:------------------------|:---------------------------|:-------------------------------|:-------------------------------------------------------------------------------------------------------------|
| **[Direct references](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-direct-reference.html)**  | No                      | No                      | Yes                        | No                             | Small applications with fixed content built into the Player.                                                 |
| **[Resources system](https://docs.unity3d.com/6000.3/Documentation/Manual/LoadingResourcesatRuntime.html)** | No                      | No                      | Yes                        | Yes (no per-asset unload)      | Prototypes and small projects that need assets for the whole application lifetime.                           |
| **[AssetBundle system](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetBundlesIntro.html)**       | Yes                     | Yes                     | No (manual)                | Yes (manual memory management) | Existing projects that already use AssetBundles, or need remote content pipelines with script-level control. |

You can additionally use the following packages depending on your project type:

-   [The Addressables package](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-managing-introduction.html#addressables-package): Provides an Editor interface for organizing your assets into content builds. OBuilt on top of the `AssetBundle` API, it automates a lot of the manual processes that the AssetBundle system has.
-   [ECS content management system](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-managing-introduction.html#ecs-content-management-system): If you use the [Entities package](https://docs.unity3d.com/Packages/com.unity.entities@latest) in your project, then it has its own content management system.

<span id="addressables-package"></span>

### Addressables package

If you want to create separate content builds through the AssetBundles system, then the [Addressables package](https://docs.unity3d.com/Packages/com.unity.addressables@latest) provides an Editor interface for organizing your assets into content builds. Addressables automatically manages dependencies, asset locations, and memory allocation, which you otherwise have to handle manually in the AssetBundle systems. The Addressables package aims to remove the limitations of the Resources, and AssetBundle systems to make it easier to manage assets on demand.

Once you have made an asset Addressable, you can reference it by address in your code, which means you can change the location of an asset without needing to rewrite any code. You can also use asset references to dynamically load and unload assets, so that you don’t always have to keep all assets in the scene in memory.

The Addressables system is designed for applications that are likely to have content updates over time. If your application has fixed content which is shipped in the initial download, then using direct references, or the Resources system is a better alternative.

For more information, refer to [Addressables overview](https://docs.unity3d.com/Packages/com.unity.addressables@latest/index.html?subfolder=/manual/AddressableAssetsOverview.html)

<span id="ecs-content-management-system"></span>

### ECS content management system

The Entities package has its own [content management system](https://docs.unity3d.com/Packages/com.unity.entities@latest/index.html?subfolder=/manual/content-management.html), where you use weak references to assets to load them at runtime. You can also create content archives to deliver content to an application. For more information, refer to [Introduction to content management](https://docs.unity3d.com/Packages/com.unity.entities@latest/index.html?subfolder=/manual/content-management-intro.html).

## Additional resources

-   [Direct reference asset management](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-direct-reference.html)
-   [Use the Resources system to load assets at runtime](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-resources-system.html)
-   [Use AssetBundles to load assets at runtime](https://docs.unity3d.com/6000.3/Documentation/Manual/assetbundles-section.html)
-   [Addressables package](https://docs.unity3d.com/Packages/com.unity.addressables@latest)
-   [Entities package](https://docs.unity3d.com/Packages/com.unity.entities@latest)
