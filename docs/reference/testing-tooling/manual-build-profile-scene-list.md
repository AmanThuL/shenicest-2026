---
title: "Manage scenes in a build"
page_title: "Unity - Manual: Manage scenes in a build"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/build-profile-scene-list.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/build-profile-scene-list.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Manage scenes in a build

Use the **Scene List** to organize the scenes in a build. Unity builds scenes in the order they appear in the list. You can add, exclude, remove, and reorder scenes in the list.

On platform profiles, the **Scene List** is visible by default. However, on build profiles the **Scene List** isn’t visible by default, because the build profiles do not override the scene list unless you add it. When the **Scene List** is not added to a build profile, the global scene list is used instead.

To access the **Scene List** for a build profile, follow these steps:

1.  Go to **File** > **Build Profiles**.
2.  Select or [create a build profile](https://docs.unity3d.com/6000.3/Documentation/Manual/create-build-profile.html) for your target platform.
3.  Select **Add Settings**.
4.  From the dropdown, select **Scene List**.

The **Scene List** section appears displaying the scenes in your project. Use the following actions to manage the scene list:

| **List action** | **Description**                                                                                                                           |
|:----------------|:------------------------------------------------------------------------------------------------------------------------------------------|
| **Add**         | Use **Add Open Scenes** to add all currently open scenes to the list. You can also drag scenes from the **Project** window into the list. |
| **Exclude**     | Clear the checkbox next to a scene to exclude it from the build. This removes the scene from the build but not from the list.             |
| **Remove**      | Right-click on a scene name and select **Remove Selection** to remove it from the list.                                                   |
| **Reorder**     | To adjust the scene order, drag scenes into a different position in the list.                                                             |

## Additional resources

-   [Build Profiles window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html)
-   [Working with scenes](https://docs.unity3d.com/6000.3/Documentation/Manual/working-with-scenes.html)
