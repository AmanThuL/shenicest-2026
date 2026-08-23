---
title: "Scripting API: Quaternion.eulerAngles"
page_title: "Unity - Scripting API: Quaternion.eulerAngles"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion-eulerAngles.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion-eulerAngles.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Quaternion](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion.html).eulerAngles

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Quaternion.html" class="switch-link gray-btn sbtn left show" title="Go to Quaternion Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>public [Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">eulerAngles</span>;

### Description

Returns or sets the euler angle representation of the rotation in degrees.

Euler angles can represent a three dimensional rotation by performing three separate rotations around individual axes. In Unity these rotations are performed around the Z axis, the X axis, and the Y axis, in that order.  
  
You can set the rotation of a Quaternion by setting this property, and you can read the Euler angle values by reading this property.  
  
When using the .eulerAngles property to set a rotation, it is important to understand that although you are providing X, Y, and Z rotation values to describe your rotation, those values are not stored in the rotation. Instead, the X, Y & Z values are converted to the Quaternion's internal format.  
  
When you read the .eulerAngles property, Unity converts the Quaternion's internal representation of the rotation to Euler angles. Because, there is more than one way to represent any given rotation using Euler angles, the values you read back out may be quite different from the values you assigned. This can cause confusion if you are trying to gradually increment the values to produce animation. See bottom scripting example for more information.  
  
To avoid these kinds of problems, the recommended way to work with rotations is to avoid relying on consistent results when reading .eulerAngles particularly when attempting to gradually increment a rotation to produce animation. For better ways to achieve this, see the [Quaternion \* operator](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Quaternion-operator_multiply.html).  
  
The following example demonstrates the rotation of a GameObject using eulerAngles based on the Input of the user. The example shows that we never rely on reading the Quanternion.eulerAngles to increment the rotation, instead we set it using our Vector3 currentEulerAngles. All rotational changes happen in the currentEulerAngles variable, which are then applied to the Quaternion avoiding the problem mentioned above.

``` codeExampleCS
using UnityEngine;

public class DocsEulerAngles : MonoBehaviour

    void Update()
    
    void OnGUI()
    
}
```

The following example demonstrates how the values you read out of .eulerAngles may be quite different from the values you assign, even though they represent the same rotation.

``` codeExampleCS
using UnityEngine;

// demonstration of eulerAngles not returning the same values as assigned
public class EulerAnglesProblemExample : MonoBehaviour

}
```
