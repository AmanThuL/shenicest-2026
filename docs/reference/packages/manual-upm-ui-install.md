---
title: "Install a UPM package from a registry"
page_title: "Unity - Manual: Install a UPM package from a registry"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-install.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-install.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Install a UPM package from a registry

**Note**: When you install a UPM package using Package Manager, the Package Manager evaluates other packages and their dependencies to determine if there are version conflicts with the version you selected. If it detects any conflicts or restrictions, it installs the version that resolves these issues. For more information, refer to [Package dependency and resolution](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-dependencies.html).

Use the same process for installing a package from either the Unity registry or any [scoped registry](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-scoped.html) defined in your project.

1.  Open the **Package Manager** window and select **Unity Registry** from the [navigation panel](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-nav.html). If you set up a [scoped registry](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-scoped.html) and you want to install a package from a scoped registry, choose **My Registries** instead.

    **Note**: If you haven’t defined any scoped registries for this project, **My Registries** doesn’t appear in the navigation panel.

    ![Select **Unity Registry** or **My Registries**](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/upm-ui-unityregistry.png)

2.  Select the package you want to install from the [list of packages](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-list.html). The package information appears in the [details panel](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-details.html).

    **Note:** If the Package Manager doesn’t list the package you want to install in the list of packages, it might be an undiscoverable package, such as an [experimental](https://docs.unity3d.com/6000.3/Documentation/Manual/pack-exp.html) or [pre-release](https://docs.unity3d.com/6000.3/Documentation/Manual/pack-preview.html) package. The Package Manager doesn’t display experimental packages unless they’re already installed, but pre-release packages appear in the Package Manager when you enable the [Show Pre-release Package Versions](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PackageManager.html#advanced_preview) project setting.

3.  Optional: If multiple versions are available, select the version to install. For more information on available versions, refer to [Find a specific version of a package](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-find-ver.html).

4.  Click **Install**.

![Install button in the corner of the details panel](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/upm-ui-install.png)

When the progress bar finishes, the new package is ready to use.

**Note**: You can install multiple packages with one click by using the multiple select feature. For more information, refer to [Perform an action on multiple packages or feature sets](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-multi.html).

## Additional resources

-   [Package types](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-package-types.html)
-   [Install a UPM package from Asset Store](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-install2.html)
-   [Download and import an asset package](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-import.html)
