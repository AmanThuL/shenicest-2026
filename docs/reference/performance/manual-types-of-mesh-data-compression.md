---
title: "Types of mesh data compression"
page_title: "Unity - Manual: Types of mesh data compression"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/types-of-mesh-data-compression.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/types-of-mesh-data-compression.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Types of mesh data compression

Unity provides two ways of compressing meshes. They work differently, and affect different aspects of performance:

-   [Vertex Compression](https://docs.unity3d.com/6000.3/Documentation/Manual/types-of-mesh-data-compression.html#vertex-compression) is a setting that affects every mesh in your project. It allows you to use lower precision data formats in your meshes. This reduces the size of mesh data in memory, slightly reduces file size, and might improve GPU performance. The potential downside is a loss of precision.
-   [Mesh Compression](https://docs.unity3d.com/6000.3/Documentation/Manual/types-of-mesh-data-compression.html#mesh-compression) is a setting that affects individual meshes. It compresses the mesh data on disk, which reduces file size. The potential downsides are increased loading times, increased temporary memory usage when loading, and the possibility of compression artifacts.

To access mesh compression settings, open the [Model Import settings window](https://docs.unity3d.com/6000.3/Documentation/Manual/class-FBXImporter.html), navigate to the **Model** tab’s **Meshes** section, and use the **Mesh Compression** dropdown.

You can use both compression methods in the same project, but not on the same mesh. If you apply Mesh Compression to a mesh, Unity doesn’t apply Vertex Compression to that mesh.

**Note:** Unity’s default settings for Vertex Compression and Mesh Compression are suitable for most projects. You should change these settings only if you have a problem, and assess the results to make sure that the changes have helped.

<span id="vertex-compression"></span>

## Vertex Compression

The Vertex Compression setting allows you to use lower precision data formats for all the meshes in your project. You do this by configuring the data type for specific data channels.

You can change the data type for a given channel from an FP32 (Floating Point32, a 32-bit floating point number) to an FP16 (Floating Point16, also known as a half-precision float). The FP16 format stores numbers with fewer places after the decimal point than FP32 numbers, which means that it takes up less space but offers slightly less precision.

Data converted from FP32 to FP16 takes up less space in memory, and slightly less space on disk. On the GPU, the data uses less memory bandwidth, which might slightly improve GPU performance.

The vertex compression technique compresses a mesh by a ratio that varies depending on how many vertex attributes you choose to compress. The compression ratio is usually around 1.45x when you compress normals, tangents, color, and three sets of UV coordinates.

<span id="mesh-compression"></span>

## Mesh Compression

You can use the Mesh Compression setting to compress the mesh data for a given model asset on disk. The Mesh Compression algorithm is more aggressive than the Vertex Compression technique, which results in higher compression ratios and therefore smaller file sizes. However, it also has more downsides.

When you apply this setting, Unity uses an algorithm to replace the explicit values for each compression channel with a range between the maximum and minimum, where a fixed number of bits represents where each value falls in that range. This reduces the size of the mesh data on disk. When Unity loads the mesh into memory, it decompresses the data, which means it converts this range back into the original values. After this, performance isn’t affected.

This technique can be useful if you need to reduce your final build size or the size of the AssetBundle the mesh is in as much as possible, and if the reduction in performance from the runtime decompression is acceptable.

### Limitations of Mesh Compression

At runtime, mesh decompression uses additional CPU resources; this means that loading mesh data takes longer. Unity also uses more temporary memory when decompressing meshes.

Additionally, the relatively high compression ratio means that unwanted artifacts can appear when Unity decompresses the mesh. To avoid these artifacts, you should test each option for the mesh you want to compress and check that it appears correctly.
