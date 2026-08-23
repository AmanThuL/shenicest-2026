---
title: "How to use the factory pattern for object creation at runtime (Unity 6)"
page_title: "How to use the factory pattern for object creation at runtime"
source_url: "https://learn.unity.com/course/design-patterns-unity-6/tutorial/how-to-use-the-factory-pattern-for-object-creation-at-runtime"
final_url: "https://learn.unity.com/course/design-patterns-unity-6/tutorial/how-to-use-the-factory-pattern-for-object-creation-at-runtime"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# How to use the factory pattern for object creation at runtime

![](https://cdn.sanity.io/images/fuvbjjlp/learn-production/e3a1497e8a517d0050257f257266eb8d45e1e7ea-400x225.jpg)

# How to use the factory pattern for object creation at runtime

Tutorial

intermediate

+10XP

30m

28

\(16\)

Unity Technologies

![How to use the factory pattern for object creation at runtime](https://connect-mediagw.unity.com/h1/20240304/learn/images/96ff2bd8-d35f-40ad-bc0d-2c5543bd55db_image__1_.png)

Summary

Implementing common game programming design patterns in your Unity project can help you efficiently build and maintain a clean, organized, and readable codebase. Design patterns reduce refactoring and testing time, speeding up development processes and contributing to a solid foundation that can be used to grow your game, team, and business.

Think of design patterns not as finished solutions you can copy and paste into your code, but as extra tools that can help you build larger, scalable applications.

This tutorial explains the factory design pattern.

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 1. Level up your code: Factory pattern

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Before you begin this tutorial, check out the video below for a brief overview of how you can use the factory pattern in a Unity project to build an interface to create objects in a superclass, while allowing subclasses to alter the type of objects.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 2. Overview

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Implementing common game programming design patterns in your Unity project can help you efficiently build and maintain a clean, organized, and readable codebase. Design patterns reduce refactoring and testing time, speeding up development processes and contributing to a solid foundation that can be used to grow your game, team, and business.

Think of design patterns not as finished solutions you can copy and paste into your code, but as extra tools that can help you build larger, scalable applications.

This tutorial explains the factory design pattern.

The content here is based on the free e-book, <a href="https://unity.com/resources/design-patterns-solid-ebook?isGated=false" class="link-primary text-inherit"><span style="text-decoration:underline">Level up your code with design patterns and SOLID</span></a>.

Check out more articles in the Unity game programming design patterns series on the <a href="https://unity.com/how-to" class="link-primary text-inherit"><span style="text-decoration:underline">Unity best practices</span></a> hub or via these links:

-   <a href="https://learn.unity.com/tutorial/65df850fedbc2a082fb11029?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit"><span style="text-decoration:underline">Object pooling</span></a>
-   <a href="https://learn.unity.com/tutorial/65df7f9bedbc2a083a63757b?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit"><span style="text-decoration:underline">The state pattern</span></a>
-   <a href="https://learn.unity.com/tutorial/65de086fedbc2a06ac2aca58?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit"><span style="text-decoration:underline">The observer pattern</span></a>
-   <a href="https://learn.unity.com/tutorial/65e0cfacedbc2a2351773054?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit"><span style="text-decoration:underline">The MVC and MVP patterns </span></a>
-   <a href="https://learn.unity.com/tutorial/65e0e048edbc2a23a5ee7442?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit"><span style="text-decoration:underline">The command pattern </span></a>

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 3. Understanding the factory pattern

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Sometimes it’s helpful to have a special object that creates other objects. Many games spawn a variety of things over the course of gameplay, and you often don’t know what you need at runtime until you actually need it.

The factory pattern designates a special object called – you guessed it – a factory for this purpose. On one level, it encapsulates many of the details involved in spawning its products. The immediate benefit is to declutter your code.

![](https://connect-mediagw.unity.com/h1/20240301/learn/images/cb8055de-0d18-40fc-881a-a596f28efdbe_Copy_of_3-1_FactoryDiagram.png)

However, if each product follows a common interface or base class, you can take this a step further and make it contain more of its own construction logic, hiding it away from the factory itself. Creating new objects thus becomes more extensible.

You can also subclass the factory to make multiple factories dedicated to specific products. Doing this helps generate enemies, obstacles, or anything else at runtime.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 4. Test the factory pattern in a sample project

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

A <a href="https://assetstore.unity.com/packages/essentials/tutorial-projects/level-up-your-code-with-design-patterns-and-solid-289616" class="link-primary text-inherit"><span style="text-decoration:underline">sample project</span></a> is available on the Unity Asset Store that demonstrates different programming design patterns in the context of game development, including the factory pattern.

The factory pattern sample consists of code for a player to move around a maze. In the maze, you can spawn two different GameObjects called **products** by clicking. They both use the same interface and share a similar shape, but one spawns particles and the other plays a sound.

![](https://connect-mediagw.unity.com/h1/20240301/learn/images/2f9f2916-5826-4b9c-951a-5fee53c570d4_Copy_of_3-3_FactorySampleProject.png)

The factory pattern scene is in the folder named **6 Factory**.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 5. Creating a simple factory

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Imagine you want to create a factory pattern to instantiate items for a game level. You can use prefabs to create GameObjects, but you might also want to run some custom behavior when creating each instance.

Rather than using **if** statements or a **switch** to maintain this logic, create an interface called "IProduct" and an abstract class called "Factory" as outlined in the code example below:

```
public interface IProduct

    public void Initialize();
}

public abstract class Factory : MonoBehaviour

```

Products need to follow a specific template for their methods, but they don’t otherwise share any functionality. Hence, you define the **IProduct** interface.

Factories might need some shared common functionality, so this sample uses abstract classes. Just be mindful of Liskov substitution from the SOLID principles when using subclasses. It states that objects of a superclass should be replaceable with objects of a subclass without affecting the correctness of the program. In other words, any program that uses a superclass reference should be able to use any of its subclasses without knowing it.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 6. Class structure in the factory pattern

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

The **IProduct** interface defines what is common between your products. In this case, you simply have a **ProductName** property and any logic the product runs on **Initialize**.

You can then define as many products as you need (**ProductA**, **ProductB**, etc.) so long as they follow the **IProduct** interface.

The base class, **Factory**, has a **GetProduct** method that returns an **IProduct**. It’s abstract, so you can’t make instances of **Factory** directly. You derive a couple of concrete subclasses (**ConcreteFactoryA** and **ConcreteFactoryB**), which will actually get the different products.

**GetProduct** in this example takes a Vector3 position so that you can instantiate a prefab GameObject more easily at a specific location. A field in each concrete factory also stores the corresponding template prefab.

The result is a structure which looks something like the image below:

![](https://connect-mediagw.unity.com/h1/20240301/learn/images/5f61fffe-229d-4a2f-9fd9-8bb63c6af59e_Copy_of_3-2_FactoryUML.png)

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 7. Code example

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

In the code snippet below, you can see a sample **ProductA** and **ConcreteFactoryA**:

```
public class ProductA : MonoBehaviour, IProduct

    private ParticleSystem particleSystem;

    public void Initialize()
    
}

public class ConcreteFactoryA : Factory

}
```

Here, you’ve made the product classes MonoBehaviours that implement **IProduct** take advantage of prefabs in the factory.

Note how each product can have its own version of **Initialize**. The example **ProductA** prefab contains a ParticleSystem, which plays when the **ConcreteFactoryA** instantiates a copy. The factory itself does not contain any specific logic for triggering the particles; it only invokes the **Initialize** method, which is common to all products.

Explore the sample project to see how the **ClickToCreate** component switches between factories to create **ProductA** and **ProductB**, which have different behaviors. **ProductB** plays a sound when it spawns, while **ProductA** sets off a particle effect to illustrate the core concept of the product variations.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 8. Pros and cons

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

You’ll benefit the most from the factory pattern when setting up many products. Defining new product types in your application doesn’t change your existing ones or require you to modify previous code.

Separating each product’s internal logic into its own class keeps the factory code relatively short. Each factory only knows to invoke **Initialize** on each product without being privy to the underlying details.

The downside is that you create a number of classes and subclasses to implement the pattern. Like the other patterns, this introduces a bit of overhead, which may be unnecessary if you don’t have a large variety of products. On the other hand, the initial time spent setting up the classes may be a good thing in the long run in terms of decoupling your code and making it easier to maintain.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 9. Adapting the factory pattern

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

The implementation of the factory can vary widely from what’s shown here. Consider the following adjustments when building your own factory pattern:

-   **Use a dictionary to search for products:** You might want to store your products as key-value pairs in a dictionary. Use a unique string identifier (for example, the name or some ID) as the key and the type as a value. This can make retrieving products and/or their corresponding factories more convenient.
-   **Make the factory (or a factory manager) static:** This makes it easier to use but requires additional setup. Static classes won’t appear in the **Inspector** window, so you will need to make your collection of products static as well.
-   **Apply it to non-GameObjects and non-MonoBehaviours:** Don’t limit yourself to prefabs or other Unity-specific components. The factory pattern can work with any C# object.
-   **Combine with the object pool pattern:** Factories don’t necessarily need to instantiate or create new objects. They can also retrieve existing ones in the **Hierarchy** window. If you are instantiating many objects at once (for example, projectiles from a weapon), use the <a href="https://unity.com/how-to/use-object-pooling-boost-performance-c-scripts-unity" class="link-primary text-inherit"><span style="text-decoration:underline">object pool pattern</span></a> for more optimized memory management.

Factories can spawn any gameplay element on an as-needed basis. However, creating products is often not their only purpose. You might be using the factory pattern as part of another larger task (for example, setting up UI elements in a dialog box of parts of a game level).

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 10. More resources

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

![](https://connect-mediagw.unity.com/h1/20240301/learn/images/2eb5adde-f85c-4c39-b680-1e36c58402d5_Blog_Post_800x450.jpg)

Find more tips on how to use design patterns in your Unity applications, as well as the SOLID principles, in the free e-book <a href="https://unity.com/resources/design-patterns-solid-ebook?isGated=false" class="link-primary text-inherit"><span style="text-decoration:underline">Level up your code with design patterns and SOLID</span></a>.

You can find all advanced Unity technical e-books and articles on the <a href="https://unity.com/how-to" class="link-primary text-inherit"><span style="text-decoration:underline">best practices</span></a> hub. The e-books are also available on the <a href="https://docs.unity3d.com/Manual/best-practice-guides.html" class="link-primary text-inherit"><span style="text-decoration:underline">advanced best practices</span></a> page in documentation.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

## Complete this Tutorial

Mark all steps complete
