---
title: "Fixing Performance Problems (Unity Learn)"
page_title: "Fixing Performance Problems - 2019.3"
source_url: "https://learn.unity.com/tutorial/fixing-performance-problems-2019-3"
final_url: "https://learn.unity.com/tutorial/fixing-performance-problems-2019-3"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Fixing Performance Problems - 2019.3

![](https://learn.unity.com/_next/static/media/tutorial-coverImage-bg.8fcd34a7.jpeg)

# Fixing Performance Problems - 2019.3

Tutorial

intermediate

+10XP

1h

476

\(207\)

Unity Technologies

![Fixing Performance Problems - 2019.3](https://connect-mediagw.unity.com/h1/20200402/learn/images/276dc309-e616-4ff4-a4c8-d119bd7cd4a6_b2cdd955_44bb_413a_b2d3_a498be6b5dbe_Transitioning.png)

Summary

Once you've discovered a performance problem in your game, how should you go about fixing it? This tutorial discusses some common issues and optimization techniques for scripts, garbage collection, and graphics rendering.

Languages available:

EnglishEnglish

<span id="react-aria-«R1ahmpmH7»">English</span><span class="pl-2"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 1. Optimizing scripts in Unity games

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Verified in 2019.3 - <a href="https://learn.unity.com/tutorial/fixing-performance-problems-2019-3" class="link-primary text-inherit"><span style="text-decoration:underline">https://learn.unity.com/tutorial/fixing-performance-problems-2019-3</span></a>

When our game runs, the <a href="https://en.wikipedia.org/wiki/Central_processing_unit" class="link-primary text-inherit"><em>central processing unit (CPU)</em></a> of our device carries out instructions. Every single frame of our game requires many millions of these CPU instructions to be carried out. To maintain a smooth frame rate, the CPU must carry out its instructions within a set amount of time. When the CPU cannot carry out all of its instructions in time, our game may slow down, stutter or freeze.

Many things can cause the CPU to have too much work to do. Examples could include demanding rendering code, overly complex physics simulations or too many animation callbacks. This article focuses on only one of these reasons: CPU performance problems caused by the code that we write in our scripts.

In this article, we will learn how our scripts are turned into CPU instructions, what can cause our scripts to generate an excessive amount of work for the CPU, and how to fix performance problems that are caused by the code in our scripts.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 2. Diagnosing problems with our code

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Performance problems caused by excessive demands on the CPU can manifest as low frame rates, jerky performance or intermittent freezes. However, other problems can cause similar symptoms. If our game has performance problems like this, the first thing we must do is to use Unity’s Profiler window to establish whether our performance problems are due to the CPU being unable to complete its tasks in time. Once we have established this, we must determine whether user scripts are the cause of the problem, or whether the problem is caused by some other part of our game: complex physics or animations, for example.

To learn how to use Unity's Profiler window to find the cause of performance problems, please follow the <a href="https://learn.unity.com/tutorial/diagnosing-performance-problems-2019-3" class="link-primary text-inherit">Diagnosing Performance Problems tutorial</a>.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 3. A brief introduction to how Unity builds and runs our game

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

To understand why our code may not be performing well, we first need to understand what happens when Unity builds our game. Knowing what's going on behind the scenes will help us to make informed decisions about how we can improve our game's performance.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 4. The build process

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

When we build our game, Unity packages everything needed to run our game into a program that can be executed by our target device. CPUs can only run code written in very simple languages known as <a href="https://en.wikipedia.org/wiki/Machine_code" class="link-primary text-inherit"><strong><em>machine code</em></strong></a> or *native code*; they cannot run code written in more complex languages like C#. This means that Unity must translate our code into other languages. This translation process is called *compiling*.

Unity first compiles our scripts into a language called <a href="https://en.wikipedia.org/wiki/Common_Intermediate_Language" class="link-primary text-inherit"><strong><em>Common Intermediate Language (CIL)</em></strong></a>. CIL is a language that is easy to compile into a wide range of different native code languages. The CIL is then compiled to native code for our specific target device. This second step happens either when we build our game (known as <a href="https://en.wikipedia.org/wiki/Ahead-of-time_compilation" class="link-primary text-inherit"><strong><em>ahead of time compilation</em></strong></a> or AOT compilation), or on the target device itself, just before the code is run (known as <a href="https://en.wikipedia.org/wiki/Just-in-time_compilation" class="link-primary text-inherit"><strong><em>just in time compilation</em></strong></a> or JIT compilation). Whether our game uses AOT or JIT compilation usually depends on the target hardware.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 5. The relationship between the code we write and compiled code

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Code that has not been compiled yet is known as <a href="https://en.wikipedia.org/wiki/Source_code" class="link-primary text-inherit"><strong><em>source code</em></strong></a>. The source code that we write determines the structure and content of the compiled code.

For the most part, source code that is well structured and efficient will result in compiled code that is well structured and efficient. However, it's useful for us to know a little about native code so that we can better understand why some source code is compiled into a more efficient native code.

Firstly, some CPU instructions take more time to execute than others. An example of this is calculating a square root. This calculation takes a CPU more time to execute than, for example, multiplying two numbers. The difference between a single fast CPU instruction and a single slow CPU instruction is very small indeed, but it's useful for us to understand that, fundamentally, some instructions are simply faster than others.

The next thing we need to understand is that some operations that seem very simple in source code can be surprisingly complex when they are compiled to machine code. An example of this is inserting an element into a list. Many more instructions are needed to perform this operation than, for example, accessing an element from an array by index. Again, when we consider an individual example we are talking about a tiny amount of time, but it is important to understand that some operations result in more instructions than others.

Understanding these ideas will help us to understand why some code performs better than other codes, even when both examples do quite similar things. Even a limited background understanding of how things work at a low level can help us to write games that perform well.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 6. Run time communication between Unity Engine code and our script code

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

It's useful for us to understand that our scripts written in C# run in a slightly different way to the code that makes up much of the Unity Engine. Most of the core functionality of the Unity Engine is written in C++ and has already been compiled to native code. This compiled engine code is part of what we install when we install Unity.

Code compiled to CIL, such as our source code, is known as *managed code*. When managed code is compiled to native code, it is integrated with something called the *managed runtime*. The managed runtime takes care of things like automatic memory management and safety checks to ensure that a bug in our code will result in an exception rather than the device crashing.

When the CPU transitions between running engine code and managed code, work must be done to set up these safety checks. When passing data from managed code back to the engine code, the CPU may need to do work to convert the data from the format used by the managed runtime to the format needed by the engine code. This conversion is known as *marshaling*. Again, the overhead from any single call between managed and engine code is not particularly expensive, but it is important that we understand that this cost exists.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 7. The causes of poorly-performing code

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Now that we understand what happens to our code when Unity builds and runs our game we can understand that when our code performs poorly, it is because it creates too much work for the CPU at run time. Let's consider the different reasons for this.

The first possibility is that our code is simply wasteful or poorly structured. An example of this might be code that makes the same function call repeatedly when it could make the call only once. This article will cover several common examples of poor structure and show example solutions.

The second possibility is that our code appears to be well structured, but makes unnecessarily expensive calls to other code. An example of this might be code that results in unnecessary calls between managed and engine code. This article will give examples of Unity API calls that may be unexpectedly costly, with suggested alternatives that are more efficient.

The next possibility is that our code is efficient but it is being called when it does not need to be. An example of this might be code that simulates an enemy's line of sight. The code itself may perform well, but it is wasteful to run this code when the player is very far from the enemy. This article contains examples of techniques that can help us to write code that runs only when it needs to.

The final possibility is that our code is simply too demanding. An example of this might be a very detailed simulation where a large number of agents are using complex AI. If we have exhausted other possibilities and optimized this code as much as we can, then we may simply need to redesign our game to make it less demanding: for example, faking elements of our simulation rather than calculating them. Implementing this kind of optimization is beyond the scope of this article as it is extremely dependent on the game itself, but it will still benefit us to read the article and consider how to make our game as performant as possible.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 8. Improving the performance of our code

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Once we have established that performance problems in our game are due to our code, we must think carefully about how to resolve these problems. Optimizing a demanding function may seem like a good place to start, but it may be that the function in question is already as optimal as it can be and is simply expensive by nature. Instead of changing that function, there may be a small efficiency saving we can make in a script that is used by hundreds of GameObjects that gives us a much more useful performance increase. Furthermore, improving the CPU performance of our code may come at a cost: changes may increase memory usage or offload work to the GPU.

For these reasons, this article isn’t a set of simple steps to follow. This article is instead a series of suggestions for improving our code's performance, with examples of situations where these suggestions can be applied. As with all performance optimization, there are no hard and fast rules. The most important thing to do is to profile our game, understand the nature of the problem, experiment with different solutions and measure the results of our changes.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 9. Writing efficient code

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Writing efficient code and structuring it wisely can lead to improvements in our game's performance. While the examples shown are in the context of a Unity game, these general best-practice suggestions are not specific to Unity projects or Unity API calls.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 10. Move code out of loops when possible

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Loops are a commonplace for inefficiencies to occur, especially when they are nested. Inefficiencies can really add up if they are in a loop that runs very frequently, especially if this code is found on many GameObjects in our game.

In the following simple example, our code iterates through the loop every time *Update()* is called, regardless of whether the condition is met.

```
void Update()

}
}
```

With a simple change, the code iterates through the loop only if the condition is met.

```
void Update()

   }
}
```

This is a simplified example but it illustrates a real saving that we can make. We should examine our code for places where we have structured our loops poorly.

Consider whether the code must run every frame**.** *Update()* is a function that is run once per frame by Unity. *Update()* is a convenient place to put code that needs to be called frequently or code that must respond to frequent changes. However, not all of this code needs to run every single frame. Moving code out of *Update()* so that it runs only when it needs to can be a good way to improve performance.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 11. Only run code when things change

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Let’s look at a very simple example of optimizing code so that it only runs when things change. In the following code, *DisplayScore()* is called in *Update()*. However, the value of the *score* may not change with every frame. This means that we are needlessly calling *DisplayScore()*.

```
Private int score;

public void IncrementScore(int incrementBy)

void Update()

```

With a simple change, we now ensure that *DisplayScore()* is called only when the value of the *score* has changed.

```
Private int score;

public void IncrementScore(int incrementBy)

```

Again, the above example is deliberately simplified but the principle is clear. If we apply this approach throughout our code we may be able to save CPU resources.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 12. Run code every \[x\] frames

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

If code needs to run frequently and cannot be triggered by an event, that doesn't mean it needs to run every frame. In these cases, we can choose to run code every \[x\] frames.

In this example code, an expensive function runs once per frame.

```
void Update()

```

In fact, it would be sufficient for our needs to run this code once every 3 frames. In the following code, we use the modulus operator to ensure that the expensive function runs only on every third frame.

```
void Update()

}
```

An additional benefit of this technique is that it's very easy to spread costly code out across separate frames, avoiding spikes. In the following example, each of the functions is called once every 3 frames and never on the same frame.

```
private int interval = 3;

void Update()

else if(Time.frameCount % 1 == 1)

}
```

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 13. Use caching

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

If our code repeatedly calls expensive functions that return a result and then discards those results, this may be an opportunity for optimization. Storing and reusing references to these results can be more efficient. This technique is known as *caching*.

In Unity, it is common to call *GetComponent()* to access components. In the following example, we call *GetComponent()* in *Update()* to access a Renderer component before passing it to another function. This code works, but it is inefficient due to the repeated *GetComponent()* call.

```
void Update()

```

The following code calls *GetComponent()* only once, as the result of the function is cached. The cached result can be reused in *Update()* without any further calls to *GetComponent()*.

```
private Renderer myRenderer;

void Start()

void Update()

```

We should examine our code for cases where we make frequent calls to functions that return a result. It is possible that we could reduce the cost of these calls by using caching.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 14. Use the right data structure

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

How we structure our data can have a big impact on how our code performs. There is no single data structure that is ideal for all situations, so to get the best performance in our game we need to use the right data structure for each job.

To make the right decision about which data structure to use, we need to understand the strengths and weaknesses of different data structures and think carefully about what we want our code to do. We may have thousands of elements that we need to iterate over once per frame, or we may have a small number of elements that we need to frequently add to and remove from. These different problems will be best solved by different data structures.

Making the right decisions here depends on our knowledge of the subject. The best place to start, if this is a new area of knowledge, is to learn about <a href="https://en.wikipedia.org/wiki/Big_O_notation" class="link-primary text-inherit"><em>Big O Notation</em></a>. Big O Notation is how algorithmic complexity is discussed, and understanding this will help us to compare different data structures. <a href="https://rob-bell.net/2009/06/a-beginners-guide-to-big-o-notation/" class="link-primary text-inherit">This article</a> is a clear and beginner-friendly guide to the subject. We can then learn more about the data structures available to us, and compare them to find the right data solutions for different problems. <a href="https://msdn.microsoft.com/en-us/library/7y3x785f" class="link-primary text-inherit">This MSDN guide to collections and data structures in C#</a> gives general guidance on choosing appropriate data structures and provides links to more in-depth documentation.

A single choice about data structures is unlikely to have a large impact on our game. However, in a data-driven game that involves a great many of such collections, the results of these choices can really add up. An understanding of algorithmic complexity and the strengths and weaknesses of different data structures will help us to create code that performs well.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 15. Minimize the impact of garbage collection

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

*Garbage collection* is an operation that occurs as part of how Unity manages memory. The way that our code uses memory determines the frequency and CPU cost of garbage collection, so it's important that we understand how garbage collection works.

In the next step, we'll cover the topic of garbage collection in-depth, and provide several different strategies for minimizing its impact.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 16. Use object pooling

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

It's usually more costly to instantiate and destroy an object than it is to deactivate and reactivate it. This is especially true if the object contains startup code, such as calls to *GetComponent()* in an *Awake()* or *Start()* function. If we need to spawn and dispose of many copies of the same object, such as bullets in a shooting game, then we may benefit from <a href="https://en.wikipedia.org/wiki/Object_pool_pattern" class="link-primary text-inherit"><strong><em>object pooling</em></strong></a>.

Object pooling is a technique where, instead of creating and destroying instances of an object, objects are temporarily deactivated and then recycled and reactivated as needed. Although well known as a technique for managing memory usage, object pooling can also be useful as a technique for reducing excessive CPU usage.

A full guide to object pooling is beyond the scope of this article, but it's a really useful technique and one worth learning. <a href="https://learn.unity.com/tutorial/5c514cacedbc2a0020694a0a#5c7f8528edbc2a002053b628" class="link-primary text-inherit"></a> Check out <a href="https://docs.unity3d.com/ScriptReference/Pool.ObjectPool_1.html" class="link-primary text-inherit">this documentation page on <strong>Object Pooling</strong></a> for more information.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 17. Avoiding expensive calls to the Unity API

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Sometimes the calls our code makes to other functions or APIs can be unexpectedly costly. There could be many reasons for this. What looks like a variable could in fact be an <a href="https://msdn.microsoft.com/en-us/data/aa287786(v=vs.85)" class="link-primary text-inherit"><em>accessor</em></a>*.* that contains additional code, triggers an event or makes a call from managed code to engine code.

In this section, we will look at a few examples of Unity API calls that are more costly than they may appear. We will consider how we might reduce or avoid these costs. These examples demonstrate different underlying causes for the cost, and the suggested solutions can be applied to other similar situations.

It's important to understand that there is no list of Unity API calls that we should avoid. Every API call can be useful in some situations and less useful in others. In all cases, we must profile our game carefully, identify the cause of costly code and think carefully about how to resolve the problem in a way that's best for our game.

#### SendMessage()

*SendMessage()* and *BroadcastMessage()* are very flexible functions that require little knowledge of how a project is structured and are very quick to implement. As such, these functions are very useful for prototyping or for beginner-level scripting. However, they are extremely expensive to use. This is because these functions make use of <a href="https://en.wikipedia.org/wiki/Reflection_(computer_programming)" class="link-primary text-inherit"><strong><em>reflection</em></strong></a>. Reflection is the term for when code examines and makes decisions about itself at run time rather than at compile time. Code that uses reflection results in far more work for the CPU than code that does not use reflection.

It is recommended that *SendMessage()* and *BroadcastMessage()* are used only for prototyping and that other functions are used wherever possible. For example, if we know which component we want to call a function on, we should reference the component directly and call the function that way. If we do not know which component we wish to call a function on, we could consider using <a href="https://learn.unity.com/tutorial/events-uh" class="link-primary text-inherit"><strong><em>Events</em></strong></a> or <a href="https://learn.unity.com/tutorial/delegates" class="link-primary text-inherit"><strong><em>Delegates</em></strong></a>.

#### Find()

*Find()* and related functions are powerful but expensive. These functions require Unity to iterate over every GameObject and Component in memory. This means that they are not particularly demanding in small, simple projects but become more expensive to use as the complexity of a project grows.

It's best to use *Find()* and similar functions infrequently and to cache the results where possible. Some simple techniques that may help us to reduce the use of *Find()* in our code include setting references to objects using the Inspector panel where possible or creating scripts that manage references to things that are commonly searched for.

#### Transform

Setting the position or rotation of a transform causes an internal *OnTransformChanged* event to propagate to all of that transform's children. This means that it's relatively expensive to set a transform's position and rotation values, especially in transforms that have many children.

To limit the number of these internal events, we should avoid setting the value of these properties more often than necessary. For example, we might perform one calculation to set a transform's *x* position and then another to set its *z* position in *Update()*. In this example, we should consider copying the transform's position to a Vector3, performing the required calculations on that Vector3 and then setting the transform's position to the value of that Vector3. This would result in only one *OnTransformChanged* event.

*Transform.position* is an example of an accessor that results in a calculation behind the scenes. This can be contrasted with *Transform.localPosition*. The value of *localPosition* is stored in the transform and calling *Transform.localPosition* simply returns this value. However, the transform's world position is calculated every time we call *Transform.position*.

If our code makes frequent use of *Transform.position* and we can use *Transform.localPosition* in its place, this will result in fewer CPU instructions and may ultimately benefit performance. If we make frequent use *Transform.position*, we should cache it where possible.

#### Update()

*Update()*, *LateUpdate()* and other <a href="https://docs.unity3d.com/Manual/EventFunctions.html" class="link-primary text-inherit"><em>event functions</em></a> look like simple functions, but they have a hidden overhead. These functions require communication between engine code and managed code every time they are called. In addition to this, Unity carries out a number of safety checks before calling these functions. The safety checks ensure that the GameObject is in a valid state, hasn't been destroyed, and so on. This overhead is not particularly large for any single call, but it can add up in a game that has thousands of MonoBehaviours.

For this reason, empty *Update()* calls can be particularly wasteful. We may assume that because the function is empty and our code contains no direct calls to it, the empty function will not run. This is not the case: behind the scenes, these safety checks and native calls still happen even when the body of the *Update()* function is blank. To avoid wasted CPU time, we should ensure that our game does not contain empty *Update()* calls.

If our game has a great many active MonoBehaviours with *Update()* calls, we may benefit from structuring our code differently to reduce this overhead. <a href="http://blogs.unity3d.com/2015/12/23/1k-update-calls/" class="link-primary text-inherit">This Unity blog post</a> on this subject goes into much more detail on this topic.

#### Vector2 and Vector3

We know that some operations simply result in more CPU instructions than other operations. Vector math operations are an example of this: they are simply more complex than float or int math operations. Although the actual difference in the time taken for two such calculations is tiny, at sufficient scale such operations can impact performance.

It's common and convenient to use Unity's <a href="https://docs.unity3d.com/ScriptReference/Vector2.html" class="link-primary text-inherit"><strong><em>Vector2</em></strong></a> and <a href="https://docs.unity3d.com/ScriptReference/Vector3.html" class="link-primary text-inherit"><strong><em>Vector3</em></strong></a> structs for mathematical operations, especially when dealing with transforms. If we perform many frequent Vector2 and Vector3 math operations in our code, for example in nested loops in *Update()* on a great many GameObjects, we may well be creating unnecessary work for the CPU. In these cases, we may be able to make a performance saving by performing int or float calculations instead.

Earlier in this article, we learned that the CPU instructions required to perform a square root calculation are slower than those used for, say, simple multiplication. Both <a href="https://docs.unity3d.com/ScriptReference/Vector2-magnitude.html" class="link-primary text-inherit">Vector2.magnitude</a> and <a href="https://docs.unity3d.com/ScriptReference/Vector3-magnitude.html" class="link-primary text-inherit">Vector3.magnitude</a> are examples of this, as they both involve square root calculations. Additionally, <a href="https://docs.unity3d.com/ScriptReference/Vector2.Distance.html" class="link-primary text-inherit">Vector2.Distance</a> and <a href="https://docs.unity3d.com/ScriptReference/Vector3.Distance.html" class="link-primary text-inherit">Vector3.Distance</a> use *magnitude* behind the scenes.

If our game makes extensive and very frequent use of *magnitude* or *Distance*, it may be possible for us to avoid the relatively expensive square root calculation by using <a href="https://docs.unity3d.com/ScriptReference/Vector2-sqrMagnitude.html" class="link-primary text-inherit">Vector2.sqrMagnitude</a> and <a href="https://docs.unity3d.com/ScriptReference/Vector3-sqrMagnitude.html" class="link-primary text-inherit">Vector3.sqrMagnitude</a> instead. Again, replacing a single call will result in only a tiny difference, but at a sufficiently large scale, it may be possible to make a useful performance saving.

#### Camera.main

<a href="http://docs.unity3d.com/ScriptReference/Camera-main.html" class="link-primary text-inherit"><em>Camera.main</em></a> is a convenient Unity API call that returns a reference to the first enabled Camera component that is tagged with "Main Camera". This is another example of something that looks like a variable but is in fact an accessory. In this case, the accessor calls an internal function similar to *Find()* behind the scenes. *Camera.main*, therefore, suffers from the same problem as *Find()*: it searches through all GameObjects and Components in memory and can be very expensive to use.

To avoid this potentially expensive call, we should either cache the result of *Camera.main* or avoid its use altogether and manually manage references to our cameras.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 18. Other Unity API calls and further optimizations

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

We have considered a few common examples of Unity API calls that may be unexpectedly costly and learned about the different reasons behind this cost. However, this is by no means an exhaustive list of ways to improve the efficiency of our Unity API calls.

<a href="https://docs.unity3d.com/Manual/BestPracticeUnderstandingPerformanceInUnity.html" class="link-primary text-inherit">This article on performance in Unity</a> is a wide-ranging guide to optimization in Unity that contains a number of other Unity API optimizations that we may find useful. Additionally, that article goes into considerable depth about further optimizations that are beyond the scope of this relatively high-level and beginner-friendly article.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 19. Running code only when it needs to run

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

There’s a saying in programming: "the fastest code is the code that doesn’t run". Often, the most efficient way to solve a performance problem is not to use an advanced technique: it is simply to remove code that doesn’t need to be there in the first place. Let’s look at a couple of examples to see where we could make this sort of saving.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 20. Culling

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Unity contains code that checks whether objects are within the frustum of a camera. If they are not within the frustum of a camera, code related to rendering these objects does not run. The term for this is *frustum culling*.

We can take a similar approach to the code in our scripts. If we have a code that relates to the visual state of an object, we may not need to execute this code when the object cannot be seen by the player. In a complex Scene with many objects, this can result in considerable performance savings.

In the following simplified example code, we have an example of a patrolling enemy. Every time *Update()* is called, the script controlling this enemy calls two example functions: one related to moving the enemy, one related to its visual state.

```
void Update()

```

In the following code, we now check whether the enemy's renderer is within the frustum of any camera. The code related to the enemy's visual state runs only if the enemy is visible.

```
private Renderer myRenderer;

void Start()

void Update()

}
```

Disabling code when things are not seen by the player can be achieved in a few ways. If we know that certain objects in our scene are not visible at a particular point in the game, we can manually disable them. When we are less certain and need to calculate visibility, we could use a coarse calculation (for example, checking if the object behind the player), functions such as *OnBecameInvisible()* and *OnBecameVisible()*, or a more detailed raycast. The best implementation depends very much on our game, and experimentation and profiling are essential.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 21. Level of detail

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

*Level of detail*, also known as *LOD*, is another common rendering optimization technique. Objects nearest to the player are rendered at full fidelity using detailed meshes and textures. Distant objects use less detailed meshes and textures. A similar approach can be used with our code. For example, we may have an enemy with an AI script that determines its behavior. Part of this behavior may involve costly operations for determining what it can see and hear, and how it should react to this input. We could use a level of detail system to enable and disable these expensive operations based on the enemy's distance from the player. In a Scene with many of these enemies, we could make a considerable performance saving if only the nearest enemies are performing the most expensive operations.

Unity's <a href="https://docs.unity3d.com/Manual/CullingGroupAPI.html" class="link-primary text-inherit">CullingGroup</a> API allows us to hook into Unity's LOD system to optimize our code. The Manual page for the CullingGroup API contains several examples of how this might be used in our game. As ever, we should test, profile and find the right solution for our game.

We’ve learned what happens to the code we write when our Unity game is built and run, why our code can cause performance problems and how to minimize the impact of expensiveness on our game. We've learned about a number of common causes of performance problems in our code, and considered a few different solutions. Using this knowledge and our profiling tools, we should now be able to diagnose, understand and fix performance problems related to the code in our game.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 22. Optimizing garbage collection in Unity games

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

When our game runs, it uses memory to store data. When this data is no longer needed, the memory that stored that data is freed up so that it can be reused. ***Garbage*** is the term for memory that has been set aside to store data but is no longer in use. *Garbage collection* is the name of the process that makes that memory available again for reuse.

Unity uses garbage collection as part of how it manages memory. Our game may perform poorly if garbage collection happens too often or has too much work to do, which means that garbage collection is a common cause of performance problems.

In this article, we’ll learn how garbage collection works, when garbage collection happens and how to use memory efficiently so that we minimize the impact of garbage collection on our game.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 23. Diagnosing problems with garbage collection

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Performance problems caused by garbage collection can manifest as low frame rates, jerky performance or intermittent freezes. However, other problems can cause similar symptoms. If our game has performance problems like this, the first thing we should do is to use Unity’s Profiler window to establish whether the problems we are seeing are actually due to garbage collection.

To learn how to use the Profiler window to find the cause of your performance problems, please follow <a href="https://learn.unity.com/tutorial/diagnosing-performance-problems-2019-3" class="link-primary text-inherit">this tutorial</a>.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 24. A brief introduction to memory management in Unity

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

To understand how garbage collection works and when it happens, we must first understand how memory usage works in Unity. Firstly, we must understand that Unity uses different approaches when running its own core engine code and when running the code that we write in our scripts.

The way Unity manages memory when running its own core Unity Engine code is called <a href="https://en.wikipedia.org/wiki/Manual_memory_management" class="link-primary text-inherit"><em>manual memory management</em></a>. This means that the core engine code must explicitly state how memory is used. Manual memory management does not use garbage collection and won't be covered further in this article.

The way that Unity manages memory when running our code is called <a href="https://docs.unity3d.com/Manual/UnderstandingAutomaticMemoryManagement.html" class="link-primary text-inherit"><em>automatic memory management</em></a>. This means that our code doesn’t need to explicitly tell Unity how to manage memory in a detailed way. Unity takes care of this for us.

At its most basic level, automatic memory management in Unity works like this:

1\. Unity has access to two pools of memory: the *stack* and the *heap* (also known as the *managed heap*. The stack is used for short term storage of small pieces of data, and the heap is used for long term storage and larger pieces of data.

2\. When a variable is created, Unity requests a block of memory from either the stack or the heap.

3\. As long as the variable is <a href="https://learn.unity.com/tutorial/scope-and-access-modifiers" class="link-primary text-inherit">in scope</a> (still accessible by our code), the memory assigned to it remains in use. We say that this memory has been *allocated*. We describe a variable held in stack memory as an *object on the stack* and a variable held in heap memory as an *object on the heap*.

4\. When the variable goes out of scope, the memory is no longer needed and can be returned to the pool that it came from. When memory is returned to its pool, we say that the memory has been *deallocated*. The memory from the stack is deallocated as soon as the variable it refers to goes out of scope. The memory from the heap, however, is not deallocated at this point and remains in an allocated state even though the variable it refers to is out of scope.

5\. The *garbage collector* identifies and deallocates unused heap memory. The garbage collector is run periodically to clean up the heap.

Now that we understand the flow of events, let’s take a closer look at how to stack allocations and deallocations that differ from heap allocations and deallocations.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 25. What happens during stack allocation and deallocation?

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Stack allocations and deallocations are quick and simple. This is because the stack is only used to store small data for short amounts of time. Allocations and deallocations always happen in a predictable order and are of a predictable size.

The stack works like a <a href="https://en.wikipedia.org/wiki/Stack_(abstract_data_type" class="link-primary text-inherit">stack data type</a>: it is a simple collection of elements, in this case, blocks of memory, where elements can only be added and removed in a strict order. This simplicity and strictness are what makes it so quick: when a variable is stored on the stack, memory for it is simply allocated from the "end" of the stack. When a stack variable goes out of scope, the memory used to store that variable is immediately returned to the stack for reuse.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 26. What happens during a heap allocation?

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

A heap allocation is much more complex than stack allocation. This is because the heap can be used to store both long term and short term data, and data of many different types and sizes. Allocations and deallocations don’t always happen in a predictable order and may require very different sized blocks of memory.

When a heap variable is created, the following steps take place:

1\. Unity must check if there is enough free memory in the heap. If there is enough free memory in the heap, the memory for the variable is allocated.

2\. If there is not enough free memory in the heap, Unity triggers the garbage collector in an attempt to free up unused heap memory. This can be a slow operation. If there is now enough free memory in the heap, the memory for the variable is allocated.

3\. If there isn’t enough free memory in the heap after garbage collection, Unity increases the amount of memory in the heap. This can be a slow operation. The memory for the variable is then allocated.

Heap allocations can be slow, especially if the garbage collector must run and the heap must be expanded.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 27. What happens during garbage collection?

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

When a heap variable goes out of scope, the memory used to store it is not immediately deallocated. Unused heap memory is only deallocated when the garbage collector runs.

Every time the garbage collector runs, the following steps occur:

1\. The garbage collector examines every object on the heap.

2\. The garbage collector searches all current object references to determine if the objects on the heap are still in scope.

3\. Any object which is no longer in scope is flagged for deletion.

4\. Flagged objects are deleted and the memory that was allocated to them is returned to the heap.

Garbage collection can be an expensive operation. The more objects on the heap, the more work it must do and the more object references in our code, the more work it must do.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 28. When does garbage collection happen?

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Three things can cause the garbage collector to run:

1\. The garbage collector runs whenever a heap allocation is requested that cannot be fulfilled using free memory from the heap.

2\. The garbage collector runs automatically from time to time (although the frequency varies by platform).

3\. The garbage collector can be forced to run manually.

Garbage collection can be a frequent operation. The garbage collector is triggered whenever a heap allocation cannot be fulfilled from available heap memory, which means that frequent heap allocations and deallocations can lead to frequent garbage collection.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 29. Problems with garbage collection

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Now that we understand the role that garbage collection plays in memory management in Unity, we can consider the types of problems that might occur.

The most obvious problem is that the garbage collector can take a considerable amount of time to run. If the garbage collector has a lot of objects on the heap and/or a lot of object references to examine, the process of examining all of these objects can be slow. This can cause our game to stutter or run slowly.

Another problem is that the garbage collector may run at inconvenient times. If the CPU is already working hard in a performance-critical part of our game, even a small amount of additional overhead from garbage collection can cause our frame rate to drop and performance to noticeably change.

Another problem that is less obvious is *heap fragmentation*. When memory is allocated from the heap it is taken from the free space in blocks of different sizes depending on the size of data that must be stored. When these blocks of memory are returned to the heap, the heap can get split up into lots of small free blocks separated by allocated blocks. This means that although the total amount of free memory may be high, we are unable to allocate large blocks of memory without running the garbage collector and/or expanding the heap because none of the existing blocks are large enough.

There are two consequences to a fragmented heap. The first is that our game’s memory usage will be higher than it needs to be and the second is that the garbage collector will run more frequently. For a more detailed discussion of heap fragmentation, see <a href="https://docs.unity3d.com/Manual/BestPracticeUnderstandingPerformanceInUnity4-1.html" class="link-primary text-inherit">this Unity best practice guide on performance</a>.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 30. Finding heap allocations

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

If we know that garbage collection is causing problems in our game, we need to know which parts of our code are generating garbage. Garbage is generated when heap variables go out of scope, so first, we need to know what causes a variable to be allocated on the heap.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 31. What is allocated on the stack and the heap?

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

In Unity, value-typed local variables are allocated on the stack and everything else is allocated on the heap. The following code is an example of stack allocation, as the variable *localInt* is both local and value-typed. The memory allocated for this variable will be deallocated from the stack immediately after this function has finished running.

```
void ExampleFunction()

```

The following code is an example of a heap allocation, as the variable localList is local but reference-typed. The memory allocated for this variable will be deallocated when the garbage collector runs.

```
void ExampleFunction()

```

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 32. Using the Profiler window to find heap allocations

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

We can see where our code is creating heap allocations with the Profiler window. You can access the window by going to **Window** \> **Analysis** \> **Profiler** (**Figure 01**).

![](https://connect-mediagw.unity.com/h1/20210308/learn/images/a7dbbc6b-7979-46c1-bc39-453860f8707c_image1.png)

With the CPU usage profiler selected, we can select any frame to see CPU usage data about that frame in the bottom part of the Profiler window. One of the columns of data is called GC allocation. This column shows heap allocations that are being made in that frame. If we select the column header we can sort the data by this statistic, making it easy to see which functions in our game are causing the most heap allocations. Once we know which function causes the heap allocations, we can examine that function.

Once we know what code within the function is causing garbage to be generated, we can decide how to solve this problem and minimize the amount of garbage generated.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 33. Reducing the impact of garbage collection

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Broadly speaking, we can reduce the impact of garbage collection on our game in three ways:

1\. We can reduce the time that the garbage collector takes to run.

2\. We can reduce the frequency with which the garbage collector runs.

3\. We can deliberately trigger the garbage collector so that it runs at times that are not performance-critical, for example during a loading screen.

With that in mind, there are three strategies that will help us here:

1\. We can organize our game so we have fewer heap allocations and fewer object references. Fewer objects on the heap and fewer references to examine means that when garbage collection is triggered, it takes less time to run.

2\. We can reduce the frequency of heap allocations and deallocations, particularly at performance-critical times. Fewer allocations and deallocations mean fewer occasions that trigger garbage collection. This also reduces the risk of heap fragmentation.

3\. We can attempt to time garbage collection and heap expansion so that they happen at predictable and convenient times. This is a more difficult and less reliable approach, but when used as part of an overall memory management strategy can reduce the impact of garbage collection.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 34. Reducing the amount of garbage created

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Let’s examine a few techniques that will help us to reduce the amount of garbage generated by our code.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 35. Caching

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

If our code repeatedly calls functions that lead to heap allocations and then discards the results, this creates unnecessary garbage. Instead, we should store references to these objects and reuse them. This technique is known as caching.

In the following example, the code causes a heap allocation each time it is called. This is because a new array is created.

```
void OnTriggerEnter(Collider other)

```

The following code causes only one heap allocation, as the array is created and populated once and then cached. The cached array can be reused again and again without generating more garbage.

```
private Renderer[] allRenderers;

void Start()

void OnTriggerEnter(Collider other)

```

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 36. Don’t allocate in functions that are called frequently

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

If we have to allocate heap memory in a MonoBehaviour, the worst place we can do it is in functions that run frequently. Update() and LateUpdate(), for example, are called once per frame, so if our code is generating garbage here it will quickly add up. We should consider caching references to objects in Start() or Awake() where possible or ensuring that code that causes allocations only runs when it needs to.

Let’s look at a very simple example of moving code so that it only runs when things change. In the following code, a function that causes an allocation is called every time Update() is called, creating garbage frequently:

```
void Update()

```

With a simple change, we now ensure that the allocating function is called only when the value of transform.position.x has changed. We are now only making heap allocations when necessary rather than in every single frame.

```
private float previousTransformPositionX;

void Update()

}
```

Another technique for reducing garbage generated in Update() is to use a timer. This is suitable for when we have a code that generates garbage that must run regularly, but not necessarily every frame.

In the following example code, the function that generates garbage runs once per frame:

```
void Update()

```

In the following code, we use a timer to ensure that the function that generates garbage runs once per second.

```
private float timeSinceLastCalled;

private float delay = 1f;

void Update()

}
```

Small changes like this, when made to code that runs frequently, can greatly reduce the amount of garbage generated.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 37. Clearing collections

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Creating new collections causes allocations on the heap. If we find that we’re creating new collections more than once in our code, we should cache the reference to the collection and use Clear() to empty its contents instead of calling new repeatedly.

In the following example, a new heap allocation occurs every time new is used.

```
void Update()

```

In the following example, an allocation occurs only when the collection is created or when the collection must be resized behind the scenes. This greatly reduces the amount of garbage generated.

```
private List myList = new List();

void Update()

```

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 38. Object pooling

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Even if we reduce allocations within our scripts, we may still have garbage collection problems if we create and destroy a lot of objects at runtime. <a href="https://en.wikipedia.org/wiki/Object_pool_pattern" class="link-primary text-inherit"><span style="text-decoration:underline">Object pooling</span></a> is a technique that can reduce allocations and deallocations by reusing objects rather than repeatedly creating and destroying them. Object pooling is used widely in games and is most suitable for situations where we frequently spawn and destroy similar objects; for example, when shooting bullets from a gun.

A full guide to object pooling is beyond the scope of this article, but it is a really useful technique and one worth learning. <a href="https://unity3d.com/learn/tutorials/topics/scripting/object-pooling" class="link-primary text-inherit"><span style="text-decoration:underline">This tutorial on object pooling on the Unity Learn site</span></a> is a great guide to implementing an object pooling system in Unity.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 39. Common causes of unnecessary heap allocations

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

We understand that local, value-typed variables are allocated on the stack and that everything else is allocated on the heap. However, there are lots of situations where heap allocations may take us by surprise. Let’s take a look at a few common causes of unnecessary heap allocations and consider how best to reduce these.

#### Strings

In C#, <a href="https://msdn.microsoft.com/en-us/library/362314fe.aspx" class="link-primary text-inherit"><span style="text-decoration:underline">strings are reference types</span></a>, not value types, even though they seem to hold the "value" of a string. This means that creating and discarding strings creates garbage. As strings are commonly used in a lot of code, this garbage can really add up.

Strings in C# are also immutable, which means that their value can’t be changed after they are first created. Every time we manipulate a string (for example, by using the + operator to concatenate two strings), Unity creates a new string with the updated value and discards the old string. This creates garbage.

We can follow a few simple rules to keep garbage from strings to a minimum. Let’s consider these rules, then look at an example of how to apply them.

1\. We should cut down on unnecessary string creation. If we are using the same string value more than once, we should create the string once and cache the value.

2\. We should cut down on unnecessary string manipulations. For example, if we have a Text component that is updated frequently and contains a concatenated string we could consider separating it into two Text components.

3\. If we have to build strings at runtime, we should use <a href="https://msdn.microsoft.com/en-us/library/system.text.stringbuilder" class="link-primary text-inherit"><span style="text-decoration:underline">the StringBuilder class</span></a>. The StringBuilder class is designed for building strings without allocations and will save on the amount of garbage we produce when concatenating complex strings.

4\. We should remove calls to Debug.Log() as soon as they are no longer needed for debugging purposes. Calls to Debug.Log() still execute in all builds of our game, even if they do not output to anything. A call to Debug.Log() creates and disposes of at least one string, so if our game contains many of these calls, the garbage can add up.

Let’s examine an example of a code that generates unnecessary garbage through the inefficient use of strings. In the following code, we create a string for a score display in Update() by combining the string "TIME:“ with the value of the float timer. This creates unnecessary garbage.

```
public Text timerText;
private float timer;

void Update()

```

In the following example, we have improved things considerably. We put the word "TIME:" in a separate Text component, and set its value in Start(). This means that in Update(), we no longer have to combine strings. This reduces the amount of garbage generated considerably.

```
public Text timerHeaderText;
public Text timerValueText;
private float timer;

void Start()

void Update()

```

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 40. Unity function calls

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

It’s important to be aware that whenever we call code that we didn’t write ourselves, whether that’s in Unity itself or in a plugin, we could be generating garbage. Some Unity function calls create heap allocations, and so should be used with care to avoid generating unnecessary garbage.

There is no list of functions that we should avoid. Every function can be useful in some situations and less useful in others. As ever, it’s best to profile our game carefully, identify where garbage is being created and think carefully about how to handle it. In some cases, it may be wise to cache the results of the function; in other cases, it may be wise to call the function less frequently; in other cases, it may be best to refactor our code to use a different function. Having said that, let’s look at a couple of common examples of Unity functions that cause heap allocations and consider how best to handle them.

Every time we access a Unity function that returns an array, a new array is created and passed to us as the return value. This behavior isn’t always obvious or expected, especially when the function is an <a href="https://msdn.microsoft.com/en-us/library/ms228503.aspx" class="link-primary text-inherit"><span style="text-decoration:underline">accessor</span></a> (for example, <a href="https://docs.unity3d.com/ScriptReference/Mesh-normals.html" class="link-primary text-inherit"><span style="text-decoration:underline">Mesh.normals</span></a>).

In the following code, a new array is created for each iteration of the loop.

```
void ExampleFunction()

}
```

It’s easy to reduce allocations in cases like this: we can simply cache a reference to the array. When we do this, only one array is created and the amount of garbage created is reduced accordingly.

The following code demonstrates this. In this case, we call Mesh.normals before the loop runs and cache the reference so that only one array is created.

```
void ExampleFunction()

}
```

Another unexpected cause of heap allocations can be found in the functions GameObject.name or GameObject.tag. Both of these are accessors that return new strings, which means that calling these functions will generate garbage. Caching the value may be useful, but in this case there is a related Unity function that we can use instead. To check a GameObject’s tag against a value without generating garbage, we can use <a href="https://docs.unity3d.com/ScriptReference/GameObject.CompareTag.html" class="link-primary text-inherit"><span style="text-decoration:underline">GameObject.CompareTag()</span></a>.

In the following example code, garbage is created by the call to GameObject.tag:

```
private string playerTag = "Player";

void OnTriggerEnter(Collider other)

If we use GameObject.CompareTag(), this function no longer generates any garbage:
private string playerTag = "Player";

void OnTriggerEnter(Collider other)

```

GameObject.CompareTag isn’t unique; many Unity function calls have alternative versions that cause no heap allocations. For example, we could use <a href="https://docs.unity3d.com/ScriptReference/Input.GetTouch.html" class="link-primary text-inherit"><span style="text-decoration:underline">Input.GetTouch()</span></a> and <a href="https://docs.unity3d.com/ScriptReference/Input-touchCount.html" class="link-primary text-inherit"><span style="text-decoration:underline">Input.touchCount</span></a> in place of <a href="https://docs.unity3d.com/ScriptReference/Input-touches.html" class="link-primary text-inherit"><span style="text-decoration:underline">Input.touches</span></a>, or <a href="https://docs.unity3d.com/ScriptReference/Physics.SphereCastNonAlloc.html" class="link-primary text-inherit"><span style="text-decoration:underline">Physics.SphereCastNonAlloc()</span></a> in place of <a href="https://docs.unity3d.com/ScriptReference/Physics.SphereCastAll.html" class="link-primary text-inherit"><span style="text-decoration:underline">Physics.SphereCastAll()</span></a>.

#### Boxing

<a href="https://msdn.microsoft.com/en-GB/library/yz2be5wk.aspx" class="link-primary text-inherit"><span style="text-decoration:underline">Boxing</span></a> is the term for what happens when a value-typed variable is used in place of a reference-typed variable. Boxing usually occurs when we pass value-typed variables, such as ints or floats, to a function with object parameters such as Object.Equals().

For example, the function String.Format() takes a string and an object parameter. When we pass it a string and an int, the int must be boxed. Therefore the following code contains an example of boxing:

```
void ExampleFunction()
{
    int cost = 5;
    string displayString = String.Format("Price: {0} gold", cost);
}
```

Boxing creates garbage because of what happens behind the scenes. When a value-typed variable is boxed, Unity creates a temporary System.Object on the heap to wrap the value-typed variable. A System.Object is a reference-typed variable, so when this temporary object is disposed of this creates garbage.

Boxing is an extremely common cause of unnecessary heap allocations. Even if we don’t box variables directly in our code, we may be using plugins that cause boxing or it may be happening behind the scenes of other functions. It’s best practice to avoid boxing wherever possible and to remove any function calls that lead to boxing.

#### Coroutines

Calling StartCoroutine() creates a small amount of garbage, because of the classes that Unity must create instances of to manage the coroutine. With that in mind, calls to StartCoroutine() should be limited while our game is interactive and performance is a concern. To reduce garbage created in this way, any coroutines that must run at performance-critical times should be started in advance and we should be particularly careful when using nested coroutines that may contain delayed calls to StartCoroutine().

yield statements within coroutines do not create heap allocations in their own right; however, the values we pass with our yield statement could create unnecessary heap allocations. For example, the following code creates garbage:

```
yield return 0;
```

This code creates garbage because the int with a value of 0 is boxed. In this case, if we wish to simply wait for a frame without causing any heap allocations, the best way to do so is with this code:

```
yield return null;
```

Another common mistake with coroutines is to use new when yielding with the same value more than once. For example, the following code will create and then dispose of a WaitForSeconds object each time the loop iterates:

```
while (!isComplete)

```

If we cache and reuse the WaitForSeconds object, much less garbage is created. The following code shows this as an example:

```
WaitForSeconds delay = new WaitForSeconds(1f);

while (!isComplete)

```

If our code generates a lot of garbage due to coroutines, we may wish to consider refactoring our code to use something other than coroutines. Refactoring code is a complex subject and every project is unique, but there are a couple of common alternatives to coroutines that we may wish to bear in mind. For example, if we are using coroutines mainly to manage time, we may wish to simply keep track of time in an Update() function. If we are using coroutines mainly to control the order in which things happen in our game, we may wish to create some sort of messaging system to allow objects to communicate. There is no one size fits all approach to this, but it is useful to remember that there is often more than one way to achieve the same thing in code.

#### Foreach loops

In versions of Unity prior to 5.5, a *foreach* loop iterating over anything other than an array generates garbage each time the loop terminates. This is due to boxing that happens behind the scenes. A System.Object is allocated on the heap when the loop begins and disposed of when the loop terminates. This problem was fixed in Unity 5.5.

For example, in versions of Unity prior to 5.5, the loop in the following code generates garbage:

```
void ExampleFunction(List listOfInts)

}
```

As long as you have Unity 2019.4 you are safe but if we are unable to upgrade our version of Unity, there is a simple solution to this problem. *for* and *while* loops do not cause boxing behind the scenes and therefore do not generate any garbage. We should favor their use when iterating over collections that are not arrays.

The loop in the following code will not generate garbage:

```
void ExampleFunction(List listOfInts)

}
```

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 41. Function references

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

References to functions, whether they refer to <a href="https://msdn.microsoft.com/en-us/library/0yw3tz5k.aspx" class="link-primary text-inherit"><span style="text-decoration:underline">anonymous methods</span></a> or named methods, are reference-typed variables in Unity. They will cause heap allocations. Converting an anonymous method to a <a href="https://en.wikipedia.org/wiki/Closure_(computer_programming)" class="link-primary text-inherit"><span style="text-decoration:underline">closure</span></a> (where the anonymous method has access to the variables in scope at the time of its creation) significantly increases the memory usage and the number of heap allocations.

The precise details of how function references and closures allocate memory vary depending on platform and compiler settings, but if garbage collection is a concern then it’s best to minimize the use of function references and closures during gameplay. <a href="https://docs.unity3d.com/Manual/BestPracticeUnderstandingPerformanceInUnity4-1.html" class="link-primary text-inherit"><span style="text-decoration:underline">This Unity best practice guide on performance</span></a> goes into greater technical detail on this topic

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 42. LINQ and Regular Expressions

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Both LINQ and Regular Expressions generate garbage due to boxing that occurs behind the scenes. It is best practice to avoid using these altogether where performance is a concern. Again, <a href="https://docs.unity3d.com/Manual/BestPracticeUnderstandingPerformanceInUnity4-1.html" class="link-primary text-inherit"><span style="text-decoration:underline">this Unity best practice guide on performance</span></a> provides greater technical detail about this subject.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 43. Structuring our code to minimize the impact of garbage collection

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

The way that our code is structured can impact garbage collection. Even if our code does not create heap allocations, it can add to the garbage collector’s workload.

One way that our code can unnecessarily add to the garbage collector’s workload is by requiring it to examine things that it should not have to examine. Structs are value-typed variables, but if we have a struct that contains a reference-typed variable then the garbage collector must examine the whole struct. If we have a large array of these structs, then this can create a lot of additional work for the garbage collector.

In this example, the struct contains a string, which is reference-typed. The whole array of structs must now be examined by the garbage collector when it runs.

```
public struct ItemData

private ItemData[] itemData;
```

In this example, we store the data in separate arrays. When the garbage collector runs, it need only examine the array of strings and can ignore the other arrays. This reduces the work that the garbage collector must do.

```
private string[] itemNames;
private int[] itemCosts;
private Vector3[] itemPositions;
```

Another way that our code can unnecessarily add to the garbage collector’s workload is by having unnecessary object references. When the garbage collector searches for references to objects on the heap, it must examine every current object reference in our code. Having fewer object references in our code means that it has less work to do, even if we don’t reduce the total number of objects on the heap.

In this example, we have a class that populates a dialog box. When the user has viewed the dialog, another dialog box is displayed. Our code contains a reference to the next instance of DialogData that should be displayed, meaning that the garbage collector must examine this reference as part of its operation:

```
public class DialogData

}
```

Here, we have restructured the code so that it returns an identifier that is used to look up the next instance of DialogData, instead of the instance itself. This is not an object reference, so it does not add to the time taken by the garbage collector.

```
public class DialogData

}
```

On its own, this example is fairly trivial. However, if our game contains a great many objects that hold references to other objects, we can considerably reduce the complexity of the heap by restructuring our code in this fashion.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 44. Timing garbage collection

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

#### Manually forcing garbage collection

Finally, we may wish to trigger garbage collection ourselves. If we know that heap memory has been allocated but is no longer used (for example, if our code has generated garbage when loading assets) and we know that a garbage collection freeze won’t affect the player (for example, while the loading screen is still showing), we can request garbage collection using the following code:

System.GC.Collect();

This will force the garbage collector to run, freeing up the unused memory at a time that is convenient for us.

We’ve learned how garbage collection works in Unity, why it can cause performance problems and how to minimize its impact on our game. Using this knowledge and our profiling tools, we can fix performance problems related to garbage collection and structure our games so that they manage memory efficiently.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 45. Optimizing graphics rendering in Unity games

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

In this article, we will learn what happens behind the scenes when Unity renders a frame, what kind of performance problems can occur when rendering and how to fix performance problems related to rendering.

Before we read this article, it is vital to understand that there is no one size fits all approach to improving rendering performance. Rendering performance is affected by many factors within our game and is also highly dependent on the hardware and operating system that our game runs on. The most important thing to remember is that we solve performance problems by investigating, experimenting and rigorously profiling the results of our experiments.

This article contains information on the most common rendering performance problems with suggestions on how to fix them and links to further reading. It’s possible that our game could have a problem - or a combination of problems - not covered here. This article, however, will still help us to understand our problem and give us the knowledge and vocabulary to effectively search for a solution.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 46. A brief introduction to rendering

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Before we begin, let’s take a quick and somewhat simplified look at what happens when Unity renders a frame. Understanding the flow of events and the correct terms for things will help us to understand, research and work towards fixing our performance problems.

At the most basic level, rendering can be described as follows:

1\. The <a href="https://en.wikipedia.org/wiki/Central_processing_unit" class="link-primary text-inherit"><span style="text-decoration:underline">central processing unit</span></a>, known as the CPU, works out what must be drawn and how it must be drawn.

2\. The CPU sends instructions to the <a href="https://en.wikipedia.org/wiki/Graphics_processing_unit" class="link-primary text-inherit"><span style="text-decoration:underline">graphics processing unit</span></a>, known as the GPU.

3\. The GPU draws things according to the CPU’s instructions.

Now let’s take a closer look at what happens. We’ll cover each of these steps in greater detail later in the article, but for now, let’s just familiarise ourselves with the words used and understand the different roles that the CPU and GPU play in rendering.

The phrase often used to describe rendering is the rendering pipeline, and this is a useful image to bear in mind; efficient rendering is all about keeping information flowing.

For every frame that is rendered, the CPU does the following work:

1\. The CPU checks every object in the scene to determine whether it should be rendered. An object is only rendered if it meets certain criteria; for example, some part of its bounding box must be within a camera’s <a href="https://docs.unity3d.com/Manual/UnderstandingFrustum.html" class="link-primary text-inherit"><span style="text-decoration:underline">view frustum</span></a>. Objects that will not be rendered are said to be culled. For more information on the frustum and frustum culling please see<a href="https://docs.unity3d.com/Manual/UnderstandingFrustum.html" class="link-primary text-inherit"><span style="text-decoration:underline"> this page</span></a>.

2\. The CPU gathers information about every object that will be rendered and sorts this data into commands known as draw calls. A draw call contains data about a single mesh and how that mesh should be rendered; for example, which textures should be used. Under certain circumstances, objects that share settings may be combined into the same draw call. Combining data for different objects into the same draw call is known as batching.

3\. The CPU creates a packet of data called a batch for each draw call. Batches may sometimes contain data other than draw calls, but these situations are unlikely to contribute to common performance issues and we, therefore, won’t consider these in this article.

For every batch that contains a draw call, the CPU now must do the following:

1\. The CPU may send a command to the GPU to change a number of variables known collectively as the render state. This command is known as a SetPass call. A SetPass call tells the GPU which settings to use to render the next mesh. A SetPass call is sent only if the next mesh to be rendered requires a change in render state from the previous mesh.

2\. The CPU sends the draw call to the GPU. The draw call instructs the GPU to render the specified mesh using the settings defined in the most recent SetPass call.

3\. Under certain circumstances, more than one pass may be required for the batch. A pass is a section of shader code and a new pass requires a change to the render state. For each pass in the batch, the CPU must send a new SetPass call and then must send the draw call again.

Meanwhile, the GPU does the following work:

1\. The GPU handles tasks from the CPU in the order that they were sent.

2\. If the current task is a SetPass call, the GPU updates the render state.

3\. If the current task is a draw call, the GPU renders the mesh. This happens in stages, defined by separate sections of shader code. This part of rendering is complex and we won’t cover it in great detail, but it’s useful for us to understand that a section of code called the vertex shader tells the GPU how to process the mesh’s vertices and then a section of code called the fragment shader tells the GPU how to draw the individual pixels.

4\. This process repeats until all tasks sent from the CPU have been processed by the GPU.

Now that we understand what’s happening when Unity renders a frame, let’s consider the sort of problems that can occur when rendering.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 47. Types of rendering problems

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

The most important thing to understand about rendering is this: both the CPU and the GPU must finish all of their tasks in order to render the frame. If anyone of these tasks takes too long to complete, it will cause a delay in the rendering of the frame.

Rendering problems have two fundamental causes. The first type of problem is caused by an inefficient pipeline. An inefficient pipeline occurs when one or more of the steps in the rendering pipeline takes too long to complete, interrupting the smooth flow of data. Inefficiencies within the pipeline are known as bottlenecks. The second type of problem is caused by simply trying to push too much data through the pipeline. Even the most efficient pipeline has a limit to how much data it can handle in a single frame.

When our game takes too long to render a frame because the CPU takes too long to perform its rendering tasks, our game is what is known as CPU bound. When our game takes too long to render a frame because the GPU takes too long to perform its rendering tasks, our game is what is known as GPU bound.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 48. Understanding rendering problems

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

It is vital that we use profiling tools to understand the cause of performance problems before we make any changes. Different problems require different solutions. It is also very important that we measure the effects of every change we make; fixing performance problems is a balancing act, and improving one aspect of performance can negatively impact another.

We will use two tools to help us understand and fix our rendering performance problems: the Profiler window and the Frame Debugger. Both of these tools are built into Unity.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 49. The Profiler window

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

The Profiler window allows us to see real-time data about how our game is performing. We can use the Profiler window to see data about many aspects of our game, including memory usage, the rendering pipeline and the performance of user scripts.

If you are not yet familiar with using the Profiler window, <a href="https://docs.unity3d.com/Manual/ProfilerWindow.html" class="link-primary text-inherit"><span style="text-decoration:underline">this page of the Unity Manual</span></a> is a good introduction.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 50. The Frame Debugger

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

The Frame Debugger allows us to see how a frame is rendered, step by step. Using the Frame Debugger, we can see detailed information such as what is drawn during each draw call, shader properties for each draw call and the order of events sent to the GPU. This information helps us to understand how our game is rendered and where we can improve performance.

If you are not yet familiar with using the Frame Debugger, <a href="https://docs.unity3d.com/Manual/FrameDebugger.html" class="link-primary text-inherit"><span style="text-decoration:underline">this page of the Unity Manual</span></a> is a very useful guide to what it does and <a href="https://learn.unity.com/tutorial/rendering-and-shading#5c7f8528edbc2a002053b53b" class="link-primary text-inherit"><span style="text-decoration:underline">this tutorial video</span></a> shows it in use.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 51. Finding the cause of performance problems

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Before we try to improve the rendering performance of our game, we must be certain that our game is running slowly due to rendering problems. There is no point in trying to optimize our rendering performance if the real cause of our problem is overly complex user scripts!

Once we have established that our problems relate to rendering, we must also understand whether our game is CPU bound or GPU bound. These different problems require different solutions, so it’s vital that we understand the cause of the problem before trying to fix it. If you’re not yet sure whether your game is CPU bound or GPU bound, you should follow<a href="https://learn.unity.com/tutorial/diagnosing-performance-problems#5c7f8528edbc2a002053b598" class="link-primary text-inherit"><span style="text-decoration:underline"> this tutorial</span></a>.

If we are certain that our problems relate to rendering and we know whether our game is CPU bound or GPU bound, we are ready to read on.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 52. If our game is CPU bound

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Broadly speaking, the work that must be carried out by the CPU in order to render a frame is divided into three categories:

1\. Determining what must be drawn

2\. Preparing commands for the GPU

3\. Sending commands to the GPU

These broad categories contain many individual tasks, and these tasks may be carried out across multiple <a href="https://en.wikipedia.org/wiki/Thread_(computing)" class="link-primary text-inherit"><span style="text-decoration:underline">threads</span></a>. Threads allow separate tasks to happen simultaneously; while one thread performs one task, another thread can perform a completely separate task. This means that the work can be done more quickly. When rendering tasks are split across separate threads, this is known as multithreaded rendering.

There are three types of threads involved in Unity’s rendering process: the main thread, the render thread and worker threads. The main thread is where the majority of CPU tasks for our game take place, including some rendering tasks. The render thread is a specialised thread that sends commands to the GPU. Worker threads each perform a single task, such as culling or mesh skinning. Which tasks are performed by which thread depends on our game’s settings and the hardware on which our game runs. For example, the more CPU cores our target hardware has, the more worker threads can be spawned. For this reason, it is very important to profile our game on target hardware; our game may perform very differently on different devices.

Because multithreaded rendering is complex and hardware-dependent, we must understand which tasks are causing our game to be CPU bound before we try to improve performance. If our game is running slowly because culling operations are taking too long on one thread, then it won’t help us to reduce the amount of time it takes to send commands to the GPU on a different thread.

NB: Not all platforms support multithreaded rendering; at the time of writing, WebGL does not support this feature. On platforms that do not support multithreaded rendering, all CPU tasks are carried out on the same thread. If we are CPU bound on such a platform, optimizing any CPU work will improve CPU performance. If this is the case for our game, we should read all of the following sections and consider which optimizations may be most suitable for our game.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 53. Graphics jobs

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

The <a href="https://docs.unity3d.com/Manual/class-PlayerSettingsStandalone.html" class="link-primary text-inherit"><span style="text-decoration:underline">Graphics jobs</span></a> option in Player Settings determines whether Unity uses worker threads to carry out rendering tasks that would otherwise be done on the main thread and, in some cases, the render thread. On platforms where this feature is available, it can deliver a considerable performance boost. If we wish to use this feature, we should profile our game with and without Graphics jobs enabled and observe the effect that it has on performance.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 54. Finding out which tasks are contributing to problems

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

We can determine which tasks are causing our game to be CPU bound by using the Profiler window. This tutorial shows how to determine where the problems lie.

Now that we understand which tasks are causing our game to be CPU bound, let’s look at a few common problems and their solutions.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 55. Sending commands to the GPU

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

The time taken to send commands to the GPU is the most common reason for a game to be CPU bound. This task is performed on the render thread on most platforms, although on certain platforms (for example, PlayStation 4) this may be performed by worker threads.

The most costly operation that occurs when sending commands to the GPU is the SetPass call. If our game is CPU bound due to sending commands to the GPU, reducing the number of SetPass calls is likely to be the best way to improve performance.

We can see how many SetPass calls and batches are being sent in the Rendering profiler of Unity’s Profiler window. The number of SetPass calls that can be sent before performance suffers depends very much on the target hardware; a high-end PC can send many more SetPass calls before performance suffers than a mobile device.

The number of SetPass calls and its relationship to the number of batches depends on several factors, and we’ll cover these topics in more detail later in the article. However, it’s usually the case that:

1\. Reducing the number of batches and/or making more objects share the same render state will, in most cases, reduce the number of SetPass calls.

2\. Reducing the number of SetPass calls will, in most cases, improve CPU performance.

If reducing the number of batches doesn’t reduce the number of SetPass calls, it may still lead to performance improvements in its own right. This is because the CPU can more efficiently process a single batch than several batches, even if they contain the same amount of mesh data.

There are, broadly, three ways of reducing the number of batches and SetPass calls. We will look more in-depth at each one of these:

1\. Reducing the number of objects to be rendered will likely reduce both batches and SetPass calls.

2\. Reducing the number of times each object must be rendered will usually reduce the number of SetPass calls.

3\. Combining the data from objects that must be rendered into fewer batches will reduce the number of batches.

Different techniques will be suitable for different games, so we should consider all of these options, decide which ones could work in our game and experiment.

#### **Reducing the number of objects being rendered**

Reducing the number of objects that must be rendered is the simplest way to reduce the number of batches and SetPass calls. There are several techniques we can use to reduce the number of objects being rendered.

1\. Simply reducing the number of visible objects in our scene can be an effective solution. If, for example, we are rendering a large number of different characters in a crowd, we can experiment with simply having fewer of these characters in the scene. If the scene still looks good and performance improves, this will likely be a much quicker solution than more sophisticated techniques.

2\. We can reduce our camera’s draw distance using the camera’s <a href="https://docs.unity3d.com/Manual/class-Camera.html" class="link-primary text-inherit"><span style="text-decoration:underline">Far Clip Plane</span></a> property. This property is the distance beyond which objects are no longer rendered by the camera. If we wish to disguise the fact that distant objects are no longer visible, we can try using <a href="https://docs.unity3d.com/Manual/GlobalIllumination.html" class="link-primary text-inherit"><span style="text-decoration:underline">fog to hide the lack of distant objects</span></a>.

3\. For a more fine-grained approach to hiding objects based on distance, we can use our camera’s <a href="https://docs.unity3d.com/ScriptReference/Camera-layerCullDistances.html" class="link-primary text-inherit"><span style="text-decoration:underline">Layer Cull Distances</span></a> property to provide custom culling distances for objects that are on separate <a href="https://docs.unity3d.com/Manual/Layers.html" class="link-primary text-inherit"><span style="text-decoration:underline">layers</span></a>. This approach can be useful if we have lots of small foreground decorative details; we could hide these details at a much shorter distance than large terrain features.

4\. We can use a technique called <a href="https://docs.unity3d.com/Manual/OcclusionCulling.html" class="link-primary text-inherit"><span style="text-decoration:underline">occlusion culling</span></a> to disable the rendering of objects that are hidden by other objects. For example, if there is a large building in our scene we can use occlusion culling to disable the rendering of objects behind it. Unity’s occlusion culling is not suitable for all scenes, can lead to additional CPU overhead and can be complex to set up, but it can greatly improve performance in some scenes. <a href="https://blogs.unity3d.com/2013/12/26/occlusion-culling-in-unity-4-3-best-practices/" class="link-primary text-inherit"><span style="text-decoration:underline">This Unity blog post on occlusion culling best practices</span></a> is a great guide to the subject. In addition to using Unity’s occlusion culling, we can also implement our own form of occlusion culling by manually deactivating objects that we know cannot be seen by the player. For example, if our scene contains objects that are used for a cutscene but aren't visible before or afterward, we should deactivate them. Using our knowledge of our own game is always more efficient than asking Unity to work things out dynamically.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 56. Reducing the number of times each object must be rendered

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Realtime lighting, shadows, and reflections add a great deal of realism to games but can be very expensive. Using these features can lead to objects being rendered multiple times, which can greatly impact performance.

The exact impact of these features depends on the rendering path that we choose for our game. Rendering path is the term for the order in which calculations are performed when drawing the scene, and the major difference between rendering paths is how they handle realtime lights, shadows, and reflections. As a general rule, Deferred Rendering is likely to be a better choice if our game runs on higher-end hardware and uses a lot of realtime lights, shadows, and reflections. Forward Rendering is likely to be more suitable if our game runs on lower-end hardware and does not use these features. However, this is a very complex issue and if we wish to make use of real time lights, shadows and reflections it is best to research the subject and experiment. <a href="https://docs.unity3d.com/Manual/RenderingPaths.html" class="link-primary text-inherit"><span style="text-decoration:underline">This page of the Unity Manual</span></a> gives more information on the different rendering paths available in Unity and is a useful jumping-off point. This <a href="https://learn.unity.com/tutorial/introduction-to-lighting-and-rendering-2019-3" class="link-primary text-inherit"><span style="text-decoration:underline">tutorial</span></a> contains useful information on the subject of lighting in Unity.

Regardless of the rendering path chosen, the use of real time lights, shadows, and reflections can impact our game’s performance and it’s important to understand how to optimize them.

1\. Dynamic lighting in Unity is a very complex subject and discussing it in depth is beyond the scope of this article, but <a href="https://docs.unity3d.com/Manual/LightPerformance.html" class="link-primary text-inherit"><span style="text-decoration:underline">this page of the Unity Manual</span></a> has details on common lighting optimizations that could help you understand it.

2\. Dynamic lighting is expensive. When our scene contains objects that don’t move, such as scenery, we can use a technique called baking to precompute the lighting for the scene so that runtime lighting calculation is not required. <a href="https://learn.unity.com/tutorial/rendering-and-shading#5c7f8528edbc2a002053b533" class="link-primary text-inherit"><span style="text-decoration:underline">This tutorial</span></a> gives an introduction to the technique, and <a href="https://docs.unity3d.com/Manual/GIIntro.html" class="link-primary text-inherit"><span style="text-decoration:underline">this section of the Unity Manual</span></a> covers baked lighting in detail.

3\. If we wish to use real time <a href="https://docs.unity3d.com/Manual/ShadowOverview.html" class="link-primary text-inherit"><span style="text-decoration:underline">shadows</span></a> in our game, this is likely an area where we can improve performance. <a href="https://docs.unity3d.com/Manual/DirLightShadows.html" class="link-primary text-inherit"><span style="text-decoration:underline">This page of the Unity Manual</span></a> is a good guide to the shadow properties that can be tweaked in Quality Settings and how these will affect appearance and performance. For example, we can use the Shadow Distance property to ensure that only nearby objects cast shadows.

4.<span style="text-decoration:underline"> <a href="https://docs.unity3d.com/Manual/ReflectionProbes.html" class="link-primary text-inherit">Reflection probes</a></span> create realistic reflections but can be very costly in terms of batches. It’s best to keep our use of reflections to a minimum where performance is a concern and to optimize them as much as possible where they are used. <a href="https://docs.unity3d.com/Manual/RefProbePerformance.html" class="link-primary text-inherit"><span style="text-decoration:underline">This page of the Unity Manual</span></a> is a useful guide to optimizing reflection probes.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 57. Combining objects into fewer batches

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

A batch can contain the data for multiple objects when certain conditions are met. To be eligible for batching, objects must:

1\. Share the same instance of the same material

2\. Have identical material settings (i.e., texture, shader, and shader parameters)

Batching eligible objects can improve performance, although as with all optimization techniques we must profile carefully to ensure that the cost of batching does not exceed the performance gains.

There are a few different techniques for batching eligible objects:

1\. Static batching is a technique that allows Unity to batch nearby eligible objects that do not move. A good example of something that could benefit from static batching is a pile of similar objects, such as boulders. <a href="https://docs.unity3d.com/Manual/DrawCallBatching.html" class="link-primary text-inherit"><span style="text-decoration:underline">This page of the Unity Manual</span></a> contains instructions on setting up static batching in our game. Static batching can lead to higher memory usage so we should bear this cost in mind when profiling our game.

2\. Dynamic batching is another technique that allows Unity to batch eligible objects, whether they move or not. There are a few restrictions on the objects that can be batched using this technique. These restrictions are listed, along with instructions, on<a href="https://docs.unity3d.com/Manual/DrawCallBatching.html" class="link-primary text-inherit"><span style="text-decoration:underline"> this page of the Unity Manual</span></a>. Dynamic batching has an impact on CPU usage that can cause it to cost more in CPU time than it saves. We should bear this cost in mind when experimenting with this technique and be cautious with its use.

3\. Batching Unity’s UI elements are a little more complex, as it can be affected by the layout of our UI. <a href="https://www.youtube.com/watch?v=t_pdIFGh4Kg" class="link-primary text-inherit"><span style="text-decoration:underline">This video from Unite Bangkok 2015</span></a> gives a good overview of the subject and <a href="https://learn.unity.com/tutorial/optimizing-unity-ui" class="link-primary text-inherit"><span style="text-decoration:underline">this guide to optimizing Unity UI</span></a> provides in-depth information on how to ensure that UI batching works as we intend it to.

4\. <a href="https://en.wikipedia.org/wiki/Geometry_instancing" class="link-primary text-inherit"><span style="text-decoration:underline">GPU instancing</span></a> is a technique that allows large numbers of identical objects to be very efficiently batched. There are limitations to its use and it is not supported by all hardware, but if our game has many identical objects on screen at once we may be able to benefit from this technique. <a href="https://docs.unity3d.com/Manual/GPUInstancing.html" class="link-primary text-inherit"><span style="text-decoration:underline">This page of the Unity Manual</span></a> contains an introduction to GPU instancing in Unity with details of how to use it, which platforms support it and the circumstances under which it may benefit our game.

5\. <a href="https://en.wikipedia.org/wiki/Texture_atlas" class="link-primary text-inherit"><span style="text-decoration:underline">Texture atlasing</span></a> is a technique where multiple textures are combined into one larger texture. It is commonly used in 2D games and UI systems, but can also be used in 3D games. If we use this technique when creating art for our game, we can ensure that objects share textures and are therefore eligible for batching. Unity has a built-in texture atlasing tool called <a href="https://docs.unity3d.com/Manual/SpritePacker.html" class="link-primary text-inherit"><span style="text-decoration:underline">Sprite Packer</span></a> for use with 2D games.

6\. It is possible to manually combine meshes that share the same material and texture, either in the Unity Editor or via code at runtime. When combining meshes in this way, we must be aware that shadows, lighting, and culling will still operate on a per-object level; this means that a performance increase from combining meshes could be counteracted by no longer being able to cull those objects when they would otherwise not have been rendered. If we wish to investigate this approach, we should examine the<a href="https://docs.unity3d.com/ScriptReference/Mesh.CombineMeshes.html" class="link-primary text-inherit"><span style="text-decoration:underline"> Mesh.CombineMeshes</span></a> function. The CombineChildren script in <a href="https://docs.unity3d.com/Manual/HOWTO-InstallStandardAssets.html" class="link-primary text-inherit"><span style="text-decoration:underline">Unity’s Standard Assets package</span></a> is an example of this technique.

7\. We must be very careful when accessing <a href="https://docs.unity3d.com/ScriptReference/Renderer-material.html" class="link-primary text-inherit"><span style="text-decoration:underline">Renderer.material</span></a> in scripts. This duplicates the material and returns a reference to the new copy. Doing so will break batching if the renderer was part of a batch because the renderer no longer has a reference to the same instance of the material. If we wish to access a batched object’s material in a script, we should use <a href="https://docs.unity3d.com/ScriptReference/Renderer-sharedMaterial.html" class="link-primary text-inherit"><span style="text-decoration:underline">Renderer.sharedMaterial</span></a>.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 58. Culling, sorting and batching

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Culling, gathering data on objects that will be drawn, sorting this data into batches and generating GPU commands can all contribute to being CPU bound. These tasks will either be performed on the main thread or on individual worker threads, depending on our game’s settings and target hardware.

1\. Culling is unlikely to be very costly on its own, but reducing unnecessary culling may help performance. There is a per-object-per-camera overhead for all active scene objects, even those which are on layers that are not being rendered. To reduce this, we should disable cameras and deactivate or disable renderers that are not currently in use.

2\. Batching can greatly improve the speed of sending commands to the GPU, but it can sometimes add unwanted overhead elsewhere. If batching operations are contributing to our game being CPU bound, we may wish to limit the number of manual or automatic batching operations in our game.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 59. Skinned meshes

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

<a href="https://docs.unity3d.com/Manual/class-SkinnedMeshRenderer.html" class="link-primary text-inherit"><span style="text-decoration:underline">SkinnedMeshRenderers</span></a> are used when we animate a mesh by deforming it using a technique called bone animation. It’s most commonly used in animated characters. Tasks related to rendering skinned meshes will usually be performed on the main thread or on individual worker threads, depending on our game’s settings and target hardware.

Rendering skinned meshes can be a costly operation. If we can see in the Profiler window that rendering skinned meshes is contributing to our game being CPU bound, there are a few things we can try to improve performance:

1\. We should consider whether we need to use SkinnedMeshRenderer components for every object that currently uses one. It may be that we have imported a model that uses a SkinnedMeshRenderer component but we are not actually animating it, for example. In a case like this, replacing the SkinnedMeshRenderer component with a MeshRenderer component will aid performance. When importing models into Unity, if we choose not to import animations in <a href="https://docs.unity3d.com/Manual/class-FBXImporter.html" class="link-primary text-inherit"><span style="text-decoration:underline">the model’s Import Settings</span></a>, the model will have a MeshRenderer instead of a SkinnedMeshRenderer.

2\. If we are animating our object only some of the time (for example, only on startup or only when it is within a certain distance of the camera), we could switch its mesh for a less detailed version or its SkinnedMeshRenderer component for a MeshRenderer component. The SkinnedMeshRenderer component has a <a href="https://docs.unity3d.com/ScriptReference/SkinnedMeshRenderer.BakeMesh.html" class="link-primary text-inherit"><span style="text-decoration:underline">BakeMesh</span></a> function that can create a mesh in a matching pose, which is useful for swapping between different meshes or renderers without any visible change to the object.

3\. <a href="https://docs.unity3d.com/Manual/ModelingOptimizedCharacters.html" class="link-primary text-inherit"><span style="text-decoration:underline">This page of the Unity Manual</span></a> contains advice on optimizing animated characters that use skinned meshes, and <a href="https://docs.unity3d.com/Manual/class-SkinnedMeshRenderer.html" class="link-primary text-inherit"><span style="text-decoration:underline">the Unity Manual page on the SkinnedMeshRenderer component</span></a> includes tweaks that can improve performance. In addition to the suggestions on these pages, it is worth bearing in mind that the cost of mesh skinning increases per vertex; therefore using fewer vertices in our models reduces the amount of work that must be done.

4\. On certain platforms, skinning can be handled by the GPU rather than the CPU. This option may be worth experimenting with if we have a lot of capacity on the GPU. We can enable GPU skinning for the current platform and quality target in <a href="https://docs.unity3d.com/Manual/class-PlayerSettingsStandalone.html" class="link-primary text-inherit"><span style="text-decoration:underline">Player Settings</span></a>.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 60. Main thread operations unrelated to rendering

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

It’s important to understand that many CPU tasks unrelated to rendering take place on the main thread. This means that if we are CPU bound on the main thread, we may be able to improve performance by reducing the CPU time spent on tasks not related to rendering.

As an example, our game may be carrying out expensive rendering operations and expensive user script operations on the main thread at a certain point in our game, making us CPU bound. If we have optimized the rendering operations as much as we can without losing visual fidelity, it is possible that we may be able to reduce the CPU cost of our own scripts to improve performance.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 61. If our game is GPU bound

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

The first thing to do if our game is GPU bound is to find out what is causing the GPU bottleneck. GPU performance is most often limited by <a href="https://en.wikipedia.org/wiki/Fillrate" class="link-primary text-inherit"><span style="text-decoration:underline">fill rate</span></a>, especially on mobile devices, but <a href="https://en.wikipedia.org/wiki/Memory_bandwidth" class="link-primary text-inherit"><span style="text-decoration:underline">memory bandwidth</span></a> and vertex processing can also be concerns. Let’s examine each of these problems and learn what causes it, how to diagnose it and how to fix it.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 62. Fill rate

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Fill rate refers to the number of pixels the GPU can render to the screen each second. If our game is limited by fill rate, this means that our game is trying to draw more pixels per frame than the GPU can handle.

It’s simple to check if the fill rate is causing our game to be GPU bound:

1\. Profile the game and note the GPU time.

2\. Decrease the display resolution in Player Settings.

3\. Profile the game again. If performance has improved, it is likely that the fill rate is the problem.

If the fill rate is the cause of our problem, there are a few approaches that may help us to fix the problem.

1\. Fragment shaders are the sections of shader code that tell the GPU how to draw a single pixel. This code is executed by the GPU for every pixel it must draw, so if the code is inefficient then performance problems can easily stack up. Complex fragment shaders are a very common cause of fill rate problems.

2\. If our game is using built-in shaders, we should aim to use the simplest and most optimized shaders possible for the visual effect we want. As an example, <a href="https://docs.unity3d.com/Manual/shader-Performance.html" class="link-primary text-inherit"><span style="text-decoration:underline">the mobile shaders that ship with Unity</span></a> are highly optimized; we should experiment with using them and see if this improves performance without affecting the look of our game. These shaders were designed for use on mobile platforms, but they are suitable for any project. It is perfectly fine to use "mobile" shaders on non-mobile platforms to increase performance if they give the visual fidelity required for the project.

3\. If objects in our game use Unity’s <a href="https://docs.unity3d.com/Manual/shader-StandardShader.html" class="link-primary text-inherit"><span style="text-decoration:underline">Standard Shader</span></a>, it is important to understand that Unity compiles this shader based on the current material settings. Only features that are currently being used are compiled. This means that removing features such as detail maps can result in much less complex fragment shader code which can greatly benefit performance. Again, if this is the case in our game, we should experiment with the settings and see if we are able to improve performance without affecting visual quality.

4\. If our project uses bespoke shaders, we should aim to optimize them as much as possible. Optimizing shader is a complex subject, but <a href="https://docs.unity3d.com/Manual/SL-ShaderPerformance.html" class="link-primary text-inherit"><span style="text-decoration:underline">this page of the Unity Manual</span></a> and the Shader optimization section of <a href="https://docs.unity3d.com/Manual/MobileOptimisation.html" class="link-primary text-inherit"><span style="text-decoration:underline">this page of the Unity Manual</span></a> contains useful starting points for optimizing our shader code.

5\. Overdraw is the term for when the same pixel is drawn multiple times. This happens when objects are drawn on top of other objects and contribute greatly to fill rate issues. To understand overdraw, we must understand the order in which Unity draws objects in the scene. An object’s shader determines its draw order, usually by specifying which<a href="https://docs.unity3d.com/ScriptReference/Rendering.RenderQueue.html" class="link-primary text-inherit"><span style="text-decoration:underline"> render queue</span></a> the object is in. Unity uses this information to draw objects in a strict order, as detailed on this <a href="https://docs.unity3d.com/Manual/SL-SubShaderTags.html" class="link-primary text-inherit"><span style="text-decoration:underline">page of the Unity Manual</span></a>. Additionally, the objects in different render queues are sorted differently before they are drawn. For example, Unity sorts items front-to-back in the Geometry queue to minimize overdraw, but sorts objects back-to-front in the Transparent queue to achieve the required visual effect. This back-to-front sorting actually has the effect of maximizing overdraw for objects in the Transparent queue. Overdraw is a complex subject and there is no one size fits all approach to solving overdraw problems, but reducing the number of overlapping objects that Unity cannot automatically sort is key. The best place to start investigating this issue is in Unity’s Scene view; there is a <a href="https://docs.unity3d.com/Manual/ViewModes.html" class="link-primary text-inherit"><span style="text-decoration:underline">Draw Mode</span></a> that allows us to see overdraw in our scene and, from there, identify where we can work to reduce it. The most common culprits for excessive overdraw are transparent materials, unoptimized particles, and overlapping UI elements, so we should experiment with optimizing or reducing these.<a href="https://learn.unity.com/tutorial/optimizing-unity-ui#5c7f8528edbc2a002053b5a2" class="link-primary text-inherit"><span style="text-decoration:underline"> This article on the Unity Learn site</span></a> focuses primarily on Unity UI, but also contains good general guidance on overdraw.

6\. The use of <a href="https://docs.unity3d.com/Manual/comp-ImageEffects.html" class="link-primary text-inherit"><span style="text-decoration:underline">image effects</span></a> can greatly contribute to filling rate issues, especially if we are using more than one image effect. If our game makes use of image effects and is struggling with fill rate issues, we may wish to experiment with different settings or more optimized versions of the image effects (such as <a href="https://docs.unity3d.com/Manual/script-BloomOptimized.html" class="link-primary text-inherit"><span style="text-decoration:underline">Bloom (Optimized)</span></a> in place of <a href="https://docs.unity3d.com/Manual/script-Bloom.html" class="link-primary text-inherit"><span style="text-decoration:underline">Bloom</span></a>). If our game uses more than one image effect on the same camera, this will result in multiple shaders passes. In this case, it may be beneficial to combine the shader code for our image effects into a single pass, such as in <a href="https://github.com/Unity-Technologies/PostProcessing/wiki" class="link-primary text-inherit"><span style="text-decoration:underline">Unity’s PostProcessing Stack</span></a>. If we have optimized our image effects and are still having fill rate issues, we may need to consider disabling image effects, particularly on lower-end devices.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 63. Memory bandwidth

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Memory bandwidth refers to the rate at which the GPU can read from and write to its dedicated memory. If our game is limited by memory bandwidth, this usually means that we are using textures that are too large for the GPU to handle quickly.

To check if memory bandwidth is a problem, we can do the following:

1\. Profile the game and note the GPU time.

2\. Reduce the Texture Quality for the current platform and quality target in <a href="https://docs.unity3d.com/Manual/class-QualitySettings.html" class="link-primary text-inherit"><span style="text-decoration:underline">Quality Settings</span></a>.

3\. Profile the game again and note the GPU time. If performance has improved, it is likely that memory bandwidth is the problem.

If memory bandwidth is our problem, we need to reduce the texture memory usage in our game. Again, the technique that works best for each game will be different, but there are a few ways in which we can optimize our textures.

1\. Texture compression is a technique that can greatly reduce the size of textures both on disk and in memory. If memory bandwidth is a concern in our game, using texture compression to reduce the size of textures in memory can aid performance. There are lots of different texture compression formats and settings available within Unity, and each texture can have separate settings. As a general rule, some form of texture compression should be used whenever possible; however, a trial and error approach to find the best setting for each texture works best. <a href="https://docs.unity3d.com/Manual/class-TextureImporter.html" class="link-primary text-inherit"><span style="text-decoration:underline">This page in the Unity Manual</span></a> contains useful information on different compression formats and settings.

2\. Mipmaps are lower-resolution versions of textures that Unity can use on distant objects. If our scene contains objects that are far from the camera, we may be able to use mipmaps to ease problems with memory bandwidth. <a href="https://docs.unity3d.com/Manual/ViewModes.html" class="link-primary text-inherit"><span style="text-decoration:underline">The Mipmaps Draw Mode</span></a> in Scene view allows us to see which objects in our scene could benefit from mipmaps, and <a href="https://docs.unity3d.com/Manual/class-TextureImporter.html" class="link-primary text-inherit"><span style="text-decoration:underline">this page of the Unity Manual</span></a> contains more information on enabling mipmaps for textures.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 64. Vertex processing

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Vertex processing refers to the work that the GPU must do to render each vertex in a mesh. The cost of vertex processing is impacted by two things: the number of vertices that must be rendered, and the number of operations that must be performed on each vertex.

If our game is GPU bound and we have established that it isn’t limited by fill rate or memory bandwidth, then it is likely that vertex processing is the cause of the problem. If this is the case, experimenting with reducing the amount of vertex processing that the GPU must do is likely to result in performance gains.

There are a few approaches we could consider to help us reduce the number of vertices or the number of operations that we are performing on each vertex.

1\. Firstly, we should aim to reduce any unnecessary mesh complexity. If we are using meshes that have a level of detail that cannot be seen in-game, or inefficient meshes that have too many vertices due to errors in creating them, this is wasted work for the GPU. The simplest way to reduce the cost of vertex processing is to create meshes with a lower vertex count in our 3D art program.

2\. We can experiment with a technique called normal mapping, which is where textures are used to create the illusion of greater geometric complexity on a mesh. Although there is some GPU overhead to this technique, it will in many cases result in a performance gain.<a href="https://docs.unity3d.com/Manual/StandardShaderMaterialParameterNormalMap.html" class="link-primary text-inherit"><span style="text-decoration:underline"> This page of the Unity Manual</span></a> has a useful guide to using normal mapping to simulate complex geometry in our meshes.

3\. If a mesh in our game does not make use of normal mapping, we can often disable the use of vertex tangents for that mesh in the mesh’s <a href="https://docs.unity3d.com/Manual/FBXImporter-Model.html" class="link-primary text-inherit"><span style="text-decoration:underline">import settings</span></a>. This reduces the amount of data that is sent to the GPU for each vertex.

4\. <a href="https://en.wikipedia.org/wiki/Level_of_detail" class="link-primary text-inherit"><span style="text-decoration:underline">Level of detail</span></a>, also known as LOD, is an optimization technique where meshes that are far from the camera are reduced in complexity. This reduces the number of vertices that the GPU has to render without affecting the visual quality of the game. <a href="https://docs.unity3d.com/Manual/class-LODGroup.html" class="link-primary text-inherit"><span style="text-decoration:underline">The LOD Group page of the Unity Manual</span></a> contains more information on how to set up LOD in our game.

5\. Vertex shaders are blocks of shader code that tell the GPU how to draw each vertex. If our game is limited by vertex processing, then reducing the complexity of our vertex shaders may help.

6\. If our game uses built-in shaders, we should aim to use the simplest and most optimized shaders possible for the visual effect we want. As an example, <a href="https://docs.unity3d.com/Manual/shader-Performance.html" class="link-primary text-inherit"><span style="text-decoration:underline">the mobile shaders that ship with Unity</span></a> are highly optimized; we should experiment with using them and see if this improves performance without affecting the look of our game.

7\. If our project uses bespoke shaders, we should aim to optimize them as much as possible. Optimizing shader is a complex subject, but<a href="https://docs.unity3d.com/Manual/SL-ShaderPerformance.html" class="link-primary text-inherit"><span style="text-decoration:underline"> this page of the Unity Manual</span></a> and the Shader optimization section of <a href="https://docs.unity3d.com/Manual/MobileOptimisation.html" class="link-primary text-inherit"><span style="text-decoration:underline">this page of the Unity Manual</span></a> contains useful starting points for optimizing our shader code.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 65. Conclusion

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

We’ve learned how rendering works in Unity, what sort of problems can occur when rendering and how to improve rendering performance in our game. Using this knowledge and our profiling tools, we can fix performance problems related to rendering and structure our games so that they have a smooth and efficient rendering pipeline.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

## Complete this Tutorial

Mark all steps complete
