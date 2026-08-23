---
title: "Scripting API: DefaultExecutionOrder"
page_title: "Unity - Scripting API: DefaultExecutionOrder"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/DefaultExecutionOrder.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/DefaultExecutionOrder.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# DefaultExecutionOrder

class in UnityEngine

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.CoreModule.html" class="cl">UnityEngine.CoreModule</a>

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

Specifies the script execution order for a MonoBehaviour-derived class relative to other MonoBehaviour-derived types.

The `DefaultExecutionOrder` attribute offers a way to specify the execution order between different MonoBehaviour scripts from code, rather than through the [Project settings](https://docs.unity3d.com/6000.3/Documentation/Manual/comp-ManagerGroup.html) window in the Unity Editor. For more information on script execution order and configuring it in the Editor, refer to [Script Execution Order](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoManager.html) in the Manual.  
  
This attribute targets classes, but it only has an effect on classes that inherit from [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html). The default execution order between script components applies only for the [event functions](https://docs.unity3d.com/6000.3/Documentation/Manual/event-functions.html) Unity calls in a determined order on all active GameObjects as part of their lifecycle, such as [MonoBehaviour.Awake](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Awake.html) and [MonoBehaviour.OnEnable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnEnable.html). It does not guarantee the relative execution order of callbacks for events that can happen at any time in the running application and that usually apply to a smaller subset of GameObjects, such as [MonoBehaviour.OnTriggerEnter](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnTriggerEnter.html).  
  
The integer value supplied as a parameter is equivalent to the integer values set in the **Script Execution Order** section of the **Project settings** window. The integer value assigned to a MonoBehaviour-derived type determines the execution order priority for script components of that type relative to the other MonoBehaviour scripts. Scripts are executed in order from lowest first to highest last, for example: -200, -100, -50, 50, 100, 200.  
  
When multiple scripts have either the same configured execution order or the default execution order, the order of execution between them is not deterministic. While the order might appear consistent during testing, you must never rely on this behavior, because it isn't guaranteed across builds, machines, or Unity versions. Note that assets imported from the asset store or other external sources might include scripts with the same configured execution order as your own scripts. If you rely on deterministic ordering between specific scripts, make sure to configure distinct execution order values for them after import.  
  
**Note**: Use this attribute with caution. Execution order defined in code with `DefaultExecutionOrder` does not show in the **Script Execution Order** section of the Editor's **Project settings**. If you define an execution order for a MonoBehaviour-derived type in code with `DefaultExecutionOrder` but define a different value for the same type in the Editor's **Project settings** window, Unity uses the value defined in the Editor UI.  
  
See Also: [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html)

``` codeExampleCS
using UnityEngine;
// Add this script to a GameObject
[DefaultExecutionOrder(50)]
public class ExampleClass : MonoBehaviour

}
```

### Properties

| Property                                                                                                | Description                                                                           |
|---------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------|
| [order](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/DefaultExecutionOrder-order.html) | Integer which defines the execution priority order for a MonoBehaviour-derived class. |

### Constructors

| Constructor                                                                                                            | Description                                                                                                       |
|------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| [DefaultExecutionOrder](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/DefaultExecutionOrder-ctor.html) | Sets the script execution order for a MonoBehaviour-derived class to the value of the supplied integer parameter. |
