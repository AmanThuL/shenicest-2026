---
title: "Install Addressables"
page_title: "Install Addressables | Addressables | 2.9.1"
source_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/installation-guide.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/installation-guide.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Install Addressables

To install the Addressables package, open the Package Manager window (**Window** \> **Package Management** \> **Package Manager**) and perform one of the following options:

-   <a href="https://docs.unity3d.com/Manual/upm-ui-install.html" class="xref">Install it from the registry</a>
-   <a href="https://docs.unity3d.com/Manual/upm-ui-quick.html" class="xref">Add the package by its name</a> (`com.unity.addressables`)

## Set up the Addressables system

The Addressables system needs a folder for its settings, which you can automatically create when you open the Addressables Groups window for the first time. To create a folder for the Addressables settings in your project, perform the following steps:

1.  Open the [Addressables Groups window](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/GroupsWindow.html) (**Window** > **Asset Management** > **Addressables** > **Groups**).
2.  Select **Create Addressables Settings**, or drag an asset into the window.

When you run the **Create Addressables Settings** command, the Addressables system creates a folder called, `AddressableAssetsData`, in which it stores settings files and assets it uses to keep track of your Addressables setup. Add the files in this folder to your source control system.

Addressables can create additional files when you change your Addressables configuration. For more information, refer to [Addressable Asset Settings reference](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetSettings.html).

![The Addressables Groups window, and the Project window after selecting Create Addressables Settings. The Project window contains an AddressableAssetsData folder in the Assets folder.](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/images/install-settings.png)  
*The Addressables Groups window, and the Project window after selecting **Create Addressables Settings**. The Project window contains an `AddressableAssetsData` folder in the `Assets` folder.*

## Additional resources

-   [Convert existing projects to Addressables](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/convert-existing-projects.html)
-   [Create and organize Addressable assets introduction](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/organize-addressable-assets.html)
-   [Addressables Groups window reference](https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/GroupsWindow.html)
