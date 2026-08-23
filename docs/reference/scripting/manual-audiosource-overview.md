---
title: "Introduction to the Audio Source component"
page_title: "Unity - Manual: Introduction to the Audio Source component"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-overview.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-overview.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Introduction to the Audio Source component

Attach an **Audio Source** component to a GameObject to control how and where sounds play in your scene.

Audio sources are components that let you integrate sound effects, music, commentary, and other audio features into your application.

They interact with other audio components in Unity that allow you to edit, enhance, and output sound in your scene, including:

-   Audio Clips
-   Audio Random Containers
-   Audio Listeners
-   Audio Mixers

This page covers how the audio source interacts with these audio components. For more information about the **Audio Source** component’s properties and how to set up the component, refer to [Audio Source component reference](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-reference.html) and [Set up an Audio Source component](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-create.html).

## Audio generators

The **Audio Source** component requires an audio generator to play sound in your scene. Audio generators are containers that hold the actual audio data, so you must assign one to the Audio Source so it has audio data to edit and play. For instructions, refer to [Assign an audio generator to your audio source](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-create.html#assign-an-audio-generator-to-your-audio-source).

The following Unity file types are audio generators:

-   [Audio Clip](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioClip.html)
-   [Audio Random Container](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioRandomContainer.html)

Refer to those pages for more information about each type and for the audio file formats Unity supports.

## Output method of the audio source

In the **Audio Source** component, the **Output** property specifies where the audio source will send the audio signal in the audio processing pipeline.

This property accepts an **Audio Mixer Group**. The Audio Mixer is a tool that lets you post-process the audio with effects. You can then assign your Audio Mixer to the property to make sure your audio source applies your effects to the audio.

If you set the property to **None**, the sound will bypass your mixer and the audio will play without your effects. This is the default behavior.

Then, any **Audio Listener** components in the scene detects the audio from nearby audio sources, and outputs the audio to the user so they can hear it. Audio listeners are usually found on cameras in the scene, but you can also assign them to other objects.

For more information about these components, refer to [Audio Listener](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioListener.html) and [Audio Mixer](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioMixer.html).

<span id="audio-listener"></span>

## Configure your audio source

You can configure the audio source to play the clip as 2D, 3D, or as a mixture (*SpatialBlend*). The audio can be spread out between speakers (stereo to 7.1) (*Spread*) and morphed between 3D and 2D (*SpatialBlend*).

If you set **SpatialBlend** to `0.0f`, then Unity will treat the audio clip as a 2D sound. If you set it to `1.0f`, the clip is fully 3D. Anything in between is a blend of 2D and 3D.

Use falloff curves to control the spread over distance. Also, if the [listener](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioListener.html) is within one or multiple [Reverb Zones](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioReverbZone.html), this applies reverberation to the source. You can also apply individual filters to each audio source for an even richer audio experience. For more details, refer to [Audio Effects](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioEffect.html).

For a list of Audio Source settings, refer to [Audio Source component reference](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-reference.html).

## API resources

The following is a list of useful API for AudioSource and its related properties.

-   [AudioSource](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.html)
-   [AudioClip](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioClip.html)
-   [AudioListener](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioListener.html)
-   [AudioMixer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.AudioMixer.html)

## Additional resources

-   [Audio Source](https://docs.unity3d.com/6000.3/Documentation/Manual/Class-AudioSource.html)
-   [Introduction to the Audio Source component](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-overview.html)
-   [Set up an Audio Source component](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-create.html)
-   [Audio Source component reference](https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-reference.html)
