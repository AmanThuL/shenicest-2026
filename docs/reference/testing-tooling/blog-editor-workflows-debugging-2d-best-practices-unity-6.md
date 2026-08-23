---
title: "Tips on Editor workflows, debugging, graphics, art assets, and 2D best practices in Unity 6"
page_title: "Tips on Editor workflows, debugging, and 2D best practices in Unity 6"
source_url: "https://unity.com/blog/editor-workflows-debugging-2d-best-practices-unity-6"
final_url: "https://unity.com/blog/editor-workflows-debugging-2d-best-practices-unity-6"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Tips on Editor workflows, debugging, and 2D best practices in Unity 6

<a href="https://unity.com/blog" class="text-xxs mt-8 flex items-center font-bold uppercase hover:underline"><span class="ml-1">Unity Blog</span></a>

# Tips on Editor workflows, debugging, graphics, art assets, and 2D best practices in Unity 6

<span class="text-gray-900 dark:text-gray-100 pb-1 loco-caption-lg-semibold">MIRUNA DUMITRASCU / UNITY TECHNOLOGIES</span><span class="text-gray-700 dark:text-gray-300 tracking-normal loco-text-body-xs-semibold">Senior Content Marketing Manager</span>

<span class="mr-2">Jul 25, 2025</span>

Programming and DevOps

Game design

2D applications

Testing and performance

Target platforms

XR

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

If you're using Unity every day, you know how important it is to work efficiently. Our goal is to help you make the most of the tools so you can get more done in less time.

This updated 100+ pages guide offers tips to speed up your workflows throughout every stage of game development, and it's useful whether you're just starting out or if you've been a Unity developer for years.

Read on to get the highlights from the *[Tips to increase productivity with Unity 6](https://unity.com/resources/tips-improve-productivity-workflow-unity-6)* e-book.

### What's in the guide?

Speed up your development with Editor workflows

Double-click on Scene in the Editor

After double-clicking on Scene in the Editor

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

This chapter covers tips on how to navigate the Editor more quickly, focusing on the Editor interface. Some of the topics include but are not limited to customizing preferred shortcuts, working with multiple Inspectors, defining your preferred default settings with Presets and more.

Do you want to focus on a specific Editor window? Double-click any tab (**Project**, **Scene**, **Game**, etc.) to go full screen in Unity.

Tips on working with the 2D tools

The Sprite Custom Lit Shader in the 'Gem Hunter Match' sample

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

In this chapter, you’ll find tips and best practices for creating 2D games, working with lighting, sprite libraries, and more. The tips are based on learning points from Unite talks and the 2D samples [*Dragon Crashers*](https://assetstore.unity.com/packages/essentials/tutorial-projects/dragon-crashers-urp-2d-sample-project-190721), [*Happy Harvest*](https://assetstore.unity.com/packages/essentials/tutorial-projects/happy-harvest-2d-sample-project-259218), [*Gem Hunter Match*](https://assetstore.unity.com/packages/essentials/tutorial-projects/gem-hunter-match-2d-sample-project-278941?srsltid=AfmBOoqmcT9YHU_GjtC8iWyfbIZtG0fgz7CyB3HFZmueknRd5OL_fuNX).

If you're looking to create lighting effects that are independent of global scene lights, consider using [a Sprite Custom Lit shader](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@12.0/manual/2d-customlit.html?q=2D%20Light%20Texture%20Node). This shader substitutes for scene lighting, allowing you to modify the 2D light texture information and control the lighting on each piece. The result is creative illumination of the sprites, like a shimmery effect that moves over pieces in a match 3 game.

Get best practices for URP, HDRP, and creating art assets

Use trim sheet for various meshes across an environment

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

In this section of the guide, we cover how to configure different URP or HDRP settings in your Unity project, a few techniques to fix light leaks, as well as managing shader, prefab and material variants, tips for asset creation and preparation, and many more.

Did you know that you can use trim sheets for optimizing your project’s performance? It reduces the number of individual textures required, while still allowing for visually complex and varied designs on the models.

Build user interfaces with UI Toolkit

Templates are reusable UXML files and are available in the Library pane in the Project tab

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Here you’ll learn about how to use UI Toolkit to work more effectively with UI design, using native OS emojis in your project, or integrating localization early on in your game to reach more markets.

Did you know that you can use UXML files similar to prefabs? For example, you could have a project with a UXML layout that contains an item icon and count number that you need to spawn many times inside an inventory.

If you right-click on any UXML you get the option to create a template, which can later be added to any other visual element in the Hierarchy pane or instantiated from code. Once created you can find it in your Library and Project view.

Debug your projects in Unity more effectively

The Console Log Entry option allows you to set the number of lines in your log

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

In this chapter, you’ll find a few quick tips on debugging in Unity, such as configuring your Console Log Entry for improved readability.

By default, the Console Log Entry shows two lines. For improved readability, you can configure this to be more streamlined with one or multiple lines depending on your preferences (see the image above).

Get familiar with DevOps workflows for better team collaboration

The Shelves tab in the Unity Version Control window

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

Here you’ll learn more about [Unity Version Control](https://unity.com/solutions/version-control), [Build Automation](https://unity.com/solutions/ci-cd), [Build Server,](https://unity.com/products/unity-build-server) as well as the [Asset Manager](https://unity.com/products/asset-manager), for better and more efficient team collaboration.

If you’re already familiar with Unity Version Control, did you know that you can work on multiple branches in parallel, without losing your work, with the **Shelve and Switch** option?

Starting with [UVCS package version 2.7.1](https://docs.unity3d.com/Packages/com.unity.collab-proxy@2.7/changelog/CHANGELOG.html), you can use shelvesets to temporarily save your current changes when switching between branches, to make sure your unfinished work is safely stored and easily accessible.

Download the e-book

<a href="https://unity.com/resources/tips-improve-productivity-workflow-unity-6" class="cursor-pointer inline-block items-center outline-hidden overflow-x-hidden btn-primary btn-md caption-sm-bold px-3 py-2.5 inline-flex rounded-full btn-arrow"></a>

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Tips to increase your productivity with Unity 6</span>

More resources

*]:text-body [&>*]:mb-4 [&>h3]:font-semibold">

You can download many more e-books for advanced Unity developers and creators from [the Unity best practices hub](https://unity.com/how-to). Choose from over 30 guides, created by industry experts, and Unity engineers and technical artists, that provide best practices for efficient game development with Unity’s toolsets and systems.

## Check out the latest technical e-books

[](https://unity.com/resources/ultimate-guide-to-profiling-unity-games-unity-6)

E-book

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Read More</span>

### Ultimate guide to profiling Unity games (Unity 6 edition)

2025-07-11

[](https://unity.com/resources/dots-concepts-features-samples-resources-unity-6)

E-book

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Read More</span>

### Introduction to DOTS concepts, features, & samples for advanced Unity developers (Unity 6 edition)

2025-05-15

[](https://unity.com/resources/scalable-performant-ui-uitoolkit-unity-6)

E-book

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Read More</span>

### Create scalable and performant UI with UI Toolkit in Unity 6

2025-04-22

[](https://unity.com/resources/create-shaders-visual-effects-urp-unity-6)

E-book

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Read More</span>

### Create popular shaders and visual effects with the Universal Render Pipeline (Unity 6 edition)

2025-03-26

[](https://unity.com/resources/c-sharp-style-guide-unity-6)

E-book

<span class="btn-label transition-spacing flex duration-300 ease-in-out">Read More</span>

### Use a C# style guide for clean and scalable game code (Unity 6 edition)

2025-01-21
