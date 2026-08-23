---
title: "Analyze a render graph in URP"
page_title: "Unity - Manual: Analyze a render graph in URP"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-view.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-view.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Analyze a render graph in URP

To analyze a render graph, use the **Render Graph Viewer** window.

The Render Graph Viewer window displays a render graph, which is the optimized sequence of render passes the Universal Render Pipeline (URP) steps through each frame. The Render Graph Viewer displays both built-in render passes and any [custom render passes](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/renderer-features/intro-to-scriptable-render-passes.html) you create.

For more information about the **Render Graph Viewer** window, refer to [Render Graph Viewer window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-viewer-reference.html).

You can also use the following windows to analyze a render graph:

-   [Rendering Debugger](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/rendering-debugger-reference.html#render-graph)
-   [Frame Debugger](https://docs.unity3d.com/6000.3/Documentation/Manual/FrameDebugger-debug.html#render-graph)

## Open the Render Graph Viewer window

Go to **Window** \> **Analysis** \> **Render Graph Viewer**.

The **Render Graph Viewer** window displays the render graph for the active camera by default. To select another camera, use the dropdown in the toolbar.

<span id="built-project"></span>

## View the render graph for a build

To connect the Render Graph Viewer window to a build, enable **Development Build** in the **Build Profiles** window when you build the project. If you build for WebGL or Universal Windows Platform (UWP), enable both **Development Build** and **Autoconnect Profiler**.

After you build your project, follow these steps:

1.  Run your built project.
2.  In the **Render Graph Viewer** window, select the **Target Selection** dropdown. The dropdown is set to **Editor** by default.
3.  In the **Local** section, select your build.

Your build appears in the **Local** section only if the build is running.

## Example: Check how URP uses a resource

You can use the resource access blocks next to a resource name to check how the render passes use the resource.

![Render Graph Viewer example](https://docs.unity3d.com/6000.3/Documentation/uploads/urp/render-graph-viewer.png)

In this example, the `_MainLightShadowmapTexture_` texture goes through the following stages:

1.  During the first five render passes between **InitFrame** and **SetupCameraProperties**, the texture doesn’t exist. The resource access blocks are dotted lines.

2.  The **Main Light Shadowmap** render pass creates the texture as a global texture, and has write-only access to it. The resource access block is red. For more information about global textures, refer to [Transfer textures between passes](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-pass-textures-between-passes.html).

    The blue merge bar below **Main Light Shadowmap** means URP merged **Main Light Shadowmap**, **Additional Lights Shadowmap** and **SetupCameraProperties** into a single render pass.

3.  The next five render passes don’t have access to the texture. The resource access blocks are gray.

4.  The first **Draw Objects** render pass has read-only access to the texture. The resource access block is green.

5.  The next two render passes don’t have access to the texture. The resource access blocks are gray.

6.  The second **Draw Objects** render pass has read-only access to the texture. The resource access block is green.

7.  Unity destroys the texture, because it’s no longer needed. The resource access blocks are blank.

## Check how URP optimized a render pass

To check the details of a render pass, for example to find out why it’s not a native render pass or a merged pass, do either of the following:

-   Select the render pass name to display the details in the Pass List.
-   Below the render pass name, hover your cursor over the gray, blue, or flashing blue resource access overview block.

For more information about displaying details of a render pass, refer to [Render Graph Viewer window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-viewer-reference.html).

## Additional resources

-   [Render Graph settings in the Rendering Debugger window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/features/rendering-debugger-reference.html#render-graph)
-   [Debug a Render Graph frame in the Frame Debugger](https://docs.unity3d.com/6000.3/Documentation/Manual/FrameDebugger-debug.html#render-graph).
-   [Optimize a render graph](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-optimize.html)
-   [Understand performance](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/understand-performance.html)
-   [Rendering in the Universal Render Pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/rendering-in-universalrp.html)
