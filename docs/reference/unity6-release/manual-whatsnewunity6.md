---
title: "New in Unity 6.0"
page_title: "Unity - Manual: New in Unity 6.0"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html"
topic: "unity6-release"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# New in Unity 6.0

Unity 6.0 includes all the features from Unity 6.0 Preview, 2023.2, and 2023.1.

To find out the changes and known issues in this version of Unity, refer to the [Unity 6.0 Release Notes](https://unity.com/releases/editor/whats-new/6000.0.23#notes).

To find the release notes for other releases, refer to the [Unity download archive](https://unity.com/releases/editor/archive).

If you are upgrading existing projects from 2022 LTS, read the [Upgrade Guide to Unity 6.0](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html) for information about how your project might be affected.

Review the new features and improvements of Unity 6.0 in these areas:

-   [2D](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#2d)
-   [Accessibility](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#accessibility)
-   [Adaptive Performance](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#adaptive-performance)
-   [Asset bundles](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#asset-bundles)
-   [Asset Store](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#asset-store)
-   [Audio](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#audio)
-   [Editor and Workflow](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#editor-and-workflow)
-   [Enterprise deployment](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#enterprise-deployment)
-   [Entities](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#entities)
-   [Graphics](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#graphics)
-   [Multiplayer](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#multiplayer)
-   [Package Manager](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#package-manager)
-   [Platforms](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#platforms)
-   [Physics](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#physics)
-   [Productivity tools](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#productivity-tools)
-   [Programmer tools](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#programmer-tools)
-   [Ray tracing API](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#ray-tracing-api)
-   [Sentis - Runtime AI](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#sentis)
-   [Shader Graph](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#shader-graph)
-   [SpeedTree](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#speedtree)
-   [Splines](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#splines)
-   [Terrain](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#terrain)
-   [Test Framework](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#test-framework)
-   [Version Control](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#version-control)
-   [Visual Scripting](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#visual-scripting)
-   [VFX Graph](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#vfx-graph)
-   [XR](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6.html#xr)

<span id="2d"></span>

## 2D

### Changes introduced in 2023.2

-   Added overlay support to the **Tile Palette** editor window, which allows you to overlay the Tile Palette window on top of the Scene view to paint tiles directly in the Scene view.

### Changes introduced in 2023.1

-   Added API to allow Sprite to get and set references to ScriptableObjects.
-   Added Brush Picks to the Tile Palette window.
-   Added options to create WhiteBox Tile Palettes.
-   Added preference option to Tile Palette Preferences for users to choose where they want to position their mouse cursor when painting on Tilemaps with Z Position.
-   Added Sample for Custom Geometry Generation and Vertex Colors.
-   Added Sprite/SpriteShape/TilemapRenderer as mask sources for SpriteMask.
-   Added SRP Batching for 2D Renderers and Particle Renderer to support URP.
-   Added support for camera frustum culling to Inverse Kinematics Manager 2D.
-   Enabled opening Sprite Editor Window from SpriteRenderer inspector to edit the Sprite that is assigned to the SpriteRenderer.
-   Enabled ScriptablePacker to add custom packing algorithm for SpriteAtlas.
-   Added a `Rigidbody2D.Slide` method which allows a Rigidbody2D to move with a specific velocity over a specific integration time and perform various slide, gravity, slip, direction-change, and surface-anchoring behaviors automatically. This method works on all body types, including Static bodies. It can simply calculate a new position, change the Rigidbody2D position immediately (supports interpolation), or defer the movement by automatically calling `Rigidbody2D.MovePosition()`. This feature makes Character Controllers easier to create.
-   Added the ability to use sub-stepping simulation when Simulation Mode is Update.
-   Enabled CompositeCollider2D to allow each Collider2D to select one of four composite operations: Merge (OR), Intersect (AND), Difference (NOT), and Flip (XOR), and a composite order for controlling the order that each Collider2D will be composited.

<span id="accessibility"></span>

## Accessibility

### Changes introduced in 2023.2

-   Added [mobile screen reader support APIs](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Accessibility.AssistiveSupport.html) that enable Unity applications to be compatible with the built-in screen readers on Android (TalkBack) and iOS (VoiceOver).
-   Added a new Editor window, the Accessibility Hierarchy Viewer, that displays the active accessibility hierarchy and its nodes in real-time, during Play mode. To access the Accessibility Hierarchy viewer, go to **Window > Accessibility > Accessibility Hierarchy Viewer** in the main menu.
-   The [Accessibility module](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.AccessibilityModule.html) is enabled by default in new projects and is listed in the **Built-in** section of the **Package Manager**.

### Changes introduced in Unity 6.0 preview

-   Added mobile screen reader support APIs for sliders to make them compatible with the built-in screen readers on Android (TalkBack) and iOS (VoiceOver).
-   Added a mobile screen reader support API for toggles to make them compatible with the built-in screen readers on Android (TalkBack) and iOS (VoiceOver).
-   Added a mobile screen reader support API for the dismiss action on Android (in the TalkBack menu) and iOS (two-finger scrub).
-   Added [accessibility settings APIs](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Accessibility.AccessibilitySettings.html) for retrieving the following system accessibility settings on Android and iOS:
    -   Font scale.
    -   Bold text.
    -   Closed captioning.

<span id="adaptive-performance"></span>

## Adaptive Performance

### Changes introduced in 2023.1

-   Added [Lifecycle controls and a general Android provider](https://docs.unity3d.com/Packages/com.unity.adaptiveperformance@5.0/manual/samples-guide.html#lifecycle-management).
-   Added an [Adaptive Performance Android Provider](https://docs.unity3d.com/Packages/com.unity.adaptiveperformance.google.android@1.0/manual/index.html) that extends the Adaptive Performance package to Android Devices.
-   Added new `IPerformanceModeStatus` to retrieve performance mode and listen to performance mode changes.

<span id="asset-bundles"></span>

## Asset bundles

### Changes introduced in 2023.1

-   Added capability to Asset Bundles that target Windows, OSX, and Linux platforms and the Dedicated Server subtarget so that they’re now built with the same Dedicated Server optimizations that built Dedicated Server Players receive (removing texture data and non-collision mesh data).

-   Implemented accessor for saving data to `.meta` files.

<span id="asset-store"></span>

## Asset Store

Added [Verified Solutions](https://docs.unity3d.com/6000.3/Documentation/Manual/verifiedsolutions.html) program, a library of third-party assets and solutions that Unity curates.

<span id="audio"></span>

## Audio

### Changes introduced in 2023.2

-   Added the [Audio Random Container](https://docs.unity3d.com/6000.3/Documentation/Manual/Create-randomized-playlist.html) to randomize audio and ensure that volume, pitch, time and triggers can be set to non-repetitive intervals, so your game never sounds the same twice.
-   Added a VU meter to the Audio Random Container.

<span id="editor-and-workflow"></span>

## Editor and Workflow

### Changes introduced in Unity 6.0

-   Implemented the drag-and-drop feature for files and assets from Unity to an external application on Linux.
-   Added the Asset Manager for Unity packages into the **Package Manager > Services > Content Management** section. This package allows users to easily browse, upload and import assets across unity projects.
-   Added a new Editor `-upmLogFile` command line argument that specifies a custom file path for UPM log output. For more information, refer to [Unity Editor command line arguments](https://docs.unity3d.com/6000.3/Documentation/Manual/EditorCommandLineArguments.html).

### Changes introduced in Unity 6.0 preview

-   Added a [piercing menu](https://docs.unity3d.com/6000.3/Documentation/Manual/SelectionPiercingMenu.html) that you can use to select GameObjects that overlap with other GameObjects. To open the piercing menu, hold down **Ctrl+Right-click** in the Scene view. The piercing menu displays a list of all selectable GameObjects under the cursor.
-   Added `Additional App IDs` to Steam ID Provider Editor Settings for Multiple App ID support.
-   Introduced [Build Profiles](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles.html) to create multiple custom build configurations for each target platform.
-   The Build Profile Diagnostic checkbox is no longer available because the Build Settings window has been replaced with the Build Profile window.
-   Integrated new build profile icons.
-   Modified the **Create** menu to replace the C# Script menu item with three separate options:
    -   **MonoBehaviour Script**
    -   **ScriptableObject Script**
    -   **Blank Script**
-   Improved the **Create** menu to reduce the amount of items at the root of the menu. The menu is now ordered alphabetically, and almost all items are now in a category.

### Changes introduced in 2023.2

-   Added the [Scene view context menu](https://docs.unity3d.com/6000.3/Documentation/Manual/SceneViewContextMenu.html). You can now access new context menus in the Scene view by right-clicking or using a customizable keyboard shortcut. These menus, created with the UI Toolkit and extensible in C#, offer easy access to frequently used commands.
-   Added the **Refresh the Scene view only when the Editor is in focus** option to the [Scene view preferences](https://docs.unity3d.com/6000.3/Documentation/Manual/preferences-scene-view.html). Enable this option to refresh the Scene view only when the Editor is in focus.
-   Added the ability to bind a keyboard shortcut to make transitions between Animator states.
-   Added basic OpenType font feature support. Currently, only kerning is enabled.
-   Added a new [Cameras overlay](https://docs.unity3d.com/6000.3/Documentation/Manual/cameras-overlay.html) to replace the Camera preview. You can use the Cameras overlay to take [first-person control of cameras](https://docs.unity3d.com/6000.3/Documentation/Manual/control-camera.html) and manage cameras in the Scene view.
-   Replaced most OS contextual menus with the UI Toolkit version.
-   Added the Color Checker, which is a tool used to calibrate lighting and post process. The Color Checker is an object that the user can add through **GameObject** > **Rendering** > **Color Checker Tool**. The tool is meant only as a production tool for lighting artists and won’t be saved in Build.
-   Enabled the Editor to show different license notification modals.
-   Added a `PropertyCollectionAttribute`, which you can use to implement custom drawers for collections.
-   Added a new tool for light placement using the pan, zoom, and orbit controls of the Camera. For more information, refer to [View and control a light from its perspective](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.0/manual/lights-placement-tool.html).

### Changes introduced in 2023.1

-   Improved and standardized right-click context menus across items and workflows. Improvements include more consistent interactions, sorting optimizations, and an optional search field.
-   Added a new launch screen for the Linux Editor.
-   Added [async test support](https://docs.unity3d.com/Packages/com.unity.test-framework@1.3/manual/reference-async-tests.html) with documentation and support for SetUp and TearDown to the test-framework.
-   Added Editor analytics event tracking for Refresh access and New link button clicks.
-   Added the **Enable PlayMode Tooltips** toggle to the Preferences window. This toggle enables tooltips in the Editor while it’s in Play mode.
-   Added the Helper Bar, which displays useful keyboard shortcuts, to the status bar. Enable the Helper Bar from the General tab of the Preferences window.
-   Added the option for Scene View preferences to only refresh the Scene view when the Editor is in focus.
-   Added an optional priority argument to [Shortcut](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ShortcutManagement.ShortcutAttribute-ctor.html) and [ClutchShortcut](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ShortcutManagement.ClutchShortcutAttribute-ctor.html) attributes.
-   Added a rebindable shortcut possibility for the Game view Stats button to the Shortcuts manager.
-   Added Stage, Scope, and Dynamic information to keywords for the Frame Debugger.
-   Added the possibility of running tests in a specified order from a test list.
-   Added the `focusedWindowChanged` callback to the `EditorWindow` class.
-   Changed to title bars on Windows for Editor. Improves upon the existing title bar feature by adding to it.
-   Displayed `OneTimeSetup` and `OneTimeTearDown` durations in the XML result under outputs.
-   Enabled adding a shortcut to enable or disable a capture for the Frame Debugger.
-   Enabled connection to Perforce servers using accounts with MFA.
-   Enabled copying a foldout or an entire event for the Frame Debugger.
-   Enabled seeing the Original and Used shaders in an event for the Frame Debugger. This is useful for events that use USEPASS or fall back to an assigned fallback shader.
-   Enabled setting the minimum and maximum values for the Levels slider for the Frame Debugger.
-   Enabled shortcut binding to mouse wheel turns for Shortcut Manager.
-   Enabled viewing the individual meshes in a SRP Batch inside the Mesh Preview for the Frame Debugger.
-   Split the texture format for the Frame Debugger into Color Format and DepthStencil Format.

### UI Toolkit

#### Changes introduced in Unity 6.0

Added an option to force Gamma rendering for the UI Toolkit in linear color space projects.

#### Changes introduced in Unity 6.0 Preview

-   Added missing [UxmlAttribute converters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UxmlAttributeConverter_1.html) to support UXML authoring: `Gradient`, `AnimationCurve`, `ToggleButtonGroupState`, Unsigned Int, and Unsigned Long.
-   Added support in `PropertyField` for `ToggleButtonGroupState` serialized properties.
-   Native [Text Generator](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-advanced-text-generator.html) Rewrite. With the Text Generator, you can use a wide array of languages and scripts, such as right-to-left (RTL) languages like Arabic and Hebrew.
-   Added a debugger for the UI Toolkit dynamic atlas.
-   Added support for deep nested attribute overrides in UXML and UI Builder.
-   Added type selector using Search.
-   Added a search field in the UI Builder Library.

#### Changes introduced in 2023.2

-   You can now use a new and flexible [runtime binding system](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-runtime-binding.html) to effortlessly connect data values to UI element properties when you create the Editor or runtime UI. You can configure data binding in either UI Builder or C# code.
-   Added new controls such as the [ToggleButtonGroup](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uxml-element-ToggleButtonGroup.html), [Tab](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uxml-element-Tab.html), and [TabViews](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uxml-element-TabView.html), and made improvements to existing controls.
-   Added icon support to the [Button](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uxml-element-Button.html), ListView, and TreeView controls.
-   Added new UxmlElement and UxmlAttribute attributes. These attributes replace the existing UxmlFactory and UxmlTraits when you [create custom controls](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-create-custom-controls.html). This streamlines the creation of custom controls, offering an efficient alternative through C# attributes, and eliminating the need for extensive code writing. For more information, refer to [Migrate custom controls from an earlier version](https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/migrate-custom-control.html). Additionally, you can now create [custom property drawers](https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/custom-control-customize-uxml-attributes.html#add-custom-property-drawer-in-ui-builder) for fields in the same manner as the **Inspector**.
-   Enhanced UI Builder with improvements to display what drives style properties, refined canvas manipulation, and made other enhancements. The updated UI Builder now also supports the authoring of UXML Objects, enabling the editing of the MultiColumnTreeView and MultiColumnListView.
-   Added the Emojis Fallback Support field to [TextElement](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uxml-element-TextElement.html) and [TextField](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uxml-element-TextField.html) to control the ordering of where to search for the glyph in the emoji range (primary font vs global fallback). Additionally, added basic support for the OpenType font features, with the current focus on enabling kerning.
-   Added a new Spacing field with a box model widget in the UI Builder’s Inspector.

#### Changes introduced in 2023.1

-   Added a Text preview to the UI Builder Inspector.
-   Added an anchor widget to the Position properties in the UI Builder Inspector pane.
-   Added basic analytics in UI Builder.
-   Added space-evenly to Justify Content property.
-   Added support for Bitmap Text.
-   Added Vertex Buffer size configuration.

### IMGUI

#### Changes introduced in 2023.1

Removed dependency on Legacy Text stack for IMGUI so that IMGUI now renders and calculates its metrics using TextCore. Some members from TextEditor have been deprecated to accommodate for the new TextUtilities used by both IMGUI and UITK. Their meanings are the same but their names have changed (from field to property):

-   `TextEditor.multiline` is now `TextEditor.isMultiline`.
-   `TextEditor.hasHorizontalCursorPos` is now `TextEditor.hasHorizontalCursor`.
-   `TextEditor.revealCursor` is now `TextEditor.showCursor`.

### TextMeshPro

#### Changes introduced in 2023.2

-   Added basic Emoji support.
-   Added basic OpenType font feature support, only kerning has been enabled for now.

#### Changes introduced in 2023.1

-   Added support for Color Glyphs and extracting OpenType font features.

<span id="enterprise-deployment"></span>

## Enterprise deployment

### Changes introduced in 2023.1

-   Added support on Windows for [Automatic proxy configuration](https://docs.unity3d.com/6000.3/Documentation/Manual/ent-proxy-autoconfig.html). With this feature, you can use Unity applications seamlessly in a web proxy environment, with minimal configuration.
-   If you use Unity on a Windows computer that lacks elevated privileges, you can [enable the installation of Unity Editors by standard users](https://docs.unity3d.com/6000.3/Documentation/Manual/ent-unpriv-install.html).

<span id="entities"></span>

## Entities

### Changes introduced in Unity 6.0 Preview

-   Added serialization support for `UnityObjectRef<>` to enable unmanaged references to Unity assets. For example, instead of a Texture on a managed IComponentData, you can have a `UnityObjectRef<Texture>` on an unmanaged `IComponentData`.
-   The Create menu adds the following Type templates:
    -   `IComponentData`
    -   `ISystem`
    -   `IJobEntity`
    -   Baker
-   Changed the way that entities are stored in preparation for the consolidation of entities and GameObject workflows. Entity IDs are now globally unique and you can now move them efficiently from one entities world to another. This does not impact ECS workflows in Unity 6.0, but it does disambiguate debugging by always showing exact entities.
-   Applied the following fixes to the entities Hierarchy window:
    -   You can select entities and systems within the hierarchy.
    -   Fixed an invalid range check that failed after you removed entities from the hierarchy view in valid use cases.
    -   Stopped the entities hierarchy from throwing exceptions when entities are destroyed.
    -   The entities hierarchy now removes all nodes of a scene and subscenes when the scene is unloaded.
    -   An exception is no longer thrown when you enter a prefab from the entities hierarchy.
-   Improved the performance of baking and the creation of archetypes and entity queries in worlds with a large number of existing types.
-   Improved the performance of LocalToWorld systems and non-dirty hierarchies.
-   Fixed an issue where an `EntityQuery` using `WithNone<T>` on an enable component wasn’t inserting a necessary job dependency.
-   `EntityQuery` singleton methods now correctly handle cases where the query contains enableable components.
-   Fixed memory leak issues, like ones affecting world deserialization and content delivery.
-   Fixed breakpoints in jobs defined in systems with `System.API`.

<span id="graphics"></span>

## Graphics

### Changes introduced in Unity 6.0

Moved Unity 6.0 documentation for the Universal Render Pipeline (URP) to the [Unity Engine](https://docs.unity3d.com/6000.0/Documentation/Manual/index.html) manual. For example, documentation about lighting in URP is now in the [Lighting](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/lighting-landing.html) section of the manual.

### Changes introduced in Unity 6.0 Preview

-   Added support for indirect Dispatch Rays (part of DXR 1.1). The method is similar to `RayTracingShader.Dispatch`, but the three dispatch dimensions are retrieved from a GraphicsBuffer. Added `RayTracingShader.DispatchIndirect` and a new `CommandBuffer.DispatchRays` signature. Added `SystemInfo.supportsIndirectDispatchRays` capability status.
-   Added the [GPU Resident Drawer](https://docs.unity3d.com/6000.0/Documentation/Manual/urp/gpu-resident-drawer.html), which automatically uses the `BatchRendererGroup` API to draw GameObjects with GPU instancing. This reduces the number of draw calls and frees CPU processing time.
-   Added support for SpeedTree GameObjects to the GPU Resident Drawer.
-   Added support for [GPU occlusion culling of instances](https://docs.unity3d.com/6000.0/Documentation/Manual/urp/gpu-culling.html) if they’re compatible with the GPU Resident Drawer, including culling of small meshes.
-   Adding a new per-batch layer filtering setting for the `BatchRendererGroup` API. You can use this setting to cull specific batches.
-   Optimized CPU performance of the Volume framework in URP and HDRP, to improve efficiency on low-end hardware and allow more precise control over quality settings.
-   Added a **Force No Crunch** texture compression setting in **Build Profiles** > **Asset Import Overrides**, which forces all textures to disable crunch compression and re-import.
-   Added an `IRenderPipelineResources` interface that allows you to [add new settings groups in the Graphics Settings window](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@17.0/manual/add-custom-graphics-settings.html). Updated the default `IRenderPipelineGraphicsSettings` Inspector to trigger notifications when a value in Graphics Settings is modified, and added a custom menu in `IRenderPipelineGraphicsSettings`.
-   Added UI Toolkit support for `CustomPostProcessOrder`.
-   Added the option to cache render graph system compilation for both URP and HDRP.

### Changes introduced in 2023.2

-   Unity 2023.2 introduces optimizations to SkinnedMeshRenderers across all supported platforms. These optimizations aim to batch compute skinning and blendshape dispatches. This can increase the amount of vertices deformed in parallel and improve the GPU performance of character and skinned mesh rendering.
-   The Progressive GPU Lightmapper is now out of preview and fully supported. For more information, refer to [Select the CPU or GPU for baking](https://docs.unity3d.com/6000.3/Documentation/Manual/progressive-lightmapper.html).
-   Added APIs to [move Light Probe positions at runtime](https://docs.unity3d.com/6000.3/Documentation/Manual/LightProbes-Moving.html).
-   Removed the **Auto Generate** setting in the Lighting window. Related APIs are now obsolete. To check lightmaps while you’re editing, you can now select a [Debug Draw Mode](https://docs.unity3d.com/6000.0/Documentation/Manual/GIVis.html) and set **Lighting Data** to **Preview**. This displays a preview of the baked lighting. The preview lightmaps are non-destructive, and you can use them after you’ve baked the scene.
-   Added `BatchCullingContext.cullingFlags` to specify whether to cull lightmapped shadow casters.
-   Added `rendererPriority` support for `BatchRendererGroup`.
-   Added support for building ray tracing acceleration structures asynchronously on a compute queue. AsyncCompute CommandBuffers can now run `CommandBuffer.BuildRayTracingAccelerationStructure` commands. Added support for `RayTracingAccelerationStructure` to RenderGraph and Render Graph Viewer.
-   Enabled exposing raytracing acceleration structure build flags for balancing build times versus ray tracing speed and memory consumption on the GPU. You can customize flags from C# when creating and building a `RayTracingAccelerationStructure`, or via the Renderer settings.
-   Added mipmap limit support and mipmap stripping support for Texture2DArrays.
-   Added support for providing tiled EXR images to LoadImage.
-   Added Native Render Pass support for DX12.
-   Added support for GPU batched skinning for D3D12 (Windows and XBox platforms).
-   Added the Custom Vertex Streams feature for particle trails.
-   Added `BakeTexture` and `BakeTrailsTexture` scripting methods.

### Changes introduced in 2023.1

-   Introduced a new graphics jobs threading mode called **Split Graphics Jobs** to reduce unnecessary start and end of frame synchronization between the main and native graphics job threads.
-   Introduced the new LightBaker v1.0 backend for manual lighting bakes, which makes [baking](https://docs.unity3d.com/6000.0/Documentation/Manual/Lightmapping-landing.html) more predictable and stable. Manual bakes no longer restart if you change the scene during baking, so the Editor is more responsive during baking. If you bake with the GPU backend, you can use a Baking Profile to select the tradeoff between performance and GPU memory usage.
-   Added screen space [lens flares](https://docs.unity3d.com/6000.0/Documentation/Manual/visual-effects-lens-flares.html) that you can generate from all lights visible on the screen (direct, indirect, emissive surfaces, specular highlights) in just a few clicks with a single post-processing volume. These lens flares are compatible with both HDRP and URP. This feature complements the Lens Flare (SRP) component, which gives you more advanced artistic control over lens flares from lights, but which you can only use on predefined light sources (directional, point and spot lights), and can only manually associate with each one.
-   [Dynamic shader variant loading](https://docs.unity3d.com/Manual/shader-loading.html#dynamicloading) provides additional user control over shader loading behavior and memory usage. This optimization enables the streaming of shader data chunks into memory, and eviction of shader data that is no longer needed at runtime, based on a user controlled memory budget. This allows to significantly reduce shader memory usage on platforms with limited memory budgets.
-   Added asynchronous compilation of pipeline state objects for [shader warmup](https://docs.unity3d.com/6000.0/Documentation/Manual/shader-prewarm.html).
-   Added DirectX Raytracing (DXR) 1.1 support in compute shaders. Added the following APIs: `SystemInfo.supportsInlineRayTracing`, `SystemInfo.supportsRayTracingShaders`, `ComputeShader.SetRayTracingAccelerationStructure`, and `CommandBuffer.SetRayTracingAccelerationStructure`(ComputeShader, …).
-   Added `#pragma require inlineraytracing` to compute shaders.
-   Added new `RayTracingAccelerationStructure.AddInstance` signature that allows adding mesh instances to the acceleration structure for GPU ray tracing. This is the equivalent of `Graphics.RenderMesh` from the rasterization pipeline.
-   Added foveated rendering support for D3D12/Vulkan.
-   Added foveated rendering support for Metal.
-   Added support for loading EXR data through `ImageConversion.LoadImage()`.
-   Added support for VK_EXT_debug_utils on Vulkan platforms.
-   Added mipmap limit groups, for more fine-grained configurability over the single value that applies to all mipmapped Texture2D assets. For more information, refer to [Quality settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-QualitySettings.html).
-   Enabled Ray Tracing Support in Terrain settings by default for new Terrains.
-   Implemented `ScriptableRenderContext.CullShadowCasters` API to kick theBatchRendererGroup culling jobs earlier in URP and HDRP.
-   Added standardized shader variant keywords for native 16-bit shader types, and wave operations. For more information, refer to [Set a shader to require a shader model or GPU feature](https://docs.unity3d.com/6000.3/Documentation/Manual/SL-ShaderCompileTargets.html).
-   Added a debug view to visualize probe sampling in Adaptive Probe Volumes. For more information, refer to [Display Adaptive Probe Volumes](https://docs.unity3d.com/6000.0/Documentation/Manual/urp/probevolumes-showandadjust.html).
-   Merged the [Adaptive Probe Volume window](https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-window.html#ProbeVolumes) with the Lighting window.

<span id="urp"></span>

### URP

For a complete description of new features and improvements in URP, refer to [What’s new in URP](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@17.0/manual/whats-new/urp-whats-new.html).

#### Changes introduced in Unity 6.0 Preview

-   Added the 8192x8192 option to Shadow texture resolution for the Main Light and Additional Lights.

-   Added the [camera history API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@17.0/api/UnityEngine.Rendering.Universal.UniversalCameraHistory.html) which lets you access per-camera history textures and use them in custom render passes. History textures are the color and depth textures that Unity rendered for each camera in previous frames.

-   Added Adaptive Probe Volumes (APV) Lighting Scenario Blending to URP.

-   Added a [new config package](https://docs.unity3d.com/6000.0/Documentation/Manual/urp/URP-Config-Package.html) that lets you override the maximum number of visible lights.

-   Added the [Render Graph Viewer](https://docs.unity3d.com/6000.0/Documentation/Manual/urp/render-graph-viewer-reference.html) window. This tool lets you visualize how render passes use frame resources, and debug the rendering process.

-   The [Rendering Debugger](https://docs.unity3d.com/6000.0/Documentation/Manual/urp/features/rendering-debugger.html) now contains a Mipmap Streaming section. This section lets you inspect the texture streaming activity.

-   Added C# script templates to create [custom post-processing effects](https://docs.unity3d.com/6000.0/Documentation/Manual/urp/post-processing/custom-post-processing-with-volume.html) that use a volume component.

-   Added APV sky occlusion support for URP.

-   Added support for Spatial Temporal Post-Processing (STP) upscaling.

-   The new [render graph](https://docs.unity3d.com/6000.0/Documentation/Manual/urp/render-graph.html) system improves the way you customize and maintain the render pipeline. The system reduces the amount of memory URP uses and makes memory management more efficient.

-   This URP version implements the [Alpha Processing](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html#post-processing) setting. If you enable this setting, URP renders the post-processing output into a render texture with an alpha channel. In previous versions, URP discarded the alpha channel by replacing alpha values with 1.

#### Changes introduced in 2023.2

-   Added cross-platform HDR display support. The Editor and built Players now provide full HDR tone mapping and display support, across all rendering pipelines and platforms that support HDR, including mobile and XR.

-   Added per-vertex quality levels for indirect lighting from Probe Volumes so that URP renders lit environments more efficiently. On mobile platforms URP doesn’t support Lighting Scenario blending or Lighting Normalization for Reflection Probes.

-   Added the **Camera And Objects** option in the Motion Blur volume component. The option uses motion vectors to blur objects that move faster than the camera’s exposure time.

-   Added support for additional directional light cookies.

-   Added the **Default Volume Profile** field to URP Global Settings.

-   Added the **Volume Profile** field to the Universal Render Pipeline asset.

-   Added alembic velocity motion vector support for URP materials.

-   Added automatic time-based motion vector generation for Shader Graph shaders with vertex animation based only on the **Time** node.

-   Added support for XR rendering and orthographic projection cameras to Forward+ rendering path.

-   Added support for foveated rendering in the Forward+ rendering path.

#### Changes introduced in 2023.1

-   Added [temporal anti-aliasing (TAA)](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/anti-aliasing.html#taa) support. The feature is not compatible with MSAA, Dynamic Resolution, or Camera stacking. The feature supports only fixed resolution, and does not support temporal upsampling.

-   Added support for [High Dynamic Range (HDR) output](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/post-processing/hdr-output.html).

-   Added the [Detailed Stats](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/rendering-debugger-reference.html#detailed-stats) section to URP Rendering Debugger.

-   Ported all URP passes to use the [RasterCommandBuffer](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@17.0/api/UnityEngine.Rendering.RasterCommandBuffer.html) API.

-   Added the **AO Method** property to **SSAO** settings where you can select the options Interleaved Gradient Noise or Blue Noise.

-   Added the **Blur Quality** property to **SSAO** settings where you can select the options High (Bilateral), Medium (Gaussian), or Low (Single-Pass Kawase).

-   Added the Falloff field to SSAO settings to control the distance from the camera where the AO effect is applied.

-   Added the clustered reflection probe support to the URP Forward+ rendering path. This enables the use of more than two reflection probes per object, allows Unity to skip per-object culling of lights and reflection probes, and enables Entities Graphics and procedural draws to make use of reflection probes.

-   Added the [low-code Custom Post Processing](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/post-processing/post-processing-custom-effect-low-code.html) feature in URP.

-   Added Decal support to render graph API.

-   Added render graph API support to URP post-processing effects.

-   Added support for shadow rendering to 2D objects, such as sprites, colliders, sprite shape, and 2D animation.

-   Added soft shadow rendering to shadow-casting 2D lights.

-   Added a limited support of Probe Volumes, with no interpolation of lighting data sets, and limited performance on lower-end hardware.

-   Improved FXAA quality. The new implementation provides better edge anti-aliasing (removing odd edge artifacts seen with the previous implementation) and better retention of texture quality. The improvement does not affect performance. The output quality is now comparable to the low and medium SMAA presets but with better performance.

<span id="hdrp"></span>

### HDRP

For a complete description of new features and improvements in URP, refer to [What’s new in HDRP](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.0/manual/whats-new-17.html).

#### Changes introduced in Unity 6.0 Preview

-   Added support for overriding material properties such as smoothness, albedo, and normal maps on all materials to facilitate material and lighting debugging. The material override feature in HDRP is available through the Rendering Debugger’s Lighting panel when rendering through the path tracer pipeline.
-   Added the Sky Occlusion feature to Adaptive Probe Volumes (APV), to allow time of day with static probe volumes.
-   Disabled storing of baked data as Streaming Asset in Adaptive Probe Volumes (APV) to make it compatible with Asset Bundles and Addressables.
-   Added AMD FidelityFX Super Resolution 2 (FSR2) Unity script bindings and HDRP integration.
-   Improved on existing Mipmap Streaming debug views and added more. The current offering in HDRP is consistent with what URP offers.
-   Added support for Spatial Temporal Post-Processing (STP) upscaling solution.

#### Changes introduced in 2023.2

-   Added HDRP path tracer support for Decals projectors. The path tracer does not support emission from decals.
-   Added the ability to stream Probe Volume data from disk at runtime. You can enable or disable disk streaming for different quality levels.
-   Made HDRP Shader Graph decals compatible with transparent objects. This means you can use decals created with Shader Graph to affect transparent objects to build procedural effects like rain drops, ripples, custom engravings, dirt effects on glass.
-   Added a night sky with stars and celestial bodies to the HDRP physical sky.
-   Added a Shader Graph output for the physically based sky and added controls to create a moon.
-   Added visualization of async compute passes and their synchronization points to the Render Graph Viewer.
-   Added beer shadow maps for volumetric clouds.
-   Added a Volume Profile field to High Definition Render Pipeline asset.
-   Added a material type for thin objects with colored transmission.
-   Added the option to disable clear coat on the material for Lit ShaderGraphs.
-   Added the Global Pass API that you can use to inject custom passes in the render pipeline without any GameObjects in a scene.
-   Added the volumetric fog fullscreen debug mode output for Arbitrary Output Variables (AOV).
-   Added Adaptive Probe Volumes (APV) ability to stream data directly from the disk. This feature is only available on devices with compute shader compatibility.
-   Added the ability to use the baking API to bake Adaptive Probe Volumes (APV) independently from lightmaps or reflection probes.

#### Changes introduced in 2023.1

-   Light Layers and Decal Layers are now managed in similar ways in both HDRP and URP. In HDRP they now share the first 16 Rendering Layers, instead of using 8 separate bits each. Additionally, a new option in the HDRP asset allows access to a full screen buffer that contains the Rendering Layers Masks of rendered Objects. HDRP can sample that buffer from the ShaderGraph through the HD Sample Buffer node, and use it to implement custom effects, like outlining objects on a specific rendering layer.
-   All Ray Tracing HDRP features (raytraced shadows, reflections, AO, global illumination, path tracing, recursive rendering,…) are officially out of experimental in Unity 2023.1.0.
-   Added a foam system to the HDRP Water System.
-   Probe Volumes are out of experimental. Revamped the control interface to provide a better experience when you place Probe Volumes, light dynamic objects and some static objects, stream data from GPU memory, interpolate lighting data sets, and work with volumetric fog and particles.
-   Added a third level of noise for volumetric clouds.
-   Added Generic Rendering Layer mode support.
-   Added [High Quality Line Rendering](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@15.0/manual/Override-High-Quality-Lines.html) which unlocks improved performance and image quality for line topology.
-   Added the ability to [compute the thickness of an object](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.0/manual/Compute-Thickness.html#:~:text=HDRP%20can%20use%20the%20optical,use%20subsurface%20scattering%20or%20refraction.).
-   Added improvements to the SSS lighting model.
-   Added Ray Tracing Terrain support for HDRP.
-   Added raytraced shadows for Pyramid and Box shaped Spot Lights.
-   Added the Ray Tracing Light Cluster to Path Tracer.
-   Added volumetric material support for local volumetric fog volumes.
-   Exposed Material Type in materials using the Lit Shader Graph.
-   Improved stripping of unused features.
-   Specular color on HDRP/Lit and HDRP/StackLit below 2% can be used to suppress specular lighting completely when “Specular Fade” is enabled.
-   Improved the water rendering system in the following ways:
    -   Added functionality to Water Mask so it dynamically removes water from inside a boat or in a cave in the middle of an island.
    -   Modified the water deformer to dynamically deform water locally. For example, to deform water around a moving ship, deform waves near shores, or deform water in a vortex.
    -   Added flow maps to create local currents, to manage surface waves that follow currents, and the water query API to allow objects to drift.
    -   Added a water line to manage the transition for cameras that are half underwater.
    -   Improved visual quality of water.
    -   Improved the UX of the water system.
-   Added an extra optional pass to compute thickness of transparent objects at runtime to get more accurate refraction and transparency rendering.
-   Improved visual quality when using temporal anti-aliasing (TAA) with two new options to perform sharpening. The first option is a post-process pass that offers higher quality sharpening, control over the amount of sharpening, and an option to reduce possible ringing artifacts. The second option is to run Contrast Adaptive Sharpening from AMD FidelityFX.
-   Specular light can now be completely faded when using a specular color workflow using the HDRP/Lit and HDRP/StackLit shaders by toggling a new option that can be found in the HDRP Global Settings under Miscellaneous/Specular Fade.
-   Added Rendering Layers support to Adaptive Probe Volumes (APV) to address light leaking issues in interior/exterior scenarios.
-   Added a new Leak Reduction Mode for Adaptive Probe Volume sampling called ‘Quality’, which ensures that no invalid probes are sampled.
-   Implemented an anti-seam mechanism to smooth transitions between multiple subdivision levels in Adaptive Probe Volumes.

<span id="multiplayer"></span>

## Multiplayer

Unity 6.0 Multiplayer features are designed to simplify and accelerate multiplayer game development in a way that prepares you for future integration with Multiplayer Services and supports the growth of engaged player communities over time.

### Multiplayer Center Core

The new [Multiplayer Center](https://docs.unity3d.com/6000.3/Documentation/Manual/multiplayer-center) makes it easier to set up and develop multiplayer games. Prompts and workflows use parameters and requirements for your game to suggest relevant packages and services before generating dynamic templates you can use to start your project.

You no longer need to leave the Editor to set up a multiplayer game. Personalized interactive guidance, educational materials, and shortcuts make it easier to experiment and respond to feedback early and often.

### Multiplayer Widgets

New [Multiplayer Widgets](https://docs.unity3d.com/Packages/com.unity.multiplayer.widgets@1.0/manual/get-started-learn-widgets.html) make it easier to integrate Multiplayer Services into your multiplayer game. You can access the widgets as a standalone package or from the new [Multiplayer Center](https://docs.unity3d.com/6000.3/Documentation/Manual/multiplayer-center).

Included widgets for services such as Multiplay, Relay, Lobby, Vivox make it easier to find compatible, relevant integrations. For example, integrating the Relay service into the Editor makes it easier to create sessions and connect users earlier in the development process.

### Multiplayer Services

The newly released [Multiplayer Services package](https://docs.unity.com/ugs/en-us/manual/mps-sdk/manual/get-started) makes it easier to manage dependencies across multiplayer services. For example, you can:

-   Quickly add multiplayer elements that integrate Unity Gaming Services into your game.
-   Set up Lobby, Relay, Distributed Authority, Matchmaker and Multiplay Hosting. A new session system provides a simple shared cloud-side backing for a multiplayer game loop that groups players together and manages a shared session/player state.
-   Create and manage peer-to-peer (P2P), Dedicated Game Server, and Distributed Authority hosted online sessions. Players can join sessions through matchmaking, a Join Code, or by browsing a list of active sessions.

To make configuration easier, sessions now integrate directly with Netcode for GameObjects, Netcode for Entities, and the Unity Transport package.

### Multiplayer Tools

#### Changes introduced in Unity 6.0

The [Multiplayer Tools package](https://docs.unity3d.com/Packages/com.unity.multiplayer.tools@2.2/manual/index.html) version 2.2.1 improves workflows for multiplayer game development in Unity, performance with Netcode for GameObjects 2.0, and adds support for Distributed Authority.

#### Changes introduced in Unity 6.0 Preview

Updated the Multiplayer Tools package to version 2.1.0, adding Network Scene Visualization as a new visual debugging tool. For more information, refer to the [Multiplayer Tools documentation](https://docs.unity3d.com/Packages/com.unity.multiplayer.tools@latest).

### Multiplayer Play Mode

The [Multiplayer Play Mode package](https://docs.unity3d.com/Packages/com.unity.multiplayer.playmode@latestindex.html) is designed to reduce iteration cycles, make it easier to validate implementation choices, and improve gameplay quality early across runtime processes.

#### Changes introduced in Unity 6.0

New Play Mode Scenarios in Unity 6.0 integrate test cycles into production environments to help you deliver a first-playable experience with real players earlier.

#### Changes introduced in Unity 6.0 Preview

Updated Multiplayer Play Mode to version 1.0. Use it to test multiplayer functionality without leaving the Unity Editor. For more information, refer to the [Multiplayer Play Mode documentation](https://docs.unity3d.com/Packages/com.unity.multiplayer.playmode@latest).

### Dedicated Server package

The [Dedicated Server package](https://docs.unity3d.com/Packages/com.unity.dedicated-server@1.0/manual/index.html) consolidates the dedicated game server workflow in the Editor to make it easier to deploy dedicated servers locally and to Multiplay hosting.

#### Changes introduced in Unity 6.0

New [Multiplayer roles](https://docs.unity3d.com/Packages/com.unity.dedicated-server@1.0/manual/multiplayer-roles.html) give you control over which multiplayer role (Client, Server) you use in each build target:

-   [Content Selection](https://docs.unity3d.com/Packages/com.unity.dedicated-server@1.0/manual/content-selection.html): Provides UI and API for selecting which content (GameObjects, Components) should be present/removed in the different multiplayer roles.
-   [Automatic Selection](https://docs.unity3d.com/Packages/com.unity.dedicated-server@1.0/manual/automatic-selection): Provides UI and API for selecting which component types should be automatically removed in the different multiplayer roles.
-   [Safety Checks](https://docs.unity3d.com/Packages/com.unity.dedicated-server@1.0/manual/safety-checks): Activates warnings that help detect potential null reference exceptions caused by stripping objects for a multiplayer role.

#### Changes introduced in Unity 6.0 Preview

Released the Dedicated Server package that you can use to switch a project between the server and client role without the need to create another project. For more information, refer to the [Dedicated Server package documentation](https://docs.unity3d.com/Packages/com.unity.dedicated-server@1.0/manual/index.html).

### Netcode for GameObjects

Netcode for GameObjects is a high-level networking library built for Unity for you to abstract networking logic.

#### Changes introduced in Unity 6.0

[Netcode for GameObjects](https://docs.unity3d.com/Packages/com.unity.netcode.gameobjects@2.0/manual/index.html) version 2.0 now supports [Distributed Authority](https://docs.unity3d.com/Packages/com.unity.netcode.gameobjects@latest?subfolder=/manual/terms-concepts/distributed-authority.html) (Beta) and includes improvements to promote best practices in multiplayer game development. For information about basic Netcode for GameObjects features with practical examples for individual APIs and systems, refer to the [Multiplayer Use Cases Bitesize Sample](https://github.com/Unity-Technologies/com.unity.multiplayer.samples.bitesize/tree/main/Basic/MultiplayerUseCases).

#### Changes introduced in Unity 6.0 Preview

-   Added Distributed Authority mode in Netcode for GameObjects clients have distributed ownership of or authority over spawned Netcode objects during a game session. With Distributed Authority, the clients have the governed authority to spawn network objects which is announced to the cloud state service and conveys state updates to all connected clients. A highly optimized cloud state service maintains the overall state of a network session between clients.
-   Added a new RPC attribute that can perform the functions of both Server and Client RPCs, as well as enabling client-to-client RPCs.
-   Added many utility methods, which include `NetworkManager.OnConnectionEvent`, `-ServerIsHost`, `-InstantiateAndSpawn`, and more.

#### Changes introduced in Unity 2023.2

-   Added the **Refresh In-Scene Prefab Instances** option in the Network Object component context menu. Use this property to update the `GlobalObjectIdHash` value for prefab instances in the scene that existed before they had a `NetworkObject` component. This property affects all scenes included in the build list.
-   Added the `NetworkManager` methods `SetPeerMTU` and `GetPeerMTU` to give full control over Maximum Transmission Unit (MTU) sizes. Use this for custom protocols in Netcode for GameObjects.
-   Improved network prefab identification generation (for example, `GlobalObjectIdHash`) to fix issues where Unity assigned invalid values.
-   Improved the serialization API and codegen pipelines in the following ways:
    -   Added the `GenerateSerializationForTypeAttribute` method that you can apply to any class or method to ensure the specific type is included in the codegen serialization process.
    -   Added the `GenerateSerializationForGenericParameterAttribute` method that you can use to include generic type(s) wrapped by a `NetworkVariable` type in the codegen process.
    -   Exposed additional `NetworkVariableSerialization` methods to improve custom `NetworkVariable` creation without any boxing cost. You can use the `NetworkVariableBase.MarkNetworkBehaviourDirty` method to mark NetworkVariables as dirty.
-   RPCs in generic `NetworkBehaviour` types can now serialize parameters of the class’s generic types.
-   Improved support for 32-bit ARMv7 in Netcode.
-   Added additional `NetworkManager` events `OnServerStarted`, `OnServerStopped`, `OnClientStarted`, and `OnClientStopped` to provide better notification of the `NetworkManager` initialization process.

### Netcode for Entities

The Netcode for Entities, part of the Unity’s Data Oriented Technology Stack (DOTS), provides a server authoritive with client prediction framework that you can use to create multiplayer games.

#### Changes introduced in Unity 6.0

[Netcode for Entities version 1.3](https://docs.unity3d.com/Packages/com.unity.netcode@1.3/manual/index.html) includes several usability improvements and the new [Megacity Metro](https://unity.com/demos/megacity-competitive-action-sample) demo game which shows how Unity 6.0 makes setting up multiplayer services, networked vehicle implementation, configurable rule-based matches, and immersive player communications faster and easier.

#### Changes introduced in Unity 6.0 Preview

-   Added support for GameObjects to render debug bounding boxes.
-   Added the NetCodeConfig ScriptableObject which contains most NetCode configuration variables that you can customize without needing to modify code.
-   You can now disable the automatic bootstrapping in the following ways:
    -   Disable automatic bootstrapping in the ProjectSettings.
    -   Add the new `OverrideAutomaticNetcodeBootstrap` MonoBehaviour to your first build scene.
-   Added `AlwaysRelevantQuery` that you can use to specify general rules for relevancy without specifying it ghost by ghost.
-   `Added BatchScaleImportanceDelegate`, a new version of the importance scaling function that works in batches. It is not required to set both the ScaleImportance and the BatchScaleImportance function pointers. If the BatchScaleImportance is set, it is the preferred.

<span id="package-manager"></span>

## Package Manager

### Changes introduced in Unity 6.0 Preview

Improved the behavior of [Project manifest](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPrj.html) files by repopulating them with default dependencies if the files are empty or full of whitespace.

### Changes introduced in 2023.1

-   Added functionality to track assets imported from an Asset Store package:
    -   Added an **Imported Assets** tab in the [package details view](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-details.html) (My Assets) to visualize imported assets.
    -   Added a **Remove** button and window for Asset Store packages, to selectively remove imported assets.
-   Enhanced the user experience for [deprecated packages](https://docs.unity3d.com/6000.3/Documentation/Manual/pack-deprecated.html). The Unity Editor notifies users at startup if their project has any deprecated packages. Updated the Package Manager window to identify two types of package deprecation:
    -   Packages that reach their end of life and are no longer supported in the given Editor.
    -   A specific version of a package marked as deprecated.
-   Added **Web3** as a category in the [Filters](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-filter2.html) menu when viewing My Assets.
-   Changed the default sorting in the My Assets view to **Purchased date**, to match the default sort method in Asset Store.
-   Changed the [install menu items](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-actions.html) to start with **Install** instead of **Add**.

<span id="package-cache-management"></span>

### Package cache management

#### Changes introduced in 2023.1

-   Changed the default location and structure of the [global cache](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-cache.html).
-   The registry data cache is now limited to a default maximum size of 10 GB. You can override the default by [customizing the global cache](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-config-cache.html).

<span id="package-manager-window"></span>

### Package Manager window

#### Changes introduced in 2023.2

-   Added a [navigation panel](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-nav.html):
    -   Added a panel to improve the navigation between views of package subsets. In earlier versions, these contexts were stored in the **Packages** dropdown menu.
    -   Added **Services** as a dedicated entry in the Package Manager navigation panel.
    -   Added **Updates** as a nested entry beneath **In Project** in the navigation panel. This nested view lists all the packages in your project that have updates available.
    -   Added individual scoped registries as nested entries beneath **My Registries** in the navigation panel.
-   Enhancements to the [list panel](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-list.html):
    -   Added a **Packages - Asset Store** expander in the list panel of the **In Project** context, so you can view and manage Asset Store packages from the **In Project** view.
    -   Relocated the [search box](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-search.html) and changed its behavior so it recalls your search terms on a per-context basis.
-   Enhancements to the [details panel](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-details.html):
    -   Improved the flow for managing packages in the **My Assets** context by streamlining the action buttons in the details panel. The most common action appears as the default action in a menu button, with additional actions listed in the menu. Also added an **In Project** label to clearly indicate when an Asset Store package is already imported into your project and up-to-date.
    -   Updated the label of the **Import** button when viewing an Asset Store package. After you [download an updated Asset Store package](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-update2.html), the main action button label is **Import update #.# to project**, so it’s clear that you need to import the update to your project.
    -   Updated the behavior of the [Documentation](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-docs.html#Editor) link for packages that you installed from a registry. You can now right-click the link and choose to **Open in browser** or **Open locally**.
    -   Added a button to sign in with your Unity ID when you’re logged out and try to view the details of an Asset Store package.
-   Other enhancements:
    -   Updated the values in the [Filters](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-filter2.html) menu when you’re viewing the My Assets context.
    -   Updated the label for the [Filters](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-filter2.html) control so it shows the selected value rather than the parent category.

<span id="platforms"></span>

## Platforms

<span id="android"></span>

### Android

#### Changes introduced in Unity 6.0

Unity’s Android build tooling is updated to align with the latest Android development tools. Unity now uses Gradle version 9.1.0 and Android Gradle Plugin (AGP) version 9.0.0.

Unity automatically applies these updates to most projects. However, projects using Custom Gradle Templates or third-party plug-ins might need manual changes. To upgrade your existing project, refer to [Upgrade to Unity 6.0](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6.html#android-build-tooling).

The tooling updates introduce the following changes:

-   Attributes such as `targetSdkVersion`, `minSdkVersion`, `lintOptions`, and `packagingOptions` are marked deprecated and automatically converted by Gradle Template Updater to their updated versions.
-   AGP 9.0.0 replaces `proguard-android.txt` with the optimized version `proguard-android-optimize.txt`. Using the old `proguard-android.txt` file is no longer supported.
-   Gradle and AGP API updates might affect custom Gradle template logic.
-   Custom Android plug-ins and [libraries](https://docs.unity3d.com/6000.3/Documentation/Manual/android-library-plugin-create.html) must declare a unique namespace.

#### Changes introduced in Unity 6.0 Preview

-   Added a new Build setting to embed debug symbols into an app bundle when uploading `.aab` files to the Google Play Store. You have an option to upload the symbols package separately as a zip file with your `.apk` or `.aab` files. You can create symbol files with `.so.sym` or `.so.dbg` and the legacy `.so` extensions.
-   Added a new Player setting to display warnings when the symbol’s package size exceeds the specified threshold.
-   Added a new property in `.androidlib` Plug-in Inspector to specify dependencies for `unityLibrary`. You can now configure `.androidlib` to depend on `unityLibrary`, and thus expand an activity by overriding `UnityPlayerActivity`.
-   Added a new Player setting to allow or deny Android devices from using the Vulkan graphics API. With Android Vulkan Allow Filter List, you can allow certain devices to use Vulkan as the default graphics API. Alternatively, with Android Vulkan Deny Filter List, you can limit certain devices from using the Vulkan API.

#### Changes introduced in 2023.2

-   Added Addressables for Android package (`com.unity.addressables.android`) to provide Play Asset Delivery support for Addressables.
-   Added texture compression format targeting support through Addressables for Android package to pack multiple texture compression formats to Android asset packs. At install-time, an APK is built only using the optimal texture compression formats based on the device’s mobile GPU to load and render textures quicker and with less memory.
-   Added `ApplicationExitInfo` API to provide information on application crashes and application not responding (ANR) errors.
-   Made these improvements:
    -   Made `GameActivity` as the default application entry point to provide more control over the interaction between Android and your application.
    -   Raised the minimum supported Android version to 6.0 (API level 23).

#### Changes introduced in 2023.1

-   Added support for [texture compression targeting](https://developer.android.com/guide/playcore/asset-delivery/texture-compression) which compresses textures multiple times using different formats. This helps to serve optimized APKs for different Android devices. For more information, refer to [Texture compression targeting](https://docs.unity3d.com/6000.3/Documentation/Manual/android-distribution-google-play.html#texture-compression-targeting).
-   Added the Android Project Configuration Manager which is a flexible and robust way to modify custom Gradle project files in your Android project. For more information, refer to [Android Project Configuration Manager](https://docs.unity3d.com/6000.3/Documentation/Manual/android-modify-gradle-project-files-methods.html#agp).
-   Added support for [GameActivity](https://developer.android.com/games/agdk/game-activity), which is an application model available for Android projects powered by [Android’s Game Development Kit](https://developer.android.com/games/agdk). It provides more control over the essential parts of an application, gives more freedom and flexibility in the core code, and minimizes the amount of JNI that an application needs to use. It also improves how games work with Jetpack components, enables you to overlay native elements, and helps you more easily take advantage of new platform features. For more information, refer to [The GameActivity application entry point](https://docs.unity3d.com/6000.3/Documentation/Manual/android-application-entries-game-activity.html).
-   Extended [Unity’s Memory API](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-memoryUsageChanged.html) to take advantage of Google Memory Advice library. This provides you with fine-grained information on memory usage which you can use to adjust your application accordingly.
-   Exposed [Android’s reportFullyDrawn API](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Android.DiagnosticsReporting.CallReportFullyDrawn.html) so you can get more accurate information on your application’s startup time, one of the major metrics of user experience. This gives you a better understanding of your application’s cold and warm start rates across devices which you can use to further optimize the application.
-   Added `build_fingerprint` information to Android builds.

<span id="ios"></span>

### iOS

#### Changes introduced in Unity 6.0 Preview

-   Added `.xcframework` plugins support.
-   Removed Custom XIB Launch Screen Type from Player settings.
-   Added a new Player setting to support 64 bit ARM and 64 bit Intel/AMD simulator architectures. The ARM 64 and x86_64 support is also added to the Plugin Importer.

<span id="visionos"></span>

### visionOS

#### Changes introduced in Unity 6.0 Preview

Added support for Apple’s visionOS platform.

<span id="web-platform"></span>

### Web platform (previously WebGL)

#### Changes introduced in Unity 6.0 Preview

-   Implemented the following `LocationService` methods and properties in Web platform:
    -   `Start()`
    -   `Stop()`
    -   `isEnabledByUser`
    -   `lastData`
    -   `status`

-   Added the ability to copy and paste to and from the Unity player.

-   Added support for **WebAssembly 2023**. For more information, refer to [WebAssembly 2023](https://docs.unity3d.com/6000.0/Documentation/Manual/webassembly-2023.html). WebAssembly 2023 includes support for up to 4GB of heap memory and is a collection of the following WebAssembly language features:
    -   WebAssembly native exceptions
    -   WebAssembly Single Instruction Multiple Data (SIMD)
    -   Optimized data operations
    -   BigInt
    -   WebAssembly.Table
    -   Non-trapping float to int conversions
    -   Sign extension

-   Implemented the following LocationService methods and properties:
    -   `GetLastHeading()`
    -   `SetHeadingUpdatesEnabled()`
    -   `IsHeadingUpdatesEnabled()`
    -   `GetHeadingStatus()`
    -   `IsHeadingAvailable()`

-   Added support for the Compass API.

-   Added support for mobile browsers.

-   Implemented the Emscripten 3.1.38 toolchain.

#### Changes introduced in 2023.2

-   Unity web builds now take advantage of the latest size and performance optimizations in the Emscripten toolchain.
-   Added support to specify the browser type and its executable path that you want your application to launch at runtime. You can specify this either using the command line or the GUI setting in the Build Settings window.

#### Changes introduced in 2023.1

-   Extended the diagnostics overlay in web builds with more metrics and graphs.
-   Improved console error message logs when `Content-Encoding: gzip` is not properly set on server, or when a web browser has a bug that prevents it from being able to decompress gzip content.

<span id="windows"></span>

### Windows

#### Changes introduced in 2023.1

Enabled Windows ARM64 Player compilation. For more information, visit the [System Requirements](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html) page.

<span id="physics"></span>

## Physics

### Changes introduced in 2023.2

-   Added `ArticulationBody.jointPosition` pointer lines to the **Joint Angular Limits** gizmo to show the exact position of the joint in the Scene view.

<span id="productivity-tools"></span>

## Productivity tools

### ProBuilder

#### Changes introduced in Unity 6.0 Preview

-   Created the ProBuilder tool context which you can activate in the Tools overlay in the Scene view. The ProBuilder tool context enables ProBuilder-specific actions in the Scene view.
-   Removed the ProBuilder window. The ProBuilder tool context used in conjunction with the [Scene view context menu](https://docs.unity3d.com/6000.3/Documentation/Manual/SceneViewContextMenu.html) provides a more streamlined workflow for ProBuilder actions.
-   Moved the Vertex, Edge, and Face edit modes to the Tool Settings overlay in the Scene view. To display ProBuilder edit modes in the Tool Settings overlay, enable the ProBuilder tool context in the Tools overlay.
-   Moved ProBuilder actions that rely on element selection, such as Bridge, Weld Vertices, and Grow Selection, to the [Scene view context menu](https://docs.unity3d.com/6000.3/Documentation/Manual/SceneViewContextMenu.html) when the ProBuilder tool context is active in the Tools overlay.
-   Moved ProBuilder actions that apply to the entire ProBuilder mesh component, such as Export, Subdivide, and Center Pivot, to the [Scene view context menu](https://docs.unity3d.com/6000.3/Documentation/Manual/SceneViewContextMenu.html).
-   Moved creation and editing tools to the Tools overlay.
-   Added a preview option for most ProBuilder actions.
-   Moved these tool options from the ProBuilder toolbar to the Tool Settings overlay:
    -   Select Hidden
    -   Orientation: Normal
    -   Rect: intersect
-   Improved creation tools:
    -   Hold **Shift** after using a create shape tool to create a copy of the shape you just created.
    -   After you use **Create PolyShape**, you can now draw multiple shapes without leaving the tool.

<span id="profiler"></span>

### Profiler

### Changes introduced in Unity 6.0 Preview

Released version 1.1.0 of Memory Profiler. Refer to the [Memory Profiler package](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@1.1/manual/whats-new.html) documentation for details.

### Changes introduced in 2023.2

-   Added a Highlights module to the Profiler window.
-   Added a new Inverted Hierarchy view for the CPU Profiler.
-   Added metadata support for RenderTextures in Memory Profiler.

### Changes introduced in 2023.1

-   Added metadata support for AudioClip and Shader in Memory Profiler.
-   Improved graphics memory tracking in Memory Profiler.

<span id="programmer-tools"></span>

## Programmer tools

<span id="kernel"></span>

### Kernel

#### Changes introduced in 2023.1

Added functionality to control player connection listen port.

<span id="scripting"></span>

### Scripting

#### Changes introduced in 2023.1

Added [an option to display C# source code line numbers](https://docs.unity3d.com/6000.3/Documentation/Manual/IL2CPP-managed-stack-traces.html) in call stacks in player builds.

<span id="ray-tracing-api"></span>

## Ray tracing API

### Changes introduced in 2023.2

-   Ray Tracing Acceleration Structure Build Flags: New Raytracing Acceleration Structure build flags were introduced to Unity’s renderers and RTAS API. These flags allow you to control the tradeoffs between ray tracing memory usage, RTAS build time and ray tracing performance. Developers and artists can use the new flags to fine tune the ray tracing performance in their scenes and renderers.
-   Inline Ray Tracing in Shaders: You can now use in-line ray tracing in rasterization and compute shaders when targeting DXR1.1-capable Windows platforms, Xbox Series X/S, and Playstation 5. You can issue ray queries from within shaders to traverse the bound Raytracing Acceleration Structure and perform intersection testing. This allows you to implement all kinds of hardware accelerated raytracing effects and simulations.

### Changes introduced in 2023.1

The Ray Tracing API is officially out of experimental status in Unity 2023.1. The Ray Tracing API includes stability and performance improvements to additional compatibility with the engine’s existing feature set.

<span id="sentis"></span>

## Sentis

Use Sentis to run machine learning models directly within Unity applications and make use of the real-time AI-driven features for optimized performance. To learn more, refer to the [Sentis](https://docs.unity3d.com/Packages/com.unity.sentis@latest/) documentation.

<span id="shader-graph"></span>

## Shader Graph

### Changes introduced in Unity 6.0

-   Added a new set of [Production Ready sample content shaders](https://docs.unity3d.com/Packages/com.unity.shadergraph@latest) to the Shader Graph package.
-   Added a **Disable Color Tint** option to the **Graph Settings** for the Canvas URP and HDRP material types and for the Sprite Unlit, Sprite Lit, and Sprite Custom Lit URP material types. Use this option to prevent Shader Graph tinting the sprite with the **Color** property of the sprite.
-   Updated the [property parameters](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.0/manual/Property-Types.html): reordered the UI to display **Name**, **Reference** and **Precision** first, renamed **Shader Declaration** to **Scope**, changed **Exposed** to **Show In Inspector**, and removed **Override Property Declaration**.
-   Updated the [keyword parameters](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.0/manual/Keywords-reference.html): renamed **Exposed** to **Generate Material Property** and changed **Scope** to **Is Overridable**.

### Changes introduced in Unity 6.0 Preview

-   Added a new sample content pack that can be installed with the Package Manager. The samples contain descriptions, examples, and break downs for a majority of the nodes in Shader Graph. These samples help you understand the inner workings of the nodes and see examples of how they work and how to use them.
-   Added new shortcuts for adding new nodes and toggling sub-window visibility, and moved several existing shortcuts to the Shortcut Manager.
-   Added a zoom step size option in the user preferences.
-   Added a customizable Heatmap color mode, which by default displays the estimated performance impact of each node in a Shader Graph.
-   Added the Feature Examples Sample to Shader Graph to show users how to achieve specific effects in Shader Graph.

### Changes introduced in 2023.2

-   Added UGUI support for Shader Graph. Shader Graph now has subtargets for Canvas in both URP and HDRP. UI artists can create custom shaders for their UI elements using Shader Graph. Define the overall look and style of UI elements, create animated UI effects, and define custom button states while using less texture memory.
-   Enabled Shader Graph Canvas Master Node to allow users to create UI shaders for Canvas in HDRP, URP, and Built-in.

### Changes introduced in 2023.1

Variant Keyword Prefiltering introduces the early exclusion of “multi_compile” keywords, based on Prefiltering Attributes driven by Render Pipeline settings. This greatly reduces the amount of variants being enumerated for potential stripping and compilation. The result is a significant reduction in shader processing time.

<span id="speedtree"></span>

## SpeedTree

### Changes introduced in Unity 6.0 Preview

Added the SpeedTree9Importer, which supports .st9 files exported by SpeedTree Modeler 9 and includes the following:

-   Support for SpeedTree Games Wind and SpeedTree Legacy Wind effects.
-   The ability to configure wind strength and direction responsiveness through the Importer Settings.
-   New SpeedTree9 shaders for built-in (`.cg`), URP, and HDRP renderers (`.shadergraph`).
-   New shaders for the new wind effects, but no major changes to lighting.

### Changes introduced in 2023.2

Improved SpeedTree visual quality in HDRP using a Transmission Mask to apply subsurface scattering only on leaves. HDRP/Nature/SpeedTree8.shadergraph to use its Subsurface Map for the Transmission Mask node to remove the unintended light transmission from tree barks and twigs. This also fixes the overly bright billboard lighting not matching the 3D geometry’s lighting.

### Changes introduced in 2023.1

`HDRP/Nature/SpeedTree8.shadergraph` now uses its Subsurface Map for the Transmission Mask node to remove the unintended light transmission from tree barks and twigs. This also fixes the overly bright billboard lighting which didn’t quite match the 3D geometry’s lighting.

<span id="splines"></span>

## Splines

### Changes introduced in 2023.2

You can now store personalized data on Spline objects. Additionally, the interface for editing points in the Inspector has been enhanced and certain APIs have been made available to the public. When you work on splines, you can now use the new [Scene view context menu](https://docs.unity3d.com/6000.3/Documentation/Manual/SceneViewContextMenu.html).

<span id="terrain"></span>

## Terrain

### Changes introduced in 2023.1

-   Migrated Terrain Tools to the Overlays toolbar framework to ensure that users have consistent and predictable Editor Scene authoring workflows.
-   Added Quality Settings to control various Terrain settings at different quality levels.

<span id="test-framework"></span>

## Test Framework

### Changes introduced in 2023.2

-   Enabled retrying and repeating tests based on test level. Soon as the test finishes running its first iteration, the Editor now retries or repeats the test. Pass the command line arguments to the Editor to:
    -   Repeat x runs the test x amount of times or until it fails. This is useful for testing unstable tests.
    -   Retry x if a test fails. This run the test x amount of times or until it succeeds.
-   You can now run the tests in a randomized order, by using the Editor command line new argument `-randomOrderSeed x`, where `x` is an integer different from 0. If a new test is added to the project, the Test Framework keeps the random order passing the same seed, and places the new test in the random list accordingly.
-   Added `TestFileReferences.json` to generate on a build step of the player, so that Test runners can consume it to enrich data for the run step.
-   The UTF version now automatically updates for SRP tests.

<span id="version-control"></span>

## Version Control

### Changes introduced in Unity 6.0

-   Added an option to delete non-empty branches that you haven’t merged anywhere.
-   Added a setting to automatically add any new files to source control.

### Changes introduced in Unity 6.0 Preview

Added a new tab view to list and manage locks in the Version Control feature of Unity.

### Changes introduced in 2023.2

Added a project option to support tracking packages that exist on disk outside of the project’s root folder.

### Changes introduced in 2023.1

-   Added a new Branch Name column in the Changesets view.
-   Added changelist related options to pending changes context menu.
-   Added option to enable changelists and display them in pending changes tab.

<span id="visual-scripting"></span>

## Visual Scripting

### Changes introduced in 2023.1

-   Added a confirmation dialog when you reset assemblies and types in Project settings.
-   Added a confirmation dialog when you reset Project settings and Editor preferences.
-   Added Sticky Notes for ScriptGraph and StateGraph.
-   Added support for parameter renaming in code used by API nodes.
-   Added support for nodes to have a button which triggers a custom action in their Inspector description.
-   Added support to convert nodes with an unknown type to placeholder nodes. These nodes return to normal when their original type is redefined, or if you replace the node.

<span id="vfx-graph"></span>

## VFX Graph

### Changes introduced in Unity 6.0 Preview

-   Improved the Shader Graph Cross Pipeline workflow.
-   You can now handle built-in and custom attributes from the blackboard panel.
-   Allowed instanced rendering of VFX that have exposed textures or graphic buffers.
-   Strips now support the “Indirect draw” option. “Indirect draw” renders only the particles that are active, instead of full capacity.
-   Added support for per-particle sorting in strips.
-   Added new profiling/debugging panels in the VFX window.
-   Added Camera Buffer Access support in VFX with URP.
-   Support of `ShaderKeyword` declared in Shader Graph.
-   Reworked Flipbook player block.
-   Added collision events that allow specific processes upon contact.
-   The following improvements have been made to shortcuts in VFX Graph:
    -   Registered the shortcuts in the global Unity Shortcut window.
    -   Synced shortcuts with ShaderGraph where possible.
    -   Added new shortcuts.
-   Added particle count readback for strips, which also allows strips to go to sleep state.
-   Enabled Frustum Culling for strips.

### Changes introduced in 2023.2

-   Added VFX Graph assets with a predefined effect to the template window. You can use these templates as a starting point for your own effects.
-   Added Custom HLSL blocks and operators. Custom HLSL nodes let you execute your own code during particle simulation. You can use an operator for horizontal flow or a block for vertical flow in the VFX Graph context.
-   Added URP Decals with VFX Graph. URP Lit decal output are now supported in VFX Graph, making it possible to create stunning decal effects on URP that matches correctly your scene lighting and materials
-   Added lighting for Shader Graph smoke effects in HDRP and URP. This means that you can create custom smoke shaders that use six-way lighting in lit shaders.
-   Extended the Camera Depth and Color buffer behavior in URP. This means you can use the depth buffer for depth-based collisions or sample the color buffer to create custom effects.
-   Added support for motion vectors in URP.
-   Added support for motion vectors with Shader Graph.
-   Added the ability to use VFX Graph’s Shade Graph integration to use the material variant workflow to override settings in the VFX Output.
-   Enabled VFX instancing with exposed textures, meshes, or graphic buffers.

### Changes introduced in 2023.1

-   Added a new output to modify the volumetric fog of HDRP.
-   Added VFX integration in Ray Tracing.
-   Fixed the six-way lighting and lightmap remapping options.
-   Optimized CPU and GPU VFX runtime in VFX Instancing.

<span id="xr"></span>

## XR

### Changes introduced in Unity 6.0

-   Enabled Optimized Buffer Discards setting for RenderGraph.
-   Added support for Apple visionOS 2.0.
-   Support Burst when running in the visionOS Simulator. Note: This features requires Burst 1.8.13+.
-   Added visionOS platform to Windows and Linux Editors. Note: App builds still require Xcode running on a Mac Silicon computer.
-   Added single-pass shader support for visionOS.
-   Added support for keyboard input in XR apps on visionOS.
-   XR package version updates
    -   [com.unity.xr.arcore](https://docs.unity3d.com/Packages/com.unity.xr.arcore@6.0/changelog/CHANGELOG.html): 5.1.0-pre.8 to 6.0.3
    -   [com.unity.xr.arfoundation](https://docs.unity3d.com/Packages/com.unity.xr.arfoundation@6.0/changelog/CHANGELOG.html): 5.1.0-pre.8 to 6.0.3
    -   [com.unity.xr.arkit](https://docs.unity3d.com/Packages/com.unity.xr.arkit@6.0/changelog/CHANGELOG.html): 5.1.0-pre.8 to 6.0.3
    -   [com.unity.xr.core-utils](https://docs.unity3d.com/Packages/com.unity.xr.core-utils@2.3/changelog/CHANGELOG.html): 2.2.1 to 2.3.0
    -   [com.unity.xr.hands](https://docs.unity3d.com/Packages/com.unity.xr.hands@1.4/changelog/CHANGELOG.html): 1.2.1 to 1.4.1
    -   [com.unity.xr.interaction.toolkit](https://docs.unity3d.com/Packages/com.unity.xr.interaction.toolkit@3.2/changelog/CHANGELOG.html): 2.4.0 to 3.0.5
    -   [com.unity.xr.legacyinputhelpers](https://docs.unity3d.com/Packages/com.unity.xr.legacyinputhelpers@2.1/changelog/CHANGELOG.html): 2.1.10 to 2.1.11
    -   [com.unity.xr.management](https://docs.unity3d.com/Packages/com.unity.xr.management@4.5/changelog/CHANGELOG.html): 4.3.3 to 4.5.0
    -   [com.unity.xr.meta-openxr](https://docs.unity3d.com/Packages/com.unity.xr.meta-openxr@2.0/changelog/CHANGELOG.html): 1.0.1 to 2.0.1
    -   [com.unity.xr.oculus](https://docs.unity3d.com/Packages/com.unity.xr.oculus@4.3/changelog/CHANGELOG.html): 4.0.0 to 4.3.0
    -   [com.unity.xr.openxr](https://docs.unity3d.com/Packages/com.unity.xr.openxr@1.12/changelog/CHANGELOG.html): 1.8.1 to 1.12.1

### Changes introduced in Unity 6.0 Preview

Added support for Foveated Rendering on Vision Pro.

### Changes introduced in 2023.2

-   Added Hololens Automation Support.
-   Extended Unity’s integrated support for tone-mapping and outputting to HDR Displays in URP, HDRP and the built-in render pipeline to provide support for XR devices that have a HDR display.

## Additional resources

-   [New in Unity 2023.1](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNew20231.html)
-   [New in Unity 2023.2](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNew20232.html)
-   [New in Unity 6.0 Preview](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6Preview.html)
-   [Upgrade Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuides.html)
-   [System requirements](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html)
-   [Install Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/GettingStartedInstallingUnity.html)
