---
title: "Script Execution Order reference"
page_title: "Unity - Manual: Script Execution Order reference"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoManager.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoManager.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Script Execution Order reference

Use the **Script Execution Order** settings to specify the relative execution order of different MonoBehaviour [script components](https://docs.unity3d.com/6000.3/Documentation/Manual/CreatingComponents.html) in your project. The execution order between different scripts in the project is different from and doesn’t change the [order of execution for event functions](https://docs.unity3d.com/6000.3/Documentation/Manual/execution-order.html) within each individual script. Unity always calls [`Awake`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Awake.html) before the first [`Update`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MonoBehaviour.Update.html) for each script, but you can configure script execution order to ensure that `Awake` for one script is always called before `Awake` for another. For example, if you have two scripts, `EngineBehaviour` and `SteeringBehaviour`, you can set the script execution order so that `EngineBehaviour` always updates before `SteeringBehaviour`.

## Configuring execution order

To configure script execution order, go to: **Edit** \> **Project Settings**, and then select the **Script Execution Order** category.

![The Script Execution Order section of the Project Settings window displays a list of script classes and their currently configured execution order values.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/ScriptExecSet.png)

-   Use the plus (+) button to add scripts to the list. Use the minus (-) button on a list item to remove it from the list.
-   To specify the execution order, drag items in the list into the desired position or edit the integer values of a script in the list.

The integer values assigned to each script don’t represent any quantity but define each script’s execution order relative to the others. Unity executes scripts in order from lowest first to highest last, for example: –200, –100, –50, 50, 100, 200. The Editor stores these values in the script [metadata files](https://docs.unity3d.com/6000.3/Documentation/Manual/AssetMetadata.html). You can leave gaps between the values to help avoid unnecessary file changes when you add or move other scripts in the list.

Unity executes any scripts not in the list during the **Default Time** slot, which occurs after any scripts with negative values and before any scripts with positive values.

**Note**: You can specify the script execution order from code rather than configuring it in the Editor by applying the `[DefaultExecutionOrder]` attribute to your MonoBehaviour-derived classes. For more information, refer to the [`[DefaultExecutionOrder]`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/DefaultExecutionOrder.html) API reference.

For more information on how Unity executes scripts and interprets the configured order, refer to [Script execution order](https://docs.unity3d.com/6000.3/Documentation/Manual/script-execution-order.html).

## Additional resources

-   [Managing update and execution order](https://docs.unity3d.com/6000.3/Documentation/Manual/managing-update-order.html)
-   [`[DefaultExecutionOrder]` API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/DefaultExecutionOrder.html)
