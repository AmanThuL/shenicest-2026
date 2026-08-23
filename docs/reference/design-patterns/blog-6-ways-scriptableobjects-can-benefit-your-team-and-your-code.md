---
title: "6 ways ScriptableObjects can benefit your team and your code"
page_title: "6 ways ScriptableObjects can benefit your team and your code"
source_url: "https://unity.com/blog/engine-platform/6-ways-scriptableobjects-can-benefit-your-team-and-your-code"
final_url: "https://unity.com/blog/engine-platform/6-ways-scriptableobjects-can-benefit-your-team-and-your-code"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# 6 ways ScriptableObjects can benefit your team and your code

<a href="https://unity.com/blog" class="text-xxs mt-8 flex items-center font-bold uppercase hover:underline"><span class="ml-1">Unity Blog</span></a>

# 6 ways ScriptableObjects can benefit your team and your code

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">THOMAS KROGH-JACOBSEN / UNITY TECHNOLOGIES</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Senior Technical Content Marketing Manager</span>

<span class="mr-2">Apr 20, 2023</span><span class="mr-2">\|</span><span class="mr-2">17 Min</span>

Testing and performance

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We’re happy to announce that we’ve launched a new technical e-book, [*Create modular game architecture in Unity with ScriptableObjects*](https://resources.unity.com/games/create-modular-game-architecture-with-scriptable-objects-ebook), which provides best practices from professional developers for deploying ScriptableObjects in production.

Along with the e-book, you can download a demo project from [GitHub](https://github.com/UnityTechnologies/PaddleGameSO) inspired by classic ball and paddle arcade game mechanics. The demo shows how ScriptableObjects can help you create components that are testable and scalable, while also being designer-friendly. Although a game like this could be built with far fewer lines of code, this demo shows ScriptableObjects in action.

A ball and paddle demo accompanies the e-book.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

This post explains the benefits of ScriptableObjects, but doesn’t cover the basics or general coding in Unity. If you’re new to programming in Unity, head over to Unity Learn, which offers helpful [introductory tutorials](https://learn.unity.com/search?k=%5B%22q%3Ascriptable%20objects%22%5D). The first chapter in the e-book also offers a solid primer.

Let’s look at six ways you can benefit from using ScriptableObjects in your projects. Want to know more? All of these examples are explored further in the e-book and demo project.

<a href="https://unity.com/" class="cursor-pointer inline-block items-center outline-hidden overflow-x-hidden btn-primary btn-md caption-sm-bold px-3 py-2.5 inline-flex rounded-full btn-arrow"></a>

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Create modular game architecture in Unity with ScriptableObjects</span>

1\. Efficient team collaboration

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Although many of the techniques shared here can also be achieved using C# classes, one of the main benefits of ScriptableObjects is the accessibility to artists and designers. They can use ScriptableObjects to configure and apply game logic in a project without having to edit the code.

The Editor makes it convenient to view and edit ScriptableObjects, enabling designers to set up gameplay data without heavy support from the developer team. This also applies to game logic, such as applying behavior to an NPC by adding a ScriptableObject (explained in the patterns below).

Storing data and logic on a single MonoBehaviour can result in time-consuming merge conflicts if two people change different parts of the same Prefab or scene. By breaking up shared data into smaller files and assets with ScriptableObjects, designers can build gameplay in parallel with developers, instead of having to wait for the latter to finish setting up the gameplay in code before testing it.

Issues can arise when colleagues with different roles access the game code and assets at the same time. With ScriptableObjects, the programmer can control what part of the project is editable in the Editor. Additionally, using ScriptableObjects to organize your code leads naturally to a codebase that’s more modular and efficient to test.

Learn how a game designer uses ScriptableObjects

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Christo Nobbs, a senior technical game designer who specializes in systems game design and Unity (C#), contributed to [*The Unity game designer playbook*](https://resources.unity.com/games/game-designer-playbook?ungated=true?utm_source=demand-gen&utm_medium=pdf&utm_campaign=clean-code&utm_content=scriptable-objects-ebook), and is the main author of a blog post series on designing game systems in Unity. His posts, “[Systems that create ecosystems: Emergent game design](https://blog.unity.com/technology/systems-that-create-ecosystems-emergent-game-design)” and “[Unpredictably fun: The value of randomization in game design](https://blog.unity.com/technology/unpredictably-fun-the-value-of-randomization-in-game-design)” provide interesting examples of how designers can use ScriptableObjects.

<a href="https://unity.com/" class="cursor-pointer inline-block items-center outline-hidden overflow-x-hidden btn-primary btn-md caption-sm-bold px-3 py-2.5 inline-flex rounded-full btn-arrow"></a>

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Paddle game</span>

2\. Data containers

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Modularity is a general software principle which can be implemented in C# without using ScriptableObjects. But, as mentioned above, ScriptableObjects help promote clean coding practices by separating data from logic, which is a first step toward modular game code. This separation means it’s easier to make changes without causing unintended side effects, and improves testability.

ScriptableObjects excel at storing static data, making them handy for configuring static gameplay values like items or NPC stats, character dialogue, and much more. Because ScriptableObjects are saved as an asset, they persist outside of game mode, making it possible to use them for loading in a static configuration that dynamically changes at runtime.

While changes to ScriptableObject data do persist in the Editor, it’s important to note that they are not designed for saving game data. In that case, it’s better to use a serialization system, such as JSON, XML, or a binary solution if performance is critical.

MonoBehaviours carry extra overhead since they require a GameObject – and by default a Transform – to act as a host. This means you need to create a lot of unused data before storing a single value. A ScriptableObject slims down this memory footprint and drops the GameObject and Transform. It also stores data at the project level, which is helpful if you need to access the same data from multiple scenes.

It’s common to have many GameObjects which rely on duplicate data that does not need to change at runtime. Rather than having this duplicate local data on each GameObject, you can funnel it into a ScriptableObject. Each of the objects stores a reference to the shared data asset, rather than copying the data itself. This can provide significant performance improvements in projects with thousands of objects.

Many objects with duplicate local data leads to performance inefficiencies

Many objects sharing data (rather than duplicating it) via a ScriptableObject

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

In software design, this is an optimization known as the [flyweight pattern](https://www.gameprogrammingpatterns.com/flyweight.html). Restructuring your code in this way using ScriptableObjects avoids copying values and reduces your memory footprint. Check out our e-book, [*Level up your code with game programming patterns*](https://resources.unity.com/games/level-up-your-code-with-game-programming-patterns) to learn more about using design patterns in Unity.

<a href="https://unity.com/" class="cursor-pointer inline-block items-center outline-hidden overflow-x-hidden btn-primary btn-md caption-sm-bold px-3 py-2.5 inline-flex rounded-full btn-arrow"></a>

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Data containers in action</span>

3\. Enums

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

A good example of how ScriptableObjects can simplify your code is to use them as enums for comparison operations. The ScriptableObject can represent a category or item type, such as a special damage effect – cold, heat, electrical, magic, etc.

If your application requires an inventory system to equip gameplay items, ScriptableObjects can represent item types or weapon slots. The fields in the Inspector then function as a drag-and-drop interface for setting them up.

Drag-and-drop ScriptableObject-based categories

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Using ScriptableObjects as enums becomes more interesting when you want to extend them and add more data. Unlike normal enums, ScriptableObjects can have extra fields and methods. There’s no need to have a separate lookup table or correlate with a new array of data.

While traditional enums have a fixed set of values, ScriptableObject enums can be created and modified at runtime, allowing you to add or remove values as needed.

If you have a long list of enum values without explicit numbering, inserting or removing an enum can change their order. This reordering can introduce subtle bugs or unintended behavior. ScriptableObject-based enums don’t have these issues. You can delete or add to your project without having to change the code every time.

Suppose you want to make an item equippable in an RPG. You could append an extra boolean field to the ScriptableObject to do that. Are certain characters not allowed to hold certain items? Are some items magical or do they have special abilities? ScriptableObject-based enums can do that.

<a href="https://unity.com/" class="cursor-pointer inline-block items-center outline-hidden overflow-x-hidden btn-primary btn-md caption-sm-bold px-3 py-2.5 inline-flex rounded-full btn-arrow"></a>

<span class="btn-label transition-spacing flex duration-300 ease-in-out">See how to use enums to categorize different players.</span>

4\. Delegate objects

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Because you can create methods on a ScriptableObject, they are as useful for containing logic or actions as they are for holding data. Moving logic from your MonoBehaviour into a ScriptableObject enables you to use the latter as a delegate object, making the behavior more modular.

If you need to perform specific tasks, you can encapsulate their algorithms into their own objects. The original [Gang of Four](https://en.wikipedia.org/wiki/Design_Patterns) refers to this general design as the [strategy pattern](https://en.wikipedia.org/wiki/Strategy_pattern). The example below shows how to make the strategy pattern more useful by using an abstract class to implement EnemyAI. The result is several derived ScriptableObjects with different behavior, which then becomes a pluggable behavior since each asset is interchangeable. You just drag and drop the ScriptableObject of choice into the MonoBehaviour.

Pluggable behaviors can change at runtime or in the Editor

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

For a detailed example showing how to use ScriptableObjects to drive behavior, watch the video series [Pluggable AI with ScriptableObjects](https://www.youtube.com/watch?v=cHUXh5biQMg?utm_source=demand-gen&utm_medium=pdf&utm_campaign=clean-code&utm_content=scriptable-objects-ebook). These sessions demonstrate a finite state machine-based AI system that can be configured using ScriptableObjects for states, actions, and transitions between those states.

<a href="https://unity.com/" class="cursor-pointer inline-block items-center outline-hidden overflow-x-hidden btn-primary btn-md caption-sm-bold px-3 py-2.5 inline-flex rounded-full btn-arrow"></a>

<span class="btn-label transition-spacing flex duration-300 ease-in-out">An audio delegate shows how you can randomize sounds by swapping ScriptableObjects. Plus, see how ScriptableObjects can plug into the game management system for determining win-lose conditions.</span>

5\. Event channels

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

A common challenge in larger projects is when multiple GameObjects need to share data or states by avoiding direct references between these objects. Managing these dependencies at scale can require significant effort and is often a source of bugs. Many developers use singletons – one global instance of a class that survives scene loading. However, singletons introduce global states and make unit testing difficult. If you’re working with a Prefab that references a singleton, you’ll end up importing all of its dependencies just to test an isolated function. This makes your code less modular and efficient to debug.

One solution is to use ScriptableObject-based events to help your GameObjects communicate. In this case, you are using ScriptableObjects to implement a form of the [observer design pattern](https://en.wikipedia.org/wiki/Observer_pattern), where a subject broadcasts a message to one or more loosely decoupled observers. Each observing object can react independently from the subject but is unaware of the other observers. The subject can also be referred to as the “publisher” or “broadcaster” and the observers as “subscribers” or “listeners.”

You can implement the observer pattern with MonoBehaviours or [C# objects](https://unity.com/how-to/create-modular-and-maintainable-code-observer-pattern). While this is already common practice in Unity development, a script-only approach means your designers will rely on the programming team for every event needed during gameplay.

The ScriptableObject-based event channel

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

At first glance, it appears that you’ve added a layer of overhead to the observer pattern, but this structure offers some advantages. Since ScriptableObjects are assets, they are accessible to all objects in your hierarchy and don’t disappear on scene loading.

Easy, persistent access to certain resources is why many developers use singletons. ScriptableObjects can often provide the same benefits without introducing as many unnecessary dependencies.

In ScriptableObject-based events, any object can serve as publisher (which broadcasts the event), and any object can serve as a subscriber (which listens for the event). The ScriptableObject sits in the middle and helps relay the signal, acting like a centralized intermediary between the two.

One way to think about this is as an “event channel.” Imagine the ScriptableObject as a radio tower that has any number of objects listening for its signals. An interested MonoBehaviour can subscribe to the event channel and respond when something happens.

The demo shows how the observer pattern helps you set up game events for UI, sounds, and scoring.

<a href="https://unity.com/" class="cursor-pointer inline-block items-center outline-hidden overflow-x-hidden btn-primary btn-md caption-sm-bold px-3 py-2.5 inline-flex rounded-full btn-arrow"></a>

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Event channels in action</span>

6\. Runtime Sets

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

At runtime, you’ll often need to track a list of GameObjects or components in your scene. For example, a list of enemies is something you’d need to frequently access, but it’s also a dynamic list that changes as more enemies are spawned or defeated. The singleton offers easy global access, but it has several drawbacks. Instead of using a singleton, consider storing data on a ScriptableObject as a “Runtime Set.” The ScriptableObject instance appears at the project level, which means it can store data that’s available to any object from any scene, offering similar global access. Since the data is located on an asset, its public list of items is accessible at any time.

In this use case, you get a specialized data container that maintains a public collection of elements but also provides basic methods to add to and remove from the collection. This can reduce the need for singletons and improve testability and modularity.

A Runtime Set provides global access to a collection of data

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Reading data directly from a ScriptableObject is also more optimal than searching the Scene Hierarchy with a find operation like **Object.FindObjectOfType** or **GameObject.FindWithTag**. Depending on your use case and the size of your hierarchy, these are relatively expensive methods that can be inefficient for per-frame updates.

<a href="https://unity.com/" class="cursor-pointer inline-block items-center outline-hidden overflow-x-hidden btn-primary btn-md caption-sm-bold px-3 py-2.5 inline-flex rounded-full btn-arrow"></a>

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Runtime Sets in action</span>

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

There are several ScriptableObjects frameworks which offer more use cases than these six scenarios. Some teams decide to use ScriptableObjects extensively, while others limit their use to loading in static data and separating logic from data. Ultimately, the needs of your project will determine how you use them.

Advanced series for Unity programmers

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

[*Create modular game architecture in Unity with ScriptableObjects*](https://resources.unity.com/games/create-modular-game-architecture-with-scriptable-objects-ebook) is the third guide in our series for intermediate to advanced Unity programmers. Each guide, authored by experienced programmers, provides best practices for topics that are important to development teams.

[*Create a C# style guide: Write cleaner code that scales*](https://blog.unity.com/engine-platform/clean-up-your-code-how-to-create-your-own-c-code-style) assists you with developing a style guide to help unify your approach to creating a more cohesive codebase.

[*Level up your code with game programming patterns*](https://blog.unity.com/games/level-up-your-code-with-game-programming-patterns)highlights best practices for using the SOLID principles and common programming patterns to create scalable game code architecture in your Unity project.

We created this series to provide actionable tips and inspiration to our experienced creators, but they aren’t rule books. There are many ways to structure your Unity project and what might seem like a natural fit for one application may not be for another. Evaluate the advantages and disadvantages of each recommendation, tip, and pattern with your colleagues before deploying it.

Find more advanced guides and articles on the [Unity best practices hub](https://unity.com/how).

“Create modular game architecture in Unity with ScriptableObjects” ebook
