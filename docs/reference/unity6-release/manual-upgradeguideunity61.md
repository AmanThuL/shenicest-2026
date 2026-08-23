---
title: "Upgrade to Unity 6.1"
page_title: "Unity - Manual: Upgrade to Unity 6.1"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity61.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity61.html"
topic: "unity6-release"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Upgrade to Unity 6.1

This page lists changes in Unity 6.1 that can affect existing projects when you upgrade them from Unity 6.0 to Unity 6.1.

Review changes for Unity 6.1 in these areas:

-   [Editor and workflow](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity61.html#editor)
-   [Graphics](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity61.html#graphics)
-   [Physics](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity61.html#physics)
-   [Platforms](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity61.html#platforms)

## Editor and workflow <span id="editor"></span>

This section outlines recent updates to the Editor and its general workflows that can affect your upgrade experience.

### Window menu changes

Package Manager, Asset Store, Services, My Assets, and Version Control now [appear in new submenus](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity61.html#editor-and-workflow). This change breaks any custom keyboard shortcuts to open these windows.

After upgrading, recreate any shortcuts to these windows.

## Graphics <span id="graphics"></span>

This section outlines recent updates to Unity’s graphics systems that can affect your upgrade experience.

### Render pipelines

For upgrade guides for specific render pipelines in Unity, refer to one of the following pages:

-   [Upgrade to URP 17.1 (Unity 6.1)](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/upgrade-guide-unity-6-1.html)

-   [Upgrade to HDRP 17.1 (Unity 6.1)](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.1/manual/upgrade-guides.html)

To upgrade other packages, refer to [the documentation for the packages you’re using](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-docs.html).

### The `_CLUSTER_LIGHT_LOOP` shader keyword replaces `_FORWARD_PLUS`

Unity 6.1 replaces the `_FORWARD_PLUS` shader keyword with the `_CLUSTER_LIGHT_LOOP` keyword. If your custom shaders use the `_FORWARD_PLUS` keyword, replace it with `_CLUSTER_LIGHT_LOOP`.

For more information about using the keywords, refer to [Shader keywords and macros reference in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/urp-shaders/shader-keywords-macros.html).

### Support for the PVRTC format is deprecated

Support for PVRTC compression is deprecated and will be fully removed in the future. It’s recommended that you transition to other compression formats, such as ASTC or ETC, to avoid issues in future upgrades.

## Physics <span id="physics"></span>

This section outlines recent updates to Physics-specific tools and settings that can affect your upgrade experience.

### Rigidbody.SetDensity is deprecated

The `SetDensity` method was deprecated for [`Rigidbody`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody.html). Use [`Rigidbody.mass`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rigidbody-mass.html) instead.

The `SetDensity` method was effectively used as a mass multiplier for the body by the physics integration instead of a per-Collider value used during mass distribution to determine each Collider’s mass.

## Platforms <span id="platforms"></span>

This section outlines recent updates to platform-specific tools and settings that can affect your upgrade experience.

### Android

#### The default Android tools versions have changed

Unity has updated the default versions of the following tools used by Android. The default versions of SDK build tools, SDK platform tools, and JDK remain unchanged. The updated versions are as follows:

| **Tool**               | **Version** |
|:-----------------------|:------------|
| Gradle                 | 8.11        |
| Android Gradle Plugin  | 8.7.2       |
| SDK Command-line tools | 16.0        |
| NDK                    | r27c        |

If your project uses any [custom Gradle templates](https://docs.unity3d.com/6000.3/Documentation/Manual/gradle-templates.html), consider recreating those templates to avoid any build issues with the updated Android Gradle Plugin version. For more information, refer to [Modify Gradle project files with Gradle template files](https://docs.unity3d.com/6000.3/Documentation/Manual/android-modify-gradle-project-files-templates.html).

### Windows

#### New default Auto Graphics API

The default Auto Graphics API in Unity 6.1 is DirectX12. Projects upgrading from older versions of Unity maintain the default setting from their version.

To change to the default for 6.1, in **Player Settings**, enable **Auto Graphics API**.
