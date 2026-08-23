---
title: "Data binding"
page_title: "Unity - Manual: Data binding"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-data-binding.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-data-binding.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Data binding

Data binding synchronizes properties of non-UI objects, such as a string property on a [MonoBehaviour](https://docs.unity3d.com/ScriptReference/MonoBehaviour.html), with properties of UI objects, such as the value property of a TextField. A binding refers to the link between the property and the visual control that modifies it. Use bindings to synchronize values between a property and a specific visual element, so you don’t need to write [event handlers](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Events-Handling.html) when the value changes in the UI.

UI Toolkit supports two types of data binding systems that you can use to create bindings for the Editor UI and the runtime UI.

| **Topic**                                                                                                             | **Description**                                                                                                                                                                                                         |
|:----------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Comparison of the binding systems](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-comparison-binding.html) | Compares the runtime binding and the SerializedObject data binding.                                                                                                                                                     |
| [Runtime data binding](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-runtime-binding.html)                 | Binds the properties of any plain C# `object` to the properties of a UI control. You can use this type of data binding in the runtime UI. You can also use it in the Editor UI as long as it’s not for serialized data. |
| [SerializedObject data binding](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-editor-binding.html)         | Binds the properties of a `SerializedObject` to the properties of a UI control. You can use this type of data binding only in the Editor UI.                                                                            |

## Additional resources

-   [Mini-tutorial: Data binding with UI Builder and C# in 5 minutes](https://discussions.unity.com/t/mini-tutorial-data-binding-with-ui-builder-and-c-in-5-minutes/1544817)
-   [Support for Editor UI](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-support-for-editor-ui.html)
-   [Support for runtime](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-support-for-runtime-ui.html)
-   <span aria-hidden="true">📖</span> **E-Book**: [UI Toolkit for advanced Unity developers - Data binding](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/data-binding.html)
