---
title: "Scripting API: PreserveAttribute"
page_title: "Unity - Scripting API: PreserveAttribute"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Scripting.PreserveAttribute.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Scripting.PreserveAttribute.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# PreserveAttribute

class in UnityEngine.Scripting

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

PreserveAttribute prevents byte code stripping from removing a class, method, field, or property.

When you create a build, Unity will try to strip unused code from your project. This is great to get small builds. However, sometimes you want some code to not be stripped, even if it looks like it is not used. This can happen for instance if you use reflection to call a method, or instantiate an object of a certain class. You can apply the \[Preserve\] attribute to classes, methods, fields and properties. In addition to using PreserveAttribute, you can also use the traditional method of a link.xml file to tell the linker to not remove things. PreserveAttribute and link.xml work for both the Mono and IL2CPP scripting backends.  
  
For more details on `[Preserve]` and link.xml, refer to [Managed code stripping](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping.html).

``` codeExampleCS
using UnityEngine;
using System.Collections;
using System.Reflection;
using UnityEngine.Scripting;

public class NewBehaviourScript : MonoBehaviour

}

public class ReflectionExample

    // No other code directly references the Boink method, so when when stripping is enabled,
    // it will be removed unless the [Preserve] attribute is applied.
    [Preserve]
    static void Boink()
    
}
```

For 3rd party libraries that do not want to take on a dependency on UnityEngine.dll, it is also possible to define their own PreserveAttribute. The code stripper will respect that too, and it will consider any attribute with the exact name "PreserveAttribute" as a reason not to strip the thing it is applied on, regardless of the namespace or assembly of the attribute.
