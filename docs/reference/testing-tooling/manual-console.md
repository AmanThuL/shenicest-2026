---
title: "Unity 6.3 Manual: Console window reference"
page_title: "Unity - Manual: Console window reference"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/Console.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/Console.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Console window reference

The **Console** window displays errors, warnings, and other messages the Editor generates. These errors and warnings help you find issues in your project, such as script compilation errors. They also alert you to actions the Editor has taken automatically, such as replacing missing meta files, which could cause an issue somewhere else in your project.

To help you debug your project, use the [Debug](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Debug.html) class to print your own messages to the Console. For example, you can print the value of a variable at certain points in your script to see how they change.

This page covers the options you can use when you work with the Console window, and how you can filter your messages by searching for specific keywords.

## Console window interface

To open the Console, from Unity’s main menu go to **Window** \> **General** \> **Console**.

![The Console window displays a series of error messages and a warning.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/Console.png)

**A**. The Console **toolbar** has options for controlling how to display messages, and for [searching and filtering](https://docs.unity3d.com/6000.3/Documentation/Manual/Console.html#search) messages.

**B**. The Console window menu has options for [opening Log files](https://docs.unity3d.com/6000.3/Documentation/Manual/Console.html#log-file), controlling [how much of each message](https://docs.unity3d.com/6000.3/Documentation/Manual/Console.html#line-count) is visible in the list, and setting stack trace options.

**C**. The Console list displays an entry for each logged message. Select a message to display its entire text in the detail area. You can choose how many lines of each message to display here. See [Adjusting the line count](https://docs.unity3d.com/6000.3/Documentation/Manual/Console.html#line-count), below.

**D**. The detail area displays the full text of the selected message. If you enable stack trace, the detail area displays references to specific lines in code files as clickable links.

## Console toolbar options

The toolbar of the Console window has options for controlling how to display messages, and for searching and filtering messages.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Option</strong>:</th><th style="text-align: left;"></th><th style="text-align: left;"><strong>Function</strong>:</th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Clear</strong></td><td style="text-align: left;"></td><td style="text-align: left;">Removes any messages generated from your code but retains compiler errors.<br />
<br />
Opens a dropdown menu with clearing options.</td></tr><tr class="even"><td style="text-align: left;"></td><td style="text-align: left;">Clear On Play</td><td style="text-align: left;">Clears the Console automatically whenever you enter Play mode.</td></tr><tr class="odd"><td style="text-align: left;"></td><td style="text-align: left;">Clear on Build</td><td style="text-align: left;">Clears the Console when you build the Project.</td></tr><tr class="even"><td style="text-align: left;"></td><td style="text-align: left;">Clear on Recompile</td><td style="text-align: left;">Clears the console when you recompile the Project.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Collapse</strong></td><td style="text-align: left;"></td><td style="text-align: left;">Displays only the first instance of recurring error messages.<br />
<br />
This is useful for run-time errors, such as null references, that are sometimes generated on each frame update.</td></tr><tr class="even"><td style="text-align: left;"><strong>Error Pause</strong></td><td style="text-align: left;"></td><td style="text-align: left;">Pauses playback whenever you call <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.LogError.html"><code>Debug.LogError</code></a> from a script.<br />
<br />
Use this to freeze playback at a specific point in the execution and inspect the Scene. This option doesn’t pause playback when you call <a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.Log.html"><code>Debug.Log</code></a> from a script.</td></tr><tr class="odd"><td style="text-align: left;"><strong>[Attach-to-Player]</strong></td><td style="text-align: left;"></td><td style="text-align: left;">Opens a drop-down menu with options for connecting to development builds that are running on remote devices, and displaying their Player logs in the Console.<br />
<br />
This option is labeled with the name of the target development build (which is the build of the log that’s displayed in the Console window). If the Console isn’t connected to a remote build, it’s labeled <strong>Editor</strong> to show that the log displayed in the Console window is from the local Unity Editor.</td></tr><tr class="even"><td style="text-align: left;"></td><td style="text-align: left;">Player Logging</td><td style="text-align: left;">If the Console is connected to a remote development build, this enables Player logging for the build.<br />
<br />
Disabling this option suspends logging, but the Console remains connected to the target build.<br />
<br />
Disabling this option also hides the rest of the options in this drop-down menu.<br />
<br />
Select any build listed below <strong>Player Logging</strong> to display its log in the Console window.</td></tr><tr class="odd"><td style="text-align: left;"></td><td style="text-align: left;">Editor</td><td style="text-align: left;">If the Console is connected to a remote <strong>development build</strong>, select this option to display the log from the local Unity Player instead of the log from the remote build.</td></tr><tr class="even"><td style="text-align: left;"></td><td style="text-align: left;"><code>&lt;Enter IP&gt;</code></td><td style="text-align: left;">Opens the <strong>Enter Player IP</strong> dialog, where you can specify the IP address of a development build on a remote device.<br />
<br />
To connect to the build, select <strong>Connect</strong> in the dialog, and add it to the list of development builds at the bottom of the drop-down menu.</td></tr><tr class="odd"><td style="text-align: left;"></td><td style="text-align: left;">[DEVELOPMENT BUILDS]</td><td style="text-align: left;">Lists the available development builds. This includes autodetected builds, and those that you add using the <strong>Enter IP</strong> option.</td></tr></tbody></table>

## <span id="search"></span> Searching and filtering Console output

You can search Console messages for specific keywords from the Console search bar. As you type a search term, the Console filters messages to display only those that contain matching text. The Console highlights only the first match in the message text, and only if it’s in the visible part of the message (see [Adjusting the Line Count](https://docs.unity3d.com/6000.3/Documentation/Manual/Console.html#line-count) below).

![Searching for the term “name” highlights the first match in each message](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/ConsoleSearch.png)

You can search for anything that appears in any Console message, including numerals and special characters. For example, you can search for the time the console logged a message.

The search looks for exact matches of whatever you type in the search bar. You can’t search for two different terms at once, or use common search engine operators.

You can also filter Console messages by type. Click the buttons beside the search bar to toggle:

<table><thead><tr class="header"><th style="text-align: left;"><strong>Button</strong></th><th style="text-align: left;"><strong>Function</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><img src="https://docs.unity3d.com/6000.3/Documentation/uploads/Main/ConsoleFilterMessage.png" alt="Messages switch" /><br />
<br />
<strong>Messages switch</strong></td><td style="text-align: left;">Displays the number of messages in the Console. Click to display or hide messages.</td></tr><tr class="even"><td style="text-align: left;"><img src="https://docs.unity3d.com/6000.3/Documentation/uploads/Main/ConsoleFilterWarning.png" alt="Warnings switch" /><br />
<br />
<strong>Warnings switch</strong></td><td style="text-align: left;">Displays the number of warnings in the Console. Click to display or hide warnings.</td></tr><tr class="odd"><td style="text-align: left;"><img src="https://docs.unity3d.com/6000.3/Documentation/uploads/Main/ConsoleFilterError.png" alt="Errors switch" /><br />
<br />
<strong>Errors switch</strong></td><td style="text-align: left;">Displays the number of errors in the Console. Click to display or hide errors.</td></tr></tbody></table>

## <span id="line-count"></span> Adjusting the line count

Each Console entry can be up to 10 lines long.

To control how many lines of each entry are visible in the list, click the Console menu button, and select **Log Entry** \> **\[X\] Lines** from the menu, where **\[X\]** is the number of lines to display for each entry.

![Log entry line count](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/ConsoleAdjustLineCount.png)

A larger line count displays more of the text of each entry, but reduces the number of entries visible at any given time. The line count doesn’t affect the Console search function, which always searches the full message text. If the matching text is on a hidden line, the search returns the message in the results, but doesn’t expand it to reveal or highlight the matching text. You can see the full message text in the detail area, but the matching text isn’t highlighted there.

## Stack trace logging

Unity Console messages and log files can include detailed stack trace information. You can control the amount of stack trace information using the [stack trace logging](https://docs.unity3d.com/6000.3/Documentation/Manual/stack-trace.html) settings.

## <span id="log-file"></span> Opening Log files from the Console

Everything Unity or your code write to the Console Window is also written to a [Log File](https://docs.unity3d.com/6000.3/Documentation/Manual/log-files.html). You can open Log files from the Console window menu. Select **Open Player Log** or **Open Editor Log**.
