---
title: "Scripting API: Object.DontDestroyOnLoad"
page_title: "Unity - Scripting API: Object.DontDestroyOnLoad"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DontDestroyOnLoad.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DontDestroyOnLoad.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html).DontDestroyOnLoad

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html" class="switch-link gray-btn sbtn left show" title="Go to Object Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public static void <span class="sig-kw">DontDestroyOnLoad</span>([Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html) <span class="sig-kw">target</span>);

### Parameters

| Parameter | Description                                                                                                                          |
|-----------|--------------------------------------------------------------------------------------------------------------------------------------|
| target    | An Object not destroyed on [Scene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.Scene.html) change. |

### Description

Do not destroy the target Object when loading a new [Scene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.Scene.html).

The load of a new [Scene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.Scene.html) destroys all current [Scene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.Scene.html) objects. Call [Object.DontDestroyOnLoad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DontDestroyOnLoad.html) to preserve an Object during scene loading. If the target Object is a component or [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html), Unity also preserves all of the [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html)’s children. [Object.DontDestroyOnLoad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DontDestroyOnLoad.html) only works for root GameObjects or components on root GameObjects. [Object.DontDestroyOnLoad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DontDestroyOnLoad.html) does not return a value.  
  
The following example script uses [Object.DontDestroyOnLoad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DontDestroyOnLoad.html). The example has `scene1` which starts playing background music from an [AudioSource](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.html). The music continues when `scene2` loads. Switch between scenes using a button.  
  
To implement this example, create two new [Scene](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SceneManagement.Scene.html)s, named `scene1` and `scene2`. Open `scene1` and add the `SceneSwap.cs` script to an empty [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) and name it `Menu`. Next, add `DontDestroy.cs` to a new [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) and name it `BackgroundMusic`. Add an [AudioSource](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.html) to `BackgroundMusic` - `Add Component > Audio > Audio Source` - and import an [AudioClip](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioClip.html) into your Project. Assign the [AudioClip](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioClip.html) to the [AudioSource](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.html)’s [AudioClip](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioClip.html) field. Create a tag, call it `music`, and add it to `BackgroundMusic`. Switch to `scene2`. Again add `SceneSwap.cs` to a new [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) and name it `Menu`. Save the Project. Return to `scene1` and run the Project from the `Editor`.  
  
`SceneSwap.cs` script:

``` codeExampleCS
using UnityEngine;
using UnityEngine.SceneManagement;

// Object.DontDestroyOnLoad example.
//
// Two scenes call each other. This happens when OnGUI button is clicked.
// scene1 will load scene2; scene2 will load scene1. Both scenes have
// the Menu GameObject with the SceneSwap.cs script attached.
//
// AudioSource plays an AudioClip as the game runs. This is on the
// BackgroundMusic GameObject which has a music tag.  The audio
// starts in AudioSource.playOnAwake. The DontDestroy.cs script
// is attached to BackgroundMusic.

public class SceneSwap : MonoBehaviour

        }
        else
        
        }
    }
}
```

`DontDestroy.cs` script:

``` codeExampleCS
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Object.DontDestroyOnLoad example.
//
// This script example manages the playing audio. The GameObject with the
// "music" tag is the BackgroundMusic GameObject. The AudioSource has the
// audio attached to the AudioClip.

public class DontDestroy : MonoBehaviour

        DontDestroyOnLoad(this.gameObject);
    }
}
```
