---
title: "Scripting API: GameObject.SetActive"
page_title: "Unity - Scripting API: GameObject.SetActive"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.SetActive.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.SetActive.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html).SetActive

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-GameObject.html" class="switch-link gray-btn sbtn left show" title="Go to GameObject Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">SetActive</span>(bool <span class="sig-kw">value</span>);

### Parameters

| Parameter | Description                                                                                          |
|-----------|------------------------------------------------------------------------------------------------------|
| value     | The active state to set, where `true` sets the GameObject to active and `false` sets it to inactive. |

### Description

Activates or deactivates the GameObject locally, according to the value of the supplied parameter.

`SetActive` only sets the local state of the GameObject, represented by the value of [GameObject.activeSelf](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-activeSelf.html). Changing the value of [GameObject.activeSelf](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-activeSelf.html) has no effect on the value of [GameObject.activeInHierarchy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-activeInHierarchy.html) if `activeInHierarchy` is `false` because of an inactive parent object.  
  
Deactivating a GameObject disables each component, including attached renderers, colliders, rigidbodies, and scripts. For example, Unity will no longer call [MonoBehaviour.Update](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Update.html) on a script attached to a deactivated GameObject. Deactivating a GameObject also stops all coroutines attached to it.  
  
**Note:** If the call to `SetActive` changes the value of [GameObject.activeInHierarchy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-activeInHierarchy.html), this triggers [MonoBehaviour.OnEnable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnEnable.html) or [MonoBehaviour.OnDisable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.OnDisable.html) on all attached MonoBehaviour scripts.

``` codeExampleCS
using UnityEngine;

public class Example : MonoBehaviour

    }

    void Update()
    
                else  cubes[i].SetActive(true);
            }
            timer = 0;
        }
    }
}
```

Additional resources: [GameObject.activeSelf](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject-activeSelf.html), [GameObject.SetGameObjectsActive](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.SetGameObjectsActive.html)
