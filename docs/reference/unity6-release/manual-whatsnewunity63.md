---
title: "New in Unity 6.3"
page_title: "Unity - Manual: New in Unity 6.3"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity63.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity63.html"
topic: "unity6-release"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# New in Unity 6.3

Unity 6.3 (6000.3) introduces several new features and improvements.

To read about all of the changes and known issues in this version of Unity, refer to the [Unity 6.3 Release Notes](https://unity.com/releases/editor/whats-new/6000.3.0#notes).

To find the release notes for other releases, refer to the [Unity download archive](https://unity.com/releases/editor/archive).

To read about changes made to packages that were updated as part of this release, refer to the [documentation of those packages](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-docs.html).

If you’re upgrading existing projects from Unity 6.2 (6000.2), refer to [Upgrade to Unity 6.3](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html) for information about how your project might be affected.

Review the new features and improvements for Unity 6.3 in these areas:

-   [2D](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity63.html#2d)
-   [Accessibility](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity63.html#accessibility)
-   [Animation](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity63.html#animation)
-   [Audio](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity63.html#audio)
-   [Editor and workflow](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity63.html#editor-and-workflow)
-   [Graphics](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity63.html#graphics)
-   [Optimization](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity63.html#optimization)
-   [Package Manager](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity63.html#package-manager)
-   [Physics](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity63.html#physics)
-   [Platforms](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity63.html#platforms)
-   [UI Toolkit](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity63.html#ui-toolkit)
-   [XR](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity63.html#xr)

<span id="2d"></span>

## 2D

This section outlines recent updates to Unity’s 2D system.

### Low-level 2D physics APIs

Added low-level 2D physics APIs that are an integration of Box2D v3, which is the latest actively developed version of Box2D. Box2D v3 includes multi-threaded performance improvements, enhanced determinism, visual debugging support for both Editor and Runtime, improved gizmos, and more.

You can leverage the low-level 2D physics system to create physics objects directly in your scene or to design custom components for your GameObjects that manage these physics objects. These APIs are available under the `UnityEngine.LowLevelPhysics2D` namespace. To learn more, refer to the [PhysicsWorld scripting reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LowLevelPhysics2D.PhysicsWorld.html).

To learn more about the low-level 2D physics API, refer to the examples in the [PhysicsExample2D repository](https://github.com/Unity-Technologies/PhysicsExamples2D).

### Render 3D as 2D

The 2D Renderer now supports rendering the [Mesh Renderer](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MeshRenderer.html) and [Skinned Mesh Renderer](https://docs.unity3d.com/6000.3/Documentation/Manual/class-SkinnedMeshRenderer.html) together with 2D sprites in the same scene when using the 2D Universal Render Pipeline. When using a compatible shader, these renderers can receive lighting from [2D Lights](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/2d-index.html), interact with [Sprite Masks](https://docs.unity3d.com/6000.3/Documentation/Manual/sprite/mask/mask-landing.html) by enabling the **2D** \> **Mask Interaction** property, and be sorted with sprites when **Sort 3D As 2D** is enabled in a [Sorting Group](https://docs.unity3d.com/6000.3/Documentation/Manual/sprite/sorting-group/sorting-group-landing).

<span id="accessibility"></span>

## Accessibility

This section outlines recent updates to Unity’s accessibility systems.

### Native screen reader support on desktop platforms

Extended the [screen reader support APIs](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Accessibility.AssistiveSupport.html) to Windows and macOS, enabling compatibility of Unity applications with Narrator and VoiceOver. For more information, refer to [Introduction to the Accessibility module](https://docs.unity3d.com/6000.3/Documentation/Manual/accessibility/module-intro.html).

### Screen reader scrolling support

Added scrolling support for TalkBack (Android), VoiceOver (iOS), and Narrator (Windows). For more information, refer to [AccessibilityNode.scrolled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Accessibility.AccessibilityNode-scrolled.html) and [IAccessibilityNotificationDispatcher.SendPageScrolledAnnouncement](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Accessibility.IAccessibilityNotificationDispatcher.SendPageScrolledAnnouncement.html).

### General Accessibility API updates and improvements

Made the following changes to the Accessibility API:

-   Added new [AccessibilityRole](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Accessibility.AccessibilityRole.html) values with screen reader support for container views, dropdown menus, tab buttons, and text fields.
-   Added a new [AssistiveSupport.screenReaderStatusOverride](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Accessibility.AssistiveSupport-screenReaderStatusOverride.html) API that allows screen reader support APIs to function even when the screen reader is off or its status is unknown.
-   Changed the underlying type of [AccessibilityRole](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Accessibility.AccessibilityRole.html) and [AccessibilityState](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Accessibility.AccessibilityState.html) to `byte`.
-   Converted [AccessibilityRole](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Accessibility.AccessibilityRole.html) from a flags enum to a standard enum.
-   Deprecated [AccessibilityNode.selected](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Accessibility.AccessibilityNode-selected.html) and renamed it to [AccessibilityNode.invoked](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Accessibility.AccessibilityNode-invoked.html).

To learn how these changes affect your project if you’re upgrading to 6.3, refer to the Accessibility API changes in [Upgrade to Unity 6.3](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html#accessibility).

<span id="animation"></span>

## Animation

This section outlines recent updates to Unity’s animation system.

### Improved performance of the Animation component in Legacy animation

Due to a back end change, the overall time spent evaluating Legacy Animation has decreased by up to 30% depending on the complexity of the animated objects. The performance improvement is most significant for animations that affect large hierarchies or GameObjects, or that animate many properties.

### New ResetControllerState method in Animator and AnimatorControllerPlayable

Added the new `ResetControllerState` method to the `Animator` and `AnimatorControllerPlayable` classes to simplify the pooling of Animators. You can use this method to revert animators to their original state before returning them to the pool. To learn more, refer to the [AnimatorControllerPlayable.ResetControllerState scripting reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animations.AnimatorControllerPlayable.ResetControllerState.html).

<span id="audio"></span>

## Audio

This section outlines recent updates to Unity’s audio system.

### Scriptable audio pipeline

Added a new audio signal chain using Burst-compiled C# units called [scriptable processors](https://docs.unity3d.com/6000.3/Documentation/Manual/audio-scriptable-processors-concepts.html). You can use scriptable processors to customize audio behavior by adding your own audio processing to Unity at specific integration points in the audio system. For more information, refer to [Scriptable audio pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/audio-scriptable-processors.html).

<span id="editor-and-workflow"></span>

## Editor and workflow

This section outlines recent updates to the Editor’s general workflows and user interface.

### Ads Mediation

Added **Ads Mediation (LevelPlay)** to the **Services** menu and **Project Settings** to make it easier to discover and install the Ads Mediation package from the Unity Editor. Refer to the [Getting Started with Unity guide](https://developers.is.com/ironsource-mobile/unity/levelplay-starter-kit/) for more information about integrating LevelPlay.

The 9.0.0 version of the Ads Mediation package includes improved SDK quality and architecture, standardized APIs, and cleaner integration for developers who integrate the Ads Mediation package into a Unity project. Refer to the [Unity Package Migration guide](https://developers.is.com/ironsource-mobile/unity/unity-plugin/unity-package-migration-9-0-0/) for more information.

### Build Profiles UI and settings

Improved the Build Profiles window interface for customizing build profiles. You can select only the specific settings that you want to configure through the **Add Settings** button in the **Build Profiles** window. This feature allows you to choose which settings to configure for a specific build profile, such as:

-   Scene list
-   Scripting Defines
-   Player settings
-   Quality settings
-   Graphics settings

Only the selected settings appear within their own sections on the **Build Profiles** window.

You can use C# scripts to configure some of these settings for specific build profiles by using these methods in the [BuildProfile](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.html) class:

-   [AddComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.AddComponent.html)
-   [CreateComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.CreateComponent.html)
-   [GetComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.GetComponent.html)

These helper methods allow you to manage [ScriptableObjects](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html) linked to a specific build profile. Each build profile can contain only one instance of the ScriptableObject type.

### Customize the toolbar

You can now change the appearance and location of controls in the main toolbar. You can also create presets to save the layout of controls in the toolbar. For more information, refer to [Customize the toolbar](https://docs.unity3d.com/6000.3/Documentation/Manual/Toolbar.html).

### Quality levels in the toolbar

You can now quickly switch between Quality levels directly from the main Editor toolbar, without opening additional menus. For more information, refer to [Toolbar reference](https://docs.unity3d.com/6000.3/Documentation/Manual/Toolbar-reference.html).

### Deeplinking for local projects

You can now forward deeplinks to local Unity projects to automatically perform operations within the Unity Editor. Predefined deeplink operations include creating a new project, installing a specific package version, or downloading assets from the Unity Asset store. Alternatively, use the [DeeplinkHandler](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/DeeplinkHandlerAttribute.html) attribute to define your own deeplink operations. For more information, refer to [Deeplinking support for local projects](https://docs.unity.com/hub/deeplinking-support) in the Unity Hub documentation. Deeplinking requires Unity Hub 3.15 or later.

### Dialog box improvements

Unity Editor dialog boxes for warnings, information, and alerts now display appropriate icons. The dialog boxes can be configured to include opt-out checkboxes. For more information, refer to the [EditorDialog API](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorDialog.html) reference.

### Dynamic overlays

Overlay panels have new options to control their height and size. You can collapse and expand an overlay, drag and move it to the toolbar, or dock it at any edge of the Scene view.

To learn more about overlay properties, refer to [Overlays reference](https://docs.unity3d.com/6000.3/Documentation/Manual/overlays-reference.html).

### New Hierarchy window

You can now use a different version of the Hierarchy window. This Hierarchy window displays extra information about GameObjects and can alternate the color of each GameObject in the list. For more information, refer to [Hierarchy window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/hierarchy-reference.html).

To learn how to enable the new Hierarchy window, refer to [Preferences](https://docs.unity3d.com/6000.3/Documentation/Manual/preferences-general.html). The **New Hierarchy** setting is in preview and might change in future versions of Unity.

### Search Indexing

Unity Search now uses a new LMDB-based back end (the same industry-standard database used by the Asset Database). The new back end significantly improves performance, especially for incremental updates, and scales reliably to large projects.

The Search Index has been simplified for easier use with the following:

-   A single index file that is now always created in `UserSettings/Search.index`. All custom indices created in a project are now ignored.
-   Dependencies, Types, and Properties are always indexed.
-   The Search Index Manager (**Windows** > **Search** > **Index Manager**) has been removed.

To customize Search indexing, go to **Preferences** \> **Search** \> **Indexing**. You can select the following options for indexing:

-   **Index on Editor startup**: When enabled, indexing starts automatically in background `AssetWorker` processes as soon as the Editor launches. When disabled, indexing only occurs the first time any Search API or tool is used. This option is enabled by default.
-   **Deep scene and prefab indexing**: Indexes the full content of scenes and prefabs. This process is longer than normal indexing. This option is disabled by default.

### Launch screen improvements

Improved consistency of the Unity Editor launch screen user interactions across supported platforms.

<span id="graphics"></span>

## Graphics

This section outlines recent updates to Unity’s graphics systems.

### Limit or remove shader variants by keyword

To reduce the number of shader variants Unity compiles, you can now use the new [Shader Build Settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-GraphicsSettings.html#shader-build-settings) in the Graphics settings window. You can do the following:

-   Limit the number of shader variants by setting the keyword type to `shader_feature` or `dynamic_branch`.
-   Exclude shader code for keywords in build profiles.
-   [Enable dynamic branching in prebuilt shaders](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/shader-stripping-fog.html) in URP.

For more information, refer to [Reduce shader variants](https://docs.unity3d.com/6000.3/Documentation/Manual/shader-variant-stripping.html).

### Check if a shader supports a graphics API

You can now use the [ShaderUtil.IsGraphicsAPISupported](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ShaderUtil.IsGraphicsAPISupported.html) API to check if a shader pass or compute shader is compatible with a graphics API.

### Ray tracing API

Ray tracing shaders now support the following:

-   Hit shaders. For more information, refer to the new [GetAnyHitShaderName](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ShaderUtil.GetAnyHitShaderName.html) and [GetClosestHitShaderName](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ShaderUtil.GetClosestHitShaderName.html) APIs.
-   `multi_compile` and `dynamic_branch` keyword support for ray-tracing shaders.

You can now use new overloads of the [RayTracingAccelerationStructure.AddInstancesIndirect](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RayTracingAccelerationStructure.AddInstancesIndirect.html) API to add multiple materials and geometries as ray tracing instances into an acceleration structure.

### GraphicsStateCollection experimental API improvements

The experimental [GraphicsStateCollection API](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Experimental.Rendering.GraphicsStateCollection.html) has new utility methods and overrides that provide a greater degree of control:

-   Added a new [CopyGraphicsStateForVariant](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Experimental.Rendering.GraphicsStateCollection.CopyGraphicsStatesForVariant.html) method.
-   Added a new [AddVariants](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Experimental.Rendering.GraphicsStateCollection.AddVariants.html) method, which adds multiple variants based on the subshaders and passes of a material.
-   The [ShaderVariant](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Experimental.Rendering.GraphicsStateCollection.ShaderVariant.html) constructor now accepts `shader`, `passId`, and `keywords`.
-   [AddVariant](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Experimental.Rendering.GraphicsStateCollection.AddVariant.html), [RemoveVariant](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Experimental.Rendering.GraphicsStateCollection.RemoveVariant.html), and [ContainsVariant](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Experimental.Rendering.GraphicsStateCollection.ContainsVariant.html) now accept `Material`.
-   [AddGraphicsStateForVariant](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Experimental.Rendering.GraphicsStateCollection.AddGraphicsStateForVariant.html) and [RemoveGraphicsStateForVariant](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Experimental.Rendering.GraphicsStateCollection.RemoveGraphicsStatesForVariant.html) now accept `ShaderVariant`.
-   [GraphicsState.SetMeshData](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Experimental.Rendering.GraphicsStateCollection.GraphicsState.SetMeshData.html) now accepts `Mesh`, `submeshIndex`, and optional `Renderer`.
-   [GraphicsState.SetRenderPassData](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Experimental.Rendering.GraphicsStateCollection.GraphicsState.SetRenderPassData.html) now accepts and sets `sampleCount`, `attachments`, `subPasses`, and other optional parameters.

### Shared Render Graph foundation across URP and HDRP

Both the Universal Render Pipeline (URP) and the High Definition Render Pipeline (HDRP) now use the same underlying Render Graph compiler and API. This shared back end lays the foundation for unified extensibility across pipelines and enables focused improvements and performance tuning on a single system.

### Render Graph Viewer on devices

You can now connect the Render Graph Viewer to player builds running on devices, including mobile and XR platforms. This gives you real-time visibility into Render Graph execution on actual hardware, so you can optimize performance.

This feature enables you to do the following:

-   Inspect Render Graph behavior on real devices.
-   Analyze native render pass merging at runtime and identify unnecessary load and store actions.
-   Track how the graph adapts dynamically based on on-screen content to spot frame-specific or content-dependent performance issues.
-   Monitor live with an auto-updating UI that reflects changes as they happen. You can pause updates manually or rely on automatic pauses if the device disconnects.

This feature is especially useful for optimizing GPU bandwidth and performance on untethered XR devices like Meta Quest 3.

For more information, refer to [Analyze a render graph](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-view.html) and [Render Graph Viewer reference](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-viewer-reference.html).

### Smarter Render Graph Helper Passes

The Render Graph utility passes now support more use cases and offer greater flexibility when creating fullscreen and copy effects. This includes the following:

-   `AddBlitPass` now returns a builder so you can further customize the pass to your needs.
-   You can now blit directly to the backbuffer, which enables simpler fullscreen effects.
-   `AddBlitPass` and `AddCopyPass` are now used internally in `FullscreenPassRendererFeature` and `CopyColorPass` when applicable.
-   Null validation ensures misconfigured blit passes fail early and clearly.
-   WebGL2 and GLES3 fallbacks are handled correctly when required.
-   Added depth blit support so you can now blit depth data to both depth and color textures, with automatic MSAA resolve when needed.

### Per-renderer value for material aspect customization

You can now use the new `unity_RendererUserValue` variable to significantly improve your project’s performance when you need to make a large number of similar objects appear different within the same scene.

The new [MeshRenderer.SetShaderUserValue](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MeshRenderer.SetShaderUserValue.html) and [SkinnedMeshRenderer.SetShaderUserValue](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SkinnedMeshRenderer.SetShaderUserValue.html) APIs allow you to specify per-renderer data in a custom 32-bit integer value and use this data to apply shader variations on a single material used by all renderers. For example, the value can include an encoded RGBA32 color, a set of UV indices across a texture atlas, or an index to a larger data structure if you need to manage larger amounts of data per renderer.

Unity references this custom 32-bit integer value as the Renderer Shader User Value (RSUV), named `unity_RendererUserValue` in the API. In Shader Graph, you can access it with a [Custom function node](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Custom-Function-Node.html).

You can also use the [GPU Resident Drawer (GRD)](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/reduce-rendering-work-on-cpu.html) along with the RSUV to further improve your project’s performance.

For more details about RSUV:

-   Refer to the feature’s [documentation](https://docs.unity3d.com/6000.3/Documentation/Manual/renderer-shader-user-value.html).
-   Import the [**Renderer Shader User Value** sample](https://docs.unity3d.com/6000.3/Documentation/Manual/renderer-shader-user-value-sample.html) (available in URP and HDRP packages)

### Metal support for NativeGraphicsJobsSplitThreading

You can now use [RenderingThreadingMode.NativeGraphicsJobsSplitThreading](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.RenderingThreadingMode.NativeGraphicsJobsSplitThreading.html) when targeting devices that support the Metal graphics API.

### Filtering options for Bloom post-processing

In URP, you can now use the new Kawase and Dual filtering options for Bloom post-processing to improve performance, especially on low-end hardware and platforms. In the **Bloom Volume Override**, set the **Filter** as **Dual** for a faster alternative for mobile devices, or **Kawase** as the fastest option at low resolution. The default option remains **Gaussian** for best quality.

The filtering method affects the visual appearance of the Bloom effect, so you need to adjust the properties for each method separately. For more information, refer to [Bloom Volume Override reference for URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/post-processing-bloom.html).

### DLSS4 Super Resolution

The Deep Learning Super Sampling (DLSS) has been upgraded to DLSS4 Super Resolution (v310.3.0) for enhanced upscaling performance and image quality.

### Lighting

This section outlines recent updates to the lighting system.

#### GPU Lightmapper as the default light baking back end

The OpenCL-based GPU Lightmapper is now [the default light baking back end](https://docs.unity3d.com/6000.3/Documentation/Manual/progressive-lightmapper.html). The GPU Lightmapper has been out of preview for several months, so this feature is now the default for new projects and new lighting settings assets.

#### Reflection probe rotation in URP

You can now use the **Rotate** tool to rotate the transform of the [reflection probes](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/lighting/reflection-probes-introduction.html)’ influence volume in URP. This feature makes it easier to light scenes that aren’t axis-aligned convincingly. The reflection probe rotation happens at runtime and is enabled by default for new projects, and opt-in for existing projects.

#### xAtlas lightmap packing in Lighting Window

You can generate tighter, more efficient lightmaps by packing actual UV shapes instead of bounding boxes with xAtlas. xAtlas is the default for new scenes. Existing scenes keep the older packer to avoid layout changes. You can switch methods in the [Lighting window](https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-window.html) or through the [`LightingSettings`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LightingSettings.html) API. However, packing can be slower and scales with scene size.

#### UnifiedRayTracing API

Added a new `UnifiedRayTracing` API library that enables ray tracing workloads on GPUs without dedicated hardware acceleration. You can use this to run GPU raytracing on platforms that don’t support hardware ray tracing via a compute shader-based fallback. For more information, refer to [Ray tracing with the UnifiedRayTracing API](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@17.3/manual/UnifiedRayTracing/unified-ray-tracing-api.html).

**Note**: Your GPU must support compute shaders to use this API.

### Shader Graph

This section outlines recent updates to Shader Graph.

#### Templates for shader graph asset creation

You can now [start from a template](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Create-Shader-Graph.html) to create a new shader graph asset. Unity now provides a selection of various shader graph templates through the [template browser window](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/template-browser.html) according to the render pipeline you’re using in your project. You can also create your own shader graph templates.

#### Improved Fullscreen and Decal material creation workflows

The material creation workflows for the following have been improved:

-   [URP’s Full Screen Pass Renderer Feature](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-features/renderer-feature-full-screen-pass.html)
-   [URP’s Decal Projector](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-feature-decal-projector-reference.html)
-   [HDRP’s Fullscreen Custom Pass](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/custom-pass-reference.html#fullscreencustompass-properties)
-   [HDRP’s Decal Projector](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/decal-projector-reference.html#properties)

In the **Material** property for these features, you can now use the **New** dropdown menu to create a new material along with its associated shader graph asset, which you can further customize.

You can now use the new **Graph Template Workflow** option in [Shader Graph Preferences](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Shader-Graph-Preferences.html) to define whether Unity generates a material or a material variant from the shader graph asset created through this workflow.

#### Additional options for shader graph creation workflow

The [Shader Graph Preferences](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Shader-Graph-Preferences.html) now include two additional options to customize your shader graph creation workflow experience:

-   You can choose whether you want Unity to automatically open the Shader Graph window every time you create a new shader graph asset.
-   You can choose whether you want Unity to automatically expand the preview area of every node you create in a shader graph when that node supports previewing.

#### Extended support of UV channels in the UV node

You can now choose from 8 UV channels (UV0 to UV7) in the [UV node](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/UV-Node.html) to access custom data you might have stored on your meshes in these channels.

#### Interpolation type selection for custom interpolators

You can now control how the data is interpolated when you transfer custom data from the vertex stage to the fragment stage with a [custom interpolator](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Custom-Interpolators-landing.html). You can apply the default linear interpolation, disable perspective correction, or keep values constant per triangle.

#### Promotion of sub graph keywords and properties

When you add a [keyword](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Keywords-reference.html) or a [property](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Property-Types.html) in a sub graph, you can now choose to promote it to the final shader, which allows exposing it as a material property. This allows you to create self-contained subgraphs and simplifies the process of authoring shaders by composition.

#### Lighting model customization through Shader Graph

You can now create your own custom lighting shaders and materials through Shader Graph in URP. The [**URP Unlit** material type](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/prebuilt-shader-graphs-urp-unlit.html) now includes new properties that enable custom lighting model authoring.

Multiple graph examples and additional templates are available to help you get started with custom lighting in Shader Graph. To use these, import the [Custom lighting sample](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Shader-Graph-Sample-Custom-Lighting.html) through the Package Manager.

#### Terrain material customization through Shader Graph

You can now create your own [custom terrain shaders and materials](https://docs.unity3d.com/6000.3/Documentation/Manual/terrain-shader-graph.html) through Shader Graph in URP and HDRP. This new functionality includes the following:

-   A new [**URP Terrain** Lit material type](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/prebuilt-shader-graphs-urp-terrain-lit.html) and a new [**HDRP Terrain Lit** material type](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/terrain-master-stack-reference.html).
-   A new [Terrain Texture node](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Terrain-Texture-Node.html) to sample textures, masks, and other properties from the Terrain Layers of a terrain material.
-   A Terrain shader graph template that you can select from the new [template browser](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/template-browser.html).

Multiple graph examples are available to help you get started with terrain shader customization in Shader Graph. To use these, import the [Terrain Shaders sample](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Shader-Graph-Sample-Terrain.html) through the Package Manager.

#### UI material customization through Shader Graph

You can now create your own [custom UI Toolkit compatible shaders and materials](https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/ui-shader-graph.html) through Shader Graph in URP. This new functionality includes the following:

-   A new [**URP UI** material type](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/prebuilt-shader-graphs-urp-ui.html).
-   A new set of [UI nodes](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/ui-nodes.html) and [Input UI nodes](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Input-Nodes.html#ui).

### Visual Effect Graph

This section outlines recent updates to Visual Effect Graph.

#### Sticky notes UX

You can now manage [sticky notes](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.3/manual/StickyNotes.html) in a Visual Effect Graph in the following ways:

-   Add sticky notes in [groups](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.3/manual/GraphLogicAndPhilosophy.html#groups).
-   Use the visual option menu that appears on top of the note when you select it.
-   Choose between three different sticky note colors: yellow, blue, and red.

<span id="optimization"></span>

## Optimization

This section outlines recent optimization updates.

<span id="profiler"></span>

### Profiler

This section outlines recent updates to the Unity Profiler.

#### Captures List in the Profiler

The Profiler now contains a **Captures List** which contains a list of saved Profiler sessions in your project. You can use the **Captures List** to navigate between saved Profiler sessions without having to manually import a capture every time. For more information, refer to [Profiler window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/ProfilerWindow.html#captures-list).

#### Highlights Profiler module

The Highlights Profiler module now contains a details pane which provides an overview of the amount of time spent on GPU and CPU resources, and the categories that contributed the most amount of time in the Profiler capture. You can use it to evaluate the entire capture, or a selection of frames. For more information, refer to [Highlights Profiler module reference](https://docs.unity3d.com/6000.3/Documentation/Manual/ProfilerHighlights.html).

### Adaptive Performance

Adaptive Performance is now more deeply integrated into the Unity Editor and provides cross-platform support:

-   The Adaptive Performance core functionality is now a built-in Editor module. Its features are available without needing to install a package. For more information, refer to the [Adaptive Performance documentation in the Unity Manual](https://docs.unity3d.com/6000.3/Documentation/Manual/adaptive-performance/adaptive-performance.html).
-   Adaptive Performance now includes a [Basic provider](https://docs.unity3d.com/6000.3/Documentation/Manual/adaptive-performance/basic-provider.html) that captures framerate data for multiple platforms.
-   The [Adaptive Performance package](https://docs.unity3d.com/Packages/com.unity.adaptiveperformance@6.0/manual/index.html) is now a core package that provides optional content, including updated samples and visual scripting nodes that work with the new module.
-   The [Adaptive Performance Android provider package](https://docs.unity3d.com/Packages/com.unity.adaptiveperformance.google.android@latest?subfolder=/manual/index.html) is now a core package compatible with the new module structure on the Android platform.

To upgrade Adaptive Performance in your project, refer to [Upgrade to Unity 6.3](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html#optimization).

### Frame Debugger support for Variable Rate Shading (VRS)

The [Frame Debugger](https://docs.unity3d.com/6000.3/Documentation/Manual/FrameDebugger.html) now supports Variable Rate Shading (VRS) on DX12 and Vulkan. The Frame Debugger shows the base shading rate, the Primitive and Fragment `ShadingRateCombiners`, and the shading rate image as a render pass attachment with an enlargeable preview.

<span id="package-manager"></span>

## Package Manager

This section outlines recent updates to Unity’s Package Manager.

### Package signatures

Added functionality to check for package signatures to maintain a healthy ecosystem that keeps projects secure and stable. For more information, refer to [Package signatures](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-signature.html).

### Package authoring tools

Use the following tools to rapidly iterate on creation and distribution of Unity Package Manager (UPM) packages:

-   Added a **Create package** feature to avoid manual setup of UPM packages. This feature generates the required files and folders for a UPM package. This feature also pre-populates the required files with default or placeholder content, ensuring the package structure is valid and ready to build on. For more information, refer to [Package creation](https://docs.unity3d.com/6000.3/Documentation/Manual/cus-pkg-lp.html).
-   Added more fields to the **Inspector** window when a UPM package is selected. Most fields can be viewed (or edited, if the package is mutable) instead of opening the package’s `package.json` file. For more information, refer to [Edit the package manifest](https://docs.unity3d.com/6000.3/Documentation/Manual/cus-edit-manifest.html).
-   Added in-Editor and command line support, so package authors can create tarball files from packages and attach signatures to them. For more information, refer to [Export and sign your UPM package](https://docs.unity3d.com/6000.3/Documentation/Manual/cus-export.html).

### Locate packages with one click

Added a **Locate** button to the **Package Manager** window. This button highlights the selected package’s `package.json` file in the **Project** window, so you can open or inspect it directly. For more information, refer to [Locate the manifest file](https://docs.unity3d.com/6000.3/Documentation/Manual/cus-edit-manifest.html#locate-manifest).

### Pin package versions

Added the ability to pin a package version for direct dependencies in your project. You can use the new `pinnedPackages` property in the project manifest file to force your project to use a specific version of a package. The Package Manager uses the pinned version of the package, even if another package version is more compatible with your version of the Unity Editor. For more information, refer to the `pinnedPackages` property in the [project manifest file](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPrj.html).

### Action buttons

Added a **Manage** dropdown menu in the **Details** panel, and gathered most action buttons for UPM packages into this menu.

Also added the following new actions to the new **Manage** dropdown menu:

-   A **Customize** button, which copies an immutable UPM package to your project’s `Packages` folder. The copied package is mutable. Copied packages have the **Custom** label in the **Package Manager** window.
-   An **Open Manifest** button (for immutable packages) and an **Edit Manifest** button (for mutable packages). These actions bring focus to the **Inspector** window, which contains details about the selected packages.
-   An **Open Manifest Externally** button (for immutable packages) and an **Edit Manifest Externally** button (for mutable packages). These actions open the selected package’s `package.json` in your default script editor.

### Package Manager window improvements

Added the following visual and functional enhancements to the **Package Manager** window:

-   Added an **Errors and Warnings** view to the navigation panel. This view, which is nested under **In Project**, appears whenever your project has packages that contain errors or warnings. It’s a convenient way to identify all packages in your project that might require attention.
-   Added a **Leave a Review** link for packages listed in the **My Assets** view of your projects. Package Manager opens your default browser, loading the Asset Store page for the selected package.
-   Changed the tab label in the **Details** panel from **Description** to **Technical Details**. Also moved the **Technical Name** of the package into this tab and clearly labelled it, to clearly distinguish it from the display name.
-   Redesigned the **Export Package** entry in the **Assets** menu and contextual menu, to account for the two types of packages you can now export. The single entry is replaced with **Export As Asset Package** and **Export As UPM Package**.
-   Removed the **Experimental Packages in Use** dropdown that conditionally appears. When your project contains experimental packages, this information is integrated into the minimalist Package Manager icon that appears at the top of the Unity Editor.

<span id="physics"></span>

## Physics

This section outlines recent updates to Unity’s physics system.

### Disable and remove physics back end

You can now disable and strip the physics integration SDK from your project. This can result in a smaller build size for certain build platforms and more optimized resource usage. To learn more, refer to [Disable and strip the physics integration from your project](https://docs.unity3d.com/6000.3/Documentation/Manual/physics-remove-backend.html).

<span id="platforms"></span>

## Platforms

This section outlines recent updates to platform-specific tools and settings.

### Android

This section outlines recent updates to the Android platform.

#### Minimum Android version update

Updated the minimum supported Android version to 7.1 (API level 25).

#### x86–64 (Magic Leap) architecture support

In Unity version 6.3 and newer, support for x86–64 (Magic Leap) target architecture is limited to existing projects only.

#### Icon support changes

Deprecated support for the round and legacy icons. The recommended best practice is to use the adaptive icons. For more information, refer to [Icon in Android Player settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettingsAndroid.html#Icon).

#### HTTP/2 protocol for UnityWebRequest

[UnityWebRequest](https://docs.unity3d.com/6000.3/Documentation/Manual/web-request.html) now uses HTTP/2 protocol by default, providing improved loading times and faster networking capabilities when communicating with web servers. The support for HTTP/2 protocol applies to Android, Embedded Linux, Linux, macOS, PS4, PS5, Universal Windows Platform, and Windows platforms.

On Android, you can force the use of HTTP/1.1 protocol using the **Force UnityWebRequest via HTTP/1.1** setting in **Android Player settings** \> **Other Settings** \> **Configuration**. For more information, refer to [Android Player settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettingsAndroid.html#Configuration).

#### App Category setting for Android 16 large screen behavior

Added support to retain the orientation, resizability, and aspect ratio behaviors on applications targeting Android 16 with the new [App Category](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettingsAndroid.html#Configuration) Player setting. Starting with Android 16, the Android OS ignores these fixed settings for large screen devices. You can use the **App Category** Player setting to categorize your application as a game, which ensures that your game application is exempted from these changes. This setting replaces the obsolete [PlayerSettings.Android.androidIsGame](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerSettings.Android-androidIsGame.html) API.

For more information, refer to [Android 16 behavior changes for large screen devices](https://docs.unity3d.com/6000.3/Documentation/Manual/android-large-screen-and-foldable-support.html#Android16).

#### Android build tools update

Unity’s Android build tooling is updated to align with the latest Android development tools. Unity now uses Gradle version 9.1.0 and Android Gradle Plugin (AGP) version 9.0.0.

Unity automatically applies these updates to most projects. However, projects using Custom Gradle Templates or third-party plug-ins might need manual changes. To upgrade your existing project, refer to [Upgrade to Unity 6.3](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html#platforms).

The tooling updates introduce the following changes:

-   Attributes such as `targetSdkVersion`, `minSdkVersion`, `lintOptions`, and `packagingOptions` are marked deprecated and automatically converted by Gradle Template Updater to their updated versions.
-   AGP 9.0.0 replaces `proguard-android.txt` with the optimized version `proguard-android-optimize.txt`. Using the old `proguard-android.txt` file is no longer supported.
-   Gradle and AGP API updates might affect custom Gradle template logic.
-   Custom Android plug-ins and [libraries](https://docs.unity3d.com/6000.3/Documentation/Manual/android-library-plugin-create.html) must declare a unique namespace.

### Dedicated Server

The Dedicated Server Linux platform now supports Arm64 architecture.

### Embedded Linux and QNX

This section outlines recent updates to the Embedded Linux and QNX platforms.

#### GameWindow API

Added a new windowing class: [GameWindow](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Windowing.GameWindow.html). The GameWindow API is available under the `UnityEngine.Windowing` namespace for Embedded Linux and QNX platforms, and it provides control over Player window properties.

Use the GameWindow API to monitor and modify window properties such as title, size, position, display, and fullscreen mode. The API also enables handling asynchronous operations including moving and resizing windows.

#### Stack Protection in builds

Embedded Linux and QNX builds now include stack protection compilation, which detects buffer overflows and prevents related vulnerabilities to improve security.

### QNX

You can now configure the properties of your Unity application windows using the new environment variable `UNITY_QNX_WINDOW_CLASS_LIST`. This allows you to override Unity’s default windowing behavior by using the platform-specific window properties, such as display index, position, size, and hardware pipeline. For more information, refer to [Application window configuration using environment variable](https://docs.unity3d.com/6000.3/Documentation/Manual/qnx-deploy.html#window-class-list).

### Web Platform

This section outlines recent updates to the Web platform.

#### Profile running Web builds via IP connection

You can now connect the Unity Profiler to a running Web build using the device’s IP address. For detailed instructions, refer to [Profile a Web build](https://docs.unity3d.com/6000.3/Documentation/Manual/web-profile.html).

#### IL2CPP metadata optimization

The IL2CPP scripting back end now uses variable-size indices for its metadata. This optimization reduces the overall metadata size and leads to smaller application build sizes for some projects. The change applies automatically during the build process and requires no action.

#### Native Apple Silicon support for Web builds

The Emscripten toolchain now runs natively on Apple Silicon hardware. Previously, Web platform builds on Apple Silicon Macs required the Rosetta 2 translation layer. This update removes that dependency, resulting in faster build times. The change is automatic and requires no action.

### Windows

Added a new **D3D12 Device Filter Asset** in **Player Settings** \> **Other Settings** \> **D3D12 Settings**. This feature allows you to control D3D12 API usage and graphics jobs mode for specific Windows devices at runtime.

The asset uses filter lists to determine which Windows devices should use the D3D12 API and specify the preferred graphics jobs mode. This helps you ensure that your application runs optimally across a range of Windows devices. For more information, refer to [D3D12 API and graphics jobs mode configuration](https://docs.unity3d.com/6000.3/Documentation/Manual/d3d12-graphics-jobs-configuration.html).

<span id="ui-toolkit"></span>

## UI Toolkit

This section outlines recent updates to Unity’s UI Toolkit.

### UI Test Framework

The [UI Test Framework](https://docs.unity3d.com/Packages/com.unity.ui.test-framework@1.0/manual/index.html) is a new package for automated testing of the UI Toolkit. It provides APIs that simulate complex interactions such as mouse clicks and movements, keyboard input, and scrolling. It optimizes state management for faster test execution, improves reporting and debugging, and ensures compatibility with the latest UI Toolkit features, helping you verify that your UI behaves as intended.

### USS filter

UI Toolkit now supports CSS-style filters on a sub-tree of elements, enabling custom post-processing effects such as opacity, tint, grayscale, sepia, invert, and blur. You can apply these filter styles using USS or directly through UI Builder. This allows you to enhance visuals and create effects like uniform transparency, color tints, and image blurring across UI elements. For more information, refer to [USS filter](https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/uss-filter.html).

### Vector graphic support

The Vector Graphics package is now a core module that is fully integrated with UI Toolkit. You can import SVG assets directly as Vector Images without installing a separate package. Note, though, that SVG Sprite creation and UGUI support still require the installation of the package. This update adds built-in antialiasing support via UI Toolkit’s tessellation methods, providing smoother, higher-quality visuals for vector content. For more information, refer to [Work with vector graphics](https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/work-with-vector-graphics.html).

### UXML support for the Image element

Previously, you had to use `--unity-image` in combination with other USS properties to set the source, scaling, and tint color for the Image element. Now, you can use the `source` attribute in UXML, along with other attributes, to define the image source and control scaling and tint color directly. You can also add and manage an Image element directly in UI Builder. For more information, refer to [Image](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uxml-element-Image.html).

### Advanced Text Generator enhancements

The Advanced Text Generator (ATG) now supports the following [Rich Text tags](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-supported-tags.html):

-   `<a>`
-   `<align>`
-   `<b>`
-   `<br>`
-   `<cspace>`
-   `<i>`
-   `<mark>`
-   `<mspace>`
-   `<noparse>`
-   `<s>`
-   `<u>`
-   `<link>`
-   `<sprite>`

ATG now powers text rendering in the Unity Editor and has support for line-breaking rules.

### UI Shader Graph

UI Toolkit now supports creating shaders with Shader Graph, allowing you to create unique visual styles and effects for your UI elements, such as gradients, animations, or color blending. For more information, refer to [UI Shader Graph](https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/ui-shader-graph.html).

### Aspect ratio

You can now use the [USS aspect-ratio property](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-SupportedProperties.html#box-model) to set a width-to-height ratio of an element. It’s equivalent to the aspect-ratio CSS property. You can set it in UXML, UI Builder, or C# script inline style.

### Pseudo state

You can now check the pseudo-state of a control in UI Toolkit. This helps you debug and verify that styles apply correctly based on the control’s state. For an example usage, refer to [Check pseudo-state of a control](https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/check-pseudo-state.html).

### Custom text animation

You can now [animate UI Toolkit text](https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/create-custom-text-animation.html) at the glyph level with [TextElement.PostProcessTextVertices](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.TextElement.PostProcessTextVertices.html) to control vertex position, tint, and UV coordinates before rendering.

<span id="xr"></span>

## XR

This section outlines recent updates to Unity’s extended reality (XR) support.

### On-tile post-processing for XR

Added on-tile post-processing, which enables you to use certain URP post-processing techniques on untethered XR platforms with reduced impact on GPU performance. On-tile post-processing can result in significant graphics performance improvements on standalone XR devices such as Meta Quest, Android XR, and other OpenXR runtimes.

Refer to [On-tile post-processing (URP)](https://docs.unity3d.com/6000.3/Documentation/Manual/xr-graphics-on-tile-post-processing.html) for more information.

### Meta XR packages in platform browser

Added Meta’s packages for XR development to the **Partner Packages** section of the platform browser when you add the Meta Quest build profile. The platform browser makes it easier to install your chosen packages from Unity and Meta to develop for Meta Quest devices. Refer to [Meta Quest build platform and build profile](https://docs.unity3d.com/6000.3/Documentation/Manual/xr-meta-quest-build-profile.html) for more information.

### Automatic viewport dynamic resolution for OpenXR headsets

Added support for automatically changing the display resolution based on current device performance. Refer to [Automatic viewport dynamic resolution](https://docs.unity3d.com/Packages/com.unity.xr.openxr@1.16/manual/features/automaticdynamicresolution.html) for more information.

## Additional resources

-   [New in Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNew.html)
-   [Upgrade Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuides.html)
-   [System requirements](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html)
-   [Install Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/GettingStartedInstallingUnity.html)
