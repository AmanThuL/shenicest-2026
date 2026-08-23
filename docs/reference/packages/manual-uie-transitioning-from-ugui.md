---
title: "Migrate from uGUI to UI Toolkit"
page_title: "Unity - Manual: Migrate from uGUI to UI Toolkit"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Transitioning-From-UGUI.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Transitioning-From-UGUI.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Migrate from uGUI to UI Toolkit

This page guides developers with experience in uGUI (Unity UI) to transition to the new UI Toolkit system. It explores the similarities and differences between uGUI and the UI Toolkit.

As uGUI is a runtime-only UI system, this page focuses on runtime UI. UI Toolkit can create both runtime and Editor UI. This guide applies to both use cases for UI Toolkit.

## UI hierarchy

Both uGUI and UI Toolkit build and maintain the UI inside a hierarchy tree structure. In uGUI, all elements in this hierarchy are visible as individual GameObjects in the hierarchy view panel. In UI Toolkit, visual elements are organized into a [visual tree](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-VisualTree.html). The [visual tree](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-VisualTree.html) isn’t visible in the panel.

To view and debug the UI hierarchy in UI Toolkit, you can use the UI Debugger. You can find UI Debugger in the Editor toolbar, under **Window** \> **UI Toolkit** \> **Debugger**.

![UI Debugger](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIEDebugger.png)

## Key differences

### Canvas versus UIDocument

The `Canvas` component in uGUI is similar to the `UIDocument` component in UI Toolkit. Both are MonoBehaviours that attach to GameObjects.

In uGUI, a `Canvas` component sits at the root of the UI tree. It works with the `Canvas Scaler` component to determine the sort order, rendering, and scaling mode of the UI underneath.

In UI Toolkit, the `UIDocument` component contains a reference to a `PanelSettings` object. The `PanelSettings` contains the rendering settings for the UI, including the scale mode and the sort order. Multiple `UIDocument` components can point to the same `PanelSettings` object, which optimizes performance when using multiple UI screens in the same scene.

![Panel Settings](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIEPanelSettings.png)

In uGUI, the UI tree hierarchy sits underneath the GameObject holding the `Canvas` component. In UI Toolkit, the `UIDocument` component holds a reference to the root element of the Visual Tree.

