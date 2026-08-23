---
title: "Scripting API: Undo.RecordObject"
page_title: "Unity - Scripting API: Undo.RecordObject"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.RecordObject.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.RecordObject.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Undo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.html).RecordObject

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

public static void <span class="sig-kw">RecordObject</span>([Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html) <span class="sig-kw">objectToUndo</span>, string <span class="sig-kw">name</span>);

### Parameters

| Parameter    | Description                                                                            |
|--------------|----------------------------------------------------------------------------------------|
| objectToUndo | The reference to the object that you will be modifying.                                |
| name         | The title of the action to appear in the undo history (i.e. visible in the undo menu). |

### Description

Records any changes done on the object after the RecordObject function.

Almost all property changes can be recorded with this function. The transform parent, AddComponent, object destruction can not be recorded with this function, for that you should use the dedicated functions.  
  
Internally this creates a temporary copy of the object's state. At the end of the frame Unity diffs the state and detects what has changed. The changed properties are recorded on the undo stack. If nothing has changed (Binary exact comparison is used for all properties), no undo operations are stored on the stack.  
  
**Important:** To correctly handle instances where *objectToUndo* is an instance of a Prefab, [PrefabUtility.RecordPrefabInstancePropertyModifications](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PrefabUtility.RecordPrefabInstancePropertyModifications.html) must be called after RecordObject.  
  
This is an example of an editor script which allows you to change an effect radius variable. The Undo state is recorded, allowing you to revert the change using the undo system.

``` codeExampleCS
//Name this script "EffectRadiusEditor"
using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(EffectRadius))]
public class EffectRadiusEditor : Editor

    }
}
```

Place this script on a GameObject to see the area of effect handle, and change the value using the gizmo in the Scene view.

``` codeExampleCS
//Name this script "EffectRadius"
using UnityEngine;
using System.Collections;

public class EffectRadius : MonoBehaviour

```

Additional resources: [Undo.RecordObjects](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.RecordObjects.html).
