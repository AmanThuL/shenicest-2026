---
title: "Get started with UI Builder"
page_title: "Unity - Manual: Get started with UI Builder"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIB-getting-started.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIB-getting-started.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Get started with UI Builder

Want to learn how to create UI with UI Builder? Use this example to get started.

To create UI in the UI Builder:

1.  Create a new UI Document (UXML).
2.  Add elements to create your UI hierarchy.
3.  Set up attributes and style properties in the Inspector.
4.  When more than one element starts to need the same style properties, [create USS style sheets and selectors](https://docs.unity3d.com/6000.3/Documentation/Manual/UIB-getting-started.html#create-a-uss-class-for-the-border-style).
5.  Test your UI and if you are satisfied with the results, [extract inline style properties to USS classes](https://docs.unity3d.com/6000.3/Documentation/Manual/UIB-getting-started.html#extract-inline-styles).
6.  Save the UI Document (UXML).

## Prerequisites

Before you start, get familiar with the following:

-   [Introduction to visual elements and visual tree](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-VisualTree.html)
-   [Introduction to UXML](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-WritingUXMLTemplate.html)
-   [Introduction to USS](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-about-uss.html)
-   [UI Builder interface overview](https://docs.unity3d.com/6000.3/Documentation/Manual/UIB-interface-overview.html)

## Example overview

This example creates the main view for the [Create a list view runtime UI](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-HowTo-CreateRuntimeUI.html) example. It creates a root element as the background, with two containers. One container holds the character name list and another holds the character details. In the character details container, you add background and foreground frames. Finally, you add two labels for the character name. This example won’t create the character name list entry UI.

![Final main view layout](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uie-howto-runtimeUI-finalMainView.png)

## Create the root element

Create a new project and then create a root visual element that covers the entire screen. Set your root element to have a background color and center all child elements in the middle of the screen.

1.  Create a project in Unity with any template.

2.  Select **Window** > **UI Toolkit** > **UI Builder**.

3.  In the UI Builder window, at the top left of the **Viewport** window, select **File** > **New** to create a new UXML document.

    ![UI Builder file menu](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIBuilder/uie-howto-runtimeUI-fileMenu.png)

4.  Name it as `MainView.uxml` and save.

5.  Drag **VisualElement** from **Library** into the **Hierarchy** panel.

    ![Create new elements by dragging from the Library](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIBuilder/uie-howto-runtimeUI-newVisualElement.png)

    **Tip**: You can also double-click a control to add it to the **Hierarchy** panel.

6.  Select the element from the **Hierarchy** panel.

7.  In the **Inspector** panel, make sure **Flex** > **Grow** is `1`. This sets the `flex-grow` property to `1`, making it cover the entire screen.

    ![Set the Flex property](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIBuilder/uie-howto-runtimeUI-flexGrow.png)

8.  To center all child elements, set both **Align Items** and **Justify Content** to `Center`.

    ![Center children](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIBuilder/uie-howto-runtimeUI-alignCenter.png)

9.  Set **Background** > **Color** to `#732526`.

    **Note:** By default, the Alpha value for colors is `0`, making them fully transparent. To make color opaque, set the Alpha value to `255`.

    ![Root element background color](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIBuilder/uie-howto-runtimeUI-backgroundColor.png)

## Create the parent container

Create a new VisualElement underneath the root element. This element becomes the parent container for the left and right sections of the UI.

1.  Drag **VisualElement** from **Library** to the root VisualElement in the **Hierarchy** panel.

    ![Add a child VisualElement](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIBuilder/uie-howto-runtimeUI-secondaryContainer.png)

2.  Select the element from the **Hierarchy** panel.

3.  In the **Inspector** panel, set **Flex** > **Direction** to `row`.

4.  Set **Flex** > **Grow** to `0`.

5.  Set **Size** > **Height** to `350` pixels.

    ![Center container properties](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIBuilder/uie-howto-runtimeUI-centerContainer.png)

## Create the character names list container

Add a ListView as the child element of the container to hold the character names.

1.  Drag a **ListView** from the **Library** to the container VisualElement in the **Hierarchy** panel.

2.  Select the element from the **Hierarchy** panel.

3.  In the **Inspector** panel, set **Name** to `CharacterList`.

    ![Background container with the empty element inside](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIBuilder/uie-howto-runtimeUI-setElementName.png)

4.  Set **Size** > **Width** to `230` pixels.

5.  Set **Spacing** > **Margin** > **Right** to `6` pixels.

    ![Size and Margin foldouts for the character list](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIBuilder/uie-howto-runtimeUI-sizeAndMargin.png)

6.  Set **Background** > **Color** to `#6E3925`.

7.  Set **Border** > **Color** to `#311A11`.

8.  Set **Border** > **Width** to `4` pixels.

9.  Set **Border** > **Radius** to `15` pixels.

    ![Styled character list](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIBuilder/uie-howto-runtimeUI-characterListStyling.png)

## Create the character details container

Add a new VisualElement under the same parent as the `#CharacterList` to hold the character details container. The purpose is that when the user selects a character from the list on the left, it displays the character’s portrait, name, and class.

1.  Drag a **VisualElement** from the **Library** to the container element in the **Hierarchy** panel. This is the container to hold all the elements on the right.

2.  Select the element from the **Hierarchy** panel.

3.  In the **Inspector** panel, set **Align** > **Align Items** to `flex-end`.

4.  Set **Align** > **Justify Content** to `space-between`.

    ![Justify content property](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIBuilder/uie-howto-runtimeUI-justifySpaceBetween.png)

5.  Add another **VisualElement** as the child of the right container.

6.  Select the element from the **Hierarchy** panel.

7.  Set **Flex** > **Grow** to `0`.

8.  Set **Size** > **Width** to `276` pixels.

9.  In the **Align** section, set both **Align Items** and **Justify Content** to `center`.

10. Set **Spacing** > **Padding** to `8` pixels.

    ![Properties of the character details container](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIBuilder/uie-howto-runtimeUI-characterDetailsProperties.png)

11. Set **Background** > **Color** to `#AA5939`.

<span id="create-a-uss-class-for-the-border-style"></span>

## Create a USS class for the border style

The character details container will use the same border styles as the character names list container. Create a USS class to apply to both containers.

1.  In the **StyleSheet** panel, select **+** > **Create New USS**.
2.  Name it `MainView.uss` and select **Save**.
3.  Click in the **Add new selector…** field and enter `.border`. A **`.border`** selector appears in the **StyleSheet** panel.
4.  In the **StyleSheet** panel, select **`.border`**.
5.  In the **Inspector** panel, set **Border** > **Color** to `#311A11`.
6.  Set **Border** > **Width** to `4` pixels.
7.  Set **Border** > **Radius** to `15` pixels.
8.  Drag **`.border`** from the **StyleSheet** panel to the character details container **VisualElement**.
9.  Drag **`.border`** from the **StyleSheet** panel to **#CharacterList**.
10. Select **#CharacterList**.
11. In the **Inspector** panel, right-click **Border** and select **Unset** to remove the inline style you set earlier.

Your UI layout now looks like the following:

![Empty character details panel](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIBuilder/uie-howto-runtimeUI-intermediate02.png)

## Create the character portrait background

Add the individual UI controls to the character details container. The first step is to add the character portrait background.

1.  Drag **VisualElement** from **Library** to the character details container.

2.  Select the element from the **Hierarchy** panel.

3.  In the **Size** section, set both **Width** and **Height** to `120` pixels.

4.  Set **Spacing** > **Padding** to `4` pixels.

5.  Set **Background** > **Color** to `#FF8554`.

6.  Set **Border** > **Color** to `#311A11`.

7.  Set **Border** > **Width** to `2` pixels.

8.  Set **Border** > **Radius** to `13` pixels.

    ![Background frame for the character portrait](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIBuilder/uie-howto-runtimeUI-pictureFrame.png)

## Create the character portrait foreground

Next in the character details container, add the foreground for an actual image.

1.  Drag **VisualElement** from **Library** to the character details container.

2.  Select the element from the **Hierarchy** panel.

3.  Set **Name** to `CharacterPortrait`.

4.  Set **Flex** > **Grow** to `1`, so that the image can use all the available space.

5.  Set **Background > Scale Mode** to `scale-to-fit`, so that you can scale the image to match the element size while keeping the correct aspect ratio.

    ![VisualElement for the portrait image](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIBuilder/uie-howto-runtimeUI-portraitElement.png)

## Create labels

Add two label controls to the character details container to display the selected character’s name and class.

1.  Drag **Label** from **Library** to the character details container in the **Hierarchy** panel.

2.  Set `Name` to `CharacterName`.

3.  Drag **Label** from **Library** to the character details container in the **Hierarchy** panel.

4.  Set `Name` to `CharacterClass`.

    ![Add labels for name and class](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIBuilder/uie-howto-runtimeUI-characterLabels.png)

5.  Select the `#CharacterName` element.

6.  Set **Text** > **Font Style** to `B`.

7.  Set **Text** > **Size** to `18` pixels.

    ![Change font settings](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIBuilder/uie-howto-runtimeUI-labelSettings.png)

8.  In the **Viewport** window, select **File** > **Save** to save the changes to `MainView.uxml`.

<span id="extract-inline-styles"></span>

## Extract inline styles

In UI Builder, you can create elements and use inline styles only to experiment while the number of elements is still small. As you build a more complex UI, it’s easier to manage styles using style sheets. You can extract inline styles to a style sheet in UI Builder.

1.  Select the root visual element.

2.  In the **Inspector** panel, in the **Style Class List** field, enter `.background` as the class name.

3.  Select **Extract Inlined Styles to New Class**. This creates a `.background` class selector with the inline styles you set for the root element and updates the UI Document (UXML) for the root visual element to use the class selector instead of the inline styles.

    ![Extract inline styles to a new class](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UIBuilder/extract-inline-styles.png)

4.  In the **Viewport** window, select **File** > **Save**.

If you want to continue to work on the [Create a list view runtime UI](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-HowTo-CreateRuntimeUI.html) example, you can repeat the steps to extract styles for all the other elements, and follow the instructions to create the example.

## Additional resources

-   [Style elements with UI Builder](https://docs.unity3d.com/6000.3/Documentation/Manual/UIB-styling-ui-using-uss-selectors.html)
