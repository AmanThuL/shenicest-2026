---
title: "Introduction to VFX Graph"
page_title: "Getting started with the VFX Graph in Unity 6 - Technical Articles"
source_url: "https://unity.com/how-to/introduction-vfx-graph-unity"
final_url: "https://discussions.unity.com/t/getting-started-with-the-vfx-graph-in-unity-6/1617550"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [Getting started with the VFX Graph in Unity 6](https://unity.com/t/getting-started-with-the-vfx-graph-in-unity-6/1617550)

<span itemprop="itemListElement" itemscope="" itemtype="http://schema.org/ListItem"> <a href="https://unity.com/c/technical-articles/23" class="badge-wrapper bullet"><span class="badge-category-bg" style="background-color: #3671B5"></span> <span class="badge-category clear-badge"> <span class="category-name" itemprop="name">Technical Articles</span> </span></a> </span>

<a href="https://discussions.unity.com/tag/Visual-Effects-Graph" class="discourse-tag">Visual-Effects-Graph</a>, <a href="https://discussions.unity.com/tag/Official" class="discourse-tag">Official</a>, <a href="https://discussions.unity.com/tag/6.0" class="discourse-tag">6.0</a>

<span class="creator" itemprop="author" itemscope="itemscope" itemtype="http://schema.org/Person"> [<span itemprop="name">TechnicalContentTeam</span>](https://discussions.unity.com/u/TechnicalContentTeam) </span>

<span class="crawler-post-infos"> March 18, 2025, 2:19pm </span>

<span itemprop="position">1</span>

<a href="https://europe1.discourse-cdn.com/unity/original/4X/0/2/b/02bcd673b967002ac0e9bed8b4aa52adae1a55fe.jpeg" class="lightbox" title="Image courtesy of Sakura Rabbit"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/0/2/b/02bcd673b967002ac0e9bed8b4aa52adae1a55fe_2_690x388.jpeg" alt="Image courtesy of Sakura Rabbit" /></a>

<span class="filename">Image courtesy of Sakura Rabbit</span><span class="informations">1999×1125 342 KB</span>

  
*Image courtesy of [Sakura Rabbit](https://linktr.ee/sakura_rabbite)*

![:waving_hand:](https://emoji.discourse-cdn.com/google/waving_hand.png?v=15) Hi everyone,

In this article, we’ll cover a thorough introduction to the VFX Graph.

This is based on our latest 160-page technical e-book, *[The definitive guide to creating advanced visual effects in Unity (Unity 6 edition)](https://unity.com/resources/creating-advanced-vfx-unity6)*, which guides artists, technical artists, and programmers using the Unity 6 version of VFX Graph. Leverage it as a reference for producing richly layered, real-time visual effects for your games.

Let’s dive in!

The Visual Effect Graph (VFX Graph) enables the authoring of both simple and complex effects using node-based visual logic. As one of several major toolsets available in Unity, the VFX Graph allows artists and designers to create with little or no coding.

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-getting-started-with-real-time-vfx-in-unity-1" id="p-7068370-getting-started-with-real-time-vfx-in-unity-1" class="anchor"></a>Getting started with real-time VFX in Unity

For complex, AAA-level visual effects on high-end platforms, use the VFX Graph to create GPU-accelerated particles in an intuitive, node-based interface.

More specifically, leverage the [VFX Graph](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/GettingStarted.html) to:

-   Create one or multiple particle systems
-   Add static meshes and control shader properties
-   Create events via C# or [Timeline](https://docs.unity3d.com/Packages/com.unity.timeline@latest/index.html) to turn parts of your effects on and off
-   Extend the library of features by creating subgraphs of commonly used node combinations
-   Use a VFX Graph inside of another VFX Graph (e.g., smaller explosions as part of another, larger effect)
-   Preview changes at various rates and/or perform step-by-step simulation

The VFX Graph works with the [Universal Render Pipeline](https://docs.unity3d.com/6000.0/Documentation/Manual/urp/urp-introduction.html) (URP) and the [High Definition Render Pipeline](https://docs.unity3d.com/Packages/com.unity.render-pipelines.high-definition@17.2/manual/index.html) (HDRP). It also adds support for the **Lit** outputs and **2D Renderer** available with URP. Check the VFX Graph feature comparison for all render pipelines [here](https://docs.unity3d.com/Manual/render-pipelines-feature-comparison.html#visual-effects?).

The VFX Graph requires compute shader support to maintain compatibility with your device. Supported devices include:

-   macOS and iOS platforms using [Metal graphics](https://developer.apple.com/metal/) API
-   Linux and Windows platforms with [Vulkan](https://www.khronos.org/vulkan/) or [GLES3](https://www.khronos.org/registry/OpenGL-Refpages/es3/) APIs
-   Android for a subset of high-end compute capable devices (only with URP)

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-core-graphics-packages-2" id="p-7068370-core-graphics-packages-2" class="anchor"></a>Core graphics packages

When you install the latest release of Unity, the most recent packages for URP, HDRP, Shader Graph, VFX Graph, and more, are included. Core graphics packages are now embedded within the main Unity installer to ensure that your project is always running on the latest, verified graphics code.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/c/6/b/c6be660233dd00d74904afb518c587ea2850c962.png" class="lightbox" title="VFX sample content in the Unity Package Manager"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/c/6/b/c6be660233dd00d74904afb518c587ea2850c962_2_690x292.png" alt="VFX sample content in the Unity Package Manager" /></a>

<span class="filename">VFX sample content in the Unity Package Manager</span><span class="informations">1256×532 79.7 KB</span>

  
*Install sample content from the Package Manager*

**Additional sample content**  
If you’re new to the VFX Graph, consider installing the **Samples** in the **Package Manager**.

These contain some basic examples for you to explore:

— The new **Learning Templates**: The [Learning Templates sample](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/sample-learningTemplates.html) is a collection of VFX assets designed to help you learn about VFX Graph concepts and features. It’s compatible with both URP and HDRP render pipelines.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/a/3/f/a3fd233860d8389d8db811f7aaed5084fcba7ea8.jpeg" class="lightbox" title="The new Learning Templates"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/a/3/f/a3fd233860d8389d8db811f7aaed5084fcba7ea8_2_690x238.jpeg" alt="The new Learning Templates" /></a>

<span class="filename">The new Learning Templates</span><span class="informations">1999×691 196 KB</span>

  
*The new Learning Templates sample showcases different VFX Graph features.*

— The **Visual Effect Graph Additions**: [This includes](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/sample-content.html) example prefabs of fire, smoke, sparks, and electricity. Each sample shows a stripped down effect to illustrate fundamental graph logic and construction. Just drag and drop one of the sample **Prefabs** into the **Hierarchy** to see them in action.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/9/f/6/9f63abff76dd503dcaa4ac2e8bcde2bac9c18d0a.jpeg" class="lightbox" title="Samples from the Visual Effect Graph Additions package"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/9/f/6/9f63abff76dd503dcaa4ac2e8bcde2bac9c18d0a_2_690x248.jpeg" alt="Samples from the Visual Effect Graph Additions package" /></a>

<span class="filename">Samples from the Visual Effect Graph Additions package</span><span class="informations">1600×576 34.7 KB</span>

  
*Samples from the Visual Effect Graph Additions package*

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-introduction-to-the-vfx-graph-3" id="p-7068370-introduction-to-the-vfx-graph-3" class="anchor"></a>Introduction to the VFX Graph

Any visual effect in the VFX Graph is made up of these two parts:

-   [Visual Effect (VFX) component](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/VisualEffectComponent.html) attached to a GameObject in the scene
-   [Visual Effect (VFX) Graph Asset](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/VisualEffectGraphAsset.html) that lives at the project level

As Unity stores each VFX Graph in the Assets folder, you must connect each asset to a Visual Effect component in your scene. Keep in mind that different GameObjects can refer to the same graph at runtime.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/3/5/a/35ab23d3d904b55999bdf520c3e0f1cc91301c28.jpeg" class="lightbox" title="The VFX Graph Asset and Visual Effect component"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/3/5/a/35ab23d3d904b55999bdf520c3e0f1cc91301c28_2_690x482.jpeg" alt="The VFX Graph Asset and Visual Effect component" /></a>

<span class="filename">The VFX Graph Asset and Visual Effect component</span><span class="informations">1600×1119 169 KB</span>

  
*The VFX Graph Asset and Visual Effect component*

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-the-vfx-graph-asset-and-component-4" id="p-7068370-the-vfx-graph-asset-and-component-4" class="anchor"></a>The VFX Graph Asset and component

To create a new visual effect, right-click in the **Project** window and navigate to **Create** \> **Visual Effects** \> **Visual Effects Graph**.

This opens a creation wizard that allows you to select a starting template. You can begin with one of the default VFX Graphs or choose one of the Learning Templates from the Samples.

Note that the Learning Templates won’t appear in the window unless the additional packages are installed in the Package Manager.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/9/5/6/956579809982ec61ca07697f322005f07c39f433.png" class="lightbox" title="Select a template to create a new VFX Graph"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/9/5/6/956579809982ec61ca07697f322005f07c39f433_2_583x500.png" alt="Select a template to create a new VFX Graph" /></a>

<span class="filename">Select a template to create a new VFX Graph</span><span class="informations">952×816 87.4 KB</span>

  
*Select a template to create a new VFX Graph.*

Choose **Create** to generate a **VFX Graph Asset** in the project.

To add the effect to the scene, attach a [Visual Effect component](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/VisualEffectComponent.html) to a GameObject and then connect the VFX Graph Asset. There are few ways to do this:

-   Drag the resulting asset into the Scene view or Hierarchy. A new default GameObject will appear in the Hierarchy window.

-   Assign the asset to an existing **Visual Effect component** in the Inspector. You can create an empty GameObject by right-clicking in the Hierarchy (**Visual Effects > Visual Effect**) or create a GameObject and then manually add the Visual Effect component.

-   With a GameObject selected, drag and drop the asset into the Inspector window. This creates the Visual Effect component and assigns the asset in one quick action.

The VFX Graph Asset contains all the logic. Select one of the following ways to edit its behavior:

-   Double-click the VFX Graph Asset in the Project window.

-   Select the VFX Graph Asset in the Project window and click the **Open** button in the header.

-   Click the **Edit** button next to the **Asset Template** property in the Visual Effect component.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/1/e/7/1e7e1b52eba8f04fbf30a4d612e84e35b2b6d9f4.jpeg" class="lightbox" title="Three ways to open a VFX Graph"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/1/e/7/1e7e1b52eba8f04fbf30a4d612e84e35b2b6d9f4_2_604x500.jpeg" alt="Three ways to open a VFX Graph" /></a>

<span class="filename">Three ways to open a VFX Graph</span><span class="informations">1600×1323 141 KB</span>

  
*Three ways to open a VFX Graph*

The asset opens in the [VFX Graph window](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/VisualEffectGraphWindow.html), available under **Window** \> **Visual Effects** \> **Visual Effect Graph**.

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-the-vfx-graph-window-5" id="p-7068370-the-vfx-graph-window-5" class="anchor"></a>The VFX Graph window

Familiarize yourself with this [window’s layout](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/VisualEffectGraphWindow.html), including its:

-   [Toolbar](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/VisualEffectGraphWindow.html): To access Global settings, as well as toggles for several panels
-   [Node workspace](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/VisualEffectGraphWindow.html): To compose and edit the VFX Graph
-   [Blackboard](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/VisualEffectGraphWindow.html): To manage attributes and properties that are reusable throughout the graph
-   [VFX Control panel](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/VisualEffectGraphWindow.html): To modify playback on the attached GameObject

<a href="https://europe1.discourse-cdn.com/unity/original/4X/b/b/a/bbaf7b255b3e48cdc9a7eaa330a90308cfe51fae.png" class="lightbox" title="The VFX Graph window"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/b/b/a/bbaf7b255b3e48cdc9a7eaa330a90308cfe51fae_2_520x499.png" alt="The VFX Graph window" /></a>

<span class="filename">The VFX Graph window</span><span class="informations">1999×1922 288 KB</span>

  
*The VFX Graph window*

Make sure you leave some space in the Editor layout for the Inspector. Selecting part of the graph can expose certain parameters, such as partition options and render states.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/f/1/a/f1a7a6865fdae776498606929c45b633ecf6eeef.png" class="lightbox" title="Use the Inspector to change certain parameters"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/f/1/a/f1a7a6865fdae776498606929c45b633ecf6eeef_2_690x384.png" alt="Use the Inspector to change certain parameters" /></a>

<span class="filename">Use the Inspector to change certain parameters</span><span class="informations">1087×606 56.1 KB</span>

  
*Use the Inspector to change certain parameters.*

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-graph-logic-6" id="p-7068370-graph-logic-6" class="anchor"></a>Graph logic

You must build your visual effect from a network of nodes inside the window’s workspace. The VFX Graph uses an interface similar to other [node-based tools](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.2/manual/Getting-Started.html), such as **Shader Graph**.

Press the spacebar or right-click to create a new graph element. With the mouse over the empty workspace, select **Create Node** to create a graph’s [Context](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Contexts.html), [Operator](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Operators.html), or [Property](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Properties.html). If you hover the mouse above an existing Context, use **Create Block**.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/c/2/6/c26e7cb3b01bb66fdeba8a9b23a30556f4a9e445.jpeg" class="lightbox" title="A VFX Graph can consist of a complex network"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/c/2/6/c26e7cb3b01bb66fdeba8a9b23a30556f4a9e445_2_588x500.jpeg" alt="A VFX Graph can consist of a complex network" /></a>

<span class="filename">A VFX Graph can consist of a complex network</span><span class="informations">1600×1359 214 KB</span>

  
*A VFX Graph can consist of a complex network.*

Opening up a complex VFX Graph can be daunting at first. Fortunately though, while a production-level graph can include hundreds of nodes, every graph follows the same set of rules – no matter its size.

Let’s examine each part of the VFX Graph to learn how they work together.

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-systems-contexts-and-blocks-7" id="p-7068370-systems-contexts-and-blocks-7" class="anchor"></a>Systems, Contexts, and Blocks

A VFX Graph includes one or more vertical stacks called [Systems](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Systems.html). Systems define standalone portions of the graph and encompass several [Contexts](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Contexts.html). A System is denoted by the dotted line that frames the Contexts it consists of.

Each Context is composed of individual [Blocks](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Blocks.html), which can set [Attributes](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Attributes.html) (size, color, velocity, etc.) for its particles and meshes. Multiple Systems can work together within one graph to create the final visual effect.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/9/7/c/97c4f30999807ea5a48017c29402863d4fb726bc.jpeg" class="lightbox" title="The vertical logic in a graph flows downward"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/9/7/c/97c4f30999807ea5a48017c29402863d4fb726bc_2_494x500.jpeg" alt="The vertical logic in a graph flows downward" /></a>

<span class="filename">The vertical logic in a graph flows downward</span><span class="informations">1977×1999 286 KB</span>

  
*The vertical logic in a graph flows downward.*

Select **Insert template** from the menu dropdown to add a sample System from the existing templates to the current VFX Graph. This can help you get started with some pre-built graph logic. Select one of the Default VFX Graph Templates for a simple System, or choose one of the Learning Templates if it’s similar to your intended effect.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/8/9/2/892a0b0fdda12888fb6778a6c7a436dd56a3684b.jpeg" class="lightbox" title="Insert a template from the menu"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/8/9/2/892a0b0fdda12888fb6778a6c7a436dd56a3684b_2_690x324.jpeg" alt="Insert a template from the menu" /></a>

<span class="filename">Insert a template from the menu</span><span class="informations">1999×939 131 KB</span>

  
*Insert a template from the menu.*

If you select the **Minimal System** template from the Default VFX Graph Templates, you’ll see a barebones System, which includes four parts like this:

<a href="https://europe1.discourse-cdn.com/unity/original/4X/b/a/b/bab6cc7cb33cc597304bc7397ffbd3d65346d0c9.png" class="lightbox" title="A Minimal System from the default templates"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/b/a/b/bab6cc7cb33cc597304bc7397ffbd3d65346d0c9_2_570x499.png" alt="A Minimal System from the default templates" /></a>

<span class="filename">A Minimal System from the default templates</span><span class="informations">1999×1751 309 KB</span>

  
*A Minimal System from the default templates*

The flow between the Contexts determines how particles spawn and simulate. Each Context defines one stage of computation:

-   **Spawn**: Determines how many particles you should create and when to spawn them (e.g., in one burst, looping, with a delay, etc.)
-   **Initialize**: Determines the starting Attributes for the particles, as well as the Capacity (maximum particle count) and Bounds (volume where the effect renders)
-   **Update**: Changes the particle properties each frame; here you can apply Forces, add animation, create Collisions, or set up some interaction, such as with Signed Distance Fields (SDF)
-   **Output**: Renders the particles and determines their final look (color, texture, orientation); each System can have multiple outputs for maximum flexibility

Systems and Contexts form the backbone of the graph’s “vertical logic,” or [processing workflow](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/GraphLogicAndPhilosophy.html). Data in a System flows downward, from top to bottom, and each Context encountered along the way modifies the data according to the simulation.

Systems are flexible, so you can omit a Context as needed or link multiple outputs together. This example shows more than one **Output Context** rendering within the same System.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/8/7/d/87d85da3e063816338c5faf21046b0fac126f88b.png" class="lightbox" title="More than one Output Context within the same System"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/8/7/d/87d85da3e063816338c5faf21046b0fac126f88b_2_690x333.png" alt="More than one Output Context within the same System" /></a>

<span class="filename">More than one Output Context within the same System</span><span class="informations">1600×774 167 KB</span>

  
*More than one Output Context within the same System*

Contexts themselves behave differently depending on their individual Blocks, which similarly calculate data from top to bottom. You can add and manipulate more Blocks to process that data.

Click the button at the top-right corner of a Context to toggle the System’s simulation space between **Local** and **World**.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/7/f/4/7f40df66687825544f82b25fc00cf44efb64ace5.png" class="lightbox" title="Examples of different Blocks"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/7/f/4/7f40df66687825544f82b25fc00cf44efb64ace5_2_690x489.png" alt="Examples of different Blocks" /></a>

<span class="filename">Examples of different Blocks</span><span class="informations">1999×1417 239 KB</span>

  
*Examples of different Blocks*

Blocks can do just about anything, from simple value storage for Color, to complex operations such as **Noises**, **Forces**, and **Collisions**. They often have slots on the left, where they can receive input from Operators and Properties.

See the [Node Library](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/node-library.html) for a complete list of Contexts and Blocks.

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-properties-and-operators-8" id="p-7068370-properties-and-operators-8" class="anchor"></a>Properties and Operators

Just as Systems form much of the graph’s vertical logic, Operators make up the “horizontal logic” of its [property workflow](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Operators.html). They can help you pass custom expressions or values into your Blocks.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/a/b/0/ab09cd428380cd43959612147794156d35f68232.jpeg" class="lightbox" title="Horizontal logic"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/a/b/0/ab09cd428380cd43959612147794156d35f68232_2_690x464.jpeg" alt="Horizontal logic" /></a>

<span class="filename">Horizontal logic</span><span class="informations">1999×1347 189 KB</span>

  
*Horizontal logic*

Operators flow left to right, akin to Shader Graph nodes. You can use them for handling values or performing a range of calculations.

Use the **Create Node** menu (right-click or press the spacebar) to create **Operator Nodes**. You can also drag an Edge Connection from a property slot and release it in an empty space, which will open the same menu with only the compatible Operators displayed.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/1/c/8/1c88144f344ba9f387fdf71c413fce4ab8c0b54b.png" class="lightbox" title="Create an Operator Node from the menu"><img src="https://europe1.discourse-cdn.com/unity/original/4X/1/c/8/1c88144f344ba9f387fdf71c413fce4ab8c0b54b.png" alt="Create an Operator Node from the menu" /></a>

<span class="filename">Create an Operator Node from the menu</span><span class="informations">353×322 9.6 KB</span>

  
*Create an Operator Node from the menu.*

These Operators from the Bonfire sample, for instance, compute a random wind direction.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/a/8/9/a8945e453e0ed5a21d8c1fff1826664992a0bcfe.png" class="lightbox" title="How wind direction is determined in the Bonfire sample"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/a/8/9/a8945e453e0ed5a21d8c1fff1826664992a0bcfe_2_690x243.png" alt="How wind direction is determined in the Bonfire sample" /></a>

<span class="filename">How wind direction is determined in the Bonfire sample</span><span class="informations">1600×565 87 KB</span>

  
*How wind direction is determined in the Bonfire sample*

Properties are editable fields that connect to graph elements using the [property workflow](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.0/manual/GraphLogicAndPhilosophy.html#property-workflow-horizontal-logic). Properties can be:

-   Any **Type**, including [integers, floats, and booleans](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Properties.html)
-   Made from **Compound** components, such as [Vectors and Colors](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Properties.html)
-   [Cast and converted](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Properties.html) (e.g., an integer to a float)
-   [Local or World space](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Properties.html); click the **L** or **W** to switch between them

Properties change value according to their actual value in the graph. You can connect the input ports (to the left of the Property) to other graph nodes.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/9/b/5/9b5c3c37186c18bb39c82ae97a03ccfbef296b6d.png" class="lightbox" title="A Force Property in a Block"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/9/b/5/9b5c3c37186c18bb39c82ae97a03ccfbef296b6d_2_690x257.png" alt="A Force Property in a Block" /></a>

<span class="filename">A Force Property in a Block</span><span class="informations">1600×598 67.8 KB</span>

  
*A Force Property in a Block*

**Property Nodes** are Operators that allow you to [reuse the same value](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Properties.html) at various points in the graph. They have corresponding global Properties that appear in the Blackboard.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/8/8/6/8866dfd15d345aaeb2e6f1744cff8cae2078711c.png" class="lightbox" title="Property Nodes"><img src="https://europe1.discourse-cdn.com/unity/original/4X/8/8/6/8866dfd15d345aaeb2e6f1744cff8cae2078711c.png" alt="Property Nodes" /></a>

<span class="filename">Property Nodes</span><span class="informations">702×131 8.06 KB</span>

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-the-blackboard-9" id="p-7068370-the-blackboard-9" class="anchor"></a>The Blackboard

The [Blackboard](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Blackboard.html) utility panel manages [Properties](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Properties.html) and [Attributes](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Attributes.html). To open it, click the **Blackboard** button in the window [Toolbar](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.0/manual/VisualEffectGraphWindow.html#Toolbar) or use the default Shift-1 shortcut.

To view Properties and Attributes together, select the **All** tab at the top of the Blackboard. To filter by type, select the respective Properties or Attributes tab.

Properties you define in the Blackboard act as global variables that you can reuse throughout the graph as [Property Nodes](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Properties.html). For example, you can define a bounding box property once and then apply it across multiple particle systems within the same graph.

Properties in the Blackboard are either:

-   **Exposed**: The green dot to the left of any Exposed Property indicates that you can see and edit it outside of the graph. Access an Exposed Property in the Inspector via script using the [Exposed Property class](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/ExposedPropertyHelper.html).
-   **Constant**: A Blackboard property without a green dot is a Constant. It is reusable within the graph but does not appear in the Inspector.

New properties are set to Exposed by default, and as such, appear in the Inspector. You must uncheck the **Exposed** option if you want to hide your Property outside of the graph, and create **Categories** to keep your properties organized.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/0/f/a/0fa9e6e08cabe462b6011f8a2ddbcdcf336df865.png" class="lightbox" title="The Blackboard and its available properties"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/0/f/a/0fa9e6e08cabe462b6011f8a2ddbcdcf336df865_2_405x500.png" alt="The Blackboard and its available properties" /></a>

<span class="filename">The Blackboard and its available properties</span><span class="informations">766×945 42.9 KB</span>

  
*The Blackboard and its available properties*

The Blackboard also manages both built-in and custom Attributes, which you can drag and drop into the graph or create directly from the interface. Each Attribute includes a short description. Hover over an attribute to highlight where it appears in the graph.

See Blackboard Attributes below for more details.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/2/5/c/25c9d1d2060a88229f79847962d47b3fdcb457fd.png" class="lightbox" title="The Sample Skinned Mesh template includes a custom Attribute"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/2/5/c/25c9d1d2060a88229f79847962d47b3fdcb457fd_2_447x500.png" alt="The Sample Skinned Mesh template includes a custom Attribute" /></a>

<span class="filename">The Sample Skinned Mesh template includes a custom Attribute</span><span class="informations">1100×1228 57.6 KB</span>

  
*The Sample Skinned Mesh template includes a custom Attribute.*

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-group-nodes-and-sticky-notes-10" id="p-7068370-group-nodes-and-sticky-notes-10" class="anchor"></a>Group Nodes and Sticky Notes

As your graph logic grows, use Group Nodes and [Sticky Notes](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/StickyNotes.html) to cut down on clutter. With Group Nodes, you can label a group of nodes and move them as one. On the other hand, Sticky Notes operate like code comments.

To create Group Nodes, select a group of nodes, right-click over them, then choose **Group Selection**. You can also use the new default shortcut, Shift + G.

You can also drag and drop a node into an existing Group Node. Hover the node over the Group and release it once the Group highlights. To remove a node from a Group, hold the Shift key while dragging it out.

By deleting a Group Node, either with the Delete key or from the right-click menu, you do not delete its included nodes.

Meanwhile, you can use Sticky Notes to describe how a section of the graph works, plus leave comments for yourself or your teammates. Add as many Sticky Notes as you need and freely move or resize them.

Each Sticky Note has a title and a body. Right-click in the graph view to create a Sticky Note. Double-click on a text area to edit its content. Set the Theme color (dark/light) and Text Size from the right click menu to organize your notes.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/4/1/8/418ee2e76d1ce818ef91446a5099e228dd0ec73f.png" class="lightbox" title="Group Nodes and Sticky notes"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/4/1/8/418ee2e76d1ce818ef91446a5099e228dd0ec73f_2_690x392.png" alt="Group Nodes and Sticky notes" /></a>

<span class="filename">Group Nodes and Sticky notes</span><span class="informations">1999×1138 219 KB</span>

  
*Work with Group Nodes and add Sticky Notes.*

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-subgraphs-11" id="p-7068370-subgraphs-11" class="anchor"></a>Subgraphs

A Subgraph appears as a single node, which can help declutter your graph logic. Use it to save part of your VFX Graph as a separate asset that you can drop into another VFX Graph for reorganization and reuse.

To create a Subgraph, select a set of nodes and then pick **Convert To Subgraph Operator** from the right mouse menu. Save the asset to disk and convert the nodes into a single **Subgraph Node**. You can package Systems, Blocks, and Operators into different types of Subgraphs.

Creating a Subgraph is analogous to refactoring code. Just as you would organize logic into reusable methods or functions, a Subgraph makes elements of your VFX Graph more modular.

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-levels-of-editing-in-vfx-graph-12" id="p-7068370-levels-of-editing-in-vfx-graph-12" class="anchor"></a>Levels of editing in VFX Graph

The VFX Graph supports three different levels of editing:

-   **Asset instance configuration**: Use this to modify any existing VFX Graph. Designers and programmers alike can adjust exposed parameters in the Inspector to tweak an effect’s look, timing, or setup. Artists can also use external scripting or events to change preauthored content. At this level, you’re treating each graph as a black box.

-   **VFX asset authoring**: This is where your creativity can truly take charge. Build a network of Operator Nodes to start making your own VFX Graph, and set up custom behaviors and parameters to create custom simulations. Whether you’re riffing off existing samples or starting from scratch, you can take ownership of a specific effect.

-   **VFX scripting**: This supports more experienced technical artists or graphics programmers using the [component API](https://docs.unity3d.com/6000.0/Documentation/ScriptReference/VFX.VisualEffect.html) to customize the VFX Graph’s behavior. With VFX scripting, your team can enjoy a more efficient pipeline for managing specific effects, and access advanced features like the Graphics Buffers.  
    [Custom HLSL](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Block-CustomHLSL.html) in Unity 6 allows you to implement complex or unique particle behaviors that aren’t easily achievable using the standard VFX Graph nodes. For example, you could create custom physics simulations, particle interactions, or flocking behaviors.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/5/a/9/5a9244f3843f9e5382e2ebe457bad6c92e7476bb.png" class="lightbox" title="Custom HLSL can create custom behaviors or interactions"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/5/a/9/5a9244f3843f9e5382e2ebe457bad6c92e7476bb_2_690x385.png" alt="Custom HLSL can create custom behaviors or interactions" /></a>

<span class="filename">Custom HLSL can create custom behaviors or interactions</span><span class="informations">1470×822 208 KB</span>

  
*Custom HLSL can create custom behaviors or interactions*

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-attributes-13" id="p-7068370-attributes-13" class="anchor"></a>Attributes

An [Attribute](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Attributes.html) is a piece of data you might use within a System, such as the color of a particle, its position and size, or how many of them you should spawn. Attributes can be read or modified during the simulation to create dynamic effects.

Attributes can be of type float (single-precision floating-point), Vector2, Vector3, Vector4 (2D, 3D, 4D vectors), bool (true/false), or int/uint (integer/unsigned integer).

Attributes are essential for managing the fundamental aspects of your VFX Graph particles. See the Standard Attributes [documentation page](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Reference-Attributes.html) for a complete list.

Most Attributes are stored per particle, which can increase the memory footprint as the number of particles and Attributes grows. For instance, if you have 10,000 particles and each particle stores multiple Attributes like position, velocity, color, and size, the memory required to maintain this data can become significant.

Monitor and optimize your Attributes by using the System Attribute Summary and Current Attribute Layout displayed in the Inspector when you select a Context:

-   **System Attribute Summary**: This section provides an overview of all system-level Attributes being used within the current System.

-   **Current Attribute Layout:** This section shows the Attributes used in the selected Context.

-   **Source Attribute Layout**: This section shows Attributes used in the source Context (the Context that provides the initial data or input), e.g. Attributes initialized in the Initialize Context that are then used in the Update Context.

For example, in the **Trigger Event on Collide** template, if you select a Context within the Dart_Spawn System, the Inspector shows:

<a href="https://europe1.discourse-cdn.com/unity/original/4X/5/3/9/539bf8313585a94dce7eebd06dff51a8ac528da5.jpeg" class="lightbox" title="Use the Inspector to see Attribute usage in the Context"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/5/3/9/539bf8313585a94dce7eebd06dff51a8ac528da5_2_314x500.jpeg" alt="Use the Inspector to see Attribute usage in the Context" /></a>

<span class="filename">Use the Inspector to see Attribute usage in the Context</span><span class="informations">986×1570 175 KB</span>

  
*Use the Inspector to see Attribute usage in the Context.*

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-events-14" id="p-7068370-events-14" class="anchor"></a>Events

The various parts of a VFX Graph communicate with each other (and the rest of your scene) through [Events](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Events.html). For example, each **Spawn Context** contains **Start** and **Stop** flow ports, which receive Events to control particle spawning.

When something needs to happen, external GameObjects can notify parts of your graph with the **SendEvent** method of the [C# API](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/ComponentAPI.html). Visual Effect components will then pass the Event as a string name or property ID.

An **Event Context** identifies an Event by its [Event string name or ID inside a graph](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Events.html). In the above example, external objects in your scene can raise an **OnPlay Event** to start a Spawn system or an OnStop Event to stop it.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/1/c/2/1c285035f6349aa382258e9d309a081d03e2919a.png" class="lightbox" title="Events control particle spawning"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/1/c/2/1c285035f6349aa382258e9d309a081d03e2919a_2_690x340.png" alt="Events control particle spawning" /></a>

<span class="filename">Events control particle spawning</span><span class="informations">1600×789 68.9 KB</span>

  
*Events control particle spawning.*

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-output-events-15" id="p-7068370-output-events-15" class="anchor"></a>Output Events

You can combine an **Output Event** with an [Output Event Handler](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/OutputEventHandlers.html). Output Events are useful if the initial spawning of the particles needs to drive something else in your scene. This is common for synchronizing lighting or gameplay with your visual effects.

The above example sends an **OnReceivedEven**t to a GameObject component outside of the graph. The C# script will then react accordingly to intensify a light or flame, activate a spark, etc.

At the same time, you can use **GPU Events** to spawn particles based on other particle behavior. This way, when a particle dies in one system, you can notify another system, which creates a useful chain reaction of effects, such as a projectile particle that spawns a dust effect upon death.

These **Update Blocks** can send [GPU Event](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Events.html) data in the following way:

-   **Trigger Event On Die**: Spawns particles on another system when a particle dies
-   **Trigger Event Rate**: Spawns particles per second (or based on their velocity)
-   **Trigger Event Always**: Spawns particles every frame

The Blocks’ outputs connect to a **GPU Event Context**, which can then notify an **Initialize Context** of a dependent system. Chaining different systems together in this fashion helps you create richly detailed and complex particle effects.

The Initialize Context of the GPU Event system can also inherit Attributes available in the parent system prior to the Trigger Event. So, for instance, by inheriting its position, a new particle will appear in the same place as the original particle that spawned it.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/1/6/4/164ceeabb3ccc8c9b7d8e5aeb0aa202e0f1eced9.png" class="lightbox" title="An Output Event can send messages to the scene"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/1/6/4/164ceeabb3ccc8c9b7d8e5aeb0aa202e0f1eced9_2_690x455.png" alt="An Output Event can send messages to the scene" /></a>

<span class="filename">An Output Event can send messages to the scene</span><span class="informations">1600×1057 98.7 KB</span>

  
*An Output Event can send messages to the scene*

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-event-attributes-16" id="p-7068370-event-attributes-16" class="anchor"></a>Event attributes

Use **Event Attribute Payloads** to pass data like 3D position or color along with the Event. These Payloads carry Attributes that implicitly travel through the graph where you can “catch” the data in an Operator or Block.

You can also read Attributes passed with **Spawn Events** or **Timeline Events**. The [Set SpawnEvent Attribute Block](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Block-SetSpawnEvent.html) modifies the Event Attribute in a Spawn Context.

To catch a Payload in an Initialize Context, use **Get Source Attribute Operators** or **Inherit Attribute Blocks**.

However, it’s important to keep these caveats in mind when using Event Attributes:

-   **Regular Event Attributes** can only be read in the Initialize Context. You cannot inherit them in Update or Output. To use the Attribute in a later Context, you must inherit and set it in Initialize.

-   **Output Event Attributes** only carry the initial values set in the Spawn Context. They do not catch any changes that occur later in the graph.

See [Sending Events](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/ComponentAPI.html) in the Visual Effect component API for more details.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/d/3/3/d3322d2e04b54eb33895af34baf10e890f865310.jpeg" class="lightbox" title="Output Event Attributes carry values from the Spawn Context"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/d/3/3/d3322d2e04b54eb33895af34baf10e890f865310_2_690x284.jpeg" alt="Output Event Attributes carry values from the Spawn Context" /></a>

<span class="filename">Output Event Attributes carry values from the Spawn Context</span><span class="informations">1920×793 71.3 KB</span>

  
*Output Event Attributes carry values from the Spawn Context*

## <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-ui-improvements-in-unity-6-17" id="p-7068370-ui-improvements-in-unity-6-17" class="anchor"></a>UI improvements in Unity 6

Unity 6 includes several quality of life improvements and updates to the VFX Graph UI.

#### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-node-search-18" id="p-7068370-node-search-18" class="anchor"></a>Node search

Creating nodes or blocks now uses a [hierarchical tree view](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/whats-new-17.html), making it easier to browse the node library. Enhancements include custom colors and a favorites folder for a more efficient and personalized search experience. Use the advanced search filtering to select from the available nodes.

The new side detail panels also display any node sub-variants (e.g., Output Particle Unlit Octagon and Output Particle Unlit Triangle are sub-variants of Output Particle Unlit Quad). You can toggle the button to show sub-variants to control their visibility. Disable it to see only the most common nodes, or enable it to access all available variants.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/c/3/f/c3f9686681688d7c99c97172526aebf688089fb6.png" class="lightbox" title="Creating nodes or blocks adds a side panel and search filtering"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/c/3/f/c3f9686681688d7c99c97172526aebf688089fb6_2_690x472.png" alt="Creating nodes or blocks adds a side panel and search filtering" /></a>

<span class="filename">Creating nodes or blocks adds a side panel and search filtering</span><span class="informations">1499×1026 56 KB</span>

  
*Creating nodes or blocks adds a side panel and search filtering.*

#### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-activation-ports-19" id="p-7068370-activation-ports-19" class="anchor"></a>Activation ports

A Block has a special [activation port](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Blocks.html), located on the top left next to its name, which is linked to a boolean property. This port allows you to control whether a Block is active.

You can manually toggle the Block on or off, or connect graph logic to the port to control when the Block should be active. This allows you to implement different behaviors or states per particle within the same system.

Note that statically inactive Blocks are grayed out and automatically removed during compilation, resulting in zero runtime cost.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/e/d/e/edea3e94e3ba178bddf65336f0c231a916a0a56d.png" class="lightbox" title="Each block includes an Activation port"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/e/d/e/edea3e94e3ba178bddf65336f0c231a916a0a56d_2_690x310.png" alt="Each block includes an Activation port" /></a>

<span class="filename">Each block includes an Activation port</span><span class="informations">1322×595 48.1 KB</span>

  
*Each block includes an Activation port.*

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-new-vfx-toolbar-20" id="p-7068370-new-vfx-toolbar-20" class="anchor"></a>New VFX Toolbar

The VFX toolbar has been simplified and now includes new options for quick access to documentation and samples.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/f/3/f/f3f7d49aa0bf5ed919e989938ed3b5202ebf85df.png" class="lightbox" title="The VFX Toolbar has been simplified"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/f/3/f/f3f7d49aa0bf5ed919e989938ed3b5202ebf85df_2_690x312.png" alt="The VFX Toolbar has been simplified" /></a>

<span class="filename">The VFX Toolbar has been simplified</span><span class="informations">1999×904 165 KB</span>

  
*The VFX Toolbar has been simplified*

#### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-keyboard-shortcuts-21" id="p-7068370-keyboard-shortcuts-21" class="anchor"></a>Keyboard shortcuts

The [Shortcut Manager](https://docs.unity3d.com/6000.0/Documentation/Manual/ShortcutsManager.html) now has a VFX Graph category that lets you modify the shortcut command available in the Visual Effect Graph window. New shortcut commands have been added to speed up the VFX artist’s workflow.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/8/e/8/8e87f97ac439d27cf133317cf0661ca61d8cce00.png" class="lightbox" title="The Shortcut Manager in Unity"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/8/e/8/8e87f97ac439d27cf133317cf0661ca61d8cce00_2_690x475.png" alt="The Shortcut Manager in Unity" /></a>

<span class="filename">The Shortcut Manager in Unity</span><span class="informations">954×657 76.7 KB</span>

  
*The Shortcut Manager now has a VFX Graph category.*

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-exploring-vfx-sample-content-22" id="p-7068370-exploring-vfx-sample-content-22" class="anchor"></a>Exploring VFX sample content

A VFX Graph is more than the sum of its parts. It requires a solid understanding of how to apply each Node and Operator, along with the ways they can work together.

Two samples, available in the Package Manager, can help show these features in context: The [VFX Graph Learning Templates](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/sample-learningTemplates.html) and the [VFX Graph Additions](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/sample-content.html).

<a href="https://europe1.discourse-cdn.com/unity/original/4X/c/6/b/c6be660233dd00d74904afb518c587ea2850c962.png" class="lightbox" title="VFX sample content in the Unity Package Manager"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/c/6/b/c6be660233dd00d74904afb518c587ea2850c962_2_690x292.png" alt="VFX sample content in the Unity Package Manager" /></a>

<span class="filename">VFX sample content in the Unity Package Manager</span><span class="informations">1256×532 79.7 KB</span>

  
*Install the sample content from the Package Manager.*

The [VFX Graph Learning Templates](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/sample-learningTemplates.html) showcase a number of techniques. This collection of education samples can help you explore a specific aspect or feature set of VFX Graph.

The sample content is compatible with both URP and HDRP projects, for VFX Graph versions 17.0 (Unity 6) and later.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/1/9/6/196c95a51385bbbe5a06fa45c06a5a36cbe8f3fe.jpeg" class="lightbox" title="VFX Graph Learning templates"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/1/9/6/196c95a51385bbbe5a06fa45c06a5a36cbe8f3fe_2_690x340.jpeg" alt="VFX Graph Learning templates" /></a>

<span class="filename">VFX Graph Learning templates</span><span class="informations">1616×797 78.2 KB</span>

  
*Get started using the VFX Graph Learning Templates.*

Use the Scene view to move around freely or the Game view to focus on each effect. The **Sample Showcase Window** in the Inspector displays the corresponding information, with quick-access links to the documentation or to navigate between effects. Each VFX asset includes embedded notes and explanations to guide you.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/d/9/f/d9f496bc26487c21bed13713b98ab7df3f427974.jpeg" class="lightbox" title="The Sample Showcase Window"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/d/9/f/d9f496bc26487c21bed13713b98ab7df3f427974_2_690x233.jpeg" alt="The Sample Showcase Window" /></a>

<span class="filename">The Sample Showcase Window</span><span class="informations">1920×650 105 KB</span>

  
*Navigate each VFX Graph using the Sample Showcase Window.*

The [VFX Graph Additions](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/sample-content.html) in the Package Manager demonstrate several simple graphs, making them a starting point for learning how to manage particles.

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-noise-and-operators-23" id="p-7068370-noise-and-operators-23" class="anchor"></a>Noise and Operators

Procedural Noise helps reduce the “machine-like” look of your rendered imagery. The VFX Graph provides several Operators that you can use for one-, two-, and three-dimensional [Noise](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Operator-CellularCurlNoise.html) and [Randomness](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Operator-RandomNumber.html).

<a href="https://europe1.discourse-cdn.com/unity/original/4X/4/a/e/4ae240134317359e7141f717cc57960ae06f2b22.png" class="lightbox" title="Noise and Random Operators"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/4/a/e/4ae240134317359e7141f717cc57960ae06f2b22_2_690x490.png" alt="Noise and Random Operators" /></a>

<span class="filename">Noise and Random Operators</span><span class="informations">971×690 57.7 KB</span>

  
*Noise and Random Operators*

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-attribute-blocks-24" id="p-7068370-attribute-blocks-24" class="anchor"></a>Attribute blocks

Attribute Blocks similarly include the option of applying Randomness in various modes. They can vary slightly per Attribute, so experiment with them to familiarize yourself with their behavior.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/0/4/3/043367289ecb1edb26c1102c288fd9850a908120.jpeg" class="lightbox" title="Randomness Blocks"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/0/4/3/043367289ecb1edb26c1102c288fd9850a908120_2_400x500.jpeg" alt="Randomness Blocks" /></a>

<span class="filename">Randomness Blocks</span><span class="informations">866×1080 118 KB</span>

  
*Randomness Blocks*

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-flipbooks-25" id="p-7068370-flipbooks-25" class="anchor"></a>Flipbooks

An animated texture can do wonders to make your effects believable. Generate these from an external **Digital Content Creation** (DCC) tool or from within Unity. Use Operators to manage the [Flipbook Block](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Block-FlipbookPlayer.html).

<a href="https://europe1.discourse-cdn.com/unity/original/4X/4/6/1/4611fde4a40cd9b16bc24b360d9236337e3f088d.png" class="lightbox" title="Flipbook Nodes"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/4/6/1/4611fde4a40cd9b16bc24b360d9236337e3f088d_2_676x500.png" alt="Flipbook Nodes" /></a>

<span class="filename">Flipbook Nodes</span><span class="informations">1278×945 127 KB</span>

  
*Flipbook Nodes*

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-physics-26" id="p-7068370-physics-26" class="anchor"></a>Physics

[Forces](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Block-Force.html), [Collisions](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Block-CollideWithAABox.html), and [Drag](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/Block-LinearDrag.html) are essential to making particles simulate natural phenomena. But don’t be afraid to push the boundaries of what’s real. As the artist, you get to decide what looks just right.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/0/7/c/07c594109f10e328057d945b01f3056b5408bd4f.png" class="lightbox" title="Physics Blocks"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/0/7/c/07c594109f10e328057d945b01f3056b5408bd4f_2_507x500.png" alt="Physics Blocks" /></a>

<span class="filename">Physics Blocks</span><span class="informations">1033×1018 112 KB</span>

  
*Physics Blocks*

### <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-visual-effect-subgraphs-27" id="p-7068370-visual-effect-subgraphs-27" class="anchor"></a>Visual Effect Subgraphs

A Visual Effect Subgraph is an asset that contains a part of a Visual Effect Graph that can be used in another Visual Effect Graph or Subgraph. Subgraphs appear as a single node.

Subgraphs can be used in graphs in the following three ways:

-   **System Subgraph**: One or many Systems contained in one Graph
-   **Block Subgrap**h: A set of Blocks and Operators packaged together and used as a Block
-   **Operator Subgraph**: A set of Operators packaged together and used as an Operator

Subgraphs enable you to factorize commonly used sets of nodes from graphs into reusable assets to add to the Library.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/8/8/1/881afa6b5759ca5b78d560d41742cf61a77d0551.jpeg" class="lightbox" title="The Bonfire sample graph uses three Subgraphs"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/8/8/1/881afa6b5759ca5b78d560d41742cf61a77d0551_2_690x433.jpeg" alt="The Bonfire sample graph uses three Subgraphs" /></a>

<span class="filename">The Bonfire sample graph uses three Subgraphs</span><span class="informations">1999×1257 221 KB</span>

  
*The Bonfire sample graph uses three Subgraphs.*

## <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-vfx-graph-learning-templates-28" id="p-7068370-vfx-graph-learning-templates-28" class="anchor"></a>VFX Graph Learning Templates

If you’re still new to VFX Graph, this collection of VFX Graphs is the best place to start. The Learning Templates are composed of various real-time effects, each here to teach one or more aspects of VFX Graph.

The graphs are small and focused, making them ideal learning samples. Dive into each template to master a new technique or use it as a starting point for your own effect. Each graph comes with detailed notes to help you understand their construction.

The Learning Templates are available from the wizard when creating a new VFX Graph, or you can import them via the Package Manager as a complete sample scene for either URP or HDRP.

Use the VFX Samples Showcase window to navigate the samples.

<a href="https://europe1.discourse-cdn.com/unity/original/4X/9/6/2/9627886f3d815edbfed6d945566eab43246ca220.jpeg" class="lightbox" title="The Samples Showcase window"><img src="https://europe1.discourse-cdn.com/unity/optimized/4X/9/6/2/9627886f3d815edbfed6d945566eab43246ca220_2_690x318.jpeg" alt="The Samples Showcase window" /></a>

<span class="filename">The Samples Showcase window</span><span class="informations">1999×922 263 KB</span>

  
*The Samples Showcase window.*

If you want to take a tour of the VFX Learning Templates, make sure to check out the *[VFX Graph Learning Templates tutorial](https://youtu.be/DKVdg8DsIVY)* or the VFX Learning Templates chapter in the *[Introduction to advanced visual effects for advanced creators (Unity 6 edition)](https://unity.com/resources/creating-advanced-vfx-unity6)* e-book.

<a href="https://www.youtube.com/watch?v=DKVdg8DsIVY" class="video-thumbnail"><img src="https://europe1.discourse-cdn.com/unity/original/4X/d/1/3/d13210bbde6900cf3c2c90615c383842cd1a7d8d.jpeg" /></a>

## <a href="https://unity.com/how-to/introduction-vfx-graph-unity#p-7068370-more-resources-29" id="p-7068370-more-resources-29" class="anchor"></a>More resources

-   E-book: [The definitive guide to creating advanced visual effects in Unity (Unity 6 edition)](https://unity.com/resources/creating-advanced-vfx-unity6)
-   Video tutorial: [Create advanced visual effects in VFX Graph: Decals \| Unity](https://youtu.be/nqhkB8CG8pc)
-   Video tutorial: [Create advanced visual effects in VFX Graph: A portal effect \| Tutorial](https://youtu.be/QpLvBIFyhuE)
-   Documentation: [Learning Templates Sample Content](https://docs.unity3d.com/Packages/com.unity.visualeffectgraph@17.2/manual/sample-learningTemplates.html)

Thanks for reading! We hope you find this article useful.

As usual, let us know if you have any feedback on the updated version of the VFX e-book or the VFX Graph Learning Templates video tutorial.

<span class="post-likes">6 Likes</span>

<span class="creator" itemprop="author" itemscope="itemscope" itemtype="http://schema.org/Person"> [<span itemprop="name">shanayyy42</span>](https://discussions.unity.com/u/shanayyy42) </span>

<span class="crawler-post-infos"> August 21, 2025, 8:17am </span>

<span itemprop="position">2</span>

I tried out VFX Graph today and I’ve found it quite user-friendly so far, with a lot of attention to detail. For example:

Nodes can be linked to different systems simultaneously (no kidding, in ShaderGraph, if a node is connected to a Vertex block, it can’t be connected to a Fragment block, even if it’s available in the Fragment, so the node has to be duplicated).

You can add or multiply multiple values ​​with a single node. Neat!

Most compound values, like Vector3, can be expanded. Say goodbye to “combine” and “split” nodes.

You can sample a SkinedMashRenderer, which was a pleasant surprise when I discovered it. I easily made an effect where a character turns to dust while running.

You can preview it by scrubbing in the timeline. It feels really nice to control time, right?

So I just want to say, well done, your work should be promoted.

<span class="post-likes">5 Likes</span>

<span class="creator" itemprop="author" itemscope="itemscope" itemtype="http://schema.org/Person"> [<span itemprop="name">OrsonFavrel</span>](https://discussions.unity.com/u/OrsonFavrel) </span>

<span class="crawler-post-infos"> August 22, 2025, 1:00am </span>

<span itemprop="position">3</span>

Thank you so much for that positive feedback. I will transmit them to the team ![:slightly_smiling_face:](https://emoji.discourse-cdn.com/google/slightly_smiling_face.png?v=14). Have a lovely day.

<span class="post-likes"></span>

### Related topics

<table class="topic-list"><colgroup><col style="width: 20%" /><col style="width: 20%" /><col style="width: 20%" /><col style="width: 20%" /><col style="width: 20%" /></colgroup><thead><tr class="header"><th>Topic</th><th></th><th class="replies">Replies</th><th class="views">Views</th><th>Activity</th></tr></thead><tbody><tr id="topic-list-item-851128" class="odd topic-list-item"><td class="main-link" itemprop="itemListElement" itemscope="" itemtype="http://schema.org/ListItem"><span class="link-top-line"> <a href="https://discussions.unity.com/t/2021-2-some-feedback-about-vfx-graph/851128" class="title raw-link raw-topic-link">[2021.2] Some feedback about VFX graph</a> </span><a href="https://unity.com/c/graphics/visual-effects/138" class="badge-wrapper bullet"><span class="badge-category-bg" style="background-color: #865EA6"></span> <span class="badge-category clear-badge"> <span class="category-name">Visual Effects</span> </span></a><a href="https://discussions.unity.com/tag/visual-effects-graph/159340" class="discourse-tag">Visual-Effects-Graph</a> ,  <a href="https://discussions.unity.com/tag/feedback/160210" class="discourse-tag">Feedback</a></td><td class="replies"><span class="posts" title="posts">22</span></td><td class="views"><span class="views" title="views">4838</span></td><td>January 27, 2022</td><td></td></tr><tr id="topic-list-item-789502" class="even topic-list-item"><td class="main-link" itemprop="itemListElement" itemscope="" itemtype="http://schema.org/ListItem"><span class="link-top-line"> <a href="https://discussions.unity.com/t/visual-effect-graph-public-roadmap-now-live/789502" class="title raw-link raw-topic-link">Visual Effect Graph Public Roadmap Now Live!</a> </span><a href="https://unity.com/c/graphics/visual-effects/138" class="badge-wrapper bullet"><span class="badge-category-bg" style="background-color: #865EA6"></span> <span class="badge-category clear-badge"> <span class="category-name">Visual Effects</span> </span></a><a href="https://discussions.unity.com/tag/visual-effects-graph/159340" class="discourse-tag">Visual-Effects-Graph</a> ,  <a href="https://discussions.unity.com/tag/official/160110" class="discourse-tag">Official</a></td><td class="replies"><span class="posts" title="posts">35</span></td><td class="views"><span class="views" title="views">11794</span></td><td>June 23, 2024</td><td></td></tr><tr id="topic-list-item-718892" class="odd topic-list-item"><td class="main-link" itemprop="itemListElement" itemscope="" itemtype="http://schema.org/ListItem"><span class="link-top-line"> <a href="https://discussions.unity.com/t/feedback-wanted-visual-effect-graph/718892" class="title raw-link raw-topic-link">Feedback Wanted: Visual Effect Graph</a> </span><a href="https://unity.com/c/graphics/visual-effects/138" class="badge-wrapper bullet"><span class="badge-category-bg" style="background-color: #865EA6"></span> <span class="badge-category clear-badge"> <span class="category-name">Visual Effects</span> </span></a><a href="https://discussions.unity.com/tag/visual-effects-graph/159340" class="discourse-tag">Visual-Effects-Graph</a> ,  <a href="https://discussions.unity.com/tag/official/160110" class="discourse-tag">Official</a></td><td class="replies"><span class="posts" title="posts">1009</span></td><td class="views"><span class="views" title="views">218826</span></td><td>February 4, 2020</td><td></td></tr><tr id="topic-list-item-1571327" class="even topic-list-item"><td class="main-link" itemprop="itemListElement" itemscope="" itemtype="http://schema.org/ListItem"><span class="link-top-line"> <a href="https://discussions.unity.com/t/unity-6-vfx-graph-learning-templates/1571327" class="title raw-link raw-topic-link">Unity 6: VFX Graph Learning Templates</a> </span><a href="https://unity.com/c/graphics/render-pipelines/136" class="badge-wrapper bullet"><span class="badge-category-bg" style="background-color: #865EA6"></span> <span class="badge-category clear-badge"> <span class="category-name">Render Pipelines</span> </span></a><a href="https://discussions.unity.com/tag/universal-render-pipeline/159334" class="discourse-tag">Universal-Render-Pipeline</a> ,  <a href="https://discussions.unity.com/tag/high-definition-render-pipeline/159335" class="discourse-tag">High-Definition-Render-Pipeline</a> ,  <a href="https://discussions.unity.com/tag/visual-effects-graph/159340" class="discourse-tag">Visual-Effects-Graph</a> ,  <a href="https://discussions.unity.com/tag/official/160110" class="discourse-tag">Official</a> ,  <a href="https://discussions.unity.com/tag/6-0/160123" class="discourse-tag">6.0</a></td><td class="replies"><span class="posts" title="posts">1</span></td><td class="views"><span class="views" title="views">3251</span></td><td>January 3, 2025</td><td></td></tr><tr id="topic-list-item-802955" class="odd topic-list-item"><td class="main-link" itemprop="itemListElement" itemscope="" itemtype="http://schema.org/ListItem"><span class="link-top-line"> <a href="https://discussions.unity.com/t/vfx-graph-with-legacy-render-pipeline/802955" class="title raw-link raw-topic-link">VFX Graph with legacy render pipeline</a> </span><a href="https://unity.com/c/graphics/visual-effects/138" class="badge-wrapper bullet"><span class="badge-category-bg" style="background-color: #865EA6"></span> <span class="badge-category clear-badge"> <span class="category-name">Visual Effects</span> </span></a><a href="https://discussions.unity.com/tag/visual-effects-graph/159340" class="discourse-tag">Visual-Effects-Graph</a></td><td class="replies"><span class="posts" title="posts">20</span></td><td class="views"><span class="views" title="views">9560</span></td><td>March 6, 2023</td><td></td></tr></tbody></table>
