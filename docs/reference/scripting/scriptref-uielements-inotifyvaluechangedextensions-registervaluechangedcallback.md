---
title: "Scripting API: UIElements.INotifyValueChangedExtensions.RegisterValueChangedCallback"
page_title: "Unity - Scripting API: UIElements.INotifyValueChangedExtensions.RegisterValueChangedCallback"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.INotifyValueChangedExtensions.RegisterValueChangedCallback.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.INotifyValueChangedExtensions.RegisterValueChangedCallback.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [INotifyValueChangedExtensions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.INotifyValueChangedExtensions.html).RegisterValueChangedCallback

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

public static bool <span class="sig-kw">RegisterValueChangedCallback</span>(INotifyValueChanged\<T> <span class="sig-kw">control</span>, EventCallback\<ChangeEvent\<T>\> <span class="sig-kw">callback</span>);

### Description

Registers this callback to receive ChangeEvent_1 when the value is changed.

  
This calls CallbackEventHandler.RegisterCallback_1 on the same control (equivalent to registering a ChangeEvent_1 callback directly). ChangeEvent_1 participates in propagation; handlers on an ancestor receive bubbled events from descendant controls of the same event type.  
  
Use [EventBase.target](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase-target.html) to identify which element originated the change, and [EventBase.currentTarget](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.EventBase-currentTarget.html) for the element on which the callback was registered. Refer to the [Change events](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Change-Events.html) manual page for guidance on filtering and composite controls.
