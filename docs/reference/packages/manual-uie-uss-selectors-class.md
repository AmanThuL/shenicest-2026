---
title: "USS class selectors"
page_title: "Unity - Manual: Class selectors"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-class.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-class.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Class selectors

USS class selectors match elements that have specific USS classes assigned. USS class selectors are analogous to CSS class selectors.

## Syntax

A class selector consists of the class name prefixed with a period. Class names are case-sensitive and can’t begin with a numeral.

``` lang-css
.className 
```

Only use a period when you write the selector in a USS file. Don’t include it when you assign the class to an element in a UXML or C# file. For example, don’t use `<Button class=".yellow" />`.

In general, don’t include a period in class names. Unity’s USS parser interprets a period as the beginning of a new class. For example, if you create a class called `yellow.button`, and create the following USS rule: `.yellow.button{...}`. The parser interprets the selector as a [multiple selector](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-multiple.html), and tries to find elements that match both a `.yellow` class and a `.button` class.

When an element has more than one class assigned, a selector only has to match one of them to match the element.

You can also specify multiple classes in a selector, in which case an element must have all of those classes assigned in order to match. See [Multiple selectors](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-multiple.html) for details.

## Example

To demonstrate how simple selectors match elements, here is an example UI Document.

``` lang-xml
<UXML xmlns="UnityEngine.UIElements">
  <VisualElement name="container1">
    <VisualElement name="container2" class="yellow">
      <Button name="OK" class="yellow" text="OK" />
      <Button name="Cancel" text="Cancel" />
    </VisualElement>
  </VisualElement>
</UXML>
```

With no styles applied, the UI looks like the following:

![Example buttons with margins and thin blue borders.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uss-selectors-nostyle.png)

The following name class selector style rule matches the element `container2` and the button element `OK`, and changes their background to yellow.

``` lang-css
.yellow 
```

The UI looks like the following when you apply the style:

![The container2 and the OK button with a yellow background.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uss-selectors-class.png)

## Additional resources

-   [Best practices for USS](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-WritingStyleSheets.html)
