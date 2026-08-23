---
title: "Create a shader graph and use it with a material"
page_title: "Create a shader graph and use it with a material | Shader Graph | 17.3.0"
source_url: "https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/First-Shader-Graph.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/First-Shader-Graph.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Create a shader graph and use it with a material

This example shows you how to do the following:

-   Create a simple Lit shader graph with the Universal Render Pipeline (URP).
-   Create and manage a material that uses this shader graph in a scene.

For more options to get started with Shader Graph, refer to:

-   [Create a shader graph asset](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Create-Shader-Graph.html)
-   [Add and connect nodes in a shader graph](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Create-Node-Menu.html)

## Create a new shader graph

Before you can build a new shader graph, you have to create a shader graph asset to contain it. Follow these steps:

1.  In the **Project** window, right-click and select **Create** > **Shader Graph** > **URP** > **Lit**.

2.  Name the created shader graph asset and press Enter.

The [Shader Graph window](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Shader-Graph-Window.html) opens, which allows you to edit the shader graph in the created asset. If the window doesn't open, double-click on the created asset.

## Create a new node

For this example, you need to create a Color node. Follow these steps:

1.  Select the Shader Graph window's workspace and press the **Spacebar**.

    The **Create Node** menu opens, with the list of all available nodes.

2.  In the **Create Node** menu's search bar, type `color`.

3.  In the **Input** > **Basic** category, double-click on **Color**.

A new **Color** node appears in the workspace.

## Connect the node to the master stack

To use the Color node property as an input for the shader, you need to connect the node to the master stack. Follow these steps:

1.  Select the **Out(4)** port of the **Color** node.

2.  Drag it to the **Base Color** block port of the **Fragment** section of the [master stack](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Master-Stack.html).

This connection updates the appearance of the 3D object in the **Main Preview**, which is now black, according to the Color node's default value.

## Change the shader color

You can change the output color of the Color node to view how it affects the final shader. Follow these steps:

1.  In the **Color** node, click on the color bar.

2.  Use the color picker to change the color.

The color of the 3D object in the **Main Preview** changes to the selected color in real time.

## Save your shader graph

You need to save your shader graph to use it with a material. To save your shader graph, do one of the following:

-   Click the **Save Asset** button in the top left corner of the window.

-   Close the graph. If Unity detects any unsaved changes, a dialog appears, and asks if you want to save those changes.

## Create a material from your shader graph

After you've saved your shader graph, you can use it to create a new material.

The process of [creating a new Material](https://docs.unity3d.com/Manual/Materials.html) and assigning it a Shader Graph shader is the same as that for regular shaders.

To create a new material from your shader graph, follow these steps:

1.  In the Project window, right-click the shader graph asset you created.

2.  Select **Create > Material**.

Unity automatically assigns the shader graph asset to the newly created material. You can view the shader graph name selected in the material's Inspector in the **Shader** property.

## Use the material in the scene

Now that you have assigned your shader to a material, you can apply this material to GameObjects in the scene through one of the following:

-   Drag the material onto a GameObject in the scene.

-   In the GameObject's Inspector, go to **Mesh Renderer > Materials**, and set the **Element** property to your material.

## Control the color from the material's Inspector

You can use a property in the shader graph to alter your shader's appearance directly from the material's Inspector, without the need to edit the shader graph.

To use a Color property instead of a Color node in your shader graph, follow these steps:

1.  Open the shader graph you created earlier in the [Shader Graph window](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Shader-Graph-Window.html).

2.  In the [Blackboard](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Blackboard.html), select **Add (+)**, and then select **Color**.

    The Blackboard now displays a [property of Color type](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Property-Types.html#color).

3.  Select the property.

4.  In the [Graph Inspector](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Internal-Inspector.html), in the **Node Settings** tab:

    -   Change the **Name** according to the name you want to identify the property within the material's Inspector.
    -   Make sure to activate the **Show In Inspector** option.

5.  Drag the property from the Blackboard onto the Shader Graph window's workspace.

6.  Connect the property's node to the **Base Color** block port of the **Fragment** section of the [master stack](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Master-Stack.html), instead of the Color node you were using previously.

    This connection updates the appearance of the 3D object in the **Main Preview**, which is now black, according to the property's default value.

7.  Save your graph, and return to the material's Inspector.

    The property you added in the graph now appears in the material's Inspector. Any changes you make to the property from the Inspector affects all objects that use this material.

## Additional resources

-   [Art That Moves: Creating Animated Materials with Shader Graph](https://unity.com/blog/engine-platform/creating-animated-materials-with-shader-graph)
-   [Custom Lighting in Shader Graph: Expanding Your Graphs in 2019](https://unity.com/blog/engine-platform/custom-lighting-in-shader-graph-expanding-your-graphs-in-2019)
-   [Shader Graph video tutorials](https://www.youtube.com/user/Unity3D/search?query=shader+graph) (on Unity YouTube Channel)
-   [Shader Graph forum](https://discussions.unity.com/tags/c/unity-engine/52/shader-graph)

##### Note

Older tutorials use a former version of Shader Graph with master nodes. To know the differences between the former master node and the [Master Stack](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Master-Stack.html), refer to the [Upgrade Guide](https://docs.unity3d.com/Packages/com.unity.shadergraph@17.3/manual/Upgrade-Guide-10-0-x.html).
