---
title: "Test conditional compilation"
page_title: "Unity - Manual: Test conditional compilation"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-conditional-compilation.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/test-conditional-compilation.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Test conditional compilation

The following example shows how to test your conditionally compiled code. It also prints a message based on the platform selected for the target build.

<span id="Sample"></span>

## Sample code

``` lang-cs
  using UnityEngine;
  using System.Collections;
  public class PlatformDefines : MonoBehaviour 
  } 
```

## Test instructions

1.  Open the **Build Profiles** window (menu: **File** > **Build Profiles**).
2.  Check that the platform you want to test your code on is the Active platform profile. If it isn’t, select your preferred platform and click **Switch Profile**.
3.  Create a [script](https://docs.unity3d.com/6000.3/Documentation/Manual/creating-scripts.html) and copy and paste the [sample code](https://docs.unity3d.com/6000.3/Documentation/Manual/test-conditional-compilation.html#Sample).
4.  In the [Game view](https://docs.unity3d.com/6000.3/Documentation/Manual/GameView.html) toolbar, click the Play button to enter Play mode. Confirm that the code works by checking for messages relevant to the platform selected in the Unity console. For example, if you choose iOS, the messages `Unity Editor` and `Unity iOS` appear in the console.

## Additional resources

-   [Unity scripting symbol reference](https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-symbol-reference.html)
-   [Custom scripting symbols](https://docs.unity3d.com/6000.3/Documentation/Manual/custom-scripting-symbols.html)
