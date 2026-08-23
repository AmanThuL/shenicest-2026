---
title: "New in Unity 6.0 Preview"
page_title: "Unity - Manual: New in Unity 6.0 Preview"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6Preview.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity6Preview.html"
topic: "unity6-release"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# New in Unity 6.0 Preview

Find out what’s changed in Unity 6.0 Preview since 2023.2 and view the documentation for the affected areas.

To find out more about the new features, changes, and improvements to this Unity version, refer to the [Unity 6.0 Preview Release Notes](https://unity.com/releases/editor/whats-new/6000.0.0#release-notes).

To find the release notes for other releases, refer to the [Unity download archive](https://unity.com/releases/editor/archive).

If you are upgrading existing projects from 2023.2, read the [Upgrade Guide to Unity 6.0 Preview](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity6Preview) for information about how your project might be affected.

## Editor and Workflow

-   Added a [piercing menu](https://docs.unity3d.com/6000.3/Documentation/Manual/SelectionPiercingMenu.html) that you can use to select GameObjects that overlap with other GameObjects. To open the piercing menu,  hold down **Ctrl+Right-click** in the Scene view. The piercing menu displays a list of all selectable GameObjects under the cursor.
-   Added `Additional App IDs` to Steam ID Provider Editor Settings for Multiple App ID support.
-   Introduced [Build Profiles](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles.html) to create multiple custom build configurations for each target platform. 
-   The Build Profile Diagnostic checkbox is no longer available because the Build Settings window has been replaced with the Build Profile window.
-   Integrated new build profile icons.
-   Modified the **Create** menu to replace the C# Script menu item with three separate options:
    -   **MonoBehaviour Script**
    -   **ScriptableObject Script**
    -   **Blank Script**
-   Improved the **Create** menu to reduce the amount of items at the root of the menu. The menu is now ordered alphabetically, and almost all items are now in a category.

### UI Toolkit

-   Added missing [UxmlAttribute converters](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UxmlAttributeConverter_1.html) to support UXML authoring: `Gradient`, `AnimationCurve`, `ToggleButtonGroupState`, Unsigned Int, and Unsigned Long.
-   Added support in `PropertyField` for `ToggleButtonGroupState` serialized properties.
-   Native [Text Generator](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-advanced-text-generator.html) Rewrite. With the Text Generator, you can use a wide array of languages and scripts, such as right-to-left (RTL) languages like Arabic and Hebrew.
-   Added a debugger for the UI Toolkit dynamic atlas.
-   Added support for deep nested attribute overrides in UXML and UI Builder.
-   Added type selector using Search.
-   Added a search field in the UI Builder Library.

## Entities

-   Added serialization support for `UnityObjectRef<>` to enable unmanaged references to Unity assets. For example, instead of a Texture on a managed IComponentData, you can have a `UnityObjectRef<Texture>` on an unmanaged `IComponentData`.
-   The Create menu adds the following Type templates: 
    -   `IComponentData`
    -   `ISystem`
    -   `IJobEntity`
    -    Baker
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

## Graphics

-   Added the GPU Resident Drawer, which automatically uses the `BatchRendererGroup` API to draw GameObjects with GPU instancing. This reduces the number of draw calls and frees CPU processing time.
-   Added support for SpeedTree GameObjects to the GPU Resident Drawer.
-   Added support for GPU occlusion culling of instances if they’re compatible with the GPU Resident Drawer, including culling of small meshes.
-   Adding a new per-batch layer filtering setting for the `BatchRendererGroup` API. You can use this setting to cull specific batches.
-   Optimized CPU performance of the Volume framework in URP and HDRP, to improve efficiency on low-end hardware and allow more precise control over quality settings.
-   Added a **Force No Crunch**  texture compression setting in **Build Profiles** > **Asset Import Overrides**, which forces all textures to disable crunch compression and re-import.
-   Added an `IRenderPipelineResources` interface that allows you to add new settings groups in the Graphics Settings window.
-   Updated the default `IRenderPipelineGraphicsSettings` Inspector to trigger notifications when a value in Graphics Settings is modified.
-   Added a custom menu in `IRenderPipelineGraphicsSettings`.
-   Added UI Toolkit support for `CustomPostProcessOrder`.
-   Added the option to cache render graph compilation for both URP and HDRP.

### URP

For a complete description of new features and improvements in URP, refer to [What’s new in URP](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@17.0/manual/whats-new/urp-whats-new.html).

-   Added the `8192x8192` option to Shadow texture resolution for the Main Light and Additional Lights.
-   Added support for foveated rendering in the Forward+ rendering path.
-   Added a Camera History Texture manager and basic interfaces to access per-camera history textures. History textures are wrapped and stored in types which contain all the textures, additional data, and API methods specific for that history. History textures are useful for rendering algorithms that accumulate samples over multiple frames or use data of previous frames as input.
-   Added Adaptive Probe Volumes (APV) Lighting Scenario Blending to URP.
-   Added a new config package that allows you to override the maximum number of lights visible on screen.
-   Added per-camera color and depth history and history access for custom render passes.
-   Added Render Graph Viewer. Access it through the **Window** > **Analysis** > **Render Graph Viewer** menu. The tool helps to visualize and debug resource usage of Render Passes in the Render Graph framework.
-   Added six Mipmap Streaming debug views to the Rendering Debugger. These views are in the **Rendering** tab, under **Mipmap Streaming**. The available debug views are:
    -   Mip Streaming Performance
    -   Mip Streaming Status
    -   Mip Streaming Activity
    -   Mip Streaming Priority
    -   Mip Count
    -   Mip Ratio
-   Added C# script templates to create a post-processing `ScriptableRendererFeature` that uses a custom `VolumeComponent`.
-   Added APV Sky Occlusion support for URP.
-   Added support for Spatial Temporal Post-Processing (STP) upscaling solution.
-   The new RenderGraph system for URP in Unity 6.0 automates runtime resource optimization, simplifying memory usage and enhancing performance, especially on mobile GPUs. Its stricter API guidelines minimize rendering errors and performance issues. The integration of the NativeRenderPass API and a comprehensive debug viewer aid in efficient troubleshooting and resource management. Additionally, the new ContextContainer class offers streamlined access to rendering resources, improving ease of use and control in complex projects.
-   This URP version implements the **Alpha Processing** setting (**URP Asset** > **Post-processing** > **Alpha Processing**). With this setting enabled, URP renders the post-processing output into a render texture with the alpha channel. Previously the post-processing workflow in URP discarded the alpha channel (replaced alpha values with 1) in the final output. The render target requires a format with the alpha channel. The camera color buffer format must be RGBA8 for SDR (HDR off) and RGBA16F for HDR (64-bits). You can configure the format using the settings in **URP Asset** > **Quality**.

### HDRP

For a complete description of new features and improvements in URP, refer to [What’s new in HDRP](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.0/manual/whats-new-17.html).

-   Added support for overriding material properties such as smoothness, albedo, and normal maps on all materials to facilitate material and lighting debugging. The material override feature in HDRP is available through the Rendering Debugger’s Lighting panel when rendering through the path tracer pipeline.
-   Added the Sky Occlusion feature to Adaptive Probe Volumes (APV), to allow time of day with static probe volumes.
-   Disabled storing of baked data as Streaming Asset in Adaptive Probe Volumes (APV) to make it compatible with Asset Bundles and Addressables.
-   Added AMD FidelityFX Super Resolution 2 (FSR2) Unity script bindings and HDRP integration.
-   Improved on existing Mipmap Streaming debug views and added more. The current offering in HDRP is consistent with what URP offers.
-   Added support for Spatial Temporal Post-Processing (STP) upscaling solution.

## Multiplayer

### Netcode for GameObjects

-   Added Distributed Authority mode in Netcode for GameObjects clients have distributed ownership of or authority over spawned Netcode objects during a game session. With Distributed Authority, the clients have the governed authority to spawn network objects which is announced to the cloud state service and conveys state updates to all connected clients. A highly optimized cloud state service maintains the overall state of a network session between clients.
-   Added a new RPC attribute that can perform the functions of both Server and Client RPCs, as well as enabling client-to-client RPCs.
-   Added many utility methods, which include `NetworkManager.OnConnectionEvent`, `-ServerIsHost`, `-InstantiateAndSpawn`, and more.

### Netcode for Entities

-   Added support for GameObjects to render debug bounding boxes.
-   Added the NetCodeConfig ScriptableObject which contains most NetCode configuration variables that you can customize without needing to modify code.
-   You can now disable the automatic bootstrapping in the following ways:
    -   Disable automatic bootstrapping in the ProjectSettings.
    -   Add the new `OverrideAutomaticNetcodeBootstrap` MonoBehaviour to your first build scene.
-   Added `AlwaysRelevantQuery` that you can use to specify general rules for relevancy without specifying it ghost by ghost.
-   `Added BatchScaleImportanceDelegate`, a new version of the importance scaling function that works in batches. It is not required to set both the ScaleImportance and the BatchScaleImportance function pointers. If the BatchScaleImportance is set, it is the preferred.

### Multiplayer Play Mode

Updated Multiplayer Play Mode to version 1.0. Use it to test multiplayer functionality without leaving the Unity Editor. For more information, refer to the [Multiplayer Play Mode documentation](https://docs.unity3d.com/Packages/com.unity.multiplayer.playmode@latest).

### Dedicated Server

Released the Dedicated Server package that you can use to switch a project between the server and client role without the need to create another project. For more information, refer to the [Dedicated Server package documentation](https://docs.unity3d.com/Packages/com.unity.dedicated-server@1.0/manual/index.html).

### Tools

Updated the Multiplayer Tools package to version 2.1.0, adding Network Scene Visualization as a new visual debugging tool. For more information, refer to the [Multiplayer Tools documentation](https://docs.unity3d.com/Packages/com.unity.multiplayer.tools@latest).

### Samples

-   Added the Dedicated Game Server sample to demonstrate how Multiplayer Play Mode and the Dedicated Server work together with Netcode for GameObjects.
-   Added the Distributed Authority sample that integrates the Distributed Authority network model in Netcode for GameObjects.

## Package Manager

Improved the behavior of [Project manifest](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPrj.html) files by repopulating them with default dependencies if the files are empty or full of whitespace.

## Particles

-   Added the Custom Vertex Streams feature for particle trails.
-   Add `BakeTexture` and `BakeTrailsTexture` scripting methods.

## Platforms

### Android

-   Added a new Build setting to embed debug symbols into an app bundle when uploading `.aab` files to the Google Play Store. You have an option to upload the symbols package separately as a zip file with your `.apk` or `.aab` files. You can create symbol files with `.so.sym` or `.so.dbg` and the legacy `.so` extensions.
-   Added a new Player setting to display warnings when the symbol’s package size exceeds the specified threshold.
-   Added a new property in `.androidlib` Plug-in Inspector to specify dependencies for `unityLibrary`. You can now configure `.androidlib` to depend on `unityLibrary`, and thus expand an activity by overriding `UnityPlayerActivity`.

### iOS

-   Added `.xcframework` plugins support.
-   Removed Custom XIB Launch Screen Type from Player settings.

### visionOS

Added support for Apple’s visionOS platform.

### Web platform (previously WebGL)

-   Implemented the following `LocationService` methods and properties in Web platform:
    -   `Start()`
    -   `Stop()`
    -   `isEnabledByUser`
    -   `lastData`
    -   `status`

-   Added the ability to copy and paste to and from the Unity player.

-   Added support for **WebAssembly 2023**. For more information, refer to [WebAssembly 2023](https://docs.unity3d.com/6000.0/Documentation/Manual/webassembly-2023.html). WebAssembly 2023 includes support for up to 4GB of heap memory and is a collection of the following WebAssembly language features:
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

## Platform Graphics

Added support for indirect Dispatch Rays (part of DXR 1.1). The method is similar to `RayTracingShader.Dispatch`, but the three dispatch dimensions are retrieved from a GraphicsBuffer. Added `RayTracingShader.DispatchIndirect` and a new `CommandBuffer.DispatchRays` signature. Added `SystemInfo.supportsIndirectDispatchRays` capability status.

## ProBuilder

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

## Profiler

Released version 1.1.0 of Memory Profiler. Refer to the [Memory Profiler package documentation](https://docs.unity3d.com/Packages/com.unity.memoryprofiler@1.1/manual/whats-new.html) for details.

## Shader Graph

-   Added a new sample content pack that can be installed with the Package Manager. The samples contain descriptions, examples, and break downs for a majority of the nodes in Shader Graph. These samples help you understand the inner workings of the nodes and see examples of how they work and how to use them.
-   Added new shortcuts for adding new nodes and toggling sub-window visibility, and moved several existing shortcuts to the Shortcut Manager.
-   Added a zoom step size option in the user preferences.
-   Added a customizable Heatmap color mode, which by default displays the estimated performance impact of each node in a Shader Graph.
-   Added the Feature Examples Sample to Shader Graph to show users how to achieve specific effects in Shader Graph.

## SpeedTree

Added the SpeedTree9Importer, which supports .st9 files exported by SpeedTree Modeler 9 and includes the following:

-   Support for SpeedTree Games Wind and SpeedTree Legacy Wind effects.
-   The ability to configure wind strength and direction responsiveness through the Importer Settings.
-   New SpeedTree9 shaders for built-in (`.cg`), URP, and HDRP renderers (`.shadergraph`).
-   New shaders for the new wind effects, but no major changes to lighting.

## Version Control

Added a new tab view to list and manage locks in the Version Control feature of Unity.

## VFX Graph

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

## XR

Added support for Foveated Rendering on Vision Pro.

## Additional resources

-   [New in Unity 2023.2](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNew20232.html)
-   [New in Unity 2023.1](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNew20231.html)
