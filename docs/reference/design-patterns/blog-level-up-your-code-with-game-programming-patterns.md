---
title: "Level up your code with game programming patterns (Unity blog)"
page_title: "Level up your code with game programming patterns"
source_url: "https://unity.com/blog/games/level-up-your-code-with-game-programming-patterns"
final_url: "https://unity.com/blog/games/level-up-your-code-with-game-programming-patterns"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Level up your code with game programming patterns

<a href="https://unity.com/blog" class="text-xxs mt-8 flex items-center font-bold uppercase hover:underline"><span class="ml-1">Unity Blog</span></a>

# Level up your code with game programming patterns

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">THOMAS KROGH-JACOBSEN / UNITY TECHNOLOGIES</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Senior Technical Content Marketing Manager</span>

<span class="mr-2">Oct 13, 2022</span><span class="mr-2">\|</span><span class="mr-2">15 Min</span>

Game design

Testing and performance

The command pattern

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

**If you have experience with object-oriented programming languages, then you’ve likely heard of the SOLID principles, MVP, singleton, factory, and observer patterns. Our new e-book highlights best practices for using these principles and patterns to create scalable game code architecture in your Unity project.**

For every software design issue you encounter, a thousand developers have been there before. Though you can’t always ask them directly for advice, you can learn from their decisions through design patterns.

By implementing common, game programming design patterns in your Unity project, you can efficiently build and maintain a clean, organized, and readable codebase, which in turn, creates a solid foundation for scaling your game, development team, and business.

A design guide written by programmers, for programmers

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

