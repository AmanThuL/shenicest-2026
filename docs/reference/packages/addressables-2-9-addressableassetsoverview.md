---
title: "Addressables introduction"
page_title: "Addressables introduction | Addressables | 2.9.1"
source_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetsOverview.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetsOverview.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Addressables introduction

The Addressables package provides a user interface for organizing assets in your project. You can organize assets into [groups](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/groups-intro.html), which define how Unity packages assets into AssetBundles and loads them.

By default, Addressables uses <a href="https://docs.unity3d.com/Manual/AssetBundlesIntro.html" class="xref">AssetBundles</a> to package your assets. You can also implement your own <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.ResourceManagement.ResourceProviders.IResourceProvider.html" class="xref"><code>IResourceProvider</code></a> class to support other ways to access assets.

## Addressables groups and labels

Use Addressables [groups](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/groups-intro.html) to organize your content. All Addressable assets belong to a group. If you don't explicitly assign an asset to a group, Unity adds it to the default group.

You can set the [group settings](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/ContentPackingAndLoadingSchema.html) to specify how the Addressables build system packages the assets in a group into bundles. For example, you can choose whether to pack all the assets in a group together in a single AssetBundle file.

Use [labels](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/Labels.html) to tag content that you want to treat together in some way. For example, if you had labels defined for `red`, `hat`, and `feather`, you can load all red hats with feathers in a single operation, whether they're part of the same AssetBundle or not. You can also use labels to decide how assets in a group are packed into AssetBundles.

Add an asset to a group and move assets between groups using the <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/GroupsWindow.html" class="xref">Addressables Groups</a> window. You can also assign labels to your assets in the Groups window.

### Group schemas

The schemas assigned to a group define the settings used to build the assets in a group. Different schemas can define different groups of settings. For example, one standard schema defines the settings for how to pack and compress your assets into AssetBundles (among other options). You also can define your own schemas to use with custom build scripts.

For more information, refer to [Define group settings](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/GroupSchemas.html).

## Asset addresses

In the Addressables system, assets are assigned addresses that can be used to load the assets at runtime. For example, an asset at `Assets/Boss1/Materials/MainMaterial.material` could be assigned an address like `boss1_material_main`. The Addressables resource manager looks up the address in the content catalog to find out where the asset is stored. Assets can be built-in to your application, cached locally, or hosted remotely. The resource manager loads the asset and any dependencies, downloading the content first, if necessary.

![An overview of the Addressables system retrieving assets from different locations. The locally-installed application includes both non-addressable assets and local addressable assets. It communicates with both a device cache and a remote host, which each have their own addressable assets that the application can retrieve.](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/images/addressables-overview-addresses.png)  
*An overview of the Addressables system retrieving assets from different locations.*

Because an address isn't tied to the physical location of the asset, you have several options to manage and optimize your assets, both in the Unity Editor and at runtime. [Catalogs](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetsOverview.html#content-catalogs) map addresses to physical locations.

Although it's best practice to assign unique addresses to your assets, an asset address doesn't have to be unique. You can assign the same address string to more than one asset when useful. For example, if you have variants of an asset, you can assign the same address to all the variants and use labels to distinguish between the variants:

-   Asset 1: address: `"plate_armor_rusty"`, label: `"hd"`
-   Asset 2: address: `"plate_armor_rusty"`, label: `"sd"`

The `Addressables` API methods that only load a single asset, such as <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.Addressables.LoadAssetAsync.html" class="xref"><code>LoadAssetAsync</code></a>, load the first instance found if you call them with an address assigned to multiple assets. Other methods, like <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.Addressables.LoadAssetsAsync.html" class="xref"><code>LoadAssetsAsync</code></a>, load multiple assets in one operation and load all the assets with the specified address.

##### Tip

You can use the <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.Addressables.MergeMode.html" class="xref"><code>MergeMode</code></a> parameter of `LoadAssetsAsync` to load the intersection of two keys.

In the earlier example, you can specify the address, `"plate_armor_rusty"`, and the label, `"hd"`, as keys and intersection as the merge mode to load Asset 1. You can then change the label value to `"sd"` to load Asset 2.

For more information on how to assign addresses to assets, refer to <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetsGettingStarted.html" class="xref">Making an asset Addressable</a>. For information on how to load assets by keys, including addresses, refer to <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/LoadingAddressableAssets.html" class="xref">Loading assets</a>.

