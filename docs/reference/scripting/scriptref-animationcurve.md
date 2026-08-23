---
title: "Scripting API: AnimationCurve"
page_title: "Unity - Scripting API: AnimationCurve"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# AnimationCurve

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

Represents the variation of a value over time. AnimationCurves are typically used to animate the value of [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html) properties in [AnimationClip](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationClip.html), but you can use them to dynamically drive any float value.

The AnimationCurve class is a core component of Unity's Animation System.  
To construct a simple AnimationCurve through code, use one of the following static utility methods:

-   Use [AnimationCurve.EaseInOut](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve.EaseInOut.html) for a curve that smoothly transitions from one value to another.
-   Use [AnimationCurve.Linear](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve.Linear.html) for a curve that linearly transitions from one value to another.
-   Use [AnimationCurve.Constant](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve.Constant.html) for a curve that holds a constant value over its duration.

To construct a complex AnimationCurve, use [AnimationCurve.AnimationCurve](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve-ctor.html) and [AnimationCurve.AddKey](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve.AddKey.html).  
  
Once constructed, use an AnimationCurve to animate the following properties:

-   The [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) position, rotation, scale, or component properties in an [AnimationClip](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationClip.html).
-   The properties of [ParticleSystem](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ParticleSystem.html) or [VisualEffect](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/VFX.VisualEffect.html).
-   The properties of your own [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.html) over time.

The following example illustrates how to use an AnimationCurve to gradually change the intensity of a [Light](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Light.html).

``` codeExampleCS
using System.Collections;
using UnityEngine;

/// <summary>
/// Increases or decreases light intensity based on an ease-in-ease-out curve.
/// </summary>
[RequireComponent(typeof(Light))]
public class SmoothLight : MonoBehaviour

    //Use this method to bring the light back to the maximum intensity over one second.
    public IEnumerator TurnUp()
    
    }

    //Use this method to bring the light back to zero intensity over one second.
    public IEnumerator TurnDown()
    
    }
}
```

### Properties

| Property                                                                                                        | Description                                               |
|-----------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------|
| [keys](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve-keys.html)                  | All keys defined in the animation curve.                  |
| [length](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve-length.html)              | The number of keys in the curve. (Read Only)              |
| [postWrapMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve-postWrapMode.html)  | The behaviour of the animation after the last keyframe.   |
| [preWrapMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve-preWrapMode.html)    | The behaviour of the animation before the first keyframe. |
| [this\[int\]](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve.Index_operator.html) | Retrieves the key at index. (Read Only)                   |

### Constructors

| Constructor                                                                                              | Description                                                       |
|----------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------|
| [AnimationCurve](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve-ctor.html) | Creates an animation curve from an arbitrary number of keyframes. |

### Public Methods

| Method                                                                                                             | Description                                                                                                           |
|--------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| [AddKey](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve.AddKey.html)                 | Add a new key to the curve.                                                                                           |
| [ClearKeys](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve.ClearKeys.html)           | Erases all KeyFrame from this instance of the AnimationCurve.                                                         |
| [CopyFrom](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve.CopyFrom.html)             | Copies the keys and properties of the specified AnimationCurve object into this instance of the AnimationCurve class. |
| [Evaluate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve.Evaluate.html)             | Evaluate the curve at time.                                                                                           |
| [GetHashCode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve.GetHashCode.html)       | A HashCode for the animation curve, computed using all individual Keyframe.                                           |
| [GetKeys](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve.GetKeys.html)               | Get all keys defined in the AnimationCurve.                                                                           |
| [MoveKey](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve.MoveKey.html)               | Moves the key at index to key.time and key.value.                                                                     |
| [RemoveKey](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve.RemoveKey.html)           | Removes a key.                                                                                                        |
| [SetKeys](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve.SetKeys.html)               | Set all keys defined in the AnimationCurve.                                                                           |
| [SmoothTangents](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve.SmoothTangents.html) | Smooth the in and out tangents of the keyframe at index.                                                              |

### Static Methods

| Method                                                                                                   | Description                                                                                         |
|----------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------|
| [Constant](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve.Constant.html)   | Creates a constant "curve" starting at timeStart, ending at timeEnd, and set to the value value.    |
| [EaseInOut](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve.EaseInOut.html) | Creates an ease-in and out curve starting at timeStart, valueStart and ending at timeEnd, valueEnd. |
| [Linear](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AnimationCurve.Linear.html)       | A straight Line starting at timeStart, valueStart and ending at timeEnd, valueEnd.                  |
