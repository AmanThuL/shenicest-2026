---
title: "Optimizing arrays"
page_title: "Unity - Manual: Optimizing arrays"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/performance-optimizing-arrays.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/performance-optimizing-arrays.html"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Optimizing arrays

The following page outlines examples to improve the performance of your code when using [arrays](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/arrays).

## Pass arrays as parameters to methods

Sometimes it might be convenient to write a method that creates a new array, fills the array with values and then returns it. However, if this method is called repeatedly, then new memory gets allocated each time.

The following example code shows an example of a method which creates an array every time it’s called:

``` lang-cs
// Bad C# script example: Every time the RandomList method is called it
// allocates a new array
using UnityEngine;
using System.Collections;

public class ExampleScript : MonoBehaviour 
        return result;
    }
}
```

One way you can avoid allocating memory every time is to make use of the fact that an array is a reference type. You can modify an array that’s passed into a method as a parameter, and the results remain after the method returns. To do this, you can configure the example code as follows:

``` lang-cs
// Good C# script example: This version of method is passed an array to fill
// with random values. The array can be cached and re-used to avoid repeated
// temporary allocations
using UnityEngine;
using System.Collections;

public class ExampleScript : MonoBehaviour 
    }
}
```

This code replaces the existing contents of the array with new values. This workflow requires the calling code to do the initial allocation of the array, but the function doesn’t generate any new garbage when it’s called. The array can then be re-used and re-filled with random numbers the next time this method is called without any new allocations on the managed heap.

## Avoid repeated access to array-valued Unity APIs

One cause of unintended allocations on arrays is the repeated accessing of Unity APIs that return arrays. All Unity APIs that return arrays create a new copy of the array each time they’re accessed. If your code accesses an array-valued Unity API more often than necessary, it can affect the performance of your application.

As an example, the following code creates four copies of the vertices array per loop iteration. The allocations happen each time the `.vertices` property is accessed:

``` lang-cs
// Bad C# script example: this loop create 4 copies of the vertices array per iteration
void Update() 
}
```

You can refactor this code into a single array allocation, regardless of the number of loop iterations. To do this, configure your code to capture the vertices array before the loop:

``` lang-cs
// Better C# script example: create one copy of the vertices array
// and work with that
void Update() 
}
```

An optimal way of doing this is to maintain a `List` of vertices which is cached and re-used between frames, and then use [`Mesh.GetVertices`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Mesh.GetVertices.html) to populate it when required.

``` lang-cs
// Best C# script example: create one copy of the vertices array
// and work with that.
List<Vector3> m_vertices = new List<Vector3>();

void Update() 
}
```

While the CPU performance implications of accessing a property that allocates an array once isn’t high, repeated accesses within tight loops create CPU performance hotspots. Repeated accesses expand the [managed heap](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-managed-memory-introduction.html).

This problem is common on mobile devices, because the [`Input.touches`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Input-touches.html) API behaves similarly to the previous example. It’s also common for projects to contain code similar to the following, where an allocation occurs each time the `.touches` property is accessed:

``` lang-cs
// Bad C# script example: Input.touches returns an array every time it’s accessed
for ( int i = 0; i < Input.touches.Length; i++ ) 
```

To improve this, you can configure your code to hoist the array allocation out of the loop condition:

``` lang-cs
// Better C# script example: Input.touches is only accessed once here
Touch[] touches = Input.touches;

for ( int i = 0; i < touches.Length; i++ ) 
```

The following code example converts the previous example to the allocation-free `Touch` API:

``` lang-cs
// BEST C# script example: Input.touchCount and Input.GetTouch don’t allocate at all.
int touchCount = Input.touchCount;

for ( int i = 0; i < touchCount; i++ ) 
```

**Note:** The property access (`Input.touchCount`) remains outside the loop condition, to save the CPU impact of invoking the property’s get method.

### Alternative non-allocating APIs

Some Unity APIs have alternative versions that don’t cause memory allocations. You should use these when possible. The following table contains an example of allocating APIs and their non-allocating alternatives:

| **Allocating API**                                                                                                        | **Non-allocating API alternative**                                                                                                                                                                                                              |
|:--------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [`Physics.RaycastAll`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.RaycastAll.html)             | [`Physics.RaycastNonAlloc`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.RaycastNonAlloc.html)                                                                                                                         |
| [`Animator.parameters`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-parameters.html)           | [`Animator.parameterCount`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator-parameterCount.html) and [`Animator.GetParameter`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.GetParameter.html) |
| [`Renderer.sharedMaterials`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer-sharedMaterials.html) | [`Renderer.GetSharedMaterials`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Renderer.GetSharedMaterials.html)                                                                                                                 |

In general, if the method returns an array, there’s usually a non-allocating version of the API which you can use to pass the array to.

## Use static instances of zero-length arrays

Some development teams prefer to return empty arrays instead of `null` when an array-valued method needs to return an empty set. This coding pattern is common in a lot of managed languages, in particular with C# and Java.

When returning a zero-length array from a method, it’s more efficient to return a pre-allocated static instance of the zero-length array than to repeatedly create empty arrays.

## Use native arrays or other native containers for large arrays

Unity’s [garbage collector](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-garbage-collector.html) is a heuristic garbage collector, which means that it treats any field that has the size of a pointer as if it is a pointer. The garbage collector checks every pointer and reference that it encounters.

When you use large arrays (with more than 10 thousand elements), the garbage collector might interpret large arrays as a long list of pointers that it needs to check, which increases memory pressure and slows the garbage collector down.

The scripting VM also has to allocate big chunks of managed heap space for large arrays which increases the chance that a random value looks like a valid address in the managed heap chunk’s memory address range. Large arrays are also a big contributing factor to managed heap fragmentation.

If you need to allocate arrays of such length, consider using the collection types in `Unity.Collections` namespace (including [`NativeArray`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Unity.Collections.NativeArray_1.html)) in the Unity core API, and the data structures in the [Unity Collections package](https://docs.unity3d.com/Packages/com.unity.collections@latest). As an additional benefit, using these collections are compatible with the [job system](https://docs.unity3d.com/6000.3/Documentation/Manual/job-system.html) and Burst.

## Additional resources

-   [Managed memory introduction](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-managed-memory-introduction.html)
-   [Reference type management](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-reference-types.html)
-   [Creating reusable code](https://docs.unity3d.com/6000.3/Documentation/Manual/performance-reusable-code.html)
