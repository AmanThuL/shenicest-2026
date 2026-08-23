---
title: "Scripting API: AudioSource.Play"
page_title: "Unity - Scripting API: AudioSource.Play"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.Play.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.Play.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [AudioSource](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.html).Play

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioSource.html" class="switch-link gray-btn sbtn left show" title="Go to AudioSource Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">Play</span>(ulong <span class="sig-kw">delay</span> = 0);

### Parameters

| Parameter | Description                                                                                                                                |
|-----------|--------------------------------------------------------------------------------------------------------------------------------------------|
| delay     | Deprecated. Delay in number of samples, assuming a 44100Hz sample rate (meaning that Play(44100) will delay the playing by exactly 1 sec). |

### Description

Plays the [clip](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-clip.html).

The delay parameter is deprecated, please use the newer [AudioSource.PlayDelayed](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.PlayDelayed.html) function instead which specifies the delay in seconds.  
  
If [AudioSource.clip](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-clip.html) is set to the same clip that is playing then the clip will sound like it is re-started. [AudioSource](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.html) will assume any [Play](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.Play.html) call will have a new audio clip to play.  
  
**Note:** The [AudioSource.PlayScheduled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.PlayScheduled.html) API will give you more accurate control over when the audio clip is played.  
  
For a list of audio file types Unity supports, refer to [Audio Clip](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioClip.html).

``` codeExampleCS
using UnityEngine;

// The Audio Source component has an AudioClip option.  The audio
// played in this example comes from AudioClip and is called audioData.

[RequireComponent(typeof(AudioSource))]
public class ExampleScript : MonoBehaviour

    void OnGUI()
    
        if (GUI.Button(new Rect(10, 170, 150, 30), "Continue"))
        
    }
}
```

Additional resources: [Stop](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.Stop.html), [Pause](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.Pause.html), [clip](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-clip.html) and [PlayScheduled](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.PlayScheduled.html) functions.
