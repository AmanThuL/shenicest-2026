---
title: "Render graph system (HDRP)"
page_title: "Render graph system in HDRP | High Definition Render Pipeline | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/render-graph-introduction.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/render-graph-introduction.html"
topic: "rendering-hdrp"
publisher: "Unity Technologies"
fetched: "2026-08-27"
kind: "html"
---

# Render graph system in HDRP

The render graph system is a set of APIs from the [Core Scriptable Render Pipeline (SRP) package](https://docs.unity3d.com/Packages/com.unity.render-pipelines.core@latest). The High Definition Render Pipeline (HDRP) uses these APIs to create the render passes in the render pipeline.

The render graph system automatically optimizes the graph to minimize the number of render passes, and the memory and bandwidth the render passes use.

**Note:** Unlike in the Universal Render Pipeline (URP), you can't use the render graph system to write custom render passes in HDRP. Use [Custom Passes](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/Custom-Pass.html) instead.

## How the render graph system optimizes rendering

The render graph system does the following to optimize rendering:

- Avoids allocating resources the frame doesn’t use.
- Removes render passes if the final frame doesn’t use their output.
- Optimizes GPU memory, for example by reusing allocated memory if a texture has the same properties as an earlier texture.
- Automatically synchronizes the compute and graphics GPU command queues, if compute shaders are used.

On mobile platforms that use tile-based deferred rendering (TBDR), the render graph system can also merge multiple render passes into a single native render pass. A native render pass keeps textures in tile memory, rather than copying textures from the GPU to the CPU. As a result, HDRP uses less memory bandwidth and rendering time.

To check how the render graph system optimizes rendering, refer to [Analyze the render graph](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/render-graph-view.html)

## Additional resources

- [Optimizing draw calls](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reduce-draw-calls-landing-hdrp.html)
- [Reduce rendering work on the CPU](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.3/manual/reduce-rendering-work-on-cpu.html)
