---
title: "Scripting API: EditorApplication.playModeStateChanged"
page_title: "Unity - Scripting API: EditorApplication.playModeStateChanged"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorApplication-playModeStateChanged.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorApplication-playModeStateChanged.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [EditorApplication](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorApplication.html).playModeStateChanged

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

Event that is raised whenever the Editor's play mode state changes.

Add an event handler to this event to receive a notification that the play mode state has changed, as well as information about the state it has changed into.  
  
The following example script logs the Editor's play mode state to the console whenever if changes. Copy it into a file called PlayModeStateChangedExample.cs and put it in a folder called Editor.

``` codeExampleCS
using UnityEngine;
using UnityEditor;

// ensure class initializer is called whenever scripts recompile
[InitializeOnLoadAttribute]
public static class PlayModeStateChangedExample

    private static void LogPlayModeState(PlayModeStateChange state)
    
}
```

Additional resources: [PlayModeStateChange](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayModeStateChange.html), [EditorApplication.isPlaying](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorApplication-isPlaying.html), [EditorApplication.pauseStateChanged](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorApplication-pauseStateChanged.html).
