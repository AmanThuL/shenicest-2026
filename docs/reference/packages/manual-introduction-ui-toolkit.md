---
title: "Introduction to UI Toolkit"
page_title: "Unity - Manual: Introduction to UI Toolkit"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/introduction-ui-toolkit.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/ui-systems/introduction-ui-toolkit.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to UI Toolkit

You can use UI Toolkit to develop custom UI and extensions for the Unity Editor, and runtime UI for games and applications.

<span id="web-inspired-design"></span>

## Web-inspired design

UI Toolkit is designed for optimal performance and adaptability across platforms and it is inspired by standard web technologies. If you have experience developing web pages or applications, the core concepts of UI Toolkit might be familiar to you. UI Toolkit provides powerful tools and workflows that leverage your existing knowledge of markup languages and style sheets.

![In essence, UI Toolkit interfaces consist of UXML and USS files to create layouts and styling by the UI Toolkit systems.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image87.png)

With UI Toolkit, you can separate the structure, style, and behavior of your UI, similar to how you might with HTML, CSS, and JavaScript:

![Similarities between UI Toolkit and web technologies](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/bpg/uitk/image216.png)

<span id="uxml"></span>

### UXML

[UXML](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UXML.html) is a markup language inspired by HTML and XML that defines UI structure and reusable templates. While you can build UI in C#, using UXML is recommended.

<span id="uss"></span>

### USS

[USS](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS.html) are style sheets that apply visual styles and layout rules to UI. Similar to CSS, USS supports a subset of standard CSS properties. While you can define styles in C#, using USS is recommended.

<span id="retained-mode-architecture"></span>

## Retained mode architecture

UI Toolkit operates in a retained mode architecture, which means the UI builds a hierarchical structure and maintains it in memory. The framework handles rendering and updates to the UI based on the state of that tree. Here’s what retained mode means in detail:

<span id="declarative-structure"></span>

### Declarative structure

UI components are defined and managed as objects or nodes within a [visual tree](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-VisualTree.html). Visual tree is an object graph made of lightweight nodes that holds all the elements in a window or panel. It defines every UI built with UI Toolkit. You declare the UI structure once, UI Toolkit takes care of rendering and updates based on the changes to the tree.

![Visual tree example](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/VisualTreeExample.png)

<span id="state-persistence"></span>

### State persistence

The UI elements in retained mode persist in memory after creation. You can modify their properties, and UI Toolkit reflects changes in the next rendering cycle. For example, if you have a button, you don’t need to redraw it manually. Updating its properties, such as position or appearance, is enough. The system handles the rest.

<span id="event-handling"></span>

### Event handling

[Events](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Events.html) such as clicks, drags, or key presses are routed automatically to the appropriate visual elements in the tree. You attach handlers to UI elements, UI Toolkit propagates events appropriately.

<span id="data-binding"></span>

## Data binding

UI Toolkit supports a [data binding system](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-data-binding.html) that allows you to link properties of UI elements to data sources. This means that when the data changes, the UI updates automatically, and vice versa. This is similar to how frameworks like React or Angular handle data binding in web development.

![Data binding example](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uitk/data-binding.gif)

<span id="layout-engine"></span>

## Layout engine

