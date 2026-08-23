---
title: "Introduction to packages"
page_title: "Unity - Manual: Introduction to packages"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-concepts.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-concepts.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to packages

This section explains many of the concepts surrounding the Unity Package Manager functionality:

-   [Introduction to packages](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-concepts.html#introduction-to-packages)
-   [Versions](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-concepts.html#versions)
-   [Manifests](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-concepts.html#manifests)
-   [Registry](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-concepts.html#registry)
-   [Package management](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-concepts.html#package-management)
-   [Package sources](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-concepts.html#package-sources)
-   [Additional resources](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-concepts.html#additional-resources)

<span id="Versions"></span>

## Versions

Multiple versions of each package are available, marking changes to that package along its lifecycle. Every time a developer updates the package, they [give it a new version number](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-semver.html). A change in package version tells you whether it contains a breaking change (major), new backward-compatible functionality (minor), or bug fixes only (patch). These indicators follow [Semantic Versioning](http://semver.org/) rules.

To view the list of versions available for a specific package, refer to [Find a specific version of a package](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-find-ver.html).

<span id="Manifests"></span>

## Manifests

There are two types of manifest files:

-   [Project manifests](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPrj.html) (`manifest.json`) store information that the Package Manager needs to locate and load the right packages, including a list of packages and versions declared as dependencies.
-   [Package manifests](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPkg.html) (`package.json`) store information about a specific package, and a list of packages and versions that the package requires.

Both files use [JSON](https://json.org) (JavaScript Object Notation) syntax.

<span id="Registry"></span>

## Registry

In the domain of Unity’s Package Manager, a package registry is a server that stores package contents and information (metadata) on each package version. Unity maintains a central registry of official packages that are available for distribution. By default, all projects use the official Unity package registry. But you can [add additional registries](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-scoped.html) to store and distribute private packages or stage custom packages while you are developing them.

<span id="Management"></span>

## Package management

The Unity Package Manager is a tool that manages the entire package system. Its primary tasks include the following:

-   It [communicates with the Unity package registry server](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-dependencies.html) and any [additional registries](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-scoped.html) you specify.
-   It reads your [project manifest](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPrj.html) and fetches package contents and metadata.
-   It [installs](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-install.html), [updates](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-update.html), and [removes](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-remove.html) UPM packages, whether they’re dependencies of the project or one of the installed packages.
-   It [downloads and imports asset packages](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-import.html) that you previously acquired from the Asset Store.
-   It [enables and disables](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-disable.html) Unity’s built-in packages.
-   It [displays information](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-details.html) about every version of every package.
-   It [resolves conflicts](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-conflicts.html) when the project and its packages require more than one package version.

The Unity Package Manager installs samples, tools, and assets on a per-project basis, rather than installing them across all projects for a specific machine or device. It uses a [global cache](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-cache.html) to store downloaded package metadata and contents. Once installed in a project, Unity treats [package assets](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-assets.html) similarly to other assets in the project. The only difference is that these assets are stored [inside the package folder](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-assets.html) and are **immutable**. You can permanently change content only from [Local](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-concepts.html#Local) and [Embedded](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-concepts.html#Embedded) package sources.

<span id="Sources"></span>

## Package sources

Sources describe where the package came from:

| **Source**                                    | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
|:----------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Registry**                                  | The Unity Package Manager downloads most packages from a package registry server into a [global cache](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-cache.html) on your computer as you request them. These packages are immutable, so you can use them in your project, but you can’t modify them or change their package manifests.                                                                                                                          |
| <span id="BuiltIn"></span>**Built-in**        | These packages allow you to enable or disable Unity features (for example, Terrain Physics, Animation, etc.). Built-in packages are immutable. For more information, refer to [Built-in packages](https://docs.unity3d.com/6000.3/Documentation/Manual/pack-build.html).                                                                                                                                                                                                   |
| <span id="Embedded"></span>**Embedded**       | An [embedded package](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-embed.html) is any package stored inside your project folder. This source corresponds with the [Custom](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-lifecycle.html#Develop) state because you typically put all the scripts, libraries, samples, and other assets your new package needs in a folder under your project folder when you begin development on a custom package. |
| <span id="Local"></span>**Local**             | You can [install a package from any folder](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-local.html) on your computer (for example, if you have cloned a development repository locally).                                                                                                                                                                                                                                                                   |
| <span id="Tarball"></span>**Tarball (local)** | You can [install a package from a tarball file](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-tarball.html) on your computer. The Package Manager extracts the package from the tarball and stores it in the cache. However, these packages are immutable, unlike installations from a local folder.                                                                                                                                                         |
| <span id="Git"></span>**Git**                 | The Package Manager installs **Git**-based packages directly from a Git repository instead of from the package registry server.                                                                                                                                                                                                                                                                                                                                            |

To edit the package manifest for a package, refer to [Inspecting packages](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-inspect.html).

The Package Manager window displays a label that corresponds to some of these sources. For more information, refer to [Labels](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-details.html#Tags).

**Note**: The Package Manager stores packages that you download from the Asset Store in different caches, depending on the package type.

## Additional resources

-   [Package types](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-package-types.html)
-   [Package states and lifecycle](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-lifecycle.html)
-   [Package dependency and resolution](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-dependencies.html)
-   [Global cache](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-cache.html)
-   [Asset Store packages](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetStorePackages.html)
