---
title: "Profiler command line arguments"
page_title: "Unity - Manual: Profiler command line arguments"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-command-line-arguments.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-command-line-arguments.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Profiler command line arguments

Set how the Profiler starts from the command line.

If you start your built player or the Unity Editor from the command line (such as the Command Prompt on Windows, Terminal on macOS, Linux shell, or adb for Android), you can pass command line arguments to configure some Profiler settings. For more information about starting Unity from the command line, refer to [Command line arguments](https://docs.unity3d.com/6000.3/Documentation/Manual/CommandLineArguments.html).

<table><thead><tr class="header"><th style="text-align: left;"><strong>Command line argument</strong></th><th style="text-align: left;"><strong>Description</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><code>-profiler-enable</code></td><td style="text-align: left;">Profile the start-up of a player or the Editor.<br />
<br />
When you use this argument with a player, it has the same effect as building the player with the <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-build-settings-reference.html">Autoconnect Profiler</a> setting enabled.<br />
<br />
When you use this argument with the Editor, it starts collecting and displaying Profiler information in the Profiler window on start-up of the Editor.</td></tr><tr class="even"><td style="text-align: left;"><code>-profiler-log-file &lt;Path/To/Log/File.raw&gt;</code></td><td style="text-align: left;">Stream profile data to a .raw file on startup. This argument works for both players and the Editor.</td></tr><tr class="odd"><td style="text-align: left;"><code>-profiler-capture-frame-count &lt;NumberOfFrames&gt;</code></td><td style="text-align: left;">Set how many frames to capture in a profile when streaming to a .raw file on start-up. This argument only works on players.</td></tr><tr class="even"><td style="text-align: left;"><code>-profiler-maxusedmemory</code></td><td style="text-align: left;">Set a maximum amount of memory in bytes for the Profiler to use at start up (for example, <code>-profiler-maxusedmemory 16777216</code>). By default, <code>maxUsedMemory</code> is 16MB for players and 256MB for the Editor.</td></tr><tr class="odd"><td style="text-align: left;"><code>-connection-id</code></td><td style="text-align: left;">Set a custom player name set when you launch a player from the command line. You can also set this name in the <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-preferences-reference.html">Profiler Preferences window</a>.</td></tr></tbody></table>

## Additional resources

-   [Profiling your application](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-profiling-applications.html)
-   [Profiler Preferences reference](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-preferences-reference.html)
-   [Profiler Build Profiles settings reference](https://docs.unity3d.com/6000.3/Documentation/Manual/profiler-build-settings-reference.html)
