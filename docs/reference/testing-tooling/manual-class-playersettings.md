---
title: "Player settings reference"
page_title: "Unity - Manual: Player"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettings.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettings.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Player

<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerSettings.html" class="switch-link gray-btn sbtn left" title="Go to PlayerSettings page in the Scripting Reference">Switch to Scripting</a>

The **Player** settings window (menu: **Edit** \> **Project Settings** \> **Player**) contain settings that determine how Unity builds and displays your final application. You can use the [PlayerSettings](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerSettings.html) API to control most of the settings available in this window.

**Note**: You can access **Player** settings from the **Build Profiles** window (menu: **File** \> **Build Profiles**).

## General settings

The Player settings differ between the [platform modules](https://docs.unity.com/hub/add-modules.html) that you’ve installed. Each [platform](https://docs.unity3d.com/6000.3/Documentation/Manual/PlatformSpecific.html) has its own Player settings which you’ll need to set for each version of your application you want to build. To navigate between them, click on the tabs with the platform operating system icon on.

![Player settings window](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/player-settings-window.png)

There are some general settings that all platforms share by default, unless you use [build profiles](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles.html).

**Note**: With build profiles, you can customize the Player settings per build profile to set different values for each platform. For more information, refer to [Customize settings with build profiles](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-override-settings.html).

<span id="general"></span>

| **Property**                                   | **Function**                                                                                                                                                                                                              |
|:-----------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <span id="CompanyName"></span>**Company Name** | Enter the name of your company. Unity uses this to locate the preferences file.                                                                                                                                           |
| <span id="ProductName"></span>**Product Name** | Enter the name that appears on the menu bar when your application is running. Unity also uses this to locate the preferences file.                                                                                        |
| **Version**                                    | Enter the version number of your application.                                                                                                                                                                             |
| **Default Icon**                               | Pick the Texture 2D file that you want to use as a default icon for the application on every platform. You can override this for specific platforms.                                                                      |
| **Default Cursor**                             | Pick the Texture 2D file that you want to use as a default cursor for the application on every supported platform.                                                                                                        |
| **Cursor Hotspot**                             | Set the pixel offset value from the top left of the default cursor to the location of the cursor hotspot. The cursor hotspot is the point in the cursor image that Unity uses to trigger events based on cursor position. |

## Platform-specific settings

The platform-specific settings are divided into the following sections:

-   **Icon**: the game icon(s) as shown on the desktop. You can choose icons from 2D image assets in the Project, such as sprites or imported images.
-   **Resolution and Presentation**: settings for screen resolution and other presentation details such as whether the game should default to fullscreen mode.
-   **Splash Image**: the image shown while the game is launching. This section also includes common settings for creating a Splash Screen. For more information, refer to the [Splash Image](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettingsSplashScreen.html) documentation.
-   **Other Settings**: any remaining settings specific to the platform.
-   **Publishing Settings**: details of how the built application is prepared for delivery from the app store or host webpage.
-   **XR Settings**: settings specific to [Virtual Reality, Augmented Reality, and Mixed Reality](https://docs.unity3d.com/6000.3/Documentation/Manual/XR.html) applications.

You can find information about the settings specific to individual platforms in the [platform’s own manual section](https://docs.unity3d.com/6000.3/Documentation/Manual/PlatformSpecific.html):

-   **Android:** [Android Player settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettingsAndroid.html)
-   **Dedicated Server:** [Dedicated Server Player settings](https://docs.unity3d.com/6000.3/Documentation/Manual/dedicated-server-player-settings.html)
-   **Embedded Linux:** [Embedded Linux Player settings](https://docs.unity3d.com/6000.3/Documentation/Manual/embedded-linux-player-settings.html)
-   **iOS:** [iOS Player settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettingsiOS.html)
-   **Linux:** [Linux Player settings](https://docs.unity3d.com/6000.3/Documentation/Manual/PlayerSettings-linux.html)
-   **macOS:** [macOS Player settings](https://docs.unity3d.com/6000.3/Documentation/Manual/PlayerSettings-macOS.html)
-   **QNX:** [QNX Player settings](https://docs.unity3d.com/6000.3/Documentation/Manual/qnx-player-settings.html)
-   **tvOS:** [tvOS Player settings](https://docs.unity3d.com/6000.3/Documentation/Manual/tvos-player-settings.html)
-   **Universal Windows Platform:** [UWP Player settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettingsWSA.html)
-   **Web and Facebook Instant Games:** [Web Player settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettingsWebGL.html)
-   **Windows:** [Windows Player settings](https://docs.unity3d.com/6000.3/Documentation/Manual/playersettings-windows.html)

You can find details of closed platform Player settings in their respective documentation.

## Additional resources

-   [Create and manage build profiles](https://docs.unity3d.com/6000.3/Documentation/Manual/create-build-profile.html)

<span class="search-words">PlayerSettings</span>
