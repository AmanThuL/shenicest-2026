---
title: "Optimizing AssetBundle memory usage"
page_title: "Unity - Manual: Optimizing AssetBundle memory usage"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/assetbundles-optimizing.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/assetbundles-optimizing.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Optimizing AssetBundle memory usage

Loading AssetBundles can consume memory depending on compression formats and access patterns.

When you load an AssetBundle, Unity allocates memory to both the assets contained in the AssetBundle and to its internal data. The main types of internal data for a loaded AssetBundle include:

-   **Loading cache**: Stores recently accessed pages of an AssetBundle file. Use [`AssetBundle.memoryBudgetKB`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetBundle-memoryBudgetKB.html) to control its size.
-   **[TypeTrees](https://docs.unity3d.com/6000.3/Documentation/Manual/assetbundles-optimizing.html#typetrees)**: Defines the serialized layout of objects.
-   **[Table of contents](https://docs.unity3d.com/6000.3/Documentation/Manual/assetbundles-optimizing.html#table-of-contents)**: Lists the assets in an AssetBundle.
-   **[Preload table](https://docs.unity3d.com/6000.3/Documentation/Manual/assetbundles-optimizing.html#preload-table)**: Lists the dependencies of each asset.

<span id="typetrees"></span>

## TypeTrees

A TypeTree is an internal Unity data structure that describes the structure of data within a serialized binary object. It acts as a schema for Unity objects from the serialization system’s perspective.

Each serialized file in an AssetBundle contains a TypeTree for each object type in that file. You can use TypeTree information to deserialize files whose type definitions might have changed since serialization (for example, when fields are added, removed, or modified).

When Unity loads an AssetBundle, it loads all TypeTrees and keeps them in memory for the AssetBundle’s lifetime. TypeTree memory overhead depends on the number of unique object types loaded from AssetBundles and their complexity. Each AssetBundle contains a complete set of TypeTrees for its objects. Unity shares identical TypeTrees between AssetBundles to reduce memory usage when multiple AssetBundles are loaded.

### Reduce TypeTree memory

You can reduce the memory requirements of AssetBundle TypeTrees in the following ways:

-   Disable TypeTrees. This excludes TypeTree information from an AssetBundle, and makes the AssetBundles smaller. However, without TypeTree information, when you load older AssetBundles with a newer version of Unity or make script changes in your project, you might get serialization errors or undefined behavior.
-   Use simple data types to reduce TypeTree complexity.

To test the impact that TypeTrees have on the size of AssetBundles, build them with and without TypeTrees disabled and compare their sizes. Use [`BuildAssetBundleOptions.DisableWriteTypeTree`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildAssetBundleOptions.DisableWriteTypeTree.html) to disable TypeTrees in an AssetBundle.

**Note:** Some platforms require TypeTrees and ignore the `DisableWriteTypeTree` setting. Additionally, not all platforms support TypeTrees.

If you disable or strip TypeTrees then consider the following:

-   **Compatibility**: It is only safe to strip TypeTrees when you always rebuild AssetBundles along with a Player build to ensure type compatibility. This is common for AssetBundles distributed in the `StreamingAssets` folder.
-   **Editor Loading**: An error is logged if you attempt to load AssetBundles without TypeTrees in Play mode. This is because Editor and Player types differ. For example, MonoBehaviours have extra fields in the Editor.
-   **Debugging**: Unity provides limited tools to analyze compatibility without TypeTrees. The `TypeTreeHash` in the AssetBundle manifest can help, and the `binary2text` tool (with `-typeinfo` flag) exposes raw TypeTree details for comparison.

<span id="table-of-contents"></span>

## Table of contents

The table of contents is a map in the AssetBundle that you can use to look up each explicitly included asset by name. The size of the table of contents data increases with the number of assets explicitly included in the AssetBundle, and the length of the string names used to map them. The [`addressableNames`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetBundleBuild-addressableNames.html) property represents the string name, and if not defined the asset path is used instead.

To minimize the amount of memory dedicated to holding table of contents data, minimize the number of AssetBundles loaded at a given time.

The methods [`GetAllAssetNames`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetBundle.GetAllAssetNames.html) and [`GetAllScenePaths`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetBundle.GetAllScenePaths.html) expose the table of contents map.

<span id="preload-table"></span>

## Preload table

The preload table lists all objects that an asset depends on. When you load an asset from an AssetBundle, Unity uses this table to automatically load all required dependencies.

Each asset has its own preload table. For example, a prefab’s preload table includes entries for all components attached to the prefab, referenced materials and textures, and any other assets the prefab uses.

Each preload entry uses 64 bits of memory and can reference objects in other AssetBundles.

When an asset references another asset that in turn references other assets, the preload table can become large because it contains duplicate entries where the assets share dependencies. If two assets both reference a third asset, then the preload tables of both assets contain entries to load the third asset.

Preload tables can contain duplicate entries where assets share dependencies. When an asset references another asset that in turn references other assets, Unity stores this information in each asset’s preload table. This can impact on memory usage.

You can reduce the impact of large preload tables in the following ways:

-   **Projects that only use AssetBundles**: Explicitly add any frequently-referenced asset that has many objects to an AssetBundle, so the preload information of that asset is shared.
-   **Projects that use Addressables, or the Scriptable Build Pipeline**: Avoid direct or indirect references from explicitly included assets to large hierarchies of objects.

## Temporary in-memory AssetBundles

Unity manages memory efficiently, but temporary in-memory AssetBundles are created in the following scenarios:

-   LZMA-compressed AssetBundles loaded via `AssetBundle.LoadFromFile`, `LoadFromMemory`, or `LoadFromStream` APIs.
-   AssetBundles that don’t use caching and are downloaded without a version or hash argument.
-   AssetBundles downloaded via `UnityWebRequestAssetBundle` on platforms without AssetBundle caching such as Web.

Temporary files exist until reads complete and `AssetBundle.Unload` is called. These in-memory copies can significantly increase RAM usage and load times.

### Caching considerations

-   **LZ4 Default**: When `Caching.compressionEnabled` is `true` (the default), downloaded AssetBundles are recompressed to LZ4 and stored in the cache. This conversion generally improves loading performance.
-   **Uncompressed**: When `Caching.compressionEnabled` is `false`, temporary AssetBundles are stored uncompressed, potentially increasing RAM usage if the original AssetBundle was compressed.

## CRC checks and performance

[CRC checks](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetBundles-Integrity.html) for LZ4 files can affect load times because the entire file needs to be decompressed. This uses minimal memory because Unity decompresses each chunk individually instead of the entire file at once.

CRC checks for LZMA files incur no additional overhead, because full decompression is inherent. For more information, refer to [Downloading AssetBundles](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetBundles-Integrity.html).

It’s recommended to perform CRC checks only once, at download time, rather than at every AssetBundle load, especially on platforms with weak CPUs.

## Detailed memory usage

Beyond temporary in-memory AssetBundles, other structures consume memory:

-   **LZ4 and uncompressed AssetBundles**: When an LZ4-based AssetBundle is open, chunks are decompressed on demand. A small cache (`ArchiveStorageReader.m_CachedBlocks`) helps manage sequential reads. For uncompressed AssetBundles, this cache might still be used.
-   **Persistent manager `SerializedFile` cache**: The `PersistentManager` uses a shared cache (`PooledFileCacherManager`) for pages of data read from `SerializedFiles` within AssetBundles. Its default size is 1MB.
-   **Archive and AssetBundle metadata**: Additional data structures for mounted Unity archives and AssetBundles that consume small amounts of memory such the `AssetBundle` object that contains the table of contents, and the `PreloadData` object.
-   **`PersistentManager.Remapper`**: Tracks relationships between instance IDs and source files. Can use noticeable memory for AssetBundles containing very large Prefabs (object hierarchies) as it never reduces in size once allocated. Objects in scenes are not tracked here.
-   **Instantiated objects**: Once assets and scenes are loaded from AssetBundles, the instantiated Unity objects themselves will consume memory.

<span id="when-unity-loads-entire-assetbundles-into-memory"></span>

## When Unity loads the entire AssetBundle into memory

The following information summarizes the use of in-memory files and format conversions when loading AssetBundles of different formats using available APIs. This directly impacts runtime memory consumption.

### File-based Loading APIs

-   **AssetBundle.LoadFromFile, LoadFromFileAsync**
    -   LZMA compression: Convert to LZ4 and open in-memory file.
    -   LZ4 compression, and uncompressed: Read content directly from file.
-   **AssetBundle.LoadFromMemory, LoadFromMemoryAsync**
    -   LZMA compression, and uncompressed: Convert to LZ4 and open in-memory file.
    -   LZ4 compression: Read content directly from memory.
-   **AssetBundle.LoadFromStream, LoadFromStreamAsync**
    -   LZMA compression: Convert to LZ4 and open in-memory file
    -   LZ4 compression, and uncompressed: Read content directly from file stream.

### Web-based Loading APIs

-   **UnityWebRequestAssetBundle.GetAssetBundle (Empty Cache, `Caching.compressionEnabled = true`)**
    -   LZMA compression: Download and stream to cache file (converting LZMA to LZ4), then load from cache
    -   LZ4 compression: Download and stream to cache file (no conversion), then load from cache
    -   Uncompressed: Download and stream to cache file (converting to LZ4), then load from cache
-   **UnityWebRequestAssetBundle.GetAssetBundle (Cached, `Caching.compressionEnabled = true`)**
    -   All compression formats: Read content directly from cached LZ4 file
-   **UnityWebRequestAssetBundle.GetAssetBundle (No Caching)**
    -   LZMA compression: Download, convert to LZ4, and open in-memory file
    -   LZ4 compression and uncompressed: Download and stream to memory-based temp file (no conversion)

**Note**: Converting and opening in-memory files involves opening the source, checking its format, converting it to LZ4 (or uncompressed if `Caching.compressionEnabled` is `false`) as an in-memory archive file, opening this in-memory file, and finally deleting it when unloaded and no more readers exist. This process can be an inefficient use of memory and loading time.

## Reducing runtime memory usage in AssetBundles with many assets

When loading assets, Unity supports loading by full project-relative path, file name, or file name without extension. The latter two options are implemented by building extra string tables. In AssetBundles with many loadable assets, these extra string tables can consume noticeable memory.

To reduce this overhead, it’s best practice to always load assets using their exact key (project-relative path or Addressables name) and disable the extra matching capabilities at build time:

-   [`BuildAssetBundleOptions.DisableLoadAssetByFileName`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildAssetBundleOptions.DisableLoadAssetByFileName.html)
-   [`BuildAssetBundleOptions.DisableLoadAssetByFileNameWithExtension`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildAssetBundleOptions.DisableLoadAssetByFileNameWithExtension.html)

Refer to the documentation for the `name` parameter in [`AssetBundle.LoadAssetAsync`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetBundle.LoadAssetAsync.html) for more information.

## Additional resources

-   [Handling dependencies between AssetBundles](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetBundles-Dependencies.html)
-   [Loading assets from AssetBundles](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetBundles-Native.html)
-   [Analyzing AssetBundles](https://docs.unity3d.com/6000.3/Documentation/Manual/assetbundles-analyze.html)
