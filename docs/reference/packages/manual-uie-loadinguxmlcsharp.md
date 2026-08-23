---
title: "Instantiate UXML from C# scripts"
page_title: "Unity - Manual: Instantiate UXML from C# scripts"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-LoadingUXMLcsharp.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-LoadingUXMLcsharp.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Instantiate UXML from C# scripts

To build UI from a UXML file:

1.  [Load the file into a `VisualTreeAsset`](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-manage-asset-reference.html),.
2.  Use either:
    -   [`Instantiate()`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualTreeAsset.Instantiate.html) to instantiate without a parent, which creates a new `TemplateContainer`.
    -   [`CloneTree(parent)`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualTreeAsset.CloneTree.html) to clone inside a parent.

Once the UXML is instantiated, you can retrieve specific elements from the visual tree with [UQuery](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UQuery.html).

The following example creates a custom Editor window and loads a UXML file as its content:

``` lang-cs
using UnityEditor;
using UnityEngine;
using UnityEngine.UIElements;
using UnityEditor.UIElements;

public class MyWindow : EditorWindow  
}
```

To load UXML assets for runtime, [set up `VisualTreeAsset` references in your MonoBehaviour scripts](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-manage-asset-reference.html) and assign the UXML assets from the Inspector. For more information and an example, refer to [Support for runtime UI](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-support-for-runtime-ui.html) and [Create a list view runtime UI](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-HowTo-CreateRuntimeUI.html).

## Additional resources

-   [Load UXML and USS from C# scripts](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-manage-asset-reference.html)
-   [UQuery](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UQuery.html)
