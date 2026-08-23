---
title: "Strategy pattern (Unity 6)"
page_title: "Strategy pattern"
source_url: "https://learn.unity.com/course/design-patterns-unity-6/tutorial/strategy-pattern"
final_url: "https://learn.unity.com/course/design-patterns-unity-6/tutorial/strategy-pattern"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Strategy pattern

![](https://cdn.sanity.io/images/fuvbjjlp/learn-production/e3a1497e8a517d0050257f257266eb8d45e1e7ea-400x225.jpg)

# Strategy pattern

Tutorial

intermediate

+0XP

3

\(9\)

Unity Technologies

![Strategy pattern](https://connect-mediagw.unity.com/h1/20250131/learn/images/9be853bd-8bb7-4e33-b639-873a416f89ad_1bc98292-3c01-4005-b57e-71aa286c3c82_image__1_.png)

Summary

By implementing common game programming design patterns in your Unity project, you can efficiently build and maintain a clean, organized, and readable codebase. Design patterns not only reduce refactoring and the time spent testing, but they also speed up onboarding and development processes, contributing to a solid foundation that can be used to grow your game, development team, and business.

Think of design patterns not as finished solutions you can copy and paste into your code, but as extra tools that can help you build larger, scalable applications when used correctly.

This tutorial explains the strategy pattern and how it can be used to quickly and effectively switch GameObject behavior at runtime.

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 1. Overview

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

This tutorial explains the strategy programming pattern and how you can use it in your Unity projects. Make sure to download the <a href="https://assetstore.unity.com/packages/essentials/tutorial-projects/level-up-your-code-with-design-patterns-and-solid-289616" class="link-primary text-inherit"><span style="text-decoration:underline">Level up your code with design patterns and SOLID</span></a> sample project from the Unity Asset Store to follow along with the examples in this tutorial.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 2. Introduction to the strategy pattern

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Gameplay seldom sits still. At runtime, your GameObjects often need to adapt to changing conditions and update themselves accordingly.

For example, imagine a stealth game where a player's movement style needs to switch between sneaking past guards to running away after being detected. Or consider a combat system where characters can exhibit different attack modes, such as melee, ranged, or magic.

Implementing these dynamic behaviors in a clean and maintainable way can be challenging as your game grows. Much as with the state pattern, using a **switch** statement can lead to large bloated classes.

The strategy pattern offers a solution to this problem by wrapping algorithms or behaviors within an object and making them interchangeable. Each strategy object encapsulates a distinct behavior that can be executed dynamically. Thus, a client object can switch its behavior at runtime by referencing different strategy objects, without needing to modify its own class structure.

![](https://connect-mediagw.unity.com/h1/20250131/learn/images/08859412-b174-4263-9171-471853529d00_Strategy_pattern_behaviors.png)

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 3. Setting up an ability system using the strategy pattern

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Imagine you’re developing a game that allows players to acquire new abilities as they progress. For instance, these abilities could serve as rewards or perks for outstanding performance in a competitive FPS or action RPG. When a player becomes eligible for a new ability, a corresponding UI button might be displayed on the screen to indicate its availability.

#### Before refactoring

Initially, you might create a single script tasked with handling all special abilities. This approach works, but because you need to add new abilities or modify existing ones, the script becomes difficult to maintain.

The initial setup for defining these abilities might look something like this:

```
public class AbilityRunner : MonoBehaviour

    public Ability CurrentAbility;

    void Update()
    
    }

    void ActivateAbility(Ability ability)
    
    }
}
```

This script would become increasingly complex and challenging to manage as the game evolved. Each new ability would require modifications to the existing code, violating the open-closed principle. Remember that your goal is to keep your software open for extension but closed for modification.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 4. Implementing the strategy pattern

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Let's revisit the ability system using the strategy pattern. Begin by creating an abstract **Ability** class or interface. This will define a method called **Use** that all specific abilities must implement. This example extends **ScriptableObject** (but a MonoBehaviour would work here as well).

```
public abstract class Ability : ScriptableObject

```

Then, create concrete implementations of the **Ability** class for each specific ability. These classes will implement the actual logic within the **Use** method to perform their unique actions.

```
[CreateAssetMenu(fileName = "RadarPulseAbility", menuName = "Abilities/RadarPulse")]
public class RadarPulse : Ability

}

[CreateAssetMenu(fileName = "AirSupportAbility", menuName = "Abilities/AirSupport")]
public class AirSupport : Ability

}

[CreateAssetMenu(fileName = "FirstAidAbility", menuName = "Abilities/FirstAid")]
public class FirstAid : Ability

}
```

These ScriptableObjects can be serialized and stored as project assets. This allows them to be easily assigned and modified within Unity’s **Inspector window**.

A client object can then reference these strategy objects. Here, we refactor the **AbilityRunner** class so that at runtime, it can set its specific **currentAbility** dynamically. In this example, pressing the **Spacebar** calls the **Use** method, which executes the ability logic.

```
public class AbilityRunner : MonoBehaviour

    }
}
```

Each ability, now encapsulated as its own object, can be edited, added, or removed without impacting the core game code. This enhances the game's flexibility, allowing for dynamic ability changes at runtime. Creating new abilities also becomes more manageable and scalable as a result.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 5. Basic implementation of the strategy pattern using the sample project

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

<a href="https://assetstore.unity.com/packages/essentials/tutorial-projects/level-up-your-code-with-design-patterns-and-solid-289616" class="link-primary text-inherit"><span style="text-decoration:underline">The project</span></a> shows a basic implementation of the strategy pattern. The player can gather power-ups to attain a desired streak. The button updates according to the streak count, displaying different abilities as the player’s streak increments. Selecting the button then activates the current special ability as a strategy.

What the button actually does is wrapped into a ScriptableObject. That means that it can be interchanged at runtime, either in the **Inspector** window or with separate game logic.

In this specific sample, a streak counter ties the associated perk or special ability to the UI, which dynamically adjusts to player performance.

Because each interchangeable strategy is encapsulated in its own class, adding more abilities does not impact the others; simply create more ScriptableObject abilities as your game requires.

When the button is activated, it triggers some decorative elements (such as a particle effect or sound), but it's not limited to any one thing.

Each encapsulated strategy can perform a vast range of actions tailored to your game's specific needs. You can alter gameplay mechanics, enhance character abilities, or even modify the game environment.

![](https://connect-mediagw.unity.com/h1/20250131/learn/images/f596a2c9-741d-4b04-83e8-36dc82d30799_Strategy_pattern_overview.png)

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 6. Pros and cons of using the strategy pattern

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

The strategy pattern works well for situations where you need to change how your game behaves at runtime. Because you can add new features without altering existing code, the strategy pattern makes your system more flexible in keeping with SOLID principles. Each behavior is neatly compartmentalized into its own class, which also makes testing easier.

On the downside, having more classes to manage can increase complexity. Because a Strategy GameObject carries a small amount of overhead with it, consider alternative patterns or optimizations when performance is critical.

Being encapsulated also means that you'll need to carefully design how these strategies will share information and communicate with the rest of your gameplay systems (for example, events). You'll need to avoid tightly coupling the strategies with other components; otherwise, you'll negate the benefits of the pattern.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 7. More use case examples

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

The strategy pattern is not just a tool for managing abilities. You can apply it to many different aspects of gameplay. Here are a few practical examples:

-   **Character movement strategies:** Imagine you're creating a platformer game where the player character's movement abilities can be upgraded, depending on the environment or power-ups. At the start, the player might only be able to walk and jump, but later they gain the abilities to double-jump, dash, or even fly.
-   **AI behavior:** Switch between different AI behaviors based on the game state or player actions. Adjust enemy states between offensive, defensive, or patrol strategies, depending on the player.
-   **Navigation strategies**: If you created a pathfinding system, you could use the strategy pattern to define multiple algorithms (A\*, Dijkstra’s shortest path, etc.) that you could swap during gameplay, depending on context.
-   **Attack strategies:** Allow players or AI to switch between weapon types dynamically, with strategies such as MeleeAttack, RangedAttack, or AreaEffectAttack. Or imagine a boss enemy that can switch modes or unique combat abilities, depending on its remaining health.
-   **Difficulty Adjustment:** Automatically adjust game difficulty based on player performance. Implement an “adaptive difficulty” strategy that changes in real-time. Or allow the player to select a “fixed difficulty” strategy for a consistent challenge.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 8. More resources

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
