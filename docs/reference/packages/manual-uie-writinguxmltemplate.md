---
title: "Introduction to UXML"
page_title: "Unity - Manual: Introduction to UXML"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-WritingUXMLTemplate.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-WritingUXMLTemplate.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to UXML

The UXML format is inspired by [HTML](https://developer.mozilla.org/en-US/docs/Web/HTML), [XAML](https://docs.microsoft.com/en-us/dotnet/desktop/wpf/xaml/?view=netdesktop-5.0), and [XML](https://developer.mozilla.org/en-US/docs/Web/XML/XML_introduction). If you’ve worked with these formats before, you’ll find similarities in UXML. However, the UXML format includes small differences to provide an efficient way to work with Unity. This page introduces the format of UXML by an example.

The following is an example UXML file. It contains several built-in UI controls that prompt the user to make a choice:

``` lang-xml
<?xml version="1.0" encoding="utf-8"?>
<engine:UXML
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:engine="UnityEngine.UIElements"
    xmlns:editor="UnityEditor.UIElements"
    xsi:noNamespaceSchemaLocation="../../UIElementsSchema/UIElements.xsd"
>
    <engine:Box>
        <engine:Toggle name="boots" label="Boots" value="false" />
        <engine:Toggle name="helmet" label="Helmet" value="false" />
        <engine:Toggle name="cloak" label="Cloak of invisibility" value="false"/>
    </engine:Box>
    <engine:Box>
        <engine:Button name="cancel" text="Cancel" />
        <engine:Button name="ok" text="OK" />
    </engine:Box>
</engine:UXML>
```

## UXML declaration

The first line of code in the above UXML example is the UXML declaration. The declaration is optional. If you do include the UXML declaration, you must put it on the first line. A UXML declaration requires a `version`. The `encoding` attribute is optional in a UXML declaration. If you include the `encoding` attribute, you must declare the character encoding of the file.

## Document root

The next line defines the document root, `<engine:UXML>`. The `<engine:UXML>` element includes attributes for the namespace prefix definitions and the location of schema definition files. You can specify these attributes in any order.

## Namespace

In UI Toolkit, each element is defined in either the `UnityEngine.UIElements` or the `UnityEditor.UIElements` namespace:

-   The `UnityEngine.UIElements` namespace contains elements that are defined as part of the Unity runtime.
-   The `UnityEditor.UIElements` namespace contains elements that are available in the Unity Editor. To fully specify an element, you must prefix it with its namespace.

For example, if you want to use the `Button` element in your UXML template, you must specify `<UnityEngine.UIElements:Button />`.

To make specifying namespaces easier, you can define a namespace prefix. For example, `xmlns:engine="UnityEngine.UIElements"` defines the `engine` prefix as `UnityEngine.UIElements`. Once you define a namespace prefix, you can use it to specify namespaces. For example, `<engine:Button />` is equivalent to `<UnityEngine.UIElements:Button />`

You can also define a default namespace by excluding a prefix. For example, `xmlns="UnityEngine.UIElements"` defines `UnityEngine.UIElements` as the default namespace. This means that specifying, for example, `<Button />` is equivalent to `<UnityEngine.UIElements:Button />`

To create a UXML file with automatically defined namespaces, select **Asset** \> **Create** \> **UI Toolkit** \> **UI Document**.

**Note**: If you define your own elements, don’t define the custom control class in the `UnityEngine.UIElements` or `UnityEditor.UIElements` namespace. Otherwise, UI Builder will hide your custom controls.

## Schema definition

The schema definition validates your UXML files. It specifies which attributes and child elements each UXML element can contain.

In a UXML file, the `xsi:noNamespaceSchemaLocation` or the `xsi:schemaLocation` attributes of the `<engine:UXML>` root element specify the location of the schema definition files.

To create a UXML file with the latest schema definition, select **Assets** \> **Create** \> **UI Toolkit** \> **UI Document**. This creates a file with the `xsi:noNamespaceSchemaLocation` attribute for the root element.

**Note**: If your text editor doesn’t recognize the `xsi:noNamespaceSchemaLocation` attribute, use the `xsi:schemaLocation` attribute instead.

To force an update of the UXML schema definition, select **Assets** \> **Update UXML Schema**.

## UXML elements

The definition of the UI is within the `<engine:UXML>` root. The UI definition is a series of nested UXML elements, each representing a visual element.

The element name corresponds to the C# class name of the element to instantiate. Most elements have attributes and their values are mapped to the corresponding class properties in C#. Each element has its own set of attributes in addition to the inherited attributes of its parent class. `VisualElement` is the base class for all elements and it provides the following attributes for all elements:

-   `name`: An identifier for the element. The name should be unique.
-   `picking-mode`: Set to either `Position` to respond to mouse events or `Ignore` to ignore mouse events.
-   `focus-index`: (**OBSOLETE**) Use `tabIndex` and `focusable`.
-   `tabindex`: An integer that defines the tabbing position of the current element.
-   `focusable`: A Boolean that indicates whether the element is focusable.
-   `class`: A space-separated list of identifiers that characterize the element. Use classes to assign visual styles to elements. You can also use classes to select a set of elements in UQuery.
-   `tooltip`: A string that displays as a tooltip when the mouse hovers over the element.
-   `view-data-key` : A string that defines the key used for serialization of the element.

## Additional resources

-   [Add styles to UXML](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-add-style-to-uxml.html)
-   [Reuse UXML files](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-reuse-uxml-files.html)
-   [Reference other files from UXML](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-reference-other-files-from-uxml.html)
-   [UXML elements Reference](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-ElementRef.html)
