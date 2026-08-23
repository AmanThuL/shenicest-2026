---
title: "Scripting API: Application.dataPath"
page_title: "Unity - Scripting API: Application.dataPath"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-dataPath.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-dataPath.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Application](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application.html).dataPath

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

<span style="color:red;"> </span>public static string <span class="sig-kw">dataPath</span>;

### Description

Contains the path to the game data folder on the target device (Read Only).

The value depends on which platform you are running on:  
  
**Unity Editor:** \<*path to project folder*\>/Assets  
  
**Mac player:** \<*path to player app bundle*\>/Contents  
  
**iOS player:** \<*path to player app bundle*\>/\<*AppName.app*\>/Data (this folder is read only, use [Application.persistentDataPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-persistentDataPath.html) to save data).  
  
**Win/Linux player:** \<*path to executablename_Data folder*\> (note that most Linux installations will be case-sensitive!)  
  
**WebGL:** The absolute url to the player data file folder (without the actual data file name)  
  
**Android:** Normally it points directly to the APK. If you are running a split binary build, it points to the [OBB](https://docs.unity3d.com/6000.3/Documentation/Manual/android-OBBsupport.html) instead.  
  
**UWP Apps:** The absolute path to the player data folder (this folder is read only, use [Application.persistentDataPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application-persistentDataPath.html) to save data)  
  
Note that the string returned on a PC will use a forward slash as a folder separator.  
  
For any unlisted platform, run the example script on the target platform to find the dataPath location in the debug log.

``` codeExampleCS
//Attach this script to a GameObject
//This script outputs the Application’s path to the Console
//Run this on the target device to find the application data path for the platform
using UnityEngine;

public class Example : MonoBehaviour

}
```
