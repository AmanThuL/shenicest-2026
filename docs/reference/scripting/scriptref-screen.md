---
title: "Scripting API: Screen"
page_title: "Unity - Scripting API: Screen"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Screen

class in UnityEngine

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.CoreModule.html" class="cl">UnityEngine.CoreModule</a>

<span id="scrollToFeedback">Leave feedback</span>

<span class="blue-btn sbtn">Suggest a change</span>

## Success!

Thank you for helping us improve the quality of Unity Documentation. Although we cannot accept all submissions, we do read each suggested change from our users and will make updates where applicable.

<span class="gray-btn sbtn close">Close</span>

## Submission failed

For some reason your suggested change could not be submitted. Please \<a>try again\</a> in a few minutes. And thank you for taking the time to help us improve the quality of Unity Documentation.

<span class="gray-btn sbtn close">Close</span>

Your name Your email Suggestion<span class="r">\*</span>

Submit suggestion

<span class="cancel left lh42 cn">Cancel</span>

<span style="color:red;"> </span>

### Description

Provides access to display information.

Use this class to get a list of supported screen resolutions, change the current resolution, or hide/show the system mouse pointer.  
  
When you launch your application, Unity immediately needs to use settings like the screen's resolution and full-screen mode to render the first frame before any custom code starts to run. This means Unity doesn't initially use your code to configure these settings. Instead, Unity gets the values of these settings from command line arguments, [Player settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettings.html), or from [PlayerPrefs](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerPrefs.html).  
  
**Priority of initial startup settings**  
  
Unity determines the initial startup settings based on the following order of priority (highest to lowest):

1.  **Command line arguments**: If you specify a setting's value via command line, Unity prioritizes and uses that setting.
2.  **Changed Player settings**: If you don't use the command line to configure the setting, and you modify the setting's value in the Player settings, Unity uses those values. For example, in the Player settings, if you change **Fullscreen Mode**, **Default Screen Width**, or **Default Screen Height**, Unity will use those values to change the screen's full-screen mode and resolution at startup.
3.  **Stored PlayerPrefs**: If you don't specify a setting's value via command line or Player settings, Unity checks if the setting is stored in [PlayerPrefs](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerPrefs.html), and uses the setting if found.
4.  **Default Player settings**: Otherwise, Unity uses the original default Player settings as a fallback.

You can also implement your own logic, but Unity will only apply your logic after it starts to execute code.  
  
**Persistence of Screen settings**  
  
During gameplay, if the user changes the Screen settings, the settings will persist between launches. Unity writes these settings to [PlayerPrefs](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerPrefs.html), which saves these settings and stores them differently depending on the platform. Unity saves the following settings to [PlayerPrefs](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerPrefs.html):

-   Full-screen mode
-   Resolution (width and height)
-   Display and game window position

Unity saves the settings to [PlayerPrefs](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerPrefs.html) when any of the following situations occur:

-   The application or user moves the window.
-   The full-screen mode changes, either when you call [Screen.SetResolution](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen.SetResolution.html), or the user presses **Alt** + **Enter** on Windows or **Option** + **Enter** on Mac.
-   The render resolution changes, such as when you call [Screen.SetResolution](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen.SetResolution.html), the user drags the window to resize it, or the user moves the window to a display with a different DPI.

### Static Properties

| Property                                                                                                                                   | Description                                                                                              |
|--------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------|
| [autorotateToLandscapeLeft](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen-autorotateToLandscapeLeft.html)           | Enables auto-rotation to landscape left.                                                                 |
| [autorotateToLandscapeRight](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen-autorotateToLandscapeRight.html)         | Enables auto-rotation to landscape right.                                                                |
| [autorotateToPortrait](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen-autorotateToPortrait.html)                     | Enables auto-rotation to portrait.                                                                       |
| [autorotateToPortraitUpsideDown](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen-autorotateToPortraitUpsideDown.html) | Enables auto-rotation to portrait, upside down.                                                          |
| [brightness](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen-brightness.html)                                         | Indicates the current brightness of the screen.                                                          |
| [currentResolution](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen-currentResolution.html)                           | The current screen resolution (Read Only).                                                               |
| [cutouts](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen-cutouts.html)                                               | Returns a list of screen areas that do not display content (Read Only).                                  |
| [dpi](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen-dpi.html)                                                       | The current pixel density of the screen measured in dots-per-inch (DPI) (Read Only).                     |
| [fullScreen](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen-fullScreen.html)                                         | Enables full-screen mode for the application.                                                            |
| [fullScreenMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen-fullScreenMode.html)                                 | Set this property to one of the values in FullScreenMode to change the display mode of your application. |
| [height](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen-height.html)                                                 | The current height of the screen window in pixels (Read Only).                                           |
| [mainWindowDisplayInfo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen-mainWindowDisplayInfo.html)                   | The display information associated with the display that the main application window is on.              |
| [mainWindowPosition](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen-mainWindowPosition.html)                         | The position of the top left corner of the main window relative to the top left corner of the display.   |
| [msaaSamples](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen-msaaSamples.html)                                       | Get the requested MSAA sample count of the screen buffer.                                                |
| [orientation](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen-orientation.html)                                       | Specifies logical orientation of the screen.                                                             |
| [resolutions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen-resolutions.html)                                       | Returns all full-screen resolutions that the monitor supports (Read Only).                               |
| [safeArea](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen-safeArea.html)                                             | Returns the safe area of the screen in pixels (Read Only).                                               |
| [sleepTimeout](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen-sleepTimeout.html)                                     | A power saving setting, allowing the screen to dim some time after the last active user interaction.     |
| [width](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen-width.html)                                                   | The current width of the screen window in pixels (Read Only).                                            |

### Static Methods

| Method                                                                                                         | Description                                                                                                                                                                                                                        |
|----------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [GetDisplayLayout](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen.GetDisplayLayout.html) | Retrieves layout information about connected displays such as names, resolutions, and refresh rates.                                                                                                                               |
| [MoveMainWindowTo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen.MoveMainWindowTo.html) | Moves the main window to the specified position relative to the top left corner of the specified display. Position value is represented in pixels. Moving the window is an asynchronous operation, which can take multiple frames. |
| [SetMSAASamples](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen.SetMSAASamples.html)     | Sets the given number of MSAA samples for the screen buffer.                                                                                                                                                                       |
| [SetResolution](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen.SetResolution.html)       | Switches the screen resolution and refresh rate if supported.                                                                                                                                                                      |
