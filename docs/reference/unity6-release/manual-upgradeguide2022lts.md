---
title: "Upgrade to Unity 2022 LTS"
page_title: "Unity - Manual: Upgrade to Unity 2022 LTS"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuide2022LTS.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuide2022LTS.html"
topic: "unity6-release"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Upgrade to Unity 2022 LTS

This page lists changes in Unity 2022 LTS version which might affect existing projects when you upgrade them from a 2021 version to 2022 LTS.

**Note**: 2022 LTS is also known as 2022.3.0.

### Page Outline

-   [Articulation Drive `forceLimit` property now accepts force input instead of impulse](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuide2022LTS.html#artdrive)
-   [Change to generated lightmap UVs](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuide2022LTS.html#lightmap)
-   [Change to `GradientField` in the UI Toolkit](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuide2022LTS.html#gradient)
-   [UI Toolkit Numeric and Compound fields are available at runtime](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuide2022LTS.html#fields)
-   [The Physical Keys option in Input Manager is enabled by default](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuide2022LTS.html#keys)
-   [Added support for `BatchRendererGroup`](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuide2022LTS.html#batch)
-   [Render pipelines](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuide2022LTS.html#ren-pipe)
-   [Enlighten Baked Global Illumination is deprecated](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuide2022LTS.html#baked-gi)
-   [Minimum Bounces isn’t available in the Lighting window](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuide2022LTS.html#minbounce)
-   [Unity’s default Gradle templates have changed](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuide2022LTS.html#default-gradle)
-   [Navigation and Pathfinding is moving from the Unity core to the AI Navigation package](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuide2022LTS.html#nav+pathfinding)
-   [Reordering of nested Prefab children is no longer supported as an override](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuide2022LTS.html#prefab-reorder)

<span id="artdrive"></span>

## Articulation Drive `forceLimit` property now accepts force input instead of impulse

The Articulation Drive `forceLimit` feature was used previously as an impulse limit instead of a force limit. This made the force limit dependent on the `fixedDeltaTime` value.

If you have already adapted to the use of this value as an impulse, when you upgrade, your values for `forceLimit` in your Articulation Drive in the Articulation Body component will be incorrect by a large scale.

There are checks for when you open an older project. When you upgrade a project, Unity automatically divides the relevant values by the `Time.fixedDeltaTime` set in the **ProjectSettings** \> **Time** page to avoid the incorrect configuration. This catches most cases where robots are simulated based on the project set Time value.

If you use custom time values from script to simulate your robots, then you need to manually correct these values.

<span id="lightmap"></span>

## Change to generated lightmap UVs

Unity’s UV generation procedure has changed. Lightmaps might appear corrupted in projects that use the [Generate Lightmap UVs option](https://docs.unity3d.com/6000.3/Documentation/Manual/LightingGiUvs-GeneratingLightmappingUVs.html) in Model Import Settings. To resolve this problem, rebake all of the lightmaps in your project.

This change only affects projects that use Generate Lightmap UVs.

<span id="gradient"></span>

## Change to `GradientField` in the UI Toolkit

From Unity 2022.1, the color picker in `GradientField` doesn’t have HDR enabled by default. Existing projects that use `GradientField` now use a regular color picker instead of the HDR color picker.

To continue the use of a HDR color picker, you can enable it using the HDR property in `GradientField`.

<span id="fields"></span>

## UI Toolkit Numeric and Compound fields are available at runtime

The following fields are now available that work automatically at runtime:

-   `DoubleField`
-   `FloatField`
-   `IntegerField`
-   `LongField`
-   `Hash128Field`
-   `RectField`
-   `RectIntField`
-   `Vector2Field`
-   `Vector3Field`
-   `Vector4Field`
-   `Vector2IntField`
-   `Vector3IntField`
-   `BoundsField`
-   `BoundsIntField`

The UXML files in your projects don’t update and work upon upgrading. However, when you add new promoted types through the UI Builder, it breaks the backwards compatibility of UXML assets with older Unity versions. To keep the UXML assets backwards compatible, you need to use the old types (`UnityEditor.UIElements` namespace) in UXML files.

<span id="keys"></span>

## The Physical Keys option in Input Managed is enabled by default

The Physical keys option allows you to map key codes to the physical keyboard layout, rather than to the language-specific layout that may vary between users in different regions. For example, on some keyboards the first row of letters reads “QWERTY”, and on others it reads “AZERTY”. This means if you scripted specific controls to use the well known “WASD” keys for movement, they would not be in the correct physical arrangement (like the arrow-key arrangement) on an AZERTY-layout keyboard. With Physical Keys enabled, Unity uses a generic ANSI/ISO “Qwerty” layout to represent the physical location of the keys regardless of the user’s actual layout. This means if you specify the “Q” key, it will always be the left-most letter on the first row of letter keys, even if the user’s keyboard has a different letter in that position.

As of 2022.1 the option is enabled by default with intent of deprecating and removing old behavior in the future.

<span id="batch"></span>

## Added support for `BatchRendererGroup`

The `BatchRendererGroup` API was originally written for the MegaCity demo but was never fully documented or usable without a lot of implementation details. This API has been rewritten from the ground up and is fully documented and supported.

For information on how to use the new interface, refer to the [BatchRendererGroup](https://docs.unity3d.com/6000.3/Documentation/Manual/batch-renderer-group.html) page.

<span id="ren-pipe"></span>

## Render pipelines

This upgrade guide describes how to upgrade to version 2022.2 of Unity’s built-in render pipeline.

To upgrade to other render pipelines to version 2022.2, refer to the documentation for the render pipeline you’re using:

-   [The URP upgrade guide](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/upgrade-guide-2022-2.html)
-   [The HDRP upgrade guide](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@14.0/manual/Upgrading-from-2022.1-to-2022.2.html)

To upgrade other packages, refer to the documentation for the packages you are using.

<span id="baked-gi"></span>

## Enlighten Baked Global Illumination is deprecated

The Enlighten Baked Global Illumination lightmapping backend is no longer available by default. When you upgrade a project to this version, Unity removes the Enlighten baking backend from the lightmapper selection dropdown and substitutes a Progressive Lightmapper in every Scene where you’ve selected the Enlighten baking backend.

On Apple silicon devices, Unity substitutes the Progressive GPU Lightmapper for the Enlighten baking backend. On all other devices, Unity selects the CPU Progressive Lightmapper.

To continue using the Enlighten baking back end, open **Edit** \> **Project Settings** \> **Editor** and in the **Graphics** section of that menu, activate **Enable Enlighten for Baked GI (Legacy)**. However, this option isn’t available in 2023.1 and later.

<span id="minbounce"></span>

## Minimum Bounces is not available in the Lighting window

The Minimum Bounces property of the [Progressive Lightmapper](https://docs.unity3d.com/6000.3/Documentation/Manual/progressive-lightmapper.html) is no longer available in the Lighting window.

When you upgrade a project to 2022.2, Unity resets the Minimum Bounces value to 2, the recommended number of minimum bounces for lightmapping. To change this value, edit the LightingSettings API property [minBounces](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LightingSettings-minBounces.html).

<span id="default-gradle"></span>

## Unity’s default Gradle templates have changed

In 2022.2, Unity updated the default versions of all tools used by Android. The new versions are as follows:

| **Tool**              | **Version**                   |                            |
|:----------------------|:------------------------------|:---------------------------|
| SDK                   |                               |                            |
|                       | Cmdline-tools component       | version 6.0                |
|                       | Build-tools component version | 32.0.0                     |
|                       | Platform-tools component      | 32.0.0                     |
|                       | Platform (API level)          | 31 and 32 added by default |
|                       | Tools component               | Removed                    |
| NDK                   | r23b                          |                            |
| JDK (OpenJDK)         | 11.0.14.1+1                   |                            |
| Gradle                | 7.2                           |                            |
| Android Gradle Plugin | 7.1.2                         |                            |

The update to Gradle version 7.2 changed some [build.gradle](https://developer.android.com/studio/build#build-files) file configuration options. This required significant changes to Unity’s default [gradle templates](https://docs.unity3d.com/6000.3/Documentation/Manual/gradle-templates.html). Unity won’t attempt to upgrade custom Gradle templates to match the new format which means projects that contain custom template files might fail to build. To solve this, recreate any custom template files based on the new default template files.

For information about the `build.gradle` configuration option changes, refer to the [Android Gradle Plugin release notes](https://developer.android.com/studio/releases/gradle-plugin).

<span id="nav+pathfinding"></span>

## Navigation and Pathfinding is moving from the Unity core to the AI Navigation package

The package documentation is located here: https://docs.unity3d.com/Packages/com.unity.ai.navigation@latest

If you have projects that were created with the Navigation feature in previous versions of the Unity engine you can do one of the following:

-   Continue to use your projects as they are
-   Convert your projects to use the new package

In either case, the **AI Navigation** package is automatically installed and added to your project.

To start using the new package you need to convert your project as follows:

1.  Go to **Window** > **AI** > **NavMesh Updater**.
2.  In the NavMesh Updater window, select which kind of data to convert.
3.  Click **Initialize Converters** to detect and display the types of data you selected.
4.  Select the data to be converted.
5.  Click **Convert Assets** to complete the conversion.

As part of the conversion process, the **NavMesh Updater** makes the following changes:

-   Any NavMesh that was previously baked and embedded in the scene is now referenced from a NavMeshSurface component created on a new GameObject called **Navigation**.
-   Any object that was marked with Navigation Static will now have a NavMeshModifier component with the appropriate settings.

If the NavMeshes in different scenes are baked with different agent settings then you need to create new Agent types to match those settings. To create the Agent types do the following:

1.  Go to **Window** > **AI** > **Navigation**.
2.  Select **Agents**.
3.  Create new entries and specify the relevant settings.

When you have created the new entries you then need to do the following:

-   Assign the newly created agent types to their respective NavMeshSurfaces in the **Navigation** created for that scene,
-   Assign the agent types to the NavMeshAgents intended to use that NavMesh.

To find the settings that were used for each existing NavMesh, select the NavMesh .asset file in the Project window. The NavMesh settings is displayed in the Inspector.

If your project uses the `NavMeshSurface`, `NavMeshModifier`, `NavMeshModifierVolume` or `NavMeshLink` components defined by scripts downloaded from [Unity’s NavMeshComponents GitHub repository](https://github.com/Unity-Technologies/NavMeshComponents) , then remove those scripts and any associated files before you add the **AI Navigation** package to your project. If you don’t remove these scripts, you might get conflicts and errors related to these components in the Console. The new components mirror the same behavior as the old components do in your project except when using the following components:

-   The `NavMeshSurface` component now includes an option to use only the objects that have a `NavMeshModifier` in the baking process.
-   You can now specify whether or not to apply the `NavMeshModifier` component to child objects in the hierarchy.

## Reordering of nested prefab children is no longer supported as an override

In earlier Unity versions, it was possible to reorder the child GameObjects of a nested prefab instance and save this new order as an override. As of Unity 2022.3, this behavior is no longer supported. This change was made to make the prefab system more robust and predictable, and avoid situations where modifications to overrides became too complex and would change UI and other elements in unpredictable ways.

When you upgrade a project to Unity 2022.3 or later, any such child reordering overrides are discarded. The child GameObjects of nested prefab instances revert to the order defined in their original prefab asset.

Potential impact:

-   UI rendering issues: UGUI components rely on hierarchy order for rendering. Reordered UI elements may appear in unexpected layers or positions.
-   Script logic issues: Scripts that depend on specific sibling indices or GameObject ordering may behave unexpectedly.
-   Animation and interaction issues: Components that reference child objects by index position may target incorrect objects.

For example, consider the following prefab structure:

-   Prefab B
    -   Child 1
    -   Child 2
-   Prefab A
    -   Prefab B
        -   Child 2
        -   Child 1

Before upgrade: **Prefab A** shows **Prefab B** children in this order: **Child 2**, **Child 1** (reordered).

After upgrade: **Prefab A** shows **Prefab B** children in this order: **Child 1**, **Child 2** (reverted to original order).

### How to identify and fix affected prefabs

Since changes to prefabs might not be immediately obvious, we recommend identifying affected prefabs before upgrading your project. You can do this by running an Editor script that saves a snapshot of all prefab hierarchies. After upgrading, you can run the script again to compare the new hierarchies against the snapshot and generate a report of any prefabs whose child order has changed.

Once you have identified an affected prefab, you must manually fix the hierarchy. Since you can no longer save a reordering override on a nested prefab’s children, the solution is to unpack the specific children that need to be reordered, making them local to the parent prefab.

Follow these steps to manually fix an affected prefab:

1.  In the upgraded project, open the parent prefab that contains the nested prefab instance with the incorrect child order.
2.  In the **Hierarchy** view, find the child GameObject within the nested prefab that you need to move.
3.  Duplicate this child GameObject. The duplicate is created as a new, regular GameObject within the parent prefab, and is not part of the nested prefab instance.
4.  Move this duplicated GameObject to its correct position in the hierarchy.
5.  Delete the original child GameObject from the nested prefab instance. This operation is stored as a “removed GameObject” override on the parent prefab.
6.  Rename the duplicated GameObject to match the original’s name.

## Additional resources

-   [Install Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/GettingStartedInstallingUnity.html)
-   [API updater](https://docs.unity3d.com/6000.3/Documentation/Manual/APIUpdater.html)
