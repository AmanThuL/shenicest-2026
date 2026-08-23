---
title: "Platform Browser window reference"
page_title: "Unity - Manual: Platform Browser window reference"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/platform-browser-reference.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/platform-browser-reference.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Platform Browser window reference

Explore the supported platforms, platform-specific configurations, and packages when you add a build profile for the target platform.

The **Platform Browser** window presents a list of Unity-supported platforms you can build your application on. To open the **Platform Browser** window, select **Add Build Profile** from the **Build Profiles** window (menu: **File** \> **Build Profiles**).

The **Platform Browser** window includes the following sections.

## Platform list

Displays the platforms supported by Unity, which include mobile, desktop, web, servers, XR, and closed platforms. Access to the closed platforms provides additional platform options. For a complete list of platforms that Unity supports and to know about the minimum system requirements for these platforms, refer to [System requirements](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html).

When you select a platform from the list, detailed information about that platform appears on the right-side of the window. If the build support module for the selected platform is not currently installed in your project, this section displays **Install with Unity Hub** button. This button directs you to **Unity Hub** to install the missing build support module required for the platform. You must restart the Unity Editor after installing the module.

**Note**: For closed platforms, or for platforms that require a specific Unity support plan, the build support modules are available as separate installer files. For more information, refer to [Embedded Systems support plan](https://unity.com/products/compare-plans/embedded) and [Game development for console platforms](https://unity.com/solutions/console).

## Name

Specify an identifier for the build profile that you add for a platform.

**Tip**: Choose a unique name for the build profile that reflects the purpose of the build and is easy to identify from a list of multiple build profiles.

## Add Build Profile

Select **Add Build Profile** to create a build profile for the selected platform. This installs any required and selected optional packages, includes the selected build configurations in the newly created build profile, which then gets added to the main **Build Profiles** window. You can then customize the new build profile to meet the requirements of your project.

**Note**: The **Add Build Profile** button text updates to reflect the number of build configurations you choose.

## Platform-specific configurations

When you select a platform from the platform list, platform-specific configuration options appear on the right-hand side of the **Platform Browser** window. These options are only available for specific platforms.

### Build Profile Configurations

Provides a set of pre-defined build configurations that are recommended for a specific build type and the target device type. These configuration options provide optimized build settings without requiring you to select individual build settings manually.

You can select individual configurations or create build profiles for all configurations simultaneously as required. Alternatively, you can opt out of these options and configure the build settings manually.

### Packages

Displays a list of packages that you can install for the selected platform. Packages required by a platform are marked with a **Required** label and are installed automatically when you create a build profile for that platform.

For some platforms, such as Meta Quest, you can install [Partner packages](https://docs.unity3d.com/6000.3/Documentation/Manual/xr-meta-quest-packages.html) directly from the **Platform Browser** window. Use the **Select All** or **Deselect All** buttons as required to select or deselect packages at once.

## Additional resources

-   [Build Profiles window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html)
-   [Platform development](https://docs.unity3d.com/6000.3/Documentation/Manual/PlatformSpecific.html)
