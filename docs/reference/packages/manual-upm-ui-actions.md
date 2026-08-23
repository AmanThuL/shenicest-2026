---
title: "Add and remove UPM packages or feature sets"
page_title: "Unity - Manual: Add and remove UPM packages or feature sets"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-actions.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-actions.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Add and remove UPM packages or feature sets

You can perform a variety of package management tasks by using the Package Manager window.

Follow these tasks to manage UPM packages or feature sets. For information about managing asset packages, refer to [Add and remove asset packages](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-actions-ap.html).

| **Topic**                                                                                                                       | **Description**                                                                 |
|:--------------------------------------------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------|
| **[Install a feature set from the Unity registry](https://docs.unity3d.com/6000.3/Documentation/Manual/fs-install.html)**       | Install a feature set from the Features expander in the Package Manager window. |
| **[Install a UPM package from a registry](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-install.html)**           | Install a package from the Unity registry or a scoped registry.                 |
| **[Install a UPM package from the Asset Store](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-install2.html)**     | Install UPM packages that you acquired from the Asset Store.                    |
| **[Install a UPM package from a local folder](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-local.html)**         | Load a UPM package from a local folder on your computer.                        |
| **[Install a UPM package from a local tarball file](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-tarball.html)** | Load a UPM package from a tarball file stored locally.                          |
| **[Install a UPM package from a Git URL](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-giturl.html)**             | Load a UPM package from a Git repository on a remote server.                    |
| **[Install a UPM package by name](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-quick.html)**                     | Install a UPM package using its exact name.                                     |
| **[Remove a UPM package from a project](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-remove.html)**              | Remove a direct dependency from your project manifest.                          |
| **[Switch to another version of a UPM package](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-update.html)**       | Update an installed UPM package to a different version.                         |

The procedures described in these sections obscure a lot of the details of what the Package Manager is actually doing behind the scenes. The Package Manager window provides a visual interface to install and uninstall packages. The Package Manager installs and uninstalls packages by adding and removing packages as project dependencies in your [project’s manifest](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPrj.html). When it adds a package, it selects the correct version to install. The version that Package Manager selects doesn’t always match the version you indicated. For more information, refer to [Package dependency and resolution](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-dependencies.html).

## Additional resources

-   [Package types](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-package-types.html)
-   [Add and remove asset packages](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-actions-ap.html)
-   [Disable a built-in package](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-disable.html)
-   [Perform an action on multiple packages or feature sets](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-multi.html)
