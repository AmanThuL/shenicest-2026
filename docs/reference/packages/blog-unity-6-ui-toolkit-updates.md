---
title: "Unity 6 UI Toolkit: News and Updates"
page_title: "Unity 6 UI Toolkit: News and Updates"
source_url: "https://unity.com/blog/unity-6-ui-toolkit-updates"
final_url: "https://unity.com/blog/unity-6-ui-toolkit-updates"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Unity 6 UI Toolkit: News and Updates

<a href="https://unity.com/blog" class="text-xxs mt-8 flex items-center font-bold uppercase hover:underline"><span class="ml-1">Unity Blog</span></a>

# Unity 6 UI Toolkit: News and updates

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">BENOIT DUPUIS / UNITY</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Senior Technical Product Manager</span>

<span class="mr-2">Nov 19, 2024</span><span class="mr-2">\|</span><span class="mr-2">7 Min</span>

Programming and DevOps

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

In the fast-paced world of game development, creating an engaging user interface (UI) is just as crucial as refining game mechanics or crafting stunning visuals. A well-designed UI serves as the bridge between players and the experience you've crafted – it can make or break immersion. As games grow in complexity, the need for intuitive, responsive UIs and the ability to display dynamic data become increasingly important. Unity 6 focuses on accelerated UI development, providing tools that simplify the UI creation process, allowing teams to bring their ideas to life faster and with greater impact.

Unity 6 brings significant improvements to UI Toolkit. Whether you’re working on an expansive open-world RPG or an indie passion project, the toolkit streamlines workflows, optimizes rapid iteration, and reduces production times. By tackling the most common UI challenges – such as managing complex hierarchies, addressing performance bottlenecks, and enabling extensive customization – Unity 6 makes designing UIs more intuitive, flexible, and, most importantly, enjoyable.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

### **Key features of UI Toolkit in Unity 6**

Unity 6's UI Toolkit introduces powerful new features that streamline UI development, enhance customization, and help you create dynamic, engaging user experiences. Let's explore the highlights:

### Runtime data binding

