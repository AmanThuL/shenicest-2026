---
title: "Introduction to Addressable asset groups (4.0)"
page_title: "Introduction to Addressable asset groups | Addressables | 4.0.2"
source_url: "https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/groups-intro.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/groups-intro.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to Addressable asset groups

Understand how to use groups to organize Addressable assets, control build paths, load paths, and AssetBundle packaging strategies.

A group is the main organizational unit of the Addressables system. Create and manage groups and the assets they contain with the **[Addressables Groups window](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/GroupsWindow.html)**.

To control how Unity handles assets during a content build, organize Addressables into groups and assign different settings to each group as required.

You can optionally use the **[Auto Group Generator window](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/groups-auto-group-generator.html)** to automatically generate optimized groups for assets and their dependencies.

![The Addressables Groups window showing the toolbar and list of groups and assets.](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/images/addressables-groups-window.png)  
  
*The Addressables Groups window showing the toolbar and list of groups and assets.*

The build scripts use groups to determine how to build your project's content, depending on the [content build system](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/groups-create.html) you're using:

-   **AssetBundles**: The build uses groups to determine the number of AssetBundles to create and where to create them from both the [settings of the group](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/GroupSchemas.html) and the [Addressables system settings](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/AddressableAssetSettings.html).
-   **Content directories**: Creates one content directory that includes all groups.

For more information, refer to [Builds](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/Builds.html).

##### Note

Addressable groups only exist in the Unity Editor. The Addressables runtime code doesn't use a group concept. However, you can [assign a label](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/Labels.html) to the assets in a group if you want to find and load all the assets that were part of that group. For more information, refer to [Loading Addressable assets](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/LoadingAddressableAssets.html).

Unity saves the groups you create in the `AssetGroups` subfolder of `AddressableAssetsData`. When you select a group in this folder, you can use the Inspector to define how Unity creates and outputs a content build.

For full details of each setting, refer to [Group Inspector settings reference](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/group-inspector-settings-reference.html).

You can also use profile variables to automatically set these paths. For more information, refer to [Profiles](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/AddressableAssetsProfiles.html).

## Additional resources

-   [Add assets to groups](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/groups-create.html)
-   [Define group settings](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/GroupSchemas.html)
-   [Labelling assets](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/Labels.html)
-   [Addressables Groups window reference](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/GroupsWindow.html)
-   [Introduction to loading Addressable assets](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/load-addressable-assets.html)
