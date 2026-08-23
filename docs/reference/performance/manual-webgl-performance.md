---
title: "Unity 6.3 Manual: Web performance considerations"
page_title: "Unity - Manual: Web performance considerations"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-performance.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-performance.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Web performance considerations

In general, Web performance is close to native apps on the GPU, because the WebGL graphics API uses your GPU for hardware-accelerated rendering. The only exception is the slight overhead for translating WebGL API calls and shaders to your OS graphics API (typically DirectX on Windows, OpenGL on Mac, and Linux).

On the CPU, Emscripten translates your code into WebAssembly, the performance of which depends on the web browser you’re using.

Be aware of the following considerations:

-   Unity provides multithreading for C/C++ code, but not yet for C# code due to limitations of WebAssembly.
-   When using WebGL API for rendering, the CPU side dispatch of WebGL operations is slower than in native OpenGL. As a result, for best performance, the recommended best practice is to avoid large numbers of draw calls per frame, so make sure that both instancing and batching techniques are used in your shaders.
-   SIMD on the web is supported as part of WebAssembly 2023 feature set. Make sure to enable WebAssembly 2023 for best performance on newer browsers.

**Tip:** To learn how Unity distributes work to different threads on non-Web platforms, refer to the new timeline [Profiler](https://docs.unity3d.com/6000.3/Documentation/Manual/Profiler.html) in Unity.

## Web-specific Player settings that affect performance

If you disable **Target WebAssembly 2023** (under **Publishing Settings** \> **WebAssembly Language Features**), improve performance by setting **Exception** (under **Other Settings** \> **Stack Trace**) to **None**.

If you enable **Target WebAssembly 2023**, the performance overhead from any exception support option is minor.

## Web content in background tabs

Your content continues to run when the canvas or browser window loses focus if one of the following options is enabled:

-   **Run in background** in the [Player settings for the Web platform](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettingsWebGL.html)
-   [Application.runInBackground](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-runInBackground.html)

However, some browsers can throttle content running in background tabs. If the tab with your content isn’t visible, your content only updates once per second in most browsers. Note that this causes [Time.time](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-time.html) to progress slower than usual with the default settings, as the default value of [Time.maximumDeltaTime](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Time-maximumDeltaTime.html) is lower than one second.

## Throttling Web performance

You might want to run your Web content at a lower frame rate in some situations to reduce CPU usage. For example, on other platforms, you can use the [Application.targetFrameRate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-targetFrameRate.html) API to do so.

When you don’t want to throttle performance, set this API to the default value of –1. This allows the browser to adjust the frame rate for the smoothest animation in the browser’s render loop, and might produce better results than Unity trying to do its own main loop timing to match a target frame rate.

**Note**: For security reasons, Unity can’t query a browser for its frame rate. As a result, Unity assumes a display rate of 60 fps for all browsers and bases `Application.targetFrameRate` on that value.
