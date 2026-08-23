---
title: "Porting Unity to CoreCLR"
page_title: "Porting Unity to CoreCLR"
source_url: "https://unity.com/blog/engine-platform/porting-unity-to-coreclr"
final_url: "https://unity.com/blog/engine-platform/porting-unity-to-coreclr"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Porting Unity to CoreCLR

<a href="https://unity.com/blog" class="text-xxs mt-8 flex items-center font-bold uppercase hover:underline"><span class="ml-1">Unity Blog</span></a>

# Porting Unity to CoreCLR

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">JOSH PETERSON / UNITY TECHNOLOGIES</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Senior Software Engineer</span>

<span class="mr-2">Oct 27, 2023</span><span class="mr-2">\|</span><span class="mr-2">10 Min</span>

Programming and DevOps

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

We’re still hard at work bringing the [latest .NET technology](https://blog.unity.com/technology/unity-and-net-whats-next) to Unity users. As one team member leading this effort, I’m excited to share further progress with you. Part of the work involves making existing Unity code work with the .NET CoreCLR JIT runtime, including a highly performant, more advanced, and more efficient garbage collector (GC).

This blog post covers recent changes we’ve made to allow the CoreCLR GC to work hand in hand with Unity engine native code. We’ll start at a high level, then get into more technical details.

A bit about garbage collectors

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Memory allocation done in the [C# language](https://devblogs.microsoft.com/dotnet/why-dotnet/) is managed by a garbage collector. Anytime memory allocation is required, the code allocating that memory can ignore the memory when it is no longer used. The GC will helpfully come by later and recycle that memory for other code to use.

Unity currently uses the [Boehm GC](https://github.com/Unity-Technologies/bdwgc), which is a conservative, non-moving GC. It will scan all thread stacks (including managed and native code) looking for managed objects to collect and once it allocates a managed object, the location of that object will never move in memory.

.NET uses the [CoreCLR GC](https://github.com/Potapy4/dotnet-coreclr/blob/master/Documentation/botr/garbage-collection.md), which is a precise, moving GC. It tracks allocated objects only in managed code, and will move them in memory to improve performance. This allows the CoreCLR GC to work with much less overhead and provide your game with better performance characteristics.

Both GCs are excellent at what they do, but they place different requirements on that code using them. The Unity engine and editor code have been developed based on the requirements of the Boehm GC, so to use the CoreCLR GC, we need to make a number of changes to the Unity code, including to the custom marshaling tools Unity wrote - the bindings generator and the proxy generator.

What does a garbage collector do, anyway?

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

You can think of managed code as a home in the city, where there is a coffee shop around the corner and a grocery store down the street. Let’s call it “Managed Code Landia.” For developers, this is a great place to live. But sometimes, we want to get away to the “Native Code Wildlands,” where C++ code can be found in its natural habitat.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

When traveling between the two, you can bring some managed memory, since the marshaling railroad allows a carry-on suitcase. Over in the Wildlands, you might want to pick up a souvenir and bring it home.

It’s convenient that the GC will dutifully follow and recycle any memory you might no longer be using, no matter where it is. But the GC has a lot of work to do. All of those threads and call stacks quickly add up. Many trips to the Native Code Wildlands later, and the GC is spending most of its time chasing you around.

Can we work together?

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Most of the work to port the Unity engine to CoreCLR is about making that engine code work with the GC, hand in hand.

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

The GC and the marshaling railroad have made an agreement not to let any managed memory cross over into the Native Code Wildlands. With that in place, the GC has much less work to do, leading to improved efficiency. The CoreCLR GC operates in this mode, knowing precisely what objects exist and only dealing with managed code. This also allows it to move objects around in memory for more efficiency.

How do we establish boundaries?

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Fun diagrams and emoji are cute, but we need to actually implement across a production code base that has evolved for more than a decade, with thousands of round trips from managed to native code and back.

Thinking about this from a systems design perspective, we need to find the boundaries. Unity has two important internal boundaries:

Calls from managed code to native code (similar to [p/invoke](https://learn.microsoft.com/en-us/dotnet/standard/native-interop/pinvoke)), through a tool called the Bindings Generator

Calls from native code to managed code (similar to Mono’s [runtime invoke](https://www.mono-project.com/docs/advanced/embedding/)), through a tool called the Proxy Generator

Both of these tools generate C++ and IL code to act as a railroad, shuffling memory between our two worlds. For the past year, developers at Unity have been modifying these two code generators to ensure they don’t allow GC-allocated objects to leak across the boundary, and provide useful diagnostics when that does happen. We have also been finding code that tries to brave the journey across the managed/native boundary itself, and we’re moving it to one of these code generators instead.

Of course, this is all happening while hundreds of other developers at Unity are actively changing the engine code, delivering new features and bug fixes to users. We’re looking to modify the rocket while it is in flight. To better understand how we’ve been able to make this transition incrementally, let’s dive deep into one aspect of this managed/native boundary: System.Object.

A System.Object by any other name

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Any memory allocated by the GC in .NET must be tied to an object of type [System.Object](https://learn.microsoft.com/en-us/dotnet/api/system.object?view=net-7.0). It’s the base class for all .NET types, so it is often the focal point of memory that crosses into native code. Unity Engine C++ code uses the ScriptingObjectPtr abstraction to represent a System.Object:

pre]:rounded-xl [&>pre]:!p-4">

```
typedef MonoObject* ScriptingBackendNativeObjectPtr;

class ScriptingObjectPtr 
    protected:
        ScriptingBackendNativeObjectPtr m_Target;
};
```

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

This is how that managed memory ends up in native code: ScriptingBackendNativeObjectPtr is a pointer to GC-allocated memory. Unity’s current GC traverses all call stacks in native code, conservatively looking for memory which might be a ScriptingObjectPtr. If we can change those instances to no longer be pointers to GC-allocated memory, then we can lower the burden on the GC and eventually change to the faster CoreCLR GC.

Three’s company

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Instead of having just one representation for ScriptingObjectPtr, we need it to have one of three possible representations:

GC-allocated pointer (the current representation)

Managed stack reference

[System.Runtime.InteropServices.GCHandle](https://learn.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.gchandle?view=net-7.0)

The **GC-allocated pointer** is a temporary step toward removing all GC-unsafe usages. It allows the ScriptingObjectPtr to continue functioning as it does currently. The intention is to remove this use case once all of the Unity code is safe for the CoreCLR GC.

The **managed stack reference** is an efficient way to represent an indirection to a managed object in the case where a value is passed from managed to native. The address of a GC-allocated pointer variable is passed to native code (rather than the GC-allocated pointer itself). This is GC-safe because the local address itself is not moved by the GC and the managed object is kept alive on a call stack in managed code. This approach is inspired by [a similar technique](https://github.com/dotnet/runtime/blob/main/src/libraries/System.Private.CoreLib/src/System/Runtime/CompilerServices/QCallHandles.cs#L22) used within the CoreCLR runtime.

The **GCHandle** serves as a strong indirection to a managed object, ensuring the object is not collected by the GC. If you happen to leave some memory in Managed Code Landia while you vacation in the Wildlands, the GC knows you want to preserve it until you come back. This is similar to the managed stack reference case, but requires explicit lifetime management. There is additional overhead due to the construction and destruction of a GCHandle. This overhead means we want to use this representation only where it is absolutely required.

This is implemented using a new type, ScriptingReferenceWrapper, which replaces ScriptingBackendNativeObjectPtr.

pre]:rounded-xl [&>pre]:!p-4">

```
struct ScriptingReferenceWrapper

    bool IsRef() const 
    bool IsHandle() const 
    uintptr_t value;
};
```

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

I’ve removed the many constructors or assignment operators here – they are used to enforce proper lifetime management of the internal resource.

Note the size of this type – it consists of only one uintptr_t value, which has the same size as a pointer, meaning ScriptingReferenceWrapper is the same size as ScriptingBackendNativeObjectPtr. Then, we can do a 1:1 replacement without code, with ScriptingObjectPtr knowing the difference.

The key here is the 4-byte alignment requirement mentioned in the code comment.Memory allocation done in the C# language is managed by a garbage collector. With that in place, we can reuse two bits of that value to indicate which of the three representations is used. The GetGCUnsafePtr and FromRawPtr methods then provide temporary interoperability for the GC-allocated pointer representation while we transition the Unity code.

Crossing the finish line

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

In an ideal world, the ScriptingObjectPtr abstraction would be unnecessary – managed memory would never show up in native code. But there are places where allowing this is useful, so we expect to complete the GC safety work in the engine, preserving managed stack reference and GCHandle cases and removing GC-allocated pointer cases entirely.

This is where the agreement between the GC and the code generators comes into play. Now that all three subsystems can understand the possible representations of ScriptingObjectPtr, our team is replacing the usages in the engine code incrementally. We can remove ScriptingObjectPtr where it is not necessary, and use the most efficient representation where it is. As long as each usage is changed end to end, the different representations can all live side by side and the rocket continues to fly.

With a fully GC-safe engine, we can enable the CoreCLR GC and ensure that it only needs to look for memory to recycle in Managed Code Landia, meaning it will do much less work and leave more time each frame for your code to execute.

*For more on Unity’s transition to CoreCLR, visit us in [the forums](https://forum.unity.com/threads/blog-post-porting-unity-to-coreclr.1508954/) or tune into Unite 2023 where we'll talk more about Unity's product roadmap. You can also connect with me directly on X at [@petersonjm1](https://twitter.com/petersonjm1?lang=en)*. Be sure to watch for new technical blogs from other Unity developers as part of the ongoing**[Tech from the Trenches](https://blog.unity.com/topic/tech-from-the-trenches) **[series](https://blog.unity.com/topic/tech-from-the-trenches)*.*
