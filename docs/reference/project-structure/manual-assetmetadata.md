---
title: "Asset metadata"
page_title: "Unity - Manual: Asset metadata"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AssetMetadata.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AssetMetadata.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Asset metadata

As part of the [importing process](https://docs.unity3d.com/6000.3/Documentation/Manual/ImportingAssets.html), Unity creates metadata about any assets you import into your project. The metadata contains information such as the asset’s [import settings](https://docs.unity3d.com/6000.3/Documentation/Manual/ImportingAssets.html#asset-import-settings), and where your project uses the asset. When you import an asset, Unity does the following:

-   [Assigns the asset a unique ID](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetMetadata.html#asset-ids).
-   [Creates a `.meta` file for the asset](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetMetadata.html#meta-files).
-   [Processes the asset](https://docs.unity3d.com/6000.3/Documentation/Manual/ImportingAssets.html#asset-processing).

<span id="asset-ids"></span>

## Asset IDs

The Unity Editor frequently checks the contents of the `Assets` folder against the list of assets it already knows about. When you place an asset in the `Assets` folder, Unity detects that you have added a new file and assigns a unique ID to the asset. This is an ID that Unity uses internally to reference the asset, so that it can move or rename the asset without breaking anything. You can use the [Import Activity window](https://docs.unity3d.com/6000.3/Documentation/Manual/ImportActivityWindow.html) to view the ID of an asset.

<span id="meta-files"></span>

## Meta files

Unity creates `.meta` files for each folder and file in your project’s `Assets` folder and stores the `.meta` file in the same location as the asset file. These files are hidden in the [Project window](https://docs.unity3d.com/6000.3/Documentation/Manual/ProjectView.html), and are considered a hidden file by your operating system, so might be hidden by default in your file browser.

The `.meta` files contain the unique ID assigned to the asset, and values for all the asset’s [import settings](https://docs.unity3d.com/6000.3/Documentation/Manual/ImportingAssets.html#asset-import-settings). If you change the import settings for an asset, Unity saves those new settings to the `.meta` file that accompanies the asset. Unity then re-imports the asset according to your updated settings, and updates the corresponding imported data in the project’s `Library` folder.

### Moving and renaming assets

Meta files contain important information about how the asset is used in your project, and they must stay with the asset file they relate to. If you move or rename an asset within the Project window, Unity automatically moves or renames the corresponding `.meta` file. However, if you move or rename an asset outside of Unity, you must move or rename the `.meta` file to match.

If an asset loses its `.meta` file, any reference to that asset is broken in your project. In this situation, Unity generates a new `.meta` file for the moved or renamed asset as if it’s a brand new asset, and deletes the old `.meta` file. When Unity deletes the old `.meta` file it might cause significant issues such as the following:

-   If a texture asset loses its `.meta` file, any materials that use that texture lose their reference to that texture. To fix it, you must manually re-assign that texture to any materials which require it.
-   If a script asset loses its `.meta` file, any GameObjects or Prefabs that have that script assigned instead have an unassigned script component, and lose their functionality. To fix it, you must manually re-assign that script to any GameObjects which require it.

<span id="EmptyFolderMetaFiles"></span>

### Empty folders and version control

Unity assigns each folder in your project’s `Assets` folder its own `.meta` file. However, some version control systems (VCS) can’t store empty folders. When you add or delete an empty folder from your project, the VCS stores the `.meta` file as added or removed, but doesn’t store the change of adding or removing the folder itself. To help resolve this issue, Unity behaves in the following ways relating to empty folders:

-   If Unity detects an empty folder that no longer has a corresponding `.meta` file, it assumes another user in your VCS deleted the folder and removed the meta file, so deletes the empty folder locally.
-   If Unity detects a new `.meta` file for a folder, but that folder doesn’t exist locally, it assumes another user in your VCS created a new folder, and then creates a new unversioned meta file for empty folders.

## Additional resources

-   [Importing assets introduction](https://docs.unity3d.com/6000.3/Documentation/Manual/ImportingAssets.html)
-   [Asset workflow](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetWorkflow.html)
