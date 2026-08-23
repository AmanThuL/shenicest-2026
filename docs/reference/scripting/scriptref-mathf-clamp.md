---
title: "Scripting API: Mathf.Clamp"
page_title: "Unity - Scripting API: Mathf.Clamp"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Clamp.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.Clamp.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Mathf](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mathf.html).Clamp

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Mathf.html" class="switch-link gray-btn sbtn left show" title="Go to Mathf Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public static float <span class="sig-kw">Clamp</span>(float <span class="sig-kw">value</span>, float <span class="sig-kw">min</span>, float <span class="sig-kw">max</span>);

### Parameters

| Parameter | Description                                                                                      |
|-----------|--------------------------------------------------------------------------------------------------|
| value     | The floating point value to restrict inside the range defined by the minimum and maximum values. |
| min       | The minimum floating point value to compare against.                                             |
| max       | The maximum floating point value to compare against.                                             |

### Returns

**float** The float result between the minimum and maximum values.

### Description

Clamps the given value between the given minimum float and maximum float values. Returns the given value if it is within the minimum and maximum range.

Returns the minimum value if the given float value is less than the minimum. Returns the maximum value if the given value is greater than the maximum value. Use Clamp to restrict a value to a range that is defined by the minimum and maximum values.  
Returns an undefined value if the minimum value is greater than the maximum value.

``` codeExampleCS
using UnityEngine;

// Mathf.Clamp example.
//
// Animate a cube along the x-axis using a sine wave.
// Let the minimum and maximum positions on the x-axis
// be changed.  The cube will be visible inside the
// minimum and maximum values.

public class ExampleScript : MonoBehaviour

    }

    void OnGUI()
    
        // Display the xMin and xMax value with better size labels.
        GUIStyle fontSize = new GUIStyle(GUI.skin.GetStyle("label"));
        fontSize.fontSize = 24;

        GUI.Label(new Rect(135, 10, 150, 30), "xMin: " + xMin.ToString("f2"), fontSize);
        GUI.Label(new Rect(135, 45, 150, 30), "xMax: " + xMax.ToString("f2"), fontSize);
    }
}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static int <span class="sig-kw">Clamp</span>(int <span class="sig-kw">value</span>, int <span class="sig-kw">min</span>, int <span class="sig-kw">max</span>);

### Parameters

| Parameter | Description                                                      |
|-----------|------------------------------------------------------------------|
| value     | The integer point value to restrict inside the min-to-max range. |
| min       | The minimum integer point value to compare against.              |
| max       | The maximum integer point value to compare against.              |

### Returns

**int** The int result between min and max values.

### Description

Clamps the given value between a range defined by the given minimum integer and maximum integer values. Returns the given value if it is within min and max.

Returns the min value if the given value is less than the min value. Returns the max value if the given value is greater than the max value. The min and max parameters are inclusive. For example, Clamp(10, 0, 5) will return a maximum argument of 5 and not 4.

``` codeExampleCS
using UnityEngine;

// Mathf.Clamp integer example.
//
// Add or subtract values from health.
// Keep health between 1 and 100. Start at 17.

public class ExampleScript : MonoBehaviour
{
    public int health = 17;
    private int[] healthUp = new int[] {25, 10, 5, 1};
    private int[] healthDown = new int[] {-10, -5, -2, -1};

    // Width and height for the buttons.
    private int xButton = 75;
    private int yButton = 50;

    // Place of the top left button.
    private int xPos1 = 50, yPos1 = 100;
    private int xPos2 = 125, yPos2 = 100;

    void OnGUI()
    
        }

        // Generate and show negative buttons.
        for (int i = 0; i < healthDown.Length; i++)
        
        }

        // Show health between 1 and 100.
        health = Mathf.Clamp(health, 1, 100);
        GUI.Label(new Rect(xPos1, xPos1, 2 * xButton, yButton), "Health: " + health.ToString("D3"));
    }
}
```
