---
title: "Scripting API: Random.Range"
page_title: "Unity - Scripting API: Random.Range"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Random.Range.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Random.Range.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Random](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Random.html).Range

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Random.html" class="switch-link gray-btn sbtn left show" title="Go to Random Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public static float <span class="sig-kw">Range</span>(float <span class="sig-kw">minInclusive</span>, float <span class="sig-kw">maxInclusive</span>);

### Description

Returns a random `float` within `[minInclusive..maxInclusive]` (range is inclusive).

If `minInclusive` is greater than `maxInclusive`, then the numbers are automatically swapped.  
  
**Important**: Both the lower and upper bounds are **inclusive**. Any given float value between them, *including both minInclusive and maxInclusive*, will appear on average approximately once every ten million random samples.  
  
There is an `int` overload of this function that operates slightly differently, especially regarding the range maximum. See its docs below.  
  
See [Random](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Random.html) for details on the algorithm, and for examples of how `UnityEngine.Random` may be different from other random number generators.

``` codeExampleCS
using UnityEngine;

public class ExampleClass : MonoBehaviour

    }
}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static int <span class="sig-kw">Range</span>(int <span class="sig-kw">minInclusive</span>, int <span class="sig-kw">maxExclusive</span>);

### Description

Return a random `int` within `[minInclusive..maxExclusive)` (Read Only).

The maximum parameter is exclusive, so for example `Random.Range(0, 10)` returns a value between 0 and 9, each with approximately equal probability.  
  
If `minInclusive` and `maxExclusive` are equal, the method returns `minInclusive`.  
  
If `minInclusive` is greater than `maxExclusive`, the input parameters are swapped but retain their inclusivity or exclusivity based on their original positions, which means the method becomes `Random.Range(minExclusive, maxInclusive)` after swapping.  
  
For example, calling `Random.Range(10, 0)` is not equivalent to `Random.Range(0, 10)`. `Random.Range(10, 0)` returns a value between 1 and 10 because 10 becomes an inclusive maximum and 0 becomes an exclusive minimum.  
  
There is a `float` overload of this function that operates slightly differently, especially regarding the range maximum, refer to its docs above.  
  
Refer to [Random](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Random.html) for details on the algorithm, and for examples of how `UnityEngine.Random` may differ from other random number generators.

``` codeExampleCS
using UnityEngine;

public class ExampleClass : MonoBehaviour

            }

            zoffset += 2;
        }
    }
}
```
