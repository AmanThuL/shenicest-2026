---
title: "New in Unity 6.2"
page_title: "Unity - Manual: New in Unity 6.2"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity62.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity62.html"
topic: "unity6-release"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# New in Unity 6.2

Unity 6.2 (6000.2) introduces several new features and improvements.

To read about all of the changes and known issues in this version of Unity, refer to the [Unity 6.2 Release Notes](https://unity.com/releases/editor/whats-new/6000.2.0#notes).

To find the release notes for other releases, refer to the [Unity download archive](https://unity.com/releases/editor/archive).

To read about changes made to packages that were updated as part of this release, refer to the [documentation of those packages](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-docs.html).

If you’re upgrading existing projects from Unity 6.1 (6000.1), refer to [Upgrade to Unity 6.2](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity62.html) for information about how your project might be affected.

Review the new features and improvements for Unity 6.2 in these areas:

-   [2D](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity62.html#2d)
-   [Assets and media](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity62.html#assets-and-media)
-   [Diagnostic data](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity62.html#diagnostic-data)
-   [Editor and workflow](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity62.html#editor-and-workflow)
-   [Entities](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity62.html#entities)
-   [Graphics](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity62.html#graphics)
-   [Package Manager](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity62.html#package-manager)
-   [Platforms](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity62.html#platforms)
-   [Programming](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity62.html#programming)
-   [UI Toolkit](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity62.html#ui-toolkit)
-   [Unity AI](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity62.html#unity-ai)
-   [XR](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity62.html#xr)

<span id="2d"></span>

## 2D

This section outlines recent updates to Unity’s 2D system.

### Added a toggle to preview changes made in the Sprite Editor window in the Scene view

The Sprite Editor window now includes a toggle to preview changes to sprites directly in the Scene view. This feature allows you to preview changes made to Sprite Rect sizes and pivot positions.

<span id="assets-and-media"></span>

## Assets and media

The previous default behavior of the Unity Editor to perform a forced garbage collection (GC) of the managed heap and an Asset GC (that is unloading of unused assets) when loading scenes is now optional. You can enable this behavior in the following ways:

-   A new **Force GC on Scene Loads** option in the **Editor** section of the [Project Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-EditorManager.html) window
-   A new [forceAssetUnloadAndGCOnSceneLoad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorSettings-forceAssetUnloadAndGCOnSceneLoad.html) property of the [EditorSettings](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorSettings.html) API

<span id="diagnostic-data"></span>

## Diagnostic data

New Unity projects created in 6.2 and later automatically collect diagnostic data by default, as part of the [Developer Data framework](https://docs.unity.com/en-us/cloud/developer-data-framework). This data is used to improve Engine performance and stability by providing real-world insights from live gameplay on actual devices. This allows Unity to prioritize and deliver critical fixes faster. You can choose to disable data collection in [Project Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/diagnostics-settings.html) or for specific builds in your project’s [Build Profiles](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-override-settings.html).

Unity uses the diagnostic data collected to power the [Diagnostics](https://docs.unity.com/en-us/cloud/developer-data/diagnostics) feature in the Unity Dashboard. Use Diagnostics to view information about your project’s performance and stability, and monitor crashes and issues that affect your users. This includes information on Application Not Responding (ANR) errors for Android projects.

<span id="editor-and-workflow"></span>

## Editor and workflow

The **Diagnostics** tab in the **Preferences** window has been renamed to [**Editor Diagnostics**](https://docs.unity3d.com/6000.3/Documentation/Manual/preferences-editor-diagnostics.html).

<span id="entities"></span>

## Entities

For a complete description of new features and improvements in the Entities package, refer to [What’s new in Entities 1.4](https://docs.unity3d.com/Packages/com.unity.entities@1.4/manual/whats-new.html).

### Entity Component System (ECS) updates and improvements

The [Unity Vehicles](https://docs.unity3d.com/Packages/com.unity.vehicles@0.1/manual/index.html) package is released in an experimental state. Unity Vehicles is a universal vehicle controller compatible with the ECS that covers a wide range of vehicle types and configurations. The package targets a medium level of vehicle physics realism, striking a balance between performance and fidelity. It’s compatible with Unity Netcode for Entities and supports client prediction.

<span id="graphics"></span>

## Graphics

This section outlines recent updates to Unity’s graphics systems.

### Mesh LOD: Automatically generate level of detail meshes

Added the ability to automatically generate level of detail (LOD) meshes at import, so you can optimize assets and reduce iteration times without the need for external tools.

By storing all LODs within a single mesh, Mesh LOD minimizes memory usage while simplifying workflows for both static and skinned meshes.

Mesh LOD is ideal for high-poly models, and ensures seamless scalability and improved performance. For more information, refer to the [Mesh LOD documentation](https://docs.unity3d.com/6000.3/Documentation/Manual/lod/mesh-lod-landing.html).

### Added support for prepass layers in URP

To set the layers that GameObjects must be assigned to so they affect prepasses only, use the new **Prepass Layer Mask** property in the [Universal Renderer asset](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-universal-renderer.html). This property allows you to include layers in the depth prepass that contain objects from a Render Object Renderer Feature, so effects like screen space ambient occlusion (SSAO) and decals work correctly with those objects.

### Shader Graph

This section outlines recent updates to Shader Graph.

#### New Append node

Shader Graph now includes an [Append node](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.2/manual/Append-Node.html) that combines two floats or vector inputs of different types into a single new vector of variable dimensions.

This node simplifies the process of combining vectors. You no longer need to use Split nodes and a Combine node.

#### Dynamic branching option for keywords

You can now set up keywords for dynamic branching directly from your shader graph through the keyword **Definition** parameter, which already includes options related to the use of shader variants.

This new option provides more flexibility to design your shader branching behavior strategy and balance keyword impacts on performance at build time and runtime, without having to edit your shader code.

For more details, refer to [Keyword impact optimization](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.2/manual/Keywords-concepts.html).

#### Improved support for material property attributes and drawers

Shader Graph [property parameters](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.2/manual/Property-Types.html) now better reflect the options available when you write shader code to display material properties in the Inspector:

-   Added **Read Only** to allow the display of property values as read-only in the material inspector.
-   Added **Custom Attributes** to allow the creation of additional material property drawers like static decorators or complex controls. A new [Custom Material Property Drawers sample](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.2/manual/ShaderGraph-Samples.html) demonstrates the use of a min/max slider that controls `Vector2` values for range remapping.
-   Added an **Enum** mode to the **Float** property type to allow the display of a dropdown menu from either a list of explicit values or an existing enum type reference.
-   Added slider mode options to the **Float** property type to allow the use of a power (non-linear) slider or an integer slider.

### HDRP

This section outlines recent updates to High Definition Render Pipeline (HDRP).

#### Added AfterOpaqueColor injection point

Use this new injection point to add a custom render pass after Unity renders opaque GameObjects to the color buffer, but before sky and fog.

For more information, refer to [Create a custom pass](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.2/manual/Custom-Pass-Creating.html).

#### Updated FidelityFX Super Resolution 2 (FSR2) to version 2.2.1

Key fixes address resource clearing issues during Dynamic Resolution Scaling (DRS), artifacts caused by luma instability with strobing lights, and corrections to luma resource size for enhanced rendering accuracy.

#### Volumetric Fog improvements

You can now fine-tune fog scaling relative to specific areas or objects using the new Scale mode for Local Volumetric Fog components. Aliasing has also been reduced in punctual lights within volumetric fog.

#### New water sample

A new water sample has been added featuring current and deformation maps from the spline package.

### SRP core

This section outlines recent updates to SRP core.

#### Added API to query preferred platform defaults instead of hardcoded depth formats

There are many instances in SRP that default to a hardcoded depth format when deciding on a depth format. For some platforms, the format chosen has negative effects on performance.

To improve performance for such platforms, use `CoreUtils.GetDefaultDepthStencilFormat` and `CoreUtils.GetDefaultDepthBufferBits` to query the preferred depth format for the target platform instead of defaulting to a hardcoded format that doesn’t take the target platform into account.

#### Improved the Render Graph Subpass merging workflow

Unity optimizes how the Render Graph subpasses are merged to improve performance and reduce unnecessary checks:

-   The Editor first checks whether the number of subpasses exceeds system limits before running the more resource-intensive subpass merging check.
-   Merging behavior is now stricter, with early exits for mismatched output or input attachments if they don’t match existing ones in the subpass.

These changes help improve the efficiency of the Render Graph Subpass merging process without modifying any existing logic.

#### Optimized the Render Graph workflow in ExecuteBeginRenderPass

Unity now uses the values from the available `nativePass` data instead of retrieving the graph pass data in `ExecuteBeginRenderPass`to optimize the Render Graph workflow by reducing redundant lookups.

<span id="package-manager"></span>

## Package Manager

This section outlines recent updates to Unity’s Package Manager.

### Added button to switch from a nonregistry package to its registry counterpart

Added a version history entry for the registry version of packages that are also installed from nonregistry sources.

If you have a nonregistry version of a package that has the same version as a registry version of the package, two entries appear in the **Version history** tab. The **Update** button provides a convenient mechanism to switch to the registry version, instead of using the nonregistry version in your project. After switching, the Package Manager removes the nonregistry version from its version history, but the local package still exists on disk, with any customization intact. For more information, refer to [Switch to another version of a UPM package](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-update.html).

### Removed the overrideBuiltIns property

Removed the `overrideBuiltIns` property from the `scopedRegistries` array of the project manifest file (`manifest.json`). This change removes the ability to override the version of a built-in package with a version from a scoped registry. If you have any existing project manifest files that use `overrideBuiltIns`, Package Manager ignores the property. This change applies to all Unity 6 versions.

<span id="platforms"></span>

## Platforms

This section outlines recent updates to platform-specific tools and settings.

### Android

The following updates were made to Android-specific tools and settings:

-   Unity now supports Android SDK 36, allowing you to target your Android application for the latest Android 16 version. This support was introduced in Unity 6.2 and is available in Unity versions 2021.3 and later.
-   For new Unity Android projects, [Predictive Back Gesture](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettingsAndroid.html) is now enabled by default.

#### Monitor Application Not Responding errors

Unity now provides information on Application Not Responding (ANR) errors for Android projects. Use the [Diagnostics](https://docs.unity.com/en-us/cloud/developer-data/diagnostics) feature in the Unity Dashboard to view ANR errors and find out more information about when and why they occurred.

### Web Platform

Added preconfigured build profiles to the Web platform. These configurations optimize project settings for development or release on mobile or desktop devices.

For more information, refer to [Web setting configurations](https://docs.unity3d.com/6000.3/Documentation/Manual/web-setting-configurations.html).

### Build Profiles

You can now override the default [**Diagnostics**](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-override-settings.html) settings to collect diagnostics data per build profile through the **Build Profiles** window. The Diagnostics section is only visible when using a build profile on Android, iOS, macOS, and Windows platforms.

<span id="programming"></span>

## Programming

This section outlines recent updates to programming-specific tools and settings.

### Unity Test Framework

Unity Test Framework is now a [core package](https://docs.unity3d.com/6000.3/Documentation/Manual/pack-core.html) and its user manual is integrated with the core Unity manual.

To learn more, refer to [Testing your code](https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/test-framework-introduction.html).

### IL2CPP Code Generation

The [**IL2CPP Code Generation** Player setting](https://docs.unity3d.com/6000.3/Documentation/Manual/playersettings-windows.html#Configuration) is renamed as follows:

-   **Faster runtime** is now **Optimize for runtime speed**.
-   **Faster (smaller) builds** is now **Optimize for code size and build time**.

<span id="ui-toolkit"></span>

## UI Toolkit

This section outlines recent updates to Unity’s UI Toolkit.

### World Space UI support

You can now create World Space UI and position it alongside 2D or 3D objects in the Scene. This lets you move, rotate, and scale UI elements like any other object. It’s ideal for interactive elements, such as health bars or labels, that are tied directly to in-game objects or characters.

For more information, refer to [World Space UI](https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/world-space-ui.html).

### Customize text rendering

Use the new [TextElement.PostProcessTextVertices](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.TextElement.PostProcessTextVertices.html) API to modify the mesh vertices of each glyph immediately before UI Toolkit renders them. You can use this callback to customize the position, tint, and UV coordinates of the text at a low level.

For an example of how to use this API, refer to [Create custom text animation](https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/create-custom-text-animation.html).

### Advanced Text Generator: Best Fit support

The [Advanced Text Generator](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-advanced-text-generator.html) now fully supports the text Best Fit feature, which automatically adjusts text size to fit its container, enhancing text layout flexibility and adaptability.

The Best Fit feature also supports the following:

-   Ellipsis truncation
-   Word wrapping
-   Multiple alignments
-   Newlines

<span id="unity-ai"></span>

## Unity AI

Unity AI introduces a suite of [AI tools integrated in the Unity Editor](https://docs.unity3d.com/6000.3/Documentation/Manual/ai-menu.html) to make creating with Unity faster and easier.

Added support to enable or disable Unity AI Assistant and Generators features from the Unity Dashboard. When disabled, no users in your organization are able to use the AI features, even if the packages are installed.

### Assistant

The new [Assistant](https://docs.unity3d.com/Packages/com.unity.ai.assistant@latest) replaces Muse Chat and offers a project-aware experience directly in the Editor. Ask questions, generate code, batch rename assets, or place objects in a scene - all while interacting with your current project context.

Assistant supports three modes of operation for handling queries and tasks:

-   **/ask** mode: Provides answers, references documentation, or retrieves project-specific details without changing your project files.
-   **/run** mode: Automates repetitive tasks by generating functional scripts that can execute changes directly in the Unity Editor.
-   **/code** mode: Generates and reviews customizable C# code snippets that interact with the Unity API.

### Generators

The [Generators](https://docs.unity3d.com/Packages/com.unity.ai.generators@latest) toolset consolidates Sprite, Texture2D, Sound, Animation, and Material into one streamlined workflow to generate sprites, textures, animations, and now sound. Generated content is saved directly into Unity assets for immediate use.

Generators use several first-party (Unity) and Partner Models (Scenario, Inc. and Layer AI, Inc.) to generate and refine assets.

### Sentis

[Sentis](https://docs.unity3d.com/Packages/com.unity.ai.inference@latest) improves local inference performance for runtime AI models. It lays the groundwork for upcoming ML-Agents compatibility and supports a variety of model formats for runtime use.

<span id="xr"></span>

## XR

This section outlines recent updates to Unity’s extended reality (XR) support.

### Magic Leap deprecation

Unity 6.2 is the last version that fully supports the Magic Leap. Starting from Unity 6.3, the Magic Leap (x86_64) target will be limited to existing projects only.

### Meta Quest link time optimization

Added support for [thin Link Time Optimization](https://blog.llvm.org/2016/06/thinlto-scalable-and-incremental-lto.html) of the Unity Engine code for the Meta Quest platform.

Refer to [Develop for Meta Quest workflow](https://docs.unity3d.com/6000.3/Documentation/Manual/xr-meta-quest-develop.html#build-profile) for more information.

### Updates to VR and MR templates

Added examples of the [Occlusion](https://docs.unity3d.com/Packages/com.unity.xr.arfoundation@6.2/manual/features/occlusion.html), [Persistent Anchor](https://docs.unity3d.com/Packages/com.unity.xr.arfoundation@6.2/manual/features/anchors/persistent-anchors.html), and [Light Estimation](https://docs.unity3d.com/Packages/com.unity.xr.arfoundation@6.2/manual/features/camera/platform-support.html#optional-features) features to the VR and MR templates.

### Visible Triangle Mesh

Added the [Visible Triangle Mesh](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/XR.XRDisplaySubsystem.XRRenderParameter-visibleMesh.html) for optimized post-processing in XR projects. Post-processing techniques are applied only to visible areas of the screen, and not hidden pixels in the Occlusion Mesh.

### Render pass shader resolve extension for XR devices

Enabled the Qualcomm `VK_QCOM_render_pass_shader_resolve` to use Multisample Anti-Aliasing (MSAA) on untethered XR devices, such as Meta Quest.

## Additional resources

-   [New in Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNew.html)
-   [Upgrade Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuides.html)
-   [System requirements](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html)
-   [Install Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/GettingStartedInstallingUnity.html)
