---
title: "Choose a content build system (Addressables 4.0)"
page_title: "Choose a content build system | Addressables | 4.0.2"
source_url: "https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/content-build-systems.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/content-build-systems.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Choose a content build system

Addressables supports the following content build systems in Unity:

-   [Content directories](https://docs.unity3d.com/6000.6/Documentation/Manual/content-directories.html)
-   [AssetBundles](xref:um-asset-bundles)

In versions of Addressables before 4.0, the AssetBundle system was the only content build system available. [Content directories](https://docs.unity3d.com/6000.6/Documentation/Manual/content-directories.html) are designed to be a replacement to the AssetBundle system. If you [upgrade to content directories](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/convert-content-directories.html), most workflows remain the same, such as creating groups, assigning labels, and using `AssetReference` to refer to assets at runtime.

It's best practice to choose one content build system, and avoid using a mixture of content directories and AssetBundles in your project. If you use a mixture of the two systems, then any shared dependencies between AssetBundles and content directories are built twice, which increases build size and might lead to asset duplication. However, you can use both build systems in existing projects that have both local and remote content. Because the content directory system doesn't currently have a remote content distribution mechanism, you can continue to use AssetBundles for its remote content capability, but use content directories for local content to gain the benefit of improved performance.

##### Tip

For new projects that don't need to serve content remotely, use the content directory system. Choose AssetBundles if you need remote content, content updates, or are using an Editor version lower than Unity 6.6.

The key differences between the content build systems are as follows:

| **Feature**                 | **Content directories**                                                                                                                        | **AssetBundles**                                                                                                                                                                                                                                                   |
|-----------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Schema name**             | [**Content Directory**](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/groups-create.html)                                | [**Content Packing & Loading**](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/groups-create.html)                                                                                                                                            |
| **Loading and unloading**   | Loads and unloads assets as needed along with their direct dependencies, and unloads assets as soon as their direct dependencies are released. | Loads assets as needed, and loads their dependent AssetBundles automatically. When unloading, assets are only unloaded once all [dependent AssetBundles](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/AssetDependencies.html) are released. |
| **Dependencies**            | Tracks dependencies per asset. Unity automatically removes duplicated content in a build, and handles dependencies automatically.              | Tracks dependencies per AssetBundle. Loading an asset requires loading its AssetBundle, and recursively loading all the dependent AssetBundles, even if the loaded asset itself doesn't reference them.                                                            |
| **Layout**                  | Granular file layout with hash-based names, optionally in a Unity archive.                                                                     | Individual Unity archive files for each defined AssetBundle. Referenced content can be duplicated in multiple AssetBundles.                                                                                                                                        |
| **Organization**            | By default, all groups build to a single content directory, regardless of how you organize assets in the Groups window.                        | Groups you create determine which AssetBundle the assets are assigned to.                                                                                                                                                                                          |
| **Compression options**     | LZ4 compression when ArchiveContentDirectories is enabled.                                                                                     | Options per-group: Uncompressed, LZ4, LZMA                                                                                                                                                                                                                         |
| **Remote content delivery** | Local content only.                                                                                                                            | Supports local and remote content.                                                                                                                                                                                                                                 |

## Define the content build system

The schemas [assigned to a group](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/groups-create.html) define the content build system and the settings used to build the assets in a group. The default schemas determine which content build system Addressables uses to create a content build of the assets in your project, as follows:

-   **Content Directories**: Uses [content directories](https://docs.unity3d.com/6000.6/Documentation/Manual/content-directories.html) to create content builds.
-   **Content Packing & Loading**: Uses [AssetBundles](xref:um-asset-bundles) to create content builds.

You can also implement your own <a href="https://docs.unity3d.com/Packages/com.unity.addressables@4.0/api/UnityEngine.ResourceManagement.ResourceProviders.IResourceProvider.html" class="xref"><code>IResourceProvider</code></a> class to support other ways to access assets.

If you use a mixture of both schemas in your project, the default build script produces two content builds: one for AssetBundles, and one for content directories.

## Additional resources

-   [Convert Addressables projects to content directories](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/convert-content-directories.html)
-   [Add assets to groups](https://docs.unity3d.com/Packages/com.unity.addressables@4.0/manual/groups-create.html)
