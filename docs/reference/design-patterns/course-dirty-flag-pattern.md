---
title: "Dirty flag pattern (Unity 6)"
page_title: "Dirty flag pattern"
source_url: "https://learn.unity.com/course/design-patterns-unity-6/tutorial/dirty-flag-pattern"
final_url: "https://learn.unity.com/course/design-patterns-unity-6/tutorial/dirty-flag-pattern"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Dirty flag pattern

![](https://cdn.sanity.io/images/fuvbjjlp/learn-production/e3a1497e8a517d0050257f257266eb8d45e1e7ea-400x225.jpg)

# Dirty flag pattern

Tutorial

intermediate

+0XP

2

\(7\)

Unity Technologies

![Dirty flag pattern](https://connect-mediagw.unity.com/h1/20250131/learn/images/544c0441-0ff7-415c-adce-45e4298d66d1_1bc98292-3c01-4005-b57e-71aa286c3c82_image__1_.png)

Summary

By implementing common game programming design patterns in your Unity project, you can efficiently build and maintain a clean, organized, and readable codebase. Design patterns not only reduce refactoring and the time spent testing, but they also speed up onboarding and development processes, contributing to a solid foundation that can be used to grow your game, development team, and business.

Think of design patterns not as finished solutions you can copy and paste into your code, but as extra tools that can help you build larger, scalable applications when used correctly.

This tutorial explains the dirty flag pattern and how it can be used to reduce overhead at runtime by only applying updates to selected GameObjects at runtime.

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 1. Overview

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

This tutorial explains the dirty flag programming pattern and how you can use it in your Unity projects. Make sure to download the <a href="https://assetstore.unity.com/packages/essentials/tutorial-projects/level-up-your-code-with-design-patterns-and-solid-289616" class="link-primary text-inherit"><span style="text-decoration:underline">Level up your code with design patterns and SOLID</span></a> sample project from the Unity Asset Store to follow along with the examples in this tutorial.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 2. Introduction to the dirty flag pattern

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Sometimes game development starts to get complicated – or at least computationally expensive. The <a href="https://gameprogrammingpatterns.com/dirty-flag.html" class="link-primary text-inherit"><span style="text-decoration:underline">dirty flag</span></a> pattern can help when you have a lot of calculations or updates happening in your scenes.

A dirty flag pattern is simply a boolean that indicates whether an object's state has changed since the last time it was processed or rendered. If an object is "dirty," it gets updated; otherwise, it's skipped, saving computational resources.

A common use case is traversing a complex hierarchy or managing a large scene file. The dirty flag can help minimize calculations until certain objects are marked "dirty.” For example, child GameObject transforms could ignore updates until the parent GameObject or root transform requires one. This can help minimize unnecessary calculations with dynamic objects that frequently change state.

Using the dirty flag pattern means strategically placing checks at points where GameObject states are likely to change. This might be within event handlers, physics updates, or animation systems. The checks then ensure that only a subset of the game world is updated in response to player actions or game events. Every resource saved helps reduce overhead.

![](https://connect-mediagw.unity.com/h1/20250220/learn/images/1ff15bc7-1af9-46d4-a61b-69a81f90e229_Dirty_flag_pattern_overview__1_.png)

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 3. An example of the dirty flag pattern in action

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Consider a large, open-world game. It’s often resource-prohibitive to load the entire game environment at once. Instead, a common tactic is to load just a portion of the game world that the player currently sees.

To manage this, the game world can be divided into smaller Unity scenes, loading each one as necessary. However, this scene loading process is relatively slow and can cause brief pauses that disrupt gameplay.

Thus, we only want to update the game world when necessary. In this example, we introduce a mechanism that only executes when certain conditions are met. We mark the world with a dirty flag when it’s ready for an update. Otherwise, the update loop skips over the expensive logic.

As the player navigates through the level, this game world only updates when the player character moves near the boundary of the current sector. This saves compute resources to help ensure a seamless gameplay experience.

Explore <a href="https://assetstore.unity.com/packages/essentials/tutorial-projects/level-up-your-code-with-design-patterns-and-solid-289616" class="link-primary text-inherit"><span style="text-decoration:underline">the sample</span></a> implementation to see one way to apply this pattern:

-   The game world is divided into sectors or regions, each with associated content that needs to load when the player is nearby.
-   A manager script tracks the player's movement and determines which sectors are relevant based on the player's current location.
-   Each sector has a dirty flag that indicates whether its content needs to be loaded or unloaded, based on the player's proximity and interaction.

Because scene loading is a relatively expensive operation, the dirty flag pattern makes sure that the expensive game world update only runs when necessary. Here, the **GameSectors** script manages what parts of the game world loads at runtime.

```
public class GameSectors: MonoBehaviour

            // Update the sector based on its dirty flag
            if(sector.IsDirty)
            
                else
                
                // Reset the dirty flag
                sector.Clean(); 
            }
        }
    }
}
```

The sample scene illustrates how to visualize material changes and scene loading/unloading in response to the player’s proximity. By using the dirty flag pattern, content loading and unloading operations are only performed when the player character moves close enough to or far enough from a sector.

This minimizes unnecessary processing and memory usage as the application shows a limited section of the game world at a time.

Each **Sector** in this example maintains its own distance to the player as the threshold to load or unload assets. Here’s a snippet of sample:

```
public class Sector : MonoBehaviour
    {

        [Tooltip("Minimum distance to load")] 
        public float m_LoadRadius;
        ...

        public bool IsLoaded { get; private set; } = false;
        public bool IsDirty { get; private set; } = false;
        
        void Awake()
        
        public void MarkDirty()
        {
            IsDirty = true;
            Debug.Log($"Sector {gameObject.name} is marked dirty");
            ...
        }

        public void LoadContent()
        
        public void UnloadContent()
        
        public bool IsPlayerClose(Vector3 playerPosition)
        
        public void Clean()
        
        ...
```

In this setup, a SceneLoader component selectively loads and unloads parts of the game as the player moves through the level.

The camera in the scene provides a top-down view to illustrate how this system works. In a real application, imagine a camera following the player character, showing only a limited field of view. In this scenario, the game could then selectively load and display only those areas immediately within the player's visibility.

![](https://connect-mediagw.unity.com/h1/20250131/learn/images/c1b49a0a-ca6e-4cf3-896e-e48ba40e1090_Dirty_flag_pattern_and_level_updates.png)

Though we can further optimize this (and not use an **Update** function at all), this example shows a simple case of using a dirty flag to reduce the expensive calls to the SceneManagement API.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 4. Pros and cons of using the dirty flag pattern

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

The dirty flag pattern is particularly valuable in large simulations or systems generating procedural content. Because costly operations only execute when needed, it minimizes unnecessary calculations and can boost memory efficiency – vital for platforms with limited memory like mobile devices.

On the negative side, be aware that the dirty flag pattern can introduce tight coupling between components. This adds a layer of dependency and risk. Also, since updates are postponed until the dirty flag is set, the application's state might temporarily lag, appearing outdated until the necessary update occurs.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 5. More use case examples

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Use the dirty flag pattern whenever you want to minimize the impact of an expensive calculation or operation, such as in the following cases.

-   **Complex hierarchical transforms.** If you have child transforms of an animated character, minimize animations until the parent transform updates (for example, only update the lower limbs if the upper limbs or body is moving). If you had a strategy game where the units are in formation, have the units update their motions only after the entire group formation is marked dirty.
-   **Physics simulations**: For physics simulations involving complex interactions or large numbers of objects, recalculate only when the state of the GameObjects changes (like position, velocity, or external forces) in order to optimize performance.
-   **Pathfinding:** Recalculating paths for AI agents can be expensive. Using dirty flags to update paths only when obstacles move or the target location changes.
-   **Procedural Content Generation:** Much like the scene-loading example, this pattern can tell the system when to regenerate procedural terrain based on specific triggers like player movement or game events.
-   **UI Layouts:** In a complex UI system, elements might need to rearrange themselves when certain conditions change (like window resizing, content updates, etc.). The dirty flag pattern can be used to update the layout only when necessary, avoiding constant recalculations. For example, a VisualElement in UI Toolkit includes a <a href="https://docs.unity3d.com/ScriptReference/UIElements.VisualElement.MarkDirtyRepaint.html" class="link-primary text-inherit"><span style="text-decoration:underline">MarkDirtyRepaint </span></a>method. Likewise, the EditorUtility has <a href="https://docs.unity3d.com/ScriptReference/EditorUtility.ClearDirty.html" class="link-primary text-inherit"><span style="text-decoration:underline">ClearDirty</span></a> and <a href="https://docs.unity3d.com/ScriptReference/EditorUtility.SetDirty.html" class="link-primary text-inherit"><span style="text-decoration:underline">SetDirty</span></a> methods.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 6. More resources

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

If you want to learn more about design programming patterns and how you can use them in your Unity projects, make sure to read the updated guide <a href="https://unity.com/resources/design-patterns-solid-ebook" class="link-primary text-inherit"><span style="text-decoration:underline">Level up your code with design patterns and SOLID</span></a> and follow along with the <a href="https://assetstore.unity.com/packages/essentials/tutorial-projects/level-up-your-code-with-design-patterns-and-solid-289616" class="link-primary text-inherit"><span style="text-decoration:underline">Level up your code with design patterns and SOLID</span></a> sample project on the Unity Asset Store.

Additionally, watch the <a href="https://youtube.com/playlist?list=PLX2vGYjWbI0TmDVbWNA56NbKKUgyUAQ9i&amp;si=VeFPCk2IKQ8jbgQY" class="link-primary text-inherit"><span style="text-decoration:underline">Game Programming Patterns Tutorials</span></a> video tutorials playlist where you can see a lot of these programming patterns in action:

-   <a href="https://youtu.be/attURV3JWKQ?si=Fc9KbXVa-3fum5L9" class="link-primary text-inherit"><span style="text-decoration:underline">Command pattern video tutorial</span></a>
-   <a href="https://youtu.be/lJMY0YdaY9c?si=7Sowcpipd867xxLp" class="link-primary text-inherit"><span style="text-decoration:underline">Factory pattern video tutorial</span></a>
-   <a href="https://youtu.be/agoe5BdLzdk?si=dx3wtLRWQl3Uf9cJ" class="link-primary text-inherit"><span style="text-decoration:underline">Model-view-presenter video tutorial</span></a>
-   <a href="https://youtu.be/3xvsaGMb-M0?si=pmzBSt6L7xsx0H93" class="link-primary text-inherit"><span style="text-decoration:underline">Pattern combo video tutorial</span></a>
-   <a href="https://youtu.be/U08ScgT3RVM?si=eqVfCCeD9d-CNPlT" class="link-primary text-inherit"><span style="text-decoration:underline">Object pooling video tutorial</span></a>

You can find all advanced Unity technical e-books and articles on <a href="https://unity.com/how-to" class="link-primary text-inherit"><span style="text-decoration:underline">the best practices hub</span></a>. The e-books are also available on the <a href="https://docs.unity3d.com/Manual/best-practice-guides.html" class="link-primary text-inherit"><span style="text-decoration:underline">Advanced best practices page</span></a> in the documentation.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

## Complete this Tutorial

Mark all steps complete
