---
title: "Use the command pattern for flexible and extensible game systems (Unity 6)"
page_title: "Use the command pattern for flexible and extensible game systems"
source_url: "https://learn.unity.com/course/design-patterns-unity-6/tutorial/use-the-command-pattern-for-flexible-and-extensible-game-systems"
final_url: "https://learn.unity.com/course/design-patterns-unity-6/tutorial/use-the-command-pattern-for-flexible-and-extensible-game-systems"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Use the command pattern for flexible and extensible game systems

![](https://cdn.sanity.io/images/fuvbjjlp/learn-production/e3a1497e8a517d0050257f257266eb8d45e1e7ea-400x225.jpg)

# Use the command pattern for flexible and extensible game systems

Tutorial

intermediate

+10XP

30m

25

\(25\)

Unity Technologies

![Use the command pattern for flexible and extensible game systems](https://connect-mediagw.unity.com/h1/20240304/learn/images/e39af8f8-f6fc-46c0-998a-f9631dd57ffe_image__1_.png)

Summary

Implementing common game programming design patterns in your Unity project can help you efficiently build and maintain a clean, organized, and readable codebase. Design patterns reduce refactoring and testing time, speeding up development processes and contributing to a solid foundation that can be used to grow your game, team, and business.

Think of design patterns not as finished solutions you can copy and paste into your code, but as extra tools that can help you build larger, scalable applications.

This tutorial explains the command design pattern.

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 1. Level up your code: Command pattern

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Before you begin this tutorial, check out the video below for a brief overview of how you can use the command pattern in a Unity project to delay logic so you can execute, manage, or plan a series of actions in a flexible way, undo and redo a set of actions, and evaluate a sequence of actions.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 2. Overview

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Implementing common game programming design patterns in your Unity project can help you efficiently build and maintain a clean, organized, and readable codebase. Design patterns reduce refactoring and testing time, speeding up development processes and contributing to a solid foundation that can be used to grow your game, team, and business.

Think of design patterns not as finished solutions you can copy and paste into your code, but as extra tools that can help you build larger, scalable applications.

This tutorial explains the command design pattern.

The content here is based on the free e-book, <a href="https://unity.com/resources/design-patterns-solid-ebook?isGated=false" class="link-primary text-inherit"><span style="text-decoration:underline">Level up your code with design patterns and SOLID</span></a>.

Check out more articles in the Unity game programming design patterns series on the <a href="https://unity.com/how-to" class="link-primary text-inherit"><span style="text-decoration:underline">Unity best practices</span></a> hub or via these links:

-   <a href="https://learn.unity.com/tutorial/65df850fedbc2a082fb11029?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit"><span style="text-decoration:underline">Object pooling</span></a>
-   <a href="https://learn.unity.com/tutorial/65df7f9bedbc2a083a63757b?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit"><span style="text-decoration:underline">The state pattern</span></a>
-   <a href="https://learn.unity.com/tutorial/65de086fedbc2a06ac2aca58?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit"><span style="text-decoration:underline">The observer pattern</span></a>
-   <a href="https://learn.unity.com/tutorial/65e0cfacedbc2a2351773054?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit"><span style="text-decoration:underline">The MVC and MVP patterns </span></a>
-   <a href="https://learn.unity.com/tutorial/65e0df08edbc2a2447bf0b98?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit"><span style="text-decoration:underline">The factory pattern </span></a>

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 3. Understanding the command pattern

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

The command programming design pattern is one of the original Gang of Four, and is useful whenever you want to track a specific series of actions. You’ve likely seen the command pattern at work if you’ve played a game that uses undo/redo functionality or keeps your input history in a list. Imagine a strategy game where the user can plan several turns before actually executing them. That’s the command pattern.

The command pattern allows actions to be represented as objects. Encapsulating actions as objects enables you to create a flexible and extensible system for controlling the behavior of GameObjects in response to user input. This works by encapsulating one or more method calls as a command object rather than invoking a method directly. Then you can store these command objects in a collection, like a queue or a stack, which works as a small buffer.

![](https://connect-mediagw.unity.com/h1/20240301/learn/images/a69a1b76-127a-42ea-9225-1bfcfce00444_Copy_of_6-1_CommandDiagram.png)

Storing command objects in this way enables you to control the timing of their execution by potentially delaying a series of actions for later playback. Similarly, you are able to redo or undo them and add extra flexibility to control each command object’s execution.

Here are some common applications of the pattern across different game genres:

-   In a real-time strategy game, the command pattern could be used to queue up unit and building actions. The game would then execute each command as resources become available.
-   In a turn-based strategy game, the player could select a unit and then store its moves or actions in a queue or other collection. At the end of the turn, the game would execute all of the commands in the player’s queue.
-   In a puzzle game, the command pattern could allow the player to undo and redo actions.
-   In a fighting game, reading button presses or gamepad motions in a specific command list could result in combos and special moves.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 4. Command pattern in a sample project

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Try out the <a href="https://assetstore.unity.com/packages/essentials/tutorial-projects/level-up-your-code-with-design-patterns-and-solid-289616" class="link-primary text-inherit"><span style="text-decoration:underline">sample project</span></a> that demonstrates different programming design patterns in the context of game development, including the command pattern.

In this sample, the player can move around a maze by clicking the buttons on the left side. As your player moves around, you can see a trail of movement. But more importantly, you can undo and redo your previous actions.

![](https://connect-mediagw.unity.com/h1/20240301/learn/images/a603741f-14d5-4629-bcf2-322b323ba7ca_Copy_of_6-2_CommandSampleProject.png)

To find the corresponding scene in the project, go to the folder named **9 Command**.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 5. The command object and command invoker

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

To implement the command pattern, you’ll need a general object that will contain your action. This command object will hold what logic to perform and how to undo it.

There are a number of ways to implement this, but here’s a simple version using an interface called **ICommand**:

```
public interface ICommand

```

In this case, every gameplay action will apply the **ICommand** interface (you could also implement this with an abstract class).

Each command object will be responsible for its own **Execute** and **Undo** methods. So adding more commands to your game won’t affect any existing ones.

The **CommandInvoker** class is then responsible for executing and undoing commands. In addition to the **ExecuteCommand** and **UndoCommand** methods, it has an undo stack to hold the sequence of command objects.

```
public class CommandInvoker

    public static void UndoCommand()
    
    }

    public static void RedoCommand()
    
    }
  }
}
```

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 6. Example: Undoable movement

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

In the sample project you can move your player around a small maze. A simple option for shifting the player’s position is to create a **PlayerMover**.

To do this, you’ll need to pass in a **Vector3** into the **Move** method to guide the player along the four compass directions. You can also use a raycast to detect the walls in the appropriate **LayerMask**. Of course, implementing what you want to apply to the command pattern is separate from the pattern itself.

```
public class PlayerMover : MonoBehaviour

    public bool IsValidMove(Vector3 movement)
    
}
```

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 7. The MoveCommand

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

To follow the command pattern, capture the **PlayerMover’s Move** method as an object. Instead of calling **Move** directly, create a new class, "MoveCommand", that implements the **ICommand** interface.

```
public class MoveCommand : ICommand

    public void Execute()
    
    public void Undo()
    
}
```

Whatever logic you want to accomplish goes in here, so invoke **Move** with the movement vector.

**ICommand** also needs an **Undo** method to restore the scene back to its previous state. In this case, the **Undo** logic subtracts the movement vector, essentially pushing the player in the opposite direction.

The **MoveCommand** stores any parameters that it needs to execute. Set these up with a constructor. In this case, you save the appropriate **PlayerMover** component and the movement vector.

Once you create the command object and save its needed parameters, use the **CommandInvoker’s** static **ExecuteCommand** and **UndoCommand** methods to pass in your **MoveCommand**. This runs the **MoveCommand’s Execute** or **Undo** and tracks the command object in the undo stack.

The **InputManager** doesn’t call the **PlayerMover’s Move** method directly. Instead, add an extra method, "RunMoveCommand", to create a new **MoveCommand** and send it to the **CommandInvoker**.

Then, set up the various **onClick** events of the UI Buttons to call **RunPlayerCommand** with the four movement vectors.

![](https://connect-mediagw.unity.com/h1/20240301/learn/images/4101802a-323f-4983-bc05-074a1c279768_Copy_of_6-3_CommandUML.png)

Check out the <a href="https://assetstore.unity.com/packages/essentials/tutorial-projects/level-up-your-code-with-design-patterns-and-solid-289616" class="link-primary text-inherit"><span style="text-decoration:underline">sample project</span></a> for implementation details for the **InputManager**. You can also set up your own input using the keyboard or gamepad. Your player can now navigate the maze. Select the **Undo** button so you can backtrack to the beginning square.

```
private void RunPlayerCommand(PlayerMover playerMover, Vector3 movement)

    if (playerMover.IsValidMove(movement))
    
}
```

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 8. Pros and cons

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Implementing replayability or undoability is as simple as generating a collection of command objects. You can also use the command buffer to play back actions in sequence with specific controls.

For example, think about a fighting game where a series of specific button clicks triggers a combo move or attack. Storing player actions with the command pattern makes setting up these combos much simpler.

On the flip side, the command pattern introduces more structure, just like the other design patterns. You’ll have to decide where these extra classes and interfaces provide enough benefit for deploying command objects in your application

![](https://connect-mediagw.unity.com/h1/20240301/learn/images/b651c92b-96b4-4a68-ba35-02f32753fbf0_Copy_of_6-4_UndoRedoStacks.png)

Once you learn the basics, you can affect the timing of commands and play them back in succession or reverse, depending on the context.

Consider the following when incorporating the command pattern:

-   **Create more commands:** The sample project only includes one type of command object, the **MoveCommand**. You can create any number of command objects that implement **ICommand** and track them using the **CommandInvoker**.
-   **Adding redo functionality is a matter of adding another stack:** When you undo a command object, push it onto a separate stack that tracks redo operations. This way you can quickly cycle through the undo history or redo those actions. Clear out the redo stack when the user invokes an entirely new movement (you can find an implementation in the sample project).
-   **Use a different collection for your buffer of command objects:** A queue might be handier if you want first in, first out (FIFO) behavior. If you use a list, track the currently active index; commands before active index are undoable. Commands after the index are redoable.
-   **Limit the size of the stacks:** Undo and redo operations can quickly get out of control. Limit the stacks to the least number of commands.
-   **Pass any necessary parameters into the constructor:** This helps encapsulate the logic as seen in the **MoveCommand** example.
-   **The CommandInvoker**: Like other external objects, the **CommandInvoker** doesn’t see the inner workings of the command object, only invoking **Execute** or **Undo**. Give the command object any data needed to work when calling the constructor.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 9. Level up your code: Pattern combo

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Now you're familiar with each pattern, check out the video below to learn more about how they can be used together.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 10. More resources

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

![](https://connect-mediagw.unity.com/h1/20240301/learn/images/584bb888-da59-40f9-b16a-2eebb8952ff8_Blog_Post_800x450.jpg)

Find more tips on how to use design patterns in your Unity applications, as well as the SOLID principles, in the free e-book <a href="https://unity.com/resources/design-patterns-solid-ebook?isGated=false" class="link-primary text-inherit"><span style="text-decoration:underline">Level up your code with design patterns and SOLID</span></a>.

You can find all advanced Unity technical e-books and articles on the <a href="https://unity.com/how-to" class="link-primary text-inherit"><span style="text-decoration:underline">best practices</span></a> hub. The e-books are also available on the <a href="https://docs.unity3d.com/Manual/best-practice-guides.html" class="link-primary text-inherit"><span style="text-decoration:underline">advanced best practices</span></a> page in documentation.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

## Complete this Tutorial

Mark all steps complete
