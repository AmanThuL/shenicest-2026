---
title: "Scripting API: AudioSource.spatialBlend"
page_title: "Unity - Scripting API: AudioSource.spatialBlend"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-spatialBlend.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource-spatialBlend.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [AudioSource](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.html).spatialBlend

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

<span style="color:red;"> </span>public float <span class="sig-kw">spatialBlend</span>;

### Description

Sets how much this AudioSource is affected by 3D spatialisation calculations (attenuation, doppler etc). 0.0 makes the sound full 2D, 1.0 makes it full 3D.

Aside from determining if this AudioSource is heard as a 2D or 3D source, this property is useful to morph between the two modes.  
  
3D spatial calculations are applied after stereo panning is determined and can be used in conjunction with panStereo.  
  
Morphing between the 2 modes is useful for sounds that should be progressively heard as normal 2D sounds the closer they are to the listener.