In our community, we often hear that it can be intimidating to learn how to incorporate design patterns and principles, such as SOLID and KISS, into daily development. That’s why our free e-book, [*Level up your code with game programming patterns*](https://resources.unity.com/games/level-up-your-code-with-game-programming-patterns), explains well-known design patterns and shares practical examples for using them in your Unity project.

Written by internal and external Unity experts, the e-book is a resource that can help expand your developer’s toolbox and accelerate your project’s success. Read on for a preview of what the guide entails.

Design patterns for solving game development challenges

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Design patterns are general solutions to common problems found in software engineering. These aren’t finished solutions you can copy and paste into your code, but extra tools that can help you build larger, scalable applications when used correctly.

By integrating patterns consistently into your project, you can improve code readability and make your codebase cleaner. Design patterns not only reduce refactoring and the time spent testing, they speed up onboarding and development processes.

However, every design pattern comes with tradeoffs, whether that means additional structures to maintain or more setup at the beginning. You’ll need to do a cost-benefit assessment to determine if the advantage justifies the extra work required. Of course, this assessment will vary based on your project.

Strive for simplicity with KISS

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

KISS stands for “keep it simple, stupid.” The aim of this principle is to avoid unnecessary complexity in a system, as simplicity helps drive greater levels of user acceptance and interaction.

Note that “simple” does not equate to “easy.” Making something simple means making it focused. While you can create the same functionality without the patterns (and often more quickly), something fast and easy doesn’t necessarily result in something simple.

If you’re unsure whether a pattern applies to your particular issue, you might hold off until it feels like a more natural fit. Don’t use a pattern because it’s new or novel to you. Use it when you need it.

It’s in this spirit that the e-book was created. Keep the guide handy as a source of inspiration for new ways of organizing your code – not as a strict set of rules for you to follow.

Now, let’s turn to some of the key software design principles.

The SOLID principles defined

The Player, refactored into classes with single responsibilities

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

SOLID is a mnemonic acronym for five core fundamentals of software design. You can think of them as five basic rules to keep in mind while coding, to ensure that object-oriented designs remain flexible and maintainable.

The SOLID principles were first introduced by Robert C. Martin in the paper, *Design Principles and Design Patterns*. First published in 2000, the principles described are still applicable today, and to C# scripting in Unity:

-   **Single responsibility** states that each module, class, or function is responsible for one thing and encapsulates only that part of the logic.
-   **Open-closed** states that classes must be open for extension but closed for modification; that means structuring your classes to create new behavior without modifying the original code.
-   **Liskov substitution** states that derived classes must be substitutable for their base class when using inheritance.
-   **Interface segregation** states that no client should be forced to depend on methods it does not use. Clients should only implement what they need.
-   **Dependency inversion** states that high-level modules should not import anything directly from low-level modules. Both should depend on abstractions.

In the e-book, we provide illustrated examples of each principle with clear explanations for using them in Unity. In some cases, adhering to SOLID can result in additional work up front. You may need to refactor some of your functionality into abstractions or interfaces, but there is often a payoff in long-term savings.

The principles have dominated software design for nearly two decades at the enterprise level because they’re so well-suited to large applications that scale. If you’re unsure about how to use them, refer back to the KISS principle. Keep it simple, and don’t try to force the principles into your scripts just for the sake of doing so. Let them organically work themselves into place through necessity.

If you’re interested in learning more, check out the [SOLID presentation from Unite Austin 2017](https://www.youtube.com/watch?v=eIf3-aDTOOA?utm_source=demand-gen&utm_medium=pdf&utm_campaign=clean-code&utm_content=game-programming-patterns-ebook) by Dan Sagmiller of Productive Edge.

Design patterns for game development

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

What’s the difference between a design principle and a design pattern? One way to answer that question is to consider SOLID as a framework for, or a foundational approach to, writing object-oriented code. While design patterns are solutions or tools you can implement to avoid everyday software problems, remember that they’re not off-the-shelf recipes – or for that matter, algorithms with specific steps for achieving specific results.

A design pattern can be thought of as a blueprint. It’s a general plan that leaves the actual construction up to you. For instance, two programs can follow the same pattern but involve very different code.

When developers encounter the same problem in the wild, many of them will inevitably come up with similar solutions. Once a solution is repeated enough times, someone might “discover” a pattern and formally give it a name.

The Gang of Four

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Many of today’s software design patterns stem from the seminal work, [*Design Patterns: Elements of Reusable Object-Oriented Software*](https://en.wikipedia.org/wiki/Design_Patterns) by Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides. This book unpacks 23 such patterns identified in a variety of day-to-day applications.

The original authors are often referred to as the “Gang of Four” (GoF),and you’ll also hear the original patterns dubbed the GoF patterns. While the examples cited are mostly in C++ (and Smalltalk), you can apply their ideas to any object-oriented language, such as C#.

Since the Gang of Four originally published *Design Patterns* in 1994, developers have since established dozens more object-oriented patterns in a variety of fields, including game development.

Learning design patterns

The factory design pattern

The singleton pattern

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

While you can work as a game programmer without studying design patterns, learning them will help you become a better developer. After all, design patterns are labeled as such because they’re common solutions to well-known problems.

Software engineers rediscover them all the time in the normal course of development. You may have already implemented some of these patterns unwittingly.

Train yourself to look for them. Doing this can help you:

-   **Learn object-oriented programming**: Design patterns aren’t secrets buried in an esoteric StackOverflow post. They are common ways to overcome everyday hurdles in development. They can inform you of how many other developers have approached the same issue – remember, even if you’re not using patterns, someone else is.
-   **Talk to other developers**: Patterns can serve as a shorthand when trying to communicate as a team. Mention the “command pattern” or “object pool” and experienced Unity developers will know what you’re trying to implement.
-   **Explore new frameworks**:When you import a built-in package or something from the Asset Store, inevitably you’ll stumble onto one or more patterns discussed here. Recognizing design patterns will help you understand how a new framework operates, as well as the thought process involved in its creation.

As indicated earlier, not all design patterns apply to every game application. Don’t go looking for them with [Maslow’s hammer](https://en.wikipedia.org/wiki/Law_of_the_instrument); otherwise, you might only find nails.

Like any other tool, a design pattern’s usefulness depends on context. Each one provides a benefit in certain situations and also comes with its share of drawbacks. Every decision in software development comes with compromises.

Are you generating a lot of GameObjects on the fly? Does it impact your performance? Can restructuring your code fix that? Be aware of these design patterns, and when the time is right, pull them from your gamedev bag of tricks to solve the problem at hand.

In addition to the Gang of Four’s *Design Patterns, [Game Programming Patterns](https://gameprogrammingpatterns.com)* by Robert Nystrom is another standout resource, currently available for free as a web-based edition. The author details a variety of software patterns in a no-nonsense manner.

In our new e-book, you can dive into the sections that explain common design patterns, such as factory, object pool, singleton, command, state, and observer patterns, plus the Model View Presenter (MVP), among others. Each section explains the pattern along with its pros and cons, and provides an example of how to implement it in Unity so you can optimize its usage in your project.

<a href="https://www.github.com/Unity-Technologies/game-programming-patterns-demo" class="cursor-pointer inline-block items-center outline-hidden overflow-x-hidden btn-primary btn-md caption-sm-bold px-3 py-2.5 inline-flex rounded-full btn-arrow"></a>

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Level up your code with game programming patterns</span>

Patterns within Unity

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Unity already implements several established gamedev patterns, saving you the trouble of writing them yourself. These include:

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

-   **Game loop**: At the core of all games is an infinite loop that must function independently of clock speed, since the hardware that powers a game application can vary greatly. To account for computers of different speeds, game developers often need to use a fixed timestep (with a set frames-per-second) and a variable timestep where the engine measures how much time has passed since the previous frame.  
      
    Unity takes care of this, so you don’t have to implement it yourself. You only need to manage gameplay using MonoBehaviour methods like Update, LateUpdate, and FixedUpdate.  
-   **Update**: In your game application, you’ll often update each object’s behavior one frame at a time. While you can manually recreate this in Unity, the MonoBehaviour class does this automatically. Use the appropriate Update, LateUpdate, or FixedUpdate methods to modify your GameObjects and components to one tick of the game clock.

<a href="https://unity.com/" class="cursor-pointer inline-block items-center outline-hidden overflow-x-hidden btn-primary btn-md caption-sm-bold px-3 py-2.5 inline-flex rounded-full btn-arrow"></a>

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Game programming patterns demo</span>

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

-   **Prototype**: Often you need to copy objects without affecting the original. This creational pattern solves the problem of duplicating and cloning an object to make other objects similar to itself. This way you avoid defining a separate class to spawn every type of object in your game.  
      
    Unity’s [Prefab](https://docs.unity3d.com/Manual/Prefabs.html?utm_source=demand-gen&utm_medium=pdf&utm_campaign=clean-code&utm_content=game-programming-patterns-ebook) system implements a form of prototyping for GameObjects. This allows you to duplicate a template object complete with its components. Override specific properties to create [Prefab Variants](https://docs.unity3d.com/Manual/PrefabVariants.html?utm_source=demand-gen&utm_medium=pdf&utm_campaign=clean-code&utm_content=game-programming-patterns-ebook) or [nest Prefabs](https://docs.unity3d.com/Manual/NestedPrefabs.html?utm_source=demand-gen&utm_medium=pdf&utm_campaign=clean-code&utm_content=game-programming-patterns-ebook) inside other Prefabs to create hierarchies. Use a special [Prefab editing mode](https://docs.unity3d.com/Manual/EditingInPrefabMode.html?utm_source=demand-gen&utm_medium=pdf&utm_campaign=clean-code&utm_content=game-programming-patterns-ebook) to edit Prefabs in isolation or in context.  
-   **Component**:Most people working in Unity know this pattern. Instead of creating large classes with multiple responsibilities, build smaller components that each do one thing.  
      
    If you use composition to pick and choose components, you can combine them for complex behavior. Add Rigidbody and Collider components for physics, or a MeshFilter and MeshRenderer for 3D geometry. Each GameObject is only as rich and unique as its collection of components.

<a href="https://unity.com/" class="cursor-pointer inline-block items-center outline-hidden overflow-x-hidden btn-primary btn-md caption-sm-bold px-3 py-2.5 inline-flex rounded-full btn-arrow"></a>

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Discuss this latest e-book directly with our team.</span>

Create code architecture that scales

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

*Both the [e-book](https://resources.unity.com/games/level-up-your-code-with-game-programming-patterns) and a [sample project](https://github.com/Unity-Technologies/game-programming-patterns-demo) on the use of design patterns are available now to download for free. Review the examples and decide which design pattern best suits your project. As you gain experience with them, you’ll recognize how and when they can enhance your development process. As always, we encourage you to visit the [forum thread](https://forum.unity.com/threads/2-new-e-books-to-help-you-write-cleaner-code-are-now-available.1347089/) and let us know what you think of the e-book and sample.*