UI Toolkit uses a [layout engine](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-LayoutEngine.html) based on the CSS [Flexbox](https://css-tricks.com/snippets/css/a-guide-to-flexbox/) model. This lets you to define how UI elements are positioned and sized within their parent containers. The layout engine automatically calculates the size and position of elements based on their properties, making it easier to create responsive designs.

Use flex properties for efficient space distribution, easy reordering, and absolute positioning of elements. The layout engine also supports alignment, justification, wrapping, and much more.

![Flexbox layout examples](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uitk/layout-engine.png)

<span id="library-of-ui-controls"></span>

## Library of UI controls

UI Toolkit provides a rich library of [standard UI controls](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-ElementRef.html) that you can use to build your interfaces, such as buttons, toggles, and list and tree views. You can use them as is, customize them, or [create your own controls](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-custom-controls.html).

![Standard UI controls](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uitk/uitk-controls.png)

<span id="text-and-fonts"></span>

## Text and fonts

UI Toolkit supports a [text system](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-work-with-text.html) that allows you to work with fonts, styles, and text elements. You can use system fonts or import custom fonts, and apply styles such as bold, italic, or underline. The text system is designed to work seamlessly with the layout engine, ensuring that text flows correctly within your UI.

![Text and fonts example](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uitk/text-fonts.gif)

<span id="support-for-editor-and-runtime-ui"></span>

## Support for Editor and runtime UI

UI Toolkit lets you create a UI that works seamlessly in both [Editor](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-support-for-editor-ui.html) and [runtime](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-support-for-runtime-ui.html) UI. The same UI elements, styling, and layout system apply across both scenarios, reducing duplication and ensuring consistency. Whether you’re building in-game menus, heads-up displays (HUDs), or custom Editor tools, UI Toolkit provides the capability to adapt your UI for different contexts.

![A pie chart appears in both the scene and an Editor window.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uitk/pie-chart.png)

<span id="ui-tools-and-resources"></span>

## UI tools and resources

UI Toolkit provides a set of tools and resources to help you design, develop, and debug your UI.

<span id="ui-debugger"></span>

### UI Debugger

[UI Debugger](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-ui-debugger.html) is a diagnostic tool that resembles a web browser’s debugging view. Use it to explore a hierarchy of elements and get information about their underlying UXML structure and USS styles.

![UI Debugger example](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uitk/ui-debugger-example.png)

<span id="ui-builder"></span>

### UI Builder

[UI Builder](https://docs.unity3d.com/6000.3/Documentation/Manual/UIBuilder.html) is a visual authoring tool that lets you create and edit UXML and USS files. You can design your UI visually, drag and drop elements, and customize styles without writing code. The UI Builder interface allows artists and designers to edit and visualize the UI as it’s being built.

![UI Builder example](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uitk/ui-builder.png)

<span id="ui-samples"></span>

### UI samples

A library of code samples for UI controls that you can view in the Editor under **Window** \> **UI Toolkit** \> **Samples**.

![UI Toolkit samples](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/uitk/ui-samples.png)

<span id="roles-and-responsibilities"></span>

## Roles and responsibilities

In a studio, UI Toolkit can be used across different disciplines, with each role contributing to specific parts of the process.

<span id="ux-ui-designers"></span>

### UX/UI Designers

UX/UI designers are responsible for the overall look and feel of the UI. They create wireframes, mockups, and prototypes to define the user experience.

Designers use UI Builder to visually design the UI and create UXML and USS files for structure and styling.

<span id="developers"></span>

### Developers

Developers implement the behavior of the UI and integrate it with game or editor logic. They work closely with designers to ensure that the UI meets the design specifications and functions correctly.

Developers use C# to create custom functionality, handle user interactions, and bind data. They also use UI Toolkit’s API to interact with the UI controls created by designers and to develop custom UI controls that designers can use and customize in their designs.

<span id="technical-artists"></span>

### Technical Artists

Technical artists often act as a bridge between designers and developers. They ensure that the visual assets are optimized for performance and integrate well with the UI.

Technical artists assist in creating USS styles and troubleshooting issues that arise during development.

<span id="qa-testing"></span>

### QA/Testing

QA/testers test the UI to ensure it functions correctly and meets design specifications.

Testers use the UI Debugger to inspect the UI hierarchy and verify interactions.

## Additional resources

-   [Get started with UI Toolkit](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-simple-ui-toolkit-workflow.html)
-   [UI Toolkit examples](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-examples.html)
-   <span aria-hidden="true">📺</span> **Video**: [UI Toolkit Tutorial Series: Tooltips and Popovers](https://www.youtube.com/watch?v=i85OSs0fYvI)
-   <span aria-hidden="true">📺</span> **Video**: [UI Toolkit Tutorial Series: Tabbed Menu](https://www.youtube.com/watch?v=sF33-iNy0rU)
-   <span aria-hidden="true">📺</span> **Video**: [UI Toolkit Tutorial Series: Drag and Drop Manipulator](https://www.youtube.com/watch?v=HvsCvq0L6I4)
-   <span aria-hidden="true">📺</span> **Video**: [UI Toolkit Tutorial Series: UI Toolkit Events](https://www.youtube.com/watch?v=IBdj-OSEM3E)
-   <span aria-hidden="true">📺</span> **Video**: [UI Toolkit Tutorial Series: SVG Support](https://www.youtube.com/watch?v=cDN-VW3McfQ)
-   <span aria-hidden="true">📺</span> **Video**: [UI Toolkit Tutorial Series: Shader Graph UI](https://www.youtube.com/watch?v=xAOBBW9hsjA)
-   <span aria-hidden="true">📺</span> **Video**: [UI Toolkit Tutorial Series: World Space Render Mode](https://www.youtube.com/watch?v=GgO2LF_ZMvM)
