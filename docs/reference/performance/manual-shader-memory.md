---
title: "Control how much memory shaders use"
page_title: "Unity - Manual: Control how much memory shaders use"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/shader-memory.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/shader-memory.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Control how much memory shaders use

In your built application, Unity stores several ‘chunks’ of compressed shader variant data. Each chunk contains multiple shader variants. When Unity loads a scene at runtime, it loads all the scene’s chunks into CPU memory and decompresses them.

To reduce memory usage on platforms that have limited memory, you can limit the size of chunks and how many decompressed chunks Unity keeps in memory.

To do this, in [Player settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettings.html), select **Other Settings** \> **Shader Variant Loading** and adjust the following settings:

-   Use **Default chunk size (MB)** to set the maximum size of compressed chunks Unity stores in your built application.
-   Use **Default chunk count** to limit how many decompressed chunks Unity keeps in memory. The default is `0`, which means there’s no limit.

See [PlayerSettings.SetDefaultShaderChunkCount](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerSettings.SetDefaultShaderChunkCount.html) for more information.

You can use **Override** to override the values for each platform individually. See [PlayerSettings.SetShaderChunkCountForPlatform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerSettings.SetShaderChunkCountForPlatform.html) for more information.

You can also use [Shader.maximumChunksOverride](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Shader-maximumChunksOverride.html) to override **Default chunk count** at runtime.
