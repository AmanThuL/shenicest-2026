---
title: "Runtime data binding"
page_title: "Unity - Manual: Runtime data binding"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-runtime-binding.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-runtime-binding.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Runtime data binding

Runtime data binding binds the properties of any plain C# `object` to the properties of a UI control. You can use this type of data binding in both the runtime and Editor UI. However, for serialized data in the Editor UI, use the [SerializedObject data binding](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-editor-binding.html) because it provides better support for Unity’s [serialization system](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization.html), including undo/redo functionality and multi-selection operations.

| **Topic**                                                                                                                             | **Description**                                                                                                      |
|:--------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------|
| [Get started with runtime binding](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-get-started-runtime-binding.html)         | Learn the basics of runtime binding from an example.                                                                 |
| [Create a runtime data binding in C# scripts](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-runtime-binding-types.html)    | Create a runtime data binding.                                                                                       |
| [Define a data source](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-runtime-binding-define-data-source.html)              | Understand how to define a data source for runtime binding, which can be any C# types.                               |
| [Define binding modes and update triggers](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-runtime-binding-mode-update.html) | Define binding modes and update triggers to configure how changes are replicated between the data source and the UI. |
| [Convert data types](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-runtime-binding-data-type-conversion.html)              | Add type converters to convert data types between the data source and the UI.                                        |
| [Define logging levels](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-runtime-binding-logging-levels.html)                 | Define logging levels to debug runtime bindings.                                                                     |
| [Create custom binding types](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-runtime-binding-custom-types.html)             | Create custom binding types and attributes.                                                                          |
| [Runtime binding example](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-runtime-binding-examples.html)                     | Learn how to create a runtime binding from examples.                                                                 |

## Additional resources

-   [SerializedObject data binding](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-editor-binding.html)
