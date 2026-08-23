---
title: "Log files reference"
page_title: "Unity - Manual: Log files reference"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/log-files.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/log-files.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Log files reference

Unity produces log files for the Editor, package manager, licensing, development players, and Hub. You can use these log files to understand where any problems happened in your application.

Unity adds all messages, warnings, and errors from the [Console window](https://docs.unity3d.com/6000.3/Documentation/Manual/Console.html) to the log files. To add your own messages to the Console window, and the logs, use the [Debug class](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Debug.html).

Each operating system stores the log files in different locations. The default locations are outlined on this page, but you can also use certain command line arguments to control when and where Unity generates log files. For more information, see the [Command line arguments](https://docs.unity3d.com/6000.3/Documentation/Manual/EditorCommandLineArguments.html) documentation.

You can use the [Application.consoleLogPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-consoleLogPath.html) property in your project code to obtain the log location for the currently running Editor or Player application.

**Note:** Not all platforms support this feature. For more information, refer to [Platform development](https://docs.unity3d.com/6000.3/Documentation/Manual/PlatformSpecific.html).

## Editor-related log locations

You can access the Editor logs from the console window. To do this, open a Console Window (main menu: **Window** \> **General** \> **Console**) and select **Open Editor Log** from the Console window menu.

You can access the other logs by using your operating system’s file manager application.

### Linux

| **Log type**         | **Log location**                                       |
|:---------------------|:-------------------------------------------------------|
| **Editor**           | `~/.config/unity3d/Editor.log`                         |
| **Package manager**  | `~/.config/unity3d/upm.log`                            |
| **Licensing client** | `~/.config/unity3d/Unity/Unity.Licensing.Client.log`   |
| **Licensing audits** | `~/.config/unity3d/Unity/Unity.Entitlements.Audit.log` |

### macOS

On macOS, you can also access Unity’s logs via the Console.app utility

| **Log type**         | **Log location**                                    |
|:---------------------|:----------------------------------------------------|
| **Editor**           | `~/Library/Logs/Unity/Editor.log`                   |
| **Package manager**  | `~/Library/Logs/Unity/upm.log`                      |
| **Licensing client** | `~/Library/Logs/Unity/Unity.Licensing.Client.log`   |
| **Licensing audits** | `~/Library/Logs/Unity/Unity.Entitlements.Audit.log` |

### Windows

On Windows, the Package Manager and Editor logs are placed in folders which aren’t shown in the Windows Explorer by default. To view the AppData folder, you must enable the Hidden Items setting on Windows. For more information on how to do this, see Microsoft’s documentation on [View hidden files and folders in Windows](https://support.microsoft.com/en-us/windows/view-hidden-files-and-folders-in-windows-97fbc472-c603-9d90-91d0-1166d1d9f4b5).

On Windows, a standard out stream doesn’t exist by default, so you must launch the Editor with a valid configured `stdout` stream, as a child process from a CI system. If you specify `-` to send output\` `to`stdout\`, then you won’t see the output in the console window.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Log type</strong></th><th style="text-align: left;"><strong>Log location</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Editor</strong></td><td style="text-align: left;"><code>%LOCALAPPDATA%\Unity\Editor\Editor.log</code></td></tr><tr class="even"><td style="text-align: left;"><strong>Package manager</strong></td><td style="text-align: left;">User account: <code>%LOCALAPPDATA%\Unity\Editor\upm.log</code><br />
SYSTEM account: <code>%ALLUSERSPROFILE%\Unity\Editor\upm.log</code></td></tr><tr class="odd"><td style="text-align: left;"><strong>Licensing client</strong></td><td style="text-align: left;"><code>%LOCALAPPDATA%\Unity\Unity.Licensing.Client.log</code></td></tr><tr class="even"><td style="text-align: left;"><strong>Licensing audits</strong></td><td style="text-align: left;"><code>%LOCALAPPDATA%\Unity\Unity.Entitlements.Audit.log</code></td></tr><tr class="odd"><td style="text-align: left;"><strong>Crash files</strong></td><td style="text-align: left;"><code>%TMP%\Unity\Editor\Crashes</code><br />
<br />
<strong>Note:</strong> You can overwrite the location of the folder location with the <code>-crash-report-folder</code> command line argument.</td></tr></tbody></table>

<span id="player"></span>

## Player-related log locations

To view the Player log, open a Console Window (main menu: **Window** \> **General** \> **Console**) and select **Open Player Log** from the Console window menu. You can also navigate to the following folder:

<table><thead><tr class="header"><th style="text-align: left;"><strong>Operating system</strong></th><th style="text-align: left;"><strong>Player log location</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Android</strong></td><td style="text-align: left;">To access the Player log for an Android application, use <a href="https://developer.android.com/studio/command-line/logcat">Android logcat</a>. For more information, see <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/android-debugging-on-an-android-device.html#view-android-logs">View Android logs</a>.</td></tr><tr class="even"><td style="text-align: left;"><strong>iOS</strong></td><td style="text-align: left;">Use the GDB console, or the Organizer Console through XCode to access iOS device logs. For more information on device logs, see <a href="https://developer.apple.com/documentation/xcode/acquiring-crash-reports-and-diagnostic-logs">Apple’s documentation</a>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Linux</strong></td><td style="text-align: left;"><code>~/.config/unity3d/CompanyName/ProductName/Player.log</code></td></tr><tr class="even"><td style="text-align: left;"><strong>macOS</strong></td><td style="text-align: left;"><code>~/Library/Logs/Company Name/Product Name/Player.log</code><br />
<br />
<strong>Note:</strong> You can also use the Console.app utility to find the log file.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Universal Windows Platform</strong></td><td style="text-align: left;"><code>%USERPROFILE%\AppData\Local\Packages\&lt;productname&gt;\TempState\UnityPlayer.log</code></td></tr><tr class="even"><td style="text-align: left;"><strong>Web</strong></td><td style="text-align: left;">Unity writes the log output to your <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-debugging.html">browser’s JavaScript console</a>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Windows</strong></td><td style="text-align: left;"><code>%USERPROFILE%\AppData\LocalLow\CompanyName\ProductName\Player.log</code></td></tr></tbody></table>

### Player crash files (Windows only)

For the location of Player crash files on Windows, refer to [`CrashReporting.crashReportFolder`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Windows.CrashReporting-crashReportFolder.html).

## Unity Hub log locations

You can access the Hub logs by using your operating system’s file manager application. You can also access these logs from within the Hub. For more information, see [Hub documentation](https://docs.unity3d.com/hub/manual/Help.html).

| **Operating system** | **Player log location**                                     |
|:---------------------|:------------------------------------------------------------|
| **Linux**            | `~/.config/UnityHub/logs/info-log.json`                     |
| **macOS**            | `~/Library/Application Support/UnityHub/logs/info-log.json` |
| **Windows**          | `%UserProfile%\AppData\Roaming\UnityHub\logs\info-log.json` |

## Additional resources

-   [Console Window](https://docs.unity3d.com/6000.3/Documentation/Manual/Console.html)
-   [Stack trace logging](https://docs.unity3d.com/6000.3/Documentation/Manual/stack-trace.html)
