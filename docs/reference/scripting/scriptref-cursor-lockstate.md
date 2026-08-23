---
title: "Scripting API: Cursor.lockState"
page_title: "Unity - Scripting API: Cursor.lockState"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Cursor-lockState.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Cursor-lockState.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Cursor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Cursor.html).lockState

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

<span style="color:red;"> </span>public static [CursorLockMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CursorLockMode.html) <span class="sig-kw">lockState</span>;

### Description

Determines whether the hardware pointer is locked to the center of the view, constrained to the window, or not constrained at all.

A locked cursor is positioned in the center of the view and cannot be moved. The cursor is invisible in this state, regardless of the value of [Cursor.visible](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Cursor-visible.html). **Note**: Locking the cursor prevents the user from interacting with UI elements.  
  
A confined cursor behaves normally, but it is confined to the view. For example, if the application is running in a window, then a confined cursor cannot leave that window. The confined cursor mode is only supported on Windows and Linux standalone builds. **Important:** In Linux Editor environments that use Wayland, the mouse might become unlocked if the main thread is blocked for too long.  
  
The recommended best practice is to only lock or confine the cursor because of a user's action, such as pressing a button.  
  
The cursor state can be changed by the operating system or the Editor. For example, check the state of the cursor when the application regains focus or the state of a game changes to reveal a UI.  
  
In the Editor, the cursor loses focus in Game mode when you press Escape or when you switch an application. In the Standalone Player, you have full control over the mouse cursor, but if you switch applications, the cursor goes out of focus.

``` codeExampleCS
using UnityEngine;

public class CursorLockExample : MonoBehaviour

    void OnGUI()
    
        //Press this button to confine the Cursor within the screen
        if (GUI.Button(new Rect(125, 0, 100, 50), "Confine Cursor"))
        
    }
}
```
