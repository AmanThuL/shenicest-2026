---
title: "Encapsulate UXML documents with logic"
page_title: "Unity - Manual: Encapsulate UXML documents with logic"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-encapsulate-uxml-with-logic.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-encapsulate-uxml-with-logic.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Encapsulate UXML documents with logic

A [Prefab](https://docs.unity3d.com/6000.3/Documentation/Manual/Prefabs.html) is a pre-made GameObject that you can instantiate multiple times in a scene. Prefabs are useful for creating reusable components. Visual elements in UI Toolkit aren’t GameObjects and therefore Prefabs don’t apply. However, you can [create a custom control](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-custom-controls.html) as a reusable UI component that encapsulates a specific hierarchy of elements with logic. Because UI Toolkit encourages you to separate the UI from your game or application code, you can use [UXML](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UXML.html) to define the structure, use [USS](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS.html) to define the look, and use C# to define the logic of your custom control.

## Create reusable UI components

As an example, let’s say you want to create a card game. You want to display cards with different statistics, such as life and attack.

![An example card](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uxml/reusable-card.png)

You can create a custom control called `CardElement` that displays the image, the life, and attack statistics for the character, and then reuse this custom control for each card in your game.

The following are the general steps to accomplish this:

1.  In C#, declare a [custom element type](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-create-custom-controls.html) called CardElement.

2.  In UXML, define the hierarchy of the custom control. You can use two approaches. Both approaches support instantiating the `CardElement` in C# and in a parent UXML.

    -   [UXML-first approach](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-encapsulate-uxml-with-logic.html#uxml-first-approach) adds children after element construction.
    -   [Element-first approach](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-encapsulate-uxml-with-logic.html#element-first-approach) adds children during element construction.

3.  Locate references to child elements of the custom control.

4.  Expose properties and methods, and encapsulate logic in your custom control the same way as you do with any C# classes.

5.  Connect your custom control with your game or application code. You can also register event callbacks to implement user interaction.

<span id="uxml-first-approach"></span>

## UXML-first approach

With this approach, you include your custom element CardElement in the hierarchy UXML document and declare its child elements directly underneath, and use the hierarchy UXML document as a [template](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-reuse-uxml-files.html). This approach offers a simpler solution with a fixed UI structure within the hierarchy UXML document.

The following C# and UXML examples demonstrate how to use the UXML-first approach to create reusable UI.

<span id="create-the-custom-control-class"></span>

### Create the custom control class

Create a C# script that defines CardElement custom control. The custom control class assigns an image and badge values to CardElement.

``` lang-cs
using UnityEngine;
using UnityEngine.UIElements;

// Define the custom control type.
[UxmlElement]
public partial class CardElement : VisualElement

    // Custom controls need a default constructor. 
    public CardElement() 
}
```

### Define the hierarchy of the custom control

Create a UXML document (`CardElement.uxml`) that defines the hierarchy of CardElement. This example styles CardElement with a USS file.

``` lang-xml
<ui:UXML xmlns:ui="UnityEngine.UIElements" xmlns:uie="UnityEditor.UIElements" editor-extension-mode="False">
    <Style src="CardElementUI.uss" />
    <CardElement> 
        <ui:VisualElement name="image" />
        <ui:VisualElement name="stats">
            <ui:Label name="attack-badge" class="badge" />
            <ui:Label name="health-badge" class="badge" />
        </ui:VisualElement>
    </CardElement> 
</ui:UXML>
```

### Connect custom controls to your game

You can connect your custom control to your game by the following:

-   Instantiate `CardElement.uxml` inside a parent UXML document. You can [navigate back and forth](https://docs.unity3d.com/6000.3/Documentation/Manual/UIB-structuring-ui-templates.html#edit-a-uxml-document-template-instance) between the hierarchy UXML and this UXML document in UI Builder.
-   Instantiate `CardElement.uxml` containing `CardElement` from a MonoBehaviour C# script. You must use [UQuery](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UQuery.html) to find CardElement before you add it to the scene.

You call `Init()` after adding the custom control into the scene.

![Workflow of the UXML-first approach](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uxml/option-b.png)

You can also add gameplay-related actions, such as a click event to interact with the elements.

**Instantiate inside parent UXML**

The following shows an example of instantiation in UXML:

``` lang-xml
<ui:UXML xmlns:ui="UnityEngine.UIElements" xmlns:uie="UnityEditor.UIElements" editor-extension-mode="False">
    <ui:Template name="CardElement" src="CardElement.uxml"/>
    <ui:Instance template="CardElement"/>
    <ui:Instance template="CardElement"/>
    <ui:Instance template="CardElement"/>
</ui:UXML>
```

For information on how to render the UXML document in your game, see [Render UI in the Game view](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-render-runtime-ui.html).

**Instantiate directly in C#**

**Note**: For learning purposes, the example code on this page uses [the Resources folder](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-manage-asset-reference.html#use-a-resources-folder) method to load the UXML files which is convenient. However, this method doesn’t scale well. It’s recommended that you use [other methods](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-manage-asset-reference.html) to load references for your production projects.

The following shows an example of instantiation in C#:

``` lang-cs
using UnityEngine;
using UnityEngine.UIElements;

public class UIManager : MonoBehaviour

    }

    private void SomeInteraction(ClickEvent evt)
    
}
```

<span id="element-first-approach"></span>

## Element-first approach

With this approach, you only include the child elements in the hierarchy UXML document and use C# to [load the hierarchy UXML document](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-manage-asset-reference.html) into the CardElement class definition. This approach offers a flexible UI structure for custom controls. For example, you can load different hierarchy UXML documents depending on specific conditions.

The following C# and UXML examples demonstrate how to use the element-first approach to create reusable UI.

### Create the custom control class

Create a C# script that defines the CardElement custom control. In addition to [defining a constructor to assign an image and badge values to CardElement](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-encapsulate-uxml-with-logic.html#create-the-custom-control-class), the custom control loads the hierarchy UXML document in its class definition.

``` lang-cs
using UnityEngine;
using UnityEngine.UIElements;

// Define the custom control type.
[UxmlElement]
public partial class CardElement : VisualElement

    // Define a constructor that loads the UXML document that defines 
    // the hierarchy of CardElement and assigns an image and badge values.
    public CardElement(Texture2D image, int health, int attack)
    
}
```

**Note**: If you have performance concerns, use lazy initialization to keep fields to cache the references and avoid re-evaluating the queries too often.

### Define the hierarchy of the custom control

Create a UXML document (`CardElement.uxml`) that defines the hierarchy of the child elements of CardElement. The example styles CardElement with a USS file.

``` lang-xml
<ui:UXML xmlns:ui="UnityEngine.UIElements" xmlns:uie="UnityEditor.UIElements" editor-extension-mode="False">
    <Style src="CardElementUI.uss" /> 
    <ui:VisualElement name="image" />
    <ui:VisualElement name="stats">
        <ui:Label name="attack-badge" class="badge" />
        <ui:Label name="health-badge" class="badge" />
    </ui:VisualElement>
</ui:UXML>
```

### Connect custom controls to your game

You can connect your custom control to your game by doing the following:

-   Instantiate `CardElement.uxml` inside a parent UXML document. In UI Builder, you can’t navigate back and forth between the hierarchy UXML and this UXML document because child elements are loaded from C#.
-   Instantiate `CardElement.uxml` containing `CardElement` from a MonoBehaviour C# script.

You call the constructor before adding the custom control to the scene.

![Workflow of the element-first approach](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uxml/option-a.png)

You can also add gameplay-related actions, such as a click event to interact with the elements.

**Instantiate inside parent UXML**

The following shows an example of instantiation in UXML:

``` lang-xml
<ui:UXML xmlns:ui="UnityEngine.UIElements" xmlns:uie="UnityEditor.UIElements" editor-extension-mode="False">
   <CardElement />
   <CardElement />
   <CardElement />
</ui:UXML>
```

For information on how to render the UXML document in your game, see [Render UI in the Game view](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-render-runtime-ui.html).

**Instantiate directly in C#**

The following shows an example of instantiation in C#:

``` lang-cs
using UnityEngine;
using UnityEngine.UIElements;

public class UIManager : MonoBehaviour

    }

    private void SomeInteraction(ClickEvent evt)
    
}
```

## Build more complex elements

As the UI of your project gets more complex, it’s better to isolate your logic into higher-level components. This makes orchestrating the UI easier for the rest of the game or application.

You can apply the concepts on this page to gradually build specialized components out of smaller, more generic components. For example, to build a main title screen from which the user can access an Options menu and an About section, you can create a TitleScreenManager element with three different child UXML documents. Each defines its own elements: Title, Options, and About.

![An example main title screen](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uxml/title-screen-manager.png)

## Additional resources

-   [Find visual elements with UQuery](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UQuery.html)
-   [Use UXML instances as templates](https://docs.unity3d.com/6000.3/Documentation/Manual/UIB-structuring-ui-templates.html)
-   [Reuse UXML files](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-reuse-uxml-files.html)
-   [Support for runtime UI](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-support-for-runtime-ui.html)
