---
title: "Flyweight pattern (Unity 6)"
page_title: "Flyweight pattern"
source_url: "https://learn.unity.com/course/design-patterns-unity-6/tutorial/flyweight-pattern"
final_url: "https://learn.unity.com/course/design-patterns-unity-6/tutorial/flyweight-pattern"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Flyweight pattern

![](https://cdn.sanity.io/images/fuvbjjlp/learn-production/e3a1497e8a517d0050257f257266eb8d45e1e7ea-400x225.jpg)

# Flyweight pattern

Tutorial

intermediate

+0XP

2

\(10\)

Unity Technologies

![Flyweight pattern](https://connect-mediagw.unity.com/h1/20250131/learn/images/f0f2bfab-f91b-4f96-a4bd-3b0a015f882e_1bc98292-3c01-4005-b57e-71aa286c3c82_image__1_.png)

Summary

By implementing common game programming design patterns in your Unity project, you can efficiently build and maintain a clean, organized, and readable codebase. Design patterns not only reduce refactoring and the time spent testing, but they also speed up onboarding and development processes, contributing to a solid foundation that can be used to grow your game, development team, and business.

Think of design patterns not as finished solutions you can copy and paste into your code, but as extra tools that can help you build larger, scalable applications when used correctly.

This tutorial explains the flyweight pattern and how you can use it to reduce the amount of duplicated data in your game, thus ensuring it runs smoothly at runtime.

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 1. Overview

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

This tutorial explains the flyweight programming pattern and how you can use it in your Unity projects. Make sure to download the <a href="https://assetstore.unity.com/packages/essentials/tutorial-projects/level-up-your-code-with-design-patterns-and-solid-289616" class="link-primary text-inherit"><span style="text-decoration:underline">Level up your code with design patterns and SOLID</span></a> sample project from the Unity Asset Store to follow along with the examples in this tutorial.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 2. Introduction to the flyweight pattern

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Large game worlds will often contain scenes populated with numerous GameObjects and components. If similar GameObjects carry the same data fields, this can result in significant duplication of data, leading to increased memory usage. Let’s consider a forest scene as an example, where each tree GameObject stores its own configuration data.

A tree in our game scene might store the following:

-   Complex data structures for defining the tree. If you were generating the tree procedurally, this could include arrays or lists of floats, colors, and Vector3 values.
-   Animation curves for defining how the tree sways in the wind.
-   Custom class instances that define other physical characteristics or gameplay metadata.

Though each individual field may be relatively small, remember that duplicating the GameObject also copies its various components and their stored data fields. If a field is a value type (for example, a struct, primitive type, or array), each duplicated GameObject will have its own copy of the data. Populate your game world forest with trees, and this redundancy quickly adds up.

The flyweight pattern is an optimization pattern that can reduce the amount of duplicated data in your game by centralizing shared data. Thus, it allows individual objects to reference this shared data instead of storing their own copies.

![](https://connect-mediagw.unity.com/h1/20250131/learn/images/41bc675e-a129-448a-a56b-f3125397947f_Flyweight_pattern_shared_data.png)

If you're accustomed to the prefab workflow in Unity, then you're already familiar with this idea. We can share as much data as possible between similar GameObjects, reducing the overall memory footprint.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 3. An unoptimized example before refactoring

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Consider a strategy game teeming with gameplay units. Each might carry attributes such as health, attack, defense, and movement. To identify each unit, you also might want to tag them with a team label and icon.

Thus, an unoptimized gameplay unit might have a class like this:

```
public class UnrefactoredUnitInstance : MonoBehaviour

    private void RefreshUnitStats()
    
    public void SetFactionData(string factionName, Sprite factionIcon, int baseHealth, int baseAttack, int baseDefense, int baseMovement)
    
}
```

In addition to its own stats, a unit carries an additional payload of data that should ideally remain constant across a given faction or team. When creating a new unit instance with the **SetFactionData** method, you pass all the common faction data – and store a copy of it. The more units you add, the more redundant data you're duplicating and storing.

This doesn't just use up more memory – it also makes it harder to keep everything updated and consistent across your game. Manually syncing data across many GameObjects is error prone and can lead to inconsistencies.

With a handful of GameObjects, it's not a problem. But with a large number of units from the same faction, the increased memory usage might start to be noticeable – or at least difficult to manage.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 4. Implementing the flyweight pattern

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

A simple solution is to store the shared data in a central repository, or flyweight GameObject.

A ScriptableObject works well for this purpose since it’s ideal for storing data that doesn’t need to change at runtime (for example, settings, configuration data, etc.)

Refactoring the shared data into a separate class can reduce redundancy, like so:

```
// Flyweight object (ScriptableObject)
[CreateAssetMenu]
public class FactionData : ScriptableObject

// Context object
public class UnitInstance : MonoBehaviour

    private void RefreshUnitStats()
    
    // Unique state for this unit instance
    public int health;
    public int attack;
    public int defense;
    public int movement;

    public Vector3 position;

    // ... Add other unique states here
}
```

Using the flyweight pattern, the **FactionData** class is a **ScriptableObject** that represents the shared faction data. It contains fields for the faction name, icon, and base unit stats.

The **UnitInstance** class is the **Context** GameObject that holds a reference to the **FactionData** ScriptableObject. It refreshes its stats based on the shared faction data. By separating shared and unique data, you reduce memory usage and potential inconsistencies across your GameObjects.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 5. Optimize memory usage with the flyweight pattern

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

The following example demonstrates the flyweight pattern by optimizing memory usage for a fleet of spaceships.

![](https://connect-mediagw.unity.com/h1/20250131/learn/images/51376f16-6de6-4081-aac1-a330d2c524f5_Flyweight_pattern_overview.png)

The core principle of the flyweight pattern is that it distinguishes between intrinsic (shared) and extrinsic (unique) state data. **Intrinsic data** is immutable and shared across instances, reducing memory usage. **Extrinsic data** varies between instances and is stored individually.

In this example**, ShipData** is a ScriptableObject that contains intrinsic, shared data for all ships, such as unit name, speed, attack power, and defense. All ships reference the same data set for these properties, minimizing the memory footprint.

```
[CreateAssetMenu(fileName = "ShipData", menuName = "Flyweight/ShipData", order = 1)]
public class ShipData : ScriptableObject

```

With the above script, you’re able to create the ScriptableObject instance from the context menu defined in the CreateAssetMenu attribute. We already created one that you can find in the **LevelUpYourCode** \> **\_DesignPatterns** \> **9_Flyweight** \> **ScriptableObjects** folder.

A **Ship** class can represent individual ships in the fleet. Each ship instance holds a reference to the shared ShipData and, in turn, manages its own unique state, such as health.

```
public class Ship : MonoBehaviour

    public void DisplayShipInfo()
    {
        Debug.Log($"Name: {sharedData.UnitName}, Health: {m_Health}");
    }
}
```

The **ShipFactory** is responsible for generating the fleet of ships. It initializes each ship using a prefab GameObject and the shared ShipData.

```
public class ShipFactory : MonoBehaviour

    public void GenerateShips(int rows, int columns)
    {
        for (int i = 0; i < rows; i++)
        {
            for (int j = 0; j < columns; j++)
            {
                Vector3 position = new Vector3(i * spacing, 0, j * spacing);
                Ship newShip = Instantiate(shipPrefab, position, Quaternion.identity, transform);
                newShip.Initialize(sharedShipData, 100); // Assuming 100 is the starting health
                newShip.name = $"Ship_{i * columns + j}";
            }
        }
    }
}
```

By centralizing shared data in a ScriptableObject, you can reduce the memory footprint across numerous ship instances. Meanwhile, unique data such as health is still managed individually by each ship instance.

Though this isn’t much memory saving per GameObject, the efficiencies become more noticeable the more ships you add to the scene. Large numbers of similar objects make the best use of the flyweight pattern.

Add the <a href="https://unity.com/how-to/use-memory-profiling-unity" class="link-primary text-inherit"><span style="text-decoration:underline">Memory Profiler</span></a> package from the Package Manager to get better insight into the memory savings. In the **Memory Profiler** window (**Window** \> **Analysis** \> **Memory Profiler**), search through the managed GameObjects to determine the allocated size. Compare before implementing the pattern versus applying the Flyweight GameObject.

![](https://connect-mediagw.unity.com/h1/20250131/learn/images/5f3f8afe-53a0-4e17-8dad-30ba5e1ee8e2_Reduce_memory_usage_with_the_Flyweight_pattern.png)

While the sample scene only showcases a few shared fields, the flyweight pattern's benefits can become substantial in large-scale projects like RPGs or strategy games with numerous onscreen units.

Use the flyweight pattern to save resources whenever you have a large number of objects that share common properties in their base classes.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 6. Pros and cons of using the flyweight pattern

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

The flyweight pattern excels in scenarios where numerous GameObjects share a common state. This is particularly useful on resource-constrained platforms, such as mobile devices, where reducing memory consumption can improve performance. Applications that require instantiating a large number of GameObjects can use the flyweight pattern to their advantage to scale more effectively.

However, the flyweight pattern incurs additional overhead and complexity. In addition to managing the individual GameObjects in your scene, you'll also need to manage their shared state. The benefit from the flyweight pattern only becomes tangible when there are a sufficient number of units to justify the additional overhead.

Also, because you're forcing units to share the same basic data, that limits their flexibility. You'll need to override the shared data to make each unit unique, akin to the prefab workflow but applied to specific data sets.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 7. More use case examples

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Though much of what the flyweight pattern provides can also be achieved using prefabs, it can be a good choice for the following types of cases:

-   **Crowd simulations**: Building a sports sim with some background crowds? Use the pattern to share models, animations, and textures to build large, dynamic crowds.
-   **Character/weapon skins and customization:** Many games often allow players to customize their weapons or gear with skins and attachments. The base properties of these items can be shared with Flyweights, with only the customizations stored individually.
-   **Level art:** When designing a forest, take all of the universal properties of a tree and store them in the base **Tree** class. Then, you don’t need to repeat them in the subclasses (for example, PineTree, MapleTree, and so on).

Note that in scenarios where your game features thousands of GameObjects with shared data (such as a swarm of projectiles in an intense shooter or armies of units in an action strategy game), consider using Unity’s <a href="https://github.com/Unity-Technologies/EntityComponentSystemSamples" class="link-primary text-inherit"><span style="text-decoration:underline">Data-Oriented Technology Stack</span></a> (DOTS) instead. DOTS can offer superior performance optimization through its focus on multithreading and reducing data dependencies. Check out the <a href="https://unity.com/blog/engine-platform/new-ebook-understanding-unity-dots" class="link-primary text-inherit"><span style="text-decoration:underline">DOTS e-book for advanced Unity developers</span></a> for an in-depth look at each of the packages and technologies in the stack and their related concepts.

As with any design pattern, evaluate the specific needs of your project before implementing it. Then, decide as a team which pattern will give the best benefit.

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
