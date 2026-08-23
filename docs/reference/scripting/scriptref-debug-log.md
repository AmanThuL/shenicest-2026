---
title: "Scripting API: Debug.Log"
page_title: "Unity - Scripting API: Debug.Log"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.Log.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.Log.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Debug](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.html).Log

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Debug.html" class="switch-link gray-btn sbtn left show" title="Go to Debug Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public static void <span class="sig-kw">Log</span>(object <span class="sig-kw">message</span>);

<span style="color:red;"> </span>

## Declaration

public static void <span class="sig-kw">Log</span>(object <span class="sig-kw">message</span>, [Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html) <span class="sig-kw">context</span>);

### Parameters

| Parameter | Description                                                            |
|-----------|------------------------------------------------------------------------|
| message   | String or object to be converted to string representation for display. |
| context   | Object to which the message applies.                                   |

### Description

Logs a message to the Unity Console.

Use [Debug.Log](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.Log.html) to print informational messages that help you debug your application. For example, you could print a message containing a GameObject.name and information about the object’s current state.  
  
You can format messages with string concatenation:  
`Debug.Log("Text: " + myText.text);`  
  
You can also use [Rich Text](https://docs.unity3d.com/6000.3/Documentation/Manual/StyledText.html) markup.  
  
If you pass a [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html) or [Component](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Component.html) as the optional `context` parameter, Unity momentarily highlights that object in the `Hierarchy` window when you click the log message in the `Console`. Use a `context` object when you have many instances of an object in a Scene so that you can identify which one produced the message. `Example 2`, below, illustrates how this feature works. When you run this example, first click one of the cubes it creates in the Scene. The example prints a log message to the `Console`. When you click on the message, Unity highlights the `context` object in the `Hierarchy` window — in this case, the cube you clicked on in the Scene.  
  
Example 1: Show some uses of [Debug.Log](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.Log.html):

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class MyGameClass : MonoBehaviour

}
```

Example 2: Show selection of a clicked [GameObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObject.html):

``` codeExampleCS
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Debug.Log example
//
// Create three cubes. Place them around the world origin.
// If a cube is clicked use Debug.Log to announce it. Use
// Debug.Log with two arguments. Argument two allows the
// cube to be automatically selected in the hierarchy when
// the console message is clicked.
//
// Add this script to an empty GameObject.

public class Example : MonoBehaviour
{
    private GameObject[] cubes;

    void Awake()
    {
        // Create three cubes and place them close to the world space center.
        cubes = new GameObject[3];
        float f = 25.0f;
        float p = -2.0f;
        float[] z = new float[] {0.5f, 0.0f, 0.5f};

        for (int i = 0; i < 3; i++)
        
        // Position and rotate the camera to view all three cubes.
        Camera.main.transform.position = new Vector3(3.0f, 1.5f, 3.0f);
        Camera.main.transform.localEulerAngles = new Vector3(25.0f, -140.0f, 0.0f);
    }

    void Update()
    
                }
            }
        }
    }
}
```

Note: Unity also adds [Debug.Log](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Debug.Log.html) messages to the Editor and Player log files. For more information about accessing these files on different platforms, refer to [Log files reference](https://docs.unity3d.com/6000.3/Documentation/Manual/log-files.html).  
  
Additional resources: [MonoBehaviour.print](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour-print.html).
