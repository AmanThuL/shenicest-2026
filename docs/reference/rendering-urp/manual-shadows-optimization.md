---
title: "Optimize shadow rendering in URP"
page_title: "Unity - Manual: Optimize shadow rendering in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/shadows-optimization.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/shadows-optimization.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Optimize shadow rendering in URP

This page describes optimization techniques that help you make shadow rendering faster in your project.

Factors that affect the shadow rendering time include:

-   The number of visible objects that cast shadows. This number depends on the [Max Distance](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/shadow-resolution-urp.html#shadow-maximum-distance) property.

-   The number of visible objects that receive shadows.

-   The number of shadow-casting lights.

-   The [Cascade Count](https://docs.unity3d.com/6000.3/Documentation/Manual/shadow-cascades-use.html) property value and the sizes of the cascade splits.

-   The [shadow resolution](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/shadow-resolution-urp.html) of the main light and additional lights.

-   The [Soft Shadows](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html#soft-shadows) property.

The following sections describe how to use those and other settings to optimize shadow rendering performance.

## Optimize main light shadows

Use one of the following techniques to optimize shadows cast by the main light.

### Use shadow cascades

Use the [shadow cascades](https://docs.unity3d.com/6000.3/Documentation/Manual/shadow-cascades-landing.html) feature to improve the visual fidelity of shadows without increasing the shadow map resolution.

Consider the [performance impact of shadow cascades](https://docs.unity3d.com/6000.3/Documentation/Manual/shadow-cascades-performance.html) when selecting the **Cascade Count** value.

### Experiment with the Soft Shadows property

Using the **Soft Shadows** property lets you achieve higher visual fidelity with lower shadow resolution values.

The [**Soft Shadows**](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/universalrp-asset.html#soft-shadows) property might have a significant performance impact on platforms that use tile-based rendering, such as mobile platforms and untethered XR platforms. If your target platform uses tile-based rendering, profile your application to determine the performance impact of this setting.

You can use a combination of a lower shadow resolution and the **Soft Shadows** option as an artistic technique. While high shadow resolution makes shadows more detailed, it also makes the shadows look sharp, which might not suit all artistic styles.

For example, in the following illustration, the image on the left has a shadow resolution of 4096 pixels, while the image on the right has a shadow resolution of 1024 pixels with the **Soft Shadows** option enabled.

![Use lower shadow resolution to achieve a softer shadow look](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/shadows/shadow-resolution-4096-vs-1024.png)  
Lower shadow resolution provides a softer shadow look, which might benefit some scenes. Left: resolution 4096 pixels, right: resolution 1024 pixels.

### Choose the resolution and the maximum distance of the main light shadows

For more information about optimizing the resolution and the maximum distance of shadows from the main light, refer to [Configure shadow resolution in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/shadow-resolution-urp.html).

## Optimize additional light shadows

Use one of the following techniques to optimize shadows cast by additional lights.

### Optimize point light shadows

To create a shadow map for a point light, Unity captures the scene in six directions. The performance impact of this operation is comparable with rendering shadows from six spot lights. On mobile platforms, this uses a significant amount of the available resources per frame.

Reduce the number of shadow-casting point lights on mobile platforms, or avoid them completely.

For more information, refer to the following pages:

-   [Configure shadow resolution in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/shadow-resolution-urp.html#shadow-resolution-additional-lights)

-   [Shadow mapping](https://docs.unity3d.com/6000.3/Documentation/Manual/shadow-mapping.html)

### Turn lights off and on using scripting

To improve performance, you can use scripting to turn shadow-casting real-time lights off depending on the distance to the camera or other conditions. To do this, use the [Light.enabled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Behaviour-enabled.html) property.

To avoid light popping, you can fade in and out the `intensity` property of a light.

For an example of this technique, refer to the `DynamicLightController.cs` script which is attached to point lights in outdoor lanterns in the Garden scene in the [Universal 3D sample](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/creating-a-new-project-with-urp.html) project.

### Use light cookies

In areas where objects are mostly static, point or spot lights with light cookies can serve as a substitute for lights that cast real-time shadows.

To configure a light cookie, use the [Cookie property of a Light component](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/light-component.html#Emission).

For more information, refer to [Introduction to cookies](https://docs.unity3d.com/6000.3/Documentation/Manual/Cookies-introduction.html).

### Use Light Explorer

The [**Light Explorer**](https://docs.unity3d.com/6000.3/Documentation/Manual/LightingExplorer.html) window provides a convenient overview of all lights, reflection and light probes, and objects with emissive materials in the scene. Use this tool to quickly find lights with certain properties in the Scene.

## General optimization techniques

This section contains general optimization techniques that are not specific to the main or additional lights.

### Reduce the number of objects that cast real-time shadows

The number of real-time shadow-casting objects has a significant impact on shadow rendering performance.

To exclude an object from casting shadows completely (both baked and real-time shadows), do the following:

1.  On a GameObject, go to **Mesh Renderer** > **Lighting**.

2.  Set the **Cast Shadows** property **Off**.

To configure a GameObject to cast only baked shadows, use the [Shadowmask lighting mode](https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-mode.html#shadowmask).

### Use the Shadowmask lighting mode

The **Shadowmask** lighting mode lets you improve shadow rendering performance by combining baked and real-time shadows at runtime.

For general information about the Shadowmask lighting mode, refer the page [Lighting Mode: Shadowmask](https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-mode.html#shadowmask)

Unity uses the following conditions to determine whether a light or a GameObject contributes to the Shadowmask:

-   The light mode of a light must be **Mixed**.

-   The light must be configured to cast shadows (the **Shadow Type** property of a light must not be **No Shadows**).

-   A GameObject must be static.

To view the existing Shadowmask in the Scene view:

1.  Open the **Draw Mode** drop-down menu
2.  Select **Baked Global Illumination** > **Shadowmask**.

Maximum four lights can have an overlap in a Shadowmask since it uses four channels (r,g,b,a). If an area has more than four overlapping mixed lights, Unity switches additional lights from mixed to baked mode.

To see how many lights affect a certain area, use the **Lighting Complexity** view in the [Rendering Debugger](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/rendering-debugger.html).

![Material \> Material Filters \> Material Override \> Lighting Complexity](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/shadows/rendering-debugger-lighting-complexity.png)

To achieve the best combination of visual fidelity and performance, use the Shadowmask mode in combination with Light Probes.

#### Choose between Distance Shadowmask and Shadowmask

On medium and lower tier mobile platforms, the **Shadowmask** mode might be a good choice from a performance perspective.

On higher tier mobile platforms or PC and console platforms, consider using the **Distance Shadowmask** mode to achieve higher visual fidelity.

For more information, refer to the page [Lighting Mode: Shadowmask](https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-mode.html#shadowmask).

### Configure static objects to cast baked shadows

When using the [Shadowmask lighting mode](https://docs.unity3d.com/6000.3/Documentation/Manual/lighting-mode.html#shadowmask), you can configure certain GameObjects to contribute to the baked shadows and not cast real-time shadows. Follow these steps:

1.  Go the **Project Settings** > **Quality** and set the **Shadowmask Mode** property to **Shadowmask**.

    In this mode, Unity uses baked shadows for every GameObject that has the **Contribute Global Illumination** property enabled.

2.  On a GameObject, in the **Mesh Renderer** component, set the **Cast Shadows** property to **On**.

3.  In the **Mesh Renderer** component, enable **Contribute Global Illumination**.

4.  Generate lighting for the changes to take effect.

Now Unity renders this GameObject with the baked shadow at runtime regardless of the distance to the camera.

### Use a separate simplified mesh for shadow casting

To cast a simple shadow from an object with a complex mesh, follow these steps:

1.  Create a simplified version of the mesh with fewer polygons.

2.  Assign any material to the simplified mesh. The material doesn’t matter because Unity doesn’t render the simplified mesh.

3.  On the original mesh, set the **Cast Shadows** property to **Off**.

4.  Place the simplified mesh in the same position as the original mesh.

5.  On the simplified mesh, set the **Cast Shadows** property to **Shadows Only**.

With this configuration, Unity renders the original mesh but uses simplified mesh to render the shadow.

## Profile shadow rendering

Use the following Unity tools to profile lighting and shadow rendering:

-   [Rendering Debugger](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/rendering-debugger.html)

-   [Frame Debugger](https://docs.unity3d.com/6000.3/Documentation/Manual/FrameDebugger.html)

-   [Render Graph Viewer](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-viewer-reference.html)

-   [Unity Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html)

If you need more detail, use the platform-specific profilers and debugging tools available for your target platform. Refer to [Profiling tools](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-profiling-tools.html) for more information.

## Additional resources

-   [Troubleshooting shadows](https://docs.unity3d.com/6000.3/Documentation/Manual/ShadowPerformance.html)

-   [Troubleshooting shadows in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/shadows-troubleshooting-urp.html)
