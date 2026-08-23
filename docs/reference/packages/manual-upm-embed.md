---
title: "Embedded dependencies"
page_title: "Unity - Manual: Embedded dependencies"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-embed.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/upm-embed.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Embedded dependencies

Any package that appears under your project’s `Packages` folder is embedded in that project. You can create an embedded package in several ways:

-   [Create a new package](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-embed.html#embed-create) directly in your project’s `Packages` folder.
-   [Place a copy of a Unity package](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-embed.html#embed-cached) in your project’s `Packages` folder.
-   [Use a C# script to embed](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-api.html#Embed) a version of a package that’s already installed.

Embedded packages don’t need to appear in the project manifest as a dependency. However, if you embedded a version of an installed package, your project manifest still lists the dependency on the original installed version. In that case, the package on disk takes priority over the version of the package listed as a dependency, so it doesn’t need to be removed from the project manifest. For example, if the project manifest specifies a dependency on version 1.3.1 of the `com.unity.example` package but the project also has an embedded package with that name, the Package Manager uses the embedded package, regardless of its apparent version, instead of downloading version 1.3.1 from the registry.

Make sure you track the contents of your embedded packages, and any changes you make to it. If your Unity project is under source control, add any packages embedded in that project to the same source control.

<span id="embed-create"></span>

## Create a new custom package

To embed a new package, create your new package content inside a folder under the `Packages` folder. For more information, follow the [instructions for creating your own custom package](https://docs.unity3d.com/6000.3/Documentation/Manual/CustomPackages.html).

Typically, your new package remains embedded in your project until you are ready to share it with other users and test it in other projects. You can use different methods to [share your package](https://docs.unity3d.com/6000.3/Documentation/Manual/cus-share.html), for example, you can [host the package on a scoped registry](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-scoped-host.html).

<span id="embed-cached"></span>

## Copy a Unity package to your project folder

A package installed from a registry is immutable, which means you can’t edit it. If you want to edit a package, you can make it mutable by copying it to the `Packages` subfolder in your project folder. This package type is called an embedded package, and it overrides what’s in your package cache. Later, you can delete that embedded package’s folder from the `Packages` subfolder, and the Package Manager will automatically change to the immutable, cached package.

To copy a Unity package to your project folder:

1.  Use the Package Manager window to select the UPM package you want to copy from the **Unity Registry** or **In Project** context.

2.  Open the **Manage** dropdown in the [details panel](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-details.html).

3.  Select **Customize**.

The package now appears with the **Custom** label. You can edit the package, which was copied to the `Packages` folder of your project.

You can delete the embedded package and the Package Manager will automatically revert to the immutable, cached package. Consider backing up the folder for the embedded package, otherwise you’ll lose any changes you made to the package. Use either of the following methods to delete the embedded version of a package:

-   Use the Package Manager’s **Manage** dropdown to **Remove** the embedded package.
-   Use your file browser or command line to locate the `Packages` folder of your project. Then, delete the folder for that package from your `Packages` folder.

## Additional resources

-   [Project manifest](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPrj.html)
-   [Use a script to embed a package in your project](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-api.html#Embed)
