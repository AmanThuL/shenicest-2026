---
title: "Use components"
page_title: "Unity - Manual: Use components"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UsingComponents.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UsingComponents.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Use components

You can use different components to change or add functions to your GameObjects. You can use the Inspector window to change the properties of any component, or you can use scripts.

For more information on how to use your components with scripts, see the [components script reference](https://docs.unity3d.com/2022.2/Documentation/ScriptReference/Component.html) page.

## Add components

You can add components to the selected GameObject through the Component menu. To add a Rigidbody component, select the GameObject and select **Component** \> **Physics** \> **Rigidbody** from the menu. The Inspector displays the Rigidbody’s properties. If you press **Play** while you have the empty GameObject selected, the Y position of the GameObject’s transform decreases. This is because the physics system in Unity causes the GameObject to fall under gravity.

![A GameObject with a Rigidbody component attached](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/RigidBodyGO1.png)

You can also add components in the **Component** browser. To open the Component browser, select **Add Component** in the Inspector.

![The Component browser](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/ComponentBrowser1.png)

You can navigate the components by category in the browser or use the search box to locate components by name.

A component must be in the same project as the GameObject you want to attach it to. A component can be specific to a package or created by a script. The Unity Editor can’t search for components from: \* Other projects. \* Scripts that are not attached to the project. \* [Packages](https://docs.unity3d.com/6000.3/Documentation/Manual/Packages.html) that haven’t been added to the project.

You can attach any number or combination of components to a single GameObject. Some components work best in combination with others. For example, the Rigidbody works with a Collider.

For more information about a particular component, see the relevant Component reference page. You can also access the reference page for a component from Unity if you select the help icon (**?**) on the component’s header in the Inspector.

## Edit components

When you attach a component to a GameObject, the component’s properties contain default values. You can edit these values in the Editor while you build a game, or in scripts when you run the game.

There are two main types of properties: values and references.

You can edit value properties in the Inspector. There are various types of values, including text, toggles and dropdowns.

For reference properties, you can drag a file from the Project view into the property, or use the object picker (circle icon) on the property. Reference properties can reference other types of components, GameObjects, or assets.

For more information about the different property types, refer to [Editing Properties](https://docs.unity3d.com/6000.3/Documentation/Manual/InspectorManageComponents.html).

The image below shows a GameObject with an **Audio Source** component. The values of the **Audio Source** in the Inspector show how you can adjust aspects of a component to suit your project.

![The Audio Source with a sound effect referenced properly in the Audio Clip](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/AudioReference1.png)

## Component context menu commands

Right click on a component for the context menu with several useful commands.

The same commands are also available from the kebab menu (⋮) in the top-right of the component panel in the Inspector window.

The table below describes the commands available so you can adjust your components:

| **Command:**               | **Description:**                                                                                                                                                                                                                                                                                                                                                                                                  |
|:---------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Reset**                  | Restores the values the component’s properties had before the most recent editing session.                                                                                                                                                                                                                                                                                                                        |
| **Remove Component**       | Removes the component from the GameObject. **Note**: Some combinations of components depend on each other ([Hinge Joint](https://docs.unity3d.com/6000.3/Documentation/Manual/class-HingeJoint.html) only works when attached to a [Rigidbody](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Rigidbody.html)); a warning message is displayed if you try to remove components that others depend on. |
| **Move Up**                | Moves the component up in the Inspector. You can also drag and drop components in the Inspector to reorder them.                                                                                                                                                                                                                                                                                                  |
| **Move Down**              | Moves the component down in the Inspector.                                                                                                                                                                                                                                                                                                                                                                        |
| **Copy Component**         | Copies the type and current property settings of a component.                                                                                                                                                                                                                                                                                                                                                     |
| **Paste Component As New** | Pastes the copied property settings of a component as a new component.                                                                                                                                                                                                                                                                                                                                            |
| **Paste Component Values** | Pastes the copied property settings of a component into another component of the same type.                                                                                                                                                                                                                                                                                                                       |

## Testing properties

In **Play Mode**, you can change properties of a component in the Inspector. This lets you see how different values for a property affect gameplay. For example, you can experiment with different heights of jumping. If you create a **Jump Height** property in a script, you can enter Play Mode, change the value, and press the jump button to see what happens. Then, without exiting Play Mode, you can change it again and see the results within seconds. When you exit Play Mode, the properties revert to their pre-Play Mode values. With this workflow, you can experiment, adjust, and refine your gameplay in less time.

## Additional resources

-   [Manage components and their values](https://docs.unity3d.com/6000.3/Documentation/Manual/InspectorManageComponents.html)
-   [The Inspector window](https://docs.unity3d.com/6000.3/Documentation/Manual/UsingTheInspector.html)