The `UIDocument` component also contains a reference to the UXML file that defines the UI layout from which the Visual Tree is built at runtime. Refer to [Creating UI](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Transitioning-From-UGUI.html#creating-ui) section for more information.

**Note:** For Editor UI, no `UIDocument` component is needed. You can derive your custom class from `EditorWindow`, then implement `CreateGUI()`. For a practical example, refer to the guide on [Creating custom Editor windows](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-HowTo-CreateEditorWindow.html).

## GameObject components vs visual elements

UI Toolkit refers to UI elements as controls or visual elements. Examples of UI elements are:

-   Controls
-   Buttons
-   Text labels

uGUI builds the UI hierarchy from GameObjects. Adding new UI elements requires adding new GameObjects to the hierarchy. The individual controls are implemented as `MonoBehaviour` components.

In UI Toolkit, the [visual tree](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-VisualTree.html) is virtual and doesn’t use GameObjects. You can no longer build or view the UI hierarchy in the hierarchy view, but it removes the overhead of using a GameObject for each UI element.

In uGUI, UI elements derive (directly or indirectly) from the `UIBehavior` base class. Similarly, in UI Toolkit all UI elements derive from a base class called `VisualElement`. The key difference is the `VisualElement` class doesn’t derive from `MonoBehaviour`. You can not attach visual elements to GameObjects.

Working with UI Toolkit controls in the script is similar to working with uGUI controls.

The following table shows common script interactions with UI controls in uGUI, and their UI Toolkit counterparts.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Action</strong></th><th style="text-align: left;"><strong>uGUI</strong></th><th style="text-align: left;"><strong>UI Toolkit</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;">Write text into a label</td><td style="text-align: left;"><code>m_Label.text = "My Text";</code></td><td style="text-align: left;"><code>m_Label.text = "My Text";</code></td></tr><tr class="even"><td style="text-align: left;">Read the state of a toggle</td><td style="text-align: left;"><code>bool isToggleChecked = m_Toggle.isOn;</code></td><td style="text-align: left;"><code>bool isToggleChecked = m_Toggle.value;</code></td></tr><tr class="odd"><td style="text-align: left;">Assign a callback to a button</td><td style="text-align: left;"><code>m_Button.onClick.AddListener(MyCallbackFunc);</code></td><td style="text-align: left;"><code>m_Button.clicked += MyCallbackFunc_1;</code><br />
or<br />
<code>m_Button.RegisterCallback&lt;ClickEvent&gt;(MyCallbackFunc_2);</code></td></tr></tbody></table>

To learn more about controls and their properties and events, please see the **[Controls Overview](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Controls.html)** page.

### Access UI elements

In uGUI, there are two ways scripts can access UI elements:

-   Assigning a reference to the UI components in the Editor.
-   Finding the components in the hierarchy using helper functions such as `GetComponentInChildren<T>()`.

Since there are no GameObject or components in UI Toolkit, you can’t directly assign references to a control in the Editor. They must be resolved at runtime using a query function. Instead, access the Visual Tree via the `UIDocument` component.

`UIDocument` is a `MonoBehaviour`, so you can assign it as a reference and make it part of a Prefab. The `UIDocument` component holds a reference to the root visual element. From the root, scripts can find child elements by type or by name, similar to uGUI.

The table below shows a direct comparison of accessing UI controls in uGUI and UI Toolkit

| **Action**                                 | **uGUI**                                      | **UI Toolkit**                          |
|:-------------------------------------------|:----------------------------------------------|:----------------------------------------|
| Find UI element by name                    | `transform.FindChild("childName");`           | `rootVisualElement.Query("childName");` |
| Find UI element by type                    | `transform.GetComponentInChildren<Button>();` | `rootVisualElement.Query<Button>();`    |
| Direct assignment of a reference in Editor | Possible                                      | Not possible                            |

<span id="creating-ui"></span>

## Create UI

One of the biggest differences between uGUI and UI Toolkit is the creation of user interfaces.

Both uGUI and UI Toolkit allow you to visually build the UI and preview it in the Editor. In uGUI, the UI is then saved inside a Prefab, along with any logic scripts attached to individual UI controls.

In UI Toolkit, The UI layout is created in UI Builder, then saved as one or multiple UXML files. At runtime, `UIDocument` components load the UXML files that the Visual Tree assembles in memory.

For a method similar to uGUI, you can create UI controls directly from a script, then add them to a Visual Tree at runtime.

### Prefabs

uGUI uses GameObjects for individual UI controls and Prefabs that both contain visuals and logic. UI Toolkit takes a different approach to re-usability, as it separates logic and layout. You can create reusable UI components through UXML and custom controls.

To create a similar template to a Prefab in UI Toolkit:

1.  Create a UXML file for the partial UI element.
2.  Create a GameObject with a `UIDocument` component.
3.  Reference the UXML file in the GameObject.
4.  Add a script to handle the UI component logic to the same GameObject.
5.  Save the GameObject as a Prefab.

### UI layout

Arranging individual UI elements on screen in uGUI is a manual process. By default, UI controls are free floating and are only affected by their direct parent. Other UI controls under the same parent don’t affect their siblings positions or sizes. Pivots and anchors control the position and size of an element.

The UI Toolkit layout system is influenced by web design, and based on automatic layout generation. The automatic layout system affects all elements by default, and an element’s size and position will affect other elements under the same parent.

The default behavior in UI Toolkit is comparable to placing all elements inside a `VerticalLayoutGroup` in uGUI, and adding a `LayoutElement` component to each.

You can disable automatic layout generation by changing the [IStyle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.IStyle.html) `position` property of the visual element. All visual elements have this property. See [Visual Tree](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-VisualTree.html) for a code sample.

UI Toolkit has no direct equivalents for anchoring and pivots of UI elements, due to the fundamental layout differences compared to uGUI.

The size and position of an element is controlled by the layout engine. For more information, see [Layout Engine](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-LayoutEngine.html) and [Coordinate and position systems](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-coordinate-and-position-system.html).

### Rendering order

In uGUI, the order of the GameObjects in the hierarchy determines the rendering order. Objects further down in the hierarchy render last and appear on top. In a scene with multiple Canvases, the `Sort Order` on the root `Canvas` component determines the render order of the individual UI trees.

The render order in a [visual tree](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-VisualTree.html) in UI Toolkit operates the same way. Parent elements render before their children, and children render from the first to the last, so that the last appears on top. In a scene with multiple UI Documents, the render order is determined by the `Sort Order` setting on the root `UIDocument` component.

To change the rendering order of an element in uGUI, such as making an element appear on top, you can call the sibling functions on the `Transform` component of the GameObject. The `VisualElement` class offers comparable functions to control the rendering order. As all UI Toolkit controls derive from this class, all controls have access to this function.

The table below shows the uGUI functions to control render order and the equivalent functions in UI Toolkit:

<table><thead><tr class="header"><th style="text-align: left;"><strong>Action</strong></th><th style="text-align: left;"><strong>uGUI</strong></th><th style="text-align: left;"><strong>UI Toolkit</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;">Make element render underneath all other siblings</td><td style="text-align: left;"><code>transform.SetAsFirstSibling();</code></td><td style="text-align: left;"><code>myVisualElement.SendToBack();</code></td></tr><tr class="even"><td style="text-align: left;">Make element render on top of all other siblings</td><td style="text-align: left;"><code>transform.SetAsLastSibling();</code></td><td style="text-align: left;"><code>myVisualElement.BringToFront();</code></td></tr><tr class="odd"><td style="text-align: left;">Manually control the element’s render order relative to its siblings</td><td style="text-align: left;"><code>transform.SetSiblingIndex(newIndex);</code></td><td style="text-align: left;"><code>myVisualElement.PlaceBehind(sibling);</code><br />
<code>myVisualElement.PlaceInFront(sibling);</code></td></tr></tbody></table>

## Events

Just like in uGUI, user interactions in UI Toolkit trigger events. The code can subscribe to receive a callback on events, such as pressing a button or moving a slider.

In uGUI, all UI elements are based on MonoBehaviour, and can expose their events in the Editor. This allows to set up logic with other GameObjects, for example to hide or show other UI elements, or to assign callback functions.

![uGUI Button OnClick Inspector](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uie-uGUI-button-callback.png)

In UI Toolkit, logic and UI layout are stored separately. Callbacks can no longer be set up directly on GameObjects or stored in Prefabs. You must set up all callbacks at runtime, and handle them via scripting.

``` lang-cs
Button playButton = new Button("Play");
playButton.RegisterCallback<ClickEvent>(OnPlayButtonPressed);
...
private void OnPlayButtonPressed(ClickEvent evt)

```

The event dispatching system in UI Toolkit differs from events in uGUI. Depending on the event type, events aren’t just sent to the target UI control, but also to all the parent controls.

To learn more about this, see [Dispatch events](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Events-Dispatching.html).

<span id="use-ugui-and-ui-toolkit-in-the-same-project"></span>

## Use uGUI and UI Toolkit in the same project

It’s possible that you use uGUI and UI Toolkit in the same project.

You can also make your entire project with uGUI and only make some menu items with UI Toolkit.

You can use either UI Toolkit or uGUI for any item that doesn’t interact outside of its own boundaries. For example, for a runtime UI, you can use uGUI to create on-screen buttons, such as the joystick for mobile, and use UI Toolkit to create a modal window.

However, advanced interactions between mixed UI don’t work:

-   You can’t only use a keyboard to navigate freely between focused element in UI Toolkit and a uGUI selected object. To navigate, you must use C# scripts to register events on the boundary elements, and manually select or focus the next element from the other domain.
-   You can’t embed uGUI inside a UI Toolkit hierarchy or UI Toolkit in a uGUI hierarchy. You can use a `RenderTexture` to draw, but the events won’t catch up.
-   Styling and event conventions in UI Toolkit are different from uGUI. It is difficult to make a project that has a UI that feels unified if you use a scattered mixture of uGUI and UI Tookit.

## Additional resources

-   [Get started with UI Toolkit](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-simple-ui-toolkit-workflow.html)
-   [UXML](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UXML.html)
-   [Unity style sheets (USS)](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS.html)
-   [Examples](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-examples.html)
