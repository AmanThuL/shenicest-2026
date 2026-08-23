---
title: "Nest prefab instances in other prefabs"
page_title: "Unity - Manual: Nest prefab instances in other prefabs"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/NestedPrefabs.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/NestedPrefabs.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Nest prefab instances in other prefabs

You can include prefab instances inside other prefabs. Prefab instances included in other prefabs are called nested prefabs. Nested prefabs keep their links to their own prefab assets, while also forming part of another prefab asset.

You can add nested prefabs in [prefab editing mode](https://docs.unity3d.com/6000.3/Documentation/Manual/EditingInPrefabMode.html), or from the Hierarchy view.

## Add a nested prefab in prefab editing mode

1.  Select the prefab you want to edit, and open [prefab editing mode](https://docs.unity3d.com/6000.3/Documentation/Manual/EditingInPrefabMode.html).
2.  Drag another prefab into the Hierarchy or Scene view. You can also add any overrides to these prefab instances.

## Add a nested prefab from the Hierarchy

You can add a prefab instance as a child of another prefab in the Hierarchy view.

1.  In the Hierarchy, select the dropdown arrow next to the prefab you want to edit.
2.  Drag a prefab from the Project window into the prefab’s hierarchy.

![An enemy bot variant prefab, with a nested Weapon Blaster prefab, and a recently added Banana prefab override.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/prefabs-nested-hierarchy.png)

The nested prefab is applied as an [override](https://docs.unity3d.com/6000.3/Documentation/Manual/PrefabInstanceOverrides.html) to the parent prefab asset, indicated by a green plus icon. You can optionally apply these override changes permanently to the parent prefab asset. For more information, refer to [Apply overrides to the prefab asset](https://docs.unity3d.com/6000.3/Documentation/Manual/PrefabInstanceOverrides.html#apply-overrides-to-the-prefab-asset).

## Additional resources

-   [Edit prefab assets](https://docs.unity3d.com/6000.3/Documentation/Manual/EditingInPrefabMode.html)
-   [Create prefabs](https://docs.unity3d.com/6000.3/Documentation/Manual/CreatingPrefabs.html)
-   [Create variations of prefabs](https://docs.unity3d.com/6000.3/Documentation/Manual/PrefabVariants.html)
-   [YAML serialization of prefabs](https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-serialization.html)
