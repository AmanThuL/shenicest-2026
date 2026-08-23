---
title: "Unity 6.3 Manual: Package name guidelines"
page_title: "Unity - Manual: Package name guidelines"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/cus-naming.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/cus-naming.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Package name guidelines

Make sure your package name meets the required guidelines and restrictions.

There are two names for a package:

-   The [display name](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPkg.html#displayName) is the user-facing name that appears in the Unity Editor. This name appears in multiple places, including the [list panel](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-list.html) and [details panel](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-details.html) of the **Package Manager** window and within the `Packages` folder of the **Project** window.
-   The technical name (sometimes referred to as the official name) is an identifier that you register the package with. The technical name maps to the [name](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPkg.html#name) property of the package manifest. The base folder for your package in your computer’s file system also uses the technical name.

When you [create your package](https://docs.unity3d.com/6000.3/Documentation/Manual/cus-create.html) with the Package Manager window, the Package Manager sets the technical name based on the display name you provide. To view these names, select your package in the **Package Manager** window then go to the **Inspector** window. If you want to edit these names, select **Edit** and change the names, following the [guidelines and restrictions](https://docs.unity3d.com/6000.3/Documentation/Manual/cus-naming.html#tech-name-guide).

<span id="tech-name-struct"></span>

## About the technical name

The technical name is a multi-part name (with three or more parts) in reverse domain format. Package Manager assembles the technical name by concatenating your top-level domain, organization name, and a modified version of the display name you provided when creating the package. This naming convention prevents name conflicts between packages from separate organizations. The technical name consists of the following elements:

-   The top-level domain for your company or organization, such as `com` or `net`.
-   Your organization name. If you’re not in an organization when you [create the package](https://docs.unity3d.com/6000.3/Documentation/Manual/cus-create.html), Package Manager sets these first two identifiers as `com.undefined`.
-   An optional product name. If your package is one of multiple packages you want to group into a single product namespace, you can include an optional, third identifier as the product name. For example, `com.example.product`.
-   A modified version of the display name, which Package Manager appends at the end of the technical name. Before appending this part of the name, Package Manager removes spaces, periods, and numbers, then converts the string to lowercase.

If the technical name conflicts with the technical name of an existing package, Package Manager appends a digit at the end.

### Examples of technical names

-   `com.organization.input`
-   `com.organization.2d.physics`
-   `com.organization.2d.tools`

<span id="tech-name-guide"></span>

## Guidelines and restrictions for the technical name

After you [create your package](https://docs.unity3d.com/6000.3/Documentation/Manual/cus-create.html), you can edit its technical name by [editing the package manifest](https://docs.unity3d.com/6000.3/Documentation/Manual/cus-edit-manifest.html).

If you edit the technical name, it must conform to the following guidelines and restrictions:

-   The name must use reverse domain name notation, which means it must start with **\<top-level-domain>.\<organization-name>**, such as `com.example` or `net.example`.
-   Don’t use `com.unity` at the beginning of your package’s technical name.
-   Don’t use `unity` anywhere in your package name.
-   The technical name can contain only lowercase letters, digits, hyphens(-), underscores (\_), and periods (.)
-   The recommended limit for the technical name is 50 characters. Package Manager imposes a strict limit of 214 characters.

**Note**: These naming restrictions apply only to the package names themselves and don’t need to match the namespace in your code. For example, you can use `Project3dBase` as a namespace in a package called `net.example.3d.base`.

## Next steps

Now that your package has valid names, you can proceed with other activities in the [package development workflow](https://docs.unity3d.com/6000.3/Documentation/Manual/CustomPackages.html). Typical activities at this stage of package development include:

-   [Add code to your package](https://docs.unity3d.com/6000.3/Documentation/Manual/cus-add-code.html)
-   Review the [package layout](https://docs.unity3d.com/6000.3/Documentation/Manual/cus-layout.html).

## Additional resources

-   [Package creation](https://docs.unity3d.com/6000.3/Documentation/Manual/cus-pkg-lp.html)
-   [Package development workflow](https://docs.unity3d.com/6000.3/Documentation/Manual/CustomPackages.html)
