---
title: "Addressables 4.0 package"
page_title: "Addressables package | Addressables | 4.0.2"
source_url: "https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/index.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/index.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Addressables package

The Addressables package provides a user interface in the Unity Editor to organize and manage the assets in your project, to create content builds that you can ship along with a Player build. It also has an API that you can use to load and release assets at runtime.

The Addressables package was originally designed on top of Unity's <a href="https://docs.unity3d.com/Manual/AssetBundlesIntro.html" class="xref">AssetBundle</a> system, but is also compatible with the newer [content directories system](https://docs.unity3d.com/6000.6/Documentation/Manual/content-directories.html). Addressables automatically manages dependencies, asset locations, and provides simpler workflows for memory management which you otherwise have to handle manually in the AssetBundle and content directories systems.

When you make an asset Addressable, you can use that asset's address to load it locally or from a content delivery network, rather than using its file name, AssetBundle location, or content directory location. This means you can change the location of assets in a project without needing to rewrite code.

| **Topic**                                                                                                                                                | **Description**                                                                      |
|----------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------|
| **[Addressables introduction](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/AddressableAssetsOverview.html)**                      | Understand the core concepts of the Addressables system.                             |
| **[Choose a content build system](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/content-build-systems.html)**                      | Choose between the content directory or AssetBundle system to create content builds. |
| **[Addressables package set up](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/AddressableAssetsGettingStarted.html)**              | Install and configure the Addressables package in your Unity project.                |
| **[Create and organize Addressable assets](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/AddressableAssetsDevelopmentCycle.html)** | Make assets Addressable and organize them into groups for efficient management.      |
| **[Build Addressable assets](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/Builds.html)**                                          | Build and package Addressable assets for deployment.                                 |
| **[Load Addressable assets](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/LoadingAddressableAssets.html)**                         | Control how to load assets with the Addressables API.                                |
| **[Distribute and update remote content](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/RemoteContentDistribution.html)**           | Host and deliver assets from remote servers and content delivery networks.           |
| **[Optimization tools](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/optimization-tools.html)**                                    | Use analysis tools to optimize Addressables.                                         |
| **[Known issues](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/known-issues.html)**                                                | Review known issues in the Addressables package and their workarounds.               |

## Additional resources

-   [Introduction to runtime asset management](xref:um-assets-managing-introduction)
-   [Convert existing projects to Addressables](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/convert-existing-projects.html)
