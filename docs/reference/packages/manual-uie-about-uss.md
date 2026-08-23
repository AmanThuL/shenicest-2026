---
title: "Introduction to USS"
page_title: "Unity - Manual: Introduction to USS"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-about-uss.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-about-uss.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to USS

A Unity Style Sheet (USS) is a text file recognized as an asset that supports style rules. The USS text file must have the `.uss` extension.

You can use USS files to define the appearance and styles for the UI elements in your games and applications. USS provides a way to separate the appearance and styling of UI elements from the rest of the code, making it easier to manage and maintain the look and feel of an application.

With USS, you can define styles for buttons, labels, images, and other UI elements in a separate USS file, and then apply these styles in your game or application code. This makes it possible to change the appearance of your application by modifying the USS file, without having to make changes to the code.

A USS consists of the following:

-   Style rules that include a selector and a declaration block.
-   Selectors that identify which visual element the style rule affects.
-   A declaration block, inside curly braces, that has one or more style declarations. Each style declaration has a property and a value. Each style declaration ends with a semi-colon.

## Syntax

The following is the general syntax of a style rule:

``` lang-css
selector 
```

## Style matching with rules

When you define a style sheet, you can apply it to a [visual tree](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-VisualTree.html). Selectors match against elements to resolve which properties apply from the USS file. If a selector matches an element, the style declarations apply to the element.

For example, the following rule matches any `Button` object:

``` lang-css
Button 
```

## Supported selector types

USS supports several types of simple and complex selectors that match elements based on different criteria, such as the following:

-   Element C# type name
-   An assigned `name` property
-   A list of USS classes
-   The element’s position in the [visual tree](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-VisualTree.html) and its relationship to other elements

USS also supports [pseudo classes](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-Pseudo-Classes.html) that you can use with selectors to target elements that are in a specific state or select the `:root` element.

If an element matches more than one selector, USS applies the styles from whichever selector [takes precedence](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uss-selector-precedence.html).

**Note**: All selectors are case-sensitive.

### Simple selectors

USS supports a set of simple selectors that are analogous, but not identical, to simple selectors in CSS. The following table provides a quick reference of USS simple selectors.

| **Selector type**                                                                                           | **Syntax**     | **Matches**                                       |
|:------------------------------------------------------------------------------------------------------------|:---------------|:--------------------------------------------------|
| [Type selector](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-type.html)           | `Type {...}`   | Elements of a specific C# or visual element type. |
| [Class selector](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-class.html)         | `.class {...}` | Elements with an assigned USS class.              |
| [Name selector](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-name.html)           | `#name {..}`   | Elements with an assigned `name` attribute.       |
| [Universal selector](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-universal.html) | `* {...}`      | Any elements.                                     |

### Complex selectors

USS supports a subset of CSS complex selectors. The following table provides a quick reference of USS complex selectors.

| **Selector type**                                                                                             | **Syntax**                    | **Matches**                                                             |
|:--------------------------------------------------------------------------------------------------------------|:------------------------------|:------------------------------------------------------------------------|
| [Descendant selector](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-descendant.html) | `selector1 selector2 {...}`   | Elements that are the descendant of another element in the visual tree. |
| [Child selector](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-child.html)           | `selector1 > selector2 {...}` | Elements that are the children of another element in the visual tree.   |
| [Multiple selector](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-multiple.html)     | `selector1selector2 {...}`    | Elements that match all the simple selectors.                           |

<span id="connect-styles-to-elements"></span>

## Connect styles to elements

You can connect styles to elements by the following methods:

-   In UI Builder, style an element with inline styles or USS selectors. For more information, refer to [Style UI with UI Builder](https://docs.unity3d.com/6000.3/Documentation/Manual/UIB-styling-ui-using-uss-selectors.html)
-   In UXML, style an element with inline styles or attach a style sheet with selectors matching this element. For more information, refer to [Add styles to UXML](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-add-style-to-uxml.html).
-   In a C# script, set styles directly to the `style` properties or add a USS style sheet to the `styleSheet` property with selectors matching an element. For more information, refer to [Apply styles in C# scripts](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-apply-styles-with-csharp.html).

<span id="supported-characters"></span>

## Supported characters

USS selectors support the following characters:

-   Must begin with a letter (`A–Z` or `a–z`) or an underscore (`_`).
-   Can contain letters, digits (`0–9`), hyphens (`-`), and underscores (`_`).
-   Selectors are case-sensitive. For example, `myClass` and `MyClass` are different.
-   Selectors can’t start with a digit or a hyphen followed by a digit (for example, `.1class` or `.-1class`).

USS selectors also support the following characters but you must escape them with a backslash (`\`):

-   [Unicode characters](https://en.wikipedia.org/wiki/List_of_Unicode_characters)
-   Special characters like `!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, `(`, `)`, `+`, `=`, `[`, `]`, `{`, `}`, `|`, `;`, `:`, `'`, `"`, `,`, `.`, `<`, `>`, `/`, `?`.

**Note**: UI Builder doesn’t support all special characters.

## Additional resources

-   [USS selectors](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors.html)
-   [Best practices for USS](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-WritingStyleSheets.html)
-   [Theme Style Sheet (TSS)](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-tss.html)
