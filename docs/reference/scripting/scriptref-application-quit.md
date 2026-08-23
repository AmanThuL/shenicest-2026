---
title: "Scripting API: Application.Quit"
page_title: "Unity - Scripting API: Application.Quit"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application.Quit.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application.Quit.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Application](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Application.html).Quit

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

## Declaration

public static void <span class="sig-kw">Quit</span>();

### Parameters

| Parameter | Description                                                                                                      |
|-----------|------------------------------------------------------------------------------------------------------------------|
| exitCode  | An optional exit code to return when the player application terminates on Windows, Mac and Linux. Defaults to 0. |

### Description

Quits the player application.

Shut down the running application. The Application.Quit call is ignored in the Editor.  
  
If you want to use `Application.Quit` when running Unity inside another application, refer to [Unity as a Library](https://docs.unity3d.com/6000.3/Documentation/Manual/UnityasaLibrary.html) documentation.  
  
On the Web platform, `Application.Quit` stops the Web Player but doesn't affect the web page front end. For ways to implement `Application.Quit` and manage resource cleanup, refer to examples in the [web templates](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl-templates.html).  
  
Android and iOS platforms have their own dedicated interfaces to hide and close applications, which might be the preferred way to close applications for some users. Therefore, it's not recommended to create your own way of shutting down with `Application.Quit` to prevent inconsistent user experience between your application and these platform interfaces. If you must programmatically quit an Android application, you can instead move the application to the background via [Activity.moveTaskToBack](https://developer.android.com/reference/android/app/Activity#moveTaskToBack(boolean)). For more information, refer to [Quit a Unity Android application](https://docs.unity3d.com/6000.3/Documentation/Manual/android-quit.html).  
  
For iOS platform, in most cases the termination of application should be left at the user's discretion. Calling `Application.Quit` method in iOS Player might appear to the user that the application has crashed. For more information, refer to [Apple Technical Page qa1561](https://developer.apple.com/library/archive/qa/qa1561/_index.html).

``` codeExampleCS
using UnityEngine;
using System.Collections;

// Quits the player when the user hits escape

public class ExampleClass : MonoBehaviour

    }
}
```
