---
title: "FAQ for input and event systems with UI Toolkit"
page_title: "Unity - Manual: FAQ for input and event systems with UI Toolkit"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-faq-event-and-input-system.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-faq-event-and-input-system.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# FAQ for input and event systems with UI Toolkit

This page includes frequently asked questions for using the event system and the input system with UI Toolkit.

1.  [How do I know if the mouse is over a visual element from a runtime panel?](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-faq-event-and-input-system.html#mouse-over)
2.  [How can I remap basic UI actions?](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-faq-event-and-input-system.html#remap)
3.  [How can I change what element is focused next when using directional navigation?](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-faq-event-and-input-system.html#directional-nav)
4.  [Is it possible to get rid of WASD inputs for directional navigation or space bar for the submit action?](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-faq-event-and-input-system.html#wasd)
5.  [How can I start entering keyboard input without ever clicking anywhere with the mouse?](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-faq-event-and-input-system.html#enter-keyboard)

<span id="mouse-over"></span>

## How do I know if the mouse is over a visual element from a runtime panel?

To find if the mouse is over a visual element from a runtime panel, use one of the following two methods:

-   Method 1 uses the Event System for automatic detection and works well with mixed uGUI and UI Toolkit UI.
-   Method 2 gives you manual control and is useful if you need to handle multiple panels yourself.

### Method 1: Use Event System

UI Toolkit elements, such as Button or Label, are not GameObjects, so they don’t cast or assign a VisualElement to a GameObject variable. Use the Event System to find the panel, then use UI Toolkit APIs to find the visual element under the pointer.

1.  Add an Event System component in your scene the same way as you create GameObject-based UI content from the [`com.unity.uGUI`](https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.ugui.html) package.

2.  Use the [`EventSystem.current.IsPointerOverGameObject`](https://docs.unity3d.com/Packages/com.unity.ugui@1.0/api/UnityEngine.EventSystems.EventSystem.html?q=eventsystem#UnityEngine_EventSystems_EventSystem_IsPointerOverGameObject) method, which returns `true` if the pointer is over UI content from either uGUI or from UI Toolkit.

3.  To list exactly what objects are under the pointer, use the [`EventSystem.current.RaycastAll`](https://docs.unity3d.com/Packages/com.unity.ugui@1.0/api/UnityEngine.EventSystems.EventSystem.html?q=eventsystem#UnityEngine_EventSystems_EventSystem_RaycastAll_UnityEngine_EventSystems_PointerEventData_System_Collections_Generic_List_UnityEngine_EventSystems_RaycastResult__) method.

4.  Find the panel under the pointer. Each intersected UI Toolkit panel is represented by a GameObject in the Event System’s environment:

    -   The GameObject’s name matches the corresponding PanelSettings.
    -   The GameObject’s parent is the GameObject that holds the current Event System component.
    -   The GameObject has two components, `PanelRaycaster` and `PanelEventHandler`. Both components have a `panel` property that returns the `IPanel` it targets.

5.  Call the [`panel.Pick`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.IPanel.Pick.html) method to find what visual element is at the pointer’s position.

6.  Use the [`RuntimePanelUtils.ScreenToPanel`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.RuntimePanelUtils.ScreenToPanel.html) method to transform the pointer’s screen coordinates into panel coordinates.

    **Note**: uGUI uses a bottom-left origin for screen coordinates, while UI Toolkit uses a top-left origin. To convert between them, mirror the Y coordinate: `yTopLeft = Screen.height - yBottomLeft`.

### Method 2: Manual panel search

1.  Make a list of all the active panels in your scene. To do this, iterate through all `UIDocument` components in your scene and add `uiDocument.rootVisualElement.panel` to the list. If multiple documents share the same PanelSettings, include only one document for each distinct PanelSettings value.
2.  Iterate through the list of panels in order of depth from topmost to bottommost.
3.  For each panel, call [`panel.Pick`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.IPanel.Pick.html) until you find one that returns a visual element.

<span id="remap"></span>

## How can I remap basic UI actions?

To remap basic UI actions:

1.  Add an Event System component in your scene the same way as you create GameObject-based UI content from the [`com.unity.uGUI`](https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.ugui.html) package.
2.  In the Inspector window, configure the **Stand alone Input Module** or **Input System UI Input Module** fields to control what input maps to each action.

**Note**: The actions mapped to Tab and Shift+Tab inputs can’t be remapped because they’re not exposed through the Event System input modules.

<span id="directional-nav"></span>

## How can I change what element is focused next when using directional navigation?

You can configure directional navigation to have other targets other than the default ones.

The following code example allows element A to navigate to elements U, D, L, R when navigating up, down, left, and right respectively:

``` lang-cs
A.RegisterCallback <NavigationMoveEvent>(e =>

    e.StopPropagation(); // Prevent further processing of the event
    A.focusController.IgnoreEvent(e); // Prevent default navigation
});
```

<span id="wasd"></span>

## Is it possible to get rid of WASD inputs for directional navigation or space bar for the submit action?

Yes. You can use the EventSystem’s **StandaloneInputModule** or **InputSystemUIInputModule** fields in the Inspector window to control what input maps to each action. However, since these actions are shared with uGUI input, this also changes the uGUI controls.

To remap UI Toolkit inputs without affecting uGUI controls, disable UI Toolkit’s runtime event handling and send all events manually to panels. To do so, call `EventSystem.SetUITookitEventSystemOverride(null, false, false);` before the start method of your current EventSystem kicks in, such as the `Awake` method of the component of your scene. For more information about this uGUI method, refer to [SetUITookitEventSystemOverride](https://docs.unity3d.com/Packages/com.unity.ugui@1.0/api/UnityEngine.EventSystems.EventSystem.html?q=eventsystem#UnityEngine_EventSystems_EventSystem_SetSelectedGameObject_UnityEngine_GameObject_).

<span id="enter-keyboard"></span>

## How can I start entering keyboard input without ever clicking anywhere with the mouse?

It’s possible that no element or panel is in focus at a given time, such as when loading your game scene for the first time. In this case, keyboard navigation doesn’t start from a predictable first element. This can be a problem for a game that plays entirely without a mouse.

To allow a predictable navigation behavior from the start, add a C# script and attach it to the same GameObject as the UIDocument responsible for the element that you choose to get the initial focus.

Assume your script is named `FirstFocus` and your initial focused element is named as `first-focused`. In your script’s `Start()` method, add a line to focus that element as the following:

``` lang-cs
public class FirstFocus : MonoBehaviour

    public void FocusFirstElement()
    
}
```

**Note**: If you disable the UIDocument’s GameObject, all its underlying hierarchy is recreated from scratch. Therefore, you must run your custom `FocusFirstElement()` method again after you re-enable the GameObject.

## Additional resources

-   [Get started with runtime UI](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-get-started-with-runtime-ui.html)
-   [Render UI in the Game view](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-render-runtime-ui.html)
-   [The Panel Settings asset](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Runtime-Panel-Settings.html)
-   [Runtime event system](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Runtime-Event-System.html)
-   [Control behavior with Events](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Events.html)
-   [Handle events](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Events-Handling.html)
