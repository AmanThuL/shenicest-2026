---
title: "Upgrade to Unity 6.0"
page_title: "Unity - Manual: Upgrade to Unity 6.0"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html"
topic: "unity6-release"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Upgrade to Unity 6.0

This page lists changes in Unity 6.0 that might affect existing projects when you upgrade them from 2022 LTS version to Unity 6.0.

-   [Render pipelines](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#ren-pipe)
-   [Gaussian Filter Radius properties from LightingSettings are now floating point values](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#gaussian-filter)
-   [Improvements to light probe energy conservation](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#light-probe)
-   [Enlighten Baked Global Illumination is no longer available](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#enlighten-baked-gi)
-   [Android: Java class UnityPlayer needs to be renamed to UnityPlayerForActivityOrService](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#android-unityplayer)
-   [Android: UnityPlayer java class no longer extends FrameLayout](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#android-framelayout)
-   [Android: Build tools update](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#android-build-tooling)
-   [FetchFirstCompatibleTypeUsingScriptableRenderPipelineExtension replaced by GetDerivedTypesSupportedOnCurrentPipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#api-fetchfirstcompatible)
-   [CustomEditorForRenderPipelineAttribute and VolumeComponentMenuForRenderPipelineAttribute deprecated](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#api-deprecated)
-   [Environment lighting: Ambient probe and skybox Reflection Probe are no longer baked by default](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#environment-lighting)
-   [Auto-generated lighting has been removed](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#auto-generated-lighting)
-   [DepthAuto, ShadowAuto, and VideoAuto graphics formats are now obsolete](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#depthauto-shadowauto-videoauto)
-   [Mipmap Limits no longer affect runtime Textures by default](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#mipmap-limits)
-   [Enhanced custom controls creation with UXML](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#enhanced-custom-controls-creation-with-uxml)
-   [Assets/Create menu and ScriptTemplates have been reorganized](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#assets-create-menu-and-scripttemplates-have-been-reorganized)
-   [UI Toolkit event handling reorganization and simplification](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#ui-toolkit-event-handling-reorganization-and-simplification)
-   [Buffer layout changes in Metal](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#buffer-layout-changes-in-metal)
-   [Packages folder in the global package cache is no longer used](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#global-cache-packages-folder)
-   [UPM_CACHE_PATH and UPM_NPM_CACHE_PATH environment variables are no longer supported](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#upm-cache-path)
-   [Default Android tools versions have changed](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#default-android-tools)
-   [Version of 7-Zip included with the Unity Editor no longer supports zstandard compression](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#7-zip-no-longer-supports-zstandard)
-   [Object.FindObjectsOfType and Object.FindObjectOfType are obsolete](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#object-findobjects)
-   [Physics: Changed how torque is computed when ForceMode.VelocityChange or ForceMode.Acceleration is used](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#physics-accvelchange)

<span id="ren-pipe"></span>

## Render pipelines

This upgrade guide describes how to upgrade to the Unity 6.0 version of Unity’s Built-In Render Pipeline. To upgrade other render pipelines, refer to:

-   [Upgrade URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/upgrade-guides.html)
-   [Upgrade HDRP](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.0/manual/upgrade-guides.html)

To upgrade other packages, refer to the documentation for the packages you’re using.

<span id="gaussian-filter"></span>

## Gaussian Filter Radius properties from LightingSettings are now floating point values

The [Progressive Lightmapper](https://docs.unity3d.com/6000.3/Documentation/Manual/progressive-lightmapper.html) includes a **Gaussian** option among its **Advanced** filtering options (**Lighting Window \> Lightmapping Settings \> Filtering \> Direct Filter \> Gaussian**). The **Radius** control for **Gaussian** filtering now supports decimal increments, such as 0.5. Previously, this control only supported integer steps (1 to 5).

As a result of this change, these properties are now deprecated in the C# API:

-   `int LightingSettings.filteringGaussRadiusAO`
-   `int LightingSettings.filteringGaussRadiusDirect`
-   `int LightingSettings.filteringGaussRadiusIndirect`

The floating point replacements for the deprecated properties are:

-   `float LightingSettings.filteringGaussianRadiusAO`
-   `float LightingSettings.filteringGaussianRadiusDirect`
-   `float LightingSettings.filteringGaussianRadiusIndirect`

You can call one of the deprecated member functions to round the Gaussian filter radius to the nearest integer.

<span id="light-probe"></span>

## Improvements to light probe energy conservation

Light Probes are now as bright as lightmaps. Previously, Unity’s Light Probes were only 94% as bright as they should be. For this reason, objects lit with light probes appeared a bit darker than objects lit with lightmaps. Because of the subtlety of this change, it is possible that many users won’t see a noticeable difference.

Should you prefer the old appearance, you can achieve it in the following way:

1.  Bake light probes.
2.  Use C# to get a copy of the array [LightmapSettings.lightProbes.bakedProbes](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LightProbes-bakedProbes.html).
3.  For each SphericalHarmonicsL2 instance, multiply coefficient 0 with 16/17.
4.  Write your copy of the array back into [LightmapSettings.lightProbes.bakedProbes](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LightProbes-bakedProbes.html).

<span id="enlighten-baked-gi"></span>

## Enlighten Baked Global Illumination is no longer available

The Enlighten Baked Global Illumination lightmapping backend is no longer available.

When you upgrade a project to this version, Unity removes the Enlighten baking backend from the lightmapper selection dropdown and substitutes a Progressive Lightmapper in every Scene where you’ve selected the Enlighten baking backend.

On Apple silicon devices, Unity substitutes the Progressive GPU Lightmapper for the Enlighten baking backend. On all other devices, Unity selects the CPU Progressive Lightmapper.

Enlighten precomputed Realtime Global Illumination is still available and is supported up until Unity 6.

<span id="android-unityplayer"></span>

## Android: Java class UnityPlayer needs to be renamed to UnityPlayerForActivityOrService

The `UnityPlayer` Java class has been replaced by two new bridge classes, `UnityPlayerForActivityOrService` and `UnityPlayerForGameActivity`. These new classes both derive from `UnityPlayer`, but public methods such as `displayChanged` and `windowFocusChanged` have moved from `UnityPlayer` specifically to `UnityPlayerForActivityOrService`.

If you [extend the default Unity activity](https://docs.unity3d.com/6000.3/Documentation/Manual/AndroidUnityPlayerActivity.html) and use the `UnityPlayer` class, you might encounter compile errors. In this case, rename `UnityPlayer` to `UnityPlayerForActivityOrService`.

<span id="android-framelayout"></span>

## Android: UnityPlayer java class no longer extends FrameLayout

The `UnityPlayer` Java class no longer extends `FrameLayout`. If you need to access `FrameLayout`, call the `getFrameLayout` function on the `UnityPlayer` instance.

<span id="android-build-tooling"></span>

## Android: Build tools update

Android build tooling versions for Gradle and Android Gradle Plugin (AGP) are updated to ensure compatibility with the latest Android development tools. The updated versions are as follows:

| **Tool**   | **Previous version** | **Updated version** |
|:-----------|:---------------------|:--------------------|
| **Gradle** | 8.13                 | 9.1.0               |
| **AGP**    | 8.10.0               | 9.0.0               |

For an overview of the changes these updates introduce, refer to the [What’s new in Unity 6.0](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#android).

Unity automatically applies this update in most projects. You might need to make manual changes if any of the following apply:

-   Custom Gradle templates are enabled in **Player Settings** > **Publishing Settings** or your project includes `mainTemplate.gradle` or `launcherTemplate.gradle`.
-   Your project uses older third-party plug-ins that are not updated for Gradle and AGP updates.

To ensure a smooth transition, take the following actions, where applicable:

-   If you have **Custom Gradle Template** enabled, review your `.gradle` files for deprecated attributes. Unity displays a dialog on build when any deprecated attributes are detected and automatically renames them to use their newer versions.

-   Check for updates from third-party SDK providers, such as Ads and Analytics providers, to ensure they support AGP 9.0.0.

-   For projects with custom logic in `.gradle` templates, make sure to review the deprecated APIs listed in the official [AGP release notes](https://developer.android.com/build/releases/agp-9-0-0-release-notes#:~:text=Deprecated%20API%20in%20the%20android%20block).

-   Configure unique namespaces for any custom Android plug-ins or libraries in your project. Set the namespace in either:

    -   `AndroidManifest.xml`: package=“com.example.library.unique”
    -   `build.gradle`: namespace “com.example.library.unique”

<span id="api-fetchfirstcompatible"></span>

## FetchFirstCompatibleTypeUsingScriptableRenderPipelineExtension replaced by GetDerivedTypesSupportedOnCurrentPipeline

`RenderPipelineEditorUtility.FetchFirstCompatibleTypeUsingScriptableRenderPipelineExtension` is now deprecated. Use [GetDerivedTypesSupportedOnCurrentPipeline](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RenderPipelineEditorUtility.GetDerivedTypesSupportedOnCurrentPipeline.html) instead. This method’s signature is also different; now it returns all derived types, not just the first one it encounters. This prevents inconsistencies, because Unity does not guarantee type order.

<span id="api-deprecated"></span>

## CustomEditorForRenderPipelineAttribute and VolumeComponentMenuForRenderPipelineAttribute deprecated

CustomEditorForRenderPipelineAttribute and VolumeComponentMenuForRenderPipelineAttribute are now deprecated. Use [CustomEditor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CustomEditor.html) and [VolumeComponentMenu](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@15.0/api/UnityEngine.Rendering.VolumeComponentMenu.html) instead. To restrict the choice of pipeline when these attributes are active, combine them with [SupportedOnRenderPipelineAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.SupportedOnRenderPipelineAttribute.html) and specify a [RenderPipelineAsset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RenderPipelineAsset.html) type. If you want to activate an SRP attribute that does work with the Built-In Render Pipeline, use [SupportedOnRenderPipelineAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.SupportedOnRenderPipelineAttribute.html) without parameters. This provides a unified workflow for both attributes when there’s a need to activate them on a specific pipeline.

<span id="environment-lighting"></span>

## Environment lighting: Ambient probe and skybox Reflection Probe are no longer baked by default

Unity’s Progressive Lightmapper no longer bakes the ambient probe and the skybox Reflection Probe by default, and the **Recalculate Environment Lighting** setting in the **Lighting** window has been removed.

To avoid a newly created scene having no environment lighting, Unity assigns a default [Lighting Data Asset](https://docs.unity3d.com/6000.3/Documentation/Manual/LightmapSnapshot.html) containing environment lighting that matches the default skybox material.

You must select **Generate Lighting** in the **Lighting** window in the following cases:

-   To fix the lights in a scene where you rely on the previous automatic baking behavior.
-   To see lighting changes in a new scene if you change the environment lighting settings.

If you rely on the previous automatic baking behavior but you use the default environment lighting settings, Unity upgrades the scene to use the default Lighting Data Asset.

<span id="auto-generated-lighting"></span>

## Auto-generated lighting has been removed

The **Auto Generate** setting in the **Lighting** window has been removed, and related APIs are now obsolete.

To generate baked lighting for a scene, you can do any of the following:

-   Select **Generate Lighting** in the **Lighting** window.
-   Use the `Lightmapping.Bake` API.
-   Use the `Lightmapping.BakeAsync` API.

To check lightmaps while you’re editing, you can now select a [Scene View Draw Mode](https://docs.unity3d.com/6000.3/Documentation/Manual/GIVis.html) and set **Lighting Data** to **Preview**. This displays a preview of the baked lighting. The preview lightmaps are non-destructive, and you can use them after you’ve baked the scene.

If a scene relies on auto-generated lighting, it no longer has its baked lighting. Select **Generate Lighting** in the **Lighting** window to re-bake the lighting manually.

If you use a script to open a scene, you must now use `Lightmapping.Bake` or `Lightmapping.BakeAsync` instead of waiting for auto-generated lighting to complete.

<span id="depthauto-shadowauto-videoauto"></span>

## DepthAuto, ShadowAuto and VideoAuto graphics formats are now obsolete

The following graphics formats, which were [previously deprecated in 2022.1](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuide2021LTS.html#Graphics), are now obsolete and produce compile errors if you use them:

-   `GraphicsFormat.DepthAuto`
-   `GraphicsFormat.ShadowAuto`
-   `GraphicsFormat.VideoAuto`

The [GraphicsFormatUtility.GetGraphicsFormat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Experimental.Rendering.GraphicsFormatUtility.GetGraphicsFormat.html) API no longer returns the obsolete formats. Instead it does the following:

-   Translates `RenderTextureFormat.Depth` to `GraphicsFormat.None` instead of `GraphicsFormat.DepthAuto`. `GraphicsFormat.None` indicates depth-only rendering.
-   Translates `RenderTextureFormat.Shadowmap` to `GraphicsFormat.None` instead of `GraphicsFormat.ShadowAuto`. If you create a render texture with the `GraphicsFormat.None` format, you must set RenderTextureDescriptor.shadowSamplingMode to ShadowSamplingMode.CompareDepths to enable depth-compare sampling.

Because `GraphicsFormat.DepthAuto` and `GraphicsFormat.ShadowAuto` were both considered depth stencil formats but used as colors formats, you may need to adjust your code.

For example, in the following snippet, `GraphicsFormatUtility.IsDepthFormat` returns `false` instead of `true`:

``` lang-cs
RenderTextureDescriptor desc = new RenderTextureDescriptor(256, 256, RenderTextureFormat.Depth, 32);
bool isDepthOnly = GraphicsFormatUtility.IsDepthFormat(desc.graphicsFormat);
```

To check if a `RenderTexture` or `RenderTextureDescriptor` is depth-only, use one of the following:

-   `if (renderTexture.graphicsFormat == GraphicsFormat.None && renderTexture.depthStencilFormat != GraphicsFormat.None)`
-   `if (renderTexture.format == RenderTextureFormat.Depth || renderTexture.format == RenderTextureFormat.Shadowmap)`

<span id="mipmap-limits"></span>

## Mipmap Limits no longer affect runtime Textures by default

Runtime-created 2D textures will no longer have their mipmap upload limited by default. Before, mipmap limits had to be disabled explicitly via the Texture2D constructor (by providing an `ignoreMipmapLimit` boolean parameter when the constructor is called with a TextureFormat, or the `IgnoreMipmapLimit` TextureCreationFlag when it’s called with a GraphicsFormat), or by toggling `tex.ignoreMipmapLimit` of a constructed texture. This behavior has changed: **mipmap limits are now opt-in for runtime-created 2D textures**.

Without making project changes, in the following cases users miss out on GPU bandwidth and memory optimizations, and potentially see a better quality than intended because textures are now getting uploaded at full resolution:

-   Users who unknowingly expect runtime textures to follow the quality settings.
-   Users who intentionally wanted runtime textures to follow the quality settings and achieved this by using any default Texture2D-constructor.

In following cases, users are not affected by this change:

-   Users who explicitly wanted runtime textures to remain full-resolution.
-   Users who intentionally wanted runtime textures to follow the quality settings and achieved by making the following explicit:
    -   Using a constructor with a TextureFormat, with `false` for `ignoreMipmapLimit`,
    -   Setting `tex.ignoreMipmapLimit` to `false` after construction.

These users may want to upgrade their scripts if they use deprecated constructors.

To upgrade your scripts, use a Texture2D constructor with a `MipmapLimitDescriptor` to indicate that a runtime Texture should be affected by the quality settings.

This change was made for consistency with the new mipmap limit support for Texture2DArrays. Rather than having each texture shape define its own default mipmap limit behavior, we opt for consistency and have decided that runtime textures should explicitly enable mipmap limits. This opt-in behavior is preferred over opt-out because runtime textures are often used in more versatile ways where unexpectedly uploading fewer mips than expected could be more harmful than unexpectedly uploading more mips.

<span id="enhanced-custom-controls-creation-with-uxml"></span>

## Enhanced custom controls creation with UXML

Simplified the creation of custom controls with UXML in UI Toolkit. This change makes the workflow faster and easier to use.

A key improvement is the introduction of [`UxmlElement`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UxmlElementAttribute.html) and [`UxmlAttribute`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UxmlAttributeAttribute.html) attributes. These attributes simplify attribute authoring and automatically derive the attribute names from property names, eliminating the need for UxmlTraits and UxmlFactory classes.

You can now [create custom attribute converters](https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/custom-control-attributes-complex-data-types.html) for specific data types, ensuring seamless conversion of values to and from UXML attribute strings. We’ve also enhanced [`UxmlObjects`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UxmlObjectAttribute.html), allowing custom, non-visual elements to be defined within visual elements. The new system leverages the Unity serialization and uses a source generator to create [`UxmlSerializedData`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UxmlSerializedData.html) classes for elements from all `UxmlAttribute` definitions for each custom element class, enabling support for custom property drawers, decorators, and various attributes.

Additionally, the introduction of attribute overrides allows for greater flexibility when you work with inherited attributes to [override the behavior of UXML attributes](https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/custom-control-customize-uxml-attributes.html#override-the-behavior-of-the-uxml-attributes). These improvements provide a more efficient and user-friendly experience for creating complex custom control in Unity 6.0 and beyond.

For more examples and information, refer to [Migrate custom control from an earlier version to Unity 6](https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/migrate-custom-control.html).

<span id="assets-create-menu-and-scripttemplates-have-been-reorganized"></span>

## Assets/Create menu and ScriptTemplates have been reorganized

The **Assets/Create** menu has been reorganized and categorized. As part of this overhaul, the Unity Built-In ScriptTemplate files have been renamed.

Users who have added elements to the **Assets/Create** menu with either `CreateAssetMenuAttribute`, `MenuItemAttribute` or a Custom ScriptTemplate might want to change their menu item’s priority as it’s placement relative to other elements is now different.

Users who were creating assets by executing these menu items with the `EditorApplication.ExecuteMenuItem` API, must verify the new path to the menu item.

Users who have previously overridden the Unity Built-In ScriptTemplates must update the names of their override files to ensure they match the new names of the Built-In Templates.

<span id="ui-toolkit-event-handling-reorganization-and-simplification"></span>

## UI Toolkit event handling reorganization and simplification

The `ExecuteDefaultAction` and `ExecuteDefaultActionAtTarget` methods have been deprecated. The following methods are added to replace them:

-   `HandleEventTrickleDown`
-   `HandleEventBubbleUp`

Unity executes these new methods on each element in the event dispatching path immediately after `TrickleDown` and before `BubbleUp` callbacks of that element. During those methods, the dispatching phase is set to `TrickleDown` or `BubbleUp` accordingly and the event’s `currentTarget` coincides with the element executing the method.

The `AtTarget` dispatching phase and the `PreventDefault` method have been deprecated. Calling `StopPropagation` or `StopPropagationImmediately` now stops further executing `HandleEventTrickleDown` and `HandleEventBubbleUp` at the same time as it stops further invocation of the `TrickleDown` and `BubbleUp` callbacks.

In most cases, if you don’t upgrade to the new methods, your code should not alter its behavior significantly. UI Toolkit still calls the obsolete methods in the same order as before, or with minimal adjustments. However, all the standard controls within UI Toolkit have migrated to using the new methods, aligning their logic execution order accordingly. Mixing calls to obsolete methods with the use of upgraded controls might lead to some logic being out of sync compared to previous Unity versions.

To upgrade existing code to the new methods, proceed as follows:

-   Replace `ExecuteDefaultAction` and `ExecuteDefaultActionAtTarget` by `HandleEventBubbleUp` and `PreventDefault` by `StopPropagation` (or remove calls to `PreventDefault` if `StopPropagation` has already been called in the same code block). This covers the majority of cases.
-   If you have problems because of old code calling `PreventDefault` during a `BubbleUp` callback, which is no longer possible and can’t be replaced by StopPropagation because the event has already reached its target, consider adding a callback during the `TrickleDown` phase to call `StopPropagation`. This step is generally sufficient to address such scenarios.
-   In rare cases where the above changes aren’t adequate to maintain the functionality of the old code, a thorough case-by-case analysis is necessary. The resolution might not always be straightforward in these contexts.

<span id="buffer-layout-changes-in-metal"></span>

## Buffer layout changes in Metal

The cross compilation of Unity shaders to Metal shaders has changed with respect to buffer layouts. Any buffer that contains min16float, half or real types now have a different memory layout compared to previous versions of Unity.

You need to act only if you’re targeting Metal and using APIs that write raw data directly to buffers, for example:

-   [ComputeBuffer.SetData](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ComputeBuffer.SetData.html)
-   [GraphicsBuffer.SetData](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GraphicsBuffer.SetData.html)
-   [CommandBuffer.SetBufferData](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CommandBuffer.SetBufferData.html)

You don’t need to act if you use only [CommandBuffer.SetComputeFloatParam](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.CommandBuffer.SetComputeFloatParam.html) or [Material.SetFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetFloat.html).

More specifically, HLSL min16float, half and real inside buffers are always converted to 32-bit MSL float, whereas in previous Unity versions they could be converted to 16-bit MSL half, depending on the target platform.

If you have tested your shaders only on Metal platforms, check the buffers in the generated MSL code to ensure the layout matches the buffer data that’s accessed in C#. You can test whether this change impacts your shaders by adding `#pragma metal_fxc_allow_float16_in_cpu_visible_buffers` to your shader code and seeing if any visual artifact is fixed. If you notice a difference, remove this pragma and adjust your shader and C# code so that it works correctly without the pragma, to improve the cross-platform compatibility of your project.

To use native 16-bit floats in buffers, consider using the DXC HLSL compiler and adding `#pragma require Native16Bit` to your shader. But note that using DXC in Unity is still in an experimental stage.

<span id="global-cache-packages-folder"></span>

## Packages folder in the global package cache is no longer used

The [global package cache](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-cache.html) contains several subfolders. One of those subfolders, `packages`, is no longer used by the Package Manager.

You need to act only if you have automation scripts or pipelines that interact directly with the global package cache’s `packages` subfolder, for example, if you use the [`UPM_CACHE_PATH` environment variable](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#upm-cache-path). If so, you can remove the references. Unity doesn’t offer a direct replacement subfolder for `packages`. Packages are now extracted directly to the project cache.

If you no longer maintain projects created with Unity 2023.2, you can safely delete the `packages` subdirectory from the global package cache root. This operation is optional.

<span id="upm-cache-path"></span>

## UPM_CACHE_PATH and UPM_NPM_CACHE_PATH environment variables are no longer supported

Previous versions of the Unity Editor supported the following environment variables:

-   `UPM_CACHE_PATH`, to specify the absolute path to the location where you want the Package Manager to store the uncompressed contents of package tarballs.
-   `UPM_NPM_CACHE_PATH`, to specify the absolute path for Package Manager’s registry data cache.

You need to act only if you have automation scripts or pipelines that set path values for `UPM_CACHE_PATH` or `UPM_NPM_CACHE_PATH`:

-   There’s no replacement for `UPM_CACHE_PATH` because packages are now extracted directly to the project cache. However, you can use the `UPM_CACHE_ROOT` environment variable to set the root of the global cache. Note that the global cache root is the parent directory to the subfolder formerly associated with `UPM_CACHE_PATH`.
-   There’s no replacement for `UPM_NPM_CACHE_PATH`. However, you can use the `UPM_CACHE_ROOT` environment variable, which is the parent directory for `UPM_NPM_CACHE_PATH`. Use `UPM_CACHE_ROOT` instead of `UPM_NPM_CACHE_PATH` and adjust the values in your scripts or pipelines.

For more information, refer to [Customize the global cache](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-config-cache.html).

<span id="default-android-tools"></span>

## Default Android tools versions have changed

Unity has updated the default versions of the following tools used by Android. The default versions of NDK, SDK Command Line Tools, and SDK Tools remain unchanged. The updated versions are as follows:

| **Tool**                       | **Version** |
|:-------------------------------|:------------|
| **Gradle**                     | 8.4         |
| **Android Gradle Plugin**      | 8.3.0       |
| **SDK Build Tools**            | 34.0.0      |
| **SDK Platform Tools**         | 34.0.5      |
| **Java Development Kit (JDK)** | 17          |

If your project uses [custom gradle templates](https://docs.unity3d.com/6000.3/Documentation/Manual/gradle-templates.html), consider recreating those templates to avoid any build issues with the updated Android Gradle Plugin version. For more information, refer to [Modify Gradle project files with Gradle template files](https://docs.unity3d.com/6000.3/Documentation/Manual/android-modify-gradle-project-files-templates.html).

<span id="7-zip-no-longer-supports-zstandard"></span>

## Version of 7-Zip included with the Unity Editor no longer supports zstandard compression

Previous Unity Editor versions included a 7-Zip fork that supported zstandard compression:

-   Windows versions included [7-Zip-zstd](https://github.com/Unity-Technologies/7-Zip-zstd), a fork of [mcmilk/7-Zip-zstd](https://github.com/mcmilk/7-Zip-zstd) which is a fork of upstream 7-Zip version 22.01. This code is vulnerable to several known security issues, such as [CVE–2023–31102](https://www.cve.org/CVERecord?id=CVE-2023-31102) and [CVE–2023–40481](https://www.zerodayinitiative.com/advisories/ZDI-23-1164/).

-   macOS and Linux versions included [p7zip-zstd](https://github.com/Unity-Technologies/p7zip-zstd), a fork of [tehmul/p7zip-zstd](https://github.com/tehmul/p7zip-zstd) (abandoned in 2017), which is a fork of [p7zip](https://p7zip.sourceforge.net/) (abandoned in 2016), which is a fork of upstream 7-Zip. This code is vulnerable to several known security issues, such as [CVE–2016–7804](https://www.cve.org/CVERecord?id=CVE-2016-7804), [CVE–2017–17969](https://www.cve.org/CVERecord?id=CVE-2017-17969), [CVE–2018–10115](https://www.cve.org/CVERecord?id=CVE-2018-10115), [CVE–2018–10172](https://www.cve.org/CVERecord?id=CVE-2018-10172), [CVE–2018–5996](https://www.cve.org/CVERecord?id=CVE-2018-5996), [CVE–2023–31102](https://www.cve.org/CVERecord?id=CVE-2023-31102) and [CVE–2023–40481](https://www.zerodayinitiative.com/advisories/ZDI-23-1164/).

Unity 6.0 includes the regular upstream version 23.01 of 7-Zip for Windows, macOS, and Linux Editors. However, this upstream version of 7-Zip doesn’t support zstandard compression or decompression for .zip or .7z archives. It also lacks support for additional compression formats and hash algorithms added in the [mcmilk/7-Zip-zstd](https://github.com/mcmilk/7-Zip-zstd) fork.

If you have packages that use 7za or 7z.exe binaries that operate on archives using zstandard compression, use one of the following options:

-   Use an alternative compression format, such as .zip archives using the deflate algorithm or .7z archives using LZMA or LZMA2.
-   Provide your own binaries that support the required archive formats and compression algorithms.

<span id="object-findobjects"></span>

## Object.FindObjectsOfType and Object.FindObjectOfType are obsolete

`Object.FindObjectsOfType` is now obsolete. Use [`Object.FindObjectsByType`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindObjectsByType.html) instead.

`Object.FindObjectOfType` is now obsolete. Use [`Object.FindFirstObjectByType`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindFirstObjectByType.html) or [`Object.FindAnyObjectByType`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindAnyObjectByType.html) instead.

These now obsolete functions automatically sorted the results by Instance ID before returning them to you. This process takes time, especially when the list of objects is large (for example, more than 100 objects).

The new `ByType` functions take a sort mode (`FindObjectsSortMode`) as a parameter. Choosing to pass in `FindObjectsSortMode.InstanceID` behaves as before and returns the objects sorted by Instance ID. If you instead pass in `FindObjectsSortMode.None`, the list returns unsorted, which can be significantly faster. It’s recommended that you use `FindObjectsSortMode.None`.

<span id="physics-accvelchange"></span>

## Physics: Changed how torque is computed when ForceMode.VelocityChange or ForceMode.Acceleration is used

`Rigidbody.AddForceAtPosition` and `Rigidbody.AddExplosionForce` now apply a different amount of torque when using `ForceMode.VelocityChange` or `ForceMode.Acceleration` than they did in Unity 2022 LTS and earlier. This is the result of fixing a mathematical error caused by multiplying angular forces via mass, which was not correct. Now, the applied force is scaled by the inertia tensor matrix.

If the change to the amount of torque being applied impacts your project, you can re-create the logic used in Unity 2022 and prior. Update the impacted methods to multiply the force used by the body’s mass, and then switch `ForceMode.Acceleration` to `ForceMode.Force`, and `ForceMode.VelocityChange` to `ForceMode.Impulse`. For example:

| Before                                                                     | After                                                                           |
|:---------------------------------------------------------------------------|:--------------------------------------------------------------------------------|
| `body.AddForceAtPosition(force, pos, ForceMode.Acceleration)`              | `body.AddForceAtPosition(force * body.mass, pos, ForceMode.Force)`              |
| `body.AddForceAtPosition(force, pos, ForceMode.VelocityChange)`            | `body.AddForceAtPosition(force * body.mass, pos, ForceMode.Impulse)`            |
| `body.AddExplosionForce(force, pos, radius, up, ForceMode.Acceleration)`   | `body.AddExplosionForce(force * body.mass, pos, radius, up, ForceMode.Force)`   |
| `body.AddExplosionForce(force, pos, radius, up, ForceMode.VelocityChange)` | `body.AddExplosionForce(force * body.mass, pos, radius, up, ForceMode.Impulse)` |

## Additional resources

-   [What’s New in Unity 6.0](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html)
-   [System requirements](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html)
-   [Install Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/GettingStartedInstallingUnity.html)
-   [API updater](https://docs.unity3d.com/6000.3/Documentation/Manual/APIUpdater.html)
