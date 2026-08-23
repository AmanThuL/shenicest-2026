---
title: "Introduction to creating and organizing Addressable assets"
page_title: "Introduction to creating and organizing Addressable assets | Addressables | 2.9.1"
source_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/organize-addressable-assets.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/organize-addressable-assets.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to creating and organizing Addressable assets

Understand how to make assets Addressable and organize them using groups, profiles, and the Addressable Asset Settings window.

To create and organize Addressable assets, you must do the following:

-   [Assign an asset as addressable](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/organize-addressable-assets.html#assign-an-asset-as-addressable).
-   [Organize Addressable assets with groups](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/organize-addressable-assets.html#manage-addressable-groups), which determine where Unity loads assets from and builds them to, and how the content is compressed.

Once you make an asset Addressable, the Addressables system adds it to a default group, unless you place it in a specific group. When you make a <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/Builds.html" class="xref">content build</a>, Unity packs assets in a group into <a href="https://docs.unity3d.com/6000.0/Documentation/Manual/AssetBundlesIntro.html" class="xref">AssetBundles</a> according to the group's settings. You can load these assets using the <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/LoadingAddressableAssets.html" class="xref">Addressables API</a>.

You can optionally use [profiles](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetsProfiles.html) to create variables for the build process, and use [labels](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/Labels.html) to determine how to group Addressable assets together.

To customize Addressable settings on a project level, use the [Addressable Asset Settings window](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetSettings.html).

## Assign an asset as Addressable

You can make an asset Addressable in the following ways:

-   Enable the **Addressable** checkbox in the Inspector window for either the asset itself or for its parent folder.
-   Drag the asset into a group in the [Addressables Groups](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/GroupsWindow.html) window.
-   Drag or assign the asset to an [AssetReference](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AssetReferences.html) field in the Inspector window.

![](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/images/addressable-inspector-checkbox.png)  
*A Banana prefab asset with the Addressable option enabled. It's assigned to the default group.*

##### Note

If you make an asset in a <a href="https://docs.unity3d.com/Manual/LoadingResourcesatRuntime.html" class="xref">Resources folder</a> Addressable, Unity moves the asset out of the Resources folder. You can move the asset to a different folder in your Project, but you can't store Addressable assets in a Resources folder.

## Manage Addressable groups

To manage Addressable assets, use the [Addressables Groups](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/groups-intro.html) window. Use this window to create Addressables groups, move assets between groups, and assign addresses and labels to assets.

![The Addressables Groups window showing the toolbar and list of groups and assets.](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/images/addressables-groups-window.png)  
  
*The Addressables Groups window showing the toolbar and list of groups and assets.*

When you first install and set up the Addressables package, it creates a default group for Addressable assets. The Addressables system assigns any assets you mark as Addressable to this group by default. You can create more groups to further organize the assets in your project and define when and how Unity builds and loads them.

For more information, refer to [Organize assets into groups](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/groups-intro.html).

## Referencing Addressable assets

To organize assets in the Unity Editor, you can use <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/api/UnityEngine.AddressableAssets.AssetReference.html" class="xref"><code>AssetReference</code></a>, which is a type that can reference an Addressable asset. You can include `AssetReference` fields in `MonoBehaviour` and `ScriptableObject` classes and then in the Unity Editor assign assets to these fields in the Inspector.

For more information, refer to [Referencing Addressable assets in code](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AssetReferences.html).

## Strategies for organizing assets

Typical strategies for organizing assets include:

-   **Concurrent usage**: Group assets that you load at the same time together, such as all the assets for a given level. This strategy is often the most effective in the long term and can help reduce peak memory use in a project.
-   **Logical entity**: Group assets belonging to the same logical entity together. For example, UI layout assets, textures, sound effects, character models, and animations.
-   **Type**: Group assets of the same type together. For example, music files, or textures.

Depending on the needs of your project, one of these strategies might make more sense than the others. For example, in a game with many levels, organizing according to concurrent usage might be the most efficient both from a project management and from a runtime memory performance standpoint.

You can also use different strategies for different types of assets. For example, in a level-based game you can group all UI assets for menu screens together, and group level data separately. You might also pack a group that has the assets for a level into bundles that contain a particular asset type.

For more information on organizing assets, refer to <a href="https://docs.unity3d.com/Manual/AssetBundles-Preparing.html" class="xref">Organizing assets into AssetBundles</a>. While this documentation focuses on AssetBundle organization, the approaches can be also applied to Addressables.

## Additional resources

-   [Addressable asset groups](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/groups-intro.html)
-   [Referencing Addressable assets in code](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AssetReferences.html)
-   [Building Addressable assets](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/Builds.html)
-   [Addressables Groups window reference](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/GroupsWindow.html)
