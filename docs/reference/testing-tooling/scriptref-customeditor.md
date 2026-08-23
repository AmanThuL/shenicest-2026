---
title: "Scripting API: CustomEditor"
page_title: "Unity - Scripting API: CustomEditor"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CustomEditor.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CustomEditor.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# CustomEditor

class in UnityEditor

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

Tells an [Editor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.html) class which run-time type it's an editor for.

When you make a custom editor for a component, put this attribute on the editor class.  
  
To set which `Editor` classes are active for the current Render Pipeline Asset, add a [SupportedOnRenderPipelineAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.SupportedOnRenderPipelineAttribute.html) underneath the attribute.  
  
Additional resources: [Editor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.html) class, [SupportedOnRenderPipelineAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Rendering.SupportedOnRenderPipelineAttribute.html).

### Properties

| Property                                                                                                 | Description                                                                                  |
|----------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|
| [isFallback](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CustomEditor-isFallback.html) | If true, match this editor only if all non-fallback editors do not match. Defaults to false. |

### Constructors

| Constructor                                                                                          | Description                                                 |
|------------------------------------------------------------------------------------------------------|-------------------------------------------------------------|
| [CustomEditor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CustomEditor-ctor.html) | Defines which object type the custom editor class can edit. |
