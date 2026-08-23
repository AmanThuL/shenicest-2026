---
title: "Scripting API: Renderer.sharedMaterial"
page_title: "Unity - Scripting API: Renderer.sharedMaterial"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-sharedMaterial.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-sharedMaterial.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Renderer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer.html).sharedMaterial

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

<span style="color:red;"> </span>public [Material](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.html) <span class="sig-kw">sharedMaterial</span>;

### Description

The shared material of this object.

Modifying `sharedMaterial` will change the appearance of all objects using this material, and change material settings that are stored in the project too.  
  
It is not recommended to modify materials returned by sharedMaterial. If you want to modify the material of a renderer use [material](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-material.html) instead.  
  
Additional resources: [material](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-material.html) property.
