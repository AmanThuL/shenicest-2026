---
title: "Introduction to addressable asset groups"
page_title: "Introduction to addressable asset groups | Addressables | 2.9.1"
source_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/groups-intro.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/groups-intro.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to addressable asset groups

Understand how to use groups to organize addressable assets, control build paths, load paths, and AssetBundle packaging strategies.

A group is the main organizational unit of the Addressables system. Create and manage your groups and the assets they contain with the **[Addressables Groups window](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/GroupsWindow.html)**.

To control how Unity handles assets during a content build, organize Addressables into groups and assign different settings to each group as required.

You can optionally use the **[Auto Group Generator window](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/groups-auto-group-generator.html)** to automatically generate optimized groups for assets and their dependencies.

![The Addressables Groups window showing the toolbar and list of groups and assets.](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/images/addressables-groups-window.png)  
  
*The Addressables Groups window showing the toolbar and list of groups and assets.*

When you begin a content build, the build scripts create AssetBundles that contain the assets in a group. The build determines the number of AssetBundles to create and where to create them from both the [settings of the group](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/GroupSchemas.html) and the [Addressables system settings](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetSettings.html). For more information, refer to [Builds](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/Builds.html).

##### Note

Addressable Groups only exist in the Unity Editor. The Addressables runtime code doesn't use a group concept. However, you can [assign a label](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/Labels.html) to the assets in a group if you want to find and load all the assets that were part of that group. For more information, refer to [Loading Addressable assets](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/LoadingAddressableAssets.html).

Unity saves the groups you create in the `AssetGroups` subfolder of `AddressableAssetsData`. When you select a group in this folder, you can use the Inspector to define the following:

-   **Build paths**: Where to save your content after a content build.
-   **Load paths**: Where your application looks for built content at runtime.
-   **Bundle mode**: How to package the content in the group into a bundle. You can choose the following options:
    -   One bundle containing all group assets
    -   A bundle for each entry in the group (useful if you mark entire folders as Addressable and want their contents built together)
    -   A bundle for each unique combination of labels assigned to group assets
-   **Content update restriction**: Restrict groups when creating content update builds. For more information, refer to [Content update builds](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/ContentUpdateWorkflow.html).

For full details of each setting, refer to [Content packing settings reference](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/ContentPackingAndLoadingSchema.html).

You can also use profile variables to automatically set these paths. For more information, refer to [Profiles](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetsProfiles.html).

## Additional resources

-   [Add assets to groups](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/groups-create.html)
-   [Define group settings](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/GroupSchemas.html)
-   [Labelling assets](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/Labels.html)
-   [Addressables Groups window reference](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/GroupsWindow.html)
-   [Introduction to loading Addressable assets](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/load-addressable-assets.html)
