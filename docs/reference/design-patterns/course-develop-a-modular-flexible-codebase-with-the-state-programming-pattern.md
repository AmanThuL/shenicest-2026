---
title: "Develop a modular, flexible codebase with the state programming pattern (Unity 6)"
page_title: "Develop a modular, flexible codebase with the state programming pattern"
source_url: "https://learn.unity.com/course/design-patterns-unity-6/tutorial/develop-a-modular-flexible-codebase-with-the-state-programming-pattern"
final_url: "https://learn.unity.com/course/design-patterns-unity-6/tutorial/develop-a-modular-flexible-codebase-with-the-state-programming-pattern"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Develop a modular, flexible codebase with the state programming pattern

![](https://cdn.sanity.io/images/fuvbjjlp/learn-production/e3a1497e8a517d0050257f257266eb8d45e1e7ea-400x225.jpg)

# Develop a modular, flexible codebase with the state programming pattern

Tutorial

intermediate

+0XP

25m

31

\(52\)

Unity Technologies

![Develop a modular, flexible codebase with the state programming pattern](https://connect-mediagw.unity.com/h1/20240304/learn/images/a203c1db-a8b7-42d1-a29d-b78e3d162658_image__1_.png)

Summary

By implementing common game programming design patterns in your Unity project, you can efficiently build and maintain a clean, organized, and readable codebase. Design patterns not only reduce refactoring and the time spent testing, but they also speed up onboarding and development processes, contributing to a solid foundation that can be used to grow your game, development team, and business.

Think of design patterns not as finished solutions you can copy and paste into your code, but as extra tools that can help you build larger, scalable applications when used correctly.

This tutorial explains how the state programming pattern can help you build and maintain a clean, organized, and readable codebase.

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 1. Overview

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

By implementing common game programming design patterns in your Unity project, you can efficiently build and maintain a clean, organized, and readable codebase. Design patterns not only reduce refactoring and the time spent testing, but they also speed up onboarding and development processes, contributing to a solid foundation that can be used to grow your game, development team, and business.

Think of design patterns not as finished solutions you can copy and paste into your code, but as extra tools that can help you build larger, scalable applications when used correctly.

This tutorial explains how the state programming pattern can help you build and maintain a clean, organized, and readable codebase.

The content here is based on the free e-book, <a href="https://unity.com/resources/design-patterns-solid-ebook?isGated=false" class="link-primary text-inherit"><span style="text-decoration:underline">Level up your code with design patterns and SOLID</span></a>, which explains well known design patterns and shares practical examples for using them in your Unity project.

Other articles in the Unity game programming design patterns series are available on the <a href="https://unity.com/how-to" class="link-primary text-inherit"><span style="text-decoration:underline">Unity best practices</span></a> hub, or you can check out the following links:

-   <a href="https://learn.unity.com/tutorial/65df850fedbc2a082fb11029?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit"><span style="text-decoration:underline">Object pooling</span></a>
-   <a href="https://learn.unity.com/tutorial/65de086fedbc2a06ac2aca58?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit"><span style="text-decoration:underline">The observer pattern</span></a>
-   <a href="https://learn.unity.com/tutorial/65e0df08edbc2a2447bf0b98?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit"><span style="text-decoration:underline">The factory pattern </span></a>
-   <a href="https://learn.unity.com/tutorial/65e0cfacedbc2a2351773054?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit"><span style="text-decoration:underline">The MVC and MVP patterns </span></a>
-   <a href="https://learn.unity.com/tutorial/65e0e048edbc2a23a5ee7442?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit"><span style="text-decoration:underline">The command pattern </span></a>

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 2. Understanding states and state machines

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Imagine constructing a playable character. At one moment, the character may be standing on the ground. Move the controller, and it appears to run or walk. Press the jump button, and the character leaps into midair. A few frames later, the character lands and re-enters its idle, standing position.

The interactivity of computer games requires the tracking and management of many systems that change at runtime. If you draw a diagram that represents the different states of your character, you might come up with something like the image below:

![](https://connect-mediagw.unity.com/h1/20240228/learn/images/1716a2af-7761-413a-ba32-2300e7170004_Copy_of_7-1_StateDiagram.png)

This state diagram resembles a flowchart, but with a few differences:

-   It consists of a number of states (Idling/Standing, Walking, Running, Jumping, and so on), and only one current state is active at a given time.  
-   Each state can trigger a transition to one other state based on conditions at runtime.  
-   When a transition occurs, the output state becomes the new active state.

This diagram illustrates something called a <a href="https://en.wikipedia.org/wiki/Finite-state_machine" class="link-primary text-inherit"><span style="text-decoration:underline">finite-state machine </span></a>(FSM). In game development, one typical use case for an FSM is to track the internal state of a prop or a game actor like the playable character. There are many use cases for an FSM in game development, and if you have some experience developing a project in Unity, you’ve likely already employed a FSM in the context of the <a href="https://docs.unity3d.com/Manual/StateMachineBasics.html" class="link-primary text-inherit"><span style="text-decoration:underline">Animation State Machines</span></a> in Unity.

An FSM is defined by a list of its states. It has an initial state with conditions for each transition. An FSM can be in exactly one of a finite number of states at any given time, with the possibility of changing from one state to another in response to external inputs that result in a transition.

The State design pattern, on the other hand, defines an interface that represents a state and a class that implements this interface for each state. The context, or the class, that needs to alter its behavior based on the state holds a reference to the current state object. When the context’s internal state changes, it simply updates the reference to the state object to point to a different object, which then changes the context’s behavior.

The State pattern is similar to the FSM in that it also allows for the management of different states and the transition between them. However, a FSM is typically implemented using a switch statement, whereas the State design pattern defines an interface that represents a state and a class that implements this interface for each state.

The state pattern is widely used in game development, and it can be an effective way to manage the different states of a game, such as a main menu, a gameplay state, and a game over state.

Let’s check out the state pattern in action with the example in the following section.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 3. Translating your state into code

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

A demo project is available on the <a href="https://assetstore.unity.com/packages/essentials/tutorial-projects/level-up-your-code-with-design-patterns-and-solid-289616" class="link-primary text-inherit"><span style="text-decoration:underline">Unity Asset Store</span></a> that provides the example code in this section.

A simplified way to describe a basic FSM in code might look something like the example below that uses an **enum** and a **switch** statement.

First, you define an enum **PlayerControllerState** consisting of three states: Idle, Walk and Jump.

Then, **switch** is used as a conditional statement in the **Update** loop to test which state you’re currently in. Depending on the state, you can call the appropriate functions to carry out the specific behavior that applies.

This can work, but the **PlayerController** script can get messy quickly, particularly as you need to formulate the conditions for transitioning between the states. Using a **switch** statement to manage the state of a game with one script is not considered the best practice because it can lead to complex and hard-to-maintain code. The **switch** statement can become large and difficult to understand as the number of states and transitions increases.

Additionally, it makes it more difficult to add new states or transitions because changes need to be made to the **switch** statement. The State pattern, on the other hand, allows for a more modular and extensible design, making it easier to add new states or transitions.

```
public enum PlayerControllerState

public class UnrefactoredPlayerController : MonoBehaviour

    }

    private void GetInput()
    
    private void Walk()
    
    private void Idle()
    
    private void Jump()
    
}
```

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 4. A simple state pattern

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Let’s reimplement the state pattern to reorganize the logic of **PlayerController**. This code example is also available in <a href="https://assetstore.unity.com/packages/essentials/tutorial-projects/level-up-your-code-with-design-patterns-and-solid-289616" class="link-primary text-inherit"><span style="text-decoration:underline">the sample project</span></a>.

According to the original Gang of Four, the state design pattern solves two problems:

-   An object should change its behavior when its internal state changes.  
-   State-specific behavior is defined independently. Adding new states does not impact the behavior of existing states.

In the previous code example, the **UnrefactoredPlayerController** class can track state changes, but it does not satisfy the second issue. You want to minimize the impact on existing states when you add new ones. To do this, you can encapsulate a state as an object.

Imagine structuring each of the states in your example like the diagram below. Here, you enter the appropriate state and loop each frame until a condition causes control flow to exit. In other words, you encapsulate the specific state with an **Entry**, **Update**, and **Exit**.

![](https://connect-mediagw.unity.com/h1/20240228/learn/images/12ebb3b9-f843-4a88-9818-33826b46f60d_Copy_of_7-2_StateExecution.png)

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 5. An example state

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Here’s an example of the **IdleState**:

Similar to the **StateMachine.cs** script, the constructor is used to pass in the **PlayerController** object. This **player** contains a reference to the State Machine and everything else needed for the Update logic. The **IdleState** monitors the Character Controller’s velocity or jump state and then invokes the state machine’s **TransitionTo** method appropriately.

Review the sample project for the **WalkState** and **JumpState** implementation as well. Rather than have one large class that switches behavior, each state has its own update logic, allowing them to function independently from one another.

```
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
 

  namespace DesignPatterns.State
   
           // pass in any parameters you need in the constructors
           public IdleState(PlayerController player)
           
          public void Enter()
           
          // per-frame logic, include condition to transition to a new state
           public void Update()
           
              // if we move above a minimum threshold, transition to walking
               if (Mathf.Abs(player.CharController.velocity.x) > 0.1f || Mathf.Abs(player.CharController.velocity.z) > 0.1f)
               
           }
 

          public void Exit()
           
       }
   }
```

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 6. Implementing the pattern using an interface

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

To implement the above pattern, create an interface called "IState". Each concrete state in your game will then implement the interface by following this convention:

-   **An Entry:** This logic executes when first entering the state.
-   **Update:** This logic runs every frame (sometimes called Execute or Tick). You can further segment the **Update** method as **MonoBehaviour** does, using a **FixedUpdate** for physics, **LateUpdate**, and so on.

Any functionality in the **Update** runs each frame until a condition is detected that triggers a state change.

-   **An Exit:** The code here runs before leaving the state and transitioning to a new state.

You’ll need to create a class for each state that implements **IState**. In the sample project, a separate class has been set up for **WalkState**, **IdleState**, and **JumpState**.

```
public interface IState

    public void Update()
    
    public void Exit()
    
}
```

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 7. The StateMachine class

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Another class, **StateMachine.cs**, will then manage how control flow enters and exits the states. With the three example states, the state machine could look like the code sample below.

To follow the pattern, the state machine references a public object for each state under its management (in this case, **walkState**, **jumpState**, and **idleState**). Because the state machine doesn’t inherit from **MonoBehaviour**, use a constructor to set up each instance.

You can pass in any parameters needed to the constructor. In the sample project, a **PlayerController** is referenced in each state. You then use that to update each state per frame (see the **IdleState** example below).

Note the following about the state machine concept:

-   The Serializable attribute allows you to display the **StateMachine.cs** (and its public fields) in the Inspector. Another MonoBehaviour (for example, a **PlayerController** or **EnemyController**) can then use the state machine as a field.  
-   The CurrentState property is read only. The **StateMachine.cs** itself does not explicitly set this field. An external object like the **PlayerController** can then invoke the **Initialize** method to set the default State.  
-   Each state object determines its own conditions for calling the **TransitionTo** method to change the currently active state. You can pass in any necessary dependencies (including the state machine itself) to each state when setting up the **StateMachine** instance.

In the example project, the **PlayerController** already includes a reference to the **StateMachine**, so you only pass in one player parameter.

Each state object will manage its own internal logic, and you can make as many states as needed to describe your GameObject or component. Each one gets its own class that implements **IState**. In keeping with the <a href="https://en.wikipedia.org/wiki/SOLID" class="link-primary text-inherit"><span style="text-decoration:underline">SOLID</span></a> principles, adding more states has minimal impact on any previously created states.

```
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
 

  namespace DesignPatterns.State
   
          // reference to the state objects
           public WalkState walkState;
           public JumpState jumpState;
           public IdleState idleState;
 

          // event to notify other objects of the state change
           public event Action<IState> stateChanged;
 

          // pass in necessary parameters into constructor 
           public StateMachine(PlayerController player)
           
          // set the starting state
           public void Initialize(IState state)
           
          // exit this state and enter another
           public void TransitionTo(IState nextState)
           
          // allow the StateMachine to update this state
           public void Update()
           
           }
       }
   }
```

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 8. More resources

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

The state pattern can help you adhere to the SOLID principles when setting up internal logic for an object. Each state is relatively small and tracks only the conditions for transitioning into another state. In keeping with the open-closed principle, you can add more states without affecting existing ones and avoid cumbersome **switch** or **if** statements in one monolithic script.

You can also expand its functionality to communicate state changes to outside objects. You might want to add events (see the <a href="https://unity.com/how-to/create-modular-and-maintainable-code-observer-pattern" class="link-primary text-inherit"><span style="text-decoration:underline">observer pattern</span></a>). Having an event on entering or exiting a state can notify the relevant listeners and have them respond at runtime.

On the other hand, if you only have a few states to track, the extra structure can be overkill. This pattern might only make sense if you expect your states to grow to a certain complexity. As with every other design pattern you’ll need to evaluate the pros and cons based on the needs of your particular game.

#### More advanced resources for programming in Unity

![](https://connect-mediagw.unity.com/h1/20240301/learn/images/d76f17f7-863a-4fbd-a34c-9c1291bc9841_Blog_Post_800x450.jpg)

The e-book <a href="https://unity.com/resources/design-patterns-solid-ebook?isGated=false" class="link-primary text-inherit"><span style="text-decoration:underline">Level up your code with design patterns and SOLID</span></a>, provides more examples of how to use design patterns in Unity.

All advanced Unity technical e-books and articles are available on the <a href="https://unity.com/how-to" class="link-primary text-inherit"><span style="text-decoration:underline">best practices</span></a> hub. The e-books are also available on the <a href="https://docs.unity3d.com/Manual/best-practice-guides.html" class="link-primary text-inherit"><span style="text-decoration:underline">advanced best practices</span></a> page in documentation.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

## Complete this Tutorial

Mark all steps complete
