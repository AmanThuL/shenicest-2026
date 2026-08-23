---
title: "Addressable AssetBundle memory considerations"
page_title: "Addressable AssetBundle memory considerations | Addressables | 2.9.1"
source_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/memory-assetbundles.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/memory-assetbundles.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Addressable AssetBundle memory considerations

When you organize Addressable groups and AssetBundles, you must make trade-offs between the size and the number of AssetBundles you create and load. Fewer, larger AssetBundles can minimize the total memory usage of AssetBundles. However, using many small AssetBundles can minimize the peak memory usage because Unity can quickly unload assets and AssetBundles.

The size of an AssetBundle on disk isn't the same as its size at runtime. However, you can use the disk size as a guide to the memory overhead of the AssetBundles in a build. You can get AssetBundle size and other information to help analyze AssetBundles from the [Build Layout Report](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/BuildLayoutReport.html).

For information on AssetBundle memory overhead, refer to <a href="https://docs.unity3d.com/Manual/assetbundles-optimizing.html" class="xref">Optimizing AssetBundles</a>.

## TypeTree management

You can <a href="https://docs.unity3d.com/Manual/assetbundles-optimizing.html" class="xref">remove TypeTrees</a> to optimize memory. However, this approach is only recommended for content you can rebuild each time you release a new Player. This is a suitable optimization for Addressable content that you include directly with the Player build. In that case you must always rebuild local Addressable groups before building a new Player.

[Distributing content remotely](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/remote-content-intro.html) adds additional considerations. The ability to add new content after the Player has shipped means the content must exactly match the Unity Editor version the Player was built with. There must also be no serialization changes in your code and in the code of all the packages that contribute content. If you use multiple Player versions, updates, and Editor versions, it can become difficult to manage matching the AssetBundles with compatible Player builds. The memory savings from disabling TypeTrees might not be worth this extra trouble.

You can enable the **[Extract TypeTree Data](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetSettings.html#build)** setting to place TypeTree data in a separate file, which can reduce the file size of a build. However, this adjusts any existing AssetBundles, so don't use this setting in projects that you have already deployed.

## Loading AssetBundle dependencies

Loading an Addressable asset also loads all the AssetBundles containing its dependencies. An AssetBundle dependency happens when an asset in one AssetBundle references an asset in another AssetBundle. For example, when a material references a texture. For more information refer to [Asset and AssetBundle dependencies](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AssetDependencies.html).

Addressables calculates dependencies between AssetBundles at the AssetBundle level. If one asset references an object in another AssetBundle, then the entire AssetBundle has a dependency on that AssetBundle. This means that even if you load an asset in the first AssetBundle that has no dependencies of its own, the second AssetBundle is still loaded into memory.

For example,`BundleA` contains Addressable assets `RootAsset1` and `RootAsset2`. `RootAsset2` references `DependencyAsset3`, which is in `BundleB`. Even though `RootAsset1` has no reference to `BundleB`, `BundleB` is still a dependency of `RootAsset1` because `RootAsset1` is in `BundleA`, which has a reference to `BundleB`.

To avoid loading more bundles than you need, keep the dependencies between AssetBundles as simple as possible. You can use the <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/BuildLayoutReport.html" class="xref">Build Layout Report</a> to check dependencies.

## Additional resources

-   <a href="https://docs.unity3d.com/Manual/assetbundles-optimizing.html" class="xref">Optimizing AssetBundles</a>
-   [Asset and AssetBundle dependencies](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AssetDependencies.html)
