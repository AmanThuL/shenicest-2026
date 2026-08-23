---
title: "Scripting API: GameObject.AddComponent"
page_title: "Unity - Scripting API: GameObject.AddComponent"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.AddComponent.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.AddComponent.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html).AddComponent

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

public [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html) <span class="sig-kw">AddComponent</span>(Type <span class="sig-kw">componentType</span>);

### Description

Adds a component of the specified type to the GameObject.

There is no corresponding method for removing a component from a GameObject. To remove a component, use [Object.Destroy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Destroy.html).

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class AddComponentExample : MonoBehaviour

}
```

Additional resources: [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html), [Object.Destroy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Destroy.html)

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public T <span class="sig-kw">AddComponent</span>();

### Description

Generic version of this method.

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class AddComponentExample : MonoBehaviour

}
```

Additional resources: [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html), [Object.Destroy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Destroy.html)

------------------------------------------------------------------------

<span style="color:red;"> **Obsolete** </span>

## Declaration

public [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html) <span class="sig-kw">AddComponent</span>(string <span class="sig-kw">className</span>);

### Description

Adds a component of the specified class name to the GameObject.

Deprecated: Use AddComponent(Type) or the generic version of this method instead.
