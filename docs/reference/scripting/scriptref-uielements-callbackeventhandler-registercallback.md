---
title: "Scripting API: UIElements.CallbackEventHandler.RegisterCallback"
page_title: "Unity - Scripting API: UIElements.CallbackEventHandler.RegisterCallback"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.CallbackEventHandler.RegisterCallback.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.CallbackEventHandler.RegisterCallback.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [CallbackEventHandler](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.CallbackEventHandler.html).RegisterCallback

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

public void <span class="sig-kw">RegisterCallback</span>(EventCallback\<TEventType> <span class="sig-kw">callback</span>, [UIElements.TrickleDown](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.TrickleDown.html) <span class="sig-kw">useTrickleDown</span>);

### Parameters

| Parameter      | Description                                                                                                                                       |
|----------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| callback       | The event handler to add. If the handler is null, this method throws an exception.                                                                |
| useTrickleDown | By default, this callback is called during the BubbleUp phase. Pass `TrickleDown.TrickleDown` to call this callback during the TrickleDown phase. |

### Description

Adds an event handler to the instance.

If the event handler is already registered for the same phase (either TrickleDown or BubbleUp), this method has no effect.  
  
Refer to the [Handle event callbacks and value changes](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Events-Handling.html) manual page for more information and examples.  
  
Additional resources: [PropagationPhase](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PropagationPhase.html)

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">RegisterCallback</span>(EventCallback\<TEventType,TUserArgsType> <span class="sig-kw">callback</span>, TUserArgsType <span class="sig-kw">userArgs</span>, [UIElements.TrickleDown](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.TrickleDown.html) <span class="sig-kw">useTrickleDown</span>);

### Parameters

| Parameter      | Description                                                                                                                                       |
|----------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| callback       | The event handler to add. If the handler is null, this method throws an exception.                                                                |
| userArgs       | Data to pass to the callback. Use this argument to avoid closing on local variables.                                                              |
| useTrickleDown | By default, this callback is called during the BubbleUp phase. Pass `TrickleDown.TrickleDown` to call this callback during the TrickleDown phase. |

### Description

Adds an event handler to the instance.

If the event handler is already registered for the same phase (either TrickleDown or BubbleUp), this method has no effect.  
  
Refer to the [Handle event callbacks and value changes](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Events-Handling.html) manual page for more information and examples.  
  
Additional resources: [PropagationPhase](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PropagationPhase.html)

``` codeExampleCS
using UnityEngine;
using UnityEngine.UIElements;

[RequireComponent(typeof(UIDocument))]
public class RegisterCallbackExample : MonoBehaviour
{
    void OnEnable()
    {
        var myClickableLabel = new Label("Click me");

        myClickableLabel.RegisterCallback<PointerDownEvent, string>((ev, userArg) =>
        {
            Debug.Log("Hello from " + userArg);
        }, gameObject.name);

        GetComponent<UIDocument>().rootVisualElement.Add(myClickableLabel);
    }
}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">RegisterCallback</span>(EventCallback\<TEventType> <span class="sig-kw">callback</span>, [UIElements.CallbackOptions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.CallbackOptions.html) <span class="sig-kw">callbackOptions</span>);

### Parameters

| Parameter       | Description                                                                        |
|-----------------|------------------------------------------------------------------------------------|
| callback        | The event handler to add. If the handler is null, this method throws an exception. |
| callbackOptions | Extra properties to set for the callback.                                          |

### Description

Adds an event handler to the instance.

If the event handler is already registered for the same phase (either TrickleDown or BubbleUp), this method has no effect.  
  
Refer to the [Handle event callbacks and value changes](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Events-Handling.html) manual page for more information and examples.  
  
Additional resources: [PropagationPhase](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PropagationPhase.html)

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">RegisterCallback</span>(EventCallback\<TEventType,TUserArgsType> <span class="sig-kw">callback</span>, TUserArgsType <span class="sig-kw">userArgs</span>, [UIElements.CallbackOptions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.CallbackOptions.html) <span class="sig-kw">callbackOptions</span>);

### Parameters

| Parameter       | Description                                                                          |
|-----------------|--------------------------------------------------------------------------------------|
| callback        | The event handler to add. If the handler is null, this method throws an exception.   |
| userArgs        | Data to pass to the callback. Use this argument to avoid closing on local variables. |
| callbackOptions | Extra properties to set for the callback.                                            |

### Description

Adds an event handler to the instance.

If the event handler is already registered for the same phase (either TrickleDown or BubbleUp), this method has no effect.  
  
Refer to the [Handle event callbacks and value changes](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Events-Handling.html) manual page for more information and examples.  
  
Additional resources: [PropagationPhase](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PropagationPhase.html)
