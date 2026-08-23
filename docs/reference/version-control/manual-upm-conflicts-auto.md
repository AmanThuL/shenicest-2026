---
title: "Unity Manual 6.3 LTS: Package Manager lock files (packages-lock.json)"
page_title: "Unity - Manual: Lock files"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-conflicts-auto.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-conflicts-auto.html"
topic: "version-control"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Lock files

A lock file contains the results of the Package Manager’s [dependency resolution](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-conflicts.html) for a project.

Package managers use lock files to provide a [deterministic](https://en.wikipedia.org/wiki/Deterministic_algorithm) result when resolving a [package dependency graph](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-dependencies.html). When the Unity Package Manager computes a successful resolution, it stores that resolution inside the project’s `Packages` folder in a JSON file called `packages-lock.json`. Any modification to the project manifest or to a [custom or local](https://docs.unity3d.com/6000.3/Documentation/Manual/cus-location.html) package’s manifest can cause the Package Manager to recalculate the resolved package versions. But as long as the version of a package in the lock file satisfies the range implied by the dependency version and the [resolution strategy](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-conflicts.html), the package remains locked at that version.

For example, here is a typical entry in the lock file:

``` lang-json
"com.unity.textmeshpro": {
  "version": "2.0.1",
  "depth": 0,
  "source": "registry",
  "dependencies": {
    "com.unity.ugui": "2.0.0"
  },
  "url": "https://packages.unity.com"
},
    etc.
```

When the Package Manager resolves any conflicting [indirect dependencies](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-dependencies.html), it tries to re-use as many locked packages as possible. This guarantees that subsequent dependency resolution produces the same results for the same set of dependencies. It also minimizes time-consuming operations such as downloading, extracting, or copying packages.

If there is no solution that only includes locked packages, then the Package Manager chooses the set of packages with the least risky upgrades, preferring patch upgrades over minor or major upgrades, and minor upgrades over major upgrades. In fact, you can customize the level of risk for upgrading. For more information, see [Customizing resolution strategies](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPrj.html#resolutionStrategy).

To force a refresh of indirect dependency versions, delete the lock file.

Don’t manually modify the lock file: the Package Manager creates and maintains the lock file, so it overwrites any changes you make to the file.

Put the lock file under source control so you can consistently reproduce the same package set to ensure your project remains consistent over time and on different machines.

## Disabling the lock file

By default, the Package Manager creates or updates the lock file when it successfully computes a dependency graph. If you see unexpected results, you can set the [enableLockFile](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPrj.html#enableLockFile) property to `false` in your project manifest to disable locking. However, if you disable the lock file, the Package Manager clones [Git URL](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-git.html) packages again, which leads to reduced performance and additional network usage. It might also lead to non-deterministic results if you push newer commits to the remote Git repository between two resolutions.
