---
title: "Managing update and execution order (Unity 6.3 Manual)"
page_title: "Unity - Manual: Managing update and execution order"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/managing-update-order.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/managing-update-order.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Managing update and execution order

Unity runtime applications run in a loop, where the engine repeatedly processes input, updates game state, and renders frames. This is commonly called the game or Player loop. Traditional component-based Unity projects use [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoBehaviour.html) script [components](https://docs.unity3d.com/6000.3/Documentation/Manual/Components.html) to hook into the Player loop through a series of built-in callbacks called [event functions](https://docs.unity3d.com/6000.3/Documentation/Manual/event-functions.html), which provide the opportunity to update your GameObjects every frame, or in response to specific events.

Knowing the execution order can help you customize and optimize your project. For example, you might need to ensure some setup work always happens before the first [frame update](https://docs.unity3d.com/6000.3/Documentation/Manual/time-per-frame-updates.html), or that scripts controlling the engine of a vehicle always run before those that control its steering.

| **Topic**                                                                                                                    | **Description**                                                                                                                                                                                                            |
|:-----------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **[Script execution order](https://docs.unity3d.com/6000.3/Documentation/Manual/script-execution-order.html)**               | Understand how Unity prioritizes execution of individual MonoBehaviour scripts.                                                                                                                                            |
| **[Event functions](https://docs.unity3d.com/6000.3/Documentation/Manual/event-functions.html)**                             | Event functions are a set of built-in callbacks which you can implement on your MonoBehaviour-derived scripts to respond to core Engine events related to physics, rendering, input, scene loading, and object lifecycles. |
| **[Event function execution order](https://docs.unity3d.com/6000.3/Documentation/Manual/execution-order.html)**              | Understand the execution order of Unity’s built-in event functions so you can respond to events and update the state of your game in the right order.                                                                      |
| **[Customizing the Player loop](https://docs.unity3d.com/6000.3/Documentation/Manual/player-loop-customizing.html)**         | Customize the Player loop to change the order in which Unity updates systems in each iteration of the loop.                                                                                                                |
| **[Using a custom update manager](https://docs.unity3d.com/6000.3/Documentation/Manual/events-per-frame-optimization.html)** | Create an update manager to handle many per-frame updates.                                                                                                                                                                 |
| **[Inspector-configurable custom events](https://docs.unity3d.com/6000.3/Documentation/Manual/unity-events.html)**           | Create your own custom events to configure persistent (lasting between Edit mode and Play mode) callbacks in the Inspector window.                                                                                         |

## Additional resources

-   [Per frame updates](https://docs.unity3d.com/6000.3/Documentation/Manual/time-per-frame-updates.html)
-   [PlayerLoop API reference](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LowLevel.PlayerLoop.html)
