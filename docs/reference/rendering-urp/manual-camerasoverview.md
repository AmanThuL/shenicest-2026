---
title: "Unity 6.3 Manual: Introduction to cameras"
page_title: "Unity - Manual: Introduction to cameras"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/CamerasOverview.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/CamerasOverview.html"
topic: "rendering-urp"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to cameras

Just as cameras are used in films to display the story to the audience, **Cameras** in Unity are used to display the game world to the player.

A Unity scene represents GameObjects in a three-dimensional space. Since the viewer’s screen is two-dimensional, Unity needs to capture a view and “flatten” it for display. It does this using cameras.

Cameras can be customized, scripted, or parented to achieve just about any kind of effect imaginable. For a puzzle game, you might keep the Camera static for a full view of the puzzle. For a first-person shooter, you would parent the Camera to the player character, and place it at the character’s eye level. For a racing game, you’d probably have the Camera follow your player’s vehicle.

By customizing and manipulating cameras, you can make the presentation of your game truly unique. You will always have at least one camera in a scene, but you can have more than one. You can have an unlimited number of cameras in a scene. They can be set to render in any order, at any place on the screen, or only certain parts of the screen.

In Unity, you create a camera by adding a [Camera component](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Camera.html) to a GameObject.

## Perspective and orthographic cameras

![The same scene shown in perspective mode (left) and orthographic mode (right)](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/CameraPerspectiveAndOrtho.jpg)

A camera in the real world, or indeed a human eye, sees the world in a way that makes objects look smaller the farther they are from the point of view. This well-known *perspective* effect is widely used in art and computer graphics and is important for creating a realistic scene. Naturally, Unity supports perspective cameras, but for some purposes, you want to render the view without this effect. For example, you might want to create a map or information display that is not supposed to appear exactly like a real-world object. A camera that does not diminish the size of objects with distance is referred to as *orthographic* and Unity cameras also have an option for this. The perspective and orthographic modes of viewing a scene are known as camera *projections*. *(scene above from [BITGEM](https://www.assetstore.unity3d.com/en/#!/publisher/1299))*

Marking a Camera as **Orthographic** removes all perspective from the Camera’s view. This is mostly useful for making isometric or 2D games.

Note that fog is rendered uniformly in orthographic camera mode and may therefore not appear as expected. This is because the Z coordinate of the post-perspective space is used for the fog “depth”. This is not strictly accurate for an orthographic camera but it is used for its performance benefits during rendering.

## Render path

Unity supports different rendering paths. You should choose which one you use depending on your game content and target platform / hardware. Different rendering paths have different features and performance characteristics that mostly affect lights and shadows. The rendering path used by your Project is chosen in the **Player** settings. Additionally, you can override it for each Camera.

For more information on rendering paths, check the [rendering paths](https://docs.unity3d.com/6000.3/Documentation/Manual/RenderingPaths.html) page.

## Additional resources

-   [Introduction to cameras in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras/camera-differences-in-urp.html)
-   [Camera render types in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-types-and-render-type.html)
-   [Camera render order in URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/cameras-advanced.html)
-   [Camera Inspector windows reference for URP](https://docs.unity3d.com/6000.3/Documentation/Manual/urp/camera-components-reference-landing.html)
-   [Camera Inspector window reference for the Built-In Render Pipeline](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Camera.html)
