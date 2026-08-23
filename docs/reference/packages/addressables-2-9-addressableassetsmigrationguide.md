---
title: "Introduction to converting existing projects to Addressables"
page_title: "Introduction to converting existing projects to Addressables | Addressables | 2.9.1"
source_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetsMigrationGuide.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetsMigrationGuide.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to converting existing projects to Addressables

You can use the Addressables package in an existing Unity project that uses one of the other <a href="https://docs.unity3d.com/Manual/assets-managing-introduction.html" class="xref">asset management options</a> available in Unity. Once you [install Addressables](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/installation-guide.html) you need to assign addresses to the assets in your project and then refactor any runtime loading code.

You can integrate the Addressables package into your project at any stage of development, but it's best practice to use Addressables from the start to avoid code refactoring and content planning changes.

## Convert assets to use Addressables

Assets that use Addressables only reference other assets built in that Addressables build. If there are Addressable assets used or referenced in the [scene data](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/convert-scene-data.html) or [Resources system](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/convert-resources-system.html), then Unity duplicates those assets on disk and in memory if they're both loaded.

To avoid this duplication, you can convert all scene data and `Resources` folder data to the Addressables build system. This reduces the memory overhead from the duplicated assets and means you can manage all content with Addressables. This also means that the content can be either local or remote, and you can update it through <a href="https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/ContentUpdateWorkflow.html" class="xref">content update</a> builds.

To convert your project to Addressables, you need to perform different steps depending on how your current project references and loads assets:

-   [Convert prefabs to use Addressables](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/convert-prefabs.html).
-   [Convert scenes to use Addressables](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/convert-scene-data.html).
-   [Move assets from the Resources system](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/convert-resources-system.html).
-   [Convert AssetBundles to Addressables](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/convert-assetbundles.html).

### Files in StreamingAssets

You can continue to load files from the <a href="https://docs.unity3d.com/Manual/StreamingAssets.html" class="xref"><code>StreamingAssets</code> folder</a> when you use the Addressables system. However, the files in this folder can't be Addressable and can't reference other assets in your project.

The Addressables system places its runtime configuration files and local AssetBundles in the `StreamingAssets` folder during a build. Addressables removes these files at the end of the build process and you won't find them in the Unity Editor.

## Additional resources

-   [Create and organize Addressable assets introduction](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/organize-addressable-assets.html)
-   [Building Addressable assets](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/Builds.html)
