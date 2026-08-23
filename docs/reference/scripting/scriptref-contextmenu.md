---
title: "Scripting API: ContextMenu"
page_title: "Unity - Scripting API: ContextMenu"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ContextMenu.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ContextMenu.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# ContextMenu

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

Use the ContextMenu attribute to add commands to the context menu of the Inspector window.

In the Inspector window of the attached script, when the user selects the context menu, the function executes.  
  
This is most useful for automatically setting up Scene data from the script. The function has to be non-static.  
  
If you want to create a context menu when you right-click a property in the Inspector, use [EditorApplication.contextualPropertyMenu](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorApplication-contextualPropertyMenu.html).  
  
If you want to create a menu item that invokes a static function when it is selected, refer to [MenuItem](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MenuItem.html).  
  

``` codeExampleCS
using UnityEngine;

public class ContextTesting : MonoBehaviour

}
```

### Constructors

| Constructor                                                                                        | Description                                             |
|----------------------------------------------------------------------------------------------------|---------------------------------------------------------|
| [ContextMenu](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ContextMenu-ctor.html) | Adds the function to the context menu of the component. |
