---
title: "Create and manage build profiles"
page_title: "Unity - Manual: Create and manage build profiles"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/create-build-profile.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/create-build-profile.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Create and manage build profiles

Create and manage build profiles to configure your application for multiple platforms.

## Create a build profile

To create a build profile, use the following steps:

1.  Navigate to **File** > **Build Profiles**.
2.  In the **Build Profiles** window, select **Add Build Profile** to open the **Platform Browser** window. The **Platform Browser** window presents a list of supported platforms that include desktop, mobile, web, and closed platforms.
3.  In the **Platform Browser** window, select the target platform. If the selected platform isn’t currently installed on your machine, use **Install with Unity Hub** and follow the installation instructions. Before installing any platform modules, refer to the [System requirements](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html) page.
4.  Enter a unique name for the build profile in the **Name** field. The name identifies the build profile in the **Build Profiles** window.
5.  Select any recommended packages to install from the **Packages** section. Required packages are automatically selected for installation when creating a build profile from the **Platform Browser**.
6.  Select **Add Build Profile**.
7.  Select the required [platform settings](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html).
8.  Select **Switch Profile** to set the new build profile as the active profile. This will attach an **Active** badge to the build profile name.

**Note**: If you plan to deploy your application on a closed platform, check the license requirements. For further information, refer to [Platform Module Installation](https://unity.com/platform-installation).

## Create a build profile from a platform profile

You can duplicate an existing platform profile and create a new build profile from it. To do that, right click the selected platform and select **Copy to new profile**.

## Manage build profiles

To manage build profiles, right-click on any build profile name. These options allow you to do the following:

-   Copy to a new build profile.
-   Rename a build profile.
-   Delete a build profile.

**Note**: There are no limits to how many build profiles you can have in a project.

## Additional resources

-   [Build Profiles window reference](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html)
-   [Build Profiles scripting API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.html)
-   [System requirements](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html)
