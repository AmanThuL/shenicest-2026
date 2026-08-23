---
title: "Custom == operator, should we keep it? (Unity Blog)"
page_title: "Custom == operator, should we keep it?"
source_url: "https://unity.com/blog/engine-platform/custom-operator-should-we-keep-it"
final_url: "https://unity.com/blog/engine-platform/custom-operator-should-we-keep-it"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Custom == operator, should we keep it?

<a href="https://unity.com/blog" class="text-xxs mt-8 flex items-center font-bold uppercase hover:underline"><span class="ml-1">Unity Blog</span></a>

Product roadmap

# Custom == operator, should we keep it?

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">LUCAS MEIJER / UNITY TECHNOLOGIES</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Contributor</span>

<span class="mr-2">May 16, 2014</span><span class="mr-2">\|</span><span class="mr-2">5 Min</span>

Programming and DevOps

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

When you do this in Unity:

pre]:rounded-xl [&>pre]:!p-4">

```
if (myGameObject == null) 
```

Unity does something special with the == operator. Instead of what most people would expect, we have a special implementation of the == operator.

This serves two purposes:

1\) When a MonoBehaviour has fields, in the editor only\[1\], we do not set those fields to "real null", but to a "fake null" object. Our custom == operator is able to check if something is one of these fake null objects, and behaves accordingly. While this is an exotic setup, it allows us to store information in the fake null object that gives you more contextual information when you invoke a method on it, or when you ask the object for a property. Without this trick, you would only get a NullReferenceException, a stack trace, but you would have no idea which GameObject had the MonoBehaviour that had the field that was null. With this trick, we can highlight the GameObject in the inspector, and can also give you more direction: "looks like you are accessing a non initialised field in this MonoBehaviour over here, use the inspector to make the field point to something".

purpose two is a little bit more complicated.

2\) When you get a c# object of type "GameObject"\[2\], it contains almost nothing. this is because Unity is a C/C++ engine. All the actual information about this GameObject (its name, the list of components it has, its HideFlags, etc) lives in the c++ side. The only thing that the c# object has is a pointer to the native object. We call these c# objects "wrapper objects". The lifetime of these c++ objects like GameObject and everything else that derives from UnityEngine.Object is explicitly managed. These objects get destroyed when you load a new scene. Or when you call Object.Destroy(myObject); on them. Lifetime of c# objects gets managed the c# way, with a garbage collector. This means that it's possible to have a c# wrapper object that still exists, that wraps a c++ object that has already been destroyed. If you compare this object to null, our custom == operator will return "true" in this case, even though the actual c# variable is in reality not really null.

While these two use cases are pretty reasonable, the custom null check also comes with a bunch of downsides.

\- It is counterintuitive.

\- Comparing two UnityEngine.Objects to eachother or to null is slower than you'd expect.

\- The custom ==operator is not thread safe, so you cannot compare objects off the main thread. (this one we could fix).

\- It behaves inconsistently with the ?? operator, which also does a null check, but that one does a pure c# null check, and cannot be bypassed to call our custom null check.

Going over all these upsides and downsides, if we were building our API from scratch, we would have chosen not to do a custom null check, but instead have a myObject.destroyed property you can use to check if the object is dead or not, and just live with the fact that we can no longer give better error messages in case you do invoke a function on a field that is null.

What we're considering is wether or not we should change this. Which is a step in our never ending quest to find the right balance between "fix and cleanup old things" and "do not break old projects". In this case we're wondering what you think. For Unity5 we have been working on the ability for Unity to automatically update your scripts (more on this in a subsequent blogpost). Unfortunately, we would be unable to automatically upgrade your scripts for this case. (because we cannot distinguish between "this is an old script that actually wants the old behaviour", and "this is a new script that actually wants the new behaviour").

We're leaning towards "remove the custom == operator", but are hesitant, because it would change the meaning of all the null checks your projects currently do. And for cases where the object is not "really null" but a destroyed object, a nullcheck used to return true, and will if we change this it will return false. If you wanted to check if your variable was pointing to a destroyed object, you'd need to change the code to check "if (myObject.destroyed) {}" instead. We're a bit nervous about that, as if you haven't read this blogpost, and most likely if you have, it's very easy to not realise this changed behaviour, especially since most people do not realise that this custom null check exists at all.\[3\]

If we change it, we should do it for Unity5 though, as the threshold for how much upgrade pain we're willing to have users deal with is even lower for non major releases.

What would you prefer us to do? give you a cleaner experience, at the expense of you having to change null checks in your project, or keep things the way they are?

Bye, Lucas ([@lucasmeijer](https://web.archive.org/web/20240426162103/https://twitter.com/lucasmeijer))

\[1\] We do this in the editor only. This is why when you call GetComponent() to query for a component that doesn't exist, that you see a C# memory allocation happening, because we are generating this custom warning string inside the newly allocated fake null object. This memory allocation does not happen in built games. This is a very good example why if you are profiling your game, you should always profile the actual standalone player or mobile player, and not profile the editor, since we do a lot of extra security / safety / usage checks in the editor to make your life easier, at the expense of some performance. When profiling for performance and memory allocations, never profile the editor, always profile the built game.

\[2\] This is true not only for GameObject, but everything that derives from UnityEngine.Object

\[3\] Fun story: I ran into this while optimising GetComponent\<T>() performance, and while implementing some caching for the transform component I wasn't seeing any performance benefits. Then [@jonasechterhoff](https://web.archive.org/web/20240426162103/https://twitter.com/jonasechterhoff) looked at the problem, and came to the same conclusion. The caching code looks like this:

pre]:rounded-xl [&>pre]:!p-4">

```
private Transform m_CachedTransform
public Transform transform

}
```

Turns out two of our own engineers missed that the null check was more expensive than expected, and was the cause of not seeing any speed benefit from the caching. This led to the "well if even we missed it, how many of our users will miss it?", which results in this blogpost :)
