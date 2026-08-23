---
title: "Scripting API: RequireComponent"
page_title: "Unity - Scripting API: RequireComponent"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RequireComponent.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RequireComponent.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# RequireComponent

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

The RequireComponent attribute automatically adds required components as dependencies.

When you add a script which uses RequireComponent to a GameObject, the required component is automatically added to the GameObject. This is useful to avoid setup errors. For example a script might require that a Rigidbody is always added to the same GameObject. When you use RequireComponent, this is done automatically, so you are unlikely to get the setup wrong.  
  
**Note:** RequireComponent only checks for missing dependencies when [GameObject.AddComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.AddComponent.html) is called. This happens both in the Editor, or at runtime. Unity does not automatically add any missing dependences to the components with GameObjects that lack the new dependencies.

``` codeExampleCS
using UnityEngine;

// PlayerScript requires the GameObject to have a Rigidbody component
[RequireComponent(typeof(Rigidbody))]
public class PlayerScript : MonoBehaviour

    void FixedUpdate()
    
}
```

### Constructors

| Constructor                                                                                                  | Description                 |
|--------------------------------------------------------------------------------------------------------------|-----------------------------|
| [RequireComponent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RequireComponent-ctor.html) | Require a single component. |
