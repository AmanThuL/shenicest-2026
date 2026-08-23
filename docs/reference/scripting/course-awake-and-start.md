---
title: "Awake and Start (Unity Learn)"
page_title: "Start MonoBehaviour Methods"
source_url: "https://learn.unity.com/course/beginner-scripting/tutorial/awake-and-start"
final_url: "https://learn.unity.com/course/beginner-scripting/tutorial/awake-and-start"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Start MonoBehaviour Methods

![](https://cdn.sanity.io/images/fuvbjjlp/learn-production/e3a1497e8a517d0050257f257266eb8d45e1e7ea-400x225.jpg)

# Start MonoBehaviour Methods

Tutorial

Beginner

+10XP

5m

328

\(274\)

Unity Technologies

![Start MonoBehaviour Methods](https://connect-mediagw.unity.com/h1/20190701/learn/images/fd1b57eb-86cc-471d-bef2-63287fdaf526_Awake_and_Start.png)

Summary

How to use Awake and Start, two of Unity's initialization functions.

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 1. Overview

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

A lot of the scripting in Unity is done using MonoBehaviours. These are pieces of code that can be attached to GameObjects and usually run code related to the GameObject to which they are attached. An important part of coding with these scripts are the methods that are called automatically as the GameObject is initialized. These methods are Awake, OnEnable and Start. In this tutorial we will be looking at each of these methods and their differences.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 2. Before you begin

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

#### New to Unity?

If you’re new to Unity, welcome! The <a href="https://learn.unity.com/pathway/unity-essentials" class="link-primary text-inherit"><strong><span style="text-decoration:underline">Unity Essentials learning pathway</span></strong></a> has been designed to help you get set up and ready to create in the Unity Editor. We recommend you complete this pathway before continuing with <a href="https://learn.unity.com/project/beginner-gameplay-scripting" class="link-primary text-inherit"><span style="text-decoration:underline">Beginner Scripting</span></a>.

#### Review the Unity Editor basics

If you need to refresh your memory of the Unity Editor basics, you can take a moment to review <a href="https://learn.unity.com/tutorial/explore-the-unity-editor-1" class="link-primary text-inherit"><strong><span style="text-decoration:underline">Explore the Unity Editor</span></strong></a> at any time.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 3. Awake

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

The first method to be called on a MonoBehaviour is Awake. It is called as soon as the MonoBehaviour is loaded into the scene. This means that if the GameObject with the script already exists in the scene when it starts then Awake will be called immediately. Otherwise, if the GameObject with the script is instantiated or the script is added after the start of the scene, Awake will be called then.

#### Uses for Awake

Awake is only ever called once and so it is often best used for setting up any references between scripts that will exist for as long as the scene does.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 4. OnEnable

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

The second method to be called on a MonoBehaviour is OnEnable. It is called whenever the MonoBehaviour is enabled. This means that if the GameObject with the script already exists in the scene when it starts then OnEnable will be called just after Awake. Similarly to Awake, it will be called on MonoBehaviours for instantiated GameObjects or when a MonoBehaviour is added to a GameObject. Unlike Awake, OnEnable can be called multiple times over the life of the MonoBehaviour. It is called every time the script is enabled.

#### Uses for OnEnable

Since OnEnable is called whenever a script is starting to be used it is often best used for setting up things that exist or should happen while the MonoBehaviour is enabled. This might be something like a shield script that controls the visual aspects of a player’s shield. Whenever the script is disabled then the visuals for the shield are off but whenever the script is re-enabled, the visuals are shown. It is commonly paired with the OnDisable method for techniques like this. OnDisable is called whenever the MonoBehaviour’s enabled flag is set to false.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 5. Start

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

The third method to be called on a MonoBehaviour is Start. It is called right before Update is called for the first time. Since Update is only called when the MonoBehaviour is enabled, Start will be called after OnEnable the first time that the script is enabled. Like Awake, Start will only ever be called once, however unlike Awake and like OnEnable, Start will only be called on an enabled MonoBehaviour.

#### Uses for Start

Since Start is only called once, it should be used to initialize things that need to persist throughout the life of the script but should only need to be setup immediately before use. A common example is setting the initial value for a variable such as setting a current health variable to be the value of a starting health variable.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 6. An important note about usage

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

All games and applications are different. Even very similar ones can be implemented in wildly different ways. The examples given here are from common practices but might not fit what you are creating. When deciding which method should call your initialization code, think about when the method is called and what you need it to do.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 7. Summary

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

In this tutorial you learned about the beginning of the life-cycle of MonoBehaviour scripts and how to use the methods called then for initialization.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

## Complete this Tutorial

Mark all steps complete
