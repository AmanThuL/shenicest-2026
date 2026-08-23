---
title: "Label assets"
page_title: "Label assets | Addressables | 2.9.1"
source_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/Labels.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/Labels.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Label assets

Use labels to tag Addressable assets for runtime loading, AssetBundle packing based on labels, and filtering assets in the Groups window.

You can tag Addressable assets with one or more labels in the [Addressables Groups](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/GroupsWindow.html) window. You can use labels in the following ways:

-   Use one or more labels as keys to identify which assets to load at runtime.
-   Pack assets in a group into AssetBundles based on their assigned labels.
-   Use labels in the filter box of the **Addressables Groups** window to find labeled assets.

## Managing labels

To create and delete labels, use the Labels window, which is accessible from the [Addressables Groups window](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/GroupsWindow.html) (**Window \> Asset Management \> Addressables \> Groups \> Tools \> Windows \> Labels**).

![The Labels window displays a configurable list of labels.](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/images/addressables-labels-window.png)  
*The Labels window.*

To create a new label, select the **+** button at the bottom of the list. Enter the new name and click **Save**.

To delete a label, select it in the list and then select the **-** button. Deleting a label also removes it from all assets.

##### Tip

To undo the deletion of a label, add it back to the Addressables Labels window with the exact same string. Any assets that had the deleted label have it reapplied. However, Unity only reapplies deleted labels in this way if you've not run an Addressables build. Once you run a build, adding a deleted label no longer reapplies it to any assets.

## Load assets by label

If you use a list of labels to load assets, you can specify whether you want to load all assets that match any label, or only assets that have every label.

For example, if you use the labels, `characters` and `animals` to load assets, you can load assets that either have the `characters` or `animals` label. Alternatively, you can can load assets that have both the `characters` and `animals` label. For more information, refer to [Loading multiple assets](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/load-assets.html#load-multiple-assets).

## Building labels

If you use the <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/ContentPackingAndLoadingSchema.html" class="xref">Bundle Mode</a> setting to pack assets into a group based on their labels, the Addressables build script creates a bundle for each unique combination of labels in the group. For example, if you have assets in a group labeled as either `cat` or `dog` and either `small` or `large`, the build produces four bundles: one for small cats, one for small dogs, one for large cats, and another for large dogs.

## Additional resources

-   [Loading multiple assets](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/load-assets.html#load-multiple-assets)
-   [Building Addressable assets](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/Builds.html)
