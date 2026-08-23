---
title: "Get started with runtime UI"
page_title: "Unity - Manual: Get started with runtime UI"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-get-started-with-runtime-ui.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-get-started-with-runtime-ui.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Get started with runtime UI

You can create a runtime UI and display it in a game view by the following steps:

1.  [Create a UI Document (`.uxml`) with controls](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-get-started-with-runtime-ui.html#create-ui-controls).
2.  [Add a UIDocument GameObject in the scene and add the UXML file as the source asset for it](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-get-started-with-runtime-ui.html#set-up-scene).
3.  [Create `MonoBehaviours` to define the behavior of your UI controls](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-get-started-with-runtime-ui.html#define-behavior).
4.  [(Optional) Configure your runtime event system](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-get-started-with-runtime-ui.html#runtime-event-system).

Try the following simple runtime UI example to get started. The example adds a label, a button, a toggle, and a text field in a scene. When you click the button, the Console window shows a message. When you select the toggle and click the button, the Console window shows how many times the buttons have been clicked. When you enter a text message in the text field, the Console window shows the message.

## Prerequisites

This guide is for developers familiar with the Unity Editor, UI Toolkit, and C# scripting. Before you start, get familiar with the following:

-   [UI Builder](https://docs.unity3d.com/6000.3/Documentation/Manual/UIBuilder.html)
-   [UXML](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UXML.html)
-   [Visual Tree](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-VisualTree.html)
-   [Label](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uxml-element-Label.html)
-   [Button](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uxml-element-Button.html)
-   [Toggle](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uxml-element-Toggle.html)
-   [TextField](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uxml-element-TextField.html)

You can find the completed files that this example creates in this [GitHub repository](https://github.com/Unity-Technologies/ui-toolkit-manual-code-examples/tree/master/simple-runtime-ui).

<span id="create-ui-controls"></span>

## Create a UI Document with controls

Create a UI Document with a label, a button, and a Toggle. For information on how to add UI controls with UI Builder or UXML, refer to [Get started with UI Toolkit](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-simple-ui-toolkit-workflow.html).

1.  Create a project in Unity Editor with any template.

2.  Create a UI Document named `SimpleRuntimeUI.uxml` with the following contents:

    ``` lang-xml
    <ui:UXML xmlns:ui="UnityEngine.UIElements" xmlns:uie="UnityEditor.UIElements"
            xsi="http://www.w3.org/2001/XMLSchema-instance" engine="UnityEngine.UIElements" editor="UnityEditor.UIElements"
            noNamespaceSchemaLocation="../UIElementsSchema/UIElements.xsd" editor-extension-mode="False">
        <ui:VisualElement style="flex-grow: 1;">
            <ui:Label text="This is a Label" display-tooltip-when-elided="true"/>
            <ui:Button text="This is a Button" display-tooltip-when-elided="true" name="button"/>
            <ui:Toggle label="Display the counter?" name="toggle"/>
            <ui:TextField picking-mode="Ignore" label="Text Field" text="filler text" name="input-message" />
        </ui:VisualElement>
    </ui:UXML>
    ```

<span id="set-up-scene"></span>

## Set up the scene

Create a UIDocument GameObject in the SampleScene and add the UI Document as the source asset.

1.  In the SampleScene, select **GameObject** > **UI Toolkit** > **UI Document**. This creates the following:

    -   A UI Toolkit folder with a Panel Settings asset and a default runtime theme.
    -   A GameObject with a UI Document component attached, and the UI Document component is connected to the Panel Settings asset.

2.  Select the **UIDocument** GameObject in the hierarchy and drag **SimpleRuntimeUI.uxml** from your Project window to the **Source Asset** field of the UI Document component in the Inspector window. This references the source asset to the UXML file you created.

<span id="define-behavior"></span>

## Define the behavior of your UI controls

To add logic, create a C# script that derives from `MonoBehaviour` to access the controls that the UI Document component references.

Unity loads a UI Document component’s source UXML when `OnEnable` is called on the component. To ensure the visual tree is loaded correctly, add logic to interact with the controls inside the `OnEnable` method.

1.  Create a C# script named `SimpleRuntimeUI.cs` with the following contents:

    ``` lang-cs
    using UnityEngine;
    using UnityEngine.UIElements;

    public class SimpleRuntimeUI : MonoBehaviour
    
        private void OnDisable()
        
        private void PrintClickMessage(ClickEvent evt)
        {
            ++_clickCount;

            Debug.Log($"{"button"} was clicked!" +
                    (_toggle.value ? " Count: " + _clickCount : ""));
        }

        public static void InputMessage(ChangeEvent<string> evt)
        {
            Debug.Log($"{evt.newValue} -> {evt.target}");
        }
    }
    ```

2.  Add **SimpleRuntimeUI.cs** as a component of the UIDocument GameObject.

<span id="runtime-event-system"></span>

## Configure your runtime event system

Depending on the active input handling selected in your project settings, and whether or not you want to mix UI Toolkit panels with uGUI canvases, there is a number of available options to modify how UI Toolkit processes input to generete its runtime events.

Refer to [Runtime event system](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Runtime-Event-System.html) for more information.

## Additional resources

-   [Render UI in the Game view](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-render-runtime-ui.html)
-   [The Panel Settings asset](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Runtime-Panel-Settings.html)
-   [Runtime event system](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Runtime-Event-System.html)
-   [FAQ for input and event systems with UI Toolkit](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-faq-event-and-input-system.html)
-   [Get started with text](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-get-started-with-text.html)
-   [Create a list view runtime UI](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-HowTo-CreateRuntimeUI.html)
