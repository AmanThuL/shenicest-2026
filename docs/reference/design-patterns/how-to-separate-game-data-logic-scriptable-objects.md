---
title: "Separate game data and logic with ScriptableObjects"
page_title: "Separate Game Data and Logic with ScriptableObjects"
source_url: "https://unity.com/how-to/separate-game-data-logic-scriptable-objects"
final_url: "https://unity.com/how-to/separate-game-data-logic-scriptable-objects"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Separate game data and logic with ScriptableObjects

This page explains how to use ScriptableObjects as data containers that separate the data from the logic in your game code.

This is the second in a series of six mini-guides created to assist Unity developers with [**the demo**](https://github.com/UnityTechnologies/PaddleGameSO) that accompanies the e-book, **[*Create modular game architecture in Unity with ScriptableObjects*](https://resources.unity.com/games/create-modular-game-architecture-with-scriptable-objects-ebook?ungated=true).**

The demo is inspired by classic ball and paddle arcade game mechanics, and shows how ScriptableObjects can help you create components that are testable, scalable, and designer-friendly.

Together, the e-book, demo project, and these mini-guides provide best practices for using [**programming design patterns**](https://resources.unity.com/games/level-up-your-code-with-game-programming-patterns?ungated=true) with the ScriptableObject class in your Unity project. These tips can help you simplify your code, reduce memory usage, and promote code reusability.

This series includes the following articles:

-   [**Get started with the Unity ScriptableObjects demo**](https://unity.com/how-to/get-started-with-scriptableobjects-demo)
-   [**Use ScriptableObject-based enums in your Unity project**](https://unity.com/how-to/scriptableobject-based-enums)
-   [**Use ScriptableObjects as delegate objects**](https://unity.com/how-to/scriptableobjects-delegate-objects)
-   [**Use ScriptableObjects as event channels in game code**](https://unity.com/how-to/scriptableobjects-event-channels-game-code)
-   [**How to use a ScriptableObject-based runtime set**](https://unity.com/how-to/scriptableobject-based-runtime-set)

Important note before you start

Data containers

General workflow

ScriptableObjects versus MonoBehaviours

Patterns demo

Storing game data with the flyweight pattern

PaddleBallSO game data

Dual serialization example: Level layouts

Other uses of ScriptableObject data containers

More ScriptableObject resources

## Important note before you start

Before you dive into the ScriptableObject demo project and this series of mini-guides, remember that, at their core, design patterns are just ideas. They won’t apply to every situation. These techniques can help you learn new ways to work with Unity and ScriptableObjects.

Each pattern has pros and cons. Choose only the ones that meaningfully benefit your specific project. Do your designers rely heavily on the Unity Editor? A ScriptableObject-based pattern could be a good choice to help them collaborate with your developers.

Ultimately, the best code architecture is the one that fits your project and team.

## Data containers

Software developers are often concerned with modularity – breaking down an application into smaller, self-contained units. Each module becomes responsible for a specific aspect of the application’s functionality.

In Unity, ScriptableObjects can help with the separation of data from logic.

ScriptableObjects excel at storing data, especially when it’s static. This makes them ideal for game statistics, configuration values for items or NPCs, character dialogue, and much more.

Isolating gameplay data from behavior logic can make each independent part of the project easier to test and maintain. This “separation of concerns” can reduce unintended and unwanted side effects as you make necessary changes.

<a href="https://github.com/UnityTechnologies/PaddleGameSO" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download PaddleBallSO<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

## General workflow

If you’d like a refresher on the ScriptableObject workflow, this [Unity Learn article](https://learn.unity.com/tutorial/introduction-to-scriptable-objects#) can help. Otherwise, here’s a quick explanation:

**Define a ScriptableObject:** To create one, define a C# class that inherits from the ScriptableObject base class with fields and properties for the data you want to store. ScriptableObjects can store the same data types available to MonoBehaviours, making them versatile data containers. Add the [CreateAssetMenuAttribute](https://docs.unity3d.com/ScriptReference/CreateAssetMenuAttribute.html) from the Editor to make creating the asset in the project easier.

**Create an asset:** Once you have defined a ScriptableObject class, you can create an instance of that ScriptableObject in the project. This appears as an asset saved to disk that you can reuse across different GameObjects and scenes.

**Set values:** After creating the asset, populate it with data by setting the values of its fields and properties in the Inspector.

**Use the asset:** Once the asset holds data, reference it from a variable or field. Any changes made to the ScriptableObject asset will be reflected across the entire project.

You can repurpose ScriptableObjects as data containers across different parts of your game. For example, you can define the properties of a weapon or a character within a ScriptableObject, and then reference that asset from anywhere in the project.

**Note:** You can also generate ScriptableObjects at runtime via the [CreateInstance](https://docs.unity3d.com/ScriptReference/ScriptableObject.CreateInstance.html) method. For data storage, however, you will commonly create the ScriptableObject assets ahead of time using the [CreateAssetMenuAttribute](https://docs.unity3d.com/ScriptReference/CreateAssetMenuAttribute.html).

## ScriptableObjects versus MonoBehaviours

To better understand why ScriptableObjects are a more suitable choice for data storage than MonoBehaviours, compare empty versions of each. Make sure to set your **Asset Serialization** to **Mode: Force Text** in the Project Settings to view the YAML markup as text.

Create a new GameObject with an otherwise empty MonoBehaviour. Then, compare that with an empty ScriptableObject asset. Placing them side by side, they should look like the comparison shown in the image above.

ScriptableObjects are lighter compared to MonoBehaviours and don’t carry the overhead associated with the latter, like the Transform component. This gives ScriptableObjects a smaller memory footprint and makes them more optimized for data storage.

## Patterns demo

ScriptableObjects are saved as assets, so they persist outside of Play mode, which can be useful. For example, ScriptableObject data is available from anywhere, even if you load a new scene.

The **Patterns** demo example features a basic credits screen that you can test yourself. Modify the Credits_Data ScriptableObject and then press Update to watch the stored text appear.

If you had an RPG with an extensive amount of dialogue or a tutorial scene with a pre-canned script, this is a common way to store lots of data.

While the data within the ScriptableObject updates instantly when modified, our project requires an Update button to refresh the screen manually. The UI Toolkit-based screen builds itself only once and needs to be notified when the data has been altered.

Create an event within the ScriptableObject if you want to sync updates automatically. For example, this ExampleSO script would call the **OnValueChanged** event every time **ExampleValue** changes. Look at the code example below.

Then, have your listening UI object subscribe to **OnValueChanged** and update accordingly.

<a href="https://github.com/UnityTechnologies/PaddleGameSO" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download PaddleBallSO<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

``` hljs
[CreateAssetMenu(menuName = "ExampleSO")]
public class ExampleSO : ScriptableObject

    }
}
```

## Storing game data with the flyweight pattern

ScriptableObjects shine when many objects share the same data. For example, if you were building a strategy game where numerous units have the same attack speed and maximum health, it’s inefficient to store those values individually on every GameObject.

Instead, you can consolidate shared data in a central place and have each object reference that shared location. In software design, this is an optimization known as the [flyweight pattern](https://en.wikipedia.org/wiki/Flyweight_pattern). Restructuring your code in this way avoids copying a lot of values and reduces your memory footprint.

In *PaddleBallSO*, the GameDataSO ScriptableObject acts as shared data storage.

Rather than keeping a separate copy of common settings (speed, mass, physics bounciness, etc.), the Paddle and Ball scripts reference the same GameDataSO instance where possible. Each game element maintains unique data like positions and input events, but defaults to shared data when possible.

Although the memory savings might not be noticeable with just two or three objects, editing shared data is faster and less error-prone than editing each one manually.

For example, if you need to modify paddle speed, adjusting it in a single location updates both paddles across every scene. If you stored them as unique fields in the MonoBehaviours, one incorrect click could easily get two values out of sync.

Offloading data into ScriptableObjects can also help with version control and prevent merge conflicts when teammates work on the same scene or Prefab.

## PaddleBallSO game data

The GameDataSO shows how to use a ScriptableObject as a data container. In *PaddleBallSO*, this includes various settings to configure gameplay:

-   **Paddle data:** Attributes like paddle speed, drag, and mass determine the movement and physics of the paddles during gameplay.  
-   **Ball data:** This holds the ball’s current speed, maximum speed, and bounce multiplier, which controls the ball’s behavior when it interacts with a simulation.  
-   **Match data:** GameDataSO contains information about delays between points during a match, helping to control the game’s pacing.  
-   **Player IDs:** PlayerIDSO ScriptableObjects function as a team identification for each player (e.g., Player1 and Player2).  
-   **Player sprites:** These optional sprites enable player avatar customization.  
-   **Level layout:** The LevelLayoutSO object defines the starting positions for players and game elements like goals and walls.

With these settings and data all in a central location, GameDataSO lets any object tap into this shared data. This simplifies how you manage those objects and promotes greater consistency throughout your project. Changing paddle physics? Make one change here instead of adjusting several scripts.

## Dual serialization example: Level layouts

Sometimes, you can have your cake and eat it, too. With dual serialization, you can store data in a ScriptableObject while simultaneously maintaining it in another format.

The **LevelLayoutSO** script demonstrates this concept. In addition to holding the starting positions for the paddles and ball, it stores transform data for the walls and goals in a custom struct.

These values can be written to disk via the **ExportToJson** method. The [JSON files](https://docs.unity3d.com/2020.1/Documentation/Manual/JSONSerialization.html) are human-readable text, enabling straightforward modification outside of Unity. This allows you to work with ScriptableObjects in the Editor and then store their data in another location, like a JSON or XML file.

File formats like JSON and XML can be challenging to work with in the Editor, but they’re easy to modify outside of Unity in a text editor. This opens up the possibility for custom or user-modded levels.

The **GameSetup** script can then use either a LevelLayout ScriptableObject or an external JSON file to generate the game level.

To load a custom-modded level, the setup script generates a ScriptableObject at runtime with CreateInstance. Then, it reads the text from the JSON file to populate the ScriptableObject.

Your custom data replaces the contents of the ScriptableObject and enables you to use this externally modded level like any other. The rest of the application functions normally, unaware of the switch.

<a href="https://github.com/UnityTechnologies/PaddleGameSO" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download PaddleBallSO<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

## Other uses of ScriptableObject data containers

Though our paddle ball mini-game can’t demonstrate every use case for ScriptableObject data containers, consider the following for your own applications:  

-   **Game configuration:** Think about constants, game rules, or any other setup parameters that don’t need to change during gameplay. Other components can then refer to this configuration data without using hard-coded values.  
-   **Character and enemy attributes:** Use ScriptableObjects to define attributes like health, attack power, speed, etc. This enables your designers to balance and tweak gameplay elements without a developer.  
-   **Inventory and item systems:** Item definitions and properties like names, descriptions, and icons are perfect for ScriptableObjects. You can also use them as part of an inventory management system to track items that the player collects, uses, or equips.  
-   **Dialogue and narrative systems:** ScriptableObjects can store dialogue text, character names, branching dialogue paths, and other narrative-related data. They can lay the foundation for complex dialogue systems.  
-   **Level and progression data:** You can use ScriptableObjects to define level layouts, enemy spawn points, objectives, and other level-related information.  
-   **Audio clips:** As seen in the *PaddleBallSO* project, ScriptableObjects can store one or more audio clips. These can define audio effects or music across multiple parts of your game.  
-   **Animation clips**: ScriptableObjects can be used to store animation clips, which is useful for defining common animations that are shared across multiple GameObjects or characters.

As you delve deeper into ScriptableObjects and tailor them to your own projects, you’ll uncover even more applications for them. They’re especially helpful for managing data and make it easier to maintain consistency across various game elements.

## More ScriptableObject resources

Read more about design patterns with ScriptableObjects in the e-book [*Create modular game architecture in Unity with ScriptableObjects*](https://resources.unity.com/games/create-modular-game-architecture-with-scriptable-objects-ebook?ungated=true). You can also find out more about common Unity development design patterns in [*Level up your code with game programming patterns*](https://resources.unity.com/games/level-up-your-code-with-game-programming-patterns?ungated=true).
