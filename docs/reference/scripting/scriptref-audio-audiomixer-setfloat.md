---
title: "Scripting API: Audio.AudioMixer.SetFloat"
page_title: "Unity - Scripting API: Audio.AudioMixer.SetFloat"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.AudioMixer.SetFloat.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.AudioMixer.SetFloat.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [AudioMixer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.AudioMixer.html).SetFloat

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

public bool <span class="sig-kw">SetFloat</span>(string <span class="sig-kw">name</span>, float <span class="sig-kw">value</span>);

### Parameters

| Parameter | Description                                                                                                                                                                                                                  |
|-----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| name      | The name of an exposed Audio Mixer group parameter. To expose a parameter, go to the Audio Mixer group's Inspector window, right click the parameter you want to expose, and choose **Expose \[parameter name\] to script**. |
| value     | Use to set the exposed Audio Mixer group parameter to a new value.                                                                                                                                                           |

### Returns

**bool** Returns false if the exposed parameter was not found or snapshots are currently being edited.

### Description

[AudioMixer.SetFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.AudioMixer.SetFloat.html) sets the value of the exposed parameter specified. Once you call this function, mixer snapshots will no longer control the exposed parameter, and you can only modify the parameter using [AudioMixer.SetFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.AudioMixer.SetFloat.html).

**Note:** Don’t call [AudioMixer.SetFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.AudioMixer.SetFloat.html) in the following event functions as it can result in unexpected behavior:

-   [MonoBehaviour.Awake](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Awake.html)
-   [MonoBehaviour.OnEnable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnEnable.html)
-   [RuntimeInitializeLoadType.AfterSceneLoad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeLoadType.AfterSceneLoad.html)

Instead, call [AudioMixer.SetFloat](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.AudioMixer.SetFloat.html) in [MonoBehaviour.Start](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Start.html) or any event function Unity calls afterwards in [Order of execution for event functions](https://docs.unity3d.com/6000.3/Documentation/Manual/execution-order.html).  
  
To see your exposed parameters,

1.  Double click on your audio mixer. This opens the **Audio Mixer** window.
2.  At the top right of the Audio Mixer tab, click on the **Exposed Parameters** button to show the list of exposed parameters.

To rename or remove a parameter, right click the item in the list.  
  
If the parameter you want to expose isn't in the list, you need to expose the parameter. To expose a parameter, right click the parameter you want to expose in the Audio Mixer Inspector window, and choose **Expose \[parameter name\] to script**.

``` codeExampleCS
using System;
using UnityEngine;
using UnityEngine.Audio;

public class MixerVolumeController : MonoBehaviour

        previousVolume = volume;
    }

    void OnGUI()
    
        GUILayout.EndHorizontal();
    }
}
```
