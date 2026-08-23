---
title: "Cinemachine - Installation and upgrade"
page_title: "Installation and upgrade | Cinemachine | 3.1.7"
source_url: "https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/InstallationAndUpgrade.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/InstallationAndUpgrade.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Installation and upgrade

Cinemachine is a free package, available for any project.

To install this package, follow the instructions in the [Package Manager documentation](https://docs.unity3d.com/Manual/upm-ui.html).

##### Tip

Once the installation is complete, a new **GameObject** \> **Cinemachine** menu is available to add [pre-built Cinemachine Cameras](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/ui-ref-pre-built-cameras.html) according to your needs.

## Installation requirements

This version of Cinemachine is compatible with the following versions of the Unity Editor:

-   2022.3 LTS and later

Cinemachine has few external dependencies. Just install it and start using it. If you are also using the Post Processing via HDRP or URP volumes, then adapter modules are provided - protected by `ifdef` directives which auto-define if the presence of the dependencies is detected.

There are similar `ifdef`-protected behaviours for other packages, such as Timeline and UGUI.

## Cinemachine project upgrade

If you have a project that uses an earlier version of Cinemachine and you need to update it to use the latest Cinemachine version, refer to the links in the table below.

##### Caution

The Cinemachine 3.x architecture includes many breaking changes compared to Cinemachine 2.x and earlier versions. While it is possible to upgrade an existing project from Cinemachine 2.x to Cinemachine 3.x, you should think carefully about whether you are willing to put in the work.

| Section                                                                                                                                                         | Description                                                                                                                        |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------|
| [Upgrade your project from Cinemachine 2.x](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineUpgradeFrom2.html)                    | Instructions to follow if your project currently uses Cinemachine 2.x.                                                             |
| [Upgrade from the Asset Store version of Cinemachine](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineUpgradeFromAssetStore.html) | Instructions to follow if your project currently uses a former version of Cinemachine from the Asset Store (prior to version 2.x). |

## Additional resources

-   [What has changed in the API between Cinemachine 2.x and 3.x](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/whats-new.html#major-api-changes)
