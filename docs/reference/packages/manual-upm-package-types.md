---
title: "Differences between package types"
page_title: "Unity - Manual: Differences between package types"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-package-types.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-package-types.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Differences between package types

Unity’s Package Manager supports two package types:

-   UPM packages (Unity Package Manager built-in format).
-   Asset packages (`.unitypackage` format).

The following table compares the differentiating characteristics of these package types:

| **Characteristic**                                                                                                        | **UPM packages**                                                                                  | **Asset packages**                                                                                                                                                    |
|:--------------------------------------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Format                                                                                                                    | Collection of files and folders, which might be compressed, depending on the distribution method. | A compressed file with a `.unitypackage` extension.                                                                                                                   |
| Primary source for the package                                                                                            | Unity registry, scoped registry, or Asset Store.                                                  | Asset Store                                                                                                                                                           |
| Typical contents                                                                                                          | Scripts, tools, utilities, and SDKs.                                                              | Art and media assets (such as models, textures, animations, audio.)                                                                                                   |
| Supports [package dependencies](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-dependencies.html)               | Yes                                                                                               | No                                                                                                                                                                    |
| Supports [version switching](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-update.html) in the Editor       | Yes                                                                                               | No                                                                                                                                                                    |
| Uses a [package manifest](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPkg.html) file                 | Yes                                                                                               | No                                                                                                                                                                    |
| <span class="notooltips">UI</span> action for adding the package to a project                                             | Install                                                                                           | Download and import                                                                                                                                                   |
| Folder structure                                                                                                          | Standardized                                                                                      | Free-form                                                                                                                                                             |
| Project folder the package is added to                                                                                    | `Packages`                                                                                        | `Assets`                                                                                                                                                              |
| Cache the package is added to                                                                                             | [Global cache](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-cache.html)               | Asset package cache. Refer to [Location of downloaded asset package files](https://docs.unity3d.com/6000.3/Documentation/Manual/asset-store-packages#asset-location). |
| You can manually remove the package from the cache                                                                        | No                                                                                                | Yes                                                                                                                                                                   |
| Sets of tabs that appear in the [Details panel](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-details.html) | Description, Version History, Dependencies, Samples (if provided), Images (if provided)           | Overview, Releases, Imported Assets, Images                                                                                                                           |

## Guidelines for package creators

If you’re creating a package, follow these guidelines to help you determine which format to choose:

-   Use UPM when you need version control, dependency management, or plan to share or maintain the package across multiple projects. The UPM format is more suited for code and reusable elements.
-   Use Asset package (`.unitypackage`) for one-time imports of art assets such as (but not limited to) models, textures, animations, and audio. This format is also appropriate for informal package sharing, rather than distributing in a registry (scoped or otherwise).

## Additional resources

-   [Add and remove UPM packages or feature sets](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-actions.html)
-   [Add and remove asset packages](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-actions-ap.html)
-   [Create UPM packages](https://docs.unity3d.com/6000.3/Documentation/Manual/CustomPackages.html)
-   [Create asset packages](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetPackagesCreate.html)
