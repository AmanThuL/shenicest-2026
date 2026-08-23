---
title: "Scripting API: Screen.SetResolution"
page_title: "Unity - Scripting API: Screen.SetResolution"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen.SetResolution.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen.SetResolution.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Screen](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen.html).SetResolution

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

public static void <span class="sig-kw">SetResolution</span>(int <span class="sig-kw">width</span>, int <span class="sig-kw">height</span>, bool <span class="sig-kw">fullscreen</span>);

<span style="color:red;"> </span>

## Declaration

public static void <span class="sig-kw">SetResolution</span>(int <span class="sig-kw">width</span>, int <span class="sig-kw">height</span>, [FullScreenMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/FullScreenMode.html) <span class="sig-kw">fullscreenMode</span>);

<span style="color:red;"> </span>

## Declaration

public static void <span class="sig-kw">SetResolution</span>(int <span class="sig-kw">width</span>, int <span class="sig-kw">height</span>, [FullScreenMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/FullScreenMode.html) <span class="sig-kw">fullscreenMode</span>, [RefreshRate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RefreshRate.html) <span class="sig-kw">preferredRefreshRate</span>);

### Description

Switches the screen resolution and refresh rate if supported.

A `width` by `height` resolution is used. If no matching resolution is supported, the closest one is set.  
If the `preferredRefreshRate` parameter is specified but no matching refresh rate is supported, the highest available is set. Changing the refresh rate is only supported when using exclusive full-screen mode.  
  
**Android**:

-   **Android 10 and older:** The `fullscreen` parameter controls the `SYSTEM_UI_FLAG_IMMERSIVE_STICKY`, `SYSTEM_UI_FLAG_LAYOUT_STABLE`, `SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN`, `SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION`, `SYSTEM_UI_FLAG_HIDE_NAVIGATION`, and `SYSTEM_UI_FLAG_FULLSCREEN` flags using [View.setSystemUiVisibility](https://developer.android.com/reference/android/view/View#setSystemUiVisibility(int)) method.
-   **Android 11 and newer:** When `fullscreen` is true, `WindowInsetsController.hide(WindowInsets.Type.navigationBars())` is called and when `fullscreen` is false, `WindowInsetsController.show(WindowInsets.Type.navigationBars())` is called. For more information, refer to Android documentation on [WindowInsetsController](https://developer.android.com/reference/android/view/WindowInsetsController).

**Usage details**:

-   To set a specific full-screen mode on a desktop platform, use the method overload that accepts the `FullScreenMode` parameter. Exclusive full-screen mode is only supported on Windows standalone Player.
-   If you use [multi-display](https://docs.unity3d.com/6000.3/Documentation/Manual/MultiDisplay.html), you can only use `Screen.SetResolution` to set the resolution of the primary screen.
-   A resolution change is applied at the end of the current frame and not immediately.
-   In the Editor, it affects only the Game view's resolution.

Examples:

``` codeExampleCS
using UnityEngine;

public class ExampleScript : MonoBehaviour

}
```

``` codeExampleCS
using UnityEngine;

public class ExampleScript : MonoBehaviour
{
    void Start()
    {
        // Switch to 640 x 480 full-screen at 60 hz
        Screen.SetResolution(640, 480, FullScreenMode.ExclusiveFullScreen, new RefreshRate() { numerator = 60, denominator = 1 });
    }
}
```

``` codeExampleCS
using UnityEngine;

public class ExampleScript : MonoBehaviour

}
```

Additional resources: [resolutions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Screen-resolutions.html) property.
