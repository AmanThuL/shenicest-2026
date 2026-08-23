---
title: "Create USS variables"
page_title: "Unity - Manual: Create USS variables"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-CustomProperties.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-CustomProperties.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Create USS variables

Variables make it easier to manage styles for complex UI, where multiple rules, sometimes in different style sheets, use the same values.

You can create a USS variable and use it in other USS properties. When you update a USS variable, all of the USS properties that use that variable update. You can also specify default values for USS variables.

## Create and assign USS variables

You can create and assign a USS variable in [UI Builder](https://docs.unity3d.com/6000.3/Documentation/Manual/UIB-styling-ui-using-uss-variables.html) or directly in a USS file.

To create a USS variable in a USS file, prefix its name with a double-hyphen (`--`).

``` lang-css
--color-1: red;
```

To use a USS variable value in another USS rule, use the `var()` function to call it.

``` lang-css
var(--color-1);
```

When you update a variable, it updates all the USS properties that use it.

For example, the following USS example defines one style rule that declares two color variables, and two style rules that use those variables. To update the color scheme, you can change the two variable values instead of changing the four color values.

``` lang-css
:root 
.paragraph-regular 
.paragraph-reverse 
```

## Specify default values for USS variables

The `var()` function accepts an optional default value. The UI system uses the default value when it can’t resolve the variable. For example, the UI system uses the default value if you remove a variable from a style sheet but forget to remove a reference to it.

To specify a default value for a variable, add it after the variable value, separated by a comma `,`.

The following USS snippet calls the `--color-1` variable. If the UI system can’t resolve the variable, it uses the hex value for red (`#FF0000`).

``` lang-css
var(--color-1, #FF0000);
```

## Differences from CSS variables

Variables work mostly the same way in USS as they do in CSS. For detailed information about CSS variables, refer to the [MDN documentation](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties). However, USS doesn’t support some CSS functionality:

-   USS doesn’t support the `var()` function inside of other functions, such as the following:

``` lang-css
  background-color: rgb(var(--red), 0, 0);
```

-   USS doesn’t support mathematical operations on variables.

## Additional resources

-   [Introduction to USS built-in variables](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-UnityVariables.html)
-   [USS built-in variable reference](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uss-built-in-variable-reference.html)