## Asset loading and unloading

To load an Addressable asset, you can use its address or other key such as a label or `AssetReference`. For more information, refer to <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/LoadingAddressableAssets.html" class="xref">Loading Addressable Assets</a>. You only need to load the main asset and Addressables loads any dependent assets automatically.

When your application no longer needs access to an Addressable asset at runtime, you must release it so that Addressables can free the associated memory. The Addressables system keeps a reference count of loaded assets, and doesn't unload an asset until the reference count returns to zero. As such, you don't need to keep track of whether an asset or its dependencies are still in use. You only need to make sure that any time you explicitly load an asset, you release it when your application no longer needs that instance. Refer to <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/UnloadingAddressableAssets.html" class="xref">Releasing Addressable assets</a> for more information.

### Control loading with asset references

An <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.AssetReference.html" class="xref"><code>AssetReference</code></a> is a type that you can set to any kind of Addressable asset. Unity doesn't automatically load the asset assigned to the reference, so you have more control over when to load and unload it.

Use fields of type `AssetReference` in a `MonoBehaviour` or `ScriptableObject` to reference an Addressable asset. You can drag and drop in the Editor Inspector to assign an Asset to an `AssetReference` field.

Addressables also provide specialized types, such as `AssetReferenceGameObject` and `AssetReferenceTexture`. You can use these specialized subclasses to prevent the possibility of assigning the wrong asset type to an `AssetReference` field. You can also use the `AssetReferenceUILabelRestriction` attribute to limit assignment to assets with specific labels.

For more information, refer to <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AssetReferences.html" class="xref">Using AssetReferences</a>.

## Dependency and resource management

One asset in Unity can depend on another. A scene might reference one or more prefabs, or a prefab might use one or more materials. One or more prefabs can use the same material, and those prefabs can exist in different AssetBundles. When you load an Addressable asset, the system automatically finds and loads any dependent assets that it references. When the system unloads an asset, it also unloads its dependencies, unless a different asset is still using them.

As you load and release assets, the Addressables system keeps a reference count for each item. When an asset is no longer referenced, Addressables unloads it. If the asset was in a bundle that no longer has any assets that are in use, Addressables also unloads the bundle.

Refer to <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/memory-assets.html" class="xref">Memory management</a> for more information.

## Content builds

The Addressables system separates the building of Addressable content from the build of your player. A content build produces the content catalog, catalog hash, and the AssetBundles containing your assets. You can build Addressable assets in a separate, [content-only build](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/builds-full-build.html), or build them at the [same time as the Player](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/build-player-builds.html).

Because asset formats are platform-specific, you must make a content build for each platform before building a player.

Refer to <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/Builds.html" class="xref">Building Addressable content</a> for more information.

## Content catalogs

The Addressables system produces a content catalog file that maps the addresses of assets to their physical locations. It can also create a hash file containing the hash of the catalog. If you're hosting Addressable assets remotely, the system uses this hash file to decide if the content catalog has changed and needs to download it. Refer to <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/BuildArtifacts.html" class="xref">Content catalogs</a> for more information.

The Profile selected when you perform a content build determines how the addresses in the content catalog map to resource loading paths. Refer to <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetsProfiles.html" class="xref">Profiles</a> for more information.

For information about hosting content remotely, refer to <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/RemoteContentDistribution.html" class="xref">Distributing content remotely</a>.

## Addressables tools

The Addressables system provides the following tools and windows to help you manage your Addressable assets:

-   <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/GroupsWindow.html" class="xref">Addressable Groups window</a>: The main interface for managing assets, group settings, and making builds.
-   <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetsProfiles.html" class="xref">Profiles window</a>: Helps set up paths used by your builds.
-   <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/BuildLayoutReport.html" class="xref">Build layout report</a>: Describes the AssetBundles produced by a content build.
-   <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/analyze-addressables-window.html" class="xref">Analyze tool</a>: the Analyze tool runs analysis rules that check whether your Addressables content conforms to the set of rules you have defined. The Addressables system provides some basic rules, such as checking for duplicate assets; you can add your own rules using the \[AnalyzeRule\] class.

## Additional resources

-   <a href="https://docs.unity3d.com/Manual/AssetBundlesIntro.html" class="xref">AssetBundles introduction</a>
-   [Organize Addressable assets](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetsDevelopmentCycle.html)
-   [Referencing Addressable assets in code](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AssetReferences.html)
