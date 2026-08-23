---
title: "Scripting API: Transform.Translate"
page_title: "Unity - Scripting API: Transform.Translate"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.Translate.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.Translate.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html).Translate

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-Transform.html" class="switch-link gray-btn sbtn left show" title="Go to Transform Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">Translate</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">translation</span>);

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">Translate</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">translation</span>, [Space](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Space.html) <span class="sig-kw">relativeTo</span> = Space.Self);

### Parameters

| Parameter   | Description                                              |
|-------------|----------------------------------------------------------|
| translation | The amount by which to move the Transform.               |
| relativeTo  | The coordinate system in which to apply the translation. |

### Description

Moves the transform along its x, y, and z axes by the values of the translation parameter's x, y, and z components respectively.

If `relativeTo` is left out or set to [Space.Self](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Space.Self.html) the movement is applied relative to the transform's local axes. (the x, y and z axes shown when selecting the object inside the Scene View.) If `relativeTo` is [Space.World](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Space.World.html) the movement is applied relative to the world coordinate system.

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">Translate</span>(float <span class="sig-kw">x</span>, float <span class="sig-kw">y</span>, float <span class="sig-kw">z</span>);

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">Translate</span>(float <span class="sig-kw">x</span>, float <span class="sig-kw">y</span>, float <span class="sig-kw">z</span>, [Space](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Space.html) <span class="sig-kw">relativeTo</span> = Space.Self);

### Parameters

| Parameter  | Description                                                |
|------------|------------------------------------------------------------|
| x          | The amount by which to move the Transform on the x-axis.   |
| y          | The amount by which to move the Transform on the y-axis.   |
| z          | The amount by which to move the Transform on the z-axis.   |
| relativeTo | The coordinate system in which the translation is applied. |

### Description

Moves the transform by x along the x axis, y along the y axis, and z along the z axis.

If `relativeTo` is left out or set to [Space.Self](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Space.Self.html) the movement is applied relative to the transform's local axes. (the x, y and z axes shown when selecting the object inside the Scene View.) If `relativeTo` is [Space.World](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Space.World.html) the movement is applied relative to the world coordinate system.

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">Translate</span>([Vector3](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Vector3.html) <span class="sig-kw">translation</span>, [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) <span class="sig-kw">relativeTo</span>);

### Parameters

| Parameter   | Description                                             |
|-------------|---------------------------------------------------------|
| translation | The amount by which to move the Transform.              |
| relativeTo  | Defines the coordinate system used for the translation. |

### Description

Moves the transform along its x, y, and z axes by the values of the translation parameter's x, y, and z components respectively.

The movement is applied relative to /relativeTo/'s local coordinate system. If `relativeTo` is null, the movement is applied relative to the world coordinate system.

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public void <span class="sig-kw">Translate</span>(float <span class="sig-kw">x</span>, float <span class="sig-kw">y</span>, float <span class="sig-kw">z</span>, [Transform](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Transform.html) <span class="sig-kw">relativeTo</span>);

### Parameters

| Parameter  | Description                                              |
|------------|----------------------------------------------------------|
| x          | The amount by which to move the Transform on the x-axis. |
| y          | The amount by which to move the Transform on the y-axis. |
| z          | The amount by which to move the Transform on the z-axis. |
| relativeTo | Defines the coordinate system used for the translation.  |

### Description

Moves the transform by x along the x axis, y along the y axis, and z along the z axis.

The movement is applied relative to /relativeTo/'s local coordinate system. If `relativeTo` is null, the movement is applied relative to the world coordinate system.

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

}
```
