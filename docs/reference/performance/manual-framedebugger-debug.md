---
title: "Debug a frame"
page_title: "Unity - Manual: Debug a frame"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/FrameDebugger-debug.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/FrameDebugger-debug.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Debug a frame

To debug a frame using the Frame Debugger:

1.  Open the Frame Debugger (menu: **Window** > **Analysis** > **Frame Debugger**).
2.  Use the target selector to select the process to attach the Frame Debugger to. If you want to debug a frame in the Unity Editor, set this to **Editor**. If you want to debug a frame in a built application, see [Attach the Frame Debugger to a built project](https://docs.unity3d.com/6000.3/Documentation/Manual/FrameDebugger-attach.html).
3.  Click **Enable**. When you do this, the Frame Debugger captures a frame. It populates the Event Hierarchy with the draw calls and other events that constitute the frame and renders the frame in the Game view.  
    **Note**: If your application is running, the Frame Debugger pauses it.
4.  Select an event from the Event Hierarchy to view the scene as it appears up to and including that event. This also displays information about the event in the Event Information Panel. You can use the previous event and next event button, the arrow keys, or the event scrubber to move through the frame linearly. If you don’t know which event Unity renders the geometry you want to debug in, these navigation tools are useful to move through the events linearly until you find it.

When a draw call event corresponds to the geometry of a GameObject, Unity highlights that GameObject in the [Hierarchy](https://docs.unity3d.com/6000.3/Documentation/Manual/Hierarchy.html).

If an event renders into a [RenderTexture](https://docs.unity3d.com/6000.3/Documentation/Manual/class-RenderTexture.html), Unity displays the contents of that RenderTexture in the Game view and Frame Debugger window. This is useful for inspecting how various off-screen render targets build up. For example:

![Viewing events that accumulate to produce the diffuse G-buffer during deferred rendering.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/frame-debugger-event-accumulation.gif)

<span id="render-graph"></span>

## Debug a Render Graph frame

If your project uses the [Render Graph system](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/render-graph-introduction.html), the Frame Debugger displays the following in the [Event Hierarchy panel](https://docs.unity3d.com/6000.3/Documentation/Manual/frame-debugger-window-event-hierarchy.html):

-   A parent rendering event called **ExecuteRenderGraph**.
-   Child rendering events called **(RP \<render-pass>:\<subpass>)**, where **\<render-pass>** is the render pass number and **\<subpass>** is the subpass number.

The Frame Debugger displays only render passes that contain a draw call.
