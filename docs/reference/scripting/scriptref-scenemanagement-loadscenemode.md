---
title: "Scripting API: SceneManagement.LoadSceneMode"
page_title: "Unity - Scripting API: LoadSceneMode"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.LoadSceneMode.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.LoadSceneMode.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# LoadSceneMode

enumeration

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

Used when loading a Scene in a player.

Use LoadSceneMode to choose what type of Scene loads when using [SceneManager.LoadScene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.LoadScene.html). The available modes are Single and Additive.  
  
Single mode loads a standard Unity Scene which then appears on its own in the Hierarchy window. Additive loads a Scene which appears in the Hierarchy window while another is active.

``` codeExampleCS
using UnityEngine;
using UnityEngine.SceneManagement;

public class Example : MonoBehaviour

        //Whereas pressing this Button loads the Additive Scene.
        if (GUI.Button(new Rect(20, 60, 150, 30), "Other Scene Additive"))
        
    }
}
```

### Properties

| Property                                                                                                              | Description                                         |
|-----------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------|
| [Single](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.LoadSceneMode.Single.html)     | Closes all current loaded Scenes and loads a Scene. |
| [Additive](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.LoadSceneMode.Additive.html) | Adds the Scene to the current loaded Scenes.        |
