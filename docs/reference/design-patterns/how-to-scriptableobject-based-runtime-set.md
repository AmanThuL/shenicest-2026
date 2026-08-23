---
title: "How to use a ScriptableObject-based runtime set"
page_title: "Using ScriptableObject-based Runtime Sets"
source_url: "https://unity.com/how-to/scriptableobject-based-runtime-set"
final_url: "https://unity.com/how-to/scriptableobject-based-runtime-set"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# How to use a ScriptableObject-based runtime set

Important note before you start

Runtime sets

Basic implementation

Generic version

Usage and limitations

Patterns demo

How runtime sets help

More ScriptableObject resources

## Important note before you start

Before you dive into the ScriptableObject demo project and this series of mini-guides, remember that, at their core, design patterns are just ideas. They won’t apply to every situation. These techniques can help you learn new ways to work with Unity and ScriptableObjects.

Each pattern has pros and cons. Choose only the ones that meaningfully benefit your specific project. Do your designers rely heavily on the Unity Editor? A ScriptableObject-based pattern could be a good choice to help them collaborate with your developers.

Ultimately, the best code architecture is the one that fits your project and team.

## Runtime sets

ScriptableObjects can [store static data](https://blog.unity.com/engine-platform/6-ways-scriptableobjects-can-benefit-your-team-and-your-code). They can be modified to hold dynamic data as well. This is particularly useful for referencing a collection of GameObjects or components at runtime.

A “runtime set” like this replicates why some developers use singletons – easy global access. Unfortunately, singletons come with baggage like undesirable dependencies. These extra dependencies can complicate testing and make debugging more difficult.

As an alternative, consider using a ScriptableObject-based runtime set for frequently referenced components. For example, use them to track game elements like spawned enemies, collectibles, or checkpoints.

As project-level assets, ScriptableObjects provide global access to data for all objects within a scene. This feature allows for information sharing without many of the drawbacks associated with singletons.

<a href="https://github.com/UnityTechnologies/PaddleGameSO" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download PaddleBallSO<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

## Basic implementation

Here’s one way to make a runtime set for GameObjects. Think of it like a data container that keeps a public collection of elements – but also includes methods to add and remove members.

At runtime, any MonoBehaviour can reference the public **Items property** to obtain the full list of GameObjects. Another script or component can call **Add** or **Remove** to modify the **Items** list.

``` hljs
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(menuName = "GameObject Runtime Set", fileName
= "GORuntimeSet")]
public class GameObjectRuntimeSetSO: ScriptableObject

   public void Remove(GameObject thingToRemove)
   
}
```

## Generic version

You can make a runtime set more specific so that it only tracks a particular type of MonoBehaviour. In that case, create specific sets for each type (e.g., EnemyRuntimeSet, PickupRuntimeSet, etc.).

A generic abstract class can streamline this process. You could then derive other runtime sets from this base class. For example, if you wanted to make a runtime set for a custom Enemy component, you could define classes for a generic RuntimeSetSO\<T> and concrete EnemyRuntimeSetSO like the code snippet below.

Notice that the concrete class, EnemyRuntimeSetSO, doesn’t have any implementation details, only a **CreateAssetMenu** attribute.

Each new component you want to track just needs a corresponding runtime set to manage it. Build as many concrete classes as you need. Enemies, NPCs, inventory items, quests, and more can all have their own runtime sets.

<a href="https://github.com/UnityTechnologies/PaddleGameSO" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download PaddleBallSO<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

``` hljs
public abstract class RuntimeSetSO<T>: ScriptableObject

   public void Remove(T thing)
   
}

[CreateAssetMenu(menuName = "Enemy Runtime Set", fileName =
"EnemyRuntimeSet")]

public class EnemyRuntimeSetSO: RuntimeSet<Enemy>

```

## Usage and limitations

Managing the runtime set is up to you. Often, you can use a second MonoBehaviour to set up or update it during gameplay.

If you want a component to include itself in a set automatically, you can also invoke the runtime set’s **Add** or **Remove** methods from the MonoBehaviour’s **OnEnable** and **OnDisable**.

For example, your fictitious **Enemy** class might look like the code snippet below.

Here, each **Enemy** component can add or remove itself using its **OnEnable** or **OnDisable** methods. If the **m_RuntimeSet** field is set in the Inspector, the **Enemy** component will appear in the **EnemyRuntimeSetSO** automatically. This is especially handy if you’re using the **Enemy** component with Prefabs.

One limitation of this technique is that if you inspect the ScriptableObject at runtime, you won’t be able to see the contents of the **Items** list in the Inspector by default.

Instead, a “Type mismatch” appears in each element field. By design, a ScriptableObject can’t serialize a scene object. The list is actually working, but the data does not display correctly.

Use a public property or the HideInInspector attribute if you want to avoid confusion and prevent the list from showing in the Inspector.

You can also fix this issue with a custom Editor script and Inspector. Good examples include [Soap – ScriptableObject Architecture Pattern](https://assetstore.unity.com/packages/tools/utilities/soap-scriptableobject-architecture-pattern-232107) in the Unity Asset Store or the Patterns demo example below.

``` hljs
public class Enemy: MonoBehaviour

     private void OnDisable()
     
}
```

## Patterns demo

Although *PaddleBallSO* doesn’t feature a use case for runtime sets, the project’s Patterns demo includes a small sample that shows this design pattern at work.

Click the **Spawn Block** button to fill in the wall of blocks incrementally. The ball destroys a block on contact.

Choose **Select Set** to show the **BlockRuntimeSet_Data** in the Inspector. This contains the list of all the blocks in the scene.

You can continuously fill blocks into the grid as quickly as the ball removes them. At the same time, the runtime set tracks the actively changing number of blocks in the Items list.

The Patterns demo shows a few quality-of-life enhancements when working with runtime sets:

-   **Custom Inspector:** Since ScriptableObjects cannot serialize scene objects out of the box, the GameObjectRuntimeSetEditor script provides a custom Inspector that overrides the default type mismatch error. Click any block in the Inspector to highlight it in the scene Hierarchy.
-   **Update events:** The runtime set has a System.Action called **ItemsChanged**. This notifies the Editor script when adding or removing members from the Items list. This refreshes the Inspector when the Items list changes. An event channel also syncs the current number of Items to a custom RuntimeSetCounter component. This shows the total block count in the onscreen UI.

<a href="https://github.com/UnityTechnologies/PaddleGameSO" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download PaddleBallSO<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

## How runtime sets help

The next time you need a centralized list of GameObjects or components, consider runtime sets. They can be less expensive than a find operation ([Object.FindObjectOfType](https://docs.unity3d.com/ScriptReference/Object.FindObjectOfType.html) or [GameObject.FindWithTag](https://docs.unity3d.com/ScriptReference/GameObject.FindWithTag.html)) and less problematic than singletons.

As ScriptableObjects, they are decoupled from individual GameObjects in the scene. Keep as many runtime sets as needed for anything you want to track frequently at runtime.

Runtime sets can simplify how you monitor gameplay objects without incurring unnecessary dependencies. You can spend the time saved during debugging and testing to develop new gameplay experiences for your players.

## More ScriptableObject resources

We hope that runtime sets can benefit your upcoming projects.

Read more about design patterns with ScriptableObjects in our technical e-book, [*Create modular game architecture in Unity with ScriptableObjects*](https://resources.unity.com/games/create-modular-game-architecture-with-scriptable-objects-ebook?ungated=true). You can also find out more about common Unity development design patterns in [*Level up your code with game programming patterns*](https://resources.unity.com/games/level-up-your-code-with-game-programming-patterns?ungated=true).
