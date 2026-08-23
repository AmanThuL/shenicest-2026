---
title: "Reserved folder name reference"
page_title: "Unity - Manual: Reserved folder name reference"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/SpecialFolders.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/SpecialFolders.html"
topic: "project-structure"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Reserved folder name reference

Every Unity project has an `Assets` folder in the project root which contains the project’s [assets](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetWorkflow.html). The [Project window](https://docs.unity3d.com/6000.3/Documentation/Manual/ProjectView.html) displays the contents of the `Assets` folder.

Some limitations apply when choosing names for new folders. There are some names for subfolders of the `Assets` folder that Unity reserves for certain subtypes of assets, and which have special compilation significance or are used to categorize assets for the Editor or Player. These folder names and their meaning are detailed in the following table.

<table><thead><tr class="header"><th style="text-align: left;">Folder name</th><th style="text-align: left;">Description</th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><code>Editor</code></td><td style="text-align: left;">Reserved for Editor scripts, which add functionality to the Unity Editor at authoring time but aren’t available in Player builds at runtime. An alternative to placing scripts in a folder called <code>Editor</code> is to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-creating.html">create an assembly definition asset</a> for Editor code. The exact location of an <code>Editor</code> folder determines the script compilation order of its contents. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/script-compile-order-folders.html">Special folders and script compilation order</a>.<br />
<strong>Maximum number of folders with this name per project:</strong> Unlimited<br />
<strong>Valid location for folder</strong>: Root of the <code>Assets</code> folder or any of its subfolders.<br />
<strong>Place relevant assets in</strong>: <code>Editor</code> folder or any of its subfolders.<br />
<br />
<strong>Note:</strong> MonoBehaviour scripts in an <code>Editor</code> folder can’t be attached to GameObjects as components.</td></tr><tr class="even"><td style="text-align: left;"><code>Editor Default Resources</code></td><td style="text-align: left;">Reserved for asset files that Editor scripts can load on-demand using <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorGUIUtility.Load.html">EditorGUIUtility.Load</a>.<br />
<strong>Maximum number of folders with this name per project:</strong> 1<br />
<strong>Valid location for folder</strong>: Root of the <code>Assets</code> folder only.<br />
<strong>Place relevant assets in</strong>: <code>Editor Default Resources</code> folder or any of its subfolders.<br />
<br />
<strong>Note</strong>: Always include the subfolder path in the path passed to <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorGUIUtility.Load.html">EditorGUIUtility.Load</a> if your asset files are in subfolders.</td></tr><tr class="odd"><td style="text-align: left;"><code>Gizmos</code></td><td style="text-align: left;">Reserved for image files used by the <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Gizmos.DrawIcon.html">Gizmos.DrawIcon</a> function to draw icons in a <strong>Scene</strong> view. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/gizmos-and-handles.html">Gizmos and Handles</a>.<br />
<strong>Maximum number of folders with this name per project:</strong> 1<br />
<strong>Valid location for folder</strong>: Root of the <code>Assets</code> folder only.<br />
<strong>Place relevant assets in</strong>: <code>Gizmos</code> folder or any of its subfolders.<br />
<br />
<strong>Note</strong>: Always include the subfolder path in the path passed to the <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Gizmos.DrawIcon.html">Gizmos.DrawIcon</a> function if your asset files are in subfolders.</td></tr><tr class="even"><td style="text-align: left;"><code>Resources</code></td><td style="text-align: left;">Reserved for assets to load on-demand from a script at application runtime rather than creating references to assets in a scene. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/LoadingResourcesatRuntime.html">Loading Resources at Runtime</a>.<br />
<strong>Maximum number of folders with this name per project:</strong> Unlimited<br />
<strong>Valid location for folder</strong>: Root of the <code>Assets</code> folder or any of its subfolders.<br />
<strong>Place relevant assets in</strong>: <code>Resources</code> folder or any of its subfolders.<br />
<br />
<strong>Note</strong>: Always include the subfolder path in the path passed to the <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.Load.html">Resources.Load</a> function if your asset files are in subfolders. Assets in a <code>Resources</code> folder increase the size of Player builds and assets not required at runtime must be manually cleaned up to prevent them degrading your application’s performance. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/LoadingResourcesatRuntime.html">The Resources folder</a>.</td></tr><tr class="odd"><td style="text-align: left;"><code>Plugins</code></td><td style="text-align: left;">Reserved for third-party plugins. For platform-specific information on valid folder path patterns, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/plug-in-inspector.html">Import and configure plug-ins</a>.</td></tr><tr class="even"><td style="text-align: left;"><code>StreamingAssets</code></td><td style="text-align: left;">Reserved for asset files that should be available in their original format at runtime for streaming. For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/StreamingAssets.html">Streaming Assets</a>.<br />
<strong>Maximum number of folders with this name per project:</strong> 1<br />
<strong>Valid location for folder</strong>: Root of the <code>Assets</code> folder only.<br />
<strong>Place relevant assets in</strong>: <code>StreamingAssets</code> folder or any of its subfolders.</td></tr></tbody></table>

## Platform-specific folders

For information on folder name formats and extensions which denote plug-ins or asset types specific to particular platforms, refer to [Platform development](https://docs.unity3d.com/6000.3/Documentation/Manual/PlatformSpecific.html).

<span id="HiddenAssets"></span>

## Hidden assets

During the [import](https://docs.unity3d.com/6000.3/Documentation/Manual/ImportingAssets.html) process, Unity ignores the following files and folders in the `Assets` folder and its subfolders:

-   Hidden folders.
-   Files and folders which start with `.`, except for those under `StreamingAssets` where this pattern is not ignored.
-   Files and folders which end with `~`.
-   Files and folders named `cvs`.
-   Files with the extension `.tmp`.

This prevents importing special and temporary files created by the operating system or other applications.

**Note**: For folders created through the Editor’s create menu, the Editor automatically converts a dot (`.`) prefix into an underscore (`_`) prefix to prevent crashes. For example, a folder created in the Editor and named `.folder` is automatically renamed `_folder`. If you want to name a folder with a dot prefix, create it directly in your local file system instead.

## Additional resources

-   [Script compilation order](https://docs.unity3d.com/6000.3/Documentation/Manual/script-compile-order-folders.html)
