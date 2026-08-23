---
title: "Reuse UXML files"
page_title: "Unity - Manual: Reuse UXML files"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-reuse-uxml-files.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-reuse-uxml-files.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Reuse UXML files

You can create a UXML file as a template and reuse it in other UXML files.

## Import a UXML template

When you design a large user interface, you can create template UXML files that define parts of the UI, and use the [`<Template>` and `<Instance>`](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-ElementRef.html#templates) elements to import it into another UXML file.

For example, if you have a portrait UI element that has an image, a name, and a label, you can create a UXML template file as `Portrait.uxml` with the following content:

``` lang-xml
<ui:UXML xmlns:ui="UnityEngine.UIElements">
    <ui:VisualElement class="portrait">
        <ui:Image name="portraitImage" style="--unity-image: url(a.png)"/>
        <ui:Label name="nameLabel" text="Name"/>
        <ui:Label name="levelLabel" text="42"/>
    </ui:VisualElement>
</ui:UXML>
```

You can then reuse the Portrait template like this:

``` lang-xml
<ui:UXML xmlns:ui="UnityEngine.UIElements">
    <ui:Template src="Portrait.uxml" name="Portrait"/>
    <ui:VisualElement name="players">
        <ui:Instance template="Portrait" name="player1"/>
        <ui:Instance template="Portrait" name="player2"/>
    </ui:VisualElement>
</ui:UXML>
```

<span id="attribute-overrides"></span>

## Override UXML attributes

When you create instances of a UXML template, you can override the default attribute values of its elements. Attribute overrides allow you to instantiate the same template many times with different values for each instance.

### Override an attribute

You can override attributes with the `UXML` tag. To override an attribute, specify the following:

-   The `element-name` attribute of the element whose attributes you want to override
-   The name of the attribute to override
-   The new attribute value

For example, if you want to display the same set of information for each player in your game, you can create a UXML template, and use attribute overrides to create player-specific instances.

First, create a template, such as `PlayerTemplate.uxml`, with the following content:

``` lang-xml
<ui:UXML xmlns:ui="UnityEngine.UIElements">
    <ui:Label name="player-name-label" text="default name" />
    <ui:Label name="player-score-label" text="default score" />
</ui:UXML>
```

Then, instance it from another UXML file and override its attributes to display each player’s name and score:

``` lang-xml
<ui:UXML xmlns:ui="UnityEngine.UIElements">
    <ui:Template src="PlayerTemplate.uxml" name="PlayerTemplate" />
    <ui:Instance name="player1" template="PlayerTemplate">
        <!-- Alice is the new value of the text attribute for the player-name-label -->
        <ui:AttributeOverrides element-name="player-name-label" text="Alice" /> 
        <!-- 2 is the new value of the text attribute for the player-score-label -->
        <ui:AttributeOverrides element-name="player-score-label" text="2" />
    </ui:Instance>
    <ui:Instance name="player2" template="PlayerTemplate">
        <!-- Bob is the new value of the text attribute for the player-name-label -->
        <ui:AttributeOverrides element-name="player-name-label" text="Bob" />
        <!-- 1 is the new value of the text attribute for the player-score-label -->
        <ui:AttributeOverrides element-name="player-score-label" text="1" />
    </ui:Instance>
</ui:UXML>
```

### Override multiple attributes

You can specify more than one attribute per override. For example, the following syntax finds any element in the instance named `player-name-label`, and

-   Overrides the default value of its `text` attribute with the new value, `Alice`.
-   Overrides the default value of its `tooltip` attribute with the new value, `Tooltip 1`.

``` lang-xml
<ui:AttributeOverrides element-name="player-name-label" text="Alice" tooltip="Tooltip 1" />
```

### Nest attribute overrides

Attribute overrides propagate through nested templates in the element hierarchy. For example, if template A instances template B, and template B instances template C, both template A and template B can override attributes in template C.

When you override attributes in nested templates, the shallowest override takes precedence. In the previous example, if template A and template B both override the same attribute of template C, the override in template A determines what actually appears in the rendered UI.

### Override template instance styles

If you’re creating instances of a UXML template, and an element in the template has an inline style defined with the `style` attribute, you can’t use `AttributeOverrides` to override that `style` attribute. However, you can use USS selectors in a USS style sheet to override the styling of your template instances.

For example, if you have the following UXML template called `Hotkeys.uxml` that defines a `#Container` with two labels, and the `#Container` has an inline style that defines the flex row direction:

``` lang-xml
<ui:UXML xmlns:ui="UnityEngine.UIElements" >
    <ui:VisualElement name="Container" style="flex-direction: row;">
        <ui:Label text="E" name="Hotkeys" />
        <ui:Label text="Talk" name="Action" />
    </ui:VisualElement>
</ui:UXML>
```

If you want to create two template instances with the second having a reversed flex row direction, you can’t use `AttributeOverides` to override the `style` attribute of the `#Container` element in your second instance.

To override the styling, first remove the inline `style` attribute from the `#Container` element in your template UXML file. Inline styles take precedence over USS styles, so removing them allows USS rules to apply.

Next, in your UXML file where you create instances of the template, assign unique names to each instance (for example, `Hotkeys` and `ReversedHotkeys`). Reference your USS style sheet (such as `ContextHotKeys.uss`) in this file:

``` lang-xml
<ui:UXML xmlns:ui="UnityEngine.UIElements">
    <ui:Template name="Hotkeys" src="Hotkeys.uxml"/>
    <Style src="ContextHotKeys.uss"/>
    <ui:Instance template="Hotkeys" name="Hotkeys" />
    <ui:Instance template="Hotkeys" name="ReversedHotkeys" />
</ui:UXML>
```

Then, in the stylesheet file `ContextHotKeys.uss`, you can use the instance name as selectors to target the `#Container` element within each instance. This lets you apply different styles to each instance as needed.

``` lang-css
#ReversedHotkeys > #Container 
#Hotkeys > #Container 
```

### Limitations

Attribute overrides have the following limitations:

-   Attribute overrides find matching attributes according to the element name you specify. You can’t use [USS Selectors](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors.html) or [UQuery](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UQuery.html) to match elements.
-   Although you can override an element’s `binding-path` attribute, data binding doesn’t work with attribute overrides.
-   You can’t override an element’s `class`, `name`, or `style` attributes.

## Specify where to nest child elements in a UXML template

You can use the `content-container` attribute of a visual element to specify where to nest child elements in a UXML template. For example, if you have the following UXML template file as `MyTemplate.uxml`:

``` lang-xml
<ui:UXML xmlns:ui="UnityEngine.UIElements" >
    <ui:Label text="Group Title" name="groupTitle" />
    <ui:VisualElement name="parent-container" content-container="anyValue">
         <!--Add child elements here -->
    </ui:VisualElement>
    <ui:VisualElement />
</ui:UXML>
```

You can then apply the template with nested child elements as this:

``` lang-xml
<ui:UXML xmlns:ui="UnityEngine.UIElements">
    <ui:Template src="MyTemplate.uxml" name="my-template"/>
    <ui:Instance template="my-template">
        <ui:Label text="Test"/> <!--This label element is instantiated inside the `parent-container` element-->
    </ui:Instance>
</ui:UXML>
```

**Note**:

-   You can provide any string value to the `content-container` attribute.
-   Define only one element with the `content-container` attribute in a UXML template. If multiple elements have this attribute, it creates ambiguity for the system. In such cases, child elements are nested within the first element that has the `content-container` attribute during a depth-first traversal of the visual tree. To ensure predictable behavior, only define `content-container` on a single element within your template.

## Additional resources

-   [Templates](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-ElementRef.html#templates)
-   [Use UXML instances as templates](https://docs.unity3d.com/6000.3/Documentation/Manual/UIB-structuring-ui-templates.html)
