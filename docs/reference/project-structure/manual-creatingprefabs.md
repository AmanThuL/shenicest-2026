---
title: "Create prefabs"
page_title: "Unity - Manual: Create prefabs"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/CreatingPrefabs.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/CreatingPrefabs.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Create prefabs

To create and use prefabs in your project, you must do the following:

1.  [Create a prefab asset](https://docs.unity3d.com/6000.3/Documentation/Manual/CreatingPrefabs.html#create-a-prefab-asset).
2.  [Create an instance of the prefab asset](https://docs.unity3d.com/6000.3/Documentation/Manual/CreatingPrefabs.html#create-an-instance-of-a-prefab).

<span id="create-a-prefab-asset"></span>

## Create a prefab asset

To create a prefab asset, perform the following steps:

1.  Create a [GameObject](https://docs.unity3d.com/6000.3/Documentation/Manual/GameObjects.html) and configure its position, scale, rotation, components, and other properties as needed.
2.  Drag the GameObject into the `Assets` folder in the [Project window](https://docs.unity3d.com/6000.3/Documentation/Manual/ProjectView.html). You can optionally select more than one GameObject to create multiple prefab assets.

Unity then creates a prefab asset from the GameObject, all its components, and child GameObjects. The original GameObject becomes an instance of the newly created prefab asset.

![A GameObject named Health Pack in the left window. After dragging the GameObject into a child folder of the `Assets` folder, the Health Pack object is saved as a .prefab file, and the original GameObject becomes an instance of the prefab asset. The Inspector displays details of the Health Pack prefab asset.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/prefab-workflow.png)

If you drag multiple GameObjects that aren’t already prefabs into the Project window, Unity creates new prefab assets for each one without any additional steps. However, if any of the GameObjects are existing prefabs or [prefab variants](https://docs.unity3d.com/6000.3/Documentation/Manual/PrefabVariants.html), Unity displays a dialog which asks you to confirm whether you want to create new prefab assets or new variants from the GameObjects.

### Replace a prefab asset

You can replace a prefab asset with a GameObject or [prefab instance](https://docs.unity3d.com/6000.3/Documentation/Manual/CreatingPrefabs.html#create-an-instance-of-a-prefab) that’s in the [Hierarchy window](https://docs.unity3d.com/6000.3/Documentation/Manual/Hierarchy.html). To replace a prefab asset:

1.  Select the GameObject or prefab in the Hierarchy window.
2.  Drag it on top of an existing prefab asset in the Project window.

If the contents of the GameObject or prefab instance differ from the prefab asset, then Unity displays a dialog to confirm that you intend to replace the prefab asset.

Unity tries to preserve references to the prefab and the individual parts of the prefab such as child GameObjects and components. To do this, it matches the names of GameObjects between the new prefab and the existing prefab that you’re replacing.

Because Unity performs this matching by name only, if there are multiple GameObjects with the same name in the prefab asset’s hierarchy, the matching is unpredictable. Therefore, to ensure Unity preserves the references when saving over an existing prefab, make sure all GameObjects within the prefab have unique names.

Unity behaves in a similar way if a GameObject has more than one of the same type of component attached to it.

<span id="create-an-instance-of-a-prefab"></span>

## Create an instance of a prefab

To create an instance of a prefab asset:

1.  Select the prefab asset in the Project window.
2.  Drag the prefab asset into the Hierarchy or Scene view.

You can also create instances of prefabs at runtime using scripting. For more information, refer to [Instantiating prefabs](https://docs.unity3d.com/6000.3/Documentation/Manual/instantiating-prefabs.html).

### Replace a prefab instance’s prefab asset

You can replace a prefab instance’s parent prefab asset, while retaining the instance’s position, rotation, and scale. Unity merges the contents of the new prefab asset and preserves any overrides and references via name-based matching.

You can replace a prefab asset in the following ways:

-   In the [Inspector for the prefab instance](https://docs.unity3d.com/6000.3/Documentation/Manual/prefab-instance-inspector-reference.html):
    1.  Drag a prefab asset from the Project window into the **Prefab** field in the Inspector.
    2.  If the prefab has any [overrides](https://docs.unity3d.com/6000.3/Documentation/Manual/prefabs-override.html), Unity displays a context menu and you can choose to either **Replace and Keep Overrides** to preserve any overrides, or **Replace** and discard any overrides.
-   In the Hierarchy window:
    1.  Right-click on a prefab instance or GameObject.
    2.  Select **Prefab** > **Replace**, or **Replace and Keep Overrides** to preserve overrides.
    3.  A **Select GameObject** window appears and you can choose the prefab asset you want to replace it with.
-   In the Project window:
    1.  Hold down Ctrl (macOS: Command) and drag a prefab asset onto a prefab instance or GameObject in the Hierarchy.
    2.  In the context menu, select **Replace**, or **Replace and Keep Overrides** to preserve overrides.

You can also use the [`PrefabUtility.ReplacePrefabAssetOfPrefabInstance`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PrefabUtility.ReplacePrefabAssetOfPrefabInstance.html) method to control this behavior in your scripts.

## Additional resources

-   [Edit prefab assets](https://docs.unity3d.com/6000.3/Documentation/Manual/EditingInPrefabMode.html)
-   [Nest prefab instances in other prefabs](https://docs.unity3d.com/6000.3/Documentation/Manual/NestedPrefabs.html)
-   [Create variations of prefabs](https://docs.unity3d.com/6000.3/Documentation/Manual/PrefabVariants.html)
-   [YAML serialization of prefabs](https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-serialization.html)
