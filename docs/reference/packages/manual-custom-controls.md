---
title: "UI Toolkit BPG - Custom controls"
page_title: "Unity - Manual: Custom controls"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/custom-controls.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/custom-controls.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Custom controls

Table of Contents

-   [The UxmlElement attribute](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/custom-controls.html#the-uxmlelement-attribute)

-   [The UxmlAttribute attribute](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/custom-controls.html#the-uxmlattribute-attribute)

-   [Example: A custom slide toggle control](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/custom-controls.html#example-a-custom-slide-toggle-control)

-   [Create more custom controls](https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/custom-controls.html#create-more-custom-controls)

UI Toolkit offers a standard set of elements for building interfaces, but you can also create custom controls tailored to your application’s needs.

For instance, a custom health bar could change color based on health value, animating from green to yellow and red as health decreases. It could be repurposed across characters without extra setup – or even used to represent other stats, like mana or power. This encapsulated control would offer a clear visual upgrade to the slider from the UI Toolkit standard library.

Custom controls let you encapsulate functionality into standalone elements, making them reusable across different parts of your interface. Well-designed controls are abstract, self-contained, and support code reuse, helping simplify project maintenance. When implementing custom controls, avoid using them with elements tied to specific components that lack standalone functionality (e.g., game menus).

<span id="the-uxmlelement-attribute"></span>

## The UxmlElement attribute

To create a custom control, start by defining a new C# script that inherits from the [VisualElement](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualElement.html) class – or a subclass that closely matches what you want to create. Want a button-like control? Just inherit from the [Button](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.Button.html) class.

To make your custom control available in UXML and the UI Builder, add the UxmlElement attribute to your class. Ensure that the custom element is defined as a public partial class:

``` lang-csharp
[UxmlElement]
public partial class ExampleElement: VisualElement

```

Your custom control will then appear in the Library section under the **Custom Controls (C#)** category in the UI Builder. You can then drag it into UI Builder’s Hierarchy window.

![Custom controls appear in the UI Builder Library.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image215.png)

**Note:** Because visual elements aren’t GameObjects, they don’t have the usual lifecycle events like `Awake`, `OnEnable`, `OnDisable`, and `OnDestroy`. Instead, you initialize a custom control using its constructor.

``` lang-csharp
[UxmlElement]
public partial class ExampleElement: VisualElement

}
```

You can also delay initialization until the custom control is added to the UI. To do this, register a callback for an [AttachToPanelEvent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.AttachToPanelEvent.html).

To detect that your custom control has been removed from the UI, use the [DetachFromPanelEvent](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.DetachFromPanelEvent.html) callback.

<span id="the-uxmlattribute-attribute"></span>

## The UxmlAttribute attribute

Adding the **UxmlAttribute** attribute to a property makes it appear in the UI Builder’s Inspector window. This allows you to set initial values interactively. UxmlAttributes can be helpful when working with a designer, as changes in the Inspector don’t require modifying code.

Apply the UxmlAttribute attribute to each property you want to expose. You can also customize attribute names with the **name** argument.

Selecting the control in the Hierarchy will display your custom attributes in the Inspector window, allowing you to configure them directly.

Decorator attributes can modify your custom attribute fields much like working with MonoBehaviours. Useful decorator attributes include TextArea, Tooltip, Range, Header, Min, Multiline, Space, and Delayed. For example, using the Range attribute adds a slider for selecting values within a range.

![Custom attributes appear in the UI Builder’s Inspector](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image191.png)

Here’s a basic example of adding the UxmlElement attribute to a custom control, which includes two exposed properties using the UxmlAttribute attribute.

``` lang-csharp
[UxmlElement]
public partial class ExampleElement: VisualElement

    [UxmlAttribute]
    public int myIntValue 
}
```

In this example, `MyStringValue` appears as **“My Text”** in the Inspector using the **name** parameter. Both `MyStringValue` and `MyIntValue` are editable in the Inspector whenever an instance of ExampleElement is selected in the Hierarchy.

**Note:** Before Unity 6, creating custom controls required implementing **UxmlTraits** and **UxmlFactory** classes, which handled attribute registration and object instantiation for custom elements.

Unity 6 simplifies custom element creation by introducing UxmlElement and UxmlAttribute attributes. These directly expose custom controls and properties in UXML and the UI Builder. This new workflow reduces the amount of boilerplate code and makes it faster to customize UI elements.

<span id="example-a-custom-slide-toggle-control"></span>

## Example: A custom slide toggle control

An example of a simple custom control could be a slide toggle, a switch-like element representing a boolean value.

This might offer a more engaging experience than a standard toggle. Adding extra visual feedback, such as an animated switch, changing color, and dynamic text, can result in a more intuitive UI.

![The custom slide toggle control represents a boolean value](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image106.png)

### Define the custom control

In the QuizU project, you can find a simple implementation of this custom control in the **CustomControlsDemo** scene. Open the **SlideToggle.cs** script to see how it works (snippets shown below).

The slide toggle custom control inherits from the most suitable base class – **`BaseField<bool>`** in this case. The UxmlElement attribute exposes the control in UXML and the UI Builder, making it reusable.

``` lang-csharp
[UxmlElement]
public partial class SlideToggle : BaseField<bool>
{
   // …

   [UxmlAttribute]
   public string EnabledText { get; set; } = "Enabled";

   [UxmlAttribute]
   public string DisabledText { get; set; } = "Disabled";
  
   [UxmlAttribute]
   public Color EnabledBackgroundColor { get; set; } = new Color(0f, 0.5f, 0.85f,1f);

   [UxmlAttribute]
   public Color DisabledBackgroundColor { get; set; } = Color.gray;
}   
```

The visual structure consists of a background (`m_Input`) and a knob (`m_Knob`), with USS classes defining the appearance.

``` lang-csharp
public SlideToggle(string label) : base(label, new VisualElement())

```

Event handling is implemented to respond to clicks, key presses, and navigation events. This allows multiple ways to change its state.

``` lang-csharp

static void OnClick(ClickEvent evt)

static void OnKeydownEvent(KeyDownEvent evt)

}
```

The label and background color update automatically as the user toggles the switch, providing visual feedback.

Here we use `SetValueWithoutNotify` to update the visual state of the toggle without triggering a `ChangeEvent`. Since this method is called internally when the value changes, the UI updates correctly without causing an infinite loop of updates.

``` lang-csharp
public override void SetValueWithoutNotify(bool newValue)

```

Explore the sample implementation in the **CustomControlsDemo** scene. Click the element with the mouse or press the Enter or Space key to toggle its active state. In this sample, the label and background color update dynamically as the user toggles the slide control, with a quick animation providing visual feedback.

Use the Inspector to set string labels and background colors that correspond to the enabled and disabled state.

![Customize the slide toggle text and colors.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image29.png)

### Use the slide toggle

Once compiled, the slide toggle is now ready to integrate into any part of your UI. Use the custom `SlideToggle` class just like any other visual element. Here’s an example implementation that uses the `SlideToggle` class to mute or unmute the sound:

``` lang-csharp
// Example usage in a MonoBehaviour

public class MuteAudioToggle : MonoBehaviour

}
}
```

In this case, the SlideToggle is part of an existing UXML document. The MonoBehaviour locates it by name within the visual tree and then uses the `RegisterValueChangedCallback` method to link the toggle state to the audio settings.

Since SlideToggle is a standalone custom element, you can use it for any kind of toggle switch in your UI. For example, in the [UI Toolkit - *Dragon Crashers* sample](https://assetstore.unity.com/packages/essentials/tutorial-projects/dragon-crashers-ui-toolkit-sample-project-231178?srsltid=AfmBOoqA2Wc-O_SUJZitEq3RljmBSbtkpSkVqTb-DhG9G_XsLEnXagbe#reviews), a similar SlideToggle enables and disables the fps counter.

![The stylized slide toggle from *UI Toolkit Sample – Dragon Crashers*](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image52.png)

Customize the SlideToggle to fit your application’s requirements – it’s ideal for settings like visuals, sound, or gameplay options. Build it once, then reuse it wherever a custom switch can enhance the user experience.

For a full implementation, refer to the **SlideToggle.cs** script in the QuizU project.

<span id="create-more-custom-controls"></span>

## Create more custom controls

If there’s a control that’s not included in the standard UI Toolkit library, you can create your own. Here are just a few examples to get you thinking about how you can deploy custom controls in your own games:

-   **Health bars/progress bars:** Game attributes like health, mana, power, etc. can vary widely based on gameplay, making them great candidates for custom controls. Expose UxmlAttributes like max value, current value, and status colors to add options for color gradients.

-   **Rating stars:** This control functions like a segmented progress bar, representing an integer value (e.g. stars for completing a level). Start with a visual element with several child elements that can switch between filled and unfilled states. Expose an int with a max value in the Inspector and allow the user to customize the sprite images with UxmlAttributes.

-   **Tab view control:** A tabbed interface is a common UI for switching between different views or sections within the same window. Implement this by creating a custom element with a row of tabs and a content area. Each tab can be a button-like visual element, with options to add or remove tabs dynamically.

Remember that in most cases, you can also trigger USS transitions to add visual flair with animations. With custom controls, your users can pinch, click, scroll, and toggle through your unique game UIs.

We can’t wait to see what you make with them.
