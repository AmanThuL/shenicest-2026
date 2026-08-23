---
title: "Organize assets with labels"
page_title: "Unity - Manual: Organize assets with labels"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/organizing-assets-with-labels.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/organizing-assets-with-labels.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Organize assets with labels

Labels are metadata that you can apply to assets to organize them into categories. Assets are easier to search and filter with a label applied to them. You can assign more than one label to each asset, and you can make custom labels or use Unity’s predefined labels.

Labels have the following advantages:

-   If you use version control, labels are shared across the team. The labels stay attached to the asset even if you move or rename it.
-   They’re lightweight, project-level metadata that you can query without loading the asset file from disk, so custom tooling and scripts can check many assets without deserializing them.
-   Labels set from scripts are immediately available in the Editor, and are shared with the [**Search**](https://docs.unity3d.com/6000.3/Documentation/Manual/search-window-reference.html) and [**Project**](https://docs.unity3d.com/6000.3/Documentation/Manual/ProjectView.html) windows, so you can quickly find what you need.

Labels are an Editor-only way of organizing assets. To organize GameObjects during runtime, use tags. For more information about how to use tags with GameObjects, refer to [Assign tags to GameObjects](https://docs.unity3d.com/6000.3/Documentation/Manual/Tags.html).

## Add a label to an asset

To add a label to an asset:

1.  Open the asset in the **Inspector** window.

2.  If the **Preview** panel is minimized, drag the title bar (A) up to expand it.

3.  In the **Preview** panel, select the label icon (B) to access the labels menu.

    ![The Preview panel in the Inspector window. A: The title bar. B: The label icon](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/inspector-preview-panel.png)

4.  In the labels menu, select a label to apply it. The menu lists every label in the project. The check mark next to the label name indicates that the label is applied to the asset.

## Create a new label for an asset

To create a new label for an asset:

1.  Type the label name in the labels menu text box.
2.  Press **Space** or **Enter** to save the label.

You can then toggle the new label like any other entry in the menu.

## Remove a label from an asset

To remove a label from an asset:

1.  Open the labels menu.
2.  Select the label you want to remove to clear the check mark.

## Filter assets by label

You can filter assets with labels in the [**Search**](https://docs.unity3d.com/6000.3/Documentation/Manual/search-window-reference.html) window, the [**Project**](https://docs.unity3d.com/6000.3/Documentation/Manual/ProjectView.html) window or in the **Inspector** with the [**Advanced Object Picker**](https://docs.unity3d.com/6000.3/Documentation/Manual/search-advanced-object-picker.html) window.

To filter assets in any of the windows, use the `l:` token in the search bar to find assets with the specified label. For more information about textual searches, refer to [Search expressions](https://docs.unity3d.com/6000.3/Documentation/Manual/search-expressions.html).

For the **Search** window, you can also select labels with the [Visual query builder](https://docs.unity3d.com/6000.3/Documentation/Manual/search-visual-query.html).

### Search by label in the Project window

1.  In the **Project** window, select the label icon (**Search by Label**).

2.  From the list, select a label name.

    ![Search by label in the Project window](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/project-window-search-by-label.png)

The **Project** window shows results grouped by location: **All**, **In Packages**, **In Assets**, and under the folder you currently have selected. For more information about how to search in the **Project** window, refer to [Search assets with the Project search provider](https://docs.unity3d.com/6000.3/Documentation/Manual/search-assets.html).

## Manage asset labels from scripts

You can perform operations on multiple labels at a time with scripts:

-   Get an asset’s labels in code with [`AssetDatabase.GetLabels`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.GetLabels.html).
-   Replace an asset’s labels with [`AssetDatabase.SetLabels`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.SetLabels.html).
-   Remove all labels from an asset with [`AssetDatabase.ClearLabels`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.ClearLabels.html).

You can also filter your search by label with [`AssetDatabase.FindAssets`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.FindAssets.html) or with [`AssetDatabase.FindAssetGUIDs`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.FindAssetGUIDs.html).

For example, the following code retrieves all GameObject assets with the same label named `Vegetation` and displays the paths to the assets:

``` lang-cs
using UnityEditor;
using UnityEngine;

static class VegetationReport

    }
}
```

## Additional resources

-   [Assets and media](https://docs.unity3d.com/6000.3/Documentation/Manual/assets-and-media.html)
-   [Searching in the Unity Editor](https://docs.unity3d.com/6000.3/Documentation/Manual/editor-searching.html)
-   [Search expressions](https://docs.unity3d.com/6000.3/Documentation/Manual/search-expressions.html)
