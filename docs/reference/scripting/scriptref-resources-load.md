---
title: "Scripting API: Resources.Load"
page_title: "Unity - Scripting API: Resources.Load"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.Load.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.Load.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Resources](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.html).Load

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

### Description

Loads the asset of the requested type stored at `path` in a [Resources](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.html) folder.

This method returns the asset at `path` if it can be found, otherwise it returns null.  
Note that the `path` is case insensitive and must not contain a file extension. All asset names and paths in Unity use forward slashes, so using backslashes in the `path` will **not** work.  
  
The `path` is relative to any folder named `Resources` inside the Assets folder of your project. More than one [Resources](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.html) folder can be used. If you have multiple [Resources](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.html) folders you cannot duplicate the use of an asset name.  
  
For example, a project may have [Resources](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.html) folders called `Assets / Resources/` and `Assets / Guns / Resources/`. The path does not need to include `Assets` and `Resources` in the string, for example loading a GameObject at `Assets / Guns / Resources / Shotgun.prefab` would only require `Shotgun` as the `path`. Also, if `Assets / Resources / Guns / Missiles / PlasmaGun.prefab` exists it can be loaded using `Guns / Missiles / PlasmaGun` as the `path` string.  
If you have multiple [Resources](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.html) folders you cannot duplicate the use of an asset name.  
  
If you have multiple assets of different types with the same name, and you don't specify the type, then the object that Unity returns is non-deterministic because the potential candidates are not ordered in any particular way. Instead, use `Resources.Load<T>(path)` to specify the required asset.

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static T <span class="sig-kw">Load</span>(string <span class="sig-kw">path</span>);

### Parameters

| Parameter | Description                          |
|-----------|--------------------------------------|
| path      | Path to the target resource to load. |

### Returns

**T** An object of the requested generic parameter type.

### Description

Loads the asset of the requested type stored at `path` in a [Resources](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Resources.html) folder using a generic parameter type filter of type `T`.

This method returns the asset at `path` if it can be found and if its type matches the requested generic parameter type, otherwise it returns null. You can use this overload to reduce type conversion in your code by providing a generic type parameter. This allows Unity to perform the C# type conversion for you.

``` codeExampleCS
// Loading assets from the Resources folder using the generic Resources.Load<T>(path) method
using UnityEngine;

public class ExampleClass : MonoBehaviour

}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static Object <span class="sig-kw">Load</span>(string <span class="sig-kw">path</span>);

<span style="color:red;"> </span>

## Declaration

public static Object <span class="sig-kw">Load</span>(string <span class="sig-kw">path</span>, Type <span class="sig-kw">systemTypeInstance</span>);

### Parameters

| Parameter          | Description                          |
|--------------------|--------------------------------------|
| path               | Path to the target resource to load. |
| systemTypeInstance | Type filter for objects returned.    |

### Returns

**Object** The requested asset returned as an Object.

### Description

Loads an asset stored at `path` in a Resources folder using an optional `systemTypeInstance` filter.

This method returns the asset at `path` if it can be found and if its type matches the optional `systemTypeInstance` parameter, otherwise it returns null.  
You may need to cast the returned object to the actual associated C# type of the asset in order to access its methods and properties, or use it with other Unity APIs.

``` codeExampleCS
// Loading assets from the Resources folder using the Resources.Load(path)
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

}
```

``` codeExampleCS
// Loading assets from the Resources folder using the Resources.Load(path, systemTypeInstance)
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

}
```
