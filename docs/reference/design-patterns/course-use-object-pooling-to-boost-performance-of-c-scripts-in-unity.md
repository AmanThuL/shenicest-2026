---
title: "Use object pooling to boost performance of C# scripts in Unity (Unity 6)"
page_title: "Use object pooling to boost performance of C# scripts in Unity"
source_url: "https://learn.unity.com/course/design-patterns-unity-6/tutorial/use-object-pooling-to-boost-performance-of-c-scripts-in-unity"
final_url: "https://learn.unity.com/course/design-patterns-unity-6/tutorial/use-object-pooling-to-boost-performance-of-c-scripts-in-unity"
topic: "design-patterns"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Use object pooling to boost performance of C# scripts in Unity

![](https://cdn.sanity.io/images/fuvbjjlp/learn-production/e3a1497e8a517d0050257f257266eb8d45e1e7ea-400x225.jpg)

# Use object pooling to boost performance of C# scripts in Unity

Tutorial

intermediate

+10XP

20m

71

\(36\)

Unity Technologies

![Use object pooling to boost performance of C# scripts in Unity](https://connect-mediagw.unity.com/h1/20240304/learn/images/b9f7990c-a91c-4455-9633-96d10fb9f9be_image__1_.png)

Summary

By implementing common game programming design patterns in your Unity project, you can efficiently build and maintain a clean, organized, and readable codebase. Design patterns not only reduce refactoring and time spent testing, but they also speed up onboarding and development processes, contributing to a solid foundation that can be used to grow your game, development team, and business.

Think of design patterns not as finished solutions you can copy and paste into your code, but as extra tools that, when used correctly, can help you build larger, scalable applications.

This tutorial explains object pooling and how it can help improve the performance of your game. It includes an example of how to implement Unity’s built-in object pooling system in your projects.

The content here is based on the free e-book, <a href="https://unity.com/resources/design-patterns-solid-ebook?isGated=false" class="link-primary text-inherit">Level up your code with design patterns and SOLID</a>, which explains well known design patterns and shares practical examples for using them in your Unity project.

Other articles in the Unity game programming patterns series are available on the <a href="https://unity.com/how-to" class="link-primary text-inherit">Unity best practices</a> hub, or you can check out the following links:

-   <a href="https://learn.unity.com/tutorial/65df7f9bedbc2a083a63757b?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit">The state pattern</a>
-   <a href="https://learn.unity.com/tutorial/65de086fedbc2a06ac2aca58?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit">The observer pattern</a>
-   <a href="https://learn.unity.com/tutorial/65e0df08edbc2a2447bf0b98?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit">The factory pattern</a>
-   <a href="https://learn.unity.com/tutorial/65e0cfacedbc2a2351773054?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit">The MVC and MVP patterns</a>
-   <a href="https://learn.unity.com/tutorial/65e0e048edbc2a23a5ee7442?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit">The command pattern</a>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 1. Level up your code: Object pool

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Before you begin this tutorial, check out the video below for a brief overview of how you can use object pooling, how it can provide performance optimization by reducing the processing power required of the CPU to run repetitive create and destroy calls, and how to use it in your Unity projects.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 2. Overview

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

By implementing common game programming design patterns in your Unity project, you can efficiently build and maintain a clean, organized, and readable codebase. Design patterns not only reduce refactoring and time spent testing, but they also speed up onboarding and development processes, contributing to a solid foundation that can be used to grow your game, development team, and business.

Think of design patterns not as finished solutions you can copy and paste into your code, but as extra tools that, when used correctly, can help you build larger, scalable applications.

This tutorial explains object pooling and how it can help improve the performance of your game. It includes an example of how to implement Unity’s built-in object pooling system in your projects.

The content here is based on the free e-book, <a href="https://unity.com/resources/design-patterns-solid-ebook?isGated=false" class="link-primary text-inherit">Level up your code with design patterns and SOLID</a>, which explains well known design patterns and shares practical examples for using them in your Unity project.

Other articles in the Unity game programming patterns series are available on the <a href="https://unity.com/how-to" class="link-primary text-inherit">Unity best practices</a> hub, or you can check out the following links:

-   <a href="https://learn.unity.com/tutorial/65df7f9bedbc2a083a63757b?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit">The state pattern</a>
-   <a href="https://learn.unity.com/tutorial/65de086fedbc2a06ac2aca58?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit">The observer pattern</a>
-   <a href="https://learn.unity.com/tutorial/65e0df08edbc2a2447bf0b98?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit">The factory pattern</a>
-   <a href="https://learn.unity.com/tutorial/65e0cfacedbc2a2351773054?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit">The MVC and MVP patterns</a>
-   <a href="https://learn.unity.com/tutorial/65e0e048edbc2a23a5ee7442?uv=2022.3&amp;projectId=65de084fedbc2a0699d68bfb" class="link-primary text-inherit">The command pattern</a>

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 3. Understanding object pooling in Unity

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Object pooling is a design pattern that can reduce garbage collection overhead and CPU load by pooling and reusing GameObjects rather than repeatedly creating and destroying them.

The key feature of object pooling is to create GameObjects in advance and store them in a pool, rather than creating and destroying them on demand. When a GameObject is needed, it’s taken from the pool and used. When no longer needed, it’s returned to the pool rather than being destroyed.

The following image shows the **Hierarchy** window displaying a sample project that fires projectiles from a gun turret, which is a common use case for object pooling. Let’s unpack this example step-by-step.

![](https://connect-mediagw.unity.com/h1/20240301/learn/images/d627e0fa-de09-4ed7-9b6e-9c6e12df2e7c_Copy_of_4-2_Hierarchy.png)

Instead of creating and then destroying GameObjects, the object pool pattern uses a set of initialized objects stored in a deactivated pool. The pattern then pre-instantiates all the required objects at a specific moment before gameplay. The pool should be activated at an appropriate time when users won’t notice the stutter, such as during a loading screen.

Once the GameObjects from the pool have been used, they’re deactivated and ready to use when the game needs them again. When an object is needed, your application doesn’t need to instantiate it first. Instead, it can request the object from the pool, activate and deactivate it, and then return it to the pool instead of destroying it.

This pattern can reduce the garbage collection overhead, as explained in the next section.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 4. Memory allocation

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Before looking at examples of how to use object pooling, let’s consider the root problem it helps to address.

The pooling technique is not just useful for reducing CPU cycles spent on instantiation and destruction. It also optimizes memory management by reducing the overhead of allocating and deallocating memory, and calling constructors and destructors.

### Managed memory in Unity

Unity’s C# scripting environment uses a managed memory system to manage the release of memory so you don’t need to manually request it through your code. The memory management system also helps guard memory access, ensures that memory you no longer use is freed, and prevents access to memory that is not valid for your code.

Unity uses a <a href="https://docs.microsoft.com/en-us/dotnet/standard/garbage-collection/fundamentals" class="link-primary text-inherit">garbage collector</a> to reclaim memory from objects that your application and the Unity Editor are no longer using. However, this also impacts runtime performance, because allocating managed memory is time consuming for the CPU, and garbage collection might stop the CPU from doing other work until it completes its task.

Every time you create a new object or destroy an existing object in Unity, memory is allocated and deallocated. This can cause garbage collection spikes that lead to in-game stuttering. It can also cause memory fragmentation that makes it harder to find sections of free contiguous memory.

Learn more about memory management in our <a href="https://resources.unity.com/games/ultimate-guide-to-profiling-unity-games?ungated=true" class="link-primary text-inherit">advanced profiling guide</a>.

![](https://connect-mediagw.unity.com/h1/20240301/learn/images/8165d405-a7d2-4759-865d-b69cdaed59da_Unity-Profiling-Ebook-AdsSocial.jpg.png)

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 5. Using UnityEngine.Pool

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Although you can create your own custom system to implement object pooling, from Unity 2021 LTS onwards there is a built-in <a href="https://docs.unity3d.com/ScriptReference/Pool.ObjectPool_1.html" class="link-primary text-inherit"><strong>ObjectPool&lt;T0&gt;</strong></a> class in the **UnityEngine.Pool** namespace. For more information about this class and how to use it, refer to <a href="https://docs.unity3d.com/Manual/performance-reusable-code.html" class="link-primary text-inherit">Pooling and reusing objects</a> in the Unity manual.

Let’s explore how to use the built-in object pooling system using the **ObjectPool\<T0>** class with this <a href="https://assetstore.unity.com/packages/essentials/tutorial-projects/level-up-your-code-with-design-patterns-and-solid-289616" class="link-primary text-inherit">sample project</a> on the Unity Asset Store. Once you open the sample project, go to **Assets**＞**7 Object Pool** **＞Scripts** ＞ **ExampleUsage2021** for the files.

**Note**: The sample uses the older Input Manager for its input handling. To ensure it works in newer versions of Unity, go to **Edit** \> **Project Settings** \> **Player** and under **Configuration**, set **Active Input Handling** to **Both**.

This example consists of a turret rapidly firing projectiles (set to 10 projectiles per second by default) when the left mouse button is pressed. Each projectile travels across the screen and needs to be destroyed when it leaves the screen. Without object pooling, this can create a considerable drag on the CPU and memory management, as explained in the previous section.

By using object pooling, you can create the visual effect of hundreds of unique bullets being fired offscreen when actually the same 10 projectiles are continually deactivated and reused.

![](https://connect-mediagw.unity.com/h1/20240301/learn/images/b500c399-79c1-4f33-893a-eb03a48c8f84_Copy_of_Copy_of_4-1_ObjectPoolSampleProject.png)

The code in the example script ensures the pool size is large enough to meet the demand for concurrently active objects, which disguises the fact that the same objects are being continually reused.

If you’ve used Unity’s Built-In Particle System, then you have first-hand experience with an object pool. The <a href="https://docs.unity3d.com/Manual/class-ParticleSystem.html" class="link-primary text-inherit"><strong>Particle System</strong> component</a> contains a setting for the maximum number of particles. This recycles available particles, preventing the effect from exceeding a maximum number. The object pool works similarly, but with any GameObject of your choosing.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 6. Unpacking RevisedGun.cs

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Let’s examine the code in **RevisedGun.cs**, which is located in the <a href="https://assetstore.unity.com/packages/essentials/tutorial-projects/level-up-your-code-with-design-patterns-and-solid-289616" class="link-primary text-inherit">sample project</a> in **Assets**＞**7 Object Pool** ＞**Scripts** ＞ **ExampleUsage2021**.

The first thing to notice is the inclusion of the **UnityEngine.Pool** namespace:

```
using UnityEngine.Pool; 
```

The **UnityEngine.Pool** namespace includes a stack-based **ObjectPool\<T0>** class to track objects with the object pool pattern. It also has a **<a href="https://docs.unity3d.com/ScriptReference/Pool.CollectionPool_2.html" class="link-primary text-inherit">CollectionPool&lt;T0,T1&gt;</a>** class (**List**, **HashSet**, **Dictionary**, etc.) and pools for other collection types.

Next, you apply specific settings for your gun-firing characteristics, including the prefab to spawn (named **projectilePrefab** of the type **RevisedProjectile**). The **ObjectPool** interface is referenced from **RevisedProjectile.cs** (which is explained in the next section) and initialized in the **Awake** function.

```
private void Awake()

```

Parameters supplied to the <a href="https://docs.unity3d.com/ScriptReference/Pool.ObjectPool_1-ctor.html" class="link-primary text-inherit"><strong>ObjectPool&lt;T0&gt; constructor</strong></a> configure the key features of the pool. The constructor provides the ability to define custom logic for the following events:

-   First creating a pooled item to populate the pool.
-   Taking an item from the pool.
-   Returning an item to the pool.
-   Destroying a pooled object (for example, if you hit a maximum limit).

The constructor also includes parameters for both a default and maximum pool size, the latter being the maximum number of items stored in the pool. If you call <a href="https://docs.unity3d.com/ScriptReference/Pool.ObjectPool_1.Release.html" class="link-primary text-inherit"><strong>ObjectPool&lt;T0&gt;.Release</strong></a> and the pool is already at its defined maximum size, the released object is destroyed.

Let’s examine how the code example uses these constructor parameters to specify how the object pool behaves.

The **CreateProjectile** method is called to create a new instance when the pool is empty, and is passed to the **ObjectPool** constructor as the **createFunc** parameter**.** In this case it simply instantiates a new projectile prefab:

```
private RevisedProjectile CreateProjectile()

```

The **OnGetFromPool** method is called when you request an instance of the GameObject, and is passed to the constructor as the **actionOnGet** parameter. You typically use this method to set the GameObject you’re getting from the pool to active:

```
private void OnGetFromPool(RevisedProjectile pooledObject)

```

The **OnReleaseToPool** method is called when you release an object back to the pool by calling **ObjectPool\<T0>.Release**, and is passed to the constructor as the **actionOnRelease** parameter. In this case the method simply deactivates the returned GameObject, which prevents the object continuing to receive **Update** calls when it’s in the pool:

```
private void OnReleaseToPool(RevisedProjectile pooledObject)

```

The **OnDestroyPooledObject** method is called when you exceed the maximum number of pooled items allowed, and is passed to the constructor as the **actionOnDestroy** parameter. When the pool is already full, the object will be destroyed:

```
private void OnDestroyPooledObject(RevisedProjectile pooledObject)

```

If true, the **collectionCheck** parameter turns on collection safety checks that throw an exception when you try to release a GameObject that has already been returned to the pool. Note that this check is only performed in the Editor. Turning this off can save some CPU cycles but means there’s a risk of getting an object returned that has already been reactivated.

The **defaultCapacity** parameter is the default size, as a number of object instances, of the stack-like structure that contains your elements. The **maxSize** parameter defines the maximum size of the stack, and the created pooled GameObjects should never exceed this size. If you try to return an object to a pool that is at **maxSize**, the object is destroyed.

Finally, in **FixedUpdate** you’ll get a pooled object instead of instantiating a new projectile every time you run the logic for firing a bullet:

```
using UnityEngine.Pool;

public class RevisedGun : MonoBehaviour

    // invoked when creating an item to populate the object pool
    private RevisedProjectile CreateProjectile()
    
    // invoked when returning an item to the object pool
    private void OnReleaseToPool(RevisedProjectile pooledObject)
    
    // invoked when retrieving the next item from the object pool
    private void OnGetFromPool(RevisedProjectile pooledObject)
    
    // invoked when we exceed the maximum number of pooled items (i.e. destroy the pooled object)
    private void OnDestroyPooledObject(RevisedProjectile pooledObject)
    
    private void FixedUpdate()
    
}
```

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 7. Unpacking RevisedProjectile.cs

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

Now let’s examine the **RevisedProjectile.cs** script:

```
// projectile revised to use UnityEngine.Pool in Unity 2021
    public class RevisedProjectile : MonoBehaviour
    
        public void Deactivate()
        
        IEnumerator DeactivateRoutine(float delay)
        
    }
```

Besides setting up a reference to the **ObjectPool**, which makes releasing the object back to the pool more convenient, there are a few additional features to note.

The **timeoutDelay** variable is used to keep track of when the projectile has been used and can be returned to the pool again. This happens by default after three seconds.

The **Deactivate** method activates a coroutine called **DeactivateRoutine**, which releases the projectile back to the pool with **objectPool.Release** and resets the moving Rigidbody velocity parameters

This process addresses the problem of dirty items, which are objects that were previously used and need to be reset back to a clean state.

As you can see in this example, <a href="https://docs.unity3d.com/ScriptReference/Pool.ObjectPool_1.html" class="link-primary text-inherit"><strong>ObjectPool&lt;T0&gt;</strong></a> makes setting up object pools efficient, because you don’t have to rebuild the pattern from scratch, unless you have a specific use case for doing so.

You’re not limited to GameObjects only. Pooling is a performance optimization technique for reusing any type of C# entity: a GameObject, an instanced prefab, a C# dictionary, and so on.

Unity offers some alternative pooling classes for other entities, such as the **<a href="https://docs.unity3d.com/ScriptReference/Pool.DictionaryPool_2.html" class="link-primary text-inherit">DictionaryPool&lt;T0,T1&gt;</a>,** which offers support for Dictionaries, and **<a href="https://docs.unity3d.com/ScriptReference/Pool.HashSetPool_1.html" class="link-primary text-inherit">HashSetPool&lt;T0&gt;</a>** for HashSets.

The **<a href="https://docs.unity3d.com/ScriptReference/Pool.LinkedPool_1.html" class="link-primary text-inherit">LinkedPool&lt;T0&gt;</a>** class uses a linked list to hold a collection of object instances for reuse, which may lead to better memory management (depending on your case) since you only use memory for the elements that are actually stored in the pool.

In comparison, **<a href="https://docs.unity3d.com/ScriptReference/Pool.ObjectPool_1.html" class="link-primary text-inherit">ObjectPool&lt;T0&gt;</a>** simply uses a C# stack and a C# array underneath and as such, contains a big chunk of contiguous memory. The drawback is that you spend more memory per item and more CPU cycles to manage this data structure in the **<a href="https://docs.unity3d.com/ScriptReference/Pool.LinkedPool_1.html" class="link-primary text-inherit">LinkedPool&lt;T0&gt;</a>** than in **<a href="https://docs.unity3d.com/ScriptReference/Pool.ObjectPool_1.html" class="link-primary text-inherit">ObjectPool&lt;T0&gt;</a>** where you can use the **defaultSize** and **maxSize** constructor parameters to configure what you need.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 8. Other ways to implement object pooling

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

As this tutorial illustrates, object pooling is commonly used when a weapon needs to fire multiple projectiles, but how you use object pools will vary by application.

A good general rule is to profile your code every time you instantiate a large number of objects, since you run the risk of causing a garbage collection spike. If you detect significant spikes that put your gameplay at risk of stuttering, consider using an object pool. However, bear in mind that object pooling can add more complexity to your codebase due to the need to manage the multiple life cycles of the pools. Additionally, you can end up reserving memory your gameplay doesn’t need if you create pools prematurely.

As mentioned earlier, there are several other ways to implement object pooling outside of the example included in this tutorial. One way is to create your own implementation that you can customize to your needs. If you do this, you’ll need to be mindful of the complications of type and thread safety, as well as defining custom object allocation/deallocation. The <a href="https://assetstore.unity.com/" class="link-primary text-inherit">Unity Asset Store</a> offers some great alternatives to save you time.

###  More advanced resources for programming in Unity

![](https://connect-mediagw.unity.com/h1/20240301/learn/images/04719a8e-0fab-401f-8799-03e6f9491bea_Blog_Post_800x450.jpg)

The e-book, <a href="https://unity.com/resources/design-patterns-solid-ebook?isGated=false" class="link-primary text-inherit">Level up your code with design patterns and SOLID</a>, provides a more thorough example of a simple custom object pool system. Unity Learn also offers an **<a href="https://learn.unity.com/tutorial/introduction-to-object-pooling" class="link-primary text-inherit">Introduction to Object Pooling</a>** tutorial and an <a href="https://learn.unity.com/tutorial/introduction-to-object-pooling-2019-3" class="link-primary text-inherit"><strong>Introduction to Object Pooling - 2019.3</strong></a> tutorial for guidance on how to use the new built-in object pooling system in 2021 LTS.

All advanced technical e-books and articles are available on the <a href="https://unity.com/how-to" class="link-primary text-inherit">Unity best practices</a> hub. The e-books are also available on the <a href="https://docs.unity3d.com/Manual/best-practice-guides.html" class="link-primary text-inherit">advanced best practices</a> page in documentation.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

## Complete this Tutorial

Mark all steps complete
