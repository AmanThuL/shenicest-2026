---
title: "Unity 6.3 Manual: UI Toolkit naming conventions"
page_title: "Unity - Manual: Naming conventions"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/naming-conventions.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/naming-conventions.html"
topic: "csharp-style"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Naming conventions

With UI Toolkit you’ll need to query the [visual elements](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-VisualTree.html) and USS using a string identifier, so using a defined set of standards will lead, overall, to fewer errors and more readable code.

As dev teams will refer to the same UXML and USS assets that make up your interface, it’s important to standardize naming conventions for both visual elements and style sheets. Naming conventions help keep your hierarchy organized in UI Builder. It will also take out the guesswork of coding conventions and formatting conventions and help you have a consistent codebase.

In the code example below, the name of the button element is used to query and store a reference to it in C#:

``` lang-csharp
root.Query<Button>("foo").First();
```

There is no one-size-fits-all style guide. Pick and choose what works best for your team and project. However, it’s generally recommended to stick as close to industry standards as possible. For that reason, we recommend the **Block Element Modifier (BEM)** naming convention for your visual elements and style sheets. BEM is widely used in the context of CSS and modern web development, from which UI Toolkit takes its inspiration.

At a glance, an element’s BEM-style name can tell you what it does, where it appears, and how it relates to other elements around it. BEM uses three main components in the following convention:

`block-name__element-name--modifier-name`

Here’s an example:

`navbar-menu__shop-button--small`

Each name part may consist of Latin letters, digits, and dashes. Also note that each name part is joined together with either a double underscore `__` or a double dash `--`. Let’s look at the three components in detail:

-   The block name (`block-name`) represents a high level-component, like a navbar-menu, character stats `--` any distinct and meaningful UI component in your layout. In the case of a generic button that is not specific to any particular block, that can simply be left out, e.g., `button--small`.

-   The element (`element-name`) is a child or part of a block and therefore semantically tied to its block. In other words elements rely on the block for their context and can’t exist without it. So, the example of `shop-button` indicates that this is styled differently from other buttons belonging to the `navbar-menu` block (e.g., `shop-button` in `navbar-menu__shop-button`).

    -   If your new element instantiates child elements in its constructor, assign the relevant classes to the children. For example, `my-block__first-child`, `my-block__other-child`.

-   Finally, the modifier indicates a variation or state of a block or element. That could be when a button is pressed, a textbox item is selected and highlighted, or in our example, when it’s a small variant of the shop button. This makes it easy to adapt to different scenarios without duplicating code.

Here are some more examples of BEM naming:

-   `menu__button-home`
-   `menu__button-shop`
-   `navbar-menu__shop-button--small`
-   `navbar-menu__shop-button--large`

BEM class names are self-descriptive, making it easier for developers to understand the structure and purpose of components and therefore, helping to maintain a clear hierarchy for managing and updating styles as projects grow. As a general rule of thumb, favor readability over brevity. Clarity is more important than any time saved from omitting a few vowels.

These examples use hyphen delimiting (aka Kebab case), which is common for CSS naming. Your team should decide early on in a project which naming scheme works best for them and stick to it throughout development.

Read more about CSS naming conventions in [this article](https://www.freecodecamp.org/news/css-naming-conventions-that-will-save-you-hours-of-debugging-35cea737d849/), as well as in the [UI Toolkit documentation](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-WritingStyleSheets.html).

💡 **Tips: Naming conventions in UI Toolkit**

Here are some guidelines for effective naming:

-   Keep names short and clear (unambiguous). Ensure that names are concise yet descriptive enough to convey their purpose and role within the UI.

-   Use names to emphasize roles and relationships, such as `inventory__slot--equipped` instead of `inventory__button--equipped`. Omit Type names like Button or Label if they don’t add clarity.

-   Avoid names/modifiers that can change (e.g., use `button--quit` instead of `button--red` when the color scheme is not yet final). Use semantic naming rather than presentational naming, which ensures names remain relevant even if styling details change.

-   Extend these conventions to art assets, like sprites and textures associated with the UI Toolkit interface. Consistency in naming between code and assets helps maintain a clear relationship and better organization throughout the project.

-   If you use the element in other projects, consider prefixing your classes to avoid conflicts with existing user class names. Namespacing or prefixing can prevent clashes when integrating with other projects or libraries.

-   Use AddToClassList() in the constructor to add the relevant USS classes to your element instances. This method ensures that the appropriate styles are applied by adding the necessary classes at the time of element instantiation, maintaining consistency and clarity in your UI code.

**Create a C# style guide**

If you or your team wants to refine key coding practices to make your project more scalable, check out our free e-book: [Create a C# style guide: Write cleaner code that scales](https://unity.com/resources/c-sharp-style-guide-unity-6). Use this guide as needed to help standardize your code style and naming conventions.
