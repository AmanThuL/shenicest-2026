---
title: "Structure UI with C# scripts"
page_title: "Unity - Manual: Structure UI with C# scripts"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Controls.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Controls.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Structure UI with C# scripts

Technical users can define the layout of the UI directly in C# scripts.

You can define the look of controls in a [USS](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS.html) file, or [modify the style properties of the control in your C# script](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-apply-styles-with-csharp.html).

Controls are interactive and represent a value that you can change. For example, a `FloatField` represents a float value. You can create C# scripts to change the value of a control, register a callback, or apply data binding.

## Add controls to a UI with C# scripts

To use a control in a UI, add it to the [visual tree](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-VisualTree.html).

The following example adds a Button control to an existing visual tree.

``` lang-cs
var newButton = new Button("Click me!");
rootVisualElement.Add(newButton);
```

When adding controls to a UI hierarchy, the [layout engine](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-LayoutEngine.html) automatically handles the sizing and positioning. You can also [override the size and position of visual elements](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-VisualTree.html).

## Change the control value

To access or change the value of a control, use its `value` property.

The following example creates a Toggle control and a Button control. When you click the button, the value of the toggle flips.

``` lang-cs
// Create a toggle and register callback
m_MyToggle = new Toggle("Test Toggle") { name = "My Toggle" };
rootVisualElement.Add(m_MyToggle);

// Create button to flip the toggle's value
Button button01 = new Button() { text = "Toggle" };
button01.clicked += () =>
{
    m_MyToggle.value = !m_MyToggle.value;
};
rootVisualElement.Add(button01);
```

For more information about the properties of a specific control, see [UI Toolkit built-in controls reference](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-ElementRef.html#built-in-controls).

## Register a callback

Controls that have `value` properties send an event if the value changes. You can register a callback to receive this event.

The following example creates a Toggle control and registers a callback:

``` lang-cs
// Create a toggle and register callback
m_MyToggle = new Toggle("Test Toggle") { name = "My Toggle" };
m_MyToggle.RegisterValueChangedCallback((evt) => { Debug.Log("Change Event received"); });
rootVisualElement.Add(m_MyToggle);
```

To learn more about callbacks and events, see [Events Handling](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Events-Handling.html).

## Apply data binding

You can bind controls to an object or a serialized property. For example, you can bind a FloatField control to a public float variable that belongs to a `MonoBehaviour`. When the control binds to the property, it automatically displays the value of the property. When you modify the control, the value of the property updates.

Similarly, when the property value changes through code, the UI displays the updated value. This two-way connection is useful when you create custom Inspector windows.

For more information about data binding, see [SerializedObject data binding](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Binding.html).

Not all controls are bindable. For a list of built-in controls and whether they support binding, see [UI Toolkit built-in controls reference](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-ElementRef.html#built-in-controls).

<span id="access-properties-of-a-controls-read-only-children"></span>

## Access properties of a control’s read-only children

Some controls have [read-only child elements](https://docs.unity3d.com/6000.3/Documentation/Manual/UIB-structuring-ui-elements.html#read-only-elements). For example, a `ListView` control has a `ScrollView` child. You can use [UQuery](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UQuery.html) to access the child’s properties and override their values.

The following example changes the scroll speed of a `ListView` control by overriding the `mouseWheelScrollSize` property of the `ScrollView` child:

``` lang-cs
var scrollView = listView.Q<ScrollView>();
scrollView.mouseWheelScrollSize = 55;
```

## Manage control states

Controls have different states that you can manage in your C# scripts. For example, you can enable or disable a control.

The following example creates a Toggle control and a Button control. When you click the button, the toggle is disabled.

``` lang-cs
// Create a toggle.
Toggle myToggle = new Toggle("A Toggle");

// Create a button to disable the toggle.
Button button01 = new Button();
button01.text = "Button01";
button01.RegisterCallback<ClickEvent>(evt =>
{
    myToggle.SetEnabled(false);
});
```

You can also implement a visual feedback change when the state changes in USS using the [pseudo-classes](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-Pseudo-Classes.html). For example, to disable a toggle, use a selector that has the `disabled` pseudo state:

``` lang-css
.unity-button:disabled

```

## Additional resources

-   [Structure UI with UXML](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UXML.html)
-   [Work with elements](https://docs.unity3d.com/6000.3/Documentation/Manual/UIB-structuring-ui-elements.html)
