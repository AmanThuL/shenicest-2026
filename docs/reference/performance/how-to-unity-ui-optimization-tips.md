---
title: "Unity UI performance optimization tips"
page_title: "Unity UI performance optimization tips"
source_url: "https://unity.com/how-to/unity-ui-optimization-tips"
final_url: "https://unity.com/how-to/unity-ui-optimization-tips"
topic: "performance"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Optimization tips for Unity UI

Find out how to fully optimize your UI, with tips for dividing Canvases and Layout Groups, pooling UI objects, and more.

This is one of several pages providing in-depth guidance on how to optimize your PC and console games. You can find the full collection in the free e-book, [*Optimize your console and PC game performance*](https://create.unity.com/performance-optimization-e-book-console-PC?ungated=true), filled with over 80 actionable tips and best practices for performance optimization.

Split up your Canvases

Limit Graphic Raycasters and disable Raycast Target

Avoid the expensive UI Elements

Avoid layout groups when possible

Pool UI objects the smart way

How to hide a Canvas

Optimal use of animators on UI Elements

When using a fullscreen UI, hide everything else

More resources

Get the free e-book for more

## Split up your Canvases

**Problem: When a single element changes on the UI Canvas, it dirties the whole Canvas.**

The [Canvas](https://docs.unity3d.com/Packages/com.unity.ugui@1.0/manual/UICanvas.html) is the basic component of Unity UI. It generates meshes that represent the UI Elements placed on it, regenerates the meshes when UI Elements change, and issues draw calls to the GPU so that the UI is actually displayed.

Generating these meshes can be expensive. UI Elements need to be collected into batches so that they’re drawn in as few draw calls as possible. Because batch generation is expensive, we only want to regenerate them when necessary. The issue is that, when one or more elements change on a Canvas, the whole Canvas has to be analyzed once again, to figure out how to optimally draw its elements.

Many users build their entire game’s UI on a single Canvas with thousands of elements. When they change one element, they can experience a CPU spike costing multiple milliseconds. To learn more about why rebuilding is so expensive, go to the 24:55 mark in [this Unite session](https://youtu.be/_wxitgdx-UI).

**Solution: Split up your Canvases.**

Each Canvas is an island that isolates its elements from those of other Canvases. Take advantage of UGUI’s ability to support multiple Canvases by slicing up your Canvases to solve the batching problems with Unity UI.

You can also nest Canvases, which allows designers to create large hierarchical UIs, without having to think about where different elements are onscreen across Canvases. Child Canvases also isolate content from both their parent and sibling Canvases. They maintain their own geometry and perform their own batching. One way to decide how to split them up is based on how frequently they need to be refreshed. Keep static UI Elements on a separate Canvas, and dynamic Elements that update at the same time on smaller sub-Canvases. Also, ensure that all UI Elements on each Canvas have the same Z value, materials, and textures.

## Limit Graphic Raycasters and disable Raycast Target

**Problem: Inadequate use of the Graphic Raycaster**

The [Graphic Raycaster](https://docs.unity3d.com/Packages/com.unity.ugui@1.0/manual/script-GraphicRaycaster.html) is the component that translates your input into UI Events. More specifically, it translates screen clicks or onscreen touch inputs into UI Events, and then sends them to interested UI Elements. You need a Graphic Raycaster on every Canvas that requires input, including sub-Canvases. However, it also loops through every input point onscreen and checks if they’re within a UI’s RectTransform, resulting in potential overhead.

Despite its name, the Graphic Raycaster is not really a raycaster. By default, it only tests UI graphics. It takes the set of UI Elements that are interested in receiving input on a given Canvas and performs intersection checks. For instance, it checks if the point at which the input event occurs against the RectTransform of each UI Element on the Graphic Raycaster’s Canvas is marked as interactive.

The challenge is that not all UI Elements are interested in receiving updates.

**Solution: Remove Graphic Raycasters from non-interactive UI Canvases and turn off the Raycast Target for static or non-interactive elements.**

In particular, text on a button turning off the Raycast Target will directly reduce the number of intersection checks that the Graphic Raycaster must perform on each frame.

**Problem: Sometimes the Graphic Raycaster does act as a raycaster.**

If you set the Render mode on your Canvas to Worldspace Camera or Screen Space Camera, you can add a blocking mask. The blocking mask determines whether the Raycaster will cast rays via 2D or 3D physics, to determine if some physics object is blocking the user’s ability to interact with the UI.

**Solution: Casting rays via 2D or 3D physics can be expensive, so use this feature sparingly.**

Minimize the number of Graphic Raycasters by excluding them from non-interactive UI Canvases, since – in this case – there is no reason to check for interaction events.

Learn more about the Graphic Raycaster in [this documentation](https://docs.unity3d.com/Packages/com.unity.ugui@1.0/manual/script-GraphicRaycaster.html).

## Avoid the expensive UI Elements

**Problem: Large List, Grid views, and numerous overlaid UI Elements are costly.**

Large List and Grid views are expensive, and layering numerous UI Elements (i.e., cards stacked in a card battle game) creates overdraw.

**Solution: Avoid numerous overlaid UI Elements.**

Customize your code to merge layered UI Elements at runtime into fewer Elements and batches.

If you need to create a large List or Grid view, such as an inventory screen with hundreds of items, consider reusing a smaller pool of UI Elements rather than a single UI Element for each item.

Check out this [GitHub project](https://github.com/boonyifei/ScrollList) for an example of an optimized Scroll List.

## Avoid layout groups when possible

**Problem: Every UI Element that tries to dirty its layout will perform at least one GetComponent call.**

When one or more child UI Element(s) change on a layout system, the layout becomes “dirty.” The changed child Element(s) invalidate the layout system that owns it.

A layout system is a set of contiguous [layout groups](https://docs.unity3d.com/Packages/com.unity.ugui@1.0/manual/UIAutoLayout.html?utm_source=demand-gen&utm_medium=pdf&utm_campaign=asset-links-gmg-choose-unity-for-multiplatform&utm_content=optimize-game-performance-2020-lts-ebook) directly above a layout element. A layout element is not just the Layout Element component (UI images, texts, and Scroll Rects), it also comprises layout elements – just as Scroll Rects are also layout groups.

Now, regarding the problem at hand: Every UI Element that marks its layout as “dirty” will perform, at minimum, one GetComponent call. This call looks for a valid layout group on the layout element’s parent. If it finds one, it continues walking up the Transform hierarchy until it stops seeking layout groups or reaches the hierarchy root; whichever comes first. As such, each layout group adds one GetComponent call to each child layout element’s dirtying process, making the nested layout groups extremely bad for performance.

**Solution: Avoid layout groups when possible.**

Use Anchors for proportional layouts. On hot UIs with a dynamic number of UI Elements, consider writing your own code to calculate layouts. Be sure to use this on demand, rather than for every single change.

Learn more about layout groups in our [documentation](https://docs.unity3d.com/Packages/com.unity.ugui@1.0/manual/UIAutoLayout.html?utm_source=demand-gen&utm_medium=pdf&utm_campaign=asset-links-gmg-choose-unity-for-multiplatform&utm_content=optimize-game-performance-2020-lts-ebook).

## Pool UI objects the smart way

**Problem: Pooling UI objects the wrong way around**

People often pool UI objects by reparenting and then disabling them, which causes unnecessary dirtying.

**Solution: Disable the object first, then reparent it into the pool.**

You will dirty the old hierarchy once, but once you reparent it, you’ll avoid dirtying the old hierarchy a second time – and you won’t dirty the new hierarchy at all. If you’re removing an object from the pool, reparent it first, update your data, and then enable it.

Learn more about the concepts of basic [Object Pooling in Unity](https://learn.unity.com/tutorial/introduction-to-object-pooling).

## How to hide a Canvas

**Problem: Unsure how to hide a Canvas**

It’s sometimes useful to hide UI Elements and Canvases. But how can you do this efficiently?

**Solution: Disable the Canvas component itself.**

Disabling the Canvas component will stop the Canvas from issuing draw calls to the GPU. This way, the Canvas will no longer be visible. However, the Canvas won’t discard its vertex buffer, it will keep all of its meshes and vertices. Then when you re-enable it, it won’t trigger a rebuild – it will just start drawing them again.

Additionally, disabling the Canvas component does not trigger the expensive OnDisable/OnEnable callbacks via the Canvas hierarchy. Just be careful to disable child components that run expensive per-frame code.

Learn more about the Canvas Component [here](https://docs.unity3d.com/Packages/com.unity.ugui@1.0/manual/UICanvas.html).

## Optimal use of animators on UI Elements

**Problem: Using animators on your UI**

Animators will dirty their UI Elements on every frame, even if the value in the animation does not change.

**Solution: Use code for UI Animation.**

Only put animators on dynamic UI Elements that always change. For Elements that rarely change or that change temporarily in response to events, write your own code or use a tweening system. There are a number of great solutions for this available on the [Asset Store](https://assetstore.unity.com/?q=tweening&orderBy=1).

## When using a fullscreen UI, hide everything else

**Problem: Poor performance with fullscreen UI**

If your game displays a pause or start screen that fully covers the scene, the rest of the game is still being rendered in the background, which can impact performance.

**Solution: Hide everything else.**

If you have a screen that covers everything else in the scene, disable the Camera rendering the 3D scene. Similarly, disable Canvas elements hidden behind the top Canvas.

Consider lowering the Application.targetFrameRate during a fullscreen UI, since you shouldn’t need to update at 60 fps.

## More resources

[Optimize your console and PC game performance](https://create.unity.com/performance-optimization-e-book-console-PC?ungated=true)

[Accelerate Success webinar: The Unity UI Makeover](https://create.unity.com/unity-ui-makeover-webinar)

[Follow-up to Accelerate Success webinar: Unity UI Makeover Q&A](https://blog.unity.com/games/unitys-ui-webinar-follow-up-questions)

[How to optimize game performance with Camera usage – Part I](https://create.unity.com/accelerate-success-camera-usage-ebook)

[Top-rated GUI assets](https://assetstore.unity.com/tools/gui?q=gui&orderBy=5&rows=42)

[Support, services, savings: See your Unity Pro benefits](https://store.unity.com/products/unity-pro)

## Get the free e-book for more

Give your players the best possible gaming experience. With over 80 actionable tips and best practices from Unity’s expert engineers, you can optimize your PC and console games.

Created by Unity’s Success and [Unity Studio Productions](https://unity.com/solutions/unity-studio-productions) teams, more specifically, these detailed practices – gathered from real-life engagements with top studios – will help boost your game’s overall performance.

<a href="https://resources.unity.com/games/performance-optimization-e-book-console-pc" class="group/btn relative flex w-fit items-center justify-center gap-2 whitespace-nowrap rounded-full cursor-pointer font-mango-sans text-xs font-semibold tracking-[-0.01rem] box-border py-0 no-underline transition-[box-shadow,background-color,color,border-color,scale] duration-300 data-[pressed]:scale-95 data-[disabled]:cursor-not-allowed data-[disabled]:opacity-40 outline-hidden data-[focus-visible]:before:pointer-events-none data-[focus-visible]:before:absolute data-[focus-visible]:before:box-border data-[focus-visible]:before:inset-[-0.25rem] data-[focus-visible]:before:z-10 data-[focus-visible]:before:rounded-full data-[focus-visible]:before:border-2 data-[focus-visible]:before:border-mango-blue-focus data-[focus-visible]:before:content-[&#39;&#39;] border-0 bg-mango-blue-500 text-white btn-primary-shadow-default data-[hovered]:bg-mango-blue-600 data-[pressed]:bg-mango-blue-700 data-[pressed]:btn-primary-shadow-pressed h-[2.875rem] px-[1.625rem]"><span class="flex items-center justify-center gap-2 transition-all duration-300 group-data-[hovered]/btn:translate-x-0 group-hover/btn:translate-x-0 group-hover/button:translate-x-0 translate-x-2">Download the e-book<span class="grid h-3 w-3 shrink-0 place-items-center text-xs opacity-0 transition-all duration-300 group-data-[hovered]/btn:opacity-100 group-hover/btn:opacity-100 group-hover/button:opacity-100"></span></span></a>
