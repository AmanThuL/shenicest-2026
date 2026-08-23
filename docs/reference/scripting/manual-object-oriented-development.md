---
title: "Object-oriented development (Unity 6.3 Manual)"
page_title: "Unity - Manual: Object-oriented development"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/object-oriented-development.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/object-oriented-development.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Object-oriented development

Traditional Unity projects are grounded in object-oriented design principles and programming philosophy, which is centered around objects, their properties and functions, and the relations between these objects. Code is organized around [GameObjects](https://docs.unity3d.com/6000.3/Documentation/Manual/working-with-gameobjects.html) whose behavior is controlled by attached [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoBehaviour.html) [components](https://docs.unity3d.com/6000.3/Documentation/Manual/components.html). In general, these MonoBehaviour components encapsulate logic (methods) and data (fields) together, which can be convenient but can have performance issues at scale.

An alternative to object-oriented development is data-oriented development, which is both a design philosophy and a set of technologies that help you implement that philosophy. This approach stresses a clear separation between code and data to maximize CPU cache efficiency and parallelism. Instead of MonoBehaviours, the [Entity Component System (ECS)](https://unity.com/ecs) architecture uses components for data, and systems for logic. The data-oriented approach offers strong performance advantages at scale but can be more challenging for inexperienced developers to learn.

Object-oriented and data-oriented development are not mutually exclusive and you can combine elements from both. For information on data-oriented development, refer to [Unity’s Data-Oriented Technology Stack](https://unity.com/dots).

| **Topic**                                                                                                                      | **Description**                                                                                                                                                                                 |
|:-------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **[Fundamental Unity types](https://docs.unity3d.com/6000.3/Documentation/Manual/fundamental-unity-types.html)**               | Understand some of the fundamental C# types that Unity provides and their special significance and behavior in the Unity Editor and runtime.                                                    |
| **[Managing update and execution order](https://docs.unity3d.com/6000.3/Documentation/Manual/managing-update-order.html)**     | Understand the order in which Unity executes your script components and the lifecycle callbacks within those scripts during the runtime application loop.                                       |
| **[Managing time and frame rate](https://docs.unity3d.com/6000.3/Documentation/Manual/managing-time-and-frame-rate.html)**     | Understand how Unity measures time so you can manage the rate at which time passes in your application and ensure values update according to the appropriate time scale.                        |
| **[Split tasks across frames with coroutines](https://docs.unity3d.com/6000.3/Documentation/Manual/coroutines-section.html)**  | Split the execution of a task synchronously across multiple scenes with coroutines. This can be useful for tasks that should progress gradually over several frames, such as a fade out effect. |
| **[Interacting with web servers](https://docs.unity3d.com/6000.3/Documentation/Manual/web-request.html)**                      | Use the UnityWebRequest system to allow your application to interact with a web server via HTTP.                                                                                                |
| **[Handle type data generically with Unity Properties](https://docs.unity3d.com/6000.3/Documentation/Manual/properties.html)** | Use the Unity Properties API to generically discover and manipulate object properties at runtime.                                                                                               |
| **[Programming with mathematics](https://docs.unity3d.com/6000.3/Documentation/Manual/programming-math.html)**                 | Use Unity’s mathematical APIs to apply trigonometric, logarithmic, and other functions in your application, move objects with vectors, and generate random values.                              |

## Additional resources

-   [Unity’s Data-Oriented Technology Stack](https://unity.com/dots)
-   [GameObject](https://docs.unity3d.com/6000.3/Documentation/Manual/class-GameObject.html)
