---
title: "Game programming patterns with Unity 6 (E-book update: More design patterns and SOLID principles)"
page_title: "Game programming patterns with Unity 6"
source_url: "https://unity.com/blog/game-programming-patterns-update-ebook"
final_url: "https://unity.com/blog/game-programming-patterns-update-ebook"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Game programming patterns with Unity 6

<a href="https://unity.com/blog" class="text-xxs mt-8 flex items-center font-bold uppercase hover:underline"><span class="ml-1">Unity Blog</span></a>

# E-book update: More design patterns and SOLID principles

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">THOMAS KROGH-JACOBSEN / UNITY TECHNOLOGIES</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Senior Technical Content Marketing Manager</span>

<span class="mr-2">Jul 23, 2024</span><span class="mr-2">\|</span><span class="mr-2">10 Min</span>

Testing and performance

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Back in the fall of 2022 we [launched](https://unity.com/blog/games/level-up-your-code-with-game-programming-patterns) the e-book [*Level up your code with game programming patterns*](https://unity.com/resources/level-up-your-code-with-game-programming-patterns), together with a GitHub repository with sample code. We also released a [five-part video tutorial series](https://www.youtube.com/playlist?list=PLX2vGYjWbI0TmDVbWNA56NbKKUgyUAQ9i) to accompany the e-book and sample project.

We've received great feedback from you on these resources, with many of you asking us to cover additional design patterns. Thank you for sharing your feedback. My team and I follow your comments closely and we really appreciate it.

Today, I’m excited to announce that an updated edition of the e-book, *Level up your code with design patterns and SOLID*, is now available, with an updated version of the [design patterns sample project](https://assetstore.unity.com/packages/essentials/tutorial-projects/level-up-your-code-with-design-patterns-and-solid-289616), which you can download from the Unity Asset Store.

Both the e-book and the sample project are now based on Unity 6 and include more examples and patterns. The sample project also includes more features from UI Toolkit, including an example that demonstrates databinding, a popular request from the community.

**Note**: Unity 6 will be available later this year. If you want to follow along with the examples in the guide, and the accompanying demo project, make sure to download [Unity 6 Preview](https://unity.com/releases/unity-6).

How design patterns and SOLID principles can benefit Unity projects

This illustration from the e-book explains how to apply the interface segregation principle from SOLID to split an interface into smaller ones.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Before diving into the new content in the e-book, some of you who are less familiar with the concepts might wonder: Why should I learn about design patterns, and how do they fit into Unity game development?

Coming back to your feedback, while the fundamentals of object-oriented programming are familiar to many, applying these principles in your own code can sometimes feel abstract and overly academic.

Think of it this way: For every software design issue you face, countless developers have encountered similar challenges before you. Although you can’t always ask them directly for advice, you can learn from their solutions through design patterns.

Design patterns offer general solutions to common problems in software engineering. They aren’t ready-made templates to copy and paste into your code, but rather tools in your toolbox to draw upon when needed. Some patterns are more intuitive than others, but each one can be useful in each context.

We created this guide for those who are new to design patterns or just need a refresher. It outlines common scenarios in game development where these patterns can be applied. If you're transitioning from another object-oriented language like Java or C++ to C#, you'll find practical examples of how to adapt these patterns specifically for Unity.

At their core, design patterns are simply ideas. They won’t apply to every situation, but when used correctly, they can help you build [scalable applications](https://unity.com/how-to/develop-modular-flexible-codebase-state-programming-pattern). Integrating them into your projects will enhance code readability and maintainability. As you become more familiar with these patterns, you'll identify opportunities to streamline your development process.

In short, our guide is designed to elevate your coding skills and create better Unity projects and establish an understanding of general industry best practices that you can carry with you throughout your career.

Download the updated e-book

<a href="https://unity.com/resources/design-patterns-solid-ebook" class="cursor-pointer inline-block items-center outline-hidden overflow-x-hidden btn-primary btn-md caption-sm-bold px-3 py-2.5 inline-flex rounded-full btn-arrow"></a>

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Download the updated e-book</span>

What’s in the updated e-book and project?

The single responsibility demo separates the Player into smaller components.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Let’s look at the key new additions to the design patterns resources:

### An expanded section on how to implement SOLID principles

The five core principles from SOLID now each have actionable code examples implemented in the sample project that are explained in the e-book. As a reminder, SOLID is a mnemonic acronym for five core fundamentals of software design – think of them as five basic rules to keep in mind that can help you keep object-oriented designs understandable, flexible, and maintainable.

As a quick reminder SOLID stands for:

-   **Single-responsibility principle:** A class should have only one reason to change, meaning it should only have one job or responsibility.
-   **Open-closed principle:** Classes should be open for extension but closed for modification, allowing them to be extended without changing existing code.
-   **Liskov substitution principle:** Objects of a superclass should be able to be replaced with objects of its subclasses without affecting the correctness of the program.
-   **Interface segregation principle:** Clients should not be forced to depend upon interfaces that they do not use. It promotes the creation of specific interfaces over a single, general-purpose interface.
-   **Dependency inversion principle:** High-level modules should not depend on low-level modules, but both should depend on abstractions.

Each SOLID principle has its own demo scene in the sample where the theory is put into a concrete example applicable to common use cases in games.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The key takeaway from diving into the examples is that following the principles can help you achieve the following benefits in your game development:

-   **Readability**: Clear and well-organized code facilitates efficient comprehension of project functionality. Adhering to SOLID principles can enhance code readability; when your code standards are consistent, you boost the chance of smooth collaboration between game programmers on a team.
-   **Scalability**: Implementing SOLID principles fosters maintainable code, which is crucial for projects that you want to scale. By adhering to these principles, changes made in one part of the codebase are less likely to introduce unexpected issues elsewhere. This approach ensures code remains flexible and adaptable to evolving requirements.
-   **Velocity**: Ultimately, SOLID principles contribute to improving game development workflows. Modular code, a key aspect emphasized by SOLID, involves breaking down systems into smaller, manageable components. This modular approach facilitates easier testing, debugging, and code reuse across projects, reducing development time and enhancing productivity.

A total of 11 patterns are now explored in the e-book and sample

An example of using data binding and the Model-View-ViewModel pattern together for health bar readings

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The updated e-book and project include four new patterns, bringing the total to 11. Here’s a quick rundown of each one:

-   **Factory pattern:** A classic use case is when you have powerups (such as speed boosts, shields, or extra lives), which share several attributes yet have different functionality. Here the factory pattern can be used to create instances of these different powerup classes derived from a common interface or base class, enabling flexible addition of new power ups without modifying existing client code.
-   **Object Pooling**: Some would refer to this as a performance optimization technique rather than a design pattern. In any case, think of it as a way to improve performance by reusing objects instead of creating and destroying them frequently. In our sample scene you will find an example of a gun turret firing large amounts of bullets at rapid speed. Rather than instantiating them (and cleaning up once they served their purpose at significant performance cost) each time we use the pattern to recycle them over and over.
-   **Singleton:** The singleton is likely one of the common patterns in game development – chances are you are already using it today. It’s useful if you need to have one object that coordinates actions across the entire scene. For example, you might want one game manager in your scene to direct the main game loop. However, there are some pitfalls to watch out for when using the singleton pattern, which we explain in the guide.
-   **Command Pattern:** You’ve likely seen the command pattern at work if you’ve played a game that uses undo/redo functionality or keeps your input history in a list. It’s a pattern you can leverage for a strategy game, for example, where the user can plan several turns before actually executing them in the order the input was given.
-   **State Pattern:** This allows an object to change its behavior when its internal state changes, which simplifies the management of complex state-dependent behavior in game characters or UI elements. Think of an enemy NPC that has different behaviors such as “idle”, “patrolling”, or “attacking” which depends on different game scenarios such as where the player is on the map.
-   **Observer Pattern**: This pattern helps you implement an efficient event system where objects can subscribe, and react, to events dynamically. One use case is that of a player collecting ammo in an action game that triggers different events such as playing a sound, updating the UI, and playing an animation.
-   **Model View Presenter (MVP):** At its core this pattern is about decoupling the display of state from the actual state, enabling a reactive design where views automatically update in response to model changes, making it a common pattern in UI programming. The **m**odel is the data, the **v**iew the user interface, and the **p**resenter a mediator which handles the logic for the view and synchronizes the data from the model.
-   **Model-View-ViewModel (New):** Like the name indicates this one is related to the MVP pattern but expands it by adding runtime data binding which simplifies how UI elements are updated. In our example we leverage the new data binding feature in UI Toolkit and Unity 6 Preview.
-   **Strategy Pattern (New)**: This pattern defines a family of algorithms by encapsulating each one, to make them interchangeable, allowing the algorithm to vary independently from clients that use it. This is a useful pattern for implementing different movement behaviors in game AI, for example.
-   **Flyweight Pattern (New)**: Use this pattern to optimize memory usage by sharing as much data as possible with similar objects. The basic idea is that you centralize the shared data among objects.
-   **Dirty Flag (New):** This pattern is useful for optimizing performance by marking objects as "dirty" when they change, so they are only recalculated or updated when necessary. This pattern can help you manage costly updates in game loops or in some UI rendering cases.

Share data across similar objects using the flyweight pattern.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The sample project mirrors the e-book by demonstrating each of the 11 patterns in action. You can [download the project](https://assetstore.unity.com/packages/essentials/tutorial-projects/level-up-your-code-with-design-patterns-and-solid-289616) from The Asset Store and follow along with the corresponding scenes to see these patterns applied in real-world scenarios. Note that the project requires Unity 6 Preview or later.

Before you jump into the project, there are a few helpful tips to keep in mind.

Navigate the menus to the SOLID and design pattern samples.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Start with the Bootstrap scene. This scene configures the demo and provides access to the main menu (you can learn more about the concept of SceneBootStrapper in the e-book). From the main menu, you can navigate to the appropriate sample. Each scene demonstrates a different SOLID principle or design pattern.

Explore the sample project.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Please note that there may be minor differences between the sample project and the code examples in the guide. To enhance clarity and readability, some examples feature simplified code like public fields.

Your team might prefer a coding style different from the conventions used in this guide or the sample project. We recommend creating a C# style guide tailored to your specific needs and following it consistently across the team. Check out our [e-book on how to create your own style guide](https://unity.com/resources/create-code-c-sharp-style-guide-e-book) to learn more.

Download the updated sample project

<a href="https://assetstore.unity.com/packages/essentials/tutorial-projects/level-up-your-code-with-design-patterns-and-solid-289616" class="cursor-pointer inline-block items-center outline-hidden overflow-x-hidden btn-primary btn-md caption-sm-bold px-3 py-2.5 inline-flex rounded-full btn-arrow"></a>

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Download the sample project</span>

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Consider the examples provided and determine which design pattern aligns best with your project needs. As you familiarize yourself with these patterns, you'll discover their potential to streamline and improve your development workflow.

Both the e-book and sample project on the use of design patterns are available to download for free:

Download the updated e-book

<a href="https://unity.com/resources/design-patterns-solid-ebook" class="cursor-pointer inline-block items-center outline-hidden overflow-x-hidden btn-primary btn-md caption-sm-bold px-3 py-2.5 inline-flex rounded-full btn-arrow"></a>

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Download the updated e-book</span>

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Happy coding!
