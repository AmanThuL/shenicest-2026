---
title: "Scripting API: AudioSource.PlayOneShot"
page_title: "Unity - Scripting API: AudioSource.PlayOneShot"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.PlayOneShot.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.PlayOneShot.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [AudioSource](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.html).PlayOneShot

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

public void <span class="sig-kw">PlayOneShot</span>([AudioClip](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioClip.html) <span class="sig-kw">clip</span>, float <span class="sig-kw">volumeScale</span> = 1.0F);

### Parameters

| Parameter   | Description                                                                                                                     |
|-------------|---------------------------------------------------------------------------------------------------------------------------------|
| clip        | The clip being played.                                                                                                          |
| volumeScale | The scale of the volume. Unity automatically clamps negative scales to zero. Note: Scales larger than one might cause clipping. |

### Description

Plays an [AudioClip](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioClip.html), and scales the [AudioSource](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.html) volume by volumeScale.

[AudioSource.PlayOneShot](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.PlayOneShot.html) does not cancel clips that are already being played by [AudioSource.PlayOneShot](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.PlayOneShot.html) and [AudioSource.Play](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.Play.html). For more information on how this method differs from [AudioSource.Play](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.Play.html), see [AudioSource](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.html).

``` codeExampleCS
using UnityEngine;
using System.Collections;

[RequireComponent(typeof(AudioSource))]
public class ExampleClass : MonoBehaviour

    void OnCollisionEnter()
    
}
```

Additional resources: [AudioSource.Play](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.Play.html).
