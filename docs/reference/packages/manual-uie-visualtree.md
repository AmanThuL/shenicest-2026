---
title: "Introduction to visual elements and the visual tree"
page_title: "Unity - Manual: Introduction to visual elements and the visual tree"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-VisualTree.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-VisualTree.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to visual elements and the visual tree

The most basic building block in UI Toolkit is a visual element. The visual elements are ordered into a hierarchy tree with parent-child relationships. This is called the visual tree.

The diagram below displays a simplified example of the visual tree, and the rendered result in UI Toolkit.

![Simplified hierarchy of the visual tree](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/VisualTreeExample.png)

The Root in the diagram represents the [`EditorWindow.rootVisualElement`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorWindow-rootVisualElement.html) in the Editor UI and the [`UIDocument.rootVisualElement`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.UIDocument-rootVisualElement.html) in a runtime UI.

The [`VisualElement`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualElement.html) class is the base for all nodes in the visual tree. The `VisualElement` base class contains properties such as styles, layout data, and event handlers. Visual elements can have children and descendant visual elements. For example, in the diagram above, the first `Box` visual element has three child visual elements: `Label`, `Checkbox`, and `Slider`.

You can customize the appearance of visual elements through inline styles and stylesheets. You can also use event callbacks to modify the behavior of a visual element.

[`VisualElement`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualElement.html) derives into subclasses that define additional behavior and functionality, such as controls. UI Toolkit includes a variety of built-in controls with specialized behavior. A control is an element of a graphical user interface. For example, the following items are available as built-in controls:

-   [Buttons](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uxml-element-Button.html)
-   [Toggles](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uxml-element-Toggle.html)
-   [Text input fields](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uxml-element-TextField.html)

A control includes the visual of the control, and the scripted logic to operate and interact with the control. It can consist of a single visual element, or a combination of multiple visual elements. For example, the Toggle control contains three elements:

-   A text label
-   An image of a box
-   An image of a checkmark

![Toggle control](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uie-toggle-control.png)

The implementation of the Toggle control defines the behavior of the control. It has an internal value of whether the toggle state is true or false. This logic alternates the visibility of the checkmark image when the value changes.

You can also combine visual elements together and modify their behavior to create [custom controls](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-create-custom-controls.html).

To use a control in a UI, add it to the visual tree.

## Additional resources

-   [Structure UI with UXML](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UXML.html)
-   [Structure UI with C# scripts](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Controls.html)
-   [UXML elements Reference](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-ElementRef.html)
