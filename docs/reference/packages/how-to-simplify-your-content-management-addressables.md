---
title: "Simplify your content management with Addressables"
page_title: "Simplify your content management with Addressables | Video game development"
source_url: "https://unity.com/how-to/simplify-your-content-management-addressables"
final_url: "https://unity.com/how-to/simplify-your-content-management-addressables"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Simplify your content management with Addressables

Learn how the Addressable Asset System can simplify your content management at both edit and runtime so your game’s initial and updated releases are smoother and easier. This article is based on a talk by Bill Ramsour, from the Live Content team, delivered at Unite Copenhagen 2019.

Addressables overview

The Addressables workflow

Addressables Groups

Production

Editor Hosting

How to load assets in Addressables

Customizing your build

Where can I learn more about Addressables?

Cloud Content Delivery: The last mile

## Addressables overview

The Addressable Asset System (i.e., Addressables) is a Unity Editor and runtime asset management system that improves support for large production teams with complex live content delivery needs. The system uses asynchronous loading to support loading from any location with any collection of dependencies. By packing asset bundles more efficiently and reducing iteration time, Addressables provides a simple way to make your game more dynamic.

Addressables addresses developers’ challenges such as iteration time, dependency management, memory management, and content packing.

## The Addressables workflow

Once an asset (e.g., a Prefab) is marked “addressable,” it generates an address that can be called from anywhere. Wherever the asset resides (local or remote), the system will locate it and its dependencies, then return it. An asset is content that you use to create your game or app. Common examples of assets include Prefabs, textures, materials, audio clips, and animations.

Addressables abstracts asset bundles to make content management more efficient, while containing the asset and all of its underlying data.

In the Addressables workflow, the request first passes through the Catalog system. The system decodes the address into a location, which consists of the data generated during the build about what the asset is, its dependencies, whether it’s local or remote and so on.

From the Catalog, the request passes through the Provider system. One or more providers use those locations to find the content and then return it to the device.

In Addressables, the runtime is asynchronous. This gives you the flexibility to retrieve an asset when you need it, no matter where it is – its location may change depending what stage of development you are in – without having to change the game code.

## Addressables Groups

When you mark something as an addressable, it becomes part of an Addressables Group, which is a container for the addressable assets and their data. You can visualize the groups in the Groups window, which is the home base for Addressables. Groups can determine whether or not that asset is going to be local to a device or up on a server.

The data on Addressables Groups is held in schemas, which are data contracts. One of the schemas focuses on how your assets and content will be built into bundles. **Build Path** and **Load Path** are among the more useful settings, allowing you to set your content to be local or remote by selecting a variable from the drop-down menus.

In the Addressables Profile system, you create a profile for an Addressables Group, and then you define for a given profile what you want the variables to evaluate to. This allows you to set the data on your group and make changes to it remotely without having to recode any part of that group.

## Production

To get the most out of Addressables, it helps to visualize your data in terms of how you want to ship your game. You don’t have to commit to a structure, because it’s easy to change Profile variables during development, but you should have a general approach to organizing your bundles.

For example, if you want to ship your game with remote content but you want that content to be local during development, you can create a profile where the remote paths point to the streaming assets. In this way, you can globally change all of your remote content to become local without touching the group’s code.

## Editor Hosting

Sometimes you need to host content on a server. You can set up a remote path and, instead of pointing to the actual URL, use the variables defined by your hosting service.

When you enable hosting, the Hosting Service sets up an HTTP host within the Editor. You can connect your device or player to this host so you can test things out.

One powerful feature of Editor hosting is that you can set everything to be remote. This is especially useful for content developers and artists, because you can build a player and deploy it to your device while you continue to iterate your content. You don’t have to redeploy your player or worry about moving content from one device to another. Check out our [documentation](https://docs.unity3d.com/Packages/com.unity.addressables@0.4/manual/AddressableAssetsHostingServices.html) to learn more about creating and configuring Hosting Services with Addressables.

With many of the key technical challenges of supporting dynamic content solved by Addressables, the “last mile” problem still remains – the hosting and delivery of assets to live production games and apps. Later this year, we will be launching an enterprise ready, global content hosting solution, fully integrated into the Addressables system. If you would like to learn more about this service, [sign up here](https://create.unity3d.com/contenthostingsignup).

## How to load assets in Addressables

The Live Content Team has been working on workflows to speed things up for you, including a few fast ways to load assets.

**How can you load assets in Addressables?**

**By address:** Coders will often load addressables by string, using the asset’s location identifier for easy runtime retrieval.

**By label:** Provides an additional Addressable Asset identifier for runtime loading of similar items.

**By AssetReference:** The AssetReference operates like a direct reference, but with deferred initialization. The AssetReference object stores the GUID as an addressable that you can load on demand. Artists [working in the Editor](https://unity.com/products/core-platform) may prefer this workflow.

If the asset you’re referencing has sub-objects (such as sprites within a SpriteAtlas) you can further reference the sub-object.

If you want to see Addressables and the sprite loading process in action, check out the [Sprite demo part](https://youtu.be/THs7h-wXHBg?t=1029) of the session.

## Customizing your build

The Addressables package has three build scripts that create Play Mode data to help you accelerate app development. The scripts are *Use Asset Database, Simulate Groups*, and *Use Existing Build*.

The *Use Asset Database* script. This lets you move in and out of Play Mode while you’re iterating on content; you can run the game quickly as you work through the flow of your game. It loads assets directly through the asset database for quick iteration with no analysis or asset bundle creation.

*Simulate Groups* analyzes content for layout and dependencies without creating asset bundles.To see when bundles load or unload during gameplay, view the asset usage in the Addressables Event Viewer window (*Window \> Asset Management \> Addressables \> Event Viewer*). This mode helps you simulate load strategies and tweak your content groups to find the right balance for a production release.

The *Use Existing Build* script is like a deployed application build, but it requires you to build the data as a separate step. If you aren’t modifying assets, this mode is the fastest since it does not process any data when entering Play Mode.

## Where can I learn more about Addressables?

If you want to use Addressables in your project, check out the [Addressable Asset System documentation](https://docs.unity3d.com/Packages/com.unity.addressables@1.21) to learn how to get started. Read our [blog post](https://blogs.unity3d.com/2019/07/15/addressable-asset-system/), check out the [GitHub Samples](https://github.com/unity-technologies/addressables-sample), or join the discussions on [forums](https://forum.unity.com/forums/addressables.156/).

## Cloud Content Delivery: The last mile

Launched in September 2020, Cloud Content Delivery (CCD) is our own enterprise-ready, global content hosting solution, fully integrated into the Addressables system. With CCD, you can build and release game updates effortlessly with powerful asset management and content delivery via the cloud – essential functionality for the operation of live games and apps. Learn more and sign up [here](https://unity.com/products/cloud-content-delivery).
