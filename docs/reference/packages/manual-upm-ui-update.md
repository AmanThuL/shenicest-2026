---
title: "Switch to another version of a UPM package"
page_title: "Unity - Manual: Switch to another version of a UPM package"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-update.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-update.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Switch to another version of a UPM package

Use the information on this page to update UPM packages that you installed from the [Unity Registry](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-install.html) or a [scoped registry](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-scoped.html), or from a [local source](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-local.html).

**Important**: The information on this page applies only to packages in the UPM format, including UPM packages you [installed from the Asset Store](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-install2.html). This information doesn’t apply to asset packages from the Asset Store that use the `.unitypackage` format. For information about updating asset packages, refer to [Update an asset package](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-update2.html). For information about these two package types, refer to [Differences between package types](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-package-types.html).

You can also use the information on this page to switch to a registry version of a package, if your project currently uses a nonregistry version of the same package. Nonregistry versions include packages installed from disk (local) or from Git or as a tarball.

If you want to install a specific version of a package, refer to [install the package by name](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-quick.html) and follow its optional step to specify a version.

If you want to update packages that you installed from a Git URL, you can use any of the following methods:

-   Locate the package in the **Package Manager** window, select it, then click the **Update** button.
-   [Reinstall the package as a Git dependency](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-giturl.html) using a new revision. For more information about how to specify revisions with Git dependencies, refer to [Targeting a specific revision](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-git.html#revision).
-   Reinstall the package from the Unity Registry.

To change to a different version of a UPM package:

1.  Open the **Package Manager** window and select **In Project**, **Unity Registry**, or **My Registries** from the [navigation panel](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-nav.html). You can also select the **Updates** entry, which lists all packages in your project that have updates available. An arrow icon appears next to packages that have updates available.

2.  Select the installed package you want to update from the [list of packages](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-list.html). The package information appears in the [details panel](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-details.html). <span id="fs-lock"></span>

3.  If the package is part of a feature set (indicated by the lock icon near the package name) you must unlock the package before you switch versions. To unlock the package and select another version, select **Unlock**. Starting with Unity 6.3, **Unlock** is in the **Manage** dropdown.

    **Note**: The package is temporarily unlocked. If you select a different context in the [navigation panel](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-nav.html), or close either the **Package Manager** window or the Unity Editor, the package reverts to a locked state. However, if you change versions when the package is unlocked (for example, with the [Install a package from a registry by name](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-quick.html) method), the package stays unlocked.

4.  Select a package in the [list of packages](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-list.html).

5.  In the [details panel](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-details.html), select the **Version History** tab. If multiple versions are available, expand the entries to view information specific to each version.

6.  Click the **Update to #.#** button, or click the **Update** button beside the version listed in the **Version History** tab.

    When the progress bar finishes, any new functionality is immediately available.

**Notes:**

-   If you switch from a nonregistry version of a package to a registry version, the Package Manager removes the nonregistry version from its version history, but the local package still exists on disk, with any customization intact.
-   If you switch to an older version of a package, you might have to run the [API Updater](https://docs.unity3d.com/6000.3/Documentation/Manual/APIUpdater.html) on the package contents.
-   You can switch versions for multiple packages with one click by using the multiple select feature. For more information, refer to [Perform an action on multiple packages or feature sets](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-multi.html).

## Additional resources

-   [Differences between package types](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-package-types.html)
-   [Add and remove UPM packages or feature sets](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-actions.html)
