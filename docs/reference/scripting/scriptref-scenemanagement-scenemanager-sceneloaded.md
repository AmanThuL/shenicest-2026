---
title: "Scripting API: SceneManagement.SceneManager.sceneLoaded"
page_title: "Unity - Scripting API: SceneManagement.SceneManager.sceneLoaded"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager-sceneLoaded.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager-sceneLoaded.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [SceneManager](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.SceneManager.html).sceneLoaded

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

### Parameters

| Parameter | Description                                                                                                                                                                                                                                                 |
|-----------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| value     | A method with the signature MyMethod([Scene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.Scene.html), [LoadSceneMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.LoadSceneMode.html)). |

### Description

Assign a custom callback to this event to get notifications when a Scene has loaded.

Create a custom callback method to receive the notification and assign it to the `SceneManager.sceneLoaded` event. The callback must have the required signature, taking a [Scene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.Scene.html) and a [LoadSceneMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.LoadSceneMode.html) as input parameters.  
  
The code example below defines a custom calllback method called `OnSceneLoaded` with the required signature. It assigns `OnSceneLoaded` to `SceneManager.sceneLoaded` in the `OnEnable` callback and unassigns it in the `OnDisable` callback.  
  
The code example and comment annotations demonstrate the execution order of the callbacks. Unity raises the `SceneManager.sceneLoaded` event and invokes the associated callback after `OnEnable` but before `Start`.  
  
Additional resources: [Details of disabling domain and scene reload](https://docs.unity3d.com/6000.3/Documentation/Manual/configurable-enter-play-mode-details.html)

``` codeExampleCS
using UnityEngine;
using UnityEngine.SceneManagement;

public class ExampleCode : MonoBehaviour

    // called second
    void OnEnable()
    
    // called third
    void OnSceneLoaded(Scene scene, LoadSceneMode mode)
    
    // called fourth
    void Start()
    
    // called when the game is terminated
    void OnDisable()
    
}
```
