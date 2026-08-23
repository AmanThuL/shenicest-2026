---
title: "Texture and mesh loading"
page_title: "Unity - Manual: Texture and mesh loading"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/LoadingTextureandMeshData.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/LoadingTextureandMeshData.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Texture and mesh loading

Unity can load texture and mesh data from disk and upload it to the GPU in two different ways: synchronously or asynchronously. These two processes are called the synchronous upload pipeline and the asynchronous upload pipeline.

When Unity uses the synchronous upload pipeline, it cannot perform other tasks while it loads and uploads the data. This can cause visible pauses in your application. When Unity uses the asynchronous upload pipeline, it can perform other tasks while it loads and uploads the data in the background.

If a texture or mesh is eligible for the asynchronous upload pipeline, Unity uses the asynchronous upload pipeline automatically. If a texture or mesh is ineligible for the asynchronous upload pipeline, Unity uses the synchronous upload pipeline automatically.

## How it works

The main difference between the synchronous and asynchronous upload pipelines is where Unity saves the data at build time, which affects how Unity loads it at runtime.

In the synchronous upload pipeline, Unity must load both the metadata (header data) and the texel or vertex data (binary data) for the texture or mesh in a single frame. In the asynchronous upload pipeline, Unity must load only the header data in a single frame, and it can stream the binary data to the GPU over subsequent frames.

In the synchronous upload pipeline:

-   At build time, Unity writes both the header and the binary data for the mesh or texture to the same .res file.
-   At runtime, when the application needs the texture or mesh, Unity loads both the header data and binary data for that texture or mesh from the .res file into memory. When all of the data is in memory, Unity then uploads the binary data from memory to the GPU. The loading and uploading operations occur mainly on the main thread, in a single frame.

In the asynchronous upload pipeline:

-   At build time, Unity writes the header data to a .res file and the binary data to a separate .resS file.
-   At runtime, when the application needs the texture or mesh, Unity loads the header from the .res file into memory. When the header is in memory, Unity then streams the binary data from the .resS file to the GPU using a fixed-sized ring buffer. Unity streams the binary data using multiple threads, over the course of several frames. Note that on some console platforms where Unity already knows the GPU hardware, Unity skips the ring buffer and loads straight into the GPU memory.

## Additional resources

-   Unity blog: [Optimizing loading performance: Understanding the Async Upload Pipeline](https://unity.com/blog/engine-platform/understanding-the-async-upload-pipeline).