The [new runtime data binding](https://docs.unity3d.com/Manual/UIE-runtime-binding.html) is a powerful feature that seamlessly connects UI elements with your game data at runtime. With it, developers can link variables, properties, and collections directly to UI components without writing extensive boilerplate code. This drastically reduces the manual work required to keep UI elements in sync with the underlying game state, making building responsive and dynamic interfaces effortless.

Runtime data bindings can be set directly from the UI Builder, making the workflow accessible for team members using codeless tools and enabling better collaboration. They are also extensible, letting developers create converters between value types and implement custom binding types. Additionally, runtime data bindings can be tweaked to achieve optimal performance, ensuring your game’s UI remains efficient and responsive.

Runtime data binding in the UI Builder

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

### Expanded UI controls library

The expanded UI Toolkit standard library provides even more built-in options for designing your UI. Recent additions like the TreeView and multicolumn ListView, introduced in 2022 LTS, facilitated the migration from IMGUI to UI Toolkit and are essential for managing and displaying large datasets.

This version introduces the [TabView](https://docs.unity3d.com/Manual/UIE-uxml-element-TabView.html) and [ToggleButtonGroup](https://docs.unity3d.com/Manual/UIE-uxml-element-ToggleButtonGroup.html). Buttons now have icon support, which can be displayed with or without accompanying text. These new controls are not limited to the Editor; they are also available for the runtime environment and are fully customizable to match the aesthetic of your game, ensuring a consistent and immersive player experience.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

### Improved extensibility

The extensibility of UI Toolkit has seen major upgrades, especially for creating custom controls and exposing them to the UI Builder. Developers can now create custom UI controls more easily, integrating them seamlessly for drag-and-drop design. This upgrade makes it easier for teams to build reusable, tailored components, saving development time and boosting creativity.

Gone are the days of writing boilerplate code with UXMLFactories and UXMLTraits, which are now deprecated and will be removed in future versions. The new approach involves simply decorating your C# code with \[UXMLElement\] and \[UXMLAttribute\] attributes — making custom control definition more straightforward, concise, and maintainable. Please refer to the [Unity manual](https://docs.unity3d.com/Manual/UIE-custom-tag-name-and-attributes.html) for creating custom UI controls using this new method.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

### Enhanced control configuration

Unity 6 also enhances how custom components are exposed and configured in the UI Builder, with support for property drawers and decorators, similar to those found in the Editor Inspector. These additions give developers complete control over how UI element attributes are exposed, providing UI designers with a more intuitive and efficient experience when adjusting properties. The result is polished, highly customizable interfaces that look great and function smoothly.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

### UXMLObjects for efficient data management

UXMLObjects provide a flexible way to define and manage serialized data directly within UXML files. This feature allows developers to create reusable, self-contained UI components that maintain readability, even with large data structures.

UXMLObjects enable UI elements to contain serialized data that can be stored and edited directly in the UI Builder, making it easier to reuse elements across different parts of the UI while preserving their data integrity. Designers can edit these data structures visually, streamlining workflows for data-driven UI components.

This feature is useful for creating structured, reusable data elements in UIs, such as configuring data for visualizations like pie charts. By serializing data within UXMLObjects, developers can maintain an organized and modular approach to UI design, making the process of managing large and dynamic data sets more efficient.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

### Advanced text and localization features

UI Toolkit now includes multi-language and emoji support, made possible by an optional text generator offering comprehensive Unicode and advanced text shaping capabilities. This ensures that your UI seamlessly supports various languages, including right-to-left (RTL) scripts like Arabic and Hebrew, providing true multilingual capabilities.

Bidirectional text support

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

This new text backend is entirely opt-in, allowing developers to transition at their own pace while benefiting from enhanced localization. Though there are some limitations — [documented in the manual](https://docs.unity3d.com/Manual/UIE-advanced-text-generator.html) — the system is a powerful tool for broadening the reach of your project.

The updated Localization Package allows developers to fully leverage the new multi-language support and easily localize UI Toolkit content, making games accessible in multiple languages. Integrating with the new bindings system allows this feature to be accessible directly from the UI Builder, resulting in a seamless and efficient workflow for multilingual projects.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

### Streamlined workflows

Unity 6 introduces several workflow improvements to make UI development faster and more intuitive. These updates allow developers to iterate quickly and make designing more efficient.

**Search in the control library**

The control library can become difficult to navigate, especially for complex projects with a large number of UI elements and custom controls. This update adds a fast and intuitive search capability within the control library, allowing quick access to UI elements. It works both in the Standard and the Project section, making it easier to find what you need.

Searching in the control library

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

**Extract inline styles to selector**

You now have more control over extracting inline styles, with the ability to extract specific values and apply them to an existing selector, not just create a new one. It significantly reduces the need for duplicating inline edits on a selector and allows for more experimentation with changes on a single element before "committing" them to a selector.

New options for extracting inline styles

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

**Fill attribute for sliders**

Sliders now have a fill attribute to extend their functionality and create visual elements such as volume controls, health bars, and more. The attribute enables a filled-in area for the slider, with an option to select the fill color. This new attribute is also supported in code, for example:

pre]:rounded-xl [&>pre]:!p-4">

```
var slider = new Slider();
slider.fill = true;
```

New slider color attribute

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

### **Performance enhancements**

Unity 6 introduces a wide array of performance improvements to ensure a smooth and responsive experience in both the Editor and runtime environments:

-   **Event dispatching**: Event dispatching rules have been simplified, making them easier to understand and twice as fast.
-   **Mesh generation enhancements**: Key improvements include jobified geometry generation for classic element geometry and a transition of the vector API to a native implementation. Text generation is also now parallelized.
-   **Custom Geometry API**: A new public API enables developers to generate custom geometry with the same level of performance, allowing for highly optimized UI components.
-   **Deep Hierarchy Layout Performance**: Improved caching of layout computations significantly boosts performance in deep hierarchies, providing a smoother user experience.
-   **Optimized TreeView for Large Datasets**: The TreeView control, previously inefficient with large datasets, has been enhanced with a new high-performance backend specifically for Entities.

For tips on optimizing content created with UI Toolkit, refer to this [breakout session from Unite 2024](https://www.youtube.com/watch?v=bECmaYIvZJg).

We’re committed to keeping performance front and center. Look for even more optimizations in future updates that ensure Unity remains the best platform for creating responsive, high-performing user interfaces.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

### Conclusion

Unity 6 offers a host of new features and improvements that will significantly enhance your ability to create sophisticated, high-quality UIs. Whether you're an indie developer or part of a larger studio, the advancements in performance, workflow, and customization are designed to help you push the boundaries of what's possible.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

### Get started and learn

If you want to get started with UI Toolkit, start by exploring our full [documentation and tutorials](https://docs.unity3d.com/Manual/UIElements.html), and join our [community](https://discussions.unity.com/tag/ui-toolkit) to gain inspiration from others and to share your projects.

You can learn UI Toolkit concepts with [QuizU](https://assetstore.unity.com/packages/essentials/tutorial-projects/quizu-a-ui-toolkit-sample-268492) or explore a complete game sample with [UI Toolkit Dragon Crashers](https://assetstore.unity.com/packages/essentials/tutorial-projects/dragon-crashers-ui-toolkit-sample-project-231178). Don’t miss the companion pieces to the samples:

-   QuizU [Discussions articles](https://discussions.unity.com/t/welcome-to-the-new-ui-toolkit-sample-project-quizu/308607) for programmers in mind and [video overview](https://www.youtube.com/watch?v=XlDdBUyI8fE) of the sample
-   E-book, [User interface design and implementation in Unity](https://unity.com/resources/user-interface-design-and-implementation-in-unity?isGated=false) and [video overview](https://www.youtube.com/watch?v=XtQist-I3Xo) of the sample
