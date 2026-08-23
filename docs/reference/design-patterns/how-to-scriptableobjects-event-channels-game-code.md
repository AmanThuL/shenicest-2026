---
title: "Use ScriptableObjects as event channels in game code"
page_title: "Use ScriptableObjects as Event Channels in Your Code"
source_url: "https://unity.com/how-to/scriptableobjects-event-channels-game-code"
final_url: "https://unity.com/how-to/scriptableobjects-event-channels-game-code"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Use ScriptableObjects as event channels in game code

How do you make disparate systems in your application work together? One common solution is to use an event to send messages between objects. Keep reading to learn how to use ScriptableObjects as event channels in your Unity project.

This is the fifth in a series of six mini-guides created to assist Unity developers with [the demo](https://github.com/UnityTechnologies/PaddleGameSO) that accompanies the e-book, [*Create modular game architecture in Unity with ScriptableObjects*](https://resources.unity.com/games/create-modular-game-architecture-with-scriptable-objects-ebook?ungated=true).

The demo is inspired by classic ball and paddle arcade game mechanics, and shows how ScriptableObjects can help you create components that are testable, scalable, and designer-friendly.

Together, the e-book, demo project, and these mini-guides provide best practices for using [programming design patterns](https://resources.unity.com/games/level-up-your-code-with-game-programming-patterns?ungated=true) with the ScriptableObject class in your Unity project. These tips can help you simplify your code, reduce memory usage, and promote code reusability.

This series includes the following articles:

-   [Get started with the Unity ScriptableObjects demo](https://unity.com/how-to/get-started-with-scriptableobjects-demo)
-   [Separate game data and logic with ScriptableObjects](https://unity.com/how-to/separate-game-data-logic-scriptable-objects)
-   [Use ScriptableObject-based enums in your Unity project](https://unity.com/how-to/scriptableobject-based-enums)
-   [Use ScriptableObjects as delegate objects](https://unity.com/how-to/scriptableobjects-delegate-objects)
-   [How to use a ScriptableObject-based runtime set](https://unity.com/how-to/scriptableobject-based-runtime-set)

Important note before you start

Loose coupling, high cohesion

Using events

Centralized events

Configuring event channels

Creating the event channel assets

Raising events

Listening for events

Adding a codeless listener

How event channels help

The function signature of a base event

Creating concrete event channels

Putting it all together

Debugging events

More ScriptableObject resources

## Important note before you start

Before you dive into the ScriptableObject demo project and this series of mini-guides, remember that, at their core, design patterns are just ideas. They won’t apply to every situation. These techniques can help you learn new ways to work with Unity and ScriptableObjects.

Each pattern has pros and cons. Choose only the ones that meaningfully benefit your specific project. Do your designers rely heavily on the Unity Editor? A ScriptableObject-based pattern could be a good choice to help them collaborate with your developers.

Ultimately, the best code architecture is the one that fits your project and team.

## Loose coupling, high cohesion

When building different modules or systems in an application, it’s often helpful to think of them as “islands of code.” Each module may have several components or GameObjects that work together for a common purpose.

For example, the player’s paddle may comprise a script that interprets player input, one that handles movement or collisions, and so forth. If these parts have interdependencies among themselves, you can use the Inspector to make those close connections.

However, keep in mind that every time you add a dependency to another object, it carries a small amount of risk. When possible, you’ll want to minimize those dependencies with external objects. Communication with things that are outside of your module or system won’t be so direct.

You could have the Paddle script refer to the Ball in your game, but that means they have a connection. Once they are joined by a dependency, making a change to one could potentially affect the other.

Ideally, you want to be able to modify part of the application without breaking anything else. The goal is to keep your modules internally cohesive but externally decoupled.

You can use the project’s **NullRefChecker** class to issue a polite warning when required references in the Inspector are missing. Simply call the static **Validate** method somewhere (e.g., in **Awake**) after each component has been set up or initialized.

Add the custom **Optional** attribute to ignore the check if the field can be left unset.

<a href="https://github.com/UnityTechnologies/PaddleGameSO" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download PaddleBallSO<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

## Using events

So, how do you get these disparate systems in your application to work together?

One solution is to use an event to send messages between objects. Events adhere to the broadcaster-listener model, which is visualized in the image above.

Here, the listening object subscribes to the event on the broadcaster, rather than calling a method or referencing a property directly.

Changes made to one component have less impact on the others. Things can still break when you modify the code, but the objects won’t be nearly as intertwined. The event in the middle works like a buffer between them.

We often describe objects in this broadcaster-listener relationship as loosely coupled.  
You can read more about events and the observer pattern in our technical e-book, *Level up your code with game programming patterns*.

<a href="https://resources.unity.com/games/level-up-your-code-with-game-programming-patterns?ungated=true" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download the e-book<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

A CENTRALIZED EVENT SYSTEM

## Centralized events

In the above scenario, the broadcaster is only responsible for sending out a signal. It doesn’t care which objects are listening.

However, the listener still needs to have some knowledge of the broadcaster in order to subscribe and unsubscribe to the delegate using OnEnable and OnDisable methods.

You can further decouple the broadcaster and listener by moving events into a static class. A general “game events” class can help insert an additional layer of abstraction between the two. This can connect the broadcaster and listener without them having direct knowledge of each other.

In this example, we’ll use a static **GameEvents** class for simplicity. However, in a real-world production scenario, it’s better to break it into smaller, specialized classes by function, such as UIEvents, GameStateEvents, HealthEvents, InventoryEvents, etc.

For example, you could create static events for quitting the application, showing a UI screen, or loading a scene. By making these events static, they can be accessed from any part of your application.

For example, you might create **GameEvents** as seen in the example below.

The static GameEvent sits in between the original broadcaster and listener as an intermediary. Modifications to either the receiver or sender have a reduced likelihood of impacting the other.

Consequently, updating code has fewer unexpected side effects. Storing your event definitions in a single location also makes them easier to manage.

While static GameEvents are effective, they may not be very accessible to your game designers. Because they are static, they must be defined within code and aren’t natively serializable in the Editor.

For a more Editor-friendly system, consider implementing events based on ScriptableObjects.

``` hljs
using UnityEngine;
using System;

public static class GameEvents

```

EVENT CHANNELS RELAY SIGNALS BETWEEN BROADCASTERS AND LISTENERS.

## Configuring event channels

ScriptableObject-based events offer a graphical alternative to static events. Though both serve similar functions, ScriptableObjects tend to be designer-friendly because they appear in the Inspector.

Since they relay a signal from a broadcaster to a listener, you can think of them as “event channels,” which are analogous to a transmission from a radio tower.

Any ScriptableObject with the following can function as an event channel:

-   **A delegate (like UnityAction or System.Action):** This notifies subscribers and passes data as parameters.  
-   **An event-raising method:** This public method invokes the delegate.

You can set up any number of event channels to determine various aspects of gameplay.

UnityAction and System.Action are both delegates. You can use one or both types in your project.

The UnityAction creates a more artist-friendly experience. Otherwise, use the System.Action delegate.

Below you’ll find an example of a **VoidEventChannelSO** from the project. This is a ScriptableObject-based event that doesn’t pass any parameters.

Here we use a UnityAction named **OnEventRaised** and expose a public **RaiseEvent**method.

<a href="https://github.com/UnityTechnologies/PaddleGameSO" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download PaddleBallSO<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

``` hljs
using UnityEngine;
using UnityEngine.Events;

[CreateAssetMenu(menuName = "Events/Void Event Channel", 
fileName = "VoidEventChannel")]
public class VoidEventChannelSO : DescriptionSO

}
```

CREATE EVENT CHANNELS IN THE PROJECT.

## Creating the event channel assets

Create the event channel asset in the project to use it. You can use the Create menu or duplicate an existing asset.

Rename each asset and use the description field to identify each ScriptableObject asset. Remember that each event channel exists as a project-level asset. You’ll reference these assets in your MonoBehaviours.

Though it’s optional, you can tag the ScriptableObject-based event channels with the \_SO suffix to differentiate them from other ScriptableObjects that carry data (which have the \_Data suffix).

Folders and naming conventions can help your project stay organized. You’ll want to customize these to your project’s needs. Read *Create a C# style guide* for more information.

<a href="https://resources.unity.com/games/create-code-style-guide-e-book?ungated=true" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download the guide<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

ASSIGN THE EVENT CHANNEL IN THE INSPECTOR.

## Raising events

Any object in your scene can now reference the event channel and call the event using the **RaiseEvent** method. For example, look at the sample MonoBehaviour with a **TriggerEvent** method below.

In the Inspector, the ScriptableObject asset needs to be assigned to the **m_EventChannel** field. When something invokes **TriggerEvent**, the event executes. Anything listening then gets a notification.

This mechanism adds much of the interactivity to your game application. Each module or system raises an event (e.g., the input system registers a key press, a ball collides with a wall, etc.). As a response, something else reacts to that.

``` hljs
public class EventRaiser: MonoBehaviour

}
```

THE GAMEMANAGER LISTENS TO CERTAIN EVENT CHANNELS AND BROADCASTS ON OTHERS.

## Listening for events

To set up a listener, a MonoBehaviour or other component will need to subscribe to the event channel’s **OnEventRaised** event. Typically this happens in**OnEnable**, like in the example below.

When the event channel raises an event, the HandleEvent method runs in response. This mechanism can be used for various purposes, like playing sounds or effects, modifying settings, etc., depending on the event’s context.

In the *PaddleBallSO* project, this is how we set up the main game loop. The GameManager listens to one set of event channels, then broadcasts on another. This allows different systems to send messages to one another without necessarily having direct dependencies.

Finally, unsubscribe from the **OnEventRaised** event in the **OnDisable** method to prevent errors or memory leaks.

<a href="https://github.com/UnityTechnologies/PaddleGameSO" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download PaddleBallSO<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

``` hljs
public class EventListener: MonoBehaviour

    private void OnDisable()
    
    private void HandleEvent()
    
}
```

CODELESS INTERACTIVITY SET UP IN THE INSPECTOR

## Adding a codeless listener

If you’re working with designers, you may want to provide them with a preconfigured general-purpose script that can listen to an event. This will enable them to create game interactions without a programmer.

The **VoidEventChannelListener** is an example of this. This component raises a UnityEvent when it receives a signal from an event channel. Simply add the VoidEventChannelListener to a GameObject, then set the event channel and UnityEvent logic.

A designer can then prototype event-driven logic just with a few settings in the Inspector.

For example, the **GameOverSounds** prefab listens for the **GameOver_SO** event channel. Once it receives this event, it plays back a sound on the given AudioSource via the **m_Response** UnityEvent.

The VoidEventChannelListener class also includes a useful delay to adjust the timing for each response.

With a little practice, this is a simple way to build interactions between your different systems and modules.

EVENT CHANNELS MARKED FOR SENDING AND RECEIVING

## How event channels help

Since they exist at the project level, event channels are globally accessible. This allows them to connect any object in the Scene Hierarchy and persist through scene loads.

Any object can act as a broadcaster or listener – it’s just a matter of how it interfaces with the event channel. This gives you a lot of flexibility in sending messages.

**Note**: It’s good practice to indicate in the Inspector whether the channel is for sending or receiving. Use the [HeaderAttribute](https://docs.unity3d.com/ScriptReference/HeaderAttribute.html) to do this.

A side benefit of using events at the project level is that they can often replace the need for a singleton. Event channels are globally available, so they can connect anything with anything. Let them drive in-game systems like cameras, quests, health, and achievements – all without creating unnecessary dependencies.

Additionally, because an event-based architecture executes only when needed, it’s more optimized than MonoBehaviour’s update methods.

## The function signature of a base event

This VoidEventChannelSO class only works for events that don’t need any parameters. Often, the raised event needs an additional payload of data to be meaningful.

For example, if you’re sending an event that applies damage in a health system, you may want to pass a value for the target, how much damage to send, what type of damage, etc.

You can change the function signature of your base event to make the event channel more suitable for that. The project defines a GenericEventChannelSO for that purpose. Have a look at the example below.

This is an abstract class with a single generic parameter. You’ll derive other event channels from it. These can then pass a single parameter, such as a float, int, or bool.

Like the VoidEventChannelSO, the GenericEventChannelSO features a UnityAction called OnEventRaised. However, this time the action carries a parameter of type T.

External objects will invoke the corresponding public RaiseEvent method. If the event has listeners, then it executes while passing a given parameter.

<a href="https://github.com/UnityTechnologies/PaddleGameSO" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download PaddleBallSO<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

``` hljs
public abstract class GenericEventChannelSO<T>: DescriptionSO

}
```

## Creating concrete event channels

Now you just need to derive concrete event channels from GenericEventChannelSO and fill in the value for T.

Aside from the usual CreateAssetMenu attribute, there’s no need for any explicit implementation details.

Creating an event channel that carries a float, **FloatEventChannelSO**, is straightforward. Have a look at the code example below.

It’s that simple! Use this workflow to create additional ones for BoolEventChannelSO, IntEventChannelSO, etc.

If you require more than one parameter as a payload, define additional generic classes (e.g., GenericEventChannelSO\<T,U>, GenericEventChannelSO\<T,U,V>, etc.) as needed.

``` hljs
[CreateAssetMenu(menuName = "Events/Float EventChannel", fileName = "FloatEventChannel")]
public class FloatEventChannelSO : GenericEventChannelSO<float> 
```

SEQUENCE OF EVENTS WHEN THE BALL HITS A SCOREGOAL

## Putting it all together

The idea is to break the application into smaller, more modular parts. Establishing clear boundaries around them keeps those parts from intertwining themselves with dependencies and helps ward off spaghetti code.

Components that lack direct knowledge of outside objects can’t manipulate something they’re not supposed to. Instead, they are forced to send and receive messages through event channels.

You can see how this works if you trace a small sequence of the paddle ball gameplay. For example, let’s imagine what happens when a Ball collides with a ScoreGoal:

The **ScoreGoal** component registers a collision. After detecting the Ball, it raises an event on the **GoalHit_SO** event channel. This passes the Player ID of the scoring player.  

The event channel notifies the **GameManager**, which in response raises another event channel called **PointsScored_SO**. This also passes the Player ID.  

This channel notifies the **ScoreManager**, which increments the score (stored in a separate object) and updates the UI components. Then, it passes both player scores via the **ScoreManagerUpdated_SO** event channel.  

As a response, the **ScoreObjective_SO** objective checks if one player has reached the target score.  

If a win condition is reached, the game ends. Otherwise, the GameManager resets the round and the ball goes back into play.

At first glance, it may seem like a lot of extra work to increment a score value by one point. However, the intention is to isolate all of the pieces involved: The Ball, the ScoreManager, GameManager, the ObjectiveManager, etc.

Every part of the application has a certain autonomy, and that makes each one easier to test. Adding new systems doesn’t need to disrupt the existing logic. In fact, the original gameplay can be completely oblivious to them.

Imagine that you wanted to add secondary effects such as sounds and animations to accompany the scoring process. You could create new components that listen to the right events and respond appropriately. The underlying logic and game flow can remain undisturbed, even as you add the new systems.

Remember that the mantra in [SOLID programming](https://en.wikipedia.org/wiki/SOLID) is “open for extension, closed for modification.” You want the ability to add new functionality to your software without having to change the existing code. Using event channels like this provides scalability.

EDITOR SCRIPTING CAN HELP DEBUG EVENTS.

## Debugging events

Event-driven architecture facilitates debugging and maintenance. Smaller parts are easier to test, whether you are writing automated unit tests with the [Unity Test Framework](https://docs.unity3d.com/Packages/com.unity.test-framework@1.1/manual/index.html) or just informally troubleshooting. This enables you to focus on a specific issue and test in isolation.

Custom Editor scripting can assist here. *PaddleBallSO* demos a few tools that help trace the flow of your application when using event channels:

-   Most event channels in the *PaddleBallSO* project show a list of listeners in the Inspector. Click each listener’s name to highlight it in the Hierarchy.
-   A custom **RaiseEvent** button can invoke a mock event at will (using the default value of T if carrying a payload). While the application is running, just trigger it manually with a single click.

When troubleshooting event channels, select the ScriptableObject asset. Test the event manually as needed. The Inspector can guide you through the objects that might be listening. Select the listeners you want to inspect in more detail.

If you’ve labeled the event channels with the HeaderAttritute, you can trace back several events to understand the flow of logic.

<a href="https://github.com/UnityTechnologies/PaddleGameSO" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download PaddleBallSO<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>

## More ScriptableObject resources

We hope that event channels and event-driven architecture can benefit your new and upcoming projects.

Read more about design patterns with ScriptableObjects in our technical e-book, [*Create modular game architecture in Unity with ScriptableObjects*](https://resources.unity.com/games/create-modular-game-architecture-with-scriptable-objects-ebook?ungated=true). You can also find out more about common Unity development design patterns in [*Level up your code with game programming patterns*](https://resources.unity.com/games/level-up-your-code-with-game-programming-patterns?ungated=true).
