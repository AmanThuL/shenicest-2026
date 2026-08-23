---
title: "Use ScriptableObject-based enums in your Unity project"
page_title: "Use ScriptableObject-based Enums in Your Project"
source_url: "https://unity.com/how-to/scriptableobject-based-enums"
final_url: "https://unity.com/how-to/scriptableobject-based-enums"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Use ScriptableObject-based enums in your Unity project

This page explains how to use ScriptableObject-based enums in your Unity project.

This is the third in a series of six mini-guides created to assist Unity developers with [the demo](https://github.com/UnityTechnologies/PaddleGameSO) that accompanies the e-book, [*Create modular game architecture in Unity with ScriptableObjects*](https://resources.unity.com/games/create-modular-game-architecture-with-scriptable-objects-ebook?ungated=true).

The demo is inspired by classic ball and paddle arcade game mechanics, and shows how ScriptableObjects can help you create components that are testable, scalable, and designer-friendly.

Together, the e-book, demo project, and these mini-guides provide best practices for using [programming design patterns](https://resources.unity.com/games/level-up-your-code-with-game-programming-patterns?ungated=true) with the ScriptableObject class in your Unity project. These tips can help you simplify your code, reduce memory usage, and promote code reusability.

This series includes the following articles:

-   [Get started with the Unity ScriptableObjects demo](https://unity.com/how-to/get-started-with-scriptableobjects-demo)
-   [Separate game data and logic with ScriptableObjects](https://unity.com/how-to/separate-game-data-logic-scriptable-objects)
-   [Use ScriptableObjects as delegate objects](https://unity.com/how-to/scriptableobjects-delegate-objects)
-   [Use ScriptableObjects as event channels in game code](https://unity.com/how-to/scriptableobjects-event-channels-game-code)
-   [How to use a ScriptableObject-based runtime set](https://unity.com/how-to/scriptableobject-based-runtime-set)

Important note before you start

Extendable enums

ScriptableObject-based enums

Player ID in PaddleBallSO

Patterns demo

Extending behavior

Benefits of ScriptableObject-based enums

More ScriptableObject resources

## Important note before you start

Before you dive into the ScriptableObject demo project and this series of mini-guides, remember that, at their core, design patterns are just ideas. They won’t apply to every situation. These techniques can help you learn new ways to work with Unity and ScriptableObjects.

Each pattern has pros and cons. Choose only the ones that meaningfully benefit your specific project. Do your designers rely heavily on the Unity Editor? A ScriptableObject-based pattern could be a good choice to help them collaborate with your developers.

Ultimately, the best code architecture is the one that fits your project and team.

DELETING OR REORDERING ENUM VALUES CAN LEAD TO UNEXPECTED BEHAVIOR.

## Extendable enums

Enums are a handy way to manage a fixed set of named values in your code. However, they come with some limitations. Since serialized enum values are stored as integers rather than their symbolic names, removing or reordering a value can lead to incorrect or unexpected behavior. This means that enums, especially when you have many of them, can create headaches in Unity development.

**The standard approach**

Here’s what a typical enum looks like:

\[System.Serializable\]  
public enum HandGestures  

You can serialize an enum with the [System.Serializable](https://learn.microsoft.com/en-us/dotnet/api/system.serializableattribute?view=net-6.0) attribute and it appears in the Inspector.

**The problem**

Reordering or deleting a value can cause trouble. Because each value internally is an integer, what it represents may become something different. In the given example, deleting the Paper value would cause Scissors to assume the value of 1.

Or, if we added a value like in the example below.

The selected enum value would change if it comes after the deleted entry.

This can cause issues when maintaining and updating projects, particularly when your enum contains numerous values. You can mitigate this issue by leaving a blank or unused element, or by explicitly setting integer values. However, neither solution is ideal.

<a href="https://github.com/UnityTechnologies/PaddleGameSO" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download PaddleBallSO<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

``` hljs
[System.Serializable]
public enum HandGestures 

```

CHECKING FOR EQUALITY BETWEEN SCRIPTABLEOBJECTS

## ScriptableObject-based enums

ScriptableObject-based enums give you the functionality of traditional enums but are stored as individual assets. For example, look at the PlayerIDSO ScriptableObject in the *PaddleBallSO* project in the example below.

Essentially, this is a blank ScriptableObject.

You can use that to create a number of ScriptableObject assets in the project, like P1, P2, etc. Even when they don’t contain any data, you can use ScriptableObjects for comparison. Simply create a new ScriptableObject asset in the project and give it a name.

You can create as many player IDs as you need within the project and easily switch between them. Just change the assigned asset in the GameDataSO script.

If you are checking for equality, this works similarly to an enum. Do two variables refer to the same ScriptableObject? If so, they’re the same item type. Otherwise, they’re not.

Even without any extra data, the ScriptableObject represents a category or item type.

``` hljs
[CreateAssetMenu(fileName = "PlayerID")]
public class PlayerIDSO: ScriptableObject

```

## Player ID in PaddleBallSO

In *PaddleBallSO*, the PlayerIDSO becomes a team designation. We use the P1 and P2 assets in the GameDataSO to differentiate between the two paddles.

The GameSetup script assigns each paddle a player ID. During gameplay, the Paddle scripts compare the player input with the designated team ID.

This has applications for any type of multiplayer game. Alternatively, consider adopting them wherever else you reach for an enum.

Since they are simply assignments in the Inspector, ScriptableObjects aren’t subject to the same issues with renaming and reordering.

Want to change the identifier names to “Player1” or “Player2,” respectively? You can do that, and everything continues to work. Adding more ScriptableObjects? Not a problem – the asset assignment in the Inspector remains the same.

BLOCKS USE ASSIGNED TEAMS FOR COMPARISONS.

## Patterns demo

This behavior is useful for creating gameplay. In the Patterns demo, click the Switch Enum button to change teams. A MonoBehaviour on the DemoBall updates the SpriteRenderer accordingly.

Does the ball inflict damage on a Block when it collides? Find out by running a quick test of equality. Here’s one way to compare them in the code example below.

This method can determine if two GameObjects are on the same team, which is useful when checking for friendly versus enemy interactions. This simple comparison can apply to item pickups, damage, or anything else that has a “team” or “alignment.”

<a href="https://github.com/UnityTechnologies/PaddleGameSO" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download PaddleBallSO<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

``` hljs
public static bool AreEqual(GameObject a, GameObject b)

    // Otherwise, return false
    return false;
}
```

## Extending behavior

The fun part happens when you add logic to your ScriptableObjects. Unlike a conventional enum, a ScriptableObject can have fields and methods, in addition to holding data.

Use these so each ScriptableObject can have specialized comparison logic. For example, you could have a ScriptableObject that defines special damage effects (e.g., cold, heat, electrical, magic, and so on).

If your application requires an inventory system to equip gameplay items, ScriptableObjects can represent item types or weapon slots. Are certain characters not allowed to hold certain items? Are some items magical or have special abilities? ScriptableObject-based enums can add methods to check for that.

The MonoBehaviour **DemoBall** in the previous example includes the **AreEqual** method to compare ScriptableObjects. When extending behavior, you can bundle the comparison logicinside the ScriptableObject itself.

In the Patterns demo, you could modify the ball so it’s more selective when colliding with an object. Look at a general-purpose item for collision in the code example below.

This could achieve similar results to the current demo, but it now has an **m_Weakness** field. This allows each ScriptableObject to define another ScriptableObject to destroy on collision.

Rather than call the **AreEqual** method, each ScriptableObject simply manages its own comparison logic.

The result is more flexible and extendable. Instead of having the ball destroy a block of a different team, you can be specific. Multiple balls in the scene could destroy different blocks, depending on their individual CollisionItems.

This sets the stage for different, more complex interactions. If you wanted to make a rock-paper-scissors system, you could define three ScriptableObjects: Rock, Paper, and Scissors. Each could have its own unique **m_Weakness**, and use the **IsWinner** method to handle the interactions.

Unlike enums, ScriptableObjects make this process modular and adaptable. There’s no need to rely on extra data structures or add extra logic to synchronize with a separate set of data. Simply add an extra field and/or method to handle the logic.

``` hljs
public class CollisionItem: ScriptableObject

}
```

## Benefits of ScriptableObject-based enums

Once you’re familiar with ScriptableObject-based enums, you’ll find they can improve your workflow, especially when working with teammates. Since they are assets, updating them creates fewer merge conflicts, reducing the risk of data loss.

Adding new ScriptableObject-based enums is just like creating another asset. Unlike traditional enums, adding new values won’t break your existing code. Plus, Unity already has built-in tools to search, filter, and organize them, just like any other asset.

As a bonus, using the Editor’s drag-and-drop UI enables your designers to extend gameplay data without extra support from a software developer. You’ll still need to coordinate how to set up fields initially, but the designers can then populate those fields with data on their own.

<a href="https://github.com/UnityTechnologies/PaddleGameSO" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download PaddleBallSO<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

## More ScriptableObject resources

ScriptableObject-based enums are one more resource your team can use to improve collaboration and efficiency.

Read more about design patterns with ScriptableObjects in our technical e-book [*Create modular game architecture in Unity with ScriptableObjects*](https://resources.unity.com/games/create-modular-game-architecture-with-scriptable-objects-ebook?ungated=true). You can also find out more about common Unity development design patterns in [*Level up your code with game programming patterns*](https://resources.unity.com/games/level-up-your-code-with-game-programming-patterns?ungated=true).
