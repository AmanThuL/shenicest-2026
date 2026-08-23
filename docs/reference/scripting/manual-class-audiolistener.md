---
title: "Audio Listener"
page_title: "Unity - Manual: Audio Listener"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioListener.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioListener.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Audio Listener

<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioListener.html" class="switch-link gray-btn sbtn left" title="Go to AudioListener page in the Scripting Reference">Switch to Scripting</a>

The **Audio Listener** acts as a microphone-like device. It receives input from any given [Audio Source](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioSource.html) in the scene and plays sounds through the computer speakers. For most applications it makes the most sense to attach the listener to the Main [Camera](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Camera.html). If an audio listener is within the boundaries of a [Reverb Zone](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioReverbZone.html) reverberation is applied to all audible sounds in the scene. Furthermore, [Audio Effects](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioEffect.html) can be applied to the listener and it will be applied to all audible sounds in the scene.

![](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/audio_listener_inspector.png)

## Properties

The Audio Listener has no properties. It simply must be added to work. It is always added to the Main Camera by default.

## Details

The Audio Listener works in conjunction with [Audio Sources](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioSource.html), allowing you to create the aural experience for your games. When the Audio Listener is attached to a **GameObject** in your scene, any Sources that are close enough to the Listener will be picked up and output to the computer’s speakers. Each scene can only have 1 Audio Listener to work properly.

If the Sources are 3D (see import settings in [Audio Clip](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioClip.html)), the Listener will emulate position, velocity and orientation of the sound in the 3D world (You can tweak attenuation and 3D/2D behavior in great detail in [Audio Source](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioSource.html)) . 2D will ignore any 3D processing. For example, if your character walks off a street into a night club, the night club’s music should probably be 2D, while the individual voices of characters in the club should be mono with their realistic positioning being handled by Unity.

You should attach the Audio Listener to either the Main Camera or to the GameObject that represents the player. Try both to find what suits your game best.

## Hints

-   Each scene can only have one Audio Listener.
-   You access the Project-wide Audio settings using the [Audio](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioManager.html) window (main menu: **Edit** > **Project Settings**, then select the **Audio** category).
-   View the [Audio Clip](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioClip.html) Component page for more information about Mono vs Stereo sounds.

<span class="search-words">AudioListener</span>
