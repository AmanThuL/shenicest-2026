---
title: "Addressables 2.9 package"
page_title: "Addressables package | Addressables | 2.9.1"
source_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/index.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/index.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Addressables package

The Addressables package provides a user interface in the Unity Editor to organize and manage the assets in your project. It also has an API that you can use to load and release assets at runtime.

The Addressables package is built on top of Unity's <a href="https://docs.unity3d.com/Manual/AssetBundlesIntro.html" class="xref">AssetBundle</a> API, and automatically manages dependencies, asset locations, and memory allocation, which you otherwise have to handle manually in the AssetBundle system.

When you make an asset Addressable, you can use that asset's address to load it locally or from a content delivery network, rather than using its file name or AssetBundle location. This means you can change the location of assets in a project without needing to rewrite code.

| **Topic**                                                                                                                                                | **Description**                                                                 |
|----------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------|
| **[Addressables package set up](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetsGettingStarted.html)**              | Install and configure the Addressables package in your Unity project.           |
| **[Addressables introduction](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetsOverview.html)**                      | Understand the core concepts of the Addressables system.                        |
| **[Create and organize Addressable assets](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetsDevelopmentCycle.html)** | Make assets Addressable and organize them into groups for efficient management. |
| **[Build Addressable assets](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/Builds.html)**                                          | Build and package Addressable assets for deployment.                            |
| **[Load Addressable assets](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/LoadingAddressableAssets.html)**                         | Control how to load assets with the Addressables API.                           |
| **[Distribute and update remote content](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/RemoteContentDistribution.html)**           | Host and deliver assets from remote servers and content delivery networks.      |
| **[Optimization tools](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/optimization-tools.html)**                                    | Use analysis tools to optimize Addressables.                                    |

## Additional resources

-   <a href="https://docs.unity3d.com/Manual/assets-managing-introduction.html" class="xref">Introduction to runtime asset management</a>
-   [Convert existing projects to Addressables](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/convert-existing-projects.html)
