---
title: "USS selectors"
page_title: "Unity - Manual: USS selectors"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# USS selectors

Selectors decide which elements that USS rules affect.

USS supports a set of simple selectors that are analogous, but not identical, to simple selectors in CSS. A simple selector matches elements by element type, USS class, element name, and wildcard.

You can combine simple selectors into complex selectors, or append [pseudo-classes](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-Pseudo-Classes.html) to them to target elements in specific states. USS supports descendant, child, and multiple complex selectors.

| **Topic**                                                                                                                  | **Description**                                                                    |
|:---------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------|
| [Type selectors](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-type.html)                         | Match elements based on their element types.                                       |
| [Name selectors](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-name.html)                         | Match elements based on the name of an element.                                    |
| [Class selectors](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-class.html)                       | Match elements that have specific USS classes assigned.                            |
| [Universal selectors](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-universal.html)               | Match any element.                                                                 |
| [Descendant selectors](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-descendant.html)             | Match elements that are descendants of another element in the visual tree.         |
| [Child selectors](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-child.html)                       | Match elements that are children of another element in the visual tree.            |
| [Multiple selectors](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-multiple.html)                 | Select elements that match all the simple selectors.                               |
| [Selectors list](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-list.html)                         | Create a comma-separated list of selectors that share the same style rule.         |
| [Pseudo-classes](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-Selectors-Pseudo-Classes.html)               | Use pseudo-classes with selectors to target elements that are in a specific state. |
| [Selector precedence](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-uss-selector-precedence.html)               | Understand USS precedence when multiple USS rules target the same elements.        |
| [Check pseudo-state of a control](https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/check-pseudo-state.html) | Check the pseudo-state of a control to ensure styles apply correctly.              |

## Additional resources

-   [Best practices for USS](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-WritingStyleSheets.html)
