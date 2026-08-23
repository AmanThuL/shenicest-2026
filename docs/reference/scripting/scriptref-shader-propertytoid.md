---
title: "Scripting API: Shader.PropertyToID"
page_title: "Unity - Scripting API: Shader.PropertyToID"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Shader.PropertyToID.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Shader.PropertyToID.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Shader](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Shader.html).PropertyToID

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Shader.html" class="switch-link gray-btn sbtn left show" title="Go to Shader Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public static int <span class="sig-kw">PropertyToID</span>(string <span class="sig-kw">name</span>);

### Parameters

| Parameter | Description           |
|-----------|-----------------------|
| name      | Shader property name. |

### Returns

**int** Unique integer for the name.

### Description

Gets unique identifier for a shader property name.

Using property identifiers is more efficient than passing strings to all material property functions. For example if you are calling [Material.SetColor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.SetColor.html) a lot, or using [MaterialPropertyBlock](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.html), then it is better to get the identifiers of the properties you need just once.  
  
Each name of shader property (for example, `_MainTex` or `_Color`) is assigned an unique integer number in Unity, that stays the same for the whole game. The numbers will not be the same between different runs of the game or between machines, so do not store them or send them over network.  
  
Additional resources: [Material](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Material.html), [MaterialPropertyBlock](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MaterialPropertyBlock.html).
