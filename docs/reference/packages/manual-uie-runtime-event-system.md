---
title: "Runtime UI event system and input handling"
page_title: "Unity - Manual: Runtime UI event system and input handling"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Runtime-Event-System.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Runtime-Event-System.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Runtime UI event system and input handling

UI Toolkit uses an event system to handle input and send events to all active panels. This system processes input events and sends them to the appropriate elements in the UI.

When you enter Play mode, UI Toolkit creates a default event system that is not part of any scene, and provides basic support for most input devices. That default event system is used if there is no other active event system to replace it.

Refer to [Use UI Toolkit and uGUI with different input systems](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Runtime-Event-System.html#ugui-input) for more information on how to use the **EventSystem** component to replace UI Toolkit’s default event system.

## Use UI Toolkit with different input systems

Unity provides two input handling systems: the legacy [Input Manager](https://docs.unity3d.com/6000.3/Documentation/Manual/class-InputManager.html) and the new [Input System package](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.8/manual/index.html). The Input Manager is part of the core Unity platform and serves as the default system unless you install the Input System package. The new Input System package provides greater flexibility and broader support for devices and platforms.

If you use Unity 6000.0+, your project might already include the Input System package—for example, when you create the project from a template that adds it. Having the package in the project doesn’t by itself change runtime input to the new Input System. To view or change what Unity uses at runtime, set **Active Input Handling** in **Player** settings as described in [Set the active input handling system](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Runtime-Event-System.html#set-the-active-input-handling-system).

UI Toolkit’s default event system can receive events from both input systems. It automatically detects the active input handling system and processes events accordingly.

<span id="set-the-active-input-handling-system"></span>

### Set the active input handling system

To set the active input handling system in your project:

1.  Select **Edit** > **Project Settings** > **Player**.

2.  In the **Player** window, under **Other Settings** > **Configuration**, set **Active Input Handling** to one of the following options:

    -   **Input Manager (Old)**: Use the legacy Input Manager.
    -   **Input System Package (New)**: Use the Input System package.
    -   **Both**: Use the Input System package if available, otherwise fall back to the legacy Input Manager.

If the Input System package is active in your project, UI Toolkit automatically derives its events from actions defined in the input system. To [configure those actions](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.8/manual/ActionsEditor.html), go to **Edit** \> **Project Settings** \> **Input System Package**.

### Set up input handling with the Input Manager

To set up input handling with Input Manager, go to **Edit** \> **Project Settings** \> **Input Manager**.

![Input Manager settings](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uitk/input-manager-nav.png)

You can configure the **Horizontal** and **Vertical** axes to influence how [`NavigationMoveEvents`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.NavigationMoveEvent.html) are generated in UI Toolkit. You can also modify the **Submit** and **Cancel** actions to generate [`NavigationSubmitEvent`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.NavigationSubmitEvent.html) and [`NavigationCancelEvent`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.NavigationCancelEvent.html) in UI Toolkit.

<span id="set-up-input-handling-with-the-input-system-package"></span>

### Set up input handling with the Input System package

To set up input handling with the Input System package, go to **Edit** \> **Project Settings** \> **Input System Package**.

![Input System settings](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uitk/input-system-nav.png)

The Input System package offers enhanced configurability compared to Input Manager. You can use the project-wide actions asset to set up how `NavigationMoveEvents`, [`PointerMoveEvent`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PointerMoveEvent.html) (“UI / Point” action), [`PointerDownEvent`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PointerDownEvent.html), [`PointerUpEvent`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PointerUpEvent.html) (“UI / Click”), [`WheelEvent`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.WheelEvent.html) (“UI / ScrollWheel”), `NavigationSubmitEvent`, and `NavigationCancelEvent` are generated for UI Toolkit.

Refer to the Input System package’s [UI Support](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.11/manual/UISupport.html) documentation for more information about each individual action.

<span id="ugui-input"></span>

## Use UI Toolkit and uGUI with different input systems

You can use UI Toolkit’s UI Documents and uGUI components at the same time. To do so, add an **EventSystem** component to the scene using one of the following:

-   In the **Hierarchy** view, select **UI** > EventSystem.
-   Create any uGUI component.

When you use UI Toolkit with an **EventSystem** component, you need to choose an appropriate input module for the input system that’s active in your project.

The following tables outline the required components and settings when you use UI Toolkit with the legacy Input Manager, with the Input System package, or together with uGUI.

### UI Toolkit with the legacy Input Manager

| **Usage**                                                  | **Required components**                                        | **Active Input Handling**           |
|:-----------------------------------------------------------|:---------------------------------------------------------------|:------------------------------------|
| **UI Toolkit only** (no uGUI **EventSystem** in the scene) | Default event system (no scene component required)             | **Input Manager (Old)**             |
| **UI Toolkit and uGUI**                                    | A **Standalone Input Module** and an **EventSystem** component | **Input Manager (Old)** or **Both** |

### UI Toolkit with the Input System package

| **Usage**                                                  | **Required components**                                              | **Active Input Handling**                  |
|:-----------------------------------------------------------|:---------------------------------------------------------------------|:-------------------------------------------|
| **UI Toolkit only** (no uGUI **EventSystem** in the scene) | Default event system (no scene component required)                   | **Input System Package (New)** or **Both** |
| **UI Toolkit and uGUI**                                    | An **Input System UI Input Module** and an **EventSystem** component | **Input System Package (New)** or **Both** |

### UI Toolkit with uGUI (legacy Input Manager or Input System package)

Use this table when you mix UI Toolkit with uGUI and need an **EventSystem** in the scene. Match the input module to **Active Input Handling** in **Player** settings.

| **Active input backend** | **Required components**                                              | **Active Input Handling**                  |
|:-------------------------|:---------------------------------------------------------------------|:-------------------------------------------|
| **Legacy Input Manager** | A **Standalone Input Module** and an **EventSystem** component       | **Input Manager (Old)** or **Both**        |
| **Input System package** | An **Input System UI Input Module** and an **EventSystem** component | **Input System Package (New)** or **Both** |

### EventSystem setup and input modules

When you add your first uGUI element to the scene, an [**EventSystem**](https://docs.unity3d.com/Packages/com.unity.ugui@3.0/manual/script-EventSystem.html) and a [**Standalone Input Module**](https://docs.unity3d.com/Packages/com.unity.ugui@3.0/manual/script-StandaloneInputModule.html) are automatically added to the scene.

The **EventSystem** belongs to uGUI. It’s responsible for uGUI events, derived from either legacy Input Manager or the Input System package, through an interchangeable Input Module component.

The **Standalone Input Module** dispatches events to UI Toolkit elements.

If your project includes the Input System package and you set **Active Input Handling** to **Input System Package (New)** or **Both**, Unity adds an [**Input System UI Input Module**](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.8/manual/UISupport.html) instead of the **Standalone Input Module**. The **Input System UI Input Module** and its accompanying **EventSystem** ensure that the events from both UI Toolkit and uGUI elements are properly dispatched.

The **EventSystem** is responsible for reading the scene and executing events, while the **Input System UI Input Module** processes input and initiates event execution. You can change the **Standalone Input Module** or **Input System UI Input Module** with other input modules, which can alter the type of input consumed. Regardless of the input module used, all events are executed through the **EventSystem**.

### Bridge components and built-in input

If you add and enable a uGUI **EventSystem** in the scene, UI Toolkit detects it and creates two uGUI-compatible components for each UI Toolkit panel: [`PanelRaycaster`](https://docs.unity3d.com/Packages/com.unity.ugui@3.0/api/UnityEngine.UIElements.PanelRaycaster.html) and [`PanelEventHandler`](https://docs.unity3d.com/Packages/com.unity.ugui@3.0/api/UnityEngine.UIElements.PanelEventHandler.html). These components serve as intermediaries between uGUI events and UI Toolkit events. The presence of these components deactivates the UI Toolkit’s automated, built-in input processing. This means that the UI Toolkit relies on these components to handle input events when they are present.

### Pointer routing, panel order, and focus

If the scene uses more than one Panel Settings asset, the event system dispatches pointer events to their panels based on their sorting order. UI Toolkit determines the recipient of pointer events by comparing the sorting order of its panel with that of uGUI canvases and other valid raycast targets. This process decides whether a UI Toolkit element, a uGUI object, or another object in the scene receives the event. Similarly, UI Toolkit uses `currentSelectedGameObject` of the **EventSystem** to manage the focus. When a UI Toolkit panel wants to get focus, it removes the focus from other uGUI objects, and when a uGUI object becomes selected, UI Toolkit panels automatically lose their focus.

A pointer event propagates through the panels until a panel responds to it. The first panel that uses an event to affect the focused element becomes the focused panel for the event system. This panel continues to receive keyboard events until another event causes a different panel to become the focused panel.

### Focus behavior and delayed focus requests

**Note:** Stopping an event’s propagation and giving an element focus are distinct actions. For example, when you click a button, it stops the propagation and allows only the button to respond to the press, but it doesn’t prevent other default click actions, such as giving focus to the button or any clicked focusable element.

In some cases, you might need to add a one-frame delay after input is processed before requesting focus for an element, especially if that input affects focus through other code paths, as shown in the following example:

``` lang-cs
public class FocusOnNextFrameExample : MonoBehaviour
{
    void OnEnable()
    {
        var root = GetComponent<UIDocument>().rootVisualElement;
        root.Q<Button>("my-button").clicked += () =>
        {
            root.schedule.Execute(() => root.Q<TextField>("my-text-field").Focus());
        };
    }
}
```

## Additional resources

-   [Input System package](https://docs.unity3d.com/Packages/com.unity.inputsystem@1.8/manual/index.html)
-   [Get started with runtime UI](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-get-started-with-runtime-ui.html)
-   [Render UI in the Game view](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-render-runtime-ui.html)
-   [Panel Settings properties](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Runtime-Panel-Settings.html)
-   [FAQ for input and event systems with UI Toolkit](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-faq-event-and-input-system.html)
