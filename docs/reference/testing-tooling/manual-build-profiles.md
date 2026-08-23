---
title: "Introduction to build profiles"
page_title: "Unity - Manual: Introduction to build profiles"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to build profiles

A build profile is a set of configuration settings you can use to build your application on a particular platform. Use the **Build Profiles** window to create multiple build profiles for each platform you work on, saving different configurations for release and development builds. For more information on release and development builds, refer to [Introduction to building](https://docs.unity3d.com/6000.3/Documentation/Manual/building-introduction.html).

Navigate to **File** \> **Build Profiles** to access the **Build Profiles** window.

## Profile types

There are two types of profiles available in the **Build Profiles** window.

### Platforms

The Platforms pane displays a list of currently installed platforms that Unity supports. A platform profile includes some [shared settings](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html#shared-build-settings) that apply to all platforms. For example, if you enable the **Development Build** setting for one platform profile, Unity will enable the setting across all the available platform profiles. Platforms also share the same scene data across each platform profile.

You can duplicate a platform, and create a new build profile. To do that, right click your selected platform and select **Copy to new profile**.

### Build Profiles

Unlike platforms, settings saved under build profiles aren’t shared across all the platforms. You can assign specific scenes to each build profile. Build profiles allow you to save multiple independent build configurations. You can save as many build profiles as you require using a custom name for each profile. Unity saves the build profile as an asset file that is ready for use with version control.

![Build profiles stored as Assets in the Project window.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/build-profiles-assets.png)

## Additional resources

-   [Create a build profile](https://docs.unity3d.com/6000.3/Documentation/Manual/create-build-profile.html)
-   [Build Profiles window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html)
-   [Build Profiles scripting API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.html)
