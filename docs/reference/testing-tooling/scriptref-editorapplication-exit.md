---
title: "EditorApplication.Exit (Scripting API)"
page_title: "Unity - Scripting API: EditorApplication.Exit"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorApplication.Exit.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorApplication.Exit.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [EditorApplication](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorApplication.html).Exit

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

public static void <span class="sig-kw">Exit</span>(int <span class="sig-kw">returnValue</span>);

### Description

Exit the Unity editor application.

Calling this function will exit right away, without asking to save changes, so you may lose data! This function is mostly useful for exiting out of a commandline process with a specific error.  
  
  
Additional resources: [Unity command line arguments](https://docs.unity3d.com/6000.3/Documentation/Manual/CommandLineArguments.html).

``` codeExampleCS
// Simple script that lets you create a new
// Scene, create a cube and an empty game object in the Scene
// Save the Scene and close the editor

using UnityEditor;
using UnityEditor.SceneManagement;

public class ExampleClass

}
```
