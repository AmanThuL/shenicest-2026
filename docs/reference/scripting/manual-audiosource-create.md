---
title: "Set up an Audio Source component"
page_title: "Unity - Manual: Set up an Audio Source component"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-create.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-create.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Set up an Audio Source component

Create an audio source to control how an audio clip plays, where it plays and how often.

To create and configure an audio source:

1.  [Import your audio files](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-create.html#import-your-audio-files).
2.  [Create an audio source](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-create.html#create-an-audio-source).
3.  [Assign an audio generator to your audio source](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-create.html#assign-an-audio-generator-to-your-audio-source).
4.  [Alter the settings of your audio source](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-create.html#alter-the-settings-of-your-audio-source).

<span id="import-your-audio-files"></span>

## Import your audio files

To import your audio files into your Unity project, drag your audio file into your project. Unity imports these files as audio clips. For a list of the audio file formats Unity supports, refer to [Audio file compatibility](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioClip.html#audio-file-compatibility).

<span id="create-an-audio-source"></span>

## Create an audio source

There are multiple ways to create an audio source. Use one of the following methods:

-   [Create an audio source from an audio file](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-create.html#create-an-audio-source-from-an-audio-file).
-   [Create an audio source from an existing GameObject](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-create.html#create-an-audio-source-from-an-existing-gameobject).
-   [Create an audio source from the menu](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-create.html#create-an-audio-source-from-the-menu).

<span id="create-an-audio-source-from-an-audio-file"></span>

### Create an audio source from an audio file

A quicker way to create an audio source is to click and drag an audio file from your Project window into the scene.

As a result, Unity automatically creates a GameObject with an **Audio Source** component, and assigns your audio file to its **Audio Clip** property.

### Create an audio source from an existing GameObject

If you have a GameObject in your scene you want to add an audio source to:

1.  Click on the GameObject.
2.  In the Inspector window, select **Add Component**.
3.  Select **Audio** > **Audio Source**.

As a result, Unity adds an **Audio Source** component to your GameObject.

Another way to do this is to drag an audio file from your Project window onto the GameObject. Unity attaches the clip along with a new audio source if it doesn’t already have one. If the object already has an audio source the new clip will replace the one that the source currently uses.

### Create an audio source from the menu

To create a new audio source from the menu:

1.  In the **Hierarchy** tab, select the **Add (+)** button.
2.  Select **Audio** > **Audio Source**.

Unity adds a new GameObject that contains an **Audio Source** component to your scene.

<span id="assign-an-audio-generator-to-your-audio-source"></span>

## Assign an audio generator to your audio source

If your audio source doesn’t have an audio generator assigned, you need to assign one. To do this:

1.  Click on your GameObject that contains the **Audio Source** component. The Inspector window shows.

2.  In the Inspector window, on the **Audio Source** component, locate the **Audio Generator** property.

3.  Then, do one of the following:

4.  Drag an audio clip or audio random container from the Project window to the property.

5.  Click the small circle icon to the right of the property, then select a resource from the list.

<span id="alter-the-settings-of-your-audio-source"></span>

## Alter the settings of your audio source

If you want to configure your audio source more to your liking, refer to [Audio Source component reference](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-reference.html).

## Additional resources

-   [Audio Source](https://docs.unity3d.com/6000.3/Documentation/Manual/Class-AudioSource.html)
-   [Introduction to the Audio Source component](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-overview.html)
-   [Audio Source component reference](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-reference.html)
