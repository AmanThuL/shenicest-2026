---
title: "Build a modular codebase with MVC and MVP programming patterns (Unity 6)"
page_title: "Build a modular codebase with MVC and MVP programming patterns"
source_url: "https://learn.unity.com/course/design-patterns-unity-6/tutorial/build-a-modular-codebase-with-mvc-and-mvp-programming-patterns"
final_url: "https://learn.unity.com/course/design-patterns-unity-6/tutorial/build-a-modular-codebase-with-mvc-and-mvp-programming-patterns"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Build a modular codebase with MVC and MVP programming patterns

![](https://cdn.sanity.io/images/fuvbjjlp/learn-production/e3a1497e8a517d0050257f257266eb8d45e1e7ea-400x225.jpg)

# Build a modular codebase with MVC and MVP programming patterns

Tutorial

intermediate

+10XP

20m

51

\(49\)

Unity Technologies

![Build a modular codebase with MVC and MVP programming patterns ](https://connect-mediagw.unity.com/h1/20240304/learn/images/29cd4408-f0c4-4f75-8451-304ac69d1910_image__1_.png)

Summary

By implementing common game programming design patterns in your Unity project, you can efficiently build and maintain a clean, organized, and readable codebase. Design patterns not only reduce refactoring and time spent testing, but they also speed up onboarding and development processes, contributing to a solid foundation that can be used to grow your game, development team, and business.

Think of design patterns not as finished solutions you can copy and paste into your code, but as extra tools that, when used correctly, can help you build larger, scalable applications.

This tutorial explains how you can efficiently build and maintain a clean, organized, and readable codebase by implementing MVC and MVP design patterns in your Unity project.

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 1. Level up your code: Model-view-presenter

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Before you begin this tutorial, check out the video below for a brief overview of how you can use the Model-view-presenter design pattern in your Unity projects. This pattern can help neatly organize your code so it’s easier to manage, less error-prone and more flexible for future updates.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 2. Overview

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

By implementing common game programming design patterns in your Unity project, you can efficiently build and maintain a clean, organized, and readable codebase. Design patterns not only reduce refactoring and time spent testing, but they also speed up onboarding and development processes, contributing to a solid foundation that can be used to grow your game, development team, and business.

Think of design patterns not as finished solutions you can copy and paste into your code, but as extra tools that, when used correctly, can help you build larger, scalable applications.

This tutorial explains how you can efficiently build and maintain a clean, organized, and readable codebase by implementing MVC and MVP design patterns in your Unity project.

The content here is based on the free e-book, <a href="https://unity.com/resources/design-patterns-solid-ebook?isGated=false" class="link-primary text-inherit"><span style="text-decoration:underline">Level up your code with design patterns and SOLID</span></a>, , which explains well known design patterns and shares practical examples for using them in your Unity project.

Other articles in the Unity game programming patterns series are available on the <a href="https://unity.com/how-to" class="link-primary text-inherit"><span style="text-decoration:underline">Unity best practices</span></a> hub, or you can check out the following links:

-   <a href="https://learn.unity.com/tutorial/65df7f9bedbc2a083a63757b?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit"><span style="text-decoration:underline">The state pattern</span></a>
-   <a href="https://learn.unity.com/tutorial/65de086fedbc2a06ac2aca58?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit"><span style="text-decoration:underline">The observer pattern</span></a>
-   <a href="https://learn.unity.com/tutorial/65e0df08edbc2a2447bf0b98?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit"><span style="text-decoration:underline">The factory pattern </span></a>
-   <a href="https://learn.unity.com/tutorial/65e0cfacedbc2a2351773054?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit"><span style="text-decoration:underline">The MVC and MVP patterns </span></a>
-   <a href="https://learn.unity.com/tutorial/65e0e048edbc2a23a5ee7442?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit"><span style="text-decoration:underline">The command pattern </span></a>

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 3. Benefits of using design patterns

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

You can use the Model View Controller (MVC) and Model View Presenter (MVP) design patterns to separate the data and logic in your application from how it’s being presented. These patterns apply the principles of separation of concerns, which can improve the flexibility and maintainability of your codebase.

In Unity game development, you can use these patterns to separate the logic of a game into distinct components, like the data (Model), the visual representation (View), and the logic that controls the interaction between the two (Controller or Presenter).

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 4. The MVC design pattern

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

MVC is a family of design patterns commonly used when developing user interfaces in software applications.

The general idea behind MVC is to separate the logical portion of your software from the data and the presentation. This helps reduce unnecessary dependencies and can potentially cut down on <a href="https://en.wikipedia.org/wiki/Spaghetti_code" class="link-primary text-inherit"><span style="text-decoration:underline">spaghetti code</span></a>.

As the name implies, the MVC pattern splits your application into three layers:

-   **The Model stores data:** The Model is strictly a data container that holds values. It does not perform gameplay logic or run calculations.
-   **The View is the interface:** The View formats and renders a graphical presentation of your data onscreen.
-   **The Controller handles logic**: Think of this as the brain. It processes the game data and calculates how the values change at runtime.

![](https://connect-mediagw.unity.com/h1/20240301/learn/images/8ca4bdd1-02eb-4661-b35b-dfe93630ed79_Copy_of_9-1_MVC.png)

This separation of concerns also specifically defines how these three parts interact with one another. The Model manages the application data, while the View displays that data to the user. The Controller handles input and performs any decisions or calculations on the game data.

Then it sends the results back to the Model.

The Controller does not contain any game data unto itself. Nor does the View. The MVC design limits what each layer does. One part holds the data, another part processes the data, and the last one displays that data to the user.

On the surface, you can think of this as an extension of the single-responsibility principle. Each part does one thing and does it well, which is the key advantage of MVC architecture.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 5. MVP and Unity

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

A <a href="https://assetstore.unity.com/packages/essentials/tutorial-projects/level-up-your-code-with-design-patterns-and-solid-289616" class="link-primary text-inherit"><span style="text-decoration:underline">sample project</span></a> is available on the Unity Asset Store that demonstrates different programming design patterns, including an example of how to implement a variation of the MVP.

When developing a Unity project with MVC, the existing UI framework (either the <a href="https://docs.unity3d.com/Manual/UIElements.html" class="link-primary text-inherit"><span style="text-decoration:underline">UI Toolkit</span></a> or <a href="https://docs.unity3d.com/Manual/com.unity.ugui.html" class="link-primary text-inherit"><span style="text-decoration:underline">Unity UI</span></a>) naturally functions as the View. Because the engine gives you a complete user interface implementation, you won’t need to develop individual UI components from scratch.

However, following the traditional MVC pattern would require View-specific code to listen for any changes in the Model’s data at runtime.

While this is a valid approach, many Unity developers opt to use a variation on MVC where the Controller acts as an intermediary. Here, the View doesn’t directly observe the Model. Instead, it does something like in the diagram above.

This variation on MVC is called the Model View Presenter design, or MVP. MVP still preserves the separation of concerns with three distinct application layers. However, it slightly changes each part’s responsibilities.

In MVP, the Presenter (called the Controller in MVC) acts as a go-between for the other layers. It retrieves data from the Model and then formats it for display in the View. MVP switches which layer handles input. Rather than the Controller, the View is responsible for handling user input.

![](https://connect-mediagw.unity.com/h1/20240301/learn/images/cf1c53e5-4959-4c37-baa5-ce037c722f27_Copy_of_9-2_MVP.png)

Notice how events and the observer pattern figure into this design. The user can interact with Unity UI’s Button, Toggle, and Slider components. The View layer sends this input back to the Presenter via UI events, and the Presenter, in turn, manipulates the Model. A state-change event from the Model tells the Presenter that the data has been updated. The Presenter passes the modified data to the View, which refreshes the UI.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 6. Try our sample project

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

A <a href="https://assetstore.unity.com/packages/essentials/tutorial-projects/level-up-your-code-with-design-patterns-and-solid-289616" class="link-primary text-inherit"><span style="text-decoration:underline">sample project</span></a> is available on the Unity Asset Store that demonstrates different programming design patterns, including an example of how to implement a variation of the MVP.

The MVP example consists of a simple system that shows the health of a character or item. This example has everything in one class that mixes the data and UI, but that wouldn’t scale well in real-world productions. Adding more functionality would become more complicated as you need to expand it. In addition, testing and refactoring would result in a lot of overhead.

Instead, you can rewrite your health components in a more MVP-centric way, starting by dividing your scripts into a Health and HealthPresenter.

In the <a href="https://assetstore.unity.com/packages/essentials/tutorial-projects/level-up-your-code-with-design-patterns-and-solid-289616" class="link-primary text-inherit"><span style="text-decoration:underline">sample project</span></a>, you can click to damage the target object represented by a shooting disc (**ClickDamage.cs**), or reset the health with the button. These events inform the **HealthPresenter** (which invokes **Damage** or **Reset**) rather than change the **Health** directly. The UI Text and UI Slider update when the **Health** raises an event and notifies the **HealthPresenter** that its values have changed.

![](https://connect-mediagw.unity.com/h1/20240301/learn/images/f06b6063-7741-4736-8d2d-6ce76a8bbaab_Copy_of_9-3_MVPSampleProject.png)

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 7. The Health interface

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Let’s dive deeper into what a **Health** component could look like. In this version, **Health** serves as the Model. It stores the actual health value and invokes an event, **HealthChanged**, every time that value changes. **Health** does not contain gameplay logic, only methods to increment and decrement the data.

This allows a clear distinction between the data, the way it’s presented, and the way it’s controlled.

```
public class Health: MonoBehaviour

    public int MinHealth => minHealth;
    public int MaxHealth => maxHealth;

    public void Increment(int amount)
    
    public void Decrement(int amount)
    
    public void Restore()
    
    public void UpdateHealth()
    
}
```

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 8. The HealthPresenter

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

In the example discussed above, most objects won’t manipulate the **Health** itself. You’ll reserve a **HealthPresenter** for that task.

Other GameObjects will need to use the **HealthPresenter** to modify the health values using **Damage**, **Heal**, and **Reset**. The **HealthPresenter** usually waits to update the user interface with the UpdateView until the Health raises its **HealthChanged** event. This is useful if setting the values in the Model takes a short duration (for example, saving values to disk or storing them in a database).

```
public class HealthPresenter : MonoBehaviour

        UpdateView();
    }

    private void OnDestroy()
    
    }

    public void Damage(int amount)
    
    public void Heal(int amount)
    
    public void Reset()
    
    public void UpdateView()
    
    }

    public void OnHealthChanged()
    
}
```

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 9. Pros and cons

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

MVP (and MVC) really shine for larger and UI-heavy software applications, but it’s not limited to those use cases. If your game requires a sizable team to develop and you expect to maintain it for a long time after launch, you might see the following benefits:

-   **Smooth division of work:** Because you’ve separated the View from the Presenter, developing and updating your user interface can happen nearly independently from the rest of the codebase.

This lets you divide your labor between specialized developers. Do you have expert front-end developers on your team? If so, let them take care of the View.

-   **Simplified unit testing with MVP and MVC:** These design patterns separate gameplay logic from the user interface. As such, you can simulate objects to work with your code without actually needing to enter Play mode in the Editor. This can save considerable amounts of time.  
-   **Readable code that can be maintained:** You’ll tend to make smaller classes with this design pattern, which makes them easier to read. Fewer dependencies usually means fewer places for your software to break, fewer places that might be hiding bugs, and easier testing.

Though MVC and MVP are widespread in web development or enterprise software, often, the benefits won’t be apparent until your application reaches a sufficient size and complexity. You’ll need to consider the following before implementing either pattern in your Unity project:

-   **You need to plan ahead:** MVC and MVP are larger architectural patterns. To use one of them, you’ll need to split your classes by responsibility, which takes some organization and requires more work up front. Design patterns are best used consistently, so you’ll want to establish a practice for organizing your UI and ensure that your team is onboard.  
-   **Not everything in your Unity project will fit the pattern:** In a pure MVC or MVP implementation, anything that renders to screen really is part of the View. Not every Unity component is easily split between data, logic, and interface (for example, a MeshRenderer). Also, simple scripts may not yield many benefits from MVC/MVP.  
      
    You’ll need to judge where you can benefit the most from the pattern. Usually, you can let the unit tests guide you. If MVC/MVP can facilitate testing, consider them for that aspect of the application. Otherwise, don’t try to force the pattern onto your project.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 10. More resources

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

![](https://connect-mediagw.unity.com/h1/20240301/learn/images/df3feaf2-5715-4e51-ae81-890dad830716_Blog_Post_800x450.jpg)

You’ll find many more tips on how to use design patterns in your Unity applications, as well as the SOLID principles, in the free e-book <a href="https://unity.com/resources/design-patterns-solid-ebook?isGated=false" class="link-primary text-inherit"><span style="text-decoration:underline">Level up your code with design patterns and SOLID</span></a>.

If you’d like more in-depth instruction on using Unity UI and UI Toolkit, check out the extensive guide, <a href="https://resources.unity.com/games/user-interface-design-and-implementation-in-unity?ungated=true" class="link-primary text-inherit"><span style="text-decoration:underline">User interface design and implementation in Unity guide</span></a>, written by UI professionals.

You can find all advanced Unity technical e-books and articles on the <a href="https://unity.com/how-to" class="link-primary text-inherit"><span style="text-decoration:underline">best practices</span></a> hub. The e-books are also available on the <a href="https://docs.unity3d.com/Manual/best-practice-guides.html" class="link-primary text-inherit"><span style="text-decoration:underline">advanced best practices</span></a> page in documentation.hub. The e-books are also available on the <a href="https://docs.unity3d.com/Manual/best-practice-guides.html" class="link-primary text-inherit"><span style="text-decoration:underline">advanced best practices</span></a> page in documentation.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

## Complete this Tutorial

Mark all steps complete
