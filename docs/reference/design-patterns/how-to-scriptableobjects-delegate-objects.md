---
title: "Use ScriptableObjects as delegate objects"
page_title: "Use ScriptableObjects as Delegate Objects"
source_url: "https://unity.com/how-to/scriptableobjects-delegate-objects"
final_url: "https://unity.com/how-to/scriptableobjects-delegate-objects"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Use ScriptableObjects as delegate objects

This page explains how to use ScriptableObjects as logic containers. By doing this, you can treat them as delegate objects, or little bundles of actions that you can call when needed.

This is the fourth in a series of six mini-guides created to assist Unity developers with [the demo](https://github.com/UnityTechnologies/PaddleGameSO) that accompanies the e-book, [*Create modular game architecture in Unity with ScriptableObjects*](https://resources.unity.com/games/create-modular-game-architecture-with-scriptable-objects-ebook?ungated=true).

The demo is inspired by classic ball and paddle arcade game mechanics, and shows how ScriptableObjects can help you create components that are testable, scalable, and designer-friendly.

Together, the e-book, demo project, and these mini-guides provide best practices for using [programming design patterns](https://resources.unity.com/games/level-up-your-code-with-game-programming-patterns?ungated=true) with the ScriptableObject class in your Unity project. These tips can help you simplify your code, reduce memory usage, and promote code reusability.

This series includes the following articles:

-   [Get started with the Unity ScriptableObjects demo](https://unity.com/how-to/get-started-with-scriptableobjects-demo)
-   [Separate game data and logic with ScriptableObjects](https://unity.com/how-to/separate-game-data-logic-scriptable-objects)
-   [Use ScriptableObject-based enums in your Unity project](https://unity.com/how-to/scriptableobject-based-enums)
-   [Use ScriptableObjects as event channels in game code](https://unity.com/how-to/scriptableobjects-event-channels-game-code)
-   [How to use a ScriptableObject-based runtime set](https://unity.com/how-to/scriptableobject-based-runtime-set)

Important note before you start

The strategy pattern

Pluggable behavior

Example: AudioDelegate

Patterns demo

Example: Strategy pattern in the objective system

More ScriptableObject resources

## Important note before you start

Before you dive into the ScriptableObject demo project and this series of mini-guides, remember that, at their core, design patterns are just ideas. They won’t apply to every situation. These techniques can help you learn new ways to work with Unity and ScriptableObjects.

Each pattern has pros and cons. Choose only the ones that meaningfully benefit your specific project. Do your designers rely heavily on the Unity Editor? A ScriptableObject-based pattern could be a good choice to help them collaborate with your developers.

Ultimately, the best code architecture is the one that fits your project and team.

A SCRIPTABLEOBJECT CONTAINS THE “STRATEGY” WITHIN THE MONOBEHAVIOUR.

## The strategy pattern

Using the [strategy pattern](https://en.wikipedia.org/wiki/Strategy_pattern), you can define an interface or base ScriptableObject class and then make those delegate objects interchangeable at runtime.

One application is to encapsulate algorithms for doing specific tasks into a ScriptableObject and then use that ScriptableObject in context of something else.

For example, if you were writing an AI or pathfinding system for an EnemyUnit class, you might create a ScriptableObject with a path search technique (like A\*, Dijkstra, etc.).

The EnemyUnit itself wouldn’t actually contain any pathfinding logic. Instead, it would keep a reference to a separate “strategy” ScriptableObject. The upshot of this design is that you can swap to a different algorithm simply by exchanging objects. This is one way to choose different behaviors at runtime.

When the MonoBehaviour needs to perform a task, it calls the external methods on the ScriptableObject rather than its own. For example, the ScriptableObject might contain public methods for **MoveUnit** or **SetTarget** for driving the enemy unit and specifying a destination.

<a href="https://github.com/UnityTechnologies/PaddleGameSO" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download PaddleBallSO<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

## Pluggable behavior

You can improve this pattern with an abstract base class or an interface. Doing that means any ScriptableObject that implements the strategy can be swapped with another. This hot-swappable ScriptableObject “plugs” into the MonoBehaviour referencing it – even on the fly at runtime.

If you need the EnemyUnit to change behaviors because of game conditions, the outer context (the MonoBehaviour) can check for those conditions. Then, it can plug in a different ScriptableObject as a response.

By separating implementation details into a ScriptableObject, you can also facilitate a better division of responsibilities amongst your team. One developer could focus on the algorithm inside the ScriptableObject, while another works on the MonoBehaviour context.

To create this pluggable behavior, make sure to:

-   **Define a base class or interface for the strategy:** This class or interface should include the methods and properties needed to execute the strategy.
-   **Create the ScriptableObject classes:** Each can provide different implementations of the strategy. For example, you could create one class that implements a simple AI algorithm and another class that implements a more complex algorithm.
-   **Create a ScriptableObject that implements the strategy:** Fill in the missing logic and populate the Inspector with any necessary values.
-   **Use the strategy in context:** In the MonoBehaviour, call the methods and properties implemented in the ScriptableObject. To make calling those methods easier, pass in the dependencies as parameters.

Organizing your code like this can make it easier to switch between different implementations of the same strategy. This pluggable behavior then becomes easier to debug and maintain.

## Example: AudioDelegate

An algorithm or strategy doesn’t have to be complicated. The *PaddleBallSO* project, for example, demonstrates a fairly basic audio playback system in the SimpleAudioDelegate.

The abstract class, **AudioDelegateSO**, defines a single Play method that accepts an AudioSource parameter. The concrete implementation then overrides this.

The **SimpleAudioDelegateSO** subclass defines an array of AudioClips. It chooses a random clip and plays it back using the overridden **Play** method implementation. This adds a variation in pitch and volume within a custom range.

Though it’s a just a few lines, you can make many different audio effects with the code snippet below.

While this specific example isn’t really suitable for heavy audio use, it’s presented here as a basic usage demo of ScriptableObjects in a strategy pattern.

A designer can create many different ScriptableObjects to represent sound effects without touching the code. Again, this requires minimal support from a developer once the base ScriptableObject is complete.

In *PaddleBallSO*, anyone can now set up a new array of sounds to play back when the ball strikes one of the level walls. Designers gain creative independence and flexibility because they are working entirely in the Editor. This approach frees up programming resources, since developers no longer need to assist with every design decision.

<a href="https://github.com/UnityTechnologies/PaddleGameSO" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download PaddleBallSO<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

``` hljs
[Serializable]
public struct RangedFloat

public abstract class AudioDelegateSO: ScriptableObject

public class SimpleAudioDelegateSO: AudioDelegateSO

}
```

THE AUDIODELEGATES DEMO SCENE SHOWS HOW SCRIPTABLEOBJECTS CAN HOLD LOGIC.

## Patterns demo

You can also see the audio example in the Patterns demo. Each sound derives from a slightly different SimpleAudioDelegateSO asset, with small variations between instances.

In this example, each corner includes an AudioSource. A custom AudioModifier MonoBehaviour uses a ScriptableObject-based delegate to play back sound.

The differences in pitch stem only from the settings on each ScriptableObject asset (BeepHighPitched_SO, BeepLowPitched_SO, etc.).

Using a ScriptableObject to control the action logic can make it easier for your design team to experiment with ideas. This enables a designer to work more independently from a developer.

THE OBJECTIVEMANAGER MONOBEHAVIOUR TESTS WIN CONDITIONS USING SCRIPTABLEOBJECTS.

## Example: Strategy pattern in the objective system

The *PaddleBallSO* project also uses the strategy pattern in its objective system. Though this isn’t something that needs to vary at runtime, encapsulating each object in a ScriptableObject provides a flexible way to test win-lose conditions.

The abstract base class, ObjectiveSO, holds values like the objective’s name and whether it has been completed.

The concrete subclasses, like ScoreObjectiveSO, then implement the actual logic on how to complete each objective. They do that by overriding the ObjectiveSO’s **CompleteObjective** method and adding the win condition logic.

Does the player need to attain a specific score or defeat a certain number of enemies? Do they need to reach a specific location or pick up a specific item? These are common win conditions that could become ScriptableObject-based objectives.

The ObjectiveManager serves as the larger context for the ScriptableObjects. It maintains a list of ObjectiveSOs and relies on each ScriptableObject to determine if it’s complete. When every ObjectiveSO shows a state of completion, the game is over.

For example, the ScoreObjectiveSO shows one way to implement a scoring objective:

-   A custom **PlayerScore** struct matches the Player ID, a UI element in the interface, and the actual score value.
-   Every time the ScoreManager component updates, the objective checks the win condition.
-   If the player’s score meets or exceeds the **m_TargetScore**, then it sends the winning PlayerScore object as an event.

The ObjectiveManager only cares that all of the given objectives are complete. It’s unaware of details within each objective itself.

Again, the goal here is modularity. This lets you customize each ObjectiveSO without affecting pre-existing ones.

The *PaddleBallSO* game really only has one objective. If one of the players reaches the winning score goal, gameplay ends.

However, you could extend this or combine objectives to create a more complex objective system. Experiment and see if you can build new game modes (e.g., score a minimum number of points before time runs out).

Since the logic is encapsulated inside a ScriptableObject, you can swap any ObjectiveSO for another. Making a new win condition simply involves reconfiguring the list in the ObjectiveManager. In a sense, the objective is “pluggable” into the surrounding context.

Note that one handy aspect of the ObjectiveSO is the event used to send messages between GameObjects. Next, we’ll explore how to use ScriptableObjects to implement this event-driven architecture.

<a href="https://github.com/UnityTechnologies/PaddleGameSO" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download PaddleBallSO<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

## More ScriptableObject resources

Read more about design patterns with ScriptableObjects in the e-book [*Create modular game architecture in Unity with ScriptableObjects*](https://resources.unity.com/games/create-modular-game-architecture-with-scriptable-objects-ebook?ungated=true). You can also find out more about common Unity development design patterns in [*Level up your code with game programming patterns*](https://resources.unity.com/games/level-up-your-code-with-game-programming-patterns?ungated=true).
